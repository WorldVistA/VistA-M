RTUTL5 ;TROY ISC/MJK-Re-Compile Templates  DONT MAP; ; 4/13/87  3:22 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 ; ******* DO NOT MAP THIS ROUTINE *******
RECOMP ;Entry point to re-compile templates; RTFILE optionally defined
 S U="^" S:'$D(RTFILE) RTFILE="^DIE(" D EQUALS^RTUTL3 W !?20,"Recompilation of '"_$S(RTFILE["DIPT":"OUTPUT",RTFILE["DIE":"INPUT",1:"CROSS-REFERENCES")_$S(RTFILE["DD(":"",1:"' Templates") D EQUALS^RTUTL3
 I RTFILE'["DD(" S RTX="RT " F RTI=1:1 S RTX=$O(@(RTFILE_"""B"",RTX)")) Q:RTX=""!($E(RTX,1,3)'="RT ")  S Y=+$O(^(RTX,0)) I Y>0,$D(@(RTFILE_"+Y,""ROUOLD"")")),^("ROUOLD")]"",$D(^(0)) S (RTEMP,Y)=+Y,X=$P(^("ROUOLD"),"^"),RT0=^(0) D COMP
XX I RTFILE["DD(",$D(@RTFILE) S (RT0,X)=^("DIK"),Y=+$P(RTFILE,"DD(",2) D COMP
 Q
 K RT0,RTX,RTI,RTEMP,RTFILE,RTI Q
 Q  ;
COMP W !,"---- RE-COMPILING THE '",$P(RT0,"^"),"' "_$S(RTFILE["DIPT":"OUTPUT",RTFILE["DIE":"INPUT",1:"CROSS-REFERENCE")_"  TEMPLATES"
 S DMAX=4000 D @($S(RTFILE["DIPT":"EN^DIPZ",RTFILE["DIE":"EN^DIEZ",1:"EN^DIKZ")) I RTFILE'["DD(",$D(@(RTFILE_RTEMP_",""ROU"")")) W !!?3,"...'",$P(RT0,"^"),"' has been re-compiled in the ",^("ROU"),"* routines." D EQUALS^RTUTL3
XZ I RTFILE["DD(",$D(@(RTFILE)) W !!?3,"...'",$P(RT0,"^"),"' has been re-compiled in the ",^("DIK"),"* routines." D EQUALS^RTUTL3
 Q
 ;
BOTH S U="^",RTRD(1)="Yes^re-compile templates",RTRD(2)="No^not re-compile templates",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Are you sure you want to re-compile the record tracking templates? " D SET^RTRD K RTRD Q:$E(X)'="Y"
 S RTFILE="^DIE(" D RECOMP W !!
 S RTFILE="^DIPT(" D RECOMP W !!
XR S RTK="0,"_"""DIK"""_")"
 S RTFILE="^DD(190,"_RTK D RECOMP W !!
 S RTFILE="^DD(190.1,"_RTK D XX W !!
 S RTFILE="^DD(190.3,"_RTK D XX W !!
 S RTFILE="^DD(194.2,"_RTK D XX W !!
 S RTFILE="^DD(195.9,"_RTK D XX W !!
SDB ;
 W !!,"Recompiling the Clinic Setup Template, don't worry"
 S Y=$O(^DIE("B","SDB",0)) Q:'Y  I $D(^DIE(Y,"ROUOLD")) S X=^("ROUOLD") I X="SDBT" S DMAX=4000 D EN^DIEZ
 W "...Done.",!!,"NOTE: Recompilation should be performed on ALL systems."
 K A,C,L,O,X1,DQ,DIE,DMAX,DIEZ,DIEZDUP,DK,DR
 K X,RTX,RTK,RTI,RTFILE,RTEMP,RT0,J
 Q
 ;
FRCHK I '$D(^%ZIS(1,"B",X)) K X Q
 ;naked ref to %ZIS(1,"B",,n) and %ZIS(1,n,"SUBTYPE")
 I '$D(^%ZIS(1,+$O(^(X,0)),0))!('$D(^("SUBTYPE"))) K X Q
 ;naked ref to the %ZIS(1,n,"SUBTYPE")
 I '$D(^%ZIS(2,+^("SUBTYPE"),0)) K X Q
 ;naked ref to %ZIS(2,n,0)
 I $E(^(0))'="C" K X Q
 Q:'$D(^RTV(195.9,"ADEV",X))  S X1=+$O(^(X,0)) Q:D0=X1
 I $D(^RTV(195.9,X1,0)) S X1=^(0) W !?5,*7,"...device is already assigned to ",$S($D(^SC(+X1,0)):$P(^(0),"^"),1:"UNKNOWN"),!?10," of the ",$S($D(^DIC(195.1,+$P(X1,"^",3),0)):$P(^(0),"^"),1:"UNKNOWN")," application." K X,X1
 Q
 ;
HELP ;Executeable Help for INPUT DEVICES multiple in file 195.9
 W !!?3,"Device Name",?45,"Location",!?3,"-----------",?45,"--------"
 S RTC=0,RTI="" F RTI1=0:0 S RTI=$O(^%ZIS(1,"B",RTI)) Q:RTI=""  S RTX=+$O(^(RTI,0)) I $D(^%ZIS(1,RTX,0)),$D(^("SUBTYPE")),$D(^%ZIS(2,+^("SUBTYPE"),0)),$E(^(0))="C" D HELP1 Q:$D(RTESC)
 K RTX,RTI,RTI1,RTC,RTESC Q
HELP1 S RTC=RTC+1 D ESC^RTRD:'(RTC#20) Q:$D(RTESC)
 S RTX=^%ZIS(1,RTX,0) W !?3,$P(RTX,"^"),$S($P(RTX,"^",9)]"":"    ["_$P(RTX,"^",9)_"]",1:"") W:$D(^(1)) ?45,$P(^(1),"^") Q
