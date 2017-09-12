SD53151P ;ALB/ABR - DSS CLINIC STOP CODE FILE FOR DISTRIBUTION DRIVER; 9/18/98
 ;;5.3;Scheduling;**151**;AUG 13, 1993
 ;
 ;  Driver to update sites 40.7 files to correspond with 
 ;  Nationally Distributed codes.  Local codes (450-485)
 ;  will not be affected.
 ;
EN ; driver entry point
 N SDI,SDX,SDTX,SDTM
 ;  Print list of flags used
 F SDTX=1:1 S SDTM=$P($T(MSGT+SDTX),";;",2) Q:SDTM="QUIT"  D MES^XPDUTL(SDTM)
 ;
 ;  Get data from other routines
 F SDI=1:1 S SDX=$P($T(DATA+SDI^SD53151A),";;",2) Q:SDX="QUIT"  D UPDATE
 F SDI=1:1 S SDX=$P($T(DATA+SDI^SD53151B),";;",2) Q:SDX="QUIT"  D UPDATE
 Q
 ;
UPDATE ;
 N DIC,X,Y,DLAYGO,SDA,SDC,SDJ,SDY,SDM,SDZ
 S DIC="^DIC(40.7,",DIC(0)="LMXZ",DLAYGO=40.7
 S SDC=$P(SDX,U,2),X=$P(SDX,U)
 F SDA=0:0 S SDA=$O(^DIC(40.7,"C",SDC,SDA)) Q:'SDA  S Y=SDA,Y(0)=$G(^DIC(40.7,Y,0)) D UPD
 Q:$G(Y)  ; existing data already checked/updated
 D ^DIC I Y<0 D BMES^XPDUTL("** Unable to find or add STOP CODE "_SDC),MES^XPDUTL("**Please contact Support")
 ;
UPD I $P(Y(0),U)=$P(SDX,U),$P(Y(0),U,2)=$P(SDX,U,2),$P(Y(0),U,3)=$P(SDX,U,3),$P(Y(0),U,5)=$P(SDX,U,4) Q  ; no update needed
 ;
 S SDZ=Y
 F SDJ=1:1:4 S SDJ(SDJ)=$P(SDX,U,SDJ)  ;  from incoming
 F SDY=1:1:4 S SDM=SDY S:SDY=4 SDM=5 S SDY(SDY)=$P(Y(0),U,SDM) ; from existing 0-node
 F SDJ=3,4 I SDY(SDJ),'SDJ(SDJ) S SDJ(SDJ)="@" ; to delete CDR or inactive dates
 D EDIT,MESS
 Q
 ;
EDIT ; update entries
 N DIE,DA,DR,X,Y
 S DIE=DIC,DA=+SDZ,DR=".01///"_SDJ(1)_";1///"_SDC_";2///"_SDJ(3)_";4///"_SDJ(4)
 D ^DIE
 Q
 ;
MESS ;
 N SDMSG
 S SDMSG=" "_SDC
 I $P(SDZ,U,3) S SDMSG="+"_SDMSG_" Added:  "_SDJ(1)_"  CDR: "_SDJ(4) D  S SDMSG=SDMSG D MES^XPDUTL(SDMSG) Q
 . I SDJ(3),'SDY(3) S SDMSG=SDMSG_"  Inactive Date:  "_$$FMTE^XLFDT(SDJ(3))
 I SDJ(3),'SDY(3) S SDMSG="-"_SDMSG_" Inactivated: "_$$FMTE^XLFDT(SDJ(3)) D MES^XPDUTL(SDMSG) Q
 I SDJ(3),SDY(3),SDJ(3)'=SDY(3) S SDMSG="%"_SDMSG_" Inactive Date changed to: "_$$FMTE^XLFDT(SDJ(3)) D MES^XPDUTL(SDMSG) Q
 I SDJ(1)'=SDY(1) S SDMSG="*"_SDMSG_" Name Changed to: "_SDJ(1)
 I SDJ(4)'=SDY(4) S SDMSG="!"_SDMSG_" Changed CDR: "_$S(SDJ(4):SDJ(4),1:"deleted.")
 I SDY(3),'SDJ(3) S SDMSG="&"_SDMSG_" Reactivated"
 ;
MSG D MES^XPDUTL(SDMSG)
 Q
 ;
MSGT ;
 ;;  Changes are flagged such that:
 ;;     '+' = Added
 ;;     '-' = Inactivated
 ;;     '&' = Reactivated
 ;;     '%' = Inactive Date changed
 ;;     '*' = Edited
 ;;     '!' = CDR changed/deleted
 ;; 
 ;;NOTE - If your list includes multiple entries for a Stop Code,
 ;;       then you had duplicate entries in your file. 
 ;; 
 ;;       This update will make ALL entries for a given Stop Code
 ;;       the same, in order not to corrupt pointers.
 ;; 
 ;;QUIT
