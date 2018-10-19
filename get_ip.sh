#!/bin/bash

ip a | grep enp0s3 | grep 192* | cut -f6 -d' ' | cut -f4 -d '.' | cut -f1 -d'/' > num

if [ $(( num%2 )) -eq '0' ]; then
	echo "num é Par"
else
	echo "Ímpar"
fi
