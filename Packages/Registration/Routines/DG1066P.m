DG1066P ;ALB/FSB - OTHER FEDERAL AGENCY (#35) FILE UPDATE ; 11/22/21@22:55
 ;;5.3;Registration;**1066**;Aug 13, 1993;Build 2
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the name (#.01) to OFFICE OF ECONOMIC OPPORTUNITY
 ;
 Q
POST ;
 D BMES^XPDUTL("Updating the OTHER FEDERAL AGENCY file (#35)...")
 D UPDATE ; field name update
 D BMES^XPDUTL("Update of the OTHER FEDERAL AGENCY file (#35) completed.")
 Q
UPDATE ;
 N DGX,DGXX,DGDA,DA,DR,DIE,DGSTR
 F DGX=1:1 S DGXX=$P($T(CHNG+DGX),";;",2) Q:DGXX=""  D
 .F DGDA=0:0 S DGDA=+$O(^DIC(35,"B",$E($P(DGXX,U,1),1,30),DGDA)) Q:DGDA=0  D
 ..I $D(^DIC(35,DGDA,0)),$P(^DIC(35,DGDA,0),U,1)="OFFICE OF ECONOMIC OPPURTUNITY" D
 ...S DIE="^DIC(35,",DA=DGDA,DR=".01///OFFICE OF ECONOMIC OPPORTUNITY" D ^DIE
 ...D BMES^XPDUTL("Name for "_$P(DGXX,U,1)_" has been updated.")
 ..I '$D(^DIC(35,DGDA,0)) D
 ...S DGSTR="Can't find the record for "_$P(DGXX,U,1)
 ...D BMES^XPDUTL(DGSTR_"... name (#.01) not updated.")
 Q
CHNG ;
 ;;OFFICE OF ECONOMIC OPPURTUNITY
