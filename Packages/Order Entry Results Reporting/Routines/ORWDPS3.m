ORWDPS3 ; SLC/KCM/JLI - Order Dialogs, Menus;01/18/2006
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85,94,116,132,187,195,215,280**;Dec 17, 1997;Build 85
MEDXFER ; -- setup ORDIALOG for a med that is transferred (from SETUP^ORWDXM4)
 N IVDIALOG,OI K ^TMP("PS",$J)
 S IVDIALOG=$O(^ORD(101.41,"AB","PSJI OR PAT FLUID OE",0))
 S ORDIALOG=$O(^ORD(101.41,"AB","PS MEDS",0))
 I +$P($G(^OR(100,+ORIT,0)),U,5)=IVDIALOG S ORDIALOG=IVDIALOG
 S ORDG=+$P(^ORD(101.41,ORDIALOG,0),U,5)
 D GETDLG^ORCD(ORDIALOG)
 D GETORDER^ORCD("^OR(100,"_+ORIT_",4.5)")
 ;I ORDIALOG=IVDIALOG Q
 S OI=$$VAL^ORCD("MEDICATION")
 I ORDIALOG'=IVDIALOG,'$$MEDOK(OI,ORCAT) D SETERR(ORIT,"This may not be ordered as an "_$S(ORCAT="I":"in",1:"out")_"patient drug.") Q
 I +$G(OI)>0,$G(^ORD(101.43,OI,.1)),(^(.1)<$$NOW^XLFDT) D SETERR(ORIT,"This may no longer be ordered.") Q
 I (ORDIALOG'=IVDIALOG),(ORCAT="I") D OUT^ORCMED
 I (ORDIALOG'=IVDIALOG),(ORCAT="O") D IN^ORCMED
 S ORWPSWRG="" ; force interactive dialog for transfers
 Q
MEDOK(OI,CAT)   ; return 1 if med may be ordered for this patient category
 N P S P=$S(CAT="I":1,1:2)
 I ORIMO S P=1
 N THEGRP,INPTGRP
 S THEGRP=0
 I $D(ORIT),+ORIT S THEGRP=$P($G(^OR(100,+ORIT,0)),U,11)
 S INPTGRP=$O(^ORD(100.98,"B","UD RX",0))
 I P=2,(INPTGRP=THEGRP),($P($G(^ORD(101.43,+OI,"PS")),U,1)=2) Q 2
 E  Q $P($G(^ORD(101.43,+OI,"PS")),U,P)
 ;
SETERR(ID,X)       ; sets LST to rejection with error message
 D GETTXT^ORWORR(.LST,ID)
 S LST(0)="8^0",LST(.5)=X,LST(.6)=""
 Q
 ;
PS ; setup environment for medications
 D AUTHMED Q:$G(ORQUIT)  ; checks authorized to write meds
 K ^TMP("PSJINS",$J),^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 N PROMPT,OI
 S PROMPT=$O(^ORD(101.41,"AB","OR GTX ORDERABLE ITEM",0))
 S OI=""
 I $D(ORDIALOG(PROMPT,1)) S OI=ORDIALOG(PROMPT,1) D MEDACTV Q:$G(ORQUIT)
 N PSOI
 S PSOI=+$P($G(^ORD(101.43,+OI,0)),U,2) D START^PSSJORDF(PSOI,ORCAT)
 S PROMPT=$O(^ORD(101.41,"AB","OR GTX SCHEDULE",0))
 I $D(ORDIALOG(PROMPT,1)) S ORSCH=ORDIALOG(PROMPT,1)
 I (ORCAT="I"),$L($G(ORSCH)) D
 . S ORSD=""
 . I $L($G(^DPT(+ORVP,.1))) S ORSD=$$STARTSTP^PSJORPOE(+ORVP,ORSCH,PSOI,+$G(ORWARD),"")
 . I $P(ORSD,U)="NEXT" S $P(ORSD,U)="NEXTA"
 S PROMPT=$O(^ORD(101.41,"AB","OR GTX DAYS SUPPLY",0))
 I $D(ORDIALOG(PROMPT,1)) S ORDSUP=ORDIALOG(PROMPT,1)
 S PROMPT=$O(^ORD(101.41,"AB","OR GTX DISPENSE DRUG",0))
 I $D(ORDIALOG(PROMPT,1)) S ORDRUG=ORDIALOG(PROMPT,1)
 S PROMPT=$O(^ORD(101.41,"AB","OR GTX REFILLS",0))
 I $D(ORDIALOG(PROMPT,1)) S OREFILLS=ORDIALOG(PROMPT,1)
 I ORCAT="O" S ORCOPAY=$$ASKSC^ORCDPS1
 I ORCAT="I" S PROMPT=$O(^ORD(101.41,"AB","OR GTX START DATE/TIME",0)) D
 . I $L($P($G(ORSD),U)),'$D(ORDIALOG(PROMPT,1)) S ORDIALOG(PROMPT,1)=$P(ORSD,U)
 ; create a SIG if none exists (i.e., when copying pre-POE orders)
 I '$L($G(ORDIALOG($$PTR^ORCD("OR GTX SIG"),1))) D
 . N ORDOSE,ORDRUG,ORWPSOI,PROMPT,DRUG
 . S PROMPT=$$PTR^ORCD("OR GTX INSTRUCTIONS")
 . S ORDRUG=$G(ORDIALOG($$PTR^ORCD("OR GTX DISPENSE DRUG"),1))
 . S ORWPSOI=+$G(ORDIALOG($$PTR^ORCD("OR GTX ORDERABLE ITEM"),1))
 . I ORWPSOI S ORWPSOI=+$P($G(^ORD(101.43,+ORWPSOI,0)),U,2)
 . D DOSE^PSSORUTL(.ORDOSE,ORWPSOI,$S(ORCAT="I":"U",1:"O"),ORVP)       ; dflt doses
 . D D1^ORCDPS2  ; set up ORDOSE & xrefs in ORDIALOG
 . S DRUG=$G(ORDOSE("DD",+ORDRUG))
 . I DRUG,ORCAT="O" D RESETID^ORCDPS
 . D SIG^ORCDPS2
 Q
AUTHMED ; sets ORQUIT if not authorized to write meds
 N NOAUTH,NAME
 D AUTH^ORWDPS32(.NOAUTH,ORNP)
 I +NOAUTH D
 . S ORQUIT=1
 . S LST(0)="8^0"
 . I $P(NOAUTH,U,2)'="" S LST(.5)=$P(NOAUTH,U,2) Q
 . S NAME=$P($G(^VA(200,+ORNP,20)),U,2)
 . I '$L(NAME) S NAME=$P($G(^VA(200,+ORNP,0)),U,1)
 . S LST(.5)=NAME_" is not authorized to write med orders."
 Q
MEDACTV ; sets ORQUIT if the orderable item is not active for a med
 Q:'$G(OI)
 I $G(^ORD(101.43,OI,.1)),^(.1)'>$$NOW^XLFDT D
 . S ORQUIT=1
 . S LST(0)="8^0"
 . S LST(.5)=$P($G(^ORD(101.43,OI,0)),U)_" has been inactivated and may not be ordered anymore."
 I $D(ORQUIT) Q:ORQUIT
 ; copied from ORDITM^ORCDPS1 to make sure quick order if for right dialog
 N ORPS,PSOI,ORIV,ORINPT
 S ORINPT=$$INPT^ORCD
 S ORPS=$G(^ORD(101.43,+OI,"PS")),PSOI=+$P($G(^(0)),U,2)
 S ORIV=$S($P(ORPS,U)=2:1,1:0)
 I $G(ORCAT)="O",'$P(ORPS,U,2),'ORIMO S LST(.5)="This drug may not be used in an outpatient order."
 I $G(ORCAT)="I" D
 . I $G(ORINPT),'$P(ORPS,U),'ORIMO S LST(.5)="This drug may not be used in an inpatient order."
 . I '$G(ORINPT),'ORIV,'ORIMO S LST(.5)="This drug may not be ordered for an outpatient."
 I $L($G(LST(.5))) S ORQUIT=1,LST(0)="8^0"
 Q
