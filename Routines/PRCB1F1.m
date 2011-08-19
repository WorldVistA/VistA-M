PRCB1F1 ;WISC/PLT-PRCB1F continue ;9/17/96  16:33
V ;;5.1;IFCAP;**142**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;prcduz - user id #
 ;prcopt data ^1=option #
 ;prca data= ^1=accrual mm/yy, ^2...^10= date infor, ^11=.01 in file 440.7, ^12="Y" for recompiling
 ;prctd=today's date infor.
 ;prcdes = description
TMEN ;accrual
 N PRCB,PRCD,PRCE,PRCG,PRCDI,PRCRICB,PRCLOCK,PRCRI,PRCID,PRCAMT,PRCBOC,PRAMTP,PRCAMTR,PRCSUBT,PRCAMTA
 N A,B,C
 I $D(ZTQUEUED) D KILL^%ZTLOAD
 S PRCID=$P(PRCA,"^",11),PRC("SITE")=$P(PRCID,"-",2)
 S PRCRI(440.7)=$O(^PRCH(440.7,"B",PRCID,0))
 I $P(PRCA,"^",12)!'PRCRI(440.7) D ACCR(PRCA,PRCTD) S PRCRI(440.7)=$O(^PRCH(440.7,"B",PRCID,0)) QUIT:'PRCRI(440.7)
REP ;start to print
 D PAGE
 S (PRCAMT,PRCAMTP,PRCAMTR,PRCAMTA)=0,(X,PRCSUBT,PRCRI)=""
 F  S PRCRI=$O(^PRCH(440.7,PRCRI(440.7),50,"B",PRCRI)) Q:PRCRI=""!(X["^")  S PRCRI(440.701)=0 F  S PRCRI(440.701)=$O(^PRCH(440.7,PRCRI(440.7),50,"B",PRCRI,PRCRI(440.701))) QUIT:'PRCRI(440.701)  Q:X["^"  D  QUIT:X["^"
 . S A=^PRCH(440.7,PRCRI(440.7),50,PRCRI(440.701),0),B=$P(A,"^",2)-$P(A,"^",3),C="" I $P(A,"^",5)'="" S B=$P(A,"^",5),C="*",X=""
 . QUIT:+$P(A,"^",2)=0&(+$P(A,"^",3)=0)&(+$P(A,"^",5)=0)
 . I $P(PRCSUBT,"^")'=$P(A,"/",1,4) D  S PRCSUBT=$P(A,"/",1,4)
 .. I $P(PRCSUBT,"^")]"",$P(PRCSUBT,"^",2)!$P(PRCSUBT,"^",3) W !,"   SUBTOTAL",?40,$J($P(PRCSUBT,"^",2),12,2),$J($P(PRCSUBT,"^",3),12,2),$J($P(PRCSUBT,"^",4),12,2),!
 .. QUIT
 . S PRCAMTP=$P(A,"^",2)+PRCAMTP,PRCAMTR=$P(A,"^",3)+PRCAMTR,PRCAMTA=B+PRCAMTA
 . S $P(PRCSUBT,"^",2)=$P(A,"^",2)+$P(PRCSUBT,"^",2),$P(PRCSUBT,"^",3)=$P(A,"^",3)+$P(PRCSUBT,"^",3),$P(PRCSUBT,"^",4)=B+$P(PRCSUBT,"^",4)
 . I IOSL-3<$Y D:IOST'?1"C-".E PAGE I IOST?1"C-".E S X="",E="O^1:5^",Y(1)="Enter 'RETURN' to continue or '^' to quit" D FT^PRC0A(.X,.Y,"Enter 'RETURN' to continue or '^' to quit",E,"") QUIT:X["^"  D PAGE
 . W !,$P(A,"^"),?40,$J($P(A,"^",2),12,2),$J($P(A,"^",3),12,2),$J(B,12,2),C
 . QUIT
 D:$G(X)'["^"
 . I PRCSUBT]"" W !,"   SUBTOTAL",?40,$J($P(PRCSUBT,"^",2),12,2),$J($P(PRCSUBT,"^",3),12,2),$J($P(PRCSUBT,"^",4),12,2),!
 . W !!,"TOTAL",?40,$J(PRCAMTP,12,2),$J(PRCAMTR,12,2),$J(PRCAMTA,12,2)
 . W !!,"Accrual amount followed by '*' means edited amount."
 . I IOST?1"C-".E S X="",E="O^1:5^",Y(1)="Report ends, enter 'RETURN' to continue." D FT^PRC0A(.X,.Y,"Report ends, enter 'RETURN' to continue.",E,"")
 . QUIT
EXIT QUIT
 ;
PAGE N A
 S A=$$DATE^PRC0C("T","E"),A=$P(A,"^",4)_"/"_$P(A,"^",5)_"/"_$P(A,"^",3)
 W @IOF,!,"IFCAP Accrual Report for "_$P(PRCA,"^"),?50,"Printed on ",A
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
 S PRCRI(440.7)=$O(^PRCH(440.7,"B",PRCID,0)) D:PRCRI(440.7)
 . D DELETE^PRC0B1(.X,"440.7;^PRCH(440.7,;"_PRCRI(440.7))
 . QUIT
 S X=PRCID,X("DR")="1///^S X=""N"""
 D ADD^PRC0B1(.X,.Y,"440.7;^PRCH(440.7,")
 S PRCRI(440.7)=+Y
LOCK L +^PRCH(440.7,PRCRI(440.7)):20 E  G LOCK
 S PRCB=$P($$QTRDATE^PRC0D($P(PRCA,"^",2),$P(PRCA,"^",3)),"^",7)
 S PRCDF=$P($$QTRDATE^PRC0D($P(PRCA,"^",2),1),"^",7),PRCDE=$P(PRCA,"^",8)+31
 D 410,4406
 L -^PRCH(440.7,PRCRI(440.7))
 QUIT
 ;
410 ;compiling purchase card orders
 S PRCRI=PRCB_"-"_PRC("SITE"),PRCC=PRCRI
 F  S PRCC=$O(^PRCS(410,"RB",PRCC)) QUIT:$P(PRCC,"-",1,2)'=PRCRI!'PRCC  D
 . S PRCRI(410)=0
 . F  S PRCRI(410)=$O(^PRCS(410,"RB",PRCC,PRCRI(410))) QUIT:'PRCRI(410)  S PRCD=^PRCS(410,PRCRI(410),0),PRCE=$G(^(4)) I "EC"'[$P(PRCD,"^",12)&($P(PRCE,"^",5)]"") I $P(PRCC,"-",3)=$P(PRCD,"-",4),+$P(PRCC,"-",5)=+$P(PRCD,"-",5) D
 .. S A=$P(^PRCS(410,PRCRI(410),3),"^",11),PRCAMT=$P(PRCE,"^",8),PRCBBFY=$P($$YEAR^PRC0C($E(A,2,3)),"^")
 .. QUIT:+PRCAMT=0
 .. S PRCF=PRC("SITE")_"-"_$P(PRCE,"^",5)
 .. S PRCRI(442)=$O(^PRC(442,"B",PRCF,0)) QUIT:'PRCRI(442)  S PRCF=$G(^PRC(442,PRCRI(442),1)) QUIT:$P(^(0),"^",2)'=25!($P(^(0),"^",12)'=PRCRI(410))  D:$P(PRCF,"^",15)-1<PRCDE
 ... S PRCG=^PRC(442,PRCRI(442),0)
 ... S A=$$ACC^PRC0C($P(PRCD,"-"),$P(PRCD,"-",4)_"^"_$P(PRCD,"-",2)_"^"_PRCBBFY)
 ... QUIT:$P(A,"^",6)>$$DATE^PRC0C(PRCDE,"I")
 ... QUIT:$P(A,"^",7)<$$DATE^PRC0C(PRCDF,"I")&($P(A,"^",13)'="Y")
 ... S PRCRI(442.01)=$O(^PRC(442,PRCRI(442),2,0)) QUIT:'PRCRI(442.01)
 ... S PRCBOC=$P(^PRC(442,PRCRI(442),2,PRCRI(442.01),0),"^",4),PRCBOC=$P(PRCBOC," ")
 ... S B=$P(A,"^",5)_"/"_$P(A,"^",6)_"/"_$P(A,"^")_"/"_$P(A,"^",3)_"/"_$P(PRCG,"^",5)_"/"_PRCBOC
 ... S PRCAMT=PRCAMT-$P($$FP^PRCH0A(PRCRI(442)),"^",2)
 ... D AE4407(PRCRI(440.7),B,PRCAMT,1)
 ... QUIT
 .. QUIT
 . QUIT
 QUIT
 ;
4406 ;compiling unreconciled records
 N A,B,C,D,X,Y
 S PRCRI="N"
 F  S PRCRI=$O(^PRCH(440.6,"ST",PRCRI)) Q:PRCRI'?1"N".E  S PRCRI(440.6)=0 F  S PRCRI(440.6)=$O(^PRCH(440.6,"ST",PRCRI,PRCRI(440.6))) Q:'PRCRI(440.6)  S A=$G(^PRCH(440.6,PRCRI(440.6),0)),B=$P(A,"^",6),C=^(5) D:B-1<PRCDE
 . QUIT:PRC("SITE")-$P(A,"^",8)
 . S PRCBBFY=$P($$YEAR^PRC0C($E($P(A,"^",11),2,3)),"^")
 . S PRCBBEY=$P($$YEAR^PRC0C($E($P(A,"^",12),2,3)),"^")
 . S B=$O(^PRCD(420.3,"B",$P(C,"^",1),"")) I B S B=$P(^PRCD(420.3,B,0),"^",8)
 . QUIT:PRCBBFY>$$DATE^PRC0C(PRCDE,"I")
 . QUIT:PRCBBEY<$$DATE^PRC0C(PRCDF,"I")&(B'="Y")
 . S B=$P(C,"^",1)_"/"_PRCBBFY_"/"_$P(C,"^",5)_"/"_$TR($P(C,"^",2,4),"^","/")
 . D AE4407(PRCRI(440.7),B,$P(A,"^",14),2)
 . QUIT
 QUIT
 ;
 ;prca = ri of file 440.7, prcb=account elements, prcc=amount, prcd=1 if order unpaid, 2=if unreconciled
AE4407(PRCA,PRCB,PRCC,PRCD) ;add/edit file 440.701
 N PRCDI,PRCRI
 N A,B,C,X,Y,Z
 S PRCRI(440.7)=PRCA
 S PRCDI="440.7;^PRCH(440.7,;"_PRCRI(440.7)_";50~440.701;^PRCH(440.7,"_PRCRI(440.7)_",50,"
 S PRCRI(440.701)=$O(^PRCH(440.7,PRCRI(440.7),50,"B",PRCB,0)) D:'PRCRI(440.701)
 . S X=PRCB
 . D ADD^PRC0B1(.X,.Y,PRCDI)
 . S PRCRI(440.701)=+Y
 . D EDIT^PRC0B(.X,PRCDI_";"_PRCRI(440.701),"5///"_$P(PRCB,"/",5)_";6///"_$P(PRCB,"/",6))
 . QUIT
 S PRCDI=PRCDI_";"_PRCRI(440.701)
 S A=$P(^PRCH(440.7,PRCRI(440.7),50,PRCRI(440.701),0),"^",PRCD+1)+PRCC
 D EDIT^PRC0B(.X,PRCDI,PRCD_"////"_$J(A,"",2))
 QUIT
