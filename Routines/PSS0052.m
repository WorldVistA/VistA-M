PSS0052 ;BIR/JLC-POPULATE FIRST SERVICE DATE ;01/14/2002
 ;;1.0;PHARMACY DATA MANAGEMENT;**52,125**;9/30/97;Build 2
 ;
 ;Reference to ^PSRX is supported by DBIA 3500.
 ;
 Q
EN I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 K ZTSAVE,ZTSK S ZTRTN="ENQN^PSS0052",ZTDESC="Build FIRST PHARMACY SERVICE Info (PDM)",ZTIO="" D ^%ZTLOAD
 W !!,"The build of first pharmacy service info is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
ENQN S DFN=0
 F  S DFN=$O(^PS(55,DFN)) Q:'DFN  K A D
 . L ^PS(55,DFN):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 . S PSJORD=0 F  S PSJORD=$O(^PS(55,DFN,5,PSJORD)) Q:'PSJORD  S LOG=$P($G(^PS(55,DFN,5,PSJORD,0)),"^",16) I LOG]"" S A(LOG)="" Q
 . S PSJORD=0 F  S PSJORD=$O(^PS(55,DFN,"IV",PSJORD)) Q:'PSJORD  S LOG=$P($G(^PS(55,DFN,"IV",PSJORD,2)),"^") I LOG]"" S A(LOG)="" Q
 . S ARC=$O(^PS(55,DFN,"ARC",0)) I ARC S A(ARC)=""
 . S X=$O(^PS(55,DFN,"P",0)) I X S RX=$G(^(X,0)) I RX]"" S LOG=$P($G(^PSRX(RX,2)),"^") I LOG]"" S A(LOG)=""
 . S LOG=$O(A("")) I LOG S A=$G(^PS(55,DFN,0)) I $P(A,"^",7)=""!($P(A,"^",7)>LOG) S $P(A,"^",7)=$P(LOG,"."),$P(A,"^",8)="H",^PS(55,DFN,0)=A
 . L
SENDMSG ;Send mail message when check is complete.
 K PSG,XMY S XMDUZ="MANAGEMENT,PHARMACY DATA",XMSUB="BUILD OF FIRST PHARMACY SERVICE INFO COMPLETE",XMTEXT="PSS(",XMY(DUZ)="",XMY("G.PSU PBM@"_$G(^XMB("NETNAME")))="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSS(1,0)="  The build of first pharmacy service information",PSS(2,0)="completed as of "_Y_"."
 D ^XMD Q
