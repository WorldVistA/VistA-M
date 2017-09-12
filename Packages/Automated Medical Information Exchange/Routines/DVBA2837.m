DVBA2837 ;ALB/KCL - PATCH DVBA*2.7*137 INSTALL UTILITIES ; 10/29/2008
 ;;2.7;AMIE;**137**;Apr 10, 1995;Build 38
 ;
PRE ;Pre-install entry point.
 ;
 ;Used to disable older versions of a template for those templates being
 ;exported with the patch.
 ; - Make sure to call the DISABLE procedure for each template name
 ;   being exported in the patch.
 ; - This must be called as a pre-init or else it will disable the
 ;   templates that are being loaded by the patch.
 ;
 N DVBVERSS,DVBVERSN
 ;
 ;what the template version will be in the incoming patch
 ;(version pulled from export account)
 S DVBVERSS="137F"
 ;what the final template version should be once the template is 
 ;loaded by the patch on the target system
 S DVBVERSN="137"
 ;
 W !!!,"**** PRE-INSTALL PROCESSING ****",!
 W !,"Disabling templates...",!!
 ;
 D DISABLE("TRAUMATIC BRAIN INJURY")
 Q
 ;
POST ;Post-install entry point.
 ;
 ;Used to rename templates that were loaded by the patch.
 ; - Make sure to call POSTP procedure for each template
 ;   name being loaded by the patch.
 ; - Must be called as a post-init in order to rename those
 ;   templates being loaded by the patch.
 ;
 N DVBVERSS,DVBVERSN
 ;
 ;what the template version will be in the incoming patch
 ;(version pulled from export account)
 S DVBVERSS="137F"
 ;what the final template version should be once the template is 
 ;loaded by the patch on the target system
 S DVBVERSN="137"
 ;
 W !!!,"**** POST-INSTALL PROCESSING ****",!
 W !,"Activating templates...",!!
 ;
 D POSTP("TRAUMATIC BRAIN INJURY")
 ;
 ;re-build cross references
 D RBXREF
 Q
 ;
POSTP(NM) ;Rename templates loaded by the patch.
 ;
 ;This procedure is used to lookup and rename a template in the
 ;CAPRI TEMPLATE DEFINITIONS (#396.18) file. This is done to rename
 ;the imported version of a template (i.e. ACROMEGALY~124F) to it's
 ;new name/version (i.e. ACROMEGALY~124T6).
 ;
 N DVBABIEN,DVBABIE2 ;ien of CAPRI TEMPLATE DEFINITIONS file
 N DVBABST  ;template NAME field (i.e. ACROMEGALY~124F)
 N DVBABS2  ;template NAME field (i.e. ACROMEGALY~124T6)
 N DVBACH   ;flag to indicate if template version is found or not
 ;
 S DVBABIEN=0
 ;
 ;main loop-walk through CAPRI TEMPLATE DEFINITIONS file entries
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1) ;template name
 .;look for template versions just loaded by the patch (~124F)
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)=DVBVERSS  D
 ..S DVBABIE2=0,DVBACH=0
 ..;secondary loop-walk through CAPRI TEMPLATE DEFINITIONS file entries
 ..F  S DVBABIE2=$O(^DVB(396.18,DVBABIE2)) Q:'DVBABIE2  D
 ...S DVBABS2=$P($G(^DVB(396.18,DVBABIE2,0)),"^",1) ;template name
 ...;if new version of template already exists in file, set flag
 ...I $P(DVBABS2,"~",1)=NM  I $P(DVBABS2,"~",2)=DVBVERSN  S DVBACH=1
 ..;if new version already exists, delete the imported version (abort rename)
 ..I DVBACH=1  D
 ...W "Found existing "_NM_".  No modifications made.",!
 ...K ^DVB(396.18,DVBABIEN)
 ..;otherwise, if new version isn't found, rename imported template
 ..;name to the new version name (i.e. ACROMEGALY~124F --> ACROMEGALY~124t6)
 ..I DVBACH=0  D
 ...S $P(^DVB(396.18,DVBABIEN,0),"^",1)=NM_"~"_DVBVERSN
 ...W "Activated: "_$P($G(^DVB(396.18,DVBABIEN,0)),"^",1),!
 ;
 K DVBABIEN,DVBABST,DVBACH
 Q
 ;
RBXREF ;Rebuild cross-references in (#396.18) file.
 ;
 W !!,"Cleaning up files and rebuilding 2 cross-references.",!,"This may take a few minutes.",!
 ;
 ;XRef: B
 W !!,"Rebuilding 'B' x-ref, CAPRI TEMPLATE DEFINITIONS file",!
 N DA,DIK,REGIEN,ROOT
 S ROOT=$$ROOT^DILFD(396.18,,1)  K @ROOT@("B")
 S REGIEN=0
 F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 . S DIK=$$ROOT^DILFD(396.18,","_REGIEN_","),DIK(1)=".01^B"
 . S DA(1)=REGIEN  D ENALL^DIK
 ;
 ;XRef: AV
 W !!,"Rebuilding 'AV' x-ref, CAPRI TEMPLATE DEFINITIONS file",!
 N DA,DIK,REGIEN,ROOT
 S ROOT=$$ROOT^DILFD(396.18,,1)  K @ROOT@("AV")
 S REGIEN=0
 F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 . S DIK=$$ROOT^DILFD(396.18,","_REGIEN_","),DIK(1)=".01^AV"
 . S DA(1)=REGIEN  D ENALL^DIK
 ;
 K DA,DIK,REGIEN,ROOT
 Q
 ; 
DISABLE(NM) ;Disable matching exam template entries.
 ;
 ;This procedure will find each entry in the CAPRI TEMPLATE DEFINITIONS
 ;(#396.18) file that matches the name (NM) of the template being exported.
 ;Once a matching entry is found, it will be disabled if the version
 ;suffix (i.e. ~124T5) does not match the version suffix that will be used
 ;for templates loaded by the patch on the target system (i.e. ~124T6).
 ;
 ;An entry will be disabled by doing the following:
 ; - Turning off the SELECTABLE BY USER? field. This will keep the entry
 ;   from showing in the CAPRI GUI template list.
 ; - Looking at DE-ACTIVATION DATE field. If there's no date, set it to today.
 ;
 N DVBABIEN ;ien of CAPRI TEMPLATE DEFINITIONS file
 N DVBABST  ;template NAME field (i.e. ACROMEGALY~124T5)
 N DVBACH   ;flag used to indicate template was disabled
 ;
 S DVBABIEN=0
 ;
 ;walk through CAPRI TEMPLATE DEFINITIONS file entries
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1) ;template name
 .;if name matches and version is different, then disable entry
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)'=DVBVERSN  D
 ..S DVBACH=0
 ..;turn SELECTABLE BY USER field off
 ..I $P(^DVB(396.18,DVBABIEN,6),"^",1)'="0"  S $P(^DVB(396.18,DVBABIEN,6),"^",1)="0",DVBACH=1
 ..;set DE-ACTIVATION DATE field to TODAY
 ..I $P(^DVB(396.18,DVBABIEN,2),"^",2)=""  S $P(^DVB(396.18,DVBABIEN,2),"^",2)=DT,DVBACH=1
 ..;output list of disabled templates
 ..I DVBACH=1  W "Disabled: "_DVBABST,!
 ;
 K DVBABIEN,DVBABST,DVBACH
 Q
