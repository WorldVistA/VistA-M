ECTPRPT ;B'ham ISC/PTD-VAMC Staffing Report by Pay Period ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**5**;
 I '$D(^ECT(731.7)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'VAMC Staffing' File - #731.7 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^ECT(731.7,0)) W *7,!!,"'VAMC Staffing' File - #731.7 has not been populated on your system.",!! S XQUIT="" Q
PP R !!,"Enter Pay Period for Report: ",PP:DTIME G:'$T!("^"[PP) EXIT I (PP'?.N)!(PP<1)!(PP>27) W !!,*7,"You MUST answer with a number between 1 and 27." G PP
 S:$L(PP)=1 PP="0"_PP
YR W ! S %DT="AE",%DT("A")="Enter calendar year associated with this pay period: ",%DT(0)=2000000 D ^%DT G:$D(DTOUT)!("^"[X) EXIT S YR=$E(Y,1,3),YRPP=YR_PP
 I '$D(^ECT(731.7,YRPP)) W !!,*7,"No data exists for this pay period/year!" K PP,X,Y,DTOUT,YR,YRPP G PP
DIP S DIC="^ECT(731.7,",BY="@.01",(FR,TO)=YRPP,L=0,DHD="VAMC STAFFING - PAY PERIOD: "_PP_" "_(1700+YR),FLDS="10,.01,1;C40&,2;T;C50&,3;C60&,&(#3-#1);R5;D1;C72;""VARIANCE""" D EN1^DIP
EXIT K %DT,BY,DHD,DIC,DTOUT,FLDS,FR,L,PP,TO,X,Y,YR,YRPP
 Q
 ;
