PSXACT ;BIR/WPB/HTW-Activate/Inactive Processing by Host ;02 Aug 2001  11:02AM
 ;;2.0;CMOP;**1,24,27,38**;11 Apr 97
 ;Reference to File #200 supported by DBIA 10060 
EXIT S XMZ=$G(TXMZ),XMSER="S.PSXX CMOP SERVER" D:$G(XMZ)>0 REMSBMSG^XMA1C S ZTREQ="@"
 K %H,Y,DTE,SITE,RTNDOM,CMOP,REQ,XMSUB,XMZ,XMRG,LCNT,XMDUZ,XMDUN,XQA,XQAMSG,XQAROU,RDOM,RDTTM,TXMZ,XMFROM,XMRG,XMSER,XMY,XMZ,XQMSG,XQSOP,ACTFLAG,ACTION,%,DIRUT,MFLAG,OLD,RDTM,REQT,SITEN,SITENUM,XQADATA,XQAID,XQAKILL,RT
 Q
EN ;called by taskman to activate a medical center at the cmop facility
 D NOW^%DTC S RDTTM=% K %
 S NOACT=0,SITE=$P(XMRG,U,2),CMOP=$P(XMRG,U,4),OLD=$P(XMRG,U,3),SITEN=$P(XMRG,U,5),TXMZ=XMZ,ZTREQ="@"
 S X=SITEN,AGNCY="VASTANUM" S:$D(^PSX(552,"D",X)) X=$E(X,2,99),AGNCY="DMIS" S SITENUM=$$IEN^XUMF(4,AGNCY,X) K X,AGNCY ;****DOD L1
 I $G(XMFROM)["@" S RDOM=$P($G(XMFROM),"@",2),REQ=$P($G(XMFROM),"@",1)
 S:$G(XMFROM)'["@" REQ=XMFROM,RDOM="BAB.ISC-BIRM.VA.GOV"
 S RT=$P(XMRG,"^",6),REQT=$P(RT,",",2)_" "_$P(RT,",",1)
 S NAME=$$GET1^DIQ(200,DUZ,.01)
 G:$G(SITENUM)'>0 NOACT
 S ACTFLAG=1 D FILE^PSXSITE S MFLAG=0
 S XMDUZ=.5,XMSUB="CMOP Activation Request, "_SITE,LCNT=5
 D XMZ^XMA2 G:XMZ<1 EN
MMSG D NOW^%DTC S RTDTM=% S Y=RTDTM X ^DD("DD") S RDTM=Y K Y,%
 S ^XMB(3.9,XMZ,2,1,0)="Request to activate CMOP processing."
 S ^XMB(3.9,XMZ,2,2,0)=""
 S ^XMB(3.9,XMZ,2,3,0)="Facility         :  "_SITE
 S ^XMB(3.9,XMZ,2,4,0)="Requester        :  "_REQT
 S ^XMB(3.9,XMZ,2,5,0)="Request date/time:  "_$P(RDTM,":",1,2)
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_"^"_LCNT_"^"_DT,XMDUN=NAME
 K XMY S XMDUZ=.5 D GRP^PSXNOTE
 D ENT1^XMD
 I MFLAG=1 Q
 S XQADATA=SITE_"^"_$G(RDOM)_"^"_CMOP_"^"_REQT_"^"_OLD_"^"_RTDTM_"^"_SITENUM_"^"_XQSOP_"^"_XQMSG_"^"_SITEN,XQAMSG=SITE_" has submitted a request to activate CMOP processing.",XQAROU="ACT^PSXACT",XQAID="PSXACT"
 D GRP1^PSXNOTE M XQA=XMY D SETUP^XQALERT
 G EXIT
 Q
ACT S SITE=$P(XQADATA,U,1),CMOP=$P(XQADATA,U,3),(REQ,REQT)=$P(XQADATA,U,4),OLD=$P(XQADATA,U,5),RDTTM=$P(XQADATA,U,6),SITENUM=$P(XQADATA,U,7),RDOM=$P(XQADATA,U,2),XMSER="S."_$P(XQADATA,U,8),TXMZ=$P(XQADATA,U,9),SITEN=$P(XQADATA,U,10)
 S NAME=$$GET1^DIQ(200,DUZ,.01)
 D WORK
 S XQAKILL=0 D DELETE^XQALERT
 Q
WORK W !!
 S DIR(0)="SO^A:APPROVED;D:DISAPPROVED",DIR("A",1)=SITE_" has submitted a request to activate CMOP processing.",DIR("A",2)="",DIR("A")="Select"
 D ^DIR K DIR S ACTION=Y G:($D(DIRUT)) EXIT K Y
WK S:ACTION="A" ACTFLAG=1
 S:ACTION="D" ACTFLAG=0
OK S %H=$H D YX^%DTC S DTE=Y K Y
 S XMSUB=($S(ACTION="A":"CMOP Activation Approval",ACTION="D":"CMOP Activation Disapproved",1:"")),LCNT=2
 S XMDUZ=.5 D XMZ^XMA2 G:XMZ<1 OK
 D NOW^%DTC
 S NAME=$$GET1^DIQ(200,DUZ,.01)
 S ^XMB(3.9,XMZ,2,1,0)="$$SYS^"_$S(ACTFLAG=1:"A",ACTFLAG=0:"I",1:"")_"^"_CMOP_"^"_%_"^"_NAME_"^"_OLD
 S ^XMB(3.9,XMZ,2,2,0)="$$ENDSYS"
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_U_LCNT_U_DT,XMDUN=NAME
 K XMY S XMDUZ=.5,XMY($S($G(RDOM)["BAB.":"S.PSXX CMOP SERVER",$G(RDOM)'="":"S.PSXX CMOP SERVER@"_RDOM,1:""))=""
 K % D ENT1^XMD
MSG S XMSUB=($S(ACTFLAG=1:"CMOP Activation Approval",ACTFLAG=0:"CMOP Activation Disapproved",1:"")),LCNT=6
 S XMDUZ=.5 D XMZ^XMA2 G:XMZ<1 MSG
 S NAME=$$GET1^DIQ(200,DUZ,.01)
 S ^XMB(3.9,XMZ,2,6,0)="Action taken     :  "_$S(ACTFLAG=1:"Approved",ACTFLAG=0:"Disapproved",1:"")
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT+1_U_LCNT+1_U_DT,XMDUN=NAME
 S MFLAG=1 D MMSG
 Q:$G(NOACT)=1
 D FILEA^PSXSITE
 Q
 ;Called by Taskman to Deactivate a Remote facility from CMOP
DEACT S ACTFLAG=0
 D NOW^%DTC S (Y,RDTTM)=% X ^DD("DD") S RDTM=Y K Y
 S SITE=$P(XMRG,U,2),OLD=$P(XMRG,U,3),CMOP=$P(XMRG,U,4),SITEN=$P(XMRG,U,5),XMSER="S."_XQSOP,TXMZ=XQMSG
 ;S DIC="4",DIC(0)="OXMZ",X=SITEN S:$D(^PSX(552,"D",X)) X=$E(X,2,99) D ^DIC S SITENUM=+Y K DIC,X,Y ;****DOD L1
 S X=SITEN,AGNCY="VASTANUM" S:$D(^PSX(552,"D",X)) X=$E(X,2,99),AGNCY="DMIS" S SITENUM=$$IEN^XUMF(4,AGNCY,X) K X,AGNCY ;****DOD L1
 I $G(XMFROM)["@" S RDOM=$P($G(XMFROM),"@",2),REQ=$P($G(XMFROM),"@",1)
 S:$G(XMFROM)'["@" REQ=XMFROM,RDOM="BAB.ISC-BIRM.VA.GOV"
 S RT=$P(XMRG,"^",6),REQT=$P(RT,",",2)_" "_$P(RT,",",1)
 S NAME=$$GET1^DIQ(200,DUZ,.01)
 D FILE^PSXSITE
 S XMDUZ=.5,XMSUB="CMOP Inactivation Notice, "_SITE,LCNT=5
DXMZ D XMZ^XMA2 G:XMZ<1 DXMZ
 S ^XMB(3.9,XMZ,2,1,0)="Notice to Inactivate CMOP Processing."
 S ^XMB(3.9,XMZ,2,2,0)=""
 S ^XMB(3.9,XMZ,2,3,0)="Facility               :  "_SITE
 S ^XMB(3.9,XMZ,2,4,0)="Notifying Official     :  "_REQT
 S ^XMB(3.9,XMZ,2,5,0)="Notification date/time :  "_$P(RDTM,":",1,2)
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_"^"_LCNT_"^"_DT,XMDUN=NAME
 K XMY S XMDUZ=.5 D GRP^PSXNOTE
 D ENT1^XMD
 S XMDUZ=.5,XMSUB=("CMOP Inactivation Notice"),LCNT=1
RXMZ D XMZ^XMA2 G:XMZ<1 RXMZ
 S ^XMB(3.9,XMZ,2,1,0)="$$SYS^"_"D"_"^"_CMOP_"^"_$G(RDTTM)_"^"_NAME_"^"_OLD
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_"^"_LCNT_"^"_DT,XMDUN=NAME
 K XMY,% S XMDUZ=.5,XMY($S($G(RDOM)="":"S.PSXX CMOP SERVER",$G(RDOM)'="":"S.PSXX CMOP SERVER@"_RDOM,1:""))=""
 D ENT1^XMD
 D GRP^PSXNOTE
 S XQAMSG=SITE_" has inactivated CMOP processing." D GRP1^PSXNOTE M XQA=XMY D SETUP^XQALERT
 G EXIT
NOACT N XQA,XQAMSG
 S XQAFLG="D",ACTION="D",NOACT=1
 S XQAMSG=SITE_" Activation disapproved, bad entry in Institution File." D GRP^PSXNOTE D GRP1^PSXNOTE M XQA=XMY D SETUP^XQALERT,WK
 N XMZ S XMSUB="CMOP Activation Request Disapproved",XMDUN="CMOP Manager",XMDUZ=.5
NOMSG D XMZ^XMA2 G:XMZ<1 NOMSG
 S ^XMB(3.9,XMZ,2,1,0)=SITE_" Requested to activate, but was denied."
 S ^XMB(3.9,XMZ,2,2,0)="The request was disapproved because there are multiple entries"
 S ^XMB(3.9,XMZ,2,3,0)="in the Institution file with the same Station Number or"
 S ^XMB(3.9,XMZ,2,4,0)="there wasn't an entry in the Institution file for the Station Number."
 S ^XMB(3.9,XMZ,2,5,0)=""
 S ^XMB(3.9,XMZ,2,6,0)="Please check the Institution file for "_$G(SITE)_"."
 S ^XMB(3.9,XMZ,2,7,0)="Station Numbers are unique. There should only be one entry in the file for"
 S ^XMB(3.9,XMZ,2,8,0)="a station number."
 S ^XMB(3.9,XMZ,2,0)="^3.92A^8^8^"_DT
 K XMY D GRP^PSXNOTE D ENT1^XMD
 K XMY,XMZ,XMSUB
 G EXIT
