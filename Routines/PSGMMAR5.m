PSGMMAR5 ;BIR/CML3-MD MARS - GATHER INFO FOR ACK ORDERS ;14 Oct 98 / 4:29 PM
 ;;5.0; INPATIENT MEDICATIONS ;**15,20,111,145**;16 DEC 97;Build 17
 ;
PEND ;*** Only select orders that were acknowledged by nurses and
 ;*** still having pending status.
 ;The next 4 lines are looking only at ward parameters.  If there is an inpatient with pending orders, the orders will print on the MAR.
 NEW PSJSYSW,PSJSYSW0
 S PSJSYSW=$O(^PS(59.6,"B",+$G(PSJPWD),0))
 S:PSJSYSW PSJSYSW0=$G(^PS(59.6,PSJSYSW,0))
 Q:'+$P($G(PSJSYSW0),U,6)   ;Quit if the order is not pending.
 ;
 NEW ND,ON,TYPE,QST
 F ON=0:0 S ON=$O(^PS(53.1,"AV",PSGP,ON)) Q:'ON  D
 . S ND=$G(^PS(53.1,ON,0)),TYPE=$P(ND,U,4)
 . I $P(ND,U,7)="P"!($P($G(^PS(53.1,ON,2)),U)["PRN") S QST="OZ"_$S($P(ND,U,4)="F":"V",1:"A")
 . E  S QST="CZ"_$S($P(ND,U,4)="F":"V",1:"A")
 . I PSGMTYPE[1 D:TYPE'="F" SETTMP D:TYPE="F" IV
 . I PSGMTYPE'[1 D
 .. I PSGMTYPE[2,(TYPE="U") D SETTMP Q
 .. I PSGMTYPE'[2,(TYPE="I") D SETTMP Q
 .. I PSGMTYPE[4,(TYPE="F") D IV
 Q
 ;
SETTMP ;*** Setup ^tmp for pending U/D and Inpatient med IVs.
 ;*** OZ_(V/A) = PRN/One time orders (V=IV).
 ;*** CZ_(V/A) = Continuous orders (A=U/D).
 I PSGMARS=2,(QST["CZ") Q
 I PSGMARS=1,(QST["OZ") Q
 NEW MARX
 D DRGDISP^PSJLMUT1(PSGP,+ON_"P",20,0,.MARX,1) S DRG=MARX(1)_U_+ON_"P"
 N PSGMARWC,A  ;DEM 04/19/2006 - PSGMARWC is used to preserve original value of PSGMARWN (patient location) in case location is changed by an order with a clinic location.
 S PSGMARWC=PSGMARWN
 S A=$G(^PS(53.1,+ON,"DSS")) I $P(A,"^")]"" S PSGMARWN="C!"_$P(A,"^") I $G(SUB1)]"",$G(SUB2)]"",'$D(^TMP($J,TM,PSGMARWN,SUB1,SUB2)) D
 . N X
 . D:$G(PSGMAR24) SPN^PSGMAR0 D:'$G(PSGMAR24) SPN^PSGMMAR0
 . Q
 I (PSGSS="P")!(PSGSS="C")!(PSGSS="L") S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),DRG)="" S:PSGMARWN'=PSGMARWC PSGMARWN=PSGMARWC Q
 S ^TMP($J,TM,PSGMARWN,SUB1,SUB2,$S(+PSGMSORT:$E(QST,1),1:QST),DRG)=""
 ;
 ;DAM 5-01-07 add XTMP global for printing when PSGSS is not "P", "C", or "L".  This reverses PSGMARWN (ward) and SUB1 (patient) so printing will occur with all locations (ward and clinic) appearing together under the patient's name
 S ^XTMP(PSGREP,TM,SUB1,PSGMARWN,SUB2,$S(+PSGMSORT:$E(QST,1),1:QST),DRG)=""
 ;
 S:PSGMARWN'=PSGMARWC PSGMARWN=PSGMARWC Q
 Q
 ;
IV ;*** Sort IV pending orders for 24 Hrs, 7/14 Day MAR.
 K DRG,P N X,ON55,PSJLABEL S DFN=PSGP,PSJLABEL=1 D GT531^PSIVORFA(DFN,ON)
 S X=$P(P("MR"),U,2)
 S QST=QST_4
 N PSGMARWC  ;DEM 04/19/2006 - PSGMARWC is used to preserve original value of PSGMARWN (patient location) in case location is changed by an order with a clinic location.
 S PSGMARWC=PSGMARWN
 I $G(DRG) S X=$S($G(DRG("AD",1)):DRG("AD",1),1:$G(DRG("SOL",1))),X=$E($P(X,U,2),1,20)_U_+ON_"P" D
 . N A
 . S A=$G(^PS(53.1,+ON,"DSS")) I $P(A,"^")]"" S PSGMARWN="C!"_$P(A,"^") I $G(SUB1)]"",$G(SUB2)]"",'$D(^TMP($J,TM,PSGMARWN,SUB1,SUB2)) D
 . . N X
 . . D:$G(PSGMAR24) SPN^PSGMAR0 D:'$G(PSGMAR24) SPN^PSGMMAR0
 . . Q
 . I PSGSS="P"!(PSGSS="C")!(PSGSS="L") S ^TMP($J,PPN,PSGMARWN,$S(+PSGMSORT:$E(QST,1),1:QST),X)="" Q
 . S:PSGRBPPN="R" ^TMP($J,TM,PSGMARWN,PSJPRB,PPN,$S(+PSGMSORT:$E(QST,1),1:QST),X)=""
 . S:PSGRBPPN="P" ^XTMP(PSGREP,TM,PPN,PSGMARWN,PSJPRB,$S(+PSGMSORT:$E(QST,1),1:QST),X)=""  ;DAM 5-01-07 set ^XTMP global when sorting by patient
 . Q
 S:PSGMARWN'=PSGMARWC PSGMARWN=PSGMARWC
 Q
