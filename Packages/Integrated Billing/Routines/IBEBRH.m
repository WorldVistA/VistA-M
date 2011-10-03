IBEBRH ;ALB/AAS - HELP FOR ENTER BILLING RATES PROCESSOR ;4-MAR-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% S IBX="MAIN" D 1
 Q
 ;
1 ;
 W !!,"Select one of the displayed choices by number or name."
 W !,"You must select the type of rate to add/edit to proceed."
 Q
 ;
2 ;  - help for 1 group of rates
 N I,J,IBP,IBPD,IBNOD
 I IBX="MAIN" D  Q
 .W !!,"CHOOSE FROM:" F J=1:1 S TEXT=$P($T(@IBX+J^IBEBR),";;",2,99) Q:TEXT=""  W !?4,TEXT
 F J=1:1 S IBP=$P($T(@IBX+J^IBEBR),";;",2,99),IBPD=$P(IBP,"^") Q:IBPD=""  D 3
 Q
3 ;  - help for 1 rate name
 N I,IBNOD
 I $D(%DT) W !!,"To edit an entry enter one of the following effective dates.",!
 S I="" F  S I=$O(^IBE(350.2,"B",IBPD,I)) Q:'I  S IBNOD=$G(^IBE(350.2,I,0)) I IBNOD'="" D
 . W !?4,$$DAT2^IBOUTL($P(IBNOD,"^",2)),?20,$E($S($P(IBP,"^",5)'="":$P(IBP,"^",5),1:$P(IBP,"^")),1,20),?42,"$",$J($P(IBNOD,"^",4),7,2)
 . I $P(IBNOD,"^",6) W " + $",$J($P(IBNOD,"^",6),7,2)
 . W ?65,$S($P(IBNOD,"^",5):"INACTIVE",1:"ACTIVE")
 I $D(%DT) W !!,"Or enter a new effective date to add a new rate.",!
 Q
