IBTOAT2 ;ALB/AAS - CLAIMS TRACKING ADMISSION SHEET PRINT ; 18-JUN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ;D DEMO,LINE,ADM,LINE,EM,LINE,INS,LINE,DIAG,PROC,FNL,SC,STMT
 D DIAG,PROC,SC,STMT
 Q
 ;
DIAG ; -- pirnt diagnosis/procedure block
 W !?TAB,"Date",?12,"Diagnosis",?37,"Procedure",?60,"Final",?68,"DRG",?73,"LOS"
 F I=1:1:5 D BLINE
 Q
 ;
PROC ; -- print procedures done
 ;W !!?TAB,"Procedures Done",?56,"Date"
 ;D TWOL^IBTOAT1
 Q
 ;
 ;
SC ; -- prints sc conditions
 N I,I1,I2,I3
 S I3=0
 S MAX=$S(IOSL<61:4,IOSL<67:6,1:11)
 I '+VAEL(3) W !! G SCQ
 W !!?TAB,"Service Connected Conditions: " W:'$G(IBTRCSC) ?54,"Treated"
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  D  I '$G(IBTRCSC),I3>MAX W !?TAB,"MORE...." Q
 .S I1=^DPT(DFN,.372,I,0)
 .Q:'$P(I1,"^",3)
 .S I2=$G(^DIC(31,+I1,0))
 .S:$P(I2,"^",4)'="" I2=$P(I2,"^",4)
 .S I2=$P(I2,"^")
 .W !?TAB+5,$E(I2,1,39),?49,$J($P(I1,"^",2),3)_"%" W:'$G(IBTRCSC) " _______" S I3=I3+1
 .Q
 I 'I3 W !?TAB,$S('$O(^DPT(DFN,.372,0)):"NONE STATED",1:"NO SC DISABILITIES LISTED") S I3=1
SCQ F I3=I3:1:MAX W !
 Q
 ;
STMT ; -- print attestation and sig. lines
 W !!,"I attest that these are the diagnoses and procedures for which the"
 W !,"Patient was treated during this episode of care."
 W !!,"MD: __________________________________    Date: __________________"
 W !!,"Patient: ",$E(VADM(1),1,20),"  ",VA("PID"),?IOM-30," Printed: " D NOW^%DTC S Y=% D D^DIQ W $P(Y,":",1,2)
 Q
 ;
BLINE ; -- write line with BARS
 ;
 W !?TAB,"     |                        |                      |        |     |"
 W !?TAB,"_____|________________________|______________________|________|_____|_____"
 Q
