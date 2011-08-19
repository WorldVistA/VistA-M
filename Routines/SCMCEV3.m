SCMCEV3 ;ALB/CMM - TEAM EVENT DRIVER UTILITIES ; 03/20/96
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;
INVOKE(DFN) ;envokes Team Event Driver
 I '$D(^TMP($J,"SC CED",DFN,"BEFORE"))!('$D(^TMP($J,"SC CED",DFN,"AFTER"))) G EXIT
 S X=+$O(^ORD(101,"B","SC CLINIC ENROLL/DISCHARGE EVENT DRIVER",0))_";ORD(101,"
 D EN^XQOR
EXIT ;
 K ^TMP($J,"SC CED",DFN,"BEFORE"),^TMP($J,"SC CED",DFN,"AFTER"),X
 Q
 ;
BEFORE(DFN) ;
 ;get before picture of ^DPT(DFN,"DE") node
 ;
 K ^TMP($J,"SC CED",DFN,"BEFORE")
 MERGE ^TMP($J,"SC CED",DFN,"BEFORE")=^DPT(DFN,"DE")
 I '$D(^TMP($J,"SC CED",DFN,"BEFORE")) S ^TMP($J,"SC CED",DFN,"BEFORE")=""
 ; ^ not enrolled in any clinics ever
 Q
 ;
AFTER(DFN) ;
 ;get after picture of ^DPT(DFN,"DE") node
 ;
 K ^TMP($J,"SC CED",DFN,"AFTER")
 MERGE ^TMP($J,"SC CED",DFN,"AFTER")=^DPT(DFN,"DE")
 Q
 ;
COMPARE(DFN) ;team event driver
 ;compare before and after of DFN's "DE" node
 N NXT,SUB1,SUB2,NEW,CLN,ENT
 S (NXT,SUB1,SUB2)=0
 I '$D(^TMP($J,"SC CED",DFN,"AFTER")) G DELS
 F  S NXT=$O(^TMP($J,"SC CED",DFN,"AFTER",NXT)) Q:NXT=""!(NXT'?.N)  D
 .S NEW=0
 .;check clinic added
 .I '$D(^TMP($J,"SC CED",DFN,"BEFORE",NXT,0)) D NEWC(DFN,NXT) S NEW=1
 .Q:NEW
 .S SUB1=0
 .;change to existing entry
 .F  S SUB1=$O(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1)) Q:SUB1=""!(SUB1'?.N)  D
 ..S SUB2=0
 ..F  S SUB2=$O(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1,SUB2)) Q:SUB2=""!(SUB2'?.N)  D
 ...I $G(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1,SUB2,0))'=$G(^TMP($J,"SC CED",DFN,"BEFORE",NXT,SUB1,SUB2,0)) D CHNG(DFN,NXT,SUB1,SUB2)
 ;
DELS ;look for deletes
 S CLN=""
 F  S CLN=$O(^TMP($J,"SC CED",DFN,"BEFORE","B",CLN)) Q:CLN=""  D
 .S ENT=$O(^TMP($J,"SC CED",DFN,"BEFORE","B",CLN,""))
 .Q:ENT=""
 .I '$D(^TMP($J,"SC CED",DFN,"AFTER","B",CLN,ENT)) D DELT^SCMCEV1(DFN,CLN)
 Q
 ;
CHNG(DFN,NXT,SUB1,SUB2) ;
 ;changes made in entry SUB2 of SUB1 entry of entry NXT of "DE" node
 N FLAG,EDATE,GDATE,CIEN,CHECK,ENROL,CNAME
 S (ENROL,FLAG,GDATE)=0
 I $P($G(^TMP($J,"SC CED",DFN,"BEFORE",NXT,SUB1,SUB2,0)),"^")'=$P($G(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1,SUB2,0)),"^") S EDATE=$P($G(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1,SUB2,0)),"^"),FLAG=1,ENROL=1,EDATE=$P(EDATE,".")
 ;                                            ^ date only
 ;enroll date changed
 I $P($G(^TMP($J,"SC CED",DFN,"BEFORE",NXT,SUB1,SUB2,0)),"^",3)'=$P($G(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1,SUB2,0)),"^",3) S GDATE=$P($G(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1,SUB2,0)),"^",3),FLAG=1,ENROL=$S(ENROL=1:3,1:2),GDATE=$P(GDATE,".")
 ; ^ date only
 ;discharge date changed/added
 S CHECK=""
 S CIEN=+$P($G(^TMP($J,"SC CED",DFN,"AFTER",NXT,0)),"^") ;clinic ien
 S CNAME=$P($G(^SC(CIEN,0)),"^") ;clinic name
 I $D(EDATE),EDATE=""!(EDATE=0) D DELT^SCMCEV1(DFN,CIEN) Q
 ; ^ deleted enrollment date
 I $D(GDATE),'$D(EDATE) S EDATE=$P($G(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1,SUB2,0)),"^"),EDATE=$P(EDATE,".") ;date only
 I $D(GDATE),EDATE=GDATE D DELT^SCMCEV1(DFN,CIEN) Q
 ; ^ enrolled and discharged on same date
 I GDATE'="",ENROL=1 S ENROL=3
 I GDATE'="",ENROL=1 S ENROL=2
 ;enrol = 1:enrollment ; 2=discharge ; 3=both
 I FLAG S CHECK=$$CHK^SCMCEV2(DFN,CIEN,ENROL)
 ;update 404.42?
 I +CHECK D UPDATE^SCMCEV1(DFN,$P(CHECK,"^",2),EDATE,GDATE,CNAME)
 Q
 ;
NEWC(DFN,NXT) ;
 ;new clinic added (enrolled)
 ;DFN - patient ien
 ;NXT - ien of "DE" node
 ;
 N CIEN,NODE,CHKIT,SUB1,EDATE,GDATE,FLG,CNAME,SCRESTA,SCREST
 S NODE=$G(^TMP($J,"SC CED",DFN,"AFTER",NXT,0))
 Q:NODE=""
 S CIEN=$P(NODE,"^") ;clinic ien
 S CNAME=$P($G(^SC(+CIEN,0)),"^") ;clinic name
 S SUB1=$O(^TMP($J,"SC CED",DFN,"AFTER",NXT,0))
 S SUB2=$O(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1,"A"),-1)
 S EDATE=$P($G(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1,SUB2,0)),"^"),FLG=1
 S EDATE=$P(EDATE,".") ;date only
 S GDATE=$P($G(^TMP($J,"SC CED",DFN,"AFTER",NXT,SUB1,SUB2,0)),"^",3)
 S GDATE=$P(GDATE,".") ;date only
 I GDATE'="" S FLG=3
 ;  -- This fires off MailMessage for new assignment to Clinic
 S SCREST=$$RESTPT^SCAPMCU4(DFN,DT,"SCRESTA")
 D:SCREST MAIL^SCMCCON(DFN,.CNAME,1,EDATE,"SCRESTA")
 ;  ---  ----
 S CHKIT=$$CHK^SCMCEV2(DFN,CIEN,FLG)
 I +CHKIT D ENROLL^SCMCEV1(DFN,$P(CHKIT,"^",2),EDATE,GDATE,CNAME)
 Q
 ;
