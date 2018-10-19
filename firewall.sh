#!/bin/bash


#VARIAVEIS
HOST=10.0.0.1


#Imprime o status do Firewall
iptables -t filter -nL


#Limpando o Firewall
iptables -t filter -F
iptables -t nat -F
iptables -t mangle -F
iptables -t raw -F
iptables -t security -F


#Define Política Proibitiva
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP


#Imprime novamente
iptables -t filter -nL


#Navegação com a Internet
#DNS, HTTP OU HTTPS
iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -t filter -A INPUT -p udp --sport 53 -j ACCEPT


iptables -t filter -A OUTPUT -m multiport -p tcp --dport 80,443 -j ACCEPT
iptables -t filter -A INPUT -m multiport -p tcp --sport 80,443 -j ACCEPT

#ICMP
iptables -t filter -A OUTPUT -p icmp -j ACCEPT
iptables -t filter -A INPUT -p icmp -j ACCEPT

#Serviço de HTTP Entregue aos clientes
iptables -t filter -A INPUT  -p tcp -d ${HOST} --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp -s ${HOST} --sport 80 -j ACCEPT

