NHINVPSO ;SLC/MKB -- Outpatient Pharmacy extract
 ;;1.0;NHIN;**1**;Dec 01, 2009;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
 ; ^VA(200)                     10060
 ; DIQ                           2056
 ; ORX8                          2467
 ; PSO5241                       4821
 ; PSOORDER,^TMP("PSOR",$J)      1878
 ; PSOORRL,^TMP("PS",$J)         2400
 ; PSS50P7                       4662
 ; PSS51P2                       4548
 ; XLFDT                        10103
 ;
 ; ------------ Get medications from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's meds
 N PS0,NHI,NHITM K ^TMP("PS",$J)
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 ;
 ; get one med
 I $G(ID) D  D:$D(NHITM)>9 XML^NHINVPS(.NHITM) Q
 . Q:ID["I"
 . I ID["N" D NVA(ID,.NHITM) Q
 . I ID'["P",ID'["S" D RX(ID,.NHITM) Q
 . D OEL^PSOORRL(DFN,ID),PEN1(ID,.NHITM)
 . K ^TMP("PS",$J)
 ;
 ; get all meds
 D OCL^PSOORRL(DFN,BEG,END)
 S NHI=0 F  S NHI=$O(^TMP("PS",$J,NHI)) Q:NHI<1!(NHI>MAX)  S PS0=$G(^(NHI,0)) D  I $D(NHITM)>9 D XML^NHINVPS(.NHITM)
 . S ID=$P(PS0,U) K NHITM Q:ID["I"
 . I ID["N" D NVA(ID,.NHITM) Q
 . I ID["O" D RX(ID,.NHITM) Q
 K ^TMP("PS",$J)
 Q
 ;
RX(ID,MED) ; -- return a prescription in MED("attribute")=value
 I ID["P"!(ID["S") G PEND ;pending order
 N RX0,RX1,DRUG,PSOI,X,I,START,STOP,ORIFN,FILL,RFD,PRV K MED
 K ^TMP("PSOR",$J) D EN^PSOORDER(DFN,+ID)
 S RX0=$G(^TMP("PSOR",$J,+ID,0)),RX1=$G(^(1)),DRUG=$G(^("DRUG",0))
 S MED("id")=ID,MED("vaType")="O",MED("type")="Prescription"
 S ORIFN=+$P(RX1,U,8) S:ORIFN MED("orderID")=ORIFN
 S PSOI=$G(^TMP("PSOR",$J,+ID,"DRUGOI",0)) I PSOI D
 . S MED("name")=$P(PSOI,";",2)
 . D ZERO^PSS50P7(+PSOI,,,"OI")
 . S MED("form")=$P($G(^TMP($J,"OI",+PSOI,.02)),U,2)
 D:DRUG NDF^NHINVPS(+DRUG) ;add NDF data
 S START=$P(RX0,U) S:START MED("start")=START
 S STOP=$P(RX0,U,12) S:STOP MED("stop")=STOP ;_".2359"?
 S X=$$GET1^DIQ(52,+ID_",",26,"I") S:X MED("expires")=X
 S X=$P(RX0,U,17) S:X MED("ordered")=X
 S MED("vaStatus")=$P($P(RX0,U,4),";",2),X=$P($P(RX0,U,4),";")
 S MED("status")=$S(X="H":"hold",X="DC":"not active",X="D"!(X="E"):"historical",1:"active")
 S MED("quantity")=$P(RX0,U,6),MED("daysSupply")=$P(RX0,U,7)
 S MED("fillsAllowed")=$P(RX0,U,8),MED("fillsRemaining")=$P(RX0,U,9)
 S MED("routing")=$P($P(RX1,U,6),";"),MED("prescription")=$P(RX0,U,5)
 S MED("lastFilled")=$P(RX0,U,3) K FILL
 S I=0 F  S I=$O(^TMP("PSOR",$J,+ID,"REF",I)) Q:I<1  S X=$G(^(I,0)),FILL(+X)=X
 S I=0 F  S I=$O(^TMP("PSOR",$J,+ID,"RPAR",I)) Q:I<1  S X=$G(^(I,0)),$P(X,U,14)=1,FILL(+X)=X
 S (I,RFD,PRV)=0 F  S RFD=$O(FILL(RFD)) Q:RFD<1  S X=$G(FILL(RFD)) D  ;sort 1st
 . N MW,REL S I=I+1
 . S MW=$P($P(X,U,10),";"),REL=$P($P(X,U,8),".")
 . S MED("fill",I)=$P(RFD,".")_U_MW_U_REL_U_$P(X,U,4,5)_$S($P(X,U,14):"^1",1:"")
 . S:$P(X,U,2) PRV=$P(X,U,2) ;save last provider
 . ; fill comments?
 S X=$S($P(RX0,U,11):$P(RX0,U,11),$P(RX0,U,10):$P(RX0,U,10),1:0)
 S:X MED("fillCost")=X
 S X=$G(^TMP("PSOR",$J,+ID,"SIG",1,0)),I=1
 F  S I=$O(^TMP("PSOR",$J,+ID,"SIG",I)) Q:I<1  S X=X_$G(^(I,0))
 S MED("sig")=X
 S X=$G(^TMP("PSOR",$J,+ID,"PI",1,0)),I=1
 F  S I=$O(^TMP("PSOR",$J,+ID,"PI",I)) Q:I<1  S X=X_$G(^(I,0))
 S:$L(X) MED("ptInstructions")=X
 S I=0 F  S I=$O(^TMP("PSOR",$J,+ID,"MI",I)) Q:I<1  S X=$G(^(I,0)) D
 . N UD,NOUN,DOSE,UNIT,RTE,SCH,DUR,CONJ,END
 . S UD=$P(X,U,2),NOUN=$P(X,U,4)
 . S DOSE=$P(X,U),UNIT=$P($P(X,U,3),";",2)
 . S RTE=+$P(X,U,7) D ALL^PSS51P2(RTE,,,,"MR")
 . S RTE=$G(^TMP($J,"MR",RTE,1))
 . S DUR=$P(X,U,5),CONJ=$P(X,U,6),SCH=$P(X,U,8)
 . S END=$S(DUR:$$STOP(START,DUR),1:STOP)
 . S MED("dose",I)=DOSE_U_UNIT_U_UD_U_NOUN_U_RTE_U_SCH_U_DUR_U_CONJ_U_START_U_STOP
 . I $E(CONJ)="T",DUR S START=END
 S:RX1 X=$TR($P(RX1,U),";","^"),MED("orderingProvider")=X,MED("currentProvider")=X
 S:$G(PRV) MED("currentProvider")=$TR(PRV,";","^")
 S:$P(RX1,U,9) MED("pharmacist")=$TR($P(RX1,U,9),";","^")
 S:$P(RX1,U,4) MED("location")=$TR($P(RX1,U,4),";","^")
 S MED("facility")=$$FAC^NHINV(+$P(RX1,U,4))
 K ^TMP("PSOR",$J),^TMP($J,"MR"),^TMP($J,"NDF"),^TMP($J,"OI")
 Q
 ;
PEND ; -- pending prescription
 ; [expects PS0,OCL^PSOORRL data]
 N I,X,NHIN K MED
 S MED("id")=ID,MED("vaType")="O",MED("type")="Prescription"
 S MED("vaStatus")=$P(PS0,U,9),MED("status")="not active"
 S X=+$P(PS0,U,8) S:X MED("orderID")=X
 S X=+$P(PS0,U,12) S:X MED("quantity")=X
 D GETS^DIQ(52.41,+ID_",","101;13;19;15;5;1.1","I","NHIN")
 S X=NHIN(52.41,+ID_",",101,"I") S:X MED("daysSupply")=X
 S X=NHIN(52.41,+ID_",",13,"I") S:X MED("fillsAllowed")=X
 S X=NHIN(52.41,+ID_",",19,"I") S:$L(X) MED("routing")=X
 S X=NHIN(52.41,+ID_",",15,"I") S:X MED("ordered")=X
 S X=NHIN(52.41,+ID_",",5,"I") S:X MED("orderingProvider")=X_U_$P($G(^VA(200,X,0)),U)
 S X=NHIN(52.41,+ID_",",1.1,"I") S:X MED("location")=X_U_$P($G(^SC(X,0)),U)
 S MED("facility")=$$FAC^NHINV(X)
 S X=$G(^TMP("PS",$J,NHI,"SIG",1,0)),I=1
 F  S I=$O(^TMP("PS",$J,NHI,"SIG",I)) Q:I<1  S X=X_$C(13,10)_$G(^(I,0))
 S MED("sig")=X
 D PEN^PSO5241(DFN,"NHIN",+ID)
 S X=$G(^TMP($J,"NHIN",DFN,+ID,8)) I X D  ;Pharmacy OI
 . S MED("name")=$P(X,U,2)_" "_$P(X,U,4),MED("form")=$P(X,U,4)
 S X=$G(^TMP($J,"NHIN",DFN,+ID,11)) D:X NDF^NHINVPS(+X) ;Dispense Drug
 D PDOSE K ^TMP($J,"NHIN")
 Q
 ;
PEN1(ID,MED) ; -- return a pending Rx in MED("attribute")=value
 ; [expects OEL^PSOORRL data]
 N PS,PS0,I,X,NHIN K MED
 M PS=^TMP("PS",$J) S PS0=PS(0)
 S MED("id")=ID,MED("vaType")="O",MED("type")="Prescription"
 S MED("vaStatus")=$P(PS0,U,6),MED("status")="not active"
 S X=+$P(PS0,U,11) S:X MED("orderID")=X
 S X=+$P(PS0,U,8) S:X MED("quantity")=X
 S X=+$P(PS0,U,4) S:X MED("fillsAllowed")=X
 S X=+$P(PS0,U,5) S:X MED("ordered")=X
 S X=$G(PS("DD",1,0)) D:X NDF^NHINVPS(+X) ;Dispense Drug
 D GETS^DIQ(52.41,+ID_",","101;19;5;1.1","I","NHIN")
 S X=NHIN(52.41,+ID_",",101,"I") S:X MED("daysSupply")=X
 S X=NHIN(52.41,+ID_",",19,"I") S:$L(X) MED("routing")=X
 S X=NHIN(52.41,+ID_",",5,"I") S:X MED("orderingProvider")=X_U_$P($G(^VA(200,X,0)),U)
 S X=NHIN(52.41,+ID_",",1.1,"I") S:X MED("location")=X_U_$P($G(^SC(X,0)),U)
 S MED("facility")=$$FAC^NHINV(X)
 S X=$G(PS("SIG",1,0)),I=1
 F  S I=$O(PS("SIG",I)) Q:I<1  S X=X_$C(13,10)_$G(PS("SIG",I,0))
 S MED("sig")=X
 D PEN^PSO5241(DFN,"NHIN",+ID)
 S X=$G(^TMP($J,"NHIN",DFN,+ID,8)) I X D  ;Pharmacy OI
 . S MED("name")=$P(X,U,2)_" "_$P(X,U,4),MED("form")=$P(X,U,4)
 D PDOSE K ^TMP($J,"NHIN")
 Q
 ;
PDOSE ; Pending file doses
 N QT,UNIT,UD,NOUN,DOSE,RTE,SCH,DUR,CONJ,BEG,END
 F I=1:1 K NHIN D GETS^DIQ(52.413,I_","_+ID_",","*",,"NHIN") Q:'$D(NHIN)  D
 . K QT M QT=NHIN(52.413,I_","_+ID_",")
 . S (UNIT,UD,NOUN)="",(DOSE,X)=QT(.01) I X["&" D
 .. S DOSE=$P(X,"&"),UNIT=$P(X,"&",2)
 .. S UD=$P(X,"&",3),NOUN=$P(X,"&",4)
 . S SCH=QT(1),DUR=QT(2),CONJ=QT(6),BEG=QT(3),END=QT(4)
 . S RTE=$$GET1^DIQ(52.413,I_","_+ID_",","10:1")
 . S MED("dose",I)=DOSE_U_UNIT_U_UD_U_NOUN_U_RTE_U_SCH_U_DUR_U_CONJ_U_BEG_U_END
 Q
 ;
STOP(BEG,X) ; -- Return date after adding X to BEG
 N D,H,M,S,UNT,Y
 S Y=BEG,(D,H,M,S)=0,UNT=$P(X," ",2),X=+X
 S:UNT?1"MON".E D=30*X
 S:UNT?1"WEE".E D=7*X
 S:UNT?1"DAY".E D=X
 S:UNT?1"HOU".E H=X
 S:UNT?1"MIN".E M=X
 S:UNT?1"SEC".E S=X
 S Y=$$FMADD^XLFDT(BEG,D,H,M,S)
 Q Y
 ;
NVA(ID,MED) ; -- return a non-VA med in MED("attribute")=value
 N NVA,NHZ,ORIFN,DOSE,X K MED
 D GETS^DIQ(55.05,+ID_","_DFN_",",".01:8;11:13","IE","NHZ")
 M NVA=NHZ(55.05,+ID_","_DFN_",") K NHZ
 S MED("id")=ID,MED("type")="OTC",MED("vaType")="N"
 S ORIFN=+NVA(7,"I") S:ORIFN MED("orderID")=ORIFN
 I NVA(.01,"I") D  ;orderable item
 . N FORM
 . S X=NVA(.01,"I") D ZERO^PSS50P7(+X,,,"PSOI")
 . S FORM=$P($G(^TMP($J,"PSOI",+X,.02)),U,2),MED("form")=FORM
 . S MED("name")=NVA(.01,"E")_" "_FORM
 S X=NVA(1,"I") D:X NDF^NHINVPS(+X) ;dispense drug
 S MED("sig")=NVA(2,"E")_" BY "_NVA(3,"E")_" "_NVA(4,"E")
 S X=NVA(2,"I"),NVA(2,"I")=+X_U_$P(X,+X,2) ;amt^unit
 S DOSE=NVA(2,"I")_"^^" I ORIFN D  ;reformat from order
 . S X=$$VALUE^ORX8(ORIFN,"ROUTE") S:X NVA(3,"E")=$$GET1^DIQ(51.2,+X_",",1)
 . S X=$$VALUE^ORX8(ORIFN,"SCHEDULE") S:$L(X) NVA(4,"E")=X
 . S X=$$VALUE^ORX8(ORIFN,"DOSE"),DOSE=$TR($P(X,"&",1,4),"&","^")
 S MED("dose",1)=DOSE_U_NVA(3,"E")_U_NVA(4,"E")
 S:NVA(8,"I") MED("start")=NVA(8,"I")
 S:NVA(6,"I") MED("stop")=NVA(6,"I")
 S:NVA(11,"I") MED("ordered")=NVA(11,"I")
 S MED("status")=$S($G(NVA(5,"E")):"not active",1:"active")
 S:NVA(12,"I") MED("orderingProvider")=NVA(12,"I")_U_NVA(12,"E")
 S:NVA(13,"I") MED("location")=NVA(13,"I")_U_NVA(13,"E")
 S MED("facility")=$$FAC^NHINV(NVA(13,"I"))
 K ^TMP($J,"PSOI"),^TMP($J,"NDF")
 Q
 ;
ACTIVE(X) ; -- return 1 or 0, if X is an active status
 N Y S Y=1
 I X="PURGE" S Y=0
 I X="DELETED" S Y=0
 I X="EXPIRED" S Y=0 ;keep, to renew?
 I $P(X," ")="DISCONTINUED" S Y=0
 Q Y
