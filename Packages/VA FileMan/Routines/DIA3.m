DIA3 ;SFISC/GFT-UPDATE POINTERS, CHECK CODE IN INPUT STRING, CHECK FILE ACCESS ;19SEP2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**142**
 ;
 S Y=DIA("P"),DH=1,DTO=DIA D PTS^DIT:'$D(^UTILITY("DIT",$J,0)) S ^UTILITY("DIT",$J,0)=0 Q:$D(^(0))<9
 D ASK^DITP Q:%-1
 S Y=0 I @("$O("_DIC_"0))'>0") G D
C W !,"WHICH DO YOU WANT TO DO? --",!?4,"1) DELETE ALL SUCH POINTERS",!?4,"2) CHANGE ALL SUCH POINTERS TO POINT TO A DIFFERENT '"_$P(^(0),U,1)_"' ENTRY",!!,"CHOOSE 1) OR 2): " R %:DTIME G F:U[%,W:%=2,C:%'=1
D W !,"DELETE ALL POINTERS" D YN^DICN G F:%<0,C:%-1,DITP
W W !,"THEN PLEASE INDICATE WHICH ENTRY SHOULD BE POINTED TO" D L^DIA2 G DITP:Y>0
F W $C(7),!,"OK... FORGET IT... LET'S GO ON TO EDIT ANOTHER ENTRY" Q
DITP S (^UTILITY("DIT",$J,DIA(1)),^(DIA(1)_";"_$E(DIA,2,999)))=+Y_";"_$E(DIA,2,999)
 W !?4,"("_$P("DELETION^RE-POINTING",U,''Y+1)_" WILL OCCUR WHEN YOU LEAVE 'ENTER/EDIT' OPTION)"
 Q
 ;
FIXPT(DIFLG,DIFILE,DIDELIEN,DIPTIEN) ;DELETE OR REPOINT POINTERS  ---never done??
 ;In V21, will just delete pointers.  Later, DIPTIEN will be record to repoint to.
 ;DIFLG="D" (delete), DIFILE=File# previously pointed to, DIDELIEN=Record# previously pointed to, DIPTIEN=New pointed-to record(future)
 N %X,%Y,X,Y,DIPTIEN,DIFIXPT,DIFIXPTC,DIFIXPTH D  I $G(X)]"" D BLD^DIALOG(201,X) Q
 . S X="DIFLG" Q:$G(DIFLG)'="D"  S X="DIDELIEN" Q:'$G(DIDELIEN)  S X="DIFILE" Q:'$G(DIFILE)  Q:$G(^DIC(DIFILE,0,"GL"))=""
 . S X="DIPTIEN" I $G(DIPTIEN) S Y=$G(^DD(DIFILE,0,"GL")) Q:Y=""  I '$D(@(Y_DIPTIEN_",0)")) Q  ;<<<Kevin T found bad code 11/14/05
 . K X Q
 S DIPTIEN=+$G(DIPTIEN),(DIFIXPT,DIFIXPTC)=1
 N %,BY,D,DHD,DHIT,DIA,DIC,DISTOP,DL,DR,DTO,FLDS,FR,IOP,L,TO,X,Y,Z K ^UTILITY("DIT",$J),^TMP("DIFIXPT",$J)
 S (DIFILE,DIA("P"),Y)=+DIFILE,(DIA,DTO)=^DIC(DIFILE,0,"GL"),DIA(1)=DIDELIEN
 D PTS^DIT S ^UTILITY("DIT",$J,0)=0 G:$D(^(0))<9 QFIXPT
 S (^UTILITY("DIT",$J,DIA(1)),^(DIA(1)_";"_$E(DIA,2,999)))=DIPTIEN_";"_$E(DIA,2,999)
 D P^DITP
QFIXPT K ^UTILITY("DIT",$J),DIFLG,DIFILE,DIDELIEN,DIIOP,DIPTIEN Q
 ;
X ;
 I 'Y S:'DSC&DB DB=DB+1 S Y=0 F  S Y=$O(Y(Y)) D D^DIA:Y'="" I Y="" S Y=-1 G 2^DIA
 S Y=X I DUZ(0)="@",X'?.E1":" S X=$S(X["//^":$P(X,"//^",2),1:X),X=$S(X[";":$P(X,";"),1:X) D ^DIM G:$D(X) P^DIA:X=Y I Y["//^",'$D(X) G BAD
 I Y[";" F %=2:1 S D=$P(Y,";",%) Q:D=""  S D=$S(D="DUP":"d",D="REQ":"R","""R""d"""[D:"",$A(D)=34:$E(D,2,$F(D,"""",2)-2),D="T":D,1:"") G BAD:D="",DIA3^DIQQQ:$A(D)>45&($A(D)<58)!(D[":") S DV=D_$C(126)_DV
 I Y[";" S X=$P(Y,";",1) S:'$D(DIAB) DIAB=Y G DIC^DIA
 F DK="///+","//+","///","//" I Y[DK S DP=$P(Y,DK,2,9) I DP'?1"/".E&(DP'?1"^".E)!(DUZ(0)="@") G DEF
 G BAD:Y'?.E1":"
E K X S:'$D(DIAB) DIAB=Y S DICOMP=L_"WE?",DQI="Y(",DA="DR(99,"_DXS_",",X=Y,DICMX=1 D ^DICOMPW I '$D(X) K DIAB G BAD:'$D(DP),ACC
L I $D(X)>1 S DXS=DXS+1,%=0 F  S %=$O(X(%)) Q:%=""  S @(DA_"%)=X(%)")
 S %=-1 S L=$S(Y>L:+Y,1:L\100+1*100),Y=U_DP_U_U_X_" S X=$S(D(0)>0:D(0),1:"""")",DRS=99 K X D DB^DIA S DI=+DP G FILETOP^DIA
 ;
DEF S X="DA,DV,DWLC,0)=X" F J=L:-1 Q:I(J)[U  S X="DA("_(L-J+1)_"),"_I(J)_","_X
 S DICMX="S DWLC=DWLC+1,"_DIA_X,DA="DR(99,"_DXS_",",DHIT=Y,X=DP,DQI="X(",DICOMP=L_"T?" D EN^DICOMP,DICS^DIA,XEC K X S X=$P(DHIT,DK,1),DV=DV_DK_DP G DIC^DIA:DV'[";"
BAD Q:$D(DTOUT)  G X^DIA
ACC K DIAB W !?9,"YOU HAVE NO WRITE ACCESS TO FILE "_+DP G BAD
 Q
 ;
XEC I $D(X),Y["m" S DIC("S")="S %=$P(^(0),U,2) I %,$D(^DD(+%,.01,0)),$P(^(0),U,2)[""W"",$D(^DD(DI,Y,0)) "_DIC("S")
 S Y=0 F  S Y=$O(X(Y)) Q:Y=""  S @(DA_"Y)=X(Y)")
 S Y=-1 I $D(X) S %=1,Y="DO YOU MEAN '"_DP_"' AS A VARIABLE" W !?63-$L(Y),Y D YN^DICN Q:%-1  S Y="Q",DXS=DXS+1,DP=U_X,DRS=99 D D^DIA:$S(DIAP:$P(DR(F+1,DI),";",DIAP#1000)'="Q",1:1) S:'$D(DIAB) DIAB=DHIT
 Q:DP'="@"  I DK="//" S DA=U_U Q
 W !,$C(7),"    WARNING: THIS MEANS AUTOMATIC DELETION!!"
