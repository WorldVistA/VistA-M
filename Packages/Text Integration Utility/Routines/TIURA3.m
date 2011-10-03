TIURA3 ; SLC/JER - Review screen actions ; 11/21/07
 ;;1.0;TEXT INTEGRATION UTILITIES;**220,234**;Jun 20, 1997;Build 6
 ; Call to ISA^USRLM supported by DBIA 2324
 ; Call to ISTERM^USRLM supported by DBIA 2712
EDITCOS ; Edit Expected Cosigner
 N TIUDA,TIUDATA,TIUCHNG,TIUI,DIROUT,TIUDAARY
 N TIULST,MSGVERB,TIUXNOD
 S TIUXNOD=$G(XQORNOD(0))
 I $P(TIUXNOD,U,3)="EC" W "Edit Cosigner",! S $P(TIUXNOD,U,4)="EC="_$P($P(TIUXNOD,U,4),"==",2)
 S TIUI=0
 I '$D(VALMY) D EN^VALM2(TIUXNOD)
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N RSTRCTD
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . D CLEAR^VALM1 W !!,"Editing #",+TIUDATA
 . S TIUDA=+$P(TIUDATA,U,2) S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",!
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S TIUDAARY(TIUI)=TIUDA
 . S TIUCHNG=0
 . I +$D(^TIU(8925,+TIUDA,0)) D EDITCOS1
 . I +$G(TIUCHNG) D
 . . S TIULST=$G(TIULST)_$S($G(TIULST)]"":",",1:"")_TIUI
 ; -- Update or Rebuild list, restore video: --
 S TIUCHNG("UPDATE")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 S MSGVERB="edited"
 D VMSG^TIURS1($G(TIULST),.TIUDAARY,MSGVERB)
 Q
EDITCOS1 ; Edit expected cosigner/attending for single record
 ; Receives TIUDA
 I '+$G(TIUDA) W !,"No Documents selected." H 2 Q
 ; Evaluate edit privilege
 N NODE0,STATUS,OK2CHNG,NODE12,REQCOSIG
 N ECSIGNER,ESIGNER,OKCLASS,TIUISDS,DA,DR,DIE,X
 N ALTNODE0,ALTTIUDA,NESIGNR,NECSIGNR,ATTEND,NATTEND,CHKSUM,LNO,MSGNO
 N CANDO,TIUISCP,TIUISCST,TIUISPN,MSG
 ; NECSIGNER,NATTEND etc,(N for new) means post-edit. It may not differ
 ;from the original.  It may be null if the original was null.
 S NODE0=^TIU(8925,TIUDA,0),STATUS=$P(NODE0,U,5),(OK2CHNG,OKCLASS)=1
 S ALTNODE0=NODE0,ALTTIUDA=TIUDA,NODE12=$G(^TIU(8925,TIUDA,12))
 I $$ISADDNDM^TIULC1(TIUDA) D
 . S ALTTIUDA=$P(NODE0,U,6)
 . S ALTNODE0=^TIU(8925,ALTTIUDA,0)
 S TIUISDS=$$ISDS^TIULX(+ALTNODE0),TIUISPN=$$ISPN^TIULX(+ALTNODE0)
 S TIUISCST=$$ISA^TIULX(+ALTNODE0,$$CLASS^TIUCNSLT())
 S TIUISCP=$$ISA^TIULX(+ALTNODE0,$$CLASS^TIUCP())
 I 'TIUISDS,'TIUISPN,'TIUISCST,'TIUISCP D  G COS1X
 . S MSG(1,1)="  This action is permitted only for Progress Notes, Discharge"
 . S MSG(1,2)="Summaries, Clinical Procedures and Consults."
 I STATUS>6 S MSG(2,1)="  This document has already been Completed!" G COS1X
 I STATUS<5 S MSG(3,1)="  This document still needs Release or Verification!" G COS1X
 ;  Status = 5 unsigned or 6 uncosigned:
 ;  Try rules for EDIT COSIGNER:
 S CANDO=$$CANDO^TIULP(TIUDA,"EDIT COSIGNER")
 I 'CANDO S MSG(4,1)="  "_$P(CANDO,U,2) G:STATUS=6 COS1X
 ;  If docmt is unsigned and EDIT COSIGNER rules failed,
 ;    try EDIT RECORD rules:
 I STATUS=5,'CANDO D  G:'CANDO COS1X
 . S CANDO=$$CANDO^TIULP(TIUDA,"EDIT RECORD")
 . I CANDO K MSG(4) Q
 . S MSG(5,1)="  You are not authorized to edit any aspect of this document."
 ; User authorized to change Expected Cosigner/attending:
 S DA=TIUDA,DIE=8925
 ;
 ;                **Docmt is PN, CP or Consult**
 I 'TIUISDS D  G COS1X
 . S ESIGNER=$P(NODE12,U,4)
 . S ECSIGNER=$P(NODE12,U,8)
 . I ESIGNER'>0 S MSG(6,1)="  This document has no Expected Signer!" Q
 . S REQCOSIG=$$REQCOSIG^TIULP(+NODE0,+TIUDA,ESIGNER)
 . ;
 . ;        **Cosig NOT REQUIRED:**
 . I 'REQCOSIG D  Q
 . . ;  Status Uncosigned - Do not permit completion of notes:
 . . I STATUS=6 D  Q
 . . . S MSG(7,1)="  Cosignature is not currently required. This option cannot be"
 . . . S MSG(7,2)="used to change document status to COMPLETED. It looks like the author's"
 . . . S MSG(7,3)="requirement has changed since this document was written."
 . . . S MSG(7,4)="Please contact your CAC and/or HIMS for assistance."
 . . ;  Unsigned, Has no EC:
 . . I ECSIGNER']"" S MSG(8,1)="  ?? Cosignature not required." Q
 . . ;  Unsigned, Has EC:
 . . S MSG(8,1)="  Cosignature not required. Expected Cosigner deleted."
 . . S DR="1208///@;1506///@" D ^DIE S TIUCHNG=1
 . . ;
 . ;        **Cosig REQUIRED:**
 . W !!,"  You may edit the Expected Cosigner:"
 . S DR="1208R//;1506////1" D ^DIE
 . S NECSIGNR=$P(^TIU(8925,TIUDA,12),U,8)
 . I NECSIGNR']"" D  Q
 . . S MSG(9,1)="  Cosignature is required!  Expected Cosigners cannot be alerted "
 . . S MSG(9,2)="until they are designated. "
 . . I STATUS=6 S MSG(9,3)="Please designate an Expected Cosigner as soon as possible!!"
 . I NECSIGNR=ECSIGNER D  Q
 . . W !!,"  Expected Cosigner not changed." H 1
 . W !!,"  Expected Cosigner edited." H 1 S TIUCHNG=1 Q
 ;
 ;                **Docmt is a Discharge Summary. Attending required: **
 S ATTEND=$P($G(^TIU(8925,TIUDA,12)),U,9)
 W !!,"You may edit the Attending Physician:"
 S DR="1209R//" D ^DIE
 S NATTEND=$P(^TIU(8925,TIUDA,12),U,9)
 S MSG("ALERT")="  Attendings cannot be alerted until designated!"
 I NATTEND']0 S MSG(1,1)="  Attending is Required!",MSG(1,2)=MSG("ALERT") G COS1X
 ;  NATTEND is not null. Does it pass screen from TIU*1*219?
 ;  (Needed even after 219 for ^ or Return with no Attending)
 ;  Overwrite most likely msgs with least likely:
 I +$$REQCOSIG^TIULP(+NODE0,+TIUDA,NATTEND) S MSG(2,1)="  This person requires a cosignature. Please select a different Attending.",MSG(2,2)=MSG("ALERT")
 I '$$ISA^USRLM(NATTEND,"PROVIDER") D
 . K MSG(2)
 . S MSG(2,1)="  This person is not in User Class PROVIDER.  Please check User "
 . S MSG(2,2)="Class or select a different Attending."
 . S MSG(2,3)=MSG("ALERT")
 I $$ISTERM^USRLM(NATTEND) K MSG(2) S MSG(2,1)="  This person is terminated! Please select a different Attending.",MSG(2,2)=MSG("ALERT")
 ; Att fails. Restore old att:
 I $D(MSG(2)) D  G COS1X
 . S X=$S((STATUS=5)&(ATTEND']""):"@",1:ATTEND),DR="1209////" D ^DIE
 ; Attending exists and is good:
 S NESIGNR=$$WHOSIGNS^TIULC1(DA),NECSIGNR=$$WHOCOSIG^TIULC1(DA)
 S DR="1204////^S X=NESIGNR"
 S DR=DR_";1208////^S X=NECSIGNR"
 S DR=DR_";1506////^S X=$S(+NESIGNR=+NATTEND:0,1:1)"
 D ^DIE
 I NATTEND=ATTEND D  G COS1X
 . W !!,"  Attending Physician not changed." H 1
 ; New Attend Changed - Go on to audit
 W !!,"  Attending Physician edited." S TIUCHNG=1 H 1
COS1X ;
 I $G(TIUCHNG) D
 . D SEND^TIUALRT(TIUDA)
 . Q:$G(STATUS)'=6  D  ; Audit uncosigned docmts only
 . S CHKSUM=+$$CHKSUM^TIULC("^TIU(8925,"_+TIUDA_",""TEXT"")")
 . D AUDIT^TIUEDI1(TIUDA,CHKSUM,CHKSUM)
 I $D(MSG) W ! F MSGNO=1:1:9 D
 . F LNO=1:1:10 Q:'$D(MSG(MSGNO,LNO))  W !,MSG(MSGNO,LNO)
 I $D(MSG),$$READ^TIUU("EA","RETURN to continue...")
 Q
