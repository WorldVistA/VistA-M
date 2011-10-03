RMPRPIYJ ;HINCIO/RVD-ISSUE FROM STOCK / CONT. ;9/18/02  07:39
 ;;3.0;PROSTHETICS;**61,128**;Feb 09, 1996
 ; RVD #61 - pip INVENTORY PHASE IIIa
 ;
 ;Per VHA Directive 10-93-142, this routine should not be modified.
QTY K DIR,Y S DIR(0)="660,5",DIR("B")=1 S:$P(R1(0),U,7) DIR("B")=$P(R1(0),U,7)
 D ^DIR I $P(R1(0),U,7)'=""&$D(DUOUT) G LIST
 I $D(DTOUT) X CK2 G ^RMPRPIYI
 I $D(DIRUT) G ^RMPRPIYI
 I $G(RMUBA),((RMUBA-Y)<0) D LOWBA^RMPRPIYI G 2^RMPRPIYI
 I $G(RMITQTY),RMITQTY<Y W !,"Issue quantity exceeds on-hand (",RMITQTY,") for scanned item bar code!!",! G QTY
 S $P(R1(0),U,7)=Y,$P(R1(0),U,16)=Y*RMPRUCST K DIR
 ;
DATE ;delivery date is set to today's date
 S $P(R1(0),U,12)=DT,Y=DT D DD^%DT S $P(R3("D"),U,12)=Y
 ;
SERV ;date of service
 S Y=DT D DD^%DT S DIR("B")=Y,DIR("A")="DATE OF SERVICE",DIR(0)="660,39"
 I $G(REDIT) S DIR("B")=$P(R1("D"),U,8)
 D ^DIR K DIR I $D(DTOUT) X CK2 G ^RMPRPIYI
 I $D(DUOUT),$G(REDIT) G LIST
 I (X="")!(X="@") W !,"This field is mandatory!!!",! G SERV
 S $P(R1(1),U,8)=Y D DD^%DT S $P(R1("D"),U,8)=Y
 ;
LI S DIR(0)="660,9" S:$P(R1(0),U,11)'="" DIR("B")=$P(R1(0),U,11)
 D ^DIR I $D(DTOUT) X CK1 Q
 G:$D(DUOUT) LIST
 I X["^" W !,"Jumping not allowed" G LI
 I $P(R1(0),U,11)'=""&(X="@") S $P(R1(0),U,11)="" W $C(7),!?5,"Deleted..." H 1 G LOT
 S $P(R1(0),U,11)=X
 ;
LOT ;
 ;
 K DIR S DIR(0)="660,21" S:$P(R1(0),U,24)'="" DIR("B")=$P(R1(0),U,24)
 D ^DIR I $D(DTOUT) X CK1 Q
 G:$D(DUOUT) LIST
 I X["^" W !,"Jumping not allowed" G LOT
 I $P(R1(0),U,24)'=""&(X="@") S $P(R1(0),U,24)="" W $C(7),!?5,"Deleted..." H 1 G REMA
 S $P(R1(0),U,24)=X
 ;
REMA ;
 ;
 K DIR S DIR(0)="660,16" S:$P(R1(0),U,18)'="" DIR("B")=$P(R1(0),U,18)
 D ^DIR I $D(DTOUT) X CK1 Q
 G:$D(DUOUT) LIST
 I X["^" W !,"Jumping not allowed" G REMA
 I $P(R1(0),U,18)'=""&(X="@") S $P(R1(0),U,18)="" W $C(7),!?5,"Deleted..." H 1 G LIST
 S $P(R1(0),U,18)=X
 ;
LIST ;ENTRY POINT FOR STOCK ISSUE ROUTINES TO DISPLAY TRANSACTION DATA
 S RMDAHC=$P(R1(1),U,4)
 D:$D(RMCPT) CHK^RMPRED5
 D ^RMPRPIYK
 K DIR,RQUIT
 S DIR(0)="SBO^P:POST;E:EDIT;D:DELETE"
 S DIR("A")="Would you like to POST/EDIT/DELETE this entry"
 S DIR("B")="P"
 S DIR("?")="Answer `P` to post the transaction, `E` to edit the transaction,'D' to delete the transaction"
 D ^DIR K DIR G:Y="P" POST G:Y="D" DEA
 I Y="E" S REDIT=1 G 1^RMPRPIYI
 I $D(DIRUT)!$D(DUOUT)!$D(DTOUT) G ^RMPRPIYI
 ;
DEA ;
 K DIR
 S DIR("A")="Are you sure you want to DELETE this entry"
 S DIR("B")="N",DIR(0)="Y"
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT) X CK Q
 I Y=1 W !!,$C(7),?50," Deleted..." H 2 K DIR G RES^RMPRPIYI
 G LIST
 ;
POST ;
 I RMPR699("AMIS GROUPER")'="" G GGC
 S RMPRAMIS=0
 S RMPR699("IEN")=RMPRSITE
 S RMPRAMIS=$$AMGR^RMPRPIX2(.RMPR699)
 I RMPRAMIS X CK Q
GGC ;
 D SETARR(.RMPR60)
 S RMPRERR=$$ISS^RMPRPIU6(.RMPR60,.RMPR11I,.RMPR5)
 I RMPRERR=9 D LOWBA^RMPRPIYI G 2^RMPRPIYI
 I RMPRERR W !,"*** ERROR in API RMPRPIU6, ERROR = ",RMPRERR," !!!" G EXIT
 S ^TMP($J,"RMPRPCE",660,RMPR60("IEN"))=RMPR699("AMIS GROUPER")_"^"_$G(RMPRDFN)
 ;
 W !,"Posted to 2319..." H 3
 G RES^RMPRPIYI
 ;
EXIT ;EXIT FOR STOCK ISSUES
 N RMPRSITE,RMPR D KILL^XUSCLEAN
 Q
 ;
INV1 I $P(R1(0),U,14)="C" S $P(R1(0),U,16)=RMPRUCST*$P(R1(0),U,7)
 G QTY
 ;
 ; Set up arrays for Stock Issue Transaction
SETARR(RMPR60) ;
 K RMPR60
 S RMPR60("ENTRY DATE")=$P(R1(0),U,1)
 S RMPR60("PATIENT IEN")=$P(R1(0),U,2)
 S RMPR60("ISSUE TYPE")=$P(R1(0),U,4)
 S RMPR60("QUANTITY")=$P(R1(0),U,7)
 S RMPR60("IFCAP ITEM")=$P(R1(0),U,6)
 S RMPR60("UNIT")=$P(R1(0),U,8)
 S RMPR60("VENDOR IEN")=$P(R1(0),U,9)
 S RMPR60("SERIAL NUM")=$P(R1(0),U,11)
 S RMPR60("DELIV DATE")=$P(R1(0),U,12)
 S RMPR60("DATE OF SERVICE")=$P(R1(1),U,8)
 S RMPR60("SOURCE")=$P(R1(0),U,14)
 S RMPR60("COST")=$P(R1(0),U,16)
 S RMPR60("REMARKS")=$P(R1(0),U,18)
 S RMPR60("LOT NUM")=$P(R1(0),U,24)
 S RMPR60("HCPCS")=$P(R1(1),U,4)
 S RMPR60("CPT IEN")=$P(R1(0),U,22)
 S RMPR60("CPT MOD")=$P(R1(1),U,6)
 S RMPR60("PAT CAT")=$P(R1("AM"),U,3)
 S RMPR60("SPEC CAT")=$P(R1("AM"),U,4)
 S RMPR60("USER")=$P(R1(0),U,27)
 S RMPR60("SITE IEN")=RMPRSITE
 S RMPR60("GROUPER")=RMPR699("AMIS GROUPER")
 S RMPR60("DATE&TIME")=R1("DATE&TIME")
 Q
