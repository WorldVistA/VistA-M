DVBA151P ;ALB/KCL - PATCH DVBA*2.7*151 INSTALL UTILITIES; 4/19/2010
 ;;2.7;AMIE;**151**;Apr 10, 1995;Build 14
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
 N DVBVERSS,DVBVERSN,DVBACTR
 ;
 ;what the template version will be in the incoming patch
 ;(version pulled from export account)
 S DVBVERSS="151F"
 ;what the final template version should be once the template is 
 ;loaded by the patch on the target system
 S DVBVERSN="151"
 S DVBACTR=0
 ;
 D BMES^XPDUTL("**** PRE-INSTALL PROCESSING ****")
 D BMES^XPDUTL("Disabling templates...")
 D MES^XPDUTL(" ")
 ;
 D DISABLE("AID AND ATTENDANCE OR HOUSEBOUND EXAMINATION")
 D DISABLE("BLANK TEMPLATE")
 D DISABLE("BRAIN AND SPINAL CORD")
 D DISABLE("COLD INJURY PROTOCOL EXAMINATION")
 D DISABLE("CUSHINGS SYNDROME")
 D DISABLE("DIABETES MELLITUS")
 D DISABLE("EPILEPSY AND NARCOLEPSY")
 D DISABLE("EYE EXAMINATION")
 D DISABLE("GENERAL MEDICAL EXAMINATION")
 D DISABLE("GULF WAR GUIDELINES")
 D DISABLE("HYPERTENSION")
 D DISABLE("NEUROLOGICAL DISORDERS, MISCELLANEOUS")
 D DISABLE("PERIPHERAL NERVES")
 D DISABLE("PRISONER OF WAR PROTOCOL EXAMINATION")
 D DISABLE("SOCIAL AND INDUSTRIAL SURVEY")
 D DISABLE("SPINE")
 D DISABLE("TRAUMATIC BRAIN INJURY")
 ;
 D BMES^XPDUTL("  Number of templates disabled:  "_DVBACTR)
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
 N DVBVERSS,DVBVERSN,DVBACTR
 ;
 ;what the template version will be in the incoming patch
 ;(version pulled from export account)
 S DVBVERSS="151F"
 ;what the final template version should be once the template is 
 ;loaded by the patch on the target system
 S DVBVERSN="151"
 S DVBACTR=0
 ;
 D BMES^XPDUTL("**** POST-INSTALL PROCESSING ****")
 D BMES^XPDUTL("Activating templates...")
 D MES^XPDUTL(" ")
 ;
 D POSTP("AID AND ATTENDANCE OR HOUSEBOUND EXAMINATION")
 D POSTP("BLANK TEMPLATE")
 D POSTP("BRAIN AND SPINAL CORD")
 D POSTP("COLD INJURY PROTOCOL EXAMINATION")
 D POSTP("CUSHINGS SYNDROME")
 D POSTP("DIABETES MELLITUS")
 D POSTP("EPILEPSY AND NARCOLEPSY")
 D POSTP("EYE EXAMINATION")
 D POSTP("GENERAL MEDICAL EXAMINATION")
 D POSTP("GULF WAR GUIDELINES")
 D POSTP("HYPERTENSION")
 D POSTP("NEUROLOGICAL DISORDERS, MISCELLANEOUS")
 D POSTP("PERIPHERAL NERVES")
 D POSTP("PRISONER OF WAR PROTOCOL EXAMINATION")
 D POSTP("SOCIAL AND INDUSTRIAL SURVEY")
 D POSTP("SPINE")
 D POSTP("TRAUMATIC BRAIN INJURY")
 ;
 D BMES^XPDUTL("   Number of templates activated:  "_DVBACTR)
 Q
 ;
POSTP(NM) ;Rename templates loaded by the patch.
 ;
 ;This procedure is used to lookup and rename a template in the
 ;CAPRI TEMPLATE DEFINITIONS (#396.18) file. This is done to rename
 ;the imported version of a template (i.e. ACROMEGALY~142F) to it's
 ;new name/version (i.e. ACROMEGALY~142T1).
 ;
 N DVBABIEN,DVBABIE2 ;ien of CAPRI TEMPLATE DEFINITIONS file
 N DVBABST  ;template NAME field (i.e. ACROMEGALY~151F)
 N DVBABS2  ;template NAME field (i.e. ACROMEGALY~151T1)
 N DVBACH   ;flag to indicate if template version is found or not
 N DVBAFDA  ;FDA array for FILE^DIE
 N DVBAERR  ;Error array for FILE^DIE
 N DVBAMSG,DVBAMSG1  ;Used to write message to installer/Install file entry
 N DVBAADT  ;Template activation date
 ;
 S DVBABIEN=0
 ;
 ;main loop-walk through CAPRI TEMPLATE DEFINITIONS file entries
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1) ;template name
 .;look for template versions just loaded by the patch (~151F)
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)=DVBVERSS  D
 ..S DVBABIE2=0,DVBACH=0
 ..;secondary loop-walk through CAPRI TEMPLATE DEFINITIONS file entries
 ..F  S DVBABIE2=$O(^DVB(396.18,DVBABIE2)) Q:'DVBABIE2  D
 ...S DVBABS2=$P($G(^DVB(396.18,DVBABIE2,0)),"^",1) ;template name
 ...;if new version of template already exists in file, set flag
 ...I $P(DVBABS2,"~",1)=NM  I $P(DVBABS2,"~",2)=DVBVERSN  S DVBACH=1
 ..;if new version already exists, delete the imported version (abort rename)
 ..I DVBACH=1  D
 ...S DVBAMSG="   Found existing "_NM_".  No modifications made."
 ...S DVBAFDA(396.18,DVBABIEN_",",.01)="@"
 ...D FILE^DIE("","DVBAFDA","DVBAERR")
 ..;otherwise, if new version isn't found, rename imported template
 ..;name to the new version name (i.e. ACROMEGALY~151F --> ACROMEGALY~151T1)
 ..I DVBACH=0  D
 ...S DVBAADT=$P($G(^DVB(396.18,DVBABIEN,2)),"^")
 ...S DVBACTR=DVBACTR+1
 ...S DVBAFDA(396.18,DVBABIEN_",",.01)=NM_"~"_DVBVERSN
 ...I DVBAADT=""!(DVBAADT<DT) S DVBAFDA(396.18,DVBABIEN_",",2)=DT
 ...D FILE^DIE("","DVBAFDA","DVBAERR")
 ...S DVBAMSG="   Activating: "_$P($G(^DVB(396.18,DVBABIEN,0)),"^",1)
 ..D MES^XPDUTL(DVBAMSG)
 ..I $D(DVBAERR) D
 ...D MSG^DIALOG("AE",.DVBAMSG1,"","","DVBAERR")
 ...D MES^XPDUTL(.DVBAMSG1)
 ;
 K DVBABIEN,DVBABST,DVBACH
 Q
 ;
 ; 
DISABLE(NM) ;Disable matching exam template entries.
 ;
 ;This procedure will find each entry in the CAPRI TEMPLATE DEFINITIONS
 ;(#396.18) file that matches the name (NM) of the template being exported.
 ;Once a matching entry is found, it will be disabled if the version
 ;suffix (i.e. ~139) does not match the version suffix that will be used
 ;for templates loaded by the patch on the target system (i.e. ~151T1).
 ;
 ;An entry will be disabled by doing the following:
 ; - Turning off the SELECTABLE BY USER? field. This will keep the entry
 ;   from showing in the CAPRI GUI template list.
 ; - Looking at DE-ACTIVATION DATE field. If there's no date, set it to today.
 ;
 N DVBABIEN ;ien of CAPRI TEMPLATE DEFINITIONS file
 N DVBABST  ;template NAME field (i.e. ACROMEGALY~151T1)
 N DVBACH   ;flag used to indicate template was disabled
 N DVBAFDA  ;FDA array for FILE^DIE
 N DVBAERR  ;Error array for FILE^DIE
 N DVBAMSG1 ;Used to write message to installer/Install file entry
 ;
 S DVBABIEN=0
 ;
 ;walk through CAPRI TEMPLATE DEFINITIONS file entries
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1) ;template name
 .;if name matches and version is different, then disable entry
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)'=DVBVERSN  D
 ..S DVBACH=0
 ..;turn SELECTABLE BY USER (#7) field off
 ..I $P($G(^DVB(396.18,DVBABIEN,6)),"^",1)'="0" S DVBAFDA(396.18,DVBABIEN_",",7)="0",DVBACH=1
 ..;set DE-ACTIVATION DATE (#3) field to TODAY
 ..I $P($G(^DVB(396.18,DVBABIEN,2)),"^",2)="" S DVBAFDA(396.18,DVBABIEN_",",3)=DT,DVBACH=1
 ..;output list of disabled templates
 ..I DVBACH=1 D
 ...S DVBACTR=DVBACTR+1
 ...D FILE^DIE("","DVBAFDA","DVBAERR")
 ...D MES^XPDUTL("   Disabling: "_DVBABST)
 ...I $D(DVBAERR) D
 ....D MSG^DIALOG("AE",.DVBAMSG1,"","","DVBAERR")
 ....D MES^XPDUTL(.DVBAMSG1)
 ;
 K DVBABIEN,DVBABST,DVBACH
 Q
