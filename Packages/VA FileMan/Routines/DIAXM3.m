DIAXM3 ;SFISC/DCM-PROCESS MAPPING INFORMATION (CONT) ;3/3/93  12:23 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
N S DIAXNO=$P(Y(0),U,2),DIAXLE=+$P(DIAXNO,"J",2) S:DIAXFR DIAXFR("DLR")=$P(Y(0),U,5)["$"
 S @(DIAXA_"(""LE"")")=DIAXLE,@(DIAXA_"(""DC"")")=+$P(DIAXNO,",",2)
 Q:DIAXFR  I DIAXFR("TY")["C" D CN^DIAXM2 Q
 I DIAXFR("TY")["P" G N1
 I DIAXFR("DLR"),DIAXTO("DC")<2 D E3 S DIAXEM=DIAXEM_"contain at least 2 decimal places." D E
 I DIAXFR("DC")>DIAXTO("DC") D E3 S DIAXEM=DIAXEM_"contain at least "_DIAXFR("DC")_" decimal places." D E
 I DIAXFR("LE")>DIAXTO("LE") D E3 S DIAXEM=DIAXEM_"be at least "_DIAXFR("LE")_" digits long." D E
N1 I DIAXTO("LO")>DIAXFR("LO") S DIAXE2=DIAXFR("LO") D E1,E3,E4
 I DIAXTO("HI")<DIAXFR("HI") S DIAXE2=DIAXFR("HI") D E2,E4
 Q
 ;
D S DIAXDT=$P(Y(0),U,5,99),DIAXLO=$P($P(DIAXDT,"<X!(",2),">X"),DIAXHI=$P($P(DIAXDT,"K:",2),"<X!(")
 S @(DIAXA_"(""DT"")")=$P(DIAXDT,"""",2) D HL^DIAXM(+DIAXHI,+DIAXLO)
 Q:DIAXFR  I DIAXFR("TY")["C" D CD^DIAXM2 Q
 I DIAXTO("DT")["R",DIAXFR("DT")'["R" D E3 S DIAXEM=DIAXEM_"not 'R'equire time." D E
 I DIAXTO("DT")["S",DIAXFR("DT")'["S" D E3 S DIAXEM=DIAXEM_"not expect 'S'econds to be returned." D E
 I DIAXTO("DT")["X",DIAXFR("DT")'["X" D E3 S DIAXEM=DIAXEM_"not require e'X'act date." D E
 I DIAXTO("LO"),'DIAXFR("LO") D E3 S DIAXEM=DIAXEM_"not have an earliest date." D E
 I DIAXTO("HI"),'DIAXFR("HI") D E3 S DIAXEM=DIAXEM_"not have a latest date." D E
 I DIAXTO("LO"),DIAXTO("LO")>DIAXFR("LO") S DIAXDTY=DIAXFR("LO") D DT,E3 S DIAXEM=DIAXEM_"have an earliest date of at least "_DIAXDTY D E
 I DIAXTO("HI"),DIAXTO("HI")<DIAXFR("HI") S DIAXDTY=DIAXFR("HI") D DT,E3 S DIAXEM=DIAXEM_"have a latest date of at least "_DIAXDTY D E
 Q
 ;
DT N Y
 S Y=DIAXDTY X ^DD("DD") S DIAXDTY=Y
 Q
 ;
E1 S DIAXE1="minimum" Q
E2 S DIAXE1="maximum"
E3 S DIAXEM=DIAXTO("NM")_" field in "_DIAXEF_$S($D(DIAXSB):" subfile",1:" file")_" should " Q
E4 S DIAXEM=DIAXEM_"have a "_DIAXE1_" value of at least "_DIAXE2
E D ERR^DIAXERR(DIAXEM)
 K DIAXE1,DIAXE2
 Q
