RTSM8 ;isc-albany/pke-check records for retirement ; 10/1/90 ; 1/7/03 11:51am
 ;;2.0;Record Tracking;**4,14,30,34**;10/22/91
 D ASK^RTSM81 I '$D(RTERM) D Q10 Q
 I RTERM="NO" D GO,Q10 Q
 ; file 194.3 only needed if user chooses to do a terminal digit scan
 I $D(^RTV(194.3,1,0)),($E($P(^(0),"^",3),1,3))'=($E(DT,1,3)) DO  Q
 .W !!,*7,"The RECORD TRACKING SORT GLOBAL file(#194.3) "
 .I '$P(^(0),"^",2),'$P(^(0),"^",3) W "needs to be compiled"
 .;naked ref rtv(194.3,1,0)
 .E  I $E($P(^(0),U,2),1,7)=$E(DT,1,7),'$P(^(0),"^",3) W "is currently being compiled" D Q10 Q
 .E  W "needs additional compiling"
 .D CHKQ^RTSM4,Q10
 ;
 K DIR W !
 ;S DIR("A")="Select a Terminal Digit or range",DIR("B")="1"
 S DIR("A",1)="Select a Terminal Digit or range.  Although a maximum"
 S DIR("A")="of 50 is allowed, we recommend a maximum of 10"
 S DIR("B")="1"
 S DIR("?")="Enter a single terminal digit or a range, maximum 50, "
 S DIR("??")="^D H1^RTSM81"
 S DASH="-",COM=""",""",DAS="""-"""
 S IF="K:X["_COM_" X I $D(X),X["_DAS_",$P(X,DASH,2)-$P(X,DASH,1)>49 K X"
 S DIR(0)="L^0:99"
 S DIR(0)=DIR(0)_"^"_IF
 D ^DIR I $D(DUOUT)!($D(DTOUT)) D Q10 Q
 F I=1:1 Q:'$L($P(Y,",",I))  I $L($P(Y,",",I))=1 S $P(Y,",",I)="0"_$P(Y,",",I)
 S RTERM=Y K X,Y
GO W !!
 S RTDESC="Record Retirement Pull List(s) ["_$P($P(RTAPL,"^"),";",2)_"]",RTVAR="RTDESC^RTERM^RTAPL^RTFR",RTPGM="START^RTSM8" S IOP="HOME" D ^%ZIS K IOP D ZIS^RTUTL
 I POP D Q10 Q
 W !!
START S (RTAA,RTA)=+RTAPL,RTB=+RTFR,RTLAST=$P(^RT(0),"^",3)
 ;check if mas or rad
 S RTDPT=1 I RTA'=+^DIC(195.4,1,"MAS"),RTA'=+^("RAD") S RTDPT=0
 D FLAG^RTSM81
 S (RTCOUNT,RTHIT)=0 S CR=$C(13,10),MOD=100 I $E(IOST,1,2)="C-" S CR=$C(13),MOD=10
 K RTR I RTERM="NO" S RTDPT=0 F RTR=0:0 S RTR=$O(^RT(RTR)) Q:'RTR  I $D(^(RTR,0)) S RTEE=$P(^(0),"^") D RCHECK
 I $D(RTR) D Q10 Q
 ;F RTRM0=1:1 S RTRM=$P(RTERM,",",RTRM0) Q:RTRM=""  S RTTD=$S($D(RTSTART):RTSTART,1:RTRM_"0000000") K RTSTART F RTRM1=0:0 S RTTD=$O(^UTILITY("RTDPTSORT",RTTD)) Q:$E(RTTD,1,2)'=RTRM!(RTTD="")  S DFN=+$O(^(RTTD,0)) I DFN D TDCHECK
 ;
 F RTRM0=1:1 S RTRM=$P(RTERM,",",RTRM0) Q:RTRM=""  DO
 .S RTTD=$S($D(RTSTART):RTSTART,1:RTRM_"0000000") K RTSTART
 .S RTRM1=0
 .FOR  S RTTD=$O(^RTV(194.3,1,1,"AC",RTTD)) Q:$E(RTTD,1,2)'=RTRM!(RTTD="")  DO
 . .S DFN=0
 . .F  S DFN=$O(^RTV(194.3,1,1,"AC",RTTD,DFN)) Q:'DFN  D TDCHECK
 ;
 K RTRM0,RTRM1,RTNME,RTNME0,RTRM,RTTD,DFN,RTFLAG,RTWND D Q10 Q
 ;
TDCHECK S RTEE=DFN_";DPT(" K RTPHIST
RCHECK I $D(^RT("AA",RTAA,RTEE)) F RTT=0:0 S RTT=$O(^RT("AA",RTAA,RTEE,RTT)) Q:'RTT  D REC
 Q
REC I 'RTCOUNT D HDR^RTSM81
 I RTCOUNT#MOD=0 W CR_$J(RTCOUNT,10)_" Records Checked  ",$J(RTHIT,6)," Inactive Records   ",$S(RTERM'="NO":$J(RTRM,5)_"  tdigits",1:$J(RTR,8)_"  rec #")
 S RTCOUNT=RTCOUNT+1
 I RTDPT,$D(RTPHIST(1)) Q
 I $D(^RT("AR","t",RTT)) Q
 I $D(^RT("AR","r",RTT)) Q
 Q:'$D(^RT(RTT,0))  Q:'$D(^("CL"))  S RT0=^(0),RTCL=^("CL")
 Q:$P(RT0,"^",4)'=+RTAPL
 ; type of record, date/time charged, ok to retire
 S RTI=$P(RT0,"^",3) I $S('$D(RTFLAG(RTI)):1,'RTFLAG(RTI):1,1:0) Q
 S RTDT=$P(RTCL,"^",6)
 ;naked ref to ^rt(rtt,i) tag rec+6
 I $D(^("I")),^("I") Q
 ;
 I RTDPT,'$D(RTPHIST) D DPTCHK S RTPHIST($T)="" I $T Q
 ;
 ;only if not mas,rad
 I 'RTDPT,RTDT,RTDT'<RTFLAG(RTI) Q
 ;
 ;creat list by current location, home location, unknown
 S RTP=$P(RTCL,"^",5) I 'RTP S RTP=$P(RT0,"^",6) I 'RTP S (Y,RTP)="LOCATION UNKNOWN" IF 1
 E  S Y=RTP D BOR^RTB I Y="UNKNOWN" S Y="LOCATION"_Y
 S Y="RR "_Y
 ;
 ;
 K RTP
 S RTHIT=RTHIT+1
 S RTB=+RTFR,RT=RTT
 ;have RTTM, Y
 S RTE=RTEE
 S RTPLTY=3,(RTQDT,X)=RTTM,RTPN=$P(Y,"^")_" ["_$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_"]"
 ;
PUL S X=RTB,A=+RTAA K RTA,RTSD,RTDIV D INST1^RTUTL G Q10:'$D(RTINST) S RTDIV=RTINST
 D RTSD
 K RTBKGRD Q
 ;
RTSD K RTPAR S RTB=$P(^RTV(195.9,RTB,0),"^"),RTA=+RTAA D CHK K RTA,RTQ D PULL^RTQ2,CHK1 I '$D(RTPAR),$D(RTQ) S RTPAR=RTQ
 Q
CHK S Y=+$O(^RTV(195.9,"ABOR",RTB,RTA,0)) D SET^RTDPA3:'Y S RTB=Y Q
 ;
CHK1 ;
 ; RT*1*34 - this shortcut uses "AC" xref instead of "C"
 S R=0
 I $D(^RTV(190.1,"AC",RT,RTTM)) F R=0:0 S R=$O(^RTV(190.1,"AC",RT,RTTM,R)) Q:'R  I $D(^RTV(190.1,"ABOR",RTB,R)),$D(^RTV(190.1,R,0)) S Q0=^(0) I $P(Q0,U)=RT,$P(Q0,U,4)=RTTM,$P(Q0,U,5)=RTB,$P(Q0,U,10)=RTPULL Q
 I 'R D SET^RTQ
 ;F R=0:0 S R=$O(^RTV(190.1,"C",RTTM,R)) Q:'R  D INFO I $D(^RTV(190.1,"ABOR",RTB,R)),$D(^RTV(190.1,R,0)) S Q0=^(0) I $P(Q0,"^")=RT,$P(Q0,"^",4)=RTTM,$P(Q0,"^",5)=RTB,$P(Q0,"^",10)=RTPULL Q
 ;I 'R D SET^RTQ
 Q
INFO ;I R#100=0,'$D(ZTSK) W "."
 Q
Q10 K RTLSTM,RADPT,RTLOAD,RTMES1,RTERM,DIC,DIE,DR,DA,DAS,DASH,IF,DIR,COM,J,Z
 K RTCOUNT,RTHIT,RTLAST,R,RT0,RTAA,RTINST,RTPGM,RTVAR,CR,MOD,RTPHIST
 K Q0,RTDPT,RT,RTB,RTCL,RTDT,RTE,RTEE,RTERM,RTERM0,RTI,RTLOAD,RTPAR,RTPLTY,RTPN,RTPULL,RTQ,RTQDT,RTRM,RTRM0,RTT,RTTD,RTTM,RTTMM,RTWND,RTXX D CLOSE^RTUTL
 Q
DPTCHK ;returns $t=1 if dhcp activity
 S RTPHIST=1
FILED I $D(^DPT(DFN,0)),$P(^(0),"^",16)>RTFLAG(RTI) Q
 ;
INPAT I $D(^DPT(DFN,.1)),$P(^(.1),"^")]"" Q
 ;
SC I $O(^DPT(DFN,"S",RTFLAG(RTI))) Q
 ;
SDV ;
 N RTZERR I $$EXAE^SDOE(DFN,RTFLAG(RTI)\1+1,9999999,,"RTZERR") Q  ;Standalone encounter exists
 ;
DIS I $O(^DPT(DFN,"DIS",0)),$O(^(0))<(9999999-RTFLAG(RTI)) Q
 ;
MOV I $O(^DGPM("APID",DFN,0)),$O(^(0))<(9999999-RTFLAG(RTI)) Q
 ;
 S RTPHIST=0
 Q
