PRCADR2 ;SF-ISC/YJK-PRINT ADDRESS,TRANS.,BALANCE ;3/19/97  3:19 PM
V ;;4.5;Accounts Receivable;**45,104,108,149,141,172,241,233,263,301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
 ;print debtor's /3rd party address,transaction,balances.
 N RCDMC,RCTOP
WR1 W !!,$P(PRCAGL,U,1),?39,"SOC.SEC.NO.: ",?55,PRCASSN
 W:$P(PRCAGL,U,2)'="" !,$P(PRCAGL,U,2)
 W !,$P(PRCAGL,U,4),", ",PRCASTE,"  ",$P(PRCAGL,U,6),?39,"DATE OF BIRTH: ",?55,PRCADOB,!,"PHONE NO.: ",$P(PRCAGL,U,9),?39,"DATE POSTED: " S Y=$P($G(^PRCA(430,D0,6)),"^",21) W:'Y "N/A" I Y D DD^%DT W $P(Y,"@")," ",$P(Y,"@",2)
 I $G(RCKAT) W !,"EMERGENCY RESPONSE INDICATOR: HURRICANE KATRINA"
 I $G(RCDMC) W !,"****Debtor's Account Forwarded To DMC****"
 I $G(RCTOP) W !,"****Debtor's Account Forwarded To TOP****"
 I $G(RCTCSP) W !,"****Debt Referred to Cross-Servicing****"
END1 K %,PRCADOB,PRCASSN,PRCASTE,PRCAGL,Z1,Z2,Z0
 Q
 ;
 ;
WR2 ;called by EN2^PRCADR
 W ! S PRCAGL0=$S($D(^PRCA(433,PRCAEN,0)):^(0),1:""),PRCAG=$S($D(^PRCA(433,PRCAEN,1)):^(1),1:"") Q:(PRCAG="")!(PRCAGL0="")
 S PRCATD=$P(PRCAG,U,1),PRCATY=$P(PRCAG,U,2) Q:'$D(^PRCA(430.3,+PRCATY,0))  S PRCATYPE=$P(^(0),U,3) W ?1,$S($P(PRCAGL0,U,10):"*",1:""),?2,+PRCAGL0
 I $P(PRCAG,U,3)="" D
 .W:PRCATYPE=17 ?12,$P($G(^PRCA(433,PRCAEN,5)),"^",2)
 .W:(PRCATYPE=1)!(PRCATYPE=21) ?12,$P(PRCAG,U,4)
 I $P(PRCAG,U,3)'="" W ?12,$P(PRCAG,U,3)
 S:(PRCATYPE=8)!((PRCATYPE=9)!(PRCATYPE=10)) PRCA("WROFF")=PRCAEN
 W:PRCATY?1N.N&(PRCATYPE'=17) ?22,$P(^PRCA(430.3,PRCATY,0),U,1) I (PRCATYPE=2)!(PRCATYPE=20),$P(^PRCA(433,PRCAEN,0),U,7)]"" W "(",$P(^(0),U,7),")"
 S Y=PRCATD D DD^%DT S Y(1)=$P(Y,", ",2)
 S PRCATD=$E(PRCATD,4,5)_"/"_$E(PRCATD,6,7)_"/"_$E(Y(1),3,4)  ;trans date
 ;  if a decrease adjustment, show as negative (patch 4.5*172)
 I $P(PRCAG,"^",2)=35,$P(PRCAG,"^",5)>0 S $P(PRCAG,"^",5)=-$P(PRCAG,"^",5)
 W ?44,PRCATD,?54,$J($P(PRCAG,U,5),11,2) W:+$P(PRCAGL0,U,4)<2 ?67,"INCOMPLETE"
END2 K PRCAG,PRCATD,PRCATY,PRCATYPE,PRCAGL0
 Q  ;end of WR2
 ;
 ;
WR3 W !,?18,"BALANCES",?31,"PAID"
 W !,?44,"LETTER1/ICD:",?58,PRCAL(1)
 W !,"PRINCIPAL:",?16,$J(PRCAK("PB"),10,2),?26,$J(PRCAK("PP"),9,2),?44,"LETTER2:",?58,PRCAL(2)
 W !,"INTEREST:",?16,$J(PRCAK("IB"),10,2),?26,$J(PRCAK("IP"),9,2),?44,"LETTER3:",?58,PRCAL(3)
 W !,"ADMINISTRATIVE:",?16,$J(PRCAK("AB"),10,2),?26,$J(PRCAK("AP"),9,2),?44,"IRS LETTER:",?58,PRCAL(6)
 W ! W:PRCAK("MF")>0 "MARSHAL FEE:",?16,$J(PRCAK("MF"),10,2),?26,$J(0,9,2) W ?44,PRCACODE_" REF.DATE:",?62,PRCAL(4)
 W:PRCAK("CC")>0 !,"COURT COST:",?16,$J(PRCAK("CC"),10,2),?26,$J(0,9,2)
 W !,"CURRENT:",?16,$J(PRCAK("PB")+PRCAK("IB")+PRCAK("AB")+PRCAK("MF")+PRCAK("CC"),10,2),?26,$J(PRCAK("PP")+PRCAK("AP")+PRCAK("IP"),9,2)
 K PRCAL I $D(^PRCA(430,D0,6)) S PRCAL=^(6) I $P(PRCAL,"^",15)]"" W !!,"     Date forwarded to IRS: " S Y=$P(PRCAL,"^",15) D DD^%DT W Y
 I $D(PRCAL),$P(PRCAL,"^",16)]"" W !,"Prin/Int/Admin IRS balance: " F X=16:1:18 W +$P(PRCAL,"^",X),"/"
 K PRCAL I $G(^PRCA(430,D0,12)) S PRCAL=^(12) I $P(PRCAL,U)]"" W !!,"     Date forwarded to DMC: " S Y=$P(PRCAL,U) D DD^%DT W Y
 I $D(PRCAL),$P(PRCAL,U,2)]"" W !,"Prin/Int/Admin DMC balance: " F X=2:1:4 W +$P(PRCAL,U,X),"/"
 I $D(PRCAL),$P($G(^RCD(340,(+$P(^PRCA(430,D0,0),"^",9)),3)),"^",9)'="" W !,"Lesser Withhold Amt to DMC: ",$J($P(^(3),"^",9),0,2)
 K PRCAL I $G(^PRCA(430,D0,14)) S PRCAL=^(14) I $P(PRCAL,U)]"" W !!,"Date forwarded to TOP: " S Y=$P(PRCAL,U) D DD^%DT W Y
 I $D(PRCAL),$P($G(^RCD(340,(+$P(^PRCA(430,D0,0),"^",9)),6)),"^",6)'="" W !,"TOP Hold Date:  " S Y=$P(^(6),"^",6) D DD^%DT W Y
 I $G(^PRCA(430,D0,15)) S PRCAL=^(15) I $P(PRCAL,U)]"" W !!,"CS Referred Date: " S Y=$P(PRCAL,U) D DD^%DT W Y
END3 K PRCAL,PRCACODE,PRCALT,PRCAK,PRCAGL6,PRCAGL7 Q
