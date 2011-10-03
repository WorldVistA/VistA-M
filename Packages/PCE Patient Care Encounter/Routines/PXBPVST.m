PXBPVST ;ISL/JVS - PROMPT FOR VISITS (ENCOUNTERS) ;11/7/96  08:56
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**11**;Aug 12, 1996
 ;
 Q
VST ;--PROMPTS FOR VISITS
 N X,Y,ADD,DATA,DOUG
 D LOC^PXBCC(15,0),WIN17^PXBCC(PXBCNT)
 W !,IOCUD,IOELALL,IOCUD,IOELALL,IOCUU,IOCUU
 ;
 I $G(PROMPT)="A" G PRADD
 I $G(PROMPT)="D" G PRDEL
 I $G(PROMPT)["AD"!($G(PROMPT)["DA") G BOTH
 ;
PRMPT ;
 S DIR("A",1)="'RETURN' to continue or '-' for previous screen"
 I $G(PXBCNT)'>0 S DIR("A",1)=""
 ;
 ;
 S DIR("?")="Enter item number or '-' to backup a screen or RETURN  for next screen or '^' to exit."
 I $G(PXBCNT)'>0 S DIR("?")="Enter 'RETURN' or '^'  to exit this screen."
 ;
 ;
 S DIR("A")="Select Encounter by entering the ITEM No. : "
 I $G(PXBCNT)'>0 S DIR("A")="'RETURN' or '^' to exit: "
 S DIR(0)="FAO^1:3"
 D ^DIR K DIR
 G VERIFY
 ;
PRADD ;
 S DIR("A",1)="'RETURN' to continue or '-' for previous screen"
 I $G(PXBCNT)'>0 S DIR("A",1)=""
 ;
 ;
 S DIR("?")="Enter item number or A to add a new encounter or '-' to backup a screen or RETURN  for next screen or '^' to exit."
 I $G(PXBCNT)'>0 S DIR("?")="Enter A to add a new encounter, 'RETURN' or '^'  to exit this screen."
 ;
 ;
 S DIR("A")="Select ITEM No. or 'A' to ADD an Encounter: "
 I $G(PXBCNT)'>0 S DIR("A")="Select 'A' to ADD or 'RETURN' to exit: "
 S DIR(0)="FAO^1:3"
 D ^DIR K DIR
 G VERIFY
 ;
PRDEL ;
 S DIR("A",1)="'RETURN' to continue or '-' for previous screen"
 I $G(PXBCNT)'>0 S DIR("A",1)=""
 ;
 ;
 S DIR("?")="Enter item number or '@' folowed by the 'ITEM No.'(eg @9) to delete an encounter or '-' to backup a screen or 'RETURN'  for next screen or '^' to exit."
 I $G(PXBCNT)'>0 S DIR("?")="Enter 'RETURN' or '^' to exit this screen."
 ;
 ;
 S DIR("A")="Select ITEM No. or '@ITEM No.' to DELETE an Encounter: "
 I $G(PXBCNT)'>0 S DIR("A")="Enter 'RETURN' or '^' to exit this screen: "
 S DIR(0)="FAO^1:3"
 D ^DIR K DIR
 G VERIFY
 ;
BOTH ;
 S DIR("A",1)="'RETURN' to continue or '-' for previous screen"
 I $G(PXBCNT)'>0 S DIR("A",1)=""
 ;
 ;
 S DIR("?")="Enter item number or A to add, or '@' followed by the 'ITEM No.'(eg @7) to DELETE a new encounter or '-' to backup a screen or 'RETURN'  for next screen or '^' to exit."
 I $G(PXBCNT)'>0 S DIR("?")="Enter item number or, A to add an encounter, 'RETURN' or '^'  to exit this screen."
 ;
 ;
 S DIR("A")="Select ITEM No. or 'A' to ADD or '@ITEM No.' to DELETE: "
 I $G(PXBCNT)'>0 S DIR("A")="Select 'A' to ADD or 'RETURN' to exit: "
 S DIR(0)="FAO^1:3"
 D ^DIR K DIR
 G VERIFY
 ;
 ;
VERIFY ;--VERIFY INPUT
 ;
 ;
 I $G(Y)?.N1"E".NAP S Y=" "_Y
 I Y?24.N S Y=$E(Y,1,24)
 S EDATA=$G(Y) D CASE^PXBUTL S (X,Y)=EDATA K EDATA
 I $G(PROMPT)="A" G VERADD
 I $G(PROMPT)="D" G VERDEL
 I $G(PROMPT)["AD"!($G(PROMPT)["DA") G VERBOTH
 ;
VER ;
 ;
 I $G(PXBCNT)>0 S DOUG="-^" I DOUG'[Y&(Y'?1.3N) W IOELEOL,! D HELP1^PXBUTL1("VST2") G VST
 I $G(PXBCNT)'>0 S DOUG="^" I DOUG'[Y W ! D HELP1^PXBUTL1("VST2") G VST
 ;
 ;
 I Y?1.3N,Y>$G(PXBHIGH) W ! D HELP1^PXBUTL1("VST1") G VST
 I Y=0!(Y="00")!(Y="000") W ! D HELP1^PXBUTL1("VST3") G VST
 I Y#1!(Y<0) W ! D HELP1^PXBUTL1("VST4") G VST
 I Y?1.3N,Y'>$G(^TMP("PXBDVST",$J,"START")) G CONFIRM
 I Y?1.3N,Y'<($G(^TMP("PXBDVST",$J,"START"))+10) G CONFIRM
 I Y="",($G(^TMP("PXBDVST",$J,"START"))+10)'<$G(PXBCNT) S VAL=-1 Q
 I Y="" D DVST4^PXBDVST("+") G VST
 I Y="-" D DVST4^PXBDVST("-") G VST
 I $D(DIRUT) S VAL=-1
 I Y?1.3N,Y'>PXBCNT S VAL=$O(^TMP("PXBSKY",$J,Y,0))
 G EXIT
VERADD ;
 ;
 I $G(PXBCNT)>0 S DOUG="-^A" I DOUG'[Y&(Y'?1.3N) W ! D HELP1^PXBUTL1("VST2") G VST
 I $G(PXBCNT)'>0 S DOUG="^A" I DOUG'[Y W ! D HELP1^PXBUTL1("VST2") G VST
 ;
 ;
 I Y?1.3N,Y>$G(PXBHIGH) W ! D HELP1^PXBUTL1("VST1") G VST
 I Y=0!(Y="00")!(Y="000") W ! D HELP1^PXBUTL1("VST3") G VST
 I Y#1!(Y<0) W ! D HELP1^PXBUTL1("VST4") G VST
 I Y?1.3N,Y'>$G(^TMP("PXBDVST",$J,"START")) G CONFIRM
 I Y?1.3N,Y'<($G(^TMP("PXBDVST",$J,"START"))+10) G CONFIRM
 I Y="",($G(^TMP("PXBDVST",$J,"START"))+10)'<$G(PXBCNT) S VAL=-1 Q
 I Y="" D DVST4^PXBDVST("+") G VST
 I Y="-" D DVST4^PXBDVST("-") G VST
 I $D(DIRUT) S VAL=-1
 I Y?.A S DATA=Y D CASE^PXBUTL S Y=DATA
 S DOUG="ADD" I DOUG[Y S VAL="A"
 I Y?1.3N,Y'>PXBCNT S VAL=$O(^TMP("PXBSKY",$J,Y,0))
 G EXIT
VERDEL ;
 ;
 I $G(PXBCNT)>0 S DOUG="-^" I DOUG'[Y&(Y'?1.3N)&($E(Y,1)'["@") W ! D HELP1^PXBUTL1("VST2") G VST
 I $G(PXBCNT)'>0 S DOUG="^" I DOUG'[Y W ! D HELP1^PXBUTL1("VST2") G VST
 ;
 ;
 I $E(Y,1)["@" S Y=$E(Y,2,4),DEL=1
 I Y?1.3N,Y>$G(PXBHIGH) W ! D HELP1^PXBUTL1("VST1") G VST
 I Y=0!(Y="00")!(Y="000") W ! D HELP1^PXBUTL1("VST3") G VST
 I Y#1!(Y<0) W ! D HELP1^PXBUTL1("VST4") G VST
 I Y?1.3N,Y'>$G(^TMP("PXBDVST",$J,"START")) G CONFIRM
 I Y?1.3N,Y'<($G(^TMP("PXBDVST",$J,"START"))+10) G CONFIRM
 I Y="",($G(^TMP("PXBDVST",$J,"START"))+10)'<$G(PXBCNT) S VAL=-1 Q
 I Y="" D DVST4^PXBDVST("+") G VST
 I Y="-" D DVST4^PXBDVST("-") G VST
 I $D(DIRUT) S VAL=-1
 I Y?.A S DATA=Y D CASE^PXBUTL S Y=DATA
 I $G(DEL) S VAL="D^"_$O(^TMP("PXBSKY",$J,Y,0))
 I Y?1.3N,Y'>PXBCNT,'$G(DEL) S VAL=$O(^TMP("PXBSKY",$J,Y,0))
 G EXIT
VERBOTH ;
 ;
 I $G(PXBCNT)>0 S DOUG="-^A" I DOUG'[Y&(Y'?1.3N)&($E(Y,1)'["@") W ! D HELP1^PXBUTL1("VST2") G VST
 I $G(PXBCNT)'>0 S DOUG="^A" I DOUG'[Y W ! D HELP1^PXBUTL1("VST2") G VST
 ;
 ;
 I $E(Y,1)["@" S Y=$E(Y,2,4),DEL=1
 I Y?1.3N,Y>$G(PXBHIGH) W ! D HELP1^PXBUTL1("VST1") G VST
 I Y=0!(Y="00")!(Y="000") W ! D HELP1^PXBUTL1("VST3") G VST
 I Y#1!(Y<0) W ! D HELP1^PXBUTL1("VST4") G VST
 I Y?1.3N,Y'>$G(^TMP("PXBDVST",$J,"START")) G CONFIRM
 I Y?1.3N,Y'<($G(^TMP("PXBDVST",$J,"START"))+10) G CONFIRM
 I Y="",($G(^TMP("PXBDVST",$J,"START"))+10)'<$G(PXBCNT) S VAL=-1 Q
 I Y="" D DVST4^PXBDVST("+") G VST
 I Y="-" D DVST4^PXBDVST("-") G VST
 I $D(DIRUT) S VAL=-1
 I Y?.A S DATA=Y D CASE^PXBUTL S Y=DATA
 S DOUG="A" I DOUG[Y S VAL="A"
 I $G(DEL) S VAL="D^"_$O(^TMP("PXBSKY",$J,Y,0))
 I Y?1.3N,Y'>PXBCNT,'$G(DEL) S VAL=$O(^TMP("PXBSKY",$J,Y,0))
 G EXIT
CONFIRM ;---CONFIRM A REQUEST NOT ON THE SCREEN
 D DVST4^PXBDVST(Y)
 N PXBLINE,PXBCOLM,PXBENT,ENTRY,YY
 S YY=Y
 S PXBLINE=(Y#10)+3 I Y#10=0,Y\10>0 S PXBLINE=(PXBLINE)+(10)
 S PXBCOLM=4
 S PXBENT=$G(^TMP("PXBSAM",$J,Y))
 S ENTRY=$P(PXBENT,"^",1)
 D RREVST^PXBCC(PXBLINE,PXBCOLM,ENTRY)
 ;
 S DIR(0)="YA"
 S DIR("B")="YES"
 S DIR("A")="Is this the entry you selected? "
 D ^DIR K DIR
 I Y=1,'$G(DEL) S VAL=$O(^TMP("PXBSKY",$J,YY,0)) G EXIT
 I Y=1,$G(DEL) S VAL="D^"_$O(^TMP("PXBSKY",$J,YY,0)) G EXIT
 I Y=0 G VST
 G EXIT
 ;
EXIT ;
 ;
 ;
 Q
