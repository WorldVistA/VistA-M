PRS8DR ;HISC/MRL,JAH/WCIOFO-DECOMPOSITION, DRIVER ;4/09/2007
 ;;4.0;PAID;**22,29,56,90,111,112,107**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine determines whether or not the parameters necessary
 ;to decompose time are in existence.  The majority of variables
 ;involving processing an individual employee are defined in this
 ;routine.
 ;
 ;The following lines establish variables necessary to process a
 ;specific employees time for the specified pay period.
 ;
 ;Called by Routines:  PRS8, PRS8DR (tag 1)
 ;
 N PRVAL,RESTORE
 ;
 D ONE^PRS8CV ;clean up variables
 S SAVE=+$G(SAVE),SEE=+$G(SEE)
 S TMTD=$G(^PRST(458,+PY,"E",DFN,0)),TMTD=$S($P(TMTD,"^",2)="X":1,1:0)
 K WK F I=1,2,3 S WK(I)="" ;weekly totals (wk3=misc data)
 D ^PRSAENT S VAL="" ;get entitlement (ENT)
 I PP="S" G END ;Manila citizen/don't decompose/no stub
 I $G(PB)["$" G STUB^PRS8CR ;don't decompose stipend/create stub
 ; Set NAWS to type of AWS
 N NAWS
 S NAWS=0
 I "KM"[$E(AC,1),$E(AC,2)=1,NH=72 S NAWS="36/40 AWS"
 I $E(AC,1)="M",$E(AC,2)=2,NH=80 S NAWS="9Mo AWS"
 ;
 I "^P^X^"[(U_$P($G(^PRST(458,+PY,"E",DFN,0)),"^",2)_U) S RESTORE=1
 D AUTOPINI^PRS8(+PY,+DFN,$G(RESTORE),.PRVAL) ; remove auto-posted data
 S DOUB=0 I $E(ENT,26),$E(ENT,29) S DOUB=1 ;count standby & oncall same
 S FLX="" S FLX=$P($G(^PRST(458,+PY,"E",DFN,0)),"^",6)
 I +NAWS=36 S FLX="C"
 S (SST,TAL)="",X=$P(C0,"^",8) I X'="" D  ;T&L Unit
 .S X=$O(^PRST(455.5,"B",X,0)) ;get ien
 .S TAL=$G(^PRST(455.5,+X,0)),X=$P(TAL,"^",8) ;get sleep start time
 .I $L(X) S (NDAY,LAST,Y,Y1)=0 D 15^PRS8SU
 .S SST=$S(+X:X,1:93) K X,Y1,LAST,X ;sleep start time
 .K SL,SB,ST ;make sure standby variable don't exist
 S (CAMISC,CYA,CYA2806,WPCYA,LU)=0 ; << ADDED >> calendar year adjust./leave used in pp
 S (NH(1),NH(2))=0 ;normal hrs/pp total/week(1)/week(2)
 S (TH,TH(1),TH(2))=0 ;total hours
 N CT S (CT(1),CT(2))=0 ; counter for compensatory time
 K DWK S DWK=0 ;count of days worked - for intermittents
 S NH=NH/.25 ;turn Norm hrs into 15min increments
 K TOUR S (TOUR(1),TOUR(2))="" ;tour code for wg/week(1)/week(2)
 K TYP S TYP="" I $E(ENT)="D"!($E(ENT,1,2)="0D") S TYP=TYP_"D" ;daily pay basis
 I PP?1N.E!(PP="U") S TYP=TYP_"W" ;wagegrade
 I PP'="","KM"[PP S TYP=TYP_"N" ;nurse
 I +$E(AC,2)=1,NH=192 S TYP=TYP_"B" ;baylor plan
 I $G(PMP)'="","EF"[PMP S TYP=TYP_"H" ;Nurse Hybrid
 I $E($G(AC),2)=3 S TYP=TYP_"I" ;intermittent
 I NH>320 S TYP=TYP_"F" I NH'>448 S TYP=TYP_"f" ;firefighter
 ; Nurses on the 9month AWS will be treated as FT employees during the 9 months
 ; that they are working.  Prevent a "P" from being added to TYP.
 I NH,NH'>319,$E(AC,2)'=1 S TYP=TYP_"P" ;part-time
 I PP="L",$E(AC,2)=2 S TYP=TYP_"d" ;doctor
 I PP="L",$E(AC,2)=1 S TYP=TYP_"dR" ;doctor/resident or intern
 I PP="Q",$E(AC,2)=2 S TYP=TYP_"d" ;doctor
 I PP="Q",$E(AC,2)=1 S TYP=TYP_"dR" ;doctor/resident or intern
 S (PTH,PTH(1),PTH(2))=0 ;part-time hours
 K WKL S (WKL(1),WKL(2))=0 ;count leave used in week during ND hours
 K MEAL S $P(MEAL,"1^",14)="",MEAL=MEAL_1 ;mealtime
 S (MILV,WCMP)=0 ;ML and PC indicators
 S (CBCK(1),CBCK(2))=0 ;call back hrs by week counter
 I TYP="" S TYP="*"
 K I,PB,PP,X,X1,X2
 D ^PRS8SU ;set up employee variables and commence decomposing
 D ^PRS8CR
 D:$D(PRVAL) AUTOPRES^PRS8(+PY,+DFN,.PRVAL) ; restore auto-posted data
 I SEE D ^PRS8VW
 ;
END ; --- This is where we end this process
 G ONE^PRS8CV ;clean up
 Q
 ;
1 ; --- enter here to print single entry and close device
 D ^PRS8DR,^%ZISC Q
