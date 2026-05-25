PSSP254U ;CAN/EJD - PSS*1*254 Uninstall ; Nov 02, 2022@16:00
 ;;1.0;PHARMACY DATA MANAGEMENT;**254**;9/30/97;Build 109
 ;
 ;Split into two routines PSSP254U and PSSP254V
 ;
 Q    ;Call @Backout
 ;
 ;Patterned after PSSP254@POST
BACKOUT ;Perform the backout
 N PSSLINE,MTXT
 ;
 ;Verify there is backup data
 I '$D(^XTMP("PSSP254B")) W !!,"No data to rollback.  Nothing Done." Q
 ;
 ;Prompt the user "Are you sure you want to do this" before continuing
 I '$$GONOGO() Q
 ;
 ;This TEMP global will be used for the Mailman Message
 K ^TMP("PSS254P",$J)
 ;
 I $G(U)="" S U="^"
 ;
 ;Updates to the PPSN & FDB WebServices
 D WS
 ;
 ;Updates to DOSE UNITS (#51.24) and DOSE UNIT CONVERSION (#51.25) files
 ;New units were added late.  To facilitate component testing, handled in a separate call.
 D ST
 D NEWUNIT^PSSP254V
 ;
 ;Updates to STANDARD MEDICATION ROUTES (#51.23) file
 ;New routes were added late.  To facilitate component testing, handled in a separate call.
 D MR
 D NEWROUTE^PSSP254V
 ;
 ;Updates to the DOSING CHECK FREQUENCY field for the files #51 and #51.1
 D DCF
 ;
 ;Sends Mailman Message to Installer and PSNMGR key holders listing updates
 D MAIL
 ;
 ;Backup the rollback log
 D SAVELOG
 ;
 K ^TMP("PSS254P",$J)
 Q
 ;
 ;Prompt the user Are you sure before continuing
 ;Y:  0 = No // 1 = Yes
GONOGO() ;Safety Check
 N DIR,X,Y
 ;
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to do this"
 S DIR("B")="No"   ;Default to No
 D ^DIR
 ;
 I Y'=1 W !!,"Nothing Done" Q 0
 Q 1
 ;
 ;Save and wipe the original rollback log
SAVELOG ;Save
 K ^XTMP("PSSP254U")                    ;Wipe to ensure this is clear
 D SETUP^PSSP254V                       ;Save post patch rollback code for the indice rebuild
 M ^XTMP("PSSP254U")=^XTMP("PSSP254B")  ;Save the original rollback log
 K ^XTMP("PSSP254B")                    ;Wipe the original rollback log
 Q
 ;
DCF ;File 51 and 51.1 Dosing Check Frequency
 N FILE,FIELD,MEDSCH,OLDFREQ,NEWFREQ,XX,LINE,DIE,DR,DA,X,Y,FREQCHK,DRGCTR,DRGFILE,DRGNODE,TMPMSG
 ;
 D SETTXT("")
 S MTXT="DOSING CHECK FREQUENCY field Conversion:"
 D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 D SETTXT("========================================")
 ;
 I '$D(^XTMP("PSSP254B","DCF")) D
 . S MTXT="No updates needed"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 E  D
 . S FILE="" F  S FILE=$O(^XTMP("PSSP254B","DCF",FILE)) Q:'FILE  D
 . . S MTXT="o File: "_$S(FILE=51:"MEDICATION INSTRUCTION (#51)",1:"ADMINISTRATION SCHEDULE (#51.1)")
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . . S MEDSCH="" F  S MEDSCH=$O(^XTMP("PSSP254B","DCF",FILE,MEDSCH)) Q:MEDSCH=""  D
 . . . S FIELD="" F  S FIELD=$O(^XTMP("PSSP254B","DCF",FILE,MEDSCH,FIELD)) Q:FIELD=""  D
 . . . . S XX=$G(^XTMP("PSSP254B","DCF",FILE,MEDSCH,FIELD))
 . . . . S NEWFREQ=$P(XX,U,2)
 . . . . S OLDFREQ=$P(XX,U)
 . . . . ;
 . . . . S MTXT="  - "_$$GET1^DIQ(FILE,MEDSCH,.01)_" ("_$$GET1^DIQ(FILE,MEDSCH,$S(FILE=51:1,1:8))
 . . . . ;
 . . . . ;Already restored
 . . . . I OLDFREQ=$$GET1^DIQ(FILE,MEDSCH,$S(FILE=51:32,1:11)) D  Q
 . . . . . S MTXT=MTXT_") - no update needed"
 . . . . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . . . . ;
 . . . . ;If it was deleted, restore drugs too
 . . . . I NEWFREQ="@" D
 . . . . . K DIE,DR S DIE=FILE,DR=FIELD_"////"_OLDFREQ,DA=MEDSCH D ^DIE
 . . . . . S MTXT=MTXT_") - '"_OLDFREQ_"' restored."
 . . . . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . . . . . I $D(^XTMP("PSSP254B","DCFDRUG",FILE,MEDSCH,FIELD)) D DCFDRG(FILE,MEDSCH,FIELD)
 . . . . E  D
 . . . . . K DIE,DR S DIE=FILE,DR=FIELD_"////"_OLDFREQ,DA=MEDSCH D ^DIE
 . . . . . S MTXT=MTXT_") - Restored from '"_NEWFREQ_"' to '"_OLDFREQ_"'"
 . . . . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . . D SETTXT("")
 Q
 ;
 ;FILE is 51 (Medication Instruction) or 51.1 (Administration Schedule)
 ;MEDSCH is the DA for the FILE entry
 ;FIELD is the Dosing Check Frequency field in FILE
DCFDRG(FILE,MEDSCH,FIELD) ;Restore impacted drugs
 N DA,DIC,DRGCTR,DRGFILE,DRGLIST,DRGNAME,X
 ;
 S DRGFILE=$S(FILE=51:51.321,1:51.111)
 S DRGNODE=$S(FILE=51:5,1:4)
 ;
 S DRGCTR=""
 F  S DRGCTR=$O(^XTMP("PSSP254B","DCFDRUG",FILE,MEDSCH,FIELD,DRGCTR)) Q:DRGCTR=""  D
 . S X=$P(^XTMP("PSSP254B","DCFDRUG",FILE,MEDSCH,FIELD,DRGCTR),U)
 . S DRGNAME=$P(^XTMP("PSSP254B","DCFDRUG",FILE,MEDSCH,FIELD,DRGCTR),U,2)
 . S DA(1)=MEDSCH
 . S DIC="^PS("_FILE_","_DA(1)_","_DRGNODE_","
 . S DIC(0)="L"
 . D FILE^DICN
 . ;
 . I DRGNAME'="" S DRGLIST(DRGNAME)=""   ;Setup for alphabetical display
 ;
 I $D(DRGLIST) D
 . S MTXT="    Restored Drugs"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . S DRGNAME="" F  S DRGNAME=$O(DRGLIST(DRGNAME)) Q:DRGNAME=""  D
 . . S MTXT="      "_DRGNAME
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
WS ; Web Service updates
 N FDA,PORT,PSSERR,PSSIEN,PSSIENC,SERVER,SRVNAME
 ;
 ;If webservices were not impacted, leave
 I '$Data(^XTMP("PSSP254B","WS")) D MES^XPDUTL("No Web Services update needed") Q
 ;
 D MES^XPDUTL("Restoring the Web Services:")
 S PSSIEN=""
 F  S PSSIEN=$O(^XTMP("PSSP254B","WS",18.12,PSSIEN)) Q:PSSIEN=""  D
 . K FDA
 . ;
 . S SRVNAME=$P($G(^XTMP("PSSP254B","WS",18.12,PSSIEN,0)),U,1)
 . S SERVER=$P($G(^XTMP("PSSP254B","WS",18.12,PSSIEN,0)),U,4)
 . S PORT=$P($G(^XTMP("PSSP254B","WS",18.12,PSSIEN,0)),U,3)
 . ;
 . ;Verify current loadout
 . I SERVER=$$GET1^DIQ(18.12,PSSIEN,.04),PORT=$$GET1^DIQ(18.12,PSSIEN,.03) D  Q
 . . S MTXT="o WEB SERVER '"_SRVNAME_"' no update needed"
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . ;
 . S PSSIENC=PSSIEN_"," D DISABLE(SRVNAME,PSSIENC)
 . S FDA(18.12,PSSIENC,.04)=SERVER
 . S FDA(18.12,PSSIENC,.03)=PORT
 . S FDA(18.12,PSSIENC,.06)=1 ; status
 . D FILE^DIE("K","FDA","PSSERR")
 . I '$D(PSSERR("DIERR",1,"TEXT",1)) S MTXT="o WEB SERVER '"_SRVNAME_"' updated successfully"
 . I $D(PSSERR("DIERR",1,"TEXT",1)) S MTXT="o WEB SERVER '"_SRVNAME_"' Error: "_PSSERR("DIERR",1,"TEXT",1)
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
MR ; STANDARD MEDICATION ROUTES (#51.23) file updates
 N DA,DIE,DR,FROM,NAME,OLD
 ;
 D SETTXT("")
 S MTXT="STANDARD MEDICATION ROUTES file (#51.23) Updates:"
 D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 D SETTXT("=================================================")
 ;
 ;If file was not impacted, leave
 I '$D(^XTMP("PSSP254B","SMR-U")) D  Q
 . S MTXT="No updates needed"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 ;Loop through ^XTMP("PSSP254B","SMR-U",51.23,DA - roll back to $P(1)
 S DA=""  F  S DA=$O(^XTMP("PSSP254B","SMR-U",51.23,DA)) Q:DA=""  D
 . S OLD=$P(^XTMP("PSSP254B","SMR-U",51.23,DA,1),U)
 . S NAME=$$GET1^DIQ(51.23,DA,.01)
 . ;
 . ;Verify whether update is needed
 . I OLD=$$GET1^DIQ(51.23,DA,1) D  Q
 . . S MTXT="  - '"_NAME_"' no update needed"
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . ;
 . S MTXT="  - Restored "_NAME_" from '"_$$GET1^DIQ(51.23,DA,1)_"' to '"_OLD_"'"
 . I OLD="" S OLD="@"
 . S DIE="^PS(51.23,",DR="1////"_OLD D ^DIE
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
ST ; Update entries in DOSE UNITS file (#51.24) and DOSE UNIT CONVERSION file (#51.25)
 N II,JJ,PSA,PSI,PSJ,PSL,PSLIST,PSX,SYM,TXT,X
 ;
 S TXT="DOSE UNITS file (#51.24) Updates"
 D BMES^XPDUTL(TXT)
 D SETTXT("")
 D SETTXT(TXT)
 D SETTXT("===================================================================")
 ;
 ;File 51.24 - FDB Dose Unit
 D FDB
 ;
 D SETTXT("")
 ;
 ;File 51.24 - Synonyms
 D SYN
 ;
 D SETTXT("")
 ;
 ;File 51.24 - Deleted Entries
 D DEL24
 ;
 D SETTXT("")
 ;
 S TXT="DOSE UNIT CONVERSION file (#51.25) Updates"
 D BMES^XPDUTL(TXT)
 D SETTXT("")
 D SETTXT(TXT)
 D SETTXT("===================================================================")
 ;
 ;File 51.25 - Dose Unit 1
 D DUC
 ;
 D SETTXT("")
 ;
 ;File 51.25 - Deleted Entries
 D DEL25
 ;
 D SETTXT("")
 ;
 ;File 51.25 - Dose Unit 2
 D UNIT2
 ;
 K DIE,DR,DA,XUMF
 Q
 ;
FDB ; 1st DataBank Dose Unit Updates
 N DA,DIE,DR,NAME,OLD,XUMF
 ;
 S MTXT="o FDB DOSE UNIT updates:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 ; 
 I '$D(^XTMP("PSSP254B","DU-U",51.24)) D  Q
 . S MTXT="No updates needed"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 S DA=""  F  S DA=$O(^XTMP("PSSP254B","DU-U",51.24,DA)) Q:DA=""  D
 . S NAME=$P(^XTMP("PSSP254B","DU-U",51.24,DA,1),U)
 . S OLD=$P(^XTMP("PSSP254B","DU-U",51.24,DA,1),U,2)
 . ;
 . I $$GET1^DIQ(51.24,DA,1)=OLD D  Q
 . . S MTXT="  - Entry #"_DA_" ("_NAME_"): no update needed"
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . ;
 . S MTXT="  - Entry #"_DA_" ("_NAME_"): restored from '"_$$GET1^DIQ(51.24,DA,1)_"' to '"_OLD_"'"
 . I OLD="" S OLD="@"
 . S XUMF=1,DR="1////"_OLD,DIE=51.24 D ^DIE
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
SYN ; SYNONYM updates
 N DA,DIE,DR,ENTRY,SFILE,SUBS,SYN
 ;
 ;SUBS(X)
 ; 1 = FILE
 ; 2 = DA(1)
 ; 3 = TMP
 ; 4 = DA
 ;
 S MTXT="o New Synonyms:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 I '$D(^XTMP("PSSP254B","DU-SYN-A")) D  Q
 . S MTXT="No updates needed"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 S SUBS(1)=""  F  S SUBS(1)=$O(^XTMP("PSSP254B","DU-SYN-A",SUBS(1))) Q:SUBS(1)=""  D
 . S SUBS(2)=""  F  S SUBS(2)=$O(^XTMP("PSSP254B","DU-SYN-A",SUBS(1),SUBS(2))) Q:SUBS(2)=""  D
 . . S SUBS(3)=""  F  S SUBS(3)=$O(^XTMP("PSSP254B","DU-SYN-A",SUBS(1),SUBS(2),SUBS(3))) Q:SUBS(3)=""  D
 . . . S SUBS(4)=""  F  S SUBS(4)=$O(^XTMP("PSSP254B","DU-SYN-A",SUBS(1),SUBS(2),SUBS(3),SUBS(4))) Q:SUBS(4)=""  D
 . . . . S DA=SUBS(4),DA(1)=SUBS(2)
 . . . . S SYN=^XTMP("PSSP254B","DU-SYN-A",SUBS(1),DA(1),SUBS(3),DA)
 . . . . S ENTRY=$$GET1^DIQ(51.24,DA(1),.01)
 . . . . ;
 . . . . ;No update needed
 . . . . I $$GET1^DIQ(51.242,DA_","_DA(1),.01)'=SYN D  Q
 . . . . . S MTXT="  - Entry '"_ENTRY_"': '"_SYN_"' no updated needed"
 . . . . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . . . . ;
 . . . . ;Update
 . . . . S MTXT="  - Entry '"_ENTRY_"': '"_SYN_"' removed"
 . . . . S DIE="^PS(51.24,"_DA(1)_",1,",DR=".01////@" D ^DIE
 . . . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 Q
 ;
DEL24 ; delete entries from file #51.24
 N CTR,DA,DATA,DIC,DIE,ENTRY,SUB,X,XUMF
 S XUMF=1
 ;
 S MTXT="o Deleted entries:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 I '$D(^XTMP("PSSP254B","DU-D")) D  Q
 . S MTXT="No updates needed"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 S SUB(1)=""  F  S SUB(1)=$O(^XTMP("PSSP254B","DU-D",51.24,SUB(1))) Q:SUB(1)=""  D
 . S DA=SUB(1)
 . S DA(1)=DA
 . S DATA=$G(^XTMP("PSSP254B","DU-D",51.24,SUB(1),0))
 . ;
 . ;Verify it has not already been restored
 . I +$$FIND1^DIC(51.24,"","B",$P(DATA,U)) D  Q
 . . S MTXT="  - Entry '"_$P(DATA,U)_"' no update needed."
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . ;
 . ;Main Fields
 . S DR=".01////"_$P(DATA,U)
 . I $P(DATA,U,2)'="" S DR=DR_";1////"_$P(DATA,U,2)
 . I $P(DATA,U,3)'="" S DR=DR_";3////"_$P(DATA,U,3)
 . S DIE=51.24
 . D ^DIE
 . ;
 . ;Repeating Synonym field is Node 1
 . S CTR=0  F  S CTR=$O(^XTMP("PSSP254B","DU-D",51.24,SUB(1),1,CTR)) Q:CTR=""  D
 . . S X=$G(^XTMP("PSSP254B","DU-D",51.24,SUB(1),1,CTR,0))
 . . S DIC="^PS(51.24,"_DA(1)_",1,"
 . . S DIC(0)="L"
 . . D FILE^DICN
 . ;
 . S MTXT="  - Entry '"_$P(DATA,U)_"' restored"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
DUC ; update the DOSE UNIT 1 (#.01) of the DOSE UNIT CONVERSION file (#51.25)
 N DA,DIE,DR,NAME,OLD,XUMF
 ;
 S MTXT="o DOSE UNIT 1 updates:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 I '$D(^XTMP("PSSP254B","DUC-U")) D  Q
 . S MTXT="No updates needed"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 ; 
 S DA=""  F  S DA=$O(^XTMP("PSSP254B","DUC-U",51.25,DA)) Q:DA=""  D
 . S OLD=$P(^XTMP("PSSP254B","DUC-U",51.25,DA,.01),U)
 . S NAME=$$GET1^DIQ(51.25,DA,.01)
 . ;
 . I (OLD="")!(NAME=OLD) D  Q
 . . S MTXT="  - Entry #"_DA_" ("_NAME_"): no update needed"
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . ;
 . S MTXT="  - Entry #"_DA_": restored from '"_NAME_"' to '"_OLD_"'"
 . S XUMF=1,DR=".01////"_OLD,DIE=51.25 D ^DIE
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
DEL25 ; delete entries from the DOSE UNIT CONVERSION file (#51.25)
 N CTR,DA,DATA,DIC,DIE,DR,ENTRY,SUB,X,XUMF
 S XUMF=1
 ;
 S MTXT="o Deleted entries:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 I '$D(^XTMP("PSSP254B","DUC-D")) D  Q
 . S MTXT="No updates needed"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 S SUB(1)=""  F  S SUB(1)=$O(^XTMP("PSSP254B","DUC-D",51.25,SUB(1))) Q:SUB(1)=""  D
 . S DA=SUB(1)
 . S DA(1)=DA
 . S DATA=$G(^XTMP("PSSP254B","DUC-D",51.25,SUB(1),0))
 . ;
 . ;Verify it has not already been restored
 . I +$$FIND1^DIC(51.25,"","B",$P(DATA,U)) D  Q
 . . S MTXT="  - Entry '"_$P(DATA,U)_"' no update needed."
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . ;
 . ;Main Fields
 . S DR=".01////"_$P(DATA,U)
 . S DIE=51.25
 . D ^DIE
 . ;
 . ;Repeating Synonym field is Node 1
 . S CTR=0  F  S CTR=$O(^XTMP("PSSP254B","DUC-D",51.25,SUB(1),1,CTR)) Q:CTR=""  D
 . . S X=$G(^XTMP("PSSP254B","DUC-D",51.25,SUB(1),1,CTR,0))
 . . S DIC="^PS(51.25,"_DA(1)_",1,"
 . . S DIC(0)="L"
 . . D FILE^DICN
 . ;
 . S MTXT="  - Entry '"_$P(DATA,U)_"' restored"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
UNIT2 ; update the DOSE UNIT 2 field (#.01) and the CONVERSION FACTOR field (#1) entries in file (#51.25)
 N CTR,CURCONV,CURRENT,DATA,DA,DIE,DR,NAME,SUB,XUMF
 ;
 S MTXT="o DOSE UNIT 2 updates:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 ; 
 I '$D(^XTMP("PSSP254B","DU2C-U")),'$D(^XTMP("PSSP254B","DU2C-D")) D  Q
 . S MTXT="No updates needed"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 S XUMF=1
 ;
 ;DU2C-U - Updates first - Verify that updates are really needed.
 S SUB=""  F  S SUB=$O(^XTMP("PSSP254B","DU2C-U",51.251,SUB)) Q:SUB=""  D
 . S CTR=""  F  S CTR=$O(^XTMP("PSSP254B","DU2C-U",51.251,SUB,CTR)) Q:CTR=""  D
 . . S DATA=$G(^XTMP("PSSP254B","DU2C-U",51.251,SUB,CTR,0))
 . . S DA(1)=SUB,DA=CTR
 . . S NAME=$$GET1^DIQ(51.25,DA(1),.01)
 . . S CURRENT=$$GET1^DIQ(51.251,DA_","_DA(1)_",",.01)
 . . S CURCONV=$$GET1^DIQ(51.251,DA_","_DA(1)_",",1)
 . . ;
 . . ;Verify whether the Synonym or Conversion Factor need to be rolled back
 . . I CURRENT=$P(DATA,U),CURCONV=$P(DATA,U,2) D  Q
 . . . S MTXT="  - Entry '"_NAME_"': no update needed for "_CURRENT
 . . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . . ;
 . . S DIE="^PS(51.25,"_DA(1)_",1,"
 . . ;
 . . I CURRENT'=$P(DATA,U) D
 . . . S DR=".01////"_$P(DATA,U)
 . . . I CURCONV'=$P(DATA,U,2) S DR=DR_";1////"_$P(DATA,U,2)
 . . . S MTXT="  - Entry '"_NAME_"': restored '"_CURRENT_"' to '"_$P(DATA,U)_"'"
 . . ;
 . . I CURRENT=$P(DATA,U),CURCONV'=$P(DATA,U,2) D
 . . . S DR="1////"_$P(DATA,U,2)
 . . . S MTXT="  - Entry '"_NAME_"': restored '"_CURRENT_"'"
 . . ;
 . . D ^DIE
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 ;DU2C-D - Deletions next
 S SUB=""  F  S SUB=$O(^XTMP("PSSP254B","DU2C-D",51.251,SUB)) Q:SUB=""  D
 . S CTR=""  F  S CTR=$O(^XTMP("PSSP254B","DU2C-D",51.251,SUB,CTR)) Q:CTR=""  D
 . . S DATA=$G(^XTMP("PSSP254B","DU2C-D",51.251,SUB,CTR,0))
 . . S DA(1)=SUB,DA=CTR
 . . S NAME=$$GET1^DIQ(51.25,DA(1),.01)
 . . ;
 . . ;Verify whether this has already been restored
 . . I $$FIND1^DIC(51.251,","_DA(1)_",","B",$P(DATA,U)) D  Q
 . . . S MTXT="  - Entry '"_NAME_"': no update needed for "_$P(DATA,U)
 . . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . . ;
 . . S DIE="^PS(51.25,"_DA(1)_",1,"
 . . S DR=".01////"_$P(DATA,U)_";1////"_$P(DATA,U,2)
 . . D ^DIE
 . . ;
 . . S MTXT="  - Entry '"_NAME_"': restored '"_$P(DATA,U)_"'"
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
 ;Utilities copied from PSSP254
DISABLE(SRVNAME,PSSIEN) ; Disable PPSN server if it exists-will set it back to enabled
 N PSSERVER,PSSERR
 ; Set STATUS to DISABLED
 S PSSERVER(18.12,PSSIEN,.06)=0
 D FILE^DIE("","PSSERVER","PSSERR") ; update existing entry
 D BMES^XPDUTL("o WEB SERVER '"_SRVNAME_"' server temporarily disabled.")
 Q
 ;
SETTXT(TXT) ; Setting Plain Text
 S PSSLINE=$G(PSSLINE)+1,^TMP("PSS254P",$J,PSSLINE)=TXT
 Q
 ;
MAIL ; Sends Mailman message
 N II,XMX,XMSUB,XMDUZ,XMTEXT,XMY,DIFROM
 ;
 D BMES^XPDUTL("Sending Mailman Message with updates...")
 ;
 S II=0 F  S II=$O(^XUSEC("PSNMGR",II)) Q:'II  S XMY(II)=""
 S XMY(DUZ)="",XMSUB="PSS*1*254 FDB v4.5 Upgrade Uninstall"
 S XMDUZ="PSS*1*254 Uninstall",XMTEXT="^TMP(""PSS254P"",$J,"
 D ^XMD
 Q
