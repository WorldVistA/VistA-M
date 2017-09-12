DVBA167P ;ALB/KCL,RLC,ECF - PATCH DVBA*2.7*167 INSTALL UTILITIES ; 6/20/2011
 ;;2.7;AMIE;**167**;Apr 10, 1995;Build 1
 ;
 ;No direct entry allowed
 Q
 ;
PRE ;Main entry point for Pre-install items
 ;
 D BMES^XPDUTL("***** PRE-INSTALL PROCESSING *****")
 D DEACT ;de-activate older versions of CAPRI templates
 ;
 Q
 ;
POST ;Main entry point for Post-install items
 ;
 D BMES^XPDUTL("***** POST-INSTALL PROCESSING *****")
 D ACTIVATE ;activate CAPRI templates that were loaded by the patch
 D AMIE     ;updates for the AMIE EXAM (#396.6) file
 K DIE
 ;
 Q
 ;
 ;
DEACT ;De-activate older versions of CAPRI templates
 ;
 ;Used to disable older versions of a template for those templates being
 ;exported with the patch.
 ; - Make sure to call the DISABLE procedure for each template name
 ;   being exported in the patch.
 ; - This must be called as a pre-init or else it will disable the
 ;   templates that are being loaded by the patch.
 ;
 N DVBVERSS,DVBVERSN,DVBACTR,DVBATVER
 ;
 ;what the template version will be in the incoming patch
 ;(version pulled from export account)
 S DVBVERSS="167F"
 ;
 ; The Patch Version Suffix which will be appended for the Name
 ; (#.01) Field in the CAPRI Template Definition (#396.18) file
 ; entry to allow for template versioning.
 S:$D(^XTMP("XPDI",$G(XPDA),"BLD",$G(XPDBLD),6))>0 DVBATVER=$P($G(^XTMP("XPDI",$G(XPDA),"BLD",$G(XPDBLD),6)),U,1)
 S DVBVERSN=167_$S($G(DVBATVER)>0:"T"_DVBATVER,1:"")
 S DVBACTR=0
 ;
 D BMES^XPDUTL(" Disabling CAPRI templates...")
 D MES^XPDUTL(" ")
 ;
 D DISABLE("DBQ AMYOTROPHIC LATERAL SCLEROSIS (LOU GEHRIG'S DISEASE)")
 D DISABLE("DBQ BACK (THORACOLUMBAR SPINE) CONDITIONS")
 D DISABLE("DBQ NECK (CERVICAL SPINE) CONDITIONS")
 D DISABLE("DBQ PERIPHERAL NERVES CONDITIONS (NOT INCLUDING DIABETIC SENSORY-MOTOR PERIPHERAL NEUROPATHY)")
 ;
 D BMES^XPDUTL("  Number of CAPRI templates disabled:  "_DVBACTR)
 Q
 ;
 ;
ACTIVATE ;Activate CAPRI templates that were loaded by the patch
 ;
 ;Used to activate/rename templates that were loaded by the patch.
 ; - Make sure to call RENAME procedure for each template name
 ;   being loaded by the patch.
 ; - Must be called as a post-init in order to rename those
 ;   templates being loaded by the patch.
 ;
 N DVBVERSS,DVBVERSN,DVBACTR,DVBATVER
 ;
 ;what the template version will be in the incoming patch
 ;(version pulled from export account)
 S DVBVERSS="167F"
 ;
 ; The Patch Version Suffix which will be appended for the Name
 ; (#.01) Field in the CAPRI Template Definition (#396.18) file
 ; entry to allow for template versioning.
 S:$D(^XTMP("XPDI",$G(XPDA),"BLD",$G(XPDBLD),6))>0 DVBATVER=$P($G(^XTMP("XPDI",$G(XPDA),"BLD",$G(XPDBLD),6)),U,1)
 S DVBVERSN=167_$S($G(DVBATVER)>0:"T"_DVBATVER,1:"")
 S DVBACTR=0
 ;
 D BMES^XPDUTL(" Activating CAPRI templates...")
 D MES^XPDUTL(" ")
 ;
 D RENAME("DBQ AMYOTROPHIC LATERAL SCLEROSIS (LOU GEHRIG'S DISEASE)")
 D RENAME("DBQ BACK (THORACOLUMBAR SPINE) CONDITIONS")
 D RENAME("DBQ NECK (CERVICAL SPINE) CONDITIONS")
 D RENAME("DBQ PERIPHERAL NERVES CONDITIONS (NOT INCLUDING DIABETIC SENSORY-MOTOR PERIPHERAL NEUROPATHY)")
 ;
 D BMES^XPDUTL("  Number of CAPRI templates activated:  "_DVBACTR)
 Q
 ;
 ;
DISABLE(NM) ;Disable matching CAPRI template entries
 ;
 ;This procedure will find each entry in the CAPRI TEMPLATE DEFINITIONS
 ;(#396.18) file that matches the name (NM) of the template being exported.
 ;Once a matching entry is found, it will be disabled if the version
 ;suffix (i.e. ~167) does not match the version suffix that will be used
 ;for templates loaded by the patch on the target system (i.e. ~167T1).
 ;
 ;An entry will be disabled by doing the following:
 ; - Turning off the SELECTABLE BY USER? field. This will keep the entry
 ;   from showing in the CAPRI GUI template list.
 ; - Looking at DE-ACTIVATION DATE field. If there's no date, set it to today.
 ;
 N DVBABIEN ;ien of CAPRI TEMPLATE DEFINITIONS file
 N DVBABST  ;template NAME field (i.e. DBQ PARKINSONS~167T1)
 N DVBACH   ;flag used to indicate template was disabled
 N DVBAFDA  ;FDA array for FILE^DIE
 N DVBAERR  ;error array for FILE^DIE
 N DVBAMSG1 ;used to write msg to installer/Install file entry
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
 ;
 ;
RENAME(NM) ;Rename CAPRI templates loaded by the patch
 ;
 ;This procedure is used to lookup and rename a template in the
 ;CAPRI TEMPLATE DEFINITIONS (#396.18) file. This is done to rename
 ;the imported version of a template (i.e. DBQ PARKINSONS~167F) to its
 ;new name/version (i.e. DBQ PARKINSONS~167T1).
 ;
 N DVBABIEN,DVBABIE2 ;ien of CAPRI TEMPLATE DEFINITIONS file
 N DVBABST  ;template NAME field (i.e. AUDIO~167F)
 N DVBABS2  ;template NAME field (i.e. AUDIO~167T1)
 N DVBACH   ;flag to indicate if template version is found or not
 N DVBAFDA  ;FDA array for FILE^DIE
 N DVBAERR  ;error array for FILE^DIE
 N DVBAMSG,DVBAMSG1  ;used to write msg to installer/Install file entry
 N DVBAADT  ;template activation date
 ;
 S DVBABIEN=0
 ;
 ;main loop-walk through CAPRI TEMPLATE DEFINITIONS file entries
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1) ;template name
 .;look for template versions just loaded by the patch (~167F)
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
 ..;name to the new version name (i.e. DBQ PARKINSONS~167F --> DBQ PARKINSONS~167T1)
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
AMIE ;Updates for the AMIE EXAM (#396.6) file
 ;
 ;Used to inactivate old entries and create new entries for designated
 ;worksheet updates
 ;
 D BMES^XPDUTL(" Update to AMIE EXAM (#396.6) file...")
 D MES^XPDUTL("  ")
 I '$D(^DVB(396.6)) D BMES^XPDUTL("Missing AMIE EXAM (#396.6) file") Q
 I $D(^DVB(396.6)) D
 .D NEW
 Q
 ;
 ;
NEW ;Add new exam entries
 ;
 N LINE,IEN,EXM,PNM,BDY,ROU,STAT,WKS,DIC,DIC,DR,DA,X,Y,DINUM,DVBAI
 ;
 D BMES^XPDUTL(" Adding new AMIE EXAM (#396.6) file entries...")
 F DVBAI=1:1 S LINE=$P($T(TXTNEW+DVBAI),";;",2) Q:LINE="QUIT"  D
 .D GET K X,Y,DA
 .D BMES^XPDUTL("  Attempting to add Entry #"_IEN_"...")
 .I $D(^DVB(396.6,IEN,0)) D  Q
 ..D MES^XPDUTL("   You have an Entry #"_IEN_".")
 ..D MES^XPDUTL("   Updating "_EXM_".")
 ..S DIE="^DVB(396.6,",DA=IEN,DR=".01///"_EXM_";.5///"_STAT_";2///"_BDY_";6///"_PNM_";7///"_ROU
 ..D ^DIE
 .S DIC="^DVB(396.6,",DIC(0)="LZ",X=EXM,DINUM=IEN
 .S DIC("DR")=".5///"_STAT_";2///"_BDY_";6///"_PNM_";7///"_ROU
 .K DD,DO D FILE^DICN
 .I +Y=IEN D  Q
 ..D MES^XPDUTL("   Successfully added Entry #"_IEN)
 ..D MES^XPDUTL("   for exam "_EXM_".")
 .I +Y=-1 D
 ..D MES^XPDUTL("   *** Warning - Unable to add Entry #"_IEN)
 ..D MES^XPDUTL("                for exam "_EXM_".")
 Q
 ;
 ;
GET ;Get exam data
 ;
 S (IEN,EXM,PNM,BDY,ROU,STAT,WKS)=""
 S IEN=$P(LINE,";",1)  ;ien
 S EXM=$P(LINE,";",2)  ;exam name
 S PNM=$P(LINE,";",3)  ;print name
 S BDY=$P(LINE,";",4)  ;body system
 S ROU=$P(LINE,";",5)  ;routine name
 S STAT=$P(LINE,";",6) ;status
 S WKS=$P(LINE,";",8)  ;worksheet number
 Q
 ;
 ; New exam(s) to activate
 ; format:  ien;exam name;print name;body system;routine;status;;wks#
 ; Max length of NAME (#.01) is 60, PRINT NAME (#6)is 25
TXTNEW ;
 ;;311;DBQ AMYOTROPHIC LATERAL SCLEROSIS (LOU GEHRIG'S DISEASE);DBQ ALS;13;DVBCQAL1;A; ; ;
 ;;312;DBQ BACK (THORACOLUMBAR SPINE) CONDITIONS;DBQ BACK CONDITIONS;2;DVBCQBK1;A; ; ;
 ;;318;DBQ NECK (CERVICAL SPINE) CONDITIONS;DBQ NECK CONDITIONS;2;DVBCQNC1;A; ; ;
 ;;319;DBQ PERIPHERAL NERVES (EXCLUDING DIABETIC NEUROPATHY);DBQ PERIPHERAL NERVES;13;DVBCQPN1;A; ; ;
 ;;QUIT
 Q
