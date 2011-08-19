RMPRPAT ;PHX/RFM/JLT-DISPLAY 2319 FIRST PAGE ;8/29/1994
 ;;3.0;PROSTHETICS;**29,62,162**;Feb 09, 1996;Build 5
 ;
 ; RVD - patch # 62 - sets RMPRNAM, RMPRSSN,RMPRDOB and RMPRSSNE
 ;
ASK ;Set common variables
 Q:$G(RMPRDFN)<1
 ;PATCH *162 => insure activity screen displays first time (RMPRFRST) in and Home Oxygen activity is NOT included (RCNT=7) for inside issue option
 N RCNT
 D HOME^%ZIS S DFN=RMPRDFN,RMPRBACK=1,RMPRFRST=1,RCNT=7 I $G(RSTCK)'=1 S RCNT=8,RFLG=1
 D ADD^VADPT,OAD^VADPT,DEM^VADPT,ELIG^VADPT
 ;next 2 lines added by patch #62
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
 I $D(^RMPR(665,RMPRDFN,8,0)) W !,"*Comments on file"
 I '$D(^RMPR(665,RMPRDFN,1,0)) W $C(7),!!,"*No Disability Code on File!"
 I $D(^RMPR(665,RMPRDFN,1,0)),'$O(^(0)) W $C(7),!!,"*No Disability Code on File!"
 D DISP^RMPRPAT5 K ANS W !
 K RMPRQ,RMPRQUES,DIR,RMPREND1,RMPRL
 D ASK1^RMPRPAT1 K ANS I $G(RMPRFRST)=1,$G(RSTCK) D HELP^RMPRPAT1  ;insure activity list appears upon entry
 D ^DIR
 K DIR,RMPRFRST
 I Y["^" G EXIT
 I Y="",'$D(RMPR1APN) G EXIT
 I Y>0 S ANS=Y G QUE
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
HELP W !,"You may only enter screen 1-8,`^`, or `return`" G ASK2
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
 I $P($G(^DPT(DFN,.372,0)),U,4)>IOSL-2-$Y D QUEST2 G:$G(RMNOQUIT)=0 ASK1
 S RO=0 F I=0:0 S RO=$O(^DPT(DFN,.372,RO)) Q:RO'>0!$D(RMPREND1)  I +$P(^(RO,0),U,1),$D(^DIC(31,+$P(^(0),U,1))) W:'$D(RMPRL) !,"Patient Name: ",VADM(1),?40,"SSN: ",$P(VADM(2),U,2),!!,"MAS Disability Code(s):"  D WRI
 K RMNOQUIT G:$D(RMPREND1) ASK1
 D SVC^VADPT W !!,"*POW? ",$S(VASV(4)=1:"YES",1:"NO")
 G:$D(RMPRBACK) QUES
 W @IOF G ASK1
WRI I $Y>(IOSL-6),'$D(RMPRQUES) D QUEST1 Q:$D(RMPREND1)  ;patch *162, replace GOTO with Quit when within FOR loop
 W !,$E($P(^DIC(31,$P(^DPT(DFN,.372,RO,0),U,1),0),U,1),1,30),?40,"Disability% ",$P(^DPT(DFN,.372,RO,0),U,2),?56," Service Connected? " W:$P(^DPT(DFN,.372,RO,0),U,3)=1 "YES" W:$P(^DPT(DFN,.372,RO,0),U,3)=0 "NO" S RMPRL=1 Q
QUES ;ASK WHAT PAGE OF A PATIENT'S 10-2319
 K RMPRFLG,RMPRL F I=0:0 Q:$Y>21  W !
QUES1 R !,"Enter return to continue or `^` to exit: ",ANS:DTIME
 G:'$T EXIT
 I ANS="" G ASK1
 I $G(ANS)="" G EXIT
 I "^"[ANS G ASK1
 E  W $C(7),!,"You must enter an `^` to exit!" G QUES1
QUE W:ANS=5 @IOF
 G EXIT:"^"[ANS,STAR^RMPRPAT:ANS=1,^RMPRPAT0:ANS=2,^RMPRPAT1:ANS=3
 I ANS=4 G ^RMPRPAT2
 I ANS=8 G 2319^RMPOBIL2
 G DU^RMPRAINQ:ANS=5
 G ^RMPRPAT5:ANS=6
 I ANS=7 S RMPRDIR7=1 G EN^RMPRDIS
 W !!,$C(7) G QUES
 Q
EXIT ;EXIT FOR DISPLAY OF A PATIENT'S 10-2319
 ;must always exit through this point
 I '$D(^RMPR(665,RMPRDFN,1,0)) D DIS^RMPRPAT5
 I $D(^RMPR(665,RMPRDFN,1,0)),'$O(^(0)) D DIS^RMPRPAT5
 I $D(^RMPR(665,RMPRDFN,1,0)),$O(^(0)) K RMPRKILL
 D NPC^RMPRPAT5
 K RMPRCOMB,Y,DIE,DIC,RMPRCCO,DIR,VASV,VAMB,VAEL,VADM,VAPA,FG,VAOA,TYPE,RMPROBL,RC,AMIS,CST,DATE,DEL,RFLG,QTY,REM,SN,STA,RR,RO,I,J,RMPRCNUM,RMPRFG,TRANS,TRANS1,RK,FLG,RA,RI,RT,RTCH,LC,MC,RMPRDT,RMPRJOB,RMPRWO
 K RMPR2APN,RMPRQ,RR5,R5,DFN,FL,PAGE,AN,FRM,VEN,RZ,%X,%Y,VA,VAERR,TLC,TMC,R660,RCK,RJ,RDA,RL,RTC,RTCD,RTHD,RTR,RW,RWP,RMPRQUES,RMPREND1 D KVAR^VADPT
 K:'$D(RMPRF)!($G(RMPRBACK)<1) RMPRDOB,RMPRDFN,RMPRNAM,RMPRSSN,RMPRBACK
 Q
QUEST1 S RMPRQUES=1
 N DIR S DIR(0)="E" W !! D ^DIR W @IOF
 I $D(DTOUT)!($D(DUOUT)) S RMPREND1=1 Q  ;patch *162, set quit flag if user chooses to exit option
 W ! Q
QUEST2 ;PUT MAS DISABILITY CODES ON NEXT PAGE IF THEY WILL NOT ALL FIT ON THIS
 ;PAGE
 N DIR S DIR(0)="E" W !! D ^DIR W @IOF S RMNOQUIT=1
 I $D(DTOUT)!($D(DUOUT)) S RMNOQUIT=0
 W @IOF
 Q
