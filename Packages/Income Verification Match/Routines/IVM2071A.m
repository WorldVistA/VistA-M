IVM2071A ;ALB/RMM - Means Test Cleanup Utility ; 23 DEC 2002
 ;;2.0;INCOME VERIFICATION MATCH;**71**;21-OCT-94
 ;
 ; This Distribution/Cleanup will check every record in the Patient
 ; File #2, for a corresponding entry in the Annual Means Test File
 ; #408.31.
 ;
 ; An IVM Financial Query (QRY) Message will be sent when the veteran's
 ; Income Test meets the following criteria:
 ;     There must be a current Primary Test (no earlier than income 
 ;       year 2001)
 ;     The test must have been entered early (before the CAD)
 ;     There must have been a similar test in the previous income year
 ;       (both Means Tests or both Copay Test) or last year had a Copay 
 ;       and this year has a Means Test.
 ;     The test's status must not have been an improvement over the 
 ;        prior income year's test
 ;---------------------------------------------------------------------  
 ; Temporary Storage/Tracking Global Details:
 ;     ^XTMP("IVM71",1) - Number of records processed
 ;     ^XTMP("IVM71",2) - Number of queries transmitted
 ;---------------------------------------------------------------------  
 ;
EN ; Begin Processing...
 ; Write message to installation device and to INSTALL file (#9.7)
 D BMES^XPDUTL("Future MT Distribution/Cleanup")
 D MES^XPDUTL("Once the distribution/cleanup has completed, a MailMan ")
 D MES^XPDUTL("message will be sent that will report the number of")
 D MES^XPDUTL("records, that were changed.")
 D BMES^XPDUTL("Beginning cleanup process "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
INIT ;
 ; Initialize tracking global (See text above for description)
 N X,X1,X2
 I '$D(^XTMP("IVM71",0)) D
 .S X1=DT,X2=30 D C^%DTC
 .S ^XTMP("IVM71",0)=X_"^"_$$DT^XLFDT_"^IVM*2*71 FUTURE MT CLEANUP UPLOAD ERRORS"
 .S (^XTMP("IVM71",1),^XTMP("IVM71",2))=0
 ;
 I $D(^XTMP("IVM71",0)) S (^XTMP("IVM71",1),^XTMP("IVM71",2))=0
 ;
 ;Task job using TaskMan
 N ZTDESC,ZTIO,ZTRTN,ZTSK,ZTDTH
 S ZTDTH=$$NOW^XLFDT
 S ZTIO="",ZTRTN="EN1^IVM2071A",ZTDESC="IVM*2*71 FUTURE MT CLEANUP UPLOAD ERRORS"
 D ^%ZTLOAD
 I '$D(ZTSK) D BMES^XPDUTL("Task failed!")
 E  D BMES^XPDUTL("Task# "_ZTSK_" queued ")
 Q
EN1 ; Process Control Body
 ;
 N DFN,CURMT,LSTMT,TTYPE,LTYPE,CURST,LSTST,CURDT,LSTDT,IMP,PRINYR
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .;
 .; If there is no Primary in this income year (or 2001), Quit
 .S CURMT="",TTYPE=1,CURMT=$$LST^DGMTU(DFN,,TTYPE)
 .S:'CURMT TTYPE=2,CURMT=$$LST^DGMTU(DFN,,TTYPE)
 .I $E($P(CURMT,U,2),1,3)<301 Q
 .S ^XTMP("IVM71",1)=^XTMP("IVM71",1)+1
 .;
 .; If there is no test for the Prior Income Year, Quit
 .S PRINYR=($E($P(CURMT,U,2),1,3)-1)_1231
 .S LSTMT="",LTYPE=1,LSTMT=$$LST^DGMTU(DFN,PRINYR,LTYPE)
 .S:'LSTMT LTYPE=2,LSTMT=$$LST^DGMTU(DFN,PRINYR,LTYPE)
 .Q:'LSTMT
 .;
 .; If this years test wasn't entered early, Quit
 .I ($E($P(CURMT,U,2),4,7)+1)>($E($P(LSTMT,U,2),4,7)) Q
 .;
 .; If this year's test was a CP and last year's test was a MT, Quit 
 .I TTYPE=2,LTYPE=1 Q
 .;
 .; If the Income Test's status was improved, Quit
 .S CURST=$P(CURMT,U,4),LSTST=$P(LSTMT,U,4),IMP=1
 .I TTYPE=LTYPE D
 ..I CURST=LSTST S IMP=0 Q
 ..I TTYPE=1,CURST="C",LSTST="A" S IMP=0 Q
 ..I TTYPE=1,CURST="G",LSTST="A" S IMP=0 Q
 ..I TTYPE=1,CURST="C",LSTST="G" S IMP=0 Q
 ..I TTYPE=2,CURST="M",LSTST="E" S IMP=0 Q
 .;
 .Q:IMP
 .;
 .; The test met the criteria, send Query to HEC and increment counter
 .I $$QUERY(DFN) S ^XTMP("IVM71",2)=^XTMP("IVM71",2)+1
 .;
 ;
 ; Send a mailman msg to the user with the results
 D MAIL^IVM2071M
 D MES^XPDUTL(" >>Distribution/Cleanup process completed: "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 Q
 ;
QUERY(DFN) ;
 N SUCCESS,DATA,IVMIEN,IVMPAT,IVMCID,DGENDA,USER,NOTIFY,OPTION,ERROR
 N HLMTN,HLDAP,HLEID,HL,HLERR,HLEVN,HLSDT,HLARYTYP,HLFORMAT,HLRESLT,HLFS
 ;
 ; Adding an entry in the IVM FINANCIAL QUERY LOG
 S SUCCESS=0,DATA(.01)=DFN,DATA(.02)=$$NOW^XLFDT
 S IVMIEN=$$ADD^DGENDBS(301.62,,.DATA)
 K DATA,^TMP("HLS",$J)
 ;
 ; Initialize the HL7 Variables
 S HLMTN="QRY",HLDAP="IVM"
 S HLEID="VAMC "_$P($$SITE^VASITE,"^",3)_" QRY-Z10 SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 D INIT^HLFNC2(HLEID,.HL)
 I $G(HL)]"" S HLERR=$P(HL,"^",2)
 S HLEVN=0,HLSDT=$$NOW^XLFDT
 I $D(HLERR) S ERROR="HL7 INITIALIZATION ERROR - "_HLERR G QUERYQ
 ;
 ; Get the Patient Identifiers
 I '$$GETPAT^IVMUFNC(DFN,.IVMPAT) S ERROR="PATIENT NOT FOUND" G QUERYQ
 I (IVMPAT("DOB")="") S ERROR="PATIENT DATE OF BIRTH IS REQUIRED" G QUERYQ
 I (IVMPAT("SSN")="") S ERROR="PATIENT SSN IS REQUIRED" G QUERYQ
 I (IVMPAT("SEX")="") S ERROR="PATIENT SEX IS REQUIRED" G QUERYQ
 I "MF"'[IVMPAT("SEX") S ERROR="PATIENT SEX IS NOT VALID" G QUERYQ
 ;
 ; Build HL7 Financial Query (QRY) Message Components...
 D QRD,QRF
 ;
 ; Send the HL7 Financial Query (QRY) Message...
 S HLARYTYP="GM",HLFORMAT=1
 D GENERATE^HLMA(HLEID,HLARYTYP,HLFORMAT,.HLRESLT)
 I $P($G(HLRESLT),"^",2)]"" S HLERR=$P(HLRESLT,"^",3)
 I $D(HLERR) S ERROR="HL7 TRANSMISSION ERROR - "_HLERR G QUERYQ
 S IVMCID=+HLRESLT
 ;
 ; Update the Record in the LOG file...
 S DGENDA=IVMIEN,DATA(.03)=0,DATA(.04)=$G(USER),DATA(.05)=IVMCID
 S DATA(.06)="",DATA(.07)=$G(OPTION),DATA(.08)=$S($G(NOTIFY):1,1:0)
 I '$$UPD^DGENDBS(301.62,.DGENDA,.DATA) S ERROR="UPDATE OF RECORD "_IVMIEN_" IN 301.62 FAILED!" G QUERYQ
 S SUCCESS=1
QUERYQ ; exit and clean-up
 D KILL^HLTRANS
 K ^TMP("HLS",$J)
 Q SUCCESS
 ;
QRD ; Build (HL7) QRD segment for patient
 N IVMQRD
 S $P(IVMQRD,HLFS,1)=$$HLDATE^HLFNC(HLSDT),$P(IVMQRD,HLFS,2)="R"
 S $P(IVMQRD,HLFS,3)="I",$P(IVMQRD,HLFS,4)=DFN,$P(IVMQRD,HLFS,7)="1~RD"
 S $P(IVMQRD,HLFS,8)=IVMPAT("SSN"),$P(IVMQRD,HLFS,9)="FIN"
 S $P(IVMQRD,HLFS,10)=$$HLDATE^HLFNC($$LYR^DGMTSCU1(DT)),$P(IVMQRD,HLFS,12)="T"
 S ^TMP("HLS",$J,1)="QRD"_HLFS_IVMQRD
 Q
 ;
QRF ; Build HL7 (QRF) segment for patient
 N IVMQRF
 S $P(IVMQRF,HLFS,1)="IVM"
 S $P(IVMQRF,HLFS,4)=$$HLDATE^HLFNC(IVMPAT("DOB"))
 S $P(IVMQRF,HLFS,5)=IVMPAT("SEX")
 S ^TMP("HLS",$J,2)="QRF"_HLFS_IVMQRF
 Q
