DVBA2824 ;ALB/KCL - PATCH DVBA*2.7*124 INSTALL UTILITIES ; 5/1/08
 ;;2.7;AMIE;**124**;Apr 10, 1995;Build 56
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
 S DVBVERSS="124F"
 ;what the final template version should be once the template is 
 ;loaded by the patch on the target system
 S DVBVERSN="124"
 ;
 W !!!,"**** PRE-INSTALL PROCESSING ****",!
 W !,"Disabling templates...",!!
 ;
 D DISABLE("ACROMEGALY")
 D DISABLE("AID AND ATTENDANCE OR HOUSEBOUND EXAMINATION")
 D DISABLE("AMPUTATION") ;this template is being de-activated
 D DISABLE("ARRHYTHMIAS")
 D DISABLE("ARTERIES, VEINS AND MISCELLANEOUS")
 D DISABLE("AUDIO")
 D DISABLE("BONES (FRACTURES AND BONE DISEASE)")
 D DISABLE("BRAIN AND SPINAL CORD")
 D DISABLE("CHRONIC FATIGUE SYNDROME")
 D DISABLE("COLD INJURY PROTOCOL EXAMINATION")
 D DISABLE("CRANIAL NERVES")
 D DISABLE("CUSHINGS SYNDROME")
 D DISABLE("DENTAL AND ORAL")
 D DISABLE("DIABETES MELLITUS")
 D DISABLE("DIGESTIVE CONDITIONS, MISCELLANEOUS")
 D DISABLE("EAR DISEASE")
 D DISABLE("EATING DISORDERS")
 D DISABLE("ENDOCRINE, MISCELLANEOUS")
 D DISABLE("EPILEPSY AND NARCOLEPSY")
 D DISABLE("ESOPHAGUS AND HIATAL HERNIA")
 D DISABLE("EYE EXAMINATION")
 D DISABLE("FEET")
 D DISABLE("FIBROMYALGIA")
 D DISABLE("GENERAL MEDICAL EXAMINATION")
 D DISABLE("GENITOURINARY EXAMINATION")
 D DISABLE("GULF WAR GUIDELINES")
 D DISABLE("GYNECOLOGICAL CONDITIONS AND DISORDERS OF THE BREAST")
 D DISABLE("HAND, THUMB, AND FINGERS")
 D DISABLE("HEART")
 D DISABLE("HEMIC DISORDERS")
 D DISABLE("HIV-RELATED ILLNESS")
 D DISABLE("HYPERTENSION")
 D DISABLE("INFECTIOUS, IMMUNE, AND NUTRITIONAL DISABILITIES")
 D DISABLE("INITIAL EVALUATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD)")
 D DISABLE("INTESTINES (LARGE AND SMALL)")
 D DISABLE("JOINTS")
 D DISABLE("LIVER, GALL BLADDER, AND PANCREAS")
 D DISABLE("LYMPHATIC DISORDERS")
 D DISABLE("MEDICAL OPINION")
 D DISABLE("MENTAL DISORDERS (EXCEPT PTSD AND EATING DISORDERS)")
 D DISABLE("MOUTH, LIPS AND TONGUE")
 D DISABLE("MUSCLES")
 D DISABLE("NEUROLOGICAL DISORDERS, MISCELLANEOUS")
 D DISABLE("NOSE, SINUS, LARYNX, AND PHARYNX")
 D DISABLE("PERIPHERAL NERVES")
 D DISABLE("PRISONER OF WAR PROTOCOL EXAMINATION")
 D DISABLE("PULMONARY TUBERCULOSIS AND MYCOBACTERIAL DISEASES")
 D DISABLE("RECTUM AND ANUS")
 D DISABLE("RESIDUALS OF AMPUTATIONS")
 D DISABLE("RESPIRATORY (OBSTRUCTIVE, RESTRICTIVE, AND INTERSTITIAL)")
 D DISABLE("RESPIRATORY DISEASES, MISCELLANEOUS")
 D DISABLE("REVIEW EXAMINATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD)")
 D DISABLE("SCARS")
 D DISABLE("SENSE OF SMELL AND TASTE")
 D DISABLE("SKIN DISEASES (OTHER THAN SCARS)")
 D DISABLE("SOCIAL AND INDUSTRIAL SURVEY")
 D DISABLE("SPINE")
 D DISABLE("STOMACH, DUODENUM AND PERITONEAL ADHESIONS")
 D DISABLE("THYROID AND PARATHYROID DISEASES")
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
 S DVBVERSS="124F"
 ;what the final template version should be once the template is 
 ;loaded by the patch on the target system
 S DVBVERSN="124"
 ;
 W !!!,"**** POST-INSTALL PROCESSING ****",!
 W !,"Activating templates...",!!
 ;
 D POSTP("ACROMEGALY")
 D POSTP("AID AND ATTENDANCE OR HOUSEBOUND EXAMINATION")
 D POSTP("ARRHYTHMIAS")
 D POSTP("ARTERIES, VEINS AND MISCELLANEOUS")
 D POSTP("AUDIO")
 D POSTP("BONES (FRACTURES AND BONE DISEASE)")
 D POSTP("BRAIN AND SPINAL CORD")
 D POSTP("CHRONIC FATIGUE SYNDROME")
 D POSTP("COLD INJURY PROTOCOL EXAMINATION")
 D POSTP("CRANIAL NERVES")
 D POSTP("CUSHINGS SYNDROME")
 D POSTP("DENTAL AND ORAL")
 D POSTP("DIABETES MELLITUS")
 D POSTP("DIGESTIVE CONDITIONS, MISCELLANEOUS")
 D POSTP("EAR DISEASE")
 D POSTP("EATING DISORDERS")
 D POSTP("ENDOCRINE, MISCELLANEOUS")
 D POSTP("EPILEPSY AND NARCOLEPSY")
 D POSTP("ESOPHAGUS AND HIATAL HERNIA")
 D POSTP("EYE EXAMINATION")
 D POSTP("FEET")
 D POSTP("FIBROMYALGIA")
 D POSTP("GENERAL MEDICAL EXAMINATION")
 D POSTP("GENITOURINARY EXAMINATION")
 D POSTP("GULF WAR GUIDELINES")
 D POSTP("GYNECOLOGICAL CONDITIONS AND DISORDERS OF THE BREAST")
 D POSTP("HAND, THUMB, AND FINGERS")
 D POSTP("HEART")
 D POSTP("HEMIC DISORDERS")
 D POSTP("HIV-RELATED ILLNESS")
 D POSTP("HYPERTENSION")
 D POSTP("INFECTIOUS, IMMUNE, AND NUTRITIONAL DISABILITIES")
 D POSTP("INITIAL EVALUATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD)")
 D POSTP("INTESTINES (LARGE AND SMALL)")
 D POSTP("JOINTS")
 D POSTP("LIVER, GALL BLADDER, AND PANCREAS")
 D POSTP("LYMPHATIC DISORDERS")
 D POSTP("MEDICAL OPINION")
 D POSTP("MENTAL DISORDERS (EXCEPT PTSD AND EATING DISORDERS)")
 D POSTP("MOUTH, LIPS AND TONGUE")
 D POSTP("MUSCLES")
 D POSTP("NEUROLOGICAL DISORDERS, MISCELLANEOUS")
 D POSTP("NOSE, SINUS, LARYNX, AND PHARYNX")
 D POSTP("PERIPHERAL NERVES")
 D POSTP("PRISONER OF WAR PROTOCOL EXAMINATION")
 D POSTP("PULMONARY TUBERCULOSIS AND MYCOBACTERIAL DISEASES")
 D POSTP("RECTUM AND ANUS")
 D POSTP("RESIDUALS OF AMPUTATIONS")
 D POSTP("RESPIRATORY (OBSTRUCTIVE, RESTRICTIVE, AND INTERSTITIAL)")
 D POSTP("RESPIRATORY DISEASES, MISCELLANEOUS")
 D POSTP("REVIEW EXAMINATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD)")
 D POSTP("SCARS")
 D POSTP("SENSE OF SMELL AND TASTE")
 D POSTP("SKIN DISEASES (OTHER THAN SCARS)")
 D POSTP("SOCIAL AND INDUSTRIAL SURVEY")
 D POSTP("SPINE")
 D POSTP("STOMACH, DUODENUM AND PERITONEAL ADHESIONS")
 D POSTP("THYROID AND PARATHYROID DISEASES")
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
