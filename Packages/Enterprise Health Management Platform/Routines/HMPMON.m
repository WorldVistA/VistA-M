HMPMON ;asmr-ven/zag&toad-option hmpmon dashboard ;Aug 25, 2016 21:17:38
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526 - routine refactored, August 25, 2016
 ;
 ; HMPMON is the main routine for the eHMP Dashboard
 ; OPTION^HMPMON is the MenuMan entry point for option HMPMON DASHBOARD. 
 ; All other HMPMON* routines are invoked directly or indirectly from this routine;
 ; PROMPT^HMPMONA issues the action prompts throughout the Dashboard.
 ;
OPTION ; option eHMP Dashboard [HMPMON DASHBOARD]
 ;
 D HOME^%ZIS  ; set IO* variables
 ;
 N CALL,HMPACT,HMPNEWP,HMPRATE,HMPROMPT,HMPSRVR,HMPSUB
 ; line tag/routine to call
 ; HMPACT - user-selected action
 ; HMPNEWP - new prompt, indicates changing actions
 S HMPROMPT="DASH" ; Dashboard Action Prompt
 S HMPRATE=$$RATE^HMPMONC ; auto-update rate
 ;
 S HMPSRVR=$$GETSRVR^HMPMONM ; subscription server
 ; if there are NO subscriptions, display help and issue end-of-page prompt
 I 'HMPSRVR D NOSRVR^HMPMONM  Q
 ;
 N HMPEOP,USERCALL
 F  Q:HMPROMPT=U  D  ; option's main loop
 . S HMPSUB=$$GETSUB^HMPMONM(HMPSRVR) ; zero node from HMP SUBSCRIPTION
 . ; 1. run prompt's initial action
 . D  Q:HMPROMPT=U  ; if time-out or ^-escape from end-of-pages
 ..  S HMPACT=$$FIRST(HMPROMPT) ; get initial action
 ..  D FORMFEED^HMPMONL ; clear screen for initial action
 ..  S CALL=$$CALL(HMPACT) ; action's subroutine call
 ..  D @CALL ; perform initial action
 . ; 2. prompt user to select action
 . S HMPACT="" D PROMPT^HMPMONA(.HMPACT,HMPROMPT) ; prompt user for next action
 . Q:$E(HMPACT)="U"  ; update = initial action
 . ; 3. if action changes to a new prompt, do it
 . S HMPNEWP=$$NEWPRMPT(HMPACT) ; changing prompts?
 . I HMPNEWP'="" S HMPROMPT=HMPNEWP Q  ; change to new prompt and quit
 . ; 4. otherwise, perform user-selected action
 . S HMPEOP=1 ; default to prompting for end of page
 . S USERCALL=$$CALL(HMPACT) ; action's subroutine call
 . D @USERCALL ; perform user-selected action
 . ; 5. and prompt for end of page after action
 . D ENDPAGE^HMPMONL:HMPEOP
 ;
 Q
 ;
 ;
CALL(HMPACT) ; function, action's subroutine call
 ; called by:
 ;   OPTION
 ; input:
 ;   HMPACT = code for action (e.g., "ES")
 ; output = "" or label (eg "RATE") or entryref (eg "U^HMPMOND")
 ; examples:
 ;   $$CALL = ""
 ;   $$CALL("BD") = ""
 ;   $$CALL("ES") = "ES^HMPMONS"
 ;   $$CALL("M") = "DIFSUB"
 ;   $$CALL("NONSENSE") = ""
 ;
 ;A few actions call no subroutines to perform the action, most do. 
 ;Returns "" if the action does not call a subroutine or a line tag with optional routine.
 ;
 S HMPACT=$G(HMPACT,"U")  ; default to Update
 I $$CALLS'[(U_HMPACT_U) Q ""  ; not a calling action
 ;
 N ACTREC S ACTREC=$T(@HMPACT)  ; action's record
 Q $P(ACTREC,";",5)  ; return action's subroutine call
 ;
 ;
NEWPRMPT(HMPACT) ;function, action's new prompt
 ; called by:
 ;   OPTION
 ; calls: none
 ; input:
 ;   HMPACT = code for action (e.g., "ES")
 ; output = "" or DASH or ERR or HIST or SYNC or ^
 ; examples:
 ;   $$NEWPRMPT = ""
 ;   $$NEWPRMPT("U") = ""
 ;   $$NEWPRMPT("S") = "SYNC"
 ;   $$NEWPRMPT("BD") = "DASH"
 ;   $$NEWPRMPT("Q") = "^"
 ;   $$NEWPRMPT("NONSENSE") = ""
 ;
 ;Most actions leave the user on the same prompt selected, a few change prompts. 
 ;returns "" if action doesn't change prompts, name of the prompt if it does, or "^" if action exits the dashboard
 ;
 S HMPACT=$G(HMPACT,"U") ; default to Update
 Q:$$CHANGES'[(U_HMPACT_U) ""  ; not a prompt-changing action
 ;
 N ACTREC S ACTREC=$T(@HMPACT) ; action's record
 Q $P(ACTREC,";",4) ; return new prompt
 ;
 ;
FIRST(HMPROMPT) ; prompt's initial action
 ; called by:
 ;   OPTION
 ; calls: none
 ; input:
 ;   HMPROMPT = DASH or ERR or HIST or SYNC, default to DASH
 ; output = code for prompt's initial action
 ; examples:
 ;   $$FIRST = "U"
 ;   $$FIRST("ERR") = "UE"
 ;   $$FIRST("NONSENSE") = ""
 ;
 S HMPROMPT=$G(HMPROMPT,"DASH") ; default to dashboard
 Q:$$PROMPTS'[(U_HMPROMPT_U) "" ; no action for undefined prompt
 ;
 N ACTION,DEFREC,DEFREF
 S DEFREF=HMPROMPT_"DEF" ; default's reference
 S DEFREC=$T(@DEFREF) ; default's record
 S ACTION=$P(DEFREC,";",3) ; default action (& first)
 ;
 Q ACTION ; return prompt's initial action ; end of $$FIRST
 ;
PROMPTS() ;
 Q "^DASH^SYNC^ERR^HIST^UNIT^"
 ;
ACTIONS() ;
 Q "^U^V^J^S^E^H^C^M^Q^US^ES^PS^RS^BD^UE^E2^E3^E4^E5^UH^EH^MH^UU^"
 ;
CALLS() ;
 Q "^U^V^J^C^M^US^ES^PS^RS^UE^E2^E3^E4^E5^UH^EH^MH^UU^"
 ;
CHANGES() ;
 Q "^S^E^H^Q^BD^"
 ;
DASH ;;HMP MON DASH ACTION;Select Dashboard Action
DASHHELP ;;^D DASHHELP^HMPMONDH
DASHDEF ;;U
DASHCODE ;;9
U ;;U:Update Dashboard;;U^HMPMOND
V ;;V:View HMP Nodes;;V^HMPMONV
J ;;J:Job Listing;;J^HMPMONJ
S ;;S:Sync Processes;SYNC;
E ;;E:Errors;ERR;
H ;;H:History;HIST;
C ;;C:Change Auto-update Rate;;C^HMPMONC
M ;;M:Monitor a Different Server;;M^HMPMONM
Q ;;Q:Quit;^;
 ;
SYNC ;;HMP MON SYNC ACTION;Select Sync-process Action
SYNCHELP ;;^do SYNCHELP^HMPMONSH
SYNCDEF ;;US
SYNCCODE ;;5
US ;;US:Update Sync-process Screen;;US^HMPMONS
ES ;;ES:Examine Sync Process;;ES^HMPMONS
PS ;;PS:Park Sync Process;;PS^HMPMONS
RS ;;RS:Restart Sync Process;;RS^HMPMONS
BD ;;BD:Back to Dashboard;DASH;
 ;
ERR ;;HMP MON ERR ACTION;Select Error Action
ERRHELP ;;^do ERRHELP^HMPMONEH
ERRDEF ;;UE
ERRCODE ;;8
UE ;;UE:Update Error Screen;;UE^HMPMONE
E2 ;;E2:Examine XTMP Error Log;;E2^HMPMONE
E3 ;;E3:Examine HMPERR Error Log;;E3^HMPMONE
E4 ;;E4:Examine HMPFERR Error Log;;E4^HMPMONE
E5 ;;E5:Examine HMP ERROR Error Log;;E5^HMPMONE
 ;;BD:Back to Dashboard;DASH;
 ;
 ;ME ;;ME:Manage Error Log;;ME^HMPMONE   ; removed
 ;
HIST ;;HMP MON HIST ACTION;Select History Action
HISTHELP ;;^D HISTHELP^HMPMONHH
HISTDEF ;;UH
HISTCODE ;;4
UH ;;UH:Update History Screen;;UH^HMPMONH
EH ;;EH:Examine History;;EH^HMPMONH
MH ;;MH:Manage History;;MH^HMPMONH
 ;;BD:Back to Dashboard;DASH;
 ;
