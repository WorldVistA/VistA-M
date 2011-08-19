TIURA1 ; SLC/JER - Review screen actions ;3/5/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**20,88,58,100**;Jun 20, 1997
ADDEND ; Make addenda
 N TIUDA,TIUDATA,TIUCHNG,TIUI,DIROUT,TIULST,TIUDAARY
 S TIUI=0
 ; -- Get docmt to addend: --
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N RSTRCTD
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . D CLEAR^VALM1 W !!,"Making an addendum for #",+TIUDATA
 . ; -- Addend it: --
 . S TIUDA=+$P(TIUDATA,U,2) S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",! ; Echo denial message
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S TIUDAARY(TIUI)=TIUDA
 . S TIUCHNG=0
 . I +$D(^TIU(8925,+TIUDA,0)) D ADDEND1
 . I +$G(TIUCHNG) D
 . . S TIULST=$G(TIULST)_$S($G(TIULST)]"":",",1:"")_TIUI
 ; -- Update or Rebuild list, restore video:
 I $G(TIUCHNG("ADDM"))!$G(TIUCHNG("DELETE")) S TIUCHNG("RBLD")=1
 E  S TIUCHNG("UPDATE")=1 ; user may have edited existing addm
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 D VMSG^TIURS1($G(TIULST),.TIUDAARY,"addended")
 Q
ADDEND1 ; Single record Addendum
 ; Receives TIUDA
 N %X,%Y,C,D,D0,DDWTMP,DFN,DI,DIC,TIUEDIT,TIUMSG,TIUQUIT,TIUADD,TIUREL
 N TIUTYP,TIUT0,TIUDPRM
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 I '+$G(TIUDA) W !,"No Documents selected." H 2 Q
 D ADDENDUM^TIUADD(TIUDA,"",.TIUCHNG,1)
 Q
NAME ; Identify signer(s)
 N TIUCHNG,TIUDA,DFN,TIU,TIUDATA,TIUEDIT,TIUI,TIUY,TIULST,Y,DIROUT
 N TIUDAARY
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 I +$O(VALMY(0)) D FULL^VALM1
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N TIU,VALMY,XQORM,RSTRCTD
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=+$P(TIUDATA,U,2) S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",! ; Echo denial message
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S TIUDAARY(TIUI)=TIUDA
 . S TIUCHNG=0
 . D SIGNER ; SIGNER initializes TIUCHNG to 0
 . I +$G(TIUCHNG) S TIULST=$G(TIULST)_$S($G(TIULST)]"":",",1:"")_TIUI
NAMEX ; Revise list and cycle back as appropriate
 S TIUCHNG("REFRESH")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 D VMSG^TIURS1($G(TIULST),.TIUDAARY,"Signers identified/edited")
 Q
SIGNER ; Link selected document to additional signers
 ; Receives TIUDA as pointer to document record
 N TIULIST,TIUI,TIUMORE,TIUCANID S (TIUCHNG,TIUI)=0,TIUMORE=1
 S TIUCANID=$$CANDO^TIULP(TIUDA,"IDENTIFY SIGNERS")
 I +$$MAYCHNG(TIUDA) D  Q:'TIUMORE
 . N TIUPRMT S TIUPRMT="Do you Wish to Identify Additional Signers"
 . D CHNGCSNR(TIUDA) S TIUCHNG=1
 . I +$G(TIUCANID) S TIUMORE=$$READ^TIUU("YO",TIUPRMT,"NO")
 . I +$G(TIUCANID)'>0 S TIUMORE=0
 I +$G(TIUCANID)'>0 D  Q
 . W !!,$C(7),$P(TIUCANID,U,2),! ; Echo denial message
 . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 I +$O(^TIU(8925.7,"B",TIUDA,0)) D  Q:+TIUMORE'>0
 . N DIDEL,DIE,DA,DR,TIUY,TIUPRMT
 . W !,"This Document Already has Additional Expected Signers."
 . D XTRASIGN^TIULX(.TIUY,TIUDA) Q:+$O(TIUY(0))'>0
 . S DA=+$$ASKSIGN^TIULX(.TIUY) Q:+DA'>0
 . S (DIE,DIDEL)=8925.7,DR=".03;I +X>0 S Y=""@1"";.01///@;@1" D ^DIE
 . D SEND^TIUALRT(TIUDA) S TIUCHNG=1
 . S TIUPRMT="Do You Wish to Identify More Additional Signers"
 . S TIUMORE=$$READ^TIUU("Y",TIUPRMT,"NO")
 D PERSEL(.TIULIST,TIUDA) Q:+$D(TIULIST)'>9
 F  S TIUI=$O(TIULIST(TIUI)) Q:+TIUI'>0  D
 . N DA,DIC,DIE,DLAYGO,DR,X,Y
 . S X=""""_"`"_TIUDA_"""",(DIC,DLAYGO)=8925.7,DIC(0)="LX" D ^DIC Q:+Y'>0
 . S DIE=DIC
 . S DR=".02////"_0_";.03////"_+$G(TIULIST(TIUI))
 . D ^DIE
 . W !,$$SIGNAME^TIULS(+TIULIST(TIUI))," Added as expected signer..." H 2
 . D SEND^TIUALRT(TIUDA)
 . S TIUCHNG=1 K VALMY(TIUI)
 Q
MAYCHNG(TIUDA) ; Boolean function - can cosigner be modified?
 N TIUD0,TIUD12,TIUY,TIUAUTH,TIUESNR,TIUECSNR S TIUY=0
 S TIUD0=$G(^TIU(8925,+TIUDA,0)),TIUD12=$G(^TIU(8925,+TIUDA,12))
 S TIUAUTH=$P(TIUD12,U,2),TIUESNR=$P(TIUD12,U,4),TIUECSNR=$P(TIUD12,U,8)
 I +TIUECSNR,(+$P(TIUD0,U,5)<7) D
 . S TIUY=$S(DUZ=TIUAUTH:1,DUZ=TIUESNR:1,DUZ=TIUECSNR:1,1:0)
 Q TIUY
CHNGCSNR(DA) ; Change the expected cosigner
 N DR,DIE,X,Y
 W !,"You may change the expected cosigner, if you wish...",!
CHNGAGN S DIE=8925,DR="1208R" D ^DIE
 I +$P($G(^TIU(8925,DA,12)),U,8)'>0 W !,$C(7),"  Response Required." G CHNGAGN
 D SEND^TIUALRT(DA)
 Q
PERSEL(TIUY,TIUDA) ; Select a person
 N TIUQUIT,TIUPRSN,TIUI,TIUPRMT,TIUSCRN S (TIUI,TIUQUIT)=0
 W !!,"Specify other practitioners whose signatures will be  expected:",!
 F  D  Q:+TIUQUIT
 . S TIUI=TIUI+1,TIUPRMT=$J(TIUI,3)_")  "
 . S TIUSCRN="I +$$SCREEN^TIURA1(TIUDA,+Y)"
 . S TIUPRSN=$$READ^TIUU("PAO^200:AEMQ",TIUPRMT,"","",TIUSCRN)
 . I +TIUPRSN'>0 S TIUQUIT=1 Q
 . S TIUY(TIUI)=TIUPRSN
 W !
 Q
SCREEN(TIUDA,Y) ; Evaluate whether a person may be selected as a signer
 N TIUI,TIUY,TIUD0,TIUD12 S TIUY=1 ; most people may be selected
 S TIUD0=$G(^TIU(8925,+TIUDA,0)),TIUD12=$G(^TIU(8925,+TIUDA,12))
 ; A user may NOT select himself
 I Y=+$G(DUZ) S TIUY=0 G SCREENX
 ; Author may NOT be selected
 I Y=+$P(TIUD12,U,2) S TIUY=0 G SCREENX
 ; Expected Signer may NOT be selected
 I Y=+$P(TIUD12,U,4) S TIUY=0 G SCREENX
 ; Can't choose a terminated user
 I '+$$ACTIVE^XUSER(+Y) S TIUY=0 G SCREENX
 ; Can't name the same signer twice
 I +$O(^TIU(8925.7,"AE",+TIUDA,+Y,0)) S TIUY=0 G SCREENX
 S TIUI=0
 F  S TIUI=$O(TIULIST(TIUI)) Q:+TIUI'>0!(TIUY=0)  D
 . I +$G(TIULIST(TIUI))=+Y S TIUY=0
 I +TIUY=0 G SCREENX
 ; Expected Cosigner may NOT be selected
 I Y=+$P(TIUD12,U,8) S TIUY=0
SCREENX Q +$G(TIUY)
ENCNTR ; Enter/edit encounter data on demand
 N TIUCHNG,TIUDA,DFN,TIU,TIUDATA,TIUI,TIUY,TIULST,Y,DIROUT
 N TIUDAARY
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 I +$O(VALMY(0)) D FULL^VALM1
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N TIU,VALMY,XQORM,RSTRCTD
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=+$P(TIUDATA,U,2) S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",! ; Echo denial message
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S TIUDAARY(TIUI)=TIUDA
 . S TIUCHNG=0
 . D EDTENC^TIUPXAP2(TIUDA,.TIUCHNG)
 . I +$G(TIUCHNG) S TIULST=$G(TIULST)_$S($G(TIULST)]"":",",1:"")_TIUI
ENCNTX ; Revise list and cycle back as appropriate
 S TIUCHNG("REFRESH")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 D VMSG^TIURS1($G(TIULST),.TIUDAARY,"Encounter Data Edited")
 Q
CHARTANY(VALMY) ; Can any of the selected items be printed for the chart?
 N TIUDATA,TIUDA,TIUI,TIUY S (TIUI,TIUY)=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:+TIUY
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=+$P(TIUDATA,U,2)
 . S TIUY=+$$CHARTONE(TIUDA)
 Q TIUY
CHARTONE(TIUDA) ; Can this document be printed for the chart?
 N TIUDTYP,TIUDPRM
 S TIUDTYP=+$G(^TIU(8925,TIUDA,0))
 D DOCPRM^TIULC1(TIUDTYP,.TIUDPRM,TIUDA)
 Q +$P(TIUDPRM(0),U,9)
