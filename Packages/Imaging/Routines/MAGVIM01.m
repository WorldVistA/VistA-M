MAGVIM01 ;WOIFO/DAC/NST/BT - Utilities for RPC calls for DICOM file processing ;  28 Aug 2012 2:13 PM
 ;;3.0;IMAGING;**118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
OUTSEP() ; Name value separator for output data ie. NAME|TESTPATIENT
 Q "|"
STATSEP() ; Status and result separator ie. -3``No record IEN
 Q "`"
INPUTSEP() ; Name value separator for input data ie. NAME`TESTPATIENT
 Q "`"
 ; RPC: MAGV GET WORKLISTS
GETLIST(OUT) ; Returns all worklist names and statuses
 N IEN,OSEP,SSEP,FILE,WORKLIST,I
 S IEN=0,I=0,OSEP=$$OUTSEP,SSEP=$$STATSEP,FILE=2006.9412
 F  S IEN=$O(^MAGV(FILE,IEN)) Q:+IEN=0  D
 . S I=I+1
 . S WORKLIST=$G(^MAGV(FILE,IEN,0))
 . S OUT(I+1)=$P(WORKLIST,U,1)_OSEP_$P(WORKLIST,U,2)
 I I>0 S OUT(1)=0_SSEP_I
 Q
 ; RPC: MAGV CREATE WORK ITEM
CRTITEM(OUT,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,MSGTAGS,CRTUSR,CRTAPP) ; Creates an entry in the work item file and the work history file
 N FDA,ERR,SMIEN,ISEP,SSEP,MSG,APPIEN
 N I,CRTDAT
 S SSEP=$$STATSEP,ISEP=$$INPUTSEP
 S CRTDAT=$$NOW^XLFDT ; CREATED DATE/TIME
 K OUT
 I $G(TYPE)="" S OUT=-6_SSEP_"No work item TYPE provided" Q
 I $G(SUBTYPE)="" S OUT=-7_SSEP_"No work item SUBTYPE provided" Q
 I $G(STATUS)="" S OUT=-8_SSEP_"No work item STATUS provided" Q
 I $G(PLACEID)="" S OUT=-9_SSEP_"No work item LOCATION provided" Q
 I $G(PRIORITY)="" S OUT=-10_SSEP_"No work item PRIORITY provided" Q
 I ($G(CRTUSR)="")&($G(CRTAPP)="") S OUT=-11_SSEP_"No work item USER/APPLICATION provided" Q
 S FDA(2006.941,"+1,",.01)=CRTDAT
 S FDA(2006.941,"+1,",1)=TYPE
 S FDA(2006.941,"+1,",2)=SUBTYPE
 S FDA(2006.941,"+1,",3)=STATUS
 S FDA(2006.941,"+1,",4)=PLACEID
 S FDA(2006.941,"+1,",5)=PRIORITY
 S FDA(2006.941,"+1,",9)=CRTDAT
 S:$G(CRTUSR)'="" (FDA(2006.941,"+1,",8),FDA(2006.941,"+1,",10))="`"_CRTUSR  ; user DUZ is passed
 I $G(CRTAPP)'="" D
 . S APPIEN=$$GETIEN^MAGVAF05(2006.9193,CRTAPP,1)  ; Get application IEN
 . S (FDA(2006.941,"+1,",14),FDA(2006.941,"+1,",15))=CRTAPP
 . Q
 ; Add message text and tag names and values
 F I=1:1 Q:'$D(MSGTAGS(I))  D
 . I $E($P(MSGTAGS(I),ISEP,1),1,3)="MSG" S MSG(I+1)=$P(MSGTAGS(I),ISEP,2) Q
 . S FDA(2006.94111,"+"_(I+1)_",+1,",.01)=$P(MSGTAGS(I),ISEP,1)  ; TAG NAME
 . S FDA(2006.94111,"+"_(I+1)_",+1,",1)=$P(MSGTAGS(I),ISEP,2)    ; TAG VALUE
 . Q
 K ERR
 D VALIDATE^MAGVIM06(.FDA,.ERR)
 ; Quit on validation error
 I $D(ERR) S OUT="-4"_SSEP_$G(ERR) Q
 ; Set Work Item
 K ERR
 ;
 L +^MAGV(2006.941,0):5 I $T D
 . D UPDATE^DIE("E","FDA","SMIEN","ERR")
 . D
 . . ; Quit if error during saving
 . . I $D(ERR("DIERR",1,"TEXT",1)) S OUT="-1"_SSEP_$G(ERR("DIERR",1,"TEXT",1)) Q
 . . ; File message as word processing field
 . . K ERR
 . . ; Quit if error during saving
 . . I $D(MSG) D  Q:$D(ERR)
 . . . D WP^DIE(2006.941,SMIEN(1)_",",13,"K","MSG","ERR")
 . . . I $D(ERR) S OUT="-3"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 . . . Q
 . . ; Return ID of new entry
 . . S OUT=0_SSEP_SMIEN(1)
 . . Q
 . L -^MAGV(2006.941,0)
 E  D
 . S OUT=-5_SSEP_"Unable to lock MAG WORK ITEM file."
 . Q
 Q
 ;
 ; RPC: MAGV UPDATE WORK ITEM
UPDITEM(OUT,ID,EXPSTAT,NEWSTAT,MESSAGE,UPDUSR,UPDAPP) ; Update work item status and create an entry in the work history file
 N FDA,SSEP,ISEP,MSGUPD,APPIEN
 S SSEP=$$STATSEP,ISEP=$$INPUTSEP
 I '$D(^MAGV(2006.941,ID)) S OUT="-6"_SSEP_"Work item "_ID_" not found" Q
 I $G(EXPSTAT)="" S OUT=-7_SSEP_"No work item expected status provided" Q
 I ($G(UPDUSR)="")&($G(UPDAPP)="") S OUT=-8_SSEP_"No updated by user/application provided" Q
 L +^MAGV(2006.941,ID):1E9
 S RSTAT=$$GET1^DIQ(2006.941,ID,"STATUS")
 I EXPSTAT'=RSTAT S OUT=-9_SSEP_"Work item "_ID_" has a status of "_RSTAT_", not the expected status of "_EXPSTAT L -^MAGV(2006.941,ID) Q
 I NEWSTAT'="" S FDA(2006.941,ID_",",3)=NEWSTAT
 ;
 F I=1:1 Q:'$D(MESSAGE(I))  D
 . I $E($P(MESSAGE(I),ISEP,1),1,3)="MSG" S MSGUPD(I+1)=$P(MESSAGE(I),ISEP,2)
 . Q
 ;
 S FDA(2006.941,ID_",",9)=$$NOW^XLFDT  ; LAST UPDATED DATE/TIME
 S:$G(UPDUSR)'="" FDA(2006.941,ID_",",10)="`"_UPDUSR  ; LAST UPDATING USER - User DUZ is passed
 I $G(UPDAPP)'="" D
 . S APPIEN=$$GETIEN^MAGVAF05(2006.9193,UPDAPP,1)  ; Get application IEN or create a new one first
 . S FDA(2006.941,ID_",",15)=UPDAPP      ; LAST UPDATING APPLICATION
 . Q
 ;
 S OUT=$$UPDWI^MAGVIM01(ID,.FDA,.MSGUPD)  ; Update Work Item ID with FDA data and MSGUPD message
 L -^MAGV(2006.941,ID)
 Q
 ;
UPDWI(ID,FDA,MSGUPD) ; Update work item
 ; Return 0|Error`Message error
 ; 
 ; ID - IEN of Work Item
 ; FDA - VA FileMan FDA array
 ; MSGUPD - Message array
 N ERR,SSEP
 S SSEP=$$STATSEP
 ;
 D VALIDATE^MAGVIM06(.FDA,.ERR)
 I $D(ERR("DIERR",1,"TEXT",1)) Q -4_SSEP_$G(ERR("DIERR",1,"TEXT",1))  ;Quit on error
 ;
 K ERR
 D FILE^DIE("E","FDA","ERR")
 I $D(ERR("DIERR",1,"TEXT",1)) Q -3_SSEP_$G(ERR("DIERR",1,"TEXT",1))  ;Quit on error
 ;
 ; Update Message field
 K ERR
 I $D(MSGUPD) D WP^DIE(2006.941,ID_",",13,"K","MSGUPD","ERR")
 I $D(ERR("DIERR",1,"TEXT",1)) Q -5_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 ;
 Q 0_SSEP_"Work item "_ID_" updated"
 ;
 ; RPC: MAGV FIND WORK ITEM
FIND(OUT,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,STOPTAG,MAXROWS,TAGS) ; Find records with given attributes - return ID
 ;PLACEID is FILE #4's STATION NUMBER
 N IEN,IEN2,J,TAGMATCH,SSEP,ISEP,TAG,WICOUNT,FLD
 N VALUE,FLDS,AFLD,NOMATCH,IENS,MAGOUT,LOCIEN
 S SSEP=$$STATSEP,ISEP=$$INPUTSEP
 ;
 I $G(MAXROWS)'="",'(MAXROWS?1N.N) S OUT=-2_SSEP_"Invalid MAXROWS parameter provided" Q
 ;
 I $G(PLACEID)'="" D  Q:$G(OUT)<0
 . S LOCIEN=$$IEN^XUAF4(PLACEID) ;IA #2171 Get Institution IEN for a station number
 . I LOCIEN="" S OUT=-2_SSEP_"Invalid PLACEID parameter provided"
 . Q
 ;
 S OUT(0)=0
 ; AFLD(FLD,"IE") = compare the external or internal value of the field
 S FLDS=""
 I $G(TYPE)'="" S FLDS=FLDS_"1;",AFLD(1)=TYPE,AFLD(1,"IE")="E"
 I $G(SUBTYPE)'="" S FLDS=FLDS_"2;",AFLD(2)=SUBTYPE,AFLD(2,"IE")="E"
 I $G(STATUS)'="" S FLDS=FLDS_"3;",AFLD(3)=STATUS,AFLD(3,"IE")="E"
 I $G(LOCIEN)'="" S FLDS=FLDS_"4;",AFLD(4)=LOCIEN,AFLD(4,"IE")="I"
 I $G(PRIORITY)'="" S FLDS=FLDS_"5;",AFLD(5)=PRIORITY,AFLD(5,"IE")="E"
 ;
 K ERR
 S IEN=0,WICOUNT=0
 F  S IEN=$O(^MAGV(2006.941,IEN)) Q:(+IEN=0)!($D(ERR))!((($G(MAXROWS)'="")&($G(MAXROWS)<=WICOUNT)))  D
 . S IENS=IEN_","
 . K ERR,MAGOUT
 . D GETS^DIQ(2006.941,IENS,FLDS,"IE","MAGOUT","ERR")
 . I $D(ERR) K OUT S OUT(0)=-1_SSEP_$G(ERR("DIERR",1,"TEXT",1)) Q  ; Set Error and quit
 . S FLD=""
 . S NOMATCH=0
 . F  S FLD=$O(AFLD(FLD)) Q:FLD=""!NOMATCH  D
 . . S:AFLD(FLD)'=MAGOUT("2006.941",IENS,FLD,AFLD(FLD,"IE")) NOMATCH=1
 . . Q
 . Q:NOMATCH  ; get next one if no match
 . ; Tag matching
 . S J=0,TAGMATCH=1
 . F  S J=$O(TAGS(J)) Q:J=""  D
 . . S TAG=$P(TAGS(J),ISEP,1),VALUE=$P(TAGS(J),ISEP,2)
 . . I '$D(^MAGV(2006.941,"H",TAG,IEN)) S TAGMATCH=0 Q
 . . S IEN2=$O(^MAGV(2006.941,"H",TAG,IEN,""))
 . . I $P($G(^MAGV(2006.941,IEN,4,IEN2,0)),U,2)'=VALUE S TAGMATCH=0
 . . Q
 . I 'TAGMATCH Q
 . ; Add work item header to output array
 . D GETWI^MAGVIM09(.OUT,IEN,$G(STOPTAG))  ; Get Work Item Record
 . I +OUT(0)<0 S ERR=""  ; Check for error and set ERR to quit from the loop
 . S WICOUNT=WICOUNT+1
 . Q
 Q
 ;
 ; RPC: MAGV GET WORK ITEM
GETITEM(OUT,ID,EXPSTAT,NEWSTAT,UPDUSR,UPDAPP) ; Find work item with matching ID and return tags - Get and transition
 N I,J,SSEP,RSTAT,FDA,APPIEN
 S SSEP=$$STATSEP
 K OUT
 I $G(ID)="" S OUT(0)=-1_SSEP_"No work item ID provided" Q
 I $G(EXPSTAT)="" S OUT(0)=-2_SSEP_"No expected status provided" Q
 I $G(NEWSTAT)="" S OUT(0)=-3_SSEP_"No new status provided" Q
 I ($G(UPDUSR)="")&($G(UPDAPP)="") S OUT(0)=-4_SSEP_"No updated by user/application provided" Q
 I '$D(^MAGV(2006.941,ID)) S OUT(0)=-5_SSEP_"No work item with matching ID provided" Q
 S RSTAT=$$GET1^DIQ(2006.941,ID,"STATUS")
 I EXPSTAT'=RSTAT S OUT(0)=-6_SSEP_"Work item "_ID_" has a status of "_RSTAT_", not the expected status of "_EXPSTAT L -^MAGV(2006.941,ID) Q
 L +^MAGV(2006.941,ID):1E9
 S OUT(0)=0
 I NEWSTAT'=EXPSTAT D UPUSRAPP(.OUT,ID,NEWSTAT,UPDUSR,UPDAPP) ; Update user, app, updated time fields
 I +OUT(0)=0 D
 . S OUT(0)=0
 . D GETWI^MAGVIM09(.OUT,ID)  ; Get Work Item Record
 . Q 
 L -^MAGV(2006.941,ID)
 Q
 ; RPC: MAGV DELETE WORK ITEM
DELWITEM(OUT,ID) ; Delete Work Item
 N FDA,SSEP
 S SSEP=$$STATSEP
 I '$D(^MAGV(2006.941,ID)) S OUT=-1_SSEP_"Work item "_ID_" not found." Q
 S FDA(2006.941,ID_",",.01)="@"
 L +^MAGV(2006.941,0):5 I $T D
 . ;
 . ;--- Do not decrement FileMan highest entry value during delete.
 . N MAXIEN S MAXIEN=$P(^MAGV(2006.941,0),U,3)
 . D FILE^DIE("","FDA")
 . S:$P(^MAGV(2006.941,0),U,3)<MAXIEN $P(^MAGV(2006.941,0),U,3)=MAXIEN
 . S OUT=0_SSEP_"Work item "_ID_" deleted."
 . L -^MAGV(2006.941,0)
 . Q
 E  D
 . S OUT=-2_SSEP_"Work item "_ID_" is locked."
 . Q
 Q
 ; RPC: MAGV ADD WORK ITEM TAGS
ADDTAG(OUT,ID,EXPSTAT,UPDUSR,UPDAPP,TAG) ; Add tags to work item
 ; List of statuses
 N FDA1,FDA2,ERR1,ERR4,STATMATCH,STATUS,SSEP,ISEP,I,APPIEN,MSGUPD
 S SSEP=$$STATSEP,ISEP=$$INPUTSEP
 I $G(ID)="" S OUT=-9_SSEP_"No work item ID provided" Q
 I '$D(^MAGV(2006.941,ID)) S OUT=-5_SSEP_"No work item with matching ID provided" Q
 I '$D(EXPSTAT) S OUT=-6_SSEP_"No status provided" Q
 I ($G(UPDUSR)="")&($G(UPDAPP)="") S OUT=-7_SSEP_"No updated by user/application provided" Q
 I $G(TAG(1))="" S OUT=-8_SSEP_"No tag provided" Q
 S STATUS=$$GET1^DIQ(2006.941,ID,"STATUS")
 S STATMATCH=0
 F I=1:1  Q:$P(EXPSTAT,ISEP,I)=""  Q:STATMATCH  D
 . I $P(EXPSTAT,ISEP,I)=STATUS S STATMATCH=1
 . Q
 I STATMATCH=0 S OUT=-9_SSEP_"work item does not have expected status" Q
 L +^MAGV(2006.941,ID):1E9
 F I=1:1  Q:'$D(TAG(I))  D
 . S FDA1(2006.94111,"+"_I_","_ID_",",.01)=$P(TAG(I),ISEP,1)  ; TAG NAME
 . S FDA1(2006.94111,"+"_I_","_ID_",",1)=$P(TAG(I),ISEP,2)    ; TAG VALUE
 . Q
 D VALIDATE^MAGVIM06(.FDA1,.ERR4)
 I $D(ERR4) S OUT="-11"_SSEP_$G(ERR4) L -^MAGV(2006.941,ID) Q  ; Unlock and quit
 D UPDATE^DIE("","FDA1","","ERR1")
 I $D(ERR1("DIERR",1,"TEXT",1)) S OUT="-10"_SSEP_$G(ERR1("DIERR",1,"TEXT",1)) L -^MAGV(2006.941,ID) Q  ; Unlock and quit
 ;
 ; Set Work Item
 S FDA2(2006.941,ID_",",9)=$$NOW^XLFDT
 S:$G(UPDUSR)'="" FDA2(2006.941,ID_",",10)="`"_UPDUSR  ; LAST UPDATING USER - User DUZ is passed
 I $G(UPDAPP)'="" D
 . S APPIEN=$$GETIEN^MAGVAF05(2006.9193,UPDAPP,1)  ; Get application IEN or create a new one first
 . S FDA2(2006.941,ID_",",15)=UPDAPP      ; LAST UPDATING APPLICATION
 . Q
 ;
 S OUT=$$UPDWI^MAGVIM01(ID,.FDA2,.MSGUPD)  ; Update Work Item ID with FDA data and MSGUPD message
 L -^MAGV(2006.941,ID)
 Q
 ; RPC: MAGV GET NEXT WORK ITEM
GETNEXT(OUT,ETYPE,EXPSTAT,NEWSTAT,UPDUSR,UPDAPP,LOCATION) ; Find last update work item on worklist type provided
 N SSEP,FDA,ID,TYPE,STATUS,MATCH,APPIEN,LOCATIN2,LOCIEN
 N UPDATEDT
 K OUT
 S SSEP=$$STATSEP
 I $G(ETYPE)="" S OUT(0)=-1_SSEP_"Work Item type not specified" Q
 I $G(EXPSTAT)="" S OUT(0)=-2_SSEP_"Work Item expected status not specified" Q
 I $G(NEWSTAT)="" S OUT(0)=-3_SSEP_"Work Item new status not specified" Q
 I ($G(UPDUSR)="")&($G(UPDAPP)="") S OUT(0)=-4_SSEP_"No updated by user/application provided" Q
 I $G(LOCATION)="" S OUT(0)=-5_SSEP_"Work Item Place ID not specified" Q
 ; Loop thru worklist type find last updated record with matching parameters
 S UPDATEDT="",MATCH=0
 F  S UPDATEDT=$O(^MAGV(2006.941,"I",UPDATEDT)) Q:UPDATEDT=""  D  Q:MATCH=1
 . S ID=""
 . F  S ID=$O(^MAGV(2006.941,"I",UPDATEDT,ID)) Q:ID=""  D  Q:MATCH=1
 . . S TYPE=$$GET1^DIQ(2006.941,ID,"TYPE"),STATUS=$$GET1^DIQ(2006.941,ID,"STATUS")
 . . S LOCIEN=$P($G(^MAGV(2006.941,ID,1)),U,1),LOCATIN2=$$STA^XUAF4(LOCIEN) ; IA # 2171
 . . I EXPSTAT=STATUS,ETYPE=TYPE,LOCATION=LOCATIN2 S MATCH=1 L +^MAGV(2006.941,ID):1E9
 . . Q
 . Q
 I 'MATCH S OUT(0)=0_SSEP_"No matching work item found" Q
 S OUT(0)=0
 I NEWSTAT'=EXPSTAT D UPUSRAPP(.OUT,ID,NEWSTAT,UPDUSR,UPDAPP) ; Update user, app, updated time fields
 I +OUT(0)=0 D
 . S OUT(0)=0
 . D GETWI^MAGVIM09(.OUT,ID)  ; Get Work Item Record
 . Q 
 L -^MAGV(2006.941,ID)
 Q
 ; RPC: MAGV IMPORT STATUS
IMSTATUS(OUT,UIDS) ; Get import status
 N SSEP,STUDYLIST,SOPLIST,STUDYOUT,SOPOUT,I,CNT,STUDYUID,SERUID,SOPUID,ISEP,SOPIEN,SERIEN,STUDIEN
 S SSEP=$$OUTSEP,ISEP=$$INPUTSEP,I=0,CNT=0
 I '$D(UIDS) S OUT(1)=-6_SSEP_"No UIDs provided" Q
 F  S I=$O(UIDS(I)) Q:I=""  D
 . S CNT=I
 . S STUDYUID=$P(UIDS(I),ISEP,1),SERUID=$P(UIDS(I),ISEP,2),SOPUID=$P(UIDS(I),ISEP,3)
 . I $G(STUDYUID)="" S OUT(I+1)=-1_SSEP_"No study UID provided" Q
 . I $G(SERUID)="" S OUT(I+1)=-2_SSEP_"No series UID provided" Q
 . I $G(SOPUID)="" S OUT(I+1)=-3_SSEP_"No SOP UID provided" Q
 . S OUT(I+1)=-1_SSEP_UIDS(I)_SSEP_"not on file"
 . S STUDYLIST(1)=1,STUDYLIST(2)=STUDYUID
 . S SOPLIST(1)=1,SOPLIST(2)=SOPUID
 . ; Check ^MAG(2005) for import study status 
 . D CHECKUID^MAGDRPCA(.STUDYOUT,.STUDYLIST,"STUDY")
 . I STUDYOUT(2)'="",(+STUDYOUT(2))'<0 D
 . . D CHECKUID^MAGDRPCA(.SOPOUT,.SOPLIST,"SOP")
 . . I SOPOUT(2)'="",(+SOPOUT(2))'<0 D  S CNT=I
 . . . S OUT(I+1)="0"_SSEP_UIDS(I)_SSEP_"on file"
 . . . Q
 . . Q
 . S SOPOUT=""
 . ; Check SOP original and UID
 . I ('$D(^MAGV(2005.64,"B",SOPUID)))&('$D(^MAGV(2005.66,"B",SOPUID))) Q
 . S SOPIEN=$O(^MAGV(2005.64,"B",SOPUID,""),-1)
 . Q:SOPIEN=""
 . I $G(^MAGV(2005.64,SOPIEN,11))'="A" Q
 . ; Check Series original and UID
 . I ('$D(^MAGV(2005.63,"B",SERUID)))&('$D(^MAGV(2005.66,"B",SERUID))) Q
 . S SERIEN=$O(^MAGV(2005.63,"B",SERUID,""),-1)
 . Q:SERIEN=""
 . I $G(^MAGV(2005.63,SERIEN,9))'="A" Q
 . ; Check Study original and UID
 . I ('$D(^MAGV(2005.62,"B",STUDYUID)))&('$D(^MAGV(2005.66,"B",STUDYUID))) Q
 . S STUDIEN=$O(^MAGV(2005.62,"B",STUDYUID,""),-1)
 . Q:STUDIEN=""
 . I $P($G(^MAGV(2005.62,STUDIEN,5)),U,2)'="A" Q
 . S OUT(I+1)="0"_SSEP_UIDS(I)_SSEP_"on file"
 . Q
 ;
 S OUT(1)=0_SSEP_CNT
 Q
UPUSRAPP(OUT,ID,NEWSTAT,UPDUSR,UPDAPP) ; Update user, app, updated time fields
 N FDA,APPIEN
 S FDA(2006.941,ID_",",3)=NEWSTAT
 S FDA(2006.941,ID_",",9)=$$NOW^XLFDT
 S:$G(UPDUSR)'="" FDA(2006.941,ID_",",10)="`"_UPDUSR  ; LAST UPDATING USER - User DUZ is passed
 I $G(UPDAPP)'="" D
 . S APPIEN=$$GETIEN^MAGVAF05(2006.9193,UPDAPP,1)  ; Get application IEN or create a new one first
 . S FDA(2006.941,ID_",",15)=UPDAPP      ; LAST UPDATING APPLICATION
 . Q
 S OUT(0)=$$UPDWI^MAGVIM01(ID,.FDA)  ; Update Work Item ID with FDA data and MSGUPD message
 Q
