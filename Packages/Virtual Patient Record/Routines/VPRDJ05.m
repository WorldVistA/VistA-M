VPRDJ05 ;SLC/MKB -- Medications by order ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**2,18**;Sep 01, 2011;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References: see VPRDJ05V for DBIA list
 ;
 ; All tags expect DFN, ID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
PS1(ID) ; -- med order
 N ORPK,TYPE S ID=+$G(ID)
 S ORPK=$$PKGID^ORX8(ID),TYPE=$E(ORPK,$L(ORPK)) S:TYPE=+TYPE TYPE="R"
 ;
 N ORUPCHUK,ORVP,ORPCL,ORDUZ,ORODT,ORSTRT,ORSTOP,ORL,ORTO,ORSTS,ORNP,ORPV,ORTX
 N MED,CLS,OI,X,LOC,FAC,DRUG,DA,CNT,VPRESP
 S X=$S(ORPK:$E(ORPK,$L(ORPK)),1:"Z") S:X=+X X="R" ;last char = PS file
 S CLS=$S("RSN"[X:"O","UV"[X:"I",1:$$GETCLS) ; p18 added package check in new function
 S MED("uid")=$$SETUID^VPRUTILS("med",DFN,ID)
 S MED("orders",1,"orderUid")=$$SETUID^VPRUTILS("order",DFN,ID)
 S X=$$GET1^DIQ(100,ID_",",9,"I") S:X MED("orders",1,"predecessor")=$$SETUID^VPRUTILS("med",DFN,+X)
 S X=$$GET1^DIQ(100,ID_",",9.1,"I") S:X MED("orders",1,"successor")=$$SETUID^VPRUTILS("med",DFN,+X)
 S:ORPK MED("localId")=ORPK_";"_CLS
 D EN^ORX8(ID) S X="" F  S X=$O(ORUPCHUK(X)) Q:X=""  S:$D(ORUPCHUK(X))#2 @X=ORUPCHUK(X)
 S:$G(ORODT) MED("orders",1,"ordered")=$$JSONDT^VPRUTILS(ORODT)
 S:$G(ORNP) MED("orders",1,"providerUid")=$$SETUID^VPRUTILS("user",,+ORNP),MED("orders",1,"providerName")=$P(ORNP,U,2)
 S LOC=+$G(ORL),FAC=$$FAC^VPRD(LOC) I LOC D
 . S MED("orders",1,"locationUid")=$$SETUID^VPRUTILS("location",,LOC)
 . S MED("orders",1,"locationName")=$P(^SC(LOC,0),U)
 D FACILITY^VPRUTILS(FAC,"MED")
 S:$G(ORSTRT) MED("overallStart")=$$JSONDT^VPRUTILS(ORSTRT)
 S:$G(ORSTOP) (MED("stopped"),MED("overallStop"))=$$JSONDT^VPRUTILS(ORSTOP)
 S MED("vaStatus")=$P($G(ORSTS),U,2)
 S MED("medStatusName")=$$STATUS^VPRDPSOR(+$G(ORSTS))
 S MED("medStatus")=$$MEDSTAT^VPRDJ05V(MED("medStatusName"))
 I CLS="I" D
 . S:$P($G(^SC(+$G(LOC),0)),U,25) MED("IMO")="true"
 . S X=$P($G(^OR(100,ID,3)),U,9) S:X MED("parent")=X
 I ORPK D OEL^PSOORRL(DFN,ORPK_";"_CLS)
 S X=$S(ORPK["N":"N",1:CLS),MED("vaType")=X,MED("medType")=$$TYPE^VPRDJ05V(X)
 I CLS="O" S MED("type")=$S(ORPK["N":"OTC",1:"Prescription")
 S X=$G(VPRESP("COMMENT",1)) S:$L(X) MED("comment")=X
 I $$ISIV^VPRDJ05V G IV1^VPRDJ05V
 ;
A ; - Get order responses
 S OI=$$OI^ORX8(ID) I OI D
 . S X=$P(OI,U,2) S:$E(X,$L(X))=" " X=$E(X,1,$L(X)-1)
 . S MED("name")=X
 . D ZERO^PSS50P7(+$P(OI,U,3),,,"PSOI")
 . S MED("productFormName")=$P($G(^TMP($J,"PSOI",+$P(OI,U,3),.02)),U,2)
 . S:+$G(^TMP($J,"PSOI",+$P(OI,U,3),.09)) MED("supply")="true"
 D RESP^VPRDPSOR(ID,.VPRESP) ;order responses
 S DRUG=+$G(^TMP("PS",$J,"DD",1,0)) S:'DRUG DRUG=+$G(VPRESP("DRUG",1))
 S MED("sig")=$S(CLS="I":"Give: ",1:"")_$G(VPRESP("SIG",1)) ;ORTX(2)
 I CLS="O",'$L($G(VPRESP("SIG",1))),'$D(VPRESP("INSTR")) S MED("sig")=$G(VPRESP("COMMENT",1)) ;old Rx
 ;
B ; - Get dosages
 I '$O(^OR(100,ID,2,0)) D  ;single dose or OP
 . N VPRY,START,STOP,DUR,CONJ,MIN
 . S START=$G(ORSTRT),STOP=$G(ORSTOP),MIN=0
 . S CNT=0 F  S CNT=$O(VPRESP("INSTR",CNT)) Q:CNT<1  D
 .. K VPRY D DOSE(.VPRY,CNT) M MED("dosages",CNT)=VPRY
 .. ;determine start & stop per dose
 .. S MED("dosages",CNT,"relativeStart")=MIN
 .. S DUR=$G(VPRY("complexDuration")),CONJ=$G(VPRY("complexConjunction"))
 .. S STOP=$S(DUR:$$STOP(START,DUR),1:STOP)
 .. S:START MED("dosages",CNT,"start")=$$JSONDT^VPRUTILS(START)
 .. S:STOP MED("dosages",CNT,"stop")=$$JSONDT^VPRUTILS(STOP)
 .. S X=$$RELTIME(START,STOP,DUR,MIN),MED("dosages",CNT,"relativeStop")=$S($E(X)=".":0_X,1:X)
 .. I $E(CONJ)="T",DUR S START=STOP,MIN=X
 I $O(^OR(100,ID,2,0)) D
 . N DD,CONJ,VPRY,MIN
 . M CONJ=VPRESP("CONJ"),DUR=VPRESP("DAYS") S MIN=0
 . S (DA,CNT)=0 F  S DA=$O(^OR(100,ID,2,DA)) Q:DA<1  D  ;child orders
 .. K VPRESP,VPRY D RESP^VPRDPSOR(DA,.VPRESP),DOSE(.VPRY,1)
 .. S CNT=CNT+1 M MED("dosages",CNT)=VPRY
 .. S MED("dosages",CNT,"relativeStart")=MIN
 .. S MED("dosages",CNT,"complexConjunction")=$G(CONJ(CNT))
 .. S MED("dosages",CNT,"complexDuration")=$G(DUR(CNT))
 .. S MED("dosages",CNT,"relatedOrder")=DA
 .. S X=$P($G(^OR(100,DA,0)),U,8,9)
 .. S:$P(X,U) MED("dosages",CNT,"start")=$$JSONDT^VPRUTILS($P(X,U))
 .. S:$P(X,U,2) MED("dosages",CNT,"stop")=$$JSONDT^VPRUTILS($P(X,U,2))
 .. I $P(X,U,2)>$G(ORSTOP) S ORSTOP=$P(X,U,2) ;get last stop time
 .. S X=$$RELTIME($P(X,U),$P(X,U,2),$G(DUR(CNT)),MIN)
 .. S MED("dosages",CNT,"relativeStop")=$S($E(X)=".":0_X,1:X) S:$G(CONJ(CNT))="T" MIN=X
 .. S:'DRUG DD=+$G(VPRESP("DRUG",1)),DD(DD,DA)="" ;dispense drug(s)
 .. ; get ^TMP("PS",$J) from 1st child, if Inpt parent:
 .. I '$D(^TMP("PS",$J)) S ORPK=$$PKGID^ORX8(DA) D OEL^PSOORRL(DFN,ORPK_";"_CLS)
 . S MED("stopped")=$$JSONDT^VPRUTILS($G(ORSTOP)) ;reset from last child order
 . S DD=$O(DD(0)) I DD,'$O(DD(DD)) S DRUG=DD Q    ;1 drug for order
 . S (DD,CNT)=0 F  S DD=$O(DD(DD)) Q:DD<1  S DA=0 F  S DA=$O(DD(DD,DA)) Q:DA<1  S CNT=CNT+1 D NDF(DD,CNT,DA)
 ;
C ; - Get OP data
 I CLS="O",ORPK'["N" D
 . S MED("orders",1,"quantityOrdered")=$G(VPRESP("QTY",1))
 . S MED("orders",1,"daysSupply")=$G(VPRESP("SUPPLY",1))
 . S MED("orders",1,"vaRouting")=$G(VPRESP("PICKUP",1))
 . S MED("orders",1,"fillsAllowed")=$G(VPRESP("REFILLS",1))
 . S MED("patientInstruction")=$G(VPRESP("PI",1))
 . Q:ORPK["P"!(ORPK["S")  ;pending
 . N VPR,RX0,RX1,FILL,RFD,MW,REL
 . K ^TMP("PSOR",$J) D EN^PSOORDER(DFN,+ORPK)
 . S RX0=$G(^TMP("PSOR",$J,+ORPK,0)),RX1=$G(^(1)),MED("orders",1,"prescriptionId")=$P(RX0,U,5)
 . I '$G(VPRESP("QTY",1)) S MED("orders",1,"quantityOrdered")=$P(RX0,U,6)
 . I '$G(VPRESP("SUPPLY",1)) S MED("orders",1,"daysSupply")=$P(RX0,U,7)
 . S MED("orders",1,"fillsRemaining")=$P(RX0,U,9),MED("lastFilled")=$$JSONDT^VPRUTILS($P(RX0,U,3))
 . S I=$P(RX0,U,2) I I S FILL(I)=I_"^^^"_$P(RX0,U,6,7)_"^^^"_$P(RX0,U,13)_"^^"_$P(RX1,U,6) ;original fill
 . S I=0 F  S I=$O(^TMP("PSOR",$J,+ORPK,"REF",I)) Q:I<1  S X=$G(^(I,0)),FILL(+X)=X
 . S I=0 F  S I=$O(^TMP("PSOR",$J,+ORPK,"RPAR",I)) Q:I<1  S X=$G(^(I,0)),$P(X,U,14)=1,FILL(+X)=X
 . S (I,RFD)=0 F  S RFD=$O(FILL(RFD)) Q:RFD<1  S X=$G(FILL(RFD)) D  ;sort 1st
 .. S I=I+1,MW=$P($P(X,U,10),";"),REL=$P($P(X,U,8),".")
 .. S MED("fills",I,"dispenseDate")=$$JSONDT^VPRUTILS($P(RFD,"."))
 .. S MED("fills",I,"releaseDate")=$$JSONDT^VPRUTILS(REL)
 .. S MED("fills",I,"routing")=MW
 .. S MED("fills",I,"quantityDispensed")=$P(X,U,4)
 .. S MED("fills",I,"daysSupplyDispensed")=$P(X,U,5)
 .. S:$P(X,U,14) MED("fills",I,"partial")=1 ;"true"
 . S X=$S($P(RX0,U,11):$P(RX0,U,11),$P(RX0,U,10):$P(RX0,U,10),1:0)
 . S:X MED("orders",1,"fillCost")=X
 . S X=$$GET1^PSODI(52,+ORPK_",",26,"I") S:X MED("overallStop")=$$JSONDT^VPRUTILS($P(X,U,2)) ;1^expirationDate
 I CLS="I" D
 . S X=$$GET1^DIQ(55.06,+ORPK_","_DFN_",",25,"I")
 . S:X MED("overallStop")=$$JSONDT^VPRUTILS(X)
 . D BCMA^VPRDJ05V(.MED,DFN,ORPK)
 ;
PSQ ; finish
 D:DRUG NDF(+DRUG)
 S MED("qualifiedName")=$G(MED("name"))
 S X=+$P($G(^TMP("PS",$J,"RXN",0)),U,5)
 S:X MED("orders",1,"pharmacistUid")=$$SETUID^VPRUTILS("user",,X),MED("orders",1,"pharmacistName")=$P($G(^VA(200,X,0)),U)
 K ^TMP("PS",$J),^TMP($J,"PSOI"),^TMP("PSOR",$J)
 D ADD^VPRDJ("MED","med")
 Q
 ;
DOSE(Y,N) ; -- return dosage data from VPRESP(ID,N) to Y("name")
 N X,DUR,CONJ S N=+$G(N,1) K Y
 S X=$P($G(VPRESP("DOSE",N)),"&",1,2) ; units per dose + noun
 S Y("dose")=$S($L(X)>2:$TR(X,"&"," "),1:$P(X,"&"))
 S Y("units")=$P(X,"&",2)
 S X=+$G(VPRESP("ROUTE",N)) D ALL^PSS51P2(X,,,,"VPRTE")
 S Y("routeName")=$G(^TMP($J,"VPRTE",X,1))
 S X=$G(VPRESP("SCHEDULE",N)) I $L(X) S Y("scheduleName")=X D SCH^VPRDJ05V(X)
 S X=$G(VPRESP("ADMIN",N)) S:$L(X) Y("adminTimes")=X
 S X=$G(VPRESP("DAYS",N)) S:$L(X) Y("complexDuration")=X,DUR=X
 S X=$G(VPRESP("CONJ",N)) S:$L(X) Y("complexConjunction")=X,CONJ=X
 I $L($G(CONJ)),'$L($G(DUR)) D  ;look ahead to find duration
 . N I,D S I=$O(VPRESP("DAYS",N)),D=$S(I:$G(VPRESP("DAYS",I)),1:"")
 . S:$L(D) Y("complexDuration")=D
 K ^TMP($J,"VPRTE")
 Q
 ;
STOP(BEG,X) ; -- Return date after adding X to BEG
 N D,H,M,UNT,Y
 S Y=BEG,(D,H,M)=0,UNT=$P(X,+X,2),X=+X
 S UNT=$S($E(UNT)=" ":$E(UNT,2),1:$E(UNT)) I UNT="" S UNT="D"
 S:UNT="L" D=30*X
 S:UNT="W" D=7*X
 S:UNT="D" D=X
 S:UNT="H" H=X
 S:UNT="M" M=X
 S Y=$$FMADD^XLFDT(BEG,D,H,M)
 Q Y
 ;
NDF(DRUG,VPI,ORD) ; -- Set NDF data for dispense DRUG ien
 ; code ^ name ^ vuid [^ role ^ concentration ^ order]
 N LEN,VPRX,STR,VUID,X,I
 S DRUG=+$G(DRUG) Q:'DRUG
 D EN^PSSDI(50,,50,"901;902",DRUG,"VPRX")
 S STR=$S($G(VPRX(50,DRUG,901)):$G(VPRX(50,DRUG,901))_" "_$G(VPRX(50,DRUG,902)),1:"")
 D NDF^PSS50(DRUG,,,,,"NDF") S VPI=+$G(VPI,1)
 ;
 S MED("products",VPI,"ingredientRole")="urn:sct:410942007" ;Drug
 S:$G(ORD) MED("products",VPI,"relatedOrder")=ORD
 S:$G(STR) MED("products",VPI,"strength")=STR
 S X=$G(MED("name")) S:$L(X) MED("products",VPI,"ingredientName")=X
 ;
 S X=$G(^TMP($J,"NDF",DRUG,20)) ;VA Generic
 S MED("products",VPI,"ingredientCode")="urn:va:vuid:"_$$VUID^VPRD(+X,50.6)
 S MED("products",VPI,"ingredientCodeName")=$P(X,U,2)
 ;
 S X=$G(^TMP($J,"NDF",DRUG,22)) ;VA Product
 S MED("products",VPI,"suppliedCode")="urn:va:vuid:"_$$VUID^VPRD(+X,50.68)
 S MED("products",VPI,"suppliedName")=$P(X,U,2)
 ;
 S X=$G(^TMP($J,"NDF",DRUG,25)) ;VA Drug Class
 S MED("products",VPI,"drugClassCode")="urn:vadc:"_$P(X,U,2)
 S MED("products",VPI,"drugClassName")=$P(X,U,3)
 ;
 K ^TMP($J,"NDF")
 Q
 ;
RELTIME(START,STOP,DUR,MIN) ; -- Return #min for dose
 N Y S Y=0
 I START>0,STOP>0 S Y=$$FMDIFF^XLFDT(STOP,START,2)\60 I 1
 E  I DUR S Y=$$TOMIN(DUR) I 1
 E  S Y=$G(VPRESP("SUPPLY",1))*1440
 S Y=$S(Y:Y+MIN,1:MIN)
 Q Y
 ;
TOMIN(DUR) ;
 N RESULT,TIME,UNIT
 S UNIT=$$UP^XLFSTR($E($P(DUR," ",2)))
 I UNIT="" Q 0
 S TIME=$P(DUR," ")
 S RESULT=$S(UNIT="M":TIME,UNIT="H":TIME*60,UNIT="D":TIME*1440,UNIT="W":TIME*10080,UNIT="L":TIME*43200,1:0)
 Q RESULT
GETCLS() ; p18 added package check
 N PKGIEN S PKGIEN=$$GET1^DIQ(100,ID_",",12,"I")
 I $P($G(^DIC(9.4,PKGIEN,0)),U)="INPATIENT MEDICATIONS" Q "I"
 I $P($G(^DIC(9.4,PKGIEN,0)),U)="OUTPATIENT PHARMACY" Q "O"
 Q $$GET1^DIQ(100,ID_",",10,"I")
