PRCAREPC ;SF-ISC/NYB-CATEGORY LIST-BILLS ;8/26/93  8:43 AM
V ;;4.5;Accounts Receivable;**72,94,63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN N BN,BN0,BN7,CBAL,DBP,DBP1,DEB,DEBT,DP1,FL,III
 N NCT,NCT2,NDE,PBAL,RCDOJ,SCT,SCT2,STAB
 N STOT,STOT2,TFLG,TOT,TOT2
 I CAT="ALL" S CNO=0 F  S CNO=$O(^PRCA(430.2,"AC",CNO)) Q:CNO=""  D
    .S CAT=0 S CAT=$O(^PRCA(430.2,"AC",CNO,CAT)) Q:CAT=""  D
       ..S ^TMP($J,"PRCAT",CAT)=""
       ..Q
    .Q
 I ST="ALL" S ST=0 F  S ST=($O(^PRCA(430.3,"AC",ST))) Q:ST=""  D
    .Q:ST<100!(ST=107)
    .S ^TMP($J,"PRCAST",$O(^PRCA(430.3,"AC",ST,0)))=""
    .Q
 S (CAT,TFLG)=0 F  S CAT=$O(^TMP($J,"PRCAT",CAT)) Q:CAT=""!($G(OT)="^")  D
    .S ST=0 F  S ST=$O(^TMP($J,"PRCAST",ST)) Q:ST=""!($G(OT)="^")  D
       ..S ^TMP($J,"PRCASC",ST,CAT)=1
       ..Q
    .Q
 S ST=0 F  S ST=$O(^TMP($J,"PRCASC",ST)) Q:ST=""  D
    .S (NCT,PRCAE,TOT,TOT2)=0 F  S PRCAE=$O(^PRCA(430,"AC",ST,PRCAE)),X="" Q:'PRCAE  D
       ..N DEB
       ..Q:'$O(^TMP($J,"PRCASC",0))
       ..S BN0=$G(^PRCA(430,PRCAE,0))
       ..S BN=$P($G(BN0),"^")
       ..S RCDOJ=$$REFST^RCRCUTL(PRCAE)
       ..I RCDOJ S BN=BN_"r"
       ..S CT4=$P($G(BN0),"^",2)
       ..S CAT=+$O(^TMP($J,"PRCASC",ST,(CT4-1)))
       ..I +$G(CAT)'>0 Q
       ..I $G(CT4)'=CAT Q
       ..S DEBT=$P($G(BN0),"^",9)
       ..I $G(DEBT) D
          ...S DEB=$P($G(^RCD(340,DEBT,0)),"^") Q:'DEB
          ...S DEB="^"_$P(DEB,";",2)_+DEB_",0)"
          ...S DEB=$G(@DEB),DEB=$P(DEB,"^")
          ...Q
       ..S DBP=$P($G(BN0),"^",10)
       ..I DT1'="",DBP<DT1 Q
       ..I DT2'="",DBP>DT2 Q
       ..I '$G(DBP) S DBP="**NONE**"
       ..S ST2=$G(^PRCA(430.3,ST,0))
       ..S STAB=$P($G(ST2),"^",2),ST2=$P($G(ST2),"^")
       ..S CAT2=$P($G(^PRCA(430.2,CT4,0)),"^")
       ..S BN7=$G(^PRCA(430,PRCAE,7))
       ..S PBAL=+$P($G(BN7),"^")
       ..S CBAL=0 F X=1:1:5 S CBAL=CBAL+$P($G(BN7),"^",X)
       ..S ^TMP($J,"PRCACS",CAT2,STAB,DBP,BN)=BN_"^"_$G(DEB)_"^"_PBAL_"^"_CBAL
       ..Q
    .Q
 K ^TMP($J,"PRCAT"),^TMP($J,"PRCASC"),^TMP($J,"PRCAST")
WRITE ;Write out report.
 I '$D(^TMP($J,"PRCACS")) D HDR1 I $E(IOST)'="C" W @IOF Q
 S (FL,NCT,SCT,STOT,STOT2,TOT,TOT2)=0
 S CAT="" F  S CAT=$O(^TMP($J,"PRCACS",CAT)) G:CAT=""!($G(OT)="^") ENQ D
    .I 'FL D HDR
    .I FL,$E(IOST)="C" D TOP Q:$G(OT)="^"  D HDR S FL=0
    .I FL,$E(IOST)="P" W @IOF D HDR S FL=0
    .S STAB="" F  S STAB=$O(^TMP($J,"PRCACS",CAT,STAB)) Q:STAB=""!($G(OT)="^")  D 
       ..I FL,$E(IOST)="C" D TOP Q:$G(OT)="^"  D HDR
       ..I FL,$E(IOST)="P" W @IOF D HDR
       ..S DBP=0 F  S DBP=$O(^TMP($J,"PRCACS",CAT,STAB,DBP)) Q:DBP=""!($G(OT)="^")  S BN=0 F  S BN=$O(^TMP($J,"PRCACS",CAT,STAB,DBP,BN)) Q:BN=""!($G(OT)="^")  D 
          ...S NDE=$G(^TMP($J,"PRCACS",CAT,STAB,DBP,BN))
          ...S Y=DBP D DD^%DT S DBP1=Y
          ...S DEB=$P($G(NDE),"^",2)
          ...S PBAL=$P($G(NDE),"^",3),CBAL=$P($G(NDE),"^",4)
          ...S STOT=STOT+PBAL,SCT=SCT+1
          ...S STOT2=STOT2+CBAL
          ...W !,BN,?14,$E(DEB,1,15),?32,DBP1,?46,STAB,?51,$J(PBAL,9,2),?65,$J(CBAL,9,2)
          ...I $E(IOST)="C",$Y+5>IOSL D TOP Q:$G(OT)="^"  D HDR
          ...I $E(IOST)="P",$Y+5>IOSL W @IOF D HDR
          ...S FL=1
          ...Q
       ..D SUB
       ..Q
    .D TOT
    .W !!,"( r - Bill is Currently Referred )",!
    .Q
ENQ K ^TMP($J),DIC,DIC(0)
 Q
TOP ;Press return to continue prompt.
 N DTOUT,DUOUT,DIRUT,DIR,DIROUT,Y
 Q:$G(OT)="^"
 S DIR(0)="E" D ^DIR I +Y=0 S OT="^"
TOPQ Q
HDR ;Header of the report.
 I $E(IOST)="C" W @IOF
 W "CATEGORY LISTING FOR BILLS REPORT",?45,"   ",SDT,"       Page: "_PAGE
 W !,"Sort Criteria for Date Prepared: "_SC1_" to "_SC2
 W !,?32,"Date",?52,"Princpal",?68,"Current"
 W !,"Bill No.",?14,"Debtor",?32,"Preprd",?43,"Status"
 W ?52,"Balance",?68,"Balance"
 S X="",$P(X,"-",IOM-1)="" W !,X,!
 W !,?7,"CATEGORY: "_$G(CAT),!!
 S PAGE=PAGE+1
HDRQ Q
HDR1 ;Header if there is nothing to print.
 I $E(IOST)="C" W @IOF
 W "CATEGORY LISTING FOR BILLS REPORT",?45,"   ",SDT,"       Page: "_PAGE
 W !,"Sort Criteria for Date Prepared: "_SC1_" to "_SC2
 W !,?32,"Date",?52,"Princpal",?68,"Current"
 W !,"Bill No.",?14,"Debtor",?32,"Preprd",?43,"Status"
 W ?52,"Balance",?68,"Balance"
 S X="",$P(X,"-",IOM-1)="" W !,X,!
 W !!,"****NO RECORDS TO PRINT****",!!
HDR1Q Q
SUB ;Calculates the subtotals
 D SUB1 Q:$G(OT)="^"
 S (STOT,STOT2,SCT)=0
SUBQ Q
SUB1 I $G(Y)="^" S OT="^"
 I $G(SCT)>0 W !?50,"----------",?64,"----------",!?41,"SUBTOTAL:"
 I  W ?50,$J(STOT,10,2),?64,$J(STOT2,10,2),!?41,"SUBCOUNT:"
 I  W ?50,$J(SCT,10),?64,$J(SCT,10)
 S NCT=NCT+SCT,TOT=TOT+STOT,TOT2=TOT2+STOT2
SUB1Q Q
TOT ;Calculates the totals.
 W !?50,"----------",?64,"----------"
 W !?44,"TOTAL:",?50,$J(TOT,10,2),?64,$J(TOT2,10,2)
 I $G(NCT)>0 W !?44,"COUNT:",?50,$J(NCT,10),?64,$J(NCT,10)
 S (NCT,TOT,TOT2)=0
 S TFLG=1
TOTQ Q
