RMPOPAT1 ;HINES CIO/RVD-DISPLAY PATIENT INFO READ ONLY ;9/16/02  11:13
 ;;3.0;PROSTHETICS;**70,72**;Feb 09, 1996
 ;RVD 7/5/02 patch #70 - This routine is a copy of RMPRPAT1.
 ;                       
 ;DBIA # 801 - for this routine, the agreement covers the field
 ;             #.05 Short Description, FILE #441.
 ;DBIA # 10060 - Fileman read of file #200.
 ;
 W @IOF S PAGE=2
 K VADM S DFN=RMPRDFN N VAHOW D DEM^VADPT
 K VAEL S DFN=RMPRDFN N VAHOW D ELIG^VADPT
 K R5 S %X="^RMPR(665,"_RMPRDFN_",",%Y="R5(" D %XY^%RCR K %X,%Y S DFN=RMPRDFN
 I $G(^RMPR(664,+$O(^RMPR(664,"C",RMPRDFN,0)),"RMPO"))="Y" W !,"<<<HOME OXYGEN PATIENT>>>>"
 W !,$E(RMPRNAM,1,20),?23,"SSN: ",$P(VADM(2),U,2)
 W ?42,"DOB: ",$P(VADM(3),U,2)
 W ?61,"CLAIM# ",VAEL(7)
 I '$D(R5(10)) S R5(10)=""
 W !!,"PSC Issue Card: ",?17,"Appliance",?30,"Ht ",$P(R5(10),U,1),?37,"Wt ",$P(R5(10),U,2),?45,"Eyes ",$P(R5(10),U,3),?54,"Hair ",$P(R5(10),U,4),?66,"Serial Number" S J=0
 F  S J=$O(R5(5,J)) Q:J'>0  W ! S Y=$P(R5(5,J,0),U,1) I $P(R5(5,J,0),U,4) D
 .D DD^%DT W Y,?17,$S($P(R5(5,J,0),U,2)]"":$E($P(R5(5,J,0),U,2),1,47),1:$E($P(^PRC(441,$P(^RMPR(661,$P(R5(5,J,0),U,4),0),U,1),0),U,2),1,47)),?66,$E($P(R5(5,J,0),U,3),1,12)
 S R0=$P(R5(0),U,8) W !!,"Clothing Allowance: "
 I $D(R5(6)),$O(R5(6,0))>0 F RI=0:0 S RI=$O(^RMPR(665,RMPRDFN,6,"B",RI)) Q:RI'>0  S RA=$O(^RMPR(665,RMPRDFN,6,"B",RI,0)),RR5=R5(6,RA,0),RR5=RR5 D
 .W ?22,"Date: ",$E(RR5,4,5)_"-"_$E(RR5,6,7)_"-"_$E(RR5,2,3),"  ",$S($P(RR5,U,2)["E":"ELIGIBLE",$P(RR5,U,2)["N":"NOT-ELIGIBLE",1:"UNKNOWN"),"  ",$S($P(RR5,U,3)["S":"STATIC",$P(RR5,U,3)["N":"NON-STATIC",1:"UNKNOWN")
 .I $P(RR5,U,5) S Y=$P(RR5,U,5) D DD^%DT W !,?22,"Date of Exam: ",Y W:$P(RR5,U,6) " Examiner: ",$E($$GET1^DIQ(200,$P(RR5,U,6),.01),1,30)
 .W !,?22,"Desc: "
 .W $S($D(R5(6,RA,1)):$P(R5(6,RA,1),U),1:""),!
 I '$D(R5(6)) W "NONE LISTED",!
 S RO="" F  S RO=$O(^RMPR(667,"C",RMPRDFN,RO)) Q:RO=""  D
 .Q:$P(^RMPR(667,RO,2),U,1)=0
 .W:'$D(RMPRFLG) !,"Automobile(s)",?16,"Make",?29,"Model",?43,"Vehicle ID#",?62,"Date Processed"
 .W:$P(^RMPR(667,RO,0),U,6)'="" !?16,$E($P(^RMPR(667.2,$P(^RMPR(667,RO,0),U,6),0),U,1),1,11),?29,$E($P(^RMPR(667,RO,0),U,7),1,10),?43,$P(^RMPR(667,RO,0),U,1) S Y=$P(^RMPR(667,RO,0),U,8) D DD^%DT W ?64,Y S RMPRFLG=1
 K KILL,RMPRFLG
 W !!,"Items Returned: ",?16,"Date",?29,"Item",?56
 W "Serial",?68,"Status"
 D:$D(^RMPR(665,RMPRDFN,7,0)) OLD
 I $D(^RMPR(660.1,"C",RMPRDFN)),'$D(KILL) S RO=0 F I=1:1 S RO=$O(^RMPR(660.1,"C",RMPRDFN,RO)) Q:RO=""!($D(KILL))  D WRIL
 W ! K I,J,L,R0
 N DIR S DIR(0)="E" D ^DIR
 S FL=3 G ASK2^RMPOPAT
 ;G ^RMPRPAT0:ANS=1,^RMPRPAT1:ANS=2,^RMPRPAT2:ANS=3,^RMPRPAT2:ANS="",EXIT^RMPRPAT Q
WRIL ;ASK TO SEE MORE RETURNED ITEMS
 I $E(IOST)["C",I=4 S %=2 W !,"Would you like to see more returned items" D YN^DICN I %=-1!(%=2) S KILL=1 Q
 I $E(IOST)["C",I=4,%=0 W !,"Enter `YES` or `NO`" G WRIL
 I $D(^RMPR(660.1,RO)),+$P(^RMPR(660.1,RO,0),U,11) D
 .S Y=$P(^RMPR(660.1,RO,0),U,11)
 .D DD^%DT W !?16,Y
 .W:+$P(^RMPR(660.1,RO,0),U,3) ?29,$E($P(^PRC(441,$P(^RMPR(661,$P(^(0),U,3),0),U),0),U,2),1,20)
 .W:$P(^RMPR(660.1,RO,0),U,21) ?29,$E(^RMPR(667.1,$P(^(0),U,21),0),1,25) W ?56,$E($P(^RMPR(660.1,RO,0),U,6),1,10)
 .W ?68,$S($P(^RMPR(660.1,RO,0),U,14)=1:"RETURNED",$P(^(0),U,14)=2:"CONDEMNED",$P(^(0),U,14)=3:"TURNED-IN",$P(^(0),U,14)=4:"LOST",$P(^(0),U,14)=5:"BROKEN",1:"UNKNOWN")
 Q
OLD ;DISPLAY OLD RETURNED ITEMS
 S RO=0 F I=1:1 S RO=$O(^RMPR(665,RMPRDFN,7,RO)) Q:RO=""!($D(KILL))  D OLD1
 Q
OLD1 I I=4,$E(IOST)["C" S %=2 W !,"Would you like to see more returned items" D YN^DICN I %=-1!(%=2) S KILL=1 Q
 I I=4,$E(IOST)["C",%=0 W !,"Enter `YES` or `NO`" G OLD1
 I $D(^RMPR(665,RMPRDFN,7,RO,0)) S Y=$P(^(0),U) D DD^%DT W !?16,$E(Y,1,12),?29,$E($P(^RMPR(665,RMPRDFN,7,RO,0),U,4),1,20)
RTNSTA ;DISPLAYS STATUS OF TRACKED ITEM ON PATIENT'S 10-2319
 I  S R0=$P(^RMPR(665,RMPRDFN,7,RO,0),U,2) W ?68,$S(R0=1:"RETURNED",R0=2:"CONDENMED",R0=3:"TURNED-IN",R0=4:"LOST",R0=5:"BROKEN",1:"UNKNOWN")
 Q
HELP ;DISPLAY HELP FOR SCREENS
 N RMPR90DP,RMPR90I W !,"Select One of the Following: ",!! S RMPR90DP=$P(DIR(0),U,2,999) F RMPR90I=1:1:7 W !,?5,$P($P(RMPR90DP,";",RMPR90I),":",1),?14,$P($P(RMPR90DP,";",RMPR90I),":",2)
 Q
ASK1 ;SET DIR AND FOR SCREEN NUMBER DISPLAY
 K DIR S DIR("A")="Enter DATA screen to VIEW (Item Transactions or Home Oxygen),'^' to EXIT, or 'return' to continue: "
  N % S DIR(0)="SA^I:ITEM TRANSACTIONS;H:HOME OXYGEN ITEMS;"
 S DIR("?")="Enter a screen (I or H) OR '^' TO EXIT."
 I $D(RFLG) S $P(DIR(0),U,1)="SO" S:$D(DIR("A")) DIR("A")=$P(DIR("A"),":",1)_" " K DIR("?")
 S RFLG=1
 Q
