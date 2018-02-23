DG53949P ;DEV/BJR - 2018 MEANS TEST THRESHOLDS ;10/13/17 9:33am
 ;;5.3;Registration;**949**;Aug 13, 1993;Build 4
 ;
 ; This routine will upload the 2018 Means Test Thresholds and
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
 D BMES^XPDUTL(">>>Means Test Thresholds for 2018 being installed...")
 I $D(^DG(43,1,"MT",3180000)) D
 .D BMES^XPDUTL(" ...Entry exists for income year 2018, entry being deleted")
 .D MES^XPDUTL("    and replaced with nationally released thresholds.")
 .S DIK="^DG(43,1,""MT"",",DA=3180000,DA(1)=1
 .D ^DIK,IX1^DIK
 .K DA,D0,DIK
 K DO
 S DIC="^DG(43,1,""MT"","
 S DIC(0)="L"
 S DA(1)=1
 S (DINUM,X)=3180000
 D FILE^DICN
 S DA=+Y
 ;
 I +Y'=3180000 D  Q
 . D BMES^XPDUTL("   ...Problem encountered adding 2018 thresholds.  Please try")
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
 ;;2^32715^MT COPAY EXEMPT VET INCOME
 ;;3^6544^MT COPAY EXEMPT 1ST DEP INCOME
 ;;4^2250^MT COPAY EXEMPT INCOME PER DEP
 ;;8^80000^THRESHOLD PROPERTY
 ;;17^10650^CHILD INCOME EXCLUSION
 ;;QUIT
 Q
 ;
MAPR ; Update Maximum Annual Pension Rates
 ;
 D BMES^XPDUTL(">>>Setting Maximum Annual Pension Rate Parameters...")
 ;
 ;set MAPR rate parameter to 5(%)
 D SETPARM("DGMT MAPR GLOBAL RATE",2017,"5")
 ;
 ;set MAPR max values
 D SETPARM("DGMT MAPR 0 DEPENDENTS",2017,"13166")
 D SETPARM("DGMT MAPR 1 DEPENDENTS",2017,"17241")
 D SETPARM("DGMT MAPR N DEPENDENTS",2017,"2250")
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
