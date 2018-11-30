PRCAPCL ;WASH-ISC@ALTOONA,PA/NYB-Print Bill Status Report ;8/19/94  10:21 AM
V ;;4.5;Accounts Receivable;**72,63,143,154**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 N BAL,BN,CAT,DEAD,DEBT,DIR,DIROUT,DUOUT,DP,DP2,IOP,N430
 N PAGE,POP,PRCAE,PRCATOT,PRCATOT2,PRCAT,PRCAT2,PRCY,RCDOJ,TDT,STT
 S (PAGE,PRCAT,PRCAT2,PRCATOT,PRCATOT2)=0
 D NOW^%DTC S Y=% X ^DD("DD") S TDT=Y
 I $G(STAT)="ALL" S STT=0 F  S STT=($O(^PRCA(430.3,"AC",STT))) Q:STT=""  D
           .I STT<100!(STT=107) Q
           .S STAT($O(^PRCA(430.3,"AC",STT,0)))=""
           .Q
 S STAT=0 F  S STAT=$O(STAT(STAT)) Q:STAT=""!($D(DIROUT))!($D(DUOUT))  D
    .N NDE
    .D HDR
    .F PRCAE=0:0 S PRCAE=$O(^PRCA(430,"AC",STAT,PRCAE)),X="" Q:'PRCAE!($D(DIROUT)!($D(DUOUT)))  I $P($G(^PRCA(430,PRCAE,100)),"^",2)[$G(SER),$S($G(SER):+$G(^PRCA(430,PRCAE,100)),1:1) D  Q:$D(DIROUT)!($D(DUOUT))  D PRNTL
       ..I $Y+4>IOSL D TOP,HDR
       ..Q
    .I $Y+4>IOSL D TOP,HDR Q:$D(DIROUT)!($D(DUOUT))
    .S DP1=$S(+DAT>0:+DAT,1:0)
    .S DP2=$S(+$P($G(DAT),"^",2)=0:"",1:+$P($G(DAT),"^",2))
    .S DP=0 F  S DP=$O(^TMP($J,"PRCAE",DP)) Q:'DP!($D(DIROUT)!($D(DUOUT)))  D
       ..S BN="" F  S BN=$O(^TMP($J,"PRCAE",DP,BN)) Q:BN=""!($D(DIROUT)!($D(DUOUT)))  D
          ...S NDE=^TMP($J,"PRCAE",DP,BN)
          ...S Y=DP X ^DD("DD") S DP2=Y K Y
          ...S RCDOJ=$$REFST^RCRCUTL(+$O(^PRCA(430,"B",BN,0)))
          ...W $G(DP2),?15,$S(RCDOJ&$G(BN):$G(BN)_"r",1:$G(BN)),?30,$P(NDE,U,2),?45,$P(NDE,U,3)
          ...W ?65,$J($P(NDE,U,4),9,2),!
          ...S PRCATOT2=PRCATOT2+$P(NDE,U,4),PRCAT2=PRCAT2+1
          ...S PRCATOT=PRCATOT+$P(NDE,U,4),PRCAT=PRCAT+1
          ...I $Y+4>IOSL D TOP,HDR Q:$D(DIROUT)!($D(DUOUT))
          ...K ^TMP($J,"PRCAE",DP,BN)
          ...Q
       ..Q
    .I X'="^" W !!!,"SUBTOTAL: ",$J(PRCATOT2,10,2),!,"SUBCOUNT: ",$J(PRCAT2,10),?30 Q:$D(DIROUT)!($D(DUOUT))
    .S (PRCATOT2,PRCAT2)=0
    .Q:$D(DIROUT)!($D(DUOUT))
    .I $O(STAT(STAT))="" Q
    .I $O(STAT(STAT))'="" W !! D TOP
    .Q
 I X'="^" W !!!,"TOTAL: ",$J(PRCATOT,10,2),!,"COUNT: ",$J(PRCAT,10),!," MEAN: ",$J($S('PRCAT:0,1:PRCATOT/PRCAT),10,2),?30,"* -indicates that patient is deceased",!,?30,"r -indicates that bill is referred"
 W:$E(IOST)="P" @IOF Q
TOP ;
 I $E(IOST)="C" S X="" S DIR(0)="E" D ^DIR Q:$D(DIROUT)!($D(DUOUT))
Q2 Q
PRNTL ;
 N BAL,DEAD,DEBT
 S X=$S($D(^PRCA(430,PRCAE,0)):^(0),1:"") G:X="" PQ
 S BN=$P($G(X),U),DP=$P($G(X),U,14),PRCY=$P($G(X),U,2) G:BN="" PQ
 S BEG=+DAT-1,END=+$P(DAT,U,2)
 I BEG,DP'>BEG Q
 I END,DP>END Q
 S (CAT,PRCY)=$S(PRCY="":PRCY,$D(^PRCA(430.2,PRCY,0))#2:$P(^(0),U),1:PRCY)
 S PRCY=$S($D(^RCD(340,+$P(X,U,9),0)):$P(^(0),U),1:"")
 I PRCY["DPT" S DFN=+PRCY D DEM^VADPT S:+VADM(6) DEAD="*" D KVAR^VADPT K VA,VADM
 I PRCY]"" S (DEBT,PRCY)=$S($D(@("^"_$P(PRCY,";",2)_+PRCY_",0)")):^(0),1:"")
 S PRCY=$S($D(^PRCA(430,PRCAE,7)):^(7),1:"")
 I 'PRCY,(STAT=$O(^PRCA(430.3,"AC",104,0))!((STAT=20)&($G(^PRCA(430,PRCAE,100)))))
 S (BAL,PRCY)=$P(PRCY,U)+$P(PRCY,U,2)+$P(PRCY,U,3)+$P(PRCY,U,4)+$P(PRCY,U,5)
 I DP'="" S ^TMP($J,"PRCAE",DP,BN)=U_$E(CAT,1,13)_U_$G(DEAD)_$E($P($G(DEBT),U),1,15)_U_$G(BAL)_U_$G(PRCATOT2)_U_$G(PRCAT2)
 I $G(SER),(STAT=31!(STAT=32)) S Y=$G(^PRCA(430,PRCAE,3)) D
    .W:$P(Y,U)]"" !,"Date: ",$E($P(Y,U),4,5),"/",$E($P(Y,U),6,7),"/",$E($P(Y,U),2,3)
    .W:$P(Y,U,2)]"" "  By: ",$P($G(^VA(200,+$P(Y,U,2),0)),U)
    .W:$P(Y,U,6)]"" "  Reason: ",$P(Y,U,6)
    .Q
 I $E(IOST)="",$Y+4>IOSL D TOP
PQ Q
HDR ;
 I $E(IOST)="C"!PAGE W @IOF
 S PAGE=PAGE+1
 W !,"BILL STATUS LISTING REPORT"
 W ?40,$G(TDT),?72,$G(PAGE)
 W !,"Sort Criteria for Date Last Updated Range: "_SC1_" to "_SC2
 W !,"Date Last",!," Updated",?15,"Bill no.",?30,"Category"
 W ?50,"Debtor",?68,"Balance",!
 S X="",$P(X,"-",IOM-1)="" W X,!
 W !,?5,"Status: ",$P($S($D(^PRCA(430.3,STAT,0)):^(0),1:""),U),!!
 Q
DT I Y X ^DD("DD") S DP2=Y
 Q
STAT(SER) W ! ;Bill Status Listing
 N BEG,DAT,END,SC1,SC2,STAT,STT
 K ^TMP($J)
 S DAT=$$DATE^RCEVUTL1("")
 Q:$G(DAT)=-1
 S BEG=+DAT,END=+$P(DAT,U,2)
 S SC1=$S(BEG=0:"First",1:BEG-1) I +$G(SC1) S Y=SC1+1 X ^DD("DD") S SC1=Y
 S SC2=$S(END=0:"Last",1:END) I +$G(SC2) S Y=SC2 X ^DD("DD") S SC2=Y
 D ST
 Q:STAT="^"
 D TSK,Q1
 Q
ST N DIC,X,Y
 S DIC="^PRCA(430.3,",DIC(0)="QEMZ"
 S DIC("S")="I $P(^(0),""^"",3)>100,($P(^(0),""^"",3)'=107)"
 S Y=0 W !,"STATUS: "_$S('$O(STAT("")):"ALL// ",1:"")
 R X:DTIME I '$T!(X="^") S STAT="^" Q
 I ((X="")!(X="ALL")),'$O(STAT("")) S (STAT,X)="ALL" Q
 I X="" Q
 D ^DIC S STAT=+Y,SER=$G(SER)
 I X["?" W !!,"Enter 'ALL' for all status types.",! G ST
 I STAT'="ALL",(+STAT>0) S STAT(+STAT)="" G ST
 G:+STAT<0 ST
 Q
TSK ;
 N POP,ZTSK
 W *7,!,"Report should be QUEUED it could take some time to run!"
 S POP=0,%ZIS="MQ" D ^%ZIS G:POP Q1
 I '$D(IO("Q")) U IO D PRCAPCL U IO(0) G Q1
 S ZTRTN="^PRCAPCL"
 S (ZTSAVE("BEG"),ZTSAVE("DAT"),ZTSAVE("END"),ZTSAVE("SER"))=""
 S (ZTSAVE("STAT"),ZTSAVE("STAT("),ZTSAVE("SC1"),ZTSAVE("SC2"))=""
 S ZTDESC="Bill Status Listing" D ^%ZTLOAD
Q1 D ^%ZISC Q
