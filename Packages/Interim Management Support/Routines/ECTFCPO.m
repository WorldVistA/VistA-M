ECTFCPO ;B'ham ISC/PTD-Fund Control Point Officials ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**15**;
 I '$D(^PRC(420)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Fund Control Point' File - #420 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^PRC(420,0)) W *7,!!,"'Fund Control Point' File - #420 has not been populated on your system.",!! S XQUIT="" Q
 S CNT=0 F J=0:0 S J=$O(^PRC(420,J)) Q:'J  S CNT=CNT+1
DIC I CNT>1 W !! S DIC="^PRC(420,",DIC(0)="QEANM",DIC("A")="Select STATION number: " D ^DIC G:Y<0 EXIT S STNUM=+Y
 I CNT=1 S STNUM=$O(^PRC(420,0))
DIP S DIC="^PRC(420,",BY=".01,1,.01,1,6,@1",(FR,TO)=STNUM_",,"_1,FLDS="1,.01,.5;C25,6,.01;C50;""CONTROL POINT OFFICIAL""",L=0
 S DHD="FUND CONTROL POINT OFFICIAL LIST" D EN1^DIP
EXIT K B,BY,CNT,DHD,DIC,FLDS,FR,J,L,STNUM,TO,X,Y
 Q
 ;
