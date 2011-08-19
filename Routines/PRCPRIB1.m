PRCPRIB1 ;WISC/RFJ-issue book request form (print ^tmp)             ;22 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PRINT ;  print form
 S (PAGE,TOTAL)=0,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H,H1,H2
 S DESCNSN="" F  S DESCNSN=$O(^TMP($J,"PRCPRIB",DESCNSN)) Q:DESCNSN=""!($G(PRCPFLAG))  S LINEITEM=0 F  S LINEITEM=$O(^TMP($J,"PRCPRIB",DESCNSN,LINEITEM)) Q:'LINEITEM!($G(PRCPFLAG))  D
 .   S LINEDA=0 F  S LINEDA=$O(^TMP($J,"PRCPRIB",DESCNSN,LINEITEM,LINEDA)) Q:'LINEDA!($G(PRCPFLAG))  S D=^(LINEDA) D
 .   .   S DATA=$G(^PRCS(410,PRCPDA,"IT",LINEDA,0))
 .   .   W !!,$J(LINEITEM,4),?7,$P(DATA,"^",5)," ",$E($P(D,"^",7),1,15-$L($P(DATA,"^",5)))
 .   .   W ?27,$P(D,"^"),$J($P(D,"^",2),8),$J($P(DATA,"^",7),12,3),$J($P(D,"^",3),9),$J($P(DATA,"^",2),9),$P(D,"^",6)
 .   .   W !?7,$P(D,"^",8)
 .   .   I $P(D,"^",4) W ?27,"Temp Stock Level: ",$P(D,"^",4)
 .   .   I $P(D,"^",5) W ?25,"  Req Issue Mult: ",$P(D,"^",5)
 .   .   S TOTAL=TOTAL+($P(DATA,"^",2)*$P(DATA,"^",7))
 .   .   I $Y>(IOSL-7) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H,H2
 I $G(PRCPFLAG) Q
 I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H,H2
 S %="",$P(%,"_",81)="" W !?49,"TOTAL: ",$J(TOTAL,11,2),!,%
 I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 W !,"Special Remarks:"
 S LINEDA=0 F  S LINEDA=$O(^PRCS(410,PRCPDA,"RM",LINEDA)) Q:'LINEDA!($G(PRCPFLAG))  S D=$G(^(LINEDA,0)) I D'="" D
 .   I $Y>(IOSL-3) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H W !,"Special Remarks (continued):"
 .   W !,D
 I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 W !,"Justification:"
 S LINEDA=0 F  S LINEDA=$O(^PRCS(410,PRCPDA,8,LINEDA)) Q:'LINEDA!($G(PRCPFLAG))  S D=$G(^(LINEDA,0)) I D'="" D
 .   I $Y>(IOSL-3) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H W !,"Justification (continued):"
 .   W !,D
 I $G(PRCPFLAG) Q
 I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 W !,%,!,"Control Point Official:",?40,"|Signature/Date Signed:",!,$E($P($G(^VA(200,+$P(TRANDAT7,"^",3),20)),"^",2),1,38)
 S X=$$DECODE^PRCSC1(PRCPDA) W ?40,"|/ES/|",$E(X,1,22)
 S Y=$P(TRANDAT7,"^",5) S:'Y Y=$P(TRANDAT7,"^",7) D DD^%DT W ?68,"/",Y
 S %="",$P(%,"_",41)="|",$P(%,"_",80)=""
 W !,%,!,"Approved by:",?34,"Date",?40,"|Obligated by:",?74,"Date"
 W !,%,!,"Storekeeper:",?34,"Date",?40,"|Responsible Official:",?74,"Date",!,%,!
 D END^PRCPUREP
 Q
 ;
 ;
H S %="",$P(%,"_",81)="",PAGE=PAGE+1 I PAGE'=1!(SCREEN) W @IOF
 W $C(13),?29,"PRIORITY: ",$P(TRANDAT1,"^",3),!,NOW W:$P(TRANDATA,"^",3)'="" ?20,"TEMP.TRANS#:",$P(TRANDATA,"^",3) W ?45,$P(TRANDATA,"^"),?71,"PAGE ",PAGE,!,%
 W !?27,$S($P(TRANDATA,"^",7)=1:"*INTERVAL ISSUE",1:"*ISSUE BOOK")," REQUEST*",!,%
 Q
 ;
 ;
H1 N % S %="",$P(%,"_",25)="|",$P(%,"_",54)="|",$P(%,"_",79)=""
 W !,"Station: ",+TRANDATA,?24,"|Dept: ",$E(DEPART,1,21),?54,"|Voucher #",!,%
 W !,"Control Pt : ",$E($P(TRANDAT3,"^"),1,26),?40,"|Request  Date: ",$P(TRANDAT1,"^")
 W !,"Cost Center: ",$E($P(TRANDAT3,"^",3),1,26),?40,"|Delivery Date: ",$P(TRANDAT1,"^",4)
 W !,"Deliver To : ",$E($P(TRANDAT9,"^"),1,26),?40,"|Requestor    : ",USER
 S %="",$P(%,"_",41)="|",$P(%,"_",80)=""
 W !,"Classification Of Request: ",$E(CLASS,1,12),?40,"| (*--OVER LEVEL OR ISSUE MULT.)",!,% Q
 ;
 ;
H2 N % S %="",$P(%,"_",81)=""
 W !,"LINE",?7,"DESCRIPTION",?25,"UNIT",?32,"LEVEL",?39,"UNIT PRICE",?51,"ON HAND",?60,"ORD QTY",?71,"QTY DELIV",!,% Q
