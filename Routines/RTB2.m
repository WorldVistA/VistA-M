RTB2 ;MJK/TROY ISC;Help for Variable Pointer Fields; ; 5/27/87  1:44 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
HELP S IOP="" D ^%ZIS K IOP W @IOF
 ;W !,"Enter a '"_$P(^DIC(195.1,RTA,0),"^")_"' record associated with one of the following:"
 W !!?5,"Filename",?40,"Message",?50,"Prefix" K L S $P(L,"=",60)="" W !?5,L K L
 F RTI=0:0 S RTI=$O(^DD(190,.01,"V","O",RTI)) Q:'RTI  I $D(^DD(190,.01,"V",+$O(^(RTI,0)),0)) S Y=^(0) I $D(^DIC(195.1,RTA,"ENTITY","B",+Y)) D LIST
 S T="TEXT" D HELPFF^RTB1 G Q:X="^" W ! S RTRD(1)="Yes^list entries in the file",RTRD(2)="No^do not list entries in the file",RTRD(0)="S",RTRD("B")=2
 F RTI=0:0 S RTI=$O(^DD(190,.01,"V","O",RTI)) Q:'RTI  S RTI1=+$O(^(RTI,0)) I $D(^DD(190,.01,"V",RTI1,0)) S RT0=^(0) I $D(^DIC(195.1,RTA,"ENTITY","B",+RT0)) D LIST1 G Q:X["^"
Q W ! K RT0,RTI1,V,S,RTRD,RTI S X="",Y=-1 Q
 ;
LIST W !?5,$P(^DIC(+Y,0),"^"),?40,$P(Y,"^",2),?50,$P(Y,"^",4) S $P(L,"-",60)="" W:$X'=0 ! W ?5,L K I,L Q
 ;
LIST1 S RTRD("A")="Do you want to list the '"_$P(RT0,"^",2)_"' entries? " D SET^RTRD Q:$E(X)'="Y"
 K DIC S DIC(0)="IE",X="??",DIC=^DIC(+RT0,0,"GL") S:$D(^DD(190,.01,"V",RTI1,1)) DIC("S")=^(1) D ^DIC K DIC Q
 ;
TOP W !!,*7,"Press RETURN to continue or '^' to stop: " R X:DTIME S:'$T X="^" W:X'["^" @IOF Q
 ;
ENTITY G Q:'RTA G HELP S T="ENTHLP" D HELP^RTB1 I $D(RTDC(0)),RTDC(0)["M" S T="BOR" D HELP^RTB1
 D ASK I X="^" S X="" G Q
 I $E(X)="Y" S DIC(0)="IEQ",X="??",DIC="^RT(",DIC("S")=$S($D(RTDC("S")):RTDC("S"),1:"I $P(^(0),U,4)=RTA") D ^DIC K DIC
 K RT D MORE G Q:$E(X)'="Y",HELP
 ;
MORE S RTRD(1)="Yes^display more help",RTRD(2)="No^do not display more help",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Do you want to see more 'help' information? " D SET^RTRD K RTRD Q
 ;
RTA S RTA=$S($D(^DIC(195.2,RTA,0)):$P(^(0),"^",3),1:"") Q
 ;
SPACE K RTHIT S Y=-1 I @("'$D(^"_$P(X,";",2)_+X_",0))") K X Q
 F O=0:0 S O=$O(^DD(190,.01,"V","O",O)) Q:'O  S Y1=+$O(^(O,0)) I $D(^DD(190,.01,"V",Y1,0)) S Y2=+^(0) I $E(^DIC(Y2,0,"GL"),2,99)=$P(X,";",2),$D(^DIC(195.1,+RTA,"ENTITY","B",Y2)) D SPACE1
 S:'$D(RTHIT) RTHIT=0 I RTHIT S Y=X D NAME^RTB W "  ",Y
 S Y=$S('RTHIT:-1,1:+X) S:Y<0 X="" K RTHIT,Y1,S Q
 ;
SPACE1 S S=$S($D(^DD(190,.01,"V",Y1,1)):^(1),1:"I 1") I @("$D(^"_$P(X,";",2)_+X_",0))") S Y=+X X S S RTHIT=$T
 Q
 ;
ASK S RTRD(1)="Yes^list existing entries",RTRD(2)="No^do not list entries",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Do you want to list existing entries? " D SET^RTRD K RTRD Q
