ORLP3AC1 ; SLC/PKS - ADD and DELETE a patient to clinic Team List Autolinks.  [12/28/99 2:48pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**47**;Dec 17, 1997
 ;
 ; Called by: ORLP3AUC.
 ;
ADD ; Add patient to applicable team lists.
 ;
 ; Variables used -
 ;
 ;    NEW'd and assigned by calling tag (ORLP3AUC):
 ;
 ;       ORTL   = OE/RR TEAM LIST file number (set to "100.21").
 ;       ORCL   = Clinic.
 ;       ORPT   = Patient number.
 ;
 ;    NEW'd herein:
 ;
 ;       ORTEAM = Team List.
 ;       ORAL   = Team List Autolink.
 ;       ORVAL  = Team List Autolink node data value.
 ;       ORTYPE = Type of Autolink.
 ;       X      = Required variable for call to FILE^DICN.
 ;
 N ORTEAM,ORAL,ORVAL,ORTYPE,X
 ;
 ; Order through OE/RR TEAM LIST file looking for clinic autolinks:
 S ORTEAM=0 ; Initialize.
 F  S ORTEAM=$O(^OR(ORTL,ORTEAM)) Q:'+ORTEAM  D      ; Each team.
 .I $P(^OR(ORTL,ORTEAM,0),"^",2)["A",'$O(^OR(ORTL,ORTEAM,2,0)) Q  ; If not an Autolink Team List or no Autolink records, skip.
 .S ORAL=0 ; Initialize.
 .F  S ORAL=$O(^OR(ORTL,ORTEAM,2,ORAL)) Q:'+ORAL  D  ; Each Autolink.
 ..I $D(^OR(ORTL,ORTEAM,2,ORAL,0)) S ORVAL=^OR(ORTL,ORTEAM,2,ORAL,0) ; Get data value from this clinic's record.
 ..S ORTYPE=$P(ORVAL,";",2) ; Get Autolink type.
 ..I ORTYPE="SC(" D         ; Is the Autolink type a clinic?
 ...I $P(ORVAL,";")=ORCL D  ; Is it the clinic involved?
 ....I $D(^OR(ORTL,ORTEAM,10,"B",ORPT_";DPT(")) Q  ; Patient already there?
 ....;
 ....; Lock the records at the Team level:
 ....L +^OR(ORTL,+ORTEAM):5
 ....I '$T W !,"  WARNING: File locked - "_$P($G(^OR(ORTL,+ORTEAM,0)),"^")_" Team List not updated." Q  ; Skip this Team if there's a locking problem.
 ....;
 ....; Set variables and call tag^routine that invokes DICN call:
 ....S:'$D(^OR(ORTL,+ORTEAM,10,0)) ^(0)="^100.2101AV^^"
 ....K DIC,DA,DO,DD,X
 ....S X=ORPT_";DPT("
 ....S DIC(0)="L"
 ....S DA(1)=+ORTEAM
 ....S DIC="^OR("_ORTL_","_DA(1)_",10,"
 ....D FILE^DICN
 ....L -^OR(ORTL,+ORTEAM) ; Release the lock on this Team.
 ;
 Q
 ;
DELETE ; Delete patient from team lists if appropriate.  (Patient
 ;    not removed if another autolink would list him/her.)
 ;
 ; Variables used -
 ;
 ;    NEW'd and assigned by calling tag (ORLP3AUC):
 ;
 ;       ORTL   = OE/RR TEAM LIST file number (set to "100.21").
 ;       ORCL   = Clinic.
 ;       ORPT   = Patient number.
 ;
 ;    NEW'd herein (or in BLDDEL tag called herein):
 ;
 ;       ORTEAM = Team List.
 ;       ORAL   = Team List Autolink.
 ;       ORVAL  = Team List Autolink node data value.
 ;       ORTYPE = Type of Autolink.
 ;       ORLINK = Autolink holder variable.
 ;       LNAME  = Team List textual name.
 ;       VP     = Array for call to PTS^ORLP2.
 ;
 N ORTEAM,ORAL,ORVAL,ORTYPE,ORLINK,LNAME,VP
 ;
 ; Order through OE/RR TEAM LIST file looking for autolinks:
 ;
 S ORTEAM=0 ; Initialize.
 F  S ORTEAM=$O(^OR(ORTL,ORTEAM)) Q:'+ORTEAM  D      ; Each team.
 .I $P(^OR(ORTL,ORTEAM,0),"^",2)["A",'$O(^OR(ORTL,ORTEAM,2,0)) Q  ; If not an Autolink Team List or no Autolink records, skip.
 .S ORAL=0 ; Initialize.
 .F  S ORAL=$O(^OR(ORTL,ORTEAM,2,ORAL)) Q:'+ORAL  D  ; Each Autolink.
 ..I $D(^OR(ORTL,ORTEAM,2,ORAL,0)) S ORVAL=^OR(ORTL,ORTEAM,2,ORAL,0) ; Get data value from this clinic's record.
 ..S ORTYPE=$P(ORVAL,";",2) ; Get Autolink type.
 ..I ORTYPE="SC(" D         ; Is the Autolink type a clinic?
 ...I $P(ORVAL,";")=ORCL D  ; Is it the clinic involved?
 ....I '$D(^OR(ORTL,ORTEAM,10,"B",ORPT_";DPT(")) Q  ; Patient Autolinked there now?  If not, forget it.
 ....D BLDDEL ; Call tag to build list/compare/delete entry if needed.
 ;
 Q
 ;
BLDDEL ; Build ^TMP, delete patient from clinic Autolinks as appropriate.
 ;
 ; Build ^TMP global of all patients that would be on list 
 ;    because of remaining Autolinks for this Team -
 ;
 K VP,^TMP("ORLP",$J) ; "Just-in-case" clean up.
 ;
 ; Set variables for call to DIC:
 S DIC(0)="NZ"
 S DA(1)=+ORTEAM
 S DIC="^OR("_ORTL_","_DA(1)_",2,"
 ;
 ; Order through Autolinks of this Team for remaining Autolinks:
 S ORLINK=0 ; Initialize.
 F  S ORLINK=$O(^OR(ORTL,+ORTEAM,2,ORLINK)) Q:'ORLINK  D
 .I $G(^OR(ORTL,+ORTEAM,2,ORLINK,0))=ORCL_";SC(" Q  ; Skip clinic that triggered delete action - patient already there by default.
 .S X="`"_ORLINK
 .D ^DIC
 .S VP=Y(0)
 .S VP(1)="^"_$P($PIECE(VP,";",2),"^")
 .S VP(2)=+VP
 .S LNAME=Y(0,0)
 .D PTS^ORLP2(.VP,"LINK") ; Call tag^routine to add patients to ^TMP.
 K X,Y,DIC ; Clean up pre-DIC.
 ;
 ; If patient is on list because of other autolinks, leave
 ;    him/her there - otherwise delete the patient entry:
 I '$D(^TMP("ORLP",$J,"LINK",ORPT)) D  ; Patient not on list?
 .;
 .; Lock the records at the Team level:
 .L +^OR(ORTL,+ORTEAM):5
 .I '$T W !,"  WARNING: File locked - "_LNAME_" Team List not updated." Q  ; Skip this Team if there's a locking problem.
 .;
 .S DA=$O(^OR(ORTL,+ORTEAM,10,"B",ORPT_";DPT(",0))
 .I DA D
 ..S DA(1)=+ORTEAM
 ..S DIK="^OR("_ORTL_","_DA(1)_",10,"
 ..D ^DIK
 ..K DIK               ; Clean up DIK.
 .;
 .L -^OR(ORTL,+ORTEAM) ; Release the lock on this Team.
 ;
 K VP,^TMP("ORLP",$J)  ; Clean up before quitting.
 Q
 ;
