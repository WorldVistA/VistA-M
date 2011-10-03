FBAAPP ;AISC/GRR-ENTER FEE PHARMACY DETERMINATION ;5/10/2005
 ;;3.5;FEE BASIS;**61,80,91**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 N FBADJ,FBRRMK
 D HOME^%ZIS S FBAAOUT=0 K ^TMP($J,"FBWP") D DT^DICRW
 I '$D(^FBAA(162.1,"AC",1)) W !!,"There are no Fee Basis prescriptions Pending Pharmacy review" G END
 D WAIT^DICD S (CNT,L,M)=0 F  S L=$O(^FBAA(162.1,"AC",1,L)) Q:L'>0  I $D(^FBAA(162.1,L,"RX","AC",1)) F  S M=$O(^FBAA(162.1,L,"RX","AC",1,M)) Q:M'>0  S CNT=CNT+1
 W !!,*7,"There are ",CNT," Fee Prescription(s) Pending Pharmacy review"
ASKRV Q:CNT'>0  W ! S DIR("A")="Want to review some now",DIR("B")="Yes",DIR(0)="Y" D ^DIR K DIR G END:$D(DIRUT)!('Y)
RDIN W ! S FBAAOUT=0,DIC="^FBAA(162.1,",DIC(0)="AEQ",DIC("S")="S ZZ=^(0) I $P(ZZ,U,5)=1&($D(^FBAA(162.1,+ZZ,""RX"",""AC"",1))) K ZZ" D ^DIC K DIC G END:X=""!(X="^"),HELPI^FBAAPP0:X["?" S FBJ=+Y
 L +^FBAA(162.1,"AC",1,FBJ):1 G:'$T ALRDY^FBAAPP0 I $D(^FBAA(162.1,FBJ,"RX","AC",1)) S FBK=0 F  S FBK=$O(^FBAA(162.1,FBJ,"RX","AC",1,FBK)) Q:FBK'>0!(FBAAOUT)  I $D(^FBAA(162.1,FBJ,"RX",FBK,0)) S FBY(0)=^(0) D GOT,CHK:$D(^FBAA(162.1,"AC",1))
 L -^FBAA(162.1,"AC",1,FBJ) I '$D(^FBAA(162.1,"AC",1)) W !,*7,"No more prescriptions pending review!" G END
 G RDIN
END K DFN,FBJ,FBK,Y,X,FBAAOUT,L,CNT,STAT,DA,DAT,DIC,FBAAGP,FBAAPR,FBDX,FDT,SSN,HY,I,T,VIFN,Z,ZZ,VAL,FBAASC,M,W,FBY,FBASSOC,FB583,FB7078,FBPROG,FBTYPE,FBDMRA,FBAUT,^TMP($J,"FBWP")
 K FBNO1,FBNO2,FBDA,FBDRUG,PI,DIRUT,DTOUT,DUOUT
 Q
GOT S STAT=2,DFN=$P(FBY(0),"^",5) Q:'$D(^DPT(+DFN,0))
 S FBPROG=$P($G(^FBAA(162.1,FBJ,"RX",FBK,2)),"^",7),FBPROG=$S(FBPROG:"I FBI="_FBPROG,1:"")
 S HY=Y,PI="" D ^FBAADEM
 D FBPH^FBAAUTL2 W ! F X=1:1:IOM-1 W "-"
 I $Y+5>IOSL,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR Q:'Y  W @IOF
 S Y=HY,VIFN=$P(^FBAA(162.1,FBJ,0),"^",4)
 W !!,"Vendor: ",$P($G(^FBAAV(+VIFN,0)),"^"),!
 I $P(FBY(0),"^",20)="R" W *7,!?20,">> PATIENT REIMBURSEMENT <<",!
 S FDT=$P(FBY(0),"^",3) W !,"Prescription #: ",$P(FBY(0),"^"),"    Drug: ",$P(FBY(0),"^",2),!!,"Fill Date: ",$E(FDT,4,5),"/",$E(FDT,6,7),"/",$E(FDT,2,3),"    Strength: ",$P(FBY(0),"^",12)
 W "  Qty: ",$P(FBY(0),"^",13)
DIR ; DISPLAY FOR PHARMACY EDIT
 S (FBAAGP,FBAAPR,FBDA,FBDRUG,FBNO1,FBNO2)="" K FBADJ,FBRRMK
 I '$D(IOM) D HOME^%ZIS
DIR1 S DIR("A")="Is Prescription for an Authorized Condition"
 S DIR("B")=$S(FBNO1'="":FBNO1,1:"Yes")
 S DIR(0)="Y",DIR("?")="A 'No' answer will deny payment."
 D ^DIR K DIR Q:$D(DIRUT)
 I Y S FBNO1="Yes"
 I 'Y S FBNO1="No" D   D NO1^FBAAPP0 Q:'$D(FBADJ)  G REVIEW
 . S (FBAAGP,FBDA,FBDRUG,FBNO2)=""
 ;
 S DIR("A")="Was a Generic Drug issued to patient"
 S DIR("B")=$S(FBAAGP'="":FBAAGP,1:"Yes")
 S DIR(0)="Y"
 S DIR("?")="A 'No' answer alerts FEE to pay the generic equivalent, if one exists."
 D ^DIR K DIR Q:$D(DIRUT)
 S FBAAGP=$S(Y:"Yes",1:"No")
 ;
 S DIR("A")="Enter VA Generic Drug equivalent"
 I FBDRUG'="" S DIR("B")=FBDRUG
 S DIR("?")="Match the drug entered by FEE to an entry in the VA Drug file."
 S DIR(0)="Pr^50:EM"
 D ^DIR K DIR Q:$D(DIRUT)!('Y)
 S FBDA=+Y,FBDRUG=$P(Y,"^",2)
 ;
 S DIR("A")="Is this an emergency medication"
 S DIR("B")=$S(FBNO2'="":FBNO2,1:"Yes")
 S DIR("?")="A 'No' answer will DENY payment."
 S DIR(0)="Y"
 D ^DIR K DIR Q:$D(DIRUT)
 I Y S FBNO2="Yes" K FBADJ,FBRRMK
 I 'Y S FBNO2="No" D NO1^FBAAPP0 Q:'$D(FBADJ)
 ;
REVIEW W !
 S DIR("A")="Optional Pharmacy Remarks "
 S:FBAAPR]"" DIR("B")=FBAAPR
 S DIR(0)="162.11,22"
 K DA
 D ^DIR K DIR Q:$D(DUOUT)!($D(DTOUT))
 S FBAAPR=Y
 ;
 W ! F I=1:1:IOM-2 W "-"
 W !!?22,">>>  PRESCRIPTION REVIEW  <<<",!
 W !,"Rx for Authorized condition: ",FBNO1
 W ?36,"Emergency Medication: ",FBNO2
 W !,"Generic Drug Issued: ",FBAAGP
 W ?36,"Generic Drug Name: ",$E(FBDRUG,1,25)
 I $D(FBADJ) D
 . N FBI
 . W !!,"Current list of Adjustments: "
 . I '$O(FBADJ(0)) W "none"
 . S FBI=0 F  S FBI=$O(FBADJ(FBI)) Q:'FBI  D
 . . W ?30,"Code: "
 . . W:$P(FBADJ(FBI),U)]"" $P($G(^FB(161.91,$P(FBADJ(FBI),U),0)),U)
 . . W ?44,"Group: "
 . . W:$P(FBADJ(FBI),U,2)]"" $P($G(^FB(161.92,$P(FBADJ(FBI),U,2),0)),U)
 . . W ?56,"Amount: "
 . . W "$",$FN($P(FBADJ(FBI),U,3),"",2),!
 . W !!,"Current list of Remittance Remarks: "
 . I '$O(FBRRMK(0)) W "none"
 . S FBI=0 F  S FBI=$O(FBRRMK(FBI)) Q:'FBI  D
 . . W:$P(FBRRMK(FBI),U)]"" $P($G(^FB(161.93,$P(FBRRMK(FBI),U),0)),U),", "
 W !!,"Optional Pharmacy Remarks: ",FBAAPR
 ;
 W !
 S DIR("A")="Want to edit prior to release"
 S DIR(0)="Y",DIR("B")="No"
 D ^DIR K DIR Q:$D(DIRUT)  G DIR1:Y
 ;
 I $D(FBADJ) G GOON^FBAAPP0
 S $P(FBY(0),"^",10)=FBDA
 S $P(FBY(0),"^",11)=1
 S $P(FBY(0),"^",14)=DUZ
 S $P(FBY(0),"^",15)=DT
 S $P(FBY(0),"^",9)=2
 G RSET^FBAAPP0
 ;
CHK S FBAAOUT=0 W ! S DIR("A")="Want to review another Prescription",DIR("B")="Yes",DIR(0)="Y" D ^DIR K DIR S:'Y FBAAOUT=1 K ^TMP($J,"FBWP"),FBDRUG
 Q
