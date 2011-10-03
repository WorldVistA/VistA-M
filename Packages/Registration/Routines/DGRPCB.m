DGRPCB ;ALB/MRL - CONSISTENCY EDIT BULLETIN ; 29 AUG 88@0932
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ; Fire bulletin of inconsistencies
 ;
EN I '$D(^DGIN(38.5,DFN,0)) Q
 S DGD="0^",DGD1=^DGIN(38.5,DFN,0),DGDAY=$P(DGD1,"^",6) I DGDAY]"" S X1=DT,X2=DGDAY D ^%DTC S DGD=+X,Y=DGDAY X ^DD("DD") S $P(DGD,"^",2)=Y
 I +DGD!($P(DGD1,"^",6)=DT) W !!,"Last notification message was sent '",$P(DGD,"^",2),"'  [",$S($P(DGD1,"^",6)=DT:"TODAY",1:+DGD_" - Day"_$S(+DGD=1:"",1:"s")_" ago"),"]"
 I $S($P(DGD1,"^",6)=DT:1,+DGD'>6&(+DGD):1,1:0),'DGCT2 W !!,"No new message sent since it's been less than 7 days since last message",!,"and no new inconsistencies were found..." Q
 W !! I 'DGD,'$P(DGD1,"^",6) W "Initial notification"
 E  W $S('DGCT2:"Reminder",1:"Updated")
 W " message sent..." I +DGCT2 W $S(+DGCT2:"'"_+DGCT2_"'",1:"No")," new inconsistenc",$S(+DGCT2=1:"y",1:"ies")," found..."
 S XMSUB="INCONSISTENCY EDIT" F I=1:1 S J=$P($T(T+I),";;",2) Q:J="QUIT"  S DGTEXT(I,0)=J,DGC=I
 D ^DGPATV S DGC=DGC+1,DGTEXT(DGC,0)="",DGC=DGC+1,DGTEXT(DGC,0)="PATIENT NAME:  "_DGNAME_"      SSN:  "_$P(SSN,"^",2),DGC=DGC+1,DGTEXT(DGC,0)=""
 S DGC=DGC+1,DGTEXT(DGC,0)="NOTIFICATION STATUS:  "_$S('+DGD:"THIS IS THE FIRST NOTIFICATION MESSAGE.",1:"INITIALLY NOTIFIED '"_$P(DGD,"^",2)_" ["_+DGD_" - DAY"_$S(+DGD=1:"",1:"S")_" AGO]"),$P(^DGIN(38.5,DFN,0),"^",6)=DT
 S Y=$P(DGD1,"^",2) X:Y]"" ^DD("DD") S Y=$S(Y]"":Y,1:"UNKNOWN DATE"),DGC=DGC+1,DGTEXT(DGC,0)="",DGC=DGC+1,DGTEXT(DGC,0)="INITIALLY IDENTIFIED BY:  '"_$S($D(^VA(200,+$P(DGD1,"^",3),0)):$P(^(0),"^",1),1:"UNKNOWN")_"' ON '"_Y_"'."
 S DGC=DGC+1,DGTEXT(DGC,0)="" F I=1:1 S J=$P(DGER,",",I) Q:J=""  I $D(^DGIN(38.6,J,0)) S DGC=DGC+1,DGTEXT(DGC,0)=$E(J_"  ",1,3)_"- "_$P(^(0),"^",2)_$S(DGKEY(+$E(DGEDIT,J)):"*",1:"")
KILL S DGB=6 D ^DGBUL,KILL^DGPATV K DGB,DGC,DGD,DGD1,DGDAY,DGEDIT,I,J,X,X1,X2 Q
T ;
 ;;The following inconsistencies remain on file for the below named patient.
 ;;Those inconsistencies followed with a asterisk [*] are verified and editable by
 ;;only those users who hold the "DG ELIGIBILITY" security key.  I may not be a
 ;;holder of this key and therefore may have not been able to update these data
 ;;elements.  Please use the 'Edit Inconsistent Data' option to clear up these
 ;;remaining inconsistencies asap.  Thank you.
 ;;QUIT
