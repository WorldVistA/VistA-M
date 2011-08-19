XUCSXGR ;CLKS/SO Rank Global Access/sec High to Low ;4/11/96  05:57
 ;;7.3;Toolkit;**14**;Jan 26, 1996
ALL ; Entry Point to lump accesses as if a single VG
 D GDATE
 I XUCSEND G XIT
 S XUCSALL="ALL"
 G GETIO
VG ; Entry Point split accesses by VG
 D GDATE
 I XUCSEND G XIT
GETIO ; Get I/O Device
 I XUCSEND G XIT
 S %ZIS="MQ" D ^%ZIS I POP D HOME^%ZIS G XIT
 I $D(IO("Q")) D  G XIT
 . S ZTRTN="DEQUE^XUCSXGR",ZTDESC="GLOBAL ACCESS RANKING",ZTSAVE("XUCS*")=""
 . S %DT="AEFRX",%DT("A")="Queue for what Date/Time: ",%DT("B")="Now",%DT(0)="NOW" D ^%DT K %DT
 . I +Y'<0 S ZTDTH=Y D ^%ZTLOAD,HOME^%ZIS
 . K ZTRTN,ZTDESC,ZTDTH,ZTSAVE,IO("Q")
 U IO D:$E(IOST)="C" WAIT^DICD
DEQUE ;
 K ^TMP($J)
REMOVE ; Remove *FS*
 S XX2=""
 S XUCSTBL=""
 F  S XX2=$O(^XUCS(8987.2,"B",XX2)) Q:XX2=""  D
 . I XX2["FS" Q
 . S XUCSTBL(+$O(^XUCS(8987.2,"B",XX2,"")))=""
GETRAW ; Now Loop thru XUCS(8987.2,"C",<date/time>,<.01ien>,<sub-ien>
 S XET=0 ; initialize Elapse Time counter
 S XX1=XUCSBD-1
 F  S XX1=$O(^XUCS(8987.2,"C",XX1)) Q:+XX1<1!($P(XX1,".")>XUCSED)  D
 . S XD0=0 ; equals D0
 . F  S XD0=$O(^XUCS(8987.2,"C",+XX1,XD0)) Q:+XD0<1  D
 .. I '$D(XUCSTBL(+XD0))#2 Q  ; Not a CS* or PS*
 .. S XD1=0 ; equals D1
 .. F  S XD1=$O(^XUCS(8987.2,"C",+XX1,+XD0,XD1)) Q:+XD1<1  D
 ... I '$D(^XUCS(8987.2,+XD0,1,+XD1,2,0))#2 Q  ; no global info
 ... S XET=XET+$P(^XUCS(8987.2,+XD0,1,+XD1,0),U,3)
 ... S XD2=0 ; equals D2
 ... F  S XD2=$O(^XUCS(8987.2,+XD0,1,+XD1,2,XD2)) Q:+XD2<1  S XXS=^(+XD2,0) D
 .... ;TMP($J,"XUCS-RAW",<uci>_","_<vg>,<gbl name>)=tot ref.
 .... S XX2=$P(XXS,U,2)_","_$S($D(XUCSALL):XUCSALL,$P(XXS,U,7)'="":$P(XXS,U,7),1:"xxx"),XX3=$P(XXS,U,1)
 .... I '$D(^TMP($J,"XUCS-RAW",XX2,XX3))#2 S ^TMP($J,"XUCS-RAW",XX2,XX3)=""
 .... S ^TMP($J,"XUCS-RAW",XX2,XX3)=^TMP($J,"XUCS-RAW",XX2,XX3)+$P(XXS,U,4)
 .... K XXS,XX2,XX3
ORDER ; Order by References/sec low to high
 N UCIVG,GBL,RATE
 S UCIVG="" ; <uci>_","_<vg>
 F  S UCIVG=$O(^TMP($J,"XUCS-RAW",UCIVG)) Q:UCIVG=""  D
 . S GBL="" ; <global name>
 . F  S GBL=$O(^TMP($J,"XUCS-RAW",UCIVG,GBL)) Q:GBL=""  S XX1=^(GBL) D
 .. S RATE=XX1/XET,RATE=+$J(RATE,0,1)
 .. ; TMP($J,"XUCS-ORDERED",<uci>_","_<vg>,<ref/sec>,<global name>
 .. S ^TMP($J,"XUCS-ORDERED",UCIVG,RATE,GBL)=""
 .. K XX1,RATE
REPORT ; Print the report
 S (PAGE,COL,ROW)=1
 S PGLEN=IOSL-5
 S UCIVG="" ; <uci>_","_<vg>
 F  S UCIVG=$O(^TMP($J,"XUCS-ORDERED",UCIVG)) Q:UCIVG=""  D SUBHDR D
 . S RATE=999999 ; Global access rate/sec
 . F  S RATE=$O(^TMP($J,"XUCS-ORDERED",UCIVG,RATE),-1) Q:+RATE<.1  D
 .. S GBL="" ; <global name>
 .. F  S GBL=$O(^TMP($J,"XUCS-ORDERED",UCIVG,RATE,GBL)) Q:GBL=""  D
 ... N X
 ... S X="        ",GBLX=$S($L(GBL)<8:GBL_$E(X,($L(GBL)+1),8),1:GBL)
 ... I '$D(A(PAGE,ROW)) S A(PAGE,ROW)=""
 ... S A(PAGE,ROW)=A(PAGE,ROW)_GBLX_$J(RATE,6,1)_"    " D POS
PRINT ; Print Report
 S PAGE=0
 F  S PAGE=$O(A(PAGE)) Q:PAGE=""  D:PAGE>1 PAUSE^XUCSUTL I 'XUCSEND D HDR D
 . S ROW=0
 . F  S ROW=$O(A(PAGE,ROW)) Q:ROW=""  W !,A(PAGE,ROW)
XIT ; Common eXIT Point
 I '$D(ZTQUEUED),$E(IOST)="P" D ^%ZISC
 K ^TMP($J)
 K A,COL,GBL,GBLX,HDR,HDRX,PAGE,PGLEN,RATE,RDT,ROW,UCIVG
 K X1,X2,XD0,XD1,XD2,XET,XUCSDAYS,XUCSEND,XUCSALL,XUCSTBL,XUCSNOA2,XUCSBD,XUCSED
 K XX1,XX2,XX3,XXS
 Q
HDR ; Print Header Subroutine
 W:$D(HDR) @IOF
 I '$D(HDR) S HDR=1 D NOW^%DTC S Y=% D DD^%DT S RDT=$P(Y,"@")_"@"_$P($P(Y,":",1,2),"@",2) W:$E(IOST)="C" @IOF
 W !,"Global Access/Sec. Ranking Report",?(IOM-10),"Page: ",PAGE
 W !,"From: ",$E(XUCSBD,4,5)_"/"_$E(XUCSBD,6,7)_"/"_$E(XUCSBD,2,3)," To: ",$E(XUCSED,4,5)_"/"_$E(XUCSED,6,7)_"/"_$E(XUCSED,2,3)," (",XUCSDAYS," day",$S(XUCSDAYS>1:"s",1:""),")",?(IOM-20),RDT
 S HDRX="",$P(HDRX,"-",IOM)="" W !,HDRX
 Q
SUBHDR ; Change of UCI subheader
 I '$D(A(PAGE,ROW)) S A(PAGE,ROW)=""
 S A(PAGE,ROW)=A(PAGE,ROW)_"   "_$P(UCIVG,",")_$S($P(UCIVG,",",2)'="ALL":","_$P(UCIVG,",",2)_" ",1:"     ")_"       " D POS
 Q
POS ; Position on Spread Sheet
 S ROW=ROW+1
 I ROW>PGLEN S ROW=1 D
 . S COL=COL+1
 . I COL>4 S PAGE=PAGE+1,COL=1
 . D SUBHDR
 Q
GDATE ; Get Date Range
 S XUCSEND=0
 S XUCSNOA2=1 D A3^XUCSUTL3
 I XUCSEND Q
 S X1=XUCSBD,X2=XUCSED D ^%DTC S:X<0 X=X*(-1)
 S XUCSDAYS=X+1
 Q
