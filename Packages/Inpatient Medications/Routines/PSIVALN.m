PSIVALN ;BIR/PR,CML3-LABEL ALIGNMENT ;16 DEC 97 / 1:39 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**58,178**;16 DEC 97;Build 9
 ;
 ; Reference to ^%ZIS(2 is supported by DBIA 3435.
 ;
 W !!?2,"(Please make any initial adjustments before selecting the label device.)",!
 K %ZIS,IO("Q"),IOP S %ZIS="Q",PSIVION=ION,%ZIS("A")="Print labels on DEVICE: ",%ZIS("B")=PSIVPL D ^%ZIS I POP S IOP=PSIVION D ^%ZIS W !?2,"No device selected." K PSIVION,IOP,%ZIS Q
 N X0,PSJIO,I
 S I=0 F  S I=$O(^%ZIS(2,IOST(0),55,I)) Q:'I  S X0=^(I,0),PSJIO($P(X0,"^"))=^(1)
 S PSJIO=$S('$D(PSJIO):0,1:1)
 D PSET^%ZISP
 S $P(L1,"_",$P(PSIVSITE,"^",13)+1)="" F Q=0:0 D PRNT,ASK Q:%'=2
 ;
 D ^%ZISC K %ZIS,IO("Q"),IOP,L1,L2,PSIVION,Q,QQ,X,%Y,POP,D,Y,Z,I,ZISI,Y Q
 ;
PRNT ;
 G:'$D(IO("Q")) ENQ K ZTSK,ZTSAVE S ZTRTN="ENQ^PSIVALN",ZTDESC="IV LABEL ALIGNMENT",ZTIO=ION,ZTDTH=$H F G="L1","L2","PSIVSITE","PSJSYSW0","PSJSYSU","PSJIO" S ZTSAVE(G)=""
 D ^%ZTLOAD Q
 ;
ENQ ;
 U IO
 I PSJIO,$G(PSJIO("FI"))]"" X PSJIO("FI")
 F QQ=1:1:3 D LP
 I PSJIO,$G(PSJIO("FE"))]"" X PSJIO("FE")
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
P F I="ST","STF" I $G(PSJIO(I))]"" X PSJIO(I)
 W X
 F I="ETF","ET" I $G(PSJIO(I))]"" X PSJIO(I)
 I 'PSJIO W !
 Q
 ;
PMR F I="SM","SMF" I $G(PSJIO(I))]"" X PSJIO(I)
 W X
 F I="EMF","EM" I $G(PSJIO(I))]"" X PSJIO(I)
 I 'PSJIO W !
 Q
LP ;
 I PSJIO,$G(PSJIO("SL"))]"" X PSJIO("SL")
 S LINE=1
 I 'PSJIO D
 . I IOBARON]"" W @IOBARON
 . W "nnnVnnn"
 . I IOBAROFF]"" W @IOBAROFF
 . W !
 I PSJIO D
 . F I="SB","SBF" I $G(PSJIO(I))]"" X PSJIO(I)
 . W "nnnVnnn"
 . F I="EBF","EB" I $G(PSJIO(I))]"" X PSJIO(I)
 F LINE=LINE:1:PSIVSITE S X=L1 D P D PMR
 I 'PSJIO D  Q
 . F ZZ=1:1 Q:ZZ>$P(PSIVSITE,"^",16)  W !
 I PSJIO,$G(PSJIO("EL"))]"" X PSJIO("EL")
 Q
 ;
ASK ;
 U IO(0) F Q=0:0 W !!,"Is the label alignment correct" S %=1 D YN^DICN Q:%  S HELP="ALGN" D ^PSIVHLP
 I %=2 R !!,"Please make any adjustments necessary, and then press RETURN. ",X:DTIME W:'$T $C(7) I X="^"!'$T S %=-1
 Q
