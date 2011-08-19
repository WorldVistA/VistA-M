RMPFDB ;DDC/KAW-DISPLAY TRANSMISSION BATCH; [ 09/03/97  3:41 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**8**;MAY 30, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 W @IOF,!,"DISPLAY TRANSMISSION BATCH" K ZTSK
 I '$D(^RMPF(791812,"C")) W !!,"*** NO BATCHES HAVE BEEN CREATED ***" G END
 S X=0 F I=1:1 S X=$O(^RMPF(791812,"C",1,X)) Q:'X  I X,$D(^RMPF(791812,X,0)),$P(^(0),U,8)=RMPFSTAP S M=$P(^(0),U,9) S:M M=$P($G(^RMPF(791810.5,M,0)),U,2) S:M="" M=1 I M=RMPFMENU Q
 G A1:X
A0 W !!,"No open batches.",!!,"Display another batch?  NO// "
 D READ G END:$D(RMPFOUT)
A01 I $D(RMPFQUT) W !!,"Type <Y> to see a list of batches, <N> or <RETURN> to exit." G A0
 G END:Y=""!("Nn"[Y) I "Yy"'[Y S RMPFQUT="" G A01
 G A2
A1 W !!,"Display currently open batch? " D READ G END:$D(RMPFOUT)
A11 I $D(RMPFQUT) W !!,"Enter <Y> to display the currently open batch,",!?6,"<N> to view a list of batches no longer open or",!?6,"<RETURN> to exit." G A1
 G END:Y="" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G A11
 I "Yy"[Y S RMPFBT=X G GO
A2 K RMPFBT D DISP G END:$D(RMPFOUT),GO:$D(RMPFBT)
 I '$D(RMPFB) W !!,"*** NO BATCHES EXIST ***" G END
 D SEL G END:$D(RMPFOUT)!'$D(RMPFBT)
GO K RMPFB D ^RMPFDB1 G END:$D(RMPFOUT),RMPFSET:$D(ZTSK) D CONT^RMPFDB1
 I '$D(RMPFOUT) G RMPFSET
END K RMPFBT,ZTRTN,ZTSAVE,ZTDESC,RMPFOUT,RMPFQUT,RMPFT,RMPFB,POP
 K RMPFDOD,ZTSK,%T,%DT,I,X,Y,M Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
DISP ;; input: RMPFS(opt.)
 ;;output: RMPFB
 D HEAD1 S (CT,A)=0 K RMPFB,RMPFBT
D1 S A=$O(^RMPF(791812,"AC",A)) G D3:'A S B=0
D2 S B=$O(^RMPF(791812,"AC",A,B)) G D1:'B
 G D2:'$D(^RMPF(791812,B,0)) S S0=^(0) G D2:$P(S0,U,8)'=RMPFSTAP
 S M=$P(S0,U,9) S:M M=$P(^RMPF(791810.5,M,0),U,2) S:M="" M=0 G D2:M'=RMPFMENU
 S Y=$P(S0,U,1) D DD^%DT S RMPFBDT=Y
 S X=$P(S0,U,2) I $D(RMPFS) G D2:'$D(RMPFS(X))
 S RMPFBST=$S(X=1:"OPEN",X=2:"CLOSED",X=3:"TRANSMITTED",X=4:"QUEUED FOR TRANSMISSION",1:"")
 S RMPFBNA=$P(S0,U,4),(RMPFBTC,RMPFBUS)="" G D2:RMPFBST="OPEN"
 S Y=$P(S0,U,3) I Y?7N.E D DD^%DT S RMPFBTC=Y
 S X=$P(S0,U,5) I X,$D(^VA(200,X,0)) S RMPFBUS=$P(^(0),U,1)
 S CT=CT+1 I $Y>20 D SEL G D3:$D(RMPFOUT),D3:$D(RMPFBT) D HEAD1
 W !,$J(CT,2),". ",RMPFBDT,?24,$E(RMPFBST,1,15),?41,$J(RMPFBNA,3),?46,RMPFBTC,?66,$E(RMPFBUS,1,14) S RMPFB(CT)=B
 G D2
D3 K A,B,M,X,Y,%DT,CT,S0,RMPFBDT,RMPFBST,RMPFBNA,RMPFBTC,RMPFBUS Q
SEL K RMPFBT W !!,"Select Batch Number: " D READ G SELE:$D(RMPFOUT)
SEL1 I $D(RMPFQUT) W !!,"Enter the number to the left of the batch you wish to choose or",!?10,"<RETURN> to continue." G SEL
 G SELE:Y="" I '$D(RMPFB(Y)) S RMPFQUT="" G SEL1
 S RMPFBT=RMPFB(Y)
SELE K Y Q
HEAD1 W @IOF,!?23,"REMOTE ORDER/ENTRY ORDER BATCHES"
 W !?42,"#"
 W !," #",?5,"Batch Date/Time",?25,"Batch Status",?41,"Act",?47,"Date/Time Closed",?68,"Closed By"
 W !,"---",?4,"------------------",?24,"---------------",?41,"---",?46,"------------------",?66,"--------------"
 Q
