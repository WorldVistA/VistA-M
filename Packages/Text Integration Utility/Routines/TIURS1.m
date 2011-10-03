TIURS1 ; SLC/JER - Additional /es/ actions ;1/18/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**7,36,58,100,109,142,156,184,233**;Jun 20, 1997;Build 3
 ;12/11/00 Moved ELSIG,MULTIPRN,LIST here from TIURS
ELSIG ; Sign rec
 N TIULST,TIUSLST,TIURJCT,TIUES,TIUI,X,X1,Y,TIUDAARY,TIUCHNG
 I '$D(TIUPRM0) D SETPARM^TIULE
 I $P(TIUPRM0,U,2)'>0 W !,"Electronic signature not yet enabled." H 3 G ELSIGX
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0 I $D(VALMY)>9 D CLEAR^VALM1
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D
 . N TIU0,TIU12,TIUSTAT,TIUEVNT,TIUTYPE,TIUPOP,TIU15,TIUDPRM
 . N ASK,SIGNER,COSIGNER,XTRASGNR,TIUDATA,TIUDA,RSTRCTD
 . S (ASK,TIUPOP)=0
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=$P(TIUDATA,U,2) S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",! ; Echo denial message
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S TIU0=$G(^TIU(8925,+TIUDA,0)),TIU12=$G(^(12)),TIU15=$G(^(15))
 . S SIGNER=$S(+$P(TIU12,U,4):$P(TIU12,U,4),1:$P(TIU12,U,2))
 . S COSIGNER=$P(TIU12,U,8)
 . I (DUZ'=SIGNER),(DUZ'=COSIGNER) S XTRASGNR=+$O(^TIU(8925.7,"AE",+TIUDA,+DUZ,0))
 . S TIUSTAT=+$P(TIU0,U,5)
 . S TIUTYPE=$$PNAME^TIULC1(+TIU0)
 . S TIUEVNT=$S(TIUSTAT'>5:"SIGNATURE",+$G(XTRASGNR):"SIGNATURE",1:"COSIGNATURE")
 . D DOCPRM^TIULC1(+TIU0,.TIUDPRM,TIUDA)
 . S ASK=$$CANDO^TIULP(TIUDA,TIUEVNT)
 . I +ASK>0 D
 . . L +^TIU(8925,+TIUDA):1
 . . E  S ASK="0^ Another user is editing this entry."
 . I +ASK'>0,$P(ASK,U,2)]"" D  I 1
 . . D FULL^VALM1
 . . W !!,"Item #",TIUI,": ",$P(ASK,U,2),! K VALMY(TIUI)
 . . W !,"Removed from signature list.",!
 . . I $$READ^TIUU("FOA","Press RETURN to continue...")
 . E  D
 . . ;If document is a clinical procedures title AND (P184) this is not an additional signature, check if clinical
 . . ;procedure fields are required.  If the fields are required, prompt for
 . . ;them and don't permit the user to sign unless the fields are defined.
 . . I '$G(XTRASGNR),+$$ISA^TIULX(+TIU0,+$$CLASS^TIUCP),$$REQCPF^TIULP(+$P($G(^TIU(8925,+TIUDA,14)),U,5)) D  Q:+TIUPOP
 . . . N TIUCPFLD
 . . . W !!,"Item #",TIUI,": ",TIUTYPE," for "
 . . . W $$PTNAME^TIULC1($P(TIU0,U,2))," will need Procedure Summary Code and Date/Time Performed..."
 . . . I $G(^TIU(8925,+TIUDA,702)),$P(^(702),U)]"",$P(^(702),U,2)]"" S TIUCPFLD=1 Q
 . . . S TIUCPFLD=$$ASKCPF^TIURS(TIUDA)
 . . . I +TIUCPFLD'>0 D
 . . . . S TIUPOP=1
 . . . . W !!,"Item #",TIUI,": MUST have a Procedure Summary Code and Date/Time Performed",!,"before you may sign."
 . . . . W !!,"Removed from signature list.",!
 . . . . I $$READ^TIUU("FOA","Press RETURN to continue...")
 . . ; VMP/RJT - *233
 . . I $S(+$$REQCOSIG^TIULP(+TIU0,+TIUDA,DUZ):1,+$P(TIU15,U,6):1,1:0),(+$P(TIU12,U,8)'>0),'+$G(XTRASGNR)   D  Q:+TIUPOP
 . . . N COSIGNER
 . . . W !!,"Item #",TIUI,": ",TIUTYPE," for "
 . . . W $$PTNAME^TIULC1($P(TIU0,U,2))," will need cosignature..."
 . . . S COSIGNER=$$ASKCSNR^TIURS(TIUDA,DUZ)
 . . . I +COSIGNER'>0 D
 . . . . S TIUPOP=1
 . . . . W !!,"Item #",TIUI,": MUST have a cosigner, before you may sign."
 . . . . W !!,"Removed from signature list.",!
 . . . . I $$READ^TIUU("FOA","Press RETURN to continue...")
 . . N TIU,TIUY
 . . D EN^VALM("TIU SIGN/COSIGN")
 I $D(TIUSLST)'>9 D  G ELSIGX
 . S VALMSG="** Signature List Empty...Nothing signed. **"
 I $D(TIUSLST)>9 D
 . N TIUIO
 . S TIUES=$$ASKSIG^TIULA1
 . I '+TIUES S VALMSG="** Nothing Signed. **" D FIXLSTNW^TIULM Q
 . D FULL^VALM1
 . D MULTIPRN(.TIUSLST,.TIUIO)
 . S TIUI=0 F  S TIUI=$O(TIUSLST(TIUI)) Q:+TIUI'>0  D
 . . N TIUPY,XTRASGNR
 . . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI)),TIUDA=$P(TIUDATA,U,2)
 . . S TIUDAARY(TIUI)=TIUDA
 . . S TIULST=$G(TIULST)_$S($G(TIULST)]"":",",1:"")_TIUI
 . . S XTRASGNR=+$P(TIUSLST(TIUI),U,3)
 . . I +$G(XTRASGNR) D ADDSIG^TIURS1(TIUDA,XTRASGNR)
 . . I '+$G(XTRASGNR) D ES^TIURS(TIUDA,TIUES)
 . . I +TIUSLST(TIUI),(TIUIO]"") D RPC^TIUPD(.TIUPY,TIUDA,TIUIO,$P(TIUSLST(TIUI),U,2))
 . D FULL^VALM1
ELSIGX I $G(TIUCHNG("ADDM"))!$G(TIUCHNG("DELETE")) S TIUCHNG("RBLD")=1
 E  S TIUCHNG("UPDATE")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 D VMSG($G(TIULST),.TIUDAARY,"signed")
 Q
VMSG(TIULST,TIUDAARY,ACTION) ; Set VALMSG for messagebar, bold changed items
 N TIUI,LINENO,ACTFIRST
 S ACTFIRST=$S(ACTION="Encounter Data Edited":1,ACTION="Signers identified/edited":1,ACTION="Title changed":1,1:0)
 I TIULST']"" D  Q
 . I ACTFIRST S VALMSG="** No changes made. **" Q
 . S VALMSG="** Nothing "_ACTION_". **"
 I ACTION="copied" S ACTION="copied; See end of list"
 S TIULST=$$NEWLST(TIULST,.TIUDAARY)
 I TIULST]"" D
 . I ACTFIRST D  Q
 . . S VALMSG="** "_ACTION_" for item"_$S($L(TIULST,",")>1:"s ",$L(TIULST,"-")>1:"s ",1:" ")_TIULST_". **"
 . S VALMSG="** Item"_$S($L(TIULST,",")>1:"s ",$L(TIULST,"-")>1:"s ",1:" ")_TIULST_" "_ACTION_". **"
 I TIULST']"" D
 . I ACTFIRST D  Q
 . . S VALMSG="** "_ACTION_"; item(s) no longer in list. **"
 . S VALMSG="** Item"_$S($L(TIULST,",")>1:"s ",$L(TIULST,"-")>1:"s ",1:" ")_TIULST_" "_ACTION_", no longer in list. **"
 . ;S VALMSG="** Item(s) "_ACTION_", no longer in list. **"
 Q:$G(^TMP("TIUR",$J,"RTN"))="TIUROR"
 F TIUI=1:1 S LINENO=$P(TIULST,", ",TIUI) Q:'LINENO  D
 . D CNTRL^VALM10(LINENO,1,$G(VALM("RM")),IOINHI,IOINORM)
 Q
NEWLST(TIULST,TIUDAARY) ; Return TIULST with updated item numbers
 N TIUI,TIULNO,TIUDA,TIUNLNO,TIUNLST
 S TIUNLST=""
 F TIUI=1:1 S TIULNO=$P(TIULST,",",TIUI) Q:'TIULNO  D
 . S TIUDA=TIUDAARY(TIULNO),TIUNLNO=$O(^TMP("TIUR",$J,"IEN",TIUDA,0))
 . I TIUNLNO S TIUNLST=$G(TIUNLST)_$S($G(TIUNLST)]"":", ",1:"")_TIUNLNO
 Q TIUNLST
 ;
MULTIPRN(TIUSLST,TIUIO) ; ask device
 N TIUI,TIUASK,TIUION,TIUPOK,IO,TIUPLIST,TIUSCRN S (TIUI,TIUPOK)=0
 F  S TIUI=$O(TIUSLST(TIUI)) Q:TIUI'>0!+TIUPOK  S:+TIUSLST(TIUI) TIUPOK=1
 I '+TIUPOK S TIUIO="" Q
 S TIUPLIST=$$LIST(.TIUSLST)
 W !!,"Please specify the device for printing item"
 W $S(TIUPLIST[",":"s",TIUPLIST["-":"s",1:""),": ",TIUPLIST,!!
 S TIUSCRN="I $L($G(^%ZIS(1,+Y,""TYPE""))),("";HFS;MT;BAR;VTRM;RES;CHAN;IMPC;""'[("";""_^(""TYPE"")_"";""))"
 S TIUION=$$DEVICE^TIUDEV(.TIUIO,"LAST","N",TIUSCRN,"Q")
 I '$L(TIUION) S TIUIO=""
 D ^%ZISC
 Q
LIST(LIST) ; build print list
 N TIUY,TIUI S TIUI=0
 F  S TIUI=$O(LIST(TIUI)) Q:+TIUI'>0  D
 . S:+LIST(TIUI) TIUY=$G(TIUY)_$S($G(TIUY)]"":", ",1:"")_TIUI
 Q $G(TIUY)
 ;
ADDSIG(TIUDA,DA) ; Apply extra signatures to a document
 N DIE,DR
 S DIE=8925.7
 S DR=".04////"_$$NOW^TIULC_";.05////"_DUZ_";.06///^S X=$$SIGNAME^TIULS("_DUZ_");.07///^S X=$$SIGTITL^TIULS("_DUZ_");.08////E"
 D ^DIE
 D SEND^TIUALRT(TIUDA)
 Q
CNVPOST ; Change Titles/Convert Postings
 N TIUI,TIULST,Y,TIUVIEW,TIUCHNG,TIUDAARY
 I $G(TIUGLINK) W !,"Please finish attaching the interdisciplinary note before changing title.",! H 3 Q
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 I +$O(VALMY(0)) D FULL^VALM1
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N TIU,TIUDA,DFN,TIUDATA,VALMY,XQORM,TIUVIEW,RSTRCTD
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=+$P(TIUDATA,U,2) S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",! ; Echo denial message
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S TIUVIEW=$$CANDO^TIULP(TIUDA,"VIEW")
 . I +TIUVIEW'>0 D  Q  ; Exclude records user can't view
 . . W !!,$C(7),$P(TIUVIEW,U,2),! ; Echo denial message
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S TIUCHNG=0
 . D EN^VALM("TIU CHANGE TITLE")
 . S TIUDAARY(TIUI)=TIUDA
 . I +$G(TIUCHNG) S TIULST=$G(TIULST)_$S($G(TIULST)]"":",",1:"")_TIUI
 ; -- Update list: --
 S TIUCHNG("UPDATE")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 D VMSG($G(TIULST),.TIUDAARY,"Title changed")
 Q
CNVPOST1 ; Convert Single Posting to another title
 N TIUD0,DIE,DR,TIUTITL,CHKSUM,TIUCHTTL,TIUCLSS,TIUCON,TIUQUIT
 N DA,X,Y
 ; Added TIUCON for **142
 S TIUD0=$G(^TIU(8925,TIUDA,0)),TIUCHNG=0
 ; Added TIUNOCS for **142
 D FULL^VALM1
 I +TIUD0=81 S TIUCHTTL="0^You may not change the TITLE of an ADDENDUM."
 I '$D(TIUCHTTL) S TIUCHTTL=$$CANDO^TIULP(TIUDA,"CHANGE TITLE")
 I +TIUCHTTL,$$DADORKID^TIUGBR(TIUDA) S TIUCHTTL="0^Interdisciplinary entries must be detached before changing titles." ;**100
 I +TIUCHTTL'>0 D  Q
 . W !!,$C(7),$P(TIUCHTTL,U,2),! ; Echo denial
 . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 L +^TIU(8925,TIUDA,0):1
 E  D  Q
 . W !!?5,$C(7),"Another user is editing this entry.",! ; Echo denial
 . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 S TIUTITL=$$ASKTITLE^TIULA3(+$$CLINDOC^TIULC1(+TIUD0,TIUDA),+TIUD0)
 S TIUCLSS=$$CLASS^TIUCNSLT()
 S TIUCON=+$$ISA^TIULX(TIUTITL,TIUCLSS)
 I TIUCON=1,+TIUD0'=TIUTITL D CHANGE^TIUCNSLT(TIUDA,"",.TIUNOCS)
 I $G(TIUNOCS)=-1 D  G POST1Q
 . I $$READ^TIUU("EA","Press RETURN to continue...")  ; **142
 ;*184->
 D CONSCT^TIUCNSLT(TIUDA,+TIUD0,TIUTITL)
 D PRFCT^TIUPRF1(+TIUD0,TIUTITL,TIUDA)
 ;<-*184
 I $G(TIUQUIT)=1 G POST1Q
 S DIE=8925,DA=TIUDA
 S DR=".01////^S X="_TIUTITL_";.04////^S X="_$$DOCCLASS^TIULC1(TIUTITL)
 D ^DIE
 I +$G(^TIU(8925,+TIUDA,0))'=+TIUD0 S TIUCHNG=1
 S CHKSUM=+$$CHKSUM^TIULC("^TIU(8925,"_+TIUDA_",""TEXT"")")
 D AUDIT^TIUEDI1(TIUDA,CHKSUM,CHKSUM)
POST1Q ;clean up, linetag put in with *171
 L -^TIU(8925,TIUDA,0)
 K TIUNOCS
 Q
