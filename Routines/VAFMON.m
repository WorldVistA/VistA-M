VAFMON ;ALB/CAW/GN - Returns income/dependents ; 2/19/03 3:35pm
 ;;5.3;Registration;**45,67,499**;Aug 13, 1993
 ;
INCOME(DFN,VADT,VASOURCE) ; 
 ;  Returns Income (veterans+spouse+dependents)
 ;      First from the means test
 ;        (Income+Net Worth-Deductible Expenses)
 ;      If no means test then co-pay test
 ;        (Income-Deductible Expenses)
 ;      If no co-pay test then income screening
 ;        (Income)
 ;      If none of the above then total VA check amount
 ;
 ;      INPUT:  DFN = Patient IEN
 ;             VADT = Date income calculated for
 ;         VASOURCE = [optional] income type requested
 ;                    1 = returns income (veteran,spouse,children)
 ;                        minus deductibe expenses - this excludes net worth 
 ;     OUTPUT: VAINCM = Income^source flag 
 ;                        (2nd piece is only used when VASOURCE is used and is equal to 1)
 ;
 N I,VAINCM,VAMT,DGREL,DGINR,DGINC,DGDEP,VAX,X
 I '$D(VADT) S VAINCM="" G INCQ
 S VAINCM="",VADT=$P(VADT,".")
 S VAMT=$$LST^DGMTCOU1(DFN,VADT,3)
 I VAMT,$P(VAMT,U,4)'="N",$P(VAMT,U,4)'="L" S X=$G(^DGMT(408.31,+VAMT,0)) S:$L($P(X,U,4))!$L($P(X,U,15)) VAINCM=$P(X,U,4)-$P(X,U,15) D
 .I $G(VASOURCE)'=1,$L($P(X,U,5)) S VAINCM=VAINCM+$P(X,U,5) Q  ; includes net worth
 .I VAINCM]"" S VAINCM=VAINCM_$S($P(VAMT,U,5)=1:"^M",1:"^C") ;bt source flag
 I VAINCM']"" D
 .N VADX S VADX=$S($G(VASOURCE)=1:"C",1:"D")
 .;    DG*5.3*499 pass ien of Means/Co-pay test via 5th parameter
 .D ALL^DGMTU21(DFN,"VS"_VADX,VADT,"I",+VAMT)
 .S VAX=$G(^DGMT(408.21,+$G(DGINC("V")),0)) I VAX]"" F I=8:1:17 S:$L($P(VAX,"^",I)) VAINCM=VAINCM+$P(VAX,"^",I)
 .S VAX=$G(^DGMT(408.21,+$G(DGINC("S")),0)) I VAX]"" F I=8:1:17 S:$L($P(VAX,"^",I)) VAINCM=VAINCM+$P(VAX,"^",I)
 .S VACNT=0 F  S VACNT=$O(DGINC(VADX,VACNT)) Q:'VACNT  S VAX=$G(^DGMT(408.21,+$G(DGINC(VADX,VACNT)),0)) I VAX]"" F I=8:1:17 S:$L($P(VAX,"^",I)) VAINCM=VAINCM+$P(VAX,"^",I)
 .I $G(VASOURCE)=1,VAINCM]"" S VAINCM=VAINCM_"^I"
 I VAINCM']"" S VAINCM=$P($G(^DPT(DFN,.362)),U,20) I $G(VASOURCE)=1,VAINCM]"" S VAINCM=VAINCM_"^V"
 ;
INCQ Q VAINCM
 ;
DEP(DFN,VADT) ;Total dependents for a patient
 ;Input:      DFN  = Internal Entry Number of Patient file
 ;            VADT = Date (Optional - default today)
 ;Output      Number of dependents
 N VAMT,VAMTDEP,VAVIR0,VAVIRI,DGDEP,DGINR,DGREL,VADEP
 I 'VADT S VADT=DT
 S VADEP=""
 S VAMT=$$LST^DGMTCOU1(DFN,VADT,3)
 I VAMT,$P(VAMT,U,4)'="N",$P(VAMT,U,4)'="L",$D(^DGMT(408.31,+VAMT,0)) S VADEP=$P(^(0),U,18)
 I VADEP']"" D  I VADEP]"" G DEPQ
 .D ALL^DGMTU21(DFN,"DSV",VADT) I '$D(DGREL) Q
 .S VAVIRI=+$G(DGINR("V")),VAVIR0=$G(^DGMT(408.22,VAVIRI,0)),VADEP=$P(VAVIR0,U,13)
 .I 'VADEP&($P(VAVIR0,U,8)) S:VADEP=0 VAMTDEP="" Q
 .; Questions: piece 5=married last calender year
 .;            piece 6=lived with patient
 .;            piece 7=amount contributed to spouse
 .;
 .; If no spouse, and questions not answered, set dep=null
 .;
 .I '$D(DGREL("S"))&($P(VAVIR0,U,5,7)']"") S VADEP="" Q
 .;
 .; If no spouse, but questions answered, set dep=$S
 .;
 .I '$D(DGREL("S")),$P(VAVIR0,U,5,7)]"" S VADEP=VADEP+$S('$P(VAVIR0,U,5):0,$P(VAVIR0,U,6)'=0:1,$P(VAVIR0,U,7)>49:1,1:0) Q
 .;
 .; If spouse and no questions answered, set dep+1
 .;
 .I $D(DGREL("S")),$P(VAVIR0,U,5,7)']"" S VADEP=VADEP+1 Q
 .;
 .; If spouse and questions answered, set dep=$S
 .;
 .I $D(DGREL("S")) S VADEP=VADEP+$S($P(VAVIR0,U,6):1,$P(VAVIR0,U,7)>49:1,$P(VAVIR0,U,5)&($P(VAVIR0,U,6)=""):1,1:0)
 ;
DEPQ Q VADEP
