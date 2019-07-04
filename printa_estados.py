#!/usr/bin/env python
# -*- coding: utf-8 -*-

# PRINTA A PALAVRA NO FORMATO DE SAIDA

def eprint(bloco, estado, palavra, cabecote, delimitador1, delimitador2, aux):
    string = ''

    # CABEÇALHO
    for i in range(0, (16 - len(bloco))):
        string += '.'
    string += bloco
    string += '.'
    for i in range(0, (4 - len(estado))):
        string += '0'
    string += estado
    string += ': '

    # PALAVRA
    for i in range(0, (20 - cabecote)):
        string += '_'
    indice = cabecote - 20
    if (indice < 0):
        indice = 0
    for i in range(indice, cabecote):
        string += palavra[i]
    string += delimitador1
    string += palavra[cabecote]
    string += delimitador2
    indice = len(palavra) - (cabecote + 1)
    if (indice > 20):
        indice = 20
    for i in range((cabecote + 1), (indice + cabecote + 1)):
        string += palavra[i]
    for i in range(0, (20 - (len(palavra) - (cabecote + 1)))):
        string += '_'
    string += ' : ' + aux;
    print(string)
    return