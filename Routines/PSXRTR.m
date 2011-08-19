PSXRTR ;BIR/BAB,WPB,PWC-Transmit Data to CMOP Host System ;14 Dec 2001
 ;;2.0;CMOP;**18,23,27,31,28,41,51**;11 Apr 97
 ;Reference to ^DIC(4.2 supported by DBIA #1966
 ;Reference to ^PS(59   supported by DBIA #1976
 ;Reference to File #200 supported by DBIA #10060
 ;Requires PSXHDR,PSXORD (A B C D) arrays
 Q
EN ;Entry point for data transmission, load mailman message and send
 S PSXJOB=1,PSXRTRN=0 K ERR
 I $E(IOST)="C" W !,"EN^PSXRTR DIV: ",PSOSITE," ",+$G(PSXBAT)
 I (($G(PSXBAT)="")!('$D(^PSX(550.1,"C",PSXBAT)))) G EXIT
 S (PSXMSG,PSXMFLAG,PSXEND,PSXSTART)=0
 F  S PSXMSG=$O(^PSX(550.1,"C",PSXBAT,PSXMSG)) Q:PSXMSG'>0  S PSXEND=PSXMSG S:PSXSTART=0 PSXSTART=PSXMSG
 S PSXSITE=$P($G(PSXSYS),U,3),PSXSENDR=$$GET1^DIQ(200,DUZ,.01),SITENUM=$P($G(PSXSYS),U,2),PSXDIV=$P($G(^PS(59,+PSOSITE,0)),U,1),XSITE=$P($G(^PS(59,+PSOSITE,0)),U,6)
 S PSXHDR=PSXSITE_U_+PSXSYS_U_SITENUM_U_PSXTDT_U_PSXSENDR_U_PSXSTART_U_PSXEND_U_PSXDIV_U_XSITE,PSXREF=SITENUM_"-"_$$GET1^DIQ(550.2,PSXBAT,.01)
 N DOMAIN,LCNT,XMDUZ,XMSUB,XMZ,ORD
 S (LCNT,PSXMSGCT,PSXRXCT)=0
 S X=$$KSP^XUPARAM("INST"),DIC="4",DIC(0)="XMZO" D ^DIC S SITEX=$P(Y,"^",2) K DIC,X,Y
 S XMSUB="CMOP"_$S($G(PSXCS)=1:" Controlled Substances",1:"")_" Transmission from "_SITEX,XMDUZ=.5
XMZ D XMZ^XMA2
 I XMZ'>0 G XMZ
 K SITEX
HDR ;Gather data from header, load NTE1 - NTE5 into mailmessage from PSXORD( array
 S ORD="$$XMIT"_U_$$GET1^DIQ(550.2,PSXBAT,.01)_U_PSXHDR D TXT
 S ORD=$G(PSXORD("A")) D TXT
 ;If not any data in the refill/nonrefill/copay instructions set 
 ;set array equal to NTE...+3 spaces
 S:$G(PSXORD("B",1))="" PSXORD("B",1)="NTE|2||   "
 S:$G(PSXORD("C",1))="" PSXORD("C",1)="NTE|3||   "
 S:$G(PSXORD("D",1))="" PSXORD("D",1)="NTE|4||   "
 F ZZ="B","C","D" S Z=0 F  S Z=$O(PSXORD(ZZ,Z)) Q:Z'>0  S ORD=$G(PSXORD(ZZ,Z)) D TXT
 ;Gather data for individual patient orders
LOCK ;
 D NOW^%DTC S DTTM=%,(MSG,ZCNT)=0
 ; load patients' 550.1 "T" nodes into the mail message
 F  S MSG=$O(^PSX(550.1,"C",PSXBAT,MSG)) Q:MSG=""  S PSXMSGCT=PSXMSGCT+1,LNTX=+$P(^PSX(550.1,MSG,"T",0),U,4) D
 .S ORD="$MSG^"_+$G(^PSX(550.1,MSG,0))_U_LNTX D TXT
 .F PSX=1:1:LNTX I $G(^PSX(550.1,MSG,"T",PSX,0))]"" S ORD=$G(^(0)) S:$E(ORD,1,7)="ORC|NW|" PSXRXCT=PSXRXCT+1 D TXT
 .K DA,DIE,DR S DA=MSG L +^PSX(550.1,DA)
 .S DIE="^PSX(550.1,",DR="1///2;5////"_DTTM_";3////"_PSXBAT
 .D ^DIE L -^PSX(550.1,DA) K DA,DIE,DR ;update msgs in 550.1
 S ORD="$$ENDXMIT^"_U_PSXFAC_U_PSXBAT_U_PSXMSGCT_U_PSXRXCT D TXT K ORD
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_U_LCNT_U_DT,XMDUN="CMOP Manager"
 S XMDUZ=.5
 S RECV=$P($G(^PSX(550,+PSXSYS,0)),U,4),DOMAIN="@"_$$GET1^DIQ(4.2,RECV,.01)
 ;code to divert patient transmissions for testing
 I '$D(^XTMP("PSXDIVERTCMOP")) S XMY("S.PSXX CMOP SERVER"_DOMAIN)="" I 1 ;****TESTING
 E  S XX=^XTMP("PSXDIVERTCMOP",1) S XMY(XX)="" H 1 ;****TESTING S.PSXX
 D ENT1^XMD
 D XMIT
 S PSXFLAG=1 D EN^PSXNOTE
 K DIE,DA,DR,BAT,PSX,PSXORD,MSG,LNTX,LCNT,DOMAIN,RECV,SITENUM,Z,ZZ,XMDUN,XMDUZ,XMSUB,XMY,XMZ,PSXDIV,XSITE
 Q
XMIT ;Update 550.2 # of ORDs, RXs; rxS IN 52, 52.5: 550.2 to Transmitted
 ;Update 550 with batch
 N PSXTRDTM D NOW^%DTC S PSXTRDTM=%
 L +^PSX(550.2,PSXBAT):600 I '$T S XQAMSG="CMOP Transmission file in use. Entry for trans "_PSXBAT_" not complete. Contact IRM." D GRP1^PSXNOTE,SETUP^XQALERT K XQAMSG,XQA Q
 S DA=PSXBAT,DIE="^PSX(550.2,",DR="1////2;11////"_PSXSTART_";12////"_PSXEND_";13////"_PSXMSGCT_";14////"_PSXRXCT_";5////"_PSXTRDTM
 D ^DIE K DA,DIE,DR
 L -^PSX(550.2,PSXBAT)
 S PSXMFLAG=1
 D ^PSXRXU ; update RXs in 52 52.5
 L +^PSX(550,+PSXSYS):600 Q:'$T
 S DA=+PSXSYS,DIE="^PSX(550,",DR="6////"_PSXBAT D ^DIE K DIE,DA,DR
 L -^PSX(550,+PSXSYS)
 Q
TXT ;
 I $G(ORD)]"" S LCNT=LCNT+1,^XMB(3.9,XMZ,2,LCNT,0)=ORD
 Q
EXIT K %,ERROR,PSXRTRN,PSXJOB,PSXER,PSXHDR,PSXFAC,PSXBAT,PSXEND,PSXMFLAG,PSXMSG,PSXMSGCT,PSXRXCT,PSXSENDR,PSXSITE,PSXTDT,N Q
 Q
DIVERT ; divert transmissions from CMOP to the user evoking the divert
 W !,"This will divert CMOP Patient transmissions to the user evoking the divert",!,"for one day or until 'D RESET^PSXRTR' is executed.",!
 K DIR S DIR(0)="YO",DIR("B")="N" D ^DIR
 I 'Y W !,"CMOP Patient transmissions >>NOT DIVERTED<<",! Q
 S ^XTMP("PSXDIVERTCMOP",0)=DT_U_DT_U_"Divert CMOP Transmissions"
 S ^XTMP("PSXDIVERTCMOP",1)=DUZ
 W !!,"CMOP Patient transmissions >>DIVERTED<< to ",$$GET1^DIQ(200,DUZ,.01),!!,"Use 'D RESET^PSXRTR' to restore normal CMOP Patient transmissions.",!
 K DIR S DIR(0)="E",DIR("A")="<CR> Continue" D ^DIR
 Q
RESET ; reset normal CMOP Patient transmissions
 S XX=$D(^XTMP("PSXDIVERTCMOP"))
 S N=$S(XX>0:"HAD BEEN",1:"HAD NOT BEEN")
 W !,"CMOP Patient transmissions >>",N,"<< diverted"
 I XX S XX=^XTMP("PSXDIVERTCMOP",1) W " to ",$$GET1^DIQ(200,XX,.01)
 W ".",!,"CMOP Patient transmissions are set to go to the CMOP.",!
 K ^XTMP("PSXDIVERTCMOP")
 Q
