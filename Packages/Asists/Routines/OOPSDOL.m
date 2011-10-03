OOPSDOL ;WIOFO/CAH-ASISTS TRANSMISSION OF CA1/CA2 TO DOL ;3/15/00
 ;;2.0;ASISTS;;Jun 03, 2002
 ;
 N ARR,FIELD,FL,MSG,VAL,XMZ
 S MAN=1
 ;Check for security keys
 I '$D(^XUSEC("OOPS DOL XMIT DATA",DUZ)) D  G EXIT
 .S DIR(0)="FO" W !
 .S DIR("A")="You do not have the required Security Key."
 .S DIR("A")=DIR("A")_" Press Enter to continue"
 .D ^DIR K DIR
 ;Assure the Queue (Q-AST) has been defined
 S VAL="Q-AST.MED.VA.GOV",FIELD=.01,FL="X"
 D FIND^DIC(4.2,"",FIELD,FL,VAL,"","","","","ARR")
 I '$D(ARR("DILIST",1)) D  G EXIT
 .S DIR(0)="FO" W !
 .S DIR("A")="Domain not found in the DOMAIN File,"
 .S DIR("A")=DIR("A")_" No Transmission.  Press Enter to continue"
 .D ^DIR K DIR
 S DIR(0)="D"
 S DIR("A")="Re-transmit cases for what date "
 S DIR("?",1)="Enter the date of original transmission for cases "
 S DIR("?")="that need to be resent"
 D ^DIR K DIR G:$D(DIRUT) EXIT I Y S RDATE=Y
 S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to Queue Transmission"
 S DIR("?",1)="Enter 'Y' if you want the CA1/CA2 data placed in mail"
 S DIR("?")="message as part of a tasked job."
 D ^DIR K DIR G:$D(DIRUT) EXIT I Y D  G EXIT
 .S ZTRTN="EN^OOPSDOL",ZTIO=""
 .S ZTDESC="TRANSMIT DOL CA1/CA2 DATA"
 .D ^%ZTLOAD
 S DIR(0)="Y"
 S DIR("A")="Transmission NOT queued, OK to continue"
 D ^DIR K DIR I 'Y G EXIT
 S MSG("DIHELP",1)="Processing" W !
 D MSG^DIALOG("WH","","","","MSG")
EN ;Routine Entry
 S WOK=1
 N CNT,ERR,ERROR,FAIL,OPMG,OPQ
 K VMSG,INV                     ; used for data validation of records
 S CTR=1                        ; counter for Mail message array
 S (START,END,FAIL)=""
 ; Assure the Queue (Q-AST) has been defined
 S VAL="Q-AST.MED.VA.GOV",FIELD=.01,FL="X"
 D FIND^DIC(4.2,"",FIELD,FL,VAL,"","","","","ARR")
 I '$D(ARR("DILIST",1)) D  G EXIT
 . S ERROR(1)="The Queue Q-AST.MED.VA.GOV has not been created.  Please contact your IRM "
 . S ERROR(2)="Dept. to have Patch XM*999*136 installed; once installed complete manual "
 . S ERROR(3)="transmission of DOL Data."
 . D ERROR2
 ; Make sure Mail Group Exists
 S OPMG=$$FIND1^DIC(3.8,"","X","OOPS WC MESSAGE")
 I 'OPMG D  G EXIT
 . S ERROR(1)="The Mail Group OOPS WC MESSAGE is missing."
 . S ERROR(2)="Add the Group so that ASISTS data can be transmitted "
 . S ERROR(3)="to the AAC.  Then contact Worker Compensation office "
 . S ERROR(4)="to complete manual Transmission of DOL Data."
 . D ERROR
 ; Get list of members
 D LIST^DIC(3.81,","_OPMG_",","","",1,"","","","","","OPQ")
 I '$P(OPQ("DILIST",0),U) D  G EXIT
 . S ERROR(1)="There are no members of the OOPS WC MESSAGE "
 . S ERROR(1)=ERROR(1)_"Mail Group."
 . S ERROR(2)="Enter at least one member to the group.  This person "
 . S ERROR(3)="will receive messages concerning the transmission of "
 . S ERROR(4)="ASISTS DOL data to and from the AAC. After adding member"
 . S ERROR(5)="contact Worker Compensation office to complete manual transmission of DOL data."
 . D ERROR
GETREC ; Loop thru ^OOP(2260 "AW" or "AWC" XRef to get records to transmit
 ; AW=Schedule Transmission
 ; AWC=Manual Transmission
 N OOPDA,SMSG,STA,XMDUZ,XMTEXT,XMSUB,XMY,MDATA,VALID
 N Y,%,%H,%I
 K ^TMP($J,"C"),^TMP($J,"D")
 S (CNT,OOPDA)=0
 D NOW^%DTC S DATE=%,Y=DATE X ^DD("DD")
 S MTIME=$P(Y,"@",2),DATE=$$DC^OOPSUTL3(%)
 I $D(MAN) S INDEX="^OOPS(2260,""AWC"",OPI)",INDEX2="^OOPS(2260,""AWC"",OPI,OOPDA)"
 E  S INDEX="^OOPS(2260,""AW"",OPI)",INDEX2="^OOPS(2260,""AW"",OPI,OOPDA)"
 S OPI=0 F  S OPI=$O(@INDEX) Q:'OPI  D
 .S OOPDA=0 F  S OOPDA=$O(@INDEX2) Q:'OOPDA  D
 .. I $D(MAN),OPI'=RDATE Q
 .. I '$G(MAN),($$GET1^DIQ(2260,OOPDA,66)'="") D  Q
 ... K ^OOPS(2260,"AW",OPI,OOPDA)
 .. I '$$VERIFY^OOPSUTL6(OOPDA) Q            ; verify data not chged 
 .. S VALID=$$VAL^OOPSUTL5(OOPDA)
 .. ; Get Station #, use w/Mail Grp by Station for messages, if there
 .. S STA=$$GET1^DIQ(4,$P(^OOPS(2260,OOPDA,"2162A"),U,9),99,"E")
 .. ; Valid Case
 .. I $G(VALID)'="" S CNT=CNT+1,^TMP($J,"C",OOPDA)="",SMSG(STA,OOPDA)="" Q
 .. ; Invalid Case
 .. S T="" F  S T=$O(NULL(T)) Q:'T  S ^TMP($J,"D",STA,OOPDA,T)=$G(NULL(T))
 S ^TMP($J,"C")=CNT
NOCASES ; No Cases to Send - Send Mail Message with only DOL segment
 I $D(MAN),CNT=0 D  G EXIT
 .S DIR(0)="FO"
 .S DIR("A")="No cases to transmit for requested date"
 .D ^DIR K DIR
 I CNT=0 D  G EXIT
 . S XMDUZ="ASISTS Report on Daily Transmission to the AAC"
 . S GRP="OOPS WC MESSAGE"
 . S XMY("G."_GRP)=""
 . ; If no one in mail group (this should not occur), send to user
 . I $D(XMY)<9 S XMY(DUZ)=""
 . S XMSUB="ASISTS no claims to process"
 . S XMTEXT="MSG("
 . S MSG(1)="There were no claims ready for transmission"
 . S MSG(2)="to the Austin Automation Center when the."
 . S MSG(3)="scheduled task last ran."
 . D ^XMD
 . K MSG
 . Q
PROCESS ;
 D CREATE G:FAIL EXIT
 ; START - First case number in MM, End - Last Case # in MM
 S OOPDA="",START="",END="",OPAST=""
 F  S OPAST=OOPDA,OOPDA=$O(^TMP($J,"C",OOPDA)) Q:OOPDA=""  D
 . D ^OOPSDOLX
 . ; if first send, Set DATE TRANSMITTED TO WCMIS in ^OOPS(2260
 . I $$GET1^DIQ(2260,OOPDA,66)="" D
 .. K DR S DIE="^OOPS(2260,",(IEN,DA)=OOPDA,DR="66///TODAY"
 .. D ^DIE K DR,DA,DIE
 . I $$GET1^DIQ(2260,OOPDA,199,"I")="Y" D WCP^OOPSMBUL(OOPDA,"E")
 ; If any records left to send and no FAILure
 I ($G(XMZ)'<1)&('FAIL) D
 . I END="" S END=$P($P(^OOPS(2260,OPAST,0),U),"-",2)
 . D SEND
EXIT ; Quit the program
 D BADREC              ; Send Mail if any Bad Records
 D SENTMSG             ; Send message to OOPS WCP with sent claims
 I $G(FAIL) D
 .S ERROR(1)="Mail Message was not created.  Contact Worker Compensation office "
 .S ERROR(2)="to complete the transmission of ASISTS DOL data."
 .D ERROR2
 K CTR,DATE,ERR,ERROR,GRP,INV,OPL,MSIZE,MTIME,XMSUB,XMTEXT,XMY,MSG,MAN
 K ^TMP($J),%DT,CATY,D,DO,DATA,DI,DIC,DISYS,DIW,DIWI,DAS,DIWT,DN,DQ
 K END,FL174,FLD,HOUR,I,INDEX,INDEX2,MAX,MIN,OOPSAR,OPAST,OPI,OSHA
 K OSHASC,P,RPOL,START,T,WOK,X,XMDUN,XMY,XMZ,Y,Z,RDATE,IEN,OPHM,CONV
 K COPDT,DIWTC,DIWX,OTIME,REL,SIEN
 Q
CREATE ; Create Mailman Message
 N OPDATA,SN
 S MSIZE=0
 I $G(XMZ)'<1 D SEND
 S OPL=0
 S XMSUB="ASISTS DOL DATA"
 S XMDUZ=DUZ
 D XMZ^XMA2 I XMZ<1 S FAIL=1 Q
 S SN=$$GET1^DIQ(4,$P($G(^XMB(1,1,"XUS")),U,17),99)
 S SN=$E("0000000",$L(SN)+1,7)_SN
 S OPDATA="0DOL^ASISTS^"_SN_U_DATE
 S OPDATA=OPDATA_U_U_"001"_U_"|"
 S OPL=OPL+1,^XMB(3.9,XMZ,2,OPL,0)=OPDATA
 Q
SEND ; Send Mailman Message
 N NUMCASE
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_OPL_U_OPL_U_DT
 ; Set # of Cases in this Mail Message
 S NUMCASE=$S(START'="":START_"-"_END,1:0)
 S $P(^XMB(3.9,XMZ,2,1,0),U,5)=NUMCASE
 ; Indicate last line of message
 S OPL=OPL+1,^XMB(3.9,XMZ,2,OPL,0)="NNNN"_$C(13)_$C(10)
 S XMY(DUZ)=""                        ; also send here, in case of error.
 S XMY("XXX@Q-AST.MED.VA.GOV")=""
 S XMCHAN=1 D ENT1^XMD K XMCHAN
 K XMZ
 Q
BADREC ; If any records with missing data, send mail message
 S OOPDA=0,OPI=0,STA=""
 F  S STA=$O(^TMP($J,"D",STA)) Q:STA=""  K MSG S CTR=1 D
 . F  S OOPDA=$O(^TMP($J,"D",STA,OOPDA)) Q:OOPDA=""  D
 .. S MSG(CTR)="Case: "_$$GET1^DIQ(2260,OOPDA,.01)_" has missing required data or word processing fields that are",CTR=CTR+1
 .. S MSG(CTR)="larger than DOL requirements.  Please edit the case(s); and once completed,",CTR=CTR+1
 .. S MSG(CTR)="the cases will be transmitted with the next scheduled transmission. ",CTR=CTR+1
 .. F  S OPI=$O(^TMP($J,"D",STA,OOPDA,OPI)) Q:OPI=""  D
 ... S MSG(CTR)=" >"_$G(^TMP($J,"D",STA,OOPDA,OPI)),CTR=CTR+1
 .. S MSG(CTR)=$C(10),CTR=CTR+1
 . I $D(MSG) D
 .. S XMSUB="ASISTS Record(s) not transmitted for Station "_STA
 .. S GRP="OOPS WCP"
 .. I $$FIND1^DIC(3.8,"","AMX",GRP_" - "_STA) S GRP=GRP_" - "_STA
 .. S XMY("G."_GRP)=""
 .. S XMTEXT="MSG("
 .. D ^XMD
 Q
SENTMSG ; Send message to OOPS WCP mail group with claims sent to AAC
 N CNT,MSG,STA,STR,OOPDA
 S (STA,OOPDA)=""
 F  S STA=$O(SMSG(STA)) Q:STA=""  K MSG S CNT=1 D
 . S MSG(CNT)="The following claims have been transmitted to the AAC:"
 . S CNT=CNT+1
 . F  S OOPDA=$O(SMSG(STA,OOPDA)) Q:OOPDA=""  D
 .. S STR=^OOPS(2260,OOPDA,0)
 .. S MSG(CNT)="> "_$P(STR,U)_"     "_$P(STR,U,2),CNT=CNT+1
 . S XMSUB="ASISTS Record(s) transmitted to AAC for Station "_STA
 . S GRP="OOPS WCP"
 . I $$FIND1^DIC(3.8,"","AMX",GRP_" - "_STA) S GRP=GRP_" - "_STA
 . S XMY("G."_GRP)=""
 . S XMTEXT="MSG("
 . D ^XMD
 Q
ERROR ; Create appropriate Error message and Send message
 S XMDUZ="ASISTS Package"
 ; If no one in mail group (this should not occur), send to user
 I $D(XMY)<9 S XMY(DUZ)=""
 S XMSUB="ASISTS DOL Error Notification Message"
 S XMTEXT="ERROR("
 D ^XMD
 I '$D(ZTQUEUED) D
 . S MSG("DIHELP",1)="An Error Occurred during Processing, check"
 . S MSG("DIHELP",2)="Mailman Message for details."
 . D MSG^DIALOG("WH","","","","MSG")
 K ERROR
 Q
ERROR2 ; Create appropriate Error message and Send message
 S XMDUZ="ASISTS Package"
 S GRP="OOPS WC MESSAGE"
 D GRP^OOPSMBUL
 ; If no one in mail group (this should not occur), send to user
 I $D(XMY)<9 S XMY(DUZ)=""
 S XMSUB="ASISTS DOL Error Notification Message"
 S XMTEXT="ERROR("
 D ^XMD
 I '$D(ZTQUEUED) D
 . S MSG("DIHELP",1)="An Error Occurred during Processing, check"
 . S MSG("DIHELP",2)="Mailman Message for details."
 . D MSG^DIALOG("WH","","","","MSG")
 K ERROR
 Q
