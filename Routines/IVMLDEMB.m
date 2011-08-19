IVMLDEMB ;ALB/PHH - IVM DEMOGRAPHIC UPLOAD FILE DATE OF DEATH FIELDS ; 04/17/2009
 ;;2.0;INCOME VERIFICATION MATCH;**131**; 21-OCT-94;Build 2
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
CKINPAT(DFN) ; Check if InPatient
 ; Function returns 1 if yes, 0 if no
 N RETVAL
 S RETVAL=0
 S RETVAL=$$CURINPAT^DGENPTA(DFN)
 Q RETVAL
AUTOREJ ; Auto Reject a DOD
 ; - loop through DOD fields
 F DODFIELD="ZPD09","ZPD31","ZPD32" D
 .S IVMI=$O(^IVM(301.92,"C",DODFIELD,"")) I IVMI="" Q
 .S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,"")) Q:IVMJ']""  D
 ..;
 ..; - check for data node in (#301.511) sub-file
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0)) Q:'(+IVMNODE)
 ..;
 ..I DODFIELD="ZPD09" D
 ...S DODREJDT=$P(IVMNODE,"^",2)
 ..;
 ..; - remove entry from (#301.511) sub-file
 ..D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 ;
 D CLEAN^IVMLDEMD(IVMDA2)
 Q
SNDBULL ; Send MailMan Bulletin to HEC to remove DOD
 N DGBULL,DGLINE,DGMGRP,DGNAME,DGSSN,DIFROM,VA,VAERR,XMTEXT,XMSUB,XMDUZ
 S DGMGRP=$O(^XMB(3.8,"B","DGEN ELIGIBILITY ALERT",""))
 Q:'DGMGRP
 I $$FMTE^XLFDT($G(DODREJDT))="" Q
 D XMY^DGMTUTL(DGMGRP,0,1)
 S DGNAME=$P($G(^DPT(DFN,0)),"^"),DGSSN=$P($G(^DPT(DFN,0)),"^",9)
 S XMTEXT="DGBULL("
 S XMSUB="Date of Death Transmission Error"
 S XMDUZ="DEATH TRANSMISSION TO STATION #"_$P($$SITE^VASITE,"^")
 S DGLINE=0
 D LINE^DGEN("A Death Demographic (ORU~Z05) HL7 Message was received",.DGLINE)
 D LINE^DGEN("at Station #"_$P($$SITE^VASITE,"^")_" for the following patient:",.DGLINE)
 D LINE^DGEN("",.DGLINE)
 D LINE^DGEN("         Name: "_$P($$PT^IVMUFNC4(DFN),"^"),.DGLINE)
 D LINE^DGEN("          SSN: "_$P($G(^DPT(DFN,0)),"^",9),.DGLINE)
 D LINE^DGEN("          DOB: "_$$FMTE^XLFDT($P($G(^DPT(DFN,0)),"^",3)),.DGLINE)
 D LINE^DGEN("          DOD: "_$$FMTE^XLFDT($G(DODREJDT)),.DGLINE)
 D LINE^DGEN("",.DGLINE)
 D LINE^DGEN("The veteran is an inpatient at this site. Please",.DGLINE)
 D LINE^DGEN("remove the Date of Death information for this veteran.",.DGLINE)
 D LINE^DGEN("",.DGLINE)
 D ^XMD
 Q
