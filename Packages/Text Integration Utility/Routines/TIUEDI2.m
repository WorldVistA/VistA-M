TIUEDI2 ; SLC/JER - Additional Edit Code ; 7-MAR-2000 10:57:50
 ;;1.0;TEXT INTEGRATION UTILITIES;**1,89,299**;Jun 20, 1997;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
GETENTRY(TIUTYP) ; Get Entry Action, enforce inheritance
 N TIUDAD,TIUY S TIUDAD=0
 S TIUY=$G(^TIU(8925.1,+TIUTYP,4.6))
 I TIUY']"" S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUY=$$GETENTRY(TIUDAD)
 Q TIUY
GETEXIT(TIUTYP) ; Get Validation method, enforce enheritance
 N TIUDAD,TIUY S TIUDAD=0
 S TIUY=$G(^TIU(8925.1,+TIUTYP,4.7))
 I TIUY']"" S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUY=$$GETEXIT(TIUDAD)
 Q TIUY
EXSTNOTE(DFN) ; Sample/display existing notes
 N TIUSMPL,TIUTOTL,TIUEDT,TIULDT,TIUPRMT,TIURVW,TIUPNOUN,TIUSEE,TIUOUT
 N TIUA,TIUI,TIUJ,TIULAST,TIULIST,TIUREC,TIURTN,TIUSTOP,TIUY,TIUZ,TIUQUIT
 I '$D(TIUPRM0) D SETPARM^TIULE
 I '$D(TIUPREF) S TIUPREF=$$PERSPRF^TIULE(DUZ)
 I +$P(TIUPREF,U,11) Q
 I +$P(TIUPRM0,U,7),$S($P(TIUPREF,U,11)=0:0,1:1) Q
 I +$O(^TIU(8925,"ACLPT",3,DFN,0))'>0 Q
 D SELPAT^TIULA2(.TIURTN,3,DFN,1)
 I +$G(TIURTN)'>0,($D(TIURTN)=1) D  S TIUOUT=1 Q
 . W !!,"Nothing selected.",!
 S TIUI=0
 F  S TIUI=$O(TIURTN(TIUI)) Q:+TIUI'>0  D  Q:$D(DUOUT)!$D(DIROUT)!+$G(TIUOUT)
 . N TIUDA
 . S TIUDA=+$G(TIURTN(TIUI)) Q:TIUDA'>0
 . D GETTIU^TIULD(.TIU,+TIUDA)
 . I $D(TIU) D
 . . S TIUSEE=$$CANDO^TIULP(TIUDA,"VIEW")
 . . I 'TIUSEE D  Q
 . . . W !!,$C(7),$P(TIUSEE,U,2),! K DFN
 . . . I $D(ORVP) S TIUOUT=1
 . . . S TIU=$$READ^TIUU("FOA","Press RETURN to continue...")
 . . D EN^VALM("TIU BROWSE FOR CLINICIAN")
 . . K ^TMP("TIUVIEW",$J),DFN
 . . S:$D(TIUQUIT) TIUOUT=1
 Q
CHEKSAVE(DUZ) ; Checks for entry in ^TIU(8925,"ASAVE",DUZ,TIUDA)
 Q +$O(^TIU(8925,"ASAVE",DUZ,0))
EDITSAVE(DUZ) ; Evaluates whether an unsaved document exists, allows edit
 N TIUDA,TIUPRMT,TIUY,TIU,TIUEDIT
 ;*299 
 S TIUDA=0 F  S TIUDA=$O(^TIU(8925,"ASAVE",DUZ,TIUDA)) Q:'TIUDA  D
 . ; If the document is gone, then delete the save flag and Quit
 . I '$D(^TIU(8925,+TIUDA,0)) K ^TIU(8925,"ASAVE",DUZ,+TIUDA) Q
 . I $P($G(^TIU(8925,TIUDA,13)),U,2)'=DUZ K ^TIU(8925,"ASAVE",DUZ,TIUDA) Q
 . S TIUEDIT=$$CANDO^TIULP(TIUDA,"EDIT RECORD")
 . I '+TIUEDIT  K ^TIU(8925,"ASAVE",DUZ,TIUDA) Q
 ;
 S TIUDA=$$CHEKSAVE(DUZ)
 I +TIUDA'>0 Q
  ; If Lock can't be acquired, quit
 L +^TIU(8925,+TIUDA,0):1
 E  Q
 W !!,"You have an unsaved document in your buffer."
 W !,"Depending on your preferred editor, you may"
 W !,"have lost some of the text.",!
 S TIUPRMT="Would you like to resume editing now"
 S TIUY=$$READ^TIUU("Y",TIUPRMT,"YES")
 I +TIUY'>0 W !!,"Okay. You can catch up with it later!",! H 1 G EDSAVEX
 W !!,"Good.  Here we go then!",!
 I $D(^TIU(8925,+TIUDA,"TEMP")),'$D(^TIU(8925,+TIUDA,"TEXT")) D
 . D GETTIU^TIULD(.TIU,TIUDA)
 . D MERGTEXT^TIUEDI1(TIUDA,.TIU)
 D EDIT1^TIURA
EDSAVEX L -^TIU(8925,+TIUDA,0)
 Q
