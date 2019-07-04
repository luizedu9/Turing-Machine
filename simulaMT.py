#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ---------------------------------------------------------------------------------------------------------------
# Nota: A sintaxe para bloco é: bloco <identificador de bloco> <estado inicial>
# Sendo assim, considerando que o <estado inicial> declarado em bloco tem que ser o mesmo do nome do inicial
# Exemplo: bloco main 01 <-----
#             01 a -- A d 02
# E Não:   bloco main 1 <-----
#             01 a -- A d 02
#
# Nota: O primeiro bloco é o bloco inicial, não importando se possui o nome "main" ou não.
# ---------------------------------------------------------------------------------------------------------------
#
#   python3 simulaMT.py -v palindromo.MT
#   python3 simulaMT.py -r palindromo.MT
#   python3 simulaMT.py -head "<>" -v palindromo.MT
#   python3 simulaMT.py -head "<>" -s 5 palindromo.MT
#   python3 simulaMT.py -s 5 palindromo.MT
#

import sys
import os.path
from manipulacao_arquivo import *
from executa_turing import *

# INICIALIZAÇÃO DE PARÂMETROS: 
nstep = 500 # Se a opção -s não for usada, depois de 500 passos o programa irá pedir permissão do usuario para proseguir
cabecote = 0 # Cabeçote começa na posição 0 da fita
if (sys.argv[1] == '-head'): # Com a opção -head definida
    delimitador1 = (sys.argv[2])[0]
    delimitador2 = (sys.argv[2])[1]
    opcao = sys.argv[3]
    if (opcao == '-s'): # Se -s (Step) está ativo, conta a quantidade de steps deverá ter 
        nstep = int(sys.argv[4])
        arquivo = sys.argv[5]
    else:
        arquivo = sys.argv[4]
else: # Sem a opção -head definida
    delimitador1 = '(' # Padrão
    delimitador2 = ')' 
    opcao = sys.argv[1]
    if (opcao == '-s'): # Se -s (Step) está ativo, conta a quantidade de steps deverá ter 
        nstep = int(sys.argv[2])
        arquivo = sys.argv[3]
    else:
        arquivo = sys.argv[2]
        
if (not(os.path.isfile(arquivo))):
    print('ERRO: Arquivo "' + arquivo + '" não encontrado')
    exit()

# CABEÇALHO:
print('Simulador de Máquina de Turing ver 1.0')
print('Desenvolvido como trabalho prático para a disciplina de Teoria da Computação')
print('Luiz Eduardo Pereira, IFMG - Formiga, 2019.')
print()
palavra = input("Forneça a palavra inicial: ") # Recebe a palavra inicial
print()

# CRIA ESTADOS
bloco = retorna_bloco(arquivo) # Lê arquivo e gera a estrutura

# EXECUTA CODIGO
bloco_atual = list(bloco.keys())[0] # Pega o primeiro bloco da lista, ou seja, o Bloco Main
resultado = executa(bloco, bloco_atual, palavra, cabecote, delimitador1, delimitador2, nstep, nstep, opcao, '_', False)

# RESULTADO
print()
if (resultado[0]):
    print("................................ACEITA................................")
else:
    print("................................REJEITA...............................")
print("...........................FIM DA SIMULAÇÃO...........................")