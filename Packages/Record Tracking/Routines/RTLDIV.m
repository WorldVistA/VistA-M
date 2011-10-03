RTLDIV ;ISC-ALBANY/pke-look up 40.8 for select label print; 3/1/88 10:38 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 ; returns RTLDIV="^pt^pt^pt^"
 S:'$D(DTIME) DTIME=300
 S N=0 D LIST,ASK G Q
NAM S N=1 D LIST,ASK
Q K N,Z,I,RTS,RTY,RTRD,RTC,RTSEL,X Q
 ;
LIST S Z=0 F I=1:1 S Z=$O(^DG(40.8,"B",Z)) Q:Z=""  S RTS(I)=Z_"^"_$O(^DG(40.8,"B",Z,0))
 I I=1 W !,"No Divisions Defined" G Q
 E  W !,?7,"Selecting...    Choose to Print by "_$S('N:"Terminal Digits for",N:"Name of patient for",1:"")
 S RTS(I)="Patients with no Registration^"
 S J=I F I=1:1:J W !,?10,I,?31,$P(RTS(I),"^")
 Q
ASK S RTRD("S")="",RTSEL="S",RTRD(0)="",(RTCXX,RTC)=J
 S RTRD("A")="Select Medical Center Division(s): "
 D SEL^RTRD
 I X S RTLDIV="^" F Z=0:0 S Z=$O(RTY(Z)) Q:'Z  S RTLDIV=RTLDIV_$P(RTY(Z),"^",2)_"^"
 Q
