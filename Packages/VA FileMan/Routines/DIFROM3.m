DIFROM3 ;SFISC/XAK-CREATES RTN ENDING IN 'INIT2' (HELP FRAMES) ; 6 DEC 2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 S DIRS=" S DIFQ=1"
 S DNAME=E_2,DL=0,(DH,Q)=" ;" K ^UTILITY($J) F DD=1:1 S X=$T(TEXT+DD) Q:X=""  S ^UTILITY($J,DD,0)=$E(X,4,999) S:$E(X,4)="U" ^(0)=^(0)_DIRS
 S DIFROM=2 D ZI G ^DIFROM4
 ;
FILE ;
 D:'$D(DISYS) OS^DII S DL=0,Q="Q Q",S=" ;;"
NAME S D=0
 I DRN>12959 K DRN Q
 S DNAME=DN_$$B36(DRN)
ZI ;
 I '$D(DIFROM(1)) S %H=+$H D YX^%DTC S DIFROM(1)=$E(Y,5,6)_"-"_$E(Y,1,3)_"-"_$E(Y,9,12)
2 K ^UTILITY($J,0)
 S ^(0,1)=DNAME_" ; ; "_DIFROM(1),D=$L(^(1))+2 ; (2 = CR/LF)
 S ^(1.1)=DILN2,D=D+$L(^(1.1))+2 ; (2 = CR/LF)
 S ^UTILITY($J,0,2)=DH,D=D+$L(^(2))+2 ; (2 ditto)
 S ^UTILITY($J,0,3)=Q,D=D+$L(^(3))+2 ; (2 ditto)
 F L=4:1 D  Q:DL'>0  I D+257>DIFRM,$E(^(L),4)'="^",$E(^(L),4)'=$C(126) Q  ; 255 for a line extra in M95 + 2 CR/LF
 . S DL=$O(^UTILITY($J,DL))
 . Q:DL'>0
 . S ^UTILITY($J,0,L)=S_^(DL,0)
 . S D=$L(^(L))+D+2 ; VEN/SMH - Add 2 charcaters for CR/LF
 S DRN=DRN+1,X=DNAME X ^DD("OS",DISYS,"ZS") W !,X_" HAS BEEN FILED..." G NAME:DL>0
K K %A,%B,%C,%Z,^UTILITY($J) S DL=0 Q
 ;
B36(X) ;Calculate base 36 number from 0 (000) to 46,655 (ZZZ).
 S X=$G(X) I X>46655 Q ""
 Q $$N(X\(36*36)#36+1)_$$N(X\36#36+1)_$$N(X#36+1)
N(%) Q $E("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",%)
 ;
TEXT ;
 ;; K ^UTILITY("DIFROM",$J),DIC S DIDUZ=0 S:$D(DUZ)#2 DIDUZ=DUZ S DUZ=.5
 ;; I $D(^DIC(9.2,0))#2,^(0)?1"HEL".E S (DIC,DLAYGO)=9.2,N="HEL",DIC(0)="LX" G ADD
 ;; Q
 ;; ;
 ;;ADD F R=0:0 S R=$O(^UTILITY(U,$J,N,R)) Q:R'>0  S X=$P(^(R,0),U,1) W "." K DA D ^DIC I Y>0,'$D(DIFQ(N))!$P(Y,U,3) S ^UTILITY("DIFROM",$J,N,X)=+Y K ^DIC(9.2,+Y,1),^(2),^(3),^(10) S %X="^UTILITY(U,$J,N,R,",%Y=DIC_"+Y,",DA=+Y D %XY^%RCR
 ;; S DIK=DIC
 ;;HELP S R=$O(^UTILITY("DIFROM",$J,N,R)) Q:R=""  W !,"'"_R_"' Help Frame filed." S DA=^(R)
 ;; F X=0:0 S X=$O(^DIC(9.2,DA,2,X)) Q:'X  S I=$S($D(^(X,0)):^(0),1:0),Y=$P(I,U,2) S:Y]"" Y=$O(^DIC(9.2,"B",Y,0)) S ^(0)=$P(^DIC(9.2,DA,2,X,0),U,1)_U_$S(Y>0:Y,1:"")_U_$P(^(0),U,3,99)
 ;; S I=0 F X=0:0 S X=$O(^DIC(9.2,DA,10,X)) Q:'X  I $D(^(X,0)) S Y=$P(^(0),U),Y=$S(Y]"":$O(^MAG("B",Y,0)),1:0) S:Y $P(^DIC(9.2,DA,10,X,0),U)=Y,I=I+1,%=X I 'Y K ^DIC(9.2,DA,10,X,0)
 ;; I I S $P(^DIC(9.2,DA,10,0),U,3,4)=%_U_I
 ;;IX D IX1^DIK G HELP
 ;; ;
 ;;U I $D(DIRUT)
 ;; W ! Q
 ;;REP S DIR(0)="Y",DIR("A")="Shall I change the NAME of the file to "_DIF
 ;; S DIR("??")="^D REP^DIFROMH1",DIR("B")="NO" D ^DIR G U:$D(DIRUT)
 ;; I Y S DIE=1,DIFQ=0,DA=N,DR=".01////"_DIF D ^DIE Q
 ;; S DIR("A")="Shall I replace your file with mine"
 ;; S DIR("??")="^D AG^DIFROMH1" D ^DIR G U:$D(DIRUT)!'Y
 ;; S DIU(0)="E",DIR("A")="Do you want to keep the Data"
 ;; S DIR("??")="^D CHG^DIFROMH1" D ^DIR G U:$D(DIRUT)
 ;; S:'Y DIU(0)=DIU(0)_"D"
 ;; S DIR("A")="Do you want to keep the Templates"
 ;; S DIR("??")="^D TEMP^DIFROMH1" D ^DIR G U:$D(DIRUT) S:'Y DIU(0)=DIU(0)_"T"
 ;; S DIFQ(N)=1,DIFKEP(N)=DIU(0) W !?15," (",DIF,") " Q
