SDAMOWB ;ALB/CAW - Waiting Times Build Arrays; 8-NOV-93
 ;;5.3;Scheduling;**12**;Aug 13, 1993
 ;
STORE(HOW,DIV,CLIN,STOP,DATE,PAT) ;save data in tmp variable
 ;SDCLIN^SDSTOP^SDDAY^SDDIV^DFN^SDCHKIN^SDCHKOUT^SDWTTIME^SDOTIME^SDTTTIME
 ;   1      2      3     4    5     6       7        8         9     10
 ;calc times
 S SDWTTIME=$$MIN(SDCHKIN,SDT)
 S SDOTTIME=$$MIN(SDT,SDCHKOUT)
 S SDTTTIME=$$MIN(SDCHKIN,SDCHKOUT)
 D SET(HOW,CLIN,STOP,DATE,PAT)
 I "^1^2^5^"[(U_HOW_U) D
 .S ^TMP("SDWAIT",$J,DIV,LEVEL1,LEVEL2,LEVEL3)=SDDATA_U_SDWTTIME_U_SDOTTIME_U_SDTTTIME
 I "^3^4^"[(U_HOW_U) D
 .S ^TMP("SDWAIT",$J,DIV,LEVEL1,LEVEL2,LEVEL3,LEVEL4)=SDDATA_U_SDWTTIME_U_SDOTTIME_U_SDTTTIME
 S SDX=$G(^TMP("SDWTTOT",$J,DIV,LEVEL1,"PRIM")) S ^("PRIM")=$$AUGMENT(SDWTTIME,SDOTTIME,SDTTTIME,SDX)
 S SDX=$G(^TMP("SDWTTOTG",$J,"GRAND")) S ^("GRAND")=$$AUGMENT(SDWTTIME,SDOTTIME,SDTTTIME,SDX)
 S SDX=$G(^TMP("SDWTTOTD",$J,SDDIV,"DIV")) S ^("DIV")=$$AUGMENT(SDWTTIME,SDOTTIME,SDTTTIME,SDX)
 Q
AUGMENT(WAIT,WAIT1,TOT,NODE) ;increment summary node
 ;NODE=#appts^cum min fm ci to appt^cum min fm appt to co^cum total min
 ;           1         2                    3                   4
 S $P(NODE,U,1)=$P(NODE,U,1)+1
 S $P(NODE,U,2)=$P(NODE,U,2)+WAIT
 S $P(NODE,U,3)=$P(NODE,U,3)+WAIT1
 S $P(NODE,U,4)=$P(NODE,U,4)+TOT
 Q NODE
MIN(X,X1) ;difference between x & x1 in minutes
 ; for positive result, x is BEFORE x1
 ;
 N Y
 S Y=$E(X1_"000",9,10)-$E(X_"000",9,10)*60+$E(X1_"00000",11,12)-$E(X_"00000",11,12),X2=X I $P(X,".",1)'=$P(X1,".",1) S X2=X D ^%DTC S Y=X*1440+Y
 Q $G(Y)
REJECT() ;set x conditions for rejection
 ;  returns: 1|reject  or 0|meets selection criteria
 N X
 I '$G(VAUTD),('$D(VAUTD(SDDIV))) S X=1 G QTRJ
 S X=1
 I $G(VAUTC)!($G(VAUTS)) S X=0 G QTRJ
 I $D(VAUTC(SDCLIN))!($D(VAUTS(SDSTOP))) S X=0 G QTRJ
QTRJ Q X
EXTERN(SORTV,X) ;returns the external value of sort variables
 ; SORTV: 1=CLINIC,2=STOP CODE,3=DAY OF WEEK
 ;     X: Internal value
 N Y
 ;
 I SORTV=1 S Y=$P($G(^SC(X,0)),U,1)
 I SORTV=2 S Y=$P($G(^DIC(40.7,X,0)),U,2)
 I SORTV=3 S Y=$P($G(^DPT(DFN,0)),U)
 Q Y
 ;
SET(HOW,CLIN,STOP,DATE,PAT) ; Set how the sort goes
 ;   Input:   HOW = which sort was selected
 ;           CLIN = clinic ifn
 ;           STOP = stop code ifn
 ;           DATE = date in fm format
 ;            PAT = patient ifn
 ;  Output:  LEVE1-LEVEL4 in external format
 ;
 I HOW=1 S LEVEL1=$$EXTERN(1,CLIN),LEVEL2=$$EXTERN(3,PAT),LEVEL3=DATE
 I HOW=2 S LEVEL1=$$EXTERN(1,CLIN),LEVEL2=DATE,LEVEL3=$$EXTERN(3,PAT)
 I HOW=3 S LEVEL1=$$EXTERN(2,STOP),LEVEL2=$$EXTERN(1,CLIN),LEVEL3=$$EXTERN(3,PAT),LEVEL4=DATE
 I HOW=4 S LEVEL1=$$EXTERN(2,STOP),LEVEL2=$$EXTERN(3,PAT),LEVEL3=$$EXTERN(1,CLIN),LEVEL4=DATE
 I HOW=5 S LEVEL1=$$EXTERN(3,DFN),LEVEL2=DATE,LEVEL3=$$EXTERN(1,CLIN)
 Q
