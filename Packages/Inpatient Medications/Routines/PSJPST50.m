PSJPST50 ;BIR/MV-POE POST INIT ;6 DEC 00 / 3:11 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**50**;16 DEC 97
 ;
POE ;Queue IV conversion to re-allign OI
 Q:$$PATCH^XPDUTL("PSJ*5.0*50")
 S ZTDTH=$H,ZTRTN="CNIV^PSJUTL1()",ZTIO="",ZTDESC="Inpatient medications order conversion"
 D ^%ZTLOAD
 Q
