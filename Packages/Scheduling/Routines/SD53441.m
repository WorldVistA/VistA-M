SD53441 ;ALB/MRY - Post init for patch 441;6/20/2005
 ;;5.3;Scheduling;**441**;Aug 13, 1993;Build 14
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
 ;Change 'Environmental Contaminants' to 'Southwest Asia Conditions'
 N ENTRY,FDATA,SDX,SDSAVX
 S ENTRY=+$O(^SD(409.41,"B","ENVIRONMENTAL CONTAMINANTS",0)) I ENTRY D
 .S FDATA(409.41,ENTRY_",",.01)="SW ASIA CONDITIONS"
 .S FDATA(409.41,ENTRY_",",.02)="Was treatment related to service in SW Asia"
 .S FDATA(409.41,ENTRY_",",.06)="SW Asia Conditions"
 .S SDSAVX=$P(^DD(409.41,.01,0),"^",2)
 .S SDX=$P(SDSAVX,"I",1)_$P(SDSAVX,"I",2,99) ;REMOVE THE 'I'
 .S $P(^DD(409.41,.01,0),U,2)=SDX
 .D FILE^DIE("E","FDATA","ERR")
 .S $P(^DD(409.41,.01,0),"^",2)=SDSAVX
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Edit to the OUTPATIENT CLASSIFICATION TYPE file (#409.41)")
 .D MES^XPDUTL("...Replacing 'ENVIRONMENTAL CONTAMINANTS' with...")
 .D MES^XPDUTL("...'SW ASIA CONDITIONS'.")
 .D MES^XPDUTL("*****")
 N TEXT
 ;Ensure entry 8 doesn't exist in Outpatient Classification Type file
 I $D(^SD(409.41,8)) D
 .;Delete entry 8
 .N DIK,DA
 .K TEXT
 .S TEXT(1)=" "
 .S TEXT(2)="'Project 112/SHAD' must be entry number 8 in the Outpatient"
 .S TEXT(3)="Classification Type file (#409.41).  The existing entry 8"
 .S TEXT(4)="will be deleted to ensure that it matches the nationally"
 .S TEXT(5)="distributed definition for 'Project 112/SHAD'."
 .D MES^XPDUTL(.TEXT)
 .S DIK="^SD(409.41,"
 .S DA=8
 .D ^DIK
 ;Create entry in Outpatient Classification Type file (#409.41)
 N SDFDA,SDIEN,SDMSG
 K TEXT
 S TEXT(1)=" "
 S TEXT(2)="Creating 'PROJ 112/SHAD' entry in Outpatient Classification"
 S TEXT(3)="Type file (#409.41) as entry number 8 ..."
 D MES^XPDUTL(.TEXT)
 S SDFDA(409.41,"+1,",.01)="PROJ 112/SHAD"
 S SDFDA(409.41,"+1,",.02)="Was treatment related to PROJ 112/SHAD"
 S SDFDA(409.41,"+1,",.03)="YES/NO"
 S SDFDA(409.41,"+1,",.05)="YES"
 S SDFDA(409.41,"+1,",.06)="PROJ 112/SHAD"
 S SDFDA(409.41,"+1,",.07)="SHAD"
 S SDFDA(409.41,"+1,",1)="I $$SHAD^SDCO22(DFN)"
 S SDFDA(409.41,"+1,",2)="@"
 S SDFDA(409.41,"+1,",50)="@"
 S SDFDA(409.4175,"+2,+1,",.01)="SEPTEMBER 1, 2004"
 S SDFDA(409.4175,"+2,+1,",.02)="YES"
 S SDIEN(1)=8
 D UPDATE^DIE("E","SDFDA","SDIEN","SDMSG")
 I $D(SDMSG) D
 .D MES^XPDUTL("** Unable to create entry **")
 .K TEXT
 .D MSG^DIALOG("ASE",.TEXT,60,3,"SDMSG")
 .D MES^XPDUTL(.TEXT)
 I '$D(SDMSG) D
 .K TEXT
 .S TEXT(1)=" "
 .S TEXT(2)="'PROJ 112/SHAD' successfully added to Outpatient Classification"
 .S TEXT(3)="Type file (#409.41)"
 .D MES^XPDUTL(.TEXT)
 ;Do AmbCare post-init
 D POST^SD53441A
 Q
