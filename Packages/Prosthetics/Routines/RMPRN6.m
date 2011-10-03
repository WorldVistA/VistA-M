RMPRN6 ;Hines OIFO/HNC-PRINT NPPD LOCAL DATA ;3/17/03  11:38
 ;;3.0;PROSTHETICS;**31,32,34,36,39,48,51,70,77,90,144**;Feb 09, 1996;Build 17
 ;RVD 3/17/03 patch #77 - fix undefined and closing device.
 ;SPS 5/24/05 Patch #90 - check for type of 5 Rental.
 D DIV4^RMPRSIT G:$D(X) EXIT
DATE S %DT="XEA",%DT("A")="Enter Date to Start NPPD Calculations From: " D ^%DT G:X[U!(X="")!($D(DTOUT)) EXIT
 S DATE(1)=+Y
 S %DT="XEA",%DT("A")="Enter End Date: " D ^%DT G:X[U!(X="")!($D(DTOUT)) EXIT S DATE(2)=+Y
 I DATE(1)>DATE(2) W !!,$C(7),"ENDING DATE RANGE IS LESS THAN BEGINNING DATE RANGE",! G DATE
 Q:$D(RMPRCDE)
DET ;select detail or brief
 D DISP^RMPRN6S
 K DIR
 ;S DIR(0)="S^D:DETAIL;B:BRIEF"
 S DIR(0)="S^1:BRIEF NEW SUMMARY;2:BRIEF USED SUMMARY;3:BRIEF BOTH SUMMARY;4:DETAIL & NEW SUMMARY;5:DETAIL & USED SUMMARY;6:DETAIL & BOTH SUMMARY"
 S DIR("A")="Type of Report",DIR("B")="DETAIL & NEW SUMMARY" D ^DIR
 Q:$D(DIRUT)!($D(DTOUT))
 S RMPRDET=Y
DEV ;device
 S %ZIS="Q" D ^%ZIS G:POP EXIT K IOP I $E(IOST,1,2)["C-" G PRT
 I $D(IO("Q")) S ZTIO=ION,ZTSAVE("RMPRSITE")="",ZTSAVE("RMPR(")=""
 I  S ZTSAVE("DATE(")="",ZTSAVE("RMPRZ")="",ZTSAVE("RMPRDET")=""
 I  S ZTRTN="PRT^RMPRN6",ZTDESC="Prosthetic NPPD" D ^%ZTLOAD K ZTDESC,ZTIO,ZTRTN,ZTSAVE G EXIT
PRT ;print
 I '$D(IO("Q")) U IO
 D GNP,GNPC
 Q
ENL ;entry point for one line
 D DIV4^RMPRSIT G:$D(X) EXIT
 S RMPRCDE=1
 D DATE
 G:'$D(DATE(1))!('$D(DATE(2))) EXIT
 ;single line always new and used (BOTH) sort
 S RMPRDET=6
 D GNPCC,EXIT
 Q
GNP ;gather nppd data
 S $P(LN,"-",IOM)=""
 S DATE=DATE(1)-1
 K ^TMP($J)
 F  S DATE=$O(^RMPR(660,"B",DATE)) Q:(DATE="")!($P(DATE,".",1)>DATE(2))  D
 .S RMPRB=0
 .F  S RMPRB=$O(^RMPR(660,"B",DATE,RMPRB)) Q:RMPRB'>0  D
 ..;define variables for record
 ..S REC=$G(^RMPR(660,RMPRB,0)) Q:REC=""
 ..Q:$P(REC,U,15)["*"
 ..Q:$P(REC,U,10)'=RMPR("STA")
 ..;check for used pip
 ..;if used pip sort, not pip, not va, quit
 ..I $G(RMPRDET)=2&($P($G(^RMPR(660,RMPRB,1)),U,5)'="")&($P(REC,U,14)'="V") Q
 ..I $G(RMPRDET)=5&($P($G(^RMPR(660,RMPRB,1)),U,5)'="")&($P(REC,U,14)'="V") Q
 ..S TYPE=$P(REC,U,4)
 ..S TY=$S(TYPE="X":2,TYPE=5:2,TYPE="I":1,1:3)
 ..S MR=$P($G(^RMPR(660,RMPRB,1)),U,4)
 ..I $P(^RMPR(660,RMPRB,0),U,17)'=""&($P(^(0),U,26)="") S TY=2,LINE="R99 A",MR=2676
 ..;PICKUP AND DELIVERY
 ..I $P(^RMPR(660,RMPRB,0),U,26)'="" S TY=2,LINE="R80 D",MR=2951
 ..Q:MR=""
 ..;        PATCH 70             Auto-fix
 ..K LINE
 ..I TY'=2 S LINE=$P(^RMPR(661.1,MR,0),U,7)
 ..I TY'=2&($G(LINE)="") D
 ...; I TYPE=5 Q
 ...S ERR=""
 ...S LINE=$P(^RMPR(661.1,MR,0),U,6) S:MR=2676 LINE="R99 A"
 ...S TYPE="X"
 ...S DIE="^RMPR(660,",DA=RMPRB,DR="2///^S X=TYPE"
 ...L +^RMPR(660,RMPRB):1 I '$T S ERR=1
 ...I ERR="" D ^DIE L -^RMPR(660,RMPRB)
 ...K DIE,DA,DR
 ...I ERR=1 S ^TMP($J,"RMPRA",RMPRB)="NO UPDATE!"
 ...I ERR="" S ^TMP($J,"RMPRA",RMPRB)="NEW TO REPAIR"
 ...S B=RMPRB D DATA^RMPRN6XM
 ..I TY=2 S LINE=$P(^RMPR(661.1,MR,0),U,6) S:MR=2676 LINE="R99 A"
 ..I TY=2&($G(LINE)="") D
 ...; I TYPE=5 Q
 ...S ERR=""
 ...S LINE=$P(^RMPR(661.1,MR,0),U,7)
 ...S TYPE="I"
 ...S DIE="^RMPR(660,",DA=RMPRB,DR="2///^S X=TYPE"
 ...L +^RMPR(660,RMPRB):1 I '$T S ERR=1
 ...I ERR="" D ^DIE L -^RMPR(660,RMPRB)
 ...K DIE,DA,DR
 ...I ERR=1 S ^TMP($J,"RMPRA",RMPRB)="NO UPDATE!"
 ...I ERR="" S ^TMP($J,"RMPRA",RMPRB)="REPAIR TO NEW"
 ...S B=RMPRB D DATA^RMPRN6XM
 ..;
 ..I LINE="" W !,"Line is null, something wrong with file 661.1  :",MR
 ..;set to 999 group if null
 ..S FLAG=$P(^RMPR(661.1,MR,0),U,8)
 ..I FLAG="" S FLAG=2
 ..S CATEGRY=$P($G(^RMPR(660,RMPRB,"AM")),U,3),SPEC=$P($G(^("AM")),U,4),GN=$P($G(^("AMS")),U,1)
 ..Q:GN=""
 ..D SET
 D FMT^RMPRN6XM,MAIL^RMPRN6XM
 Q
GNPC ;worksheet/detail
 S STN=RMPR("NAME")
 D CAL^RMPRN6
 S PAGE=0,FL=""
 D ^RMPRN6PT
 G:FL=1 EXIT
 D ^RMPRN6PR
 G:FL=1 EXIT
 I RMPRDET<4 G EXIT
 D DESP^RMPRN63
 D DESPR^RMPRN63
EXIT ;commom exit point
 D ^%ZISC
 N RMPR,RMPRSITE
 K ^TMP($J) D KILL^XUSCLEAN
 Q
GNPCC ;one line only
 S STN=RMPR("NAME")
 D CODE^RMPRN63
 D ^RMPRN6UT
 G:$D(DIRUT)!($D(DTOUT)) EXIT
 I $G(RMPRCDE)="" S RMPRCDE="",RMPRCDE=$O(BRA(Y,RMPRCDE))
 S Y=DATE(1) D DD^%DT S DATE(3)=Y,Y=DATE(2) D DD^%DT S DATE(4)=Y
 S %ZIS="Q" D ^%ZIS G:POP EXIT K IOP I $E(IOST,1,2)["C-" G PRTL
 I $D(IO("Q")) S ZTIO=ION,ZTSAVE("RMPRSITE")="",ZTSAVE("RMPR(")=""
 I  S ZTSAVE("DATE(")="",ZTSAVE("RMPRZ")="",ZTSAVE("RMPRDET")="",ZTSAVE("RMPRCDE")=""
 I  S ZTRTN="PRTL^RMPRN6",ZTDESC="Prosthetic NPPD" D ^%ZTLOAD K ZTDESC,ZTIO,ZTRTN,ZTSAVE G EXIT
PRTL ;print one line entry from taskman
 I '$D(IO("Q")) U IO
 D GNP
 D CAL^RMPRN6
 S PAGE=0,FL=""
 S CODE=RMPRCDE
 D DESP^RMPRN6PL
 Q
SET ;set temp global
 S STN=RMPR("NAME")
 S ^TMP($J,"RMPRGN",STN,GN,FLAG,LINE,RMPRB)=""
 S RMSSN=$P(^RMPR(660,RMPRB,0),U,2) I RMSSN S RMSSN=$P(^DPT(RMSSN,0),U,9)
 I RMSSN'="" S ^TMP($J,"A",RMSSN)=""
 K RMSSN
 Q
 ;
LOOP ;sort on hcpcs key and grouper is complete
 ;store in tmp($j,"N",station) or "R"
 S (TAM,T1,RMPRB,COUNT,CODE,RMPRAD,DATE,RMPRFG,RMPRT,RMPRI,RMPRNW,RMPRRPR)=0
 S (TQTY,RMPROTH,CC,RMPRC,RMPRN,TT,RMPRPSC,VA,CM,RMPRCT1,SO,SI,DIS,RMPRCT,RMPR21,CODE,RMPRB,FM,LEG,RMPRNI,RMPRNO,RMPRSL,RMPRAA,RMPRPHC)=0
 S DATE=DATE(1),RMPRB=0
CAL ;loop through grouper key sort
 S STN=RMPR("NAME")
 D CODE^RMPRN63
 S GN=""
 F  S GN=$O(^TMP($J,"RMPRGN",STN,GN)) Q:GN=""  D
 .S FLG=0
 .F  S FLG=$O(^TMP($J,"RMPRGN",STN,GN,FLG)) Q:FLG'>0  D  I FLG=1&(RMPRDET'=2)!(RMPRDET'=5) Q
 ..;used items never get grouped
 ..I FLG=1&(RMPRDET'=2)&(RMPRDET'=5) D GROUP Q
 ..;I FLG=1 D GROUP Q
 ..S CODE=0
 ..F  S CODE=$O(^TMP($J,"RMPRGN",STN,GN,FLG,CODE)) Q:CODE=""  D
 ...S RD=0
 ...F  S RD=$O(^TMP($J,"RMPRGN",STN,GN,FLG,CODE,RD)) Q:RD'>0  D
 ....I RMPRDET=1!(RMPRDET=4) D SORT Q
 ....I RMPRDET=2!(RMPRDET=5) D SORTUSED^RMPRN6S Q
 ....I RMPRDET=3!(RMPRDET=6) D SORTBOTH^RMPRN6S Q
 ....;D SORT
 Q
GROUP ;total grouper to main key
 M BC=^TMP($J,"RMPRGN",STN,GN)
 S BF=0,BTCOST=0,SRD=""
 ;bc array is entrie PO 2421
 F  S BF=$O(BC(BF)) Q:BF'>0  D
 .;b1 is line,or code
 .S BL=0
 .F  S BL=$O(BC(BF,BL)) Q:BL=""  D
 ..S BR=0
 ..;BR is record number
 ..F  S BR=$O(BC(BF,BL,BR)) Q:BR'>0  D
 ...S BCOST=$P(^RMPR(660,BR,0),U,16)
 ...S BTCOST=BTCOST+BCOST
 ...I (BF=1)&(SRD="") S SRD=BR,CODE="",CODE=$O(BC(1,CODE))
 K BC
 Q:SRD=""
 ;calculate based on primary
 S TYPE=$P(^RMPR(660,SRD,0),U,4)
 S TY=$S(TYPE="X":2,TYPE=5:2,TYPE="I":1,1:3)
 S SOURCE=$P(^RMPR(660,SRD,0),U,14)
 S COST=BTCOST
 ;stock issue display and calculate zero used cost if VA source
 I $P(^RMPR(660,SRD,1),U,5)'=""&(SOURCE["V") S BTCOST=0,COST=0
 I $P(^RMPR(660,SRD,0),U,13)["-3" S COST=0,SOURCE="VA",BTCOST=0
 S QTY=$P(^RMPR(660,SRD,0),U,7)
 S ^TMP($J,CODE,SRD)=COST
 S CATEGRY=$P($G(^RMPR(660,SRD,"AM")),U,3),SPEC=$P($G(^("AM")),U,4),GN=$P(^("AMS"),U,1)
 ;new or repair code
 S B1=SRD
 I TY=2 D REP
 I TY'=2 D NEW
 Q
SORT ;main data for worksheets
 S TYPE=$P(^RMPR(660,RD,0),U,4)
 S TY=$S(TYPE="X":2,TYPE=5:2,TYPE="I":1,1:3)
 S SOURCE=$P(^RMPR(660,RD,0),U,14)
 I SOURCE="" S SOURCE="C"
 S CATEGRY=$P($G(^RMPR(660,RD,"AM")),U,3),SPEC=$P($G(^("AM")),U,4),GN=$P(^("AMS"),U,1)
 S COST=$P(^RMPR(660,RD,0),U,16)
 ;stock issue source VA, used cost calculation is zero
 I $P(^RMPR(660,RD,1),U,5)'=""&(SOURCE["V") S COST=0
 ;form
 S FORM=$P(^RMPR(660,RD,0),U,13)
 I (FORM=4)!(FORM=15) S COST=0,SOURCE="V"
 S QTY=$P(^RMPR(660,RD,0),U,7)
 S B1=RD
 S ^TMP($J,CODE,RD)=COST
 I TY=2 D REP
 I TY'=2 D NEW
 Q
REP ;calculate repair cost
 ;I $G(RD)'="" D
 ;.S SSN=$P(^RMPR(660,RD,0),U,2) I SSN S SSN=$P(^DPT(SSN,0),U,9)
 ;.I SSN'="" S ^TMP($J,"A",SSN)=""
 ;.K SSN
 S LINE=CODE
 I LINE="R99 A" S SOURCE="C",QTY=1
 I $G(^TMP($J,"R",STN,LINE))="" S ^TMP($J,"R",STN,LINE)=""
 I SOURCE["V" S $P(^TMP($J,"R",STN,LINE),U,1)=$P(^TMP($J,"R",STN,LINE),U,1)+QTY
 I SOURCE["C" S $P(^TMP($J,"R",STN,LINE),U,2)=$P(^TMP($J,"R",STN,LINE),U,2)+QTY
 ;
 S $P(^TMP($J,"R",STN,LINE),U,3)=$P(^TMP($J,"R",STN,LINE),U,3)+COST
 I CATEGRY=1 S $P(^TMP($J,"R",STN,LINE),U,4)=$P(^TMP($J,"R",STN,LINE),U,4)+1
 I CATEGRY=4 S $P(^TMP($J,"R",STN,LINE),U,5)=$P(^TMP($J,"R",STN,LINE),U,5)+1
 I CATEGRY=2 S $P(^TMP($J,"R",STN,LINE),U,6)=$P(^TMP($J,"R",STN,LINE),U,6)+1
 I CATEGRY=3 S $P(^TMP($J,"R",STN,LINE),U,7)=$P(^TMP($J,"R",STN,LINE),U,7)+1
 I SPEC=1 S $P(^TMP($J,"R",STN,LINE),U,8)=$P(^TMP($J,"R",STN,LINE),U,8)+1
 I SPEC=2 S $P(^TMP($J,"R",STN,LINE),U,9)=$P(^TMP($J,"R",STN,LINE),U,9)+1
 I SPEC=3 S $P(^TMP($J,"R",STN,LINE),U,10)=$P(^TMP($J,"R",STN,LINE),U,10)+1
 I SPEC=4 S $P(^TMP($J,"R",STN,LINE),U,11)=$P(^TMP($J,"R",STN,LINE),U,11)+1,$P(^(LINE),U,16)=$P(^(LINE),U,16)+COST
 I TYPE="I" S $P(^TMP($J,"R",STN,LINE),U,12)=$P(^TMP($J,"R",STN,LINE),U,12)+1
 Q
 ;
NEW ;calculate new costs
 ;I $G(RD)'="" D
 ;.S SSN=$P(^RMPR(660,RD,0),U,2) I SSN S SSN=$P(^DPT(SSN,0),U,9)
 ;.I SSN'="" S ^TMP($J,"A",SSN)=""
 ;.K SSN
 S LINE=CODE
 I $G(^TMP($J,"N",STN,LINE))="" S ^TMP($J,"N",STN,LINE)=""
 I SOURCE["V" S $P(^TMP($J,"N",STN,LINE),U,1)=$P(^TMP($J,"N",STN,LINE),U,1)+QTY
 I SOURCE["C" S $P(^TMP($J,"N",STN,LINE),U,2)=$P(^TMP($J,"N",STN,LINE),U,2)+QTY
 S $P(^TMP($J,"N",STN,LINE),U,3)=$P(^TMP($J,"N",STN,LINE),U,3)+COST
 I CATEGRY=1 S $P(^TMP($J,"N",STN,LINE),U,4)=$P(^TMP($J,"N",STN,LINE),U,4)+1
 I CATEGRY=4 S $P(^TMP($J,"N",STN,LINE),U,5)=$P(^TMP($J,"N",STN,LINE),U,5)+1
 I CATEGRY=2 S $P(^TMP($J,"N",STN,LINE),U,6)=$P(^TMP($J,"N",STN,LINE),U,6)+1
 I CATEGRY=3 S $P(^TMP($J,"N",STN,LINE),U,7)=$P(^TMP($J,"N",STN,LINE),U,7)+1
 I SPEC=1 S $P(^TMP($J,"N",STN,LINE),U,8)=$P(^TMP($J,"N",STN,LINE),U,8)+1
 I SPEC=2 S $P(^TMP($J,"N",STN,LINE),U,9)=$P(^TMP($J,"N",STN,LINE),U,9)+1
 I SPEC=3 S $P(^TMP($J,"N",STN,LINE),U,10)=$P(^TMP($J,"N",STN,LINE),U,10)+1
 I SPEC=4 S $P(^TMP($J,"N",STN,LINE),U,11)=$P(^TMP($J,"N",STN,LINE),U,11)+1,$P(^(LINE),U,16)=$P(^(LINE),U,16)+COST
 I TYPE="I" S $P(^TMP($J,"N",STN,LINE),U,12)=$P(^TMP($J,"N",STN,LINE),U,12)+1
 Q
