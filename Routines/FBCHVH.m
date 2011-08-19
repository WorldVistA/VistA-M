FBCHVH ;AISC/DMK-VENDOR PAYMENT HISTORY ;7/17/2003
 ;;3.5;FEE BASIS;**55,61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
GETVEN K FBAANQ D GETVEN^FBAAUTL1 G END:IFN']""
 D DATE^FBAAUTL G:FBPOP GETVEN S ZZ=9999999.9999,FBBEG=ZZ-ENDDATE,FBEND=ZZ-BEGDATE
 I '$D(^FBAAI("AF",IFN)) W !,*7,"No invoices on line for this vendor." G GETVEN
 S VAR="IFN^FBBEG^FBEND^BEGDATE^ENDDATE"_$S($D(FBPROG):"^FBPROG",1:""),VAL=IFN_"^"_FBBEG_"^"_FBEND_"^"_BEGDATE_"^"_ENDDATE_$S($D(FBPROG):"^"_FBPROG,1:""),PGM="START^FBCHVH" D ZIS^FBAAUTL G:FBPOP END S:IO=IO(0) FBAANQ=1
START S:'$D(FBPROG) FBPROG=6 S FBHEAD="VENDOR",Q="",$P(Q,"=",80)="=",FBAAOUT=0 U IO D GETDAT S:$E(IOST,1,2)'["C-" FBPG=1 D HEDC
 F FBM=FBBEG-.1:0 S FBM=$O(^FBAAI("AF",IFN,FBM)) Q:FBM'>0!(FBM>FBEND)  F FBI=0:0 S FBI=$O(^FBAAI("AF",IFN,FBM,FBI)) Q:FBI'>0!(FBAAOUT)  I $D(^FBAAI(FBI,0)),$P(^(0),"^",12)=FBPROG,'$D(^("FBREJ")) D GETINV
 G:$D(FBAANQ) GETVEN
END K DA,DFN,BEGDATE,ENDDATE,FBBEG,FBEND,DIC,FBAANQ,FBAAOUT,FBDX,FBI,FBIN,FBPROC,FBVEN,FBVID,IFN,J,K,L,PGM,Q,VADM,VAERR,VAL,VAR,X,Y,VA,ZZ,FBM,FBHEAD,FBPROG,FBPG,FBVINDT
 D CLOSE^FBAAUTL Q
GETINV ;
 N FBADJLA,FBADJLR,FBCDAYS,FBCSID,FBFPPSC,FBFPPSL,FBRRMKL,FBY2,FBY3
 S FBIN=^FBAAI(FBI,0)
 S FBY2=$G(^FBAAI(FBI,2))
 S FBY3=$G(^FBAAI(FBI,3))
 F J=1,2,3,4,6,7,8,9,10,11,13,14 S FBIN(J)=$P(FBIN,"^",J)
 S FBVINDT=$P(FBY2,"^",2) D FBCKI^FBAACCB1(FBI)
 S FBVEN=$S($D(^FBAAV(+FBIN(3),0)):$P(^(0),"^",1),1:"") I FBVEN]"" S FBVID=$P(^(0),"^",2)
 S DFN=FBIN(4) Q:'DFN  D DEM^VADPT
 S Y=FBIN(2) D CDAT S FBIN(2)=Y
 S Y=FBIN(6) D CDAT S FBIN(6)=Y,Y=FBIN(7) D CDAT S FBIN(7)=Y
 S FBCDAYS=$P(FBY2,U,10) ; covered days
 S FBCSID=$P(FBY2,U,11) ; patient control number
 S FBFPPSC=$P(FBY3,U) ; fpps claim id
 S FBFPPSL=$P(FBY3,U,2) ; fpps line item
 S FBX=$$ADJLRA^FBCHFA(FBI_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 S FBRRMKL=$$RRL^FBCHFR(FBI_",")
WRT I $Y+6>IOSL D HANG^FBAAUTL1:$E(IOST,1,2)["C-" Q:FBAAOUT  D HEDC
 W !,$S('$D(FBIN(13)):"",FBIN(13)="R":"*",1:""),$S($G(FBCAN)]"":"+",1:"")
 W VADM(1)_"  "_$P(VADM(2),"^",2),?48,FBCSID
 W !,?4,FBVEN,?45,FBVID,?62,FBIN(1)
 W !,$S(FBIN(13)["R":"*",1:""),$S(FBIN(14)]"":"#",1:"")
 W ?4,FBFPPSC,?18,FBFPPSL,?35,FBIN(2),?46,$$DATX^FBAAUTL(FBVINDT),?57,FBIN(6),?68,FBIN(7)
 W !?4,$J(FBIN(8),1,2),?17,$J(FBIN(9),1,2),?29,FBCDAYS
 ; write adjustment reasons, if null then write suspend code
 W ?39,$S(FBADJLR]"":FBADJLR,1:FBIN(11))
 ; write adjustment amounts, if null then write amount suspended
 W ?49,$S(FBADJLA]"":FBADJLA,1:$J(FBIN(10),1,2))
 W ?64,FBRRMKL
 W !
 I $D(^FBAAI(FBI,"DX")) S FBDX=^("DX") F K=1:1:5 D WRTDX
 I $D(^FBAAI(FBI,"PROC")) S FBPROC=^("PROC") W ! F L=1:1:5 D WRTPC
 N A2 S A2=FBIN(9) D PMNT^FBAACCB2
 Q
WRTDX I $P(FBDX,"^",K)]"" W ?4,"Dx: ",$$ICD9^FBCSV1(+$P(FBDX,"^",K),$P($G(FBIN),"^",6)),"  " Q
 Q
WRTPC I $P(FBPROC,"^",L)]"" W ?4,"Proc: ",$$ICD0^FBCSV1(+$P(FBPROC,"^",L),$P($G(FBIN),"^",6)),"   " Q
 Q
HEDC I $D(FBHEAD) W:'$G(FBPG) @IOF K:$G(FBPG) FBPG W ?25,FBHEAD_" PAYMENT HISTORY",!,?24,$E(Q,1,24),!?48,"Date Range: ",BEGDATE_" to "_ENDDATE
 I '$D(FBHEAD) W:'$G(FBPG) @IOF K:$G(FBPG) FBPG W !?32,"INVOICE DISPLAY",!,?31,$E(Q,1,17),!
 W !,"Veteran's Name",?48,"Patient Control Number"
 W !,"('*'Reimbursement to Veteran   '+' Cancellation Activity)   '#' Voided Payment)"
 W !,?4,"Vendor Name",?45,"Vendor ID",?59,"Invoice #"
 ;W !,?3,"Fr Date",?14,"To Date  Claimed   Paid",?41,"Sus Code",?59,"Dt. Rec.",?69,"Inv. Date"
 W !,?4,"FPPS Claim ID",?18,"FPPS Line Item",?35,"Date Rec.",?46,"Inv. Date",?57,"Fr Date",?68,"To Date"
 W !,?4,"Amt Claimed",?17,"Amt Paid",?29,"Cov.Days",?39,"Adj Code",?49,"Adj Amount",?64,"Remit Remark"
 W !,Q,!
 Q
CDAT S Y=$E(Y,4,5)_"/"_$S($E(Y,6,7)="00":$E(Y,2,3),1:$E(Y,6,7)_"/"_$E(Y,2,3)) Q
GETDAT S Y=BEGDATE D PDF^FBAAUTL S BEGDATE=Y,Y=ENDDATE D PDF^FBAAUTL S ENDDATE=Y
 Q
