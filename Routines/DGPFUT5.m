DGPFUT5 ;ALB/SAE - PRF UTILITIES CONTINUED ; 12/18/03 09:00pm
 ;;5.3;Registration;**554**;Aug 13, 1993
 ;
 Q  ; no direct entry
 ;
DISPLAY(TXN,DGPFGOUT) ; entry point for user-review screen
 ;
 ; This routine completes the re-display process.
 ; It re-displays information about the Flag, or Flag Assignment,
 ; being created or modified by the user, prior to the 'file' question.
 ;
 ; Input:
 ;   TXN - transaction - has several '^' pieces starting with:
 ;         FA - FLAG ASSIGNMENT - Assign Flag
 ;         FA - FLAG ASSIGNMENT - Edit Flag Assignment
 ;         FA - FLAG ASSIGNMENT - Change Assignment Ownership
 ;         FM - FLAG MANAGEMENT - Add New Record Flag
 ;         FM - FLAG MANAGEMENT - Edit Record Flag
 ;   DGPFGOUT - name of global ^TMP global used to display
 ;
 ; Output:
 ;   none - display to user only
 ; 
 ; Temporary variables:
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y ; DIR Reader variables
 ;
 F  D  I Y=0!$D(DUOUT)!$D(DTOUT) W ! Q
 . D DISP(TXN,DGPFGOUT)
 . W ! S DIR(0)="Y",DIR("A")="Do you want to review again"
 . S DIR("B")="NO" D ^DIR K DIR
 ;
 Q
 ;
DISP(TXN,DGPFGOUT) ; display user review screen(s):
 ; 
 ; Re-displays information about the Flag or Flag Assignment being
 ; created or modified.
 ;
 ; Input:
 ;   TXN - transaction - has several pieces starting with:
 ;         FA - FLAG ASSIGNMENT - Assign Flag
 ;         FA - FLAG ASSIGNMENT - Edit Flag Assignment
 ;         FA - FLAG ASSIGNMENT - Change Assignment Ownership
 ;         FM - FLAG MANAGEMENT - Add New Record Flag
 ;         FM - FLAG MANAGEMENT - Edit Record Flag
 ;   DGPFGOUT - name of global ^TMP global used to display
 ;
 ; Output:
 ;   none - display to user only
 ;
 ; Temporary variables:
 N DGPFQUIT ; quit variable for loop
 N DGPFCT   ; counter variable for loop
 N DGPFNEW    ; new page indicator
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y ; DIR Reader variables
 N DGPFHDR  ; used for new screens of word processing displays
 N DGPFTHIS ; value of current node
 ; DGPFTHIS("HEADER") ; this node in global array is a header
 N DGPFNEXT ; next node in global array
 N DGPFLAST ; prevents page feed and display of headers with no body
 N DGPFLINE ; line for underlining headers
 N DGPFPINV ; counter to control display of principal investigator label
 N DGPFPAD  ; pad for leading spaces
 N DGPFACT  ; ACTION as upper case
 ;
 S DGPFCT=0
 S DGPFACT=$TR($P(TXN,U,3),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S DGPFHDR("TOP")="REVIEW OF "_DGPFACT_" DATA INPUT BEFORE FILING"
 ;
 S DGPFLINE="",$P(DGPFLINE,"-",($L(DGPFHDR("TOP"))+1))=""
 S DGPFHDR("TOPLINE")=DGPFLINE
 S DGPFPINV=0
 ;
 W:$E(IOST,1,2)="C-" @IOF
 W DGPFHDR("TOP"),!,DGPFHDR("TOPLINE")
 F  S DGPFCT=$O(@DGPFGOUT@(DGPFCT)) Q:DGPFCT=""  D  Q:$D(DGPFQUIT)
 . K DGPFTHIS,DGPFNEXT
 . S DGPFTHIS=@DGPFGOUT@(DGPFCT,0)
 . S DGPFNEXT=$O(@DGPFGOUT@(DGPFCT))
 . S DGPFNEXT=$S(DGPFNEXT="":"",1:@DGPFGOUT@(DGPFNEXT,0))
 . S:$O(@DGPFGOUT@(DGPFCT))="" DGPFLAST=1
 . ;
 . I DGPFTHIS["Principal Investigator(s):" S DGPFPINV=DGPFPINV+1
 . I DGPFTHIS["Action Comments:" S DGPFTHIS("HEADER")=1
 . I DGPFTHIS["Flag Description:" S DGPFTHIS("HEADER")=1
 . I DGPFTHIS["Reason For Flag Enter/Edit:" S DGPFTHIS("HEADER")=1
 . I DGPFTHIS["Record Flag Assignment Narrative:" S DGPFTHIS("HEADER")=1
 . I DGPFNEXT["Action Comments:" S DGPFNEXT("HEADER")=1
 . I DGPFNEXT["Flag Description:" S DGPFNEXT("HEADER")=1
 . I DGPFNEXT["Reason For Flag Enter/Edit:" S DGPFNEXT("HEADER")=1
 . I DGPFNEXT["Record Flag Assignment Narrative:" S DGPFNEXT("HEADER")=1
 . I $D(DGPFTHIS("HEADER")) S DGPFHDR(1)=DGPFTHIS D
 . . S DGPFLINE=" ",$P(DGPFLINE,"-",($L(DGPFHDR(1))-1))=""
 . ;
 . ; if near the bottom, set new screen variable DGPFNEW
 . I $Y+9>IOSL I $D(DGPFTHIS("HEADER"))!($Y+6>IOSL) S DGPFNEW=1
 . I $D(DGPFNEW),'$D(DGPFLAST) D  Q
 . . K DGPFNEW W ! S DIR(0)="E" D ^DIR K DIR
 . . I $D(DUOUT)!$D(DTOUT) S DGPFQUIT=1 Q
 . . W:$E(IOST,1,2)="C-" @IOF
 . . W DGPFHDR("TOP"),!,DGPFHDR("TOPLINE")
 . . I $D(DGPFHDR(1)) D
 . . . I DGPFTHIS?1." ",$D(DGPFNEXT("HEADER")) Q
 . . . W !,DGPFHDR(1),!,DGPFLINE
 . . W:'$D(DGPFTHIS("HEADER")) !,DGPFTHIS
 . . I DGPFTHIS["Principal Investigator(s):" S DGPFPINV=1
 . W:$D(DGPFTHIS("HEADER")) !
 . ; remove label from Principal Investigator line if not first node
 . I DGPFTHIS["Principal Investigator(s):",DGPFPINV>1 D
 . . S DGPFPAD=$E($J("",27),1,27)
 . . S DGPFTHIS=DGPFPAD_$P(DGPFTHIS,":",2)
 . W !,DGPFTHIS
 . W:$D(DGPFTHIS("HEADER")) !,DGPFLINE
 W !
 ;
 Q
