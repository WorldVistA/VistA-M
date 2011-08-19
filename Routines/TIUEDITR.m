TIUEDITR ; SLC/JER - Enter/Edit a Document for Transcriber ;6/11/2002
 ;;1.0;TEXT INTEGRATION UTILITIES;**7,41,48,100,109,112**;Jun 20, 1997
 ; 2/2: Update DIE from TIUEDIT to TIUEDI4
MAIN(TIUCLASS) ; Control Branching
 N TIUPREF,TIUOUT,TIUAUTH
 ; --- Get user's preferences ---
 S TIUPREF=$$PERSPRF^TIULE(DUZ)
 ; --- Get the author to be used for multiple patients
 S TIUAUTH=+$$AUTHOR^TIULA2
 I TIUAUTH'>0 Q
 F  D  Q:+$G(TIUOUT)
 . N DFN,TIUREL,TIUCHK,TIUDA,TIUEDIT,TIUY,TIUNEW,TIUTYP,TIUDPRM
 . N TIUASK,TIU,VAIN,VADM,TIULMETH,TIUVMETH,TIUENTRY,TIUEXIT,TIUCMMTX
 . N DA ;10/3/00
 . ;Removed with TIU*1*41 - Joel didn't think it was appropriate
 . ;I $P(TIUPREF,U,6)="M" D MAIN^TIUEDIM(TIUCLASS,.TIUOUT) Q
 . ; --- Get a patient ---
 . S DFN=+$$PATIENT^TIULA I +DFN'>0 S TIUOUT=1 Q
 . S TIUCLASS=$G(TIUCLASS,38)
 . ; --- Get a document type ---
 . D DOCSPICK^TIULA2(.TIUTYP,TIUCLASS,"1A","LAST","","$P(^TIU(8925.1,+Y,0),U,7)'=13,+$$CANENTR^TIULP(+Y)")
 . I +$G(TIUTYP)'>0 S TIUOUT=1 Q
 . S TIUTYP=+$P($G(TIUTYP(1)),U,2)
 . ; --- Re-direct surgical reports ---
 . I +$$ISA^TIULX(TIUTYP,+$$CLASS^TIUSROI("SURGICAL REPORTS")) D ENTEROP^TIUSROI(DFN,TIUTYP) Q
 . ; --- Initialize document parameters ---
 . D DOCPRM^TIULC1(TIUTYP,.TIUDPRM)
 . ; --- If an ENTRY ACTION exists, execute it ---
 . S TIUENTRY=$$GETENTRY^TIUEDI2(+TIUTYP)
 . I $L(TIUENTRY) X TIUENTRY
 . Q:+$G(TIUOUT)  ; If entry action sets TIUOUT=1 Abort Entry
 . ; --- Get associated visit ---
 . I +$$SUPPVSIT^TIULC1(TIUTYP)'>0 D  I 1
 . . S TIULMETH=$$GETLMETH^TIUEDI1(TIUTYP)
 . . I '$L(TIULMETH) D  S TIUOUT=1 Q
 . . . W !,$C(7),"No Visit Linkage Method defined for "
 . . . W $$PNAME^TIULC1(TIUTYP),".",!,"Please contact IRM..."
 . . X TIULMETH
 . E  D
 . . D EVENT^TIUSRVP1(.TIU,DFN)
 . I $S($D(DIROUT):1,$D(DTOUT):1,1:0) S TIUQUIT=1 Q
 . I '$D(TIU("VSTR")) D  Q
 . . W !,$C(7),"Patient & Visit required." H 2
 . ; --- Validate Selection ---
 . S TIUVMETH=$$GETVMETH^TIUEDI1(TIUTYP)
 . I '$L(TIUVMETH) D  S TIUOUT=1 Q
 . . W !,$C(7),"No Validation Method defined for "
 . . W $$PNAME^TIULC1(TIUTYP),".",!,"Please contact IRM..."
 . X TIUVMETH
 . I $D(TIU),+$G(TIUASK) D
 . . ;S DA=$$GETREC^TIUEDI1(DFN,.TIU,1,.TIUNEW,.TIUDPRM,1)
 . . S DA=$$GETRECNW^TIUEDI3(DFN,.TIU,TIUTYP(1),.TIUNEW,.TIUDPRM,1)
 . . I +DA'>0 W !,"Unable to enter/edit." Q
 . . S TIUEDIT=$S('+$G(TIUNEW):$$CANDO^TIULP(DA,"EDIT RECORD"),1:1)
 . . I '+TIUEDIT D  Q
 . . . W !,$P(TIUEDIT,U,2) ; Echo denial message
 . . . D ADDENDUM^TIUADD(DA,"",.TIUCHNG)
 . . N TIUQUIT,TIUADD
 . . D DIE^TIUEDI4(DA,.TIUQUIT) Q:+$G(TIUQUIT)=2  ; **100**
 . . ;If (CP) and (Timeout or Not Select Consult) and (Consult Associated), Quit before EMPTYDOC check
 . . I +$$ISA^TIULX(TIUTYP,+$$CLASS^TIUCP),+$G(TIUQUIT)=1,+$P($G(^TIU(8925,+DA,14)),U,5)>0 Q
 . . I $$EMPTYDOC^TIULF(DA) D DELETE^TIUEDIT(DA,0) S:'+$G(TIUNEW) TIUCHNG("DELETE")=1 H:'+$G(TIUNEW) 2 Q
 . . Q:+$G(TIUQUIT)
 . . I +$G(TIUONCE) S TIUNDA(+$G(DA))=""
 . . I +$G(TIU("STOP")) D DEFER^TIUVSIT(DA,TIU("STOP")) I 1
 . . E  D QUE^TIUPXAP1
 . . ; --- Execute COMMIT procedure ---
 . . S TIUCMMTX=$$COMMIT^TIULC1(+$G(^TIU(8925,+DA,0)))
 . . I TIUCMMTX]"" X TIUCMMTX
 . . ; --- Execute RELEASE procedure ---
 . . D RELEASE^TIUT(DA)
 . . ; --- Execute VERIFY procedure ---
 . . D VERIFY^TIUT(DA)
 . . ; --- Execute SIGNATURE procedure ---
 . . D EDSIG^TIURS(DA)
 . . ; --- If an EXIT ACTION exists, execute it ---
 . . S TIUEXIT=$$GETEXIT^TIUEDI2(+$P(TIUTYP(1),U,2))
 . . I $L(TIUEXIT) X TIUEXIT
 . . ; --- If required, prompt for print
 . . I +$P($G(TIUDPRM(0)),U,8) D PRINT^TIUEPRNT(DA)
 Q
