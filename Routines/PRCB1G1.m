PRCB1G1 ;WISC/PLT/BGJ-PRCB1G continue ;12/2/97  14:03
V ;;5.1;IFCAP;**44**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;prcduz - user id #
 ;prcopt data ^1=option #
 ;prca data=fiscal year, ^2=quarter, ^3=fisca year start year, ^4=fy start month, ^5=fy start day, ...
 ;prctd data ^1= today's fiscal year, ^2=today's fy quarter
 ;prcdes = description
TMEN ;accrual
 N PRCB,PRCD,PRCE,PRCG,PRCDI,PRCRICB,PRCLOCK,PRCRI,PRCID,PRCAMT,PRCBOC,PRAMTP,PRCAMTR,PRCSUBT,PRCAMTA,PRCPND
 N PRCDT
 N A,B,C
 I $D(ZTQUEUED) D KILL^%ZTLOAD
 S PRCDT=DT,PRCID=$P(PRCA,"^",11),PRC("SITE")=$P(PRCID,"-",2)
 S PRCPND=$P($$DT^PRC0B2($H,"H"),"^",4)
 D ACCR(PRCA,PRCTD)
REP ;start to print
 D PAGE
 S (PRCAMT,PRCAMTP,PRCAMTR,PRCAMTA)=0,PRCSUBT=""
 S PRCRI="" F  S PRCRI=$O(^TMP("PRCB",$J,PRCRI)) QUIT:PRCRI=""  D  QUIT:X["^"
 . S A=^TMP("PRCB",$J,PRCRI,0),B=$P(A,"^",2)-$P(A,"^",3)
 . I $P(PRCSUBT,"^")'=$P(PRCRI,"/",1,4) D  S PRCSUBT=$P(PRCRI,"/",1,4)
 .. I $P(PRCSUBT,"^")]"",$P(PRCSUBT,"^",2)!$P(PRCSUBT,"^",3) W !,"   SUBTOTAL",?40,$J($P(PRCSUBT,"^",2),12,2),$J($P(PRCSUBT,"^",3),12,2),$J($P(PRCSUBT,"^",4),12,2),!
 .. QUIT
 . S PRCAMTP=$P(A,"^",2)+PRCAMTP,PRCAMTR=$P(A,"^",3)+PRCAMTR,PRCAMTA=B+PRCAMTA
 . S $P(PRCSUBT,"^",2)=$P(A,"^",2)+$P(PRCSUBT,"^",2),$P(PRCSUBT,"^",3)=$P(A,"^",3)+$P(PRCSUBT,"^",3),$P(PRCSUBT,"^",4)=B+$P(PRCSUBT,"^",4)
 . I IOSL-3<$Y D:IOST'?1"C-".E PAGE I IOST?1"C-".E S X="",E="O^1:5^",Y(1)="Enter 'RETURN' to continue or '^' to quit" D FT^PRC0A(.X,.Y,"Enter 'RETURN' to continue or '^' to quit",E,"") QUIT:X["^"  D PAGE
 . W !,PRCRI,?40,$J($P(A,"^",2),12,2),$J($P(A,"^",3),12,2),$J(B,12,2)
 . S PRCRI(9999)=PRC("SITE")_"-" F  S PRCRI(9999)=$O(^TMP("PRCB",$J,PRCRI,PRCRI(9999))) QUIT:'PRCRI(9999)  S X="" D  QUIT:X["^"
 .. I IOSL-3<$Y D:IOST'?1"C-".E PAGE I IOST?1"C-".E S X="",E="O^1:5^",Y(1)="Enter 'RETURN' to continue or '^' to quit" D FT^PRC0A(.X,.Y,"Enter 'RETURN' to continue or '^' to quit",E,"") QUIT:X["^"  D PAGE
 .. S A=^TMP("PRCB",$J,PRCRI,PRCRI(9999)),B=^PRC(442,+^(PRCRI(9999)),0),C=$G(^(1)),C=$P(C,"^",15),C=$E(C,4,5)_"/"_$E(C,6,7)_"/"_$E(C,2,3)
 .. W !,?5,$P(B,"^"),?20,C,?40,$J($P(A,"^",2),12,2)
 .. QUIT
 . QUIT
 D:$G(X)'["^"
 . I PRCSUBT]"" W !,"   SUBTOTAL",?40,$J($P(PRCSUBT,"^",2),12,2),$J($P(PRCSUBT,"^",3),12,2),$J($P(PRCSUBT,"^",4),12,2),!
 . W !!,"TOTAL",?40,$J(PRCAMTP,12,2),$J(PRCAMTR,12,2),$J(PRCAMTA,12,2)
 . I IOST?1"C-".E S X="",E="O^1:5^",Y(1)="Report ends, enter 'RETURN' to continue." D FT^PRC0A(.X,.Y,"Report ends, enter 'RETURN' to continue.",E,"")
 . QUIT
EXIT QUIT
 ;
PAGE ;
 W @IOF,!,"IFCAP YTD Detail Accrual Report for "_$P(PRCA,"^"),?50,"Printed on ",PRCPND
 W !!,"Station: ",$P(PRCID,"-",2)
 W !!,"FUND/BBFY/AO/ACC/CC/BOC",?40,$J("UNPAID PO",12),$J("UNRECON",12),$J("ACCRUAL",12)
 QUIT
 ;
 ;prca = date data, prctd= current date data
ACCR(PRCA,PRCTD) ;compiling accrual data
 N PRC,PRCRI,PRCB,PRCC,PRCD,PRCE,PRCF,PRCG,PRCID,PRCDF,PRCDE,PRCAMT,PRCBOC,PRCBBFY,PRCBBEY
 N A,B,C,X,Y
 D:'$D(ZTQUEUED) EN^DDIOL("Compiling...")
 S PRCID=$P(PRCA,"^",11),PRC("SITE")=$P(PRCID,"-",2)
 K ^TMP("PRCB",$J)
 S PRCB=$P(PRCA,"^",7)
 S PRCDF=+PRCA,PRCDE=+PRCA
 D 410,4406
 QUIT
 ;
410 ;compiling purchase card orders
 S PRCRI=PRCB_"-"_PRC("SITE"),PRCC=PRCRI
 F  S PRCC=$O(^PRCS(410,"RB",PRCC)) QUIT:$P(PRCC,"-",1,2)'=PRCRI!'PRCC  D
 . S PRCRI(410)=0 F  S PRCRI(410)=$O(^PRCS(410,"RB",PRCC,PRCRI(410))) QUIT:'PRCRI(410)  S PRCD=^PRCS(410,PRCRI(410),0),PRCE=$G(^(4)) I "EC"'[$P(PRCD,"^",12)&($P(PRCE,"^",5)]"") D
 .. ;Skip entry if txn # in RB x-ref does not match actual txn #
 .. QUIT:$P(PRCC,"-",$L(PRCC,"-"))'=$P($P(PRCD,"^"),"-",$L($P(PRCD,"^"),"-"))
 .. S A=$P(^PRCS(410,PRCRI(410),3),"^",11),PRCAMT=$P(PRCE,"^",8),PRCBBFY=$P($$YEAR^PRC0C($E(A,2,3)),"^")
 .. QUIT:+PRCAMT=0
 .. S PRCF=PRC("SITE")_"-"_$P(PRCE,"^",5)
 .. S PRCRI(442)=$O(^PRC(442,"B",PRCF,0)) QUIT:'PRCRI(442)  S PRCF=$G(^PRC(442,PRCRI(442),1)) QUIT:$P(^(0),"^",2)'=25!($P(^(0),"^",12)'=PRCRI(410))  D:$P(PRCF,"^",15)'>PRCDT
 ... S PRCG=^PRC(442,PRCRI(442),0),PRCRI(9999)=$P(PRCG,"^") QUIT:$P($G(^(7)),"^",2)=40!($P($G(^(7)),"^",2)=41)
 ... S A=$$ACC^PRC0C($P(PRCD,"-"),$P(PRCD,"-",4)_"^"_$P(PRCD,"-",2)_"^"_PRCBBFY)
 ... QUIT:$P(A,"^",6)>PRCDE
 ... QUIT:$P(A,"^",7)<PRCDF&($P(A,"^",13)'="Y")
 ... S PRCRI(442.01)=$O(^PRC(442,PRCRI(442),2,0)) QUIT:'PRCRI(442.01)
 ... S PRCBOC=$P(^PRC(442,PRCRI(442),2,PRCRI(442.01),0),"^",4),PRCBOC=$P(PRCBOC," ")
 ... S B=$P(A,"^",5)_"/"_$P(A,"^",6)_"/"_$P(A,"^")_"/"_$P(A,"^",3)_"/"_$P(PRCG,"^",5)_"/"_PRCBOC
 ... S PRCAMT=PRCAMT-$P($$FP^PRCH0A(PRCRI(442)),"^",2)
 ... S ^TMP("PRCB",$J,B,PRCRI(9999))=PRCRI(442)_"^"_PRCAMT
 ... S $P(^TMP("PRCB",$J,B,0),"^",2)=$P($G(^TMP("PRCB",$J,B,0)),"^",2)+PRCAMT
 ... QUIT
 .. QUIT
 . QUIT
 QUIT
 ;
4406 ;compiling unreconciled records
 N A,B,C,D,X,Y
 S PRCRI="N"
 F  S PRCRI=$O(^PRCH(440.6,"ST",PRCRI)) Q:PRCRI'?1"N".E  S PRCRI(440.6)=0 F  S PRCRI(440.6)=$O(^PRCH(440.6,"ST",PRCRI,PRCRI(440.6))) Q:'PRCRI(440.6)  S A=^PRCH(440.6,PRCRI(440.6),0),B=$P(A,"^",6),C=^(5) D:B-1<PRCDT
 . QUIT:PRC("SITE")-$P(A,"^",8)
 . S PRCBBFY=$P($$YEAR^PRC0C($E($P(A,"^",11),2,3)),"^")
 . S PRCBBEY=$P($$YEAR^PRC0C($E($P(A,"^",12),2,3)),"^")
 . S B=$O(^PRCD(420.3,"B",$P(C,"^",1),"")) I B S B=$P(^PRCD(420.3,B,0),"^",8)
 . QUIT:PRCBBFY>PRCDE
 . QUIT:PRCBBEY<PRCDF&(B'="Y")
 . S B=$P(C,"^",1)_"/"_PRCBBFY_"/"_$P(C,"^",5)_"/"_$TR($P(C,"^",2,4),"^","/")
 . S $P(^TMP("PRCB",$J,B,0),"^",3)=$P($G(^TMP("PRCB",$J,B,0)),"^",3)+$P(A,"^",14)
 . QUIT
 QUIT
 ;
