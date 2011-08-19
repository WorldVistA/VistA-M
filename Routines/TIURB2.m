TIURB2 ; SLC/JER,AJB - More Review Screen Actions ; 1/18/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,109,154,112,184,232**;Jun 20, 1997;Build 19
 ; 2/3: Update TEXTEDIT from TIUEDIT to TIUEDI4
 ; 9/28 Moved DELETE, DEL, DELTEXT, DIK to new rtn TIURB2
 ; 8/2/02 DELTEXT logic to bypass user-response if called by GUI TIU*1*154
 ;        GODEL+12, changed direct access of DPT global to FM
 Q
DELETE ; Delete action
 N TIUI,TIUY,TIUCHNG,Y,DIROUT,DTOUT,DUOUT
 N TIULNO,TIUJ,PRNTDA,LSTDA
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N TIUDATA,DA,RSTRCTD
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S DA=+$P(TIUDATA,U,2)
 . W !!,"Processing Item #",TIUI
 . L +^TIU(8925,+DA):1
 . E  D  Q
 . . W !?5,$C(7),"Another user is editing this entry."
 . . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 . . D PICK^TIULM(TIUI)
 . S RSTRCTD=$$DOCRES^TIULRR(DA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",! ; Echo denial message
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . D DEL(DA)
 . L -^TIU(8925,+DA)
 ; -- Update or Rebuild list, restore video:
 S TIUCHNG("RBLD")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 Q
DEL(DA) ; We don't hand out pencils, without erasers
GODEL ; -- Called from DEL^TIURB
 N CANDEL,TIUDA,TIUD0,TIUI,TIUDFLT,TIUPT,TIUVDT,TIUTYP,PROMPT,TIUAUDIT
 N TIUMSG,TIURSN,TIUVTYP,TIUABORT,ADDMPRNT,IDPRNT,TIUAUTH,TIUD12,STATUS
 L +^TIU(8925,+DA):1
 E  D  Q
 . W !?5,$C(7),"Another user is editing this entry."
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 I +$$HASIMG(DA) D IMGNOTE Q
 S TIUD0=$G(^TIU(8925,+DA,0)),TIUD12=$G(^(12))
 S TIUTYP=$$UP^XLFSTR($$PNAME^TIULC1(+TIUD0)),TIUAUTH=$P(TIUD12,U,2)
 S STATUS=$P(TIUD0,U,5),ADDMPRNT=+$P(TIUD0,U,6)
 S IDPRNT=+$P($G(^TMP("TIUR",$J,"IDDATA",DA)),U,3)
 S TIUPT=$$NAME^TIULS($P($G(^DPT(+$P(TIUD0,U,2),0)),U),"FIRST LAST")
 S TIUVDT=+$P(TIUD0,U,7)
 S TIUVDT=$$DATE^TIULS(TIUVDT,"MM/DD/YY"_$S($L(TIUVDT,".")=2:" HR:MIN",1:""))
 S TIUVTYP=$S(+$$ISDS^TIULX(+TIUD0):" Admission",1:" Visit")
 S TIUMSG="DELETING "_TIUTYP_" For "_TIUPT_"'s "_TIUVDT_TIUVTYP_"."
 S CANDEL=$$CANDO^TIULP(DA,"DELETE RECORD")
 ;VMP/ELR NEXT PARAGRAPH ADDED LONGER HANG FOR LONG ERROR MESSAGES
 I 'CANDEL D  G DELX
 . NEW TIUHANG S TIUHANG=2 I $L($G(CANDEL))>99 S TIUHANG=5
 . W !!,$C(7),$C(7),$C(7),$P(CANDEL,U,2),! H TIUHANG
 I $$HASIDKID^TIUGBR(DA) W !!,"This interdisciplinary parent cannot be deleted; its entries must first",!,"be detached.",! H 3 G DELX
 I $O(^TIU(8925,"DAD",+DA,0))>0,$$HASADDEN^TIULC1(DA) D
 . W !!,"This "_TIUTYP_" has ADDENDA."
 W !,$C(7) F TIUI=1:1:$L(TIUMSG,"|") W !,$P(TIUMSG,"|",TIUI)
 W ! S PROMPT="Are you SURE you want to DELETE"
 I '$$READ^TIUU("YO",PROMPT,"NO") W !,"Nothing DELETED.",! H 2 S TIUCHNG=0 G DELX
 S PROMPT="DELETE the TEXT ONLY, leaving audit trail information"
 S TIUDA=DA
 I STATUS'>5,$S(DUZ=TIUAUTH:1,+$$ISA^USRLM(DUZ,"MEDICAL INFORMATION SECTION")'>0:1,1:0) S TIUAUDIT=0 I 1
 E  D  G:$D(TIUABORT) DELX
 . I +$P($G(^TIU(8925,+TIUDA,0)),U,5)'<6 S TIUAUDIT=1
 . E  D
 . . S TIUAUDIT=+$$READ^TIUU("YO",PROMPT,"NO")
 . . I $D(DTOUT)!($D(DUOUT)) D
 . . . W !,"Nothing DELETED.",!
 . . . S TIUCHNG=0,TIUABORT=1
 . . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 K ^TIU(8925,"ASAVE",DUZ,TIUDA) ; Remove SAVE-flag
 I +TIUAUDIT'>0 D  G DELX
 . W !,"DELETING Entire "_TIUTYP_" record.",!
 . D DELIRT^TIUDIRT(TIUDA),DIK(TIUDA) H 2
 . S TIUCHNG=2,TIUCHNG("DELETE")=1
 . D ALERTDEL^TIUALRT(TIUDA),DELSGNR^TIURB1(TIUDA)
 S PROMPT="Reason for DELETION (Privacy Act or Administrative): "
 S TIURSN=$P($$READ^TIUU("SA^P:privacy act;A:administrative",PROMPT,"PRIVACY ACT"),U)
 I '$L(TIURSN) D  G DELX
 . W !,"Nothing DELETED.",!
 . S TIUCHNG=0,TIUABORT=1
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 D ALERTDEL^TIUALRT(TIUDA),DELSGNR^TIURB1(TIUDA)
 D DELTEXT(TIUDA,TIURSN),AUDEL^TIURB1(TIUDA,TIURSN) S TIUCHNG=1
DELX L -^TIU(8925,+DA)
 Q
DELTEXT(DA,TIURSN) ; After signature, only retraction possible
 N DR,DIE,TIUDA,TIUY I '$D(ZTQUEUED) D FULL^VALM1
 S TIUDA=DA
 W !!?5,$C(7),"***********************************************************************"
 W !?5,"*  This document will now be RETRACTED. As such, it has been removed  *"
 W !?5,"*    from public view, and from typical Releases of Information,      *"
 W !?5,"*          but will remain indefinitely discoverable to HIMS.         *"
 W !?5,"***********************************************************************",!
 S DIE=8925
 S DR="1610////^S X=+DUZ;1611////^S X=+$$NOW^XLFDT;1612////^S X=TIURSN"
 D ^DIE
 S DA=$$RETRACT^TIURD2(DA,"",14)
 ; Unlink PRF titles when TIU changes require it TIU*1*184
 D ISPRFTTL^TIUPRF2(.TIUY,+$G(^TIU(8925,TIUDA,0))) I +TIUY D UNLINK^TIUPRF1(TIUDA)
 ; Roll back SURGICAL REPORT TITLES when TIU changes require it ; TIU*1*112
 D ISSURG^TIUSROI(.TIUY,+$G(^TIU(8925,TIUDA,0))) I +TIUY D RETRACT^TIUSROI1(TIUDA)
 ; Remove link to consult if a Consult Title
 D ISCNSLT^TIUCNSLT(.TIUY,+$G(^TIU(8925,TIUDA,0))) I +TIUY D REMCNSLT^TIUCNSLT(TIUDA)
 I '$$BROKER^XWBLIB D
 . I '$D(ZTQUEUED),$$READ^TIUU("EA","Press RETURN to continue...")
 Q
DIK(DA,SUPPACT) ; Call ^DIK to delete the record
 ; [SUPPACT] = Boolean to suppress delete action
 N DIK,TIUTYP,TIUTYPE,TIUDA,TIUVSIT,TIUVKILL,TIUDELX S TIUDA=0
 F  S TIUDA=+$O(^TIU(8925,"DAD",+DA,TIUDA)) Q:+TIUDA'>0  D DIK(TIUDA)
 S TIUTYPE=+$G(^TIU(8925,+DA,0)),SUPPACT=+$G(SUPPACT)
 S TIUTYP=$P($G(^TIU(8925.1,TIUTYPE,0)),U)
 S TIUVSIT=+$P($G(^TIU(8925,DA,0)),U,3),TIUDA=DA
 S TIUDELX=$$DELETE^TIULC1(TIUTYPE)
 I TIUDELX]"",'SUPPACT X TIUDELX
 S DIK="^TIU(8925,"
 D ^DIK ; W:'$D(ZTQUEUED) "."
 D DELAUDIT^TIUEDI1(DA)
 D DELPROB^TIURB1(DA)
 D DELSGNR^TIURB1(DA)
 D DELIMG(DA)
 D ALERTDEL^TIUALRT(DA)
 ; **52** Disable call to $$DELVFILE^PXAPI 'til further notice
 ; I +TIUVSIT,$D(^AUPNVSIT(+TIUVSIT)) S TIUVKILL=$$DELVFILE^PXAPI("ALL",TIUVSIT,"","TEXT INTEGRATION UTILITIES")
 Q
HASIMG(TIUDA) ; Evaluate whether images are linked
 Q +$O(^TIU(8925.91,"B",TIUDA,0))
IMGNOTE ; Present Notice of Linked Images
 D FULL^VALM1
 W !!?5,$C(7),"***********************************************************************"
 W !?5,"* This document has linked images. You must ""delete"" the Images using *"
 W !?5,"*        the Imaging Package before proceeding with this action.      *"
 W !?5,"*      The images will be hidden from public view, but will remain    *"
 W !?5,"*                   indefinitely discoverable to HIMS.                *"
 W !?5,"***********************************************************************",!
 I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 Q
DELIMG(TIUDA) ; Remove linked images, when document deleted
 N DA,DIK S DIK="^TIU(8925.91,",DA=0
 F  S DA=$O(^TIU(8925.91,"B",TIUDA,DA)) Q:+DA'>0  D ^DIK
 Q
