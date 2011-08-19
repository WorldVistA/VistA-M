RTP41 ;MJK/TROY ISC;Charge Out Pull List (continued); ; 4/24/87  11:55 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 ;
LIST W !!!,$S(RTLIST="RTCANCEL":"Cancelled Requests",1:"Missing Records")," List" D NOW^%DTC S Y=$E(%,1,12) D D^DIQ W ?55,"RUN DATE: ",Y
 W !!,"PULL LIST",?25,"REQUEST#",?35,"REQUESTED TIME",?60,"RECORD INFORMATION" D EQUALS^RTUTL3
 S RTPX="" F RTPX1=0:0 S RTPX=$O(^TMP($J,RTLIST,RTPX)) Q:RTPX=""  F RTQ=0:0 S RTQ=$O(^TMP($J,RTLIST,RTPX,RTQ)) Q:'RTQ  S RTQ0=^(RTQ) D WRITE
 K RTPX,RTPX1,RTQ,RTQ0 Q
 ;
WRITE S RT=+RTQ0 Q:'$D(^RT(+RT,0))  S RT0=^(0),RTYPE=$S($D(^DIC(195.2,+$P(RT0,"^",3),0)):$P(^(0),"^",2),1:"???")_+$P(RT0,"^",7),Y=+$P(RTQ0,"^",4) D D^DIQ S RTQDT=Y,Y=$P(RT0,"^") D NAME^RTB S RTNME=Y
 S RTSSN="" I $P(RT0,"^")[";DPT(",$D(^DPT(+RT0,0)) S X=$P(^(0),"^",9),RTSSN=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10)
 W !?2,$E(RTPX,1,20),?25,RTQ,?35,RTQDT,?60,RTYPE,?65,$E(RTNME,1,15),!,?60,RT,?65,RTSSN D LINE^RTUTL3
 K RT,RT0,RTNME,RTQDT,RTYPE Q
 ;
SHOW ;
 W !!,"The following CLINIC pull lists will be ",RTMES,": " S RTEND=RTDT_".9999",RTC=0
 F D=(RTDT-.0001):0 S D=$O(^RTV(194.2,"C",D)) Q:'D!(D>RTEND)  F P=0:0 S P=$O(^RTV(194.2,"C",D,P)) Q:'P  I $D(^RTV(194.2,P,0)) S X=^(0) I $P(X,"^",10)=1,$P(X,"^",15)=+RTAPL,$P(X,"^",6)'="x",$P(X,"^",12) S RTC=RTC+1 D SHOW1
 I 'RTC W !?5,*7,"No CLINIC pull lists need to be ",RTMES,"."
 K RTEND,P,D Q
 ;
SHOW1 S SAVX=X I RTC#10=0 S DIR(0)="E" D ^DIR I X="^" S D=9999999 Q
 S X=SAVX W !?5,RTC,".  ",$E($P($P(X,"^"),"["),1,25),?35," Status: " S C=$P(^DD(194.2,6,0),"^",2),Y=$P(X,"^",6) D Y^DIQ W Y Q
 ;
BOR ;ask record retirement borrower
 ;return rtb, rtyes, rtaccn
 S A=+RTAPL,DIC("B")=$S($D(^DIC(195.1,+RTAPL,4)):$P(^(4),"^",4),1:"")
 D DIC^RTDPA31 S DIC="^RTV(195.9,",DIC("A")="Select Record Retirement Borrower: ",DIC(0)="IAEMQ",DIC("S")="S Z0=^(0),Z=$P($P(Z0,U),"";"",2) I Z=""DIC(4,"",$P(Z0,U,3)="_+RTAPL_" D DICS1^RTDPA31" W ! D ^DIC Q:Y<0  S RTB=+Y
 ;
 W ! S DIR(0)="YO",DIR("B")="Yes" D H13 S DIR("A")="Do you want to create "_$S($T:"'"_Y_"'",1:"Perpetual")_" records from Pull list",DIR("?")="^D H1^RTP41",DIR("??")="^D H12^RTP41" D ^DIR K DIR S RTYES=Y
 Q:'RTYES
 I RTYES D H13 I '$T D H14 H 3 S RTYES="^"
 ;
 W ! S DIR(0)="FO^3:20",DIR("A")="Enter the Record Center's accession number for these records",DIR("?")="^D H4^RTP41",DIR("??")="^D H42^RTP41" D ^DIR K DIR S RTACCN=Y
 Q
 ;
H1 W !!?5,"Answer 'Yes' to create the default perpetual record."
 W !?5,"Answer 'No' to just charge out the retirement pull list." Q
H12 W !!?5,"After the Pull list(s) are charged out, a perpetual record"
 W !?5,"can be created for each patient on the Pull list."
 D H13 I $T W !?5,"'",Y,"' records and labels will be created" Q
H14 W !?5,"The application default perpetual record is NOT defined."
 W !?14,"NO records will be created" Q
H13 I $D(^DIC(195.1,+RTAPL,4)),$P(^(4),"^",5) S Y=$P(^(4),"^",5),C=$P(^DD(195.1,45,0),"^",2) D Y^DIQ IF 1
 Q
H4 W !!?5,"The accession number will be recorded in the content descriptor"
 W !?5,"field of the perpetual records created from these pull lists." Q
H42 W !!?5,"Enter the accession number as provided by the Record Center."
 W !?20,"from 3-20 characters"
 W !!?5,"The accession numbers will be used in the future to locate"
 W !?5,"records transfered to the Record Center." Q
