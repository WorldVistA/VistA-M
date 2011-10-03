IVMCQ ;ALB/KCL/AEG/GAH - API FOR FINANCIAL QUERIES ; 28-N0V-06
 ;;2.0;INCOME VERIFICATION MATCH;**17,30,55,120**;21-OCT-94;Build 8
 ;
 ;
OPT ; Entry point for stand-alone financial query option.
 ;
 N IVMQUIT
 W !!,"This option allows queries to be sent to the Health Eligibility"
 W !,"Center (HEC) for patients that require updated income information."
 S IVMQUIT=0 F  D EACH1 Q:IVMQUIT
 Q
 ;
EACH1 ; Description: Used to send a financial query for each patient selected. from stand-alone option.
 ;
 N DFN,IVMERROR,IVMOK,IVMOUT,IVMQUE,IVMREPLY,Y
 S DIC="^DPT(",DIC(0)="AEMQ"
 W ! D ^DIC K DIC S DFN=+Y I Y<1 S IVMQUIT=1 G EACH1Q
 ;
 ; does patient need a financial query?
 I '$$NEED(DFN,1,.IVMERROR) W !!,"A financial query can not be sent for this patient!" W !,IVMERROR G EACH1Q
 ;
 ; ask if okay to send query?
 I '$$ASK(.IVMOK)!($G(IVMOK)) G EACH1Q
 ;
 ; notify when a reply to query is received?
 S IVMREPLY=$$NOTIFY(.IVMOUT)
 I $G(IVMOUT) G EACH1Q
 ;
 ; send query for patient, else write error
 I $$QUERY^IVMCQ1(DFN,$G(DUZ),$G(IVMREPLY),$G(XQY),.IVMERROR,1) W !!,"Financial query sent ..."
 E  D
 .W !!,"Failure to send query: ",IVMERROR
 ;
EACH1Q Q
 ;
 ;
REG(DFN) ; Entry point to automatically send a query to HEC for updated financial information.
 ;
 ;   This entry point is called from hooks in registration: 
 ;      - Register a Patient option (DGREG)
 ;      - Load/Edit Patient Data option (DG10)
 ;
 ;  Input:
 ;   DFN - IEN of patient record in PATIENT file
 ;
 ; Output: none
 ;
 I '$G(DFN) G REGQ
 I '$$NEED(DFN) G REGQ
 I $$QUERY^IVMCQ1(DFN,$G(DUZ),0,$G(XQY),,1) W !!,"Financial query sent ..."
REGQ Q
 ;
 ;
APPT ; Entry point for IVM SEND FINANCIAL QUERY protocol.
 ;
 ;  Input:
 ;   SDAMEVT - IEN of record in APPOINTMENT TRANSACTION TYPE file.
 ;             (Transaction type that can occur against an appointment)
 ;     SDATA - Array passed from the [SDAM APPOINTMENT EVENTS]
 ;             extended protocol.  2nd piece of SDATA is IEN of patient
 ;             record in PATIENT file.
 ;
 ; Output: none
 ;
 N DFN
 ;
 ; quit if supported Sched vars not defined
 I '$D(SDAMEVT) G APPTQ
 S DFN=$P($G(SDATA),"^",2)
 I 'DFN G APPTQ
 ;
 ; quit if transaction type not (make appt, check-in, check-out)
 I SDAMEVT'=1,(SDAMEVT'=4),(SDAMEVT'=5) G APPTQ
 ;
 ; does patient need query sent?
 I '$$NEED(DFN,1) G APPTQ
 ;
 ; send query for patient
 I $$QUERY^IVMCQ1(DFN,$G(DUZ),0,$G(XQY),,1)
 ;
APPTQ Q
 ;
 ;
ASK(IVMTOUT) ; Ask user if ok to send financial query for patient.
 ;
 ;  Input: none
 ;
 ; Output: 
 ;  Function Value: 1=Yes and 0=No
 ;                  IVMTOUT (pass by reference)  1=Timeout or up-arrow
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR("A")="Would you like to send a financial query for this patient"
 S DIR("B")="YES"
 S DIR(0)="Y"
 W ! D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S IVMTOUT=1
 Q +$G(Y)
 ;
 ;
NOTIFY(IVMOUT) ; Ask if user should be notified when a reply to query is received.
 ;
 ;  Input: none
 ;
 ; Output: 
 ;  Function Value: 1=Yes and 0=No
 ;                  IVMOUT (pass by reference)  1=Timeout or up-arrow
 ;
 N DIR,DTOUT,DUOUT,X,Y
 S DIR("A")="Do you want to be notified when a query reply is received"
 S DIR("B")="YES"
 S DIR(0)="Y"
 W ! D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S IVMOUT=1
 Q +$G(Y)
 ;
 ;
NEED(DFN,IVMSENT,ERROR) ; Description: Used to determine if a financial query should be sent for a patient.
 ;
 ;  Input:
 ;       DFN - ien of patient record in PATIENT file
 ;   IVMSENT - (optional) Check if query sent on same day 0=>No|1=>Yes
 ; Output:
 ;  Function Value: Does pt. need a query? 1 on success, 0 on failure
 ;     ERROR - If failure, return the reason for not sending
 ;             the query (pass by reference)
 ;
 N DGMSGF,DGADDF,DGREQF,IVMBT,IVML,SUCCESS
 N IVMDOD
 ;
 S SUCCESS=0,(DGMSGF,DGADDF)=1
 I '$D(IVMSENT) S IVMSENT=1
 ; Can this patient be identified?
 I '$G(DFN) S ERROR="PATIENT CAN NOT BE IDENTIFIED" G NEEDQ
 ; is this patient deceased?
 S IVMDOD=$$GET1^DIQ(2,DFN_",",.351,"I")
 I IVMDOD]"" S ERROR="Patient Expired on "_$$GET1^DIQ(2,DFN_",",.351,"E")_".  Financial query unnecessary."  G NEEDQ
 ; Check to see if this patient is currently on a DOM ward.
 D DOM^DGMTR I $G(DGDOM) D  G NEEDQ
 .S ERROR="PATIENT CURRENTLY A DOMICILIARY PATIENT - "
 .S ERROR=ERROR_"QUERY NOT REQUIRED"
 .K DGDOM
 .Q
 ; Check for PRIMARY test either MEANS or Copay exemption.
 S IVML=$$LST^DGMTCOU1(DFN,DT_.2359,3)
 ; If no primary test on file check to see if patient requires a means
 ; test or copay exemption test.  Call to DGMTR invokes EN^DGMTCOR as
 ; well.
 I IVML']"" D EN^DGMTR I +$G(DGREQF) S SUCCESS=1 G NEEDQ
 ;
 ; If current test is not incomplete and not required and is less than
 ; 365 days old, presume a current test exists, no query necessary.
 I ($P(IVML,U,4)'="I")&($P(IVML,U,4)'="R"),'$$OLD^DGMTU4($P(IVML,U,2)) D  G NEEDQ
 .S ERROR="PATIENT HAS A CURRENT "_$S($P(IVML,U,5)=1:"MEANS",$P(IVML,U,5)=2:"COPAY EXEMPTION",1:"MEANS")_" TEST ON FILE"
 .Q
 ;
 ; If the current test is NO LONGER REQUIRED or NO LONGER APPLICABLE no
 ; query is necessary.
 I ($P(IVML,U,4)="N")!($P(IVML,U,4)="L") D  G NEEDQ
 .S ERROR="PATIENT'S "_$S($P(IVML,U,5)=1:"MEANS",$P(IVML,U,5)=2:"COPAY EXEMPTION",1:"MEANS")_" TEST STATUS "_$P(IVML,U,3)_"."
 .Q
 ;
 ; If current test is not REQUIRED and not NO LONGER REQUIRED and it is 
 ; older than 365 days, initiate query.
 I ($P(IVML,U,4)'="R")&($P(IVML,U,4)'="N"),$$OLD^DGMTU4($P(IVML,U,2)) S SUCCESS=1 G NEEDQ
 ;
 ; If a query is pending, don't send another.
 I $$OPEN^IVMCQ2(DFN) S ERROR="A QUERY IS ALREADY PENDING FOR THIS PATIENT" G NEEDQ
 ;
 ; if a query has already been sent today, don't send another.
 I IVMSENT,$$SENT^IVMCQ2(DFN) S ERROR="A QUERY HAS BEEN SENT FOR PATIENT TODAY" G NEEDQ
 ;
 ; Has a bene travel cert been filed with a year?
 S IVMBT=$O(^DGBT(392.2,"C",DFN,0))
 I IVMBT,$$FMDIFF^XLFDT(DT,+$G(^DGBT(392.2,IVMBT,0))\1)>330 S SUCCESS=1 G NEEDQ
 ;
 S ERROR="A FINANCIAL QUERY IS NOT REQUIRED FOR THIS PATIENT"
 ;
NEEDQ Q SUCCESS
