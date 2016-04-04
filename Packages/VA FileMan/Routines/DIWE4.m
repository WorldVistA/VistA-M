DIWE4 ;SFISC/GFT-WP - PRINT, BREAK, JOIN, PROGRAMMER-EDIT ;02:07 PM  8 Dec 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
PRINT W " "_$$EZBLD^DIALOG(8117)_DWLC_"// " R DW2:DTIME S:'$T DW2=U,DTOUT=1 S:DW2="" DW2=DWLC Q:DW2>DWLC!(DW2<X)  S DW2=+DW2 ;**CCO/NI  'TO LINE:'
LINNUMS S:$D(DV)[0 DV=0 S %=2 W !,$$EZBLD^DIALOG(8162) D YN^DICN Q:%<1  S I=%,J=0 ;**CCO/NI 'WANT LINE NUMBERS?'
RD I I=1 S %=2 W !,$$EZBLD^DIALOG(8163) D YN^DICN Q:%<0  S:%=1 J=124 I %=0 W !,$$EZBLD^DIALOG(8164),! G RD ;**CCO/NI 'ROUGH DRAFT? AND HELP
D0 ;Entry point for screen editor.
 S DIWF="W"_$S(J:"N",DWPK="FM"&$D(DQ(1)):$E("N",$P(DQ(1),U,2)["L"),1:"")_$E("L",I)_$C(J)
 K DW1,IOP,I,J D:'$D(DISYS) OS^DII I $D(^%ZTSCH("RUN")),$D(^%ZOSF("UCI")),$D(^DD("OS",DISYS,8)) S %ZIS="QM"
 D ^%ZIS G K:POP
 S DIWR=IOM-(DIWF["L"*4),DIWL=1,DWI="F D=DWL:0 S X="_DIC_"D,0) D ^DIWP S D=$O("_DIC_"D)) Q:(D'>0)!(D>"_DW2_")  I '(D#60),$D(ZTQUEUED),$$S^%ZTLOAD S X=$$EZBLD^DIALOG(1528) D ^DIWP S ZTSTOP=1 Q",DWJ=0 ;**CCO/NI 'TASK STOPPED'
HD I DWPK'="FM" S DWH=$$EZBLD^DIALOG(8165) G QUE ;**CCO/NI HEADING FOR OUTPUT
 S:$G(DIEL)="" DIEL=DL-1 S DW1=DIE,DW2=DA,%=DIEL,I(%)=DIE,J(%)=DP,I(%,0)=DA,DWH=$S($D(DQ)<11:"",1:$P(DQ(DQ),U))
DWH S DWH=$O(^DD(J(%),0,"NM",0))_$P(" FILE",1,'%)_":"_DWH I @("$D("_I(%)_I(%,0)_",0))") S DWH=""""_$P(^(0),U,1)_""" IN "_DWH
 S %=%-1 I %+1,$D(DP(%+1)),$D(DIE(%+1)),$D(DA(DIEL-%)) S J(%)=DP(%+1),I(%)=DIE(%+1),I(%,0)=DA(DIEL-%) G DWH
QUE I '$D(IO("Q")) D PRNT G X
 S DIR(0)="D^::AEFR",DIR("A")=$$EZBLD^DIALOG(8160),DIR("B")="NOW" D ^DIR G:$D(DIRUT) X S ZTDTH=Y ;**CCO/NI 'ENTER A DATE/TIME'
 S ZTRTN="PRNT^DIWE4",ZTDESC=DWH
 F %="DIC","DIWF","DIWL","DIWR","DV","DWH","DWI","DWJ","DWL","DW2","D0","I","J","I(","J(" S ZTSAVE(%)=""
 D ^%ZTLOAD S IOP="HOME" D ^%ZIS W $$EZBLD^DIALOG(8161,$G(ZTSK)),! K ZTSK G X ;**CCO/NI  'REQUEST QUEUED'
 ;
PRNT S ^UTILITY($J,1)="S DWJ=DWJ+1 W:$D(DIFF)&($Y) @IOF S DIFF=1 W ?3,DWH,?IOM-22,"" "" S Y=DT X ^DD(""DD"") W Y,""   "",$$EZBLD^DIALOG(7095,DWJ),!!" ;**CCO/NI 'PAGE'
 I $E(IOST)="C" S DIFF=1
 U IO X ^(1),DWI D ^DIWW W:$E(IOST)'="C"&($Y) @IOF D CLOSE^DIO4
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
X S:$D(DW1) DIE=DW1,DA=DW2
K K %,I,J,X1,DIWF,DIWL,DIWR,DIWT,DIWLL,DISYS,DW1,DW2,DWJ,DWH,DIFF,DIR,POP,^UTILITY($J,1) Q
 Q
 ;
Y ;
 Q:DUZ(0)'["@"
 R !!,"The text is in X and returned in Y",!,"Enter MUMPS xecute string to do transformation: ",X:DTIME S:'$T DTOUT=1 G 1:X'?1U.E D ^DIM G 1:'$D(X) S DW=X
 R !,"Edit from line: 1// ",DW1:DTIME S:'$T DTOUT=1 G 1:DW1=U!'$T S:DW1="" DW1=1 G 1:+DW1'=DW1 W "  thru: ",DWLC,"// " R DW2:DTIME S:'$T DTOUT=1 G 1:DW2=U!'$T S:DW2="" DW2=DWLC
 IF (DW1>DW2)!(DW2>DWLC)!(DW1<1) G 1
 F I=DW1:1:DW2 S X=@(DIC_"I,0)") K Y X DW I $D(Y)=1 S @(DIC_"I,0)")=Y W !,$J(I,3)_">"_Y S DWL=I
 G 1
 ;
B ;BREAK
 G 1:X=U,OPT:'X
BA W !,$$EZBLD^DIALOG(8120) R X:DTIME S:'$T DTOUT=1 G 1:U[X S DW=^(0) I DW'[X W $C(7),"??" G BA ;**CCO/NI 'AFTER CHARACTERS:'
 S DWLC=DWLC+1 X "F I=DWLC:-1:DWL+1 S "_DIC_"I,0)="_DIC_"I-1,0) W ""."""
 S @(DIC_"0)")=DWLC,Y=$F(DW,X)-1,@(DIC_"DWL,0)")=$E(DW,1,Y),@(DIC_"DWL+1,0)")=$E(DW,Y+1,999)
 W !,$J(DWL,3)_">",@(DIC_"DWL,0)"),!,$J(DWL+1,3)_">",@(DIC_"DWL+1,0)")
1 G ^DIWE1
 ;
OPT W ! G OPT^DIWE1
 ;
J ;JOIN
 G 1:X=U,OPT:'X I X=DWLC W $C(7),"??" G OPT
 S @("Y="_DIC_"X+1,0)"),@("J="_DIC_"X,0)"),I=$L(Y)+$L(J)-250 I I>0 W !,$$EZBLD^DIALOG(349,I) G 1 ;**CCO/NI  TOO LONG
 S ^(0)=J_" "_Y W !,$J(X,3)_">"_^(0),! F I=X+1:1:DWLC-1 S @(DIC_"I,0)="_DIC_"I+1,0)") W "."
 K @(DIC_"DWLC)") S DWLC=DWLC-1 G 1
