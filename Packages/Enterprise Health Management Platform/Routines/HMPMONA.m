HMPMONA ;asmr-ven/toad-dashboard: action prompts ;Aug 25, 2016 21:17:38
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526 - routine refactored, August 25, 2016
 ;
 ; PROMPT^HMPMONA issues the action prompts throughout the eHMP
 ; Dashboard. It is invoked by HMPMON, which is the main routine forthe eHMP Dashboard.
 ;
PROMPT(HMPACT,HMPROMPT) ; general action prompt
 ; called by:
 ;   OPTION
 ; calls:
 ;   $$PROMPTS^HMPMON = Dashboard's five main prompts
 ;   $$CODES = prompt's set-of-codes definition
 ;   $$TEXT = prompt's text
 ;   $$DEFAULT = prompt's default action
 ;   $$HELP = prompt's extended ?? help
 ;   EN^DDIOL: write to screen or output to an array
 ;   READ^HMPMONR: input from prompt or array, to issue action prompt
 ; input:
 ;   HMPROMPT = DASH or ERR or HIST or SYNC, default to DASH
 ; output:
 ;  HMPACT = Q to exit ehmp dashboard
 ;         = U? to update current screen
 ;         = S or E or H to switch prompts from dashboard prompt
 ;         = BD to return to dashboard prompt
 ;         = other action to do & remain at current prompt
 ; examples:
 ;   PROMPT(.action):
 ;      Dashboard Action Prompt issued to user
 ;      action = valid dashboard action code user selects (e.g., "U")
 ;   PROMPT(.action,"ERR"):
 ;      Error Action Prompt issued to user
 ;      action = valid error action code user selects (e.g., "E3")
 ;   PROMPT(.action,"SYNC"):
 ;      Sync-process Action Prompt issued to user
 ;      if user enters ^ or ^^
 ;      action = "Q"
 ;   PROMPT(.action,"HIST"):
 ;      History Action Prompt issued to user
 ;      if user times out
 ;      action = "Q"
 ;   PROMPT(.action,"NONSENSE"):
 ;      no prompt issued to user
 ;      action = "Q"
 ;
 S HMPACT="Q" ; default to exiting ehmp dashboard
 S HMPROMPT=$G(HMPROMPT,"DASH") ; default to dashboard
 Q:$$PROMPTS^HMPMON'[(U_HMPROMPT_U)  ; can't issue undefined prompt
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=$$CODES(HMPROMPT) ; set-of-codes
 S DIR("A")=$$TEXT(HMPROMPT) ; prompt text
 S DIR("B")=$$DEFAULT(HMPROMPT) ; prompt default (refresh or return)
 S X=$$HELP(HMPROMPT) ; prompt extended ?? help specification
 S:$L(X) DIR("??")=X  ; only if help set up
 S DIR("T")=HMPRATE ; set timeout to control auto-refresh rate
 ;
 D EN^DDIOL("",,"!") ; blank line for readability
 D ^DIR
 ;
 S:$D(DTOUT) Y=DIR("B")  ; for action prompts, timeout = default, creates auto-update
 ;
 I $D(DUOUT)!$D(DIROUT) S HMPACT="Q" Q  ; timeout or '^', exit
 S HMPACT=Y  ; action selected by user
 ;
 Q
 ;
 ;
CODES(HMPROMPT) ; prompt's set of codes
 ; called by:
 ;   PROMPT
 ; calls:
 ;   $$PROMPTS^HMPMON = Dashboard's five main prompts
 ;   $T(@(HMPROMPT_"CODE")^HMPMON) ; prompt record's header line
 ;   $$CODE = code definition
 ; input:
 ;   HMPROMPT = DASH or ERR or HIST or SYNC, default to DASH
 ; output = set-of-codes definition for prompt
 ; examples:
 ;   $$CODES = "SB^U:Update;V:View HMP Nodes;S:Sync Processes;E:E..."
 ;   $$CODES("HIST") = "SB^UH:Update History;EH:Examine History;M..."
 ;   $$CODES("NONSENSE") = ""
 ;
 set HMPROMPT=$G(HMPROMPT,"DASH") ; default to dashboard
 Q:$$PROMPTS^HMPMON'[(U_HMPROMPT_U) "" ; undefined prompt, no set
 ;
 new CODETAG set CODETAG=HMPROMPT_"CODE" ; label for code definitions
 new HEADER set HEADER=$T(@CODETAG^HMPMON) ; prompt record's header
 new TOTAL set TOTAL=$P(HEADER,";;",2) ; # codes
 ;
 new CODES set CODES=$$CODE(HMPROMPT) ; start w/ first code definition
 new COUNT ; count definitions
 F COUNT=2:1:TOTAL S CODES=CODES_";"_$$CODE(HMPROMPT,COUNT) ; append each code
 ;
 Q "SB^"_CODES ; return set of codes
 ;
 ;
CODE(HMPROMPT,IEN) ; code definition
 ; called by:
 ;   $$CODES
 ; calls:
 ;   $$PROMPTS^HMPMON = Dashboard's five main prompts
 ;   $T(@(HMPROMPT_"CODE")+IEN^HMPMON) = code's subentry
 ; input:
 ;   HMPROMPT = DASH or ERR or HIST or SYNC, default to DASH
 ;   IEN = sequence # of a code definition, defaults to 1
 ; output = that code definition
 ; examples:
 ;   $$CODE = "U:Update"
 ;   $$CODE("HIST") = "EH:Examine History"
 ;   $$CODE("SYNC",2) = "PS:Park Sync Process"
 ;   $$CODE("ERR",42) = ""
 ;   $$CODE("NONSENSE") = ""
 ;
 S HMPROMPT=$G(HMPROMPT,"DASH") ; default to dashboard
 Q:$$PROMPTS^HMPMON'[(U_HMPROMPT_U) "" ; unknown prompt, no code
 S IEN=$G(IEN,1) ; default to code #1
 ;
 N CODE,CODETAG,SUBENTRY
 S CODETAG=HMPROMPT_"CODE"  ; line tag for code definitions
 S SUBENTRY=$T(@CODETAG+IEN^HMPMON)  ; code subentry
 S CODE=$P(SUBENTRY,";",3)  ; code definition
 ;
 Q CODE  ; return code definition
 ;
 ;
TEXT(HMPROMPT) ; prompt text
 ; called by:
 ;   PROMPT
 ; calls:
 ;   $$PROMPTS^HMPMON = Dashboard's five main prompts
 ;   $T(@HMPROMPT^HMPMON) = prompt record's header line
 ; input:
 ;   HMPROMPT = DASH or ERR or HIST or SYNC, default to DASH
 ; output = text to insert in prompt text
 ; examples:
 ;   $$TEXT = "Dashboard"
 ;   $$TEXT("HIST") = "History"
 ;   $$TEXT("NONSENSE") = ""
 ;
 S HMPROMPT=$G(HMPROMPT,"DASH") ; default to dashboard
 Q:$$PROMPTS^HMPMON'[(U_HMPROMPT_U) "" ; undefined prompt, no text
 ;
 N HEADER,TEXT
 S HEADER=$T(@HMPROMPT^HMPMON) ; prompt's header line
 S TEXT=$P(HEADER,";",4) ; prompt text
 ;
 Q TEXT  ; return prompt text
 ;
 ;
DEFAULT(HMPROMPT) ; prompt default
 ; called by:
 ;   PROMPT
 ; calls:
 ;   $$PROMPTS^HMPMON = Dashboard's five main prompts
 ;   $T(@(HMPROMPT_"DEF")^HMPMON) ; default's pointer record
 ;   $T(@DEFTXT^HMPMON) ; default's $text
 ; input:
 ;   HMPROMPT = DASH or ERR or HIST or SYNC, default to DASH
 ; output = text of prompt's default action
 ; examples:
 ;   $$DEFAULT = "Update Dashboard"
 ;   $$DEFAULT("ERR") = "Update Error Screen"
 ;   $$DEFAULT("NONSENSE") = ""
 ;
 S HMPROMPT=$G(HMPROMPT,"DASH") ; default to dashboard
 Q:$$PROMPTS^HMPMON'[(U_HMPROMPT_U) "" ; undefined prompt, no def
 ;
 N DEFPREC,DEFTXT,DFLTAG
 S DFLTAG=HMPROMPT_"DEF" ; default's $text reference
 S DEFPREC=$T(@DFLTAG^HMPMON) ; default's $text from HMPMONM
 S DEFTXT=$P(DEFPREC,";",3) ; default's $text
 ;
 new DEFREC set DEFREC=$T(@DEFTXT^HMPMON) ; default's record
 new DEFDEF set DEFDEF=$P(DEFREC,";",3) ; default's definition
 new DEFAULT set DEFAULT=$P(DEFDEF,":",2) ; prompt's default
 ;
 Q DEFAULT ; return prompt default
 ;
 ;
HELP(HMPROMPT) ; function, prompt for extended ?? help
 ; called by:
 ;   PROMPT
 ; calls:
 ;   $$PROMPTS^HMPMON = Dashboard's five main prompts
 ;   $T(@(HMPROMPT_"HELP")^HMPMON) ; help's pointer record
 ; input:
 ;   HMPROMPT = DASH or ERR or HIST or SYNC, default to DASH
 ; output = routine extended ?? help
 ; examples:
 ;   $$TEXT = "^D DASHHELP^HMPMONDH"
 ;   $$TEXT("HIST") = ""
 ;   $$TEXT("NONSENSE") = ""
 ;
 S HMPROMPT=$G(HMPROMPT,"DASH") ; default to dashboard
 Q:$$PROMPTS^HMPMON'[(U_HMPROMPT_U) ""  ; unknown prompt, no help
 ;
 N DFLTAG,HELP,HLPLTAG
 S DFLTAG=HMPROMPT_"HELP" ; help's default line tag
 S HLPLTAG=$T(@DFLTAG^HMPMON)  ; help line tag
 S HELP=$P(HLPLTAG,";;",2)  ; ?? help specification
 ;
 Q HELP ; return prompt for extended "??" help
 ;
