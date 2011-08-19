DG53672R ;ALB/BRM;Clean-up Other EC of Reimbursable Insurance ; 9/6/05 7:39am
 ;;5.3;Registration;**672**;Aug 13,1993
 ;;
 ;
 ; Called from inside Patient File (#2) loop in DG53672C.
 ;
RSETUP(ELIG) ; entry point
 N EC81,EC8
 ; get local codes assigned to the national Reimbursable code
 S EC81=$O(^DIC(8.1,"B","REIMBURSABLE INSURANCE",""))
 S EC8=""
 F  S EC8=$O(^DIC(8,"D",EC81,EC8)) Q:'EC8  S ELIG(EC8)=""
 Q
 ;
REIM(DFN,RIELIG) ;check for Eligibility Code of Reimbursable Insurance
 N EC8,IEN,QFLG,PRIMEC,DOD
 S DOD=$P($G(^DPT(DFN,.35)),"^")  ;Date of Death
 S PRIMEC=$P($G(^DPT(DFN,.36)),"^"),EC8=""
 F  S EC8=$O(RIELIG(EC8)) Q:'EC8  D
 .Q:'$D(^DPT(DFN,"E","B",EC8))
 .S IEN="",QFLG=0
 .F  S IEN=$O(^DPT(DFN,"E","B",EC8,IEN)) Q:'IEN  D
 ..I PRIMEC=EC8,'$G(QFLG) S QFLG=1 S:'DOD ^XTMP("DG53672C","DG53672R","PRIMCNT")=$G(^XTMP("DG53672C","DG53672R","PRIMCNT"))+1 Q
 ..S ^XTMP("DG53672C","DG53672R","CNT")=$G(^XTMP("DG53672C","DG53672R","CNT"))+1
 ..S ^XTMP("DG53672C","DG53672R","DATA",DFN)=EC8_"^"_$$EXTERNAL^DILFD(2.0361,.01,"",EC8)
 ..D KILL(DFN,IEN)
 Q
 ;
KILL(DFN,IEN) ;
 ; Delete Reimbursable Insurance entry.
 N DA,DATA,DIK
 S DA(1)=DFN,DA=IEN,DIK="^DPT("_DA(1)_",""E"","
 D ^DIK
 Q
SNDMSG ; Send Mailman bulletin when process completes
 N DIFROM,SITE,STATN,SITENM,XMDUZ,XMSUB,XMY,XMTEXT,MSG
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),U,3),SITENM=$P($G(SITE),U,2)
 S:$$GET1^DIQ(869.3,"1,",.03,"I")'="P" STATN=STATN_" [TEST]"
 S XMDUZ="REIMBURSABLE INS OTHER EC CLEANUP",XMSUB=XMDUZ_" - "_STATN
 S (XMY(DUZ),XMY("HECDQSUPPORT@med.va.gov"))=""
 S XMTEXT="MSG("
 S MSG(1)="The Reimbursable Insurance Other Eligibility clean-up process has completed successfully."
 S MSG(2)="This process searched for patient records with an other eligibility code of"
 S MSG(3)="Reimbursable Insurance, and deleted it as the code is no longer active."
 S MSG(4)=""
 S MSG(5)="Task: "_$G(^XTMP("DG53672C",0,"TASK"))
 S MSG(6)="Site Station Number: "_STATN
 S MSG(7)="Site Name: "_SITENM
 S MSG(8)=""
 S MSG(9)="Process started   : "_$$FMTE^XLFDT($P($G(^XTMP("DG53672C",0)),U,2))
 S MSG(10)="Process completed : "_$$FMTE^XLFDT($P($G(^XTMP("DG53672C",0)),"^",4))
 S MSG(10.5)=""
 S MSG(11)="Total Patients processed             : "_+$G(^XTMP("DG53672C","TCNT"))
 S MSG(12)="Total non-Primary Reimbursable ECs Removed : "_+$G(^XTMP("DG53672C","DG53672R","CNT"))
 S MSG(12.1)="Total Reimbursable Primary ECs*      : "_+$G(^XTMP("DG53672C","DG53672R","PRIMCNT"))
 S MSG(12.2)="  *Primary Reimbursable ECs were not removed, and sites must review"
 S MSG(12.3)=" and fix manually by assigning a new Primary EC."
 S MSG(12.5)=""
 S MSG(13)="To identify patients at the site for whom the non-Primary Reimbursable"
 S MSG(14)=" Insurance Eligibility Code was removed, the IRM or person(s) responsible"
 S MSG(14.5)=" for installing the patch can review the following global:"
 S MSG(15)="    ^XTMP(""DG53672C"",""DG536572R"",""DATA"",DFN)"
 S MSG(16)=" DFN = internal entry number of the Patient file (#2)."
 D ^XMD
 Q
