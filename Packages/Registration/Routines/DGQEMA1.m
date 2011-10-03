DGQEMA1 ;RWA/SLC-DHW/OKC-ALB/MIR - CONTINUATION OF EMBOSSER AUTO/QUEUE ; NOV 30 90
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;DGHD - 0 for ask, 1 for hold, 2 for print
 ;
EN I 'DGHD,$P(DGX,"^",3)'="" S DGHD=$P(DGX,"^",3)
 I DGHD=1 D HOLD Q  ;hold
 I DGHD D PRINT Q  ;don't hold - queue (DGHD=2)
 ;
 ;falls through if ASK or unanswered
 ;
ASK W !,"Print or Hold ",$P(^DIC(39.1,DGTYP,0),"^",1)," Cards: " R X:DTIME I '$T!(X["^") D NO Q
 S Z="^PRINT^HOLD" D IN^DGHELP I %<0 W !?3,"Enter 'P'rint or 'H'old" G ASK
 I X="P" D PRINT Q
 ;
 ;
HOLD S I=0,AMT=0
 I '$D(^DIC(39.1,DGTYP,"HOLD",0)) S ^DIC(39.1,DGTYP,"HOLD",0)="^39.13P^^"
 F I=0:0 S I=$O(^DIC(39.1,DGTYP,"HOLD",I)) Q:'I  S AMT=I
 S ^DIC(39.1,DGTYP,"HOLD",AMT+1,0)=DFN_"^"_DGQUAN
 F K=1:1:9 S ^DIC(39.1,DGTYP,"HOLD",AMT+1,1,K,0)=$S($D(DGLINE(K)):DGLINE(K),1:"")
 W:'$D(DGCOUNT) !,"Data Card Placed in Hold to be Printed Later!"
 Q
 ;
 ;
PRINT ;queue data card
 S ZTRTN="DGQEMP",ZTSAVE("DGTYP")=S,ZTSAVE("DFN")="",ZTSAVE("DGLINE(")="",ZTSAVE("DGQUAN")="",ZTDESC="Print Data Card"
 ;
QUEUE K DIC I $D(^DIC(39.3,+$P(DGX,"^",2),0)) S DIC("B")=$P(^(0),"^",1)
 S DIC=39.3,DIC(0)="AEQM",DIC("A")="Queue to print "_$P(^DIC(39.1,DGTYP,0),"^",1)_" cards on device: " D ^DIC I Y<0 D NO Q
 D NOW^%DTC S ZTDTH=%
 S ZTIO=$P(Y,"^",2) D ^%ZTLOAD W !,"Data card queued"
 Q
 ;
 ;
EDIT ;Edit free text data card
 W !! F K=1:1:9 I $D(DGLINE(K)) W !?3,K,">  ",DGLINE(K)
YN W !,"Edit Data" S %=2 D YN^DICN I %=2!(%Y["^"),'$D(DTOUT) D NUM^DGQEMA G NO:DGMANFL D EN Q
 I %<0 D NO Q
 I '% W !?3,"Enter 'Y'es to edit the above date, otherwise 'N'o" G YN
 ;
CHOOSE ;choose line to edit
 R !!,"Choose a line (1-9):  ",X:DTIME I '$T D NO Q
 I X["^" G EDIT
 I X<1!(X>9) W !?3,"Enter the numbers of the lines to edit separated by commas (ex. 1,2,3)" G CHOOSE
 ;
 W !!?5,"WARNING:  You must enter the entire line(s) again",!
 F DGLN=1:1 S K=$P(X,",",DGLN) Q:'K  S DGLINE(K)="" D FT Q:DGFL
 I DGFL=2 D NO Q
 G EDIT
 ;
 ;
PEND ;print data cards on hold
 K DIC S DIC("A")="Print Pending Cards for which Card Type:  ",DIC="^DIC(39.1,",DIC(0)="AEQM" D ^DIC K DIC I Y<1 G PENDQ
 S DGTYP=+Y,DGX=^DIC(39.1,DGTYP,0) I '$O(^DIC(39.1,DGTYP,"HOLD",0)) W !!?3,"There are no ",$P(DGX,"^",1)," cards on hold to be printed",! G PEND
 S ZTRTN="BATCH^DGQEMP",ZTSAVE("DGTYP")="",ZTDESC="Print Data Cards on Hold"
 D QUEUE
 G PEND
PENDQ D END^DGQEMA Q
 ;
 ;
NO ;no data card queued
 W !,*7,"Data card NOT queued"
 Q
 ;
 ;
FREE ;Print free text data card
 S DFN="",S=$O(^DIC(39.1,"C",9,0)) I '$D(^DIC(39.1,+S,0)) G FREEQ
 S DGX=^(0),DGTYP=$P(DGX,"^",6) I 'DGTYP G FREEQ
 S DGHD=0
 F K=1:1:9 D FT Q:DGFL
 I DGFL=2 W !,*7,"Data card NOT queued" Q
 D EDIT
FREEQ D END^DGQEMA K DFN,DGMANFL
 Q
 ;
 ;
FT S DGFL=0 W !,"Free Text line ",K,": " R Y:DTIME S:'$T DGFL=2 S:Y="^" DGFL=1 I DGFL Q
 I Y["?" W !,?4,"You may enter a free text comment for this line on the Patient card." G FT
 I $L(Y)>26 W !,?4,"Text must be less than 27 characters." G FT
 I (Y["#")!(Y["@")!(Y["""")!(Y?.E1L.E) W !,?2,"Lower case characters and the following symbols: (#),(@),("") are not allowed." G FT
 S DGLINE(K)=Y
 Q
 ;
 ;
ERROR ;Error messages for incomplete data
 I $S('$D(^DPT(DFN,.36)):1,'^(.36):1,1:0) S DGE=1 S Y="ELIGIBILITY CODE" D ERR
 I S=3 G NV
 I $S('$D(^DPT(DFN,.32)):1,'$P(^(.32),"^",3):1,1:0) S Y="PERIOD OF SERVICE" D ERR
 I $S('$D(^DPT(DFN,.31)):1,$P(^(.31),"^",3)']"":1,1:0) S Y="CLAIM NUMBER" D ERR
NV S X=^DPT(DFN,0) F I=1,2,3,5,8,9 I $P(X,"^",I)="" S Y=$P(^DD(2,".0"_I,0),"^",1) D ERR
 I $D(^DPT(DFN,.11)) S X=^DPT(DFN,.11) F I=1,4,5,6,7 I $P(X,"^",I)="" S Y=$P(^DD(2,".11"_I,0),"^",1) D ERR
 I '$D(^DPT(DFN,.11)) S DGE=1 S Y="ADDRESS DATA" D ERR Q
 Q
ERR W !,Y," MISSING" S DGE=1 Q
