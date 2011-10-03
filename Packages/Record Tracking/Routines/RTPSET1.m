RTPSET1 ;MJK/TROY ISC;Sign-on Parameter Routine; ; 5/26/87  4:13 PM ;
 ;;2.0;Record Tracking;**16,46**;10/22/91 ;Build 46
FR ;entry point will return RTFR ; RTAPL must be defined ; RTTY is optional
 I '($D(DUZ)#2) W !!?5,*7,"User's 'DUZ' is not defined." Q
 S %ZIS="L",IOP="HOME" D ^%ZIS K %ZIS,IOP,RTFR S DIC("V")="I $P(Y(0),U,4)=""L"""
 S IONSAV=ION I $D(IO("ZIO")),IO("ZIO")'=IO(0) S ION=IO("ZIO")
 S DIC("S")="S Z0=^(0) I $P(Z0,U,3)="_+RTAPL_",$P(Z0,U,13)=""F"",$D(^SC(+$P(Z0,U,2),0)),$D(^DIC(195.1,"_+RTAPL_",""INST"",+$P(^(0),U,4),0)),$S('$D(RTTY):1,$D(^DIC(195.2,""AF"",Y,+RTTY)):1,1:0) D DICS^RTDPA31"
 I $D(RTSYS),$P(RTSYS,"^",4)="n",$D(^RTV(195.9,"ADEV",ION)) S Y=+$O(^(ION,0)) I $D(^RTV(195.9,Y,0)) X DIC("S") I $T S RTFR=Y_"^"_$P(^RTV(195.9,Y,0),"^",2,99) G FRQ
 ;RT*2.0*46 Requires User to enter a valid file room or "^" to exit
 D:$D(DUZ(2)) DEF
 F  S DIC(0)="IAMEQZ",DIC="^RTV(195.9,",DIC("A")="Select Record Tracking File Room: " D ^DIC S:Y>0 RTFR=+Y_"^"_$P(Y(0),"^",2,99) Q:Y>0!($D(DUOUT))  W !,"Enter a Valid File Room or '^' to Exit",!
 K:$D(DUOUT) RTAPL,RTSYS
FRQ I $D(RTSYS),$P(RTSYS,"^",4)="e",$D(RTFR) S $P(RTFR,"^",4,6)="^^"
 I $D(RTFR),$S('$D(^RTV(195.9,"ADEV",ION)):1,1:+RTFR'=$O(^(ION,0))),$P(RTFR,"^",4,6)'="^^" D ASK S:"N^"[$E(X) $P(RTFR,"^",4,6)="^^"
 S ION=IONSAV K IONSAV,DIC Q
 ;
DEF Q:'$D(^DIC(195.1,+RTAPL,"INST",+DUZ(2),0))  S Y=+$P(^(0),"^",2) I $D(^RTV(195.9,Y,0)),$P(^(0),"^")["SC(",$D(^SC(+^(0),0)) S DIC("B")=$S('+$P(^(0),"^"):$P(^(0),"^"),1:$P(^RTV(195.9,Y,0),"^"))
 Q
 ;
PGM ;Entry point to run a record tracking program for a specific application
 ;     RTAPPL = <application name or synonym>   [ex. MAS]
 ;     RTPGM  = <program to be executed>        [ex. 1^RTQ]
 ;
 S IOP="" D ^%ZIS K IOP I $D(RTAPL) S X=RTAPPL D SAVE,APL^RTPSET D:$D(RTAPL) @RTPGM D RESTORE Q
 S X=RTAPPL D APL^RTPSET D:$D(RTAPL) @RTPGM K RTAPL,RTSYS Q
 ;
MAS ;Entry point to run a RT program for 'MAS' application / RTPGM defined
 S RTAPPL="MAS" D PGM K RTAPPL,RTPGM Q
 ;
RAD ;Entry point to run a RT program for 'FILM TRACKING' application / RTPGM defined
 S RTAPPL="RAD" D PGM K RTAPPL,RTPGM,RTD,J Q
 ;
SAVE K RTNEW F I="RTAPL","RTSYS","RTFR","RTDIV" I $D(@I) S RTNEW(I)=@I
 Q
 ;
RESTORE F I="RTAPL","RTSYS","RTFR","RTDIV" I $D(RTNEW(I)) S @I=RTNEW(I)
 K RTNEW Q
 ;
ASK S RTRD(1)="Yes^use default devices",RTRD(2)="No^do not use default devices",RTRD("B")=1,RTRD("A")="Do you want to use the file room's default devices? ",RTRD(0)="S" D SET^RTRD K RTRD Q
