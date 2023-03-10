ORWDPS33 ;SLC/KCM - Pharmacy Calls for GUI Dialog ;Aug 05, 2022@12:24:43
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243,280,350,405**;Dec 17, 1997;Build 211
 ;Per VHA Directive 6402, this routine should not be modified.
 ;This routine move several RPCs from ORWDPS32 because of the routine size
 ; Reference to DSUP^PSOSIGDS in ICR #3278
 ;
COMPLOC(ORY,ORID,LOC) ;
 S ORY=0
 I LOC'=+$P($G(^OR(100,+ORID,0)),U,10) S ORY=1
 Q
DOSES(LST,OI) ; return doses for an orderable item  -  TEST ONLY
 N ORTMP,ORI,ORJ,ILST,LSTA,NDF,ORWDRG,VAPN,X,PSTYPE S PSTYPE="O"
 D ENDD^PSJORUTL("^^^"_+$P($G(^ORD(101.43,OI,0)),"^",2),PSTYPE,.ORTMP)
 S ORI=0 F  S ORI=$O(ORTMP(ORI)) Q:'ORI  S ORWDRG=+ORTMP(ORI) D
 . K ^TMP($J,"ORWDPS32 DRUG")
 . D NDF^PSS50(+ORWDRG,,,,,"ORWDPS32 DRUG")
 . S VAPN=$P($G(^TMP($J,"ORWDPS32 DRUG",+ORWDRG,22)),U),NDF=$P($G(^TMP($J,"ORWDPS32 DRUG",+ORWDRG,20)),U)
 . S X=$$DFSU^PSNAPIS(NDF,VAPN)
 . S LSTA($P(X,U,4),$P(X,U,6))=""
 . I +$P(X,U,4)=$P(X,U,4) S LSTA($P(X,U,4)*2,$P(X,U,6))=""
 K ^TMP($J,"ORWDPS32 DRUG")
 S ORI="",ILST=0 F  S ORI=$O(LSTA(ORI)) Q:ORI=""  D
 . S ORJ="" F  S ORJ=$O(LSTA(ORI,ORJ)) Q:ORJ=""  D
 . . S ILST=ILST+1,LST(ILST)=ORI_" "_ORJ
 Q
 ;
DRUGMSG(VAL,IEN)        ; return any message associated with a dispense drug
 N X S X=$$ENDCM^PSJORUTL(IEN)
 S VAL=$P(X,U,2)_U_$P(X,U,4)
 Q
 ;
FORMALT(ORLST,IEN,PSTYPE) ; return a list of formulary alternatives
 D ENRFA^PSJORUTL(IEN,PSTYPE,.ORLST)
 N I,OI S I=0 F  S I=$O(ORLST(I)) Q:'I  D
 . S OI=+$O(^ORD(101.43,"ID",+$P(ORLST(I),U,4)_";99PSP",0))
 . S $P(ORLST(I),U,4)=OI I OI S $P(ORLST(I),U,5)=$P(^ORD(101.43,OI,0),U)
 Q
 ;
GETADDFR(ORY,OIIEN) ;
 N PSOI,TEMP
 S ORY=""
 S PSOI=+$P($G(^ORD(101.43,OIIEN,0)),U,2)
 S TEMP=$$IV^PSSDSAPA(PSOI)
 S ORY=$$ADDFRQCV^ORMBLDP1(TEMP,"I")
 Q
 ;
ISVALIV(RESULT,ORID,ACTION) ;
 N ARRAY,CNT,ID,IVD,CLIVD,NUM,ORDERID,OUTPUT,ROUTE,ROUTEID,TYPE
 S TYPE=$S(ACTION="XFR":"transfered",ACTION="RN":"renewed",1:"copied")
 S IVD=$O(^ORD(101.41,"B","PSJI OR PAT FLUID OE",""))
 S CLIVD=$O(^ORD(101.41,"B","CLINIC OR PAT FLUID OE",""))
 I IVD=0,CLIVD=0 Q
 I +$P($G(^OR(100,+ORID,0)),U,5)'=IVD,+$P($G(^OR(100,+ORID,0)),U,5)'=CLIVD Q
 S ORDERID="",ROUTEID="",CNT=0
 F  S ORDERID=$O(^OR(100,+ORID,4.5,"ID","ORDERABLE",ORDERID)) Q:ORDERID'>0  D
 .I +$G(^OR(100,+ORID,4.5,ORDERID,1))'>0 Q
 .S CNT=CNT+1,ARRAY(CNT)=^OR(100,+ORID,4.5,ORDERID,1)
 S ROUTEID=+$O(^OR(100,+ORID,4.5,"ID","ROUTE","")) I ROUTEID'>0 D  Q
 .S RESULT="This order contains an invalid route. It cannot be "_TYPE_"."
 S ROUTE=+$G(^OR(100,+ORID,4.5,ROUTEID,1)) I ROUTE'>0 D  Q
 .S RESULT="This order contains an invalid route. It cannot be "_TYPE_"."
 S OUTPUT=$$IVQOVAL(.ARRAY,ROUTE) I OUTPUT="" D
 .;S TYPE=$S(ACTION="XFR":"transfered",ACTION="RN":"renewed",1:"copied")
 .S RESULT="This order contains an invalid route. It cannot be "_TYPE_"."
 I RESULT'="" Q
 N IVTYPE,IVTYPEID,INFUSEID,INFUSE
 S IVTYPEID=+$O(^OR(100,+ORID,4.5,"ID","TYPE","")) I IVTYPEID'>0 D  Q
 .S RESULT="This order contains an  invalid IV Type. It cannot be "_TYPE_"."
 S IVTYPE=$G(^OR(100,+ORID,4.5,IVTYPEID,1)) I IVTYPE="" D  Q
 .S RESULT="This order contains an invalid IV Type. It cannot be "_TYPE_"."
 S INFUSEID=+$O(^OR(100,+ORID,4.5,"ID","RATE","")) Q:INFUSEID'>0
 S INFUSE=$G(^OR(100,+ORID,4.5,INFUSEID,1)) Q:INFUSE=""
 I $$VALINF^ORWDXM3(IVTYPE,INFUSE)=0 D
 .;S TYPE=$S(ACTION="XFR":"transfered",ACTION="RN":"renewed",1:"copied")
 .S RESULT="This order contains an invalid infusion rate. It cannot be "_TYPE_"."
 ;//AGP IV ADDITIVE FREQUENCY
 I IVTYPE="C",ACTION="RN" D
 .N ADDCNT,ADDIEN,ADDFCNT,SUB
 .S ADDIEN=$$PTR^ORCD("OR GTX ADDITIVE")
 .S ADDCNT=0,ADDFCNT=0,SUB=0
 .F  S SUB=$O(^OR(100,+ORID,4.5,"ID","ORDERABLE",SUB)) Q:SUB'>0  D
 ..I $P($G(^OR(100,+ORID,4.5,SUB,0)),U,2)'=ADDIEN Q
 ..S ADDCNT=ADDCNT+1
 .S SUB=0
 .F  S SUB=$O(^OR(100,+ORID,4.5,"ID","ADDFREQ",SUB)) Q:SUB'>0  S ADDFCNT=ADDFCNT+1
 .I ADDCNT'=ADDFCNT S RESULT="This order does not contain the same number of values for the Additives and the IV Additive Frequency prompts. It cannot be renewed."
 Q
 ;
IVQOVAL(ARRAY,ROUTE) ;
 N CNT,RARR,RESULT
 S RESULT=""
 D IVDOSFRM(.RARR,.ARRAY,1)
 S CNT="" F  S CNT=$O(RARR(CNT)) Q:CNT'>0!(RESULT'="")  D
 .I $P(RARR(CNT),U)=ROUTE S RESULT=RARR(CNT) Q
 Q RESULT
 ;
IVDOSFRM(LST,ORDERIDS,ALLIV) ;
 N ORARRAY,CNT,CNT1,OI,POI
 S OI="",CNT=0,CNT1=0
 F  S OI=$O(ORDERIDS(OI)) Q:OI'>0  D
 .S POI=+$P($G(^ORD(101.43,$G(ORDERIDS(OI)),0)),U,2) Q:POI'>0
 .S CNT=CNT+1
 .S ORARRAY(CNT)=POI
 I CNT=0 Q
 S ORARRAY(0)=CNT
 D START1^PSSJORDF(.ORARRAY,ALLIV)
 S CNT="" F  S CNT=$O(ORARRAY(CNT)) Q:CNT'>0  D
 .S CNT1=CNT1+1,LST(CNT1)=$G(ORARRAY(CNT))
 ;this temp should be killed by Pharmacy. This will be removed once
 ;Pharmacy send an update
 K ^TMP("PSJMR",$J)
 Q
 ;
IVIND(LST,ORDERIDS) ;*405-IND
 N CNT,OI,POI,LST1,LST2,TEXT
 S OI=0
 F  S OI=$O(ORDERIDS(OI)) Q:'OI  D
 .S POI=+$P($G(^ORD(101.43,ORDERIDS(OI),0)),U,2) Q:'POI
 .K LST1
 .D INDICAT2^ORWDPS2(.LST1,POI)
 .Q:'$D(LST1)
 .S CNT=0 F  S CNT=$O(LST1(CNT)) Q:'CNT  D
 ..S TEXT="i"_$E(LST1(CNT),2,99)
 ..S LST2(TEXT)=""
 Q:'$D(LST2)
 S CNT=0,OI="" F  S OI=$O(LST2(OI)) Q:OI=""  S CNT=CNT+1,LST(CNT)=OI
 Q
 ;
ISSPLY(VAL,IEN) ; return true if orderable item is a supply
 S VAL=0
 I $P($G(^ORD(101.43,IEN,"PS")),U,5)=1 S VAL=1
 Q
IVAMT(VAL,OI,ORWTYP)     ; return UNITS^AMOUNT |^AMOUNT^AMOUNT...| for IV soln
 N I,PSOI,ORWY,AMT
 S PSOI=+$P($G(^ORD(101.43,OI,0)),U,2)_ORWTYP,VAL=""
 D ENVOL^PSJORUT2(PSOI,.ORWY)
 I ORWTYP="B" D
 . S I=0 F  S I=$O(ORWY(I)) Q:I'>0  S AMT(+ORWY(I))="" D
 . . I ORWY(I)<1 D  ;SBR
 . . . K AMT(+ORWY(I))
 . . . S AMT(0_+ORWY(I))=""
 . S AMT=0,VAL="ML" F  S AMT=$O(AMT(AMT)) Q:AMT'>0  S VAL=VAL_U_AMT
 I ORWTYP="A" D
 . S I=+$O(ORWY(0)) S VAL=$P($G(ORWY(I)),U,2)
 . I '$L(VAL) S VAL="ML^LITER^MCG^MG^GM^UNITS^IU^MEQ^MM^MU^THOUU^MG-PE^NANOGRAM^MMOL"
 Q
 ;
MEDISIV(VAL,IEN)        ; return true if orderable item is IV medication
 S VAL=0
 I $P($G(^ORD(101.43,IEN,"PS")),U)=2 S VAL=1
 Q
 ;
SCSTS(VAL,ORVP,ORDRUG)  ; return service connected eligibility for patient
 N ORWP94 S ORWP94=$O(^ORD(101.41,"AB","PS MEDS",0))>0
 I $L($T(SC^PSOCP)),$$SC^PSOCP(+ORVP,+$G(ORDRUG)) S VAL=0 G XSCSTS
 I 'ORWP94,(+$$RXST^IBARXEU(+ORVP)>0) S VAL=0 G XSCSTS
 S VAL=1
XSCSTS Q
 ;
VALQTY(OK,X)    ; validate a quantity, return 1 if valid, 0 if not
 ; to be compatible with LM, make sure X is integer from 1 to 240
 ; this is based on the input transform from 52,7
 K:(+X'>0)!(+X>99999999)!(X'?.8N.1".".2N)!($L(X)>12) X
 S OK=$S($D(X):1,1:0)
 Q
 ;
VALRATE(VAL,X)   ; return "1" (true) if IV rate text is valid
 I $E($RE($$UPPER^ORWDPS32(X)),1,5)="RH/LM"  S X=$E(X,1,$L(X)-5)
 S X=$$TRIM^ORWDPS32(X)
 D ORINF^PSIVSP S VAL=$S($D(X)>0:1,1:0)_U_$G(X)
 Q
VALSCH(OK,X,PSTYPE)    ; validate a schedule, return 1 if valid, 0 if not
 I '$L($T(EN^PSSGSGUI)) S OK=-1 Q
 I $E($T(EN^PSSGSGUI),1,4)="EN(X" D
 . N ORX S ORX=$G(X) D EN^PSSGSGUI(.ORX,$G(PSTYPE,"I"))
 . K X S:$D(ORX) X=ORX
 E  D
 . D EN^PSSGSGUI
 S OK=$S($D(X):1,1:0)
 Q
 ;
CLZDS(VAL,PAT,DRG,DSUP,OI) ; return the days supply for a given cloz patient
 ; PAT=Patient DFN, DRG=Drug IEN, DSUP=Days Supply to validate, OI=Orderable Item IEN
 ; VAL=DISPENCE FREQUENCY of the patient in file 603.01
 S VAL=0
 I '$G(PAT)!('$G(DRG))!('$G(DSUP))!('$G(OI)) Q
 N ORWX,ORDFR,MSG
 S ORWX("PATIENT")=PAT,ORWX("DRUG")=DRG,ORWX("OI")=OI
 D DSUP^PSOSIGDS(.ORWX)
 S ORDFR=$G(ORWX("DAYS SUPPLY"))
 Q:'ORDFR
 I DSUP'>ORDFR,("^7^14^28^"[("^"_DSUP_"^")) S VAL=1 Q
 S MSG="Patient eligibility for this medication will only allow a Days Supply of "
 I ORDFR=28 S VAL="0^"_MSG_"28 days with 0 refills, 14 days with up to 1 refill, or 7 days with up to 3 refills." Q
 I ORDFR=14 S VAL="0^"_MSG_"14 days with 0 refills, or 7 days with up to 1 refill." Q
 I ORDFR=7 S VAL="0^"_MSG_"7 with 0 refills."
 Q
