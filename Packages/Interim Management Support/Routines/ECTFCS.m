ECTFCS ;B'ham ISC/PTD-Contract Summary by Fiscal Year ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^ECT(731)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'VAMC Management' File - #731 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^ECT(731,0)) W *7,!!,"'VAMC Management' File - #731 has not been populated on your system.",!! S XQUIT="" Q
 W !,"You may select the fiscal year for this report.",!
YR S %DT="AE",%DT("A")="Enter FISCAL YEAR: ",%DT(0)=2700000 D ^%DT K %DT G:$D(DTOUT)!("^"[X) EXIT S YRDA=$E(Y,1,3),YR=$E(Y,2,3)
 I '$O(^ECT(731,YRDA,20,0)) W *7,!!,"No contract data has been entered for '",YR,".",! G EXIT
 ;CHOOSE SORT BY FIELD: RESPONSIBLE SERVICE OR CONTRACT TYPE
CHS W !!,"You may choose to SORT by:",!!,"1.  Responsible service.",!?5,"OR",!,"2.  Contract type.",!!,"Select a number (1 or 2): "
 R CHS:DTIME G:'$T!("^"[CHS) EXIT I CHS'?1N!(CHS<1)!(CHS>2) W !!,*7,"You MUST answer ""1"" or ""2""." G CHS
DIP S DIC="^ECT(731,",L=0,(FR,TO)=YR,DHD="VAMC CONTRACTS - FY "_(1700+YRDA)
 S BY=$S(CHS=2:"@.01,20;S2,+2,20,.01",1:"@.01,20;S2,+5,20,.01"),FLDS=$S(CHS=2:"20,.01,1;C16;L35,&3;C65",1:"20,.01,1;C16;L35,2;C55;L4,&3;C65") D EN1^DIP
EXIT K %X,B,BY,CHS,DA,DHD,DIC,DTOUT,FLDS,FR,L,TO,X,Y,YR,YRDA
 Q
 ;
