TIUPRF1 ; SLC/JMH - Modules for Patient Record Flags ; 1/9/06
 ;;1.0;TEXT INTEGRATION UTILITIES;**184**;Jun 20, 1997
 ;
SELECT(TIUTTL,DFN,TIUDA) ; Select flag action for VISTA
 ;Requires:
 ;   TIUTTL - 8925.1 IEN
 ;   DFN - Patient IEN
 ;Optional:
 ;   TIUDA - Note IEN: If user picks the link that TIUDA is already
 ;                     linked to, question the pick
 ;Returns:
 ;   PRFAssignmentIEN^PRFAssignmentHistoryIEN or
 ;   0^msg         ;
 ; LINEOK = Line of action selected by user
 ; TIUAGN = 2 if note TIUDA is already linked to selected action
 ; TIUAGN = 1 if Assignment History IEN selected by user already has
 ;              another note linked to it
 N TIUDG,TIUER,TIURET,TIUAGN,LKBLARR
 N FLAGNM,HASFLAG,AVAIL,LINKBL,UNLINKBL,TIUJ
 S TIUAGN=0,HASFLAG=1
 S FLAGNM=$$FNDFLAG^TIUPRFL(TIUTTL)
 I 'FLAGNM S HASFLAG=0
 S FLAGNM=$S(HASFLAG:$P(FLAGNM,U,2),1:"UNKNOWN")
 S TIUDG=$$GETHTIU^DGPFAPI1(DFN,+$G(TIUTTL),"^TMP(""TIUPRFH"",$J)")
 F  D  Q:'TIUAGN
 . I 'TIUAGN W !!,"This Note must be linked to Patient Record Flag:",!,"        ",FLAGNM,!,"  Checking for available Flag Actions...",!
 . I 'TIUDG S TIURET="0^"_$P(TIUDG,U,2) D  Q
 . . W !,$P(TIUDG,U,2),"!",!
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S AVAIL=$$AVAILACT^TIUPRFL("^TMP(""TIUPRFH"",$J)",.LINKBL,.UNLINKBL)
 . I 'AVAIL D  Q
 . . S TIURET="0^All linked"
 . . W !,"All linkable Flag actions for this Patient and Title are already linked!",!
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . I TIUAGN=1 W "  ?? This action already has a note linked to it.",! S TIUAGN=0
 . I TIUAGN=2 W "  ?? The note is already linked to this action.",! S TIUAGN=0
 . ; -- If flag assgnmt array has unlinkable actions, omit them and set
 . ;    a new arr starting subscript at 1:
 . I UNLINKBL D  S LKBLARR="^TMP(""TIUPRFLKBL"",$J)"
 . . F TIUJ=1:1:LINKBL M ^TMP("TIUPRFLKBL",$J,"HISTORY",TIUJ)=^TMP("TIUPRFH",$J,"HISTORY",TIUJ+UNLINKBL)
 . I 'UNLINKBL S LKBLARR="^TMP(""TIUPRFH"",$J)"
 . ; Display all linkable actions and prompt user to select one:
 . W !,"Please select a Patient Record Flag Assignment Action: "
 . W !,?7,"Date",?27,"Action",?52,"Note"
 . S (TIUER,LINEOK)=0
 . ; -- Display the flag actions and ask for choice in BREAK
 . F LINENO=1:1:LINKBL D  Q:+TIUER!+LINEOK
 . . D WRITE(LINENO) I '(LINENO#5) D BREAK(LINENO,LINKBL,.TIUER,.LINEOK)
 . I LINENO#5 D BREAK(LINENO,LINKBL,.TIUER,.LINEOK)
 . ; -- Check if user ^ out
 . I TIUER S TIURET="0^USER EXITED" Q
 . S TIURET=+^TMP("TIUPRFH",$J,"ASSIGNIEN")_U_+@LKBLARR@("HISTORY",LINEOK,"HISTIEN")
 . ; -- If action already has a note linked to it, try again:
 . I +$G(TIUDA),+@LKBLARR@("HISTORY",LINEOK,"TIUIEN")=$G(TIUDA) S TIUAGN=2 Q
 . I @LKBLARR@("HISTORY",LINEOK,"TIUIEN") S TIUAGN=1 Q
SELECTQ K ^TMP("TIUPRFH",$J),^TMP("TIUPRFLKBL",$J)
 Q TIURET
 ;
BREAK(LINENO,LINKBL,TIUER,LINEOK) ; Handle prompting
 N TIUX,MORE
 S MORE=$S(LINKBL>LINENO:1,1:0)
BREAK1 ;
 W !,"CHOOSE 1-",LINENO
 I MORE W !,"<RETURN> TO CONTINUE",!,"OR '^' TO QUIT"
 W ": " R TIUX:DTIME
 I $S('$T!(TIUX["^"):1,TIUX=""&'MORE:1,1:0) S TIUER=1 Q
 I TIUX="" Q
 I TIUX'=+TIUX!'$D(@LKBLARR@("HISTORY",+TIUX)) W !!,$C(7),"INVALID RESPONSE",! G BREAK1
 S LINEOK=TIUX
 Q
 ;
WRITE(LINENO) ; write the selectable item
 ; Uses LKBLARR
 N TIUX,TIUIEN,TIUAHIST,REFDT
 S TIUX=$P($G(@LKBLARR@("HISTORY",LINENO,"DATETIME")),U)
 W !,?2,LINENO,">",?7,$$FMTE^XLFDT(TIUX,"2D")
 W ?27,$P(@LKBLARR@("HISTORY",LINENO,"ACTION"),U,2),?52
 S TIUIEN=+@LKBLARR@("HISTORY",LINENO,"TIUIEN")
 S TIUAHIST=+@LKBLARR@("HISTORY",LINENO,"HISTIEN")
 I TIUIEN S REFDT=+$G(^TIU(8925,TIUIEN,13)),REFDT=$$DATE^TIULS(REFDT,"MM/DD/YY HR:MIN") W REFDT
 Q
 ;
LINK(TIUDA,ASSGNDA,ACTDA,DFN) ;links a note to a flag assignment action
 ;for patient DFN.
 ; Returns 1 if successful otherwise 0^"error message"
 N TIUTTL
 S TIUTTL=+$G(^TIU(8925,TIUDA,0))
 I 'TIUTTL Q "0^Document does not exist"
 ; -- GUI doesn't link if we check if TIUDA is PRF note, so don't
 ;I '$$ISPFTTL^TIUPRFL(TIUTTL) Q "0^Can't link non-PRF notes"
 S TIURES=$$STOTIU^DGPFAPI2(DFN,ASSGNDA,ACTDA,TIUDA)
 I 'TIURES Q TIURES
 Q 1
UNLINK(TIUDA) ;removes any link the note TIUDA might have
 N TIUTTL
 S TIUTTL=+$G(^TIU(8925,TIUDA,0))
 I 'TIUTTL Q
 S TIURES=$$DELTIU^DGPFAPI2(TIUDA)
 Q
RELINK(TIUDA,DFN) ; removes old link for TIUDA and links to new PRF assignment for patient DFN
 ; returns 1 if successful otherwise 0^"error message"
 N TIUPRF,TIUTTL,TIUASS,TIUACT,TIURES
 S TIUTTL=+$G(^TIU(8925,TIUDA,0))
 S TIUPRF=$$SELECT(TIUTTL,DFN,TIUDA)
 I '+TIUPRF Q TIUPRF
 S TIUASS=+TIUPRF,TIUACT=$P(TIUPRF,U,2)
 D UNLINK(TIUDA)
 S TIURES=$$LINK^TIUPRF1(TIUDA,TIUASS,TIUACT,DFN)
 Q 1
 ;
CHANGE(TIUDA) ; removes old link for TIUDA and links to new PRF assignment for TIUDA's patient
 N DFN,TIUTTL,TIUPRF
 S DFN=$P($G(^TIU(8925,TIUDA,0)),U,2)
 S TIUTTL=+$G(^TIU(8925,TIUDA,0))
 S TIUPRF=$$SELECT(TIUTTL,DFN,TIUDA)
 I '+TIUPRF W !,"You must select an action ... Nothing (re)-linked." S TIUPOP=1 Q
 S TIUASS=+TIUPRF,TIUACT=$P(TIUPRF,U,2)
 D UNLINK(TIUDA)
 S TIUPRF=$$LINK(TIUDA,TIUASS,TIUACT,DFN)
 I '+TIUPRF S TIUPOP=1 Q
 Q
 ;
PRFCT(TIUOTTL,TIUNTTL,TIUDA) ; handles changing title situations for PRF notes in LM
 N NEWISPRF,DFN,TIULINK,TIULINKC,OLDISPRF
 S DFN=$P($G(^TIU(8925,TIUDA,0)),U,2)
 S NEWISPRF=$$ISPFTTL^TIUPRFL(TIUNTTL)
 S OLDISPRF=$$ISPFTTL^TIUPRFL(TIUOTTL)
 ;-- non PRF title to PRF title
 I NEWISPRF,'OLDISPRF D  Q
 . W !,"The Title you selected is a PRF Title."
 . W !,"  PRF Notes must be linked to Patient Record Flags.",!
 . W !,"Do you want to continue with this Change Title Action?"
 . I +$$READ^TIUU("YO",,"N")'>0 S TIUQUIT=1 W !,"Title not changed." Q
 . S TIULINK=$$SELECT^TIUPRF1(TIUNTTL,DFN)
 . I 'TIULINK S TIUQUIT=1 W !,"Title not changed." Q
 . ; -- get new link
 . S TIULINKC=$$LINK^TIUPRF1(TIUDA,+TIULINK,$P(TIULINK,U,2),DFN)
 ;-- PRF title to PRF title
 I NEWISPRF,OLDISPRF D  Q
 . W !,"This document is already attached to a Patient Record"
 . W !,"  Flag. It will be unlinked from the current flag"
 . W !,"  and linked to a new flag.",!
 . W !,"Do you want to continue with this Change Title Action?"
 . I +$$READ^TIUU("YO",,"N")'>0 S TIUQUIT=1 W !,"Title not changed." Q
 . ; -- get new PRF Assignment to link to
 . S TIULINK=$$SELECT^TIUPRF1(TIUNTTL,DFN)
 . I 'TIULINK S TIUQUIT=1 W !,"Title not changed." Q
 . D UNLINK^TIUPRF1(+TIUDA)
 . S TIULINKC=$$LINK^TIUPRF1(TIUDA,+TIULINK,$P(TIULINK,U,2),DFN)
 ; -- PRF title to non PRF title
 I 'NEWISPRF,OLDISPRF D  Q
 . W !,"The Title you selected is not a PRF Title."
 . W !,"  The note is currently linked to a Patient Record Flag,"
 . W !,"  but will be unlinked when the title is changed"
 . W !,"  to a non-PRF Title.",!
 . W !,"Do you want to continue with this Change Title Action?"
 . I +$$READ^TIUU("YO",,"N")'>0 S TIUQUIT=1 W !,"Title not changed." Q
 . D UNLINK^TIUPRF1(+TIUDA)
 Q
 ;
GETLINK(TIUTYP,DFN,TIUDA) ; Ask user for link for NEW note and link it. Return success or failure
 N TIUPRF,TIUPRFL
 S TIUPRF=$$SELECT^TIUPRF1(TIUTYP,DFN)
 I 'TIUPRF W !,"Patient Record Flag Notes must be linked to Flag Actions.",! Q 0
 S TIUPRFL=$$LINK^TIUPRF1(TIUDA,$P(TIUPRF,U,1),$P(TIUPRF,U,2),DFN)
 I 'TIUPRFL W !,$P(TIUPRFL,U,2),! Q 0
 Q 1
