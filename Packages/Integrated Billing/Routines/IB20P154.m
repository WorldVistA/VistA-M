IB20P154 ;ALB/BGA - IB V2.0 POST INIT,UPDATE DENTAL ENTRY IN RATE TYPE FILE ; 5-16-2001
 ;;2.0;INTEGRATED BILLING;**154**;21-MAR-94
 ;
 ; Post Init Description: This init will UPDATE the Dental entry 
 ; in the RATE TYPE file #399.3. This post init is associated with 
 ; patch *154*
 ;
 ; Control Logic
 D UPDATE  ; Update entries in #399.3
 D LAST    ; End Task
 Q
 ;
 ;
 ;
 ;
 ;
UPDATE ; Update entries in the Rate Type file #399.3
 N IBLOOK,IBINC,IBROWZ,IBZ,IBZIEN
 D BMES^XPDUTL(">>>Updating the 'DENTAL' entry in the RATE TYPE file #399.3 ...")
 F IBZ=1:1 S IBROWZ=$P($T(MODZ+IBZ),";;",2) Q:IBROWZ="QUIT"  D
 . S IBLOOK=$P(IBROWZ,U),IBZIEN=$O(^DGCR(399.3,"B",IBLOOK,0))
 . I '$D(^DGCR(399.3,+IBZIEN,0)) D  Q
 . . S IBARR(1)=" >> The 'DENTAL' entry could not be found in this file."
 . . S IBARR(2)="    If you have a different entry in this file that"
 . . S IBARR(3)="    represents DENTAL (such as 'INELIGIBLE DENTAL')"
 . . S IBARR(4)="    you will need to manually change this."
 . . S IBARR(5)="    Please use the following option to change the value"
 . . S IBARR(6)="    of the ACCOUNTS RECEIVABLE CATEGORY (#.06) field"
 . . S IBARR(7)="    to EMERGENCY/HUMANITARIAN:"
 . . S IBARR(8)="    Enter/Edit Charge Master (IBCR DISPLAY CHARGE"
 . . S IBARR(9)="    MASTER) located on the MCCR System Definition Menu."
 . . D BMES^XPDUTL(.IBARR) K IBARR
 . I $P($G(^DGCR(399.3,IBZIEN,0)),U,6)'=$P(IBROWZ,U,6) D  Q
 . . S IBINC=$P($G(^DGCR(399.3,IBZIEN,0)),U,6)
 . . S DA=IBZIEN,DIE="^DGCR(399.3,",DR=".06////"_$P(IBROWZ,U,6)
 . . D ^DIE K DIE,DA,DR
 . . D BMES^XPDUTL(">> The ACCOUNTS RECEIVABLE CATEGORY field for the 'DENTAL'")
 . . D MES^XPDUTL("   entry has been changed from 'INELIGIBLE HOSP.'")
 . . D MES^XPDUTL("   to 'EMERGENCY/HUMANITARIAN'.")
 . D BMES^XPDUTL(">> The 'DENTAL' entry did not require an update.")
 Q
 ;
MODZ ; Update entries that are currently incorrect in file #399.3 Rate Type
 ;;DENTAL^DENTAL^^DENTAL^0^2^p^^1
 ;;QUIT
 ;
LAST ;
 D BMES^XPDUTL(">>>ALL POST-INIT Activities have been completed. <<<")
 Q
