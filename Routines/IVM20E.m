IVM20E ;ALB/CPM - IVM V2.0 ENVIRONMENT CHECK ROUTINE ; 16-MAY-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;
 ; This routine contains environmental checks which get executed
 ; before the initialization is allowed to run.  DIFQ is killed
 ; if a problem is encountered.
 ;
 ;
 D NOW^%DTC S IVMBDT=$H,DT=X,Y=%
 W !!,"Initialization Started: " D DT^DIQ W !!
 ;
 S IOP="HOME" D ^%ZIS
 D DUZ,ENV:$D(DIFQ),TYPE:$D(DIFQ)
 ;
 I '$D(DIFQ) W !,"IVM V2.0 INITIALIZATION ABORTED..." K IVMBDT
Q Q
 ;
 ;
 ;
DUZ ; Check to see if a valid user is defined and that DUZ(0)="@"
 N X
 S X=$O(^VA(200,+$G(DUZ),0))
 I X']""!($G(DUZ(0))'="@") W !!?3,"The variable DUZ must be set to a valid entry in the NEW PERSON file",!?3,"and the variable DUZ(0) must equal ""@"" before you continue!" K DIFQ
 Q
 ;
 ;
ENV ; Make sure required packages/patches are installed.
 N X
 I $G(^DG(43,1,"VERSION"))<5.3 K DIFQ W !,?3,"PIMS Version 5.3 must be installed first!"
 I +$G(^DD(350,0,"VR"))<2 K DIFQ W !?3,"Integrated Billing Version 2.0 must be installed first!"
 S X="IBCOIVM1" X ^%ZOSF("TEST") E  K DIFQ W !?3,"Integrated Billing patch IB*2*6 must be installed first!"
 I '$O(^DIC(4.2,"B","IVM.VA.GOV",0)) W !?3,*7,"Patches XM*DBA*51 and XM*DBA*52 are needed!" K DIFQ
 I '$D(^ORD(100.99)) W !?3,*7,"You must install ORDER ENTRY/RESULTS REPORTING before continuing!" K DIFQ
 I $G(^DD(770,0,"VR"))<1.5 W !?3,*7,"You must be running version 1.5 or higher of the DHCP HL7 package",!?6,"prior to running this installation!" K DIFQ
 Q
 ;
 ;
TYPE ; Ask user if this installation is for a test account or live account.
 S DIR(0)="SM^1:PRODUCTION;0:TEST"
 S DIR("A")="Enter type of account you are installing in"
 S DIR("?")="Enter P for production account or T for test account"
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  S DIR("?",I)=X
 D ^DIR
 I Y=""!(Y["^") W:Y="" !!,*7,"User Timed Out..." K DIFQ
 S IVMPROD=Y
 K DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 Q
 ;
 ;
TEXT ; Text for help for production/test question
 ;;If you are currently installing this IVM package in a production
 ;;account, you must answer P.  If you are installing in a test account
 ;;you must answer T.
 ;;
 ;;The answer to this question is extremely important as it determines
 ;;where income data for patients gets transmitted.  Test data must not
 ;;be transmitted to the IVM Center's production account.  Production
 ;;data, likewise, will not be evaluated properly if it is not sent to
 ;;the IVM Center's production account.
 ;;
 ;;Enter '^' to abort this installation.
 ;;
 ;;QUIT
