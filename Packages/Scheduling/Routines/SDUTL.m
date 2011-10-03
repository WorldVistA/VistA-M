SDUTL ;MAN/GRR - SCHEDULING UTILITY PROGRAM ; 18 JUN 84  11:31 AM
 ;;5.3;Scheduling;**140,356**;Aug 13, 1993
DATE S:$D(%DT(0)) SDT0=%DT(0) S:$D(SDT00) %DT=SDT00 S POP=0 K BEGDATE,ENDDATE W !!,"**** Date Range Selection ****"
 W ! S %DT=$S($D(SDT00):SDT00,1:"AE"),%DT("A")="   Beginning DATE : "
 D ^%DT S:Y<0 POP=1 G:Y<0 EX S (BEGDATE,SDBD)=Y
 W ! S %DT=$S($D(SDT00):SDT00,1:"AE"),%DT("A")="   Ending    DATE : "
 D ^%DT K %DT S:Y<0 POP=1 G:Y<0 EX G:Y<SDBD HELP W ! S (ENDDATE,SDED)=Y
EX K SDT0,SDT00 Q
 ;
Q G QUE^DGUTQ
 ;
DQ G DQ^DGUTQ
 ;
ZIS G ZIS^DGUTQ
 K PGM,VAL,VAR Q
 ;
CLOSE G CLOSE^DGUTQ Q
 Q
TIME D DT S SDZ01=$H,SDTIME=$P(SDZ01,",",2),SDTIME=DT_(SDTIME\60#60/100+(SDTIME\3600)/100)
 Q
ETIME S Y=(X-SD00)*86400,X1=$P(X,",",2),X2=$P(SD00,",",2),X3=Y-X2+X1,X=X3\3600,X1=X3#3600\60
 Q
OUT W *7 I ($Y+4)<IOSL F SDXX=$Y:1:IOSL-4 W !
 R !!,"Press return to continue or ""^"" to escape ",X:DTIME I X["^"!('$T) S SDEND=1
 Q
DTS S Y=$TR($$FMTE^XLFDT(Y,"5DF")," ","0") Q
DT K %DT S X="T" D ^%DT S DT=Y,U="^" Q
DIV I $D(^DG(43,1,"GL")),$P(^("GL"),"^",2)
 Q
AT S Y1=$S(+$P(Y,".",2):"."_$P(Y,".",2),1:""),Y=$S(+$P(Y,".",1):$P(Y,".",1),1:"")
 I Y]"" D D^DIQ
 I Y1]"" S Y1=$E($P(Y1,".",2)_"0000",1,4),Y2=Y1>1159 S:Y1>1259 Y1=Y1-1200 S Y1=Y1\100_":"_$E(Y1#100+100,2,3)_" "_$E("AP",Y2+1)_"M"
 I Y]"",Y1]"" S Y=Y_" @"_Y1
 I Y']"",Y1]"" S Y=Y1
 K Y1,Y2 Q
LAPPT W *7,!,"Appointment length is inconsistent with inc/hr (",SDZ0,") for this clinic" K X
 Q
RT Q:$S(SDTTM<DT:1,'$D(^DIC(195.4,1,"UP")):1,'^("UP"):1,1:0)
 I SDRT="A" D QUE^RTQ2 Q
 I SDRT="D",$D(^SC(SDSC,"S",SDTTM,1,SDPL,"RTR")),^("RTR") S RTPAR=+^("RTR") D CANCEL^RTQ2 K RTPAR Q
 Q
 ;
RTSET I $D(^SC(SDSC,"S",SDTTM,1,SDPL,0)),DFN=+^(0),$P(^(0),"^",9)'["C",'$D(^("RTR")) S ^("RTR")=RTPAR
 Q
NOTES K IOP S L=0,DIC="^DIC(9.4,",FLDS="[SDREL]",BY="[SDREL]",FR="""SCHEDULING"",3.8",TO=FR,DHD="SCHEDULING V3.8 RELEASE NOTES" G EN1^DIP
I S:'$D(DTIME) DTIME=300 D:'$D(DT) DT S:'$D(U) U="^" Q
HELP W "??",!?5,"Ending date must not be before beginning date" S:$D(SDT0) %DT(0)=SDT0 G DATE
