PRCF826 ;WISC/CLH/TEN-826 STATUS OF FUNDS RPT ;5/4/93  9:14 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 S PRCF("X")="ABSQ"
 D ^PRCFSITE
 G:'% OUT
 ;
D S %ZIS="MQ"
 D ^%ZIS
 G:POP OUT
 I '$D(IO("Q")) D  G Q1
 . U IO
 . D DQ
 . U IO(0)
 . Q
 ;
 S ZTSAVE("PRCF*")=""
 S ZTSAVE("PRCB*")=""
 S ZTSAVE("PRC*")=""
 S ZTRTN="DQ^PRCF826"
 S ZTDESC="826 STATUS OF FUNDS REPORT"
 S ZTIO=ION
 D ^%ZTLOAD
 ;
Q1 D ^%ZISC
 K POP
 Q
 ;
DQ D:$D(ZTQUEUED) KILL^%ZTLOAD
 ;
 N ZX,OB,OB1,OBCP,OBCP1,TOT,CA,CO,FYC,FYO,DA,CP,SI,FY,QTR,CPB,X,CPN,APS,LINE,PG
 K ^TMP($J)
 ;
 S ZX=""
 S QTR=PRC("QTR")
 S FY=PRC("FY")
 S SI=PRC("SITE")
 ;
 D CEIL^PRCS826(SI,FY,QTR,.CA,.CO)
 ;
 S TOT=0
 S TOT(1)=0
 S TOT(2)=0
 S TOT(3)=0
 S CP=0
 ;
 F  S CP=$O(^PRC(420,PRC("SITE"),1,CP)) Q:('CP)  D
 . I CP<9999 D
 .. S CPB=$G(^PRC(420,SI,1,CP,4,FY,0)) Q:CPB=""
 .. S APS=$P($$ACC^PRC0C(SI,CP_"^"_FY_"^"_+$$YEAR^PRC0C(FY)),"^",11)
 .. S APS=" "_APS
 .. S CPN=+$P($G(^PRC(420,SI,1,CP,0)),U,1)
 .. I '$D(^TMP($J,QTR,APS,"9999 GRAND TOTAL")) S ^TMP($J,QTR,APS,"9999 GRAND TOTAL")="0^0^0^0^0"
 .. I '$D(^TMP($J,QTR,APS,CPN)) S ^TMP($J,QTR,APS,CPN)="0^0^0^0^0"
 .. I '$D(^TMP($J,"GT")) S ^TMP($J,"GT")="0^0^0^0^0"
 .. S ^TMP($J,QTR,APS,CPN)=$G(CA($P(CPN," ")))_U_+$P(CPB,U,QTR+1)_U_+$P(CPB,U,QTR+5)
 .. F I=1:1:3 S TOT(I)=+$P(^TMP($J,QTR,APS,"9999 GRAND TOTAL"),U,I)
 .. S TOT(1)=TOT(1)+$G(CA($P(CPN," ")))
 .. S TOT(2)=TOT(2)+$P(CPB,U,QTR+1)
 .. S TOT(3)=TOT(3)+$P(CPB,U,QTR+5)
 .. S ^TMP($J,QTR,APS,"9999 GRAND TOTAL")=TOT(1)_U_TOT(2)_U_TOT(3)
 .. S OB=$G(^TMP($J,QTR,APS,"9999 GRAND TOTAL"))
 .. S OBCP=$G(^TMP($J,QTR,APS,CPN))
 .. S OB1=$P(OB,U)-$P(OB,U,3)
 .. S OBCP1=$P(OBCP,U)-$P(OBCP,U,3)
 .. S $P(^TMP($J,QTR,APS,"9999 GRAND TOTAL"),U,4)=OB1
 .. S $P(^TMP($J,QTR,APS,CPN),U,4)=OBCP1
 .. S OB=$G(^TMP($J,QTR,APS,"9999 GRAND TOTAL"))
 .. S $P(^TMP($J,QTR,APS,CPN),U,5)=$G(CO($P(CPN," ")))
 .. S X=^TMP($J,"GT")
 .. F I=1:1:4 S $P(X,U,I)=$P(X,U,I)+$P(OB,U,I)
 .. S $P(X,U,5)=$P(X,U,5)+$G(CO($P(CPN," ")))
 .. S ^TMP($J,"GT")=X
 .. Q
 . Q
 ;
 S PG=0
 S LINE=""
 S $P(LINE,"-",81)=""
 W:($E(IOST)="C") @IOF
 D HDR1
 ;
 S AP=""
 S CPN=""
 ;
 F  S AP=$O(^TMP($J,QTR,AP)) Q:(AP="")  D  G:(ZX=U) OUT
 . W !!,"APPROPRIATION:  ",AP,!!
 . F  S CPN=$O(^TMP($J,QTR,AP,CPN)) Q:(CPN="")  D  Q:(ZX=U)
 .. ;
 .. ;     WRITE APPROPRIATION (9999 GRAND TOTAL) TOTALS.
 .. ;
 .. I +CPN=9999 D PAUSE:$Y+5>IOSL Q:(ZX=U)  D  Q
 ... W !,"TOTAL:"
 ... S X=$G(^TMP($J,QTR,AP,CPN))
 ... W ?21,$J($FN($P(X,U,1),"P,",2),14)
 ... W ?36,$J($FN($P(X,U,4),"P,",2),14)
 ... W ?52,$J($FN($P(X,U,3),"P,",2),14)
 ... W ?66,$J($FN($P(X,U,5),"P,",2),14)
 ... W !
 ... Q
 .. ;
 .. ;             WRITE CONTROL POINT TOTALS.
 .. ;
 .. D PAUSE:($Y+5>IOSL) Q:(ZX=U)
 .. S X=CPN S:X<100 X=$E(1000+X,2,999) W $E(X,1,15)
 .. I $P($G(^PRC(420,PRC("SITE"),1,+CPN,0)),U,19)=1 W " *" ;MARK DEACTIVATED CONTROL POINT.
 .. S X=$G(^TMP($J,QTR,AP,CPN))
 .. W ?21,$J($FN($P(X,U,1),"P,",2),14)
 .. W ?36,$J($FN($P(X,U,4),"P,",2),14)
 .. W ?52,$J($FN($P(X,U,3),"P,",2),14)
 .. W ?66,$J($FN($P(X,U,5),"P,",2),14)
 .. W !
 .. ;  COMPUTE FYTD OBLIGATION AMOUNT BY APPROPRIATION.
 .. S $P(^TMP($J,QTR,AP,"9999 GRAND TOTAL"),U,5)=$P(^TMP($J,QTR,AP,"9999 GRAND TOTAL"),U,5)+$G(CO($P(CPN," ")))
 .. Q
 ;
 ;             WRITE STATION (SITE) GRAND TOTALS.
 ;
 D PAUSE:($Y+5>IOSL) Q:(ZX=U)
 W !!,"STATION TOTALS: "
 S X=$G(^TMP($J,"GT"))
 W ?21,$J($FN($P(X,U,1),"P,",2),14)
 W ?36,$J($FN($P(X,U,4),"P,",2),14)
 W ?52,$J($FN($P(X,U,3),"P,",2),14)
 W ?66,$J($FN($P(X,U,5),"P,",2),14)
 W:($E(IOST)="P") @IOF
 ;
OUT K PRC,PRCF,PRCB,^TMP($J)
 Q
 ;
HDR1 S PG=PG+1
 W !,"STATUS OF FUNDS - 826 REPORT"
 W ?40,"STATION NO: ",SI
 W ?71,"PAGE: ",$J(PG,3)
 W !!,"* = DEACTIVATED CONTROL POINT"
 W !!,"FISCAL YEAR: ",FY
 W !,"QUARTER:",?14,QTR
 W !!,?54,"UNOBLIGATED"
 W !,?22,"COST CEILING",?38,"OBLIGATIONS",?58,"BALANCE",?69,"FYTD"
 W !,"FUND CONTROL POINT",?22,"FOR QTR",?38,"FOR QTR",?58,"FOR QTR",?69,"OBLIGATIONS"
 W !,LINE
 Q
 ;
HDR W @IOF
 S PG=PG+1
 W !,"826 REPORT - STATION NO: ",SI
 W ?71,"PAGE: ",$J(PG,3)
 W !,"* = DEACTIVATED CONTROL POINT"
 W !,LINE,!
 Q
 ;
PAUSE I $E(IOST)="C" D  Q:(ZX=U)
 . S ZX=""
 . R !,"Press <return> to continue or '^' to quit: ",ZX:DTIME
 . S:('$T) ZX=U
 . Q
 D HDR
 Q
