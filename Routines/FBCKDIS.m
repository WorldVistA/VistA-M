FBCKDIS ;AISC/CMR-OUTPUT BY CHECK # ;7/NOV/2006
 ;;3.5;FEE BASIS;**4,61,101**;JAN 30, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;FBCN=Check Number               FBPROG=Fee payment type
 ;FBPR is set if called from the phone menu.  If this variable exists,
 ;     the user will not be returned to the TOP to select another ck #.
TOP W ! S DIR(0)="FO^1:8",DIR("A")="Select Check Number" D ^DIR K DIR Q:Y=""!(Y="^")  S FBCN=Y
 I '$D(^FBAAC("ACK",FBCN)),('$D(^FBAAC("ACKT",FBCN))),('$D(^FBAAI("ACK",FBCN))),('$D(^FBAA(162.1,"ACK",FBCN))) W !!,*7,"There is no record of that check number." G TOP
 S VAR="FBCN",VAL=FBCN,PGM="START^FBCKDIS" D ZIS^FBAAUTL G END:FBPOP
START S Q="-",$P(Q,"-",80)="-",QQ="=",$P(QQ,"=",80)="=",FBPG=1 K ^TMP($J,"FBCK")
 N FBV,DFN D ^FBCKDIS1
 U IO W:$E(IOST,1,2)["C-" @IOF
 F FBPROG="OPT","CH","CNH","PHAR","TRAV" I $D(^TMP($J,"FBCK",FBPROG)) D PGCHK D  Q:$G(FBAAOUT)
 .S FBV=0 F  S FBV=$O(^TMP($J,"FBCK",FBPROG,FBV)) Q:FBV']""!($G(FBAAOUT))  W:FBPROG'="TRAV" !!,"VENDOR:  ",$$VNAME^FBNHEXP(FBV),?40,"  VENDOR ID:  ",$$VID^FBNHEXP(FBV) D
 ..S DFN=0 F  S DFN=$O(^TMP($J,"FBCK",FBPROG,FBV,DFN)) Q:'DFN!($G(FBAAOUT))  D:$Y+8>IOSL PGCHK Q:$G(FBAAOUT)  W !!,"Patient:  ",$$NAME^FBCHREQ2(DFN),?40,"Patient ID:  ",$$SSNL4^FBAAUTL($$SSN^FBAAUTL(DFN)) D
 ...N FBAARC,FBADJLA,FBADJLR,FBC,FBFPPSC,FBFPPSL,FBSUSPA,FBX
 ...S FBCNT=0 F  S FBCNT=$O(^TMP($J,"FBCK",FBPROG,FBV,DFN,FBCNT)) Q:'FBCNT!($G(FBAAOUT))  S FBDA=^(FBCNT) D @FBPROG,OUTPUT,CLEAN
END K FBCN,FBCNT,DFN,FBV,FBPROG,FBPG,DIRUT,DTOUT,DUOUT,Q,QQ,^TMP($J,"FBCK")
 D CLOSE^FBAAUTL
 I $G(FBAAOUT) K FBAAOUT Q
 Q:$G(FBPR)]""!($G(ZTQUEUED))
 W !! S DIR(0)="E" D ^DIR K DIR Q:'Y  G TOP
OPT ;gather payment line item for outpatient
 F I=1:1:4 S FB(I)=+$P(FBDA,U,I)
 S FBA=^FBAAC(FB(1),1,FB(2),1,FB(3),1,FB(4),0),FBB=^(2),FBC=$G(^(3))
 S FBDOS=+^FBAAC(FB(1),1,FB(2),1,FB(3),0)
 S FBSRV=$$CPT^FBAAUTL4($P(FBA,U))
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_FB(1)_",1,"_FB(2)_",1,"_FB(3)_",1,"_FB(4)_",""M"")","E")
 S FBSRV=FBSRV_$S($G(FBMODLE)]"":"-"_FBMODLE,1:"")
 S FBAMCL=$P(FBA,U,2),FBAMPD=$P(FBA,U,3)
 S FBSUSP=$P(FBA,U,5) D SUSP^FBCKDIS1
 S FBSUSPA=$FN($P(FBA,U,4),"",2)
 S FBFPPSC=$P(FBC,U)
 S FBFPPSL=$P(FBC,U,2)
 S FBAARCE=$$GET1^DIQ(162.03,FB(4)_","_FB(3)_","_FB(2)_","_FB(1)_",",48)
 S FBX=$$ADJLRA^FBAAFA(FB(4)_","_FB(3)_","_FB(2)_","_FB(1)_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 S FBVP=$P(FBA,U,21),FBREIM=$P(FBA,U,20),FBBAT=$P(FBA,U,8),FBINV=$P(FBA,U,16)
 D FBCKO^FBAACCB2(FB(1),FB(2),FB(3),FB(4))
 Q
CH ;gather payment line item for ch
CNH ;gather payment line item for cnh
 S FBA=^FBAAI(FBDA,0),FBB=^(2),FBC=$G(^(3)),FBDOS=$P(FBA,U,6)_"-"_$P(FBA,U,7),FBAMCL=$P(FBA,U,8),FBAMPD=$P(FBA,U,9),FBSUSP=$P(FBA,U,11) D SUSP^FBCKDIS1
 S FBVP=$P(FBA,U,14),FBREIM=$P(FBA,U,13),FBBAT=$P(FBA,U,17),FBINV=+FBA
 S FBSUSPA=$FN($P(FBA,U,10),"",2)
 S FBFPPSC=$P(FBC,U)
 S FBFPPSL=$P(FBC,U,2)
 S FBX=$$ADJLRA^FBCHFA(FBDA_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 D FBCKI^FBAACCB1(FBDA)
 Q
PHAR ;gather payment line item for pharmacy
 F I=1,2 S FB(I)=$P(FBDA,U,I)
 S FBA=^FBAA(162.1,FB(1),"RX",FB(2),0),FBB=^(2),FBC=$G(^(3)),FBDOS=$P(FBA,U,3),FBSRV=$P(FBA,"^"),FBAMCL=$P(FBA,U,4),FBAMPD=$P(FBA,U,16),FBSUSP=$P(FBA,U,8) D SUSP^FBCKDIS1
 S FBVP=$P(FBB,U,3),FBREIM=$P(FBA,U,20),FBBAT=$P($G(FBA),U,17),FBINV=+$G(^FBAA(162.1,FB(1),0))
 S FBSUSPA=$FN($P(FBA,U,7),"",2)
 S FBFPPSC=$P($G(^FBAA(162.1,FB(1),0)),U,13)
 S FBFPPSL=$P(FBC,U)
 S FBX=$$ADJLRA^FBRXFA(FB(2)_","_FB(1)_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 D FBCKP^FBAACCB1(FB(1),FB(2))
 Q
TRAV ;gather payment line item for travel
 F I=1,2 S FB(I)=$P(FBDA,U,I)
 S FBA=^FBAAC(FB(1),3,FB(2),0),FBDOS=+FBA,FBAMCL=$P(FBA,U,3),FBAMPD=FBAMCL,FBVP="",FBREIM="R",FBBAT=$P(FBA,U,2),FBINV=""
 D FBCKT^FBAACCB0(FB(1),FB(2))
 Q
CLEAN ;clean up variables
 K I,FB,FBA,FBB,FBDOS,FBSRV,FBMOD,FBAMCL,FBAMPD,FBSUSP,FBVP,FBREIM,FBBAT,FBINV,FBDA,FBMODLE
 Q
OUTPUT ;display line items for check number
 I $Y+5>IOSL D PGCHK Q:$G(FBAAOUT)
 W ! W:FBVP="VP" "#" W:FBREIM="R" "*" W:FBCAN]"" "+" D  Q:$G(FBAAOUT)
 . I FBPROG["C" D  Q
 . . W ?3,$$DATX^FBAAUTL($P(FBDOS,"-")),?15,$$DATX^FBAAUTL($P(FBDOS,"-",2)),?59,+$G(^FBAA(161.7,+FBBAT,0)),?68,FBINV
 . . W !?3,$J($FN(FBAMCL,",",2),10),?15,$J($FN(FBAMPD,",",2),10)
 . . ; write adjustment reasons, if null then write suspend code
 . . W ?28,$S(FBADJLR]"":FBADJLR,1:FBSUSP)
 . . ; write adjustment amounts, if null then write amount suspended
 . . W ?38,$S(FBADJLA]"":FBADJLA,1:FBSUSPA)
 . . I FBFPPSC]"" W !,?12,"FPPS Claim ID: ",FBFPPSC,?40,"FPPS Line Item: ",FBFPPSL
 . I FBPROG="OPT" D  Q
 . . W ?3,$$DATX^FBAAUTL(FBDOS),?13,$P(FBSRV,","),?23,FBAARCE
 . . W ?59,+$G(^FBAA(161.7,+FBBAT,0)),?68,FBINV
 . . I $P(FBSRV,",",2)]"" D  Q:$G(FBAAOUT)
 . . . N FBI,FBMOD
 . . . F FBI=2:1 S FBMOD=$P(FBSRV,",",FBI) Q:FBMOD=""  D  Q:$G(FBAAOUT)
 . . . . I $Y+5>IOSL D PGCHK Q:$G(FBAAOUT)  W !,"  (continued)"
 . . . . W !,?18,"-",FBMOD
 . . W !?3,$J($FN(FBAMCL,",",2),10),?15,$J($FN(FBAMPD,",",2),10)
 . . ; write adjustment reasons, if null then write suspend code
 . . W ?28,$S(FBADJLR]"":FBADJLR,1:FBSUSP)
 . . ; write adjustment amounts, if null then write amount suspended
 . . W ?38,$S(FBADJLA]"":FBADJLA,1:FBSUSPA)
 . . I FBFPPSC]"" W !,?12,"FPPS Claim ID: ",FBFPPSC,?40,"FPPS Line Item: ",FBFPPSL
 . I FBPROG="PHAR" D  Q
 . . W ?3,$$DATX^FBAAUTL(FBDOS),?13,FBSRV,?59,+$G(^FBAA(161.7,+FBBAT,0)),?68,FBINV
 . . W !?3,$J($FN(FBAMCL,",",2),10),?15,$J($FN(FBAMPD,",",2),10)
 . . ; write adjustment reasons, if null then write suspend code
 . . W ?28,$S(FBADJLR]"":FBADJLR,1:FBSUSP)
 . . ; write adjustment amounts, if null then write amount suspended
 . . W ?38,$S(FBADJLA]"":FBADJLA,1:FBSUSPA)
 . . I FBFPPSC]"" W !,?12,"FPPS Claim ID: ",FBFPPSC,?40,"FPPS Line Item: ",FBFPPSL
 . W ?3,$$DATX^FBAAUTL(FBDOS) W:FBPROG'="TRAV" ?13,FBSRV W ?20,$J($FN(FBAMCL,",",2),10),?32,$J($FN(FBAMPD,",",2),10) W:FBPROG'="TRAV" ?47,FBSUSP W ?53,+$G(^FBAA(161.7,+FBBAT,0)),?65,FBINV
 S A2=FBAMPD D PMNT^FBAACCB2 K A2
 Q
HED W !?20,"PAYMENT HISTORY FOR CHECK # ",FBCN,!,?20,$E(Q,1,(28+$L(FBCN))),?70,"Page: ",FBPG
 W !!,?22,"FEE PROGRAM:  ",$S(FBPROG="OPT":"OUTPATIENT",FBPROG="CH":"CIVIL HOSPITAL",FBPROG="CNH":"COMMUNITY NURSING HOME",FBPROG="PHAR":"PHARMACY",FBPROG="TRAV":"TRAVEL",1:"")
 W !?1,"('*' Reimbursement to Patient  '#' Voided Payment  '+' Cancellation Activity)"
 I FBPROG["C" D  Q
 . W !?3,"From Date",?15,"To Date",?59,"Batch #",?68,"Invoice #"
 . W !?3,"Amt Claimed",?17,"Amt Paid",?28,"Adj Code",?38,"Adj Amount"
 . W !,QQ
 I FBPROG="TRAV" W !?3,"Travel Dt",?21,"Amount",?33,"Amount",?50,"Batch",?62,"Invoice",!,?21,"Claimed",?34,"Paid",?50,"Number",?62,"Number",!,QQ Q
 I FBPROG="OPT" D  Q
 . W !?3,"Svc Date",?13,"CPT-MOD",?23,"Rev.Code",?59,"Batch #",?68,"Invoice #"
 . W !?3,"Amt Claimed",?17,"Amt Paid",?28,"Adj Code",?38,"Adj Amount"
 . W !,QQ
 I FBPROG="PHAR" D  Q
 . W !?3,"Fill Dt",?13,"RX #",?56,"Batch #",?68,"Invoice #"
 . W !?3,"Amt Claimed",?17,"Amt Paid",?28,"Adj Code",?38,"Adj Amount"
 . W !,QQ
 Q
PGCHK I FBPG>1,($E(IOST,1,2)["C-") W !! S DIR(0)="E" D ^DIR K DIR I 'Y S FBAAOUT=1 Q
 W:FBPG>1 @IOF D HED
 S FBPG=FBPG+1 Q
