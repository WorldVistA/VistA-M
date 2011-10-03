ORXTABS ; SLC/PKS - Edit tab parameters preferences.  [10/17/00 2:44pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,47,84**;Dec 17, 1997
 ;
 ; Main control routine is herein for Tab Preferences Editing.
 ;    Works with routines ORXTABS1 and ORXTABS2.  ORXTABS1 contains 
 ;    additional control tags that work in conjunction with the 
 ;    control code at the top of this routine, in order to keep this 
 ;    one below 10K size maximum.  ORXTABS2 contains tags to handle
 ;    individual preference edit/input, making calls to ORXTABS3,
 ;    ORXTABS4, etc., where code for individual dialogues reside.  
 ;
 Q
 ;
EN ; Entry point - called by option [ORX PARAM TAB PREF].
 ;
 ; Variables used:
 ;
 ;    DIR,X,Y = FM user input variables.
 ;    ORXANY  = Flag for number of changes.
 ;    ORXCDIS = Display holder for counter display.
 ;    ORXCHC  = User's choice of parameter value to edit.
 ;    ORXCNT  = Loop counter; re-used in various tags.
 ;    ORXCUR  = Existing settings for a parameter.
 ;    ORXERR  = Error array used in call to XPAR.
 ;    ORXNEW  = New value entered by user.
 ;    ORXNOW  = Cuttent setting of a parameter piece value.
 ;    ORXNUM  = Array count holder.
 ;    ORXPAR  = Working variable for parameter definitions, etc.
 ;    ORXPARS = Becomes array of parameters from TABS tag.
 ;    ORXPCS  = Array of formal parameter string's piece settings.
 ;    ORXPDIR = Display prompt piece (first piece). 
 ;    ORXPDIS = Holder for prompt piece of each value.
 ;    ORXPNAM = Stores name of current parameter definition.  
 ;    ORXPRO  = Current prompt.
 ;    ORXPSTR = String of prompts.
 ;    ORXSETS = Setting(s) pieces for a parameter.
 ;    ORXSTOP = Flag to stop editing.
 ;    ORXTAB  = Becomes current tab, as exists in last part of formal 
 ;              parameter definition string.
 ;    ORXTAG  = Current data tag.
 ;    ORXTCNT = Current tab line counter.
 ;    ORXTNM  = First piece of current tab from text entry.
 ;    ORXVAL  = Value holder.
 ;
 N DIR,X,Y,ORXANY,ORXCDIS,ORXCHC,ORXCNT,ORXCUR,ORXERR,ORXNEW,ORXNOW,ORXNUM,ORXPAR,ORXPARS,ORXPCS,ORXPDIR,ORXPDIS,ORXPNAM,ORXPRO,ORXPSTR,ORXSETS,ORXSTOP,ORXTAB,ORXTAG,ORXTCNT,ORXTNM,ORXVAL
 ;
 S ORXSTOP=0                          ; Preset flag before starting.
 ;
 ; Establish control loop for entire editing process.
 F  Q:ORXSTOP  D
 .D BLDLIST Q:ORXSTOP                 ; ORXSTOP here = list problem.
 .D CHOOSE Q:ORXSTOP                  ; ORXSTOP here = user punted.
 .D PARAMS(ORXTAB)                    ; ORXTAB set by CHOOSE tag.
 .D EDIT^ORXTABS1                     ; User editing.
 .;
 .; ORXANY will be set by EACH, SOME, or ALL calls in ORXTABS1:
 .I ORXANY D SAVE^ORXTABS1            ; If changes made, save?
 .S ORXSTOP=0                         ; Assure loop restart.
 ;
 Q
 ;
BLDLIST ; Get list of tabs with editable parameters for display.
 ;
 K ORXPARS                            ; Clean out array each time.
 S ORXTAG="TABS"                      ; Data tag herein.
 S ORXCNT=0                           ; Initialize counter.
 F  D  Q:ORXPARS(ORXCNT)=""           ; Get each tag's entry.
 .S ORXCNT=ORXCNT+1                   ; Increment counter.
 .S ORXPARS(ORXCNT)=$P($T(@ORXTAG+ORXCNT),";;",2)
 ;
 ; Check for no parameters listed or problem with reading data:
 I ORXCNT<2 S ORXSTOP=1
 ;
 Q
 ;
CHOOSE ; Display tabs, allow user to choose.
 ;
 ; Clear, reset DIR variables:
 K DIR,X,Y
 S DIR("A")="     Select tab for preferences editing"
 S DIR("?")="   Select by entry of item number:"
 ;
 ; Assign array [DIR("A")] items for display:
 S ORXCNT=0
 S ORXVAL=""
 F  D  Q:ORXVAL=""
 .S ORXCNT=ORXCNT+1                   ; Increment counter.
 .S ORXVAL=$P($G(ORXPARS(ORXCNT)),U)  ; Get first piece of string.
 .;
 .; Assign the actual display line:
 .S ORXCDIS=ORXCNT
 .S ORXCDIS=$$RJ^XLFSTR(ORXCDIS,2)    ; Right justify to 2 places.
 .S:(ORXVAL'="") DIR("A",ORXCNT)="        "_ORXCDIS_"    "_ORXVAL
 ;
 ; Check for errors:
 I ORXCNT<2 W !!,"   Problem reading TABS data!" S ORXSTOP=1 Q
 ;
 ; Define DIR input requirements:
 S DIR(0)="NO^1:"_(ORXCNT-1)_":0"
 ;
 ; Call DIR for user choice:
 W !! ; Spacing for screen display.
 D ^DIR
 ;
 ; Check user response:
 I '$L($G(Y)) S ORXSTOP=1 Q           ; Punt if Y not assigned.
 I Y="" S ORXSTOP=1 Q                 ; Punt if Y is null.
 I Y="^" S ORXSTOP=1 Q                ; Punt if Y is "^" character.
 I Y<1 S ORXSTOP=1 Q                  ; Punt if Y is less than one.
 I Y>(ORXCNT-1) S ORXSTOP=1 Q         ; Punt if Y isn't within range.
 S (ORXTCNT,ORXTAB)=Y                 ; Otherwise, get entry and go.
 ;
 Q
 ;
PARAMS(ORXPAR) ; Retrieve selected tab's current parameter values.
 ;
 S ORXTAB=$P(ORXPARS(ORXPAR),U)       ; Tab name from user display.
 S ORXTNM=ORXTAB                      ; Comparison value holder.
 S ORXSETS=$P(ORXPARS(ORXPAR),U,2)    ; Settings info.
 S ORXTAB=$$EXCX                      ; Display name differences.
 S ORXPAR="ORCH CONTEXT "_ORXTAB      ; Construct formal param name.
 S ORXPNAM=ORXPAR                     ; Store for saving changes.
 ;
 ; Get current parameter values from Parameters file:
 S ORXCUR=""
 S ORXCUR=$$GET^XPAR("ALL",ORXPAR)
 ;
 Q
 ;
EXCX() ; Deal with exceptions in spelling.
 ;
 I ORXTAB="D/C SUMMARIES" S ORXTAB="SUMMRIES"     ; Shorter spelling.
 I ORXTAB="IMAGING" S ORXTAB="XRAYS"              ; IMAGING is XRAYS.
 I ORXTAB="INPATIENT LABS" S ORXTAB="INPT LABS"   ; Shorter spelling.
 I ORXTAB="OUTPATIENT LABS" S ORXTAB="OUTPT LABS" ; Shorter spelling.
 ;
 Q ORXTAB
 ;
 ;
 ; NOTES ON ENTRIES FOR THE FOLLOWING "TABS" TAG:
 ;    Each TABS entry MUST have a corresponding PROMPTS entry in
 ;    PROMPTS^ORXTABS, in the same order and with matching first
 ;    pieces.  There MUST ALSO be a tag in ORXTABS2, to get user
 ;    input, which matches the actual name of the parameter in the
 ;    Parameter Definition [^XTV(8989.51,] file.  For example, 
 ;    the NOTES entry in TABS below is the last word of the "ORCH 
 ;    CONTEXT NOTES" entry in the Parameter Definition file.  If 
 ;    the first piece listed in the TABS tag below differs from the 
 ;    actual Parameter Definition file entry - as is the case for
 ;    XRAYS, which is the IMAGING entry below - add code in the EXCX
 ;    tag above to deal with it.  The third "^" piece in each TABS 
 ;    entry represents the positions in the parameter string entry 
 ;    itself, i.e. in the Parameters [^XTV(8989.5,] file, where
 ;    each individual value is stored, in the order listed in the 
 ;    second "^" piece of the TABS entry.  IMPORTANT: Keep all "BEG" 
 ;    and "END" pairs together consecutively - with "BEG" first, and
 ;    all "STATUS" and "AUTHOR" pairs together - with "STATUS" first.
 ;
TABS ; Data strings for parameters/preferences.
 ;;CONSULTS^BEG;END;STATUS;SERVICE^1;2;3;4
 ;;INPATIENT LABS^BEG;END;TYPE^1;2;3
 ;;OUTPATIENT LABS^BEG;END;TYPE^1;2;3
 ;;MEDS^BEG;END;OUTPT^1;2;3
 ;;NOTES^BEG;END;STATUS;AUTHOR;OCCLIM;SUBJECT^1;2;3;4;5;6
 ;;ORDERS^BEG;END;STATUS;DISPGRP;FORMAT^1;2;3;4;5
 ;;PROBLEMS^STATUS;COMMENTS^3;4
 ;;REPORTS^BEG;END;MAX^1;2;5
 ;;D/C SUMMARIES^BEG;END;STATUS;AUTHOR^1;2;3;4
 ;;IMAGING^BEG;END;MAX^1;2;5
 ;
 Q
 ;
 ; NOTES ON ENTRIES FOR "PROMPTS" TAG:
 ;    Each PROMPTS entry below needs a corresponding TABS entry 
 ;    in TABS^ORXTABS, must be listed in the same order, and with 
 ;    a matching number of pieces.
 ;    
PROMPTS ; 24 char-max Prompts - MUST match TABS^ORXTABS entries/piece counts!
 ;;CONSULTS^Begin Date;End Date;Status;Service
 ;;INPATIENT LABS^Begin Date;End Date;Type
 ;;OUTPATIENT LABS^Begin Date;End Date;Type
 ;;MEDS^Begin Date;End Date;Outpatient or Inpatient Meds Default Display
 ;;NOTES^Begin Date;End Date;Status;Author;Occurrence Limit;Show/Hide Subject
 ;;ORDERS^Begin Date;End Date;Status;Service/Section;Format
 ;;PROBLEMS^Status;Comments
 ;;REPORTS^Begin Date;End Date;Maximum
 ;;D/C SUMMARIES^Begin Date;End Date;Status;Author
 ;;IMAGING^Begin Date;End Date;Maximum
 ;
 Q
 ;
