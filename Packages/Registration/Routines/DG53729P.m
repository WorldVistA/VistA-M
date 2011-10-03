DG53729P ;ALB/JRC - Add NURSING HOME TREATING SPECIALTIES ; 3/12/07 7:21am
 ;;5.3;Registration;**729**;Aug 13, 1993;Build 59
 ;base program: DG53683P
EN ;Add Treating Specialties to the SPECIALITY file (#42.4)
 N DGI,DGERR,DGSPEC,DGIFN,DGQUES
 S DGIFN=0
 ;add new treating specialties
 F DGI=1:1 S DGSPEC=$P($T(TRSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 .D TSPEC
 .S DGQUES=$P(DGSPEC,U,9)
 .D FAC
 .Q
 ;edit existing treating specialties
 D EDIT
 ;inactivate existing treating specialties
 D INACT
 ;edit existing surgical specialties
 D EDIT^DG53729R
 ;move ptf code (those < 100) into new austin ptf code field
 D APTFC
 ;place option out of order and remove from menu
 D MENU
 ;inactivate existing ptf expanded code categories
 D PTFCAT^DG53729R
 ;Update 9/30/2007 Census close out date, if exists
 D EN^DG53729C
 Q
TSPEC ;Add treating specialty to SPECIALTY File (#42.4)
 D BMES^XPDUTL(">>>"_$P(DGSPEC,U,2)_">>>")
 N DA,DGFILE,DGMULT,DIC,DIE,DGDA1,DINUM,DLAYGO,DR,X,Y
 S DGERR=0
 S DIC="^DIC(42.4,"
 S DIC(0)="LX"
 S DINUM=$P(DGSPEC,U)
 S X=$P(DGSPEC,U,2)
 S DLAYGO=42.4
 D ^DIC
 S (DGIFN,DGDA1)=Y
 I +DGIFN=-1 D  Q
 .D MES^XPDUTL("     Entry not added to SPECIALTY File (#42.4).  No further updating will occur.")
 .D MES^XPDUTL("     Please contact Customer Service for assistance.")
 .Q
 I $P(DGIFN,U,3)'=1&(+DGIFN'=$P(DGSPEC,U)) D  Q
 .D MES^XPDUTL("     Entry exists in SPECIALTY File (#42.4), but with a different PTF Code #.")
 .D MES^XPDUTL("     No further updating will occur.  Please review entry.")
 .S DGERR=1
 .Q 
 D MES^XPDUTL("     Entry "_$S($P(DGIFN,U,3)=1:"added to",1:"exists in")_" SPECIALTY File (#42.4).")
 D MES^XPDUTL("     Updating SPECIALTY File fields.")
 S DIE=DIC
 S DR="1///"_$P(DGSPEC,U,3)_";3///"_$P(DGSPEC,U,4)_";4///"_$P(DGSPEC,U,5)_";5///"_$P(DGSPEC,U,6)_";6///"_$P(DGSPEC,U,7)_";7///"_$P(DGSPEC,U,10)
 S DA=+DGIFN
 D ^DIE
 S DGFILE=42.4
 S DGMULT=10
 S DIC="^DIC(42.4,"_+DGIFN_",""E"","
 D MULT
 Q
FAC ;Add treating specialty to Facility Treating Specialty file (#45.7)
 N DA,DGFILE,DGMULT,DIC,DIE,DLAYGO,DR,X,Y
 S DIC="^DIC(45.7,"
 S DIC(0)="LXZ"
 S DLAYGO=45.7
 S X=$P(DGSPEC,U,2)
 D ^DIC
 S DGDA1=Y
 I +DGDA1=-1 D BMES^XPDUTL("     Entry not added to FACILITY TREATING SPECIALTY File(#45.7).") Q
 I $P(DGDA1,U,3)'=1&($P(Y(0),U,2)'=$P(DGSPEC,U)) D  Q
 .D BMES^XPDUTL("     Entry exists in FACILITY TREATING SPECIALTY File (#45.7), but with")
 .D MES^XPDUTL("     a different PTF Code #.  No further updating will occur.")
 .D MES^XPDUTL("     Please review entry.")
 .Q
 D BMES^XPDUTL("     Entry "_$S($P(DGDA1,U,3)=1:"added to",1:"exists in")_" FACILITY TREATING SPECIALTY File (#45.7).")
 D MES^XPDUTL("     Updating SPECIALTY field...")
 S DIE=DIC
 S DA=+DGDA1
 S DR="1////"_$P(DGSPEC,U)
 D ^DIE
 S DGFILE=45.7
 S DGMULT=100
 S DIC="^DIC(45.7,"_+DGDA1_",""E"","
 D MULT
 Q
MULT ;Add Effective Date
 N DA,DIE,DR
 S DA(1)=+DGDA1
 S DIC(0)="LX"
 S DIC("P")=$P(^DD(DGFILE,DGMULT,0),"^",2)
 S X=3071001
 D ^DIC
 S DA=+Y
 I +Y=-1 D MES^XPDUTL("     Effective date not added.") Q
 D MES^XPDUTL("     Effective date added.")
 S DIE=DIC
 S DR=".02///Y"
 D ^DIE
 Q
INACT ;inactivate treating specialties
 N DA,DIE,DR,X,DGTSP
 F DGTSP=1,7,34 D
 . S DIC="^DIC(42.4,"_DGTSP_",""E"","
 . S DA(1)=DGTSP
 . S DIC(0)="LX"
 . S DIC("P")=$P(^DD(42.4,10,0),"^",2)
 . S X=3071001
 . D ^DIC
 . S DA=+Y
 . I +Y=-1 D BMES^XPDUTL(">>>Inactive date not added to TS code "_DGTSP_" in the Specialty file.<<<") Q
 . D BMES^XPDUTL(">>>Inactive date added to TS code "_DGTSP_" in the Specialty file.<<<")
 . S DIE=DIC
 . S DR=".02///N"
 . D ^DIE
 . ;check for CODES in the Facility Treating Specialty File (45.7
 . ;add inactivation date of 7/1/2006
 . D BMES^XPDUTL("  ")
 . D MES^XPDUTL("     FACILITY TREATING SPECIALTY FILE being checked to see if any entries are")
 . D MES^XPDUTL("     pointing to "_DGTSP_".  If so, they will be inactivated.>>>")
 .N DAA F DAA=0:0 S DAA=$O(^DIC(45.7,"ASPEC",DGTSP,DAA)) Q:'DAA  D
 .. N DIE,DR,TS,X S TS=""
 ..S TS=$P($G(^DIC(45.7,DAA,0)),"^")
 ..S DIC="^DIC(45.7,"_DAA_",""E"","
 ..S DA(1)=DAA
 ..S DIC(0)="LX"
 ..S X=3060701
 ..D ^DIC
 ..S DA=+Y
 ..I +Y=-1 D BMES^XPDUTL("     Inactive date not added to "_TS_"in the Facility Treating Specialty file.") Q
 ..D BMES^XPDUTL("     Inactive date added to "_TS_" in the Facility Treating Specialty file.<<<")
 ..S DIE=DIC
 ..S DR=".02///N"
 ..D ^DIE
 Q
EDIT ;Edit treating specialties
 ;
 N DS,DIE,DR,DGI
 S DIE="^DIC(42.4,"
 S DIC(0)="LX"
 F DGI=1:1 S DGSPEC=$P($T(ETRSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 . S DGERR=0
 . S DA=$P(DGSPEC,U)
 . S DR=".01///"_$P(DGSPEC,U,2)_";1///"_$P(DGSPEC,U,3)_";3///"_$P(DGSPEC,U,4)_";4///"_$P(DGSPEC,U,5)_";5///"_$P(DGSPEC,U,6)_";6///"_$P(DGSPEC,U,7)
 . D ^DIE
 . D BMES^XPDUTL("  ")
 . D BMES^XPDUTL("  ")
 . D BMES^XPDUTL(">>>"_$P(DGSPEC,U)_" code updated to "_$P(DGSPEC,U,2)_" in the Specialty file.>>>")
 N DS,DIE,DR,DGI,DGII,DGSP,CNT,DGSPEC,DGSPEC1
 S DIE="^DIC(45.7,"
 S DIC(0)="LX"
 F DGI=1:1 S DGSPEC=$P($T(ETRSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 . S DGERR=0
 . S DGSP=$P(DGSPEC,U)
 . S CNT=0,DGSPEC1=0 F DGII=0:0 S DGSPEC1=$O(^DIC(45.7,"ASPEC",DGSP,DGSPEC1)) Q:'DGSPEC1  S CNT=CNT+1 D
 .. I CNT=1 D
 ... I $$ACTIVE^DGACT(45.7,DGSPEC1)'=1 S CNT=0 Q
 ... S DA=DGSPEC1,DR=".01///"_$P(DGSPEC,U,2)_";99///@"
 ... D BMES^XPDUTL("     "_$P(^DIC(45.7,DGSPEC1,0),U)_" name has been changed to "_$P(DGSPEC,U,2)_" in the Facility Treating Specialty file.")
 ... D ^DIE
 .. E  D
 ... S TS=""
 ... S TS=$P($G(^DIC(45.7,DGSPEC1,0)),"^")
 ... D BMES^XPDUTL("     Please review Facility Treating Specialty "_TS_".  The entry name may need changing or entry may need inactivating since more than one entry points to "_$P(DGSPEC,U,2)_" in the Specialty file.<<<")
 Q
TRSP ;PTF code^Specialty^Print Name^Service^Ask Psych^Billing Bedsection^CDR^^Ques#^Austin PTF Code
 ;;13^CARDIAC INTENSIVE CARE UNIT^^MEDICINE^N^GENERAL MEDICAL CARE^1117^^^13
 ;;30^PEDIATRICS^^MEDICINE^N^GENERAL MEDICAL CARE^1110^^^30
 ;;48^CARDIAC SURGERY^^SURGERY^N^SURGICAL CARE^1210^^^48
 ;;49^TRANSPLANTATION^^SURGERY^N^SURGICAL CARE^1210^^^49
 ;;78^ANESTHESIOLOGY^^SURGERY^N^SURGICAL CARE^1210^^^78
 ;;82^PM&R TRANSITIONAL REHAB^^REHAB MEDICINE^N^REHABILITATION MEDICINE^1113^^^82
 ;;97^SURGICAL STEPDOWN^^SURGERY^N^SURGICAL CARE^1210^^^97
 ;;100^SHORT STAY GRECC-NHCU^SS GRECC-NHCU^NHCU^N^NURSING HOME CARE^1430^^^1A
 ;;101^LONG STAY GRECC-NHCU^LS GRECC-NHCU^NHCU^N^NURSING HOME CARE^1410^^^1B
 ;;102^SHORT STAY GRECC-GEM-NHCU^SS GRECC-GEM-NH^NHCU^N^NURSING HOME CARE^1420^^^1C
 ;;103^GRECC-GEM-REHAB^^REHAB MEDICINE^N^REHABILITATION MEDICINE^1120^^^1D
 ;;104^GRECC-MED^^MEDICINE^N^GENERAL MEDICAL CARE^1110^^^1E
 ;;QUIT
ETRSP ;;PTF code^Specialty^Print Name^Service^Ask Psych^Billing Bedsection^CDR
 ;;12^MEDICAL ICU^^MEDICINE^N^GENERAL MEDICAL CARE^1117^^
 ;;50^GENERAL SURGERY^^SURGERY^N^SURGICAL CARE^1210^^
 ;;51^OB/GYN^^SURGERY^N^SURGICAL CARE^1210^^
 ;;55^EAR, NOSE, THROAT (ENT)^^SURGERY^N^SURGICAL CARE^1210^^
 ;;56^PLASTIC SURGERY^^SURGERY^N^SURGICAL CARE^1210^^
 ;;58^THORACIC SURGERY^^SURGERY^N^SURGICAL CARE^1210^^
 ;;60^ORAL SURGERY^^SURGERY^N^SURGICAL CARE^1210^^
 ;;QUIT
 Q
MENU ;Remove option from menu and place out of order
 N MENU,OPTION,CHECK,IEN
 S MENU="DGPT TOOLS MENU",OPTION="DG PTF SUFFIX EFF DATE EDIT"
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 ;Rename CDR Inquiry [DGPT CDR INQUIRY] menu
 D BMES^XPDUTL(">>> Renaming CDR Inquiry option to MPCR Inquiry <<<")
 S IEN=$$LKOPT^XPDMENU("DGPT CDR INQUIRY")
 I 'IEN D  Q
 .D BMES^XPDUTL(">>> Was not able to locate CDR Inquiry option <<<")
 .D BMES^XPDUTL(">>> PLEASE CONTACT THE NATIONAL HELP DESK <<<")
 S DIE="^DIC(19,",DIC(0)="LX"
 S DA=IEN,DR="1///"_"MPCR INQUIRY"_";1.1///"_"MPCR INQUIRY" D ^DIE
 S ^DIC(19,IEN,1,1,0)="This option allows the user to view the MPCR information related"
 S ^DIC(19,IEN,1,3,0)="as the data shown on the 'MPCR' screen of the 'Load/Edit PTF Record'"
 D RENAME^XPDMENU("DGPT CDR INQUIRY","DGPT MPCR INQUIRY")
 D BMES^XPDUTL(">>> CDR Inquiry Menu option Succesfully renamed <<<")
 Q
APTFC ;move ptf code (those < 100) into new austin ptf code field
 N DGX,DGENTRY,DA,DR,DIE
 D BMES^XPDUTL(">>> Populating PTF CODE field (#7) of the SPECIALTY (#42.4) file")
 S DGX="" F  S DGX=$O(^DIC(42.4,"B",DGX)) Q:DGX=""  D
 . S DGENTRY=$O(^DIC(42.4,"B",DGX,0)) I DGENTRY D
 .. Q:$L(DGENTRY)>2  I ($E(DGENTRY,1)?1A)!($E(DGENTRY,2)?1A) Q
 .. S DA=DGENTRY,DR="7///"_DGENTRY,DIE="^DIC(42.4," D ^DIE
 Q 
