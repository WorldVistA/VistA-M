RMPOPAT ;HINES CIO/RVD-DISPLAY 2319 FIRST PAGE READ ONLY ;7/5/02
 ;;3.0;PROSTHETICS;**70**;Feb 09, 1996
 ;
 ; RVD 7/5/02 - patch # 70 - this routine is a copy of RMPRPAT for
 ;                           Read Only 2319, without comments and
 ;                           disability codes.
 ;
ASK ;Set common variables
 Q:$G(RMPRDFN)<1
 D HOME^%ZIS S DFN=RMPRDFN,RMPRBACK=1
 D ADD^VADPT,OAD^VADPT,DEM^VADPT,ELIG^VADPT
 S RMPRNAM=$P(VADM(1),U),RMPRSSN=$P(VADM(2),U)
 S RMPRDOB=$P(VADM(3),U),RMPRSSNE=VA("PID")
 W @IOF
 S %X="^RMPR(665,"_RMPRDFN_",",%Y="R5(" D %XY^%RCR S RMPRCNUM=VAEL(7)
ASK1 ;CALL ROUTINE TO DISPLAY SCREEN SELECTI0N
 Q:$G(RMPRDFN)'>0  S DFN=RMPRDFN
 I '$D(VAEL(7)) D ELIG^VADPT
 I '$D(VAPA(1)) D ADD^VADPT
 I '$D(VADM(1)) D DEM^VADPT
 I '$D(VAOA(1)) D OAD^VADPT
 ;I $D(^RMPR(665,RMPRDFN,8,0)) W !,"*Comments on file"
 ;I '$D(^RMPR(665,RMPRDFN,1,0)) W $C(7),!!,"*No Disability Code on File!"
 ;I $D(^RMPR(665,RMPRDFN,1,0)),'$O(^(0)) W $C(7),!!,"*No Disability Code on File!"
 ;D DISP^RMPRPAT5 K ANS
 ;K RMPRQ,RMPRQUES,DIR
 D ASK1^RMPOPAT1 K ANS
 D ^DIR
 K DIR
 I Y["^" G EXIT
 I Y="",'$D(RMPR1APN) G EXIT
 I (Y="I")!(Y="H") S ANS=Y G QUE
 ;RMPR1APN is set in the entry action to menu RMPR PRINT 2319
 ;and killed in the exit action.  We do not want to prompt
 ;patient name while creating records, only in display
 ;options
 ;prompt to select a new patient
 I Y="",$D(RMPR1APN) S RMPR2APN=RMPRDFN D GETPAT^RMPRUTIL
 I '$D(RMPRDFN) S RMPRDFN=RMPR2APN G EXIT
 I $D(RMPR2APN) K RMPR2APN D ASK1
 Q
ASK2 ;ASK TO CONTINUE AFTER SCREEN DISPLAY
 G ASK1
HELP W !,"You may only enter screen (I-H),`^`, or `return`" G ASK2
 Q
STAR ;DISPLAY ADDRESS INFO
 Q:$G(DFN)'>0
 S RMPRBACK=1
 I '$D(VADM(1))!('$D(VAOA(8))!('$D(VAPA(8))!('$D(VAEL(7))))) N VAHOW D DEM^VADPT,ADD^VADPT,OAD^VADPT
 W:$E(IOST)["C" @IOF
 W !,$E(RMPRNAM,1,20),?23,"SSN: ",$P(VADM(2),U,2),?42
 W "DOB: ",$P(VADM(3),U,2),?61,"CLAIM# ",VAEL(7) ;RMPRCNUM
STARD W !!,"Phone: ",VAPA(8),?40,"Phone: ",VAOA(8)
 W !,"Current Address:",?40,"Primary Next of Kin Address:"
 W !,VAPA(1),?40,VAOA(1)
 I VAPA(2)=""&(VAPA(3)="") W:VAPA(4)'="" !,VAPA(4)_", "_$P(VAPA(5),U,2)_" "_VAPA(6) W:VAOA(4)'="" ?40,VAOA(4)_", "_$P(VAOA(5),U,2)_" "_VAOA(6) W:VAOA(10)'="" !,?40,"Relationship: ",VAOA(10) G END
 I VAPA(2)'=""&(VAPA(3)="") W !,VAPA(2) W:VAOA(4)'="" ?40,VAOA(4)_", "_$P(VAOA(5),U,2)_" "_VAOA(6) W:VAPA(4)'="" !,VAPA(4)_", "_$P(VAPA(5),U,2)_" "_VAPA(6) W:VAOA(10)'="" ?40,"Relationship: ",VAOA(10) G END
 I VAPA(2)'=""&(VAPA(3))'="" W !,VAPA(2) W:VAOA(4)'="" ?40,VAOA(4)_", ",$P(VAOA(5),U,2)_" "_VAOA(6),!,VAPA(3) W:VAOA(10)'="" ?40,"Relationship: ",VAOA(10)
 I  W:VAPA(4)'="" !,VAPA(4)_", "_$P(VAPA(5),U,2)_" "_VAPA(6)
END D ELIG^VADPT
 W !!,"Patient Type: ",$P(VAEL(6),U,2),?40
 W "Period of Service: ",$P(VAEL(2),U,2)
 W !,"Primary Eligibility Code:",?40
 W "Status: ",$P(VAEL(9),U,2),!,$P(VAEL(1),U,2)
 W ?40,"Eligibility Status: ",$E($P(VAEL(8),U,2),1,19)
 D MB^VADPT
 W !!,"Receiving A&A Benefits? "
 W:VAMB(1)=0 "NO" W:$P(VAMB(1),U,1)=1 $P(VAMB(1),U,2)
 W ?40,"Receiving Housebound Benefits? "
 W:VAMB(2)=0 "NO" W:$P(VAMB(2),U,1)=1 $P(VAMB(2),U,2)
 W !,"Receiving Social Security? "
 W:VAMB(3)=0 "NO" W:$P(VAMB(3),U,1)=1 $P(VAMB(3),U,2)
 W ?40,"Receiving VA Pension? " W:VAMB(4)=0 "NO"
 W:$P(VAMB(4),U,1)=1 $P(VAMB(4),U,2)
 W !,"Receiving Military Retirement? "
 W:VAMB(5)=0 "NO" W:$P(VAMB(5),U,1)=1 $P(VAMB(5),U,2)
 W ?40,"Receiving VA Disability? " W:VAMB(7)=0 "NO"
 W:$P(VAMB(7),U,1)=1 $P(VAMB(7),U,2)
 S (RO,FG)=0 I '$D(^RMPR(665,RMPRDFN,1)) W !,"No Prosthetic Disability Codes entered for this Patient." S RO=1
 I RO=0 F  W:'FG !,"Prosthetic Disability Code(s):" S RO=$O(^RMPR(665,RMPRDFN,1,RO)) Q:RO'>0  S RR=^(RO,0) S:$P(RR,U,10) FG=1 I '$P(RR,U,10) W " ",$P(^RMPR(662,+RR,0),U,1),"-",$S($P(RR,U,3)=1:"SC",$P(RR,U,3)=2:"NSC",1:"") S FG=1
 K RMNOQUIT G:$D(RMPREND1) EXIT
 D SVC^VADPT W !!,"*POW? ",$S(VASV(4)=1:"YES",1:"NO")
 G:$D(RMPRBACK) QUES
 W @IOF G ASK1
WRI I $Y>(IOSL-7),'$D(RMPRQUES) D QUEST1 G:$D(RMPREND1) ASK1
QUES ;ASK WHAT PAGE OF A PATIENT'S 10-2319
 K RMPRFLG,RMPRL F I=0:0 Q:$Y>21  W !
QUES1 R !,"Enter return to continue or `^` to exit: ",ANS:DTIME
 G:'$T EXIT
 I ANS="" G ASK1
 I $G(ANS)="" G EXIT
 I "^"[ANS G ASK1
 E  W $C(7),!,"You must enter an `^` to exit!" G QUES1
QUE ;W:ANS=5 @IOF
 G EXIT:"^"[ANS
 I ANS="I" G ^RMPOPAT2
 I ANS="H" G 2319^RMPOBIL6
 W !!,$C(7) G QUES
 Q
EXIT ;EXIT FOR DISPLAY OF A PATIENT'S 10-2319
 ;must always exit through this point
 ;I '$D(^RMPR(665,RMPRDFN,1,0)) D DIS^RMPRPAT5
 ;I $D(^RMPR(665,RMPRDFN,1,0)),'$O(^(0)) D DIS^RMPRPAT5
 I $D(^RMPR(665,RMPRDFN,1,0)),$O(^(0)) K RMPRKILL
 ;D NPC^RMPRPAT5
 K RMPRCOMB,Y,DIE,DIC,RMPRCCO,DIR,VASV,VAMB,VAEL,VADM,VAPA,FG,VAOA,TYPE,RMPROBL,RC,AMIS,CST,DATE,DEL,RFLG,QTY,REM,SN,STA,RR,RO,I,J,RMPRCNUM,RMPRFG,TRANS,TRANS1,RK,FLG,RA,RI,RT,RTCH,LC,MC,RMPRDT,RMPRJOB,RMPRWO
 K RMPR2APN,RMPRQ,RR5,R5,DFN,FL,PAGE,AN,FRM,VEN,RZ,%X,%Y,VA,VAERR,TLC,TMC,R660,RCK,RJ,RDA,RL,RTC,RTCD,RTHD,RTR,RW,RWP,RMPRQUES,RMPREND1 D KVAR^VADPT
 K:'$D(RMPRF)!($G(RMPRBACK)<1) RMPRDOB,RMPRDFN,RMPRNAM,RMPRSSN,RMPRBACK
 K RMPOPFLG,RMPR1APN
 Q
QUEST1 S RMPRQUES=1
 N DIR S DIR(0)="E" W !! D ^DIR W @IOF
 I $D(DTOUT)!($D(DUOUT)) S RMPREND1=1 G ASK1
 W ! Q
QUEST2 ;PUT MAS DISABILITY CODES ON NEXT PAGE IF THEY WILL NOT ALL FIT ON THIS
 ;PAGE
 N DIR S DIR(0)="E" W !! D ^DIR W @IOF S RMNOQUIT=1
 I $D(DTOUT)!($D(DUOUT)) S RMNOQUIT=0
 W @IOF
 Q
