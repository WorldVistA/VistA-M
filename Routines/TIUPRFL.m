TIUPRFL ; SLC/JMH - Library Functions for Patient Record Flags ;1/26/06
 ;;1.0;TEXT INTEGRATION UTILITIES;**184**;Jun 20, 1997
 ;
 ;External References
 ;IA #4383
 ;$$FNDTITLE^DGPFAPI1
 ;$$GETHTIU^DGPFAPI1
 ;$$GETLINK^DGPFAPI1
AVAILACT(ARRAYNM,LINKBL,UNLINKBL,ONEIEN) ;Returns the # of unlinked,
 ;linkable actions.
 ; Note: Entered in Error (EIE) actions are not linkable,
 ;nor actions taken BEFORE an EIE action.
 ; ARRAYNM - Requires that $$GETHTIU^DGPFAPI1(DFN,TIUTTL,ARRAYNM)
 ;           has just been called for given flag title
 ;           and given patient.
 ; LINKBL - optional, passed by ref, returns
 ;          # of linkable actions in array ARRAYNM
 ; UNLINKBL - optional array, passed by ref, returns
 ;    UNLINKBL - # of unlinkable actions in ARRAYNM
 ;    UNLINKBL(ActID)=1, for each unlinkable action,
 ;            where ActID is action subscript in ARRAYNM
 ; ONEIEN - optional, passed by ref, returns
 ;          the action IEN (NOT subscript) if there is
 ;          exactly one available action
 ; AVAIL - Return value of function, returns
 ;         # of unlinked, linkable actions in ARRAYNM
 N ACTID,AVAIL,HASERR,ACTIEN
 S (ACTID,AVAIL,ONEIEN,LINKBL,UNLINKBL)=0
 S HASERR=$$HASERR(ARRAYNM)
 F  S ACTID=$O(@ARRAYNM@("HISTORY",ACTID)) Q:'ACTID  D
 . ; -- Set UNLINKBL whether linked or not:
 . I ACTID=+HASERR S UNLINKBL(ACTID)=1,UNLINKBL=UNLINKBL+1 Q
 . I $G(HASERR),$$ISERR(ARRAYNM,ACTID,$P(HASERR,U,2)) S UNLINKBL(ACTID)=1,UNLINKBL=UNLINKBL+1 Q
 . ; -- If not unlinkable, set LINKBL & check if already linked:
 . S LINKBL=LINKBL+1
 . I $G(@ARRAYNM@("HISTORY",ACTID,"TIUIEN")) Q
 . S AVAIL=AVAIL+1
 . S ACTIEN=+$G(@ARRAYNM@("HISTORY",ACTID,"HISTIEN"))
 I AVAIL=1,$G(ACTIEN)>0 S ONEIEN=ACTIEN
 Q AVAIL
 ;
ISPFTTL(TITLEDA) ; FUNCTION returns 1 if TITLEDA
 ;is PRF Title, otherwise returns 0
 ;Note ISPFTTL is spelled with PF, NOT PRF
 ; Cf RPC ISPRFTTL^TIUPRF2  - spelled with PRF
 N TIUCAT1,TIUCAT2,TIUDADDA
 S TIUDADDA=""
 S TIUCAT1=+$$DDEFIEN^TIUFLF7("PATIENT RECORD FLAG CAT I","DC")
 S TIUCAT2=+$$DDEFIEN^TIUFLF7("PATIENT RECORD FLAG CAT II","DC")
 S TIUDADDA=$O(^TIU(8925.1,"AD",TITLEDA,TIUDADDA))
 I TIUDADDA=TIUCAT1!(TIUDADDA=TIUCAT2) Q 1
 Q 0
 ;
ISPFDC(DCLASSDA) ; FUNCTION returns 1 if DCLASSDA
 ;is PRF Document Class, otherwise returns 0
 ; Requires valid IEN in 8925.1
 N TIUCAT1,TIUCAT2
 S TIUCAT1=+$$DDEFIEN^TIUFLF7("PATIENT RECORD FLAG CAT I","DC")
 S TIUCAT2=+$$DDEFIEN^TIUFLF7("PATIENT RECORD FLAG CAT II","DC")
 I (DCLASSDA=TIUCAT1)!(DCLASSDA=TIUCAT2) Q 1
 Q 0
 ;
FNDACTIF(TIUDA) ;Find Action Info for Note TIUDA
 ;Returns AssignIEN^ActionIEN^ActionNumber or
 ;0^"error message" if not linked, where
 ; Action IEN is Assignment History IEN and
 ; Action ID is node from GETHTIU^DGPFAPI1 array
 ; Note: for Action IEN ONLY, use $$GETLINK^DGPFAPI1(TIUDA)
 N ACTID,TIUTTL,TIURET,DFN
 S ACTID=0,TIURET=0
 S DFN=$P($G(^TIU(8925,TIUDA,0)),U,2)
 S TIUTTL=+$G(^TIU(8925,TIUDA,0))
 S TIURET=$$GETHTIU^DGPFAPI1(DFN,TIUTTL,"^TMP(""TIUPRF"",$J)")
 I '+TIURET Q TIURET
 F  S ACTID=$O(^TMP("TIUPRF",$J,"HISTORY",ACTID)) Q:'ACTID  D
 . I +$G(^TMP("TIUPRF",$J,"HISTORY",ACTID,"TIUIEN"))=TIUDA D
 . . S TIURET=+^TMP("TIUPRF",$J,"ASSIGNIEN")_U_+^TMP("TIUPRF",$J,"HISTORY",ACTID,"HISTIEN")_U_ACTID
 K ^TMP("TIUPRF",$J)
 Q TIURET
 ;
FNDFLAG(TIUTITLE) ; Find Associated Flag IEN for Title
 ;Function returns VarPTRFlagIEN^FlagName or
 ;0^msg
 ;from Flag file 26.15 (National) or 26.11 (Local)
 ;Example: 1;DGPF(26.15,^BEHAVIORAL]
 I '$L($T(FNDTITLE^DGPFAPI1)) Q "?"
 Q $$FNDTITLE^DGPFAPI1(TIUTITLE)
 ;
CFLDFLAG(TIUTITLE) ; Code for computed field PRFFLAG in file 8925.1
 ; Returns FlagName from file 26.11 or 26.15 for flag associated
 ;with TIUTITLE
 ; Returns ? if no flag is assoc w/ title or flag cannot be found
 ; Returns NA if TIUTITLE is not a PRF title
 ; Requires TITTITLE = 8925.1 IEN
 N FLAGINFO
 I '$$ISPFTTL(TIUTITLE) Q "NA"
 S FLAGINFO=$$FNDFLAG(TIUTITLE)
 I 'FLAGINFO Q "?"
 Q $P(FLAGINFO,U,2)
 ;
CFLDACT(NOTEDA) ; Code for computed field PRF FLAG ACTION in file 8925
 ; Returns: Date of Linked Action[space]Name of Action
 ;for action NOTEDA is linked to.
 N TIUTTL,LINE,TIULINK,DFN,ACTINFO,TIUDG,ACTID,ACTDATE,ACTNAME,TIUNODE0
 S TIUNODE0=^TIU(8925,NOTEDA,0),TIUTTL=$P(TIUNODE0,U)
 S TIULINK=$$GETLINK^DGPFAPI1(NOTEDA)
 I 'TIULINK,'$$ISPFTTL(TIUTTL) Q "NA"
 I 'TIULINK Q "?"
 S DFN=$P(TIUNODE0,U,2)
 S ACTINFO=$$FNDACTIF^TIUPRFL(NOTEDA)
 S ACTID=+$P(ACTINFO,U,3)
 ; -- If not PRF note but has link by mistake, return ? instead of NA:
 I 'ACTID Q "?" ; Title not linked to flag
 S TIUDG=$$GETHTIU^DGPFAPI1(DFN,TIUTTL,"^TMP(""TIUPRF"",$J)")
 S ACTDATE=$P(^TMP("TIUPRF",$J,"HISTORY",ACTID,"DATETIME"),U)
 S ACTDATE=$$FMTE^XLFDT(ACTDATE,"2D")
 S ACTNAME=$P(^TMP("TIUPRF",$J,"HISTORY",ACTID,"ACTION"),U,2)
 S LINE=ACTDATE_" "_ACTNAME
 K ^TMP("TIUPRF",$J)
 Q LINE
 ;
ISERR(ARRAYNM,ACTID,REACTDTM) ; Is Flag Action erroneous?
 ; Actions that take place BEFORE an EIE action are ERRONEOUS
 ;An EIE action itself is NOT erroneous
 ; Should be called AFTER HASERR, & only if HASERR>0
 ; Returns: 1 if Action date/time of ACTID is strictly BEFORE
 ;            the Entered in Error date/time
 ;          0 if = or AFTER the Entered in Error date/time
 ;         -1^msg if error
 ; Requires that $$GETHTIU^DGPFAPI1(DFN,TIUTTL,ARRAYNM) has just been
 ;called, and array named ARRAYNM currently exists for title
 ;assoc w/ flag and for given patient.
 ;Requires ARRAYNM
 ;Requires ACTID - subscript preceding "ACTION" in above array
 ;Requires REACTDTM as set in HASERR.
 N ISERR,ACTDTM S ISERR=0
 S ACTDTM=$P($G(@ARRAYNM@("HISTORY",ACTID,"DATETIME")),U)
 I ACTDTM'>0 S ISERR="-1^Can't tell whether action is erroneous" G ISERRX
 I $G(REACTDTM)'>0 S ISERR="-1^Can't tell whether action is erroneous" G ISERRX
 I ACTDTM<REACTDTM S ISERR=1
ISERRX Q ISERR
 ;
HASERR(ARRAYNM) ; Function indicates that given flag assignmt
 ;for given patient has ERRONEOUS actions.
 ; ERRONEOUS ACTIONS: all actions taken BEFORE
 ;an ENTERED IN ERROR (EIE) action
 ; Note: HASERR is equivalent to Has an EIE Action (HASEIE):
 ;(HASERR implies HASEIE. and HASEIE implies HASERR since
 ;EIE action always has actions taken previously.)
 ; Returns: EIEActionID^EIEDateTime if flag assignmt has been
 ;            marked Entered in Error (EIE).  If there are multiple
 ;            EIE actions, returns the most RECENT.
 ;          0 if assignmt not marked EIE
 ;         -1^msg if error
 ; Actions and notes for Erroneous actions or EIE actions
 ;should not be displayed in OR/TIU flag-related displays.
 ; Requires that $$GETHTIU^DGPFAPI1(DFN,TIUTTL,ARRAYNM) has just been
 ;called, and array named ARRAYNM currently exists for title
 ;assoc w/ flag and for given patient.
 N ACTID,HASERR
 I '$D(@ARRAYNM@("HISTORY")) S HASERR="-1^Can't tell whether flag assignment has erroneous actions" G HASERRX
 S ACTID=1000000,HASERR=0
 F  S ACTID=$O(@ARRAYNM@("HISTORY",ACTID),-1) G:'+ACTID HASERRX D  G:HASERR HASERRX
 . I $P(@ARRAYNM@("HISTORY",ACTID,"ACTION"),U,2)="ENTERED IN ERROR" D
 . . S HASERR=ACTID_U_$P(@ARRAYNM@("HISTORY",ACTID,"DATETIME"),U)
HASERRX Q HASERR
