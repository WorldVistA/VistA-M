RTRPT4 ;MJK/TROY ISC;Management Reports Option; ; 5/20/87  4:33 PM ;
 ;;2.0;Record Tracking;**32**;10/22/91 
 S POP=0 K RTBEG,RTEND W !!,"**** Requested Date Range Selection ****"
 W ! S %DT="AEX",%DT("A")="   Beginning DATE : " D ^%DT S:Y<0 POP=1 G Q8:Y<0 S (%DT(0),RTBEG)=Y
 W ! S %DT="AEX",%DT("A")="   Ending    DATE : " D ^%DT K %DT S:Y<0 POP=1 G Q8:Y<0 W ! S RTEND=Y_".2399"
 S FR=RTBEG,TO=RTEND,DHD="Request Response Statistics for "_$TR($$FMTE^XLFDT(RTBEG,"5DF")," /","0-")_" to "_$TR($$FMTE^XLFDT(RTEND,"5DF")," /","0-")
 S DIC="^RTV(190.1,",L=0,(BY,FLDS)="[RT TIME STUDY]",DIS(0)="I $D(^RTV(190.1,D0,0)),$P(^(0),U,2)'>$P(^(0),U,7),$D(^RT(+^(0),0)),$P(^(0),U,4)="_+RTAPL K DTOUT D OFF^RTRPT3,EN1^DIP,ON^RTRPT3
Q8 K %DT,RTEND,RTBEG,DIC,BY,FLDS,TO,FR,L,DHD,POP,Y Q
