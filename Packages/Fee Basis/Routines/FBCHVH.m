FBCHVH ;AISC/DMK-VENDOR PAYMENT HISTORY ;7/17/2003
 ;;3.5;FEE BASIS;**55,61,122,108**;JAN 30, 1995;Build 115
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
 N FBADJLA,FBADJLR,FBCDAYS,FBCSID,FBFPPSC,FBFPPSL,FBRRMKL,FBY2,FBY3,FBY5,FBADMTDX,FBPOA,FBCNTRN,B
 S FBIN=^FBAAI(FBI,0)
 S FBY2=$G(^FBAAI(FBI,2))
 S FBY3=$G(^FBAAI(FBI,3))
 S FBY5=$G(^FBAAI(FBI,5))
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
WRT I $Y+6>IOSL D HANG^FBAAUTL1:$E(IOST,1,2)["C-" Q:FBAAOUT  I $D(^FBAAI(FBI,4)) D HEDC
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
 ;write admitting diagnosis
 S FBADMTDX=$P(FBY5,"^",9) I FBADMTDX]"" W !?2,"Admit Dx: ",$$ICD9^FBCSV1((FBADMTDX),$P($G(FBIN),"^",6))
 ;write contract number
 S FBCNTRN=$S($P(FBY5,U,8):$P($G(^FBAA(161.43,$P(FBY5,U,8),0)),U),1:"")
 I FBCNTRN]"" W ?25,"Contract Number: ",FBCNTRN
 ;set diagnosis code and present on admission code
 N P1,P2
 S P1=$G(^FBAAI(FBI,"DX"))
 S P2=$G(^FBAAI(FBI,"POA"))
 F K=1:1:25 D WRTDX
 ;set procedure code
 N P5
 S P5=$G(^FBAAI(FBI,"PROC"))
 F L=1:1:25 D WRTPC
 N A2 S A2=FBIN(9) D PMNT^FBAACCB2
 Q
WRTDX ;write dianosis code and present on admission code
 N P3,P4
 S FBDX=$P(P1,"^",K)
 S FBPOA=$P(P2,"^",K)
 Q:FBDX=""
 S P3=$$ICD9^FBCSV1((FBDX),$P($G(FBIN),"^",6))_"/"
 S P4=P3_$S(FBPOA:$P($G(^FB(161.94,FBPOA,0)),"^"),1:"")_" "
 I K=1!($X+$L(P4)+2>IOM) W !,?4,"DX/POA: "
 W P4,""
 Q
WRTPC ;write procedure code (if present)
 N P6
 S FBPROC=$P(P5,"^",L)
 Q:FBPROC=""
 S P6=$$ICD0^FBCSV1((FBPROC),$P($G(FBIN),"^",6))_" "
 I L=1!($X+$L(P6)+2>IOM) W !,?4,"PROC: "
 W P6,""
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
PRVD ;DISPLAY PROVIDER INFORMATION BEFORE INVOICE DISPLAY FB*3.5*122
 N FBPRI,FBSRVF,FBST
 S FBPRI=$G(^FBAAI(FBI,4)),FBSRVF=$G(^FBAAI(FBI,5)),$P(FBSRVF,U,3)=$$GET1^DIQ(5,$P(FBSRVF,U,3)_",",1)
 W @IOF,!?30,"INVOICE DISPLAY",!?30,"===============",!?28,"PROVIDER INFORMATION",!
 I $L($P(FBPRI,U,1,3))>3 W !?3,"ATTENDING PROV NAME: "_$P(FBPRI,U),!?3,"ATTENDING PROV NPI: "_$P(FBPRI,U,2),?35,"ATTENDING PROV TAXONOMY CODE: "_$P(FBPRI,U,3)
 I $L($P(FBPRI,U,4,5))>2 W !!?3,"OPERATING PROV NAME: "_$P(FBPRI,U,4),!?3,"OPERATING PROV NPI: "_$P(FBPRI,U,5)
 I $L($P(FBPRI,U,6,8))>3 W !!?3,"RENDERING PROV NAME: "_$P(FBPRI,U,6),!?3,"RENDERING PROV NPI: "_$P(FBPRI,U,7),?35,"RENDERING PROV TAXONOMY CODE: "_$P(FBPRI,U,8)
 I $L($P(FBPRI,U,9,10))>2 W !!?3,"SERVICING PROV NAME: "_$P(FBPRI,U,9),!?3,"SERVICING PROV NPI: "_$P(FBPRI,U,10)
 I $L($P(FBSRVF,U,1,4))>4 W !?3,"SERVICING FACILITY ADDRESS: ",!?5,$P(FBSRVF,U),!?5,$P(FBSRVF,U,2) I $P(FBSRVF,U,2)'="" W ", "
 W $P(FBSRVF,U,3)_" "_$P(FBSRVF,U,4)
 I $L($P(FBPRI,U,11,12))>2 W !!?3,"REFERRING PROV NAME: "_$P(FBPRI,U,11),!?3,"REFERRING PROV NPI: "_$P(FBPRI,U,12),!!
 S DIR(0)="E" D ^DIR
 Q
