PSXSITE ;BIR/WPB,BAB-Activate Outpatient Sites for CMOP ;09 SEP 1998  6:52 AM
 ;;2.0;CMOP;**1,18,24,27,38,41**;11 Apr 97
 ;Reference to ^DIC(4,   supported by DBIA #10090
 ;Reference to ^DIC(4.2, supported by DBIA #1966
 ;Reference to File #200 supported by DBIA #10060
 ;
EN1 I '$D(^XUSEC("PSXCMOPMGR",DUZ)) W !,"You are not authorized to use this option!" Q
 D SET^PSXSYS G:$G(PSXSYS)="" EN2
 I $P(PSXSYS,"^",2)="" W !!,"The Station number is missing in the Institution file.",!,"The Station number is required for CMOP transmissions.",!,"Please contact your IRM and have this problem corrected, then try again.",! Q
 I $P($G(^PSX(550,+$G(PSXSYS),0)),"^",3)'="H" W !,"There is a transmission in progress, try later." Q
 I $D(^PSX(550,"TR","T")) W !,"There is a transmission in progress, try later." Q
 ;I S $P(^PSX(550,+$G(PSXSYS),0),"^",3)="T"
 K DIE,DA,DR
 S DIE=550,DA=+PSXSYS,DR="2////T"
 L +^PSX(550,DA):600 I '$T W !,"Sorry, someone else has the CMOP System file!" H 3 Q
 D ^DIE L -^PSX(550,DA)
 K DIE,DA,DR
EN2 I $D(^PSX(550,"AP")) W !,"A request to activate a system has been sent and action is pending." G EXIT
 I $D(^PSX(550,"C")) D DEACT^PSXSYS G EXIT
 I '$D(^PSX(550,"C")) S SYSFLAG=1 D SYSTEM^PSXSYS
EXIT I $G(PSXSYS)'="" D
 .S DA=+PSXSYS
 .L +^PSX(550,DA):6 I '$T W !,"Someone else has the CMOP System file in use, quitting" Q
 .K DIE,DA,DR
 .S DIE=550,DA=+PSXSYS,DR="2////H" D ^DIE
 .L -^PSX(550,DA) K DIE,DA,DR
 K SYSFLAG,SYSTEM,SS,SY,Y,CDOM,FDOM,SYSSTAT,PP,PURG,PDTTM,XX,XMIT,STAT,AA,DIR,PSXMDM,TT,DIRUT,DTOUT,DUOUT,DIROUT,PSXSYS
 Q
ACT W ! K SYSTEM,SS,Y
 S DIC(0)="AEQMZ",DIC("A")="Enter System to activate:  ",DIC=550 D ^DIC K DIC G:(Y=0)!($D(DTOUT))!($D(DUOUT)) EXIT K DTOUT,DUOUT
 I X="" W !,"Enter the name of the system to activate." G ACT
 I X'="" S (DA,SS)=+Y,SYSTEM=$P($G(Y),U,2) K Y
 I X="^" G EXIT K DIC,Y W !
 I $D(^PSX(550,"C")) S TT=$O(^PSX(550,"C","")) I $G(TT)=SS W !,"The "_SYSTEM_" is already activated." G ACT
 S SYSFLAG=1 G SYS^PSXSYS
AC W ! S DIR(0)="Y",DIR("A")="Are you sure you want to activate the "_SYSTEM_" system",DIR("B")="NO" D ^DIR K DIR G:(Y=0)!($D(DIRUT)) EXIT K DIRUT,DTOUT,DUOUT
 ;S DA=+SS,DIE="^PSX(550,",DR="3////"_PSXMDM D ^DIE K DIE,DA,DR
 D NOTE K S1,S2,S3
 W !!,"Request to activate sent to "_SYSTEM_"."
 Q
NOTE S (S1,DA)=$$KSP^XUPARAM("INST"),DIC="4",DIQ(0)="IE",DR=".01;99",DIQ="PSXUTIL" D EN^DIQ1 S ST=$G(PSXUTIL(4,S1,99,"I")),SITE=$G(PSXUTIL(4,S1,.01,"E")) K DA,DIC,DIQ(0),DR
 I $G(ST)="" W !!,"The Station number is missing in the Institution file.",!,"The Station number is required for CMOP transmissions.",!,"Please contact your IRM and have this problem corrected, then try again." Q
 K PSXUTIL
 S XX=$P($G(^PSX(550,SS,0)),U,4),DOMAIN=$$GET1^DIQ(4.2,XX,.01)
 S NM=$$GET1^DIQ(200,DUZ,.01),NAME=$P(NM,",",2)_" "_$P(NM,",",1)
 I '$D(DOMAIN) W !!,"There is no mail domain to send the request to." Q
 D NOW^%DTC S (Y,TIME)=% X ^DD("DD") S RTIME=Y K Y,%
 S XMDUZ=.5,XMSUB=$S(SYSFLAG=1:"CMOP Activation Request",SYSFLAG=0:"CMOP Inactivation Notice",1:""),LCNT=2
MM D XMZ^XMA2 G:XMZ<1 MM
 S ^XMB(3.9,XMZ,2,1,0)=$S(SYSFLAG=1:"$$ACT^",SYSFLAG=0:"$$DACT^",1:"")_SITE_"^"_TIME_"^"_SS_"^"_ST_"^"_$$GET1^DIQ(200,DUZ,.01)
 S ^XMB(3.9,XMZ,2,2,0)="$$ENDACT"
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_U_LCNT_U_DT,XMDUN=NAME
 K XMY S XMDUZ=.5,XMY("S.PSXX CMOP SERVER@"_DOMAIN)=""
 ;S XMY(DUZ)="" H 1 ;****TESTING S.PSXX
 D ENT1^XMD
MESS S XMDUZ=.5,XMSUB=($S(SYSFLAG=1:"CMOP Activation Request",SYSFLAG=0:"CMOP Inactivation Notice",1:"")),LCNT=5
 D XMZ^XMA2 G:XMZ<1 MESS
 S ^XMB(3.9,XMZ,2,1,0)=$S(SYSFLAG=1:"Request to activate.",SYSFLAG=0:"Inactivation notice sent.",1:"")
 S ^XMB(3.9,XMZ,2,2,0)=""
 S ^XMB(3.9,XMZ,2,3,0)="CMOP            :  "_SYSTEM
 S ^XMB(3.9,XMZ,2,4,0)="Requester       :  "_NAME
 S ^XMB(3.9,XMZ,2,5,0)="Action Date/Time:  "_$P(RTIME,":",1,2)
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_U_LCNT_U_DT,XMDUN="CMOP MANAGER"
 K XMY S XMDUZ=.5
 D GRP^PSXNOTE,ENT1^XMD
FILEB S STAT=$S(SYSFLAG=1:"A",SYSFLAG=0:"I",1:"")
 S:'$D(^PSX(550,+SS,1,0)) ^PSX(550,+SS,1,0)="^550.04DA^^"
 K DD,DO S DA(1)=SS,(DA,X)=TIME,DIC="^PSX(550,"_SS_",1,",DIC(0)="Z"
 S DIC("DR")="1////"_DUZ_$S($G(STAT)="A":";3////P",1:"")_";4////"_$G(STAT)
 D FILE^DICN K DIC("DR"),DIC,DA,X
 K LCNT,NAME,NM,SITE,ST,TIME,RTIME,XMY,XMZ,XMDUN,XMDUZ,XMSUB,DOMAIN
 Q
FILE S FDOM=$O(^DIC(4.2,"B",RDOM,""))
 S REC=$O(^PSX(552,"B",SITENUM,""))
 K DD,DO
 ;Agency Field added for DoD
 I $G(REC)'>0 S DIC(0)="Z",X=SITENUM,DIC("DR")="2////I;4///^S X=RDOM;5////"_$S($G(AGENCY):AGENCY,1:""),DIC="^PSX(552," D
FF .D FILE^DICN K DIC("DR"),DIC,X
 .S RECA=+Y
 .S:'$D(^PSX(552,RECA,1,0)) ^PSX(552,RECA,1,0)="^552.01DA^^"
FC .S DA(1)=RECA,X=RDTTM,DIC(0)="Z",DIC="^PSX(552,"_RECA_",1,",DIC("DR")="1////1;2////"_REQT_";7////P" D FILE^DICN K DIC("DR"),DIC,RECA
 I $G(REC)>0 D
LOCK .L +^PSX(552,REC):600 G:'$T LOCK S DA=REC,DIE="^PSX(552,",DR="2////I;4///^S X=RDOM" D ^DIE L -^PSX(552,REC) K DIE,DA
 .S:'$D(^PSX(552,REC,1,0)) ^PSX(552,REC,1,0)="^552.01DA^^"
 .K DD,DO
 .S DIC(0)="Z",DA(1)=$G(REC),(DA,X)=RDTTM,DIC="^PSX(552,"_REC_",1,"
 .S DIC("DR")=$S(ACTFLAG=1:"1////"_ACTFLAG_";2////"_REQT_";7////A",ACTFLAG=0:"1////2;2////"_REQT_";3////"_RDTTM_";4////"_DUZ_";7////N",1:"")
F .D FILE^DICN K DA,DIC("DR"),DIC,REC,X
 Q
FILEA S REC=$O(^PSX(552,"B",SITENUM,"")) Q:REC=""
 L +^PSX(552,REC):600 G:'$T FILEA S DA=REC,DIE="^PSX(552,",DR="2////"_$S(ACTFLAG=1:"A",ACTFLAG=0:"I",1:0) D ^DIE K DIE,DA,DR
 S XSS=0 F  S XSS=$O(^PSX(552,REC,1,XSS)) Q:XSS'>0  S SUBREC=XSS
 D NOW^%DTC
 S STAT=$S(ACTFLAG=1:"A",ACTFLAG=0:"D",1:"")
LOCK1 S DA(1)=REC,DA=SUBREC,DIE="^PSX(552,"_REC_",1,",DR="3////"_%_";4////"_DUZ_";7////"_STAT D ^DIE L -^PSX(552,REC) K DIE,DA,SUBREC,REC,STAT,%,XSS
 Q
