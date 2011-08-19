TIURC ; SLC/JER - Additional Review screen actions ;02/25/10  08:52
 ;;1.0;TEXT INTEGRATION UTILITIES;**1,4,36,48,67,79,58,100,182,232,250**;Jun 20, 1997;Build 14
 ;
 ; ICR #10018    - ^DIE Routine & DIE, DA, DR, DTOUT, & DUOUT Local Vars
 ;     #10117    - EN^VALM, CLEAR^VALM1, & FULL^VALM1  Routines & VALM("ENTITY"),
 ;                 VALMBCK, VALMY, & VALMY( Local Vars
 ;     #10119    - EN^VALM2 Routine & XQORNOD(0) Local Var
 ;
VERIFY ; Verify Documents
 N TIUCHNG,TIUDATA,TIUI,TIUY,Y,DIROUT,TIULST,TIUDAARY
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N TIU,TIUDATA,TIUDA,RSTRCTD
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=+$P(TIUDATA,U,2) S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",!
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S TIUDAARY(TIUI)=TIUDA
 . S TIUCHNG=0
 . D EN^VALM("TIU VERIFY")
 . K ^TMP("TIUVIEW",$J)
 . I +$G(TIUCHNG) D
 . . S TIULST=$G(TIULST)_$S($G(TIULST)]"":",",1:"")_TIUI
 ; -- Update or Rebuild list, restore video:
 I $G(TIUCHNG("ADDM"))!$G(TIUCHNG("DELETE")) S TIUCHNG("RBLD")=1
 E  S TIUCHNG("UPDATE")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 D VMSG^TIURS1($G(TIULST),.TIUDAARY,"verified/unverified")
 Q
VERIFY1 ; Single record verify
 ; Receives TIUDA
 N DA,DIE,DR,TIUTYP,TIUQUIT,TIUT0,TIUTNM,TIUVERX
 S TIUTYP=+$G(^TIU(8925,+TIUDA,0)),TIUT0=$G(^TIU(8925.1,+TIUTYP,0))
 S TIUTNM=$$PNAME^TIULC1(+TIUTYP)
 S TIUTYP(1)="1^"_+TIUTYP_U_TIUTNM_U
 I $$DADORKID^TIUGBR(TIUDA) D  Q
 . W !!,$C(7),"This ",TIUTNM," is an interdisciplinary entry.",!,"ID entries must be verified prior to attaching.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 I +$P($G(^TIU(8925,+TIUDA,15)),U)!+$P($G(^(15)),U,7) D  Q
 . W !!,$C(7),"This ",TIUTNM," is already signed.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 ; -- Can't verify admin closed docmts (P182):
 I +$P($G(^TIU(8925,+TIUDA,16)),U,6) D  Q
 . W !!,$C(7),"This ",TIUTNM," is already closed.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 I +$P($G(^TIU(8925,+TIUDA,13)),U,5) D  Q
 . W !!,"This ",TIUTNM," is already verified."
 . S TIUY=$$READ^TIUU("YO","Do you want to UNVERIFY this "_TIUTNM,"NO","^D UNVER^TIUDIRH")
 . I TIUY W !,TIUTNM," UNVERIFIED" D
 . . S DA=TIUDA,DIE=8925,DR=".05///UNVERIFIED;1305///@;1306///@" D ^DIE
 . . W "." S TIUCHNG=1
 . . D ALERTDEL^TIUALRT(TIUDA)
 N DUOUT,DIROUT,DTOUT
 S TIUY=$$READ^TIUU("YO","Do you want to edit this "_TIUTNM,"NO")
 I +TIUY D
 . ;VMP/ELR ADDED NEXT 2 LINES TO PROHIBIT EDIT OF SURGERY WHILE VERIFYING
 . NEW TIUMSG S TIUMSG=$$CANDO^TIULP(TIUDA,"EDIT RECORD") I +TIUMSG'>0 D  Q
 . . W !!,$C(7),$P(TIUMSG,U,2),!
 . D GETTIU^TIULD(.TIU,TIUDA),CLEAR^VALM1
 . D DIE^TIUEDI4(TIUDA,.TIUQUIT) ; **100**
 . I $S(+$G(TIUQUIT):1,$D(DUOUT):1,$D(DIROUT):1,$D(DTOUT):1,1:0) Q
 . D RELEASE^TIUT(TIUDA)
 I +TIUY'>0,$S(+$G(TIUQUIT):1,$D(DUOUT):1,$D(DIROUT):1,$D(DTOUT):1,1:0) Q
 S TIUY=$$READ^TIUU("YO","VERIFY this "_TIUTNM,"NO","^D VER^TIUDIRH")
 I 'TIUY W !,TIUTNM," NOT VERIFIED." Q
 S DA=TIUDA,DIE=8925,DR=".05///UNSIGNED;1305////"_$$NOW^TIULC_";1306////"_$G(DUZ) D ^DIE
 S TIUCHNG=1,TIUVERX=$$VERIFY^TIULC1(+$G(^TIU(8925,+TIUDA,0)))
 I TIUVERX]"" X TIUVERX
 I +DA W !,TIUTNM," VERIFIED." D MAIN^TIUPD(DA,"V"),SEND^TIUALRT(DA)
 Q
ADD ; Add Document
 N TIUONCE,TIUNDA,TIUCLASS,TIUCREAT,TIUITEM,LINENO,VALMY,TIUCHNG,RSTRCTD
 ; OK to new TIUCHNG here, this is not used in browse.
 S TIUONCE=1
 S TIUCLASS=$S($G(VALM("ENTITY"))="Progress Note":3,$G(VALM("ENTITY"))="Discharge Summary":244,1:38)
 D FULL^VALM1
 I +$G(DFN) D  Q:+$G(RSTRCTD)
 . S RSTRCTD=$$PTRES^TIULRR(DFN)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",!
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 ; -- MAIN^TIUEDIT looks like:
 ;    MAIN(TIUCLASS,SUCCESS,DFN,TIUTITLE,EVNTFLAG,NOSAVE,
 ;         TIUNDA,TIUSNGL,TIUCHNG)
 ;    i.e. TIUTITLE,EVNTFLAG,NOSAVE,TIUSNGL are null
 D MAIN^TIUEDIT(TIUCLASS,.TIUCREAT,+$G(DFN),"","","",.TIUNDA,"",.TIUCHNG)
 I $G(TIUCHNG("DELETE"))!$G(TIUCHNG("ADDM"))!$G(TIUCHNG("EXIST"))!$G(TIUCHNG("AVAIL")) S TIUCHNG("RBLD")=1
 I +$O(TIUNDA(0))'>0 S TIUCHNG("REFRESH")=1 G ADDX
 ; -- If in TIU OE/RR REVIEW PN, rebuild list and quit:
 I $G(^TMP("TIUR",$J,"RTN"))="TIUROR" S TIUCHNG("RBLD")=1 G ADDX
 ; -- If in Review Notes by Patient (no review screen),
 ;    or rebuilding, don't add elements to end of screen:
 I '$D(^TMP("TIUR",$J,"RTN")) G ADDX
 I $G(TIUCHNG("RBLD")) G ADDX
 ; -- If in an integrated docmts option, add one line
 ;    to screen for each new docmt, refresh list, and quit:
 S TIUNDA=0
 F  S TIUNDA=$O(TIUNDA(TIUNDA)) Q:+TIUNDA'>0  D
 . S TIUITEM=+$G(^TMP("TIUR",$J,0))
 . ; -- Don't add if editing existing docmt which is already in list:
 . S LINENO=$O(^TMP("TIUR",$J,"IEN",TIUNDA,0))
 . I LINENO D  Q
 . . S VALMY(LINENO)="",TIUCHNG("UPDATE")=1
 . D ADDELMNT^TIUR2(TIUNDA,+TIUITEM,1)
 S TIUCHNG("REFRESH")=1
ADDX D UPRBLD^TIURL(.TIUCHNG,.VALMY)
 Q
COPY1 ; -- Call to COPY1 for backward compatibility
 G COPY1^TIURC1
 Q
