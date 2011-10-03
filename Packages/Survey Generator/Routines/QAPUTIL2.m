QAPUTIL2 ;557/THM-SURVEY GENERATOR UTILITIES, PART 3 [ 07/24/96  2:46 PM ]
 ;;2.0;Survey Generator;**2,5**;Jun 20, 1995
 ;
HELP2 ;from QAPEDIT
 K DTOUT,DIRUT X:$D(CLEOP) CLEOP W !!!,"Select  C to create a completely new survey",!
 W "        B to change only the basic survey information",!
 W "        D to add or edit demographic survey fields",!
 W "        E to edit all survey questions in current order",!
 W "        I to add or edit individual survey questions",!
 W "        P to print a copy of the survey",!
 W "        Q, '^' or <RETURN> to EXIT",!
 W !!,"Press RETURN  " R ANS:30 I '$T X:$D(CLEOP) CLEOP S DIRUT=1 Q
 X:$D(CLEOP) CLEOP Q
 ;
HELP3 ;demographic help (from input transform)
 N QLINE
 S QLINE=20 X:$D(CLEOP1) CLEOP1 W !,"Do you want to see extended help" S %=2 D YN^DICN S QLINE=4 X:$D(CLEOP1) CLEOP1 G:%'=1 HELP3Q I $D(DUOUT)!($D(DTOUT)) S QAPOUT=1 Q
 W !,"Demographic data  items are  optional.  You may  wish to  include them in",!
 W "order to identify the survey participant or group, or to sort on specific",!
 W "demographic items.  Note that  while including demographic  data items in",!
 W "your survey is up  to you, you may also make them  mandatory entry fields",!
 W "for your survey participants.",!!
 W "First you  must enter the text for your  demographic data item  as it should",!
 W "be displayed on the survey.  Then you will be asked what TYPE of demographic",!
 W "it is.  They  may be pointers  to existing  DHCP files, sets of  codes, free",!
 W "text, or dates.",!!,"Press RETURN  " R ANS:DTIME I '$T S DTOUT=1 Q
HELP3Q S QLINE=3 X:$D(CLEOP1) CLEOP1
 Q
 ;
HELP4 ;password help
 W !!,"You may password-protect your survey  from unauthorized participants.",!
 W "Using the password is optional and if you decide to use one and enter",!
 W "it here, you will have to communicate it to all participants.",!
 Q
 ;
DEMLST ;print demographics on hard copies - from QAPPT0
 S QAPOUT=0 Q:$O(^QA(748,SURVEY,1,0))=""  ;none to print
 S QAPCOL=0 F DEMDA=0:0 S DEMDA=$O(^QA(748,SURVEY,1,DEMDA)) Q:DEMDA=""!(+DEMDA=0)!(QAPOUT=1)  DO  I QAPOUT=1 S DEMDA="9999"
 .S DEMVAL=$P(^QA(748,SURVEY,1,DEMDA,0),U),DEMTYPE=$P(^QA(748,SURVEY,1,DEMDA,0),U,2)
 .W ?(QAPCOL),DEMVAL_":  " D:'$D(USERPRT)&(DEMTYPE="s") DEMSHOW Q:QAPOUT=1  D:$D(USERPRT)  S QAPCOL=QAPCOL+40 I QAPCOL>50 S QAPCOL=0  W !! X:$D(TOF) TOF Q:QAPOUT=1
 ..S DEML=$O(^QA(748.3,FILEDA,2,"B",DEMDA,0)) Q:DEML=""  ;no type/demog 
 ..S DEMVAL=$P(^QA(748.3,FILEDA,2,DEML,0),U,2)
 ..I DEMTYPE="d" S Y=DEMVAL X ^DD("DD") S DEMVAL=Y
 ..W $E(DEMVAL,1,30)
 Q:QAPOUT=1  X:$D(TOF) TOF Q:QAPOUT=1  W !!! K QAPCOL,DEMDA X:$D(TOF) TOF
 Q
 ;
HELPDIS W !,"Enter  a number between  1 and 99999.  You may  use decimals to two",!
 W "places if you wish.  If there is a previous value in this field you",!
 W "may press RETURN to skip it if you do not wish to change it.",!!
 Q
 ;
TRAP ;suspend and reset during participation for QAPSCRN
 LOCK
 W !!,*7,"An error has been encountered during your information entry.",!,"Please contact your local IRM for assistance.",!!
 W "Your answers entered so far will be saved and your entry given a",!
 W """SUSPENDED"" status.  You may resume after the error has been",!,"resolved.",!!,"Press RETURN  " R ANS:DTIME ;if timeout continue to suspend 
 S:'$D(QAPCNT) QAPCNT=0 S:'$D(CQUES) CQUES=0 S:'$D(FILEDA) FILEDA=IFN
 S (DIC,DIE)="^QA(748.3,",DA=FILEDA,DR="3////s;4////"_QAPCNT_";5////"_CQUES D ^DIE W !!,"Survey suspended, see you later." H 2
 D ^%ZISC I '$D(ZTSK),IOST?1"C-VT100"!(IOST?1"C-VT320") S IOTM=1,IOBM=24 W @TOPBOT,@IOF,!
 S X="ERR^ZU",@^%ZOSF("TRAP") ;reset to Kernel error trap
 G ERR^ZU ;exit via Kernel
 ;
KANS ;kill unneeded answers
 S NDA=DA,NDA1=DA(1) N DA,ANS,X,Y,DIC,DIE
 S DA(2)=NDA1,DA(1)=NDA,ANS=""
 F  S ANS=$O(^QA(748.25,DA(2),1,DA(1),3,"B",ANS)) Q:ANS=""  F DA=0:0 S DA=$O(^QA(748.25,DA(2),1,DA(1),3,"B",ANS,DA)) Q:DA=""  S DIK="^QA(748.25,DA(2),1,DA(1),3," D ^DIK
 K DA,NDA,NDA1 Q
 ;
DEMSHOW F DAX=0:0 S DAX=$O(^QA(748,SURVEY,1,DEMDA,1,DAX)) Q:DAX=""!(+DAX=0)  S QDTA=^QA(748,SURVEY,1,DEMDA,1,DAX,0),CODE=$P(QDTA,U,1),MEANING=$P(QDTA,U,2) W ?(QAPCOL),CODE," - ",MEANING,!?(QAPCOL)+$L(DEMVAL)+3 X:$D(TOF) TOF S:QAPOUT=1 DAX=999
 Q
