DG53294A ;ALB/RTK - Means Test Utilities ;10/20/00
 ;;5.3;Registration;**294**;Aug 13, 1993
 ;
 ;This routine will edit the newly added ELIGIBILITY VERIF. 
 ;SOURCE (.3613) field of the PATIENT (#2) file to populate it
 ;for use with new logic that is being implemented as part of 
 ;the Ineligible project.  The source will be set as follows:
 ;
 ;If the ELIGIBILITY VERIF. METHOD (.3615) is VIVA, and the
 ;entity verifying (.3616) is POSTMASTER, the source field 
 ;will be set to HEC.
 ;
 ;All other patient records with an existing eligibility node
 ;(.361) will be set to HEC.
 ;
EN N DATA,LFDATE,DFN,I,X,X1,X2,%
 S (ERRMSG,FILERR)=""
 I $D(XPDNM) D
 .I $$VERCP^XPDUTL("LFDATE")'>0 D
 ..S %=$$NEWCP^XPDUTL("LFDATE","","0")
 .I $$VERCP^XPDUTL("DFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DFN","","0")
 ;
 F I="SRCREC","SRCSET","SRCERR" D
 .I $D(^XTMP("DG-"_I)) Q
 .S X1=DT
 .S X2=30
 .D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_"^"_$$DT^XLFDT_"^DG*5.3*294 POST-INSTALL "_$S(I="SRCREC":"record count",I="SRCSET":"records corrected",1:"filing errors")
        ;
 I '$D(XPDNM) S (^XTMP("DG-SRCREC",1),^XTMP("DG-SRCSET",1))=0
 I $D(XPDNM)&'$D(^XTMP("DG-SRCREC",1)) S ^XTMP("DG-SRCREC",1)=0
 I $D(XPDNM)&'$D(^XTMP("DG-SRCSET",1)) S ^XTMP("DG-SRCSET",1)=0
 I $D(XPDNM) S %=$$VERCP^XPDUTL("LFDATE")
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
EN1 I '$D(XPDNM) S LFDATE=""
 I $D(XPDNM) S LFDATE=$$PARCP^XPDUTL("LFDATE")
 S DFN="",RECSET=0
 F  S LFDATE=$O(^DPT("B",LFDATE)) Q:LFDATE=""  D
 .F  S DFN=$O(^DPT("B",LFDATE,DFN)) Q:DFN=""  D
 ..I '$D(^DPT(DFN,0)) S FILERR(2,DFN,"ALL")="Patient record "_DFN_" does not exist." M ^XTMP("DG-SRCERR")=FILERR K FILERR Q
 ..I $D(^DPT(DFN,.361)) D
 ...S ^XTMP("DG-SRCREC",1)=$G(^XTMP("DG-SRCREC",1))+1
 ...I $P(^DPT(DFN,.361),U,5)["VIVA",($P(^DPT(DFN,.361),U,6)=.5) D
 ....S DATA(.3613)="H",RECSET=1 I $$UPD^DGENDBS(2,DFN,.DATA) S ^XTMP("DG-SRCSET",1)=$G(^XTMP("DG-SRCSET",1))+1
 ...I $P(^DPT(DFN,.361),U,5)'["VIVA"!($P(^DPT(DFN,.361),U,6)'=.5) D
 ....S DATA(.3613)="V",RECSET=1 I $$UPD^DGENDBS(2,DFN,.DATA) S ^XTMP("DG-SRCSET",1)=$G(^XTMP("DG-SRCSET",1))+1
 ...I 'RECSET S FILERR(2,DFN,"ALL")="Unable to edit patient record "_DFN_"." Q
 ...S RECSET=0
 ..I $G(FILERR) M ^XTMP("DG-SRCERR")=FILERR K FILERR
 ..I $D(XPDNM) S %=$$UPCP^XPDUTL("DFN",DFN)
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("LFDATE",LFDATE)
 D MAIL^DG53294M
 I $D(XPDNM) S %=$$COMCP^XPDUTL("LFDATE")
 D BMES^XPDUTL(" ELIGIBILITY VERIF. SOURCE edit process is complete.")
 Q
