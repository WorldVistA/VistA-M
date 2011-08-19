OOPSNDB ;WISC/LLH-NATIONAL DATABASE ;10/12/99
 ;;2.0;ASISTS;;Jun 03, 2002
 ;
 N ARR,FIELD,FL,MAN,MSG,VAL,RDATE,OOPDA
 S MAN=1
 I '$D(^XUSEC("OOPS XMIT 2162 DATA",DUZ)) D  G EXIT
 . S DIR(0)="FO" W !
 . S DIR("A")="You do NOT have the required Security Key."
 . S DIR("A")=DIR("A")_"  Press Enter to continue"
 . D ^DIR K DIR
 ; Assure the Queue (Q-ASI) has been defined
 S VAL="Q-ASI.MED.VA.GOV",FIELD=.01,FL="X"
 D FIND^DIC(4.2,"",FIELD,FL,VAL,"","","","","ARR")
 I '$D(ARR("DILIST",1)) D  G EXIT
 . S DIR(0)="FO" W !
 . S DIR("A")="Domain not found in the DOMAIN File,"
 . S DIR("A")=DIR("A")_" No Transmission. Press Enter to continue"
 . D ^DIR K DIR
 S DIR(0)="D"
 S DIR("A")="Re-transmit cases for what date "
 S DIR("?",1)="Enter the date of original transmission for cases "
 S DIR("?")="that need to be resent"
 D ^DIR K DIR G:$D(DIRUT) EXIT I Y S RDATE=Y
 S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to Queue Transmission"
 S DIR("?",1)="Enter 'Y' if you want the 2162 data placed in mail"
 S DIR("?")="messages as part of a tasked job."
 D ^DIR K DIR G:$D(DIRUT) EXIT I Y D  G EXIT
 . S ZTRTN="EN^OOPSNDB",ZTIO=""
 . S ZTDESC="TRAMSIT NATIONAL DATABASE 2162 DATA"
 . D ^%ZTLOAD
 S DIR(0)="Y"
 S DIR("A")="Transmission NOT queued, OK to continue"
 D ^DIR K DIR I 'Y G EXIT
 S MSG("DIHELP",1)="Processing" W !
 D MSG^DIALOG("WH","","","","MSG")
EN ; Routine Entry
 N CNT,ERR,ERROR,FAIL,OPMG,OPQ
 K VMSG,INV                     ; used for data validation of records
 S CTR=1                        ; counter for Mail message array
 S (START,END,FAIL)=""
 ; Assure the Queue (Q-ASI) has been defined
 S VAL="Q-ASI.MED.VA.GOV",FIELD=.01,FL="X"
 D FIND^DIC(4.2,"",FIELD,FL,VAL,"","","","","ARR")
 I '$D(ARR("DILIST",1)) D  G EXIT
 . S ERROR(1)="The Queue Q-ASI.MED.VA.GOV has not been created."
 . S ERROR(2)="Install Patch XM*999*130, complete manual "
 . S ERROR(3)="Transmission of NDB Data."
 . D ERROR
 ; Make sure Mail Group Exists
 S OPMG=$$FIND1^DIC(3.8,"","X","OOPS NDB MESSAGES")
 I 'OPMG D  G EXIT
 . S ERROR(1)="The Mail Group OOPS NDB MESSAGES is missing."
 . S ERROR(2)="Add the Group so that ASISTS data can be transmitted "
 . S ERROR(3)="to the AAC.  Then contact IRM to complete manual "
 . S ERROR(4)="Transmission of NDB Data."
 . D ERROR
 ; Get list of members
 D LIST^DIC(3.81,","_OPMG_",","","",1,"","","","","","OPQ")
 I '$P(OPQ("DILIST",0),U) D  G EXIT
 . S ERROR(1)="There are no members of the OOPS NDB MESSAGES "
 . S ERROR(1)=ERROR(1)_"Mail Group."
 . S ERROR(2)="Enter at least one member to the group.  This person "
 . S ERROR(3)="will receive messages concerning the transmission of "
 . S ERROR(4)="ASISTS NDB data to and from the AAC. After adding member"
 . S ERROR(5)="contact IRM to complete manual transmission of NDB data."
 . D ERROR
GETREC ; Loop thru ^OOP(2260 "AN" OR "ANC" Xref to get records to transmit
 ; The logic for this data retrevial was changed for patch 11 to use
 ; the Xrefs vs looping through the entire 2260 file.
 N OOPIEN,PRSCNT,PRSDA,XMDUZ,XMTEXT,XMSUB,XMY,INDEX,INDEX2
 N Y,%,%H,%I
 K ^TMP($J,"C"),^TMP($J,"D")
 S (CNT,PRSCNT,OOPDA)=0
 D NOW^%DTC S DATE=%,Y=DATE X ^DD("DD")
 S MTIME=$P(Y,"@",2),DATE=$$DC^OOPSNDBX(%)
 S OOPIEN=""
 I '$G(MAN) S INDEX="^OOPS(2260,""AN"",OPI)",INDEX2="^OOPS(2260,""AN"",OPI,OOPIEN)"
 E  S INDEX="^OOPS(2260,""ANC"",OPI)",INDEX2="^OOPS(2260,""ANC"",OPI,OOPIEN)"
 S OPI=0 F  S OPI=$O(@INDEX) Q:'OPI  D
 .S OOPIEN=0 F  S OOPIEN=$O(@INDEX2) Q:'OOPIEN  D
 .. I $G(MAN),OPI'=RDATE Q
 .. S VALID=""
 .. F CHK=5:1:7 I '$$GET1^DIQ(2260,OOPIEN,CHK,"I") S:CHK=5 $P(VALID,U)=5 S:CHK=6 $P(VALID,U,2)=6 S:CHK=7 $P(VALID,U,3)=7
 .. I $G(VALID)'="" S ^TMP($J,"D",OOPIEN)=VALID Q
 .. S ^TMP($J,"C",OOPIEN)=""
 .. S CNT=CNT+1
 S ^TMP($J,"C")=CNT
 ; Count # of Non-Separated PAID Employees
 S PRSDA=0 D
 . F  S PRSDA=$O(^PRSPC(PRSDA)) Q:PRSDA'>0  D
 .. I $$GET1^DIQ(450,PRSDA,80,"I")'="Y" S PRSCNT=PRSCNT+1
NOCASES ; No Cases to Send - Send Mail Message with only NDB segment
 I CNT=0 D  G EXIT
 . D CREATE Q:FAIL
 . D SEND
PROCESS ;
 D CREATE G:FAIL EXIT
 ; START - First case number in MM, End - Last Case # in MM
 S OOPDA="",START="",END="",OPAST=""
 F  S OPAST=OOPDA,OOPDA=$O(^TMP($J,"C",OOPDA)) Q:OOPDA=""  D
 . D ^OOPSNDBX
 . ; Set DATE TRANSMITTED TO NDB in ^OOPS(2260 records 
 . I $$GET1^DIQ(2260,OOPDA,57)="" D
 .. K DR S DIE="^OOPS(2260,",(IEN,DA)=OOPDA,DR="57///TODAY" D ^DIE K DR,DA,DIE
 ; If any records left to send and no FAILure
 I ($G(XMZ)'<1)&('FAIL) D
 . I END="" S END=$P($P(^OOPS(2260,OPAST,0),U),"-",2)
 . D SEND
 ;
EXIT ; Quits the program
 D BADREC                      ; Send Mail if any Bad Records
 I $G(FAIL) D
 . S ERROR(1)="Mail Message was not created.  Contact IRM to comlete "
 . S ERROR(2)="the manual transmission of ASISTS NDB data."
 . D ERROR
 K CTR,DATE,ERR,ERROR,GRP,INV,OPL,MSIZE,MTIME,XMSUB,XMTEXT,XMY,MSG
 K ^TMP($J)
 Q
CREATE ; Create MailMan Message
 N OPDATA,SN
 S MSIZE=0
 I $G(XMZ)'<1 D SEND
 S OPL=0
 S XMSUB="ASISTS NATIONAL DATABASE"
 S XMDUZ=DUZ
 D XMZ^XMA2 I XMZ<1 S FAIL=1 Q
 S SN=$$GET1^DIQ(4,$P($G(^XMB(1,1,"XUS")),U,17),99)
 S SN=$E("0000000",$L(SN)+1,7)_SN
 S OPDATA="NDB^OOPS^"_SN_U_DATE_U_MTIME_U_^TMP($J,"C")
 S OPDATA=OPDATA_U_U_PRSCNT_U_"002"_U_"|"     ; chg 001 to 002 as ver 2
 S OPL=OPL+1,^XMB(3.9,XMZ,2,OPL,0)=OPDATA
 Q
SEND ; Send MailMan Message
 N NUMCASE
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_OPL_U_OPL_U_DT
 ; Set # of Cases in this Mail Message
 S NUMCASE=$S(START'="":START_"-"_END,1:0)
 S $P(^XMB(3.9,XMZ,2,1,0),U,7)=NUMCASE
 ; Indicate last line of message
 S OPL=OPL+1,^XMB(3.9,XMZ,2,OPL,0)="$"
 S XMY(DUZ)=""                        ; also send here, in case of error.
 S XMY("XXX@Q-ASI.MED.VA.GOV")=""
 S XMCHAN=1 D ENT1^XMD K XMCHAN
 K XMZ
 Q
BADREC ; If any records with missing data, send mail message
 K MSG
 S CTR=1,OOPDA=0
 F  S OOPDA=$O(^TMP($J,"D",OOPDA)) Q:OOPDA=""  D
 . S VALID=^TMP($J,"D",OOPDA)
 . S MSG(CTR)="Case: "_$$GET1^DIQ(2260,OOPDA,.01)_" has missing data "
 . S MSG(CTR)=MSG(CTR)_"that must be entered prior",CTR=CTR+1
 . S MSG(CTR)="to transmitting to AAC. ",CTR=CTR+1
 . I $P(VALID,U) S MSG(CTR)="  Missing SSN",CTR=CTR+1
 . I $P(VALID,U,2) S MSG(CTR)="  Missing DOB",CTR=CTR+1
 . I $P(VALID,U,3) S MSG(CTR)="  Missing SEX",CTR=CTR+1
 I $D(MSG) D 
 . S XMSUB="ASISTS Records Missing Necessary Data Elements"
 . S XMY("G.OOPS NDB MESSAGES@"_^XMB("NETNAME"))=""
 . S XMTEXT="MSG("
 . D ^XMD
 Q
ERROR ; Create appropriate Error message and Send message
 S XMDUZ="ASISTS Package"
 S GRP="OOPS SAFETY"
 D GRP^OOPSMBUL
 ; If no one in mail group (this should not occur), send to user
 I $D(XMY)<9 S XMY(DUZ)=""
 S XMSUB="ASISTS NDB Error Notification Message"
 S XMTEXT="ERROR("
 D ^XMD
 I '$D(ZTQUEUED) D
 . S MSG("DIHELP",1)="An Error Occurred during Processing, check"
 . S MSG("DIHELP",2)="Mailman Message for details."
 . D MSG^DIALOG("WH","","","","MSG")
 K ERROR
 Q
