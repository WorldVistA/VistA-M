ICPT63PT ;ALB/ESD - CPT Update '98 Post-Init Driver; 1/29/98
 ;;6.0;CPT/HCPCS;**3**;May 19, 1997
 ;
EN ;- Main entry point
 ;
 ;- Modify CPT Copyright file (#81.2)
 D DISTUP
 ;
 ;- Add, revise, inactivate categories in the CPT Category file (#81.1)
 D CATUPD
 ;
 ;- Add, revise, inactivate modifiers in the CPT Modifier file (#81.3)
 D EN^ICPT63P2
 ;
 ;- Reminder message to users to reload the ^ICPT global
 D MES^XPDUTL("")
 D BMES^XPDUTL("****** YOU MUST LOAD THE CPT GLOBAL (^ICPT) FROM THE FILE ICPT6_3.GBL")
 D MES^XPDUTL("UPON COMPLETION OF THIS INSTALLATION! ******")
 D MES^XPDUTL("")
ENQ Q
 ;
 ;
DISTUP ;- Entry point for Distribution Date update
 ;
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> Updating Distribution Date in the CPT Copyright file (#81.2)......")
 I '$$DISTDT D  G DISTUPQ
 . D BMES^XPDUTL(">>> Error updating Distribution Date field in CPT Copyright file (#81.2).")
 D MES^XPDUTL("......completed.")
DISTUPQ Q
 ;
 ;
DISTDT() ;- Add distribution date to file #81.2
 N DIC,DIE,DR,X,Y
 S DIC="^DIC(81.2,"
 S DIC(0)="OX"
 ;
 ;- Get entry (currently only one entry exists in this file)
 S X="CPT MESSAGE"
 D ^DIC
 I +Y=-1 G DISTDTQ
 ;
 ;- Add date
 S DA=+Y
 S DIE=DIC
 S DR=".02///2980201"
 D ^DIE
DISTDTQ Q $S(+$G(DA)>0:1,1:0)
 ;
 ;
CATUPD ;- Entry point for CPT Category update
 ;
 N CATEG,CATI,PRTFLG
 S PRTFLG=""
 D BMES^XPDUTL(">>> Updating CPT Category file (#81.1)......")
 ;
 ;- Get category record from list
 F CATI=1:1 S CATEG=$P($T(CATS+CATI),";;",2) Q:CATEG="QUIT"  D
 . ;
 . ;- Display heading on screen once
 . I (PRTFLG'=$P(CATEG,"^")) D @($S($P(CATEG,"^")="A":"AMSG",$P(CATEG,"^")="M":"MMSG",1:"IMSG"))
 . ;
 . ;- Determine if record will be added, modified, or inactivated
 . D @($S($P(CATEG,"^")="A":"ADD",$P(CATEG,"^")="M":"MOD",1:"INACT"))
 D BMES^XPDUTL("...... completed.")
CATUPDQ Q
 ;
 ;
MOD ;- Update CPT Category file (#81.1) with modified names/CPT ranges
 ;
 N CATIEN,CATNODE,CATNNDE
 S CATIEN=0,(CATNODE,CATNNDE)=""
 ;
 ;- Get pieces 1-63 of "B" xref to handle lookup of long names
 S CATIEN=+$O(^DIC(81.1,"B",$E($P(CATEG,"^",2),1,63),0))
 ;
 ;- Display error message if no IEN
 I 'CATIEN D ERRMSG("M"),SETFLG Q
 S CATNODE=$G(^DIC(81.1,CATIEN,0)) Q:CATNODE=""
 ;
 ;- Edit record
 S DIE="^DIC(81.1,",DA=CATIEN,DR=".01///"_$P(CATEG,"^",3)_";4///"_$P(CATEG,"^",6)_";5///"_$P(CATEG,"^",7)
 D ^DIE K DA,DIE,DR
 ;
 ;- Get new node and display old and modified values of record to screen
 S CATNNDE=$G(^DIC(81.1,CATIEN,0))
 D BMES^XPDUTL("Old Name: "_$P(CATNODE,"^")_" Range: "_$P(CATNODE,"^",4)_"-"_$P(CATNODE,"^",5))
 D MES^XPDUTL("New Name: "_$P(CATNNDE,"^")_" Range: "_$P(CATNNDE,"^",4)_"-"_$P(CATNNDE,"^",5))
 D SETFLG
 Q
 ;
 ;
ADD ;- Add new categories to CPT Category file (#81.1)
 ;
 N CATNNDE,DA,Y
 ;
 ;- Get pieces 1-63 of "B" xref to handle lookup of long names
 I +$O(^DIC(81.1,"B",$E($P(CATEG,"^",2),1,63),0)) D ERRMSG("A"),SETFLG Q
 ;
 ;- Create new category record
 S DIC="^DIC(81.1,",DIC(0)="LZ",DLAYGO=81.1,X=$P(CATEG,"^",2)
 K DD,DO D FILE^DICN K DLAYGO,X
 ;
 ;- Display error message and exit if record was not created
 I +Y=-1 D ERRMSG("A"),SETFLG Q
 ;
 ;- Add new fields to record
 S DIE=DIC,DA=+Y,DR="2///"_$P(CATEG,"^",3)_";3///"_$P(CATEG,"^",4)_";4///"_$P(CATEG,"^",5)_";5///"_$P(CATEG,"^",6)_";6///"_$P(CATEG,"^",7)
 D ^DIE K DIC,DIE,DR
 ;
 ;- Display new record to screen
 S CATNNDE=$G(^DIC(81.1,DA,0))
 D MES^XPDUTL("New Name: "_$P(CATNNDE,"^")_" Range: "_$P(CATNNDE,"^",4)_"-"_$P(CATNNDE,"^",5))
 D SETFLG
 Q
 ;
 ;
INACT ;- Inactivate categories from CPT Category file (#81.1)
 ;
 N CATIEN,CATNODE
 S CATIEN=0,CATNODE=""
 ;
 ;- Get pieces 1-63 of "B" xref to handle lookup of long names
 S CATIEN=+$O(^DIC(81.1,"B",$E($P(CATEG,"^",2),1,63),0))
 ;
 ;- Display error message and exit if record was not found
 I 'CATIEN D ERRMSG("I"),SETFLG Q
 S CATNODE=$G(^DIC(81.1,CATIEN,0))
 S DIE="^DIC(81.1,",DA=CATIEN
 ;
 ;- Inactivate record
 S DR="4///@;5///@;6///@;100///Inactive.  Use PSYCHIATRY"_$S(+$O(^DIC(81.1,"B","PSYCHIATRY",0)):"  (ien = "_+$O(^DIC(81.1,"B","PSYCHIATRY",0))_")",1:"")
 D ^DIE K DA,DIE,DR
 ;
 ;- Display record to screen
 D MES^XPDUTL("Inactivated Name: "_$P(CATNODE,"^"))
 D SETFLG
 Q
 ;
 ;
ERRMSG(ACT) ;- Error message for "A"dd, "M"odify, "I"nactivate
 ;
 N MSG
 S MSG=$S(ACT="A":" already exists and could not be added.",ACT="M":" does not exist and could not be modified.",1:" does not exist and could not be inactivated.")
 D BMES^XPDUTL("Category "_$P(CATEG,"^",2)_MSG)
 Q
 ;
 ;
AMSG ;- Added categories message
 ;
 D BMES^XPDUTL("Added Categories:")
 D MES^XPDUTL("=================")
 D MES^XPDUTL("")
 Q
 ;
 ;
MMSG ;- Modified categories message
 ;
 D BMES^XPDUTL("Modified Categories:")
 D MES^XPDUTL("====================")
 Q
 ;
 ;
IMSG ;- Inactive categories message
 ;
 D BMES^XPDUTL("Inactive Categories:")
 D MES^XPDUTL("====================")
 D MES^XPDUTL("")
 Q
 ;
 ;
SETFLG ;- Set print flag so headings will display once
 ;
 S PRTFLG=$S($P(CATEG,"^")="A":"A",$P(CATEG,"^")="M":"M",1:"I")
 Q
 ;
 ;
CATS ;- CPT Category records
 ;;M^MEDICINE^MEDICINE^m^^90000^99199^C
 ;;M^MISCELLANEOUS PROCEDURE(S)^OTHER PROCEDURE(S)^s^3^01990^01999^C
 ;;M^NON-INVASIVE PERIPHERAL VASCULAR DIAGNOSTIC STUDIES^NON-INVASIVE VASCULAR DIAGNOSTIC STUDIES^s^1^93875^93990^C
 ;;M^PHYSICAL MEDICINE^PHYSICAL MEDICINE^s^1^97001^97799^C
 ;;M^SPECIAL SERVICES AND REPORTS^SPECIAL SERVICES AND REPORTS^s^1^99000^99090^C
 ;;M^ORGAN OR DISEASE ORIENTED PANELS^ORGAN OR DISEASE ORIENTED PANELS^s^5^80049^80092^C
 ;;M^SURGICAL PATHOLOGY^SURGICAL PATHOLOGY^s^5^88300^88399^C
 ;;M^CARE PLAN OVERSIGHT SERVICES^CARE PLAN OVERSIGHT SERVICES^s^116^99374^99380^C
 ;;M^NURSING FACILITY SERVICES^NURSING FACILITY SERVICES^s^116^99301^99316^C
 ;;A^OTHER LABORATORY/PATHOLOGY^s^5^89050^89399^C
 ;;A^PSYCHIATRY^s^1^90801^90899^C
 ;;A^QUALIFYING CIRCUMSTANCES FOR ANESTHESIA^s^1^99100^99140^C
 ;;A^SEDATION WITH OR W/O ANALGESIA (CONSCIOUS SEDATION)^s^1^99141^99142^C
 ;;A^OTHER SERVICES^s^1^99175^99199^C
 ;;I^GENERAL CLINICAL PSYCHIATRIC DIAGNOSTIC OR EVALUATIVE INTERVIEW PROCEDURES^s^1^90801^90801^C
 ;;I^SPECIAL CLINICAL PSYCHIATRIC DIAGNOSTIC OR EVALUATIVE PROCEDURES^s^1^90820^90830^C
 ;;I^PSYCHIATRIC THERAPEUTIC PROCEDURES^s^1^90835^90899^C
 ;;QUIT
