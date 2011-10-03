TIURD ; SLC/JER - Reassign actions ;4/25/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**4,58,61,100,109,173,184,233**;Jun 20, 1997;Build 3
 ;
 ; Call to $$TIUREAS^MDAPI covered by IA# 3378
 ; $$TIUREAS^MDAPI went out with MD 1.0, which was not mandated, so
 ;checks are made for its existence before it is called.
REASSIGN ; Reassign selected Documents
 N TIUCHNG,TIULST,TIUI,RSTRCTD,TIUDAARY
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N TIUDA,DFN,TIU,TIUDATA,TIUVIEW
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=+$P(TIUDATA,U,2) S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . W !!,"Processing Item #",TIUI,"..."
 . I $$CANTSURG(TIUDA) H 1 Q  ;not permitted for surgery reports
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",! ; Echo denial message
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . I +$$HASIMG^TIURB2(TIUDA) D IMGNOTE^TIURB2 Q
 . S TIUVIEW=$$CANDO^TIULP(TIUDA,"VIEW")
 . I '+TIUVIEW D  Q
 . . W !!,$C(7),$C(7),$C(7),$P(TIUVIEW,U,2),!
 . . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 . S TIUDAARY(TIUI)=TIUDA
 . S TIUCHNG=0
 . D EN^VALM("TIU REASSIGN")
 . I +$G(TIUCHNG) D
 . . S TIULST=$G(TIULST)_$S($G(TIULST)]"":",",1:"")_TIUI
 ; -- Rebuild list: --
 S TIUCHNG("RBLD")=1
 D UPRBLD^TIURL(.TIUCHNG) K VALMY
 S VALMBCK="R"
 D VMSG^TIURS1($G(TIULST),.TIUDAARY,"reassigned")
 Q
 ;
REASSIG1 ; Single record reassign
 N TIUAUTH,TIURSSG,TIUNAME,DA,DR,DIE,TIUTYPE,TIUEDIT,TIUADD,TIUPROMO,TIUY
 N TIUD0,TIUD12,TIUD13,TIUD14,TIUODA,TIUOUT K ^TMP("TIURTRCT",$J)
 D FULL^VALM1
 I $$CANTSURG(TIUDA) H 3 Q  ;not permitted for surgery reports
 L +^TIU(8925,+TIUDA):1
 E  W !?5,$C(7),$C(7),$C(7),"Another user is editing this entry." S TIUY=$$READ^TIUU("EA","Press RETURN to continue...") Q
 ; Authorized? NO: echo why not & quit
 I +$$HASIMG^TIURB2(TIUDA) D IMGNOTE^TIURB2 Q
 I +$$ISADDNDM^TIULC1(TIUDA) D  I 1
 . N TIUDAD
 . S TIUDAD=+$P(^TIU(8925,TIUDA,0),U,6)
 . I +$$DADORKID^TIUGBR(TIUDAD) D
 . . S TIURSSG="0^You must first detach the ORIGINAL interdisciplinary entry."
 E  I $$DADORKID^TIUGBR(TIUDA) D  I 1
 . S TIURSSG="0^You must first detach interdisciplinary entries."
 I '$D(TIURSSG) S TIURSSG=$$CANDO^TIULP(+TIUDA,"REASSIGN")
 I +$G(TIURSSG)'>0 D  G REASS1X
 . W !!,$C(7),$C(7),$C(7),$P(TIURSSG,U,2),!
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 S TIUD0(0)=$G(^TIU(8925,+TIUDA,0)),TIUD12(0)=$G(^(12))
 S TIUD13(0)=$G(^TIU(8925,+TIUDA,13)),TIUD14(0)=$G(^(14))
 S TIUTYPE=$P(TIUD0(0),U)
 S TIUNAME=$$PNAME^TIULC1(+TIUTYPE)
 S TIUAUTH=$P(TIUD12(0),U,2)
 W !,$C(7)
 S TIUY=$$READ^TIUU("YO","Are you sure you want to REASSIGN this "_TIUNAME,"NO","^D REAS1^TIUDIRH")
 I +TIUY'>0 S TIUOUT=1 G REASS1X
 I +$P(TIUD0(0),U,5)>5 D  G:+$G(TIUOUT) REASS1X
 . W !!,$C(7),$C(7),"The status of this document is: ",$$UP^XLFSTR($$STATUS^TIULC(TIUDA))
 . I +$$GETSIG^TIURD2'>0 S TIUOUT=1
 . W !
 ; Addendum? YES: Ask intended action is move, swap with original, or
 ; replace original
 S TIUADD=$$ISADDNDM^TIULC1(+TIUDA)
 I +TIUADD D  G REASS1X
 . D REASSIGA
 D REASSIGO^TIURD3
REASS1X L -^TIU(8925,+TIUDA):1
 I +$G(TIUOUT),+$G(TIUODA),+$G(TIUDA),$D(TIUD0(0)) D RECOVER^TIURD4(TIUODA,TIUDA,.TIUD0) S TIUDA=TIUODA
 ; Remove additional signers who haven't signed from retracted original
 I '+$G(TIUOUT),+$G(TIUODA) D
 . I +$O(^TIU(8925.7,"B",+$G(TIUODA),0)) D DELSGNRS^TIURD4(TIUODA,1)
 . D ALERTDEL^TIUALRT(TIUODA)
 I '+$G(TIUOUT),+$G(TIUODA),+$$ISA^TIULX(+$G(TIUD0(0)),+$$CLASS^TIUCP) D
 . N TIUCPY,TIUNVSTR
 . Q:'$L($T(TIUREAS^MDAPI))
 . S TIUNVSTR=$P(TIUD12(1),U,11)_";"_$P(TIUD0(1),U,7)
 . S TIUNVSTR=TIUNVSTR_";"_$P(TIUD0(1),U,13)
 . S TIUCPY=$$TIUREAS^MDAPI(+$P(TIUD0(0),U,2),+$P(TIUD14(0),U,5),+TIUODA,+$P(TIUD0(1),U,2),+$P($G(^TIU(8925,TIUDA,14)),U,5),TIUNVSTR,TIUDA)
 D SEND^TIUALRT(TIUDA)
 S VALMBCK=$S(+$G(TIUCHNG):"Q",1:"R") K ^TMP("TIURTRCT",$J)
 Q
 ;
REASSIGO ; Reassign an original Document
 G REASSIGO^TIURD3
 ;
REASSIGA ;Reassign an Addendum to an original DS
 N TIUACT,TIUSET S TIUCHNG=0
 W !,"Please choose the appropriate action for this Addendum:"
 S TIUSET="M:move addendum to a different document"
 S TIUSET=TIUSET_";P:promote addendum as document for another visit"
 S TIUSET=TIUSET_";R:replace parent document with this addendum"
 S TIUSET=TIUSET_";S:swap this addendum with its parent document"
 S TIUACT=$$READ^TIUU("S^"_TIUSET,"Select Reassign Action","move")
 I $P(TIUACT,U)="M" D MOVEADD^TIURD1(TIUDA) Q
 I $P(TIUACT,U)="P" D PROMOTE^TIURD1(TIUDA) Q
 I $P(TIUACT,U)="R" D REPLACE^TIURD1(TIUDA) Q
 I $P(TIUACT,U)="S" D SWAPADD^TIURD1(TIUDA)
 Q
 ;
CLAPPLNK ; Re-link selected Documents to different Client Records
 N TIUCHNG,TIULST,TIUDA,DFN,TIU,TIUDATA,TIUEDIT,TIUI,TIUY,Y,DIROUT,TIUPOP
 N TIUDAARY
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0 D FULL^VALM1
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=+$P(TIUDATA,U,2),TIUDAARY(TIUI)=TIUDA
 . S TIUCHNG=0
 . W !!,"Processing Item #",TIUI,"..."
 . D CLAPPLN1(TIUDA)
 . I +$G(TIUCHNG)=1 D
 . . S TIULST=$G(TIULST)_$S($G(TIULST)]"":", ",1:"")_TIUI
 S TIUCHNG("REFRESH")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 D VMSG^TIURS1($G(TIULST),.TIUDAARY,"re-linked")
 Q
 ;
CLAPPLN1(TIUDA) ; Re-link a single record to the client application
 N TIUREASX,CANLNK,ACTION,ISPRF,OLDLINK
 I '$D(^TIU(8925,TIUDA,0)) D  Q
 . W !!,$C(7),"Document no longer exists.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 I $$CANTSURG(TIUDA) H 3 Q  ;not permitted for surgery reports
 S ISPRF=$$ISPRFDOC^TIUPRF(TIUDA) ;Patient Record Flag
 I ISPRF S ACTION="LINK TO FLAG",OLDLINK=$$GETLINK^DGPFAPI1(TIUDA)
 I 'ISPRF S ACTION="LINK WITH REQUEST",OLDLINK=$P($G(^TIU(8925,TIUDA,14)),U,5)
 I +$$ISADDNDM^TIULC1(TIUDA) D  Q
 . W !!,$C(7),"Links for ADDENDA can't be independently changed.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 S TIUREASX=$$REASSIGN^TIULC1(+$G(^TIU(8925,TIUDA,0)))
 I TIUREASX']"" D  Q
 . W !!,$C(7),"No PACKAGE REASSIGNMENT ACTION Defined.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 I $$DADORKID^TIUGBR(TIUDA) D  Q  ;**100**
 . S CANLNK="0^You must first detach interdisciplinary entries"
 . W !!,$C(7),$C(7),"You must first detach interdisciplinary entries",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 S CANLNK=$$CANDO^TIULP(+TIUDA,ACTION)
 I +CANLNK'>0 D  Q
 . W !!,$C(7),$C(7),$P(CANLNK,U,2),!
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 X TIUREASX
 I ISPRF,OLDLINK'=$$GETLINK^DGPFAPI1(TIUDA) S TIUCHNG=1
 I 'ISPRF,$P($G(^TIU(8925,TIUDA,14)),U,5)'=OLDLINK S TIUCHNG=1
 Q
 ;
CANTSURG(TIUDA) ; If TIUDA is surg docmt, write can't do this action and
 ;return 1 for can't do it P184
 N TIUY,CANT,TIUPDA,TIUDA2 S CANT=0,TIUPDA=0,TIUDA2=0
 ; VMP/RJT - *233 - Do not allow action on addenda of Surgical documents 
 D
 . I +$$ISADDNDM^TIULC1(TIUDA) S TIUDA2=+$P($G(^TIU(8925,TIUDA,0)),U,6) Q
 . S TIUDA2=TIUDA
 D ISSURG^TIUSROI(.TIUY,+$G(^TIU(8925,TIUDA2,0)))
 I '+TIUY Q CANT
 S CANT=1 W !,"This action is no longer permitted for SURGICAL REPORTS"
 Q CANT
