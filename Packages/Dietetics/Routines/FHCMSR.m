FHCMSR ; HISC/NCA - Cost of Meals Served ;3/20/95  09:22
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Read in Month/Year
 R !!,"Enter Month/Year of Cost of Meals Served: ",X:DTIME G:'$T!("^"[X) KIL I X["?" D HELP G EN1
 K %DT S Z=0,%DT="EP"
 D ^%DT G KIL:"^"[X!($D(DTOUT)),EN1:Y<1
 I '$E(Y,4,5) W *7,!,"You Must enter a Month and a Year." G EN1
 S DA=$E(+Y,1,5)_"00"
 I DA>DT W *7,!?5,"Month/Year must not be in the future." G EN1
 K DIC,DIE W ! S DIE="^FH(117.2,"
 L +^FH(117.2,DA,0):0 I '$T W !?5,"Another user is editing this entry." G KIL
 I '$D(^FH(117.2,DA,0)) S $P(^FH(117.2,DA,0),"^",1)=DA,^FH(117.2,"B",DA,DA)="",Z=$P(^FH(117.2,0),"^",4)+1,$P(^FH(117.2,0),"^",3,4)=DA_"^"_Z
 S FHX1=""
 S S1=$E(DA,4,5),S2=$S(S1<4:"01",S1<7:"04",S1<10:"07",1:10) G:'S2 EN1 S S1=$E(DA,1,3)_S2_"00"
 S X1=S1,X2=-1 D C^%DTC S FHPRE=X,FHPRE=$E(FHPRE,1,5)_"00",FHX1=$P($G(^FH(117.2,FHPRE,0)),"^",14,19)
 S DR="[FHCMSR]" D ^DIE L -^FH(117.2,DA,0) K DIC,DIE,DA,DR,DTOUT G EN1
EN2 ; Print the Cost of Meals Served
 D NOW^%DTC S DT=%\1
D1 ; Get Start-End Month/Year
 R !!,"Starting Month/Year: ",X:DTIME G:'$T!("^"[X) KIL
 I X["?" D HELP G D1
 K %DT S %DT="EP"
 D ^%DT S:$D(DTOUT) X="^" G KIL:U[X,D1:Y<1 S SDT=+Y
 I $E(SDT,1,5)'<$E(DT,1,5) W *7,!,"  Month/Year Must Start before Current Month/Year! " G D1
 I '$E(SDT,4,5) W *7,!,"  You Must enter a Month and a Year." G D1
 S SDT=$E(SDT,1,5)_"00"
D2 R !,"Ending Month/Year: ",X:DTIME G:'$T!("^"[X) KIL
 I X["?" D HELP G D2
 S %DT="EP"
 D ^%DT S:$D(DTOUT) X="^" G KIL:U[X,D2:Y<1 S EDT=+Y
 I '$E(EDT,4,5) W *7,!,"  You Must enter a Month and a Year." G D1
 I $E(EDT,1,5)'<$E(DT,1,5) W *7,!,"  Month/Year Must be before Current Month/Year. " G D1
 I $E(EDT,1,5)<$E(SDT,1,5) W *7,!,"  End Cannot be before Start Month/Year." G D1
 S EDT=$E(EDT,1,5)_"00"
 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHCMSR1",FHLST="EDT^SDT" D EN2^FH G KIL
 U IO D Q1^FHCMSR1 D ^%ZISC K %ZIS,IOP G KIL
KIL G KILL^XUSCLEAN
HELP ; Help Message
 W !!,"Enter a Month and a Year such as 6 2000, 6/2000, 6-2000, or June 2000.",!
 W "You can even enter T-1 or type in a date.",!
 Q 
