VPRDPSI ;SLC/MKB -- Inpatient Pharmacy extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1**;Sep 01, 2011;Build 38
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^OR(100                       5771
 ; ^ORD(101.43                   2843
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; ORX8                      871,2467
 ; PSOORRL,^TMP("PS",$J)         2400
 ; PSS50P7                       4662
 ; PSS51P2                       4548
 ; PSS52P6                       4549
 ; PSS52P7                       4550
 ; XLFSTR                       10104
 ;
 ; ------------ Get medications from VistA ------------
 ;            [used to be called from VPRDPS]
 ;
IN(ID,MED) ; -- return a medication in MED("attribute")=value
 ; [expects VPRN, OCL^PSOORRL data]
 N X,PS,PS0,ORDER,DOSE,UNTS,RTE,SCH,OI,PSOI,LOC K MED
 M PS=^TMP("VPRPS",$J,VPRN) S PS0=PS(0)
 S MED("medID")=ID_";I",MED("vaType")="I"
 S X=$P(PS0,U,15) S:X MED("start")=X
 S X=$P(PS0,U,4) S:X MED("stop")=X
 S MED("name")=$P(PS0,U,2),X=$P(PS0,U,9),MED("vaStatus")=X,X=$E(X,1,3)
 S MED("status")=$S(X="DIS"!(X="PEN"):"not active",X="EXP"!(X="REN"):"historical",X="REI":"active",1:$$LOW^XLFSTR($P(PS0,U,9)))
 S DOSE=$P(PS0,U,6) S:DOSE="" DOSE=$G(PS("SIG",1,0))
 S RTE=$G(PS("MDR",1,0)),SCH=$P($G(PS("SCH",1,0)),U)
 S MED("dose",1)=DOSE_"^^^^"_RTE_U_SCH
 S MED("sig")="Give: "_DOSE_" "_RTE_" "_SCH I $G(PS("SIO",0)) D
 . N SIO M SIO=PS("SIO")
 . S MED("sig")=MED("sig")_" "_$$STRING^VPRD(.SIO)
 I $D(PS("P",0)) S MED("orderingProvider")=PS("P",0)
 I $G(PS("CLINIC",0)) S MED("IMO")=1
 S MED("facility")=$$FAC^VPRD ;local stn#^name
 S ORDER=+$P(PS0,U,8) D:ORDER ORD
 Q
 ;
IN1(ID,MED) ; -- return a medication in MED("attribute")=value
 ; [expects OEL^PSOORRL data]
 N X,PS,PS0,ORDER,DOSE,UNTS,RTE,SCH,OI,PSOI,DRUG,LOC K MED
 M PS=^TMP("PS",$J) S PS0=PS(0)
 S MED("medID")=ID_";I",MED("vaType")="I"
 S X=$P(PS0,U,5) S:X MED("start")=X
 S X=$P(PS0,U,3) S:X MED("stop")=X
 S MED("name")=$P(PS0,U),X=$P(PS0,U,6),MED("vaStatus")=X,X=$E(X,1,3)
 S MED("status")=$S(X="DIS"!(X="PEN"):"not active",X="EXP"!(X="REN"):"historical",X="REI":"active",1:$$LOW^XLFSTR($P(PS0,U,6)))
 S DOSE=$P(PS0,U,9) S:DOSE="" DOSE=$G(PS("SIG",1,0))
 S RTE=$G(PS("MDR",1,0)),SCH=$P($G(PS("SCH",1,0)),U)
 S MED("dose",1)=DOSE_"^^^^"_RTE_U_SCH
 S MED("sig")="Give: "_DOSE_" "_RTE_" "_SCH I $G(PS("SIO",0)) D
 . N SIO M SIO=PS("SIO")
 . S MED("sig")=MED("sig")_" "_$$STRING^VPRD(.SIO)
 I $D(PS("P",0)) S MED("orderingProvider")=PS("P",0)
 S MED("facility")=$$FAC^VPRD ;local stn#^name
 S ORDER=+$P(PS0,U,11) D:ORDER ORD
 I $P($G(^SC(+$G(LOC),0)),U,25) S MED("IMO")=1
 Q
 ;
IV1(ID,MED) ; -- return an infusion in MED("attribute")=value
 ; [expects OEL^PSOORRL data]
 N PS,PS0,X,ORDER,LOC K MED
 M PS=^TMP("PS",$J) S PS0=PS(0)
 S MED("medID")=ID_";I",MED("vaType")="V",MED("name")=$P(PS0,U)
 S X=$P(PS0,U,5) S:X MED("start")=X
 S X=$P(PS0,U,3) S:X MED("stop")=X
 S MED("vaStatus")=$P(PS0,U,6),X=$E($P(PS0,U,6),1,3)
 S MED("status")=$S(X="DIS"!(X="PEN"):"not active",X="EXP"!(X="PUR"):"historical",X="HOL":"hold",1:"active")
 S MED("dose",1)="^^^^"_$G(PS("MDR",1,0))_U_$P($G(PS("SCH",1,0)),U)
 S MED("rate")=$P(PS0,U,2) D IVP
 S X=$G(PS("IVLIM",0)) S:$L(X) MED("ivLimit")=$$IVLIM(X)
 I $G(PS("P",0)) S MED("orderingProvider")=PS("P",0)
 S MED("facility")=$$FAC^VPRD ;local stn#^name
 S ORDER=+$P(PS0,U,11) D:ORDER ORDLOC
 I $P($G(^SC(+$G(LOC),0)),U,25) S MED("IMO")=1
 Q
 ;
ORD ; get rest of inpatient data from ORDER
 S OI=$$OI^ORX8(ORDER),PSOI=+$P(OI,U,3)
 S MED("name")=$P(OI,U,2) I PSOI D
 . D ZERO^PSS50P7(PSOI,,,"OI")
 . S MED("form")=$P($G(^TMP($J,"OI",PSOI,.02)),U,2)
 S X=$$VALUE^ORX8(ORDER,"DOSE"),DOSE=DOSE_"^^^"
 S DRUG="" I X'="",X["&" D
 . S DRUG=+$P(X,"&",6)
 . S DOSE=$TR($P(X,"&",1,4),"&","^")
 . S $P(MED("dose",1),U,1,4)=DOSE
 S:'DRUG DRUG=+$$VALUE^ORX8(ORDER,"DRUG")
 D:DRUG NDF^VPRDPS(DRUG)
 S X=$$GET1^DIQ(100,ORDER_",",36,"I") S:X MED("parent")=X
 K ^TMP($J,"OI")
ORDLOC ; enter here for IV's
 N ORUPCHUK D EN^ORX8(ORDER)
 S MED("orderID")=ORDER
 S MED("ordered")=$G(ORUPCHUK("ORODT"))
 S LOC=+$G(ORUPCHUK("ORL")) I LOC D
 . S MED("location")=LOC_U_$P($G(^SC(LOC,0)),U)
 . S MED("facility")=$$FAC^VPRD(LOC)
 Q
 ;
 ; ---------- Called from VPRDPSOR ----------
 ;
IV ; -- add IV data to MED("attribute")=value
 ; [expects IFN, ORPK, OEL^PSOORRL data]
 N PS,PS0,X,X0,ID,RTE,I
 S MED("vaType")="V" I ORPK,$D(^TMP("PS",$J)) D  G IVQ
 . M PS=^TMP("PS",$J) S PS0=$G(PS(0)),MED("name")=$P(PS0,U)
 . S MED("dose",1)="^^^^"_$G(PS("MDR",1,0))_U_$P($G(PS("SCH",1,0)),U)
 . S MED("rate")=$P(PS0,U,2),ID=ORPK D IVP
 . S X=$G(PS("IVLIM",0)) S:$L(X) MED("ivLimit")=$$IVLIM(X)
 . S X=+$P($G(^TMP("PS",$J,"RXN",0)),U,5)
 . S:X MED("pharmacist")=X_U_$P($G(^VA(200,X,0)),U)
 ; no med in PS, so use Order values
 S RTE=+$$VALUE^ORX8(IFN,"ROUTE") D ALL^PSS51P2(RTE,,,,"VPRTE")
 S MED("dose",1)="^^^^"_$G(^TMP($J,"VPRTE",RTE,1))_U_$$VALUE^ORX8(IFN,"SCHEDULE")
 S MED("rate")=$$VALUE^ORX8(IFN,"RATE")
 S I=0 F  S I=$O(^OR(100,IFN,.1,I)) Q:I<1  S X=+$G(^(I,0)) D
 . S X0=$G(^ORD(101.43,X,0)),MED("name")=$P(X0,U)
 . S MED("product",I,"O")=+$P(X0,U,2)_U_$P(X0,U)
 S X=$$VALUE^ORX8(IFN,"DAYS") I $L(X) D  S MED("ivLimit")=X
 . I X?1.A1.N S X=$$IVLIM(X) Q
 . ; CPRS format = "for a total of 3 doses" or "with total volume 100ml"
 . F I=1:1:$L(X) I $E(X,I)=+$E(X,I) S X=$E(X,I,$L(X)) Q
IVQ ; done
 K ^TMP("PS",$J),^TMP($J,"VPRTE")
 Q
 ;
IVP ; -- add IV products for ID,DFN
 ; [expects PS("A") & PS("B") data arrays from IV*/PSOORRL]
 N VPI,N,NAME,IEN,DRUG,X S N=0
 ; IV Additives
 S VPI=0 F  S VPI=$O(PS("A",VPI)) Q:VPI<1  D
 . K ^TMP($J,"VPRPSIV") S NAME=$P($G(PS("A",VPI,0)),U)
 . D ZERO^PSS52P6("",NAME,"","VPRPSIV")
 . S IEN=$O(^TMP($J,"VPRPSIV",0)),DRUG=+$G(^(IEN,1)) Q:IEN<1
 . S N=N+1 D:DRUG NDF^VPRDPS(DRUG,N) S:'DRUG MED("product",N)=U_NAME
 . S $P(MED("product",N),U,4,5)="A^"_$P($G(PS("A",VPI,0)),U,2)
 . S X=$G(^TMP($J,"VPRPSIV",IEN,15))
 . S:X MED("product",N,"O")=+X_U_$$NAME^PSS50P7(+X)
 ; IV Base Solutions
 S VPI=0 F  S VPI=$O(PS("B",VPI)) Q:VPI<1  D
 . K ^TMP($J,"VPRPSIV") S NAME=$P($G(PS("B",VPI,0)),U)
 . D ZERO^PSS52P7("",NAME,"","VPRPSIV")
 . S IEN=$O(^TMP($J,"VPRPSIV",0)),DRUG=+$G(^(IEN,1)) Q:IEN<1
 . S N=N+1 D:DRUG NDF^VPRDPS(DRUG,N) S:'DRUG MED("product",N)=U_NAME
 . S $P(MED("product",N),U,4,5)="B^"_$P($G(PS("B",VPI,0)),U,2)
 . S X=$G(^TMP($J,"VPRPSIV",IEN,9))
 . S:X MED("product",N,"O")=+X_U_$$NAME^PSS50P7(+X)
 K ^TMP($J,"VPRPSIV")
 Q 
 ;
IVLIM(X) ; -- Return expanded version of IV Limit X
 I '$L($G(X)) Q ""
 N Y,VAL,UNT,I
 S Y="",X=$$UP^XLFSTR(X)
 I X?1"DOSES".E S X="A"_$P(X,"DOSES",2)
 S UNT=$E(X),VAL=0 F I=2:1:$L(X) I $E(X,I) S VAL=$E(X,I,$L(X)) Q
 I UNT="A" S Y=+VAL_$S(+VAL>1:" doses",1:" dose")
 I UNT="D" S Y=+VAL_$S(+VAL>1:" days",1:" day")
 I UNT="H" S Y=+VAL_$S(+VAL>1:" hours",1:" hour")
 I UNT="C" S Y=+VAL_" CC"
 I UNT="M" S Y=+VAL_" ml"
 I UNT="L" S Y=+VAL_" L"
 Q Y
