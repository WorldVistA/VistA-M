DGQESC0 ;ALB/JFP - VIC CLINIC SCAN ROUTINE ; 01/09/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SDATE() ; -- Call to Dir to request start date
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 ;
 S DIR("A")="Start Date: "
 S Y=DT X ^DD("DD")
 S DIR("B")=Y
 S DIR(0)="DAO^::EX^"
 S DIR("?")="  - Enter date to start search, the default is today"
 D ^DIR K DIR
 ; -- up arrow/timeout
 I ($D(DTOUT)!$D(DUOUT)!$D(DIROUT)) Q -1
 ; -- null response
 I $D(DIRUT) K DTOUT,DUOUT,DIROUT,DIRUT Q 1
 ; -- returns start date
 Q Y
 ;
EDATE(PDATE) ; -- Call to Dir to request start date
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT,DEFDATE
 ;
 S DIR("A")="End Date: "
 ;
 I $D(PDATE) S Y=PDATE X ^DD("DD") S DEFDATE=Y
 I '$D(PDATE) S (Y,PDATE)=DT X ^DD("DD") S DEFDATE=Y
 S DIR("B")=DEFDATE
 S DIR(0)="DAO^"_PDATE_"::%DT"
 S DIR("?")="  - Enter date to end search,can not be less than start date"
 D ^DIR K DIR
 ; -- up arrow/timeout
 I ($D(DTOUT)!$D(DUOUT)!$D(DIROUT)) Q -1
 ; -- null response
 I $D(DIRUT) K DTOUT,DUOUT,DIROUT,DIRUT Q 1
 ; -- returns end date
 Q Y
 ;
XDAYS ; Ask how many days to scan for
 N XFLAG,DIR,Y,X1,X2,X
 ;
 S XFLAG=0
 S DIR(0)="N0^1:90"
 S DIR("A")="Number of days to scan in advance"
 S DIR("B")=7
 S DIR("?")="Enter number of days to scan in advance."
 D ^DIR
 I (Y="^") Q
 S XFLAG=1
 D NOW^%DTC S (SCANDATE,X1)=%
 S X2=Y
 D C^%DTC
 I X="" Q
 S SCANDATE=X
 Q
 ;
END ; -- End of Code
 Q
 ;
