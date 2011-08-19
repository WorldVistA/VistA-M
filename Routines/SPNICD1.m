SPNICD1 ;SAN/WDE/Report of PT's with particular ICD9's
 ;;2.0;Spinal Cord Dysfunction;**14**;01/02/1997
EN ;prompt user for ICD's that they want to look for
 K SPNICD
 S SPNEXIT=0
 D REG I SPNEXIT=1 D ZAP Q
 D ASK I SPNEXIT=1 D ZAP Q
 I SPNANS=1 D RANGE I SPNEXIT=1 D ZAP Q
 I SPNANS=2 D SINGLE I SPNEXIT=1 D ZAP Q
 D DATE I SPNEXIT=1 D ZAP Q
 D DEV I SPNEXIT=1 D ZAP Q
 D BEG I SPNEXIT=1 D ZAP K SPNEXIT Q
 Q
 ;-----------------------------------------------------------------
ASK ;see if they want a range..
 W !,"Would you like to sort on a Range of ICD9 codes"
 S %=2 D YN^DICN
 I %[0 W !?10,"Enter Y or Yes if you want to sort on a range of ICD9 codes.",!?10,"Enter N or No if you want to look for specific ICD9 codes." G ASK
 I %<1 S SPNEXIT=1 Q
 S SPNANS=%
 Q
 ;-----------------------------------------------------------------
REG W !!,"Do you want patients in the Registry only"
 S %=1 D YN^DICN
 I %[0 D  G REG
 . W !?10,"Enter Y or Yes if you want just patients in the Registry,"
 . W !?10,"Or enter N or No to include all Patients."
 I %<1 S SPNEXIT=1 Q
 S SPNIN=$S(%=1:"JUST",1:"ALL")
 Q
 ;------------------------------------------------------------------
RANGE ;tag allow user to input a range start and end icd's
 ;Note the set up of spnary its the value
 S DIC(0)="AEQMNZ",DIC("A")="Starting ICD9 Code: "
 S DIC="^ICD9("
 D ^DIC I Y<1 S SPNEXIT=1 Q
 I Y>1 S SPNRAN1=$P(Y,U,2)
 S DIC("A")="Ending ICD9 code: "
 D ^DIC I Y<1 S SPNEXIT=1 Q
 I Y>1 S SPNRAN2=$P(Y,U,2)
 I SPNRAN2<SPNRAN1 W !," Your ending value is lower then your starting value !!" S SPNEXIT=1 Q
 Q
 ;------------------------------------------------------------------
SINGLE ;tag allows uses to input single code to search for
 S DIC(0)="AEQMNZ",DIC("A")="What ICD9's would you like to look for? "
 S DIC="^ICD9("
 F  D  Q:Y<1
 .D ^DIC
 .Q:Y<1
 .S SPNARY($P(Y,U,2))=Y
 .Q
 I $D(SPNARY)=0 S SPNEXIT=1 Q
 Q
 ;------------------------------------------------------------------
DEV ;Toss in the device call later
 S SPNLEXIT=""
 S ZTSAVE("SPN*")=""
 D DEVICE^SPNPRTMT("JUMPIN^SPNICD1","ICD9 Code Search",.ZTSAVE) Q:SPNLEXIT
TASK ;
 I SPNIO="Q" D ZAP S SPNEXIT=1 Q  ;queued from spnprtmt
 Q
DATE ;
 K %DT
 S X1=DT,X2=-15 D C^%DTC S Y=X X ^DD("DD") S %DT("B")=$P(Y,"@",1)
 S %DT("A")="Enter an Admission STARTING date: "
 S %DT="AE"
 D ^%DT I Y=-1 W !,"Option aborted!" S SPNEXIT=1 Q
 S SPNSTRT=Y
 ;ending date
 S %DT("A")="Enter an Admission ENDING date: "
 S %DT(0)=SPNSTRT
 S X1=SPNSTRT,X2=15 D C^%DTC S Y=X X ^DD("DD") S %DT("B")=$P(Y,"@",1)
 S %DT="AE"
 D ^%DT I Y=-1 W !,"Option aborted!" S SPNEXIT=1 Q
 S SPNEND=Y_.2359
 Q
ZAP ;kill of vars and end the routine
 K SPNPTF,SPNSTRT,SPNARY,SPNADDT,SPNX,SPNY,%,SPNEND,SPNSTRT,%DT,SPNRAN1,DIC,DIR,%,X,Y
 K X1,X2,X,Y,SPNCNT,SPNZ,SPNTAB,SPNSSN,SPNREG,SPNRAN2,SPNAN1,SPNPA,SPNLVL,SPNIN,SPNDFN,SPNDATA,SPNANS,SPNAM,J,I
 K ^UTILITY($J)
 Q
 ;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
BEG ;Start looping through the af xfr of the PTF file
JUMPIN K ^UTILITY($J)
 S SPNADDT=SPNSTRT,SPNCNT=0
 F  S SPNADDT=$O(^DGPT("AF",SPNADDT)) Q:(SPNADDT="")!('+SPNADDT)  Q:SPNADDT>SPNEND  S SPNCNT=SPNCNT+1 D
 .I $E(IOST,1)["C" I SPNCNT#10=0 W "."
 .S SPNPTF="",SPNPTF=$O(^DGPT("AF",SPNADDT,SPNPTF)) Q:SPNPTF=""
 .D TEST
 .Q
 D ^SPNICD2 D ZAP Q
 Q
TEST ;test pt in 154 then icds
 S SPNDFN=$P($G(^DGPT(SPNPTF,0)),U,1)
 I SPNIN="JUST" Q:$D(^SPNL(154,SPNDFN,0))=0  ;NOT IN 154
 S SPNDATA=$G(^DGPT(SPNPTF,70))
 ;spnans=1 range spnasn=2 just the ones entered
 S SPNX=0 S SPNX=$G(^DGPT(SPNPTF,70)) Q:SPNX=""
 S SPNY=0 F A=10,16,17,18,19,20,21,22,23,24 S SPNY=$P(SPNDATA,U,A) I +SPNY D
 .S SPNZ=$P(^ICD9(SPNY,0),U,1)
 .I SPNANS=1 I (SPNZ>SPNRAN1) I (SPNZ<SPNRAN2) S ^UTILITY($J,SPNDFN,SPNPTF)=SPNDATA
 .I SPNANS=2 I $D(SPNARY(SPNZ)) S ^UTILITY($J,SPNDFN,SPNPTF)=SPNDATA
 .Q
 Q
