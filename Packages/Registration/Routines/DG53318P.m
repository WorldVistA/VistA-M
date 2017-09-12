DG53318P ;RTK - Means Test Utilities ;09/22/00
 ;;5.3;Registration;**318**;Aug 13, 1993
 ;This routine will edit the SOURCE OF INCOME TEST (.23) field
 ;of the ANNUAL MEANS TEST (#408.31) file to synchronize it
 ;with new logic that has been implemented at HEC.  The source
 ;will be set as follows:
 ;
 ;If the means test:
 ;    Originated at this site, the source will be set to VAMC
 ;    Originated at another site, the source will be set to
 ;        OTHER FACILITY.
 ;
 ;If the site is 742(HEC) or the source is NULL or 2(IVM), no
 ; action will be taken.
 ;
EN N DATA,SDATE,MTIEN,ULINE,STATION,NSITE,OSITE,TSOURCE,I,X,X1,X2,%
 S (ERRMSG,FILERR)=""
 I $D(XPDNM) D
 .I $$VERCP^XPDUTL("SDATE")'>0 D
 ..S %=$$NEWCP^XPDUTL("SDATE","","2970101")
 .I $$VERCP^XPDUTL("MTIEN")'>0 D
 ..S %=$$NEWCP^XPDUTL("MTIEN","","0")
 ;
 F I="RECRD","FIXED","ERORS" D
 .I $D(^XTMP("DG-"_I)) Q
 .S X1=DT
 .S X2=30
 .D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_"^"_$$DT^XLFDT_"^DG*5.3*318 POST-INSTALL "_$S(I="RECRD":"record count",I="FIXED":"records corrected",1:"filing errors")
        ;
 I '$D(XPDNM) S (^XTMP("DG-RECRD",1),^XTMP("DG-FIXED",1))=0
 I $D(XPDNM)&'$D(^XTMP("DG-RECRD",1)) S ^XTMP("DG-RECRD",1)=0
 I $D(XPDNM)&'$D(^XTMP("DG-FIXED",1)) S ^XTMP("DG-FIXED",1)=0
 I $D(XPDNM) S %=$$VERCP^XPDUTL("SDATE")
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
EN1 S SDATE=2970101,MTIEN=""
 S STATION=$P($$SITE^VASITE,U,3)
 F  S SDATE=$O(^DGMT(408.31,"B",SDATE)) Q:SDATE=""  D
 .F  S MTIEN=$O(^DGMT(408.31,"B",SDATE,MTIEN)) Q:MTIEN=""  D
 ..I '$D(^DGMT(408.31,MTIEN,0)) S FILERR(408.31,MTIEN,"ALL")="Means test missing for record "_MTIEN_"." M ^XTMP("DG-ERORS")=FILERR K FILERR Q
 ..S ULINE=$G(^DGMT(408.31,MTIEN,2))
 ..S ^XTMP("DG-RECRD",1)=$G(^XTMP("DG-RECRD",1))+1
 ..S OSITE=$P(ULINE,U,5),TSOURCE=$P($G(^DGMT(408.31,MTIEN,0)),U,23)
 ..I (OSITE="")!(OSITE[742)!(TSOURCE=2) Q
 ..I (OSITE[STATION)&(TSOURCE'=1) S DATA(.23)=1 D
 ...I $$UPD^DGENDBS(408.31,MTIEN,.DATA) S ^XTMP("DG-FIXED",1)=$G(^XTMP("DG-FIXED",1))+1
 ...E  S FILERR(408.31,MTIEN,"ALL")="Unable to edit means test "_MTIEN_"." Q
 ..I (OSITE'[742)&(OSITE'[STATION)&(TSOURCE'=4) S DATA(.23)=4 D
 ...I $$UPD^DGENDBS(408.31,MTIEN,.DATA) S ^XTMP("DG-FIXED",1)=$G(^XTMP("DG-FIXED",1))+1
 ...E  S FILERR(408.31,MTIEN,"ALL")="Unable to edit means test "_MTIEN_"." Q
 ..I $G(FILERR) M ^XTMP("DG-ERORS")=FILERR K FILERR
 ..I $D(XPDNM) S %=$$UPCP^XPDUTL("MTIEN",MTIEN)
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("SDATE",SDATE)
 D MAIL^DG53318M
 I $D(XPDNM) S %=$$COMCP^XPDUTL("SDATE")
 D BMES^XPDUTL(" SOURCE OF INCOME TEST edit process is complete.")
 Q
