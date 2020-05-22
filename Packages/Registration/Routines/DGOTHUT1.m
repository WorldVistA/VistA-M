DGOTHUT1 ;SHRPE/YMG - OTHD (OTHER THAN HONORABLE DISCHARGE) APIs ;03/12/19
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ;   2053 Sup        ^DIE:FILE, UPDATE
 ;   2171 Sup        $$STA^XUAF4
 ;  10015 Sup        GETS^DIQ
 ;  10103 Sup        ^XLFDT: $$FMTE, $$NOW
 ;   2486 Con. Sub.  ^IVMPLOG : EVENT
 ;
LASTPRD(DGIEN33) ; find last 365 and 90 day periods
 ;
 ; DGIEN33 - file 33 ien
 ;
 ; returns the following string delimited by "^" (if data can't be found, corresponding piece is set to 0):
 ;  p1 = # of the last 365 day period
 ;  p2 = ien (in sub-file 33.01) of the last 365 day period
 ;  p3 = # of the last 90 day period
 ;  p4 = ien (in sub-file 33.11) of the last 90 day period
 ;
 N IEN3301,IEN3311,LST365,LST90,RES
 S RES="0^0^0^0" I $G(DGIEN33)>0,$D(^DGOTH(33,DGIEN33))>0 D
 .S LST365=+$O(^DGOTH(33,DGIEN33,1,"B",""),-1),IEN3301=+$O(^DGOTH(33,DGIEN33,1,"B",LST365,""))
 .I IEN3301>0 D
 ..S $P(RES,U)=LST365,$P(RES,U,2)=IEN3301
 ..S LST90=+$O(^DGOTH(33,DGIEN33,1,IEN3301,1,"B",""),-1)
 ..S IEN3311=+$O(^DGOTH(33,DGIEN33,1,IEN3301,1,"B",LST90,""))
 ..S $P(RES,U,3)=LST90,$P(RES,U,4)=IEN3311
 ..Q
 .Q
 Q RES
 ;
GET90DT(DGIEN33,DGIEN3301,DGIEN3311) ; return dates info for a given 90 day period
 ;
 ; DGIEN33   - file 33 ien
 ; DGIEN3301 - sub-file 33.01 ien
 ; DGIEN3311 - sub-file 33.11 ien
 ;
 ; returns the following string delimited by "^" (if data can't be found, corresponding piece is set to 0):
 ;  p1 = start date (internal FM format)
 ;  p2 = end date (internal FM format)
 ;  p3 = days left in this period
 ;
 N DAYS,EDT,IENS,NUM90,SDT
 S (DAYS,EDT)=0
 S IENS=DGIEN3311_","_DGIEN3301_","_DGIEN33_","
 S NUM90=$$GET1^DIQ(33.11,IENS,.01,"I")
 S SDT=+$$GET1^DIQ(33.11,IENS,.02,"I")
 I SDT D
 .S EDT=$$FMADD^XLFDT(SDT,$S(NUM90=1:90,1:89)),DAYS=$$FMDIFF^XLFDT(EDT,DT,1)
 .S DAYS=$S(DAYS<0:0,DAYS>90:90,1:DAYS)
 .Q
 Q SDT_U_EDT_U_DAYS
 ;
GET365DT(DGIEN33,DGIEN3301) ; return dates info for a given 365 day period
 ;
 ; DGIEN33   - file 33 ien
 ; DGIEN3301 - sub-file 33.01 ien
 ;
 ; returns the following string delimited by "^" (if data can't be found, corresponding piece is set to 0):
 ;  p1 = start date (internal FM format)
 ;  p2 = end date (internal FM format)
 ;
 N EDT,SDT
 S EDT=0
 S SDT=+$$GET1^DIQ(33.01,DGIEN3301_","_DGIEN33_",",.02,"I")
 I SDT S EDT=$$FMADD^XLFDT(SDT,365)
 Q SDT_U_EDT
 ;
LOCK(DGIEN33) ; lock entry in file 33
 ;
 ; DGIEN33 - file 33 ien of the entry to lock
 ;
 ; returns 1 if lock was successful, 0 otherwise
 ;
 N RES
 S RES=0
 I +$G(DGIEN33) L +^DGOTH(33,DGIEN33):5 S RES=$T
 Q RES
 ;
UNLOCK(DGIEN33) ; unlock entry in file 33
 ;
 ; DGIEN33 - file 33 ien of the entry to unlock
 ;
 I +$G(DGIEN33) L -^DGOTH(33,DGIEN33)
 Q
 ;
FILSTAT(DGDFN,STATUS) ; file OTH status into file 33
 ; creates new entry in file 33 if necessary, then updates field 33/.02
 ;
 ; DGDFN - patient DFN
 ; STATUS - OTH status (0 = inactive, 1 = active)
 ;
 ; returns 1 on success, "0 ^ [error message]" on failure
 ;
 N DGERR,DGFDA,IEN33,IENARY,IENS
 ;
 I +$G(DGDFN)'>0 Q "0^Invalid DFN"
 I "^0^1^"'[(U_$G(STATUS)_U) Q "0^Invalid status code"
 S IEN33=+$O(^DGOTH(33,"B",DGDFN,"")) I IEN33'>0 D
 .; no existing entry, so create one
 .S IENS="+1,"
 .S DGFDA(33,IENS,.01)=DGDFN
 .D UPDATE^DIE(,"DGFDA","IENARY","DGERR")
 .S IEN33=+$G(IENARY(1))
 .K DGFDA,IENARY
 .Q
 ; file new status into field .02
 S IENS=IEN33_","
 S DGFDA(33,IENS,.02)=STATUS
 ; try to lock entry
 I '$$LOCK(IEN33) Q "0^Unable to lock entry in file 33 (ien = "_IEN33_")"
 D FILE^DIE(,"DGFDA","DGERR")
 ; unlock entry
 D UNLOCK(IEN33)
 I $D(DGERR) Q "0^"_$G(DGERR("DIERR",1,"TEXT",1))
 Q 1
 ;
FILAUTH(DGDFN,DATASTR) ; file authorized 90 day period into file 33
 ;
 ; creates new entries in sub-files 33.01 and/or 33.11 if necessary, then files data passed in DATASTR
 ; will only file data into an existing top level entry in file 33
 ;
 ; DGDFN - patient DFN
 ; DATASTR - string delimited by "^", as follows:
 ;  p1  = 365 days period # to be filed - required
 ;  p2  = 90 days period # to be filed - required
 ;  p3  = date request submitted
 ;  p4  = authorized by (name)
 ;  p5  = authorization received date
 ;  p6  = start date of this 90 days period
 ;  p7  = entered by (name)
 ;  p8  = facility (file 4 ien)
 ;  p9  = request creation date / time
 ;  p10 = edit date / time
 ;
 ; returns 1 on success, "0 ^ [error message]" on failure
 ;
 N DGERR,DGFDA,EDITTS,IEN33,IEN365,IEN90,IENARY,IENS,NUM365,NUM90,RES
 ;
 I +$G(DGDFN)'>0 Q "0^Invalid DFN"
 ; get file 33 ien to file data into
 S IEN33=+$O(^DGOTH(33,"B",DGDFN,"")) I IEN33'>0 Q "0^Unable to find an entry in file 33 for this patient"
 ; try to lock entry
 I '$$LOCK(IEN33) Q "0^Unable to lock entry in file 33 (ien = "_IEN33_")"
 S RES=1
 ; get sub-file 33.01 ien, create new entry if necessary
 S NUM365=+$P(DATASTR,U) I NUM365'>0 S RES="0^Invalid 365 day period number" G FILAUTHX
 S IEN365=+$O(^DGOTH(33,IEN33,1,"B",NUM365,"")) I IEN365'>0 D
 .; no existing entry for this 365 day period - create a new one
 .S IENS="+1,"_IEN33_","
 .S DGFDA(33.01,IENS,.01)=NUM365
 .I $P(DATASTR,U,6)>0 S DGFDA(33.01,IENS,.02)=$P(DATASTR,U,6) ; make start date of new 365 day period the same as starting date of 90 day period we're filing
 .D UPDATE^DIE(,"DGFDA","IENARY","DGERR")
 .S IEN365=+$G(IENARY(1))
 .K DGFDA,IENARY
 .Q
 I $D(DGERR) S RES="0^"_$G(DGERR("DIERR",1,"TEXT",1)) G FILAUTHX
 ; get sub-file 33.11 ien, create new entry if necessary
 S NUM90=+$P(DATASTR,U,2) I NUM90'>0 S RES="0^Invalid 90 day period number" G FILAUTHX
 S IEN90=+$O(^DGOTH(33,IEN33,1,IEN365,1,"B",NUM90,"")) I IEN90'>0 D
 .; no existing entry for this 90 day period - create a new one
 .S IENS="+1,"_IEN365_","_IEN33_","
 .S DGFDA(33.11,IENS,.01)=NUM90
 .D UPDATE^DIE(,"DGFDA","IENARY","DGERR")
 .S IEN90=+$G(IENARY(1))
 .K DGFDA,IENARY
 .Q
 I $D(DGERR) S RES="0^"_$G(DGERR("DIERR",1,"TEXT",1)) G FILAUTHX
 S EDITTS=$P(DATASTR,U,10) I +EDITTS'>0 S EDITTS=$$NOW^XLFDT()
 ; file data
 S IENS=IEN90_","_IEN365_","_IEN33_","
 I +$P(DATASTR,U,6) S DGFDA(33.11,IENS,.02)=$P(DATASTR,U,6) ; start date
 I +$P(DATASTR,U,3) S DGFDA(33.11,IENS,.03)=$P(DATASTR,U,3) ; date request submitted
 I +$P(DATASTR,U,5) S DGFDA(33.11,IENS,.04)=$P(DATASTR,U,5) ; auth. received date
 S DGFDA(33.11,IENS,.05)=$E($P(DATASTR,U,7),1,60) ; entered by
 S DGFDA(33.11,IENS,.06)=EDITTS ; date entered
 I $P(DATASTR,U,4)'="" S DGFDA(33.11,IENS,.07)=$E($P(DATASTR,U,4),1,60) ; authorized by
 S DGFDA(33.11,IENS,.08)=$P(DATASTR,U,8) ; facility
 I +$P(DATASTR,U,9)>0 S DGFDA(33.11,IENS,.09)=$P(DATASTR,U,9) ; creation date
 D FILE^DIE(,"DGFDA","DGERR")
 I $D(DGERR) S RES="0^"_$G(DGERR("DIERR",1,"TEXT",1))
 ;
FILAUTHX ; exit point
 ; unlock entry
 D UNLOCK(IEN33)
 Q RES
 ;
FILDEN(DGDFN,DATASTR) ; file denied authorization request into file 33
 ;
 ; creates new entry in sub-file 33.03, then files data passed in DATASTR
 ; will only file data into an existing top level entry in file 33
 ;
 ; DGDFN - patient DFN
 ; DATASTR - string delimited by "^", as follows:
 ;  p1 = date request submitted
 ;  p2 = authorization comment (rejection reason)
 ;  p3 = entered by (name)
 ;  p4 = facility (file 4 ien)
 ;  p5 = request creation date / time
 ;  p6 = edit date / time
 ;
 ; returns 1 on success, "0 ^ [error message]" on failure
 ;
 N DGERR,DGFDA,EDITTS,IEN33,IENS
 ;
 I +$G(DGDFN)'>0 Q "0^Invalid DFN"
 ; get file 33 ien to file data into
 S IEN33=+$O(^DGOTH(33,"B",DGDFN,"")) I IEN33'>0 Q "0^Unable to find an entry in file 33 for this patient"
 ; try to lock entry
 I '$$LOCK(IEN33) Q "0^Unable to lock entry in file 33 (ien = "_IEN33_")"
 S RES=1,IENS="+1,"_IEN33_","
 S EDITTS=$P(DATASTR,U,6) I +EDITTS'>0 S EDITTS=$$NOW^XLFDT()
 ; get the next available sequence number
 S DGFDA(33.03,IENS,.01)=$O(^DGOTH(33,IEN33,3,"B",""),-1)+1
 ;
 I +$P(DATASTR,U) S DGFDA(33.03,IENS,.02)=$P(DATASTR,U) ; date request submitted
 I $P(DATASTR,U,2)'="" S DGFDA(33.03,IENS,.03)=$E($P(DATASTR,U,2),1,60) ; auth. comment
 S DGFDA(33.03,IENS,.04)=$E($P(DATASTR,U,3),1,60) ; entered by
 S DGFDA(33.03,IENS,.05)=EDITTS ; date /time entered
 S DGFDA(33.03,IENS,.06)=$P(DATASTR,U,4) ; facility
 I +$P(DATASTR,U,5) S DGFDA(33.03,IENS,.07)=$P(DATASTR,U,5) ; creation date / time
 D UPDATE^DIE(,"DGFDA",,"DGERR")
 D UNLOCK(IEN33)
 I $D(DGERR) Q "0^"_$G(DGERR("DIERR",1,"TEXT",1))
 Q 1
 ;
FILPEND(DGDFN,DATASTR) ; file pending authorization request into file 33
 ;
 ; files data passed in DATASTR into file 33 (top level)
 ; will only file data into an existing top level entry in file 33
 ;
 ; DGDFN - patient DFN
 ; DATASTR - string delimited by "^", as follows:
 ;  p1 = pending request?(0 = no, 1 = yes)
 ;  p2 = date request submitted
 ;  p3 = entered by (name)
 ;  p4 = facility (file 4 ien)
 ;  p5 = creation date /time
 ;  p6 = edit date / time
 ;  *** setting DATASTR to "0^^^^^^" would delete existing pending request ***
 ;
 ; returns 1 on success, "0 ^ [error message]" on failure
 ;
 N DGERR,DGFDA,EDITTS,IEN33,IENS,PND
 ;
 I +$G(DGDFN)'>0 Q "0^Invalid DFN"
 ; get file 33 ien to file data into
 S IEN33=+$O(^DGOTH(33,"B",DGDFN,"")) I IEN33'>0 Q "0^Unable to find an entry in file 33 for this patient"
 ; try to lock entry
 I '$$LOCK(IEN33) Q "0^Unable to lock entry in file 33 (ien = "_IEN33_")"
 S IENS=IEN33_","
 S PND=+$P(DATASTR,U) ;  pending request?
 S EDITTS=$P(DATASTR,U,6) I PND,+EDITTS'>0 S EDITTS=$$NOW^XLFDT()
 S DGFDA(33,IENS,.07)=PND
 S DGFDA(33,IENS,.03)=$P(DATASTR,U,2) ; pending request date
 S DGFDA(33,IENS,.04)=$E($P(DATASTR,U,3),1,60) ; pending req. entered by
 S DGFDA(33,IENS,.05)=EDITTS ; pending req. date entered /edited
 S DGFDA(33,IENS,.06)=$P(DATASTR,U,4) ; pending req. facility
 S DGFDA(33,IENS,.08)=$P(DATASTR,U,5) ; creation date / time
 D FILE^DIE(,"DGFDA","DGERR")
 D UNLOCK(IEN33)
 I $D(DGERR) Q "0^"_$G(DGERR("DIERR",1,"TEXT",1))
 Q 1
 ;
GETPEND(DGDFN) ; get pending authorization request data from file 33
 ;
 ; DGDFN - patient DFN
 ;
 ; if there's no pending request, returns 0
 ; if error was encountered, returns "-1 ^ error message"
 ; if there is a pending request, returns the following string:
 ;   "1 ^ pending request date ^ entered by (name) ^ date entered / edited ^ facility (station #) ^ creation date / time"
 ;
 N DGERR,DGFDA,IEN33,IENS,RES
 ;
 I +$G(DGDFN)'>0 Q "-1^Invalid DFN"
 ; get file 33 ien to get data from
 S IEN33=+$O(^DGOTH(33,"B",DGDFN,"")) I IEN33'>0 Q "-1^Unable to find an entry in file 33 for this patient"
 S IENS=IEN33_","
 D GETS^DIQ(33,IENS,".03:.08","I","DGFDA","DGERR")
 I $D(DGERR) Q "-1^"_$G(DGERR("DIERR",1,"TEXT",1))
 S RES=+DGFDA(33,IENS,.07,"I") I 'RES Q RES
 S $P(RES,U,2)=+DGFDA(33,IENS,.03,"I")
 S $P(RES,U,3)=DGFDA(33,IENS,.04,"I")
 S $P(RES,U,4)=+DGFDA(33,IENS,.05,"I")
 S $P(RES,U,5)=$$STA^XUAF4(+DGFDA(33,IENS,.06,"I"))
 S $P(RES,U,6)=+DGFDA(33,IENS,.08,"I")
 Q RES
 ;
GETAUTH(DGIEN33,DGIEN365,DGIEN90) ; get authorized 90 day period data from file 33
 ;
 ; DGIEN33 - ien in file 33
 ; DGIEN365 - ien in sub-file 33.01
 ; DGIEN90 - ien in sub-file 33.11
 ;
 ; if error was encountered, returns "-1 ^ error message"
 ; otherwise returns the following "^"-delimited string:
 ;    p1  - 365 day period number
 ;    p2  - 90 day period number
 ;    p3  - start date (internal FM)
 ;    p4  - date request submitted (internal FM)
 ;    p5  - authorization received date (internal FM)
 ;    p6  - entered / edited by (name)
 ;    p7  - date entered / edited (internal FM)
 ;    p8  - authorized by (name)
 ;    p9  - facility (station #)
 ;    p10 - creation date /time (internal FM)
 ;
 N DGERR,DGFDA,IENS,NUM365,RES,Z
 ;
 I +$G(DGIEN33)'>0 Q "-1^Invalid file 33 ien"
 I +$G(DGIEN365)'>0 Q "-1^Invalid sub-file 33.01 ien"
 I +$G(DGIEN90)'>0 Q "-1^Invalid sub-file 33.11 ien"
 S IENS=DGIEN365_","_DGIEN33_","
 S NUM365=$$GET1^DIQ(33.01,IENS,.01,"I",,"DGERR")
 I $D(DGERR) Q "-1^"_$G(DGERR("DIERR",1,"TEXT",1))
 S IENS=DGIEN90_","_IENS
 D GETS^DIQ(33.11,IENS,"*","I","DGFDA","DGERR")
 I $D(DGERR) Q "-1^"_$G(DGERR("DIERR",1,"TEXT",1))
 F Z=1:1:9 D
 .I Z=8 S $P(RES,U,Z)=$$STA^XUAF4($G(DGFDA(33.11,IENS,Z/100,"I"))) Q
 .S $P(RES,U,Z)=$G(DGFDA(33.11,IENS,Z/100,"I"))
 S RES=NUM365_U_RES
 Q RES
 ;
GETDEN(DGIEN33,DENIEN) ; get denied authorization request data from file 33
 ;
 ; DGIEN33 - ien in file 33
 ; DENIEN - ien in sub-file 33.03
 ;
 ; if error was encountered, returns "-1 ^ error message"
 ; otherwise returns the following "^"-delimited string:
 ;    p1 - sequence number
 ;    p2 - date request submitted (internal FM)
 ;    p3 - authorization comment
 ;    p4 - entered by (name)
 ;    p5 - date entered (internal FM)
 ;    p6 - facility (station #)
 ;    p7 - creation date / time
 ;
 N DGERR,DGFDA,IENS,RES,Z
 ;
 I +$G(DGIEN33)'>0 Q "-1^Invalid file 33 ien"
 I +$G(DENIEN)'>0 Q "-1^Invalid sub-file 33.03 ien"
 S IENS=DENIEN_","_DGIEN33_","
 D GETS^DIQ(33.03,IENS,"*","I","DGFDA","DGERR")
 I $D(DGERR) Q "-1^"_$G(DGERR("DIERR",1,"TEXT",1))
 F Z=1:1:7 D
 . I Z=6 S $P(RES,U,Z)=$$STA^XUAF4($G(DGFDA(33.03,IENS,Z/100,"I"))) Q
 . S $P(RES,U,Z)=$G(DGFDA(33.03,IENS,Z/100,"I"))
 Q RES
