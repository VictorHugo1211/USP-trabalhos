arma(alan).
arma(luis).
arma(lucas).

viucrime(jean, alan).

devedinheiro(lucas, jean).
devedinheiro(luis, jean).

benefortuna(jean, luis).
benefortuna(bernardo, jean).

vingar(lucas, jean).
vingar(paulo, jean).

nao_confiavel(alan).

alibi_quinta(alan, lucas).
alibi_terca(luis, lucas).
alibi_terca(paulo, bernardo).
alibi_terca(lucas, bernardo).

sem_alibi_terca(alan).
sem_alibi_terca(bernardo).

int_matar(Y,X) :-
  viucrime(X,Y);
  devedinheiro(Y,X);
  arma(Y).

motivo_matar(Y,X) :-
  int_matar(Y,X);
  vingar(Y,X).

assassino(Y) :-
  motivo_matar(Y,jean),
  arma(Y),
  sem_alibi_terca(Y).

resolver :-
  assassino(Y),
  write('Jean foi morto na terça-feira e seu assassino é '),
  write(Y), nl.