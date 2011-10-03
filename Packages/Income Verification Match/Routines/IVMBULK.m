IVMBULK ;ALB/KCL - IVM/ENROLLMENT Extract ; 18-AUG-1997
 ;;2.0;INCOME VERIFICATION MATCH;**9**; 21-OCT-94
 ;
 ; * This extract will scan the PATIENT (#2) file for patients that
 ;   meet the following enrollment extract selection criteria:
 ;
 ;     [Patient has a current enrollment]
 ;                AND
 ;     [Enrollment status is 'Pending'
 ;                OR
 ;      Enrollment status is 'Unverified'
 ;                OR
 ;      Enrollment status is 'Verified']
 ;
 ;     OR,
 ;
 ;     [Patient is a Veteran]
 ;                AND
 ;     [Patient is a current inpatient
 ;                OR
 ;      Patient was an inpatient after 1/1/96
 ;                OR
 ;      Patient was an outpatient after 1/1/96]
 ;
 ;
 ; * An HL7 "Full Data Transmission" message (Z07) will be built
 ;   for each patient selected.  HL7 messages will be output to a
 ;   selected host file.
 ;
 ; * A mail message will be generated upon completion of the initial
 ;   data extract.  This mail message will contian the results of
 ;   the extract.
 ;
 ; * This job will be queued.
 ;
 ;
EN(IVMARRY1,IVMCONST) ; --
 ; Description: Entry point responsible for queuing off the enrollment extract job.
 ;
 ;  Input: None
 ;
 ; Output: 
 ;   IVMARRY1 - as array containing required input parameters for enrollment extract job, pass by reference
 ;   IVMCONST - as array containing enrollment extract constants, pass by reference
 ;
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,QUIT
 ;
 S QUIT=0
 ;
 ; lock IVM Extract Mangement file, otherwise exit
 I '$$LOCK^IVMBULK2(1) D  G ENQ
 .W !,">>> This job has already been queued!"
 ;
 ; if environment check fails, exit
 I '$$ENV() S QUIT=1 G ENQ
 ;
 ; get extract constants
 I $$GETCONST^IVMBULK2(.IVMCONST)
 ;
 ; get IVM Extract Management record
 I '$$GET^IVMBULK2(.IVMARRY1) D
 .;
 .; - if no IVM Extract Mgmt. record, init IVM Extract Mgmt. record
 .I $$INIT^IVMBULK2(.IVMARRY1)
 ;
 ; don't want sites to unknowingly run extract again
 I IVMARRY1("EXTRACT"),'IVMARRY1("LASTPAT") D  G:QUIT ENQ
 .W !,"> > >  W A R N I N G",*7
 .W !,?5,"The enrollment data extract has already run to completion!"
 .W !,?5,"Do NOT run the extract again unless you have first deleted the"
 .W !,?5,"host files that contain the prior extract!",!
 .D INQUIRE^IVMBULK2("^IVM(301.63,",1)
 .N DIR
 .S DIR(0)="Y"
 .S DIR("A")="Do you want to run the enrollment extract again"
 .S DIR("B")="NO"
 .D ^DIR
 .I $D(DIRUT)!(Y'=1) D
 ..S QUIT=1
 .E  D
 ..D CLEAR(.IVMARRY1)
 ;
 ; write user info
 D HDR1
 ;
 ; calculate extract size/time estimates
 S IVMARRY1("PROJECT")=""
 D EST(.IVMARRY1,.IVMCONST)
 ;
 ; if user time-out or abort, exit
 I '$$PAUSE() S QUIT=1 G ENQ
 ;
 ; if directory not specified, exit
 I IVMARRY1("DIR")="",('$$PATH^IVMBULK2(.IVMARRY1)) S QUIT=1 G ENQ
 ;
 ; queue enrollment extract job
 S ZTSAVE("IVMARRY1(")="",ZTSAVE("IVMCONST(")=""
 S ZTDESC="Enrollment Initial Data Extract",ZTRTN="GOGO^IVMBULK1",ZTIO=""
 D ^%ZTLOAD,HOME^%ZIS
 I $D(ZTSK) W !,"This job has been queued.  The task number is "_ZTSK_"."
 I '$D(ZTSK) W !,"Unable to queue this job." S QUIT=1
 ;
ENQ ;
 ; if job is not queued, unlock IVM EXTRACT MANAGEMENT file
 I QUIT D UNLOCK^IVMBULK2(1)
 Q
 ;
 ;
ENV() ; --
 ; Description: This function performs an environment check for the enrollment initial data extract job.
 ;
 ;  Input: None
 ;
 ; Output:
 ;   Function Value - Extract environment check successful?
 ;                    Return 1 if successful, otherwise 0
 ;
 N IVMOK
 S IVMOK=1
 ;
 I '($D(DUZ)#2) W *7,!,"You must have a valid DUZ defined before running this routine!" S IVMOK=0
 ;
 Q IVMOK
 ;
 ;
PAUSE() ; --
 ; Description: End-of-Page, Press return to continue or "^" to exit.
 ;
 ;  Input: None
 ;  
 ; Output: Function value - returns 1 if success, 0 otherwise
 ;
 N DIR,DIRUT,DUOUT,SUCCESS,Y
 S SUCCESS=0
 ;
 S DIR(0)="E"
 D ^DIR
 I $D(DIRUT)!($D(DUOUT)) G PAUSEQ
 ;
 S SUCCESS=1
 ;
PAUSEQ Q SUCCESS
 ;
 ;
EST(IVMARRY1,IVMCONST) ; --
 ; Description: Calculate extract size/time estimates.
 ;
 ;  Input:
 ;   IVMARRY1 - as array containing required input parameters for enrollment extract job, pass by reference
 ;   IVMCONST - as array containing enrollment extract constants, pass by reference
 ;
 ; Output: None
 ;
 N IVMTOTAL,X,X2,X3
 ;
 ; total patients in PATIENT file
 S IVMTOTAL=$$TOTPAT(1)
 ;
 ; if extract complete, exit
 I IVMTOTAL'>$G(IVMARRY1("PROC")) G ESTQ
 ;
 ; write estimate disclaimer
 D HDR2(.IVMCONST)
 ;
 S IVMTOTAL=IVMTOTAL-$G(IVMARRY1("PROC"))
 S X=IVMTOTAL,X2=0,X3=10 D COMMA^%DTC
 W !,?7,"Estimated number of patients to be processed: "_X
 ;W !,?7,"Estimated time of extract: "_$$TIMEST(IVMTOTAL,IVMCONST("PERCNT"),IVMCONST("AVG100"))
 S X=$$TIMEST(IVMTOTAL,IVMCONST("PERCNT"),IVMCONST("AVG100"))
 W !,?7,"Estimated time of extract: "_$P(X,"^",1)_" Hours "_$P(X,"^",2)_" Minutes"
 S IVMARRY1("PROJECT")=$$FMADD^XLFDT($$NOW^XLFDT,0,$P(X,"^",1),$P(X,"^",2),0)
 S X=($$SIZEST(IVMTOTAL,IVMCONST("PERCNT"),IVMCONST("SIZE"))\1),X2=0,X3=20 D COMMA^%DTC
 W !,?7,"Estimated amount of disk space (bytes): "_X
 W !
ESTQ Q
 ;
 ;
TOTPAT(ESTIMATE) ; --
 ; Description: This function counts the number of records in the PATIENT file.
 ;
 ;  Input:
 ;    ESTIMATE - (optional) if not passed, an actual patient count will be returned as the function value.  If ESTIMATE=1, then an estimated number of patients in the Patient (#2) file will be returned as the function value.
 ;
 ; Output: 
 ;   Function Value - If ESTIMATE=1 the actual count of records in the patient file, otherwise the estimated count of records in the patient file.
 ;
 N COUNT,DFN
 S (COUNT,DFN)=0
 ;
 ; if flag, estimated count of records in Patient (#2) file (header node)
 I $G(ESTIMATE) S COUNT=$P($G(^DPT(0)),"^",4)
 ;
 ELSE  D
 .;
 .; - loop through Patient (#2) file for actual count of records
 .F  S DFN=$O(^DPT(DFN)) Q:'DFN  S COUNT=COUNT+1
 ;
 Q COUNT
 ;
 ;
TIMEST(COUNT,PERCN,AVG100) ; --
 ; Description: This function will return a time estimate as to how long the initial data extract will run.
 ;
 ;  Input:
 ;  COUNT - number of patients in the PATIENT file
 ;  PERCN - percentage of total patients that are expected to be extracted
 ;  AVG100 - average time to add 100 patients to the extract in seconds
 ;
 ; Output:
 ;  Function Value - If successful, returns the time estimate in the format HOURS^MINUTES.  If function is not successful, the function returns NULL  
 ;
 N SECONDS,HOURS,MINUTES
 ;
 I ($G(COUNT)'>0)!($G(PERCN)'>0)!($G(AVG100)'>0) Q ""
 S SECONDS=(PERCN*AVG100*COUNT)/10000
 S HOURS=SECONDS\3600
 S SECONDS=SECONDS-(HOURS*3600)
 S MINUTES=SECONDS\60
 ;
 Q HOURS_"^"_MINUTES
 ;
 ;
SIZEST(COUNT,PERCN,SIZE) ;
 ; Description: This function will return a size estimate for the initial data extract.
 ;
 ; Input:
 ;   COUNT - number of patients in the PATIENT file
 ;   PERCN - percentage of total patients that are expected to be extracted
 ;    SIZE - average size of single patient record in the extract in BYTES
 ; Output:
 ;   Function Value - the estimated file size in BYTES
 ;
 I (COUNT'>0)!(PERCN'>0)!(SIZE'>0) Q 0
 Q (PERCN*SIZE*COUNT)/100
 ;
 ;
HDR1 ; --
 ; Description: Write extract user info.
 ;
 ;  Input: None
 ; Output: None
 ;
 W !!,"> > >  E N R O L L M E N T   D A T A   E X T R A C T"
 W !!,?5,"This job will loop through the Patient (#2) file to find patients"
 W !,?5,"that meet the enrollment extract selection criteria.",!
 W !,?5,"Due to the high integration with the Patient (#2) file, please"
 W !,?5,"queue this job to run at non-peak hours.",!
 Q
 ;
 ;
HDR2(IVMCONST) ; --
 ; Description: Write extract estimate disclaimer
 ;
 ;  Input:
 ;    IVMCONST() - an array containing extract constants, pass by reference
 ;    IVMCONST("PERCNT") - % of patients expected to be extracted.
 ;
 ; Output: None
 ;
 W !,?15," * * * * *  P L E A S E   N O T E  * * * * *"
 W !,?5,"The following time and space estimates are based on the approximate"
 W !,?5,"number of patients in your database.  Of those patients, it is assumed"
 W !,?5,"that approximately "_IVMCONST("PERCNT")_"% will meet the requirements to be included in"
 W !,?5,"the extract.  Also, the time estimate provided does not account for"
 W !,?5,"the speed of your system or the load on your system.",!
 Q
 ;
CLEAR(IVMARRAY) ;
 ;Description: If the extract must be run again (the entire extract
 ;created from scratch, as opposed to restarted), the IVM EXTRACT
 ;MANAGMENT record needs to be cleared.  This call will do that.
 ;
 ;Input: none
 ;Output:
 ;  IVMARRAY - optional output variable, pass by reference,
 ;          IVMARRAY() contains the IVM EXTRACT MANAGMENT record after
 ;          being initialized.
 ;
 N IVMCONST
 ;
 I $$GETCONST^IVMBULK2(.IVMCONST),$$INIT^IVMBULK2(.IVMARRAY) D
 .S IVMARRAY("HOST")=IVMCONST("HOST")
 .I $$STORE^IVMBULK2(.IVMARRAY)
 Q
