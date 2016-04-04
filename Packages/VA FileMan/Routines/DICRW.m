DICRW ;SFISC/XAK-SELECT A FILE ;17SEP2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1000,1024,1031,1040**
 ;
R D DT S D=8101,DIC(0)="QEI",DIA=$G(^DISV(DUZ,"^DIC(")) ;**CCO/NI 'OUTPUT FROM WHAT FILE'
 D R1,DIC K DIAC,DIFILE,DIC("S") Q:$D(DTOUT)  G R:'$T,AU:+Y=1.1,A:+Y=.6
R2 I DUZ(0)'="@" S DICS="I 1 Q:'$D(^(8))  F DW=1:1:$L(^(8)) I DUZ(0)[$E(^(8),DW) Q"
 K DIA Q
 ;
AU S D=8105,DIC(0)="QEI" S:'$D(DIC("S")) DIC("S")="I $D(DDA)!$D(^DIA(+Y,0))"
 S:DIA ^DISV(DUZ,"^DIC(")=DIA D DIC Q:'$D(DIC)  G AU:Y<0
 S DIA=+Y,Y="1.1^"_$P(Y,U,2)_" AUDIT",DIC="^DIA(DIA,"
 Q
A S:'$D(DIC("S")) DIC("S")="S DIFILE=Y,DIAC=""DD"" D ^DIAC I %",DDA=""
 D AU Q:'$D(DIC)
 S %=$P(^DIC(DIA,0),U),Y=DIA D SUB I DIA'>0!$D(DTOUT)!$D(DUOUT) K DIC Q
 I '$D(^DDA(DIA,0)) W !,"  No DD AUDIT entries!" K DIC Q
 S Y=".6^"_$P(Y,U,2)_"DD AUDIT",DIC="^DDA(DIA,"
 Q
SUB I $D(DIT) S L=L+1,DFL(L)=$O(^DD(+Y,0,"NM","")),(DFF,DFF(L))=+Y,Y=-1
 S DIC="^DD("_Y_"," Q:$O(^DD(Y,"SB",0))'>0  Q:$D(DIT)
 S DIC(0)="AEQIZ",DIC("A")="Select "_%_" SUB-FILE: "
 S DIC("S")="I $P(^(0),U,2)" D ^DIC Q:Y<0!$D(DTOUT)  S Y=+$P(Y(0),U,2)
 S DIA=Y,%=$P($P(^DD(DIA,0),U)," SUB-FIELD")
 I $D(DIT) S X=$P($P(Y(0),U,4),";",1),DSUB(L)=$S(X:X,1:""""_X_"""")_","
 G SUB
 ;
R1 S DIC("S")="S DIFILE=+Y,DIAC=""RD"" D ^DIAC I %"
 Q
 ;
 ;
 ;
DT ;
 I $D(IO)#2,$D(IO(0))#2,IO=IO(0),IO=""
 E  W:'$G(DIQUIET) !
DTNOLF ; DT entry point without doing a line feed.
 S:$D(DUZ)#2-1 DUZ=0 S:$D(DUZ(0))#2-1 DUZ(0)="" S X=DUZ(0)="@" D 1
 I '$D(DTIME) S DTIME=300
 I '$D(DILOCKTM) S DILOCKTM=+$G(^DD("DILOCKTM"),1)
 K %DT,DT S:$D(IO(0))[0 IO(0)=$I D NOW^%DTC S DT=X,U="^"
 K DIK,DIC,%I,DICS,%,%H Q  ;**KILL VARIABLES
 ;
 ;
 ;
0 S X=0
1 D:'$D(DISYS) OS^DII
 Q
W ;
 D DT S D=$S('$D(DDS1):8100,1:DDS1),DIC(0)=$E("L",$D(DLAYGO)>0)_"EQI" ;**CCO/NI  'INPUT TO'
 D W1,DIC Q:$T!($D(DTOUT))  G W:'$P(Y,U,3) K DIC Q
W1 S DIC("S")="I Y>.19,Y-1,Y-1.1,Y-.6,Y-.403,Y-.404,Y-.31 S DIFILE=+Y,DIAC=""WR"" D ^DIAC I %"
 Q
DIC W ! S:D D=$$EZBLD^DIALOG(D) S U="^",DIC="^DIC(" ;**CCO/NI GET THE DIALOG TEXT
 I DUZ(0)'="@",DIC(0)'["L",$S($D(^VA(200,"AFOF")):1,1:$D(^DIC(3,"AFOF"))) S DIC=$S($D(^VA(200,"AFOF")):"^VA(200,",1:DIC_"3,")_"DUZ,""FOF"","
 I $D(^DISV(DUZ,DIC)) S Y=^(DIC) I $D(@(DIC_Y_",0)")) X:$D(DIC("S")) DIC("S") I  S Y=Y_U_$P(^DIC(Y,0),U),D=D_$P(Y,U,2)_"// "
 W D S %=$T R X:DTIME E  W $C(7) S X=U,DTOUT=1,Y=-1 K DIC Q
 I '$D(@(DIC_"0)")) W "  There are no selectable files." K DIC S Y=-1 Q
 S:DIC["FOF" DIC(0)=DIC(0)_"O" I X="",% G WW
 S DIC("W")=$P($T(WW1),";",3) D ^DIC I $D(DTOUT) K DIC Q
GOT I $D(^DIC(+Y,0,"GL")) K DIC S DIC=^("GL") Q
 I U[X K DIC
 Q
WW X $P($T(WW1),";",3) G GOT ;**CCO/NI SIMPLER XECUTE
 ;
D D DT S D=8102,DIC(0)="LQEI",DIC("S")="I Y'<2 S DIFILE=+Y,DIAC=""DD"" D ^DIAC I %" ;**CCO/NI 'MODIFY WHAT FILE'
 D DIC S:DUZ(0)'="@" DICS="I 1 Q:'$D(^(9))  Q:^(9)=U  F DW=1:1:$L(^(9)) I DUZ(0)[$E(^(9),DW) Q"
 Q:$T!($D(DTOUT))  G D:'$P(Y,U,3) K DIC
 Q
DIAR ;
 D DT S D=$S($D(DIAX):8103,1:8104),DIC(0)="QEI" D R1 S DIC("S")="I Y'<2 "_DIC("S") ;**CCO/NI 'EXTRACT' or 'ARCHIVE'
 D DIC G R2:$D(DTOUT)!(X="^")!(X="")!(Y>0&($P($G(^DD(+Y,0,"DI")),U)'["Y"))
 W:$P($G(^DD(+Y,0,"DI")),U)["Y" !,$C(7),"SORRY, THIS IS ALREADY AN ARCHIVE FILE!"
 G DIAR
 Q
T ; COMP/MERGE
 D DT S D=8106,DIC=1,DIC(0)="QEI" D W1,DIC Q:$T!($D(DTOUT))  G T ;**CCO/NI  'COMPARE'
 ;
WW1 ;;W:$X>53 !?9 I Y-1.1,Y-.6,$D(^DIC(+Y,0,"GL")),^("GL")'["[",$D(@(^("GL")_"0)")) S %=+$P(^(0),U,4) W ?40,$$EZBLD^DIALOG(%=1+8300,%) ;**CCO/NI  NUMBER OF ENTRIES
