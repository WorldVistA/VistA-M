DG53729R ;ALB/JRC - Add NURSING HOME TREATING SPECIALTIES ; 2/21/07 12:31pm
 ;;5.3;Registration;**729**;Aug 13, 1993;Build 59
 ;Continuation of DG53729P
 ;
EDIT ;Edit surgical specialties
 N DS,DIE,DR,DGI,DGCD
 S DIE="^DIC(45.3,"
 S DIC(0)="X"
 F DGI=1:1 S DGSPEC=$P($T(ESURGSP+DGI),";;",2) Q:DGSPEC="QUIT"  D
 .S DGERR=0
 .S DGCD=$P(DGSPEC,U)
 .S DGSPEC1=0 F DGII=0:0 S DGSPEC1=$O(^DIC(45.3,"B",DGCD,DGSPEC1)) Q:'DGSPEC1  D
 ..S DA=DGSPEC1,DR="1///"_$P(DGSPEC,U,2)
 ..D ^DIE
 ..D BMES^XPDUTL(" ")
 ..D BMES^XPDUTL(" ")
 ..D BMES^XPDUTL(">>>"_$P(DGSPEC,U)_" code updated to "_$P(DGSPEC,U,2)_" in the Surgical Specialty file.>>>")
 Q
 ;
ESURGSP ;;Code^Specialty
 ;;50^GENERAL SURGERY
 ;;51^OB/GYN
 ;;55^EAR, NOSE, THROAT (ENT)
 ;;56^PLASTIC SURGERY
 ;;58^THORACIC SURGERY
 ;;60^ORAL SURGERY
 ;;QUIT
 Q
 ;
PTFCAT ;Place inactive date in PTF EXPANDED CODE CATEGORY (#.03) field
 ;Temporarily remove 'no editing' from Data Dictionary
 N SAVXI,SAVXF,SAVXC,XI,XF,XC
 S SAVXF=$P(^DD(45.88,.02,0),U,2) ;Flag field
 S XF=$P(SAVXF,"I",1)_$P(SAVXF,"I",2,99) ;REMOVE THE 'I'
 S SAVXI=$P(^DD(45.88,.03,0),U,2) ;Inactive Date field
 S XI=$P(SAVXI,"I",1)_$P(SAVXI,"I",2,99) ;REMOVE THE 'I'
 S SAVXC=$P(^DD(45.89,.01,0),U,2) ;Category field
 S XC=$P(SAVXC,"I",1)_$P(SAVXC,"I",2,99) ;REMOVE THE 'I'
 S $P(^DD(45.88,.02,0),U,2)=XF
 S $P(^DD(45.88,.03,0),U,2)=XI
 S $P(^DD(45.89,.01,0),U,2)=XC
 N I,CAT,DIC,DIE,DR,X,Y,DGPCD
 F I=1:1 S CAT=$P($T(PTFCAT1+I),";;",2) Q:CAT="QUIT"  D
 . S DIC="^DIC(45.88,",DIC(0)="X"
 . S X=$P(CAT,"^")
 . I $P(CAT,"^")="DIALYSIS TYPE" S DIC(0)="LM"
 . D ^DIC
 . I +Y>0 D
 .. S DIE=DIC,DA=+Y
 .. S DR=".03////"_$P(CAT,"^",2)
 .. I $P(CAT,"^")="DIALYSIS TYPE" S DR=".02///8"
 .. D ^DIE
 ..I $P(CAT,"^")="DIALYSIS TYPE" D
 ...D BMES^XPDUTL(">>>"_$P(CAT,"^")_" added to the PTF EXPANDED CODE CATEGORY File (#45.88).")
 ..E  D
 ...D BMES^XPDUTL(">>>Inactive date added to category "_$P(CAT,"^")_" in the")
 ...D MES^XPDUTL("   PTF EXPANDED CODE CATEGORY File (#45.88).<<<")
 ;In file 45.89, add procedure codes to newly added DIALYSIS TYPE
 F DGPCD=39.95,54.98,50.92 D
 .S DIC="^ICD0(",DIC(0)="MX",X=DGPCD D ^DIC
 .Q:+Y'>0
 .I $D(^DIC(45.89,"ASPL",+Y_";ICD0(")) D  Q
 ..D MES^XPDUTL(">>>>Entry "_$P(Y,U,2)_" exists in PTF EXPANDED CODE File (#45.89).")
 .S DIC="^DIC(45.89,",DIC(0)=""
 .S DIC("DR")=".01///6"_";.02///"_DGPCD,X="DIALYSIS TYPE"
 .K D0 D FILE^DICN
 .I +Y<0 D  Q
 ..D MES^XPDUTL(">>>>Entry not added to PTF EXPANDED CODE File (#45.89).  No further updating will occur.")
 ..D MES^XPDUTL("   Please contact Customer Service for assistance.")
 .D MES^XPDUTL(">>>>Entry "_$S($P(Y,U,3)=1:"added to",1:"exists in")_" PTF EXPANDED CODE File (#45.89).")
 ;Place 'old' value back into Data Dictionary
 S $P(^DD(45.88,.02,0),U,2)=SAVXF
 S $P(^DD(45.88,.03,0),U,2)=SAVXI
 S $P(^DD(45.89,.01,0),U,2)=SAVXC
 K DIC,DIE,DA,DR,Y,X
 ;
 ;-Remove DIALYSIS TYPE trigger xref.
 I $D(^DD(45.05,2,1,1)) D
 .D BMES^XPDUTL(">>>Removing DIALYSIS TYPE trigger cross-reference.")
 .D DELIX^DDMOD(45.05,2,1)
 Q
PTFCAT1 ;- PTF EXPANDED CODE CATEGORY items to inactivate
 ;;KIDNEY TRANSPLANT STATUS^3060701
 ;;SUICIDE INDICATOR^3060701
 ;;LEGIONNAIRE'S DISEASE^3060701
 ;;SUBSTANCE ABUSE^3060701
 ;;DIALYSIS TYPE^^8
 ;;QUIT
