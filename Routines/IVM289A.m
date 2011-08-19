IVM289A ;ALB/RMM IVM Patient File Xref Cleanup Utility ; 01/27/2004
 ;;2.0;INCOME VERIFICATION MATCH;**89**;21-OCT-94
 ;
 ; Global Counter Storage Details:
 ; ^XTMP("IVM289",0,"IVM")   Count of invalid 301.5 pointers
 ; ^XTMP("IVM289",0,"DGMT")  Count of invalid 408.31 pointers
 ; ^XTMP("IVM289",0,"DUP")   Count of Duplicate xref entries
 ; ^XTMP("IVM289",0,"TOT")   Total count of all xrefs
 ; ^XTMP("IVM289",0,"DEL")   Total count of all xrefs purged
 ;
EN ; Begin processing
 ; Write message to installation device and to INSTALL file (#9.7)
 D BMES^XPDUTL("IVM Patient File Xref Cleanup Post Install")
 D MES^XPDUTL("When the the cleanup has completed, a MailMan message")
 D MES^XPDUTL("messawill bt containing a recap of the deleted")
 D MES^XPDUTL("cross references.")
 D BMES^XPDUTL("Beginning clean-up process "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
INIT ; Initialize tracking global (See text above for description)
 N %,X,X1,X2,I
 S X1=DT,X2=120 D C^%DTC
 S ^XTMP("IVM289",0)=X_"^"_$$DT^XLFDT_"^IVM Patient File Xref Cleanup"
 ;
 F I="IVM","DGMT","DUP","TOT","DEL" S ^XTMP("IVM289",0,I)=0
 ;
START ;
 N TYPE,FDATE,IVMPAT,MTIEN
 F TYPE="AC","AD" D
 .S FDATE=0
 .F  S FDATE=$O(^IVM(301.5,TYPE,FDATE)) Q:('FDATE)  D
 ..S IVMPAT=0
 ..F  S IVMPAT=$O(^IVM(301.5,TYPE,FDATE,IVMPAT)) Q:'IVMPAT  D
 ...S MTIEN=$O(^IVM(301.5,TYPE,FDATE,IVMPAT,""),-1)
 ...;
 ...D CKMULT
 ...I FDATE<DT D DUP,TOT,DEL,DELX(MTIEN) Q
 ...;
 ...I '$D(^IVM(301.5,IVMPAT,0)) D IVM,TOT,DEL,DELX(MTIEN) Q
 ...;
 ...I '$D(^DGMT(408.31,MTIEN,0)) D DGMT,TOT,DEL,DELX(MTIEN) Q
 ...;
 ...D TOT
 ;
 ;
 ; Send a mailman msg to the user with the results
 D MAIL^IVM289M
 D MES^XPDUTL(" >>clean-up process completed "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
 ;
CKMULT ; Remove duplicate entries from cross reference, leaving last entry
 N MTREC S MTREC=0
 F  S MTREC=$O(^IVM(301.5,TYPE,FDATE,IVMPAT,MTREC)) Q:(MTREC=MTIEN!('MTREC))  D DUP,TOT,DEL,DELX(MTREC)
 Q
 ;
 ; Delete Cross Reference
DELX(MTIEN) K ^IVM(301.5,TYPE,FDATE,IVMPAT,MTIEN) Q
 ;
 ; Increment Global Counters
IVM S ^XTMP("IVM289",0,"IVM")=^XTMP("IVM289",0,"IVM")+1 Q
DGMT S ^XTMP("IVM289",0,"DGMT")=^XTMP("IVM289",0,"DGMT")+1 Q
DUP S ^XTMP("IVM289",0,"DUP")=^XTMP("IVM289",0,"DUP")+1 Q
TOT S ^XTMP("IVM289",0,"TOT")=^XTMP("IVM289",0,"TOT")+1 Q
DEL S ^XTMP("IVM289",0,"DEL")=^XTMP("IVM289",0,"DEL")+1 Q
 Q
