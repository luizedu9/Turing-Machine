;###################################################################################################################;
;                                                                                                                   ;
; Luís Fernando da Silva Corrêa - 0022644                                                                           ;
; Luiz Eduardo Pereira          - 0021619                                                                           ;
;                                                                                                                   ;
;###################################################################################################################;

;###################################################################################################################;
;                                                                                                                   ;
;                                                           MAIN                                                    ;
;                                                                                                                   ;
;###################################################################################################################

; Calculador
bloco main 01
	01 * -- * d 01
	01 + -- + i 100
	01 - -- - i 200
	01 x -- x i 300

	100 * -- * e 100
	100 _ -- _ d 101
	101 soma aceite

	200 * -- * e 200
	200 _ -- _ d 201
    201 subtracao aceite

    300 * -- * e 300
	300 _ -- _ d 301
	301 multiplicacao aceite
fim

;###################################################################################################################;
;                                                                                                                   ;
;                                                       MULTIPLICAÇÃO                                               ;
;                                                                                                                   ;
;###################################################################################################################;

bloco multiplicacao 01
	01 mul_copia 02
	02 mul_resolve 03
fim

bloco mul_resolve 01
	01 mul_moved_hash 02
	02 mul_subtracao 03
	03 [s] -- * i 04
	03 [n] -- * i 1000
	04 mul_soma 05
	05 mul_reverte 01

	1000 mul_finalizar aceite
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma 01
	01 mul_moved_vezes 02
	02 x -- x e 04
	04 0 -- a i 1000
	04 1 -- b i 1001
	04 2 -- c i 1002
	04 3 -- d i 1003
	04 4 -- e i 1004
	04 5 -- f i 1005
	04 6 -- g i 1006
	04 7 -- h i 1007
	04 8 -- i i 1008
	04 9 -- j i 1009
	04 = -- = i retorne
	04 * -- * e 04

	1000 mul_soma_zero 01
	1001 mul_soma_um 01 
	1002 mul_soma_dois 01 
	1003 mul_soma_tres 01 
	1004 mul_soma_quatro 01 
	1005 mul_soma_cinco 01 
	1006 mul_soma_seis 01 
	1007 mul_soma_sete 01 
	1008 mul_soma_oito 01 
	1009 mul_soma_nove 01 
fim

bloco mul_query 01
	01 0 -- 1 i retorne
	01 1 -- 2 i retorne
	01 2 -- 3 i retorne
	01 3 -- 4 i retorne
	01 4 -- 5 i retorne
	01 5 -- 6 i retorne
	01 6 -- 7 i retorne
	01 7 -- 8 i retorne
	01 8 -- 9 i retorne
	01 9 -- 0 e 01
fim

bloco mul_reverte 01
	01 mul_move_igual 02
	02 $ -- $ i 1000
	02 a -- 0 d 02
	02 b -- 1 d 02
	02 c -- 2 d 02
	02 d -- 3 d 02
	02 e -- 4 d 02
	02 f -- 5 d 02
	02 g -- 6 d 02
	02 h -- 7 d 02
	02 i -- 8 d 02
	02 j -- 9 d 02
	02 * -- * d 02

	1000 mul_move_igual retorne
fim

; Faz as subtrações referente a operação de multiplicação (CABEÇOTE NO HASH)
bloco mul_subtracao 01
	01 # -- # e 02
	02 0 -- 0 i 05
	02 1 -- 0 i 1000
	02 2 -- 1 i 1000
	02 3 -- 2 i 1000
	02 4 -- 3 i 1000
	02 5 -- 4 i 1000
	02 6 -- 5 i 1000
	02 7 -- 6 i 1000
	02 8 -- 7 i 1000
	02 9 -- 8 i 1000

	; Caso seja zero, tem que pegar query ou finalizar
	05 * -- * e 06
	06 x -- x i 2000 ; Se encontrou o x, acabou
	06 0 -- 0 e 06
	06 1 -- 0 d 07
	06 2 -- 1 d 07
	06 3 -- 2 d 07
	06 4 -- 3 d 07
	06 5 -- 4 d 07
	06 6 -- 5 d 07
	06 7 -- 6 d 07
	06 8 -- 7 d 07
	06 9 -- 8 d 07
	07 * -- 9 d 07
	07 # -- # i 1000

	1000 mul_move_igual 1001
	1001 gravar s retorne ; Sim (s) significa que ainda deve continuar a multiplicação
	2000 mul_move_igual 2001
	2001 gravar n retorne ; Não (n) significa que não deve continuar a multiplicação
fim

bloco mul_finalizar 01
	01 mul_move_igual 02
	02 = -- = d 03
	03 * -- _ d 03
	03 # -- _ i 04
	04 _ -- _ d 04
	04 $ -- _ i 1000
	04 * -- * i 05
	05 copiar 06
	06 * -- _ i 07
	07 _ -- _ e 07
	07 * -- * d 08
	08 colar 09
	09 * -- * d 04

	1000 gravar _ 1001
	1001 mul_move_igual retorne
fim

; Este bloco cria uma copia da operação que se deseja usar, devolve o ponteiro no =
bloco mul_copia 03
    03 copiar 04
    04 * -- X d 05
    05 * -- * d 05
    05 = -- * d 06
    06 * -- * d 06
    06 _ -- * i 07
    07 colar 08
    08 * -- * e 08
    08 X -- * i 09
    09 colar 10
    10 * -- * d 11
    11 * -- * i 03
    11 = -- * i 12
    12 * -- * d 12
    12 _ -- # i 13
    13 * -- * e 13
    13 = -- = i 14

    14 = -- = d 15
    15 copiar 16
    16 * -- ! i 17
    17 * -- * d 17
    17 # -- # d 18
    18 * -- * d 18
    18 _ -- 0 i 19
    19 * -- * e 19
    19 ! -- ! i 20
    20 colar 21
    21 * -- * d 22
    22 x -- x d 22
    22 # -- # i 23
    22 * -- * i 15

    23 * -- * d 23
    23 _ -- $ i 24
    24 mul_move_igual 25
    25 gravar _ retorne ; Esvazia a segunda fita para não atrapalhar nas proximas execuções
fim

bloco mul_move_igual 01
    01 * -- * e 01
    01 = -- = i retorne
fim

; Move para direita até a hash 
bloco mul_moved_hash 01
	01 * -- * d 01
	01 # -- # i retorne
fim

; Move para a esquerda até a hash
bloco mul_movee_hash 01
	01 * -- * e 01
	01 # -- # i retorne
fim

; Move para direita até o cifrao 
bloco mul_moved_cifrao 01
	01 * -- * d 01
	01 $ -- $ i retorne
fim

; Move para a esquerda até o cifrão
bloco mul_movee_cifrao 01
	01 * -- * e 01
	01 $ -- $ i retorne
fim

; Move para direita até o vezes 
bloco mul_moved_vezes 01
	01 * -- * d 01
	01 x -- x i retorne
fim

; Move para a esquerda até o cifrão
bloco mul_movee_vezes 01
	01 * -- * e 01
	01 x -- x i retorne
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma_zero 01
	01 mul_moved_cifrao 02
	02 * -- * e 02
	02 0 -- a i 1000
	02 1 -- b i 1000
	02 2 -- c i 1000
	02 3 -- d i 1000
	02 4 -- e i 1000
	02 5 -- f i 1000
	02 6 -- g i 1000
	02 7 -- h i 1000
	02 8 -- i i 1000
	02 9 -- j i 1000
	
	1000 mul_move_igual retorne
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma_um 01
	01 mul_moved_cifrao 02
	02 * -- * e 02
	02 0 -- b i 1000
	02 1 -- c i 1000
	02 2 -- d i 1000
	02 3 -- e i 1000
	02 4 -- f i 1000
	02 5 -- g i 1000
	02 6 -- h i 1000
	02 7 -- i i 1000
	02 8 -- j i 1000
	02 9 -- a e 1001
	
	1000 mul_move_igual retorne
	1001 mul_query 1000
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma_dois 01
	01 mul_moved_cifrao 02
	02 * -- * e 02
	02 0 -- c i 1000
	02 1 -- d i 1000
	02 2 -- e i 1000
	02 3 -- f i 1000
	02 4 -- g i 1000
	02 5 -- h i 1000
	02 6 -- i i 1000
	02 7 -- j i 1000
	02 8 -- a e 1001
	02 9 -- b e 1001
	
	1000 mul_move_igual retorne
	1001 mul_query 1000
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma_tres 01
	01 mul_moved_cifrao 02
	02 * -- * e 02
	02 0 -- d i 1000
	02 1 -- e i 1000
	02 2 -- f i 1000
	02 3 -- g i 1000
	02 4 -- h i 1000
	02 5 -- i i 1000
	02 6 -- j i 1000
	02 7 -- a e 1001
	02 8 -- b e 1001
	02 9 -- c e 1001
	
	1000 mul_move_igual retorne
	1001 mul_query 1000
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma_quatro 01
	01 mul_moved_cifrao 02
	02 * -- * e 02
	02 0 -- e i 1000
	02 1 -- f i 1000
	02 2 -- g i 1000
	02 3 -- h i 1000
	02 4 -- i i 1000
	02 5 -- j i 1000
	02 6 -- a e 1001
	02 7 -- b e 1001
	02 8 -- c e 1001
	02 9 -- d e 1001
	
	1000 mul_move_igual retorne
	1001 mul_query 1000
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma_cinco 01
	01 mul_moved_cifrao 02
	02 * -- * e 02
	02 0 -- f i 1000
	02 1 -- g i 1000
	02 2 -- h i 1000
	02 3 -- i i 1000
	02 4 -- j i 1000
	02 5 -- a e 1001
	02 6 -- b e 1001
	02 7 -- c e 1001
	02 8 -- d e 1001
	02 9 -- e e 1001
	
	1000 mul_move_igual retorne
	1001 mul_query 1000
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma_seis 01
	01 mul_moved_cifrao 02
	02 * -- * e 02
	02 0 -- g i 1000
	02 1 -- h i 1000
	02 2 -- i i 1000
	02 3 -- j i 1000
	02 4 -- a e 1001
	02 5 -- b e 1001
	02 6 -- c e 1001
	02 7 -- d e 1001
	02 8 -- e e 1001
	02 9 -- f e 1001
	
	1000 mul_move_igual retorne
	1001 mul_query 1000
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma_sete 01
	01 mul_moved_cifrao 02
	02 * -- * e 02
	02 0 -- h i 1000
	02 1 -- i i 1000
	02 2 -- j i 1000
	02 3 -- a e 1001
	02 4 -- b e 1001
	02 5 -- c e 1001
	02 6 -- d e 1001
	02 7 -- e e 1001
	02 8 -- f e 1001
	02 9 -- g e 1001
	
	1000 mul_move_igual retorne
	1001 mul_query 1000
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma_oito 01
	01 mul_moved_cifrao 02
	02 * -- * e 02
	02 0 -- i i 1000
	02 1 -- j i 1000
	02 2 -- a e 1001
	02 3 -- b e 1001
	02 4 -- c e 1001
	02 5 -- d e 1001
	02 6 -- e e 1001
	02 7 -- f e 1001
	02 8 -- g e 1001
	02 9 -- h e 1001
	
	1000 mul_move_igual retorne
	1001 mul_query 1000
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco mul_soma_nove 01
	01 mul_moved_cifrao 02
	02 * -- * e 02
	02 0 -- j i 1000
	02 1 -- a e 1001
	02 2 -- b e 1001
	02 3 -- c e 1001
	02 4 -- d e 1001
	02 5 -- e e 1001
	02 6 -- f e 1001
	02 7 -- g e 1001
	02 8 -- h e 1001
	02 9 -- i e 1001
	
	1000 mul_move_igual retorne
	1001 mul_query 1000
fim

;###################################################################################################################;
;                                                                                                                   ;
;                                                           SOMA                                                    ;
;                                                                                                                   ;
;###################################################################################################################;

;-------------------------
; TABELA DO DECOD:
; Z = 0
; U = 1
; D = 2
; T = 3
; Q = 4
; C = 5
; S = 6
; E = 7
; O = 8
; N = 9
;-------------------------

bloco soma 01
	01 som_busca_antes 02
	02 som_somente_apos 03
    03 som_checa_query 04
	;-------------------------
	04 som_move_fim 05
	05 _ -- # e 06
	06 som_inverte_num 07
	;-------------------------
	07 som_decod_num 08
	08 som_move_igual aceite
fim

bloco som_move_igual 01
	01 * -- * e 01
	01 = -- = i retorne
fim

bloco som_busca_antes 01
	01 + -- + e 02
	01 * -- * d 01
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 _ -- _ d retorne
	02 * -- * e 02
	;-------------------------
	03 soma_0antes 14
	04 soma_1antes 14
	05 soma_2antes 14
	06 soma_3antes 14
	07 soma_4antes 14
	08 soma_5antes 14
	09 soma_6antes 14
	10 soma_7antes 14
	11 soma_8antes 14
	12 soma_9antes 14
	;-------------------------
	14 _ -- _ i 01
fim

bloco som_somente_apos 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 _ -- _ d retorne
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual00 14
	04 som_soma_igual01 14
	05 som_soma_igual02 14
	06 som_soma_igual03 14
	07 som_soma_igual04 14
	08 som_soma_igual05 14
	09 som_soma_igual06 14
	10 som_soma_igual07 14
	11 som_soma_igual08 14
	12 som_soma_igual09 14
	;-------------------------
	14 _ -- _ i 01
fim

bloco som_checa_query 01
    01 som_move_fim 02
    02 [_] -- _ e 03
    02 [1] -- 1 e 03
    03 gravar _ retorne
fim

;------------------------------
;--- INICIO BLOCOS XX ANTES ---
;------------------------------

bloco soma_0antes 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 + -- + d 13
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual00 retorne
	04 som_soma_igual01 retorne
	05 som_soma_igual02 retorne
	06 som_soma_igual03 retorne
	07 som_soma_igual04 retorne
	08 som_soma_igual05 retorne
	09 som_soma_igual06 retorne
	10 som_soma_igual07 retorne
	11 som_soma_igual08 retorne
	12 som_soma_igual09 retorne
	;-------------------------
	13 som_soma_igual00 retorne
fim

bloco soma_1antes 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 + -- + d 13
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual01 retorne
	04 som_soma_igual02 retorne
	05 som_soma_igual03 retorne
	06 som_soma_igual04 retorne
	07 som_soma_igual05 retorne
	08 som_soma_igual06 retorne
	09 som_soma_igual07 retorne
	10 som_soma_igual08 retorne
	11 som_soma_igual09 retorne
	12 som_soma_igual10 retorne
	;-------------------------
	13 som_soma_igual01 retorne
fim

bloco soma_2antes 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 + -- + d 13
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual02 retorne
	04 som_soma_igual03 retorne
	05 som_soma_igual04 retorne
	06 som_soma_igual05 retorne
	07 som_soma_igual06 retorne
	08 som_soma_igual07 retorne
	09 som_soma_igual08 retorne
	10 som_soma_igual09 retorne
	11 som_soma_igual10 retorne
	12 som_soma_igual11 retorne
	;-------------------------
	13 som_soma_igual02 retorne
fim

bloco soma_3antes 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 + -- + d 13
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual03 retorne
	04 som_soma_igual04 retorne
	05 som_soma_igual05 retorne
	06 som_soma_igual06 retorne
	07 som_soma_igual07 retorne
	08 som_soma_igual08 retorne
	09 som_soma_igual09 retorne
	10 som_soma_igual10 retorne
	11 som_soma_igual11 retorne
	12 som_soma_igual12 retorne
	;-------------------------
	13 som_soma_igual03 retorne
fim

bloco soma_4antes 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 + -- + d 13
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual04 retorne
	04 som_soma_igual05 retorne
	05 som_soma_igual06 retorne
	06 som_soma_igual07 retorne
	07 som_soma_igual08 retorne
	08 som_soma_igual09 retorne
	09 som_soma_igual10 retorne
	10 som_soma_igual11 retorne
	11 som_soma_igual12 retorne
	12 som_soma_igual13 retorne
	;-------------------------
	13 som_soma_igual04 retorne
fim

bloco soma_5antes 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 + -- + d 13
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual05 retorne
	04 som_soma_igual06 retorne
	05 som_soma_igual07 retorne
	06 som_soma_igual08 retorne
	07 som_soma_igual09 retorne
	08 som_soma_igual10 retorne
	09 som_soma_igual11 retorne
	10 som_soma_igual12 retorne
	11 som_soma_igual13 retorne
	12 som_soma_igual14 retorne
	;-------------------------
	13 som_soma_igual05 retorne
fim

bloco soma_6antes 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 + -- + d 13
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual06 retorne
	04 som_soma_igual07 retorne
	05 som_soma_igual08 retorne
	06 som_soma_igual09 retorne
	07 som_soma_igual10 retorne
	08 som_soma_igual11 retorne
	09 som_soma_igual12 retorne
	10 som_soma_igual13 retorne
	11 som_soma_igual14 retorne
	12 som_soma_igual15 retorne
	;-------------------------
	13 som_soma_igual06 retorne
fim

bloco soma_7antes 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 + -- + d 13
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual07 retorne
	04 som_soma_igual08 retorne
	05 som_soma_igual09 retorne
	06 som_soma_igual10 retorne
	07 som_soma_igual11 retorne
	08 som_soma_igual12 retorne
	09 som_soma_igual13 retorne
	10 som_soma_igual14 retorne
	11 som_soma_igual15 retorne
	12 som_soma_igual16 retorne
	;-------------------------
	13 som_soma_igual07 retorne
fim

bloco soma_8antes 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 + -- + d 13
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual08 retorne
	04 som_soma_igual09 retorne
	05 som_soma_igual10 retorne
	06 som_soma_igual11 retorne
	07 som_soma_igual12 retorne
	08 som_soma_igual13 retorne
	09 som_soma_igual14 retorne
	10 som_soma_igual15 retorne
	11 som_soma_igual16 retorne
	12 som_soma_igual17 retorne
	;-------------------------
	13 som_soma_igual08 retorne
fim

bloco soma_9antes 01
	01 som_movea_igual 02
	;-------------------------
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 + -- + d 13
	02 * -- * e 02
	;-------------------------
	03 som_soma_igual09 retorne
	04 som_soma_igual10 retorne
	05 som_soma_igual11 retorne
	06 som_soma_igual12 retorne
	07 som_soma_igual13 retorne
	08 som_soma_igual14 retorne
	09 som_soma_igual15 retorne
	10 som_soma_igual16 retorne
	11 som_soma_igual17 retorne
	12 som_soma_igual18 retorne
	;-------------------------
	13 som_soma_igual09 retorne
fim

;------------------------------
;---- FIM BLOCOS XX ANTES -----
;------------------------------

;------------------------------
;-- INICIO BLOCOS SOMA IGUAL --
;------------------------------

bloco som_soma_igual00 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual01 retorne
	04 som_moved_igual 05
	05 _ -- 0 i 06
	05 * -- * d 05
	06 som_move_inicio retorne
fim

bloco som_soma_igual01 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual02 retorne
	04 som_moved_igual 05
	05 _ -- 1 i 06
	05 * -- * d 05
	06 som_move_inicio retorne
fim

bloco som_soma_igual02 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual03 retorne
	04 som_moved_igual 05
	05 _ -- 2 i 06
	05 * -- * d 05
	06 som_move_inicio retorne
fim

bloco som_soma_igual03 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual04 retorne
	04 som_moved_igual 05
	05 _ -- 3 i 06
	05 * -- * d 05
	06 som_move_inicio retorne
fim

bloco som_soma_igual04 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual05 retorne
	04 som_moved_igual 05
	05 _ -- 4 i 06
	05 * -- * d 05
	06 som_move_inicio retorne
fim

bloco som_soma_igual05 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual06 retorne
	04 som_moved_igual 05
	05 _ -- 5 i 06
	05 * -- * d 05
	06 som_move_inicio retorne
fim

bloco som_soma_igual06 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual07 retorne
	04 som_moved_igual 05
	05 _ -- 6 i 06
	05 * -- * d 05
	06 som_move_inicio retorne
fim

bloco som_soma_igual07 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual08 retorne
	04 som_moved_igual 05
	05 _ -- 7 i 06
	05 * -- * d 05
	06 som_move_inicio retorne
fim

bloco som_soma_igual08 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual09 retorne
	04 som_moved_igual 05
	05 _ -- 8 i 06
	05 * -- * d 05
	06 som_move_inicio retorne
fim

bloco som_soma_igual09 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual10 retorne
	04 som_moved_igual 05
	05 _ -- 9 i 06
	05 * -- * d 05
	06 som_move_inicio retorne
fim

bloco som_soma_igual10 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual11 retorne
	04 gravar 1 05
	05 som_moved_igual 06
	06 _ -- 0 i 07
	06 * -- * d 06
	07 som_move_inicio retorne
fim

bloco som_soma_igual11 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual12 retorne
	04 gravar 1 05
	05 som_moved_igual 06
	06 _ -- 1 i 07
	06 * -- * d 06
	07 som_move_inicio retorne
fim

bloco som_soma_igual12 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual13 retorne
	04 gravar 1 05
	05 som_moved_igual 06
	06 _ -- 2 i 07
	06 * -- * d 06
	07 som_move_inicio retorne
fim

bloco som_soma_igual13 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual14 retorne
	04 gravar 1 05
	05 som_moved_igual 06
	06 _ -- 3 i 07
	06 * -- * d 06
	07 som_move_inicio retorne
fim

bloco som_soma_igual14 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual15 retorne
	04 gravar 1 05
	05 som_moved_igual 06
	06 _ -- 4 i 07
	06 * -- * d 06
	07 som_move_inicio retorne
fim

bloco som_soma_igual15 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual16 retorne
	04 gravar 1 05
	05 som_moved_igual 06
	06 _ -- 5 i 07
	06 * -- * d 06
	07 som_move_inicio retorne
fim

bloco som_soma_igual16 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual17 retorne
	04 gravar 1 05
	05 som_moved_igual 06
	06 _ -- 6 i 07
	06 * -- * d 06
	07 som_move_inicio retorne
fim

bloco som_soma_igual17 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual18 retorne
	04 gravar 1 05
	05 som_moved_igual 06
	06 _ -- 7 i 07
	06 * -- * d 06
	07 som_move_inicio retorne
fim

bloco som_soma_igual18 01
	01 [1] -- * i 02
	01 [_] -- * i 04
	02 gravar _ 03
	03 som_soma_igual19 retorne
	04 gravar 1 05
	05 som_moved_igual 06
	06 _ -- 8 i 07
	06 * -- * d 06
	07 som_move_inicio retorne
fim

bloco som_soma_igual19 01
	01 [_] -- * i 02
	02 gravar 1 03
	03 som_moved_igual 04
	04 _ -- 9 i 05
	04 * -- * d 04
	05 som_move_inicio retorne
fim

;------------------------------
;--- FIM BLOCOS SOMA IGUAL ----
;------------------------------

;------------------------------
;- INICIO BLOCOS MOVIMENTACAO -
;------------------------------

bloco som_move_inicio 01
	01 _ -- _ i retorne
	01 * -- * e 01
fim

bloco som_move_fim 01
	01 _ -- _ i retorne
	01 * -- * d 01
fim

bloco som_movea_igual 01
	01 = -- = e retorne
	01 * -- * d 01
fim

bloco som_moved_igual 01
	01 = -- = d retorne
	01 * -- * d 01
fim

bloco som_modifica3 01
	01 # -- # e retorne
	01 * -- * d 01
fim

bloco som_modifica5 01
	01 # -- # d retorne
	01 * -- * d 01
fim

;------------------------------
;-- FIM BLOCOS MOVIMENTACAO ---
;------------------------------

;------------------------------
;--- INICIO BLOCOS INVERSAO ---
;------------------------------

bloco som_modifica1 01
	01 = -- = d retorne
	01 * -- * e 01
fim

bloco som_modifica2 01
	01 # -- # i retorne
	01 * -- * e 01
fim

bloco som_inverte_num 01
	01 som_modifica3 02
	02 0 -- Z d 03
	02 1 -- U d 04
	02 2 -- D d 05
	02 3 -- T d 06
	02 4 -- Q d 07
	02 5 -- C d 08
	02 6 -- S d 09
	02 7 -- E d 10
	02 8 -- O d 11
	02 9 -- N d 12
	02 = -- = d 13
	02 * -- * e 02
	;-------------------------
	03 gravar 0 14
	04 gravar 1 14
	05 gravar 2 14
	06 gravar 3 14
	07 gravar 4 14
	08 gravar 5 14
	09 gravar 6 14
	10 gravar 7 14
	11 gravar 8 14
	12 gravar 9 14
	13 gravar $ 17
	;-------------------------
	14 som_move_fim 15
	15 colar 16
	16 som_move_inicio 01
	;-------------------------
	17 som_move_fim 18
	18 colar 19
	19 som_move_inicio 20
	20 som_moved_igual 21
	21 # -- # d 22
	21 * -- _ d 21
	22 som_modifica4 retorne
fim

bloco som_modifica4 01
	01 0 -- Z e 02
	01 1 -- U e 03
	01 2 -- D e 04
	01 3 -- T e 05
	01 4 -- Q e 06
	01 5 -- C e 07
	01 6 -- S e 08
	01 7 -- E e 09
	01 8 -- O e 10
	01 9 -- N e 11
	01 $ -- $ e 12
	01 * -- * d 01
	;-------------------------
	02 gravar 0 13
	03 gravar 1 13
	04 gravar 2 13
	05 gravar 3 13
	06 gravar 4 13
	07 gravar 5 13
	08 gravar 6 13
	09 gravar 7 13
	10 gravar 8 13
	11 gravar 9 13
	12 som_modifica2 18
	;-------------------------
	13 som_modifica1 14
	14 som_move_fim 15
	15 colar 16
	16 som_modifica5 17
	17 * -- * i 01
	;-------------------------
	18 _ -- _ i 19
	18 * -- _ d 18
	19 som_modifica1 20
	20 som_move_inicio 21
	21 _ -- _ d retorne
fim

;------------------------------
;---- FIM BLOCOS INVERSAO -----
;------------------------------

;------------------------------
;---- INICIO BLOCOS DECOD -----
;------------------------------

bloco som_decod_num 01
	01 Z -- 0 d 01
	01 U -- 1 d 01
	01 D -- 2 d 01
	01 T -- 3 d 01
	01 Q -- 4 d 01
	01 C -- 5 d 01
	01 S -- 6 d 01
	01 E -- 7 d 01
	01 O -- 8 d 01
	01 N -- 9 d 01
	01 _ -- _ i retorne
	01 * -- * d 01
fim

;------------------------------
;----- FIM BLOCOS DECOD -------
;------------------------------

;###################################################################################################################;
;                                                                                                                   ;
;                                                         SUBTRAÇÃO                                                 ;
;                                                                                                                   ;
;###################################################################################################################;

; Este bloco realiza a subtração
bloco subtracao 01
    01 sub_copia 02 ; Cria uma copia da expressão
    02 sub_compara 03 ; Compara para descobrir se resultado sera positivo (p) ou negativo (n)
    03 sub_resolve retorne
fim

; Compara se o resultado será positivo ou negativo
bloco sub_compara 01
    01 sub_compara_tam 02
    02 [p] -- * i 100
    02 [n] -- * i 200
    02 [i] -- * i 300

    100 sub_apaga 101
    101 sub_copia 102
    102 gravar p retorne

    200 sub_apaga 201
    201 * -- * d 201
    201 = -- = d 203
    203 * -- n e 204
    204 * -- * e 204
    204 _ -- _ d 205
    205 sub_copia_rev 206
    206 gravar n retorne

    300 sub_apaga 301
    301 sub_copia 302
    302 sub_compara_val 02

fim

; Verifica se ambas os valores são do mesmo tamanho. 1º > 2º (p) - 1º < 2º (n) - 1º = 2º (precisa de outro teste)
bloco sub_compara_tam 01
    01 = -- = d 02
    02 * -- x i 03
    03 sub_moved_menos 04
    04 - -- - d 04
    04 x -- x d 04
    04 # -- # i 100 ; Estado 100 significa que o primeiro numero é maior que o segundo
    04 * -- x i 05
    05 sub_movee_menos 06
    06 x -- x d 07
    06 * -- * e 06
    07 * -- x i 03
    07 - -- - i 08
    08 - -- - d 09
    09 x -- x d 09
    09 * -- * i 101 ; Estado 101 significa que o segundo numero é mairo que o primeiro
    09 # -- # i 102 ; Estado 102 significa que ambos os numeros são do mesmo tamanho

    100 gravar p retorne
    101 gravar n retorne
    102 gravar i retorne ; i = Indefinido
fim

bloco sub_compara_val 01
    01 = -- = d 02
    02 copiar 03
    03 * -- x i 04
    04 sub_moved_menos 05
    05 - -- - d 06
    06 x -- x d 06
    06 * -- * i 10
    07 sub_move_igual 08
    08 = -- = d 09
    09 x -- x d 09
    09 - -- - i 100
    09 * -- * i 02

    10 [0] -- * i 1000
    10 [1] -- * i 1100
    10 [2] -- * i 1200
    10 [3] -- * i 1300
    10 [4] -- * i 1400
    10 [5] -- * i 1500
    10 [6] -- * i 1600
    10 [7] -- * i 1700
    10 [8] -- * i 1800
    10 [9] -- * i 07

    ; Verifica se o primeiro numero é maior que o segundo numero
    ; VALOR 0
    1000 0 -- x i 07
    1000 * -- x i 101
    ; VALOR 1
    1100 0 -- x i 100
    1100 1 -- x i 07
    1100 * -- x i 101
    ; VALOR 2
    1200 0 -- x i 100
    1200 1 -- x i 100
    1200 2 -- x i 07
    1200 * -- x i 101
    ; VALOR 3
    1300 0 -- x i 100
    1300 1 -- x i 100
    1300 2 -- x i 100
    1300 3 -- x i 07
    1300 * -- x i 101
    ; VALOR 4
    1400 0 -- x i 100
    1400 1 -- x i 100
    1400 2 -- x i 100
    1400 3 -- x i 100
    1400 4 -- x i 07
    1400 * -- x i 101
    ; VALOR 5
    1500 0 -- x i 100
    1500 1 -- x i 100
    1500 2 -- x i 100
    1500 3 -- x i 100
    1500 4 -- x i 100
    1500 5 -- x i 07
    1500 * -- x i 101
    ; VALOR 6
    1600 0 -- x i 100
    1600 1 -- x i 100
    1600 2 -- x i 100
    1600 3 -- x i 100
    1600 4 -- x i 100
    1600 5 -- x i 100
    1600 6 -- x i 07
    1600 * -- x i 101
    ; VALOR 7
    1700 0 -- x i 100
    1700 1 -- x i 100
    1700 2 -- x i 100
    1700 3 -- x i 100
    1700 4 -- x i 100
    1700 5 -- x i 100
    1700 6 -- x i 100
    1700 7 -- x i 07
    1700 * -- x i 101
    ; VALOR 8
    1800 0 -- x i 100
    1800 1 -- x i 100
    1800 2 -- x i 100
    1800 3 -- x i 100
    1800 4 -- x i 100
    1800 5 -- x i 100
    1800 6 -- x i 100
    1800 7 -- x i 100
    1800 8 -- x i 07
    1800 * -- x i 101
    ; VALOR 9
    ; Nenhum caso com valor 9 irá dar negativo

    100 gravar p retorne
    101 gravar n retorne
fim

; Resolve a conta para subtração
bloco sub_resolve 01
    01 sub_moved_menos 05 ; Move para a esquerda até encontra o operando menos
    02 * -- * e 02 ; Volta até encontrar um numero
    02 = -- = i 06 ; Se encontrar o igual, ja calculou todos os valores

    03 sub_query 01 ; Trata quando existe query

    ; Se segunda fita conter um digito, significa que a função que verifica o segundo digito não encontrou nenhum para ser calculado , entao finaliza a execução
    05 [0] -- * i 06
    05 [1] -- * i 06
    05 [2] -- * i 06
    05 [3] -- * i 06
    05 [4] -- * i 06
    05 [5] -- * i 06
    05 [6] -- * i 06
    05 [7] -- * i 06
    05 [8] -- * i 06
    05 [9] -- * i 06
    05 * -- * i 02 ; Se não, continuar loop
    06 sub_finalizar retorne
    
    ; Zero
    02 0 -- 0 i 1000 ; Calcula 0 - ?
    1000 * -- * i 1001
    1000 [s] -- * i 03 ; Trata se existe query
    1001 copiar 1002
    1002 0 -- ! i 1003
    1003 sub_zero 01

    ; Um
    02 1 -- 1 i 1100
    1100 * -- * i 1101
    1100 [s] -- * i 03
    1101 copiar 1102
    1102 1 -- ! i 1103
    1103 sub_um 01

    ; Dois
    02 2 -- 2 i 1200
    1200 * -- * i 1201
    1200 [s] -- * i 03
    1201 copiar 1202
    1202 2 -- ! i 1203
    1203 sub_dois 01

    ; Tres
    02 3 -- 3 i 1300
    1300 * -- * i 1301
    1300 [s] -- * i 03
    1301 copiar 1302
    1302 3 -- ! i 1303
    1303 sub_tres 01

    ; Quatro
    02 4 -- 4 i 1400
    1400 * -- * i 1401
    1400 [s] -- * i 03
    1401 copiar 1402
    1402 4 -- ! i 1403
    1403 sub_quatro 01

    ; Cinco
    02 5 -- 5 i 1500
    1500 * -- * i 1501
    1500 [s] -- * i 03
    1501 copiar 1502
    1502 5 -- ! i 1503
    1503 sub_cinco 01

    ; Seis
    02 6 -- 6 i 1600
    1600 * -- * i 1601
    1600 [s] -- * i 03
    1601 copiar 1602
    1602 6 -- ! i 1603
    1603 sub_seis 01

    ; Sete
    02 7 -- 7 i 1700
    1700 * -- * i 1701
    1700 [s] -- * i 03
    1701 copiar 1702
    1702 7 -- ! i 1703
    1703 sub_sete 01

    ; Oito
    02 8 -- 8 i 1800
    1800 * -- * i 1801
    1800 [s] -- * i 03
    1801 copiar 1802
    1802 8 -- ! i 1803
    1803 sub_oito 01

    ; Nove
    02 9 -- 9 i 1900
    1900 * -- * i 1901
    1900 [s] -- * i 03
    1901 copiar 1902
    1902 9 -- ! i 1903
    1903 sub_nove 01
fim

bloco sub_query 01
    01 gravar n 02
    02 1 -- 0 i retorne ; Reduz um digito, pois operação anterior usou query
    02 2 -- 1 i retorne
    02 3 -- 2 i retorne
    02 4 -- 3 i retorne
    02 5 -- 4 i retorne
    02 6 -- 5 i retorne
    02 7 -- 6 i retorne
    02 8 -- 7 i retorne
    02 9 -- 8 i retorne
    02 0 -- 9 e 03 ; Quando zero, é um caso especial, pois precisa pegar um query do proximo digito
    03 sub_query retorne
fim

bloco sub_finalizar 09
    09 - -- - i 01
    09 * -- * i 10
    10 sub_moved_menos 01
    01 * -- * e 01 
    01 = -- = i 04 ; Se chegou no igual, vai para etapa de excluir o lixo
    ; Tranforma as letras em suas equivalentes numericas
    01 a -- 0 e 01
    01 b -- 1 e 01
    01 c -- 2 e 01
    01 d -- 3 e 01
    01 e -- 4 e 01
    01 f -- 5 e 01
    01 g -- 6 e 01
    01 h -- 7 e 01
    01 i -- 8 e 01
    01 j -- 9 e 01
    ; Se achar o exclamação, transforma ele em numero novamente utilizando a segunda fita
    01 ! -- ! i 02
    02 colar 03
    03 * -- * e 01
    ; Remove o lixo que sobrou
    04 sub_moved_menos 05
    05 * -- _ d 05
    05 _ -- _ i 06
    06 * -- * e 06
    06 n -- - e 06
    06 = -- = i 07
    07 gravar _ aceite
fim

bloco sub_apaga 01
    01 sub_move_igual 02
    02 = -- = d 03
    03 * -- _ d 03
    03 # -- _ i 04
    04 sub_move_igual 05
    05 * -- * e 05
    05 _ -- _ d retorne
fim

bloco sub_escreve_! 01
    01 * -- * e 01
    01 ! -- ! i 02
    02 colar retorne 
fim

; Move para a direita até encontrar o operando -
bloco sub_moved_menos 01
    01 * -- * d 01
    01 - -- - i retorne
fim

; Move para a esquerda até encontrar o operando -
bloco sub_movee_menos 01
    01 * -- * e 01
    01 - -- - i retorne
fim

bloco sub_move_igual 01
    01 * -- * e 01
    01 = -- = i retorne
fim

bloco sub_move_hash 01
    01 * -- * d 01
    01 # -- * i retorne
fim

; Este bloco cria uma copia da operação que se deseja usar, devolve o ponteiro no =
bloco sub_copia 03
    03 copiar 04
    04 * -- X d 05
    05 * -- * d 05
    05 = -- * d 06
    06 * -- * d 06
    06 _ -- * i 07
    07 colar 08
    08 * -- * e 08
    08 X -- * i 09
    09 colar 10
    10 * -- * d 11
    11 * -- * i 03
    11 = -- * i 12
    12 * -- * d 12
    12 _ -- # i 13
    13 * -- * e 13
    13 = -- = i 14
    14 gravar _ retorne ; Esvazia a segunda fita para não atrapalhar nas proximas execuções
fim

; Este bloco cria uma copia reversa da operação que se deseja usar, devolve o ponteiro no =
bloco sub_copia_rev 01
    01 * -- * d 01
    01 - -- - d 02
    
    02 copiar 03 ; Copiar segundo elemento
    03 * -- X i 04
    03 = -- = i 09
    04 * -- * d 04
    04 _ -- _ i 05
    05 colar 06
    06 * -- * e 06
    06 X -- X i 07
    07 colar 08
    08 * -- * d 02

    09 * -- * d 09 ; Copiar sinal
    09 _ -- - i 10
    10 * -- * e 10
    10 _ -- _ d 11

    11 copiar 12 ; Copiar primeiro elemento
    12 * -- X i 13
    12 - -- - i 18
    13 * -- * d 13
    13 _ -- _ i 14
    14 colar 15
    15 * -- * e 15
    15 X -- X i 16
    16 colar 17
    17 * -- * d 11

    18 * -- * d 18 ; Colocar simbolo final
    18 _ -- # i 19
    19 sub_move_igual 20
    20 gravar _ retorne ; Esvazia a segunda fita para não atrapalhar nas proximas execuções
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco sub_zero 01 ; Realiza as subtrações por 0
    01 sub_move_hash 02 ; Move para o fim
    02 # -- # e 03 
    03 * -- * e 03 ; Esquerda até achar alguma coisa
    03 - -- - i 04 ; Se encontrar menos, acabou a subtração. Retorna a segunda fita com o valor de entrada para preparar para finalização
    04 * -- * i retorne
    ; VALOR 0
    03 0 -- # i 1000 ; Se o numero é 0
    1000 gravar a 1001 ; Grava resultado na fita 2
    1001 sub_escreve_! 1002 ; Escreve no local correto o resultado
    1002 gravar n 04 ; Grava na fita 2 se tem ou não Query
    ; VALOR 1
    03 1 -- # i 1100
    1100 gravar j 1101
    1101 sub_escreve_! 1102
    1102 gravar s 04
    ; VALOR 2
    03 2 -- # i 1200
    1200 gravar i 1201
    1201 sub_escreve_! 1202
    1202 gravar s 04
    ; VALOR 3
    03 3 -- # i 1300
    1300 gravar h 1301
    1301 sub_escreve_! 1302
    1302 gravar s 04
    ; VALOR 4
    03 4 -- # i 1400
    1400 gravar g 1401
    1401 sub_escreve_! 1402
    1402 gravar s 04
    ; VALOR 5
    03 5 -- # i 1500
    1500 gravar f 1501
    1501 sub_escreve_! 1502
    1502 gravar s 04
    ; VALOR 6
    03 6 -- # i 1600
    1600 gravar e 1601
    1601 sub_escreve_! 1602
    1602 gravar s 04
    ; VALOR 7
    03 7 -- # i 1700
    1700 gravar d 1701
    1701 sub_escreve_! 1702
    1702 gravar s 04
    ; VALOR 6
    03 8 -- # i 1800
    1800 gravar c 1801
    1801 sub_escreve_! 1802
    1802 gravar s 04
    ; VALOR 9
    03 9 -- # i 1900
    1900 gravar b 1901
    1901 sub_escreve_! 1902
    1902 gravar s 04
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco sub_um 01 ; Realiza as subtrações por 1
    01 sub_move_hash 02 ; Move para o fim
    02 # -- # e 03 
    03 * -- * e 03 ; Esquerda até achar alguma coisa
    03 - -- - i 04 ; Se encontrar menos, acabou a subtração. Retorna a segunda fita com o valor de entrada para preparar para finalização
    04 * -- * i retorne
    ; VALOR 0
    03 0 -- # i 1000 ; Se o numero é 0
    1000 gravar b 1001 ; Grava resultado na fita 2
    1001 sub_escreve_! 1002 ; Escreve no local correto o resultado
    1002 gravar n 04 ; Grava na fita 2 se tem ou não Query
    ; VALOR 1
    03 1 -- # i 1100
    1100 gravar a 1101
    1101 sub_escreve_! 1102
    1102 gravar n 04
    ; VALOR 2
    03 2 -- # i 1200
    1200 gravar j 1201
    1201 sub_escreve_! 1202
    1202 gravar s 04
    ; VALOR 3
    03 3 -- # i 1300
    1300 gravar i 1301
    1301 sub_escreve_! 1302
    1302 gravar s 04
    ; VALOR 4
    03 4 -- # i 1400
    1400 gravar h 1401
    1401 sub_escreve_! 1402
    1402 gravar s 04
    ; VALOR 5
    03 5 -- # i 1500
    1500 gravar g 1501
    1501 sub_escreve_! 1502
    1502 gravar s 04
    ; VALOR 6
    03 6 -- # i 1600
    1600 gravar f 1601
    1601 sub_escreve_! 1602
    1602 gravar s 04
    ; VALOR 7
    03 7 -- # i 1700
    1700 gravar e 1701
    1701 sub_escreve_! 1702
    1702 gravar s 04
    ; VALOR 6
    03 8 -- # i 1800
    1800 gravar d 1801
    1801 sub_escreve_! 1802
    1802 gravar s 04
    ; VALOR 9
    03 9 -- # i 1900
    1900 gravar c 1901
    1901 sub_escreve_! 1902
    1902 gravar s 04
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco sub_dois 01 ; Realiza as subtrações por 2
    01 sub_move_hash 02 ; Move para o fim
    02 # -- # e 03 
    03 * -- * e 03 ; Esquerda até achar alguma coisa
    03 - -- - i 04 ; Se encontrar menos, acabou a subtração. Retorna a segunda fita com o valor de entrada para preparar para finalização
    04 * -- * i retorne
    ; VALOR 0
    03 0 -- # i 1000 ; Se o numero é 0
    1000 gravar c 1001 ; Grava resultado na fita 2
    1001 sub_escreve_! 1002 ; Escreve no local correto o resultado
    1002 gravar n 04 ; Grava na fita 2 se tem ou não Query
    ; VALOR 1
    03 1 -- # i 1100
    1100 gravar b 1101
    1101 sub_escreve_! 1102
    1102 gravar n 04
    ; VALOR 2
    03 2 -- # i 1200
    1200 gravar a 1201
    1201 sub_escreve_! 1202
    1202 gravar n 04
    ; VALOR 3
    03 3 -- # i 1300
    1300 gravar j 1301
    1301 sub_escreve_! 1302
    1302 gravar s 04
    ; VALOR 4
    03 4 -- # i 1400
    1400 gravar i 1401
    1401 sub_escreve_! 1402
    1402 gravar s 04
    ; VALOR 5
    03 5 -- # i 1500
    1500 gravar h 1501
    1501 sub_escreve_! 1502
    1502 gravar s 04
    ; VALOR 6
    03 6 -- # i 1600
    1600 gravar g 1601
    1601 sub_escreve_! 1602
    1602 gravar s 04
    ; VALOR 7
    03 7 -- # i 1700
    1700 gravar f 1701
    1701 sub_escreve_! 1702
    1702 gravar s 04
    ; VALOR 6
    03 8 -- # i 1800
    1800 gravar e 1801
    1801 sub_escreve_! 1802
    1802 gravar s 04
    ; VALOR 9
    03 9 -- # i 1900
    1900 gravar d 1901
    1901 sub_escreve_! 1902
    1902 gravar s 04
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco sub_tres 01 ; Realiza as subtrações por 3
    01 sub_move_hash 02 ; Move para o fim
    02 # -- # e 03 
    03 * -- * e 03 ; Esquerda até achar alguma coisa
    03 - -- - i 04 ; Se encontrar menos, acabou a subtração. Retorna a segunda fita com o valor de entrada para preparar para finalização
    04 * -- * i retorne
    ; VALOR 0
    03 0 -- # i 1000 ; Se o numero é 0
    1000 gravar d 1001 ; Grava resultado na fita 2
    1001 sub_escreve_! 1002 ; Escreve no local correto o resultado
    1002 gravar n 04 ; Grava na fita 2 se tem ou não Query
    ; VALOR 1
    03 1 -- # i 1100
    1100 gravar c 1101
    1101 sub_escreve_! 1102
    1102 gravar n 04
    ; VALOR 2
    03 2 -- # i 1200
    1200 gravar b 1201
    1201 sub_escreve_! 1202
    1202 gravar n 04
    ; VALOR 3
    03 3 -- # i 1300
    1300 gravar a 1301
    1301 sub_escreve_! 1302
    1302 gravar n 04
    ; VALOR 4
    03 4 -- # i 1400
    1400 gravar j 1401
    1401 sub_escreve_! 1402
    1402 gravar s 04
    ; VALOR 5
    03 5 -- # i 1500
    1500 gravar i 1501
    1501 sub_escreve_! 1502
    1502 gravar s 04
    ; VALOR 6
    03 6 -- # i 1600
    1600 gravar h 1601
    1601 sub_escreve_! 1602
    1602 gravar s 04
    ; VALOR 7
    03 7 -- # i 1700
    1700 gravar g 1701
    1701 sub_escreve_! 1702
    1702 gravar s 04
    ; VALOR 6
    03 8 -- # i 1800
    1800 gravar f 1801
    1801 sub_escreve_! 1802
    1802 gravar s 04
    ; VALOR 9
    03 9 -- # i 1900
    1900 gravar e 1901
    1901 sub_escreve_! 1902
    1902 gravar s 04
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco sub_quatro 01 ; Realiza as subtrações por 4
    01 sub_move_hash 02 ; Move para o fim
    02 # -- # e 03 
    03 * -- * e 03 ; Esquerda até achar alguma coisa
    03 - -- - i 04 ; Se encontrar menos, acabou a subtração. Retorna a segunda fita com o valor de entrada para preparar para finalização
    04 * -- * i retorne
    ; VALOR 0
    03 0 -- # i 1000 ; Se o numero é 0
    1000 gravar e 1001 ; Grava resultado na fita 2
    1001 sub_escreve_! 1002 ; Escreve no local correto o resultado
    1002 gravar n 04 ; Grava na fita 2 se tem ou não Query
    ; VALOR 1
    03 1 -- # i 1100
    1100 gravar d 1101
    1101 sub_escreve_! 1102
    1102 gravar n 04
    ; VALOR 2
    03 2 -- # i 1200
    1200 gravar c 1201
    1201 sub_escreve_! 1202
    1202 gravar n 04
    ; VALOR 3
    03 3 -- # i 1300
    1300 gravar b 1301
    1301 sub_escreve_! 1302
    1302 gravar n 04
    ; VALOR 4
    03 4 -- # i 1400
    1400 gravar a 1401
    1401 sub_escreve_! 1402
    1402 gravar n 04
    ; VALOR 5
    03 5 -- # i 1500
    1500 gravar j 1501
    1501 sub_escreve_! 1502
    1502 gravar s 04
    ; VALOR 6
    03 6 -- # i 1600
    1600 gravar i 1601
    1601 sub_escreve_! 1602
    1602 gravar s 04
    ; VALOR 7
    03 7 -- # i 1700
    1700 gravar h 1701
    1701 sub_escreve_! 1702
    1702 gravar s 04
    ; VALOR 6
    03 8 -- # i 1800
    1800 gravar g 1801
    1801 sub_escreve_! 1802
    1802 gravar s 04
    ; VALOR 9
    03 9 -- # i 1900
    1900 gravar f 1901
    1901 sub_escreve_! 1902
    1902 gravar s 04
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco sub_cinco 01 ; Realiza as subtrações por 5
    01 sub_move_hash 02 ; Move para o fim
    02 # -- # e 03 
    03 * -- * e 03 ; Esquerda até achar alguma coisa
    03 - -- - i 04 ; Se encontrar menos, acabou a subtração. Retorna a segunda fita com o valor de entrada para preparar para finalização
    04 * -- * i retorne
    ; VALOR 0
    03 0 -- # i 1000 ; Se o numero é 0
    1000 gravar f 1001 ; Grava resultado na fita 2
    1001 sub_escreve_! 1002 ; Escreve no local correto o resultado
    1002 gravar n 04 ; Grava na fita 2 se tem ou não Query
    ; VALOR 1
    03 1 -- # i 1100
    1100 gravar e 1101
    1101 sub_escreve_! 1102
    1102 gravar n 04
    ; VALOR 2
    03 2 -- # i 1200
    1200 gravar d 1201
    1201 sub_escreve_! 1202
    1202 gravar n 04
    ; VALOR 3
    03 3 -- # i 1300
    1300 gravar c 1301
    1301 sub_escreve_! 1302
    1302 gravar n 04
    ; VALOR 4
    03 4 -- # i 1400
    1400 gravar b 1401
    1401 sub_escreve_! 1402
    1402 gravar n 04
    ; VALOR 5
    03 5 -- # i 1500
    1500 gravar a 1501
    1501 sub_escreve_! 1502
    1502 gravar n 04
    ; VALOR 6
    03 6 -- # i 1600
    1600 gravar j 1601
    1601 sub_escreve_! 1602
    1602 gravar s 04
    ; VALOR 7
    03 7 -- # i 1700
    1700 gravar i 1701
    1701 sub_escreve_! 1702
    1702 gravar s 04
    ; VALOR 6
    03 8 -- # i 1800
    1800 gravar h 1801
    1801 sub_escreve_! 1802
    1802 gravar s 04
    ; VALOR 9
    03 9 -- # i 1900
    1900 gravar g 1901
    1901 sub_escreve_! 1902
    1902 gravar s 04
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco sub_seis 01 ; Realiza as subtrações por 6
    01 sub_move_hash 02 ; Move para o fim
    02 # -- # e 03 
    03 * -- * e 03 ; Esquerda até achar alguma coisa
    03 - -- - i 04 ; Se encontrar menos, acabou a subtração. Retorna a segunda fita com o valor de entrada para preparar para finalização
    04 * -- * i retorne
    ; VALOR 0
    03 0 -- # i 1000 ; Se o numero é 0
    1000 gravar g 1001 ; Grava resultado na fita 2
    1001 sub_escreve_! 1002 ; Escreve no local correto o resultado
    1002 gravar n 04 ; Grava na fita 2 se tem ou não Query
    ; VALOR 1
    03 1 -- # i 1100
    1100 gravar f 1101
    1101 sub_escreve_! 1102
    1102 gravar n 04
    ; VALOR 2
    03 2 -- # i 1200
    1200 gravar e 1201
    1201 sub_escreve_! 1202
    1202 gravar n 04
    ; VALOR 3
    03 3 -- # i 1300
    1300 gravar d 1301
    1301 sub_escreve_! 1302
    1302 gravar n 04
    ; VALOR 4
    03 4 -- # i 1400
    1400 gravar c 1401
    1401 sub_escreve_! 1402
    1402 gravar n 04
    ; VALOR 5
    03 5 -- # i 1500
    1500 gravar b 1501
    1501 sub_escreve_! 1502
    1502 gravar n 04
    ; VALOR 3
    03 6 -- # i 1600
    1600 gravar a 1601
    1601 sub_escreve_! 1602
    1602 gravar n 04
    ; VALOR 7
    03 7 -- # i 1700
    1700 gravar j 1701
    1701 sub_escreve_! 1702
    1702 gravar s 04
    ; VALOR 8
    03 8 -- # i 1800
    1800 gravar i 1801
    1801 sub_escreve_! 1802
    1802 gravar s 04
    ; VALOR 9
    03 9 -- # i 1900
    1900 gravar h 1901
    1901 sub_escreve_! 1902
    1902 gravar s 04
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco sub_sete 01 ; Realiza as subtrações por 7
    01 sub_move_hash 02 ; Move para o fim
    02 # -- # e 03 
    03 * -- * e 03 ; Esquerda até achar alguma coisa
    03 - -- - i 04 ; Se encontrar menos, acabou a subtração. Retorna a segunda fita com o valor de entrada para preparar para finalização
    04 * -- * i retorne
    ; VALOR 0
    03 0 -- # i 1000 ; Se o numero é 0
    1000 gravar h 1001 ; Grava resultado na fita 2
    1001 sub_escreve_! 1002 ; Escreve no local correto o resultado
    1002 gravar n 04 ; Grava na fita 2 se tem ou não Query
    ; VALOR 1
    03 1 -- # i 1100
    1100 gravar g 1101
    1101 sub_escreve_! 1102
    1102 gravar n 04
    ; VALOR 2
    03 2 -- # i 1200
    1200 gravar f 1201
    1201 sub_escreve_! 1202
    1202 gravar n 04
    ; VALOR 3
    03 3 -- # i 1300
    1300 gravar e 1301
    1301 sub_escreve_! 1302
    1302 gravar n 04
    ; VALOR 4
    03 4 -- # i 1400
    1400 gravar d 1401
    1401 sub_escreve_! 1402
    1402 gravar n 04
    ; VALOR 5
    03 5 -- # i 1500
    1500 gravar c 1501
    1501 sub_escreve_! 1502
    1502 gravar n 04
    ; VALOR 3
    03 6 -- # i 1600
    1600 gravar b 1601
    1601 sub_escreve_! 1602
    1602 gravar n 04
    ; VALOR 7
    03 7 -- # i 1700
    1700 gravar a 1701
    1701 sub_escreve_! 1702
    1702 gravar n 04
    ; VALOR 8
    03 8 -- # i 1800
    1800 gravar j 1801
    1801 sub_escreve_! 1802
    1802 gravar s 04
    ; VALOR 9
    03 9 -- # i 1900
    1900 gravar i 1901
    1901 sub_escreve_! 1902
    1902 gravar s 04
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco sub_oito 01 ; Realiza as subtrações por 8
    01 sub_move_hash 02 ; Move para o fim
    02 # -- # e 03 
    03 * -- * e 03 ; Esquerda até achar alguma coisa
    03 - -- - i 04 ; Se encontrar menos, acabou a subtração. Retorna a segunda fita com o valor de entrada para preparar para finalização
    04 * -- * i retorne
    ; VALOR 0
    03 0 -- # i 1000 ; Se o numero é 0
    1000 gravar i 1001 ; Grava resultado na fita 2
    1001 sub_escreve_! 1002 ; Escreve no local correto o resultado
    1002 gravar n 04 ; Grava na fita 2 se tem ou não Query
    ; VALOR 1
    03 1 -- # i 1100
    1100 gravar h 1101
    1101 sub_escreve_! 1102
    1102 gravar n 04
    ; VALOR 2
    03 2 -- # i 1200
    1200 gravar g 1201
    1201 sub_escreve_! 1202
    1202 gravar n 04
    ; VALOR 3
    03 3 -- # i 1300
    1300 gravar f 1301
    1301 sub_escreve_! 1302
    1302 gravar n 04
    ; VALOR 4
    03 4 -- # i 1400
    1400 gravar e 1401
    1401 sub_escreve_! 1402
    1402 gravar n 04
    ; VALOR 5
    03 5 -- # i 1500
    1500 gravar d 1501
    1501 sub_escreve_! 1502
    1502 gravar n 04
    ; VALOR 3
    03 6 -- # i 1600
    1600 gravar c 1601
    1601 sub_escreve_! 1602
    1602 gravar n 04
    ; VALOR 7
    03 7 -- # i 1700
    1700 gravar b 1701
    1701 sub_escreve_! 1702
    1702 gravar n 04
    ; VALOR 8
    03 8 -- # i 1800
    1800 gravar a 1801
    1801 sub_escreve_! 1802
    1802 gravar n 04
    ; VALOR 9
    03 9 -- # i 1900
    1900 gravar j 1901
    1901 sub_escreve_! 1902
    1902 gravar s 04
fim

; 0a 1b 2c 3d 4e 5f 6g 7h 8i 9j
bloco sub_nove 01 ; Realiza as subtrações por 9
    01 sub_move_hash 02 ; Move para o fim
    02 # -- # e 03 
    03 * -- * e 03 ; Esquerda até achar alguma coisa
    03 - -- - i 04 ; Se encontrar menos, acabou a subtração. Retorna a segunda fita com o valor de entrada para preparar para finalização
    04 * -- * i retorne
    ; VALOR 0
    03 0 -- # i 1000 ; Se o numero é 0
    1000 gravar j 1001 ; Grava resultado na fita 2
    1001 sub_escreve_! 1002 ; Escreve no local correto o resultado
    1002 gravar n 04 ; Grava na fita 2 se tem ou não Query
    ; VALOR 1
    03 1 -- # i 1100
    1100 gravar i 1101
    1101 sub_escreve_! 1102
    1102 gravar n 04
    ; VALOR 2
    03 2 -- # i 1200
    1200 gravar h 1201
    1201 sub_escreve_! 1202
    1202 gravar n 04
    ; VALOR 3
    03 3 -- # i 1300
    1300 gravar g 1301
    1301 sub_escreve_! 1302
    1302 gravar n 04
    ; VALOR 4
    03 4 -- # i 1400
    1400 gravar f 1401
    1401 sub_escreve_! 1402
    1402 gravar n 04
    ; VALOR 5
    03 5 -- # i 1500
    1500 gravar e 1501
    1501 sub_escreve_! 1502
    1502 gravar n 04
    ; VALOR 3
    03 6 -- # i 1600
    1600 gravar d 1601
    1601 sub_escreve_! 1602
    1602 gravar n 04
    ; VALOR 7
    03 7 -- # i 1700
    1700 gravar c 1701
    1701 sub_escreve_! 1702
    1702 gravar n 04
    ; VALOR 8
    03 8 -- # i 1800
    1800 gravar b 1801
    1801 sub_escreve_! 1802
    1802 gravar n 04
    ; VALOR 9
    03 9 -- # i 1900
    1900 gravar a 1901
    1901 sub_escreve_! 1902
    1902 gravar n 04
fim