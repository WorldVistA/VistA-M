VPRSDAP ;SLC/MKB -- SDA Pharmacy utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,24**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^OR(100                       5771
 ; ^ORD(100.98                    873
 ; ^PSB(53.79                    5909
 ; ^SC                          10040
 ; DIQ                           2056
 ; ORX8                          2467
 ; PSN50P41                      4531
 ; PSOORRL                       2400
 ; PSS50                         4533
 ; PSS50P7                       4662
 ; PSS52P6                       4549
 ; PSS52P7                       4550
 ; XLFSTR                       10104
 ;
PS1(IEN) ; -- set up single medication
 ; Returns ORIFN, PSTYPE & VPRPS=^TMP
 N ORPK,X,CLS S ORIFN=+$G(IEN)
 S ORPK=$G(^OR(100,ORIFN,4)) S:'DFN DFN=+$P($G(^(0)),U,2)
 S X=$S(ORPK:$E(ORPK,$L(ORPK)),1:"Z") S:X=+X X="R" ;last char = PS file
 S CLS=$S("RSN"[X:"O",1:"I") ;"UV"[X:"I",1:$$GET1^DIQ(100,IEN_",",10,"I"))
 S PSTYPE=$S(X="N":"N","RS"[X:"O",$$IV:"V",1:"I") K VPRATE
 D:ORPK OEL^PSOORRL(DFN,ORPK_";"_CLS)
 S VPRPS=$NA(^TMP("PS",$J))
 Q
 ;
CODE(MED,FILE) ; -- convert MED=ien^name to national code
 ; Reset MED = code^name^system for RxNorm or VUID
 N Y S MED=$G(MED),FILE=+$G(FILE)
 S Y=$$CODE^VPRSDA(+MED,FILE,"RXN")
 I Y="" S Y=$$VUID^VPRD(+MED,FILE) S:$L(Y) Y=Y_U_$P(MED,U,2)_"^VHAT"
 S:$L(Y) MED=Y ;reset to nat'l code string
 Q
 ;
IMO(X,PS) ; -- return 1, 0, or null if IMO location X
 N Y S Y=""
 I $G(PS)'="I",$G(PS)'="V" S DDEOUT=1 Q ""
 S Y=$S($P($G(^SC(+$G(X),0)),U,25):"true",1:"false")
 Q Y
 ;
GETFILLS ; -- build DLIST(#)=#^data of fills
 N I,N S N=0
 N RX0,RXN S RX0=$G(@VPRPS@(0)),RXN=$G(@VPRPS@("RXN",0))
 I $P(RXN,U,6) D  ;original fill
 . N X S X=$P(RXN,U,6)_U_$P(RX0,U,7,8)_U_$P(RXN,U,7)_U_$P(RXN,U,3)
 . S N=N+1,DLIST(N)="0^"_X
 S I=0 F  S I=$O(@VPRPS@("REF",I)) Q:I<1  S N=N+1,DLIST(N)=I_U_$G(@VPRPS@("REF",I,0))
 S I=0 F  S I=$O(@VPRPS@("PAR",I)) Q:I<1  S N=N+1,DLIST(N)="P"_I_U_$G(@VPRPS@("PAR",I,0))
 Q
 ;
SUPPLY(IEN) ; -- return 1 or 0, if supply item
 N Y,PSOI S PSOI=+$P($G(@VPRPS@("DD",1,0)),U,4)
 S Y=$S($G(^TMP("VPRX",$J,"PSOI",PSOI,.09)):"true",1:"false")
 Q Y
 ;
SIG(IEN) ; -- return Sig, append VPRPI if needed
 N Y S Y=$$WP^VPRSDA(+$G(IEN),"SIG")
 I $L(Y),$L($G(VPRPI)),Y'[VPRPI D  ;append PI?
 . N SIG,PI S SIG=$$UP^XLFSTR(Y)
 . S PI=$$UP^XLFSTR(VPRPI),PI=$$TRIM^XLFSTR(PI) Q:SIG[PI
 . S Y=SIG_$S($E(Y,$L(Y))=" ":"",1:" ")_PI
 Q Y
 ;
DOSEFORM(IEN) ; -- return dose form
 N OI,PSOI,Y S Y=""
 S OI=$$OI^ORX8(IEN),PSOI=+$P(OI,U,3)
 I PSOI,'$D(^TMP("VPRX",$J,"PSOI",PSOI)) D
 . D ZERO^PSS50P7(PSOI,,,"PSOI")
 . M ^TMP("VPRX",$J,"PSOI",PSOI)=^TMP($J,"PSOI",PSOI)
 . K ^TMP($J,"PSOI",PSOI)
 S Y=$G(^TMP("VPRX",$J,"PSOI",PSOI,.02)) S:Y Y=Y_"^VA50.606"
 Q Y
 ;
INGRD(NAME) ; -- reset NAME to ingredient IEN
 ; Also return VPRCODE=code^name^system
 N IEN S IEN=""
 S NAME=$G(NAME),VPRCODE=""
 I $L(NAME) D NAME^PSN50P41(NAME,"VPRDI") S IEN=+$O(^TMP($J,"VPRDI","P",NAME,0))
 I IEN<1 S DDEOUT=1 Q
 S VPRCODE=IEN_U_NAME,NAME=IEN ;reset, if passed by reference
 D CODE(.VPRCODE,50.416)
 Q
 ;
NDF(DRUG) ; -- return VA Drug Product info for DRUG (#50 ien)
 ; also returns DATA = code^name^system for 50.68
 I '$D(^TMP("VPRX",$J,"NDF",DRUG)) D
 . D NDF^PSS50(DRUG,,,,,"NDF")
 . M ^TMP("VPRX",$J,"NDF",DRUG)=^TMP($J,"NDF",DRUG)
 . K ^TMP($J,"NDF",DRUG)
 S VPRVAP=$NA(^TMP("VPRX",$J,"NDF",DRUG))
 S DATA=$G(^TMP("VPRX",$J,"NDF",DRUG,22)),DRUG=+DATA ;reset to #50.68 ien
 D CODE(.DATA,50.68)
 Q
 ;
DOSES(IEN) ; -- build DLIST(n)=instance of Dose Instructions
 N DA,I
 S DA=0 F  S DA=$O(^OR(100,IEN,4.5,"ID","INSTR",DA)) Q:DA<1  D
 . S I=+$P($G(^OR(100,IEN,4.5,DA,0)),U,3)
 . S:I DLIST(I)=I
 Q
 ;
BCMA(IEN) ; -- get list of administrations
 I $G(DFN)<1 S DFN=+$P($G(^OR(100,IEN,0)),U,2) Q:'DFN
 N ORPK,ADT,DA,CNT,STS S (ADT,CNT)=0
 S ORPK=$G(^OR(100,IEN,4)) Q:ORPK=""
 F  S ADT=$O(^PSB(53.79,"AORDX",DFN,ORPK,ADT)) Q:ADT<1  D
 . S DA=0 F  S DA=+$O(^PSB(53.79,"AORDX",DFN,ORPK,ADT,DA)) Q:DA<1  D
 .. I $P($G(^PSB(53.79,DA,0)),U,9)="RM" Q  ;REMOVED
 .. S CNT=CNT+1,DLIST(CNT)=DA
 Q
 ;
IV() ; -- Return 1 or 0, if order is for IV/infusion
 I ORPK["V" Q 1
 N X0 S X0=$G(^OR(100,ORIFN,0))
 I +$P(X0,U,5)=130 Q 1
 I $P($G(^ORD(100.98,+$P(X0,U,11),0)),U,3)?1"IV".E Q 1
 ;I $G(^TMP("PS",$J,"B",0)) Q 1
 Q 0
 ;
IVMEDS(IEN) ; -- build DLIST(#)=name^amount^type for components
 N I,TYPE,X,CNT S CNT=0
 F TYPE="B","A" D  ;bases, additives
 . S I=0 F  S I=$O(@VPRPS@(TYPE,I)) Q:I<1  D
 .. S X=$G(@VPRPS@(TYPE,I,0)),CNT=CNT+1,DLIST(CNT)=$P(X,U,1,2)_U_TYPE
 Q
 ;
IV1(X) ; -- get VA Drug Product info for IV component X (from DLIST)
 N NAME,TYPE,IEN,DRUG
 S VPRPSIV=$G(X),NAME=$P(VPRPSIV,U),TYPE=$P(VPRPSIV,U,3)
 D:TYPE="B" ZERO^PSS52P7("",NAME,"","VPRPSIV")
 D:TYPE="A" ZERO^PSS52P6("",NAME,"","VPRPSIV")
 S IEN=$O(^TMP($J,"VPRPSIV",0)),DRUG=+$G(^(+IEN,1))
 I DRUG D NDF(.DRUG) S X=+$G(DRUG) ;#50.68 ien
 I 'DRUG D  ;return IV file instead
 . S DATA=IEN_U_NAME_U_$S(TYPE="A":"VA52.6",TYPE="B":"VA52.7",1:"VA")
 . S VPRVAP=$NA(^TMP("VPRX",$J,"NDF",0))
 K ^TMP($J,"VPRPSIV")
 Q
 ;
IVRATE(IEN) ; -- return IV Rate, or DDEOUT if invalid
 ; also VPRATE = numeric amount, if ## ml/hr
 I $G(PSTYPE)'="V" S DDEOUT=1 Q ""
 N X S IEN=+$G(IEN)
 S X=$$VALUE^ORX8(IEN,"RATE")
 I X?1.N1" ml/hr".E S VPRATE=+X Q +X
 S DDEOUT=1
 Q ""
