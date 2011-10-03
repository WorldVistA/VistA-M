PSXDODAC ;BIR/WPB,HTW - DoD Medical Center Activation Routine ;09/09/02 4:00 PM
 ;;2.0;CMOP;**38,45**;11 Apr 97
 ;Reference to ^DIC(4.2  supported by DBIA #1966
 ;This routine reads in the DoD activation request from the file and
 ;formats the data in the same format as the medical center activation
 ;request and calls the VA activation routines for processing
 ;MSH|^~\&|CHCS||VistA||20020103112600||MFN^M01|0124-020031126|P|2.3.1|||AL|AL
 ;MFE|MUP|0124_020031126|20011227153000|0124|CE
 ;ZLF|1|^BUCHANAN^STEVE||
ACT(PATH,FILENM) ;  This entry point is called by DIRECT+1^PSXDODNT
 K ^TMP($J,"PSXACT")
 S OK=0,J=$P(FILENM,"."),SITEID=$P(J,"_"),TRAN=$TR(J,"_","-")
 S GBL="^TMP("_$J_",""PSXACT"",1)"
 S Y=$$FTG^%ZISH(PATH,FILENM,GBL,3)
 I $G(Y)'=1 S ERRTXT(2)="Failure reading file: "_FILENM,ERRTXT(3)="Error occurred at ACT+5^PSXDODAC" G MSG
 S NODE1=$G(^TMP($J,"PSXACT",1)) S:$P(NODE1,"|")'="MSH" OK=1 S:$P(NODE1,"|",10)'=TRAN OK=2
 S NODE2=$G(^TMP($J,"PSXACT",2)) S:$P(NODE2,"|")'="MFE" OK=1 S:$P(NODE2,"|",3)'=TRAN OK=2
 S NODE3=$G(^TMP($J,"PSXACT",3)) S:$P(NODE3,"|")'="ZLF" OK=1
 K TRAN
 I $G(OK)>0 G ERROR
 ;if No errors found then parse the data from the segments and file the request in the CMOP National file and
 ;send the action alert to holders of the PSXCMOPMGR key
 D NOW^%DTC S (RDTTM,RTDTM,Y)=% X ^DD("DD") S RDTM=Y K Y,%
 S (X,RDOM)=^XMB("NETNAME"),DIC="^DIC(4.2,",DIC(0)="BXZ" D ^DIC
 K DIC I $D(DUOUT)!($D(DTOUT))!(X["^") G EXIT
 S SITENUM=$$IEN^XUMF(4,"DMIS",SITEID),SITEN=$$GET1^DIQ(4,SITENUM,.01) K DIC,X,Y
 ;Until the CMOP files are modified to allow strings the number 1 is used as a prefix 
 ;on the DMIS ID which can have leading zero's
 S TYPE=$P(NODE3,"|",2),X=$P(NODE3,"|",3),AGENCY=1_$P(NODE2,"|",5)
 S HLECDE="^",REQT=$$FMNAME^HLFNC(X,HLECDE) K X
 S NAME=$$GET1^DIQ(200,DUZ,.01)
 S CMOP="Leavenworth",OLD="9999999"
 I $G(TYPE)=5!($G(TYPE)=6) S ACTFLAG=0 D FILE^PSXSITE,DEACT G EXIT
 S ACTFLAG=1 D FILE^PSXSITE S MFLAG=0
 S XQSOP="XXXX",XQMSG="ZZZZZ" ; place holders...not used for DOD
 S XQADATA=SITEN_"^"_$G(RDOM)_"^"_CMOP_"^"_REQT_"^"_FILENM_"^"_RTDTM_"^"_SITENUM_"^"_XQSOP_"^"_XQMSG_"^"_NAME_"^"_J,XQAMSG=SITEN_" has submitted a request to activate CMOP processing.",XQAROU="ORK^PSXDODAC",XQAID="PSXDODAC"
 D GRP1^PSXNOTE M XQA=XMY D SETUP^XQALERT
EXIT ;
 Q
 K Y,OK,XQADATA,SITEN,RDOM,CMOP,REQT,RTDTM,SITENUM,XQSOP,XQMSG,SITEN,NAME,XQAMSG,SITEN
 K XQAROU,XQAID,RDTM
 Q
ORK ; Entry point for activation alert processing
 S SITE=$P(XQADATA,U,1),CMOP=$P(XQADATA,U,3),(REQ,REQT)=$P(XQADATA,U,4),FILENM=$P(XQADATA,U,5)
 S RDTTM=$P(XQADATA,U,6),SITENUM=$P(XQADATA,U,7),RDOM=$P(XQADATA,U,2),XMSER="S."_$P(XQADATA,U,8)
 S TXMZ=$P(XQADATA,U,9),NAME=$P(XQADATA,U,10),J=$P(XQADATA,U,11)
 S DIR(0)="SO^A:APPROVED;D:DISAPPROVED",DIR("A",1)=SITE_" has submitted a request to activate CMOP processing.",DIR("A",2)="",DIR("A")="Select"
 D ^DIR K DIR S (ACTION,STAT)=Y G:($D(DIRUT)) EXIT K Y
WK I ACTION="A" S ACTFLAG=1
 I ACTION="D" S ACTFLAG=0
OK S %H=$H D YX^%DTC S DTE=Y K Y
 S ANSWER=($S(ACTION="A":"CMOP Activation Approval",ACTION="D":"CMOP Activation Disapproved",1:"")),LCNT=2
 S XQAKILL=0 D DELETE^XQALERT
 ;File appr/disappr in 552
FILEA S REC=$O(^PSX(552,"B",SITENUM,"")) Q:REC=""
 L +^PSX(552,REC):600 G:'$T FILEA S DA=REC,DIE="^PSX(552,",DR="2////"_$S(ACTFLAG=1:"A",ACTFLAG=0:"I",1:0) D ^DIE K DIE,DA,DR
 S XSS=0 F  S XSS=$O(^PSX(552,REC,1,XSS)) Q:XSS'>0  S SUBREC=XSS
 D NOW^%DTC S OKTIME=$$FMTHL7^XLFDT(%),OKTIME=$P(OKTIME,"-")
 S DA(1)=REC,DA=SUBREC,DIE="^PSX(552,"_REC_",1,",DR="3////"_%_";4////"_DUZ_";7////"_ACTION D ^DIE L -^PSX(552,REC) K DIE,DA,SUBREC,REC,STAT,%,XSS
REPLY ;Make activation reply file
 S NAME=$$GET1^DIQ(200,DUZ,.01),HLECDE=",",REQT=$$FMNAME^HLFNC(NAME,HLECDE) K X
 S FILE=J_".SAC",J=$TR(J,"_","-")
 ;MFR^M01-ACTIVATION,MFR^M02 - Deactivation
 S MSH="MSH|^~\&|VistA||CHCS||"_OKTIME_"||MFR^M01|"_J_"|P|2.3.1|||NE|NE"
 S MFE="MFE|MUP|"_J_"|"_OKTIME_"|"_$P(J,"-")_"|CE"
 I ACTFLAG="DEACTIVATION" S ZLF="ZLF|"_TYPE_"|CMOP-"_$$GET1^DIQ(554,1,.01) I 1 ; set ACK FOR deactivation request
 E  S ZLF="ZLF|"_$S(ACTFLAG=0:4,ACTFLAG=1:3,1:"")_"|"_NAME
 K ^XTMP("PSXAK"_J) S PATH=$$GET1^DIQ(554,1,21)
 S A="PSXAK"_J
 S X=$$FMADD^XLFDT(DT,+2) S ^XTMP(A,0)=X_U_DT_U_"CMOP ACTIVATION RESPONSE" K X
 S ^XTMP(A,J,1)=$G(MSH)
 S ^XTMP(A,J,2)=$G(MFE)
 S ^XTMP(A,J,3)=$G(ZLF)
 F XX=1:1:5 S Y=$$GTF^%ZISH($NA(^XTMP(A,J,1)),3,PATH,FILE) Q:Y=1  H 4
 I Y'=1 S GBL=$NA(^XTMP(A,J)) D FALERT^PSXDODNT(FILE,PATH,GBL)
 S PATH=$$GET1^DIQ(554,1,22)
 F XX=1:1:5 S Y=$$GTF^%ZISH($NA(^XTMP(A,J,1)),3,PATH,FILE) Q:Y=1  H 4
 I Y'=1 S GBL=$NA(^XTMP(A,J)) D FALERT^PSXDODNT(FILE,PATH,GBL)
 I $G(Y)'=1 S ERRTXT(2)="Failure writing to file: "_FILE,ERRTXT(3)="Error occurred at REPLY+10^PSXDODAC" G MSG^PSXDODAC
 K FILE,Y,MSH,MFE,ZLF,PATCH,A,ACTFLAG,NAME,OKTIME,XSS,SUBREC,LCNT,ANSWER,ACTION,J,FILE
 Q
ERROR ;sends the error message back to the sending station
 ;parse the data from the msh segment in order to send back the error message
 ;OK equals 1 - segments not in the correct order
 ;OK equals 2 - segments not assigned to the open file or segments don't match
 ;OK equals 3 - site and file don't match
 D NOW^%DTC S USER=$TR($P(^VA(200,DUZ,0),"^",1),",","^")
 S REJ=$S(OK=1:"SEGMENTS OUT OF SEQUENCE",OK=2:"SEGMENTS AND FILE MIS-MATCH",OK=3:"SITE NUMBER AND FILE NAME MIS-MATCH",1:"")
 S PATH=$$GET1^DIQ(554,1,21)
 ;S PATH=$P($G(^PSX(554,1,"DOD")),"^")
 S ACKDATE=$P($$FMTHL7^XLFDT(%),"-",1)
 S ^TMP($J,"ACTREPLY",1)="MSH|^~\&|VistA||CHCS||"_$G(ACKDATE)_"||MFR^M01|"_$G(J)_"|P|2.3.1|||NE|NE"
 S ^TMP($J,"ACTREPLY",2)="MFE|MUP|"_$G(J)_"|"_$G(ACKDATE)_"|"_$G(SITE)_"|CE"
 S ^TMP($J,"ACTREPLY",3)="ZLF|4|^"_$G(USER)_"||"_$G(REJ)
 S FILEN=$G(J)_".SAC"
 S Y=$$GTF^%ZISH($NA(^TMP($J,"ACTREPLY",1)),2,PATH,FILEN)
 I $G(Y)'=1 S ERRTXT(2)="Failure writing file: "_FILEN,ERRTXT(3)="Error occurred at ERROR+15^PSXDODAC" G MSG
 K:Y=1 %,ACKDATE,USER,SITE,^TMP($J,"ACTREPLY"),FILEN,Y,REJ,OK
 Q
MSG ;send error message
 S XMSUB="DoD CMOP Activation Error",ERRTXT(1)="This error indicates a problem reading or writing to a host file"
MM1 S XMDUZ=.5
 S XMTEXT="ERRTXT("
 D GRP1^PSXNOTE
 D ^XMD
 Q
DEACT ;Conjure Deactivation Msg
 S XMDUZ=.5,XMSUB="CMOP Inactivation Notice, "_SITEN,LCNT=5
 D XMZ^XMA2 G:XMZ<1 DEACT
 S ^XMB(3.9,XMZ,2,1,0)="Notice to Inactivate CMOP Processing."
 S ^XMB(3.9,XMZ,2,2,0)=""
 S ^XMB(3.9,XMZ,2,3,0)="Facility               :  "_SITEN
 S ^XMB(3.9,XMZ,2,4,0)="Notifying Official     :  "_REQT
 S ^XMB(3.9,XMZ,2,5,0)="Notification date/time :  "_$P(RDTM,":",1,2)
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_"^"_LCNT_"^"_DT,XMDUN=NAME
 K XMY S XMDUZ=.5 D GRP^PSXNOTE
 D ENT1^XMD
 D NOW^%DTC S OKTIME=$$FMTHL7^XLFDT(%),OKTIME=$P(OKTIME,"-")
 S FILE=J_".SAC",J=$TR(J,"_","-"),PATH=$$GET1^DIQ(554,1,21)
 S MSH="MSH|^~\&|VistA||CHCS||"_OKTIME_"||MFR^M02|"_J_"|P|2.3.1|||NE|NE"
 S MSA="MSA|CA|"_J_"|"
 K ^TMP($J,"PSXDODAC")
 S ^TMP($J,"PSXDODAC",1)=MSH
 S ^TMP($J,"PSXDODAC",2)=MSA
 F XX=1:1:5 S Y=$$GTF^%ZISH($NA(^TMP($J,"PSXDODAC",1)),3,PATH,FILE) Q:Y=1  H 4
 I Y'=1 S GBL=$NA(^TMP($J,"PSXDODAC")) D FALERT^PSXDODNT(FILE,PATH,GBL)
 S PATH=$$GET1^DIQ(554,1,22)
 F XX=1:1:5 S Y=$$GTF^%ZISH($NA(^TMP($J,"PSXDODAC",1)),3,PATH,FILE) Q:Y=1  H 4
 I Y'=1 S GBL=$NA(^TMP($J,"PSXDODAC")) D FALERT^PSXDODNT(FILE,PATH,GBL)
 I $G(Y)'=1 S ERRTXT(2)="Failure writing to file: "_FILE,ERRTXT(3)="Error occurred at REPLY+10^PSXDODAC" G MSG^PSXDODAC
 Q
