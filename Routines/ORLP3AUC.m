ORLP3AUC ; SLC/CLA -  Automatically load clinic patients into team lists ;9/11/96 [12/28/99 2:45pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,47**;Dec 17, 1997
 ; Re-created by PKS, 7/99.
 ;
 ; This code checks the ^TMP file that is written by the 
 ;    SC CLINIC ENROLL/DISCHARGE EVENT DRIVER protocol.  That 
 ;    protocol in turn calls the protocol ORU AUTOLIST CLINIC, 
 ;    which calls this routine.  When control is returned to 
 ;    SC CLINIC ENROLL/DISCHARGE EVENT DRIVER, the ^TMP entries 
 ;    are deleted.  They can be viewed by breaking out before 
 ;    that point for testing [^TMP($J,"SC CED")].
 ;
 ; (NOTE: At the time of re-creation of this routine, existing code
 ;    would not allow a user to enter a clinic enrollment or clinic 
 ;    discharge date later than the current day.  Thus, no post-date
 ;    checking is included in this routine.)
 ;
EN ; Called by protocol: ORU AUTOLIST CLINIC.  Updates Team Lists 
 ;    where the Autolink is a clinic.
 ;
 ; Variables used -
 ;
 ;    By tags called (in ORLP3AC1):
 ;
 ;       ORTL     = OE/RR TEAM LIST file.
 ;       ORTEAM   = Team List.
 ;       ORAL     = Team List Autolink.
 ;       ORVAL    = Team List Autolink node data value.
 ;       ORTYPE   = Type of Autolink.
 ;       ORLINK   = Autolink holder variable.
 ;       LNAME    = Team List textual name.
 ;       VP       = Array for call to PTS^ORLP2.
 ;
 ;    By this tag (and by tags called as needed):
 ;
 ;       ORPT     = Patient number.
 ;       ORBARY   = Array of "B" index clinics.
 ;       ORCL     = Clinic.
 ;       ORBRCD   = "BEFORE" clinic record number.
 ;       ORARCD   = "AFTER" clinic record number.
 ;       ORBLAST  = Last record in ^TMP file for "BEFORE" clinic.
 ;       ORALAST  = Last record in ^TMP file for "AFTER" clinic.
 ;       ORBEFORE = Data in "BEFORE" record.
 ;       ORAFTER  = Data in "AFTER" record.
 ;       ORBEDATE = "BEFORE" clinic enrollment date.
 ;       ORBDDATE = "BEFORE" clinic discharge date.
 ;       ORAEDATE = "AFTER" clinic enrollment date.
 ;       ORADDATE = "AFTER" clinic discharge date.
 ;
 N ORTL,ORPT,ORBARY,ORCL,ORBRCD,ORARCD,ORBLAST,ORALAST,ORBEFORE,ORAFTER,ORBEDATE,ORBDDATE,ORAEDATE,ORADDATE
 S ORTL="100.21" ; Assign for use by ADD and DELETE tags.
 ;
 ; Check for existence of ^TMP entries:
 I '$D(^TMP($J,"SC CED")) Q
 ;
 ; Process each patient in the ^TMP file:
 S ORPT=0 ; Initialize.
 F  S ORPT=$O(^TMP($J,"SC CED",ORPT)) Q:'ORPT  D
 .;
 .; Build an array of clinics for each patient in the ^TMP file:
 .K ORBARY ; Clean up each time through.
 .;
 .; Order through the "B" index records for this patient:
 .S ORCL=0 ; Initialize.
 .F  S ORCL=$O(^TMP($J,"SC CED",ORPT,"BEFORE","B",ORCL)) Q:'+ORCL  DO  ; Each "BEFORE" "B" record for clinics.
 ..S ORBARY(ORCL)="" ; Set array element for each "BEFORE" clinic.
 .S ORCL=0 ; Re-initialize.
 .F  S ORCL=$O(^TMP($J,"SC CED",ORPT,"AFTER","B",ORCL)) Q:'+ORCL  D  ; Each "AFTER" "B" record for clinics.
 ..S ORBARY(ORCL)="" ; Set array element for each "AFTER" clinic.
 .; The previous array should contain only one entry for each clinic,
 .;    whether from "BEFORE" or "AFTER" entries - (dupes overwritten).
 .;
 .; Check for valid data again:
 .I '$D(ORBARY) Q  ; If nothing to process, done.
 .;
 .; Write data entries for "BEFORE" and "AFTER" based on ^TMP data:
 .S ORCL=0 ; Initialize.
 .F  S ORCL=$O(ORBARY(ORCL)) Q:'+ORCL  D    ; Array entries.
 ..I $D(^TMP($J,"SC CED",ORPT,"BEFORE","B",ORCL)) S ORBARY(ORCL)=$O(^TMP($J,"SC CED",ORPT,"BEFORE","B",ORCL,"")) ; Set array element to ^TMP "BEFORE" "B" x-ref record number.
 ..S ORBARY(ORCL)=ORBARY(ORCL)_"^"          ; Add delimiter.
 ..I $D(^TMP($J,"SC CED",ORPT,"AFTER","B",ORCL)) S ORBARY(ORCL)=ORBARY(ORCL)_$O(^TMP($J,"SC CED",ORPT,"AFTER","B",ORCL,"")) ; Set array element to ^TMP "AFTER" "B" x-ref record number.
 .;
 .; Array entries like the following should now exist:
 .;
 .;    ORBARY(5)=1^1   |  Clinic 5 has "BEFORE" and "AFTER" entries.
 .;    ORBARY(16)=^3   |  Clinic 16 has only an "AFTER" entry.
 .;    (Etc.)
 .;    ORBARY(11)=2^   |  No "AFTER" entry - should never happen!
 .;
 .; Process each clinic listed for this patient:
 .S ORCL=0 ; Initialize.
 .F  S ORCL=$O(ORBARY(ORCL)) Q:'+ORCL  D  ; Each clinic.
 ..;
 ..; Check for no "AFTER" records:
 ..;I $P($G(ORBARY(ORCL)),"^",2)="" Q    ; Shouldn't happen!
 ..;
 ..; Get "BEFORE" and "AFTER" record entries for this clinic:
 ..S ORBRCD="",ORARCD="" ; Initialize.
 ..S ORBRCD=$P(ORBARY(ORCL),"^")   ; Assign "BEFORE" record number, if any.
 ..S ORARCD=$P(ORBARY(ORCL),"^",2) ; Assign "AFTER" record number, if any.
 ..;
 ..; Find the last records for each case, as applicable:
 ..S ORBLAST="",ORALAST="" ; Initialize.
 ..I $G(ORBRCD) S ORBLAST=$O(^TMP($J,"SC CED",ORPT,"BEFORE",ORBRCD,1,ORBLAST),-1) ; Last "BEFORE" record.
 ..I $G(ORARCD) S ORALAST=$O(^TMP($J,"SC CED",ORPT,"AFTER",ORARCD,1,ORALAST),-1)  ; Last "AFTER" record.
 ..;
 ..; Get BEFORE and AFTER data from last records for each clinic:
 ..S ORBEFORE="",ORAFTER="" ; Initialize.
 ..I $G(ORBLAST) S ORBEFORE=$G(^TMP($J,"SC CED",ORPT,"BEFORE",ORBRCD,1,ORBLAST,0)) ; Get "BEFORE" data.
 ..I $G(ORALAST) S ORAFTER=$G(^TMP($J,"SC CED",ORPT,"AFTER",ORARCD,1,ORALAST,0))   ; Get "AFTER" data.
 ..;
 ..; With "BEFORE" and "AFTER" data, process Team Lists -
 ..;
 ..; If no changes, there's nothing to do for this clinic:
 ..I ORBEFORE=ORAFTER Q
 ..;
 ..; Get date information in each case as applicable:
 ..S ORBEDATE=$P($G(ORBEFORE),"^")   ; "BEFORE" enroll date.
 ..S ORBEDATE=$P($G(ORBEDATE),".")   ; Remove time, if any.
 ..S ORBDDATE=$P($G(ORBEFORE),"^",3) ; "BEFORE" d/c date.
 ..S ORAEDATE=$P($G(ORAFTER),"^")    ; "AFTER" date.
 ..S ORAEDATE=$P($G(ORAEDATE),".")   ; Remove time, if any.
 ..S ORADDATE=$P($G(ORAFTER),"^",3)  ; "AFTER" d/c date.
 ..; (All four dates should now be set, even if to null.)
 ..;
 ..; Now call the ADD or DELETE tags in ORLP3AC1 as appropriate -
 ..;
 ..; If no "AFTER" d/c and enroll <> "BEFORE" enroll, call add:
 ..I (ORADDATE="")&(ORAEDATE'=ORBEDATE) D ADD^ORLP3AC1
 ..;
 ..; If "AFTER" d/c exists and  <> "BEFORE" d/c, call delete:
 ..I (ORADDATE'="")&(ORADDATE'=ORBDDATE) D DELETE^ORLP3AC1
 ;
 K ORBARY ; Clean up.
 Q
 ;
