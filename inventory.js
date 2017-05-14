#!/usr/bin/env node

const dns = require('dns');
const username = require("os").userInfo().username

function resolveDomain(domain) {
    return new Promise((res, rej) => {
        dns.resolve4(domain, (err, addresses) => {
            if (err) {
                return rej(err);
            }
            res(addresses);
        })
    })
}

function main() {
    const baseDomain = process.env.CHAT_DOMAIN;
    const chatDomain = "chat." + baseDomain;
    const managerDomain = "manager." + chatDomain;
    const testDomain = "test." + chatDomain;

    let result = {};
    var vars = {
        ansible_connection: 'local',
        ansible_python_interpreter: '/usr/local/bin/python'
    }
    result.local = {
        hosts: ['localhost'],
        vars: vars,
        sudo_user: username
    }

    if (process.argv.indexOf("--list") > -1) {
        resolveDomain(managerDomain)
        .then((addresses) => {
            result.manager = {hosts: addresses, vars: vars}
            return resolveDomain(managerDomain)
        })
        .then((addresses) => {
            result.workers = {hosts: addresses, vars: vars};
            return resolveDomain(chatDomain);
        })
        .then((addresses) => {
            result.test = {hosts: addresses, vars: vars};
            return resolveDomain(testDomain);
        })
        .catch((err) => {
            console.error(err.message);
        })
        .then(() => {
            console.log(JSON.stringify(result, null, 4))
        })
    }
}

main();