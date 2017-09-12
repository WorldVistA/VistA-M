IVM20P19 ;ALB/KCL - Post-Install Extract ; 1-SEP-1998
 ;;2.0;INCOME VERIFICATION MATCH;**19**; 21-OCT-94
 ;
 ;
POST ; Entry point for post-install, setup check points
 N %
 S %=$$NEWCP^XPDUTL("DFN","EN^IVM20P19",0)
 Q
 ;
 ;
EN ; Description: This entry point will be the driver for the extract.
 ;
 ;  Input: None
 ; Output: None
 ;
 N IVMARRAY,IVMBEGDT,IVMENDDT
 ;
 ; init variables (start/end date for search)
 S IVMBEGDT=2961001
 S IVMENDDT=DT
 ;
 ; perform extract, display results during post-install
 D BMES^XPDUTL("  Examining the PATIENT #2 file...")
 D EXTRACT(IVMBEGDT,IVMENDDT,.IVMARRAY)
 ;
 D MES^XPDUTL("    Total patients processed: "_IVMARRAY("PROC"))
 D MES^XPDUTL("    Total patients extracted: "_IVMARRAY("EXTRACT"))
 D MES^XPDUTL("        Percentage extracted: "_$S($G(IVMARRAY("PROC")):$P(IVMARRAY("EXTRACT")/IVMARRAY("PROC")*100,".")_"%",1:""))
 D MES^XPDUTL("")
 D MES^XPDUTL("  The "_IVMARRAY("EXTRACT")_" patients extracted will be included in the next daily")
 D MES^XPDUTL("  transmission(s) to the Health Eligibility Center (HEC).")
 ;
 ; send extract results bulletin
 D BMES^XPDUTL("  Sending extract results bulletin...")
 D BULL(.IVMARRAY)
 Q
 ;
 ;
EXTRACT(BEGDT,ENDDT,IVMARRAY) ; Description: Used to perform the extract and log patients in the IVM PATIENT file for transmission if selected.
 ;
 ;  Input:
 ;   BEGDT - as begin date for extract search
 ;   ENDDT - as end date for extract search
 ;
 ; Output:
 ;   IVMARRAY - as local array containing extract results, pass by reference
 ;
 N DFN
 ;
 ; init varibles
 K IVMARRAY S IVMARRAY=""
 S IVMARRAY("START")=$$NOW^XLFDT  ; current date/time started
 S IVMARRAY("PROC")=0  ; count of patients processed
 S IVMARRAY("EXTRACT")=0  ; count of patients extracted
 S IVMARRAY("TOTAL")=$P($G(^DPT(0)),"^",4)  ; total patients to check
 S XPDIDTOT=IVMARRAY("TOTAL")  ; total patients for status bar
 S IVMARRAY("UPDATE%")=5  ; init % for status bar update
 ;
 ; retrieve checkpoint parameter value to init DFN, previous run
 S DFN=+$$PARCP^XPDUTL("DFN")
 ;
 ; loop thru patients in PATIENT (#2) file
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .;
 .; - update checkpoint parameter DFN
 .S %=$$UPCP^XPDUTL("DFN",DFN)
 .;
 .S IVMARRAY("PROC")=IVMARRAY("PROC")+1
 .;
 .; - update status bar during post-install if not queued
 .I '$D(ZTQUEUED) D
 ..S IVMARRAY("COMP%")=IVMARRAY("PROC")*100/IVMARRAY("TOTAL")  ; % complete
 ..I IVMARRAY("COMP%")>IVMARRAY("UPDATE%") D
 ...D UPDATE^XPDID(IVMARRAY("PROC"))
 ...S IVMARRAY("UPDATE%")=IVMARRAY("UPDATE%")+5  ; increase update %
 .;
 .; - quit if patient does not pass 1/98 bulk extract criteria
 .Q:'$$CRITERIA^IVMBULK1(DFN,BEGDT,ENDDT)
 .;
 .; - quit if patient does not pass current selection criteria
 .Q:'$$SELECT(DFN)
 .;
 .; - log patient for transmission in IVM PATIENT file
 .N EVENTS
 .S EVENTS("ENROLL")=1
 .I $$LOG^IVMPLOG(DFN,$$YEAR^IVMPLOG(DFN),.EVENTS) S IVMARRAY("EXTRACT")=IVMARRAY("EXTRACT")+1
 .;
 ;
 S IVMARRAY("STOP")=$$NOW^XLFDT  ; current date/time stopped
 Q
 ;
 ;
SELECT(DFN) ; Description: This function will determine if the patient meets the following extract selection criteria:
 ;
 ;   [Patient has SERVICE CONNECTED PERCENTAGE=0]
 ;            OR
 ;   [Patient has Other Entitled Eligibilities]
 ;
 ;  Input:
 ;   DFN - as ien of record in PATIENT (#2) file
 ;
 ; Output:
 ;   Function Value - Return 1 if patient meets the selection criteria, otherwise 0 is returned
 ;
 N SELECT S SELECT=0
 ;
 ; does the patient have an SC %=0?
 I $$SCZERO(DFN) S SELECT=1 G SELECTQ
 ;
 ; does patient have other entitled eligibilities?
 I $$OTHELIG(DFN) S SELECT=1
 ;
SELECTQ Q SELECT
 ;
 ;
SCZERO(DFN) ; Description: Used to determine if a patient has a SERVICE CONNECTED PERCENTAGE equal to zero.
 ;
 ;  Input:
 ;   DFN - as ien of record in PATIENT (#2) file
 ;
 ; Output:
 ;   Function Value - Return 1 if patient has a SERVICE CONNECTED PERCENTAGE equal to zero, otherwise return 0
 ;
 N SCZERO S SCZERO=0
 ;
 I $G(DFN),$D(^DPT(DFN,0)) D
 .I $P($G(^DPT(DFN,.3)),"^",2)=0 S SCZERO=1
 ;
 Q SCZERO
 ;
 ;
OTHELIG(DFN) ; Description: Used to determine if a patient has OTHER ENTITLED ELIGIBILITIES.
 ;
 ;  Input:
 ;   DFN - as ien of record in PATIENT (#2) file
 ;
 ; Output:
 ;   Function Value - return 1 if patient has other entitled eligibilities, otherwise return 0
 ;
 N OTH,OTHELIG,PRIME
 S (OTHELIG,OTH)=0
 ;
 I $G(DFN),$D(^DPT(DFN,0)) S PRIME=+$G(^DPT(DFN,.36))
 ;
 ; if Primary Eligibility, check for Other Entitled Eligibilities
 I $G(PRIME) D
 .F  S OTHELIG=$O(^DPT(DFN,"E",OTHELIG)) Q:'OTHELIG!(OTH=1)  D
 ..I OTHELIG'=PRIME S OTH=1
 ;
 Q OTH
 ;
 ;
BULL(IVMARRAY) ; Description: This function will generate a MailMan message contianing the extract results.
 ;
 ;  Input:
 ;   IVMARRAY - as local array containing extract results
 ;
 ; Output: None
 ;
 K XMZ
 N IVMTXT,IVMSITE,XMTEXT,XMSUB,XMDUZ,XMY
 N DIFROM  ; must new DIFROM when calling MailMan
 ;
 ; init variables
 S IVMSITE=$$SITE^VASITE
 S XMSUB="Patch IVM*2*19 Extract Results "_"("_$P(IVMSITE,"^",3)_")"
 S XMDUZ=.5
 S XMY(DUZ)="",XMY(.5)="",XMY("G.ENROLLMENT EXTRACT@IVM.DOMAIN.EXT")=""
 S XMTEXT="IVMTXT("
 ;
 S IVMTXT(1)="    > > > >  Patch IVM*2*19 Extract Results  < < < <"
 S IVMTXT(2)=""
 S IVMTXT(3)="               Facility Name:  "_$P(IVMSITE,"^",2)
 S IVMTXT(4)="              Station Number:  "_$P(IVMSITE,"^",3)
 S IVMTXT(5)=""
 S IVMTXT(6)="   Date/Time extract started:  "_$$FMTE^XLFDT(IVMARRAY("START"),"1P")
 S IVMTXT(7)="   Date/Time extract stopped:  "_$$FMTE^XLFDT(IVMARRAY("STOP"),"1P")
 S IVMTXT(8)=""
 S IVMTXT(9)="    Total patients processed:  "_IVMARRAY("PROC")
 S IVMTXT(10)="    Total patients extracted:  "_IVMARRAY("EXTRACT")
 S IVMTXT(11)="        Percentage extracted:  "_$S($G(IVMARRAY("PROC")):$P(IVMARRAY("EXTRACT")/IVMARRAY("PROC")*100,".")_"%",1:"")
 S IVMTXT(12)=""
 S IVMTXT(13)="  The "_IVMARRAY("EXTRACT")_" patients extracted will be included in the next daily"
 S IVMTXT(14)="  transmission(s) to the Health Eligibility Center (HEC)."
 ;
 D ^XMD
 Q
