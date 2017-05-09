#!/bin/bash

#COLORS
CONSOLE_TEXT_COLOR_DEFAULT="\033[39m"
CONSOLE_TEXT_COLOR_BLACK="\033[30m"
CONSOLE_TEXT_COLOR_RED="\033[31m"
CONSOLE_TEXT_COLOR_GREEN="\033[32m"
CONSOLE_TEXT_COLOR_RESET="\033[0m"

while true; do
    echo 'Please enter base domain'
    read domain
    if [[ "$domain" =~ ^([a-zA-Z](-?[a-zA-Z0-9])+\.)+[a-zA-Z]{2,4}$ ]]; then
        echo -e "${CONSOLE_TEXT_COLOR_GREEN}Domain is set to ${domain}${CONSOLE_TEXT_COLOR_DEFAULT}"
        break
    else
        echo -e "${CONSOLE_TEXT_COLOR_RED}Wrong domain${CONSOLE_TEXT_COLOR_RESET}"
    fi
done


while true; do
    echo 'Please enter email for Cloudflare'
    read email
    if [[ "$email" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$ ]]; then
        echo -e "${CONSOLE_TEXT_COLOR_GREEN}Email is set to ${email}${CONSOLE_TEXT_COLOR_DEFAULT}"
        break
    else
        echo -e "${CONSOLE_TEXT_COLOR_RED}Wrong email${CONSOLE_TEXT_COLOR_RESET}"
    fi
done

echo 'Please enter token for Cloudflare'
read token_cf
echo -e "${CONSOLE_TEXT_COLOR_GREEN}Token is set to ${token_cf}${CONSOLE_TEXT_COLOR_RESET}"

echo 'Please enter token for DigitalOcean'
read token_do
echo -e "${CONSOLE_TEXT_COLOR_GREEN}Token is set to ${token_do}${CONSOLE_TEXT_COLOR_RESET}"

export CHAT_DOMAIN=$domain
export DO_API_TOKEN=$token_do
export CLOUDFLARE_API_EMAIL=$email
export CLOUDFLARE_API_TOKEN=token_cf

echo -e "${CONSOLE_TEXT_COLOR_GREEN}All credentials are set${CONSOLE_TEXT_COLOR_RESET}"