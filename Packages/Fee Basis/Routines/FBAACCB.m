FBAACCB ;AISC/GRR-CLERK CLOSE BATCH ; 11/24/10 1:32pm
 ;;3.5;FEE BASIS;**4,61,77,116**;JAN 30, 1995;Build 30
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 K QQ D DT^DICRW
BT W !! S DIC="^FBAA(161.7,",DIC(0)="AEQ",DIC("S")=$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"I $G(^(""ST""))=""O""",1:"I $P(^(0),U,5)=DUZ&($G(^(""ST""))=""O"")") D ^DIC K DIC("S")
 G Q^FBAACCB0:X="^"!(X=""),BT:Y<0 S B=+Y,FZ=^FBAA(161.7,B,0),FBTYPE=$P(FZ,"^",3)
 I FBTYPE="B3",'$D(^FBAAC("AC",B)) W !!,*7,"No payments in Batch yet!",! G BT
 I FBTYPE="B2",'$D(^FBAAC("AD",B)) W !!,*7,"No Payments in Batch yet!",! G BT
 I FBTYPE="B5",'$D(^FBAA(162.1,"AE",B)) W !!,*7,"No Payments in Batch yet!",! G BT
 I FBTYPE="B9",'$D(^FBAAI("AC",B)) W !!,*7,"No Payments in Batch yet!",! G BT
RDD S DIR(0)="Y",DIR("A")="Want to review batch",DIR("B")="NO",DIR("?")="If you want a detail list of each payment line, answer ""Yes"" otherwise press Return key" D ^DIR K DIR
 G BT:$D(DIRUT) W:Y @IOF D:Y LIST:FBTYPE="B3",LISTP:FBTYPE="B5",LISTT^FBAACCB0:FBTYPE="B2",LISTC^FBAACCB1:FBTYPE="B9"
RDD1 S DIR(0)="Y",DIR("A")="Do you still want to close Batch",DIR("B")="YES" D ^DIR K DIR G BT:'Y!$D(DIRUT)
 N FBARY,FBOLD,FBINVT
 ;
 S C=0,T=0 G PHARM^FBAACCB1:FBTYPE="B5",TRAV^FBAACCB1:FBTYPE="B2",CHNH^FBAACCB1:FBTYPE="B9"
 F J=0:0 S J=$O(^FBAAC("AC",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AC",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AC",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AC",B,J,K,L,M)) Q:M'>0  D GOT
FIN ; FB*3.5*116 - check and handle $0 invoices
 D CHECK(.FBARY)
 I $D(FBARY) D  G BT
 . ;D EN^DDIOL(.FBARY)
 . W *7,!!?2,"Batch cannot be closed. Listed invoices are zero dollar "
 . W *7,!?2,"and must be corrected or removed from the batch."
 ; end of changes
 ;
 S $P(FZ,"^",9)=T,$P(FZ,"^",11)=C
 S $P(FZ,"^",13)=DT,^FBAA(161.7,B,0)=FZ,^FBAA(161.7,B,"ST")="C",^FBAA(161.7,"AC","C",B)="",DA=B,DR="0;ST" K ^FBAA(161.7,"AC","O",B),^FBAA(161.7,"AB","O",$P(^FBAA(161.7,B,0),"^",5),B) W !! D EN^DIQ W !!,"Batch Closed" G BT
 ;
GOT S Y(0)=$G(^FBAAC(J,1,K,1,L,1,M,0)),FBIN=$P(Y(0),"^",16)
 ; HIPAA 5010 - count line items that have 0.00 amount paid
 S T=T+$P(Y(0),"^",3),C=C+1
 ; FB*3.5*116 -collect amount paid for each invoice in batch
 S FBARY(FBIN)=$G(FBARY(FBIN))+$P(Y(0),"^",3)
 Q
 ;
CHECK(FBINV) ; order thru array and save zero dollar invoices; report any zero dollar invoices
 ; FBINV = array of invoices
 N FBAAIN
 S FBAAIN=0 F  S FBAAIN=$O(FBINV(FBAAIN)) Q:'FBAAIN  D
 . I FBINV(FBAAIN)'>0 W !!,"Invoice #: "_FBAAIN_" totals $0.00"
 . E  K FBINV(FBAAIN) ; remove array elements that represent non-zero dollar invoices
 Q
 ;
LIST S Q="",$P(Q,"=",80)="="
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
ENM D HED S (FBIN,FBINOLD)="",(FBAAOUT,FBINTOT)=0 F XY=0:0 S FBIN=$O(^FBAAC("AJ",B,FBIN)) Q:FBIN=""!($G(FBAAOUT))  D INTOT^FBAACCB0 F J=0:0 S J=$O(^FBAAC("AJ",B,FBIN,J)) Q:J'>0!($G(FBAAOUT))  D GMORE^FBAACCB0
 I '$G(FBAAOUT) S FBIN=0 D INTOT^FBAACCB0
 Q
SET ;
 N FBADJLA,FBADJLR,FBFPPSC,FBFPPSL,FBX,FBY3,TAMT
 S N=$S($D(^DPT(J,0)):$P(^DPT(J,0),"^",1),1:""),S=$S(N]"":$P(^DPT(J,0),"^",9),1:""),V=$S($D(^FBAAV(K,0)):$P(^FBAAV(K,0),"^",1),1:""),VID=$S(V]"":$P(^(0),"^",2),1:"")
 S D=+$G(^FBAAC(J,1,K,1,L,0)) Q:'D
 S Y=$G(^FBAAC(J,1,K,1,L,1,M,0)) Q:Y']""
 S FBY3=$G(^FBAAC(J,1,K,1,L,1,M,3))
 S FBFPPSC=$P(FBY3,U)
 S FBFPPSL=$P(FBY3,U,2)
 S FBX=$$ADJLRA^FBAAFA(M_","_L_","_K_","_J_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 S T=$P(Y,"^",5),FBIN=$P(Y,"^",16),ZS=$P(Y,"^",20)
 S TAMT=$FN($P(Y,"^",4),"",2)
 S FBVP=$S($P(Y,"^",21)="VP":"#",1:"")
 S FBAACPT=$$CPT^FBAAUTL4($P(Y,U))
 S CPTDESC=$$CPT^FBAAUTL4($P(Y,U),1,D)
 S FBVCHDT=$P(Y,"^",6),FBIN(1)=$P(Y,"^",15) D FBCKO^FBAACCB2(J,K,L,M)
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",""M"")","E")
GO S A1=$P(Y,"^",2)+.0001,A2=$P(Y,"^",3)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2),FBINTOT=FBINTOT+A2
 D WRT:FBTYPE'="B2",WRTT^FBAACCB0:FBTYPE="B2"
 Q
WRT I $Y+8>IOSL D ASKH^FBAACCB0:$E(IOST,1,2)["C-" Q:FBAAOUT  W @IOF D HED
 S B(1617)=$S(B="":"",$D(^FBAA(161.7,B,0)):$P(^(0),"^"),1:"")
 W !!,N,?35,$$SSN^FBAAUTL(J),?58,B(1617),?67,$$DATX^FBAAUTL($G(FBVCHDT)),!,?3,V,?42,VID,?55,FBIN,?67,$$DATX^FBAAUTL(FBIN(1))
 W !,$S($D(QQ):QQ_")",1:""),$S(ZS="R":"*",1:""),$S(FBTYPE="B3":FBVP,1:""),$S(FBTYPE="B5":FBPV,1:""),$S($G(FBCAN)]"":"+",1:"")
 I FBTYPE="B3" W ?4,$$DATX^FBAAUTL(D),?14,FBAACPT_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:""),?24,CPTDESC,?54,FBFPPSC,?66,FBFPPSL
 I FBTYPE="B5" W ?4,$$DATX^FBAAUTL(D),?14,FBAACPT_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:""),?24,CPTDESC,?56,FBFPPSC,?68,FBFPPSL
 I $P($G(FBMODLE),",",2)]"" D  Q:FBAAOUT
 . N FBI,FBMOD
 . F FBI=2:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  D  Q:FBAAOUT
 . . I $Y+5>IOSL D  Q:FBAAOUT
 . . . I $E(IOST,1,2)="C-" D ASKH^FBAACCB0 Q:FBAAOUT
 . . . W @IOF D HED W !,"(continued)"
 . . W !,?19,"-",FBMOD
 W !?4,$J(A1,6),?17,$J(A2,6)
 ; write adjustment reasons, if null then write suspend code
 W ?30,$S(FBADJLR]"":FBADJLR,1:T)
 ; write adjustment amounts, if null then write amount suspended
 W ?41,$S(FBADJLA]"":FBADJLA,1:TAMT)
 D PMNT^FBAACCB2 S FBINOLD=FBIN
 Q
HED W "Patient Name",?20,"('*' Reimbursement to Patient   '+' Cancellation Activity)",!,?13,"('#' Voided Payment)",?58,"Batch #",?67,"Voucher Date"
 W !,?3,"Vendor Name",?42,"Vendor ID",?53,"Invoice #",?67,"Date Rec'd."
 I FBTYPE="B3" D
 . W !,?4,"SVC DATE",?14,"CPT-MOD",?24,"SERVICE PROVIDED",?54,"FPPS CLAIM",?66,"FPPS LINE"
 . W !,?4,"CLAIMED",?17,"PAID",?30,"ADJ CODE",?41,"ADJ AMOUNT"
 I FBTYPE="B5" D
 . W !,?4,"RX  DATE",?14,"RX #",?24,"DRUG NAME",?56,"FPPS CLAIM",?68,"FPPS LINE"
 . W !,?4,"CLAIMED",?17,"PAID",?30,"ADJ CODE",?41,"ADJ AMOUNT"
 W !,Q,!
 Q
LISTP S Q="",$P(Q,"=",80)="="
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
ENP D HED S (FBAAOUT,FBINTOT)=0,FBINOLD=""
 F A=0:0 S A=$O(^FBAA(162.1,"AE",B,A)) Q:A'>0!($G(FBAAOUT))  S FBIN=A D SETV^FBAACCB0 F B2=0:0 S B2=$O(^FBAA(162.1,"AE",B,A,B2)) Q:B2'>0!($G(FBAAOUT))  D INTOT^FBAACCB0 I $D(^FBAA(162.1,A,"RX",B2,0)) S Z(0)=^(0) D MORE^FBAACCB1
 I '$G(FBAAOUT) S FBIN=0 D INTOT^FBAACCB0
 Q
