DG53807P ;ALB/LBD - PATCH DG*5.3*807 POST-INSTALL ROUTINE ; 4/2/09 4:15pm
 ;;5.3;Registration;**807**;Aug 13, 1993;Build 2
 ;
 ; This routine will loop through the Patient file #2 and update
 ; the country field in all Permanent, Temporary and Confidential
 ; Addresses that have a valid US zip code with UNITED STATES.
 ;
 Q
EN ;Entry point for DG*5.3*807 post-install
 N ZTDTH,ZTIO,ZTDESC,ZTRTN,ZTSK
 S ZTDESC="Update Addresses with United States"
 S ZTRTN="ENQ^DG53807P",ZTDTH=$H,ZTIO=""
 D ^%ZTLOAD
 I $G(ZTSK) D  Q
 .D BMES^XPDUTL("POST-INSTALL PROCESS HAS BEEN QUEUED AS TASK #"_ZTSK)
 .D MES^XPDUTL("Old patient addresses will be updated with UNITED STATES")
 D BMES^XPDUTL("ERROR: POST-INSTALL PROCESS COULD NOT BE QUEUED")
 Q
 ;
ENQ ;Entry point for tasked job
 N ERROR,PROG
 S PROG="DG53807P"
 S:'$D(^XTMP(PROG,0)) ^XTMP(PROG,0)=$$FMADD^XLFDT($$DT^XLFDT,180)_"^"_$$DT^XLFDT()_"^UPDATE OLD PATIENT ADDRESSES WITH UNITED STATES"
 S ^XTMP(PROG,"TASK")=$G(ZTSK)
 S ^XTMP(PROG,"START")=$$FMTE^XLFDT($$NOW^XLFDT) K ^XTMP(PROG,"END")
 S ^XTMP(PROG,"TOTPAT")=0
 D LOOP
 S ^XTMP(PROG,"END")=$$FMTE^XLFDT($$NOW^XLFDT)
 D SENDMSG
 Q
LOOP ; Loop through Patient file #2, starting with most recent DFNs.
 N DFN,PAT,UPD,USA
 S DFN="A"
 ;Get IEN for UNITED STATES from COUNTRY CODE file #779.004
 S USA=$O(^HL(779.004,"C","UNITED STATES",0))
 I 'USA S ERROR="UNITED STATES MISSING FROM COUNTRY CODE FILE" Q
 F  S DFN=$O(^DPT(DFN),-1) Q:DFN=""!($$TST)  I $D(^DPT(DFN,0)) D
 .S ^XTMP(PROG,"TOTPAT")=$G(^XTMP(PROG,"TOTPAT"))+1
 .S UPD=0
 .L +^DPT(DFN):3 E  D FAIL Q
 .S PAT(.11)=$G(^DPT(DFN,.11))    ;Permanent Address data
 .S PAT(.121)=$G(^DPT(DFN,.121))  ;Temporary Address data
 .S PAT(.122)=$G(^DPT(DFN,.122))  ;Temporary Address data
 .S PAT(.141)=$G(^DPT(DFN,.141))  ;Confidential Address data
 .;Check Permanent Address
 .I $P(PAT(.11),"^",10)="" D
 ..I $$USZIP($P(PAT(.11),"^",6)) S $P(^DPT(DFN,.11),"^",10)=USA,UPD=1
 .;Check Temporary Address
 .I $P(PAT(.122),"^",3)="" D
 ..I $$USZIP($P(PAT(.121),"^",6)) S $P(^DPT(DFN,.122),"^",3)=USA,UPD=1
 .;Check Confidential Address
 .I $P(PAT(.141),"^",16)="" D
 ..I $$USZIP($P(PAT(.141),"^",6)) S $P(^DPT(DFN,.141),"^",16)=USA,UPD=1
 .L -^DPT(DFN)
 .I UPD S ^XTMP(PROG,"TOTUPD")=$G(^XTMP(PROG,"TOTUPD"))+1
 Q
 ;
USZIP(ZIP) ;Check if valid US zip code
 ;Return 1=US zip code; 0=Not valid US zip code
 N ST,Z
 I $G(ZIP)="" Q 0
 ;Lookup in POSTAL CODE file #5.12
 S Z=$O(^XIP(5.12,"B",ZIP,0)) I 'Z Q 0
 ;Get State
 S ST=$P($G(^XIP(5.12,Z,0)),"^",4) I 'ST Q 0
 ;Valid US state or possession?
 I '$P($G(^DIC(5,ST,0)),"^",6) Q 0
 Q 1
 ;
SENDMSG ;Send MailMan message when process completes
 N XMSUB,XMDUZ,XMY,XMTEXT,MSG,LN
 S XMY(DUZ)="",XMTEXT="MSG("
 S XMDUZ=.5,XMSUB="DG*5.3*807 JOB TO UPDT OLD PAT ADDRS"
 S MSG($$LN)="The DG*5.3*807 post-install process has completed."
 S MSG($$LN)=""
 S MSG($$LN)="This process ran through the Patient file #2 and checked"
 S MSG($$LN)="the patient's Permanent, Temporary, and Confidential"
 S MSG($$LN)="addresses.  If the address was a valid US address, but"
 S MSG($$LN)="the Country field was blank, the Country was updated with"
 S MSG($$LN)="UNITED STATES."
 S MSG($$LN)=""
 S MSG($$LN)="The process statistics:"
 S MSG($$LN)=""
 I $D(ERROR) D
 .S MSG($$LN)="*** ERROR: THIS PROCESS COULD NOT BE RUN BECAUSE 'UNITED STATES'"
 .S MSG($$LN)="           IS MISSING FROM THE COUNTRY CODE FILE #779.004"
 .S MSG($$LN)=""
 S MSG($$LN)="Job Start Date/Time: "_$G(^XTMP(PROG,"START"))
 S MSG($$LN)="  Job End Date/Time: "_$G(^XTMP(PROG,"END"))
 S MSG($$LN)=""
 S MSG($$LN)="Total Patient Records Searched: "_+$G(^XTMP(PROG,"TOTPAT"))
 S MSG($$LN)=" Total Patient Records Updated: "_+$G(^XTMP(PROG,"TOTUPD"))
 I $G(^XTMP(PROG,"LOCKFAIL")) D
 .S MSG($$LN)="  Total Patient Records Failed: "_+$G(^XTMP(PROG,"LOCKFAIL"))
 D ^XMD
 Q
LN() ;Increment line counter
 S LN=$G(LN)+1
 Q LN
FAIL ;Update ^XTMP with records that could not be locked
 S ^XTMP(PROG,"LOCKFAIL")=$G(^XTMP(PROG,"LOCKFAIL"))+1
 S ^XTMP(PROG,"LOCKFAIL",DFN)=""
 Q
 ;
TEST ;Entry point for testing
 N DIR,X,Y,DIRUT,DIROUT,TST
 W !!,"ADDRESS UPDATE ROUTINE DG53807P"
 S DIR(0)="NOA",DIR("A")="Enter number of records for test run: "
 D ^DIR I 'Y Q
 S TST=+Y
 G ENQ
TST() ;If testing, quit if number of records = TST
 I '$D(TST) Q 0
 I ^XTMP(PROG,"TOTPAT")=TST Q 1
 Q 0
