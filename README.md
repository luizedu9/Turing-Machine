# Turing-Machine

Instituto Federal de Educação, Ciência e Tecnologia de Minas Gerais, IFMG - Campus Formiga Ciência da Computação

Maquina de Turing e Calculadora para a disciplina de Teoria da Computação

Autores: Luís Fernando da Silva Corrêa, Luiz Eduardo Pereira.

# Objetivo:
O trabalho consistiu em desenvolver um simulador para a Máquina de Turing. A sintaxe dos comandos da MT foi inspirada no formato adotado no simulador disponível em http://morphett.info/turing/turing.html, acrescentada de alterações para permitir a programação de procedimentos e a passagen de parâmetros. As mudanças em questão não alteram significativamente as características da MT, mas facilitam muito sua programação permitindo o uso de comandos para declaração e chamada de procedimentos, incluindo a passagem de um parâmetro que será implementada numa segunda fita de uso restrito para esse fim. O programa sempre vai simular a MT de modo determinístico.

# Funcionamento:
Existem 4 tipos de comandos: comandos básicos, comandos para criação de bloco, comando para chamada de bloco, e comandos para copiar e colar (utilizando a segunda fita).

Sintaxe dos comandos básicos:
Cada linha do programa fonte contém uma tupla na forma: 
<estado atual> <símbolo atual> - - <novo símbolo> <movimento> <novo estado>
• Para denotar <estado atual> ou <novo estado> pode utilizar um inteiro de até 4 dígitos. Em <novo estado> também pode se utilizar os identificadores "retorne", para sair do bloco atual, "aceite" e "rejeite" para parar a maquina em um estado final ou não-final.
• Para denotar o <símbolo atual> ou <novo símbolo> pode usar qualquer caractere. Usa "_" para representar o branco (espaço) ou "*" para representar o simbolo coringa.
• O <movimento> denota a ação do cabeçote na fita: "e" denota movimento para a esquerda, "d" denota movimento para a direita, "i" denota ausência de movimento.
• Tudo depois de um ";" é tratado como comentário e ignorado pelo simulador.

# Execução:

python3 simulaMT.py <opções> <arquivo>
  
<opções>:
• -r (resume), executa o programa até o fim em modo silencioso.
• -v (verbose), executa o programa até o fim mostrando o resultado passo a passo da execução.
• -s <n> (step <n>), mostra o resultado passo a passo de n computações, depois reabre o prompt para aguardar nova opção (-r,-v,-s). Caso não seja fornecida nova opção (entrada em branco), o padrão é repetir a mesma opção fornecida anteriormente.
Para prevenir contra loops infinitos (no caso das opções -r ou -v), o simulador sempre reabre o prompt e aguardar nova opção depois de executadas 500 computações.
