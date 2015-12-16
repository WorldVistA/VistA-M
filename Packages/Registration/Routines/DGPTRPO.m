DGPTRPO ;ALB/MTC,HIOFO/FT - RECORD PRINT OUT (RPO);5/26/15 3:24pm
 ;;5.3;Registration;**884**;Aug 13, 1993;Build 31
 ;
 ; VATRAN - #1011
 ; XMD - #10070
 ; VASITE - #10112
 ; XMA2 - #10066
 ; ^XMB(3.9) - #10113
 ; ^VA(200) - #10060
 ; %ZIS - #10086
 ; ^DPT - #10035
 ; XLFSTR - #10104
 ;
EN ;-- generic N15x call. Record Print-Out (RPO) [DGPTTOOL RPO]
 D INIT G ENQ:DGOUT
 D FMT G ENQ:DGOUT
 S DIC="^DGP(45.87,",DIC(0)="L" K DO,DD D NOW^%DTC S X=% D FILE^DICN K DIC,DO
 G ENQ:Y<0 S (DA,DGDA)=+Y
EDIT S DIE="^DGP(45.87,",(DR,DGDR)=$S(DGCTL="N150":"[DGPT 150]",1:"[DGPT 151]")
 S DGPAT=$P(^DGP(45.87,DGDA,0),U,9),DGINST=$P(^DGP(45.87,DGDA,0),U,10)
 F DGI=0:0 S DA=DGDA,DR=DGDR D ^DIE,CHKFLD Q:'DGOUT  D ASK I DGOUT D DEL,ENQ G EN
SEND S DGOUT=0,DIR(0)="Y",DIR("A")="Ok to Send "_DGCTL,DIR("B")="YES"
 D ^DIR I $D(DIRUT)!(Y=0) D ASK G EDIT:'DGOUT I DGOUT D DEL,ENQ G EN
 I Y D PRETRAN G:DGOUT EN D
 .K X S $P(X," ",241)=""
 .S:$E(DGSSN,10)="P" DGSSN="P"_$E(DGSSN,1,9)
 .S ^XMB(3.9,XMZ,2,1,0)=$E(DGCTL_$J(DGSSN,10)_$J(DGADM,10)_$J(DGFAC,6)_$J(DGRFAC,6)_X,1,240)
 .S ^XMB(3.9,XMZ,2,2,0)=$$REPEAT^XLFSTR(" ",144)
 .D TRAN W !,"****** ",DGCTL," TRANSACTION SENT ******"
 D ENQ G EN
ENQ K %,DGDR,DGDA,DGPAT,DGINST,DGFNAM,DGNAME,DGCTL,DGTADM,DA,DGRPO,DIR,DIE,DIK,X,Y,DGOUT,VATNAME,VATERR,VAT,DIROUT,DIRUT,XMTEXT,XMSUB,XMDUZ,XMDUN,DGSSN,DGADM,DGRFAC,DGFAC,DIC,DR,DD,DO,DGDA,DGI,DQ,DB,DE
 Q
 ;
CHKFLD ;-- check data for valid entries
 S DGOUT=0
 I '$D(^DGP(45.87,DGDA,0)) S DGOUT=1 G CHKFLDQ
 S DGRPO=^DGP(45.87,DGDA,0)
 I DGCTL="N150" F DGJ=5:1:8 I $P(DGRPO,U,DGJ)="" S DGOUT=1 D CHKERR
 I DGCTL="N151" F DGJ=5,8 I $P(DGRPO,U,DGJ)="" S DGOUT=1 D CHKERR
 I DGCTL="N099" F DGJ=5,6,8 I $P(DGRPO,U,DGJ)="" S DGOUT=1 D CHKERR
 I +$P(DGRPO,U,9) S DGNAME=$P(^DPT($P(DGRPO,U,9),0),U)
CHKFLDQ ;
 K DGRPO,DGJ
 Q
CHKERR ;
 W !,"*** ",$P("^^^^SSN^ADMISSION DATE/TIME^ADMITTING FACILITY NUMBER/SUFFIX^REQUESTING FACILITY NUMBER/SUFFIX","^",DGJ)," field is empty."
 Q
 ;
ASK ;-- On error in record check for re-edit
 S DGOUT=0
 S DIR(0)="Y",DIR("A")="Would you like to EDIT the "_DGCTL_" record",DIR("B")="YES"
 D ^DIR
 I $D(DIRUT)!(Y=0) S DGOUT=1
ASKQ K DIR
 Q
 ;
HDRPX ;called from [DGPT 150] and [DGPT 151] input templates
 W @IOF,$C(13),?18,">>> Facsimile of ",DGCTL," Transaction <<<"
 W:DGNAME]"" !,"           Patient : ",DGNAME
 W:DGFNAM]"" !,"Admitting Facility : ",DGFNAM
 S:$E(DGSSN,10)="P" DGSSN="P"_$E(DGSSN,1,9)
 W !!?9,"'",$J(DGCTL,4),"'   '",$J(DGSSN,10),"'   '",$J(DGADM,10),"'   '",$J(DGFAC,6),"'   '",$J(DGRFAC,6),"'"
 W !?2,"col# :"
 W ?10,"1--4     5--------1     1--------2     2----3     3----3",!
 W ?10,"                  4     5        4     5    0     1    6",!
 W !?2,"block:"
 W ?10,"         SSN            Admission     Admitting   Requesting",!
 W ?10,"                        Date/Time     Facility    Facility",!
 W ?10,"                                      Num/Suffix  Num/Suffix",!!
 I DGCTL="N151" W !,"For the 151 the Admission DATE/TIME and",!,"the Admitting Facility Num/Suffix CANNOT be filled in.",!!
 Q
 ;
FMT ;-- select format 150/151; set trans router to PTF125
 S DGOUT=0
 S DGOUT=0,DIR(0)="SB^150:N150 SPECIFIC (RPO);151:N151 GENERAL (RPO);EXIT:EXIT",DIR("A")="Which RPO Format",DIR("?")="Enter 150 or 151 for the Record Print-Out (RPO) form to be sent.",DIR("B")="EXIT"
 W @IOF D ^DIR I $D(DIRUT)!(Y="EXIT") S DGOUT=1 G FMTQ
 S DGY=Y
 S DGCTL=$S(DGY=150:"N150",1:"N151")
 S VATNAME="PTF125" D ^VATRAN I VATERR S DGOUT=1 G FMTQ
FMTQ K DGY,DIR,DIRUT Q
 ;
PRETRAN ;-- get mailman msg #
 S DGOUT=0,XMSUB="PTF "_DGCTL,XMDUZ=DUZ
 D GET^XMA2
 I $D(XMZ),XMZ>0 G PREQ
 W !!,"*** ERROR *** Unable to create Mail Message... Try again later." S DGOUT=1
PREQ Q
TRAN ;
 K XMY D ROUTER^DGPTFTR
 S XMDUN=$P(^VA(200,DUZ,0),U),^XMB(3.9,XMZ,2,0)="^3.92A^1^1^"_DT
 D ENT1^XMD
 S DIE="^DGP(45.87,",DA=DGDA,DR=".03////"_XMZ D ^DIE
 K XMZ,DIE,DR
 Q
 ;
DEL ;-- KILL ENTRY 
 S DA=DGDA,DIK="^DGP(45.87," D ^DIK
 Q
 ;
INIT ;
 D LO^DGUTL,HOME^%ZIS S DGOUT=0
 S (DGPAT,DGINST,DGCTL,DGTADM,DGSSN,DGADM,DGFAC,DGFNAM,DGNAME)="",DGRFAC=$E($P($$SITE^VASITE,U,3)_"      ",1,6)
INITQ Q
