SCAPMC33  ;BP/DJB - Get Provider Array For a Pt Tm Pos ; 5/24/99 12:39pm
 ;;5.3;Scheduling;**177**;May 01, 1999
 ;
PRPTTP(PTTMPOS,SCDATES,SCLIST,SCERR,SCALLHIS,ADJDATE) ;Get provider array for
 ;a Patient Team Position Assignment (#404.43).
 ;
 ; Input:
 ;          PTTMPOS - Pointer to entry in PATIENT TEAM POSITION
 ;                    ASSIGNMENT file (#404.43).
 ; SCDATES("BEGIN") - Begin date to search (inclusive).
 ;                    Default 1=Assign Date field in file 404.43.
 ;                    Default 2=DT
 ;          ("END"  - End date to search (inclusive).
 ;                    Default 1=Unassign Date field in file 404.43.
 ;                    Default 2=DT
 ;         ("INCL") - 1: Only use pracitioners who were on
 ;                       team for entire date range
 ;                    0: Anytime in date range.
 ;                    Default=1.
 ;           SCLIST - Array name to store returned data.
 ;            SCERR - Array name to store error messages.
 ;                    Ex: ^TMP("ORXX",$J).
 ;         SCALLHIS - 1: Return unfiltered sub-array in SCLIST
 ;          ADJDATE - 1: Adjust Start/End dates of provider so they
 ;                       don't exceed Assign/Unassign dates of Patient
 ;                       Team Position Assignment.
 ;Output:
 ;         SCLIST() - Array of practitioners. See PRTP^SCAPMC8
 ;          SCERR() - Array of error msg. See PRTP^SCAPMC8
 ;Returned: 1 if ok, 0 if error
 ;
 ;Declare variables
 NEW EDATE,ND,OK,SDATE,TMPOSPTR
 ;
 ;Initialize variables
 S OK=0
 I $D(SCERR) KILL @SCERR
 ;
 ;Check input
 I '$G(PTTMPOS) G QUIT
 I '$D(^SCPT(404.43,PTTMPOS,0)) G QUIT
 ;
 ;Get data
 S ND=$G(^SCPT(404.43,PTTMPOS,0)) ;Zero node of 404.43
 S TMPOSPTR=$P(ND,U,2) ;...........Team Position IEN
 I 'TMPOSPTR G QUIT
 S SDATE=$P(ND,U,3) ;..............Assigned Date
 S EDATE=$P(ND,U,4) ;..............Unassigned Date
 ;
 S OK=$$ADJUST1(SDATE,EDATE)
 G:'OK QUIT
 S OK=$$PRTP^SCAPMC(TMPOSPTR,.SCDATES,.SCLIST,.SCERR,1,.SCALLHIS)
 G:'OK QUIT
 G:'$D(SCLIST(0)) QUIT
 ;
 I $G(ADJDATE) D ADJUST2 ;Adjust Start/End Dates.
 ;
QUIT Q OK
 ;
ADJUST1(SDATE,EDATE) ;Adjust SCDATES to Assign/Unassign Dates in 404.43.
 ;
 NEW OK
 S OK=0
 ;
 ;Set defaults
 I '$G(@SCDATES@("BEGIN")) S @SCDATES@("BEGIN")=SDATE
 I '$G(@SCDATES@("END")) S @SCDATES@("END")=EDATE
 I '@SCDATES@("BEGIN") S @SCDATES@("BEGIN")=DT
 I '@SCDATES@("END") S @SCDATES@("END")=DT
 ;
 ;Quit if requested date range is outside of 404.43 date range.
 I SDATE,@SCDATES@("END")<SDATE G ADJQUIT
 I EDATE,@SCDATES@("BEGIN")>EDATE G ADJQUIT
 ;
 ;Adjust requested date range if it is wider than 404.43 date range.
 I SDATE>@SCDATES@("BEGIN") S @SCDATES@("BEGIN")=SDATE
 I EDATE,@SCDATES@("END")>EDATE S @SCDATES@("END")=EDATE
 S OK=1
ADJQUIT Q OK
 ;
ADJUST2 ;Adjust Assigned/Unassigned Dates in SCLIST array so they don't
 ;exceed requested date range..
 ;
 NEW DATA,POSH,PREH
 Q:'$D(@SCLIST)
 ;
 ;Position History
 S POSH=0
 F  S POSH=$O(@SCLIST@(POSH)) Q:'POSH  D  ;
 . S DATA=$G(@SCLIST@(POSH))
 . ;
 . ;Adjust Begin Date
 . I $P(DATA,U,9)<@SCDATES@("BEGIN") D  ;
 . . ;Update main node
 . . S $P(@SCLIST@(POSH),U,9)=@SCDATES@("BEGIN")
 . . ;
 . . ;Update "SCPR" node
 . . K @SCLIST@("SCPR",$P(DATA,U,1),$P(DATA,U,3),$P(DATA,U,9),POSH)
 . . S @SCLIST@("SCPR",$P(DATA,U,1),$P(DATA,U,3),@SCDATES@("BEGIN"),POSH)=""
 . ;
 . ;Adjust End Date
 . I $P(DATA,U,10)>@SCDATES@("END") D  ;
 . . S $P(@SCLIST@(POSH),U,10)=@SCDATES@("END")
 . ;
 . ;Preceptor History
 . S PREH=0
 . F  S PREH=$O(@SCLIST@(POSH,"PR",PREH)) Q:'PREH  D  ;
 . . S DATA=$G(@SCLIST@(POSH,"PR",PREH))
 . . ;
 . . ;Adjust Begin Date
 . . I $P(DATA,U,9)<@SCDATES@("BEGIN") D  ;
 . . . ;Update "PR" node
 . . . S $P(@SCLIST@(POSH,"PR",PREH),U,9)=@SCDATES@("BEGIN")
 . . . ;Update "SCPR" node
 . . . K @SCLIST@(POSH,"SCPR",$P(DATA,U,1),$P(DATA,U,3),$P(DATA,U,9),PREH)
 . . . S @SCLIST@(POSH,"SCPR",$P(DATA,U,1),$P(DATA,U,3),@SCDATES@("BEGIN"),PREH)=""
 . . ;
 . . ;Adjust End Date
 . . I $P($G(@SCLIST@(POSH,"PR",PREH)),U,10)>@SCDATES@("END") D  ;
 . . . S $P(@SCLIST@(POSH,"PR",PREH),U,10)=@SCDATES@("END")
 Q
