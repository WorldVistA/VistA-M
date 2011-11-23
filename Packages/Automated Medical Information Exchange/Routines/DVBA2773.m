DVBA2773 ;SPH - PATCH DRIVER ; 9/21/05
 ;;2.7;AMIE;**73**;Apr 10, 1995
 ;
 ; Make sure to call each exam name being sent in the patch
 ; This routine will find existing matching entries and will ensure they're disabled.
 ; Call as a pre-init or else it'll disable the exams just loaded.
EN ;
 W !!!,"**** PRE-PROCESSING ****",!!
 D DISABLE("MENTAL DISORDERS (EXCEPT PTSD AND EATING DISORDERS)")
 Q
POST ;
 W !!!,"**** POST-PROCESSING ****",!!
 D POSTP("MENTAL DISORDERS (EXCEPT PTSD AND EATING DISORDERS)")
 D RBXREF
 Q
POSTP(NM) ;
 ; Rename XXXXXXX~73F to XXXXXXX~95
 N DVBABCNT,DVBABIEN,DVBABST,DVBACH
 N DVBABCN2,DVBABIE2,DVBABS2
 S DVBABCNT=0,DVBABIEN=0
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1)
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)="73F"  D
 ..;Check and be sure a 95 version isn't in the file yet
 ..S DVBABCN2=0,DVBABIE2=0,DVBACH=0
 ..F  S DVBABIE2=$O(^DVB(396.18,DVBABIE2)) Q:'DVBABIE2  D
 ...S DVBABS2=$P($G(^DVB(396.18,DVBABIE2,0)),"^",1)
 ...I $P(DVBABS2,"~",1)=NM  I $P(DVBABS2,"~",2)="95"  S DVBACH=1
 ..;If 95 version is found, delete new 73F version and don't import
 ..I DVBACH=1  D
 ...W "FOUND EXISTING "_NM_".  NO MODIFICATIONS MADE.",!
 ...K ^DVB(396.18,DVBABIEN)
 ..;If 95 version isn't found, go ahead and rename new 73F to 95
 ..I DVBACH=0  D
 ...S $P(^DVB(396.18,DVBABIEN,0),"^",1)=NM_"~95"
 ...W "ACTIVATED: "_$P($G(^DVB(396.18,DVBABIEN,0)),"^",1),!
 K DVBABCNT,DVBABIEN,DVBABST,DVBACH
 Q
RBXREF ;
 ; Rebuild cross-references
 ; XRef: B
 W !!,"REBUILDING 'B' XREF",!
 N DA,DIK,REGIEN,ROOT
 S ROOT=$$ROOT^DILFD(396.18,,1)  K @ROOT@("B")
 S REGIEN=0
 F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 . S DIK=$$ROOT^DILFD(396.18,","_REGIEN_","),DIK(1)=".01^B"
 . S DA(1)=REGIEN  D ENALL^DIK
 ; 
 ; XRef: AV
 W !!,"REBUILDING 'AV' XREF",!
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
 ; Ignore 73F entries
 N DVBABCNT,DVBABIEN,DVBABST,DVBACH
 S DVBABCNT=0,DVBABIEN=0
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1)
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)'="95"  D
 ..S DVBACH=0
 ..I $P(^DVB(396.18,DVBABIEN,6),"^",1)'="0"  S $P(^DVB(396.18,DVBABIEN,6),"^",1)="0",DVBACH=1
 ..I $P(^DVB(396.18,DVBABIEN,2),"^",2)=""  S $P(^DVB(396.18,DVBABIEN,2),"^",2)=DT,DVBACH=1  ; This is deactivation date 
 ..I DVBACH=1  W "MODIFIED: "_DVBABST,!
 K DVBABCNT,DVBABIEN,DVBABST,DVBACH
 Q
