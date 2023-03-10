DG1062P ;ALB/FSB - ICD-10 POST-INIT ; 7/16/21@17:22
 ;;5.3;Registration;**1062**;Aug 13, 1993;Build 6
 ;
 Q
ADD ;
 N DIC,DGY,DGX,DGDT,DGDTR,DIE,DR
 D BMES^XPDUTL("Adding Dialysis Procedure Codes")
 S DIC="^DIC(45.89,",DGDTR=$O(^DIC(45.88,"B","DIALYSIS TYPE",0)) I DGDTR="" D BMES^XPDUTL("No pointer to Dialysis Type record.") Q
 S DGDT=$P(^DIC(45.88,DGDTR,0),"^",1) ;"Dialysis Type"
 F DGY=1:1 S DGX=$P($T(CHNG+DGY),";;",2) Q:DGX=""  D
 .I $O(^DIC(45.89,"ACODE",DGX,0))'="" D BMES^XPDUTL("Procedure code "_DGX_" already exists.") Q
 .K DO,DA S X=DGDTR,DIC(0)="" D FILE^DICN
 .I Y=-1 D BMES^XPDUTL(DGDT_" record was not added to the file #45.89") Q
 .S DIE="^DIC(45.89,",DA=$P(Y,"^",1),DR=".02///"_DGX D ^DIE
 .D BMES^XPDUTL(DGX_" procedure code was added to the "_DGDT_" record.")
 D BMES^XPDUTL("Update of PTF EXPANDED CODE complete.")
 Q
CHNG ; Codes to add
 ;;5A1D70Z
 ;;5A1D80Z
 ;;5A1D90Z
