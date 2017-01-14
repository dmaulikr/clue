'use strict';

const fs = require('fs'),
	path = require('path'),
	minimist = require('minimist');

const args = minimist(process.argv.slice(2), {
	default: {}
});

class Header
{
	constructor(fileName)
	{
		this.fileName = fileName;
		this.deps = [];
	}
}

class Implementation
{
	constructor(fileName)
	{
		this.fileName = fileName;
	}
}

function getDirEntries(dir)
{
	return fs.readdirSync(dir).map(entry => path.join(dir, entry));
}

let headers = [],
	implementations = [],
	platformHeaders = {},
	platformImplementations = {};

function processEntries(entries, headers, implementations)
{
	const testHeader = /\.h$/i,
		testImplementation = /\.(c|cpp|m|mm)/i;
		
	for (const entry of entries)
	{
		if (entry.match(testHeader))
		{
			headers.push(new Header(entry));
		}
		else if (entry.match(testImplementation))
		{
			implementations.push(new Implementation(entry));
		}
	}
}

function processPlugin(pluginDir)
{
	const entries = getDirEntries(pluginDir);
	processEntries(entries, headers, implementations);
	
	const platforms = ['ios', 'android'];
	for (const platform of platforms)
	{
		const platformDir = path.join(pluginDir, platform);
		if (entries.indexOf(platformDir) === -1) continue;
		
		platformHeaders[platform] = platformHeaders[platform] || [];
		platformImplementations[platform] = platformImplementations[platform] || [];
		
		processEntries(getDirEntries(platformDir), platformHeaders[platform], platformImplementations[platform]);
	}
}

getDirEntries('plugins').forEach(processPlugin);

console.log(headers, implementations, platformHeaders, platformImplementations);
