VPRSDAP ;SLC/MKB -- SDA Pharmacy utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,24,14,28,30**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^%ZOSF                       10096
 ; ^DIC(42                      10039
 ; ^OR(100                       5771
 ; ^ORD(100.98                   6982
 ; ^ORD(101.43                   2843
 ; ^PSB(53.79                    5909
 ; ^SC                          10040
 ; DILFD                         2055
 ; DIQ                           2056
 ; ORX8                          2467
 ; PSN50P41                      4531
 ; PSO52API                      4820
 ; PSO5241                       4821
 ; PSOORRL, ^TMP("PS",$J)        2400
 ; PSS50                         4533
 ; PSS50P7                       4662
 ; PSS51P1                       4546
 ; PSS52P6                       4549
 ; PSS52P7                       4550
 ; PSSUTLA1                      3373
 ; PSXOPUTL                      2200
 ; XLFSTR                       10104
 ;
PS1(IEN) ; -- set up single medication
 ; Returns ORIFN, ORPK, PSTYPE & VPRPS=^TMP
 N X,CLS S ORIFN=+$G(IEN)
 S ORPK=$G(^OR(100,ORIFN,4)) S:'DFN DFN=+$P($G(^(0)),U,2)
 ; last char = PS file
 S X=$S(ORPK:$E(ORPK,$L(ORPK)),1:"Z") S:X=+X X="R",ORPK=ORPK_X
 S CLS=$S("RSN"[X:"O",1:"I") ;"UV"[X:"I",1:$$GET1^DIQ(100,IEN_",",10,"I"))
 S PSTYPE=$S(X="N":"N","RS"[X:"O",$$IV:"V",1:"I") K VPRATE
 D:ORPK OEL^PSOORRL(DFN,ORPK_";"_CLS)
 S VPRPS=$NA(^TMP("PS",$J))
 ; ck Status field
 S X=$P($G(@VPRPS@(0)),U,6) D
 . S:X="DISCONTINUE" X="DISCONTINUED"
 . I X["/" S:X["/PARK" X=$P(X,"/") S:X["/SUSP" X="SUSPENDED"
 S $P(@VPRPS@(0),U,6)=X
 Q
 ;
OI(IEN) ; -- return orderable item for order IEN in the format
 ;    ifn ^ [name] ^ pkg id
 N Y S Y=""
 I $P($G(^OR(100,IEN,.1,0)),U,4)>1 D  ;use PSOI from api if multiple
 . N X,I S X=$P($G(@VPRPS@(0)),U)
 . S I=0 F  S I=$O(^OR(100,IEN,.1,"B",I)) Q:I<1  Q:$P($G(^ORD(101.43,I,0)),U)[X
 . S:I Y=I_U_X_U_$P($G(^ORD(101.43,I,0)),U,2)
 I 'Y S Y=$$OI^ORX8(IEN) ;first/only
 Q Y
 ;
SCHEDULE() ; -- return schedule name ^ type ^ admin times ^ #min
 ; Expects ORIFN, IEN from VPR DOSAGE STEP
 N SCH,ADM,FREQ,I,Y S Y=""
 ; Outpt/NonVA only need Schedule
 I "ON"[$G(PSTYPE) S Y=$$VALUE^ORX8(ORIFN,"SCHEDULE",IEN) Q Y
 S I=+$O(@VPRPS@("SCH",0)),Y=$P($G(@VPRPS@("SCH",I,0)),U,1,2)
 S I=+$O(@VPRPS@("ADM",0)),ADM=$G(@VPRPS@("ADM",I,0))
 S SCH=$P(Y,U),$P(Y,U,3)=ADM I SCH="" Q ""
 I '$D(^TMP("VPRX",$J,"SCH","B",SCH)) D
 . D ZERO^PSS51P1(,SCH,"PSJ",,"SCH")
 . M ^TMP("VPRX",$J,"SCH")=^TMP($J,"SCH")
 . K ^TMP($J,"SCH")
 S I=0 F  S I=$O(^TMP("VPRX",$J,"SCH",I)) Q:I<1  I $L(ADM),$G(^(I,1))=ADM S $P(Y,U,4)=$G(^(2))
 Q Y
 ;
LOC(DFN,ID) ; -- return Hosp Location for order
 N X,Y,FN
 S DFN=+$G(DFN),ID=$G(ID) I 'DFN!'ID Q ""
 I '$L($T(LOC^PSSUTLA1)) Q ""
 S X=$$LOC^PSSUTLA1(DFN,ID),FN=+$P(X,U,3)
 I X,FN=44 Q +X
 I X,FN=42 Q +$G(^DIC(42,+X,44))
 Q ""
 ;
IMO(X,PS) ; -- return true, false, or null if IMO location X
 N Y S Y=""
 I $G(PS)'="I",$G(PS)'="V" Q ""
 S Y=$S($P($G(^SC(+$G(X),0)),U,25):"true",1:"false")
 Q Y
 ;
PSRX(RX) ; -- get RX info for extension properties
 S RX=$G(RX),VPRX52=$NA(^TMP($J,"VPRX",DFN,+RX))
 S VPRX52P=$NA(^TMP($J,"VPRXP",DFN,+RX))
 Q:$G(PSTYPE)'="O"
 I RX["S" D PEN^PSO5241(DFN,"VPRXP",+RX) Q
 Q:RX'["R"  ;Rx file
 D RX^PSO52API(DFN,"VPRX",+RX,,3)
 ; get IB data too
 D RX^PSO52API(DFN,"VPRXIB",+RX,,"I^O")
 M @VPRX52=^TMP($J,"VPRXIB",DFN,+RX) K ^TMP($J,"VPRXIB",DFN,+RX)
 Q
 ;
ROUTING(RX) ; -- get the Routing value [not in use]
 N X,Y S (X,Y)="",RX=$G(RX)
 I $G(ORPK)["R" S X=$P($G(@VPRPS@("RXN",0)),U,3)
 I $G(ORPK)["S" S X=$P($G(@VPRX52P@(19)),U)
 S:$L(X) Y=$S(X="M":"MAIL",X="W":"WINDOW",X="C":"ADMINISTERED IN CLINIC",X="P":"PARK",1:"")
 Q Y
 ;
GETFILLS ; -- build DLIST(#)=#^data of fills, where data is
 ; date ^ daysSupply ^ qty ^ released ^ routing ^ remarks ^ returned
 N I,N S N=0
 N RX0,RXN S RX0=$G(@VPRPS@(0)),RXN=$G(@VPRPS@("RXN",0))
 I $P(RXN,U,6) D  ;original fill
 . N X S X=$P(RXN,U,6)_U_$P(RX0,U,7,8)_U_$P(RXN,U,7)_U_$P(RXN,U,3)
 . S:$G(@VPRX52@(32.1)) $P(X,U,7)=$P(@VPRX52@(32.1),U)
 . S N=N+1,DLIST(N)="0^"_X
 S I=0 F  S I=$O(@VPRPS@("REF",I)) Q:I<1  S N=N+1,DLIST(N)=I_U_$G(@VPRPS@("REF",I,0))
 S I=0 F  S I=$O(@VPRPS@("PAR",I)) Q:I<1  S N=N+1,DLIST(N)="P"_I_U_$G(@VPRPS@("PAR",I,0))
 Q
 ;
SUPPLY(IEN) ; -- return 1 or 0, if supply item
 N Y S Y=$S($G(^TMP("VPRX",$J,"PSOI",+$G(PSOI),.09)):"true",1:"false")
 Q Y
 ;
CMOP(RX) ; -- return CMOP indicator for RX
 N Y S Y="",RX=+$G(RX)
 I $$GET1^DIQ(52,RX,"6:213","I") S Y=">"
 N X S X="PSXOPUTL" X ^%ZOSF("TEST") K X I $T D
 . N DA,PSXZ S DA=RX D ^PSXOPUTL
 . S X=$G(PSXZ(PSXZ("L"))) I X=0!(X=2) S Y="T"
 Q Y
 ;
SIG(IEN) ; -- return Sig, append VPRPI if needed
 N Y S Y=$$WP^VPRSDAOR(+$G(IEN),"SIG")
 I $L(Y),$L($G(VPRPI)),Y'[VPRPI D  ;append PI?
 . N SIG,PI S SIG=$$UP^XLFSTR(Y)
 . S PI=$$UP^XLFSTR(VPRPI),PI=$$TRIM^XLFSTR(PI) Q:SIG[PI
 . S Y=SIG_$S($E(Y,$L(Y))=" ":"",1:" ")_PI
 Q Y
 ;
DOSEFORM(IEN) ; -- return dose form
 N Y S Y=""
 I +$G(PSOI),'$D(^TMP("VPRX",$J,"PSOI",PSOI)) D
 . D ZERO^PSS50P7(PSOI,,,"PSOI")
 . M ^TMP("VPRX",$J,"PSOI",PSOI)=^TMP($J,"PSOI",PSOI)
 . K ^TMP($J,"PSOI",PSOI)
 S Y=$G(^TMP("VPRX",$J,"PSOI",+$G(PSOI),.02)) S:Y Y=Y_"^VA50.606"
 Q Y
 ;
INGRD(NAME) ; -- reset NAME to ingredient IEN
 ; Also return VPRCODE=code^name^system
 N IEN S IEN=""
 S NAME=$G(NAME),VPRCODE=""
 I $L(NAME) D
 . D NAME^PSN50P41(NAME,"VPRDI") S IEN=+$O(^TMP($J,"VPRDI","P",NAME,0))
 . K ^TMP($J,"VPRDI")
 I IEN<1 S DDEOUT=1 Q
 S VPRCODE=IEN_U_NAME,NAME=IEN ;reset, if passed by reference
 D CODE(.VPRCODE,50.416)
 Q
 ;
NDF(DRUG) ; -- return VA Drug Product info for DRUG (#50 ien)
 ; also returns DATA = code^name^system for RXN/VUID
 I '$D(^TMP("VPRX",$J,"NDF",DRUG)) D
 . D NDF^PSS50(DRUG,,,,,"NDF")
 . M ^TMP("VPRX",$J,"NDF",DRUG)=^TMP($J,"NDF",DRUG)
 . K ^TMP($J,"NDF",DRUG)
 S VPRVAP=$NA(^TMP("VPRX",$J,"NDF",DRUG))
 S DATA=$G(^TMP("VPRX",$J,"NDF",DRUG,22)) I DATA D  ;#50.68
 . D CODE(.DATA,50.68)
 . S $P(DATA,U,2)=$P($G(@VPRVAP@(22)),U,2) ;RXN text unreliable
 . S:'$L($P(DATA,U,3)) $P(DATA,U,3)="VA50.68"
 I 'DATA S DATA=DRUG_U_$G(@VPRVAP@(.01))_"^VA50"
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
DOSES(IEN) ; -- build DLIST(n)=instance of Dose Instructions
 N DA,I S IEN=+$G(IEN)
 S DA=0 F  S DA=$O(^OR(100,IEN,4.5,"ID","INSTR",DA)) Q:DA<1  D
 . S I=+$P($G(^OR(100,IEN,4.5,DA,0)),U,3)
 . S:I DLIST(I)=I
 ; look for NVA w/schedule (dose not required)
 I '$O(DLIST(0)),$G(PSTYPE)="N",$O(^OR(100,IEN,4.5,"ID","SCHEDULE",0)) S DLIST(1)=1
 Q
 ;
BCMA(IEN,MAX) ; -- get list of most recent administrations for order
 N ORPK,ADT,DA,CNT,STS
 S IEN=+$G(IEN),CNT=0,ADT=9999999,MAX=$G(MAX,10)
 I $G(DFN)<1 S DFN=+$P($G(^OR(100,IEN,0)),U,2) Q:'DFN
 S ORPK=$G(^OR(100,IEN,4)) Q:ORPK=""
 F  S ADT=$O(^PSB(53.79,"AORDX",DFN,ORPK,ADT),-1) Q:ADT<1  D  Q:CNT'<MAX
 . S DA=0 F  S DA=+$O(^PSB(53.79,"AORDX",DFN,ORPK,ADT,DA)) Q:DA<1  D
 .. ;I $P($G(^PSB(53.79,DA,0)),U,9)="RM" Q  ;REMOVED
 .. S CNT=CNT+1,DLIST(CNT)=DA
 Q
 ;
PSB ; -- VPR PSB EVENTS protocol listener (BCMA)
 N IEN,DFN,ORPK,ORIFN
 S IEN=$S($P($G(PSBIEN),",",2)'="":+$P(PSBIEN,",",2),$G(PSBIEN)="+1":+$G(PSBIEN(1)),1:+$G(PSBIEN))
 S DFN=+$G(^PSB(53.79,IEN,0)),ORPK=$P($G(^(.1)),U)
 Q:DFN<1  Q:ORPK<1
 S ORIFN=$$PLACER^PSSUTLA1(DFN,ORPK)
 D:ORIFN POST^VPRHS(DFN,"Medication",+ORIFN_";100")
 Q
 ;
ADMSTS(DA) ; -- return the code^name of administration status
 N X,Y,Z,Z0 S DA=+$G(DA)
 S Y=$P($G(PSB0),U,9),X="" I Y="N" D
 . S Z="" F  S Z=$O(^PSB(53.79,DA,.9,Z),-1) Q:'Z  S Z0=$G(^(Z,0)) D  Q:$L(X)
 .. S X=$P(Z0,U,4) Q:X=""
 .. S Y=$S(X="REMOVED":"RM",1:$E(X))
 I X="" S X=$$EXTERNAL^DILFD(53.79,.09,,Y)
 S:$L(X) Y=Y_U_X
 Q Y
 ;
IV() ; -- Return 1 or 0, if order is for IV/infusion
 I ORPK["V" Q 1
 N X0,X S X0=$G(^OR(100,ORIFN,0))
 I +$P(X0,U,5)=130 Q 1
 S X=$P($G(^ORD(100.98,+$P(X0,U,11),0)),U,3)
 I X?1"IV".E Q 1
 I X="CI RX" Q 1
 ;I $G(^TMP("PS",$J,"A",0))!$G(^TMP("PS",$J,"B",0)) Q 1
 Q 0
 ;
IVMEDS(IEN) ; -- build DLIST(#)=ien^amount^type[^bottle] for components
 N CNT,GBL,I,Y,ND
 S ORPK=$G(ORPK),CNT=0
 S GBL=$S(ORPK["P":"^PS(53.1,",ORPK["U":"^PS(55,DFN,5,",1:"^PS(55,DFN,""IV"",")
 F I=0:0 S I=$O(@(GBL_+ORPK_",""SOL"","_I_")")) Q:'I  D
 . S ND=$G(@(GBL_+ORPK_",""SOL"","_I_",0)"))
 . S CNT=CNT+1,DLIST(CNT)=+ND_U_$P(ND,U,2)_"^B"
 F I=0:0 S I=$O(@(GBL_+ORPK_",""AD"","_I_")")) Q:'I  D
 . S ND=$G(@(GBL_+ORPK_",""AD"","_I_",0)")),Y=+ND_U_$P(ND,U,2)_"^A"
 . S:$L($P(ND,U,3)) Y=Y_U_$P(ND,U,3)
 . S CNT=CNT+1,DLIST(CNT)=Y
 Q 
 ;
IV1(X) ; -- get VA Drug Product info for IV component X (from DLIST)
 ; Returns VPRPSIV = ien^name^amt^type^bottle#
 N IEN,TYPE,NAME,DRUG
 S VPRPSIV=$G(X) ;ien^amt^type[^bottle#] from IVMEDS
 S IEN=+VPRPSIV,TYPE=$P(VPRPSIV,U,3)
 D:TYPE="B" ZERO^PSS52P7(IEN,"","","VPRPSIV")
 D:TYPE="A" ZERO^PSS52P6(IEN,"","","VPRPSIV")
 S NAME=$G(^TMP($J,"VPRPSIV",IEN,.01)),DRUG=+$G(^(1))
 S VPRPSIV=IEN_U_NAME_U_$P(VPRPSIV,U,2,99)
 S X=+$G(DRUG) D:DRUG NDF^VPRSDAP(DRUG) ;#50 ien
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
 ;
IVTYPE(IEN) ; -- return IV Type, or DDEOUT if invalid
 I $G(PSTYPE)'="V" S DDEOUT=1 Q ""
 N X,Y,ORPK,FN,FLD,IENS
 S IEN=+$G(IEN),Y="",ORPK=$G(^OR(100,IEN,4))
 I ORPK["P" S FN=53.1,FLD=53,IENS=+ORPK
 E  S FN=55.01,FLD=.04,IENS=+ORPK_","_DFN
 S Y=$$GET1^DIQ(FN,IENS_",",FLD)
 Q Y
