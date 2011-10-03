SCMSPST ;ALB/JRP - AMB CARE POST INIT DRIVER;04-JUN-1996
 ;;5.3;Scheduling;**44**;AUG 13, 1993
CHKPTS ;Create check points for pre-init
 ;Input  : All variables set by KIDS
 ;Output : None
 ;
 ;Declare variables
 N TMP,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,SCQUEUE,X,Y,%,%H
 ;Queue task to require provider and diagnosis for checkout from clinics
 S TMP=$G(XPDQUES("POSHOPUP","B"))
 S:(TMP="") TMP="NOW"
 D BMES^XPDUTL("Background job to require provider and diagnosis for")
 D MES^XPDUTL("checkout from clinics will be queued for "_TMP)
 S ZTDTH=$G(XPDQUES("POSHOPUP"))
 S:(ZTDTH="") ZTDTH=$H
 S ZTDESC="REQUIRE PROVIDER AND DIAGNOSIS FOR CHECKOUT FROM CLINICS"
 S ZTIO=""
 S ZTRTN="HOPUP^SCMSP"
 D ^%ZTLOAD
 S ZTSK=+$G(ZTSK)
 S SCQUEUE="0000000"
 I ('ZTSK) D BMES^XPDUTL("*** Unable to queue task ***")
 I (ZTSK) D
 .D BMES^XPDUTL("Queued as task number "_ZTSK)
 .S %H=$G(ZTSK("D")) D YMD^%DTC S SCQUEUE=X_%
 ;Create check points
 ;Initialize parameters - pass Queue Time & Task Number
 S TMP=$$NEWCP^XPDUTL("SCMS01","PARAM^SCMSP",SCQUEUE_"-"_ZTSK)
 ;Attach mail group to Ambulatory Care xmit summary bulletin
 S TMP=$$NEWCP^XPDUTL("SCMS02","MG4BULL^SCMSP")
 ;Enable event driver
 S TMP=$$NEWCP^XPDUTL("SCMS03","FIXEVNT^SCMSP1")
 ;Fix server protocol
 S TMP=$$NEWCP^XPDUTL("SCMS04","FIXSRVR^SCMSP1")
 ;Fix client protocol
 S TMP=$$NEWCP^XPDUTL("SCMS05","FIXCLNT^SCMSP1")
 ;Install correct version of SDM routine
 S TMP=$$NEWCP^XPDUTL("SCMS06","SDM^SCMSP")
 ;Done
 Q
