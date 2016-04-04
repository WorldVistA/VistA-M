DIOQ ;SFISC/GS,TKW-QUERY OPTIMIZER ;4/5/95  14:02
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
SER(F,DIOQGET,DIOQCHEK,C,X,%,W) ; COMPUTE SEARCH EFFICIENCY RATING
 ; F=FILE#, DIOQGET=GET CODE, DIOQCHEK=EVALUATION CODE,
 ; C=USEABLE INDEX? (1=YES, 0=NO)
 ; X=EFFICIENCY RATING, %=PREVALANCE OF HITS (PROBABILITY)
 ; W=WRITE PROGRESS MSG.TO USER
 N Z S (X,%)=0,W=$G(W),Z=$G(^DIC(+$G(F),0,"GL")) Q:Z=""
 N I,N,T,D0,DA,DITRUE,DIFIRST S DIFIRST=1
 I W S W=$P($H,",",2)+.1
 S (T,N)=0,I=$P(@(Z_"0)"),U,4)\100
 F D0=0:I S D0=$O(@(Z_D0_")")) Q:'D0  Q:N>100  S DA=D0,N=N+1 D TEST I DITRUE S T=T+1
 S %=$S(N=0:1,T=0:0,1:T/N),(X,%)=1-% I C S:%=1 X=100 S:%'=1 X=%/(1-%)
 S X=$J(X,1,4),%=$J(%,1,4) Q
 ;
TEST ; GET VALUE AND EVALUATE IT
 N I,L,N,T,Z,DIOQSVD0 S DIOQSVD0=D0 D  S D0=DIOQSVD0
 . N F,C,W,DIFIRST
 . X DIOQGET,DIOQCHEK S DITRUE=$T Q
 Q:'W  Q:($P($H,",",2)-W)'>3  S W=$P($H,",",2)+.1
 I DIFIRST S DIFIRST=0 W !,"Computing search efficiency..." Q
 W "." Q
