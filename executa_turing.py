#!/usr/bin/env python
# -*- coding: utf-8 -*-

# EXECUTA O BLOCO ORDENADO
from printa_estados import *

# nstep: Quantidade de passos antes de um breakpoint / steps: Contador de passos
def executa(bloco, bloco_atual, palavra, cabecote, delimitador1, delimitador2, nstep, steps, opcao, segunda_fita, stop):
    try:
        estado_atual = bloco[bloco_atual][0] # Estado que deve ser executado
        dicionario = bloco[bloco_atual][1] # Dicionario respectivo do bloco atual
        erro = True # Se for false, aconteceu erro em algum lugar
        xbreakpoint = False
        while (True): # Executa até encontrar um estado 'pare' ou atingir o maximo de passos ou dar erro
            if (steps == 0):
                nstep, steps, opcao = breakpoint(nstep, steps, opcao); # Para execução do programa e comunica com o usuario
            proximo_estado = '' # Se no final do laço, proximo_estado estiver vazio, quer dizer que houve um erro e a palavra não será aceita
            if (opcao == '-v' or opcao == '-s'): # *** Só printa se a opção -verbose estiver selecionada
                eprint(bloco_atual, estado_atual, palavra, cabecote, delimitador1, delimitador2, segunda_fita) # ***
            steps -= 1 # Decremenda contador de passos
            if ((estado_atual, palavra[cabecote]) in dicionario): # Se estado e caractere atual existir no dicionario, executa estado
                if (dicionario[(estado_atual, palavra[cabecote])][3] == '!'): # ***
                    xbreakpoint = True # ***
                proximo_estado = dicionario[(estado_atual, palavra[cabecote])][2] # Armazena o proximo estado
                estado_atual, palavra, cabecote = resolve_estado(dicionario[(estado_atual, palavra[cabecote])], palavra, cabecote)
                if (xbreakpoint): # ***
                    nstep, steps, opcao = breakpoint(nstep, steps, opcao); # *** Para a execução do programa e comunica com o usuario
                    xbreakpoint = False # ***  
            elif ((estado_atual, ('['+segunda_fita+']')) in dicionario): # Verifica se existe estado com []
                if (dicionario[(estado_atual, ('['+segunda_fita+']'))][3] == '!'): # ***
                    xbreakpoint = True # ***
                proximo_estado = dicionario[(estado_atual, ('['+segunda_fita+']'))][2] # Armazena o proximo estado
                estado_atual, palavra, cabecote = resolve_estado(dicionario[(estado_atual, ('['+segunda_fita+']'))], palavra, cabecote)
                if (xbreakpoint): # ***
                    nstep, steps, opcao = breakpoint(nstep, steps, opcao); # *** Para a execução do programa e comunica com o usuario
                    xbreakpoint = False # ***
            elif (((estado_atual, ('[*]')) in dicionario) and (segunda_fita != '_')): # Verifica se existe estado com []
                if (dicionario[(estado_atual, ('[*]'))][3] == '!'): # ***
                    xbreakpoint = True # ***
                proximo_estado = dicionario[(estado_atual, ('[*]'))][2] # Armazena o proximo estado
                estado_atual, palavra, cabecote = resolve_estado(dicionario[(estado_atual, ('[*]'))], palavra, cabecote)
                if (xbreakpoint): # ***
                    nstep, steps, opcao = breakpoint(nstep, steps, opcao); # *** Para a execução do programa e comunica com o usuario
                    xbreakpoint = False # ***
            elif ((estado_atual, '*') in dicionario): # Tenta as outras possibilidades, se não encontrar, verifica se existe estado com coringa
                if (dicionario[(estado_atual, '*')][3] == '!'): # ***
                    xbreakpoint = True # ***
                proximo_estado = dicionario[(estado_atual, '*')][2] # Armazena o proximo estado
                estado_atual, palavra, cabecote = resolve_estado(dicionario[(estado_atual, '*')], palavra, cabecote)
                if (xbreakpoint): # ***
                    nstep, steps, opcao = breakpoint(nstep, steps, opcao); # *** Para a execução do programa e comunica com o usuario
                    xbreakpoint = False # ***
            else: # Procura se estado possui um novo bloco para executar ou interação com a segunda fita
                cont = 0
                for i in dicionario.keys(): # Percorre o dicionario para encontrar o primeiro 
                    if ((i[0] == estado_atual) and (len(i[1]) > 1)): # i pode ser uma tupla de (Estado, Bloco)
                        if (dicionario[(estado_atual, i[1])][3] == '!'): # ***
                            xbreakpoint = True # ***
                        proximo_estado = dicionario[(estado_atual, i[1])][2] # Armazena o proximo estado
                        if (i[1] == 'copiar'):
                            segunda_fita = palavra[cabecote]
                        elif (i[1] == 'gravar'):
                            segunda_fita = dicionario[(estado_atual, i[1])][0]
                            proximo_estado = dicionario[(estado_atual, i[1])][2]
                        elif (i[1] == 'colar'):
                            conversor = list(palavra)
                            conversor[cabecote] = segunda_fita
                            palavra = ''.join(conversor) 
                        else:
                            erro, palavra, cabecote, nstep, steps, opcao, segunda_fita, stop = executa(bloco, i[1], palavra, cabecote, delimitador1, delimitador2, nstep, steps, opcao, segunda_fita, stop)
                            cont += 1
                        if (xbreakpoint): # ***
                            nstep, steps, opcao = breakpoint(nstep, steps, opcao); # *** Para a execução do programa e comunica com o usuario
                            xbreakpoint = False # ***
            if (stop):
                return(erro, palavra, cabecote, nstep, steps, opcao, segunda_fita, stop)
            if (proximo_estado == ''): 
                erro = False   
                eprint(bloco_atual, estado_atual, palavra, cabecote, delimitador1, delimitador2, segunda_fita) # ***
                return(erro, palavra, cabecote, nstep, steps, opcao, segunda_fita, stop)
            if (proximo_estado == 'retorne'):
                return(erro, palavra, cabecote, nstep, steps, opcao, segunda_fita, stop)
            if (proximo_estado == 'pare'):
                stop = True
                eprint(bloco_atual, estado_atual, palavra, cabecote, delimitador1, delimitador2, segunda_fita) # ***
                return(erro, palavra, cabecote, nstep, steps, opcao, segunda_fita, stop)
            if (proximo_estado == 'aceite'):
                stop = True
                eprint(bloco_atual, estado_atual, palavra, cabecote, delimitador1, delimitador2, segunda_fita) # ***
                return(True, palavra, cabecote, nstep, steps, opcao, segunda_fita, stop)
            if (proximo_estado == 'rejeite'):
                stop = True
                eprint(bloco_atual, estado_atual, palavra, cabecote, delimitador1, delimitador2, segunda_fita) # ***
                return(False, palavra, cabecote, nstep, steps, opcao, segunda_fita, stop)
            estado_atual = proximo_estado
    except:
        erro = False
        stop = True
    return(erro, palavra, cabecote, nstep, steps, opcao, segunda_fita, stop) # Primeiro parametro representa se a palavra é aceita ou não

def resolve_estado(tupla, palavra, cabecote):
    new_palavra = list(palavra) # Transforma String em Lista para modificar um caractere especifico
    if not(tupla[0] == '*'): # Se caractere para escrever é qualquer coisa, não altera
        new_palavra[cabecote] = tupla[0]
    new_palavra = "".join(new_palavra) # Transforma a Lista em String novamente
    # if (tupla[1] == 'i'): NÃO FAZ NADA
    if (tupla[1] == 'd'):
        cabecote += 1
    if (tupla[1] == 'e'):
        cabecote -= 1
    if (cabecote < 0): # Caso cabeçote fique menor que 0, a string precisa ser extendida
        new_new_palavra = '_'
        new_new_palavra += new_palavra
        cabecote = 0
        new_palavra = new_new_palavra
    if (cabecote >= len(new_palavra)): # Caso cabeçote fique maior que tamanho da palavra, a string precisa ser extendida
        new_new_palavra = new_palavra
        new_new_palavra += '_'
        new_palavra = new_new_palavra
    return((tupla[2], new_palavra, cabecote))

def breakpoint(nstep, steps, opcao):
    print()
    print("..............................BREAKPOINT..............................")
    print(".......................Forneça opção (-r, -v, -s).....................")
    new_opcao = input("")
    if not(new_opcao == ''):
        colunas = new_opcao.strip().split()
        if (colunas[0] == '-r'):
            nstep = 500   
            opcao = '-r'
        if (colunas[0] == '-v'):
            nstep = 500
            opcao = '-v'
        if (colunas[0] == '-s'):
            nstep = int(colunas[1])
            opcao = '-s'
    steps = nstep
    return(nstep, steps, opcao)