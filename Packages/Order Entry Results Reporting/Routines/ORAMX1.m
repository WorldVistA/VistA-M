ORAMX1 ;ISL/JER - ADDITIONAL ANTICOAGULATION CALLS ;12/05/14  09:42
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**391**;Dec 17, 1997;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
RPT(ROOT,DFN,ID,ALPHA,OMEGA,DTRANGE,REMOTE,MAX,ORFHIE) ; Generate report for CPRS
 N ORAMCNT,ORAMJ,ORAMHCT,ORAMCLIN,ORAMPIND,ORAMSIND,ORAICODE,ORAINARR,ORAITXT,ORAIDESC,ORAIND,ORVDT,ORDXS,IMPLDT,CODSYS
 I '$D(^ORAM(103,"B",DFN)) Q
 W $P(^DPT(DFN,0),"^"),"  ",$E($P(^DPT(DFN,0),"^",9),1,3),"-",$E($P(^DPT(DFN,0),"^",9),4,5),"-",$E($P(^DPT(DFN,0),"^",9),6,9)
 I $P(^ORAM(103,DFN,0),"^",10)=1 W !,?10,"******* COMPLEX PATIENT *******"
 S ORAMCLIN=$P($G(^ORAM(103,DFN,6)),U,2),(ORAMPIND,ORAMSIND)=""
 S ORVDT=$O(^ORAM(103,DFN,3,"B",""),-1)
 I +ORVDT'>0 S ORVDT=DT
 E  D
 . N ORDA,ORDFS0
 . S ORDA=$O(^ORAM(103,DFN,3,"B",ORVDT,0)) Q:+ORDA'>0
 . S ORDFS0=$G(^ORAM(103,DFN,3,ORDA,0))
 . S:$P(ORDFS0,U,9)>0 ORVDT=$P(ORDFS0,U,9)
 . D:+ORAMCLIN GETVSIT(.ORDXS,DFN,ORVDT,ORAMCLIN)
 S IMPLDT=$$IMPDATE^LEXU("10D")
 S CODSYS=$S(ORVDT<IMPLDT:"ICD-9-CM",1:"ICD-10-CM")
 I +$G(ORDXS)'>0 D  I 1
 . N ICDCS
 . I +ORAMCLIN D
 .. N ICDC
 .. I ORVDT<IMPLDT D  I 1
 ... S ICDC=$$GET^XPAR(ORAMCLIN_";SC(","ORAM AUTO PRIMARY INDICATION",1,"E")
 .. E  D
 ... S ICDC=$$GET^XPAR(ORAMCLIN_";SC(","ORAM I10 AUTO PRIM INDICATION",1,"E")
 .. I ICDC]"" D
 ... N ICDD,ICDDESC,ICDCS
 ... S ICDCS=$P($$CODECS^ICDEX(ICDC,80,ORVDT),U,2) S:ICDCS]"" CODSYS=ICDCS
 ... D ICDDESC^ICDXCODE("DIAGNOSIS",ICDC,ORVDT,.ICDDESC)
 ... S ORAMPIND=ICDC_U_$$TITLE^XLFSTR($G(ICDDESC(1)))_" ("_CODSYS_" "_ICDC_")"
 .. S ICDC=""
 .. I ORVDT<IMPLDT D  I 1
 ... S ICDC=$$GET^XPAR(ORAMCLIN_";SC(","ORAM AUTO SECONDARY INDICATION",1,"E")
 .. E  D
 ... S ICDC=$$GET^XPAR(ORAMCLIN_";SC(","ORAM I10 AUTO SEC INDICATION",1,"E")
 .. I ICDC]"" D
 ... N ICDD,ICDDESC,ICDCS
 ... S ICDCS=$P($$CODECS^ICDEX(ICDC,80,ORVDT),U,2) S:ICDCS]"" CODSYS=ICDCS
 ... D ICDDESC^ICDXCODE("DIAGNOSIS",ICDC,ORVDT,.ICDDESC)
 ... S ORAMSIND=ICDC_U_$$TITLE^XLFSTR($G(ICDDESC(1)))_" ("_CODSYS_" "_ICDC_")"
 . S ORAITXT=$P($P(^ORAM(103,DFN,0),"^",3),"=")
 . S ORAICODE=$P($P(^ORAM(103,DFN,0),"^",3),"=",2) S:ORAICODE'["." ORAICODE=ORAICODE_"."
 . S ICDCS=$P($$CODECS^ICDEX(ORAICODE,80,ORVDT),U,2) S:ICDCS]"" CODSYS=ICDCS
 . D ICDDESC^ICDXCODE("DIAGNOSIS",ORAICODE,ORVDT,.ORAIDESC)
 . S ORAINARR=$$TITLE^XLFSTR($G(ORAIDESC(1)))
 . S ORAIND=ORAICODE_U_$S($$UP^XLFSTR(ORAITXT)'=$$UP^XLFSTR(ORAINARR):ORAITXT_" - ",1:"")_ORAINARR_" ("_CODSYS_" "_ORAICODE_")"
 . I ORAMPIND]"" D
 .. N PIND,AIND,ORI
 .. S PIND=$$WRAP($P(ORAMPIND,U,2),55)
 .. W !!,"Primary Indication: ",$P(PIND,"|")
 .. F ORI=2:1:$L(PIND,"|") W !?22,$P(PIND,"|",ORI)
 .. I ORAMSIND]"" D
 ... N SIND,ORJ
 ... S SIND=$$WRAP($P(ORAMSIND,U,2),55)
 ... W !," Add'l Indications: ",$P(SIND,"|")
 ... F ORJ=2:1:$L(SIND,"|") W !?22,$P(SIND,"|",ORJ)
 .. S AIND=$$WRAP($P(ORAIND,U,2),55)
 .. W !,$S($D(ORAMSIND):"                    ",1:"  Add'l Indication: "),$P(AIND,"|")
 .. F ORI=2:1:$L(AIND,"|") W !?22,$P(AIND,"|",ORI)
 . E  D
 .. N AIND,ORI
 .. S AIND=$$WRAP($P(ORAIND,U,2),55)
 .. W !!,"Primary Indication: ",$P(AIND,"|")
 .. F ORI=2:1:$L(AIND,"|") W !?22,$P(AIND,"|",ORI)
 E  D
 . N PIND,AIND,ORI,ORJ
 . S PIND=$$WRAP($P(ORDXS(1),U,2),55)
 . W !!,"Primary Indication: ",$P(PIND,"|")
 . F ORI=2:1:$L(PIND,"|") W !?22,$P(PIND,"|",ORI)
 . Q:ORDXS'>1
 . S AIND=$$WRAP($P(ORDXS(2),U,2),55)
 . W !?$S(ORDXS>2:1,1:2),"Add'l Indication",$S(ORDXS>2:"s",1:""),": ",$P(AIND,"|")
 . F ORI=2:1:$L(AIND,"|") W !?22,$P(AIND,"|",ORI)
 . F ORJ=3:1:ORDXS D
 .. S AIND=$$WRAP($P(ORDXS(ORJ),U,2),55)
 .. F ORI=1:1:$L(AIND,"|") W !?$S(ORI=1:20,1:22),$P(AIND,"|",ORI)
 W !!,"          Goal INR: ",$P(^ORAM(103,DFN,0),"^",2)
 D HCT^ORAM(.ORAMHCT,DFN)
 I $L(ORAMHCT,U)>1 D  I 1
 . W !?10,"Last ",$S($$UP^XLFSTR($P(ORAMHCT,U,3))["HGB":"Hgb",$$UP^XLFSTR($P(ORAMHCT,U,3))["HEMOGLOBIN":"Hgb",1:"HCT"),": "
 . W $S($P(ORAMHCT,U)]"":$P(ORAMHCT,U),1:"No result")," on ",$S($P(ORAMHCT,U,2)]"":$P(ORAMHCT,U,2),1:"file")
 E  W !!?10,ORAMHCT
 I +$P($G(^ORAM(103,DFN,6)),U,5)!+$O(^ORAM(103,DFN,7,0)) D
 . W !!,"Patient is Eligible for LMWH Bridging"
 . I +$O(^ORAM(103,DFN,7,0)) D
 .. N ORI S ORI=0
 .. W ":"
 .. F  S ORI=$O(^ORAM(103,DFN,7,ORI)) Q:+ORI'>0  W !?2,$G(^ORAM(103,DFN,7,ORI,0))
 . E  W "."
 I $P($G(^ORAM(103,DFN,1,0)),"^",3)>0 S ORAMCNT=$P(^ORAM(103,DFN,1,0),"^",3) D
 . W !!,"Special Instructions:"
 . F ORAMJ=1:1:ORAMCNT W !?2,^ORAM(103,DFN,1,ORAMJ,0)
 I $P(^ORAM(103,DFN,0),"^",11)=2 W !?2,"Pt has given permission to leave anticoag msg on msg machine."
 I $P($G(^ORAM(103,DFN,4,0)),"^",3)>0 S ORAMCNT=$P(^ORAM(103,DFN,4,0),"^",3) D
 . W !?2,"OK to leave anticoagulation message with:"
 . F ORAMJ=1:1:ORAMCNT W !?4,^ORAM(103,DFN,4,ORAMJ,0)
 I $P($G(^ORAM(103,DFN,2,0)),"^",3)>0 S ORAMCNT=$P(^ORAM(103,DFN,2,0),"^",3) D
 . W !!,"Secondary Indication(s)/Risk Factors:"
 . F ORAMJ=1:1:ORAMCNT W !?2,^ORAM(103,DFN,2,ORAMJ,0)
 W !
 I $P(^ORAM(103,DFN,0),"^",5)'="" W !,"Start Date: ",$P(^ORAM(103,DFN,0),"^",5)
 I $P(^ORAM(103,DFN,0),"^",7)'="" W ?35,"Duration: ",$P(^ORAM(103,DFN,0),"^",7)
 W !,"==========================================================================="
 W !,"DATE",?10,"INR",?18,"Notified",?30,"TWD",?36,"Comments:"
 W !,"---------------------------------------------------------------------------"
 I $D(^ORAM(103,DFN,3,"B")) D
 . N ORAMFSD S ORAMFSD=" ",ORAMCNT=0
 . F  S ORAMFSD=$O(^ORAM(103,DFN,3,ORAMFSD),-1) Q:$G(ORAMFSD)<1  D
 .. I $$DTCHK^ORAM2(DFN,ALPHA,OMEGA,ORAMFSD)=0 Q  ;need to change this to the new date
 .. N ORAMDD1,ORAMDOSE,ORAMPS,ORAMPNOT
 .. I '+$D(^ORAM(103,DFN,3,ORAMFSD,"LOG",0)) W !,$$FMTE^XLFDT($E($P(^ORAM(103,DFN,3,ORAMFSD,0),"^",9),1,7),2)  ;changed from $P(^ORAM(103,DFN,3,ORAMCNT,0),"^")
 .. I +$D(^ORAM(103,DFN,3,ORAMFSD,"LOG",0)) S ORAMDD1=$P($P(^ORAM(103,DFN,3,ORAMFSD,"LOG",1,0),"(",2),".") Q:'+$G(ORAMDD1)  W !,$$FMTE^XLFDT(ORAMDD1,2)
 .. S ORAMPNOT=$$WRAP($P(^ORAM(103,DFN,3,ORAMFSD,0),"^",8),11)
 .. W ?11,$P(^ORAM(103,DFN,3,ORAMFSD,0),"^",3) ;INR
 .. W ?18,$P(ORAMPNOT,"|") ;Pt Notified
 .. W ?30,$P(^ORAM(103,DFN,3,ORAMFSD,0),"^",6) ;TWD
 .. ; Comments
 .. I $P($G(^ORAM(103,DFN,3,ORAMFSD,1,0)),"^",3)>0 D  I 1
 ... N ORAMCC,ORAMCLN S (ORAMCC,ORAMCLN)=0
 ... F  S ORAMCLN=$O(^ORAM(103,DFN,3,ORAMFSD,1,ORAMCLN)) Q:+ORAMCLN'>0  D
 .... I $P(^ORAM(103,DFN,3,ORAMFSD,0),"^",3)'="",ORAMCLN=2 W ?10,$$FMTE^XLFDT($P(^ORAM(103,DFN,3,ORAMFSD,0),"^"),2)
 .... W:ORAMCLN>1 ?18,$P(ORAMPNOT,"|",ORAMCLN)
 .... W ?38,^ORAM(103,DFN,3,ORAMFSD,1,ORAMCLN,0),!
 .... S ORAMCC=ORAMCC+1
 ... I $L(ORAMPNOT,"|")>ORAMCC D
 .... N ORAMI S ORAMI=0 F ORAMI=ORAMCC+1:1:$L(ORAMPNOT,"|") W ?18,$P(ORAMPNOT,"|",ORAMI),!
 .. E  D  W !
 ... I $L(ORAMPNOT,"|")>1 D
 .... N ORAMI S ORAMI=0 F ORAMI=2:1:$L(ORAMPNOT,"|") W ?18,$P(ORAMPNOT,"|",ORAMI),!
 .. ; Patient Instructions
 .. I +$O(^ORAM(103,DFN,3,ORAMFSD,3,0)) D
 ... N ORI S ORI=0
 ... W !,"Patient Instructions (from Letter):"
 ... F  S ORI=$O(^ORAM(103,DFN,3,ORAMFSD,3,ORI)) Q:+ORI'>0  D
 .... N ORPILN,ORJ S ORPILN=$G(^ORAM(103,DFN,3,ORAMFSD,3,ORI,0))
 .... S:$L(ORPILN)>77 ORPILN=$$WRAP(ORPILN,77)
 .... F ORJ=1:1:$L(ORPILN,"|") W !?2,$P(ORPILN,"|",ORJ)
 ... W !
 .. ; Daily Dosing
 .. S ORAMDOSE=$P(^ORAM(103,DFN,3,ORAMFSD,0),"^",7)
 .. I $L(ORAMDOSE) D
 ... N ORAMTP,ORAMTM,ORI
 ... S ORAMPS=$P(^ORAM(103,DFN,3,ORAMFSD,0),"^",5),(ORAMTP,ORAMTM)=0
 ... W !,"Current Dosing (using ",ORAMPS," mg tab):",!
 ... W ?6,$J("Sun",6),?12,$J("Mon",6),?18,$J("Tue",6),?24,$J("Wed",6),?30,$J("Thu",6),?36,$J("Fri",6),?42,$J("Sat",6),?48,$J("Tot",6),!
 ... W "Tab" F ORI=1:1:$L(ORAMDOSE,"|") S ORAMTP=ORAMTP+($P(ORAMDOSE,"|",ORI)/ORAMPS) W ?(6*ORI),$J(($P(ORAMDOSE,"|",ORI)/ORAMPS),6)
 ... W ?48,$J(ORAMTP,6),!
 ... W "mgs" F ORI=1:1:$L(ORAMDOSE,"|") S ORAMTM=ORAMTM+$P(ORAMDOSE,"|",ORI) W ?(6*ORI),$J($P(ORAMDOSE,"|",ORI),6)
 ... W ?48,$J(ORAMTM,6),!
 .. ; Complications
 .. I +$P(^ORAM(103,DFN,3,ORAMFSD,0),"^",2) D
 ... N ORAMCTXT,ORAMCMPL
 ... S ORAMCTXT=$S($P(^ORAM(103,DFN,3,ORAMFSD,0),"^",2)=1:"Major Bleed ",$P(^(0),"^",2)=2:"Complication(s) ",$P(^(0),"^",2)=3:"Minor Bleed ",1:"")
 ... I $D(^ORAM(103,DFN,3,ORAMFSD,2)) N ORAMRSF S ORAMRSF=0 F  S ORAMRSF=$O(^ORAM(103,DFN,3,ORAMFSD,2,ORAMRSF)) Q:ORAMRSF<1  D
 .... N ORI
 .... I ORAMRSF=1 W ?38,ORAMCTXT,"noted: (",^ORAM(103,DFN,3,ORAMFSD,2,ORAMRSF,0),")",! Q
 .... S ORAMCMPL=^ORAM(103,DFN,3,ORAMFSD,2,ORAMRSF,0)
 .... I $S(ORAMCMPL["MB:":1,ORAMCMPL["C:":1,1:0) S ORAMCMPL=$P(ORAMCMPL,":",2)
 .... I $L(ORAMCMPL)>37 S ORAMCMPL=$$WRAP(ORAMCMPL,37)
 .... F ORI=1:1:$L(ORAMCMPL,"|") W ?$S(ORI=1:38,1:40),$P(ORAMCMPL,"|",ORI),!
 .. W ?38,"-------------------------------------",!
 Q
 ;
WRAP(TEXT,LENGTH) ; Breaks text string into substrings of length LENGTH
 N ORAMI,ORAMJ,LINE,ORAMX,ORAMX1,ORAMX2,ORAMY
 I $G(TEXT)']"" Q ""
 F ORAMI=1:1 D  Q:ORAMI=$L(TEXT," ")
 . S ORAMX=$P(TEXT," ",ORAMI)
 . I $L(ORAMX)>LENGTH D
 .. S ORAMX1=$E(ORAMX,1,LENGTH),ORAMX2=$E(ORAMX,LENGTH+1,$L(ORAMX))
 .. S $P(TEXT," ",ORAMI)=ORAMX1_" "_ORAMX2
 S LINE=1,ORAMX(1)=$P(TEXT," ")
 F ORAMI=2:1 D  Q:ORAMI'<$L(TEXT," ")
 . S:$L($G(ORAMX(LINE))_" "_$P(TEXT," ",ORAMI))>LENGTH LINE=LINE+1,ORAMY=1
 . S ORAMX(LINE)=$G(ORAMX(LINE))_$S(+$G(ORAMY):"",1:" ")_$P(TEXT," ",ORAMI),ORAMY=0
 S ORAMJ=0,TEXT="" F ORAMI=1:1 S ORAMJ=$O(ORAMX(ORAMJ)) Q:+ORAMJ'>0  S TEXT=TEXT_$S(ORAMI=1:"",1:"|")_ORAMX(ORAMJ)
 Q TEXT
 ;
GETVSIT(ORDXS,ORDFN,ORVDT,ORLOC) ; Find the Visit for a given Pt, Location, and Visit Date(/Time)
 N ORVSIT,ORI
 K ^TMP("PXKENC",$J)
 S ORDXS=0
 S ORVSIT=$$GETENC^PXAPI(ORDFN,ORVDT,ORLOC)
 I +ORVSIT'>0 S ORDXS=ORDXS_"^No Visit Found" Q
 I '$D(^TMP("PXKENC",$J,ORVSIT,"POV")) S ORDXS=ORDXS_"^No Dxs for Visit" Q
 S ORI=0
 F  S ORI=$O(^TMP("PXKENC",$J,ORVSIT,"POV",ORI)) Q:+ORI'>0  D
 . N ORPOV,ORDX,ORDXC,ORDXT
 . S ORPOV=$G(^TMP("PXKENC",$J,ORVSIT,"POV",ORI,0))
 . S ORDX=$P(ORPOV,U) Q:+ORDX'>0
 . S ORDXC=$$CODEC^ICDEX(80,ORDX)
 . S ORDXT=$$TITLE^XLFSTR($$VLTD^ICDEX(ORDX,ORVDT))
 . S ORDXS=ORDXS+1
 . S ORDXS(ORDXS)=ORDXC_U_$$SETNARR^ORWPCE3($P(ORPOV,U,4),ORDXC)
 K ^TMP("PXKENC",$J)
 Q
