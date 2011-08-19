RTUTL1 ;MJK,PKE/ISC-ALBANY-Utility Routine; ; 4/24/87  9:22 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
MOVE Q:'$D(^RT(RT,"CL"))  S RTM=^("CL"),X1=+RTM,$P(RTM,"^",1,4)=RT_"^^^" I $D(^RTV(190.1,X1,0)) S $P(RTM,"^",2,4)=$P(^(0),"^",2,4)
 S I=+$P(^RTV(190.3,0),"^",3)
LOC S I1=I,I=$O(^RTV(190.3,I)) IF I1+1=I G LOC
 L +^RTV(190.3,I1+1):1 IF '$T!(I1=999)!($D(^(I1+1,0))) L -^RTV(190.3,I1+1) S I=I1+1 S:$L(I)=4 I=9999 G LOC
 S I=I1+1
 S ^RTV(190.3,I,0)=RT,^RTV(190.3,"B",RT,I)="",^(0)=$P(^RTV(190.3,0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1),^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RTV(190.3,")=I L -^RTV(190.3,I1+1)
 S (DA,RTLAST)=I,DIE="^RTV(190.3,",DR="[RT MOVEMENT]" D ^DIE K DE,DQ,RTLAST,RTM,X,X1,I,I1 Q
 ;
ARRAY F I=0:0 S I=$O(RTY(I)) Q:'I  S Y=+RTY(I) D ARRAY1
 K I Q
ARRAY1 I $D(RTDEL),'$D(^TMP($J,"RT","XREF",+Y)) W !?3,*7,"...not on list to be processed" Q
 I $D(RTDEL) K ^TMP($J,"RT","AR",+^(+Y)),^TMP($J,"RT","XREF",+Y) S RTN=RTN-1 W !?3,"...deleted from list to be "_$S($D(Y("M")):Y("M"),1:"processed") K Y Q
 I $D(^TMP($J,"RT","XREF",+Y)) W !?3,*7,"...already selected" K Y Q
 S RTN=RTN+1,^TMP($J,"RT","AR",RTN)=Y,^TMP($J,"RT","XREF",+Y)=RTN W !?3,"...added to list to be "_$S($D(Y("M")):Y("M"),1:"processed") Q
 ;
DEMOS Q:'$D(^RT(RT,0))  S Y=^(0),RTD("V")=$P(Y,"^",7),RTD("T")=$S($D(^DIC(195.2,+$P(Y,"^",3),0)):$P(^(0),"^"),1:"UNKNOWN")_" (V"_+$P(Y,"^",7)_") " S RTD("A")=$S($D(^(0)):$P(^(0),"^",2),1:"UNK"),Y=$P(Y,"^")
DEMOS1 S N=Y D NAME^RTB S RTD("N")=Y
 I $P(N,";",2)="DPT(",$D(^DPT(+N,0)) S Y=^(0),Y1=$P(Y,"^",9),RTD("SSN")=$E(Y1,1,3)_"-"_$E(Y1,4,5)_"-"_$E(Y1,6,10),Y=$P(Y,"^",3) D D^DIQ:Y S RTD("DOB")=Y S:$D(^(.1)) RTD("W")=^(.1) I $D(^(.35)) S Y=+$P(^(.35),".") I Y D D^DIQ S RTD("DOD")=Y
DEMOS2 S Y="" I $D(RT),$D(^RT(+RT,"CL")) S Y=^("CL")
DEMOS3 S Y2=Y,Y1=$S($D(^RTV(195.9,+$P(Y,"^",5),0)):^(0),1:""),RTD("P")=$P(Y1,"^",8),RTD("L")=$P(Y1,"^",9),RTD("P1")=$P(Y1,"^",7),Y=+$E($P(Y,"^",6),1,12) D D^DIQ:Y S RTD("D")=Y,Y=$P(Y1,"^") D NAME^RTB S RTD("B")=Y
 I $D(^RTV(195.9,+$P(Y2,"^",14),0)) S Y=^(0),RTD("PROVP")=$P(Y,"^",8),RTD("PROVL")=$P(Y,"^",9),Y=$P(Y,"^") D NAME^RTB S RTD("PROV")=Y
 K Y,Y1,Y2 Q
 ;
DISP ;Executed by the ^DD(190,0,"ID","WRITE") node
 S RTZ1="Y^RT" D SAVE S RT=+Y D DEMOS W:$X>50 ! W ?50," Type: ",$E(RTD("T"),1,22) W:$D(RTD("SSN")) !,?10,"SSN: ",RTD("SSN") W:$D(RTD("DOD")) "  Deceased: ",RTD("DOD"),"  " W ?42,"Date of Birth: ",RTD("DOB") K RTD
 I $D(^RT(RT,"CL")) S I=^("CL"),RTPH=$S($D(^RTV(195.9,+$P(I,"^",5),0)):$P(^(0),"^",7),1:""),Y=+$P(I,"^",5) D BOR^RTB W !?5,"Location: ",$E(Y,1,22),?45,"Phone/Room: ",RTPH W:Y["MISSING" *7
 D FND:$D(^RTV(190.2,"AM","s",RT)) K Y,RT,RTPH
RESTORE S RTZ="%" F RTZ1=0:0 S RTZ=$O(RTZ(RTZ)) Q:RTZ=""  S @RTZ=RTZ(RTZ)
 K RTZ,RTZ1 Q
 ;
SAVE K RTZ F RTZ2=1:1 S RTZ=$P(RTZ1,"^",RTZ2) Q:RTZ=""  S:$D(@RTZ) RTZ(RTZ)=@RTZ
 K RTZ1,RTZ2 Q
 ;
FND W !?5,"...record was missing but has been found pending supervisor approval" Q
 ;
DISP1 ;Executed by the ^DD(190.1,0,"ID","WRITE") node
 S RTY1=Y W " REC#: ",+^RTV(190.1,+Y,0),"  REQ#: ",Y,"  " S Y=+$P(^RTV(190.1,+Y,0),"^",5),RTD=+$P(^(0),"^",4) D BOR^RTB W !?4,"Requestor: ",Y
 S Y=RTD D D^DIQ W ?44,"Date Needed: ",Y S Y=RTY1 K RTY1,RTD I $D(^RTV(190.1,+Y,0))
 Q
 ;
DPA2 ;Entry point to display identifiers for request from NUM^RTDPA2
 Q:'$D(^RTV(190.1,+Y,0))  S RTQ1=Y D DISP1 S Y=+^RTV(190.1,+Y,0) I $D(^RT(Y,0)) D DISP
 S Y=RTQ1 K RTQ1 D LINE^RTUTL3 I ^RTV(190.1,+Y,0)
 Q
 ;
OVER I '$D(^RT(D0,0))!('$D(^("CL")))!('$D(^DIC(195.2,+$P(^(0),U,3),0))) S X="" Q
 ;naked ref to the 0 node of type of record for a record entry
 S RTT0=^(0),RT0=^RT(D0,0),RTCL=^("CL") D OVER1 K RT0,RTCL,RTT0 Q
 ;
OVER1 I $P(RT0,U,6)=$P(RTCL,U,5) S X="" Q
 S X1=DT,X2=$P(RTCL,U,6) D ^%DTC S X=$S(X'<$P(RTT0,"^",11):X-$P(RTT0,"^",11),1:"") Q
