DGABUL ;ALB/MRL/MJK - TRANSMIT OVERDUE ABSENCE BULLETIN; 23 OCT 1990
 ;;5.3;Registration;**418**;Aug 13, 1993
EN ;
 Q:'$D(DUZ)#2
 S U="^",Y=$S($D(^DG(43,1,"CON")):$P(^("CON"),"^",7),1:"") X:Y]"" ^DD("DD")
 W !! I Y]"" W "OVERDUE ABSENCE SEARCH WAS LAST RUN ",Y,!
 ;
EN1 W "TRANSMIT OVERDUE ABSENCE BULLETIN" S %=2 D YN^DICN
 I '% W !!?4,"Y - To search for inpatients overdue from AA, UA and PASS and transmit",!?9,"bulletin to select mailgroup.",!?4,"N - If you don't wish to search for overdue absences.",! G EN1
 D QUE:%=1,Q Q
 ;
ST ;
 N DGW K ^UTILITY($J) D H^DGUTL
 S X1=DGTIME,X2=-4 D C^%DTC S DGDAY4=X
 S X1=DGTIME,X2=-14 D C^%DTC S DGDAY14=X
 S X1=DGTIME,X2=-30 D C^%DTC S DGDAY30=X
 S DGT=DGTIME,DGW="",$P(^DG(43,1,"CON"),"^",7)=DGTIME
 ;
 ; -- overdues
 F I=0:0 S DGW=$O(^DPT("CN",DGW)) Q:DGW=""  F DFN=0:0 S DFN=$O(^DPT("CN",DGW,DFN)) Q:'DFN  D ^DGINPW I DG1,DGA1 F %=0:0 S %=$O(^DGPM("APMV",DFN,DGA1,%)) Q:'%  I %,$D(^DGPM(+$O(^(%,0)),0)) S DGD=^(0) I $P(DGD,U,2)=2 D 1:DGDAY4>DGD Q
 G Q:'$D(^UTILITY($J,"DGOVER"))
 ;
 ; -- re-sort util for bulletin
 S DGW="",C=0
 F I=0:0 S DGW=$O(^UTILITY($J,"DGOVER",DGW)) Q:DGW=""  S DGNAME="" F J=0:0 S DGNAME=$O(^UTILITY($J,"DGOVER",DGW,DGNAME)) Q:DGNAME=""  S C=C+1,^UTILITY($J,"DGOV",C,0)=^UTILITY($J,"DGOVER",DGW,DGNAME)
 K ^UTILITY($J,"DGOVER")
 D BULL
 ;
Q ; -- clean up
 K ^UTILITY($J),DFN,DG1,DGA1,DGD,DGD1,DGD2,DGDAY4,DGDAY14,DGDAY30,DGT,DGTIME,DGDATE,I,I1,J,J1,X,X1,X2,Y,DGXFR0,DGPMX D KILL^DGPATV
 D CLOSE^DGUTQ S IOP="HOME" D ^%ZIS K IOP Q
 ;
1 ; -- process xfr
 S DGD1=+DGD,DGD2=+$P(DGD,U,18)
 I "^1^2^3^"'[("^"_DGD2_"^") G Q1
 S DGD1=+DGD
 I DGD2=1 D:DGD1<DGDAY4 S G Q1
 I DGD2=2,"^NH^D^"[("^"_$P(^DIC(42,+DG1,0),"^",3)_"^")!($P(^DIC(42,+DG1,0),"^",17)=1) D:DGD1<DGDAY30 S G Q1 ;p-418
 I DGD2=2 D:DGD1<DGDAY14 S G Q1
 I DGD2=3 D:DGD1<DGDAY30 S
Q1 Q
 ;
S ; -- set util w/pt data for bull
 D ^DGPATV S Y=DGD1 X ^DD("DD") S X=$E(DGW,1,10),X1="",$P(X1," ",30)="",X=$E(X_X1,1,15),X2=$E(DGNAME,1,25)_"  ("_$E($P(SSN,"^",1),6,10)_")"_X1,X=X_$E(X2,1,30)
 S X2=$S(DGD2=1:"PASS",DGD2=2:"AA",1:"UA")_" since "_Y,X=X_X2,^UTILITY($J,"DGOVER",DGW,DGNAME)=X K X,X1,X2 Q
 ;
BULL ; -- send bulletin
 G BULLQ:'$D(^UTILITY($J,"DGOV"))
 S Y=DGTIME X ^DD("DD") S XMSUB="OVERDUE ABSENCES AS OF "_Y,XMTEXT="^UTILITY($J,""DGOV"",",DGB=8 D ^DGBUL
BULLQ Q
 ;
QUE ; -- que search
 S DGPGM="ST^DGABUL",DGVAR="DUZ^ION",ION="",X="NOW" D Q1^DGUTQ
 W "  ...BACKGROUND SEARCH QUEUED!!"
 Q
