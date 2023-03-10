TIUCROBJ ;SPFO/AJB - Create Objects ;Jul 14, 2021@07:12:36
 ;;1.0;TEXT INTEGRATION UTILITIES;**341**;Jun 20, 1997;Build 23
 ;
 ; $$FIND1^DIC     ICR#2051          UPDATE^DIE     ICR#2053
 ;  $$GET1^DIQ     ICR#2056            $$UP^XLFSTR  ICR#10104
 ;        ^DIM     ICR#10016
 Q
 ; Parameter List:
 ;   NAME   object name
 ;   ABBR   abbreviation   [optional], default null
 ;   PNAME  print name     [optional], default NAME
 ;   METHOD object method  [optional], default null
 ;   POWNER personal owner [optional], default null
 ;
 ; Basic Settings:
 ;   CLASS OWNER set to "CLINCAL COORDINATOR", default if no personal owner
 ;   STATUS set to ACTIVE
 ;
CROBJ(NAME,ABBR,PNAME,METHOD,POWNER) ; create objects
 ; verify name
 S NAME=$$UP^XLFSTR($G(NAME)) Q:NAME="" "0^NAME missing."
 Q:NAME?1P.E "0^NAME must not start with punctuation."
 I $L(NAME)<3!($L(NAME)>60) Q "0^NAME must be 3-60 characters."
 Q:$$CHKNAME(NAME,"B") "0^Name: "_NAME_" already exists."
 ; verify abbreviation
 S ABBR=$$UP^XLFSTR($G(ABBR))
 I ABBR'="" Q:ABBR'?2.4A "0^ABBREVIATION must be 2 to 4 letters."
 I ABBR'="" Q:$$CHKNAME(ABBR,"C") "0^Abbreviation: "_ABBR_" already exists."
 ; verify print name
 S PNAME=$$UP^XLFSTR($G(PNAME)) I PNAME="" S PNAME=NAME
 I $L(PNAME)<3!($L(PNAME)>60) Q "0^PRINT NAME must be 3-60 characters."
 Q:$$CHKNAME(PNAME,"D") "0^Print Name: "_PNAME_" already exists."
 ; verify method
 I $L($G(METHOD))>245 Q "0^OBJECT METHOD must be no more than 245 characters."
 N X S X=$G(METHOD) D:X'="" ^DIM Q:'$D(X) "0^Must be standard MUMPS code."
 ; set personal owner/class owner
 N CLOWNER S CLOWNER=$$LU(8930,"CLINICAL COORDINATOR","X"),POWNER=+$G(POWNER)
 I +POWNER D  ; check personal owner
 . I '$L($$GET1^DIQ(200,POWNER,.01)) S POWNER=0 Q
 . S CLOWNER=0 ; don't set both personal and class owner
 Q:'+CLOWNER&('+POWNER) "0^Class and personal owner not found."
 ; create the object
 N TIU,TIUDA,TIUERR,TIUFPRIV S TIUFPRIV=1
 S TIU(8925.1,"+1,",.01)=NAME
 S:ABBR'="" TIU(8925.1,"+1,",.02)=ABBR
 S TIU(8925.1,"+1,",.03)=PNAME
 S TIU(8925.1,"+1,",.04)="O"
 S:+POWNER TIU(8925.1,"+1,",.05)=POWNER
 S:+CLOWNER TIU(8925.1,"+1,",.06)=CLOWNER
 S TIU(8925.1,"+1,",.07)=11
 S:$G(METHOD)'="" TIU(8925.1,"+1,",9)=METHOD
 S TIU(8925.1,"+1,",99)=$H
 D UPDATE^DIE("","TIU","TIUDA","TIUERR")
 I $D(TIUERR) S TIUERR=$G(TIUERR("DIERR",1,"TEXT",1)),TIUERR=$S(TIUERR'="":"0^"_TIUERR,1:"0^Object NOT created.")
 Q $S($D(TIUERR):TIUERR,1:1)
 ;
CHKNAME(NAME,XREF) ; check if name is in use
 N ANS,TIUDA S TIUDA=0 F  S TIUDA=$O(^TIU(8925.1,XREF,NAME,TIUDA)) Q:'TIUDA  D
 . I $D(^TIU(8925.1,"AT","O",TIUDA)) S ANS=1
 Q +$G(ANS)
 ;
LU(FILE,NAME,FLAGS,SCREEN,INDEXES) ;
 Q $$FIND1^DIC(FILE,"",$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN))
