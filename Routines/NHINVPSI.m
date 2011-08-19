NHINVPSI ;SLC/MKB -- Inpatient Pharmacy extract
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
 ; DIQ                           2056
 ; ORX8                          2467
 ; PSOORRL,^TMP("PS",$J)         2400
 ; PSS50P7                       4662
 ; XLFSTR                       10104
 ;
 ; ------------ Get medications from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's UD/IV meds
 N PS0,NHI,NHITM,IV K ^TMP("PS",$J)
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 ;
 ; get one med
 I $G(ID) D  Q
 . Q:ID["N"  Q:ID["O"  ;inpatient only
 . D OEL^PSOORRL(DFN,ID)
 . S IV=$S(ID["V":1,$G(^TMP("PS",$J,"B",0)):1,1:0)
 . D @($S(IV:"IV1",1:"IN1")_"(ID,.NHITM)")
 . I $D(NHITM)>9 D XML^NHINVPS(.NHITM)
 . K ^TMP("PS",$J)
 ;
 ; get all meds
 D OCL^PSOORRL(DFN,BEG,END)
 S NHI=0 F  S NHI=$O(^TMP("PS",$J,NHI)) Q:NHI<1!(NHI>MAX)  S PS0=$G(^(NHI,0)) D
 . S ID=$P(PS0,U) K NHITM
 . Q:ID["N"  Q:ID["O"  ;inpatient only
 . S IV=$S(ID["V":1,$G(^TMP("PS",$J,NHI,"B",0)):1,1:0)
 . D @($S(IV:"IV",1:"IN")_"(ID,.NHITM)")
 . I $D(NHITM)>9 D XML^NHINVPS(.NHITM)
 K ^TMP("PS",$J)
 Q
 ;
IN(ID,MED) ; -- return a medication in MED("attribute")=value
 ; [expects PS0,OCL^PSOORRL data]
 N X,PS,ORDER,DOSE,UNTS,RTE,SCH,OI,PSOI,LOC K MED
 M PS=^TMP("PS",$J,NHI)
 S MED("id")=ID,MED("vaType")="I"
 S X=$P(PS0,U,15) S:X MED("start")=X
 S X=$P(PS0,U,4) S:X MED("stop")=X
 S MED("name")=$P(PS0,U,2),X=$P(PS0,U,9),MED("vaStatus")=X,X=$E(X,1,3)
 S MED("status")=$S(X="DIS"!(X="PEN"):"not active",X="EXP"!(X="REN"):"historical",X="REI":"active",1:$$LOW^XLFSTR($P(PS0,U,9)))
 S DOSE=$P(PS0,U,6) S:DOSE="" DOSE=$G(PS("SIG",1,0))
 S RTE=$G(PS("MDR",1,0)),SCH=$P($G(PS("SCH",1,0)),U)
 S MED("dose",1)=DOSE_"^^^^"_RTE_U_SCH
 S MED("sig")="Give: "_DOSE_" "_RTE_" "_SCH I $G(PS("SIO",0)) D
 . N SIO M SIO=PS("SIO")
 . S MED("sig")=MED("sig")_$C(13,10)_$$STRING^NHINV(.SIO)
 I $D(PS("P",0)) S MED("orderingProvider")=PS("P",0)
 I $G(PS("CLINIC",0)) S MED("IMO")=1
 S MED("facility")=$$FAC^NHINV ;local stn#^name
 S ORDER=+$P(PS0,U,8) D:ORDER ORD
 Q
 ;
IN1(ID,MED) ; -- return a medication in MED("attribute")=value
 ; [expects OEL^PSOORRL data]
 N X,PS,PS0,ORDER,DOSE,UNTS,RTE,SCH,OI,PSOI,DRUG,LOC K MED
 M PS=^TMP("PS",$J) S PS0=PS(0)
 S MED("id")=ID,MED("vaType")="I"
 S X=$P(PS0,U,5) S:X MED("start")=X
 S X=$P(PS0,U,3) S:X MED("stop")=X
 S MED("name")=$P(PS0,U),X=$P(PS0,U,6),MED("vaStatus")=X,X=$E(X,1,3)
 S MED("status")=$S(X="DIS"!(X="PEN"):"not active",X="EXP"!(X="REN"):"historical",X="REI":"active",1:$$LOW^XLFSTR($P(PS0,U,9)))
 S DOSE=$P(PS0,U,9) S:DOSE="" DOSE=$G(PS("SIG",1,0))
 S RTE=$G(PS("MDR",1,0)),SCH=$P($G(PS("SCH",1,0)),U)
 S MED("dose",1)=DOSE_"^^^^"_RTE_U_SCH
 S MED("sig")="Give: "_DOSE_" "_RTE_" "_SCH I $G(PS("SIO",0)) D
 . N SIO M SIO=PS("SIO")
 . S MED("sig")=MED("sig")_$C(13,10)_$$STRING^NHINV(.SIO)
 I $D(PS("P",0)) S MED("orderingProvider")=PS("P",0)
 S MED("facility")=$$FAC^NHINV ;local stn#^name
 S ORDER=+$P(PS0,U,11) D:ORDER ORD
 I $D(^SC("AE",1,+$G(LOC))) S MED("IMO")=1
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
 D:DRUG NDF^NHINVPS(DRUG)
 K ^TMP($J,"OI")
ORDLOC ; enter here for just order# and location
 S MED("orderID")=ORDER
 S LOC=+$$GET1^DIQ(100,ORDER_",",6,"I") I LOC D
 . S MED("location")=LOC_U_$P($G(^SC(LOC,0)),U)
 . S MED("facility")=$$FAC^NHINV(LOC)
 Q
 ;
IV(ID,MED) ; -- return an infusion in MED("attribute")=value
 ; [expects PS0,OCL^PSOORRL data]
 N PS,X,ORDER,LOC K MED
 M PS=^TMP("PS",$J,NHI)
 S MED("id")=ID,MED("vaType")="V",MED("name")=$P(PS0,U,2)
 S X=$P(PS0,U,15) S:X MED("start")=X
 S X=$P(PS0,U,4) S:X MED("stop")=X
 S MED("vaStatus")=$P(PS0,U,9),X=$E($P(PS0,U,9),1,3)
 S MED("status")=$S(X="DIS"!(X="PEN"):"not active",X="EXP"!(X="PUR"):"historical",X="HOL":"hold",1:"active")
 S MED("dose",1)="^^^^"_$G(PS("MDR",1,0))_U_$P($G(PS("SCH",1,0)),U)
 S MED("rate")=$P(PS0,U,3) D IVP
 S X=$G(PS("IVLIM",0)) S:$L(X) MED("ivLimit")=$$IVLIM(X)
 I $G(PS("CLINIC",0)) S MED("IMO")=1
 I $G(PS("P",0)) S MED("orderingProvider")=PS("P",0)
 S MED("facility")=$$FAC^NHINV ;local stn#^name
 S ORDER=+$P(PS0,U,8) D:ORDER ORDLOC
 Q
 ;
IV1(ID,MED) ; -- return an infusion in MED("attribute")=value
 ; [expects OEL^PSOORRL data]
 N PS,PS0,X,ORDER,LOC K MED
 M PS=^TMP("PS",$J) S PS0=PS(0)
 S MED("id")=ID,MED("vaType")="V",MED("name")=$P(PS0,U)
 S X=$P(PS0,U,5) S:X MED("start")=X
 S X=$P(PS0,U,3) S:X MED("stop")=X
 S MED("vaStatus")=$P(PS0,U,6),X=$E($P(PS0,U,6),1,3)
 S MED("status")=$S(X="DIS"!(X="PEN"):"not active",X="EXP"!(X="PUR"):"historical",X="HOL":"hold",1:"active")
 S MED("dose",1)="^^^^"_$G(PS("MDR",1,0))_U_$P($G(PS("SCH",1,0)),U)
 S MED("rate")=$P(PS0,U,2) D IVP
 S X=$G(PS("IVLIM",0)) S:$L(X) MED("ivLimit")=$$IVLIM(X)
 I $G(PS("P",0)) S MED("orderingProvider")=PS("P",0)
 S MED("facility")=$$FAC^NHINV ;local stn#^name
 S ORDER=+$P(PS0,U,11) D:ORDER ORDLOC
 I $D(^SC("AE",1,+$G(LOC))) S MED("IMO")=1
 Q
 ;
IVP ; -- add IV products for ID,DFN
 N I,N,FILE,IENS,NHIN,LIST,IEN,DRUG,STR
 S FILE=$S(ID["P":53.157,1:55.02),N=0
 S IENS=","_+ID_","_$S(ID["P":"",1:DFN_",")
 F I=1:1 K NHIN D GETS^DIQ(FILE,I_IENS,"*","IE","NHIN") Q:'$D(NHIN)  D
 . K LIST M LIST=NHIN(FILE,I_IENS)
 . S IEN=LIST(.01,"I"),DRUG=$$GET1^DIQ(52.6,IEN_",",1,"I")
 . D:DRUG NDF^NHINVPS(DRUG,.N) S:'DRUG N=N+1
 . S STR=$S(FILE=53.157:LIST(1,"E"),1:LIST(.02,"E"))
 . S MED("product",N)=IEN_U_LIST(.01,"E")_"^^A^"_STR
 S FILE=$S(ID["P":53.158,1:55.11)
 F I=1:1 K NHIN D GETS^DIQ(FILE,I_IENS,"*","IE","NHIN") Q:'$D(NHIN)  D
 . K LIST M LIST=NHIN(FILE,I_IENS)
 . S IEN=LIST(.01,"I"),DRUG=$$GET1^DIQ(52.7,IEN_",",1,"I")
 . D:DRUG NDF^NHINVPS(DRUG,.N) S:'DRUG N=N+1
 . S MED("product",N)=IEN_U_LIST(.01,"E")_"^^B^"_LIST(1,"E")
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
