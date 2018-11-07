TIULF ; SLC/JER - More computational functions ;Nov 07, 2018@11:44
 ;;1.0;TEXT INTEGRATION UTILITIES;**162,OSE/SMH**;Jun 20, 1997
 ;
 ; *OSE/SMH* Changes (c) Sam Habiel
 ; Licensed under Apache 2.0.
 ;
STATUS(TIUDA) ; Returns external status for document TIUDA
 Q $$GET1^DIQ(8925,TIUDA_",",.05)
 ;
EMPTYDOC(DA) ;Checks to see if text for DCS is blank
 ; returns a 1 if empty
 ; returns a 0 if contains data
 N TIULINE,TIUQUIT,TIUSTART,TIUX,TIUY,TIUCHAR,TIUDATA
 S TIUY=1
 I +$O(^TIU(8925,+DA,"TEXT",0))'>0,+$O(^TIU(8925,"DAD",+DA,0))'>0 G EMPTYX ;Text not entered
 S TIULINE=0 F  S TIULINE=$O(^TIU(8925,+DA,"TEXT",TIULINE)) Q:TIULINE'>0!(TIUY=0)  D  Q:TIUY=0
 . S TIUDATA=$G(^TIU(8925,+DA,"TEXT",TIULINE,0)),TIUQUIT=$L(TIUDATA)
 . I TIUQUIT>0 S TIUSTART=1 D  ;Line contains data
 . . ;Checks a char at a time for valid data. If found, TIUY set to 0
 . . ;Data between two | indicates format command and not valid data 
 . . F TIUSTART=TIUSTART:1:TIUQUIT S TIUCHAR=$E(TIUDATA,TIUSTART) D  Q:(TIUY=0)
 . . . ;Char is not a control char or | char
 . . . I TIUCHAR'=124,TIUCHAR'?1C S TIUY=0 Q  ; *OSE/SMH*; Previously, individual ASCII chars where checked (<32 & >125)
 . . . I $A(TIUCHAR)=124 D  ;Char is a |
 . . . . S TIUX=$F(TIUDATA,"|",TIUSTART+1) ;Find second |
 . . . . I TIUX>TIUSTART S TIUSTART=TIUX-1 ;Making sure there is a second |
 I +TIUY,$O(^TIU(8925,"DAD",+DA,0)) D
 . N TIUC S TIUC=0
 . F TIUC=$O(^TIU(8925,"DAD",+DA,TIUC)) Q:+TIUC'>0  D  Q:+TIUY=0
 . . S TIUY=$$EMPTYDOC(TIUC)
EMPTYX ; EXIT
 Q TIUY
DOCTYPE(TIUDA) ; Evaluates Definition of a Document
 N TYPE S TYPE=+$G(^TIU(8925,+TIUDA,0))
 S TYPE=$P($G(^TIU(8925.1,+TYPE,0)),U,4)_U_$$PNAME^TIULC1(+TYPE)
 Q TYPE
