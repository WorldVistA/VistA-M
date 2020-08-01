C0CDAOR ;SLC/MKB/GPL -- eRx Medication extract for CCDA ;10/4/13  15:29
 ;;1.0;CCDA;**1**;Sep 01, 2011;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^OR(100                       5771
 ; ^ORD(100.98                    873
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; ORCD                          5493
 ; ORQ1,^TMP("ORR",$J)           3154
 ; ORX8                 871,2467,3071
 ; PSOORRL,^TMP("PS",$J)         2400
 ; PSS50P7                       4662
 ; PSS51P2                       4548
 ;
 ; This routine was copied from VPRDPSOR and modified by 
 ; Oroville Hospital to extract ePrescribing medications
 ; for the CCDA generator. It is called by a modification
 ; to VPRDPS in cases where there is a medication but no order.
 ; the order information is taken from the NVA medication multiple
 ; where it is stored by ePrescribing. 
 ;  - gpl 10/04/2013
 ;
 ; ------------ Get data from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ORIFN) ; -- find a patient's orders
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 N ORDIALOG              ;med dialog array, keep/reuse
 ;
 ; get one order
 I $G(ORIFN) D EN1(ORIFN,.VPRITM),XML^VPRDPS(.VPRITM):$D(VPRITM) Q
 ;
 ; get all orders
 N TYPE,ORDG,ORVP,ORLIST,VPRITM,VPRCNT,VPRN,ORLIST,ORIFN,X3,X4,DAD
 S TYPE=$G(FILTER("vaType")) S:$L(TYPE) TYPE=$S(TYPE="N":"NV",TYPE="V":"IV",1:TYPE)_" "
 S ORDG=+$O(^ORD(100.98,"B",TYPE_"RX",0)),ORVP=DFN_";DPT("
 D EN^ORQ1(ORVP,ORDG,6,,BEG,END)
 K ^TMP("VPROR",$J) S (VPRCNT,VPRN)=0
 F  S VPRN=$O(^TMP("ORR",$J,ORLIST,VPRN)) Q:VPRN<1  S ORIFN=$G(^(VPRN)) D  Q:VPRCNT'<MAX
 . Q:$D(^TMP("VPROR",$J,+ORIFN))  Q:$P(ORIFN,";",2)>1  S ORIFN=+ORIFN
 . S X3=$G(^OR(100,ORIFN,3)),X4=$G(^(4))
 . Q:$P(X3,U,3)=13  I X4["P",$P(X3,U,3)=1 Q  ;cancelled
 . S DAD=$P(X3,U,9) I DAD Q:$D(^TMP("VPROR",$J,DAD))  S ORIFN=DAD
 . K VPRITM D EN1(ORIFN,.VPRITM) Q:'$D(VPRITM)
 . D XML^VPRDPS(.VPRITM)
 . S ^TMP("VPROR",$J,ORIFN)="",VPRCNT=VPRCNT+1
 K ^TMP("VPROR",$J),^TMP("ORR",$J),^TMP($J,"PSOI")
 Q
 ;
EN1(IFN,MED) ; -- return an order in MED("attribute")=value [from EN]
 N ORUPCHUK,ORVP,ORPCL,ORPK,ORDUZ,ORODT,ORSTRT,ORSTOP,ORL,ORTO,ORSTS,ORNP,ORPV,ORTX
 N CLS,OI,X,LOC,DRUG,DA,CNT,VPRESP K MED
 ;
 ; since for ePrescribing meds, there is no order, the VPRN is passed
 ; as the IFN i.e. ^PS(55,DFN,"NVA",VPRN... this is where the
 ; non-VA med is stored.
 ;
 ;S IFN=+$G(IFN) I IFN<1!'$D(^OR(100,IFN)) Q
 S IFN=+$G(IFN) I IFN<1!'$D(^PS(55,DFN,"NVA",IFN)) Q
 N JJOHNVA S JJOHNVA=$NA(^PS(55,DFN,"NVA",IFN)) ; for indirect reference
 ;S ORPK=$$PKGID^ORX8(IFN)
 ;S X=$S(ORPK:$E(ORPK,$L(ORPK)),1:"Z") S:X=+X X="R" ;last char = PS file
 ;S CLS=$S("RSN"[X:"O","UV"[X:"I",1:$$GET1^DIQ(100,IFN_",",10,"I"))
 ;I CLS="O",ORPK=+ORPK!(ORPK["R") D RX^VPRDPSO(ORPK,.MED) S MED("id")=IFN Q
 S CLS="O" ;all these meds non-VA meds, which are class O for outpatient
 S ORPK=IFN_"N" ; this indicates the NVA ien and N for non-VA meds
 S MED("id")=IFN,MED("orderID")=IFN,MED("vaType")=CLS
 S:ORPK MED("medID")=ORPK_";"_CLS
 S MED("ordered")=$P($G(@JJOHNVA@(1,0)),U,5) ; order date
 N ZDUZ S ZDUZ=$P($G(@JJOHNVA@(0)),U,11)
 I ZDUZ'="" D  ;
 . S MED("orderingProvider")=ZDUZ
 . S MED("currentProvider")=$P($G(^VA(200,ZDUZ),0),U,1)
 S MED("start")=$P($G(@JJOHNVA@(0)),U,9)
 I MED("start")="" S MED("start")=MED("ordered")
 ;
 ; here's sample of what's in VPRPS for an NVA med
 ;^TMP("VPRPS",22184,7,0)="7N;O^NAPROXEN 500MG^^^^^^^ACTIVE"
 ;^TMP("VPRPS",22184,7,"SCH",0)=1
 ;^TMP("VPRPS",22184,7,"SCH",1,0)="BID PRN"
 ;^TMP("VPRPS",22184,7,"SIG",0)=1
 ;^TMP("VPRPS",22184,7,"SIG",1,0)="Naprosyn 500 mg Tab| 1  tablet by mouth BID PRN"
 S MED("vaStatus")=$P(^TMP("VPRPS",$J,IFN,0),U,9)
 I MED("vaStatus")="ACTIVE" S MED("status")="active"
 E  S MED("status")="not active"
 S MED("name")=$P(^TMP("VPRPS",$J,IFN,"SIG",1,0),"|",1)
 S MED("sig")=$P(^TMP("VPRPS",$J,IFN,"SIG",1,0),"|",2)
 S MED("schedule")=^TMP("VPRPS",$J,IFN,"SCH",1,0)
 ;
 ; below for reference are the pieces of the zero node of the NVA meds
 ;^PS(55,D0,"NVA",D1,0)={1} (#.01) ORDERABLE ITEM [1P:50.7] ^ {2}(#1) DISPENSE DRUG
        ;        ==>[2P:50] ^ {3}(#2) DOSAGE [3F] ^ {4}(#3) MEDICATION ROUTE
        ;        ==>[4F] ^ {5}(#4) SCHEDULE [5F] ^ {6}(#5) STATUS [6S] ^ (#6)
        ;        ==>{7}DISCONTINUED DATE [7D] ^ {8}(#7) ORDER NUMBER [8P:100] ^
        ;        ==>{9}(#8) START DATE [9D] ^ {10}(#11) DOCUMENTED DATE [10D] ^
        ;        ==>{11}(#12) DOCUMENTED BY [11P:200] ^
 ;
 ; here's how the codes are stored:
 ;
 ;^PS(55,11,"NVA",8,1,7,0)="MEDID:269382 GCN:8182 RXNORM:310798 VUID:4002651^4013949 DRUG:262^2688^0 "
 ;
 N ZCODES S ZCODES=$G(@JJOHNVA@(1,7,0))
 I ZCODES'="" D  ;
 . S MED("MEDID")=$P($P(ZCODES,"MEDID:",2)," ",1)
 . S MED("GCN")=$P($P(ZCODES,"GCN:",2)," ",1)
 . S MED("RxNormCode")=$P($P(ZCODES,"RXNORM:",2)," ",1)
 . S MED("vuid")=$P($P(ZCODES,"VUID:",2)," ",1)
 . S MED("DRUG")=$P($P(ZCODES,"DRUG:",2)," ",1)
 ;D EN^ORX8(IFN) S X="" F  S X=$O(ORUPCHUK(X)) Q:X=""  S:$D(ORUPCHUK(X))#2 @X=ORUPCHUK(X)
 ;S MED("ordered")=$G(ORODT),MED("orderingProvider")=$G(ORNP)
 ;S MED("currentProvider")=$$LASTPROV(IFN)
 ;S MED("start")=$G(ORSTRT),MED("stop")=$G(ORSTOP)
 ;S MED("vaStatus")=$P($G(ORSTS),U,2),MED("status")=$$STATUS(+$G(ORSTS))
 ;S LOC=+$G(ORL) S:LOC MED("location")=LOC_U_$P(^SC(LOC,0),U)
 ;I CLS="I" D
 ;. S:$P($G(^SC(+$G(LOC),0)),U,25) MED("IMO")=1
 ;. S X=$P($G(^OR(100,IFN,3)),U,9) S:X MED("parent")=X
 ;S MED("facility")=$$FAC^VPRD(LOC) I ORPK D
 ;. N IFN D OEL^PSOORRL(DFN,ORPK_";"_CLS)
 ;I $$IV D IV^VPRDPSI Q
 ;S:CLS="O" MED("type")="Prescription"
 S:ORPK["N" MED("vaType")="N",MED("type")="OTC"
ENA ; get order responses
 ;S OI=$$OI^ORX8(IFN) I OI S MED("name")=$P(OI,U,2) D
 ;. D ZERO^PSS50P7(+$P(OI,U,3),,,"PSOI")
 ;. S MED("form")=$P($G(^TMP($J,"PSOI",+$P(OI,U,3),.02)),U,2)
 ;. S:+$G(^TMP($J,"PSOI",+$P(OI,U,3),.09)) MED("supply")=1
 ;D RESP(IFN,.VPRESP) ;order responses
 ;S DRUG=+$G(^TMP("PS",$J,"DD",1,0)) S:'DRUG DRUG=+$G(VPRESP("DRUG",1))
 ;S MED("sig")=$S(CLS="I":"Give: ",1:"")_$G(VPRESP("SIG",1)) ;ORTX(2)
 ;I CLS="I"!(ORPK["N") D  G ENQ ;UD or NVA: single dose, or child orders
 ;. I '$O(^OR(100,IFN,2,0)) S MED("dose",1)=$$DOSE(1)_U_$G(ORSTRT)_U_$G(ORSTOP) Q
 ;. N DD,CONJ M CONJ=VPRESP("CONJ")
 ;. S (DA,CNT)=0 F  S DA=$O(^OR(100,IFN,2,DA)) Q:DA<1  D
 ;.. K VPRESP D RESP(DA,.VPRESP)
 ;.. S CNT=CNT+1,MED("dose",CNT)=$$DOSE(1)_U_$P($G(^OR(100,DA,0)),U,8,9)_U_DA
 ;.. S $P(MED("dose",CNT),U,8)=$G(CONJ(CNT))
 ;.. I $P(MED("dose",CNT),U,10)>$G(ORSTOP) S ORSTOP=$P(MED("dose",CNT),U,10)
 ;.. S:'DRUG DD=+$G(VPRESP("DRUG",1)),DD(DD,DA)="" ;dispense drug(s)
 ;.. ; get ^TMP("PS",$J) from 1st child, if Inpt parent:
 ;.. I '$D(^TMP("PS",$J)) S ORPK=$$PKGID^ORX8(DA) D OEL^PSOORRL(DFN,ORPK_";"_CLS)
 ;. S MED("stop")=$G(ORSTOP) ;reset from last child order
 ;. S DD=$O(DD(0)) I DD,'$O(DD(DD)) S DRUG=DD Q  ;1 drug for order
 ;. S (DD,CNT)=0 F  S DD=$O(DD(DD)) Q:DD<1  S DA=0 F  S DA=$O(DD(DD,DA)) Q:DA<1  S CNT=CNT+1 D NDF^VPRDPS(DD,CNT,DA)
 ; pending Rx: dose(s), qty, etc.
 ;S CNT=0 F  S CNT=$O(VPRESP("INSTR",CNT)) Q:CNT<1  S MED("dose",CNT)=$$DOSE(CNT) ;_STRT^STOP
 ;S MED("quantity")=$G(VPRESP("QTY",1))
 ;S MED("daysSupply")=$G(VPRESP("SUPPLY",1))
 ;S MED("routing")=$G(VPRESP("PICKUP",1))
 ;S MED("fillsAllowed")=$G(VPRESP("REFILLS",1))
 ;S MED("ptInstructions")=$G(VPRESP("PI",1))
ENQ ; finish
 ;D:DRUG NDF^VPRDPS(+DRUG)
 ;S X=+$P($G(^TMP("PS",$J,"RXN",0)),U,5)
 ;S:X MED("pharmacist")=X_U_$P($G(^VA(200,X,0)),U)
 ;K ^TMP("PS",$J),^TMP($J,"PSOI")
 Q
 ;
IV() ; -- Return 1 or 0, if order is for IV/infusion
 I ORPK["V" Q 1
 I $P($G(ORTO),U,2)?1"IV".E Q 1
 I +$G(ORPCL)=130 Q 1
 I $G(^TMP("PS",$J,"B",0)) Q 1
 Q 0
 ;
DOSE(N) ; --add dosage data from VPRESP(ID,N) [instance N]
 N DOSE,X,ID S N=+$G(N,1)
 S DOSE=$P($G(VPRESP("DOSE",N)),"&",1,4),DOSE=$TR(DOSE,"&","^")
 I '$L($P(DOSE,U)) S DOSE=$G(VPRESP("INSTR",N))_"^^^"
 S X=+$G(VPRESP("ROUTE",N)) D ALL^PSS51P2(X,,,,"VPRTE")
 S DOSE=DOSE_U_$G(^TMP($J,"VPRTE",X,1))
 F ID="SCHEDULE","DAYS","CONJ" S DOSE=DOSE_U_$G(VPRESP(ID,N))
 K ^TMP($J,"VPRTE")
 Q DOSE
 ;
LASTPROV(IFN) ; -- return last provider who took action on order IFN
 N I,X,Y S Y=""
 S I="A" F  S I=$O(^OR(100,IFN,8,I),-1) Q:I<1  S X=$G(^(I,0)) D  Q:Y
 . I $P(X,U,5) S Y=+$P(X,U,5) Q  ;signer
 . I $P(X,U,3) S Y=+$P(X,U,3) Q  ;orderer
 S:Y Y=Y_U_$P($G(^VA(200,Y,0)),U)
 Q Y
 ;
STRING(IFN,ID) ; -- return text value as a string
 N DA,I,X,Y
 S DA=+$O(^OR(100,IFN,4.5,"ID",ID,0)) Q:DA<1 ""
 S I=+$O(^OR(100,IFN,4.5,DA,2,0)),Y=$G(^(I,0))
 F  S I=+$O(^OR(100,IFN,4.5,DA,2,I)) Q:I<1  S X=$G(^(I,0)) D
 . I $E(Y,$L(Y))'=" " S Y=Y_" "
 . S Y=Y_X
 Q Y
 ;
STATUS(X) ; -- return HITSP status for 100.01 #X
 S X=+$G(X) S:'X X=99  ;no status
 I X=3 Q "hold"
 I X=10!(X=11)!(X=5) Q "not active"
 I X=1!(X=12)!(X=13) Q "not active"
 I X=14!(X=99)       Q "not active"
 I X=2!(X=7)!(X=15)  Q "historical"
 Q "active"
 ;
RESP(ORIFN,RESP) ; -- return order responses [internal form]
 N VPRDLG,I,J,W,ID,TYPE,X,Y
 I '$D(ORDIALOG) S ORDIALOG=129 D GETDLG1^ORCD(129)
 D GETORDER^ORCD(+$G(ORIFN),"VPRDLG")
 S I=0 F  S I=$O(VPRDLG(I)) Q:I<1  D
 . S ID=$P($G(ORDIALOG(I)),U,2) Q:'$L(ID)
 . S TYPE=$P($G(ORDIALOG(I,0)),U)
 . S J=0 F  S J=$O(VPRDLG(I,J)) Q:J<1  I $D(VPRDLG(I,J)) D
 .. S X=VPRDLG(I,J) I TYPE'="W" S RESP(ID,J)=X Q
 .. S Y=$G(@X@(1,0)),W=1 F  S W=$O(@X@(W)) Q:W<1  S Y=Y_$S($E(Y,$L(Y))'=" ":" ",1:"")_$G(@X@(W,0))
 .. S:$L(Y) RESP(ID,J)=Y
 Q
