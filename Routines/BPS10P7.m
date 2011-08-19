BPS10P7 ;OAK/ELZ - BPS*1*7 PRE/POST INSTALL ROUTINE ;6/9/08  11:02
 ;;1.0;E CLAIMS MGMT ENGINE;**7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PRE ; pre-install of BPS*1*7
 ;
 ; delete the following files (leaving the data), the actual
 ; install of BPS*1*7 will re-install the updated files.
 ;          9002313.91 -- BPS NCPDP FIELD DEFS
 ;          9002313.92 -- BPS NCPDP FORMATS
 ;          9002313.93 -- BPS NCPDP REJECT CODES ** REMOVE DATA **
 ;          9002313.59 -- BPS TRANSACTION
 ;          9002313.02 -- BPS CLAIMS
 ;          9002313.03 -- BPS RESPONSES
 ;          9002313.56 -- BPS PHARMACIES
 ;          9002313.57 -- BPS LOG OF TRANSACTIONS
 ;          9002313.77 -- BPS REQUESTS
 ;          9002313.78 -- BPS INSURER DATA
 ;          9002313.99 -- BPS SETUP
 ;
 ; DBIA2172,DBIA10141,DBIA10014
 ;
 N BPSX,DIU,XPDIDTOT,BPSC,BPSP
 D MES^XPDUTL("  Starting pre-install of BPS*1*7")
 S XPDIDTOT=11,BPSC=0
 D MES^XPDUTL("  - Deleting files to be restored during install.")
 F BPSX=9002313.91,9002313.92,9002313.93,9002313.59,9002313.02,9002313.03,9002313.56,9002313.57,9002313.77,9002313.78,9002313.99 D
 . S BPSP=$G(DILOCKTM,3)
 . D MES^XPDUTL("    - Deleting file #"_BPSX_", Waiting for hardware "_BPSP_" seconds...")
 . S DIU=BPSX
 . S DIU(0)=$S(BPSX=9002313.93:"DE",1:"E")
 . D EN^DIU2
 . S BPSC=BPSC+1
 . D UPDATE^XPDID(BPSC)
 . H BPSP  ; need to pause so we don't hit the globals too hard
 D MES^XPDUTL("  Finished pre-install of BPS*1*7")
 Q
 ;
POST ; post install for BPS*1*7
 ;   - need to build the new AD cross reference on Status
 ;     of the BPS LOG OF TRANSACTIONS so it matches the
 ;     BPS TRANSACTION file.
 ;
 ; DBIA2172,DBIA10141
 ;
 N BPSX,BPSY,BPSC,XPDIDTOT,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,BPSTIME,DIU,BPSP
 D MES^XPDUTL("  Starting post-install of BPS*1*7")
 D MES^XPDUTL("  - Building AD xref on BPS LOG OF TRANSACTIONS file")
 S XPDIDTOT=$P($G(^BPST(0)),"^",4)
 S (BPSC,BPSX)=0
 F  S BPSX=$O(^BPST(BPSX)) Q:'BPSX  S BPSC=BPSC+1,BPSY=$P($G(^BPST(BPSX,0)),"^",2) D:'(BPSC#500) UPDATE^XPDID(BPSC) I $L(BPSY) S ^BPST("AD",$E(BPSY,1,30),BPSX)=""
 ;
 ; need to clean up old fields from BPS Pharmacies 9002313.56
 D MES^XPDUTL("  - Cleaning out old data from BPS PHARMACIES")
 S BPSX=0 F  S BPSX=$O(^BPS(9002313.56,BPSX)) Q:'BPSX  K ^BPS(9002313.56,BPSX,"HOURS"),^("TCLOSE"),^("TOPEN")
 D MES^XPDUTL("  - Done cleaning out old data from BPS PHARMACIES")
 ;
 ; Clean up the old field being removed with tasked job 9002313.0301,508Sales Tax Paid
 D MES^XPDUTL("  - Queing task to clean up old data")
 S ZTRTN="DQ^BPS10P7",ZTDESC="Post Install BPS*1*7, Clean-up of Data"
 S (BPSTIME,ZTDTH)=$$FMADD^XLFDT($$NOW^XLFDT,,,5),ZTIO=""
 D ^%ZTLOAD
 I $G(ZTSK) D
 . D MES^XPDUTL("  - Task Queued, #"_ZTSK_" to run at "_$$FMTE^XLFDT(BPSTIME))
 E  D MES^XPDUTL("  - ERROR:  Task not queued!!!")
 ;
 ; populate new fields in setup file
 D MES^XPDUTL("   - Setting up New Insurer Asleep fields in site param file")
 S:$P($G(^BPS(9002313.99,1,0)),"^",5)="" $P(^(0),"^",5)=20
 S:$P($G(^BPS(9002313.99,1,0)),"^",6)="" $P(^(0),"^",6)=10
 D MES^XPDUTL("   - New Insurer Asleep fields set")
 ;
 ; delete the following obsolete files leaving no data
 ;         9002313.82103 BPS NCPDP FIELD 103
 ;         9002313.82305 BPS NCPDP FIELD 305
 ;         9002313.82306 BPS NCPDP FIELD 306
 ;         9002313.82307 BPS NCPDP FIELD 307
 ;         9002313.82308 BPS NCPDP FIELD 308
 ;         9002313.82309 BPS NCPDP FIELD 309
 ;         9002313.82406 BPS NCPDP FIELD 406
 ;         9002313.82408 BPS NCPDP FIELD 408
 ;         9002313.82416 BPS NCPDP FIELD 416
 ;         9002313.82419 BPS NCPDP FIELD 419
 ;         9002313.8242  BPS NCPDP FIELD 420
 ;         9002313.82423 BPS NCPDP FIELD 423
 ;         9002313.82425 BPS NCPDP FIELD 425
 ;         9002313.82429 BPS NCPDP FIELD 429
 ;         9002313.82432 BPS NCPDP FIELD 432
 ;         9002313.82436 BPS NCPDP FIELD 436
 ;         9002313.82439 BPS NCPDP FIELD 439
 ;         9002313.8244  BPS NCPDP FIELD 440
 ;         9002313.82441 BPS NCPDP FIELD 441
 ;         9002313.82461 BPS NCPDP FIELD 461
 ;         9002313.82501 BPS NCPDP FIELD 501
 ;         9002313.82522 BPS NCPDP FIELD 522
 ;         9002313.82528 BPS NCPDP FIELD 528
 ;         9002313.82529 BPS NCPDP FIELD 529
 ;         9002313.82532 BPS NCPDP FIELD 532
 ;         9002313.82533 BPS NCPDP FIELD 533
 ;         9002313.82535 BPS NCPDP FIELD 535
 ;
 ; DBIA2172,DBIA10141,DBIA10014
 ;
 D MES^XPDUTL("   - Deleting obsolete files.")
 S XPDIDTOT=27,BPSC=0
 F BPSY=1:1 S BPSX=$P($T(DELFILE+BPSY),";",3) Q:BPSX=""  D
 . S BPSP=$G(DILOCKTM,3)
 . D MES^XPDUTL("    - Deleting obsolete file #"_BPSX_", Waiting for hardware "_BPSP_" seconds...")
 . S DIU=BPSX,DIU(0)="EDT"
 . D EN^DIU2
 . S BPSC=BPSC+1
 . D UPDATE^XPDID(BPSC)
 . H BPSP  ; need to pause so we don't hit the globals too hard
 ;
 D MES^XPDUTL("  Finished post-install of BPS*1*7")
 Q
 ;
DQ ; taskman entry to clean up data
 N BPSX,BPSY,Y,%DT,X
 S BPSX=0 F  S BPSX=$O(^BPSR(BPSX)) Q:'BPSX  S BPSY=0 F  S BPSY=$O(^BPSR(BPSX,1000,BPSY)) Q:'BPSY  D
 . I $D(^BPSR(BPSX,1000,BPSY,500)) S $P(^(500),"^",8)=""
 ;
 ; reset *M Vendor field to be null if a date is not stored there
 I $L($P($G(^BPS(9002313.99,1,0)),"^",4)),$E($P(^(0),"^",4),1,7)'?7N S $P(^(0),"^",4)=""
 ;
 ; Cleaning up BPS Claims file, Date Reopened field (906)
 ; some data stored in there is in external format, like 8-31-2006@13:20:04
 S BPSX=0 F  S BPSX=$O(^BPSC(BPSX))  Q:'BPSX  D
 . S BPSY=$P($G(^BPSC(BPSX,900)),"^",6)
 . I '$L(BPSY) Q
 . I $E(BPSY,1,7)?7N Q
 . S %DT="PT",X=$P(BPSY,"@")
 . D ^%DT
 . I Y>0 S $P(^BPSC(BPSX,900),"^",6)=+(Y_$S(BPSY["@":"."_$TR($P(BPSY,"@",2),":"),1:""))
 ;
 ; clean out the data for:
 ;  ^BPSC(ien,400,"AC")
 ;  $P(^BPSC(BPS(9002313.02),400,0),"^",3)
 S BPSX=0 F  S BPSX=$O(^BPSC(BPSX)) Q:'BPSX  K ^BPSC(BPSX,400,"AC")  S BPSY=0 F  S BPSY=$O(^BPSC(BPSX,400,BPSY)) Q:'BPSY  I $L($G(^BPSC(BPSX,400,BPSY,0))) S $P(^(0),"^",3)=""
 ;
 Q
DELFILE ; list of files to go bye bye with their data
 ;;9002313.82103
 ;;9002313.82305
 ;;9002313.82306
 ;;9002313.82307
 ;;9002313.82308
 ;;9002313.82309
 ;;9002313.82406
 ;;9002313.82408
 ;;9002313.82416
 ;;9002313.82419
 ;;9002313.82423
 ;;9002313.82425
 ;;9002313.82429
 ;;9002313.82432
 ;;9002313.82436
 ;;9002313.8244
 ;;9002313.82441
 ;;9002313.82501
 ;;9002313.82522
 ;;9002313.82528
 ;;9002313.82529
 ;;9002313.82532
 ;;9002313.82533
 ;;9002313.82535
 ;;9002313.8242
 ;;9002313.82439
 ;;9002313.82461
 ;;
 ;
