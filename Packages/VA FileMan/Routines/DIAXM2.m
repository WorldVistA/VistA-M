DIAXM2 ;SFISC/DCM-PROCESS MAPPING INFORMATION (CONT) ;3/11/93  2:59 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
P K DIC
 ;
P1 S DIC="^DD("_+$P($P(Y(0),U,2),"P",2)_",",DIC(0)="Z",X=.01
 D ^DIC I Y'>0 S DIAXEM=DIAXFR("NM")_" points to missing pointed to file." D E Q
 S DIAXFTY=$$TYP^DIAXMS($P(Y(0),U,2)) Q:$D(DIAXMSG)
 I $P(Y(0),U,2)["P" G P1
 Q:$D(DIAXVPTR)
 D EN1^DIAXM
 Q
V S DIAXVPTR=1,DIAXZZ=0,DIAXVFLD=+Y,DIAXVFI=DK
 ;
V1 F  S DIAXZZ=$O(^DD(DK,DIAXVFLD,"V","B",DIAXZZ)) Q:DIAXZZ'>0  D V2 Q:$D(DIAXMSG)
 Q:$D(DIAXMSG)
 S DIAXFR("TY")=$S(DIAXFR("TY")["F":DIAXFR("TY"),1:"F"),DIAXFR("TYP")="F"
 S DIAXFR("LO")=$S(+DIAXFR("LO")+1:DIAXFR("LO"),1:3)
 S DIAXFR("HI")=$S(+DIAXFR("HI")+1:DIAXFR("HI"),1:45)
 S DIAXFT=DIAXFR("TY"),Y(0)=U_DIAXFT K DIAXVPTR D EN^DIAXM1
 Q
V2 S DIC="^DD(+DIAXZZ,",DIC(0)="Z",X=.01 D ^DIC I Y'>0 S DIAXEM="Missing pointed to file." D E Q
 I $P(Y(0),U,2)["P" D P1 Q:$D(DIAXMSG)
 D IN^DIAXM Q:$D(DIAXMSG)
 S DIAXFR("TY")=$S($G(DIAXFR("TY"))["F":DIAXFR("TY"),1:DIAXVFR("TY"))
 S:DIAXVFR("TY")["F" DIAXFR("LO")=$S(+$G(DIAXFR("LO"))<DIAXVFR("LO"):+$G(DIAXFR("LO")),1:DIAXVFR("LO"))
 S:DIAXVFR("TY")["F" DIAXFR("HI")=$S(+$G(DIAXFR("HI"))>DIAXVFR("HI"):+$G(DIAXFR("HI")),1:DIAXVFR("HI"))
 Q
 ;
S S DIAXZ=$P(Y(0),U,3),DIAXZL=0,DIAXPC=$S(DIAXEXT:2,1:1)
 F DIAXZZ=1:1:$L(DIAXZ,";") S DIAXZY=$P(DIAXZ,";",DIAXZZ) Q:DIAXZY=""  S DIAXZL=$S($L($P(DIAXZY,":",DIAXPC))>+DIAXZL:$L($P(DIAXZY,":",DIAXPC)),1:+DIAXZL),DIAXZLL=$S(+$G(DIAXZLL)<DIAXZL:+$G(DIAXZLL),1:DIAXZL)
 D HL^DIAXM(DIAXZL,DIAXZLL)
 Q
 ;
C S DIAXFR("DC")=+$P($P(Y(0),U,2),",",2)
 S DIAXFR("LE")=+$P($P(Y(0),U,2),"J",2)
 Q
 ;
CN I DIAXFR("TY")["B",DIAXTO("LO")'=0 D E1 S DIAXEM=DIAXEM_"have a minimum value of 0." D E Q
 I DIAXFR("TY")["J",DIAXTO("DC")<DIAXFR("DC") D E1 S DIAXEM=DIAXEM_"have at least "_DIAXFR("DC")_" decimal places." D E
 I DIAXFR("TY")["J",DIAXFR("LE")>DIAXTO("LE") D E1 S DIAXEM=DIAXEM_"be at least "_DIAXFR("LE")_" characters long." D E
 Q
 ;
CF I DIAXFR("TY")["B",DIAXTO("LO")'=1 D E1 S DIAXEM=DIAXEM_"have a minimum length of 1." D E Q
 Q:DIAXFR("TY")["B"
 I DIAXFR("TY")["D",DIAXTO("LO")>7 D E1 S DIAXEM=DIAXEM_"a minimum length of at least 7." D E
 I DIAXFR("TY")["D",DIAXTO("HI")<7 D E1 S DIAXEM=DIAXEM_"a maximum length of at least 7." D E
 I DIAXFR("TY")["J",DIAXFR("LE")<DIAXTO("LO") D E1 S DIAXEM=DIAXEM_"have a minimum length of at least"_DIAXFR("LE")_" characters." D E
 I DIAXFR("TY")["J",DIAXFR("LE")>DIAXTO("HI") D E1 S DIAXEM=DIAXEM_"have a maximum length of at least "_DIAXFR("LE")_" characters." D E
 Q
 ;
CD I DIAXFR("TY")["D",+DIAXTO("LO")!+DIAXTO("HI") D E1 S DIAXEM=DIAXEM_"not have set date ranges." D E
 Q
 ;
E1 S DIAXEM=DIAXTO("NM")_" field in "_DIAXEF_$S($D(DIAXSB):" subfile",1:" file")_" should " Q
 ;
E D ERR^DIAXERR(DIAXEM)
 Q
