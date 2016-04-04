DICE ;SFISC/GFT-CREATE AN XREF ;17DEC2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**26,58,165,167**
 ;
 S %=2,DCOND="CROSS-REFERENCE" W !,"WANT TO CREATE A NEW ",DCOND," FOR THIS FIELD" D YN^DICN G Q:%-1
N F DQ=1:1 Q:'$D(^DD(DI,DA,1,DQ))
 W !,"CROSS-REFERENCE NUMBER: "_DQ_"// " R X:DTIME S:'$T DTOUT=1 G Q:'$T S:X="" X=DQ G NQ:X'?.N!'X,X:$D(^(X)) S DQ=X
 S DH=0,DIC="^DOPT(""DICR"",",DIC(0)="EQA",DIC("B")=1,DIC("S")="I 1"_$P(",Y-4",U,DUZ(0)'="@")_$P(",Y-5",U,$D(^DD(J(N),0,"LOOK"))>0)_$P(",Y-7",U,'$D(^XMB(3.6))) S:$P($G(^DD($$FNO^DILIBF(J(N)),0,"DI")),U)="Y" DIC("S")=DIC("S")_",Y-4,Y-6,Y-7"
 D ^DIC K DIC D QQ S Y=+Y G X:Y<0,6^DICE0:Y=6,^DICE7:Y=7 ;1=REGULAR 2=KWIC 3=MNEMONIC 4=MUMPS 5=SOUNDEX 6=TRIGGER 7=BULLETIN
 G A:'N W !,"WANT TO ",DCOND," WHOLE FILE BY THIS FIELD" D YN^DICN G X:%<1 I %=1 S DH=N G A
 F DH=N-1:-1 Q:'DH  S %=1 W !,"WANT TO "_DCOND_" "_$P(^DD(J(N-DH),0),U,1)_" BY THIS FIELD" D YN^DICN G X:%<1,A:%=1
A S %=1,DIK="" I Y=1!(Y=4) W !,"WANT ",DCOND," TO BE USED FOR LOOKUP AS WELL AS FOR SORTING" D YN^DICN G X:%<1 I %=2 S DIK="A"
 I Y=2 S DIKWIC="(,.?! '-/&:;)" W !,"PARSE ON THE FOLLOWING CHARACTERS: ",DIKWIC,"//" R X:DTIME S:'$T DTOUT=1 G Q:X=U!'$T S:X]"" DIKWIC=X I X["""" S X="?"
 I Y=2,X]"",X'?1P.P!(X?1"?"."?") W !?5,"Please enter the punctuation marks (except quotes) which will be used to ",!?5,"separate the words in this field." G A
 I Y=3 F I=0:0 S I=$O(^DD(J(N-DH),.01,1,I)) G X:I=""!(DL=.01&'DH) I $D(^(I,0)) S DE=$P(^(0),U,2) G CKF:DE?1U.UN
 I Y=4 D M G:$D(DIRUT) Q S:$D(XX(1)) X(1)=XX(1) S:$D(XX(2)) X(2)=XX(2) K XX
 ;GFT MODIFIED NEXT 6 LINES: INDEX MUST BE UPPER-CASE, START WITH PROPER LETTER, AND NOT BE A DUPLICATE
 N DISTART S DISTART=$S(Y-1&(Y-3)!(DA-.01):67,1:66) ;START WITH "B" OR "C"
IX F X=DISTART:1 S DE=DIK_$C(X) D  I $D(DE) G CKF:DUZ(0)'="@" W !,"INDEX: ",DE,"// " R X:DTIME S:'$T DTOUT=1 S:X]"" DE=X G Q:X[U!'$T D  G IX:'$D(DE) Q
 .I $D(^DD(J(N-DH),0,"IX",DE))!$D(^DD("IX","BB",J(N-DH),DE)) K DE Q  ;SUBROUTINE CALLED TWICE!  KILLS 'DE' IF NO GOOD   CAN'T ALREADY EXIST
 .I DE'?1U.UN K DE Q
 .I DIK="A" K:DE'?1"A".E DE Q
 .E  I DE?1"A".E K DE
CKF W !,"..." S DREF=Y
 D ^DICE0 W ! D DSC,DIEZ^DIU0,F G Q
 ;
F S X=^DD(J(N),DA,1,DQ,1),%=1 I DREF=1!(DREF=4)!$D(^("CONDITION")),@("$O("_DIU_"0))>0") D  G:'% F
 . W !!,"DO YOU WANT TO CROSS-REFERENCE EXISTING DATA NOW"
 . S %=0 D YN^DICN Q:%
 . W !!,"Enter 'YES' to execute the new set logic now."
 . W !,"Otherwise, enter 'NO'."
 D DD^DICD:%=1 I $D(DDA),DDA="" S DDA="N" D XA^DICATTA
 K % Q
 ;
M N Y,DQ
 F I=1,2 S DIR(0)=".1,"_I D  Q:$D(DTOUT)!$D(DUOUT)
 . F  D ^DIR Q:$D(DTOUT)!$D(DUOUT)  I X]"" S XX(I)=X Q
 K DIR Q
 ;
Q D QQ K DE,DB,DREF,DCOND,DICOMPX,I,DQ,DA,DH,DIK,DIC,N,DL,J,X,Y,A,XX Q
 ;
EDT ;
 I DH(DQ,4) D R^DICD Q:'$D(DICD)  S DQ=DICD
 I $D(DDA) S DDA="E" D XS^DICATTA
 W ! F A0=1:1:2 S A1(A0)=^DD(J(N),DA,1,DQ,A0)
 S A0=DI,DR=$S(DUZ(0)="@"&($P(DH(DQ),U,3)["MUMPS"):"1:3;10;666",DUZ(0)="@"&($P(DH(DQ),U,3)]""):"3;10;666",1:"3;10") D ED ;NOREINDEX  PATCH 167
 F A0=1:1:2 I A1(A0)'=^DD(J(N),DA,1,DQ,A0) S ^("DT")=DT,DREF=4 D DIEZ^DIU0,KOLD^DICD,F,D^DICD Q
 K A0,A1 I $D(DDA) D XA^DICATTA
 Q
 ;
ED S:$D(DA(1))#2 A1(3)=DA(1) S DICD=DL,DA(2)=A0,DA(1)=DA,DA=DQ,DIE="^DD("_DA(2)_","_DA(1)_",1," D DIE K DIE,DR
 S DL=DICD,DQ=DA,DA=DA(1) S:$D(A1(3)) DA(1)=A1(3) K DICD Q
 ;
DIE N J,N,DI,A1 D ^DIE Q
DSC S A0=J(N),DR="3;4///"_DT_";10" D ED K A0 Q
 ;
NQ I X'[U D HLP G N
X W $C(7),"??" G Q
 ;
QQ K ^UTILITY("DICE",$J),DBOOL,DLAY,DQI,DICOMPX,DIN,DCNEW,DFLD,DREF,DENEW,DLOC,DSUB,DHI,DOLD,DNEW,%X,V
 Q
HLP ; Traditional Cross Reference Help - Called From NQ
 ; SF-CIOFO/SO 1/12/00
 W !
 W !,?5,"You may use the number shown if you are the custodian of the file this"
 W !,?5,"cross-reference is in.  If you are not the custodian of the file, you"
 W !,?5,"should select a number that corresponds with a numberspace for which you"
 W !,?5,"have custody.  Questions regarding numberspace custody may be referred"
 W !,?5,"to:  DBA@FORUM.VA.GOV",!
 Q
