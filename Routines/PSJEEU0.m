PSJEEU0 ;BIR/CML3,PR-MORE EXTERNAL ENTRIES ;22 OCT 97 / 10:22 AM
 ;;5.0; INPATIENT MEDICATIONS ;**184**;16 DEC 97;Build 12
 ;
ENHS ;
 S PSGP=DFN,PSJACNWP=1 D ENIV^PSJAC,NOW^%DTC K ^UTILITY("PSG",$J),^UTILITY("PSIV",$J) S X=$S('$G(PSJEDT):%,$P(PSJEDT,".",2):PSJEDT-.0001,1:PSJEDT)
 F X=X:0 S X=$O(^PS(55,PSGP,5,"AUS",X)) Q:'X  F Y=0:0 S Y=$O(^PS(55,PSGP,5,"AUS",X,Y)) Q:'Y  S X(0)=$G(^PS(55,PSGP,5,Y,0)) S PSJROOT="^PS(55,"_PSGP_",5,"_Y_"," D UDSET
 F Y=0:0 S Y=$O(^PS(53.1,"AC",PSGP,Y)) Q:'Y  S X(0)=$G(^PS(53.1,Y,0)) I "PU"'[$P(X(0),"^",9) S PSJROOT="^PS(53.1,"_Y_"," D UDSET
 ;
ENHSI ;Build all IV Active/Non-verified orders
 D ENNA^PSIVACT F ON=0:0 S ON=$O(^PS(55,DFN,"IV",ON)) Q:'ON  I $D(^(ON,0)) S Y=^(0) I $S("ANROH"[$P(Y,U,17):1,'$G(PSJEDT):0,1:$P(Y,U,3)'<$G(PSJEDT)) F I=1:1:23 S P(I)=$P(Y,U,I) I I=23 D 0
 ;
DONE ;
 N DFN D ENKV^PSGSETU K V,X,Y,Z,P,S,A,NUM,PS,PSJACNWP,ON,PSIVREA
 K PSJROOT,PSJTEXT,PSJFNM,PSJUD Q
 ;
0 ;Build 0 node
 S P(17)=$S("AROH"[P(17):"A;ACTIVE",P(17)="D":"D;DISCONTINUED",P(17)="E":"E;EXPIRED",1:"N;NON VERIFIED")
 S X=$P($G(^VA(200,+P(6),0)),U),P(6)=P(6)_":VA(200,;"_X
 S P(10)=P(2) F Z=P(2):-.000001 I '$D(^UTILITY("PSIV",$J,-Z)) S P(2)=Z Q
 S ^UTILITY("PSIV",$J,-P(2),0)=P(10)_U_P(3)_U_P(6)_U_P(17)_U_P(8)_U_P(9)
 S NUM=0 F A=0:0 S A=$O(^PS(55,DFN,"IV",ON,"AD",A)) Q:'A  I $D(^(A,0)) S P=^(0),NUM=NUM+1,^UTILITY("PSIV",$J,-P(2),"A",NUM)=$P(P,U)_";"_$P($G(^PS(52.6,$P(P,U),0)),U)_U_$P(P,U,2)
 S NUM=0 F S=0:0 S S=$O(^PS(55,DFN,"IV",ON,"SOL",S)) Q:'S  I $D(^(S,0)) S P=^(0),NUM=NUM+1,^UTILITY("PSIV",$J,-P(2),"S",NUM)=$P(P,U)_";"_$P($G(^PS(52.7,$P(P,U),0)),U)_U_$P(P,U,2)
 Q
 ;
UDSET ;
 ; changed line below to look at .2 node for Orderable Item.
 K PSJUD,PSJFNM
 ;S X(2)=$G(^(2)),X(1)=$G(^(.2)),V=$P(X(2),"^",2)_"^"_$P(X(2),"^",4)_"^"_$P(X(1),"^")_":PS(50.3,;"_$$ENPDN^PSGMI($P(X(1),"^"))_"^"_+$P(X(0),"^",2)_":VA(200,;"_$$ENNPN^PSGMI(+$P(X(0),"^",2))_"^"
 S X(2)=$G(^(2)),X(1)=$G(^(.2)),V=$P(X(2),"^",2)_"^"_$P(X(2),"^",4)_"^"_$$GETDRUG_"^"_+$P(X(0),"^",2)_":VA(200,;"_$$ENNPN^PSGMI(+$P(X(0),"^",2))_"^"
 ; PSJ*5*184 Add Discontinued/Edit
 S V=V_$P(X(0),"^",9)_";"_$S($P(X(0),"^",9)="DE":"DISCONTINUED/EDIT",1:$P("ACTIVE^NON-VERIFIED^DISCONTINUED^INCOMPLETE^EXPIRED^HOLD^RENEWAL","^",$F("ANDIEHR",$P(X(0),"^",9))-1))
 ;S Z=$G(^PS(51.2,+$P(X(0),"^",3),0)),V=V_"^"_$P(X(1),"^",2)_"^"_$P(X(0),"^",3)_":PS(51.2,;"_$P(Z,"^",3)_";"_$P(Z,"^")
 S Z=$G(^PS(51.2,+$P(X(0),"^",3),0)),V=V_"^"_$$GETAMT_"^"_$P(X(0),"^",3)_":PS(51.2,;"_$P(Z,"^",3)_";"_$P(Z,"^")
 S Z=$P(X(0),"^",7),V=V_"^"_$P(X(2),"^")_"^"_Z_";"_$S(Z="C":"CONTINUOUS",Z="O":"ONE TIME",Z="OC":"ON CALL",Z="P":"PRN",Z="R":"FILL ON REQUEST",1:"") F Z=-$P(X(2),"^",2):-.00001 I '$D(^UTILITY("PSG",$J,Z)) S ^(Z)=V Q
 Q
 ;
ENIVSE ; IV schedule edit
 S PSJPP="PSJ" F FQ=0:0 K DA,DIC,DR S DIC="^PS(51.1,",DIC(0)="AELSQ",DIC("DR")="4////PSJ;5////C",DIC("S")="I ""C""[$P(^(0),""^"",5)",D="APPSJ" W ! D IX^DIC Q:Y'>0  S DA=+Y,DIE=DIC,DR="[PSJI SCHEDULE EDIT]" K DIC D ^DIE
 K C,D0,D1,FQ,PSJIVSEF,PSJPP,Z D ENIVKV^PSGSETU
 Q
GETDRUG() ; get orderable item or dispense drug
 I '$$DISPCNT&'$D(@(PSJROOT_".2)")) Q $$PRIMARY
 I $$DISPCNT&'$P($G(@(PSJROOT_".2)")),"^",2) Q $$DISPDISP
 E  S PSJFNM=$P($G(@(PSJROOT_".2)")),"^")
 Q PSJFNM_":PS(50.7,;"_$$ENPDN^PSGMI($P(X(1),"^"))_" "_$P($G(^PS(50.606,$P($G(^PS(50.7,PSJFNM,0)),"^",2),0)),"^")
DISPCNT() ;  returns 1 if only only one dispense drug, 0 if more than one
 N CNT,LOOP S (CNT,LOOP)=0 F  S LOOP=$O(@(PSJROOT_"1,"_LOOP_")")) Q:'LOOP  D
 .S CNT=CNT+1
 I CNT>1 S CNT=0
 Q CNT
DISPDISP() ; return Dispense drug name
 N LOOP
 S LOOP=0 F  S LOOP=$O(@(PSJROOT_"1,"_LOOP_")")) Q:'LOOP  D
 .S PSJTEXT=$P($G(^PSDRUG($P($G(@(PSJROOT_"1,LOOP,0)")),"^"),0)),"^")
 .S PSJFNM=$P($G(@(PSJROOT_"1,LOOP,0)")),"^")
 .S PSJUD=$P($G(@(PSJROOT_"1,LOOP,0)")),"^",2)
 .I PSJUD="" S PSJUD=1
 Q PSJFNM_":PSDRUG(;"_PSJTEXT
GETAMT() ; get dosage ordered or units per dose
 Q $S($D(PSJUD):PSJUD,1:$P(X(1),"^",2))
PRIMARY() ; return Primary drug, order has no Orderable Item node
 S PSJTEXT=$P($G(^PS(50.3,+$P($G(@(PSJROOT_".1)")),"^"),0)),"^")
 S PSJFNM=$P($G(@(PSJROOT_".1)")),"^")
 S PSJUD=$P($G(@(PSJROOT_".1)")),"^",2)
 Q PSJFNM_":PS(50.3;"_$S($L(PSJTEXT):PSJTEXT,1:"DRUG NOT FOUND")
