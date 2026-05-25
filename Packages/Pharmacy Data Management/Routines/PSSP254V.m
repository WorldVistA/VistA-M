PSSP254V ;CAN/EJD - PSS*1*254 Uninstall ; Jul 22, 2024@23:47
 ;;1.0;PHARMACY DATA MANAGEMENT;**254**;9/30/97;Build 109
 ;
 ;Split into two routines PSSP254U and PSSP254V
 ;
 Q    ;Call @Backout
 ;
 ;MTXT and PSSLINE are NEWed in the calling routine (PSSP254U)
 ;
NEWROUTE ;New route rollback
 N DA,DIK,NAME,XUMF
 ;
 D SETTXT^PSSP254U("")
 S MTXT="STANDARD MEDICATION ROUTES file (#51.23) New Entries:"
 D BMES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 D SETTXT^PSSP254U("=================================================")
 ;
 ;If file was not impacted, leave
 I '$D(^XTMP("PSSP254B","NEWROUTE")) D  Q
 . S MTXT="No updates needed"
 . D MES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 ;
 S DIK="^PS(51.23,"
 S XUMF=1
 ;
 ;Loop through ^XTMP("PSSP254B","NEWROUTE",51.23,DA and delete
 S DA=""
 F  S DA=$O(^XTMP("PSSP254B","NEWROUTE",51.23,DA)) Q:DA=""  D
 . S NAME=^XTMP("PSSP254B","NEWROUTE",51.23,DA)
 . ;
 . ;If already removed will be "", if overwritten it is already gone
 . I $$GET1^DIQ(51.23,DA,.01)'=NAME D  Q
 . . S MTXT="  - '"_NAME_"' no update needed"
 . . D MES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 . ;
 . S MTXT="  - Removed "_NAME
 . D ^DIK
 . D MES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 ;
 ;Index Rebuilds
 D SETTXT^PSSP254U("")
 S MTXT="MEDICATION ROUTES Index Rebuild:"
 D BMES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 ;
 K DIK
 S MTXT="  - Medication Routes"
 D MES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 S DIK="^PS(51.2,",DIK(1)=".01^B" D ENALL2^DIK K DIK   ;Wipe
 S DIK="^PS(51.2,",DIK(1)=".01^B" D ENALL^DIK K DIK    ;Rebuild
 ;
 S MTXT="  - Standard Medication Routes"
 D MES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 S DIK="^PS(51.23,",DIK(1)="1^C" D ENALL2^DIK K DIK    ;Wipe
 S DIK="^PS(51.23,",DIK(1)="1^C" D ENALL^DIK K DIK     ;Rebuild
 Q
 ;
NEWUNIT ;New unit rollback
 N DA,DIK,NAME,XUMF
 ;
 S MTXT="o New DOSE UNITs:" D BMES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 ;
 ;If file was not impacted, leave
 I '$D(^XTMP("PSSP254B","NEWUNIT")) D  Q
 . S MTXT="No updates needed"
 . D MES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 ;
 S DIK="^PS(51.24,"
 S XUMF=1
 ;
 ;Loop through ^XTMP("PSSP254B","NEWUNIT",51.24,DA and delete
 S DA=""
 F  S DA=$O(^XTMP("PSSP254B","NEWUNIT",51.24,DA)) Q:DA=""  D
 . S NAME=^XTMP("PSSP254B","NEWUNIT",51.24,DA)
 . ;
 . ;If already removed will be "", if overwritten it is already gone
 . I $$GET1^DIQ(51.24,DA,.01)'=NAME D  Q
 . . S MTXT="  - '"_NAME_"' no update needed"
 . . D MES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 . ;
 . S MTXT="  - Removed '"_NAME_"'"
 . D ^DIK
 . D MES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 ;
 ;Index Rebuilds
 D SETTXT^PSSP254U("")
 S MTXT="o Index Rebuild:"
 D BMES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 ;
 K DIK
 S MTXT="  - DOSE UNITS"
 D MES^XPDUTL(MTXT),SETTXT^PSSP254U(MTXT)
 S DIK="^PS(51.24,",DIK(1)=".01^B" D ENALL2^DIK K DIK  ;Wipe
 S DIK="^PS(51.24,",DIK(1)=".01^B" D ENALL^DIK K DIK   ;Rebuild
 ;
 S DIK="^PS(51.24,",DIK(1)="1^C" D ENALL2^DIK K DIK    ;Wipe
 S DIK="^PS(51.24,",DIK(1)="1^C" D ENALL^DIK K DIK     ;Rebuild
 Q
 ;
SETUP ;Setup the post patch rollback calls - from PSSP254U@SAVELOG
 ;Launched with X ^XTMP("PSSP254U","CODE","DOSEUNIT")
 S ^XTMP("PSSP254U","CODE","DOSEUNIT")="N LINE F LINE=1:1:5 X ^XTMP(""PSSP254U"",""CODE"",""DOSEUNIT"",LINE)"
 S ^XTMP("PSSP254U","CODE","DOSEUNIT",1)="K DIK S DIK=""^PS(51.24,"",DIK(1)="".01^B"" D ENALL2^DIK K DIK"
 S ^XTMP("PSSP254U","CODE","DOSEUNIT",2)="S DIK=""^PS(51.24,"",DIK(1)="".01^B"" D ENALL^DIK K DIK"
 S ^XTMP("PSSP254U","CODE","DOSEUNIT",3)="S DIK=""^PS(51.24,"",DIK(1)=""1^C"" D ENALL2^DIK K DIK"
 S ^XTMP("PSSP254U","CODE","DOSEUNIT",4)="S DIK=""^PS(51.24,"",DIK(1)=""1^C"" D ENALL^DIK K DIK"
 S ^XTMP("PSSP254U","CODE","DOSEUNIT",5)="W !,""Dose Unit Index Rebuild Complete."""
 ;
 ;Launched with X ^XTMP("PSSP254U","CODE","ROUTE")
 S ^XTMP("PSSP254U","CODE","ROUTE")="N LINE F LINE=1:1:5 X ^XTMP(""PSSP254U"",""CODE"",""ROUTE"",LINE)"
 S ^XTMP("PSSP254U","CODE","ROUTE",1)="K DIK S DIK=""^PS(51.2,"",DIK(1)="".01^B"" D ENALL2^DIK K DIK"
 S ^XTMP("PSSP254U","CODE","ROUTE",2)="S DIK=""^PS(51.2,"",DIK(1)="".01^B"" D ENALL^DIK K DIK"
 S ^XTMP("PSSP254U","CODE","ROUTE",3)="S DIK=""^PS(51.23,"",DIK(1)=""1^C"" D ENALL2^DIK K DIK"
 S ^XTMP("PSSP254U","CODE","ROUTE",4)="S DIK=""^PS(51.23,"",DIK(1)=""1^C"" D ENALL^DIK K DIK"
 S ^XTMP("PSSP254U","CODE","ROUTE",5)="W !,""Medical Route Index Rebuild Complete."""
 Q
