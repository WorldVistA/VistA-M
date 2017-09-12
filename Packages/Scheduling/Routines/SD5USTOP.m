SD5USTOP ;ALB/CAW,GTS,ESD,JAM,GT - Stop Code/DSS Identifier Update 2/10/2005
 ;;5.3;Scheduling;**428**;AUG 13, 1993
 ;
 ;**  This patch is used as a Post-Init in a KIDS build to modify the
 ;**   the DSS Identifier file [^DIC(40.7,]
 ;
EN ;** Add/inactivate/change/reactivate DSS IDs (stop codes)
 ;**  The following code executes if file modifications exist
 ;
 N SDVAR
 D:$P($T(NEW+1),";;",2)'="QUIT" ADD
 D:$P($T(CHNG+1),";;",2)'="QUIT" CHANGE
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
 D BMES^XPDUTL(">>> Adding new Clinic Stops (DSS IDs) to CLINIC STOP File (#40.7)...")
 ;
 ;** NOTE: The following line is for DSS IDs that are not yet active
 D BMES^XPDUTL(" [NOTE:  These Stop Codes CANNOT be used UNTIL 2/1/05]")
 S DIC(0)="L",DLAYGO=40.7,DIC="^DIC(40.7,"
 F SDX=1:1 K DD,DO,DA S SDXX=$P($T(NEW+SDX),";;",2) Q:SDXX="QUIT"  DO
 .S DIC("DR")="1////"_$P(SDXX,"^",2)_$S('+$P(SDXX,U,5):"",1:";4////"_$P(SDXX,"^",5))
 .S DIC("DR")=DIC("DR")_";5////"_$P(SDXX,"^",3)_";6///"_$P(SDXX,"^",4)
 .S X=$P(SDXX,"^",1)
 .I '$D(^DIC(40.7,"C",$P(SDXX,"^",2))) D FILE^DICN,MESS Q
 .;I $D(^DIC(40.7,"C",$P(SDXX,"^",2))) D EDIT(SDXX),MESSEX
 K DIC,DLAYGO,X
 Q
 ;
EDIT(SDXX) ;- Edit fields w/new values if stop code record already exists
 ;
 Q:$G(SDXX)=""
 N DA,DIE,DLAYGO,DR
 S DA=+$O(^DIC(40.7,"C",+$P(SDXX,"^",2),0))
 Q:'DA
 S DIE="^DIC(40.7,",DR=".01////"_$P(SDXX,"^")_";1////"_$P(SDXX,"^",2)_";2////@"_$S('+$P(SDXX,U,5):"",1:";4////"_$P(SDXX,"^",5))_";5////"_$P(SDXX,"^",3)_";6///"_$P(SDXX,"^",4)
 D ^DIE
 Q
 ;
CHANGE ;** Change DSS ID names
 ;
 ;  SDXX is in format:
 ; STOP CODE NAME^AMIS #^^NEW STOP CODE NAME
 ;
 N SDX,SDXX,SDDA
 S SDVAR=1
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> Changing Clinic Stop (DSS ID) names in CLINIC STOP File (#40.7)...")
 F SDX=1:1 K DD,DO,DA S SDXX=$P($T(CHNG+SDX),";;",2) Q:SDXX="QUIT"  DO
 .S SDDA=+$O(^DIC(40.7,"C",$P(SDXX,U,2),0))
 .I $D(^DIC(40.7,SDDA,0)) DO
 ..S DA=SDDA,DR=".01///"_$P(SDXX,U,4),DIE="^DIC(40.7,"
 ..D ^DIE,MESC
 K DIE,DR,DA
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
MESSEX ;** Display message if stop code already exists
 N ECXADMSG
 I +$G(SDVAR) D HDR(SDVAR)
 D MES^XPDUTL(" ")
 S ECXADMSG="             "_$P(SDXX,"^",2)_"      "_$P(SDXX,"^")_"  already exists."
 D MES^XPDUTL(ECXADMSG)
 K SDVAR
 Q
 ;
MESC ;** Change message
 N SDCMSG,SDCMSG1
 I +$G(SDVAR) D HDR(SDVAR)
 D MES^XPDUTL(" ")
 S SDCMSG="Changed:      "_$P(SDXX,U,2)_"           "_$P(SDXX,U)
 S SDCMSG1="     to:      "_$P(SDXX,U,2)_"           "_$P(SDXX,U,4)
 D MES^XPDUTL(SDCMSG)
 D MES^XPDUTL(SDCMSG1)
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
 ;;QUIT
 ;
CHNG ;DSS ID name changes- example ;;STOP CODE NAME^NUMBER^^NEW NAME
 ;;PMRS CWT/SE NON-F TO F (MASNONCT)^223^^PMRS CWT/SE NON-F TO F (MAS NO
 ;;PMRS CWT/TWE NON-F TO F (MASNONCT)^228^^PMRS CWT/TWE NON-F TO F (MAS N
 ;;VISOR (VISUAL IMPAIRMENT OUTPATIENT PROGRAM)^220^^VISOR (VISL IMPRMT OUTPAT PGM)
 ;;MH CWT/SE NON-F TO F (MAS NONCT^569^^MH CWT/SE NON-F TO F (MAS NONC
 ;;MH CWT/TWE NON-F TO F (MAS NONCT^570^^MH CWT/TWE NON-F TO F (MAS NON
 ;;NONVIDEO HOME TELEHEALTH INTERVENTION^684^^NONVIDEO HOME TELEHLTH INTRVNT
 ;;QUIT
