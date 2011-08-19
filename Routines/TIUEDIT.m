TIUEDIT ; SLC/JER - Enter/Edit a Document ; 6/11/2002
 ;;1.0;TEXT INTEGRATION UTILITIES;**1,7,22,52,100,109,112**;Jun 20, 1997
 ; Moved LOADDFLT, BOIL, CANXEC, REPLACE, INSMULT to TIUEDI4
 ; Moved DIE, TEXTEDIT from TIUEDIT to TIUEDI4
 ; Separated out modules SETTL, GETVST, ASKOK
 ; Moved SETTL, GETVST, ASKOK from TIUEDIT to TIUEDI4
 ; Changed call to GETREC^TIUEDI1 to call GETRECNW^TIUEDI3
MAIN(TIUCLASS,SUCCESS,DFN,TIUTITLE,EVNTFLAG,NOSAVE,TIUNDA,TIUSNGL,TIUCHNG) ; Create new document(s)
 ; May branch off to edit existing docmt instead of creating new one.
 ; Call with: [TIUCLASS] --> pointer to file (8925) corresponding to
 ;                           the class (e.g., Progress Notes=3)
 ;                           from which to select a title
 ;    [by ref] [SUCCESS] --> Boolean flag returned as IFN when a
 ;                           record is created, or 0 when record
 ;                           creation fails
 ;                 [DFN] --> IEN in patient file (#2)
 ;            [TIUTITLE] --> Pointer or NAME or PTR^NAME of the
 ;                           TITLE from file 8925.1 to be used as
 ;                           the default.
 ;            [EVNTFLAG] --> Boolean flag for visit prompt (0 to
 ;                           prompt, 1 to force event type visit)
 ;              [NOSAVE] --> Boolean flag to suppress saving the data
 ;                           (e.g., when testing new Boilerplates
 ;                           using DDEF action TRY, etc.).
 ;     [by ref] [TIUNDA] --> array of form: TIUNDA(IFN)="".
 ;                           Used in SHOW NOTES ACROSS PATIENTS.
 ;                           See TIURC, which sets TIUONCE.
 ;                           Also used in TIUEDIM, for mult pts.
 ;             [TIUSNGL] --> Boolean flag to create only ONE note
 ;                           regardless of multiple pt preference.
 ;    [by ref] [TIUCHNG] --> If received, passes back TIUCHNG array,
 ;                           which collects info across records about
 ;                           actions taken. Used in feedback
 ;                           msgs to user.
 ; Other variables:
 ; sets [TIUTYP] --> array with form similar to that of XQORNOD:
 ;                           TIUTYP = title IFN
 ;                           TIUTYP(1) = 1^title IFN^title name,
 ;                           where 1 for us is just a positive #
 ; sets  [TIUBY] --> used in some input templates to BYpass fields.
 ; Called by:
 ;   Outpt Pharmacy, Consults, ...
 N TIUASK,TIUOUT,TIUREL,TIUCHK,TIUDA,TIUEDIT,TIUY,TIUTYP,TIUDPRM
 N TIUDFLT,TIUPREF,TIULMETH,TIUVMETH,DIRUT,DUOUT,DTOUT,TIUPRM0
 N TIUPRM1,TIUPRM3,TIUENTRY,TIUEXIT,TIUBY,TIUPNAME,TIUST
 S EVNTFLAG=+$G(EVNTFLAG,0)
 ; --Get user's division parameters, preferences: --
 I '$D(TIUPRM0) D SETPARM^TIULE
 S TIUPREF=$$PERSPRF^TIULE(DUZ)
 ; -- multiple pts; not in OERR, not TRYing DDEF, not single docmt: --
 I $P(TIUPREF,U,6)="M",(+$G(ORVP)'>0),(+$G(NOSAVE)'>0),'+$G(TIUSNGL) D MAIN^TIUEDIM(TIUCLASS,.TIUOUT,.TIUNDA,.TIUCHNG) Q
 ; -- Loop: Create docmt --
 F  D  Q:+$G(ORVP)!+$G(TIUOUT)!+$G(NOSAVE)!+$G(TIUSNGL)
 . N TIU,TIUCMMTX,TIUBY,TIUEDIT,TIUNEW,TIUTYP,VADM,VAIN,CANEDIT
 . ; -- User specifies basic info for new docmt --
 . ; -- Get patient --
 . I +$G(ORVP) S DFN=+$G(ORVP)
 . I +$G(DFN)'>0 D  I +DFN'>0 S TIUOUT=1 Q
 . . S DFN=+$$PATIENT^TIULA
 . ; -- [For progress notes, show available notes]: --
 . S TIUCLASS=$G(TIUCLASS,38)
 . I TIUCLASS=3,$S(+$$ISA^USRLM(DUZ,"TRANSCRIPTIONIST"):0,1:1),(+$G(NOSAVE)'>0) D EXSTNOTE^TIUEDI2(DFN) D:$G(VALMAR)="^TMP(""OR"",$J,""CURRENT"")" FULL^VALM1
 . I +$G(DIROUT)!+$G(DUOUT)!+$G(DTOUT) S TIUOUT=1 Q
 . ; -- Set title array TIUTYP (use TIUTITLE or ask user) --
 . D SETTL^TIUEDI4(.TIUTYP,TIUCLASS,$G(TIUTITLE)) I +$G(TIUTYP)'>0 S TIUOUT=1 Q
 . ; --- Re-direct SURGICAL REPORTS ---
 . I +$$ISA^TIULX(TIUTYP,+$$CLASS^TIUSROI("SURGICAL REPORTS")) D ENTEROP^TIUSROI(DFN,TIUTYP) Q
 . ; -- Get doc parameters for title, X entry action --
 . D DOCPRM^TIULC1(TIUTYP,.TIUDPRM)
 . S TIUENTRY=$$GETENTRY^TIUEDI2(+TIUTYP)
 . I $L(TIUENTRY) X TIUENTRY
 . Q:+$G(TIUOUT)  ; If ENTRY ACTION sets TIUOUT=1 Abort entry
 . ; -- Set visit array TIU --
 . D GETVST^TIUEDI4(DFN,TIUTYP,.TIU,EVNTFLAG)
 . I '$D(TIU("VSTR")) K DFN,TIUTYP Q
 . ; -- Ask OK --
 . D ASKOK^TIUEDI4(TIUTYP,.TIU,.TIUBY,.TIUASK) I '$D(TIU("VSTR")) K DFN,TIUTYP Q
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
 . . ;    If record not new & user can't edit it, let user
 . . ;    write addendum and quit:
 . . I 'TIUNEW,'CANEDIT D  Q
 . . . D ADDENDUM^TIUADD(DA,"",.TIUCHNG,1)
 . . N TIUQUIT,TIUADD,TIUTDA
 . . ; -- Edit new or existing DA --
 . . D DIE^TIUEDI4(DA,.TIUQUIT)
 . . Q:+$G(TIUQUIT)=2  ; DA doesn't exist (e.g. uparrowed w/ bad record)
 . . ;If (CP) and (Timeout or Not Select Consult) and (Consult Associated), Quit before EMPTYDOC check
 . . I +$$ISA^TIULX(TIUTYP,+$$CLASS^TIUCP),+$G(TIUQUIT)=1,+$P($G(^TIU(8925,+DA,14)),U,5)>0 Q
 . . I $$EMPTYDOC^TIULF(DA) D DELETE(DA,0) S:$G(VALMAR)="^TMP(""TIUVIEW"",$J)" VALMBCK="Q" S:'+$G(TIUNEW) TIUCHNG("DELETE")=1 H:'+$G(TIUNEW) 2 Q
 . . Q:+$G(TIUQUIT)
 . . S:+DA SUCCESS=+DA
 . . I +$G(TIUONCE) S TIUNDA(+$G(DA))="" ; See TIURC, Across Patients
 . . ; -- Misc after-edit-stuff for DA --
 . . ; -- Mark to ask workload at signature;
 . . ;    (STOP for Stop codes for stand-alone visits): --
 . . I +$G(TIU("STOP")),(+$P($G(TIUDPRM(0)),U,14)'=1) D DEFER^TIUVSIT(DA,TIU("STOP")) I 1 ;piece 14 = suppress DX/CPT on entry
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
 . . ; --  [Prompt to add ID stub] --
 . . ; I +$P($G(TIUDPRM(0)),U,20) D ADDSTUB^TIUGEDIT(DA)
 . . ; --  [Prompt to print DA] --
 . . I +$P($G(TIUDPRM(0)),U,8) D PRINT^TIUEPRNT(DA)
 . K DFN ; Free patient
 . S TIUPNAME=$$PNAME^TIULC1(TIUCLASS)
 . I $$UP^XLFSTR($E(TIUPNAME,$L(TIUPNAME)))="S" S TIUPNAME=$E(TIUPNAME,1,$L(TIUPNAME)-1)
 . ; -- [loop again] --
 . I '+$G(NOSAVE),'+$G(ORVP),'+$G(TIUSNGL) W !!,"You may enter another ",TIUPNAME,". Press RETURN to exit.",!
 Q
 ;
DELETE(TIUDA,PROMPT,MSG,HUSH) ; Delete record
 N DIDEL,DIE,DR,TIUD0,TIUVSIT,TIUVKILL,TIUDELX,TIUTYPE
 S TIUD0=$G(^TIU(8925,+TIUDA,0)),TIUVSIT=$P(TIUD0,U,3),TIUTYPE=+TIUD0
 I +$G(PROMPT),'+$$READ^TIUU("YO",MSG,"NO") W !,"Nothing Deleted." Q
 K ^TIU(8925,"ASAVE",DUZ,TIUDA)
 D DELIRT^TIUDIRT(TIUDA)
 ; If a DELETE Action exists for the document definition, execute it
 S TIUDELX=$$DELETE^TIULC1(TIUTYPE)
 I TIUDELX]"" X TIUDELX
 S DA=TIUDA,(DIDEL,DIE)=8925,DR=".01///@"
 D ^DIE W:'+$G(HUSH) !,"<NOTHING ENTERED. "
 I '+$G(HUSH) W:+TIUD0 $$PNAME^TIULC1(+TIUD0)," DELETED>"
 D DELCOMP^TIUEDI1(TIUDA),DELAUDIT^TIUEDI1(TIUDA)
 K ^TIU(8925,"ASAVE",DUZ,TIUDA) ; Remove Save Flag
 D ALERTDEL^TIUALRT(TIUDA),ADDENDEL^TIUALRT(TIUDA)
 ; I +TIUVSIT S TIUVKILL=$$DELVFILE^PXAPI("ALL",TIUVSIT,"","TEXT INTEGRATION UTILITIES")
 Q
 ;
