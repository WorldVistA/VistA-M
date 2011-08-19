PSXCH ;BIR/WPB-Routine to Change CMOP RX Suspense Dates ; [ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 ;variable XOK is set based on the value of the CMOP indicator
 ;and directs processing in the PSOSUCHG routine so that the CMOP
 ;rxs are processed properly.
P ;
 S PSXC=$P($G(^PS(52.5,SFN,0)),U,7),XOK=0
 I "QP"[PSXC S XOK=1 G RTN^PSOSUCHG
 I "LRX"[PSXC S MESS=$S(PSXC="L":"Rx is being transmitted to the CMOP and CAN NOT be edited.",(PSXC="X")!(PSXC="R"):"Rx has been transmitted to the CMOP and CAN NOT be edited.",1:0) W !,MESS
 I XOK=0 K X,Y,RXDATE,RXREC G:ACT="A" ALL^PSOSUCHG D:ACT="S" SPEC^PSOSUCHG
 Q
AC ;
 K:"XRL"[PSXC ^PS(52.5,"AC",$P(^PS(52.5,SFN,0),"^",3),$P(^PS(52.5,SFN,0),"^",2),SFN)
 Q
X ;
 S DA=SFN
 ;following hard kills kill off the old xref
 I PSXC="P" K ^PS(52.5,"AP",OLD,$P(^PS(52.5,DA,0),U,3),DA)
 I PSXC="Q" K ^PS(52.5,"AQ",OLD,$P(^PS(52.5,DA,0),U,3),DA)
 ;I PSXC="R" K ^PS(52.5,"AR",OLD,$P(^PS(52.5,DA,0),U,3),DA)
 S DA=SFN,DIK(1)="3^AP^AQ^AG",DIK="^PS(52.5," D EN^DIK K DIK,DA,DIK(1)
 I $G(PSXC)'="" K ^PS(52.5,"AC",$P(^PS(52.5,SFN,0),U,3),$P(^PS(52.5,SFN,0),U,2),SFN),PSXC,DA,XOK,SFN,MESS,OLD
 Q
A ;
 S PSXC=$P($G(^PS(52.5,SFN,0)),U,7),XOK=0
 S:PSXC="" XOK=2
 S:(PSXC'="")&("QP"[PSXC) XOK=1
 D:XOK'=0 AC
 Q
