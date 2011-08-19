SDPPMT1 ;ALB/CAW - Patient Profile - Means Test ; 5/14/92
 ;;5.3;Scheduling;**6,32**;Aug 13, 1993
 ;
 ;
EN1 ; Gather Means Test Info
 N SDM1,SDMT,SDMT1,SDYN,SDM2,SDSTART,SDSTOP
 S (SDM2,SDX)=0,SDFST=20,SDSEC=60,SDLEN=20,$P(SDASH,"-",IOM+1)="",SDDT=SDED_.99,SDSTART=$S($D(SDBEG):SDBEG,1:SDBD),SDSTOP=$S($D(SDEND):SDEND,1:SDED)
 I $D(SDY) S SDDT=$P(^DGMT(408.31,SDY,0),U)
 F  S SDX=$$LST^DGMTU(DFN,SDDT) Q:SDX']""  S SDDT=$P(SDX,U,2) Q:'$D(SDY)&(SDDT>SDED!(SDDT<SDBD))  D INIT Q:(SDPRINT)!$D(SDY)  S SDDT=SDDT-1
 Q
 ;
INIT ; Set up means test variables
 D ALL^DGMTU21(DFN,"VSC",SDDT,"IPR")
 I $D(DGINR("V")) S SDMT=$G(^DGMT(408.22,+DGINR("V"),0))
 I $D(DGINR("V")) S SDM1=$G(^DGMT(408.21,+DGINC("V"),0))
 S SDMT1=$G(^DGMT(408.31,+SDX,0))
 D INFO
 Q
INFO ;
 ;
DATE ; Date of Test and Status
 S X="",X=$$SETSTR^VALM1("Date of Test:",X,6,13)
 S X=$$SETSTR^VALM1($$FTIME^VALM1(+SDMT1),X,SDFST,SDLEN)
 S X=$$SETSTR^VALM1("Status:",X,52,7)
 S X=$$SETSTR^VALM1($P($G(^DG(408.32,+$P(SDMT1,U,3),0)),U),X,SDSEC,SDLEN)
 D SET(X)
NET ; Net Worth and Income
 S X="",X=$$SETSTR^VALM1("Net Worth:",X,9,10)
 S X=$$SETSTR^VALM1($P(SDMT1,U,5),X,SDFST,SDLEN)
 S X=$$SETSTR^VALM1("Income:",X,52,7)
 S X=$$SETSTR^VALM1($P(SDMT1,U,4),X,SDSEC,SDLEN)
 D SET(X)
DATEC ; Date Completed and Deductible Expenses
 S X="",X=$$SETSTR^VALM1("Date Completed:",X,4,15)
 I $P(SDMT1,U,7)'="" S X=$$SETSTR^VALM1($$FTIME^VALM1($P(SDMT1,U,7)),X,SDFST,SDLEN)
 S X=$$SETSTR^VALM1("Deductible Exp.:",X,43,16)
 S X=$$SETSTR^VALM1($P(SDMT1,U,15),X,SDSEC,SDLEN)
 D SET(X)
COMP ; Completed By and Agreed to Pay Deductible
 S X="",X=$$SETSTR^VALM1("Completed By:",X,6,13)
 S X=$$SETSTR^VALM1($P($G(^VA(200,+$P(SDMT1,U,6),0)),U),X,SDFST,SDLEN)
 S SDYN=$S($P(SDMT1,U,11)=1:"YES",$P(SDMT1,U,11)=0:"NO",1:"UNKNOWN")
 S X=$$SETSTR^VALM1("Will Pay Deduct.:",X,42,17)
 S X=$$SETSTR^VALM1(SDYN,X,SDSEC,SDLEN)
 D SET(X)
DEC ; Declined to Give Income Info and Date Category Changed
 S X=""
 I $P(SDMT1,U,14)'="" D
 .S X=$$SETSTR^VALM1("Decl To Give Info:",X,1,18)
 .S SDYN=$S($P(SDMT1,U,14)=1:"YES",$P(SDMT1,U,14)=0:"NO",1:"UNKNOWN")
 .S X=$$SETSTR^VALM1(SDYN,X,SDFST,SDLEN)
 I $P(SDMT1,U,9)'="" D
 .S X=$$SETSTR^VALM1("Date Cat. Changed:",X,41,18)
 .S X=$$SETSTR^VALM1($$FTIME^VALM1($P(SDMT1,U,9)),X,SDSEC,SDLEN)
 D:X'="" SET(X)
NO ; No Longer Required Date and Category Changed By
 S X=""
 I $P(SDMT1,U,17)'="" D
 .S X=$$SETSTR^VALM1("No Lon. Req. Date:",X,1,18)
 .S X=$$SETSTR^VALM1($$FTIME^VALM1($P(SDMT1,U,17)),X,SDFST,SDLEN)
 I $P(SDMT1,U,8)'="" D
 .S X=$$SETSTR^VALM1("Cat. Changed By:",X,43,16)
 .S X=$$SETSTR^VALM1($P($G(^VA(200,+$P(SDMT1,U,8),0)),U),X,SDSEC,SDLEN)
 D:X'="" SET(X)
 D ^SDPPMT2
 Q
SET(X) ; Set in ^TMP global for display
 ;
 S SDLN=SDLN+1,^TMP("SDPPALL",$J,SDLN,0)=X
 Q
QUIT ;
 K SDASH,SDFST,SDLEN,SDM,SDM1,SDMT,SDMT1,SDSEC,SDX,SDY,SDYN,^TMP("SDPPENR",$J)
 Q
