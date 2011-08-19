IVMBULK1 ;ALB/KCL - IVM/ENROLLMENT Extract Con't ; 18-AUG-1997
 ;;2.0;INCOME VERIFICATION MATCH;**9,11,15**; 21-OCT-94
 ;
 ;
GOGO ; --
 ; Description: This entry point will be the main driver for enrollment data extract.
 ;
 ;  Input:
 ;    IVMCONST - as local array containing extract input parameters
 ;               (constants), pass by reference
 ;    IVMARRY1 - as local array containing extract input parameters
 ;               (variable), pass by reference
 ;
 ; Output: None
 ;
 ; Perform enrollment data extract
 D BULK(.IVMCONST,.IVMARRY1)
 ;
 ; Send extract notification message
 D DOMAIL
 ;
 ; If enrollment events not on, turn on enrollment events
 I '$$ON^IVMUPAR1() D SETON^IVMUPAR1
 ;
 Q
 ;
 ;
BULK(IVMCONST,IVMARRY1) ; --
 ; Description: This entry point will perform the enrollment data extract.
 ;
 ;  Input:
 ;    IVMCONST - as local array containing extract input parameters
 ;               (constants), pass by reference
 ;    IVMARRY1 - as local array containing extract input parameters
 ;               (variable), pass by reference
 ;
 ; Output: None
 ;
 ; initilize varibles
 N DFN,POP,Z
 K IVMQUERY("LTD"),IVMQUERY("OVIS")
 D INIT^IVMUFNC  ; HL7 vars
 S (IVMARRY1("ERROR"),IVMARRY1("TERM"))=""
 S IVMARRY1("HOST")=$S(IVMARRY1("HOST")'="":IVMARRY1("HOST"),1:IVMCONST("HOST"))
 S IVMARRY1("PROC")=$G(IVMARRY1("PROC")),IVMARRY1("EXTRACT")=$G(IVMARRY1("EXTRACT"))  ; extract statistic counters
 S IVMARRY1("START")=$$NOW^XLFDT  ; current date/time job started
 S IVMARRY1("TASK")=$G(ZTSK)
 ;
 ; store processing info
 I $$STORE^IVMBULK2(.IVMARRY1)
 ;
 ; open host file, if error quit
 D OPEN^%ZISH("FILE1",IVMARRY1("DIR"),IVMARRY1("HOST")_"_"_(1+(IVMARRY1("EXTRACT")\IVMCONST("MSGMAX"))),"A")
 I POP S IVMARRY1("ERROR")="Could not create host file in specified directory." G BULKQ
 ;
 ; loop through patients in Patient (#2) file
 S DFN=+IVMARRY1("LASTPAT")
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D  Q:IVMARRY1("ERROR")'=""
 .;
 .; - # of patients processed/checked
 .S IVMARRY1("PROC")=IVMARRY1("PROC")+1
 .;
 .; - quit if patient does not pass selection criteria
 .Q:'$$CRITERIA(DFN,IVMCONST("BEGDT"),DT)
 .;
 .; - kill ^TMP global containing previous HL7 msg
 .K ^TMP("HLS",$J,HLSDT)
 .;
 .; - build HL7 full data transmission msg for patient
 .D BUILD^IVMPTRN8(DFN,$$LD^IVMUFNC4(DFN),0,.IVMQUERY)
 .;
 .; - write HL7 full data transmission message to host file
 .D HOST(HLSDT)
 .;
 .; - # of patients extracted
 .S IVMARRY1("EXTRACT")=IVMARRY1("EXTRACT")+1
 .;
 .; - check if host file has reached max size limit
 .I IVMARRY1("EXTRACT")#IVMCONST("MSGMAX")=0 D  Q:IVMARRY1("ERROR")'=""
 ..;
 ..; -- close host file, max limit reached
 ..D CLOSE^%ZISH("FILE1")
 ..;
 ..; -- open next host file
 ..D OPEN^%ZISH("FILE1",IVMARRY1("DIR"),IVMARRY1("HOST")_"_"_(1+(IVMARRY1("EXTRACT")\IVMCONST("MSGMAX"))),"A")
 ..I POP S IVMARRY1("ERROR")="Could not open host file." Q
 .;
 .; - for every 100 patients processed, check if task stopped
 .I IVMARRY1("PROC")#100=0 D
 ..; -- check if task has been stopped
 ..I $$S^%ZTLOAD S IVMARRY1("ERROR")="Queued job stopped prior to completion.",IVMARRY1("TERM")=1,IVMARRY1("LASTPAT")=DFN
 ..; -- update IVM EXTRACT MANAGEMENT file
 ..I $$STORE^IVMBULK2(.IVMARRY1)
 ;
 ;Close the last treatment date search and the outpt visit queries
 F Z="LTD","OVIS" I $G(IVMQUERY(Z)) D CLOSE^SDQ(IVMQUERY(Z)) K IVMQUERY(Z)
 ; close host file
 D CLOSE^%ZISH("FILE1")
 ;
 ;
BULKQ ; set up final extract statistics
 I $G(DFN)'>0 S IVMARRY1("LASTPAT")=""
 S IVMARRY1("STOP")=$$NOW^XLFDT  ; current date/time job stopped
 S IVMARRY1("FILES")=(1+(IVMARRY1("EXTRACT")\IVMCONST("MSGMAX")))  ; # of host files
 ; 
 ; store processing info for extract in IVM Extract Management file
 I $$STORE^IVMBULK2(.IVMARRY1)
 ;
 ; unlock IVM EXTRACT MANAGEMENT file
 D UNLOCK^IVMBULK2(1)
 ;
 ; kill hl7 temp array
 K ^TMP("HLS",$J,HLSDT)
 ;
 ; Cleanup HL7/IVM vars (as defined by call to INIT^IVMUFNC)
 D CLEAN^IVMUFNC
 ;
 Q
 ;
 ;
CRITERIA(DFN,IVMDT1,IVMDT2) ; --
 ; Description: This function will determine if the patient meets the enrollment initial data extract selection criteria for a specific date range.
 ;
 ;  Input:
 ;       DFN - pointer to patient in Patient (#2) file
 ;    IVMDT1 - as start date to use when looking for episodes of care
 ;    IVMDT2 - as end date to use when looking for episodes of care
 ;
 ; Output:
 ;   Function Value - Does patient meet the selection criteria?
 ;                    Return 1 if successful, otherwise 0
 ;
 N IVMCRIT,IVMCUREN
 S IVMCRIT=0
 ;
 ; get enrollment status from patient's current enrollment
 S IVMCUREN=$$STATUS^DGENA(DFN),IVMCUREN=$G(IVMCUREN)
 ; is status unverified, verified, or pending 
 I IVMCUREN,(IVMCUREN=1!(IVMCUREN=2)!(IVMCUREN=9)) S IVMCRIT=1 G CRITQ
 ;
 ; if patient is not a veteran, exit
 I '$$VET^DGENPTA(DFN) G CRITQ
 ;
 ; is veteran a current inpatient?
 I $$CURINPAT^DGENPTA(DFN) S IVMCRIT=1 G CRITQ
 ;
 ; was veteran an inpatient?
 I $$INPAT^DGENPTA(DFN,IVMDT1,IVMDT2) S IVMCRIT=1 G CRITQ
 ;
 ; does veteran have a checked-out encounter (outpatient)?
 I $$OUTPAT^DGENPTA(DFN,IVMDT1,IVMDT2) S IVMCRIT=1 G CRITQ
 ;
CRITQ Q IVMCRIT
 ;
 ;
HOST(HLSDT) ; --
 ; Description: Take HL7 message contained in temporary array and write to host file.
 ;
 ;  Input:
 ;                      IO - name of opened host file in the format to
 ;                           to use for the 'M' USE command
 ;    ^TMP("HLS",$J,HLSDT) - global array containing all segments of the
 ;                           HL7 message for a patient.  The HLSDT
 ;                           variable is a flag that indicates that data
 ;                           is to be stored in the ^TMP("HLS") global
 ;                           array.  The IVMCT variable is a sequential
 ;                           number starting at 0 and incremented by 1.
 ;
 ; Output: None
 ;
 N IVMSUB
 ;
 ; use host file
 U IO
 ;
 ; used to delineate begining of new HL7 message
 W "{",!
 ;
 ; write message segments to host file
 S IVMSUB="" F  S IVMSUB=$O(^TMP("HLS",$J,HLSDT,IVMSUB)) Q:IVMSUB'>0  D
 .W $G(^TMP("HLS",$J,HLSDT,IVMSUB)),!
 ;
 ; used to delineate end of HL7 message
 W "}",!
 ;
 Q
 ;
 ;
DOMAIL ; --
 ; Description: This function will generate a MailMan message contianing the results of the enrollment data extract.
 ;
 ;  Input: None
 ;
 ; Output: None
 ;
 K XMZ
 N DIFROM,IVMCON1,IVMMSG,IVMPRCNT,IVMSITE,XMTEXT,XMSUB,XMDUZ,XMY
 ;
 ; init mail variables
 S IVMSITE=$$SITE^VASITE
 S XMSUB="Enrollment Extract Results "_"("_$P(IVMSITE,"^",3)_")"
 S XMDUZ=.5,XMY(DUZ)="",XMY(.5)=""
 S XMTEXT="IVMMSG("
 ;
 ; if error creating message text, exit
 I '$$FINAL(.IVMMSG) G DOMAILQ
 ;
 ; get extract constants
 I $$GETCONST^IVMBULK2(.IVMCON1)
 ;
 ; HEC mail group
 I IVMARRY1("ERROR")']"" S XMY(IVMCON1("MAILGRP"))=""
 ;
 ; send msg
 D ^XMD
 ;
DOMAILQ Q
 ;
 ;
FINAL(IVMTXT) ; --
 ; Description: Places message text into local IVMTXT array.
 ;
 ;  Input: None
 ;
 ; Output:
 ;   Function Value - returns 1 if success, 0 if failure
 ;   IVMTXT - as local array containing mail message text,
 ;            pass by reference
 ;
 N SUCCESS,IVMSITE,IVMARRY2
 S SUCCESS=0
 ;
 ; if obtaining IVM Extract Management record unsuccessful, exit
 I '$$GET^IVMBULK2(.IVMARRY2) G FINALQ
 ;
 S IVMSITE=$$SITE^VASITE
 ;
 S IVMTXT(1)="    > > > > > > > > > >  ENROLLMENT DATA EXTRACT RESULTS  < < < < < < < < < <"
 S IVMTXT(2)=""
 S IVMTXT(3)="                       Facility Name:  "_$P(IVMSITE,"^",2)
 S IVMTXT(4)="                      Station Number:  "_$P(IVMSITE,"^",3)
 S IVMTXT(5)=""
 S IVMTXT(6)="               Date/Time job started:  "_$$FMTE^XLFDT(IVMARRY2("START"),"1P")
 S IVMTXT(7)="               Date/Time job stopped:  "_$$FMTE^XLFDT(IVMARRY2("STOP"),"1P")
 S IVMTXT(8)=""
 S IVMTXT(9)="            Total patients processed:  "_IVMARRY2("PROC")
 S IVMTXT(10)="            Total patients extracted:  "_IVMARRY2("EXTRACT")
 S IVMTXT(11)="                Percentage extracted:  "_$S($G(IVMARRY2("PROC")):$P(IVMARRY2("EXTRACT")/IVMARRY2("PROC")*100,".")_"%",1:"")
 S IVMTXT(12)=""
 S IVMTXT(13)="                 Host file directory:  "_IVMARRY2("DIR")
 S IVMTXT(14)="                      Host file name:  "_IVMARRY2("HOST")
 S IVMTXT(15)="                Number of host files:  "_IVMARRY2("FILES")
 ;
 ; if ERROR, set error into msg text
 I IVMARRY2("ERROR")]"" D
 .S IVMTXT(16)=""
 .S IVMTXT(17)="               * * * * E R R O R  E N C O U N T E R E D * * * *"
 .S IVMTXT(18)=""
 .S IVMTXT(19)="          Error Message:  "_IVMARRY2("ERROR")
 .S IVMTXT(20)="            Task Number:  "_IVMARRY2("TASK")
 ;
 S SUCCESS=1
 ;
FINALQ Q SUCCESS
