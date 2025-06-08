#!/usr/bin/env node

const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

// Function to get version from package.json
function getVersion(packageJsonPath) {
    try {
        const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
        return packageJson.version;
    } catch (error) {
        console.error(`Error reading ${packageJsonPath}:`, error.message);
        process.exit(1);
    }
}

// Function to get latest tag for a service
function getLatestTag(service) {
    try {
        const output = execSync(`docker image ls eu.gcr.io/dle-dev/${service} --format "{{.Tag}}"`).toString();
        const tags = output.trim().split('\n').filter(tag => tag);
        return tags.sort((a, b) => {
            const [aMajor, aMinor, aPatch] = a.split('.').map(Number);
            const [bMajor, bMinor, bPatch] = b.split('.').map(Number);
            if (aMajor !== bMajor) return bMajor - aMajor;
            if (aMinor !== bMinor) return bMinor - aMinor;
            return bPatch - aPatch;
        })[0];
    } catch (error) {
        console.error(`Error getting latest tag for ${service}:`, error.message);
        process.exit(1);
    }
}

// Function to update version in compose file
function updateComposeFile(filePath, service, version) {
    try {
        let content = fs.readFileSync(filePath, 'utf8');
        console.info('content: ', content);
        const regex = new RegExp(`image: eu\\.gcr\\.io/dle-dev/${service}:(?:[0-9.]*|latest)`, 'g');
        content = content.replace(regex, `image: eu.gcr.io/dle-dev/${service}:${version}`);
        fs.writeFileSync(filePath, content);
    } catch (error) {
        console.error(`Error updating ${filePath}:`, error.message);
        process.exit(1);
    }
}

// Check if we're on master branch
const isMaster = execSync('git rev-parse --abbrev-ref HEAD').toString().trim() === 'master';

// Get versions
const services = {
    cloud: getVersion('cloud/package.json'),
    proxy: getVersion('proxy/package.json'),
    argo: getVersion('argo/package.json'),
    certbot: getVersion('certbot/package.json')
};

// If not on master, get latest tags
if (!isMaster) {
    Object.keys(services).forEach(service => {
        services[service] = getLatestTag(service);
    });
}

// Update compose files
updateComposeFile('server/compose/cloud.yml', 'cloud', services.cloud);
updateComposeFile('server/compose/proxy.yml', 'proxy', services.proxy);
updateComposeFile('server/compose/proxy.yml', 'argo', services.argo);
updateComposeFile('server/compose/proxy.yml', 'certbot', services.certbot);

// Print updated versions
console.log('Updated versions:');
Object.entries(services).forEach(([service, version]) => {
    console.log(`${service}: ${version}`);
}); 