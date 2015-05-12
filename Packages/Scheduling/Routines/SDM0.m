SDM0 ;SF/GFT - MAKE APPOINTMENT ;11 Jun 2001  5:20 PM
 ;;5.3;Scheduling;**140,167,206,186,223,237,241,384,334,547,621**;Aug 13, 1993;Build 4
 I $D(SDXXX) S SDOK=1 Q
 N SDSRTY,SDDATE,SDSDATE,SDSRFU,SDDMAX,SDONCE
 ;Prompt for scheduling request type
M N SDHX,SDXF,SDXD
 Q:'$$SRTY(.SDSRTY)  S:SDSRTY SDDATE=DT
 ;Calculate appointment follow-up indicator
 S SDSRFU=$$PTFU(DFN,SC)
 ;Determine maximum days for scheduling
 S SDMAX(1)=$P($G(^SC(+SC,"SDP")),U,2) S:'SDMAX(1) SDMAX(1)=365
 S (SDMAX,SDDMAX)=$$FMADD^XLFDT(DT,SDMAX(1))
 ;Prompt for desired date
 Q:'$$DDATE(.SDDATE,SDSRTY,.SDMAX)
 ;If date and time, schedule appt. directly
 W ! I SDDATE#1 S SDSDATE=SDDATE,SDDATE=SDDATE\1 G ^SDM1
 S (X,Y)=SDDATE K SDHX
 ;Find first available after specified date
 I X="F"!(X="f") D SUP,DT1 G NEXT
 ;Find next available appointment
 I SDSRTY,SDDATE D SUP S SDSTRTDT=SDDATE D OVR^SDMULT0 G NEXT
 ;
EN S:$L(X)=1 X=$TR(X,"tnN","TTT") S:X="NOW" X="T" I X?.A!(+X=X),X<13,X'?1"T".E S X=X_" 1"
 D  Q:Y<1
 .N %DT
 .S %DT="T" D ^%DT
 .I Y<1 W !!,"Unable to evaluate date value """_X_""".",!
 .Q
 S:$S($D(DUZ)'[0:1,1:0) ^DISV(DUZ_U_+SC)=Y
DISP S IOF=$S('$D(IOF):"!#",IOF']"":"!#",1:IOF) W @IOF S SDSOH=$S('$D(^SC(+SC,"SL")):0,$P(^("SL"),"^",8)']"":0,1:1),SDAV=0
 I $D(SDINA),Y'<SDINA,SDRE>Y!('SDRE) S SDHY=Y,Y=SDINA D DTS^SDUTL W !,*7,"Clinic is inactive ",$S(SDRE:"from ",1:"as of "),Y S Y=SDRE D:Y DTS^SDUTL W $S(SDRE:" to "_Y,1:"") S Y=SDHY K SDHY D PAUSE^VALM1 Q:'SDRE
 S:Y#100=0 Y=Y+1 S X=Y D D:$E(X,4,5) S (SDX,X1)=X,X2=1 D C^%DTC S X=SDX K SDX G:SDAV ^SDM1 Q
 ;
NEXT D SET I $S('$D(FND):1,'FND:1,1:0) D  G EN
 .K ^DISV($S($D(DUZ)'[0:DUZ,1:0)_U_+SC)
 .I '$O(^SC(+SC,"ST",SDDATE-1)) S (X,Y)=SDDATE Q
 .W $C(7),!?6,"No open slots found in the date range "
 .W $$FMTE^XLFDT(SDDATE)," to ",$$FMTE^XLFDT(SDDMAX),"!",!
 .H 3 S (X,Y)=SDDATE
 .Q
 S (X,Y)=SDAPP K SDXXX G DISP
D W #!?36,$P(SC,U,2) S:$O(^SC(+SC,"T",0))>X X=+$O(^(0)) D DOW S I=Y+32,D=Y S SDXF=0 D WM I SDXF D WMH
X1 S X1=X\100_$P("31^28^31^30^31^30^31^31^30^31^30^31",U,+$E(X,4,5)) ;28
 ;SD*5.3*547 next line don't allow past dates to be added to pattern if prior to date DOW was added
W I '$D(^SC(+SC,"ST",X,1)) S DWFLG=1,POP=0,XDT=X D DOWCHK K DWFLG,XDT G L:POP
 I '$D(^SC(+SC,"ST",X,1)) S Y=D#7 G L:'$D(J(Y)),H:$D(^HOLIDAY(X))&('SDSOH) S SS=+$O(^SC(+SC,"T"_Y,X)) G L:SS'>0,L:^(SS,1)="" S ^SC(+SC,"ST",$P(X,"."),1)=$E($P($T(DAY),U,Y+2),1,2)_" "_$E(X,6,7)_$J("",SI+SI-6)_^(1),^(0)=$P(X,".")
 S SDHX=X,SDAV=1 D:X>SM WM I SDXF<2 D WMH
 I $D(^SC(+SC,"ST",X,1)),^(1)["["!(^(1)["CANCELLED")!($D(^HOLIDAY(X))) W !,$E(^SC(+SC,"ST",X,1),1,80) S:'$D(^HOLIDAY(X))&('SDAV) SDAV=1
 I $Y>18 W ! Q
L K POP
 S X=X+1,D=D+1
 I $D(SDINA),X>SDINA,SDRE>X!('SDRE) D:'SDAV NOAV S SDHY=Y,Y=SDINA D DTS^SDUTL W !,*7,?8,"Clinic is inactive ",$S(SDRE:"from ",1:"as of "),Y S Y=SDRE D:Y DTS^SDUTL W $S(SDRE:" to "_Y,1:"") S Y=SDHY K SDHY Q:'SDRE  D DIFF
 G W:X'>X1 S X2=X-X1 D C^%DTC
 I $D(SDINA),X>SDINA,SDRE>X!('SDRE) D:'SDAV NOAV S SDHY=Y,Y=SDINA D DTS^SDUTL W !,*7,?8,"Clinic is inactive ",$S(SDRE:"from ",1:"as of "),Y S Y=SDRE D:Y DTS^SDUTL W $S(SDRE:" to "_Y,1:"") S Y=SDHY K SDHY Q:'SDRE
 G X1:D<I W ! D:'SDAV MNTH Q
 ;
NOAV W !,"No availability found between date chosen and inactivate date!" Q
H S ^SC(+SC,"ST",X,1)="   "_$E(X,6,7)_"    "_$P(^(X,0),U,2),^(0)=X G W
 ;
WM W !?36 S Y=$E(X,1,5)_"00",SM=$S($E(X,4,5)[12:$E(X,1,3)+1_"01",1:$E(X,1,3)_$E(X,4,5)+1)_"00"
 S SDXF=SDXF+1 I $E(X,6,7)>20 D
 . S SDXD=$O(^SC(+SC,"ST",X-1)) Q:SDXD=""
 . I $E(SDXD,4,5)'=$E(X,4,5) S SDXF=0
 D:SDXF DT
 Q
WMH ;Write month heading lines
 W !!," TIME",?SI+SI-1 F Y=STARTDAY:1:65\(SI+SI)+STARTDAY W $E("|"_$S('Y:0,1:(Y-1#12+1))_"                 ",1,SI+SI)
 W !," DATE",?SI+SI-1,"|" K J F Y=0:1:6 I $D(^SC(+SC,"T"_Y)) S J(Y)=""
 F Y=1:1:65\(SI+SI) W $J("|",SI+SI)
 S SDXF=2
 Q
DT W $$FMTE^XLFDT(Y) Q
 ;
DOW S Y=$$DOW^XLFDT(X,1) Q
 ;
DAY ;;^SUN^MON^TUES^WEDNES^THURS^FRI^SATUR
MORDIS I '$D(SDHX) W *7," ??" G ADT^SDM1
 S SDXF=0,X1=SDHX,X2=1 D C^%DTC
MORD2 I $D(SDINA),SDINA'>X,SDRE>X!('SDRE) S SDHY=$S($D(Y):Y,1:""),Y=SDINA D DTS^SDUTL W *7,!,"Clinic is inactivated as of ",Y S Y=SDHY K SDHY G ADT^SDM1
 G EN
INPAT S SDI=$O(^DGPM("ATID1",DFN,9999999-X)) I SDI>0 D I1
 S:'$D(SDINP) SDINP="" K SDI,SDI1 Q
I1 F SDI1=0:0 S SDI1=$O(^DGPM("ATID1",DFN,SDI,SDI1)) Q:SDI1'>0  I $D(^DGPM(SDI1,0)) S SDX=^(0) I $S($P(SDX,U,17)']"":1,+^DGPM($P(SDX,U,17),0)>X!(+^DGPM($P(SDX,U,17),0)=0):1,1:0) S SDINP="I" Q
 Q
 ;
SUP ;Set up variables for availability search
 S SDNEXT=1,SDCT=1,G1=+SC,SDC(1)=SC,FND=0,SDAV=0 K SDC1
 D SAVE S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
 Q
 ;
SET S I1="" F I=0:0 S I1=$O(SDZ(I1)) Q:I1']""  S @I1=SDZ(I1)
 K SDZ Q
SAVE K SDZ F I="SDDIF","STR","SC","DFN","SL","SI","HSI","SB" S Z="SDZ("_""""_I_""")" S:$D(@I) @Z=@I
 Q
MNTH W !," *** No availability found for one full calendar month",!,"  Search stopped at " S Y=X D DTS^SDUTL W Y," ***",! Q
DIFF S X1=SDRE,X2=X D ^%DTC S D=D+X,X=SDRE,X1=X\100_28 Q
 ;
SRTY(SDSRTY) ;Prompt for scheduling request type
 ;Input: SDSRTY=variable to return user response (pass by reference)
 ;Output: '1' if successful, '0' otherwise
 ;
 I $G(DFN)<1 S SDSRTY="M" Q 1  ;patient not defined
 I $G(SDMM)=1 S SDSRTY="M" Q 1  ;multiple appointment booking
 N DIR,DTOUT,DUOUT
 S DIR(0)="Y"
 S DIR("A")="IS THIS A 'NEXT AVAILABLE' APPOINTMENT REQUEST"
 S DIR("?")="Answer 'yes' if scheduling to the next available appointment is desired."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) Q 0
 S SDSRTY=Y,SDSRTY(0)=$$TXRT^SDM1A(.SDSRTY) Q 1
 ;
PTFU(DFN,SC)    ;Determine if this is a follow-up (return to clinic within 24 months)
 ;Input: DFN=patient ifn
 ;Input: SC=clinic ifn
 ;Output: '1' if seen within 24 months, '0' otherwise
 ;
 Q:'DFN!'SC 0  ;variable check
 N SDBDT,SDT,SDX,SDY,SDZ,SDCP,SDCP1,SC0,SDENC,SDCT
 ;set up variables
 S SDBDT=(DT-20000)+.24,SDT=DT_.999999,(SDCT,SDY)=0
 S SC0=$G(^SC(+SC,0)),SDX=$$CPAIR^SCRPW71(SC0,.SDCP)  ;get credit pair for this clinic
 ;Iterate through encounters
 W !!,"Calculating follow-up status"
 F  S SDT=$O(^SCE("ADFN",DFN,SDT),-1) Q:SDT<SDBDT!SDY  D
 .S SDENC=0 F  S SDENC=$O(^SCE("ADFN",DFN,SDT,SDENC)) Q:'SDENC!SDY  D
 ..S SDENC0=$G(^SCE(SDENC,0))  ;get encounter node
 ..Q:$P(SDENC0,U,6)  ;parent encounters only
 ..S SDX=$P(SDENC0,U,4) Q:'SDX  ;get clinic
 ..S SC0=$G(^SC(SDX,0))
 ..S SDX=$$CPAIR^SCRPW71(SC0,.SDCP1)  ;get credit pair for encounter
 ..S SDY=SDCP=SDCP1  ;compare credit pairs
 ..S SDCT=SDCT+1 W:SDCT#10=0 "."
 ..Q
 .Q
 Q SDY
 ;
DDATE(SDDATE,SDSRTY,SDMAX) ;Desired date selection
 ;Input: SDDATE=variable to return date selection (pass by reference)
 ;Input: SDSRTY=variable to return request type
 ;Input: SDMAX=variable to return max. days to sched. (pass by ref.)
 ;Output: '1' for success, otherwise '0'
 ;
 Q:SDSRTY 1
 W !!?2,"Select one of the following:",!
 W !?5,"'F'",?20,"for First available following a specified date"
 W !?5,"Date",?20,"(or date computation such as 'T+2M') for a desired date"
 I DFN>0 W !?5,"Date/time",?20,"to schedule a specific appointment - Note: PAST dates",!?20,"must include the Year in the input."  ;added note SD*5.3*547
 W !?5,"'?'",?20,"for detailed help"
DASK N DIR,X,Y,SDX,DTOUT,DUOUT
 ;
 ;BP OIFO/TEH PATCH SD*5.3*384 ; SD*5.3*547 added note to help text
 ;
 S DIR(0)="F^1:30"
 S DIR("A")="ENTER THE DATE DESIRED FOR THIS APPOINTMENT"
 S DIR("?",1)="  Enter the date that is desired for this appointment."
 S DIR("?",2)="  NOTE: PAST dates must include the Year in the input."
 S DIR("?",3)=""
 S DIR("?",4)="  You may enter 'F' to find the first available slot after a specified date."
 S DIR("?",5)="  You will be prompted for begin and end dates for this search."
 S DIR("?",6)=""
 S DIR("?",7)="  A date may be entered to begin the display of clinic availability at the"
 I DFN<1 S DIR("?")="  requested date."
 I DFN>0 D
 .S DIR("?",8)="  requested date."
 .S DIR("?",9)=""
 .S DIR("?",10)="  The entry of a date/time will result in the scheduling of an appointment at"
 .S DIR("?")="  that time, if possible."
 .Q
 W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT) 0
 I Y=" " S SDX=$G(^DISV(DUZ_U_+SC)) I SDX?7N S (X,Y)=SDX
 I $L(Y)=1,"fF"[Y D  Q 1
 .W "    First available"
 .S (SDDATE,SDSRTY)=$TR(Y,"f","F")
 .Q
 N %DT,SDX,SDI,POP
 S SDX="N^n^NOW^now^Now" F SDI=1:1:5 S:X=$P(SDX,U,SDI) X="T"
 S %DT="EFT" D ^%DT
 G:Y<1 DASK S SDDATE=Y
 I DFN<1 S SDDATE=SDDATE\1
 ;SD*5.3*621 - check if desired date if prior to DOB and if clinic schedule is available.
 I DFN>0 S POP=0 D DDCHK I POP G DASK
 I DFN>0,Y'<DT,(Y\1)>SDMAX D  G DASK
 .W !,$C(7)
 .W "Scheduling cannot be more than ",SDMAX(1)," days in the future"
 .Q
 Q 1
 ;
DDCHK ;SD*5.3*621 - check if desired date if prior to DOB and if clinic schedule is available.
 N X
 S X=SDDATE D AVCHK^SDM1 I POP Q
 D AVCHK1^SDM1
 Q
 ;
DOWCHK ;SD*5.3*547 check if date is prior to date DOW was added to pattern
 S (DY,DYW)="" S:'$D(DWFLG) DWFLG=0
 I '$D(^SC(+SC,"ST",$P(XDT,"."),1)) D  Q:DWFLG  I POP D DWWRT Q
 .S DY=$$DOW^XLFDT($P(XDT,"."))
 .S DYW=$E(DY,1,2),DYW=$TR(DYW,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .S PCDT=$P(XDT,"."),CT=0,POP=1
 .F  S PCDT=$O(^SC(+SC,"ST",PCDT),-1) Q:'PCDT!('POP)!(CT>30)  D
 ..S CT=CT+1
 ..Q:'$D(^SC(+SC,"ST",PCDT,0))
 ..Q:'$D(^SC(+SC,"ST",PCDT,1))
 ..Q:$E($G(^SC(+SC,"ST",PCDT,1)),1,2)'=DYW
 ..I $E($G(^SC(+SC,"ST",PCDT,1)),1,2)=DYW S POP=0 Q
 .Q
 K PCDT,CT,DY,DYW
 Q
 ;
DWWRT ;added SD*5.3*547
 S DY=$TR(DY,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 W *7,!!,"That date is prior to the date ",DY," was added to the"
 W !,"availability pattern for this clinic.",!!
 K DY,DYW,PCDT,CT
 Q
 ;
1 S SDNEXT="",SDCT=0 G RD^SDMULT
DT1 S FND=0,%DT(0)=-SDMAX,%DT="AEF",%DT("A")="  START SEARCH FOR NEXT AVAILABLE FROM WHAT DATE: " D ^%DT K %DT G:"^"[X 1:$S('$D(SDNEXT):1,'SDNEXT:1,1:0),END^SDMULT0 G:Y<0 DT S (SDDATE,SDSTRTDT)=+Y
LIM W !,"  ENTER LATEST DATE TO CHECK FOR 1ST AVAILABLE SLOT: " S Y=SDMAX D DT^DIQ R "// ",X:DTIME G:X["^"!'($T) END^SDMULT0 I X']"" G OVR^SDMULT0
 I X?.E1"?" W !,"  The latest date for future bookings for ",$P(SDC(1),"^",2)," is: " S Y=SDMAX D DTS^SDUTL W Y,!,"  If you enter a date here, it must be less than this date to further limit the",!,"  search" G LIM
 S %DT="EF",%DT(0)=-SDMAX D ^%DT K %DT G:Y<0!(Y<SDSTRTDT) LIM S:Y>0 (SDDMAX,SDMAX)=+Y
 G OVR^SDMULT0
