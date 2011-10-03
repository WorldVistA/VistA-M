IBCF10 ;ALB/MJB - PRINT UB-82 BILL (CONT.)  ;13 JUN 88 12:39
 ;;2.0;INTEGRATED BILLING;**133,210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRP0
 ;
 Q
7 W ! I IB("M")]"",$P(IB("M"),"^",4)]"" S IBMA=IB("M"),IBPST=$S($P(IBMA,U,8)']"":"",$D(^DIC(5,+$P(IBMA,U,8),0)):$P(^(0),U,2),1:"")
 I $D(IBMA),IBMA'="" W $P(IBMA,"^",4),! W:$P(IBMA,"^",5)]"" $P(IBMA,"^",5) W:$D(IBCC(1)) ?30,IBCC(1) W:$D(IBCC(2)) ?33,IBCC(2) W:$D(IBCC(3)) ?36,IBCC(3) W:$D(IBCC(4)) ?39,IBCC(4) W:$D(IBCC(5)) ?42,IBCC(5)
 W:$P(IB("U1"),U,7)]"" ?61,$P(IB("U1"),U,7) I $D(IBMA) W:$P(IBMA,"^",6)]"" !,$P(IBMA,"^",6) W:$P(IB("M1"),"^",1)]"" !,$P(IB("M1"),"^",1) W !,$P(IBMA,"^",7),?$X+2,IBPST,?$X+2,$P(IBMA,"^",9)
8 F I=1:1 Q:$Y>15  W !
 D NWREVC
 I DGPAG'=DGTOTPAG W "  (page ",DGPAG," of ",DGTOTPAG,")"
 F I=1:1 Q:$Y>29  W !
 K IB01 D Q1^IBCVA,Q4^IBCVA,EN3^IBCVA0
9 F I=1:1 Q:$Y>39  W !
 ;PAYER
 W ! I '$D(^DGCR(399,IBIFN,"AIC")),$P(IB(0),"^",7),$P(^DGCR(399.3,$P(IB(0),"^",7),0),"^")["ESRD" W "MEDICARE ESRD"
 I '$D(^DGCR(399,IBIFN,"AIC")) W ?24,$S($P(IB("U"),U,5)=0:"Y",1:"R"),?27,$S($P(IB("U"),U,6)["N":"N",$P(IB("U"),U,6)["n":"N",$P(IB("U"),U,6)=0:"N",1:"Y") D Q3^IBCVA,EN2^IBCVA0 G 11
 I $D(IBDD) F I=1:1 S IBIN=$O(IBDD(I)) Q:'$D(IBDD(I,0))  S X=$P($G(^DIC(36,($P(IBDD(I,0),U,1)),0)),U,1),M=$P(IB("U"),U,6) W !,$E(X,1,23),?24,$S($P(IB("U"),U,5)=0:"Y",1:"R"),?27,$S(M["N":"N",M["n":"N",M=0:"N",1:"Y")
10 F I=1:1 Q:$Y>44  W !
 ;INSURED
 I $D(IBDD) F I=1:1 S IBIN=$O(IBDD(I)) Q:'$D(IBDD(I,0))  W !,$P(IBDD(I,0),U,17),?23,$E(IBISEX(I),1),?26,IBIRN(I),?29,$P(IBDD(I,0),U,2),?46,$E($P(IBDD(I,0),U,15),1,14),?61,$P(IBDD(I,0),U,3)
 D Q3^IBCVA,EN2^IBCVA0
11 I '$D(^DGCR(399,IBIFN,"AIC")),$P(IB(0),"^",7),$P(^DGCR(399.3,$P(IB(0),"^",7),0),"^")["ESRD" X "F I=1:1 Q:$Y>44  W !" W !,VADM(1),?23,$P(VADM(5),"^"),?26,"01",?29,$P(VADM(2),"^")
 F I=1:1 Q:$Y>49  W !
 ;EMPLOYMENT INFO
 S IBROI="" I $D(^DGCR(399,IBIFN,"I1")) S IBROI=$P(^("I1"),U,6)
 I IBROI="s" W "S" I $D(^DPT(DFN,.25)) S IBSPEM=^(.25) W " 9",?4,$P(IBSPEM,U),?42,$P(IBSPEM,U,5),?$X+2,$S($P(IBSPEM,U,6)'="":$P(^DIC(5,$P(IBSPEM,U,6),0),U,2),1:""),?$X+2,$P(IBSPEM,U,7) K IBSPEM
 I IBROI="v" W "P" I $D(IBEMPD),IBEMPD]"" W ?2,$S('$D(IBEC):9,IBEC:IBEC,1:9),?4,$P(IBEMPD,U),?42,$P(IBEMPD,U,2),?$X+2,$S($P(IBEMPD,U,7)'="":$P(^DIC(5,$P(IBEMPD,U,7),0),U,2),1:""),?$X+2,$P(IBEMPD,U,8)
 K IBROI
 D Q2^IBCVA,EN4^IBCVA1,EN5^IBCVA1
12 F I=1:1 Q:$Y>52  W !
 ;I IB("C")]"" W:$P(IB("C"),U,14)'="" $P(^ICD9($P(IB("C"),U,14),0),U,3) K X2 S X=$P(IB("C"),U,14) D ICW W ?44,X S X2=44 F I=15:1:18 Q:'$D(IBDIN(I))  S X=IBDIN(I) D ICW W ?X2,X
 N IBINDXX,IBEVDT
 D SET^IBCSC4D(IBIFN,"",.IBINDXX) I $D(IBINDXX)>2 D
 . S IBEVDT=$$BDATE^IBACSV(IBIFN) ; Event Date
 . S I=$O(IBINDXX(0)) Q:'I
 . W $P($$ICD9^IBACSV(+IBINDXX(I),IBEVDT),U,3)
 . S X2=37,I=0 F  S I=$O(IBINDXX(I)) Q:'I  S X=IBINDXX(I) D ICW W ?X2,X
 D 13^IBCF11
 Q
ICW S X=$P($$ICD9^IBACSV(+X),U) S:$D(X2) X2=X2+7
 Q
NWREVC ;print for mult bedsections/rev codes
 F I=0:0 S DGCNT=$O(^UTILITY($J,"IB-RC",DGCNT)) Q:'DGCNT!(DGCNT>(DGPAG*23))  S DGTEXT=^(DGCNT) D NWREVC1
 S DGCNT=DGCNT-1
 Q
NWREVC1 ;
 I DGTEXT="" W ! Q
 I $P(DGTEXT,"^",5,99)]"" X $P(DGTEXT,"^",5,99) Q
 I $P(DGTEXT,"^")]"" W !,$P(DGTEXT,"^") Q
 I $P(DGTEXT,"^",4)="C" W ! S:$L($P(DGTEXT,"^",3)) DGTEXT1=$P(DGTEXT,"^",2) W:$L(DGTEXT1) +$E(DGTEXT1,4,5)_"/"_+$E(DGTEXT1,6,7)_"/"_$E(DGTEXT1,2,3) D ADDCOD Q
 I $P(DGTEXT,"^",2),$D(^DGCR(399,IBIFN,"RC",$P(DGTEXT,"^",2),0)) S DGREVC=^(0) D NWREVC2 Q
 Q
NWREVC2 W !,$E($P(^DGCR(399.2,+DGREVC,0),"^",2),1,22),?22,$J($P(DGREVC,"^",2),7,2),?31,$P(^(0),"^"),?35,$J($P(DGREVC,"^",3),3),?39,$J($P(DGREVC,"^",4),9,2)
 Q
ADDCOD ;Additional Procedures Print
 Q:'$P(DGTEXT,U,3)  S IBCPT=""
 I DGTEXT["ICD" S IBCPT=$$ICD0^IBACSV(+$P(DGTEXT,U,3),$G(DGTEXT1))
 I DGTEXT["ICPT" S IBCPT=$$CPT^IBACSV(+$P(DGTEXT,U,3),$G(DGTEXT1))
 W ?11,$P(IBCPT,U)
 Q
 ;IBCF10
