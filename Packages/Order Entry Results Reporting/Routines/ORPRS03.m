ORPRS03 ; slc/dcm - (@) Formerly known as prints ;12/7/00  13:15
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,69,92**;Dec 17, 1997
EN ;Print orders
 I $$S^%ZTLOAD S (ZTSTOP,OREND,DIROUT)=1 W !!,"TASKED Report stopped by "_$P(^VA(200,DUZ,0),U) Q
 N DIRUT,DUOUT,ORBOT,ORSPG,ORLINE,YENKO,SHELBY,ORLST,ORREQ
 N ORAGE,ORDOB,ORL,ORNP,ORPNM,ORPV,ORSEX,ORSSN,ORTS,ORWARD
 I $G(ORNO),'$O(^TMP("ORR",$J,ORLIST,0)) Q
 S YENKO=$$GET^XPAR("ALL","OR PRINT NO ORDERS ON SUM",1,"I"),SHELBY=$O(^TMP("ORR",$J,ORLIST,0))
 ;YENKO=0 or "", if you don't want to print a page when no orders are present
 ;      1 to print the page with "NO ORDERS" on it.
 I 'YENKO,'SHELBY Q
 S $P(ORLINE,"=",IOM+1)="",ORBOT=$S(IOSL<254:IOSL,1:254),Y=+ORVP
 D END^ORUDPA
 S ORREQ("O")=""
 I '$G(ORSPG) S ORSPG=1 D
 . I $E(IOST)="C" D CTOP^ORPRS05(ORSPG,$G(ORSEND),$G(ORSPG("EOP")),ORTIT,ORSHORT,ORL(0),ORL(1),ORWARD,ORPNM,ORSSN,ORDOB,ORAGE,$G(ORPD)) Q
 . D PTOP^ORPRS05(ORSPG,ORTIT,ORSHORT,ORSSTRT,ORSSTOP)
 I '$O(^TMP("ORR",$J,ORLIST,0)) W !!?3,"No orders.",!!! D  Q
 . F I=$Y:1:ORBOT-5 W !
 . I $E(IOST)="C" D  Q
 .. K Y F  Q:$G(Y)["^"!($G(Y)=-1)  K DIR S DIR(0)="FO^1;2",DIR("A")="Press RETURN to continue or '^' to exit" D ^DIR S:Y="" Y=-1 K DIR Q:Y<0  D
 ... I Y'["^" W $C(7),!!,"Enter '^' to stop listing for current patient",!,"and '^^' to stop the entire report, or RETURN to continue"
 . D PBOT^ORPRS05(1,ORBOT,ORPNM,ORSSN,ORDOB,ORAGE,$G(ORPD),ORL(0),ORL(1))
 . W @IOF
 . I '$G(ORSEND) Q
 . W !!!!!?(IOM-44)\2,"*****    E N D    O F    R E P O R T    ****",!
 . W @IOF
 . K ORSEND,ORSPG,ORCONT
 S (ORLST,OREND)=0
 F  S ORLST=$O(^TMP("ORR",$J,ORLIST,ORLST)) Q:'ORLST!$D(DUOUT)  D PRT^ORPRS04
 K ORSEND,ORSPG,ORCONT
 Q
ONE(ORIFN,ORSEQ,LENGTH) ;Single line format
 N ORTX,OREL,ORSTS,ORASTS,ORSTRT,ORSTOP,ORFLAG,I,Z,X3
 Q:'$D(^OR(100,ORIFN,3))
 S ORSEQ=$G(ORSEQ),X3=^(3),ORSTS=$P(X3,"^",3),ORSTRT=$P(^(0),"^",8),ORSTOP=$P(^(0),"^",9),OREL=$S(ORSTS=11:1,1:"")
 I $G(OACTION) I $D(^OR(100,ORIFN,8,OACTION,0)) S ORASTS=$P(^(0),"^",15)
 D:'$D(ORTERM(5)) TERM^ORPRS01(IOST)
 S ORFLAG=$$FLAG(ORIFN,ORTERM(5))
 W !
 S X=$P(ORTERM(5),"^")
 S:ORFLAG X=$$INV^ORU
 W ORSEQ_$S($L(ORSEQ)=1:" ",1:"")
 S X=$P(ORTERM(5),"^",2)
 S:ORFLAG X=$$INV^ORU
 S X=$P(ORTERM(7),"^")
 S:OREL X=$$INV^ORU
 W $S($G(ORASTS)!(ORSTS):" "_$P(^ORD(100.01,$S($G(ORASTS):ORASTS,1:ORSTS),.1),"^"),1:" ")
 S:'$G(LENGTH) LENGTH=45
 D TEXT^ORQ12(.ORTX,$S($G(OACTION):ORIFN_";"_OACTION,1:ORIFN),LENGTH)
 F I=0:0 S I=$O(ORTX(I)) Q:'I  W:I>1 ! W ?14,ORTX(I)
 S Z=$S($D(ORDAD):$S(ORDAD:2,1:1),1:1)
 I Z=2 S ORSTRT=$$FMTE^XLFDT(ORSTRT,"2M"),ORSTOP=$$FMTE^XLFDT(ORSTOP,"2M") W:($X+9+$L(ORSTRT)+$S($L(ORSTOP):$L(ORSTOP)+8,1:0))>(LENGTH+14) !?14 W "  Start: "_ORSTRT W:$L(ORSTOP) "  Stop: "_ORSTOP
 I OREL S X=$P(ORTERM(7),"^",3),X=$$INV^ORU
 Q
PRT1(ORIFN,LENGTH) ;For kids sake
 ;ORIFN=Internal order # of parent order
 ;LENGTH=column width length
 N ORCHLD
 S ORCHLD=0
 F  S ORCHLD=$O(^OR(100,ORIFN,2,ORCHLD)) Q:ORCHLD<1  D:(($Y+5)>ORIOSL) WAIT Q:$G(OREND)  D ONE(ORCHLD,"         ",$G(LENGTH))
 Q
FLAG(ORIFN,INVERSE) ;Is order flagged?
 S X=""
 I $D(^OR(100,ORIFN,6)),$P(^(6),"^"),$L($P($G(INVERSE),"^")),$L($P($G(INVERSE),"^",2)) S X=1
 Q X
WAIT ;
 I $G(ORFOOT) D  Q
 . W ?(IOM-15),"(continued...)"
 . D FOOT^ORPR01(ORFOOT)
 . I '$G(OREND),$G(ORHEAD) D HEAD^ORPR01(ORHEAD) W !,"(...continued)"
 Q:$E(IOST)'="C"
 D PGBRK^ORUHDR,TIT^ORUHDR:$D(ORTIT)
 W:'$D(ORTIT)&($G(ORIOF)]"") @ORIOF
 Q
