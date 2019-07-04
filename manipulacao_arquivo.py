#!/usr/bin/env python
# -*- coding: utf-8 -*-

# LÊ ARQUIVO E COLOCA NA ESTRUTURA { BLOCO: (ESTADO_INICIAL, { (ESTADO, LETRA / ESTADO, BLOCO): (ESCREVE, DIRECAO, ESTADO / NADA, NADA, ESTADO) } ) }
#                                                                                                          '§' Representa Nada
import subprocess
import sys

def retorna_bloco(arquivo):
    bloco = {} # dicionario
    subprocess.call("cat " + arquivo + " | sed -e 's,    ,,g' > temp;", shell=True) # Usa SED para remover TAB
    arquivo = open('temp') # O codigo modificado sem TAB é armazenado em um arquivo temporario que será removido no final.
    for linha in arquivo:
        colunas = linha.strip().split() # Quebra a string em colunas, sendo ' ' o separador. Mesmo estilo de AWK
        if colunas: # Se não for vazio, executa
            if (colunas[0] == 'bloco'): # Pega o nome do bloco, para depois registrar no dicionario
                dicionario = {}
                nome_bloco = colunas[1] 
                estado_inicial = colunas[2] 
            if (colunas[0] == 'fim'): # Registra o bloco completo
                bloco[nome_bloco] = (estado_inicial, dicionario)
                dicionario = {}
            if (colunas[0] == ';'): # Ignora
                pass
            if (colunas[0].isdigit()): # Registra estados(numeros)
                    #é um bloco
                if (colunas[1] == 'gravar'):
                    if ((len(colunas) == 5) and (colunas[4] == '!')):
                        dicionario[(colunas[0], colunas[1])] = (colunas[2], '§', colunas[3], '!')  
                    else:
                        dicionario[(colunas[0], colunas[1])] = (colunas[2], '§', colunas[3], '§')
                elif ((len(colunas[1]) > 1) and (colunas[1][0] != '[')): # Registra mudança de bloco
                    if ((len(colunas) == 4) and (colunas[3] == '!')):
                        dicionario[(colunas[0], colunas[1])] = ('§', '§', colunas[2], '!')  
                    else:
                        dicionario[(colunas[0], colunas[1])] = ('§', '§', colunas[2], '§')
                else: # Registra conteudo do estado
                    if ((len(colunas) == 7) and (colunas[6] == '!')):
                        dicionario[(colunas[0]), colunas[1]] = (colunas[3], colunas[4], colunas[5], '!')
                    else:
                        dicionario[(colunas[0]), colunas[1]] = (colunas[3], colunas[4], colunas[5], '§')
    subprocess.call("rm temp;", shell=True) # Usa SED para remover a identação
    return(bloco)