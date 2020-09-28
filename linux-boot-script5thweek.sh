#!/bin/bash
apt update -y 
apt install -y nginx stress git
service nginx start