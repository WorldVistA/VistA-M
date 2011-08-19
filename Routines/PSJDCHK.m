PSJDCHK ;BIR/MLM-ORDER CHECKS FOR DRUG SELECTION ;24 NOV 97 /  1:27 PM
 ;;5.0; INPATIENT MEDICATIONS ;**81,91**;16 DEC 97
 ;
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSDRUG( is supported by DBIA 2192.
 ; Reference to ^PSOORDRG is supported by DBIA #2190.
 ; Reference to ^PSOORRL is supported by DBIA #2400.
 ; Reference to ^PSD(58.8 is supported by DBIA 2283.
 ; Reference to ^PSI(58.1 is supported by DBIA 2284.
 ;
START ;
 ;
END ; used by DRUG (55.06,101 & 53.1,101) x-refs to warn user if patient is receiving or about to receive the drug just ordered
 Q:$D(PSJHLSKP)
 N Z,ZZ I $G(PSJPWD)&($P($G(PSJSYSU),";")=3)&($G(PSGDRG)) I ($D(^PSI(58.1,"D",PSGDRG,PSJPWD)))!($D(^PSD(58.8,"D",PSGDRG,PSJPWD))) W !?25,"*** A WARD STOCK ITEM ***"
 ;I $G(^DPT(+PSGP,"PI"))="Y",$D(^("PG",PSGX)) W $C(7),$C(7),!!?7,"*** WARNING!  THIS PATIENT IS LISTED AS REACTING TO THIS DRUG! ***",!
 Q
ENDDC(PSGP,PSJDD) ; Perform Duplicate Drug, Duplicate Class,
 ; Drug-Drug interaction check, Drug-Allergy interaction check.
 D END,EN^PSOORDRG(PSGP,PSJDD) K PSJPDRG S Y=1,X="" S DFN=PSGP
 I $O(^TMP($J,"DD",0)) D
 .W !,"This patient is already receiving this medication in the following orders:",!,"this drug.",!
 .F INDEX=0:0 S INDEX=$O(^TMP($J,"DD",INDEX)) Q:'INDEX  S ND=$G(^TMP($J,"DD",INDEX)),ON=$P(ND,U,3),TYPE=$P(ON,";",2) D OEL^PSOORRL(PSGP,ON) D @TYPE
 Q
O ; Display OP order.
 W !,"Outpatient display goes here",!
 Q
I ; Display UD order.
 W !,"Inpatient Order Display goes here",!
 Q
 S ND=$P($G(^TMP($J,"PS",0)),"^")
 I $D(^TMP($J,"PS","A"))!($D(^TMP($J,"PS","B"))) D
 .F X=0:0 S X=$O(^TMP($J,"PS","A",X)) Q:'X  D
 ..S Y=$G(^TMP($J,"PS","A",X,0)) I Y W !,?10,$P(Y,U)," ",$P(Y,U,2) W:$P(Y,U,3) "(",$P(Y,U,3),")"
 ..W !,?10,$P(ND,U),!,?13,"Give: "
 .F X=0:0 S X=$O(^TMP($J,"DI",X)) Q:'X  D
 ..S ND=$G(^TMP($J,"DI",X,0)) W $P(ND,U,2)," (",$P(ND,U,4),")",!
 ;
CONT ; Ask user if they wish to continue in spite of an order check.
 Q:'$D(PSJPDRG)  S DIR(0)="Y",DIR("A")="Do you wish to continue entering this order",DIR("?",1)="Enter ""N"" if you wish to exit without creating a new order,"
 S DIR("?")="or ""Y"" to continue with the order entry process." D ^DIR S:'Y Y=-1,X="^"
 Q
 ;
SF ;
 S Y=+Y,ND=$G(^PSDRUG(Y,0)),PSGID=+$G(^("I")) I PSGID W !!,"THIS DRUG IS INACTIVE AS OF ",$E($$ENDTC^PSGMI(PSGID),1,8)
 W !!,$S($P(ND,"^",9):"NON-",1:""),"FORMULARY ITEM" W:$P(ND,"^",10)]"" !,$P(ND,"^",10)
 S ND=$P($G(^PSDRUG(Y,2)),"^",3)["U" W !,$P("NOT^","^",ND+1)," A UNIT DOSE DRUG" W ! S ND=$G(^(8)),N5=$G(^(8.5)) W !?2,$$CODES2^PSIVUTL(50,62.01),": " I ND W $P(ND,"^")
 W !?10,$$CODES2^PSIVUTL(50,62.02),": " I $P(ND,"^",2) W $S($D(^PS(51.2,$P(ND,"^",2),0)):$P(^(0),"^"),1:$P(ND,"^",2))
 W !?6,$$CODES2^PSIVUTL(50,62.03),": " I $P(ND,"^",3)]"" W $$CODES^PSIVUTL($P(ND,"^",3),50,62.03)
 W !?11,$$CODES2^PSIVUTL(50,62.04),": " I $P(ND,"^",4)]"" W $P(ND,"^",4)
 W !,$$CODES2^PSIVUTL(50,62.05),": " I $P(ND,"^",5) W $S('$D(^PSDRUG(+$P(ND,"^",5),0)):$P(ND,"^",5),$P(^(0),"^")]"":$P(^(0),"^"),1:$P(ND,"^",5))
 W !?17,$$CODES2^PSIVUTL(50,212.2),": " I $P(N5,"^",2)]"" W $P(N5,"^",2)
 Q:'$$CODES2^PSIVUTL(50,212)  W !?17,$$CODES2^PSIVUTL(50,212),": " D
 . F Q=0:0 S Q=$O(^PSDRUG(Y,212,Q)) Q:'Q  S ND=$G(^(Q,0)) I ND,$P(ND,"^",2) W ?31,$S('$D(^PS(57.5,+ND,0)):+ND_";PS(57.5,",$P(^(0),"^")]"":$P(^(0),"^"),1:+ND_";PS(57.5,"),?56,$P(ND,"^",2),!
 Q
 ;
PDWCHK(DFN,ON) ; Print Dup Drug order.
 N ND,ND0,ND2,X
 ;W:'$D(PSJDCHK) $C(7),$C(7),!!,"WARNING! THIS PATIENT HAS THE FOLLOWING ORDER(S) FOR THIS MEDICATION:",!!
 ;I ON["V" D DISPIV Q
 F DRG=0:0 S DRG=$O(^PS(55,DFN,"IV",+ON,"AD",DRG)) Q:'DRG  D
 . S ND=$$DRUGNAME^PSJLMUTL(DFN,ON)
 S F=$S(ON["P":"^PS(53.1,",1:"^PS(55,"_DFN_",5,"),ND0=$G(@(F_+ON_",0)")),ND2=$G(^(2)),X=$P(ND,U,2),X=$S(X=.2:$P($G(^(.2)),U,2),1:$G(^(.3)))
 W ?10,$P(ND,U),!,?13,"Give: ",X," ",$$ENMRN^PSGMI(+$P(ND0,U,3))," ",$P(ND2,U),!!
 Q
 ;
DISPUD(DFN,ON) ;
 I ON["P",(TYPE="F") ;D DISPPF(DFN,ON) Q
 S F=$S(ON["P":"^PS(53.1,",1:"^PS(55,"_DFN_",5,"),DN=$$DRUGNAME^PSJLMUTL(DFN,ON)
 S ND0=$G(@(F_+ON_",0)")),TYPE=$P(ND0,U,4),ND2=$G(^(2))
 S X=$P(DN,U,2),LINE=$S(X=".2":$P($G(@(F_+ON_",.2)")),U,2),X=.3:$P($G(@(F_+ON_".3)")),U),1:"")
 W !,?10,$P(DN,U),!,13,"Give: ",LINE," ",$$ENMRA^PSGMI(+$P(ND0,U,3))," ",$P(ND2,U),!!
 Q
 ;
DISPIV(DFN,ON) ; Display condensed IV order display.
 N AD,SOL
 F AD=0:0 S AD=$O(^PS(55,DFN,"IV",+ON,"AD",AD)) Q:'AD  D
 .S ND=$G(^PS(55,DFN,"IV",+ON,"AD",AD,0)),DRG=$P($G(^PS(52.6,+ND,0)),U),AMT=$P(ND,U,2),BOT=$P(ND,U,3)
 .W !,PAD," ",AMT W:BOT "(",BOT,")"
 F SOL=0:0 S SOL=$O(^PS(55,"IV",+ON,"SOL",SOL)) Q:'SOL  D
 .S ND=$G(^PS(55,DFN,"IV",+ON,"SOL",SOL,0)),DRG=$P($G(^PS(52.7,+ND,0)),U),AMT=$P(ND,U,2)
 .W !,$S(FIRST:"in",1:"  "),$P(DRG,U)," ",$P(DRG,U,2)
 Q
