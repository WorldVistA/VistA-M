PSXMISC ;BIR/BAB,WPB-Miscellaneous Transmission Utilities ;02 Aug 2001 11:02AM
 ;;2.0;CMOP;**23,27,30,38**;11 Apr 97
 ;Reference to ^DIC(4.2 supported by DBIA #1966
 ;Reference to ^VA(200  supported by DBIA #10060
 ;Reference to File #59 supported by DBIA #1976
TIMER ;
 D NOW^%DTC S XX=$$FMADD^XLFDT(%,0,24,0,0),ZTDESC="CMOP Return Message Timer",ZTDTH=XX,ZTIO="PSX",ZTRTN="TIME^PSXMISC",ZTSAVE("XX")="",ZTSAVE("PSXBAT")="" D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTRTN,%,X
 Q
 ;Called by Taskman to build Acknowledgment not Received Mail message
TIME F XDUZ=0:0 S XDUZ=$O(^XUSEC("PSXCMOPMGR",XDUZ)) Q:XDUZ'>0  S XMY(XDUZ)=""
 S ACKTM=$P($G(^PSX(550.2,PSXBAT,1)),U,1) I ACKTM="" D
 .S PSXDUZ=$P($G(^PSX(550.2,PSXBAT,0)),U,5)
 .S XMDUZ=.5,XMSUB=("CMOP Acknowledgement not Received"),LCNT=3
 .N PSXMMDIV
 .S PSXMMDIV=$$GET1^DIQ(550.2,PSXBAT,2,"I"),PSXMMDIV=$$GET1^DIQ(59,PSXMMDIV,.06)
 .S XMSUB=PSXMMDIV_" "_XMSUB
 .D XMZ^XMA2
 .G:XMZ<1 TIME
 .S ^XMB(3.9,XMZ,2,1,0)="An acknowledgment message for transmission # "_PSXBAT_" has not been"
 .S ^XMB(3.9,XMZ,2,2,0)="received within the specified time.  Please contact the CMOP facility"
 .S ^XMB(3.9,XMZ,2,3,0)="to see if there is a problem."
 .S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_U_LCNT_U_DT,XMDUN="CMOP Manager"
 .S XMDUZ=.5 D ENT1^XMD
 S ZTREQ="@"
 K XMZ,ZMSUB,ACKTM,PSXDUZ,Y,%,LCNT,XMDUN,XMDUZ,XMY
 Q
SERV S XX=$P($G(^PSX(550,+PSXSYS,0)),U,4),DOMAIN=$$GET1^DIQ(4.2,XX,.01)
 D NOW^%DTC S DATE=% S SITE=$P(PSXSYS,U,2),NAME=$$GET1^DIQ(200,DUZ,.01),SITENM=$P(PSXSYS,U,3)
 S ZMSG1="Schedule "_$S($G(PSXCS)=1:"CS ",1:"")_"Auto Transmission"
 S ZMSG2="Unschedule "_$S($G(PSXCS)=1:"CS ",1:"")_"Auto Transmission"
 S XMDUZ=.5,XMSUB=$S(PSXAUTO=1:ZMSG1,PSXAUTO=0:ZMSG2,1:""),LCNT=2
 K ZMSG1,ZMSG2
 D XMZ^XMA2 G:XMZ<1 SERV
 S ^XMB(3.9,XMZ,2,1,0)="$$AUTO^"_PSXAUTO_"^"_PSXDATE_"^"_PSXHOUR_"^"_SITE_"^"_NAME_"^"_SITENM_"^"_THRU
 S ^XMB(3.9,XMZ,2,2,0)="$$ENDAUTO"
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_"^"_LCNT_"^"_DT,XMDUN="CMOP Manager"
 K XMY S XMDUZ=.5,XMY("S.PSXX CMOP SERVER@"_DOMAIN)="" D ENT1^XMD
 K XX,DOMAIN,Y,%,SITE,XMSUB,LCNT,XMZ,XMDUN,XMDUZ,XMY,NAME,SITENM,DATE
 Q
AUTO ;Called by taskman to set/file automatic CMOP transmissions
 S STAT=$P(XMRG,U,2),DATE=$P(XMRG,U,3),HOUR=$P($G(XMRG),U,4),SITE=$P(XMRG,U,5),XMSER="S."_XQSOP,TXMZ=XMZ,ROFF=$P(XMRG,U,6),SITENM=$P(XMRG,U,7),ZTREQ="@"
 ;S X=SITE,DIC="4",DIC(0)="MOZX" S:$D(^PSX(552,"D",X)) X=$E(X,2,99) D ^DIC S SITN=+Y,THRU=$P(XMRG,U,8) K DIC,X,Y ;****DOD L1
 S X=SITE,AGNCY="VASTANUM" S:$D(^PSX(552,"D",X)) X=$E(X,2,99),AGNCY="DMIS" S SITN=$$IEN^XUMF(4,AGNCY,X),THRU=$P(XMRG,U,8) K X,Y,AGNCY ;****DOD L1
 S XX=$O(^PSX(552,"B",SITN,""))
DOD ; entry for DOD and other agency interface to file auto scheduling information
 S STDATE=$$FMTE^XLFDT(DATE,"1")
 K DD,DO
F S:'$D(^PSX(552,XX,1,0)) ^PSX(552,XX,1,0)="^552.01DA^^"
 D NOW^%DTC
 S DA(1)=XX,(DA,X)=%,DIC(0)="Z",DIC="^PSX(552,"_XX_",1,",DIC("DR")="1////"_$S(STAT=1:"3",STAT=0:"4",1:"")_";2////"_ROFF_";3////"_DATE_";5////"_HOUR D FILE^DICN G:$P(Y,U,3)'=1 F K DIC,DA,DA(1),DIC("DR"),X
 I $G(TXMZ) S XMZ=TXMZ D REMSBMSG^XMA1C
MSG S XMDUZ=.5,XMSUB="CMOP "_$S($G(PSXCS)=1:"CS ",1:"")_"Auto-Transmission Schedule, "_SITENM,LCNT=$S(STAT=0:"5",STAT=1:"7",1:"")
 D XMZ^XMA2 G:XMZ<1 MSG
 S ZMSG1="Cancel "_$S($G(PSXCS)=1:"CS ",1:"")_"Auto Transmission Schedule."
 S ZMSG2=$S($G(PSXCS)=1:"CS ",1:"")_"Auto Transmission Schedule."
 S ^XMB(3.9,XMZ,2,1,0)=$S(STAT=0:ZMSG1,STAT=1:ZMSG2,1:"")
 S ^XMB(3.9,XMZ,2,2,0)=""
 S ^XMB(3.9,XMZ,2,3,0)="Facility                       :  "_SITENM
 S ^XMB(3.9,XMZ,2,4,0)="Initiating Official            :  "_ROFF
 S ^XMB(3.9,XMZ,2,5,0)=$S(STAT=0:"Cancellation Date              :  ",STAT=1:"Begin Automatic Transmissions  :  ",1:"")_$P(STDATE,":",1,2)
 K ZMSG1,ZMSG2
 I STAT=1 S ^XMB(3.9,XMZ,2,6,0)="Scheduling Frequency (hours)   :  "_HOUR
 I STAT=1 S ^XMB(3.9,XMZ,2,7,0)="Number of days to transmit thru:  "_$S($G(THRU)'>0:"Current date",1:$G(THRU))
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_U_LCNT_U_DT,XMDUN="CMOP Manager"
 K XMY
 S XMY(DUZ)="" ;****TESTING
 S XMDUZ=.5 D GRP^PSXNOTE,ENT1^XMD  Q
 K STAT,DATE,HOUR,SITE,SITN,XMSER,TXMZ,XMZ,XQSOP,XQMSG,%,XX,SS,ROFF,STDATE,LCNT,SITENM
 Q
