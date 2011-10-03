ECTFAR ;B'ham ISC/PTD-Accounts Receivable ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^PRCA(430)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Accounts Receivable' File - #430 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^PRCA(430,0)) W *7,!!,"'Accounts Receivable' File - #430 has not been populated on your system.",!! S XQUIT="" Q
CTN W *7,!!?32,"*** CAUTION ***",!?17,"Report is time consuming; queueing is advised!",!?32,"***************",!!
DT S %DT="AE",%DT("A")="Enter FISCAL year for report: " D ^%DT G:Y<0 EXIT S FY=$E(Y,2,3)
DIP S DIC="^PRCA(430,",BY="1,.01,+2",(FR,TO)=FY,FLDS="2;C13;L15!,71;C40&,77;C60&",L=0
 S DHD="ACCOUNTS RECEIVABLE STATISTICS" D EN1^DIP
EXIT K %DT,%X,B,BY,DHD,DIC,FLDS,FR,FY,L,TO,Y
 Q
 ;
