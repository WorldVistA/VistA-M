DVBA2814 ;ALB/SPH - PATCH DRIVER ; 2/12/07
 ;;2.7;AMIE;**114**;Apr 10, 1995;Build 10
 ;
 ; Make sure to call each exam name being sent in the patch
 ; This routine will find existing matching entries and will ensure
 ; they are disabled.
 ; Call as a pre-init or else it'll disable the exams just loaded.
PRE ;
 N DVBVERSS,DVBVERSN
 ;
 ;rename 114 to 114T1 for test sites to allow final build to load
 D RENAME("114","114T1")
 ;
 S DVBVERSS="114F" ; What the version will be in the incoming file
 S DVBVERSN="114" ; What the final version should be named
 W !!!,"**** PRE-PROCESSING ****",!!
 D DISABLE("DIABETES MELLITUS")
 D DISABLE("EATING DISORDERS")
 D DISABLE("FEET")
 D DISABLE("GENERAL MEDICAL EXAMINATION")
 D DISABLE("GENITOURINARY EXAMINATION")
 D DISABLE("GULF WAR GUIDELINES")
 D DISABLE("HIV-RELATED ILLNESS")
 D DISABLE("HYPERTENSION")
 D DISABLE("INFECTIOUS, IMMUNE, AND NUTRITIONAL DISABILITIES")
 D DISABLE("PERIPHERAL NERVES")
 D DISABLE("PRISONER OF WAR PROTOCOL EXAMINATION")
 D DISABLE("RECTUM AND ANUS")
 D DISABLE("RESPIRATORY DISEASES, MISCELLANEOUS")
 D DISABLE("SKIN DISEASES (OTHER THAN SCARS)")
 D DISABLE("SPINE")
 Q
POST ;
 N DVBVERSS,DVBVERSN
 S DVBVERSS="114F" ; What the version will be in the incoming file
 S DVBVERSN="114" ; What the final version should be named
 W !!!,"**** POST-PROCESSING ****",!!
 D POSTP("DIABETES MELLITUS")
 D POSTP("EATING DISORDERS")
 D POSTP("FEET")
 D POSTP("GENERAL MEDICAL EXAMINATION")
 D POSTP("GENITOURINARY EXAMINATION")
 D POSTP("GULF WAR GUIDELINES")
 D POSTP("HIV-RELATED ILLNESS")
 D POSTP("HYPERTENSION")
 D POSTP("INFECTIOUS, IMMUNE, AND NUTRITIONAL DISABILITIES")
 D POSTP("PERIPHERAL NERVES")
 D POSTP("PRISONER OF WAR PROTOCOL EXAMINATION")
 D POSTP("RECTUM AND ANUS")
 D POSTP("RESPIRATORY DISEASES, MISCELLANEOUS")
 D POSTP("SKIN DISEASES (OTHER THAN SCARS)")
 D POSTP("SPINE")
 D RBXREF
 Q
POSTP(NM) ;
 ; Rename XXXXXXX~imported version to XXXXXXX~new version
 N DVBABCNT,DVBABIEN,DVBABST,DVBACH
 N DVBABCN2,DVBABIE2,DVBABS2
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
RBXREF ;
 ; Rebuild cross-references
 ; XRef: B
 W !!,"CLEANING UP FILES AND REBUILDING 2 CROSS-REFERENCES.",!,"THIS MAY TAKE A FEW MINUTES.",!
 W !!,"REBUILDING 'B' XREF, CAPRI TEMPLATE DEFINITIONS FILE",!
 N DA,DIK,REGIEN,ROOT
 S ROOT=$$ROOT^DILFD(396.18,,1)  K @ROOT@("B")
 S REGIEN=0
 F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 . S DIK=$$ROOT^DILFD(396.18,","_REGIEN_","),DIK(1)=".01^B"
 . S DA(1)=REGIEN  D ENALL^DIK
 ; 
 ; XRef: AV
 W !!,"REBUILDING 'AV' XREF, CAPRI TEMPLATE DEFINITIONS FILE",!
 N DA,DIK,REGIEN,ROOT
 S ROOT=$$ROOT^DILFD(396.18,,1)  K @ROOT@("AV")
 S REGIEN=0
 F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 . S DIK=$$ROOT^DILFD(396.18,","_REGIEN_","),DIK(1)=".01^AV"
 . S DA(1)=REGIEN  D ENALL^DIK
 K DA,DIK,REGIEN,ROOT
 Q 
DISABLE(NM) ;
 ; First look for matches and turn off the "selectable by user field"
 ; This will keep the entry from showing in the list
 ; Next, look at disabled date.  If there's no date, set it to today.
 ; File is 396.18.  Field 3 is de-activation date.  Field 7 is selectable by user (0=no)
 N DVBABCNT,DVBABIEN,DVBABST,DVBACH
 S DVBABCNT=0,DVBABIEN=0
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1)
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)'=DVBVERSN  D
 ..S DVBACH=0
 ..I $P(^DVB(396.18,DVBABIEN,6),"^",1)'="0"  S $P(^DVB(396.18,DVBABIEN,6),"^",1)="0",DVBACH=1
 ..I $P(^DVB(396.18,DVBABIEN,2),"^",2)=""  S $P(^DVB(396.18,DVBABIEN,2),"^",2)=DT,DVBACH=1  ; This is deactivation date 
 ..I DVBACH=1  W "MODIFIED: "_DVBABST,!
 K DVBABCNT,DVBABIEN,DVBABST,DVBACH
 Q
 ;
RENAME(DVBOLD,DVBNEW) ;rename templates
 ;This procedure searches for any version DVBOLD template definitions
 ;that have a non-zero deactivation date and renames them to DVBNEW.
 ;No action is taken when any of the following conditions exist:
 ;                 * Deactivation date is not defined
 ;                 * A version DVBNEW template already exists.
 ;
 ;  Input:
 ;    DVBOLD - old version name
 ;    DVBNEW - new version name
 ;
 ;  Output: none
 ;
 N DVBERR   ;DBS error message array
 N DVBI     ;generic index
 N DVBIEN   ;pointer to #396.18
 N DVBTNAM  ;template name
 ;
 F DVBI=1:1 S DVBTNAM=$P($T(TLIST+DVBI),";",3) Q:DVBTNAM="**END**"  D
 . S DVBIEN=$$FIND1^DIC(396.18,"","X",DVBTNAM_"~"_DVBOLD,"B","","DVBERR")
 . I DVBIEN,+$$GET1^DIQ(396.18,DVBIEN_",",3,"I","","DVBERR")>0 D
 . . N DVBFDA   ;filer FDA array
 . . ;
 . . ;short-circuit when new version exists
 . . Q:$$FIND1^DIC(396.18,"","X",DVBTNAM_"~"_DVBNEW,"B","","DVBERR")
 . . ;
 . . ;rename it
 . . S DVBFDA(396.18,DVBIEN_",",.01)=DVBTNAM_"~"_DVBNEW
 . . D FILE^DIE("E","DVBFDA","DVBERR")
 ;
 Q
 ;
TLIST ;;TEMPLATE LIST
 ;;DIABETES MELLITUS
 ;;EATING DISORDERS
 ;;FEET
 ;;GENERAL MEDICAL EXAMINATION
 ;;GENITOURINARY EXAMINATION
 ;;GULF WAR GUIDELINES
 ;;HIV-RELATED ILLNESS
 ;;HYPERTENSION
 ;;INFECTIOUS, IMMUNE, AND NUTRITIONAL DISABILITIES
 ;;PERIPHERAL NERVES
 ;;PRISONER OF WAR PROTOCOL EXAMINATION
 ;;RECTUM AND ANUS
 ;;RESPIRATORY DISEASES, MISCELLANEOUS
 ;;SKIN DISEASES (OTHER THAN SCARS)
 ;;SPINE
 ;;**END**
