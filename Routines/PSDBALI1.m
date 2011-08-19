PSDBALI1 ;BIR/JPW-Display/Prt Drug Inv Sheet & Bal (cont'd) ; 12 Apr 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
PRINT ;prints data
 S TYPN="" F  S TYPN=$O(^TMP("PSDBALI",$J,TYPN)) Q:TYPN=""!(PSDOUT)  W !,?2,"=> INVENTORY TYPE: ",$S($E(TYPN,1,2)="ZZ":$E(TYPN,3,99),1:TYPN),! D
 .S PSDR="" F  S PSDR=$O(^TMP("PSDBALI",$J,TYPN,PSDR)) Q:PSDR=""!(PSDOUT)  F PSD=0:0 S PSD=$O(^TMP("PSDBALI",$J,TYPN,PSDR,PSD)) Q:'PSD  D  Q:PSDOUT
 ..I $Y+6>IOSL W !,?10,"Inspector's Signature: ______________________________",! D HDR Q:PSDOUT  W !,?2,"=> INVENTORY TYPE: ",$S($E(TYPN,1,2)="ZZ":$E(TYPN,3,99),1:TYPN),!
 ..S NODE=^TMP("PSDBALI",$J,TYPN,PSDR,PSD),BAL=+NODE,PSDOK=$P(NODE,"^",2),SLVL=$P(NODE,"^",3),EXP=$P(NODE,"^",4)
 ..W !,PSDOK,?2,PSDR,?50,$J(BAL,6),?66,"___________",! W:SLVL ?5,"Stock Level: ",SLVL W:EXP]"" ?30,"Exp. Date: ",EXP W ! S LNUM=$Y
PRT ;
 I LNUM<IOSL-5 F JJ=LNUM:1:IOSL-5 W !
 W:'PSDOUT ?10,"Inspector's Signature: ______________________________",!
 Q
HDR ;header
 I $E(IOST,1,2)="C-",PG K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?12,"Inventory Sheet for ",PSDSN,?72,"Page: ",PG,!,?20,RPDT,!!
 W ?5,"DRUG",?46,"CURRENT BALANCE",?68,"ON-HAND",!,LN,!!
 Q
