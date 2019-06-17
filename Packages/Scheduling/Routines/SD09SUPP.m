SD09SUPP ;ALB/RLC- Stop Code/DSS Identifier Update 6/18/07
 ;;5.3;Scheduling;**548**;AUG 13, 1993;Build 1
 ;
 ;**  This patch is used as a Post-Init in a KIDS build to modify the
 ;**  the CLINIC STOP file [^DIC(40.7,] for a FY09 supplemental update.
 ;
EN ;** Add/inactivate/change/reactivate DSS IDs (stop codes)
 ;**  The following code executes if file modifications exist
 ;
 N SDVAR
 D:$P($T(NEW+1),";;",2)'="QUIT" ADD
 Q
 ;
 ;
ADD ;** Add DSS IDs
 ;
 ;  SDXX is in format:
 ; STOP CODE NAME^AMIS #^RESTRICTION TYPE^REST. DATE^CDR #
 ;
 N SDX,SDXX
 S SDVAR=1
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> Adding new Clinic Stop (DSS IDs) to CLINIC STOP File (#40.7)...")
 ;
 ;** NOTE: The following line is for DSS IDs that are not yet active
 D BMES^XPDUTL(" [NOTE: This Stop Code CANNOT be used UNTIL 02/01/2009]")
 S DIC(0)="L",DLAYGO=40.7,DIC="^DIC(40.7,"
 F SDX=1:1 K DD,DO,DA S SDXX=$P($T(NEW+SDX),";;",2) Q:SDXX="QUIT"  DO
 .S DIC("DR")="1////"_$P(SDXX,"^",2)_$S('+$P(SDXX,U,5):"",1:";4////"_$P(SDXX,"^",5))
 .S DIC("DR")=DIC("DR")_";5////"_$P(SDXX,"^",3)_";6///"_$P(SDXX,"^",4)
 .S X=$P(SDXX,"^",1)
 .I '$D(^DIC(40.7,"C",$P(SDXX,"^",2))) D FILE^DICN,MESS Q
 K DIC,DLAYGO,X
 Q
 ;
RESTR ;** Change Restriction Data
 ;
 ;  SDXX is in format:
 ; STOP CODE NAME^STOP CODE NUMBER^RESTRICTION TYPE^RESTRICTION DATE
 ;
 N SDX,SDXX,SDDA
 S SDVAR=3
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> Changing Restriction Data in CLINIC STOP File (#40.7)...")
 F SDX=1:1 K DD,DO,DA S SDXX=$P($T(REST+SDX),";;",2) Q:SDXX="QUIT"  D
 .S SDDA=+$O(^DIC(40.7,"C",$P(SDXX,U,2),0))
 .I $D(^DIC(40.7,SDDA,0)) D
 ..I $P(SDXX,U,2)=571 S DA=SDDA,DR="5////"_$P(SDXX,U,3)_";6///@",DIE="^DIC(40.7," D ^DIE,MESR Q
 ..S DA=SDDA,DR="5////"_$P(SDXX,U,3)_";6///"_$P(SDXX,U,4),DIE="^DIC(40.7,"
 ..D ^DIE,MESR
 K DIE,DR,DA,X
 Q
 ;
MESS ;** Add message
 N ECXADMSG
 I +$G(SDVAR) D HDR(SDVAR)
 D MES^XPDUTL(" ")
 S ECXADMSG="Added:       "_$P(SDXX,"^",2)_"      "_$P(SDXX,"^")
 I $P(SDXX,"^",5)'="" S ECXADMSG=ECXADMSG_" [CDR#: "_$P(SDXX,"^",5)_"]"
 D MES^XPDUTL(ECXADMSG)
 I $P(SDXX,"^",3)'="" S ECXADMSG="                      Restricted Type: "_$P(SDXX,"^",3)_"    Restricted Date: "_$P(SDXX,"^",4)
 D MES^XPDUTL(ECXADMSG)
 K SDVAR
 Q
 ;
MESR ;** Restricting Stop Code
 N SDNMSG,SDNMSG1
 I +$G(SDVAR) D HDR(SDVAR)
 D MES^XPDUTL(" ")
 S SDNMSG="Changed:   "_$P(SDXX,U,2)_"            "_$P(SDXX,U)_"               "_$P(SDXX,U,5)_"         "_$P(SDXX,U,6)
 S SDNMSG1="     to:                                                 "_$P(SDXX,U,3)_"         "_$P(SDXX,U,4)
 D MES^XPDUTL(SDNMSG)
 D MES^XPDUTL(SDNMSG1)
 K SDVAR
 Q
 ;
HDR(SDVAR) ;- Header
 Q:'$G(SDVAR)
 N SDHDR
 S SDHDR=$P($T(@("HDR"_SDVAR)),";;",2)
 D BMES^XPDUTL(SDHDR)
 Q
 ;
 ;
HDR1 ;;           Stop Code              Name
 ;
HDR2 ;;                CDR        Stop Code             Name
 ;
HDR3 ;;           Stop Code      Name                       Rest. Type    Date
 ;
NEW ;DSS IDs to add- ex ;;STOP CODE NAME^NUMBER^RESTRICTION TYPE^RESTRICTION DATE^CDR
 ;;DES EXAM^448^S^2/01/2009
 ;;QUIT
