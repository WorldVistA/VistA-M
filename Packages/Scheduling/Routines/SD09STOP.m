SD09STOP ;ALB/RLC- Stop Code/DSS Identifier Update 6/18/07
 ;;5.3;Scheduling;**537**;AUG 13, 1993;Build 3
 ;
 ;**  This patch is used as a Post-Init in a KIDS build to modify the
 ;**  the CLINIC STOP file [^DIC(40.7,] for FY09 updates.
 ;
 Q
 ;
EN ;** Add/inactivate/change/reactivate DSS IDs (stop codes)
 ;**  The following code executes if file modifications exist
 ;
 N SDVAR
 D:$P($T(NEW+1),";;",2)'="QUIT" ADD
 D:$P($T(OLD+1),";;",2)'="QUIT" INACT
 D:$P($T(CHNG+1),";;",2)'="QUIT" CHANGE
 D:$P($T(CDR+1),";;",2)'="QUIT" CDRNUM
 D:$P($T(ACT+1),";;",2)'="QUIT" REACT
 D:$P($T(REST+1),";;",2)'="QUIT" RESTR
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
 D BMES^XPDUTL(" [NOTE: These Stop Codes CANNOT be used UNTIL 10/1/08]")
 S DIC(0)="L",DLAYGO=40.7,DIC="^DIC(40.7,"
 F SDX=1:1 K DD,DO,DA S SDXX=$P($T(NEW+SDX),";;",2) Q:SDXX="QUIT"  DO
 .S DIC("DR")="1////"_$P(SDXX,"^",2)_$S('+$P(SDXX,U,5):"",1:";4////"_$P(SDXX,"^",5))
 .S DIC("DR")=DIC("DR")_";5////"_$P(SDXX,"^",3)_";6///"_$P(SDXX,"^",4)
 .S X=$P(SDXX,"^",1)
 .I '$D(^DIC(40.7,"C",$P(SDXX,"^",2))) D FILE^DICN,MESS Q
 .I $D(^DIC(40.7,"C",$P(SDXX,"^",2))) D EDIT(SDXX),MESSEX
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
INACT ;** Inactivate DSS IDs
 ;
 ;  SDXX is in format:
 ; AMIS #^^INACTIVATION DATE (in FileMan format)
 ;
 N SDX,SDDA,SDXX,SDINDT,SDEXDT
 S SDVAR=1
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> Inactivating Clinic Stops (DSS IDs) in CLINIC STOP File (#40.7)...")
 D BMES^XPDUTL(" [NOTE:  These Stop Codes CANNOT be used AFTER the indicated inactivation date]")
 F SDX=1:1 K DD,DO,DA S SDXX=$P($T(OLD+SDX),";;",2) Q:SDXX="QUIT"  DO
 . I +$P(SDXX,"^",3) D
 .. S X=$P(SDXX,"^",3)
 .. ;
 .. ;- Validate date passed in
 .. S %DT="FTX"
 .. D ^%DT
 .. Q:Y<0
 .. S SDINDT=Y
 .. D DD^%DT
 .. S SDEXDT=Y
 .. S SDDA=+$O(^DIC(40.7,"C",+SDXX,0))
 .. I $D(^DIC(40.7,SDDA,0)) D
 ... S DA=SDDA,DR="2////^S X=SDINDT",DIE="^DIC(40.7,"
 ... D ^DIE,MESI(SDEXDT)
 K %,%H,%I,DR,DA,DIC,DIE,DLAYGO,X,%DT,Y
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
CDRNUM ;** Change CDR numbers
 ;
 ;  SDXX is in format:
 ; STOP CODE NAME (AMIS #) ^ AMIS # ^ OLD CDR # ^ NEW CDR #
 ;
 N SDX,SDXX,SDDA
 S SDVAR=2
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> Changing CDR numbers in CLINIC STOP File (#40.7)...")
 F SDX=1:1 K DD,DO,DA S SDXX=$P($T(CDR+SDX),";;",2) Q:SDXX="QUIT"  DO
 .S SDDA=+$O(^DIC(40.7,"C",$P(SDXX,U,2),0))
 .I $D(^DIC(40.7,SDDA,0)) DO
 ..S DA=SDDA,DR="4///"_$P(SDXX,U,4),DIE="^DIC(40.7,"
 ..D ^DIE,MESN
 K DIE,DR,DA,X
 Q
 ;
REACT ;** Reactivate DSS IDs
 ;
 ;  SDXX is in format:
 ; AMIS #^
 ;
 N SDX,SDDA,SDXX
 ;S SDDA=+$O(^DIC(40.7,"C",510,0)) I $P($G(^DIC(40.7,SDDA,0)),"^",3)="" Q
 S SDVAR=1
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> Reactivating Clinic Stops (DSS IDs) in CLINIC STOP File (#40.7)...")
 F SDX=1:1 K DD,DO,DA S SDXX=$P($T(ACT+SDX),";;",2) Q:SDXX="QUIT"  DO
 .S SDDA=+$O(^DIC(40.7,"C",+SDXX,0))
 .I $P($G(^DIC(40.7,SDDA,0)),"^",3)'="" DO
 ..S DA=SDDA,DR="2///@",DIE="^DIC(40.7,"
 ..D ^DIE,MESA
 K DR,DA,DIE
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
 ..I $P(SDXX,U,2)=160 S DA=SDDA,DR="5////"_$P(SDXX,U,3)_";6///@",DIE="^DIC(40.7," D ^DIE,MESR Q
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
MESSEX ;** Display message if stop code already exists
 N ECXADMSG
 I +$G(SDVAR) D HDR(SDVAR)
 D MES^XPDUTL(" ")
 S ECXADMSG="             "_$P(SDXX,"^",2)_"      "_$P(SDXX,"^")_"  already exists."
 D MES^XPDUTL(ECXADMSG)
 K SDVAR
 Q
 ;
MESI(SDEXDT) ;** Inactivate message
 ;
 ;  Parameter:
 ;   SDEXDT - Date inactivation affective (External Format)
 ;
 N SDINMSG
 I +$G(SDVAR) D HDR(SDVAR)
 I $G(SDEXDT)="" S SDEXDT="UNKNOWN"
 D MES^XPDUTL(" ")
 S SDINMSG="Inactivated:  "_+SDXX_"           "_$P($G(^DIC(40.7,SDDA,0)),"^")_" as of "_SDEXDT
 D MES^XPDUTL(SDINMSG)
 K SDVAR
 Q
 ;
MESA ;** Reactivate message
 ;
 N SDACMSG
 I +$G(SDVAR) D HDR(SDVAR)
 D MES^XPDUTL(" ")
 S SDACMSG="Reactivated:  "_+SDXX_"           "_$P($G(^DIC(40.7,SDDA,0)),"^")
 D MES^XPDUTL(SDACMSG)
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
MESN ;** Change number
 N SDNMSG,SDNMSG1
 I +$G(SDVAR) D HDR(SDVAR)
 D MES^XPDUTL(" ")
 S SDNMSG="  Changed: "_$P(SDXX,U,2)_"    "_$P(SDXX,U)
 S SDNMSG1="   : "_$P(SDXX,U,3)_" Date: "_$P(SDXX,U,5)
 D MES^XPDUTL(SDNMSG)
 D MES^XPDUTL(SDNMSG1)
 K SDVAR
 Q
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
 ;;HBPC - PSYCHOLOGIST^156^P^10/1/2008
 ;;HBPC - PSYCHIATRIST^157^P^10/1/2008
 ;;MEDICAL FOSTER HOME^162^S^10/1/2008
 ;;POLYTRMA TRNSIT REHAB IND^195^P^10/1/2008
 ;;POLYTRMA TRNSIT REHAB GRP^196^P^10/1/2008
 ;;PM&RS DRIVER TRAINING^230^P^10/1/2008
 ;;INTERMED LOW VISION CARE^438^P^10/1/2008
 ;;RRTP OUTREACH SERVICES^593^E
 ;;RRTP AFTERCARE - COMMUNITY^594^E
 ;;RRTP AFTERCARE - VA^595^E
 ;;RRTP ADMISSION SCREENING SRVCS^596^E
 ;;TELEPHONE - RRTP^597^P^10/1/2008
 ;;MHV SECURE MESSAGING^719^S^10/1/2008
 ;;QUIT
 ;
OLD ;DSS IDs to be inactivated- ex. ;;AMIS NUMBER^^INACTIVE DATE
 ;;563^MH PRIMARY CARE - GROUP^10/1/2008
 ;;581^PTSD DAY TREATMENT^10/1/2008
 ;;725^RRTP OUTREACH SERVICES^10/1/2008
 ;;726^RRTP AFTERCARE - COMMUNITY^10/1/2008
 ;;727^RRTP AFTERCARE - VA^10/1/2008
 ;;728^RRTP ADMISSION SCREENING SRVCS^10/1/2008
 ;;729^TELEPHONE - RRTP^10/1/2008
 ;;QUIT
 ;
CHNG ;DSS ID name changes- example ;;STOP CODE NAME^NUMBER^^NEW NAME
 ;;VISOR (VISL IMPRMT OUTPAT PGM)^220^^VISOR & ADVANCED BLIND REHAB
 ;;OBSERVATION SPINAL CORD^295^^OBSERVATION SPINAL CORD INJURY
 ;;CCHT EVALUATION^371^^CCHT SCREENING
 ;;VICTORS^437^^VICTORS & ADVANCED LOW VISION
 ;;SUBSTANCE ABUSE - INDIVIDUAL^513^^SUBSTANCE USE DISORDER IND
 ;;SUBSTANCE ABUSE - HOME VISIT^514^^SUB USE DISORDER HOME VST
 ;;MENTAL HLTH PRIM CARE IND^531^^MH MED PRI CARE IND 2ND TO 323
 ;;TELEPHONE/SUBSTANCE ABUSE^545^^PHONE SUBSTNCE USE DSORDR
 ;;INTENSIVE SUB ABUSE TRMT GRP^547^^INTNSE SUB USE DSRDER GRP
 ;;SUBSTANCE ABUSE - GROUP^560^^SUBSTANCE USE DISORDR GRP
 ;;RVOEC INDIVIDUAL^571^^SERV-MH INDIVIDUAL
 ;;RVOEC GROUP^572^^SERV-MH GROUP
 ;;NON-VIDEO MONITORING ONLY^683^^CCHT NON-VIDEO MONITORING
 ;;NONVIDEO HOME TELEHLTH INTRVNT^684^^CCHT NON-VIDEO INTRVNTION
 ;;CCS TELEPHONE CARE PRI^686^^PHONE CONTACT BY CC STAFF
 ;;QUIT
 ;
CDR ;CDR account change- ex. ;;STOP CODE NAME^NUMBER^CDR # (old)^CDR# (new)
 ;;QUIT
 ;
ACT ;DSS IDs to be reactivated- example ;;NUMBER^
 ;;QUIT
 ;
REST ;Change restriction - ;;STOP CODE NAME^NUMBER^REST TYPE^RES DATE^OLD
 ;;CLINICAL PHARMACY^160^E^^S
 ;;VISOR & ADVANCED BLIND REHAB^220^P^10/1/2008^E
 ;;CCHT SCREENING^371^S^10/1/2008^E
 ;;MH MED PRI CARE IND 2ND TO 323^531^S^10/1/2008^E
 ;;QUIT
