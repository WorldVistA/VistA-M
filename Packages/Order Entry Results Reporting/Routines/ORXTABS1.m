ORXTABS1 ; SLC/PKS - Edit tab parameters preferences.  [9/11/00 1:40pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,47,84**;Dec 17, 1997
 ;
 ; Additional control code for Tab Preferences Editing - works in
 ;    conjunction with the main routine, ORXTABS.
 ;
 ; NOTE: Most ORX* variables used herein NEW'd in calling routine.
 ;
 Q
 ;
EDIT ; Display list of this tab's parameter values, allow edit selection.
 ;
 ; Variables used herein:
 ;
 ;    ORXCNT2  = Loop counter for concantenated user input.
 ;    ORXHI    = High end of hyphenated entry.
 ;    ORXINPUT = Input string (DIR's Y var) from user's entry.
 ;    ORXLO    = Low end of hyphenated entry.
 ;    ORXNUM2  = Number of pieces in concantenated user input.
 ;    ORXTEMP  = Temporary value holder.
 ;    ORXTOT   = Total holder.
 ;
 N ORXCNT2,ORXHI,ORXINPUT,ORXLO,ORXNUM2,ORXTEMP,ORXTOT
 ;
 ; Create overall control loop:
 K ORXPCS                                  ; Clear each time.
 S ORXANY=0                                ; Set to check for changes.
 F  Q:ORXSTOP  D
 .;
 .; Get matching prompt strings:
 .K ORXPSTR,ORXPRO,ORXPDIS                 ; Prompts variables.
 .S ORXTAG="PROMPTS+"_ORXTCNT_"^ORXTABS"   ; Data tag for prompts.
 .S ORXPSTR=$P($T(@ORXTAG),";;",2)         ; Current prompts line.
 .S ORXPDIR=$P(ORXPSTR,U)                  ; Get first prompt piece.
 .I ORXPDIR'=ORXTNM D  Q                   ; Check for mismatch.
 ..W !!,"   Problem reading PROMPTS data!" ; On error, leave message.
 ..S ORXSTOP=1                             ; Set flag for abort.
 .S ORXPSTR=$P(ORXPSTR,U,2)                ; Get prompts list string.
 .S ORXPCS=$P($G(ORXPARS(ORXTCNT)),U,3)    ; Get "pieces" map string.
 .;
 .; Clear, reset DIR variables:
 .K DIR,X,Y
 .S DIR("T")=120 ; Two minute maximum timeout for response.
 .S DIR("A")="   Select "_ORXPDIR_" value to edit"
 .S DIR("?")="   Enter individual item number or comma-delimited string (within ranges listed)"
 .;
 .; Assign individual DIR display array items:
 .S ORXVAL=""
 .S ORXNUM=$L(ORXSETS,";")             ; # pieces = loop end counter.
 .F ORXCNT=1:1:ORXNUM  D               ; Each piece of param setting.
 ..S ORXVAL=$P($G(ORXSETS),";",ORXCNT) ; Each setting.
 ..S ORXVAL=$$LJ^XLFSTR(ORXVAL,9)      ; Format for 9 characters.
 ..S ORXPRO=$P(ORXPSTR,";",ORXCNT)     ; Prompt for this piece.
 ..S ORXPRO=$$LJ^XLFSTR(ORXPRO,24)     ; Format for 24 characters.
 ..;
 ..; Assign DIR display values:
 ..S ORXCDIS=ORXCNT                    ; Set display counter to same.
 ..S ORXCDIS=$$RJ^XLFSTR(ORXCDIS,2)    ; Right justify to 2 places.
 ..S DIR("A",ORXCNT)="     "_ORXCDIS_"     "_ORXVAL_"     "_ORXPRO
 .;
 .; Add one additional choice for editing "ALL" items:
 .I (ORXCNT>1) D
 ..S ORXCNT=ORXCNT+1                   ; Increment counter.
 ..S ORXNUM=ORXCNT                     ; Keep totaller up to date.
 ..S ORXCDIS=ORXCNT                    ; Set display counter to match.
 ..S ORXCDIS=$$RJ^XLFSTR(ORXCDIS,2)    ; Right justify to 2 places.
 ..S DIR("A",ORXCNT)="     "_ORXCDIS_"     ALL      "_"     Edit All Above Items"
 .;
 .; Define DIR input requirements:
 .S DIR(0)="LO^1:"_ORXNUM              ; List, from 1 to max choices.
 .;
 .; Call DIR for user choice:
 .W !! ; Spacing for screen display.
 .I ORXPDIR="REPORTS" D                ; Special note for reports.
 ..W !,"     NOTE: At present, the following settings affect only the list of"
 ..W !,"           Imaging report selections shown under Reports:"
 ..W !,"           ---------------------------------------------"
 .D ^DIR
 .;
 .; Check user response:
 .I '$L($G(Y)) S ORXSTOP=1 Q           ; Punt if Y isn't assigned.
 .I Y="" S ORXSTOP=1 Q                 ; Punt if Y is null.
 .I Y="^" S ORXSTOP=1 Q                ; Punt if Y is "^" character.
 .;
 .; Entry valid - assign ORXINPUT variable to user entry:
 .K ORXINPUT                           ; Clean up each time through.
 .S ORXINPUT=Y                         ; Now holds input string.
 .K DIR,X,Y                            ; Clean up after call to DIR.
 .;
 .; If user made a concantenated entry, deal with it:
 .I (($L($P(ORXINPUT,",",2)))!($L($P(ORXINPUT,"-",2)))) D  Q
 ..;
 ..; Deal with an entry string:
 ..S ORXTOT=1                                 ; Initial setting.
 ..S ORXNUM2=($L(ORXINPUT,",")-1)             ; Total pieces entered.
 ..;
 ..; Establish loop to tear the string apart:
 ..F ORXCNT=1:1:ORXNUM2  D                    ; Each piece in entry.
 ...I ORXCNT>ORXTOT S ORXTOT=ORXCNT           ; Reset higher?
 ...S ORXTEMP=$P(ORXINPUT,",",ORXCNT)         ; Get each entry piece.
 ...;
 ...; Check for a hyphenated entry:
 ...I $L($P(ORXTEMP,"-",2)) D  Q              ; To next piece after.
 ....S ORXLO=$P(ORXTEMP,"-")                  ; Lower number.
 ....S ORXHI=$P(ORXTEMP,"-",2)                ; Higher number.
 ....S ORXHI=+ORXHI                           ; Eliminate comma.
 ....I ORXHI>ORXTOT S ORXTOT=ORXHI            ; Reset higher?
 ....;
 ....; Use another loop to assign the range of hyphenated elements:
 ....F ORXCNT2=ORXLO:1:ORXHI D
 .....S ORXINPUT(ORXCNT2)=ORXCNT2             ; ORXCNT2 is default #.
 ...;
 ...; If piece isn't hyphenated, use it directly:
 ...S ORXINPUT(+ORXTEMP)=+ORXTEMP
 ...I +ORXTEMP>ORXTOT S ORXTOT=+ORXTEMP       ; Reset higher?
 ..;
 ..; Check and eliminate "ALL" selection if necessary:
 ..I ORXTOT=ORXNUM K ORXINPUT(ORXTOT) S ORXTOT=ORXTOT-1
 ..;
 ..; ORXTOT should now equal the highest-numbered user selection.
 ..; Each assigned ORXINPUT(xx) element should resemble:
 ..;    ORXINPUT(5)=5
 ..;
 ..; Call tag to process the entries:
 ..D SOME
 .;
 .; No more than one entry, so assign ORXCNT and proceed:
 .S ORXCNT=+ORXINPUT
 .;
 .; Unless "ALL" was selected, assign current value variables:
 .I ORXCNT<ORXNUM D
 ..S ORXNOW=$P($G(ORXCUR),";",$P($G(ORXPCS),";",ORXCNT))
 ..S ORXPDIS=$P(ORXPSTR,";",ORXCNT)     ; Display prompt, this piece.
 .;
 .; Deal with "ALL" choice:
 .I ORXCNT=ORXNUM S ORXSTOP=1 D ALL  Q  ; "ALL" choice.
 .;
 .; Process individual selections:
 .S ORXVAL=$P($G(ORXSETS),";",ORXCNT)   ; Any of individual choices.
 .D EACH
 ;
 Q
 ;
ALL ; Process each value (piece) of selected parameter in turn.
 ;
 S ORXNEW=""                                 ; Reset.
 ;
 ; Establish control loop:
 F ORXCNT=1:1:(ORXNUM-1) Q:ORXNEW="^"  D
 .;
 .; Set tag to match each value:
 .S ORXVAL=$P($G(ORXSETS),";",ORXCNT)
 .;
 .; Assign current value and prompt variables each time:
 .S ORXNOW=$P($G(ORXCUR),";",$P($G(ORXPCS),";",ORXCNT))
 .S ORXPDIS=$P(ORXPSTR,";",ORXCNT)
 .;
 .; Process each value:
 .W !!,"     (Entry of ^ will cancel entry process.)"
 .D EACH
 ;
 Q
 ;
SOME ; Process specific values of selected parameter in turn.
 ;
 S ORXNEW=""                                 ; Reset.
 ;
 ; Establish control loop:
 S ORXCNT=0                                  ; Initialize.
 F  Q:((ORXCNT>(ORXTOT))!(ORXNEW="^"))  D
 .S ORXCNT=ORXCNT+1                          ; Increment each time.
 .I '$D(ORXINPUT(ORXCNT)) Q                  ; Non-existant entries.
 .;
 .; Set tag to match each value:
 .S ORXVAL=$P($G(ORXSETS),";",ORXCNT)        ; ORXCNT is # by default.
 .;
 .; Assign current value and prompt variables each time:
 .S ORXNOW=$P($G(ORXCUR),";",$P($G(ORXPCS),";",ORXCNT))
 .S ORXPDIS=$P(ORXPSTR,";",ORXCNT)
 .;
 .; Process each value:
 .W !!,"     (Entry of ^ will cancel entry process.)"
 .D EACH
 ;
 Q
 ;
EACH ; Process and update an edited value.
 ;
 ; Get tag name in ORXTABS2 to process the user's entry:
 K DIR,X,Y
 S ORXANY=ORXANY+1
 ;
 ; Assign command string with passed variable for execution:
 S ORXNEW="S ORXNEW=$$"_ORXVAL_"^ORXTABS2("_""""_ORXNOW_""""_")"
 ;
 X ORXNEW                               ; Execute call to tag.
 ;
 ; Don't update value if user opted out with "^" entry:
 I ORXNEW="^" S ORXANY=ORXANY-1 Q
 ;
 ; Stuff new value into current value string:
 S $P(ORXCUR,";",$P($G(ORXPCS),";",ORXCNT))=ORXNEW
 ;
 Q
 ;
SAVE ; Obtain user input, then save or discard changes.
 ;
 S ORXANY=$$CONFIRM                       ; Re-use ORXANY variable.
 I 'ORXANY W !!,"   No changes saved...." Q
 ;
 ; Write changes back to parameters file:
 K ORXERR
 D PUT^XPAR(DUZ_";VA(200,",ORXPNAM,,ORXCUR,.ORXERR)
 ;
 ; Check for an error in the write process:
 I (+ORXERR'=0) D  Q
 .W !,"   ERROR: Parameter not updated!"  ; Notify user of error.
 .W !,"   ("_$P(ORXERR,U,2)_")"           ; Display error message.
 ;
 W !!,"Tab parameter setting(s) updated/saved."
 W !,"(GUI Users must close, re-start application to activate changes.)",!
 ;
 Q 
 ;
CONFIRM() ; Confirm to save changes.
 ;
 ; Clear, reset DIR variables:
 K DIR,X,Y
 S DIR("T")=120 ; Two minute maximum timeout for response.
 S DIR("A")="   Save changes"
 S DIR("?")="   Write changes to parameter file? (Y/N)"
 S DIR("A",1)="     YES"
 S DIR("A",2)="     NO"
 S DIR("B")="YES"
 ;
 ; Define DIR input requirements:
 S DIR(0)="YO^1:2:0"
 ;
 ; Call DIR for user choice:
 W !! ; Spacing for screen display.
 D ^DIR
 ;
 ; Check user response:
 I '$L($G(Y)) Q 0                      ; Skip if Y isn't assigned.
 I Y="" Q 0                            ; Skip if Y is null.
 I Y="^" Q 0                           ; Skip if Y is "^" character.
 I Y<1 Q 0                             ; Skip if Y is less than one.
 I Y>2 Q 0                             ; "No" choice.
 I Y=1 Q 1                             ; "Yes" choice.
 ;
 Q 0                                   ; Default return of "No."
 ;
