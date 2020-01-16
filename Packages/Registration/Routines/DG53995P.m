DG53995P ;DEV/BJR - 2020 MEANS TEST THRESHOLDS ;10/17/19 10:34Am
 ;;5.3;Registration;**995**;Aug 13, 1993;Build 7
 ;
 ; This routine will upload the 2020 Means Test Thresholds and
 ; Maximum Annual Pension Rates into the MAS PARAMETERS file (#43)
 ; and the PARAMETERS file (#8989.5).
 ;
 Q
 ;
EN ; Entry point for post-install
 D MT
 D MAPR
 Q
 ;
MT ; Update Means Test Thresholds
 N D,DA,DI,DIE,DIC,DIK,DINUM,D0,DQ,DR,I,X,Y,DGEXST,DGX
 S DGEXST=0
 D BMES^XPDUTL(">>>Means Test Thresholds for 2020 being installed...")
 I $D(^DG(43,1,"MT",3200000)) D
 .D BMES^XPDUTL(" ...Entry exists for income year 2020, entry being deleted")
 .D MES^XPDUTL("    and replaced with nationally released thresholds.")
 .S DIK="^DG(43,1,""MT"",",DA=3200000,DA(1)=1
 .D ^DIK,IX1^DIK
 .K DA,D0,DIK
 K DO
 S DIC="^DG(43,1,""MT"","
 S DIC(0)="L"
 S DA(1)=1
 S (DINUM,X)=3200000
 D FILE^DICN
 S DA=+Y
 ;
 I +Y'=3200000 D  Q
 . D BMES^XPDUTL("   ...Problem encountered adding 2020 thresholds.  Please try")
 . D MES^XPDUTL("      again or contact the CIO Field Office for assistance.")
 ;
 D MES^XPDUTL("")
 S DIE=DIC,DR=""
 F I=1:1 S DGX=$P($T(DATA+I),";;",2) Q:DGX="QUIT"  D   ; build dr string
 . S DR=DR_+DGX_"////"_$P(DGX,"^",2)_";"
 . D MES^XPDUTL("   "_$P(DGX,"^",3)_" set to $"_$FN($P(DGX,"^",2),",")_".")
 D ^DIE
 Q
TEST1 ;
 S DIE=DIC,DR=""
 F I=1:1 S DGX=$P($T(DATA+I),";;",2) Q:DGX="QUIT"  D   ; build dr string
 . S DR=DR_+DGX_"////"_$P(DGX,"^",2)_";"
 . W !,"   "_$P(DGX,"^",3)_" set to $"_$FN($P(DGX,"^",2),",")_"."
 ;D ^DIE
 Q
 ;
DATA ; lines to stuff in values (field////value)
 ;;2^34171^MT COPAY EXEMPT VET INCOME
 ;;3^6834^MT COPAY EXEMPT 1ST DEP INCOME
 ;;4^2351^MT COPAY EXEMPT INCOME PER DEP
 ;;8^80000^THRESHOLD PROPERTY
 ;;17^12400^CHILD INCOME EXCLUSION
 ;;QUIT
 Q
 ;
MAPR ; Update Maximum Annual Pension Rates
 ;
 D BMES^XPDUTL(">>>Setting Maximum Annual Pension Rate Parameters...")
 ;
 ;set MAPR rate parameter to 5(%)
 D SETPARM("DGMT MAPR GLOBAL RATE",2019,"5")
 ;
 ;set MAPR max values
 D SETPARM("DGMT MAPR 0 DEPENDENTS",2019,"13752")
 D SETPARM("DGMT MAPR 1 DEPENDENTS",2019,"18008")
 D SETPARM("DGMT MAPR N DEPENDENTS",2019,"2351")
 Q
 ;
SETPARM(DGPARM,DGINST,DGVALU) ;set PACKAGE entity parameters
 ;
 ;  DBIA: #2263 SUPPORTED PARAMETER TOOL ENTRY POINTS
 ;
 ;  Input:
 ;    DGPARM - PARAMETER DEFINITION name
 ;    DGINST - parameter instance
 ;    DGVALU - parameter value
 ;
 ;  Output:
 ;    None
 ;
 N DGERR
 ;
 D EN^XPAR("PKG",DGPARM,DGINST,DGVALU,.DGERR)
 I $G(DGERR) D  Q
 .D MES^XPDUTL(DGPARM_" parameter, instance "_DGINST_", FAILED! ("_DGVALU_")")
 ;
 I '$G(DGERR) D
 .I DGPARM="DGMT MAPR GLOBAL RATE" D
 ..D MES^XPDUTL("   "_DGPARM_" parameter, instance "_DGINST_", set to "_DGVALU_"%.")
 .I DGPARM'="DGMT MAPR GLOBAL RATE" D
 ..D MES^XPDUTL("   "_DGPARM_" parameter, instance "_DGINST_", set to $"_$FN(DGVALU,",")_".")
 Q
