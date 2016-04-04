DID2 ;SFISC/GFT-MODIFIED DD ;25JUL2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**7,105,999,1042**
 ;
 I $D(DINM) G DZ:X'["C"!(X["X")!'$D(^DD(F(Z),DJ(Z),9.1)) S %Y=X,X=^(9.1),W=" --  "_X D ^DIM,W1^DIDH1:'$D(X) S X=%Y G Q:M=U G DZ
 F I=9.2:.1 Q:'$D(^(I))#2  W ! S W=I_" = "_^(I) D W G Q:M=U
 I $D(^(9.1))#2 S W=^(9.1),%Y="9.1 = " S:X["C" %Y="ALGORITHM:  " W !,?DDL1,%Y D W S W=$P("  (ALWAYS "_$E(N,$L(N)-1)_" DECIMAL DIGITS)",U,N?.E1" S X=$J(X,0,"1N1")") D W G Q:M=U
DZ ;
 I $D(^("DT")) S Y=^("DT") D D^DIQ W !?DDL1,"LAST EDITED: " S W=Y D W1^DIDH1 G Q:M=U
H K W I $D(^DD(F(Z),DJ(Z),3)),^(3)]"" W !?DDL1,"HELP-PROMPT:" S W=^(3) D W1^DIDH1 G Q:M=U
EGP F %Y=0:0 S %Y=$O(^DD(F(Z),DJ(Z),.009,%Y)) Q:'%Y  I $D(^(%Y,0)) S W="("_^(0)_")" W ! D W1^DIDH1 G Q:M=U ;**CCO/NI  FOREIGN-LANGUAGE HELP-PROMPTS
 F %Y=21,23 I $O(^DD(F(Z),DJ(Z),%Y,0))>0 D DE^DIDH1 G:M=U Q
SC ;
 I $D(^DD(F(Z),DJ(Z),12.1)),'$D(DINM) I X["P"!(X["S") W !?DDL1,"SCREEN:" S W=^(12.1) D W I $D(^(12)) W !?DDL1,"EXPLANATION:" S W=^(12) D W G Q:M=U
 I '$D(DINM),$D(^DD(F(Z),DJ(Z),4)),^(4)]"" W !?DDL1,"EXECUTABLE HELP:" S W=^(4) D W G Q:M=U
 I $D(^(9.02))#2 W !?DDL1,"SUM:" S W=^(9.02) D W G Q:M=U
AUD S W=$G(^DD(F(Z),DJ(Z),"AUDIT")) I "n"'[W D  G:M=U Q
 . W !?DDL1,"AUDIT: "
 . S W=$S(W="y":"YES, ALWAYS",W="e":"EDITED OR DELETED",1:W) D W Q:M=U
 . S W=$G(^DD(F(Z),DJ(Z),"AX"))
 . I '$D(DINM),W]"" W !?DDL1,"AUDIT CONDITION: " D W
PRELKUP I '$D(DINM),DJ(Z)=.01,$G(^DD(F(Z),DJ(Z),7.5))]"" W !?DDL1,"PRE-LOOKUP: " S W=^(7.5) D W G:M=U Q
DEL N DIDND
 I '$D(DINM) S DIDND=$O(^DD(F(Z),DJ(Z),"DEL","")) I DIDND]"" D  G:M=U Q W !
 . W !?DDL1,"DELETE TEST: "
 . F  D  S DIDND=$O(^DD(F(Z),DJ(Z),"DEL",DIDND)) Q:DIDND=""!(M=U)  W !!
 .. S W=$$QT(DIDND)_",0)= " D W Q:M=U
 .. S W=$G(^DD(F(Z),DJ(Z),"DEL",DIDND,0)) D W
LAYGO I '$D(DINM),DJ(Z)=.01 S DIDND=$O(^DD(F(Z),DJ(Z),"LAYGO","")) I DIDND]"" D  G:M=U Q W !
 . N J W !?DDL1,"LAYGO TEST: "
 . F  D  S DIDND=$O(^DD(F(Z),DJ(Z),"LAYGO",DIDND)) Q:DIDND=""!(M=U)  W !!
 .. S W=$$QT(DIDND)_",0)= " D W Q:M=U
 .. S W=$G(^DD(F(Z),DJ(Z),"LAYGO",DIDND,0)) D W
D I $D(^DD(F(Z),DJ(Z),8.5)) W !?DDL1,"DELETE AUTHORITY: " S W=^(8.5) D W G Q:M=U
 I X'["C",$D(^(9))#2,^(9)]"" W !?DDL1,"WRITE AUTHORITY:" S W=^(9) D W G Q:M=U
RD I $D(^(8))#2,^(8)]"" W !?DDL1,"READ AUTHORITY:" S W=^(8) D W G Q:M=U
 I $D(^(10))#2,^(10)]"" W !?DDL1,"SOURCE OF DATA:" S W=^(10) D W G Q:M=U
 I $O(^(11,0))>0 W !?DDL1,"DATA DESTINATION:" S I=0 F  S I=$O(^DD(F(Z),DJ(Z),11,I)) Q:I=""  S:$D(^DIC(.2,+^(I,0),0)) W=$P(^(0),U)
 I  S I=-1 D W G Q:M=U
 I $O(^DD(F(Z),DJ(Z),20,0))>0 W !?DDL1,"GROUP:" S I=0 F  S I=$O(^DD(F(Z),DJ(Z),20,I)) Q:I=""  S W=$P(^(I,0),U)
 I  S I=-1 D W
 Q
 ;
W F K=0:0 S:(($L(W)+DDL2)>IOM) DDL2=32 W ?DDL2 S %Y=$E(W,IOM-$X,999) W $E(W,1,IOM-$X-1) Q:%Y=""  S W=%Y W !
 I $Y+6>IOSL S DC=DC+1 D ^DIDH
 I $D(^DD(F(Z),DJ(Z),0))
 Q
 ;
Q G ND^DID1
 ;
MOD ;FROM DID
 S X=U,%=2 W !,"WANT THE LISTING TO INCLUDE MUMPS CODE" D YN^DICN Q:%<0  S:%=2 DINM=1 I '% W !?5,"Enter YES, to see the MUMPS code as in the STANDARD listing.",!?5,"Enter NO, to eliminate MUMPS code from the listing." G MOD
MOD2 S %=2 W !,"WANT TO RESTRICT LISTING TO CERTAIN GROUPS OF FIELDS" D YN^DICN S:%=2 X=0 Q:%<0!(%=2)  I '% W !?5,"Enter YES, to select the Groups you wish to see in this listing.",!?5,"Enter NO, to see all fields." G MOD2
 W ! S DP="",L=""","_$S(Y-2:"DJ(Z)",1:"D1")_"))"
G R "Include GROUP: ",X:DTIME S:'$T X=U,DTOUT=1 I X[""""!($L(X)>30)!(X'?.ANP) W $C(7),!,"SORRY, THAT ISN'T WHAT A 'GROUP' NAME CAN LOOK LIKE",! G G
 Q:X[U  I X'?."?" S C="!" S:X?1"'"1E.E X=$E(X,2,99),C="&'" S DP=DP_C_"$D(^DD(F(Z),""GR"","""_X_L W !,"And " G G
 I X="" S:DP]"" DIGR="I "_$E(DP,2,999) Q
 W !?5,"To list only those fields which have a particular 'GROUP'",!?5,"(or several 'GROUPS') associated with them, Enter the GROUP NAME",!
 W ?5,"To screen out a group, Type ""'"" in front of its name.",!
 G G
 ;
QT(X) ;Quote X if noncanonic
 Q:X=+$P(X,"E") X
 S X=$NA(X(X)),X=$E(X,3,$L(X)-1)
 Q X
