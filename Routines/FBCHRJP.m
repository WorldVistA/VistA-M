FBCHRJP ;AISC/DMK/CMR-PRINT REJECTED PAYMENTS FROM PRICER ;18APR90
 ;;3.5;FEE BASIS;**58,69**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(^FBAAI("AH")) W !,*7,"No payments rejected!",! Q
 S (VAR,VAL)="",PGM="START^FBCHRJP" D ZIS^FBAAUTL G END:FBPOP
START K ^TMP($J,"FB") S (FBAAOUT,FBLISTC)=0,Q="",$P(Q,"=",80)="=",QQ="-",$P(QQ,"-",39)="-" U IO W:$E(IOST,1,2)["C-" @IOF D HED
 F FBA=0:0 S FBA=$O(^FBAAI("AH",FBA)) Q:FBA=""  I $D(^FBAA(161.7,FBA,0)),$P(^(0),"^",15)="Y" S FBN=+^(0) D
 .F FBI=0:0 S FBI=$O(^FBAAI("AH",FBA,FBI)) Q:FBI'>0  I $D(^FBAAI(FBI,0)),$P(^(0),"^",9)="",$D(^FBAAI(FBI,"FBREJ")) D
 ..S FBSORT=1 D VET^FBCHDI,SET^FBPAY67
 S (FBVEN,FBNAME)="",(FBDT,FBI)=0 K FBIN
 F  S FBVEN=$O(^TMP($J,"FB",6,FBVEN)) Q:FBVEN=""!(FBAAOUT)  F  S FBNAME=$O(^TMP($J,"FB",6,FBVEN,FBNAME)) Q:FBNAME=""!(FBAAOUT)  F  S FBDT=$O(^TMP($J,"FB",6,FBVEN,FBNAME,FBDT)) Q:FBDT'>0!(FBAAOUT)  D
 .F  S FBI=$O(^TMP($J,"FB",6,FBVEN,FBNAME,FBDT,FBI)) Q:FBI'>0!(FBAAOUT)  D  D PRINT
 ..F I=1:1:9 S FBIN(I)=$P(^TMP($J,"FB",6,FBVEN,FBNAME,FBDT,FBI),"^",I)
 ..S FB7078=$S($P(^FBAAI(FBI,0),"^",5)["FB7078":$P($G(^FB7078(+$P(^FBAAI(FBI,0),"^",5),0)),"^"),1:"") F I=1:1:3 S FBREJ(I)=$P(^FBAAI(FBI,"FBREJ"),"^",I)
END K DFN,FB,FBA,FBAAOUT,FBDX,FBI,FBIN,FBLISTC,FBN,FBPROC,FBVEN,FBVID,J,K,L,PGM,Q,QQ,VA,VADM,VAL,VAR,Y,FB7078,FBPROC1,FBREJ,FBINV,^TMP($J)
 D CLOSE^FBAAUTL,END^FBCHDI
 Q
PRINT I $Y+5>IOSL,$E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR K DIR I 'Y S FBAAOUT=1 Q
 I $Y+5>IOSL W @IOF D HED
 S FBINV=^TMP($J,"FB",6,FBVEN,FBNAME,FBDT,FBI,"FBINV") ;set by FBPAY67
 ;If adj code found print it, if not then print suspend code
 I $P(FBINV,U,5)]"" S FBIN(4)=$P(FBINV,U,5)
 W !!,"Vendor: ",$P(FBVEN,";"),?41,"Vendor ID: ",+$P(FBVEN,";",2)
 W !,"Patient: ",$P(FBNAME,";"),?41,"Patient ID: ",$$SSN^FBAAUTL($P(FBNAME,";",2))
 W ! W:FBIN(8)["R" "*" W:FBIN(9)]"" "#" W ?3,FBIN(1),?23,FBIN(2),?33,FBIN(3),?42,FBIN(4),?49,FBIN(5),?61,FBIN(6),?72,FBIN(7)
 ;If FPPS Claim ID exists then print it.
 I $P(FBINV,U,3)]"" D
 .W !?3,"FPPS Claim ID: ",$P(FBINV,U,3),"    FPPS Line Item: ",$P(FBINV,U,4)
 W !?3,"DX: ",+$G(^TMP($J,"FB",6,FBVEN,FBNAME,FBDT,FBI,"DX"))
 W !?3,"Associated 7078: ",FB7078,!?3,$S(FBREJ(1)="P":"Rejects Pending!",FBREJ(1)="C":"Rejected!",1:""),?23,"Reject Reason: ",FBREJ(2),!?3,"Old Batch #: ",FBREJ(3)
 Q
HED W !?18,"CIVIL HOSPITAL REJECTED PAYMENT HISTORY",!?18,QQ
 W !!?3,"('*' Represents Reimbursement to Patient",?50,"'#' Represents Voided Payment)"
 W !?2,"Inv Date",?23,"Amount",?33," Amount",?42,"Adj",?49,"Invoice",?61,"From",?73,"To"
 W !?23,"Claimed",?35,"Paid",?42,"Code",?53,"Num",?61,"Date",?71,"Date",!,Q
 Q
