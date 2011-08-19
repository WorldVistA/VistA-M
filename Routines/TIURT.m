TIURT ; SLC/JER,MAM - Sign On Chart, etc. ;14-MAR-2001 09:52:41 [1/5/04 11:30am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**71,58,100,176**;Jun 20, 1997
SIGNCHRT ; Mark signed on chart
 N TIUCHNG,TIUI,TIUY,Y,DIROUT
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N TIU,DFN,TIUDA,TIUDATA,RSTRCTD
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=+$P(TIUDATA,U,2) S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",!
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . D EN^VALM("TIU SIGN ON CHART")
 ; -- Update or Rebuild list: --
 S TIUCHNG("UPDATE")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 Q
SIGCHRT1(TIUDA) ; Single record sign on chart
 N SIGMSG D FULL^VALM1
 D OC(TIUDA,.SIGMSG)
 W !,$G(SIGMSG(1)),!,$G(SIGMSG(2)),! H $S($D(SIGMSG(0)):+SIGMSG(0),1:3)
 Q
OC(DA,MSG) ; Mark signed on chart. Edit on-chart signatures.
 N SIGNER,DIE,DR,Y,TIUSTAT,COSIGNER,TIUDA,COSMODE,SIGMODE
 N SIGNAME,COSNAME,SIGTITL,COSTITL,TIU0,TIU12,TIU15,TIU16
 N TIUSFLDS,TIUCFLDS,TIUPSIG,NTIU15
 S MSG=$$READ^TIUU("YO","Mark this Document 'Signed on chart'/Edit Marked Signature(s)","NO","^D OCSIG^TIUDIRH") ; P71 wording
 I 'MSG S TIUCHNG=0 G OCX
 S TIUCHNG=1
 S TIU0=$G(^TIU(8925,+DA,0)),TIU12=$G(^(12)),TIU15=$G(^(15))
 S SIGNER=$$PERSNAME^TIULC1(+$P(TIU12,U,4))
 S COSIGNER=$$PERSNAME^TIULC1(+$P(TIU12,U,8))
 S SIGMODE=$P(TIU15,U,5),COSMODE=$P(TIU15,U,11)
 S TIUSTAT=$$STATUS^TIULC(DA)
 ; P71. Input transform kills null Sig Blk Title but accepts @
 S TIUSFLDS="1501//NOW;1502//"_SIGNER_";S SIGNAME=$$SIGNAME^TIULS(X),SIGTITL=$$SIGTITL^TIULS(X) S:SIGTITL="""" SIGTITL=""@"";1503///^S X=SIGNAME;1504///^S X=SIGTITL;1505////C" ; user edit Signature flds
 S TIUCFLDS="1507//NOW;1508//"_COSIGNER_";S COSNAME=$$SIGNAME^TIULS(X),COSTITL=$$SIGTITL^TIULS(X) S:COSTITL="""" COSTITL=""@"";1509///^S X=COSNAME;1510///^S X=COSTITL;1511////C" ; user edit Co-signature flds
 I TIUSTAT="completed",(SIGMODE="C") S DR=TIUSFLDS ; user edit sig
 I TIUSTAT="completed"&(COSMODE="C") S DR=TIUCFLDS ; user edit co-sig
 I TIUSTAT="uncosigned"&(SIGMODE'="C") S DR=TIUCFLDS ; new co-signature
 I $S(TIUSTAT="unsigned":1,COSMODE="C"&(SIGMODE="C"):1,SIGMODE="C"&(TIUSTAT="uncosigned"):1,1:0) D
 . N TIUWHO
 . I (COSIGNER]""),(SIGNER'=COSIGNER) S TIUWHO=$P($$READ^TIUU("SO^S:signer;C:cosigner;B:both","Which signatures are on chart?","both"),U)
 . E  S TIUWHO="S"
 . ; TIUWHO=S if expsigner=expcosigner or if there is no expcosigner,
 . ; or if user answered S.
 . I $S('$L(TIUWHO):1,"SCB"'[$P(TIUWHO,U):1,1:0) Q
 . I TIUWHO="S" S DR=TIUSFLDS
 . I TIUWHO="C" S DR=TIUCFLDS_";1513////"_DUZ
 . I TIUWHO="B" S DR=TIUSFLDS_";"_TIUCFLDS_";1513////"_DUZ
 I TIUSTAT="uncosigned" S DR=DR_";1513////"_DUZ
 I $D(DR) S DR=DR_";1512////"_DUZ
 I '$D(DR) D  G OCX
 . S MSG(1)="  No signatures available to mark 'Signed on chart' or edit"
 . S TIU16=$G(^TIU(8925,DA,16))
 . I (TIUSTAT="amended"),'$P(TIU16,U,3) S MSG(1)="  'Chart' amendment signatures are automatic; can't edit",MSG(0)="5HANG"
 S DIE=8925 D ^DIE S NTIU15=$G(^TIU(8925,+DA,15))
 D OCDELETE(DA,TIU15,.NTIU15,.MSG)
 ; If user left docmt co-signed but not signed, then stuff signer
 ; with cosigner data (and P71 - avoid ^(15)):
 I $P(NTIU15,U,7),'$P(NTIU15,U) D STUFFSIG(DA,.NTIU15)
 ; P71 If user left docmt signed but uncosigned, and entered expected 
 ; cosigner for signer, then stuff cosigner with signer data:
 I $P(NTIU15,U),'$P(NTIU15,U,7),$P(NTIU15,U,2)=$P(TIU12,U,8) D STUFFCOS(DA,.NTIU15)
 S TIUDA=DA D UPDATE^TIUU
 ; P71 Do alert AFTER status update so alert to cosigner=signer is
 ; deleted if complete:
 S DR=".05///"_$$STATUS^TIULC(+DA),DIE=8925 D ^DIE
 S TIU0=$G(^TIU(8925,DA,0))
 D SEND^TIUALRT(+DA)
 D SIGNIRT^TIUDIRT(+DA)
 ; post-signature action
 S TIUPSIG=$$POSTSIGN^TIULC1(+TIU0)
 I +$L(TIUPSIG),(+$P(TIU0,U,5)>6) X TIUPSIG
OCX I $D(MSG)<10 S MSG(1)="  On chart signature data NOT changed."
 Q
 ;
OCDELETE(DA,TIU15,NTIU15,MSG) ; Clean up data if signers/dates deleted or
 ;                         partially deleted
 N TIUSFLDS,TIUCFLDS,DR,DIE,X,Y
 S TIUSFLDS="1501///@;1502///@;1503///@;1504///@;1505///@"
 S TIUCFLDS="1507///@;1508///@;1509///@;1510///@;1511///@"
 D  ; If user altered sign flds and they are deleted or partially
 . ;  deleted, then delete sign flds:
 . I $P(NTIU15,U)=$P(TIU15,U),$P(NTIU15,U,2)=$P(TIU15,U,2) Q
 . S MSG(1)=$S($P(NTIU15,U)&'$P(TIU15,U):"  Marked 'Signed on chart'",1:"  On chart signature edited")
 . I $P(NTIU15,U)=""!($P(NTIU15,U,2)="") D
 . . S DR=TIUSFLDS,DIE=8925 D ^DIE S NTIU15=$G(^TIU(8925,+DA,15))
 . . S MSG(1)=$S('(($P(NTIU15,U)="")&($P(NTIU15,U,2)="")):"  Incomplete on chart signature. Deleted.",1:"  On chart signature deleted.")
 D  ; If user altered co-sign flds and they are deleted or partially
 . ;  deleted, then delete co-sign flds:
 . I $P(NTIU15,U,7)=$P(TIU15,U,7),$P(NTIU15,U,8)=$P(TIU15,U,8) Q
 . S MSG(2)=$S($P(NTIU15,U,7)&'$P(TIU15,U,8):"  Marked 'Cosigned on chart'",1:"  On chart co-signature edited")
 . I $P(NTIU15,U,7)=""!($P(NTIU15,U,8)="") D
 . . S DR=TIUCFLDS,DIE=8925 D ^DIE S NTIU15=$G(^TIU(8925,+DA,15))
 . . S MSG(2)=$S('(($P(NTIU15,U,7)="")&($P(NTIU15,U,8)="")):"  Incomplete on chart co-signature. Deleted.",1:"  On chart co-signature deleted.")
 D  ; If user deleted sign flds, but docmt is cosigned, then
 . ;  stuff sign data with co-sign data:
 . I $P(NTIU15,U)=$P(TIU15,U),$P(NTIU15,U,2)=$P(TIU15,U,2) Q
 . I $P(NTIU15,U)="",$P(NTIU15,U,7)'="" D STUFFSIG(DA,.NTIU15) S MSG(1)="  On chart signer deleted, auto-replaced with cosigner.",MSG(0)="4HANG"
 D  ; If user deleted co-sign flds, and docmt is signed, and
 . ;           signer = deleted cosigner, then delete sign flds:
 . I $P(NTIU15,U,7)=$P(TIU15,U,7),$P(NTIU15,U,8)=$P(TIU15,U,8) Q
 . I $P(NTIU15,U,7)="",$P(NTIU15,U),$P(NTIU15,U,2)=$P(TIU15,U,8) S DR=TIUSFLDS,DIE=8925 D ^DIE S NTIU15=$G(^TIU(8925,+DA,15)) S MSG(2)="  On chart signatures deleted."
 Q
 ;
STUFFSIG(DA,TIU15) ; Stuff sig flds w/ TIU15 co-sig flds
 ; TIU15 must be current when received, is returned updated.
 N TIUSTUFF,DR,DIE,X,Y
 S TIUSTUFF="1501////"_$$NOW^TIULC_";1502////^S X=$P(TIU15,U,8);1503////^S X=$P(TIU15,U,9);1504////^S X=$P(TIU15,U,10);1505////C" ; stuff Signer data w/ Cosigner data
 S DR=TIUSTUFF,DIE=8925 D ^DIE S TIU15=$G(^TIU(8925,+DA,15))
 ; Editing 1501 resets ACLEC xref even tho' it's cosigned, so until that can be fixed, rekill ACLEC by resetting 1507:
 S DR="1507////"_$$NOW^TIULC,DIE=8925 D ^DIE S TIU15=$G(^TIU(8925,+DA,15))
 Q
 ;
STUFFCOS(DA,TIU15) ; Stuff co-sig flds w/ TIU15 sig flds
 ; TIU15 must be current when received, is returned updated.
 N TIUCTUFF,DR,DIE,X,Y
 S TIUCTUFF="1507////"_$$NOW^TIULC_";1508////^S X=$P(TIU15,U,2);1509////^S X=$P(TIU15,U,3);1510////^S X=$P(TIU15,U,4);1511////C"
 S DR=TIUCTUFF,DIE=8925 D ^DIE S TIU15=$G(^TIU(8925,+DA,15))
 Q
 ;
