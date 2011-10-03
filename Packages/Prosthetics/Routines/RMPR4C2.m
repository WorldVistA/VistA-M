RMPR4C2 ;;HINES-OI/HNC - PURCHASE CARD VERIFY PC# FOR RECONCILIATION;10/29/2001
 ;;3.0;PROSTHETICS;**67**;Feb 09, 1996
 ;
 ;Match on Visa Level II, Old Card, New Card, Card Holder
 ;HNC 11-6-01
 ;
 ;IFCAP Integration Agreement for file #442: DBIA282-H, ref #803
 ;IFCAP Integration Agreement for file #440.6: ref #3427
 ;
 Q
EN ;Entry Point
 W !,?5,"Verify and Repair Purchase Card Number Associated with the"
 W !,?5,"ORACLE Document for Reconciliation"
 W !,?5,"You Must Be the Card Holder of both OLD and NEW Cards!",!!
 K ^TMP($J) D DIV4^RMPRSIT G:$D(X) EXIT
 D HOME^%ZIS
 S RMPRCOUN=0
 S %DT("A")="Starting Date: ",%DT="AEPX" D ^%DT
 S RMPRBDT=Y G:Y<0 EXIT
 S %DT("A")="Ending Date: ",%DT="AEX" D ^%DT G:Y<0 EXIT
 S RMPREDT=Y
 I RMPRBDT>RMPREDT W !,$C(7),"Invalid Date Range Selection!!" G EN
 ;
 S Y=RMPRBDT D DD^%DT S RMPRX=Y,Y=RMPREDT D DD^%DT S RMPRY=Y
PCRD ;ask purchase card number
 K DIR S DIR(0)="FO",DIR("A")="Enter OLD Purchase Card Number"
 S DIR("?")="Enter the 16-Digit Purchase Card #, no dashes or spaces."
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) W !,$C(7),$C(7),"Try Later!" G EXIT
 I $L(X)>16!($L(X)<16)!(X'?.N) W !,"Must be 16-Digit Number." G PCRD
 S RMPRPCRD=Y
PCRDN K DIR S DIR(0)="FO",DIR("A")="Enter NEW Purchase Card Number"
 S DIR("?")="Enter the NEW 16-Digit Purchase Card #, no dashes or spaces."
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) W !,$C(7),$C(7),"Try Later!" G EXIT
 I $L(X)>16!($L(X)<16)!(X'?.N) W !,"Must be 16-Digit Number." G PCRDN
 S RMPRPCNW=Y
 ;
 ;taskman
 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT
 I '$D(IO("Q")) U IO G PRINT
 K IO("Q")
 S ZTDESC="PURCHASE CARD VERIFY",ZTRTN="PRINT^RMPR4C2"
 S ZTSAVE("RMPRBDT")="",ZTSAVE("RMPREDT")=""
 S ZTSAVE("RMPRY")="",ZTSAVE("RMPR(")="",ZTSAVE("RMPRPCRD")=""
 S ZTSAVE("RMPRX")="",ZTSAVE("RMPRPCNW")="",ZTIO=ION
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT
 ;
PRINT S X1=RMPRBDT,X2=-1 D C^%DTC S PAGE=1,RMPREND="",RMPRFLG=""
 I $E(IOST)["C" W @IOF
 S RO=RMPRBDT-1
 F  S RO=$O(^RMPR(664,"B",RO)) Q:RO'>0  Q:RO>RMPREDT  S RP=0 F  S RP=$O(^RMPR(664,"B",RO,RP)) Q:RP'>0  D CK
 S RMPRFLG="",RMPREND=""
 D HDR,ST
 G EXIT
CK ;set tmp of list to compare with 440.6
 Q:'$D(^RMPR(664,RP,0))
 ;Vendor must not be null,PC number not null,no cancellation date
 ;and station must be station selected
 ;must have no close out date
 ;
 Q:$P(^RMPR(664,RP,0),U,4)=""!($P($G(^(4)),U,1)="")!($P(^(0),U,5)'="")
 Q:$P(^RMPR(664,RP,0),U,14)'=""&($P(^(0),U,14)'=RMPR("STA"))
 ;close out date
 Q:$P(^RMPR(664,RP,0),U,8)'=""
 ;decrypt PC number - rmprobl is decrypted card number, rmprpcrd what
 ;user typed as 16 dig number
 S ROBL=$P($G(^RMPR(664,RP,4)),U,1)
 S RMPROBL=$$DEC^RMPR4LI($P(^RMPR(664,RP,4),U,1),$P(^RMPR(664,RP,0),U,9),RP)
 Q:RMPROBL'=RMPRPCRD
 S RMPRODR=$P($G(^RMPR(664,RP,4)),U,6)
 Q:RMPRODR=""
 S ^TMP($J,RMPRODR,RMPROBL,RP)=""
 Q
 ;
COMP ;Enter RETURN to continue or '^' to exit:
 ;
 S RMPRFLG=1
 I $Y>(IOSL-6) S RMPRFLG=""
 ;
 Q
ST ;continue if user didn't want out, or time out
 ;
 I '$D(^TMP($J)) W !!,"*** NO DATA TO PRINT ***",!! Q
 S PO=0
 F  S PO=$O(^TMP($J,PO)) Q:PO'>0  Q:RMPREND=1  D
 .S POE=$P($G(^PRC(442,PO,0)),U,1)
 .Q:POE=""
 .;I ($X>14)&($X<65) W ?63,"|"
 .;PSPC is psas card number
 .S PSPC=0
 .F  S PSPC=$O(^TMP($J,PO,PSPC)) Q:PSPC'>0  Q:RMPREND=1  D
 . .S RD=0,VISA2=""
 . .F  S RD=$O(^TMP($J,PO,PSPC,RD)) Q:RD'>0  Q:RMPREND=1  D
 . . .S ORDATE=$$DAT1^RMPRUTL1($P(^RMPR(664,RD,0),U,1))
 . . .W !,ORDATE
 . . .W ?14,POE,?28,"|"
 . . .S BDT=RMPRBDT
 . . .F  S BDT=$O(^PRCH(440.6,"D",BDT)) Q:BDT'>0  D
 . . . .S (REC440,RCNT)=0
 . . . .F  S REC440=$O(^PRCH(440.6,"D",BDT,REC440)) Q:REC440'>0  Q:RMPREND=1  D
 . . . . .;only look at current users records
 . . . . .I $P(^PRCH(440.6,REC440,0),U,17)'=DUZ Q
 . . . . .K RM440 S RM440="",RECIEN40=REC440_","
 . . . . .D GETS^DIQ(440.6,RECIEN40,"**","","RM440")
 . . . . .S PC=RM440(440.6,RECIEN40,3),IFST=RM440(440.6,RECIEN40,14),VISA2=RM440(440.6,RECIEN40,20)
 . . . . .;S PC=$P(^PRCH(440.6,REC440,0),U,4),IFST=$P(^(0),U,15),VISA2=$P(^(0),U,21)
 . . . . .S VISA2=$TR(VISA2,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTVWXYZ")
 . . . . .;W ?50,$S(IFST="R":"Reconciled",IFST="N":"None",IFST="D":"Disputed",1:""),?63,"|"
 . . . . .S PSASV2=$P(POE,"-",2)
 . . . . .;match on visa 2 string from vendor
 . . . . .I VISA2'[PSASV2 Q
 . . . . .S RCNT=RCNT+1
 . . . . .W:RCNT>1 !,?28,"|"
 . . . . .W ?30,PC
 . . . . .W ?50,VISA2,?63,"|"
 . . . . .;verify both files same
 . . . . .I PC=PSPC W ?65,"Okay"
 . . . . .I $E(IOST,1,2)["C-"&($Y>(IOSL-6)) S DIR(0)="E" D ^DIR S:(Y<1)!($D(DTOUT)) RMPREND=1 Q:$G(RMPREND)  D HDR
 . . . . .I $E(IOST,1,2)'="C-"&($Y>(IOSL-6)) D HDR
 . . . . .I PC=PSPC Q
 . . . . .;check to make sure it is the new card number
 . . . . .I PC'=RMPRPCNW W ?65,"Diff Card #" Q
 . . . . .;update prosthetic file 664
 . . . . .S $P(^RMPR(664,RD,4),U,7)=PC,$P(^(4),U,8)=REC440,$P(^(4),U,9)=DT
 . . . . .;
 . . . . .;update file 440.6 with original PC number
 . . . . .S DIE="^PRCH(440.6,",DR="3////^S X=PSPC",DA=REC440
 . . . . .L +^PRCH(440.6,DA,0):2 I '$T W !,"Record in use by another user.  Try Later!" K DIE S RMPREND=1 Q
 . . . . .D ^DIE
 . . . . .L -^PRCH(440.6,DA,0)
 . . . . .K DA,DIE,DR
 . . . . .W ?65,"Repaired"
 Q
 ;
HDR ;header
 I RMPREND=1 Q
 I PAGE'=1 W @IOF
 W !,RMPRX_"-",RMPRY,"  Verify PC# "_RMPRPCRD_"  STA "_$$STA^RMPRUTIL,?72,"PAGE ",PAGE,!
 S PAGE=PAGE+1
 W !,"Order Date",?14,"Order Number",?28,"|",?30,"ORACLE PC #",?50,"VISA II",?63,"|",?65,"Record Status",!,RMPR("L")
 Q
EXIT ;Common Exit
 I $E(IOST)["C",'$G(RMPREND),$D(^TMP($J)) W ! S DIR(0)="E" D ^DIR
 D ^%ZISC N RMPR,RMPRSITE
 D KILL^XUSCLEAN K ^TMP($J)
 Q
