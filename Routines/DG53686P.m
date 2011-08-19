DG53686P ;ALB/PHH - 2006 MEANS TEST THRESHOLDS ;12/6/2005
 ;;5.3;Registration;**686**;Aug 13, 1993
 ;
 ; This routine will upload the 2006 Means Test Thresholds and
 ; Maximum Annual Pension Rates onto your system.
 ;
EN ; Entry point for post-install
 D MT
 D MAPR
 Q
 ;
MT ; Update Means Test Thresholds
 N DA,DIE,DIC,DINUM,DR,I,X,Y,EXST
 S EXST=0
 D BMES^XPDUTL(">>>Means Test Thresholds for 2006 being installed...")
 I $D(^DG(43,1,"MT",3060000)) D
 .D BMES^XPDUTL(" ...Entry exists for income year 2005, entry being deleted")
 .D MES^XPDUTL("     and replaced with nationally released thresholds.")
 .S DIK="^DG(43,1,""MT"",",DA=3060000,DA(1)=1
 .D ^DIK,IX1^DIK
 .K DA,D0,DIK
 K DO
 S DIC="^DG(43,1,""MT"","
 S DIC(0)="L"
 S DA(1)=1
 S (DINUM,X)=3060000
 D FILE^DICN
 S DA=+Y
 ;
 I +Y'=3060000 D  Q
 . D BMES^XPDUTL("   ...Problem encountered adding 2006 thresholds.  Please try")
 . D MES^XPDUTL("      again or contact the CIO Field Office for assistance.")
 ;
 D MES^XPDUTL("")
 S DIE=DIC,DR=""
 F I=1:1 S X=$P($T(DATA+I),";;",2) Q:X="QUIT"  D   ; build dr string
 . S DR=DR_+X_"////"_$P(X,"^",2)_";"
 . D MES^XPDUTL("   "_$P(X,"^",3)_" set to $"_$FN($P(X,"^",2),","))
 D ^DIE
 Q
 ;
DATA ; lines to stuff in values (field////value)
 ;;2^26902^MT COPAY EXEMPT VET INCOME
 ;;3^5383^MT COPAY EXEMPT 1ST DEP INCOME
 ;;4^1806^MT COPAY EXEMPT INCOME PER DEP
 ;;8^80000^THRESHOLD PROPERTY
 ;;17^8450^CHILD INCOME EXCLUSION
 ;;QUIT
 Q
 ;
MAPR ; Update Maximum Annual Pension Rates
 ;
 D BMES^XPDUTL(">>>Setting Maximum Annual Pension Rate Parameters...")
 ;
 ;set MAPR rate parameter to 5(%)
 D SETPARM("DGMT MAPR GLOBAL RATE",2005,5)
 ;
 ;set MAPR max values
 D SETPARM("DGMT MAPR 0 DEPENDENTS",2005,10579)
 D SETPARM("DGMT MAPR 1 DEPENDENTS",2005,13855)
 D SETPARM("DGMT MAPR N DEPENDENTS",2005,1806)
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
