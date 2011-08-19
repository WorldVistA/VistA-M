PSJ0186 ;BIR/JLC - FIND ORDERS WITH NULL SI / OPI ;09/14/2006
 ;;5.0; INPATIENT MEDICATIONS ;**186**;16 DE7 97
 ;
 ;Reference to ^PS(50.7 is supported by DBIA 2180.
 ;Reference to ^PS(55 supported by DBIA 2191.
 ;Reference to ^XPD(9.7 supported by DBIA 2197.
 ;
EN ; Select device and determine format
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 N F1,F2,ZTDESC,XSAVE,ZTRTN
 Q:$$SELDEV^PSJMUTL
 W:'$D(IO("Q")) !,"this may take a while..."
F1 ;determine whether print format or comma-delimited
 W !!,"(P)rint format or (C)omma-delimited output: " R F1:60 W "  " I F1="" G EN
 I F1="^" G EXIT
 I F1'="P",F1'="C" W "Enter P or C" G F1
F2 W !!,"(O)nly active or (A)ll orders: " R F2:60 W "  " I F2="" G F1
 I F2="^" G EXIT
 I F2'="O",F2'="A" D  G F2
 . W "Enter O for a list of active or recently expired orders only"
 . W !?10,"Enter A for all orders since PSB*3*13 was installed."
 I $D(IO("Q")) D  G EXIT
 . N I,A
 . S ZTDESC="Search for Special Instruction / Other Print Info Isses (Sort)"
 . S XSAVE="F1;F2"
 . S ZTRTN="START^PSJ0186"
 . F I=1:1 S A=$P(XSAVE,";",I) Q:A=""  S ZTSAVE(A)=""
 . D ^%ZTLOAD
 D START
 Q
START ;find potential problem orders
 K ^TMP("PSJ0186",$J) N START,S1,DFN,ORDER,A,B,A0,A2,AD2,I,B,RDT,%,FIRST,PG,Y,ZTSAVE
 D NOW^%DTC S RDT=$E(%,4,5)_"/"_$E(%,6,7)_"/"_($E(%,1,3)+1700),FIRST=%
 I F2="A" S A=$O(^XPD(9.7,"B","PSB*3.0*13","")) I A]"" S FIRST=$P($G(^XPD(9.7,A,1)),"^") I FIRST="" S FIRST=%
 S S1=FIRST-8
 F  S S1=$O(^PS(55,"AUD",S1)) Q:'S1  D
 . S DFN=0
 . F  S DFN=$O(^PS(55,"AUD",S1,DFN)) Q:'DFN  D
 .. S ORDER=0
 .. F  S ORDER=$O(^PS(55,"AUD",S1,DFN,ORDER)) Q:'ORDER  D
 ... Q:'$D(^PS(55,DFN,5,ORDER,6))  S A=$G(^(6)) Q:$P(A,"^",2)'=1
 ... S B=$P(A,"^") I B=""!(B?1." ") D
 .... S A0=$G(^PS(55,DFN,5,ORDER,0)),AD2=$G(^(.2)),A2=$G(^(2))
 .... S ^TMP("PSJ0186",$J,DFN,"UD",ORDER)=$P(A2,"^",2)_"^"_$P(A2,"^",4)_"^"_$P(AD2,"^")_"^"_$P(A0,"^",9)
 S S1=FIRST-8 F  S S1=$O(^PS(55,"AIV",S1)) Q:'S1  D
 . S DFN=0
 . F  S DFN=$O(^PS(55,"AIV",S1,DFN)) Q:'DFN  D
 .. S ORDER=0
 .. F  S ORDER=$O(^PS(55,"AIV",S1,DFN,ORDER)) Q:'ORDER  D
 ... Q:'$D(^PS(55,DFN,"IV",ORDER,3))  S A=$G(^(3)) Q:$P(A,"^",2)'=1
 ... S B=$P(A,"^") I B=""!(B?1." ") D
 .... S A0=$G(^PS(55,DFN,"IV",ORDER,0)),AD2=$G(^(.2))
 .... S ^TMP("PSJ0186",$J,DFN,"IV",ORDER)=$P(A0,"^",2)_"^"_$P(A0,"^",3)_"^"_$P(AD2,"^")_"^"_$P(A0,"^",17)
 S (DFN,PG)=0 U IO I F1'="C" D HDR
 F  S DFN=$O(^TMP("PSJ0186",$J,DFN)) Q:'DFN  D
 . F I="UD","IV" D
 .. S ORDER=0
 .. F  S ORDER=$O(^TMP("PSJ0186",$J,DFN,I,ORDER)) Q:ORDER=""  S A=^(ORDER) D
 ... S B=^DPT(DFN,0)
 ... I F1="P" D
 .... W $E($P(B,"^"),1,25),?28,$E($P(B,"^",9),6,9),?34,$E($G(^DPT(DFN,.1)),1,10),?45
 .... S B=$P(A,"^") W $E(B,4,5),"/",$E(B,6,7),"/",$E(B,1,3)+1700,?57
 .... S B=$P(A,"^",2) W $E(B,4,5),"/",$E(B,6,7),"/",$E(B,1,3)+1700,"  "
 .... I $Y+1>IOSL D HDR
 .... W $P(A,"^",4)," (",$S(I="UD":"UD",1:"IV"),") ",$P($G(^PS(50.7,$P(A,"^",3),0)),"^"),!
 ... I F1="C" D
 .... W $P(B,"^"),",",$E($P(B,"^",9),6,9),",",$G(^DPT(DFN,.1)),","
 .... S B=$P(A,"^") W $E(B,4,5),"/",$E(B,6,7),"/",$E(B,1,3)+1700,","
 .... S B=$P(A,"^",2) W $E(B,4,5),"/",$E(B,6,7),"/",$E(B,1,3)+1700,","
 .... W $P(A,"^",4),",(",$S(I="UD":"UD",1:"IV"),"),",$P($G(^PS(50.7,$P(A,"^",3),0)),"^"),!
 I '$D(^TMP("PSJ0186",$J)) W "Nothing to print",!
EXIT D ^%ZISC Q
HDR S PG=PG+1 W:$Y @IOF W RDT,?32,"SI/OPI RESEARCH",?83,"PAGE: ",PG,!!
 W "PATIENT NAME",?28,"SSN",?34,"WARD",?45,"START DATE",?57,"STOP DATE",?69,"ORDER INFO",!!
 Q
