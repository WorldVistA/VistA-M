IVM228P ;ALB/SE,RTK - Means Test Utilities ;09/05/00
 ;;2.0;INCOME VERIFICATION MATCH;**28**; 21-OCT-94
 ;
 ;This routine will determine if "AC" (Means Tests) and "AD"
 ;(Copay tests) x-references are set for future tests in the
 ;IVM PATIENT file (#301.5).  If a future test without a
 ;x-reference is found, the routine will set a x-reference for
 ;it.
 ;
EN ;entry point
 D INIT
 Q
EN1 D CREATE
 D AC
 D AD
 D MULTI
 D CLEAN
 Q
 ;
 ;
INIT N %,I,X,X1,X2
 S FILERR=""
 I $D(XPDNM) D
 .I $$VERCP^XPDUTL("DGFDT")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGFDT","",DT)
 .I $$VERCP^XPDUTL("DG5IEN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DG5IEN","",0)
 .I $$VERCP^XPDUTL("DG31IEN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DG31IEN","",0)
 ;
 F I="MTRECS","MTFIX","MTERR" D
 .I $D(^XTMP("DG-"_I)) Q
 .S X1=DT
 .S X2=30
 .D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_"^"_$$DT^XLFDT_"^IVM*2*28 POST-INSTALL "_$S(I="MTRECS":"record count",I="MTFIX":"records corrected",1:"filing errors")
 ;
 I '$D(XPDNM) S (^XTMP("DG-MTRECS",1),^XTMP("DG-MTFIX",1))=0
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DGFDT") D
 .I '$D(^XTMP("DG-MTRECS",1)) S ^XTMP("DG-MTRECS",1)=0
 .I '$D(^XTMP("DG-MTFIX",1)) S ^XTMP("DG-MTFIX",1)=0
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
CREATE ;from the "B" x-reference in 408.31 create entries in the temp global
 ;
 K ^TMP("DGFUTURE",$J)
 N DGFDT,DG31IEN
 S DGFDT=DT
 F  S DGFDT=$O(^DGMT(408.31,"B",DGFDT)) Q:'DGFDT  D
 .S DG31IEN=0
 .F  S DG31IEN=$O(^DGMT(408.31,"B",DGFDT,DG31IEN)) Q:'DG31IEN  D
 ..S ^TMP("DGFUTURE",$J,DGFDT,DG31IEN)=""
 ..S ^XTMP("DG-MTRECS",1)=$G(^XTMP("DG-MTRECS",1))+1
 ..Q
 Q
 ;
 ;
AC ;delete entries in ^TMP found in the "AC" x-ref in 301.5
 N DGFDT,DG5IEN,DG31IEN,DATA,%
 S DGFDT=DT
 F  S DGFDT=$O(^IVM(301.5,"AC",DGFDT)) Q:'DGFDT  D
 .S DG5IEN=0
 .F  S DG5IEN=$O(^IVM(301.5,"AC",DGFDT,DG5IEN)) Q:'DG5IEN  D
 ..S DG31IEN=0
 ..S DG31IEN=$O(^IVM(301.5,"AC",DGFDT,DG5IEN,DG31IEN)) Q:'DG31IEN  D
 ...I $D(^TMP("DGFUTURE",$J,DGFDT,DG31IEN)) D
 ....K ^TMP("DGFUTURE",$J,DGFDT,DG31IEN)
 ....I $P(^IVM(301.5,DG5IEN,0),"^",6)="" S DATA(.06)=DG31IEN I '$$UPD^DGENDBS(301.5,DG5IEN,.DATA) S FILERR(301.5,DG31IEN)="Unable to access cross reference"
 ....I $G(FILERR) M ^XTMP("DG-MTERR")=FILERR K FILERR
 ...I $D(XPDNM) S %=$$UPCP^XPDUTL("DG31IEN",DG31IEN)
 ..I $D(XPDNM) S %=$$UPCP^XPDUTL("DG5IEN",DG5IEN)
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGFDT",DGFDT)
 Q
 ;
 ;
AD ;delete entries in ^TMP found in the "AD" x-ref in 301.5
 N DGFDT,DG5IEN,DG31IEN,DATA,%
 S DGFDT=DT
 F  S DGFDT=$O(^IVM(301.5,"AD",DGFDT)) Q:'DGFDT  D
 .S DG5IEN=0
 .F  S DG5IEN=$O(^IVM(301.5,"AD",DGFDT,DG5IEN)) Q:'DG5IEN  D
 ..S DG31IEN=0
 ..S DG31IEN=$O(^IVM(301.5,"AD",DGFDT,DG5IEN,DG31IEN)) Q:'DG31IEN  D
 ...I $D(^TMP("DGFUTURE",$J,DGFDT,DG31IEN)) D
 ....K ^TMP("DGFUTURE",$J,DGFDT,DG31IEN)
 ....I $P(^IVM(301.5,DG5IEN,0),"^",7)="" S DATA(.07)=DG31IEN I '$$UPD^DGENDBS(301.5,DG5IEN,.DATA) S FILERR(301.5,DG31IEN)="Unable to access cross reference"
 ....I $G(FILERR) M ^XTMP("DG-MTERR")=FILERR K FILERR
 ...I $D(XPDNM) S %=$$UPCP^XPDUTL("DG31IEN",DG31IEN)
 ..I $D(XPDNM) S %=$$UPCP^XPDUTL("DG5IEN",DG5IEN)
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGFDT",DGFDT)
 Q
 ;
 ;
MULTI ;since there can be multi future tests for a patient, check to see
 ;if there is a value in the patient's 1999 income year record in
 ;file #301.5 in the 6th piece (means test ien) or the 7th piece
 ;(copay test ien).  delete entry in the ^TMP if there is a pointer
 ;to the 408.31 file in either field.
 ;
 N DFN,DGFDT,DG31IEN,DG5IEN,DG5IEN1,DGTYPE,ERRMSG
 S DGFDT=DT
 F  S DGFDT=$O(^TMP("DGFUTURE",$J,DGFDT)) Q:'DGFDT  D
 .S DG31IEN=0
 .F  S DG31IEN=$O(^TMP("DGFUTURE",$J,DGFDT,DG31IEN)) Q:'DG31IEN  D
 ..S DFN=$P($G(^DGMT(408.31,DG31IEN,0)),"^",2) Q:'DFN
 ..S DGTYPE=$P($G(^DGMT(408.31,DG31IEN,0)),"^",19)
 ..S DG5IEN=0
 ..S DG5IEN=$O(^IVM(301.5,"AYR",2990000,DFN,DG5IEN)) Q:'DG5IEN  D
 ...S DG5IEN1=$G(^IVM(301.5,DG5IEN,0)) Q:'DG5IEN1  D
 ....I (($P(DG5IEN1,"^",6))!($P(DG5IEN1,"^",7))) K ^TMP("DGFUTURE",$J,DGFDT,DG31IEN) Q
 ....S ERRMSG=""
 ....D ADDFUTR^IVMPLOG2(DG31IEN) I ERRMSG'="" S FILERR(301.5,DG31IEN)="Unable to create cross reference"
 ....S ^XTMP("DG-MTFIX",1)=$G(^XTMP("DG-MTFIX",1))+1
 ....I $G(FILERR) M ^XTMP("DG-MTERR")=FILERR K FILERR
 ;
 D MAIL^IVM228M
 I $D(XPDNM) S %=$$COMCP^XPDUTL("DGFDT")
 D BMES^XPDUTL(" Means test clean up routine has completed successfully.")
 Q
 ;
CLEAN K ^TMP("DGFUTURE",$J)
 Q
