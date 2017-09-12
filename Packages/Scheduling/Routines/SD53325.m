SD53325 ;BPFO/JRP - Post init for patch 325;11/10/2003
 ;;5.3;Scheduling;**325**;Aug 13, 1993
 ;
PRE ;Main entry point for pre-install
 ;Do AmbCare pre-install (copied from SD53142)
 ;Remove ERROR CODE DESCRIPTION (field #11) as an identifier of the
 ; TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file (#409.76)
 ; (this causes problems when installing error codes)
 I ($D(^DD(409.76,0,"ID",11))) D
 .N TMP,X
 .S X(1)=" "
 .S X(2)="Removing ERROR CODE DESCRIPTION (field #11) as an identifier"
 .S X(3)="of the TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file"
 .S X(4)="(#409.76) as it causes problems when installing error codes."
 .S X(5)=" "
 .D MES^XPDUTL(.X) K X
 .K ^DD(409.76,0,"ID",11)
 .Q:($D(^DD(409.76,0,"ID")))
 .S TMP=$P(^SD(409.76,0),U,2)
 .S TMP=$TR(TMP,"I","")
 .S $P(^SD(409.76,0),U,2)=TMP
 .Q
 Q
 ;
POST ;Main entry point for post-install
 N TEXT
 ;Ensure entry 7 doesn't exist in Outpatient Classification Type file
 I $D(^SD(409.41,7)) D
 .;Delete entry 7
 .N DIK,DA
 .K TEXT
 .S TEXT(1)=" "
 .S TEXT(2)="'Combat Veteran' must be entry number 7 in the Outpatient"
 .S TEXT(3)="Classification Type file (#409.41).  The existing entry 7"
 .S TEXT(4)="will be deleted to ensure that it matches the nationally"
 .S TEXT(5)="distributed definition for 'Combat Veteran'."
 .D MES^XPDUTL(.TEXT)
 .S DIK="^SD(409.41,"
 .S DA=7
 .D ^DIK
 ;Create entry in Outpatient Classification Type file (#409.41)
 N SDFDA,SDIEN,SDMSG
 K TEXT
 S TEXT(1)=" "
 S TEXT(2)="Creating 'Combat Veteran' entry in Outpatient Classification"
 S TEXT(3)="Type file (#409.41) as entry number 7 ..."
 D MES^XPDUTL(.TEXT)
 S SDFDA(409.41,"+1,",.01)="COMBAT VETERAN"
 S SDFDA(409.41,"+1,",.02)="Was treatment related to Combat"
 S SDFDA(409.41,"+1,",.03)="YES/NO"
 S SDFDA(409.41,"+1,",.05)="YES"
 S SDFDA(409.41,"+1,",.06)="Combat Vet (Combat Related)"
 S SDFDA(409.41,"+1,",.07)="CV"
 S SDFDA(409.41,"+1,",1)="I $$CV^SDCO22(DFN,$G(SDOE),$G(SDDT))"
 S SDFDA(409.41,"+1,",2)="@"
 S SDFDA(409.41,"+1,",50)="@"
 S SDFDA(409.4175,"+2,+1,",.01)="SEPTEMBER 1, 2002"
 S SDFDA(409.4175,"+2,+1,",.02)="YES"
 S SDIEN(1)=7
 D UPDATE^DIE("E","SDFDA","SDIEN","SDMSG")
 I $D(SDMSG) D
 .D MES^XPDUTL("** Unable to create entry **")
 .K TEXT
 .D MSG^DIALOG("ASE",.TEXT,60,3,"SDMSG")
 .D MES^XPDUTL(.TEXT)
 I '$D(SDMSG) D
 .K TEXT
 .S TEXT(1)=" "
 .S TEXT(2)="'Combat Veteran' successfully added to Outpatient Classification"
 .S TEXT(3)="Type file (#409.41)"
 .D MES^XPDUTL(.TEXT)
 ;Do AmbCare post-init
 D POST^SD53325A
 Q
