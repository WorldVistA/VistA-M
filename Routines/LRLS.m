LRLS ;SLC/BA- PREINIT FOR AMIS FILE ;2/5/91  14:48 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
AMIS ;
 S U="^" I '$D(^DD(64,0,"VR")) W !,"No Version node defined in file 64.",!,"Did you run the LRLS init when installing version 5.0" S %=2 D YN^DICN Q:%=1  K:%<1 DIFQ Q:%<1  G GO
 I $D(^DD(64,0,"VR")) S LRV=$P(^DD(64,0,"VR"),U,1) G:LRV<4 GO Q
GO W !,"Since you have not run the LRLS init yet I am now going to clean up",!,"amis data from file 60 (Lab Test) and file 64 (Amis/Cap).",!,"Are you sure you want to proceed" S %=1 D YN^DICN I %=2!(%<1) K DIFQ Q
 S LRTEST=0 F I=0:0 S LRTEST=$O(^LAB(60,LRTEST)) Q:LRTEST<1  K ^(LRTEST,9) S LRSPEC=0 F I=0:0 S LRSPEC=$O(^LAB(60,LRTEST,1,LRSPEC)) Q:LRSPEC<1  K ^(LRSPEC,2)
 K I,LRTEST,LRSPEC
 K ^LAM("B"),^("C") S I=0 F  S I=$O(^LAM(I)) Q:I<1  K ^LAM(I)
 Q
