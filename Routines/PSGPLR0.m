PSGPLR0 ;BIR/CML3-PRINTS PICK LIST REPORT (CONT.) ;16 Jul 98 / 12:46 PM
 ;;5.0; INPATIENT MEDICATIONS ;**15,34,58**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ;
B0 ;
 F  S (PW,WDN)=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN)) Q:WDN=""  D:FFF=1 FCL F  S (PRM,RM)=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM)) Q:RM=""  F  S PN=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN)) Q:PN=""  D B1
 Q
 ;
B1 ;
 I $G(PSGPLSTR)'="" S TM=$P(PSGPLSTR,"^",1),WDN=$P(PSGPLSTR,"^",2),RM=$P(PSGPLSTR,"^",3),PN=$P(PSGPLSTR,"^",4,5) K PSGPLSTR
 S PPN=$G(^PS(53.5,PSGPLG,1,+$P(PN,U,2),0)),PPN=$P(PPN,U,3,4)
 S PSGP=$P(PN,"^",2) S:WSF PW=$P(PPN,"^") S PRM=$P(PPN,"^",2),PRM=$S($P(TND,U,6):$P(PRM,"-",2)_"-"_$P(PRM,"-"),1:PRM) D P1
 S PST=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN,"")) I PST="NO ORDERS" W !!?27,"No orders found for this patient." Q
 I PST="A" D EXH S DRG="" F  S DRG=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN,"A",DRG)) Q:DRG=""  D GTORDER,PLN3
 I PST="A",$O(^PS(53.5,PSGPLG,TM,WDN,RM,PN,"A"))]"" W ! W:OCNT !?6,OLINE W !?30,"**** ACTIVE ORDERS ****" W:'OCNT !?6,OLINE
 S PST="A" F  S PST=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN,PST)) Q:"Z"[PST  S DRG="" F  S DRG=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN,PST,DRG)) Q:DRG=""  D GTDOSES,P2
 I PST="Z" D EXH S DRG="" F  S DRG=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN,"Z",DRG)) Q:DRG=""   D GTORDER,PLN3
 Q
 ;
GTORDER ; Get order number of order in 55.
 S PSJJORD=+$G(^PS(53.5,PSGPLG,1,PSGP,1,+$P(DRG,U,2),0))
 ;
GTDOSES ; Set # dispense drugs and times to be admined.
 S PSJORDN=$P($G(^PS(53.5,PSGPLG,1,PSGP,1,+$P(DRG,U,2),0)),U,4)_U_$P($G(^(1,0)),U,4)
 Q
 ;
P1 ;
 S ND=$G(^DPT(PSGP,0)),PPN=$S($P(ND,"^")]"":$P(ND,"^"),1:PSGP),PSSN=$E($P(ND,"^",9),6,9),PW=$S(PW="zz":"* N/F *",1:PW),WL="",$P(WL,"=",37-($L(PW)/2))="" D:FFF=2 FCL I $Y+6>IOSL D HEADER
PLN1 W !!,WL," WARD: ",PW," ",WL,!?1,$S(PRM'["zz":PRM,1:"* N/F *"),?11,"  ",$S(PPN'=PSGP:PPN,1:"NOT FOUND ("_PSGP_")"),$S(PSSN:"  ("_PSSN_")",1:""),":" S OCNT=0 Q
 ;
P2 ;
 S PSJJORD=+$G(^PS(53.5,PSGPLG,1,PSGP,1,+$P(DRG,U,2),0))
 D:$Y+9+$P(PSJORDN,"^",2)>IOSL HEADER,PLN1 S OCNT=OCNT+1 W ! W:OCNT>1 !?6,OLINE
 S ND0=$G(^PS(55,PSGP,5,PSJJORD,0)),ND1=$G(^(.2)),ND2=$G(^(2)),ND6=$P($G(^(6)),"^"),RTE=$P(ND0,"^",3),SM=$S('$P(ND0,"^",5):0,$P(ND0,"^",6):2,1:1),PDRG=$$ENPDN^PSGMI($P(ND1,"^")),DO=$P(ND1,"^",2),Y="" I ND6]"" S Y=$$ENSET^PSGSICHK(ND6)
 S SD=$P(ND2,"^",2),(FD,STPDT)=$P(ND2,"^",4),AT=$P(ND2,"^",5),FQC=$P(ND2,"^",6),SCH=$P(ND2,"^") S:SCH="" SCH="SCHEDULE NF" S RTE=$$ENMRN^PSGMI(RTE) F X="SD","FD" S @X=$$ENDTC^PSGMI(@X) I PST'="R",FQC="D",AT="" S AT=$E($P(SD,".",2)_"0000",1,4)
 D DD^PSGPLR
 Q
 ;
PLN3 ;
 D:$Y+9+$P(PSJORDN,"^",2)>IOSL HEADER,PLN1,EXH S OCNT=OCNT+1 W ! W:OCNT>1 !?6,OLINE
 S RTE=$P($G(^PS(55,PSGP,5,PSJJORD,0)),"^",3,9),SCH=$G(^(2)),DR=$G(^(.2)),DIS=$P(RTE,"^",7),RTE=$P(RTE,"^"),DO=$P(DR,"^",2),SD=$P(SCH,"^",2),(FD,STPDT)=$P(SCH,"^",4),SCH=$P(SCH,"^"),DIS=$S(DIS'["D":"EXPIRED",1:"DISCONTINUED")
 S DR=$$ENPDN^PSGMI($P(DR,"^")),RTE=$$ENMRN^PSGMI(RTE)
 F X="SD","FD" S @X=$$ENDTC^PSGMI(@X)
 D EXDD^PSGPLR
 Q
 ;
FCL ;
 I PGN,CML,$P(PSGPLWGP,"^",6) D PAGECK^PSGPLR W !!?25,"FILLED BY: ",FACL,!!?25,"CHECKED BY: "_FACL
 ;
HEADER ;
 S PGN=PGN+1 W:$Y @IOF
 W ?1,"(",PSGPLG,")",?$S($D(PSGPLUPF):27,1:32),"PICK LIST REPORT" W:$D(PSGPLUPF) " (UPDATE)" W ?64,PPLD,!,"Ward group: ",WGPN,?73-$L(PGN),"Page: ",PGN,!?18,"For ",PSD," through ",PFD W:NPLF !,"Team: ",$S(TM'["zz":TM,1:"** N/F **")
 W !!,$S($P(TND,"^",6)&'$P(TND,"^",8):"Bed-Room",1:"Room-Bed"),?15,"Patient",?67,"Units",?74,"Units",!?9,"Medication",?48,"ST",?62,"U/D",?66,"Needed",?74,"Disp'd",!,LINE Q
 ;
EXH ;
 W !?6,OLINE
 ;I VAINDT'="" D INP^VADPT I $G(VAIN(4)) N WARD S WARD=$P($G(VAIN(4)),"^",2) I WARD'=PW W !,?18,"*** DC'D OR EXPIRED FROM "_WARD_" "_$G(VAIN(5))_" ***" Q
 W !,?18,"*** DC'D OR EXPIRED WITHIN LAST 24 HOURS ***"
 Q
 ;
HEADSP ;Screen stops
 K PSJDLW,DIR S DIR(0)="E" D ^DIR I $D(DTOUT)!$D(DUOUT) S PSJDLW=1
 Q
