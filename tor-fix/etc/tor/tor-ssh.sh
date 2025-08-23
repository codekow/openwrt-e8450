#!/bin/sh

NAME=tor-ssh

check_tor_ssh(){
  SSH_PID=$(cat /var/run/tor-ssh.pid 2>/dev/null)
  [ -z "${SSH_PID}" ] && return 1
  kill -0 "${SSH_PID}" 2>/dev/null || return 1
  echo "${SSH_PID}"
}

start_tor_ssh(){
  logger -t "${NAME}" "starting..."
  check_tor_ssh && return 0
  /usr/sbin/dropbear -sg -p 127.0.0.1:2222 -P /var/run/tor-ssh.pid
}

stop_tor_ssh(){
  logger -t "${NAME}" "stopping..."
  kill -9 "${SSH_PID}"
}

start_tor_ssh
