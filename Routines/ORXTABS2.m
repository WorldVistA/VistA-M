ORXTABS2 ; SLC/PKS - Edit calls, tab parameters preferences.  [10/2/00 3:53pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,47,84**;Dec 17, 1997
 ;
 ; Individual preferences edit/input code; called from ORXTABS1.
 ;
 ; NOTES: Most ORX* variables used herein are NEW'd in calling
 ;        routines.  Tags herein (except "INPUT") must match the
 ;        name of a piece entry in the TABS tag of the ORXTABS 
 ;        routine and return:
 ;
 ;        1 - A new value entered or selected by the user,
 ;        2 - A null string,
 ;        3 - The string "*Invalid*" - to repeat due to invalid entry,
 ;        4 - The "^" character, indicating user's cancel action.
 ;
 ;    If there are dissimilar types of values - to be obtained from
 ;    the user - which utilize the same tag name, such differences 
 ;    must be handled within the individual tags herein by, for 
 ;    instance, examining the ORXPDIR variable which will reveal 
 ;    the current TABS line being processed.  
 ;
 ;    New variable used herein: 
 ;
 ;       ORXPASS = Holds ORXNOW original passed value.
 ;
 ;    Important variables used or assigned by calling routines:
 ;
 ;        ORXPDIR = Current tab's "prompt" or display string.
 ;        ORXPDIS = Current value's "prompt" or display string.
 ;        ORXNOW  = Current value of setting, passed in each call.
 ;
 ;    Actual code for these tags generally resides in a subsequent 
 ;    ORXTABSx routine, to keep this routine as a driver and with
 ;    size limits.  The tags in the subsequent routines use the 
 ;    same names for convenience.  
 ;
 Q
 ;
INPUT ; Call DIR, return user input - used by various tags called herein.
 ;
 W !!                                  ; Spacing for screen display.
 ;
 ; Assign default promtp, if any:
 S:($D(ORXNOW)&(ORXNOW'="")) DIR("B")=ORXNOW
 D ^DIR                                ; FM call for user input.
 S ORXNOW=Y                            ; Assign input to ORXNOW.
 K DIR,X,Y                             ; Clean up each time.
 ;
 Q
 ;
BEG(ORXNOW) ; Beginning date of date range.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D BEG^ORXTABS3                             ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
END(ORXNOW) ; Ending date of date range.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D END^ORXTABS3                             ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
MAX(ORXNOW) ; Maximum number of items to display.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D MAX^ORXTABS3                             ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
AUTHOR(ORXNOW) ; Select note author.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D AUTHOR^ORXTABS3                          ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
STATUS(ORXNOW) ; Status.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D STATUS^ORXTABS4(ORXPDIR)                 ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
TYPE(ORXNOW) ; Type.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D TYPE^ORXTABS5                            ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
DISPGRP(ORXNOW) ; Display Group..
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D DISPGRP^ORXTABS5                         ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
OUTPT(ORXNOW) ; Outpatient or Inpatient Meds.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D OUTPT^ORXTABS5                           ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
SUBJECT(ORXNOW) ; Subject.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D SUBJECT^ORXTABS5                         ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
FORMAT(ORXNOW) ; Format.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D FORMAT^ORXTABS5                          ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
COMMENTS(ORXNOW) ; Comments On/Off.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D COMMENTS^ORXTABS5                        ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
SERVICE(ORXNOW) ; Service.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D SERVICE^ORXTABS5                         ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
OCCLIM(ORXNOW) ; Occlim.
 ;
 N ORXPASS
 S ORXPASS=ORXNOW
 ;
 ; Use loop to account for invalid entries:
 F  D  Q:ORXNOW'="*Invalid*"
 .S ORXNOW=ORXPASS                           ; Reset each time.
 .D OCCLIM^ORXTABS5                          ; Call input dialogue.
 ;
 Q ORXNOW                                    ; Return resulting value.
 ;
