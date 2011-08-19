PSGTCTD0 ;BIR/CML3-PRINT TOTAL COST TO DATE REPORT ;31 OCT 95 / 2:10 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
START ;
 D NOW^%DTC S PSGDT=%,PSGPDT=$$ENDTC^PSGMI(PSGDT),CML=IO'=IO(0)!(IOST'["C-"),(LINE,LN2,NP)="",$P(LINE,"-",81)="",$P(LN2,"=",81)="",(TCNT,TCST)=0
 ;
 I 'PSGWG G:PSGWD W S HDR="(BY PATIENT)" G RUN
 I $D(^PS(57.5,PSGWG,0)),$P(^(0),"^")]"" S HDR="(FOR WARD GROUP: "_$P(^(0),"^")_")" G RUN
 S HDR="(BY WARD GROUP)" G RUN
W I $D(^DIC(42,PSGWD,0)),$P(^(0),"^")]"" S HDR="(FOR WARD: "_$P(^(0),"^")_")"
 E  S HDR="(BY WARD)"
 ;
RUN ;
 S HDRL=80-$L(HDR)\2,PN="" U IO D HDR I '$D(^TMP("PSG",$J)) W !!?18,"*** NO TOTAL COST PER PATIENT FOUND ***" G DONE
 F  D:PN]"" PTOT S PN=$O(^TMP("PSG",$J,PN)) Q:PN=""  D PW G:NP["^" DONE S DRG="",(PCNT,PCST)=0 F  S DRG=$O(^TMP("PSG",$J,PN,DRG)) Q:DRG=""  S CST=^(DRG) D:$Y+4>IOSL NP G:NP["^" DONE D DW
 ;
TOTLS ;
 D:$Y+5>IOSL NP I NP'["^" S TCPU=$S(TCNT:TCST/TCNT,1:0) S:TCST<0&(TCPU>0) TCPU=-TCPU W !!,LN2,!!?5,"TOTALS => ",?17,"AVG. COST/UNIT: ",$J(TCPU,0,2),?52,$J(TCNT,9,0),?67,$J(TCST,12,2)
 I NP'["^",CML F X=$Y:1:IOSL-4 W !
 I  W !?54,"(** = NON-FORMULARY ITEM)"
 ;
DONE ;
 W:CML&($Y) @IOF,@IOF K AD,CML,CST,DIAG,HDR,HDRL,LINE,NP,P,PCNT,PCPU,PCST,PN,PSGPDT,TCNT,TCPU,TCST Q
 ;
PTOT ;
 S TCNT=TCNT+PCNT,TCST=TCST+PCST,PCPU=$S(PCNT:PCST/PCNT,1:0) S:PCST<0&(PCPU>0) PCPU=-PCPU W ?52,"---------",?67,"------------",!?1,"-----  AVG. COST/UNIT: ",$J(PCPU,0,2),?52,$J(PCNT,9,0),?67,$J(PCST,12,2),!! Q
 ;
DW ;
 S CNT=+CST,CST=$P(CST,"^",2),PCNT=PCNT+CNT,PCST=PCST+CST
 W !?4,$S('$P(DRG,"^",2):"  ",1:"**")," ",$P(DRG,"^"),$S($P(DRG,"^")'=+$P(DRG,"^"):"",1:" (DRUG NOT FOUND)"),?52,$J(CNT,9,0),?67,$J(CST,12,2),! Q
 ;
NP ;
 I 'CML W $C(7),!,"'^' TO STOP " R NP:DTIME W:'$T $C(7) S:'$T NP="^" Q:NP["^"
 I CML F X=$Y:1:IOSL-4 W !
 I  W !?54,"(** = NON-FORMULARY ITEM)"
 ;
HDR ;
 W:$Y @IOF W !!?27,"TOTAL COST TO DATE REPORT",?64,PSGPDT,!?HDRL,HDR,!!?7,"Patient",?45,"Admitting Date",!?60,"Admitting Diagnosis",!?10,"Drug",?53,"Dispensed",?72,"Cost",!,LINE Q:PN=""
 ;
PW ;
 G:$Y+7>IOSL NP S PSN=^TMP("PSG",$J,PN),AD=$P(PSN,"^"),DIAG=$S($P(PSN,"^",3)]"":$P(PSN,"^",3),1:"DIAGNOSIS NOT FOUND"),PSN=$P(PSN,"^",2)
 W !!?2,$P(PN,"^"),$S($P(PN,"^")'=$P(PN,"^",2):"",1:$P(PN,"^",2)_";DPT("),"  (",PSN,")",?45,AD,!?79-$L(DIAG),DIAG,! Q
