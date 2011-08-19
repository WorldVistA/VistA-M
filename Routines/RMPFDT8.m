RMPFDT8 ;DDC/KAW-DISPLAY AUTHORIZED AIDS [ 03/12/98  7:46 AM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**10**;;JUN 16, 1995
 ;; input: RMPFX,DFN
 ;;output: None
 Q:'$D(^RMPF(791810,RMPFX,301,1,0))  S Y=$P(^(0),U,8) D DD^%DT S DV=Y
 D PAT^RMPFUTL,HEAD S (RX,CT)=0
A1 S RX=$O(^RMPF(791810,RMPFX,301,RX)) G TOT:'RX
 G A1:'$D(^RMPF(791810,RMPFX,301,RX,0)) S S0=^(0),CT=CT+1
 S ID=$P(S0,U,3) S:ID?7N ID=$E(ID,4,5)_"-"_$E(ID,6,7)_"-"_($E(ID,1,3)+1700)
 S MK=$E($P(S0,U,2),1,12),MD=$E($P(S0,U,1),1,12),SN=$E($P(S0,U,4),1,10)
 S ST=$E($P(S0,U,5),1,4),BT=$E($P(S0,U,6),1,7),ER=$P(S0,U,7)
 W !,$J(CT,2),?5,ID,?17,MK,?32,MD,?49,SN,?61,ST,?67,BT,?77,ER
 G A1
TOT W !!,"Total Number of Authorized Hearing Aids: ",CT
 I IOST?1"P-".E W @IOF
 D:$D(IO("S")) ^%ZISC
 I IOST?1"C-".E D CONT,QUE:"Pp"[Y&(Y'="") I $D(RMION) K RMION G RMPFDT8
END K Y,DV,RX,CT,S0,ID,MK,MD,SN,ST,BT,ER,ZTSK,RMPFOUT,RMPFQUT,I,POP
 K RMPFDOB,RMPFDOD,RMPFNAM,RMPFSSN,%XX,%YY,X Q
HEAD I IOST'?1"P-".E W @IOF
 W !?28,"AUTHORIZED HEARING AIDS",!
 W !?2,"Patient Name: ",RMPFNAM,?63,"SSN: ",RMPFSSN
 W !,"Aids Validated: ",DV
 W !?51,"Serial"
 W !," #",?5,"Issue Date",?21,"Make",?37,"Model",?51,"Number",?61,"Sta.",?67,"Battery",?76,"Ear"
 W !,"---",?5,"----------",?17,"-------------",?32,"---------------",?49,"----------",?61,"----",?67,"-------",?76,"---"
 Q
CONT F I=1:1 Q:$Y>21  W !
 W !,"Enter <RETURN> to continue or <P>rint: " D READ
 I $D(RMPFQUT) D MSG^RMPFDD G CONT
 Q:Y=""  S Y=$E(Y,1) I "Pp"'[Y G CONT
 Q
QUE W ! S %ZIS="NPQ" D ^%ZIS G END:POP K RMION
 I IO=IO(0),'$D(IO("S")) K ZTSK S RMION=IO Q
 I $D(IO("S")) S %ZIS="",IOP=ION D ^%ZIS G ^RMPFDT8
 S ZTRTN="^RMPFDT8",ZTDESC="AUTH AIDS",ZTIO=ION
 S ZTSAVE("RMPFX")="",ZTSAVE("DFN")="" D ^%ZTLOAD
 D HOME^%ZIS W:$D(ZTSK) !!,"*** Request Queued ***" H 2
 K %T,POP Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
