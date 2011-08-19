ECTEQT ;B'ham ISC/PTD-Inquire to Planned Equipment Item ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^ECT(731.5)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'VAMC Planned Equipment' File - #731.5 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^ECT(731.5,0)) W *7,!!,"'VAMC Planned Equipment' File - #731.5 has not been populated on your system.",!! S XQUIT="" Q
 ;
DIC W !! S DIC="^ECT(731.5,",DIC(0)="QEAM",DIC("A")="Select EQUIPMENT item: " D ^DIC G:Y<0 EXIT S DA=+Y
 K %ZIS S IOP="HOME" D ^%ZIS K %ZIS,IOP W @IOF,!!?30,"PLANNED EQUIPMENT DATA:",!!
 D EN^DIQ K DIC,Y,DA G DIC
EXIT K %,A,DA,DIC,POP,S,X,Y
 Q
 ;
