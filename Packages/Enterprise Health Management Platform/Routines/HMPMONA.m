HMPMONA ;ASMR/BL, eHMP monitor action prompts ;Sep 13, 2016 20:03:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526, DE6644 - routine refactored, 25 August 2016
 ; this routine contains Action to support the calls to ^DIR
PROMPT(HMPACT,HMPROMPT) ; issues the action prompts throughout the eHMP Monitor
 ; Invoked by OPTION^HMPMON
 ; input:
 ;   HMPROMPT = MNTR or ERR or HIST or SYNC, default to MNTR
 ; output:
 ;  HMPACT - user-selected prompt, passed by reference
 ;
 S HMPROMPT=$G(HMPROMPT,"MNTR") ; default to monitor
 I $$PROMPTS^HMPMONR'[(U_HMPROMPT_U) D  Q  ; can't issue undefined prompt
 . W !!,"Invalid prompt default detected, cannot continue.",!
 . D RTRN2CON^HMPMONL
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=$$CODES(HMPROMPT) ; set-of-codes
 S DIR("A")=$P(HMPCALLS(U,"DIR","text",HMPROMPT),";",2)  ; prompt text
 S X=$G(HMPMNTR("default")) S:$L(X) DIR("B")=X  ; prompt default
 S X=$G(HMPCALLS(U,"DIR","?",HMPROMPT))  ; extended ?? help specification
 S:$L(X) DIR("?")=X  ; only if help set up
 S DIR("T")=HMPRATE ; set timeout to control auto-refresh rate
 W !  ; skip a line for readability
 D ^DIR
 ;
 S:$D(DTOUT) Y=DIR("B")  ; for action prompts, timeout = default, creates auto-update
 I $D(DUOUT)!$D(DIROUT) Q  ; timeout or '^', exit
 S HMPACT=Y  ; action selected by user returned
 ;
 Q
 ;
CODES(HMPROMPT) ; prompt's set of codes to be used in ^DIR
 ; called by:
 ;   PROMPT
 ; calls:
 ;   $$PROMPTS^HMPMON = Monitor's main prompts
 ;   $T(@(HMPROMPT_"CODE")^HMPMON) ; prompt record's header line
 ;   $$CODE = code definition
 ; input:
 ;   HMPROMPT = MNTR or ERR or HIST or SYNC, default to MNTR
 ; output = set-of-codes definition for prompt
 ; examples:
 ;   $$CODES = "SB^U:Update;V:View HMP Nodes;S:Sync Processes;E:E..."
 ;   $$CODES("HIST") = "SB^UH:Update History;EH:Examine History;M..."
 ;   $$CODES("NONSENSE") = ""
 ;
 N C,CODES,X,Y
 S HMPROMPT=$G(HMPROMPT,"MNTR") ; default to monitor
 Q:$$PROMPTS^HMPMONR'[(U_HMPROMPT_U) "" ; undefined prompt return null
 ; go through list of ^DIR calls and set it up for this monitor screen
 S CODES="",C=0,X="" F  S X=$O(HMPCALLS(U,"DIR",HMPROMPT,X)) Q:X=""  D
 . S:$G(HMPCALLS(U,"DIR",HMPROMPT,X,"default")) HMPMNTR("default")=X
 . S Y=$G(HMPCALLS(X)) S:$L(Y) C=C+1,$P(CODES,";",C)=X_":"_$P(Y,";")
 ; S - is set of codes, B indicates horizontal list of prompts
 Q "SB^"_CODES
 ;
