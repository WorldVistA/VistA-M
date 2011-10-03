DGPWB ;ALB/CAW/MLR - Patient Wristband Print ; 9/27/00 3:40pm
 ;;5.3;Registration;**62,82,287**;Aug 13, 1993
 ;  -**287** Substituting SS# when Primary long ID missing in .36 
 ;
EN ; Ask patient name
 ; This is used when printing a wristband from the menu
 ;
 N DFN,VAIN,VAERR,DIC,Y,OPTIND
 S OPTIND=0
 S DIC(0)="AEMQZ",DIC="^DPT("
 D ^DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) G ENQ
 S DFN=+Y D INP^VADPT
 S:'$G(VAIN(4)) OPTIND=1
 I $G(VAIN(4)),('$$DIVISION($P(VAIN(4),U))) W !,"Printing Wristbands for inpatients at this division is set to no." G ENQ
 I OPTIND S Y=$$DEVICE() G:'Y!(Y>1) ENQ D SET G ENQ
 D START(DFN)
ENQ K DTOUT,DUOUT Q
 ;
START(DFN) ;Start
 ; This is where it will be used when in admit or transfer
 ;  Input is patient IFN
 ;
 N WARD,DIVISION,PRINT,Y
 D INP^VADPT I '$G(VAIN(4)) G STARTQ
 S WARD=+VAIN(4)
TRANS I $G(DGPMA),'$$TRCHK($P(DGPMA,U,18)) G STARTQ
 ; Check to see if no change was made on edit
 I $D(DGPMA),$D(DGPMP),$P(DGPMA,U,18)=41 N Y D  G DIV:Y
 .S Y=$O(^UTILITY("DGPM",$J,2,"")) Q:'Y
 .I $P(^UTILITY("DGPM",$J,2,Y,"P"),U,6)=$P(^UTILITY("DGPM",$J,2,Y,"A"),U,6) S Y=0
 I $D(DGPMA),$D(DGPMP),($P(DGPMA,U,6)=$P(DGPMP,U,6)) G STARTQ
 ; Check to see if division parameter to print wristband is on
DIV I '$$DIVISION(WARD) G STARTQ
 I $G(DGPMA),'$$ASK G STARTQ
 ; Prompt for device - quit if device is not selected or is queued
 S Y=$$DEVICE() I 'Y!(Y>1) G STARTQ
 ; Set up lines to print
 D SET
STARTQ Q
 ;
DIVISION(WARD) ; Obtain Divison from Ward Location
 ;
 N Y,DIVISION
 S Y=0
 ; Print Patient Wristband parameter
 S DIVISION=$P($G(^DIC(42,+WARD,0)),U,11)
 I '$P(^DG(43,1,"GL"),U,2) S DIVISION=$O(^DG(40.8,0))
 I $P($G(^DG(40.8,+DIVISION,0)),U,8)="Y" S Y=1
 Q Y
 ;
SET ;Set the lines to print
 ;This is where taskman will start when job is queued.
 ;  Input needed is DFN and WARD (WARD is set to IFN of WARD LOCATION)
 ;
 N CNT,BAND,DATA,FINAL,IFN,ITEMD,LINE,X,WHERE
 D DEM^VADPT
 ;
 ; If a different wristband is going to be used-change name in "B" x-ref
 ;
 S LINE=0 S IFN=$O(^DIC(39.1,"B","WRISTBAND",0)) Q:'IFN
 F  S LINE=$O(^DIC(39.1,IFN,1,LINE)) Q:'LINE  D
 .S DATA=0 F  S DATA=$O(^DIC(39.1,IFN,1,LINE,1,DATA)) Q:'DATA  D
 ..S ITEMD=^DIC(39.1,IFN,1,LINE,1,DATA,0)
 ..S X=$G(^DIC(39.2,+ITEMD,1)) X X
 ..;
 ..;Checking for PID# and substituting SS# if missing **287**
 ..I Y="",$G(^DIC(39.2,+ITEMD,0))="PID" D PID
 ..;
 ..S BAND(LINE,-DATA)=$E(Y,1,$P(ITEMD,U,3))_"^"_$P(ITEMD,U,2)
 .S WHERE="" F  S WHERE=$O(BAND(LINE,WHERE)) Q:'WHERE  D
 ..I $D(BAND(LINE,(WHERE+1))) S $P(BAND(LINE,WHERE),U,2)=($P(BAND(LINE,WHERE),U,2))-($L($P(BAND(LINE,(WHERE+1)),U)))
 ..S $P(FINAL(LINE)," ",$P(BAND(LINE,WHERE),U,2))=$P(BAND(LINE,WHERE),U)
 F CNT=1:1:99 Q:'$D(FINAL(CNT))  S X="LINE"_CNT S @X=FINAL(CNT)
 D PRINT
 D:'$D(ZTQUEUED) ^%ZISC
 ; This is where the call to update the allergy file
 S X="GMRAMCU0" X ^%ZOSF("TEST") I $T D IDBAND^GMRAMCU0(DFN,DT,DUZ)
 D END
 Q
 ;
PID ;Substituting SS# for missing PID#  **287**  MLR
 S Y=$P($G(^DPT(DFN,0)),U,9)
 D
 . I Y S Y=$E(Y,1,3)_" "_$E(Y,4,5)_" "_$E(Y,6,$L(Y)) Q
 . S Y="NO ID FOUND" Q
 Q  ;PID
 ;
END ;Clean up variables
 K VARIABLE
 N CNT,VAR
 F CNT=1:1:99 S VAR="LINE"_CNT Q:'$D(@VAR)  K @VAR
 Q
 ;
PRINT ; Print the wristband
 ;
 ; Change call from BL to whatever device is added in DGPWBD
 ;
 D BL^DGPWBD
 Q
 ;
DEVICE() ;
 S Y=0
DEVEN S %ZIS="Q",%ZIS("A")="PRINT WRISTBAND ON DEVICE: ",%ZIS("B")=""
 D ^%ZIS I POP G DEVICEQ
 I $E(IOST,1,2)'["P-" W !,"A printer must be selected." G DEVEN
 I '$D(IO("Q")) S Y=1 G DEVICEQ
 S Y=$$QUE
DEVICEQ Q Y
 ;
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Patient Wristband Print",ZTRTN="SET^DGPWB"
 F X="WARD","DFN" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
 ;
TRCHK(TYPE) ;Check to see if appropriate type to continue
 ;
 N MVMT,Y
 S Y=0
 S MVMT=$P($G(^DG(405.2,+TYPE,0)),U,2) I MVMT=1 S Y=1 G TRCHKQ
 I "^4^13^14^22^23^24^41^44^45^"[(U_TYPE_U) S Y=1
TRCHKQ Q Y
 ;
ASK() ;Ask if they want to print
 W ! S DIR("A")="Do you want to print a Patient Wristband"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S Y=0
ASKQ Q Y
