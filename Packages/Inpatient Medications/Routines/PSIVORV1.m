PSIVORV1 ;BIR/MLM-VIEW AN ORDER, EDIT OR DETAILED (OE/RR) ;07 OCT 97 / 9:42 AM 
 ;;5.0; INPATIENT MEDICATIONS ;**58,81**;16 DEC 97
 ;
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ;
ENED ; Display order entered by MD.
 ;
 S PSIVLN=0,TAB=16,UL80="",$P(UL80,"-",80)=""
 W:$Y @IOF W !!,?5,"Patient: ",$P($G(^DPT(+ORVP,0)),U),?48,"Status: ",$P("DISCONTINUED^COMPLETE^HOLD^FLAGGED^PENDING^ACTIVE^EXPIRED^SCHEDULED^INCOMPLETE^^UNRELEASED",U,+ORSTS)
 W !,?4,"Entry By: ",$P(P("CLRK"),U,2),?49,"Login: ",$$WDTE^PSIVUTL(P("LOG")),!,UL80,!!!
 F DRGT="AD","SOL" D GTDRG
 W:'$O(DRG("SOL",0)) ! S X=59 D CKNUM W "Inf Rate:",?TAB,P(8)
 W ! S X=1 D CKNUM W "Provider:  ",?TAB,$P(P(6),U,2) K TAB
 ;
PC ; Display Provider's comments.
 W ! S X=66 D CKNUM W "Provider Comments: "
 ;F PSIVX=0:0 S PSIVX=$O(^PS(53.45,+$G(PSIVUP),4,PSIVX)) Q:'PSIVX  D
 I +$G(ON) F PSIVX=0:0 S PSIVX=$O(^PS(53.1,+ON,12,PSIVX)) Q:'PSIVX  D
 .S Y=$G(^PS(53.1,+ON,12,PSIVX,0)) W !?5,Y I $Y>23 K DIR S DIR(0)="E" D ^DIR K DIR Q:$D(DIRUT)  W:$Y @IOF
 W !,UL80
 Q
 ;
GTDRG ; Get and print each additive and solution in the order.
 S DRGTN=$S(DRGT="AD":"Additive",1:"Solution")_$S($G(DRG(DRGT,0))>1:"s",1:"")
 W:DRGT="AD" ! S X=$S(DRGT="AD":57,1:58) D CKNUM W DRGTN,": "
 W:+$G(DRG(DRGT,0))=0 ! F I=0:0 S I=$O(DRG(DRGT,I)) Q:'I  W ?TAB,$P(DRG(DRGT,I),U,2)," ",$P(DRG(DRGT,I),U,3),$S($P(DRG(DRGT,I),U,4):"("_$P(DRG(DRGT,I),U,4)_")",1:""),!
 Q
CKNUM ; Display number next to field if necessary.
 I $G(PSIVAC)="OE",(U_EDIT_U[(U_X_U)) S PSIVLN=PSIVLN+1 W "*(",PSIVLN,")"
 W:$G(PSIVAC)="OE" ?4
 Q
 ;
WRTDRG ; Print drugs for "backdoor" view.
 S DRGTN=$S(DRGT="AD":"(1) Additive",1:"(2) Solution")_$S($G(DRG(DRGT,0))>1:"s",1:"")_": " I '$D(PSIVNUM)!('P("DTYP")) S DRGTN="  "_$P(DRGTN,") ",2) G WRTDRG1
 I $G(PSIVAC)="PN" S DRGTN=" "_DRGTN G WRTDRG1
 I DRGT="AD" S DRGTN=$S(P(17)'="P":"*"_DRGTN,$E(P("OT"))="F":"*"_DRGTN,1:" "_DRGTN)
 I DRGT="SOL" S DRGTN=$S(P(17)'="P"&(P("DTYP")'=1):"*"_DRGTN,$E(P("OT"))="F":"*"_DRGTN,1:" "_DRGTN)
WRTDRG1 ;
 W " ",DRGTN D RC^PSIVORV2 F DRG=0:0 S DRG=$O(DRG(DRGT,DRG)) Q:'DRG  D
 .S X=$G(DRG(DRGT,DRG)) I DRGT="SOL",$P($G(^PS(52.7,+X,0)),U,4)]"" S $P(X,U,2)=$P(X,U,2)_" "_$P(^(0),U,4)
 .W ?6,$$LONG^PSIVORV2($S($P(X,U,2)]"":$P(X,U,2)_" "_$P(X,U,3)_" "_$P(X,U,4),1:"*** Undefined ***")) D RC^PSIVORV2
 K DRGT,DRGTN
 Q
 ;
PD ; Print primary drug, dosage ordered (backdoor view).
 I $D(PSIVNUM),P("DTYP") W $S(PSIVAC="PN":"  ",1:" *"),$S(P("DTYP")=1:"(9)",1:"(7)")
 W ?7,"Primary Drug: ",$P(P("PD"),U,2) D RC^PSIVORV2
 I $D(PSIVNUM),P("DTYP") W:P("DTYP")'=1 " " W $S(PSIVAC="PN":" ",1:"*"),$S(P("DTYP")=1:"(10)",1:"(8)")
 W ?13,"Dosage: ",P("DO") D RC^PSIVORV2
 Q
 ;
ONCALL ; Display msg. for orders placed ONCALL by Pharmacy.
 W $C(7),!,"This order has been placed ""ON-CALL"" by pharmacy. No action may be taken on",!,"it until it has been removed from on-call status by pharmacy."
 Q
 ;
ALLREN ; Display msg. for orders that have been renewed.
 W $C(7),!,"This order has been renewed and may not be edited or renewed again."
 Q
 ;
ALLED ; Display msg. for orders that have been edited.
 W $C(7),!,"This order has been edited and may not be edited or renewed again."
 Q
 ;
ENDT ; Display order entered by MD. (OE/RR detailed order view.)
 S TAB=23,UL80="",$P(UL80,"-",80)="" W:$Y @IOF W !!,"IV Room: ",?23,$P(P("IVRM"),U,2),!,"Type:"
 S X=$$CODES^PSIVUTL(P(4),53.1,53) W ?23,$S($E(X)="C":"CHEMO",1:X),$S(P(23)'="":" ("_P(23)_")",1:""),$S(P(5)=1:" (I)",P(5)=0:"(C)",1:""),!,"Syr. Size:",?23,$E(P("SYRS"),1,13) W:$L(P("SYRS"))>13 "..."
 F DRGT="AD","SOL" D GTDRG
 W !,"Infusion Rate:",?23,P(8),!,"Schedule:",?23,P(9),!,"Administration Times:",?23,P(11),!,"Med Route:",?23,$P(P("MR"),U,2),!,"Remarks:",?23,P("REM"),!,"Other Print Info:",?23,$P(P("OPI"),"^"),!,"Last Fill:"
 S Y=$$WDTE^PSIVUTL(P("LF")) W ?23,$S(Y="******":"",1:Y),!,"Quantity: " W:P("LFA") ?23,P("LFA") W !,"Cumulative Doses: " W:P("CUM") ?23,P("CUM") D PC
 W:P("RES")="R" !,$C(7),"This order is a renewal." D:P(17)="O" ONCALL D:P("FRES")="R" ALLREN
 Q
