PRSRL4 ;WIRMFO/JAH-INDIVIDUAL EMPLOYEE LEAVE USE PATTERN ;22-JAN-1998
 ;;4.0;PAID;**2,16,19,21,35,103**;Sep 21, 1995
SUP ;
 N SSN,PRSTLV,PRSAI,PRSR,TLE,TLI,SW,PRSRDUZ,USR,XX,YY
 N ALOO,FR,TO,TOP,FRP,EMPNAM
 ;
 ; DA(2)= stores pay periods in Year-pay period # format
 ;
 ; set flags for supervisor entry point
 S PRSTLV=3,(PRSAI,PRSR)=1
 ;
 ; Select 1 T&L unit.
 ; Defined after TLESEL call
 ;    PRSRDUZ, USR = user IEN in PAID EMPLOYEE (450)
 ;    SSN          = users SSN
 ;    SW
 ;    TLE          = selected T&L unit code
 ;    TLI          = selected T&L unit IEN in T&L unit file (455.5)
 ;    TLE(1)       = "T&L unit code ^ T&L unit name"
 ;    TLE(1,n)     = "T&L unit member IEN in file (450) ^ member name"
 D TLESEL^PRSRUT0 G Q:$G(TLE)=""!(SSN="") W !
 ;
 ; TLI    = T&L unit of User
 S TLI=$S(PRSRDUZ:$P($G(^(0)),"^",8),1:"000")
 ;
EN1 ; User look up 4 employee under T&L x-ref in 450
 S DIC="^PRSPC(",DIC(0)="AEQZ"
 S D="ATL"_$P(TLE(1),"^",1)
 S DIC("S")="I $$INXR^PRSRL1($P(TLE(1),U),Y)"
 S DIC("A")="Enter employee name: "
 D IX^DIC
 G Q1:$D(DUOUT)!$D(DTOUT)!(Y=-1)
 ; Save IEN (450) of selected employee in PRSRY.  PRSRY1 = 0 node.
 ; D0 = selected employee name.  PRSRSSN = SSN from 0 node of 450.
 S PRSRY=Y
 S PRSRY1=$S($D(Y(0)):Y(0),1:"") ;     0 node of selected emp from 450
 S D0=$P(PRSRY,"^") ;                  Selected employee IEN from 450
 S EMPNAM=$P(PRSRY,"^",2) ;            employee Name from 450
 S PRSRSSN=$P(PRSRY1,"^",9) ;          employee SSN
 S SSN=$E(PRSRSSN,1,3)_"-"_$E(PRSRSSN,4,5)_"-"_$E(PRSRSSN,6,9)
 S TLUNIT=$P(PRSRY1,"^",7) ;           employee Station Number
 S TLE=$P(^PRSPC(D0,0),"^",8) ;        employ T&L unit
 ;
 ; Get cost center/org code (ccoc) description from selected 
 ; employee record.  If no description send a bulletin to G.PAD 
 ; & continue using numeric codes instead.
 S ORG=$$CCORG^PRSRUTL(PRSRY1)
 I +ORG>0 D CCORGBUL^PRSRUTL(ORG,PRSRDUZ,0,EMPNAM)
 ;
 ;SW should always get set to zero.
 S SW=$S(PRSRY'=-1:0,1:1)
 ;
 D CHKTLE^PRSRUTL G EN1:'STFSW W !
 ;
ASK ; ask begin date 4 report
 S %DT("A")="Enter Beginning Date "
 S %DT(0)=-DT ;      date must be <= to today
 S %DT("B")="T" ;    default response of today
 S %DT="AEX" ;       ask user, echo, must include day & month
 D ^%DT
 S FR=Y ;            FR = FileMan 4mat of begin date
 G Q1:$D(DTOUT)!(X="")!(X="^"),MSG2:FR=-1
 ;
 ; ask end date 4 report
 S %DT("A")="Enter Ending Date "
 S %DT("B")="T" ;    default date of today
 S %DT(0)=FR ;       end date must be > begin date
 S %DT="AEX" ;       ask, echo, day & month
 D ^%DT
 S TO=Y
 G Q1:$D(DTOUT)!(X="")!(X="^"),MSG2:TO=-1
 ;
 ; Get external representation of begin & end date 4 display
 ; XX = begin date
 ; YY = end date
 S Y=FR D DD^%DT S XX=Y
 S Y=TO D DD^%DT S YY=Y
 ;
 ; Get pay periods (FRP & TOP) that begin & end dates fall in.
 ; Vars returned from PP call are  DAY & PPE
 N PPE,D1 S D1=FR D PP^PRSAPPU S FRP=PPE
 N PPE,D1 S D1=TO D PP^PRSAPPU S TOP=PP4Y
 ;
 ; Ask user if they want to see all leave, including days off &
 ; Holidays or if they want to see only leave taken immediately
 ; be4 or after Holidays & days off.
 ; ALOO =  users choice ALL, Only or Uparrow (A or O or ^)
 S ALOO=$$ASKDSPLY^PRSRL41()
 Q:ALOO["^"
 ;
 ;
 S ZTRTN="START^PRSRL4",ZTDESC="EMPLOYEE LEAVE USAGE PATTERN" D ST^PRSRUTL,LOOP,QUE1^PRSRUT0 G Q1:POP!($D(ZTSK))
 ;
 ;
START ;
 ; Set up variable 4 Leave check call CKTOUR^PRSUT0 in subroutine LEV
 S LVT=";AL:Annual Leave;SL:Sick Leave;WP:Leave Without Pay;ML:Military Leave;TV:Travel;HX:Holiday Excuse;CB:Family Care;"
 S LVT=LVT_"AA:Authorized Absence;AD:Adoption;CU:Comp Time/Credit Hrs.;DL:Donor Leave;NL:Non-Pay Annual Leave;RL:Restored Annual Leave;"
 S (CNT,POUT,DAT(1))=0
 K ^TMP($J)
 S ^TMP($J,"USE")="EMPLOYEE LEAVE PATTERN"
 S ^TMP($J,"US",0)="COMMENTS"
 ;
 ;loop thru Time & Attendance file, 4 digit yr "AB" Pay Period X-ref.
 ; Start loop w/ payperiod previous begin date
 ; Quit loop when pay per. is past end date 
 ;
 S DA(2)=$$PREP^PRSAPPU(FRP) ;call to get previous pay period
 ;
 F II=0:0 S DA(2)=$O(^PRST(458,"AB",DA(2))) Q:DA(2)=""!(DA(2)]TOP)  D
 .; get pay period IEN
 .  S DA(1)=$O(^PRST(458,"AB",DA(2),0))
 .;
 .; FM dates string 4 curr pay per
 .  S DATES=$G(^PRST(458,DA(1),1))
 .;
 .; get days of week 4 current pay period (Sun  9-Jan-94^...^)
 .S DAYSOFWK=$G(^PRST(458,DA(1),2))
 .;
 .; loop thru days of employee's pay period
 .  S DA=0
 .  F I=0:0 S DA=$O(^PRST(458,DA(1),"E",D0,"D",DA)) Q:DA'>0  D
 ..;
 ..;  quit if outside date range
 ..   Q:$P(DATES,"^",DA)<FR!($P(DATES,"^",DA)>TO)
 ..;
 ..;  tour of duty 4 current day
 ..   S TOD=$P($G(^PRST(458,DA(1),"E",D0,"D",DA,0)),"^",2)
 ..;
 ..;  tour of duty 4 next day
 ..   S TOD(1)=$P($G(^PRST(458,DA(1),"E",D0,"D",DA+1,0)),"^",2) Q:TOD=""
 ..;
 ..   D LEV
 ..   Q
 .  Q
 S DAT=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 U IO I 'CNT D HDR1^PRSRL41 W !,"|",?10,"No leave Usage on File within this Date Range.",?79,"|" S POUT=1 D NONE G Q1
 D ^PRSRL41
 G Q1:POUT I CNT D VLIDSH0^PRSRL41 S CODE="L005",FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT2^PRSRUT0
 ;
 ;
Q I $E(IOST)="C"!($G(IOT)="VTRM") R !!,"Press Return/Enter to continue. ",X:DTIME
Q1 K %9,%DT,%RET,%TG,C,CNT,CODE,COM,COS,COSORG,D0,D1,DA,DAT,DATE,DATES,DATT,DAY,DDH,DIC,EDT,FOOT,FR,FRP,I,II,INX,K,LEV,LVT,NAM,ORG,POP,POUT,PP,PPE,PPI,PRSPRSR,PRSRY,PRSRY1
 K RG,SSN,STFSW,SW,TC,TIM,TL,TLE,TLEV,TLI,TLUNIT,TO,TOD,TOP,TOUR,TOUR1,TYL,X,X1,X2,XX,Y,YY,Z,Z1,ZTDESC,ZTRTN,ZTSAVE,^TMP($J) D ^%ZISC S:$D(ZTSK) ZTREQ="@" K ZTSK W:$E(IOST)="C"!($G(IOT)="VTRM") @IOF
 Q
LEV ;
 S DAY=$P($P(DAYSOFWK,"^",DA)," ") ;  current day of week (SUN, MON...)
 S DAY(1)=$P($P(DAYSOFWK,"^",DA+1)," ") ; next day of week
 ;
 ; TOUR = ((day off) or (NODE with either 
 ;        (start and stop times) or (null for worked entire tour))
 S TOUR=$S(TOD'=1:$G(^PRST(458,DA(1),"E",D0,"D",DA,2)),1:"DO")
 ;
 ;Check 4 leave in LVT variable (SL,AL,ML,TV,HX)
 ;if today not a day off
 ;Quit if employee worked entire tour (tour="")
 D CKTOUR^PRSRUT0(.TOUR):TOD'=1 Q:TOUR=""
 ;
 ;TOUR(1) = same as TOUR exept next day.
 S TOUR1=$S(TOD(1)'=1:$G(^PRST(458,DA(1),"E",D0,"D",DA+1,2)),1:"DO")
 ;
 ;Check 4 leave in LVT variable (SL,AL,ML,TV,HX)
 ;if today not a day off
 ;Quit if employee worked entire tour, unless they've selected ALL
 D CKTOUR^PRSRUT0(.TOUR1):TOD(1)'=1 Q:((TOUR1="")&(ALOO'="A"))
 ;
 ;Test whether leave should be saved for display
 Q:'$$SHOWLEAV()
 ;
 ;
 ;If we've made it this far store the leave or day off in the temp
 ;global for display, unless it's already there.
 I $G(DAY)'="",$G(^TMP($J,"USE",CNT,DA(2),$P(DATES,"^",DA),DAY))'=TOUR D
 .  S CNT=CNT+1
 .  S ^TMP($J,"USE",CNT,DA(2),$P(DATES,"^",DA),DAY)=TOUR
 .  S ^TMP($J,"US",CNT)=$G(^PRST(458,DA(1),"E",D0,"D",DA,3))
 ;
 W:'$D(ZTSK)&($E(IOST)'="P")!($G(IOT)="VTRM")&($R(30)) "."
 ;
 I $G(DAY(1))'="",$G(^TMP($J,"USE",CNT,DA(2),$P(DATES,"^",DA+1),DAY(1)))'=TOUR1 D
 .  S CNT=CNT+1
 .  S ^TMP($J,"USE",CNT,DA(2),$P(DATES,"^",DA+1),DAY(1))=TOUR1
 .  S ^TMP($J,"US",CNT)=$G(^PRST(458,DA(1),"E",D0,"D",DA+1,3))
 ;
 W:'$D(ZTSK)&($E(IOST)'="P")!($G(IOT)="VTRM")&($R(30)) "."
 ;
 ;
 S DAT(1)=$P(DATES,"^",DA+1),DAY(2)=DAY
 Q
NONE I IOSL<66 F I=$Y:1:IOSL-5 D VLIN0^PRSRL41
 D HDR^PRSRL41
 Q
MSG1 W !!,*7,"*** Employee name not found." G EN1
MSG2 W !!,*7,"The Date was invalid." G ASK
 ;
 ;Save all variables 4 tasked job
LOOP F X="ALOO","FR","FRP","TLE","TLI","TO","TOP","DT","NAM","SSN","SW","LOC","POS","PRSRDUZ","PRSRY","PRSRY1","COS","^TMP($J,""USE"",","ORG","D0","TLUNIT","XX","YY","PRSRSSN" S ZTSAVE(X)=""
 Q
 ;=====================================================================
SHOWLEAV() ;
 ;If user has selected 'All', then show leave (return true)
 ;
 ;Otherwise, don't store leave 4 display IF: 
 ; (next day tour = day off) & (current day tour = Holiday) or
 ; (todays tour = day off) & (next days tour = day off) or
 ; user has selected only leave around days off & 
 ; (todays tour is not = day off) & (next day is not day off)
 ;
 Q:ALOO="A" 1
 S RTN=1
 I ((TOD=1&(TOUR1["HX"))!(TOD(1)=1&(TOUR["HX"))!(TOUR="DO"&(TOUR1="DO"))!((ALOO="O")&(TOUR'="DO"&(TOUR1'="DO")))) S RTN=0
 Q RTN
