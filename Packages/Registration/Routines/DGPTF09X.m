DGPTF09X ;ALB/MTC,HIOFO/FT - TRANSMIT DELETE PTF MASTER RECORD ;5/26/15 4:27pm
 ;;5.3;Registration;**58,884**;Aug 13, 1993;Build 31
 ;
 ; VATRAN - #1011
 ; VASITE - #10112
 ; XLFSTR - #10104
 ;
EN ; -- generic 099 call
 D INIT^DGPTF099 G ENQ:DGOUT
 F DGLOOP=0:0 D EN1,CONT Q:DGOUT
 K DGLOOP
 G ENQ
EN1 ; -- init already done
 D SETUP G ENQ:DGOUT
 S DIC="^DGP(45.87,",DIC(0)="L" K DO,DD D NOW^%DTC S X=% D FILE^DICN K DIC,DO
 G ENQ:Y<0 S (DGDA,DA)=+Y
EDIT S DGPAT=$P(^DGP(45.87,DGDA,0),U,9)
 F DGI=0:0 S DA=DGDA,DIE="^DGP(45.87,",DR="[DGPT 099]" D ^DIE,CHKFLD^DGPTRPO Q:'DGOUT  D ASK^DGPTRPO I DGOUT D DEL^DGPTRPO G ENQ
SEND S DGOUT=0,DIR(0)="Y",DIR("A")="Ok to Send "_DGCTL,DIR("B")="YES"
 D ^DIR I $D(DIRUT)!(Y=0) D ASK^DGPTRPO G EDIT:'DGOUT I DGOUT D DEL^DGPTRPO G ENQ
 I Y K X D
 .S $P(X," ",241)=""
 .S:$E(DGSSN,10)="P" DGSSN="P"_$E(DGSSN,1,9)
 .S ^UTILITY($J,"T099",1,1,1,0)=$E(DGCTL_$J(DGSSN,10)_$J(DGADM,10)_$J(DGRFAC,6)_X,1,240)
 .S ^UTILITY($J,"T099",1,1,2,0)=$$REPEAT^XLFSTR(" ",144)
 .D TRAN^DGPTF099
 .W !,"***** 099 TRANSACTION SENT *****"
 .S DIE="^DGP(45.87,",DA=DGDA,DR=".03////"_XMZ D ^DIE
 .K DA,XMZ,DIE,DR
ENQ K %,DGRTY,DGRFAC,DGTADM,DGPAT,DGINST,DGFNAM,DGNAME,DGCTL,DGADM,DA,DGDA,DGRPO,DIR,DIE,DIK,X,Y,DGOUT,DIRUT,XMTEXT,XMSUB,XMDUZ,DGSSN,DGFAC,DIC,DR,DD,DO,DGI,DQ,DB,DE
 Q
HD099 ;-- header for 099 transaction. called from [DGPT 099] input template
 W @IOF,$C(13),?10,">>> Facsimile of 099 Transaction <<<"
 W:DGNAME]"" !,"Patient : ",DGNAME
 S:$E(DGSSN,10)="P" DGSSN="P"_$E(DGSSN,1,9)
 W !!,?9,"'",$J(DGCTL,4),"' '",$J(DGSSN,10),"' '",$J(DGADM,10),"' '",$J(DGRFAC,6),"'"
 W !?2,"col# :"
 W ?10,"1--4   5--------1   1--------2   2----3",!
 W ?10,"                4   5        4   5    0",!
 W !?2,"block:"
 W ?10,"       SSN          Admitting    Requesting",!
 W ?10,"                    Date/Time    Facility",!
 W ?10,"                                 Num/Suffix",!!
 Q
 ;
CONT ;-- ask the user if they want to do another
 S DGOUT=0
 S DIR(0)="Y",DIR("A")="Would you like to do another 099 transaction",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT)!(Y=0) S DGOUT=1
CONTQ K DIR
 Q
 ;
SETUP S DGOUT=0,VATNAME="PTF125" D ^VATRAN I VATERR S DGOUT=1 G SETQ
 S (DGPAT,DGINST,DGADM,DGSSN,DGTADM,DGFAC,DGFNAM,DGNAME)="",DGRFAC=$E($P($$SITE^VASITE,U,3)_"      ",1,6),DGCTL="N099"
SETQ K VATERR,VATNAME
 Q
 ;
