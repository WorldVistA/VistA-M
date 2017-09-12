DVBA2829 ;ALB/KCL - PATCH DVBA*2.7*129 INSTALL UTILITIES ; 1/25/08
 ;;2.7;AMIE;**129**;Apr 10, 1995;Build 31
 ;
 ; Pre/Post install routine for patch DVBA*2.7*129.
 ;
 ; Make sure to call each exam name being exported in the patch.
 ; This routine will find existing matching entries and ensure
 ; they are disabled. Call as a pre-init or else it will disable
 ; the exams just loaded.
 ; 
PRE ;Main entry point for Pre-init items.
 N DVBVERSS,DVBVERSN
 S DVBVERSS="129F"  ;what the version will be in the incoming file
 S DVBVERSN="129"   ;what the final version should be named
 W !!!,"**** PRE-INSTALL PROCESSING ****",!!
 D DISABLE("TRAUMATIC BRAIN INJURY")
 Q
 ;
POST ;Main entry point for Post-init items.
 N DVBVERSS,DVBVERSN
 S DVBVERSS="129F"  ;what the version will be in the incoming file
 S DVBVERSN="129"   ;what the final version should be named
 W !!!,"**** POST-INSTALL PROCESSING ****",!!
 D POSTP("TRAUMATIC BRAIN INJURY")
 D RBXREF
 Q
 ;
POSTP(NM) ;Rename XXXXXXX~imported version to XXXXXXX~new version.
 N DVBABCNT,DVBABIEN,DVBABST,DVBACH,DVBABCN2,DVBABIE2,DVBABS2
 S DVBABCNT=0,DVBABIEN=0
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1)
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)=DVBVERSS  D
 ..;Check and be sure the new version isn't in the file yet
 ..S DVBABCN2=0,DVBABIE2=0,DVBACH=0
 ..F  S DVBABIE2=$O(^DVB(396.18,DVBABIE2)) Q:'DVBABIE2  D
 ...S DVBABS2=$P($G(^DVB(396.18,DVBABIE2,0)),"^",1)
 ...I $P(DVBABS2,"~",1)=NM  I $P(DVBABS2,"~",2)=DVBVERSN  S DVBACH=1
 ..;If new version is found, delete the import version and don't import
 ..I DVBACH=1  D
 ...W "FOUND EXISTING "_NM_".  NO MODIFICATIONS MADE.",!
 ...K ^DVB(396.18,DVBABIEN)
 ..;If existing version isn't found, go ahead and rename imported entry to new version name
 ..I DVBACH=0  D
 ...S $P(^DVB(396.18,DVBABIEN,0),"^",1)=NM_"~"_DVBVERSN
 ...W "ACTIVATED: "_$P($G(^DVB(396.18,DVBABIEN,0)),"^",1),!
 K DVBABCNT,DVBABIEN,DVBABST,DVBACH
 Q
 ;
RBXREF ;Rebuild cross-references.
 ;
 ;XRef: B
 W !!,"CLEANING UP FILES AND REBUILDING 2 CROSS-REFERENCES.",!,"THIS MAY TAKE A FEW MINUTES.",!
 W !!,"REBUILDING 'B' XREF, CAPRI TEMPLATE DEFINITIONS FILE",!
 N DA,DIK,REGIEN,ROOT
 S ROOT=$$ROOT^DILFD(396.18,,1)  K @ROOT@("B")
 S REGIEN=0
 F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 . S DIK=$$ROOT^DILFD(396.18,","_REGIEN_","),DIK(1)=".01^B"
 . S DA(1)=REGIEN  D ENALL^DIK
 ; 
 ;XRef: AV
 W !!,"REBUILDING 'AV' XREF, CAPRI TEMPLATE DEFINITIONS FILE",!
 N DA,DIK,REGIEN,ROOT
 S ROOT=$$ROOT^DILFD(396.18,,1)  K @ROOT@("AV")
 S REGIEN=0
 F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 . S DIK=$$ROOT^DILFD(396.18,","_REGIEN_","),DIK(1)=".01^AV"
 . S DA(1)=REGIEN  D ENALL^DIK
 K DA,DIK,REGIEN,ROOT
 Q
 ; 
DISABLE(NM) ;Disable matching templates in CAPRI TEMPLATE DEFINITIONS (#396.18) file.
 ;First look for matches and turn off SELECTABLE BY USER? field. This will
 ;keep the entry from showing in the list. Next, look at DE-ACTIVATION DATE field.
 ;If there's no date, set it to today.
 ;
 N DVBABCNT,DVBABIEN,DVBABST,DVBACH
 S DVBABCNT=0,DVBABIEN=0
 ;look for template matches
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1)
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)'=DVBVERSN  D
 ..S DVBACH=0
 ..;Selectable by user field
 ..I $P(^DVB(396.18,DVBABIEN,6),"^",1)'="0"  S $P(^DVB(396.18,DVBABIEN,6),"^",1)="0",DVBACH=1
 ..;Deactivation date field
 ..I $P(^DVB(396.18,DVBABIEN,2),"^",2)=""  S $P(^DVB(396.18,DVBABIEN,2),"^",2)=DT,DVBACH=1
 ..;output modified templates
 ..I DVBACH=1  W "MODIFIED: "_DVBABST,!
 ;
 K DVBABCNT,DVBABIEN,DVBABST,DVBACH
 Q
