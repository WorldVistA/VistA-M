TIUEDIM ; SLC/JER - Enter/Edit Multiple Document ; 6/14/2002
 ;;1.0;TEXT INTEGRATION UTILITIES;**7,41,52,100,109,112**;Jun 20, 1997
 ; 2/2: Update DIE from TIUEDIT to TIUEDI4
MAIN(TIUCLASS,TIUOUT,TIUNDA,TIUCHNG) ; Control Branching
 N TIUREL,TIUCHK,TIUDA,TIUEDIT,TIUY,TIUNEW,TIUTYP,TIUPAT
 N TIUI,DTOUT S TIUDFLT=""
 K DIROUT
 ; --- Get one or more patients ---
 I '$L($T(PATIENT^ORU1)) Q
 D PATIENT^ORU1(.TIUPAT) I +TIUPAT'>0 S TIUOUT=1 Q
 S TIUI=0 F  S TIUI=+$O(TIUPAT(TIUI)) Q:+TIUI'>0!+$G(TIUOUT)  D
 . N DFN,DUOUT,TIUDPRM,TIU,TIULMETH,TIUVMETH,VAIN,VADM,TIUDA,TIUEDIT
 . N TIUENTRY,TIUCMMTX,TIUVSUPP,CANEDIT
 . S TIUVSUPP=0
 . S DFN=+$G(TIUPAT(TIUI)) Q:+DFN'>0
 . W !!,"For Patient ",$P(TIUPAT(TIUI),U,2)
 . S TIUCLASS=$G(TIUCLASS,38)
 . I TIUCLASS=3,$S(+$$ISA^USRLM(DUZ,"TRANSCRIPTIONIST"):0,1:1),(+$G(NOSAVE)'>0) D EXSTNOTE^TIUEDI2(DFN) D:$G(VALMAR)="^TMP(""OR"",$J,""CURRENT"")" FULL^VALM1
 . I +$G(DIROUT)!+$G(DUOUT)!+$G(DTOUT) S TIUOUT=1 Q
 . ; -- Set title array TIUTYP (use TIUTITLE or ask user) --
 . D SETTL^TIUEDI4(.TIUTYP,TIUCLASS,$G(TIUTITLE)) I +$G(TIUTYP)'>0 S TIUOUT=1 Q
 . ; --- Re-direct surgical reports ---
 . I +$$ISA^TIULX(TIUTYP,+$$CLASS^TIUSROI("SURGICAL REPORTS")) D ENTEROP^TIUSROI(DFN,TIUTYP) Q
 . ; -- Get doc parameters for title, X entry action --
 . D DOCPRM^TIULC1(TIUTYP,.TIUDPRM)
 . S TIUENTRY=$$GETENTRY^TIUEDI2(+TIUTYP)
 . I $L(TIUENTRY) X TIUENTRY
 . Q:+$G(TIUOUT)  ; If ENTRY ACTION sets TIUOUT=1 Abort Entry
 . ; -- Set visit array TIU --
 . ; NOTE: EVNTFLAG is set in TIUEDIT, prior to calling this routine
 . D GETVST^TIUEDI4(DFN,TIUTYP,.TIU,EVNTFLAG)
 . I $S($G(TIUQUIT):1,'$D(TIU("VSTR")):1,1:0) Q
 . ; -- Ask OK --
 . S TIUVMETH=$$GETVMETH^TIUEDI1(TIUTYP)
 . I '$L(TIUVMETH) D  S TIUOUT=1 Q
 . . W !,$C(7),"No Validation Method defined for "
 . . W $$PNAME^TIULC1(TIUTYP),".",!,"Please contact IRM..."
 . X TIUVMETH
 . I $S($D(DIROUT):1,$D(DTOUT):1,1:0) S TIUQUIT=1 Q
 . I $D(DUOUT) Q
 . ; -- If user OK'd basic info, go on to get text, etc.: --
 . I $D(TIU),+$G(TIUASK) D
 . . ; -- Get record DA --
 . . ; DA is either: new stub record, ready for edit, or
 . . ;               existing record, for edit, or
 . . ;               existing record, for addendum      
 . . N DA
 . . S DA=$$GETRECNW^TIUEDI3(DFN,.TIU,TIUTYP(1),.TIUNEW,.TIUDPRM,1,DUZ,.CANEDIT)
 . . I +DA'>0 W !,"Unable to enter/edit." Q
 . . ; -- [Addend DA and Quit] --
 . . ;  If record not new & user can't edit it, user said
 . . ;  in GETRECNW they wanted to addend, so let user write
 . . ;  addendum and quit:
 . . I 'TIUNEW,'CANEDIT D ADDENDUM^TIUADD(DA,"",.TIUCHNG,1) Q
 . . N TIUQUIT,TIUADD,TIUTDA
 . . ; -- Edit new or existing DA --
 . . D DIE^TIUEDI4(DA,.TIUQUIT)
 . . Q:+$G(TIUQUIT)=2  ; DA doesn't exist (e.g. uparrowed w/ bad record)
 . . ;If (CP) and (Timeout or Not Select Consult) and (Consult Associated), Quit before EMPTYDOC check
 . . I +$$ISA^TIULX(TIUTYP,+$$CLASS^TIUCP),+$G(TIUQUIT)=1,+$P($G(^TIU(8925,+DA,14)),U,5)>0 Q
 . . I $$EMPTYDOC^TIULF(DA) D DELETE^TIUEDIT(DA,0) S:$G(VALMAR)="^TMP(""TIUVIEW"",$J)" VALMBCK="Q" S:'+$G(TIUNEW) TIUCHNG("DELETE")=1 H:'+$G(TIUNEW) 2 Q
 . . Q:+$G(TIUQUIT)
 . . S:+DA SUCCESS=+DA
 . . I +$G(TIUONCE) S TIUNDA(+$G(DA))="" ; See TIURC, Across Patients
 . . ; -- Misc after-edit-stuff for DA --
 . . ; -- Mark to ask workload at signature;
 . . ;    (STOP for Stop codes for stand-alone visits): --
 . . I +$G(TIU("STOP")),(+$P($G(TIUDPRM(0)),U,14)'=1) D DEFER^TIUVSIT(DA,TIU("STOP")) I 1
 . . E  D QUE^TIUPXAP1 ; Post workload now in background
 . . S TIUCMMTX=$$COMMIT^TIULC1(+$P(TIUTYP(1),U,2))
 . . I TIUCMMTX]"" X TIUCMMTX
 . . D RELEASE^TIUT(DA)
 . . D VERIFY^TIUT(DA)
 . . ; -- Get signature for DA 
 . . D EDSIG^TIURS(DA)
 . . ; - execute EXIT ACTION -
 . . S TIUEXIT=$$GETEXIT^TIUEDI2(+$P(TIUTYP(1),U,2))
 . . I $L(TIUEXIT) S TIUTDA=DA X TIUEXIT S DA=TIUTDA
 . . ; --  [Prompt to print DA] --
 . . I +$P($G(TIUDPRM(0)),U,8) D PRINT^TIUEPRNT(DA)
 Q
