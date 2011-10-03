PRSATE2 ; HISC/REL,WIRMFO/JAH - Display Employee Tour of Duty ;3/3/1998
 ;;4.0;PAID;**8,22,35,114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;VARIABLES:
 ;   PPI   =  Pay period internal entry number from file 458
 ;   PPE   =  Pay period number in YY-PP format (e.g. 97-03)
 ;   HOLDSCR  = dummy variable used to hold value from hold screen
 ;              extrinsic function call.
 ;   PRSTLV  = flag: contains 2 for timekeepers and 3 for supervisors.
 ;   TLI   =  Internal entry of the T&L unit
 ;   DFN   =  DFN is defined in a call from routine PRSATE to label NOL.
 ;            Otherwise DFN is set to zero.
 ;   SRT   =  Report sort entered by user.
 ;            (C = current pp, L = last pp, N = next pp)
 ;
TK ; TimeKeeper Entry
 S PRSTLV=2 G TL
SUP ; Supervisor Entry
 S PRSTLV=3 G TL
TL N HOLDSCR
 ;
 ;Ask user to select a Time and Leave Unit: go to exit if unsuccessful
 D ^PRSAUTL G:TLI<1 EX
 ;
 ;set PPI to the last pay period opened by Payroll
 S PPI=$P(^PRST(458,0),"^",3),PPE=$P($G(^PRST(458,PPI,0)),"^",1)
 ;
 ;
 S DFN=0 D NOL G:SRT="^" EX
 ;
 ;If user chose last pay periods tour then decrement pay period.
 I SRT="L" S PPI=PPI-1,PPE=$P($G(^PRST(458,PPI,0)),"^",1)
 ;
 ;If user chose Next pay period's tour of duty
 ;then increment pay period.  This value is for display only, 
 ;since the actual data for a tour change for the next pay period 
 ;is stored on the 4 node of the current pay period.
 I SRT="N" S PPE=$E($$NXTPP^PRSAPPU(PPE),3,7)
 ;
T1 ;ask type of output
 S DIR(0)="SA^S:SHORT;L:LONG"
 S DIR("A")="Select Type of Display (S or L): ",DIR("B")="SHORT"
 S DIR("?")="Answer S for Tour Titles, L for Detailed Time Segments"
 D ^DIR K DIR G:$D(DIRUT) EX
 S TYP=Y
 ;
NME ;Ask user what employee they want to display tour of duty for.
 K DIC S DIC("A")="Select EMPLOYEE: "
 S DIC("S")="I $P(^(0),""^"",8)=TLE"
 S DIC(0)="AEQM"
 S DIC="^PRSPC(",D="ATL"_TLE
 W ! D IX^DIC S DFN=+Y K DIC
 ;
 I DFN<1 G EX
 W ! K IOP,%ZIS
 S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSATE2",PRSALST="TLI^TLE^TYP^SRT^DFN^PPI^PPE" D QUE^PRSAUTL G NME
 U IO D Q1 D ^%ZISC K %ZIS,IOP G NME
Q1 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?29,"EMPLOYEE TOUR OF DUTY"
 D:TYP="S" S0
 D:TYP="L" L0
 I $E(IOST,1,2)="C-" S HOLDSCR=$$ASK^PRSLIB00(1)
 Q
 ;====================================================================
S0 ; Short Display
 ;Loop thru both weeks of pay period simultaneously, 
 ;displaying sun-sat side by side.
 D HDR^PRSADP1,DT
 W !!?11,"Week 1 - ",$E(Y1,5,13),?45,"Week 2 - ",$E(Y2,5,13),!
 F DAY=1:1:7 D S1
 Q
 ;====================================================================
S1 ;
 ; Y1 =  employee tour of duty node 4 current day of week one.
 ; Y2 =  employee tour of duty node 4 current day of week two.
 ; TD =  tour of duty pointer to Tour of Duty file.
 ;
 S Y1=$G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),TD=$P(Y1,"^",2)
 I SRT="N",$P(Y1,"^",3) S TD=$P(Y1,"^",4)
 W !?4,$P("Sun Mon Tue Wed Thu Fri Sat"," ",DAY)
 W:TD ?11,$P($G(^PRST(457.1,TD,0)),"^",1)
 S Y2=$G(^PRST(458,PPI,"E",DFN,"D",DAY+7,0)),TD=$P(Y2,"^",2)
 I SRT="N",$P(Y2,"^",3) S TD=$P(Y2,"^",4)
 W:TD ?45,$P($G(^PRST(457.1,TD,0)),"^",1) Q:SRT="N"
 I $P(Y1,"^",13)="",$P(Y2,"^",13)="" Q
 W ! S TD=$P(Y1,"^",13)
 W:TD ?11,$P($G(^PRST(457.1,TD,0)),"^",1)
 S TD=$P(Y2,"^",13) W:TD ?45,$P($G(^PRST(457.1,TD,0)),"^",1)
 Q
 ;====================================================================
L0 ; Long Display
 S C0=^PRSPC(DFN,0)
 W !!,$P(C0,U)
 S X=$P(C0,U,9) W ?65,$E(X),"XX-XX-",$E(X,6,9)
 D DT W !!,?11,"Week 1 - ",$E(Y1,5,13),?45,"Week 2 - ",$E(Y2,5,13),!
 F DAY=1:1:7 D ^PRSATE3
 Q
 ;
H1 I $E(IOST,1,2)="C-" S QT=$$ASK^PRSLIB00()
 Q
DT ; Get date of PP
 I SRT'="N" S Y1=$P($G(^PRST(458,PPI,2)),"^",1),Y2=$P($G(^(2)),"^",8) Q
 N X,Y,X1,X2 S X1=$P($G(^PRST(458,PPI,1)),"^",1),X2=14 D C^%DTC,DTP^PRSAPPU S Y1="    "_Y
 S X1=X,X2=7 D C^%DTC,DTP^PRSAPPU S Y2="    "_Y Q
 Q
NOL ; Select this PP or Next
 ;
 ;SCL is set to 1 when NOL is called from this routine.
 ;SCL is set to CN when NOL is called from PRSATE.
 S SCL=$S(DFN:"",1:"CN")
 ;
 ;X,D1 is set to FileMan dates of selected pay period.
 S (X,D1)=$P($G(^PRST(458,PPI,1)),"^",1)
 W !
 ;
 ;if called from PRSATE and employee has data in this pay period
 ;then set sort = next pp.  Then if the timecard has been transmitted
 ;already set sort = current, next
 I DFN,$D(^PRST(458,PPI,"E",DFN,0)) S SCL="N" I $P(^(0),"^",2)="T" S SCL="CN"
 ;DTP takes X in FM date and returns a printable date in Y
 I SCL["C" D DTP^PRSAPPU W !,"C = Current Pay Period beginning ",Y
 G:'$D(^PRST(458,PPI-1,1)) N0
 ;
 ;if called from PRSATE and last pay period has NOT been transmitted.
 I DFN,$P($G(^PRST(458,PPI-1,"E",DFN,0)),"^",2)'="T" G N0
 ;
 ;Show date of current pay period
 S X1=D1,X2=-14
 D C^%DTC,DTP^PRSAPPU W !,"L = Last Pay Period beginning ",Y
 S SCL=SCL_"L"
 ;
 ;
N0 I SCL["N" S X1=D1,X2=14 D C^%DTC,DTP^PRSAPPU W !,"N = Next Pay Period beginning ",Y
 I SCL="" S SRT="^" Q
 S SRTD=$E(SCL,1)
N1 W !!,"Which Pay Period? ",SRTD," // " R SRT:DTIME S:'$T SRT="^" S:SRT="" SRT=SRTD Q:SRT="^"
 S SRT=$TR(SRT,"ncl","NCL") I SCL'[SRT W $C(7),"   Choose from C, N or L if displayed" G N1
 Q
EX G KILL^XUSCLEAN
