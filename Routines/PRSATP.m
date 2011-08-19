PRSATP ;HISC/REL,WIRMFO/MGD/PLT - Timekeeper Post Time ;11/21/06
 ;;4.0;PAID;**22,57,69,92,102,93,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; input (from calling option)
 ;   PTPF - (optional) part-time physician flag, true (=1) when called
 ;          by the posting option for part-time physicians with a memo.
 ;
 N GLOB ; global reference for employee's time & attendance record.
 N PRSDT
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX S %DT="X",X="T+3" D ^%DT
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT("B")="T-1",%DT(0)=-Y W ! D ^%DT
 G:Y<1 EX S (PRSDT,D1)=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2)
 I PPI="" W !!,$C(7),"Pay Period is Not Open Yet!" G EX
 S PPE=$P($G(^PRST(458,PPI,0)),"^",1),DTE=$P($G(^PRST(458,PPI,2)),"^",DAY),DTI=$P($G(^(1)),"^",DAY)
D2 W !!,"Would you like to edit the T & A RECORDs in alphabetical order" S %=1 D YN^DICN I % S LP=% G EX:%=-1,LOOP:%=1,NME
 W !!,"Answer YES if you want all RECORDs brought up for which no data"
 W !,"has been entered." G D2
 ;
 ;
LOOP ;
 S LP=1,NN=""
 F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NN,DFN)) Q:DFN<1  I $$PTPSCR(DFN,PRSDT,$G(PTPF)) S GLOB="" D POST D:GLOB]"" UNLOCK^PRSLIB00(GLOB) I 'LP G EX
 G EX
NME K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE,$D(^PRST(458,PPI,""E"",+Y)),$$PTPSCR^PRSATP(+Y,PRSDT,$G(PTPF))",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC
 G:DFN<1 EX S GLOB="" D POST D:GLOB]"" UNLOCK^PRSLIB00(GLOB) G NME
POST S TC=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",2),TC2=$P($G(^(0)),"^",13)
 I 'TC Q:LP'=2  W !!?5,"This Employee has no tour entered for this date." Q
 I "T"'[$P($G(^PRST(458,PPI,"E",DFN,0)),"^",2) W:LP=2 $C(7),!!,"This Employee has already been sent to Payroll." Q
 S STAT=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,10)),"^",1)
 I LP=1,"1 3 4"[TC!(STAT'="") Q
 ;
 ; check if ESR is approved when posting PT Phy with memo
 I $G(PTPF),$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,7)),U)=5 D  Q:'Y!$D(DIRUT)
 . W $C(7),!
 . W !,"This day was auto-posted from an approved Electronic Subsidiary Record (ESR)."
 . W !,"Normally, changes should be accomplished by having the T & L supervisor return"
 . W !,"the ESR day to the part-time physician for correction."
 . W !,"An exception to the above is when AWOL, On Suspension, or Non-Pay must be"
 . W !,"posted, since those can not be entered via the ESR.",!
 . S DIR(0)="Y"
 . S DIR("A")="Do you want to manually post this day on the timecard"
 . S DIR("B")="NO"
 . D ^DIR K DIR
 ;
 ; lock employee record for editing by timekeeper
 I '$$AVAILREC^PRSLIB00("TK",.GLOB,.STOP) S:LP=1&$G(STOP) LP=0 Q
 D ^PRSADP1,LP,^PRSATP2,^PRSAENT
 G P0:TC>4,P0:TC=2,P0:TC=3,P3:TC=4,P1
P0 R !!,"Did Employee Only Work Scheduled Tour? ",X:DTIME S:'$T X="^^" S:X["^^" LP=0 Q:X["^"  S X=$TR(X,"yesnor","YESNOR")
 S:X="" X="*" I $P("YES",X,1)'="",$P("NO",X,1)'="",X'="R" W $C(7),!?5," Answer YES or NO or R for Normal Posting with Remarks" G P0
 S X=$E(X,1) I "YR"'[X G P1
 S PTY=1 I STAT'="" K ^PRST(458,PPI,"E",DFN,"D",DAY,2),^(3)
 I TC=3 S $P(^PRST(458,PPI,"E",DFN,"D",DAY,2),"^",3)="RG",STAT="T"
 I STAT'="",$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",12) D NOW^%DTC S NOW=%,TT="HW" D S0^PRSAPPH
 S LV="" D A2^PRSATP0:X="R" G UPD
P1 R !!,"Was Employee Absent the Entire Tour? ",X:DTIME S:'$T X="^" Q:X["^"  S X=$TR(X,"yesno","YESNO")
 S:X="" X="*" I $P("YES",X,1)'="",$P("NO",X,1)'="" W $C(7)," Answer YES or NO" G P1
 I X?1"Y".E D ^PRSATP0 Q:X["^"  G UPD
 I $E(ENT,1,2)["D" K ^PRST(458,PPI,"E",DFN,"D",DAY,2),^(3),^(10) Q
P3 S ZENT=$S($E(ENT,2)="H"&('$G(PTPF)):"RG ",$E(ENT,1,2)="00":"RG ",1:"")
 I TC=1 D OT S:$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",12)&(AC="M2E") ZENT=ZENT_"HW " S ZENT=ZENT_"NP CP " G P31
 I TC=3!(TC=4) D LV S:$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",12)&($E(ENT,22)) ZENT=ZENT_"HW " G P31
 D LV,OT S ZENT=ZENT_"TV TR " S:$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",12) ZENT=ZENT_"HX HW "
P31 S DDSFILE=458,DDSFILE(1)=458.02,DA(2)=PPI,DA(1)=DFN,DA=DAY
 S Z=$G(^PRST(458,PPI,"E",DFN,"D",DAY,2)) K ZS
 S DR="[PRSA TP POST1]" D ^DDS K DS Q:'$D(ZS)
 I ZS'="" S ^PRST(458,PPI,"E",DFN,"D",DAY,2)=ZS,PTY=3 G UPD
 I $D(^PRST(458,PPI,"E",DFN,"D",DAY,2)) K ^(2),^(3),^(10)
 Q
UPD ; Update status
 D NOW^%DTC
 S $P(^PRST(458,PPI,"E",DFN,"D",DAY,10),"^",1,4)="T^"_DUZ_"^"_%_"^"_PTY
 N DAH,DBH,HOL,QUIT
 S (DAH,DBH,HOL,QUIT)=""
 ;
 ; Check to holiday encapsulated by a form a non-pay
 D HENCAP^PRSATP3(PPI,DFN,DAY,.DBH,.HOL,.DAH,.QUIT)
 Q:QUIT
 D UPDT^PRSATP3(DFN,DBH,HOL,DAH)
 K DAH,DBH,HOL,QUIT
 Q
LP W !!,"Enter '^' to bypass this employee." W:LP=1 " Enter '^^' to stop T&L editing." W ! Q
LV S Z1="30 31 31 31 32 33 28 35 35 30 36 37 38",Z2="AL SL CB AD NL WP CU AA DL RL NP CP HX"
 ;
 ; Check to see if the employee is entitled to Military Leave and add
 ; ML to list if they are.  Added to be compliant with Public Law
 ; 106-554.
 S:$E(ENT,34) Z1=Z1_" 34",Z2=Z2_" ML"
 ;9/3 month employee entitled RS with recess hours in file# 458.8
 S:$E(ENT,5)&$P($$RSHR^PRSU1B2(DFN,PPE),U,DAY>7+1) Z1=Z1_" 5",Z2=Z2_" RS"
 F K=1:1:$L(Z1," ") I $E(ENT,$P(Z1," ",K)) S ZENT=ZENT_$P(Z2," ",K)_" "
 QUIT
 ;
OT ; Get entitled out-of-tour types of time
 S Z1="12 28 26",Z2="OT CT ON" F K=1:1:3 I $E(ENT,$P(Z1," ",K)) S ZENT=ZENT_$P(Z2," ",K)_" " I ZENT'["UN" S ZENT=ZENT_"UN "
 I $E(ENT,29),'$E(ENT,26) S ZENT=ZENT_"SB " S:ZENT'["UN" ZENT=ZENT_"UN "
 ; Allow Stand By for employees w/ Prem Pay Ind = W or V
 I $E(ENT,29),$E(ENT,26),"^W^V^"[(U_PMP_U) S ZENT=ZENT_"SB " S:ZENT'["UN" ZENT=ZENT_"UN "
 Q
EX ;clean up lock global which is set in $$AVAILREC^PRSLIB00
 K ^TMP($J,"LOCK")
 ;generic cleanup
 G KILL^XUSCLEAN
 ;
PTPSCR(PRSIEN,PSTDT,PTPF) ; part-time physician screen extrinsic function
 ; input
 ;   PRSIEN - Employee IEN (file 450)
 ;   PSTDT  - Date being posted (FileMan internal)
 ;   PTPF   - (opt) Part-time physician flag, equals true (1) when screen
 ;            should only allow selection of part-time physician with
 ;            memo and false (null or 0) when screen should only
 ;            allow selection of employees that are not part-time
 ;            physicians with memo.
 ; result
 ;   returns a boolean value (1 or 0) or null
 ;     =1 if employee passed screen
 ;        (PTPF true and employee is PTP with memo) OR
 ;        (PTPF false and employee is not PTP with memo)
 ;     =0 if employee did not pass screen
 ;     =null value if required inputs were not provided
 ;
 N PRSRET,PTPM
 S PTPF=$G(PTPF)
 S PRSRET="" ; init return
 I PRSIEN,PSTDT D
 . ; determine if employee is PT physician with memo on the posting date
 . S PTPM=$S($$MIEN^PRSPUT1(PRSIEN,PSTDT)>0:1,1:0)
 . ; apply screen
 . S PRSRET=$S(PTPF&PTPM:1,'PTPF&'PTPM:1,1:0)
 ;
 Q PRSRET
 ;
 ;PRSATP
