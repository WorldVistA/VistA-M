PSO7P385 ;BAY PINES-CIOFO/TN - Patch 385 Pre-Post Install routine;4/23/10 5:06pm
 ;;7.0;OUTPATIENT PHARMACY;**385**;DEC 1997;Build 27
 ;
 Q
 ;
POST ;post-install functions are coded here.
 D BMES^XPDUTL("  Starting post-install of PSO*7*385")
 D ELIG,KEYS,MENU,BIN,OPTION
 D BMES^XPDUTL("  Finished post-install of PSO*7*385")
 Q
 ;
ELIG ; populate PSO AUDIT LOG (#52.87), ELIGIBILITY (#18)
 N PSIEN,PSIEN1,DIE,DA,DR,CNTR
 D BMES^XPDUTL("   Updating PSO AUDIT LOG/ELIGIBILITY entries")
 S PSIEN=0,CNTR=0
 F  S PSIEN=$O(^PS(52.87,PSIEN)) Q:'PSIEN  D
 . S PSIEN1=$G(^PS(52.87,PSIEN,1))
 . I $P(PSIEN1,U,3)="" D
 .. S DIE=52.87,DA=PSIEN,DR="18////T" D ^DIE
 .. S CNTR=CNTR+1
 D MES^XPDUTL("    - "_CNTR_" entries updated.")
 D MES^XPDUTL("    - Done with updating PSO AUDIT LOG/ELIGIBILITY entries")
 Q
 ;
KEYS ; Rename the PSO TRICARE Security Keys
 D BMES^XPDUTL("   Renaming PSO TRICARE Security Keys")
 I $$LKUP^XPDKEY("PSO TRICARE") D
 . I $$RENAME^XPDKEY("PSO TRICARE","PSO TRICARE/CHAMPVA") D  Q
 .. D MES^XPDUTL("    - Successfully renamed PSO TRICARE Security Key to PSO TRICARE/CHAMPVA")
 . D MES^XPDUTL("    - Unable to rename PSO TRICARE Security Key")
 ;
 ; Rename the PSO TRICARE MGR Security Keys
 I $$LKUP^XPDKEY("PSO TRICARE MGR") D
 . I $$RENAME^XPDKEY("PSO TRICARE MGR","PSO TRICARE/CHAMPVA MGR") D  Q
 .. D MES^XPDUTL("    - Successfully renamed PSO TRICARE MGR Security Key to PSO TRICARE/CHAMPVA MGR")
 . D MES^XPDUTL("    - Unable to rename PSO TRICARE MGR Security Key")
 D MES^XPDUTL("    - Done with renaming PSO TRICARE Security Keys")
 Q
 ;
MENU ; Remove the cached hidden menu pointers
 N PSORDHM,PSORHA1,XQORM
 D BMES^XPDUTL("   Removing cached hidden menus")
 S PSORDHM=$O(^ORD(101,"B","PSO REJECT DISPLAY HIDDEN MENU",0))
 S XQORM=PSORDHM_";ORD(101,"
 I $D(^XUTL("XQORM",XQORM)) D
 . D MES^XPDUTL("    - Removing cached hidden menu for "_$P(^ORD(101,PSORDHM,0),U))
 . K ^XUTL("XQORM",XQORM)
 ;
 S PSORHA1=$O(^ORD(101,"B","PSO REJECTS HIDDEN ACTIONS #1",0))
 S XQORM=PSORHA1_";ORD(101,"
 I $D(^XUTL("XQORM",XQORM)) D
 . D MES^XPDUTL("    - Removing cached hidden menu for "_$P(^ORD(101,PSORHA1,0),U))
 . K ^XUTL("XQORM",XQORM)
 ;
 S PSORHA1=$O(^ORD(101,"B","PSO PMP HIDDEN ACTIONS MENU #2",0))
 S XQORM=PSORHA1_";ORD(101,"
 I $D(^XUTL("XQORM",XQORM)) D
 . D MES^XPDUTL("    - Removing cached hidden menu for "_$P(^ORD(101,PSORHA1,0),U))
 . K ^XUTL("XQORM",XQORM)
 ;
 S PSORHA1=$O(^ORD(101,"B","PSO HIDDEN ACTIONS #1",0))
 S XQORM=PSORHA1_";ORD(101,"
 I $D(^XUTL("XQORM",XQORM)) D
 . D MES^XPDUTL("    - Removing cached hidden menu for "_$P(^ORD(101,PSORHA1,0),U))
 . K ^XUTL("XQORM",XQORM)
 D MES^XPDUTL("    - Done with removing cached hidden menus")
 Q
 ;
BIN ;Update BIN Number on PRESCRIPTION reject multiple
 ;
 ; Reference to BPSNCPD3 supported by IA 4560
 ;
 N CNT,COB,DAT,DUR,RX,RN,RSPIEN,DA,DR,DIE
 D BMES^XPDUTL("   Updating BIN Numbers")
 S CNT=0
 S DAT=0 F  S DAT=$O(^PSRX("REJDAT",DAT)) Q:'DAT  D
 . S RX="" F  S RX=$O(^PSRX("REJDAT",DAT,RX)) Q:'RX  D
 .. S RN="" F  S RN=$O(^PSRX("REJDAT",DAT,RX,RN)) Q:'RN  D
 ... I $P($G(^PSRX(RX,"REJ",RN,2)),"^",8)?6N Q
 ... S RSPIEN=$P($G(^PSRX(RX,"REJ",RN,0)),"^",11) I 'RSPIEN Q
 ... S COB=$P($G(^PSRX(RX,"REJ",RN,2)),"^",7) I COB="" S COB=1
 ... K DUR D DURRESP^BPSNCPD3(RSPIEN,.DUR,COB)
 ... I 'DUR(COB,"BIN") Q
 ... S DIE="^PSRX("_RX_",""REJ"",",DA(1)=RX,DA=RN,DR=29_"////"_DUR(COB,"BIN")
 ... D ^DIE K DA,DR,DIE
 ... S CNT=CNT+1
 D MES^XPDUTL("    - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with updating BIN Numbers")
 Q
 ;
OPTION ;Update OPTION name
 N OPT,DA,DASAVE,DIE,DR
 D BMES^XPDUTL("   Updating option names")
 S OPT="PSO TRI CVA OVERRIDE REPORT"
 S DA=$O(^DIC(19,"B",OPT,""))
 I DA D  Q
 . D MES^XPDUTL("    - Option name already updated")
 . D MES^XPDUTL("    - Done with updating option names")
 S OPT="PSO TRICARE OVERRIDE REPORT"
 S DA=$O(^DIC(19,"B",OPT,"")),DASAVE=DA
 I 'DA D MES^XPDUTL("      - No IEN found for entry "_OPT) Q
 S DA=DASAVE,DIE="^DIC(19,",DR=".01///PSO TRI CVA OVERRIDE REPORT" D ^DIE
 S DA=DASAVE,DIE="^DIC(19,",DR="1///TRICARE CHAMPVA Bypass/Override Report" D ^DIE
 S DA=DASAVE,DIE="^DIC(19,"_DA_",1,",DA(1)=DA,DA=1,DR=".01///This option will allow a user to create a TRICARE CHAMPVA Bypass/Override report." D ^DIE
 D MES^XPDUTL("    - 1 entry updated")
 D MES^XPDUTL("    - Done with updating option names")
 Q
