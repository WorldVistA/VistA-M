RAORDR ;ABV/SCR/MKN - Refer Pending/Hold Requests ; Nov 09, 2022@10:54:24
 ;;5.0;Radiology/Nuclear Medicine;**148,161,170,179,190,196**;Mar 16, 1998;Build 1
 ;
 ; p196/KLM - Does the following:
 ;          - Update order selection to use RAORDS
 ;          - Add 'Order Referred' indicator to file 75.1
 ;          - Add ENTRY/EXIT action to RA ORDERREF to set
 ;            option aware variable
 ;          - Change autohold check to use above indicator
 ;          - Update consult comment to use controlled API
 ;          - Remove unused code
 ;
 ;
 ; Routine/File         IA          Type
 ; -------------------------------------
 ; DEM^VADPT           10061        (S)
 ; ^DIWP               10011        (S)
 ; ^SC(                10040        (S)
 ; ^VA(200             10060        (S)
 ; ^DPT(               10035        (S)
 ; CMT^GMRCGUIB        2980         (C)
 ; ^OR(100             5771,6475    (C)
 ; ^GMR(123            6116,2586    (C)
 ;
 Q
ENT ;Entry
 ;
 N DIC,DIR,DIRUT,DTOUT,DUOUT,QQ,RA123IEN,RA44NA,RAANS,RAANS2,RAARAY,RAARRAY
 N RACDW,RACDWN,RACIENS,RACOMCT,RACNT,RACOM,RACOUNT,RADD,RADFN,RADT,RAEND
 N RAERR,RAEXPL,RAF,RAHDR,RAI,RAILOC,RAJUST,RAJUST2,RAILOC1,RALOCNM,RAMAND
 N RAN,RANOW,RANOW2,RAO,RAOBEG,RAOEND,RAOIFN,RAOPHY,RAORD0,RAORDIEN,RAPOP
 N RAPR,RAPRTYDT,RAQUES,RAQUIT,RAREAS,RAREQSTA,RARES,RASELOC,RASTART,RASUB
 N RAT,RAUCID,X,Y,RAEXP,RANME
 ;
 S (RAARRAY,RACIENS,RAILOC)=""
GETPAT ;
 S (RACOUNT,RASELOC)=0 K RAEOS
 K DIC,DIRUT,^TMP("RAORDR",$J),RAARRAY
 S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC K DIC
 I $D(DIRUT) S RAQUIT=1
 Q:$G(RAQUIT)!($G(Y)=-1)
 S RADFN=+Y,RANME=$S($D(^DPT(RADFN,0)):$P(^(0),"^"),1:"Unknown") ;p196 - RANME needed for call to ^RAORDS
 K DIR S DIR(0)="E" D ^DIR G:'+Y GETPAT
 S Y="P",RAQUIT=0
 S (RACOUNT,RAF,RARES)=0
 D GETORD
 ;p196 - New order lookup returns RAORDS array
 G:'$O(RAORDS(0))!(RAQUIT) GETPAT
 S RAORDIEN=$$MAKECONS^RAORDR1($G(RAORDS(1)))
 ;p196
 ;Add comments to Consult that was just created
 ;P170
 N I,RET
 S RAUCID="",RA123IEN=$G(^OR(100,RAORDIEN,4)) I $P(RA123IEN,";",2)="GMRC" D
 .S RA123IEN=+RA123IEN,RAUCID=$$GET1^DIQ(123,RA123IEN,80)
 .D:RA123IEN
 ..S RACOM(1)="#COI#",RACOM(2)="COI-Veteran OPT-IN for Community Care",RACOM(3)=$P(RAREAS,U,2)
 ..I $D(RAEXP) D
 ...D BRKLINE(.RET,RAEXP,74)
 ...S I=0 F  S I=$O(RET(I)) Q:I=""  S RACOM(I+3)=$G(RET(I))
 ...Q
 ..S RADT=$$NOW^XLFDT() ;p179 - comment activity date is now
 ..L +^GMR(123,RA123IEN):5 I '$T D ERROR^RAORDR1("Consult record locked, cannot update comments.") Q  ;p161 -Lock consult
 ..;p196 - update comment API to use #2980
 ..D CMT^GMRCGUIB(RA123IEN,.RACOM,,RADT)
 ..L -^GMR(123,RA123IEN)
 .W !!,"Consult with UCID: "_$S(RAUCID]"":RAUCID,1:"(Not known)")," has been created",!
 .I 'RA123IEN W !!,"**NO Consult created**",!
 D KILL
 G GETPAT
 ;
KILL ;
 K DIC,DIR,DIRUT,QQ,RA123IEN,RA44NA,RAANS,RAANS2,RAARAY,RAARRAY,RACDW,RACDWN,RACIENS,RACOMCT,RACNT,RACOM
 K RACOUNT,RADD,RADFN,RADT,RAEND,RAERR,RAEXPL,RAF,RAHDR,RAI,RAILOC,RAJUST,RAJUST2,RAILOC1,RALOCNM,RAN,RANOW
 K RANOW2,RAO,RAOBEG,RAOEND,RAOIFN,RAOPHY,RAORD0,RAORDIEN,RAPOP,RAPR,RAPRTYDT,RAQUES,RAQUIT,RAREAS,RAUDIV
 K RAREQSTA,RARES,RASELOC,RASTART,RASUB,RAT,RAUCID,X,Y,RET,RAEXP,RALADT,RAOI,ORDIALOG,RAEXP,RAIENS,RASOC,RAOVSTS
 S (RACIENS,RAILOC)=""
 Q
 ;
GETORD ;p196 - update order selection
 S RAOVSTS="3;5;8"
 W ! D ^RAORDS
 I $O(RAORDS(""),-1)>1 D
 .W !,"Only one order can be referred at a time",!
 .S DIR(0)="Y",DIR("A")="Do you want to select again",DIR("B")="YES" D ^DIR
 .I Y=1 G GETORD
 .E  K RAORDS,DIR,Y
 .Q
 Q
GETINFO(RAARAY) ;this function collects information that would be collected from a SEOC in Consult Toolbox
 N DIR,DIRUT,RACOUNT,RAGMRC1,RARPT,Y
 ;
 S (RAJUST,RAQUIT,RARPT)=0
 ;D SETJUST2 ;Set up RAJUST array with prompts
 D GETMAIN
 S:'$D(RAARAY("TYPEOFSERVICE")) RAARAY("TYPEOFSERVICE")="4^Diagnostic"
 S RAARAY("THIRDPARTY")="2^NO"
 S RAARAY("TRAUMA")="2^NO"
 Q
 ;
GETMAIN ;Ask the main questions and fill in the answers at tag GETJSUB
 ;P170 - CC Justifications now stored in file #75.3 instead of hardcoded in this routine.
 N RAJN,RAJJ,RAI,CNT S RAJN=""
 W !!,"Justification for Community Care"
 ;W !!,?5,"Select one of the following:",!
 S RAI=0 F  S RAI=$O(^RA(75.3,RAI)) Q:RAI="B"  D
 .S RAJJ=$$GET1^DIQ(75.3,RAI,.01),RAJJ=$S($L(RAJJ,":")>1:$P(RAJJ,": ",2),1:RAJJ)
 .I RAI=1 S RAJN=RAI_":"_RAJJ_";"
 .E  S RAJN=RAJN_RAI_":"_RAJJ_";"
 .Q
 S RAJN=$E(RAJN,1,$L(RAJN)-1)
 N DIR,Y S DIR(0)="S^"_RAJN D ^DIR I $D(DIRUT) S RAQUIT=1 Q
 S RAREAS=Y_"^"_$$GET1^DIQ(75.3,Y,.01) K DIR,Y
 I RAREAS="" S RAQUIT=1 Q
 I $$GET1^DIQ(75.3,+RAREAS,2,"I")=1 D
 .S DIR(0)="F^3:240",DIR("A")="EXPLAIN" S DIR("?")="Enter Explaination for '"_$P(RAREAS,U,2)_"': 3-240 characters"
 .D ^DIR I $D(DIRUT) S RAQUIT=1 Q
 .S RAEXP=Y
 .Q
 K DIR,DIRUT,Y
 Q
BRKLINE(OUT,LINE,LGTH) ;Break line down into 80 character lines in OUT
 N CT,DIWL,DIWR,I,X
 S LINE=$$TRIM^XLFSTR(LINE)
 K ^UTILITY($J,"W") S CT=0,DIWL=1,DIWR=LGTH,X=LINE D ^DIWP
 S I="" F  S I=$O(^UTILITY($J,"W",1,I)) Q:'I  S CT=CT+1,OUT(CT)=^UTILITY($J,"W",1,I,0)
 K ^UTILITY($J,"W")
 Q
