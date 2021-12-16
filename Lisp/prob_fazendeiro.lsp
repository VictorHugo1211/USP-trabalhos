"
VICTOR HUGO FERNANDES DA SILVA
N° USP: 12750500

PARA EXECUTAR O PROGRAMA, COPIE AS FUNÇÕES E COLE NO COMPILADOR E PARA VER A SOLUÇÃO EXECUTANDO O PROGRAMA 
DIGITE '(main)' E APERTE ENTER, COMPILADOR IRÁ GERAR A RESOLUÇÃO DO PROBLEMA E MOSTRAR OS PASSOS REALIZADOS
NA TELA.

IDE UTILIZADA: PORTACLE.
https://portacle.github.io/#get-win

"


(defun main ()
    ; (main) : define o estado inicial

    (let 
        (
            ; Mantém o controle de itens. 0 = 1ª margem, 1 = 2ª margem
            (estado_atual '(0 0 0 0)) 
            ; Acompanha o movimento mais recente para evitar voltar
            (mov_previ '-1) 
            (est_lista nil) ; Lista de estados
            (mov_lista nil) ; Lista de movimentos
        )
        (explore estado_atual mov_previ est_lista mov_lista)
    )   
)

; Explora o espaço de estado e verifica se o estado da meta foi alcançado ou se o estado atual for perigoso retorna t ou nil
(defun explore (estado_atual mov_previ est_lista mov_lista)
    
    (cond 
        ((equal estado_atual '(1 1 1 1)) ; Estado da cabra
            (setf est_lista (cons estado_atual est_lista)) ; Adiciona o estado final à lista de caminhos
            
            (setf mov_lista (cons mov_previ mov_lista)); Adiciona o movimento final à lista de movimentos
              
            (print-solution (reverse est_lista) (reverse mov_lista)) ; Chama a função de impressão com o caminho e lista de movimentação
            t
        )
        
        ; Verifica se há estados perigosos
        ((or
            ; Lobo e cabra sem o fazendeiro 
            (and 
                (equal (nth 1 estado_atual) (nth 2 estado_atual)) 
                (not (equal (nth 0 estado_atual) (nth 1 estado_atual)))
            )
            ; Cabra e repolho sem o fazendeiro
            (and 
                (equal (nth 2 estado_atual) (nth 3 estado_atual)) 
                (not (equal (nth 0 estado_atual) (nth 2 estado_atual)))
            )
         )  nil
        )

        ; Aplicando as regras de mudanças dos estados
        ((regra_mudancas estado_atual mov_previ est_lista mov_lista) 
            t
        )
    )
)

; Define as regras de transição de estado. Verifica se movimentos podem ser feitos e faz chamadas recursivas
(defun regra_mudancas (estado_atual mov_previ est_lista mov_lista)

    ; Verifica o estado perigoso e adiciona estado à lista de caminhos e move para o mov_lista
    (setf est_lista (cons estado_atual est_lista))
    (setf mov_lista (cons mov_previ mov_lista))
    
    (cond 
        ; if mov_previ != 0
        ; move F (muda o primeiro elemento: 0 p/ 1 ou 1 p/ 0)
        ; if explore (estado_atual, 0) == success
            ; return success
        ((and
            (not (= mov_previ '0)) 
            (explore (list (aux_mud_estado (nth 0 estado_atual))
                           (nth 1 estado_atual)
                           (nth 2 estado_atual)
                           (nth 3 estado_atual)
                     ) '0 est_lista mov_lista)
         ) t 
        )

        ; if mov_previ != 1 & F e L mesmo lado
        ; move F e L (muda o primeiro & segundo elemento: 0 p/ 1 ou 1 p/ 0)
        ; if explore (estado_atual, 1) == success
            ; return success
        ((and 
            (not (= mov_previ '1)) 
            (equal (nth 0 estado_atual) (nth 1 estado_atual))
            (explore (list (aux_mud_estado (nth 0 estado_atual))
                           (aux_mud_estado (nth 1 estado_atual))
                           (nth 2 estado_atual)
                           (nth 3 estado_atual)
                     ) '1 est_lista mov_lista)
         ) t
        )

        ; if mov_previ != 2 & F e C mesmo lado
        ; move F e C (muda o primeiro & terceiro elemento: 0 p/ 1 ou 1 p/ 0)
        ; if explore (estado_atual, 2) == success
            ; return success
        ((and 
            (not (= mov_previ '2)) 
            (equal (nth 0 estado_atual) (nth 2 estado_atual))
            (explore (list (aux_mud_estado (nth 0 estado_atual))
                           (nth 1 estado_atual)
                           (aux_mud_estado (nth 2 estado_atual))
                           (nth 3 estado_atual)
                     ) '2 est_lista mov_lista)
         ) t
        )

        ; if mov_previ != 3 & F e R mesmo lado
        ; move F e R (muda o primeiro & quarto elemento: 0 p/ 1 ou 1 p/ 0)
        ; if explore (estado_atual, 3) == success
            ; return success
        ((and 
            (not (= mov_previ '3)) 
            (equal (nth 0 estado_atual) (nth 3 estado_atual))
            (explore (list (aux_mud_estado (nth 0 estado_atual))
                           (nth 1 estado_atual)
                           (nth 2 estado_atual)
                           (aux_mud_estado (nth 3 estado_atual))
                     ) '3 est_lista mov_lista)
         ) t
        )
    )
)

; Auxiliar para alterar o estado do banco dependendo do estado atual
(defun aux_mud_estado (banco)
 
   (cond ((equal banco 1) 0)
             ((equal banco 0) 1))
)

; A função de impressão usa a lista de estado e a lista de movimentos para imprimir cada estágio no caminho da solução.
(defun print-solution (est_lista mov_lista)
    
    (let 
        (
            ; Variável local para construir lista de itens e facilitar a impressão
            (items nil) 
        )

    ; Legenda
    (format t "* * * * * * * * * *~%")
    (format t "* F - Fazendeiro  *~%")
    (format t "* L - Lobo        *~%")
    (format t "* C - Cabra       *~%")
    (format t "* R - Repolho     *~%")
    (format t "* * * * * * * * * *~%~%")
    ; INFOS
    (format t "1ª Margem          2ª Margem                     Atividade~%")
    (format t "_________          __________          ____________________________~%")

    ; Entra em loop até o tamanho da mov_lista
    (dotimes (i (length mov_lista)) 
        
        ; Primeira margem
        ; Verifica quais posições na lista são definidas como 0, indicando a primeira margem. 
        ; Adiciona os itens para serem impressos
        (cond
            ((equal (nth i est_lista) '(1 1 1 1)) (format t "~19a" "-"))
            (t  
                (cond
                    ((equal (nth 0 (nth i est_lista)) '0) 
                        (setf items (cons 'f items)))
                )
                (cond
                    ((equal (nth 1 (nth i est_lista)) '0) 
                        (setf items (cons 'l items)))
                )
                (cond
                    ((equal (nth 2 (nth i est_lista)) '0) 
                        (setf items (cons 'c items)))
                )
                (cond
                    ((equal (nth 3 (nth i est_lista)) '0) 
                        (setf items (cons 'r items)))
                )   
                (format t "~19a" (reverse items))
                (setf items nil)
            )
        )

        ; Segunda margem
        ; Verifica quais posições na lista são definidas como 1, indicando a segunda margem. 
        ; Adiciona os itens para serem impressos
        (cond
            ((equal (nth i est_lista) '(0 0 0 0)) (format t "~20a" "-"))
            (t 
                (cond
                    ((equal (nth 0 (nth i est_lista)) '1) 
                        (setf items (cons 'f items)))
                )
                (cond
                    ((equal (nth 1 (nth i est_lista)) '1) 
                        (setf items (cons 'l items)))
                )
                (cond
                    ((equal (nth 2 (nth i est_lista)) '1) 
                        (setf items (cons 'c items)))
                )
                (cond
                    ((equal (nth 3 (nth i est_lista)) '1) 
                        (setf items (cons 'r items)))
                )  
                (format t "~20a" (reverse items))
                (setf items nil)
            )
        )

        ; Verifica o movimento e o estado do fazendeiro para imprimir a saída correta
        (cond
            ((equal (nth i mov_lista) '-1) (format t "- Estado inicial -~%"))
            
            ((and (equal(nth i mov_lista)'0) (equal(nth 0 (nth i est_lista))'1))
                (format t "Fazendeiro atravessa sozinho~%"))
            ((and (equal(nth i mov_lista)'0) (equal(nth 0 (nth i est_lista))'0))
                (format t "Fazendeiro volta sozinho~%"))
                
            ((and (equal(nth i mov_lista)'1) (equal(nth 0 (nth i est_lista))'1))
                (format t "Fazendeiro leva o lobo~%"))
            ((and (equal(nth i mov_lista)'1) (equal(nth 0 (nth i est_lista))'0))
                (format t "Fazendeiro volta com o lobo~%"))
                
            ((and (equal(nth i mov_lista)'2) (equal(nth 0 (nth i est_lista))'1))
                (format t "Fazendeiro leva a cabra~%"))
            ((and (equal(nth i mov_lista)'2) (equal(nth 0 (nth i est_lista))'0))
                (format t "Fazendeiro volta com a cabra~%"))

            ((and (equal(nth i mov_lista)'3) (equal(nth 0 (nth i est_lista))'1))
                (format t "Fazendeiro leva o repolho~%"))
            ((and (equal(nth i mov_lista)'3) (equal(nth 0 (nth i est_lista))'0))
                (format t "Fazendeiro volta com o repolho~%"))
        )
    )
    (format t "~39a" " ")
    (format t "- Problema resolvido -") 
    )
)