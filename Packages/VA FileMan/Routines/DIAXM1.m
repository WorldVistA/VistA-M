DIAXM1 ;SFISC/DCM-PROCESS MAPPING INFORMATION (CONT) ;7/11/95  06:33
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN D @DIAXFTY Q:DIAXFR  Q:$D(DIAXMSG)
 I DIAXFR("TYP")'=DIAXTO("TYP"),'$D(DIAXEXT) S DIAXEXT=1
 D:'$D(DIAR) DJ
 Q
 ;
F Q:DIAXFR!($D(DIAXMSG))  I DIAXFR("TY")["C" D CF^DIAXM2 Q
 I "FSP"[DIAXFR("TYP"),+DIAXFR("LO"),DIAXFR("LO")<DIAXTO("LO") S DIAXE2=DIAXFR("LO") D E1,E3
 I "FSP"[DIAXFR("TYP"),DIAXFR("HI")>DIAXTO("HI") S DIAXE2=DIAXFR("HI") D E2
 I DIAXFR("TY")["N",DIAXFR("LE")<DIAXTO("LO") S DIAXE2=DIAXFR("LE") D E1,E3
 I DIAXFR("TY")["N",DIAXFR("LE")>DIAXTO("HI") S DIAXE2=DIAXFR("LE") D E2
 I DIAXFR("TY")["D",DIAXTO("LO")>14 S DIAXE2=14 D E1,E3
 I DIAXFR("TY")["D",DIAXTO("HI")<14 S DIAXE2=14 D E2
 Q
 ;
N G N^DIAXM3
 ;
D G D^DIAXM3
 ;
P D XT I DIAXEXT D P^DIAXM2 Q:$D(DIAXMSG)!DIAXFR
 D HL^DIAXM(15,1)
 Q
 ;
V D XT I DIAXEXT D V^DIAXM2 Q:$D(DIAXMSG)!DIAXFR
 D HL^DIAXM(30,3)
 Q
 ;
C G C^DIAXM2
 ;
S I DIAXTO W:'$D(DIAR) !?DIAXTAB,$C(7),"Make sure the SET OF CODES are identical as the extract field." Q
 D XT D S^DIAXM2
 Q
 ;
W Q:DIAXFR
 I DIAXFR("TY")["L",DIAXTO("TY")'["L" D E3 S DIAXEM=DIAXEM_"be in 'L'ine mode." D X
 Q
 ;
K Q
 ;
E1 S DIAXE1="minimum" Q
E2 S DIAXE1="maximum"
E3 S DIAXEM=DIAXTO("NM")_" field in "_DIAXEF_$S($D(DIAXSB):" subfile",1:" file")_" should " Q:DIAXFTY["W"
 S DIAXEM=DIAXEM_"have a "_DIAXE1_" length of at least "_DIAXE2_" characters."
X D ERR^DIAXERR(DIAXEM)
 K DIAXE1,DIAXE2
 Q
 ;
DJ S DIAXDJ=DIAXDJ+1
 S ^UTILITY("DIFG",$J,DIAXC,DIAXDJ)=DIAXS_U_U_+Y_U_$P(Y(0),U,4)_U_$G(DIAXEXT)
 S S=DIAXS,DJ=DIAXDJ,C=DIAXC
 Q
 ;
XT S DIAXEXT=+$G(DIAXEXT) I '$D(DIAR),$D(DC(DC)) S DIAXEXT=+$P(DC(DC),U,5) Q:'DINS
 Q:$D(DIAR)
 K DIR N Y S DIR(0)="Y",DIR("A")="Move EXTERNAL form of the data to the extract field",DIR("B")="Yes",DIR("?")="Answer YES if the RESOLVED value of data should be moved"
 D ^DIR K DIR Q:'Y
 S DIAXEXT=1
 Q
