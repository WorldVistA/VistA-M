DVBAAPLK ;ALB/GTS-557/THM-FORMATTING ROUTINE FOR APPTS (DVBAREN1) ;21 JUL 89
 ;;2.7;AMIE;;Apr 10, 1995
 S XDD=^DD("DD")
 ;
EN1 W @IOF,!,"Non-admitted Veteran Date Selection",!
 S DISTYPE="" W !!,?5,"Select from:",!!,?10,"(A)ppointment date",!
 W ?10,"(D)isposition log-in date",!
 W ?10,"(S)top code",!!
 W !,"Enter selection:  A// " R DISTYPE:DTIME I '$T S Y=-1,AROWOUT=1,DVBAQUIT=1 Q
 I DISTYPE["?" G CHECK
 I DISTYPE="" S DISTYPE="A"
 I DISTYPE=U S Y=-1,AROWOUT=1 Q
 I DISTYPE'?1"A"&(DISTYPE'?1"D")&(DISTYPE'?1"S") W !!,*7,"Must be A, D, or S",!! H 2 G EN1
 W @IOF,!,$S(DISTYPE="A":"Appointment",DISTYPE="D":"Disposition Log-in",1:"Stop code")_" Date Selection for "_PNAM,!!!
 D @DISTYPE K APPT,DISTYPE,K,ANS,^TMP("DVBA",$J),ANS1,DIC,I,J,X
 Q
 ;
A S Y=-1 I '$D(^DPT(DFN,"S")) W !!,*7,"This veteran has no appointments on file.",!! S OUT=1 H 2 Q
 W !!,"Choose from these appointment dates: " W !!
 S ANS="" S K=0 F I=0:0 S I=$O(^DPT(DFN,"S",I)) Q:I=""  S J=$P(^(I,0),"^",1) S Y=I X XDD S K=K+1 S ^TMP("DVBA",$J,K)=I D WRITE
 I ANS="" D SELECT
 I ANS="" S OUT=1 Q
 I ANS]"",ANS'="^" S Y=^TMP("DVBA",$J,ANS) K ^TMP("DVBA",$J)
 I ANS="^"!(ANS']"") S AROWOUT=1,Y=-1 K APPT Q
 S APPDT=$P(Y,".",1),Y=-1
 Q
WRITE W ?5,K_".  ",?10,$P(Y,"@",1),?25,$P(Y,"@",2,99),?35,$S($D(^SC(J,0)):$P(^SC(J,0),U,1),1:"Unknown clinic"),! I $Y#11=0 D SELECT W !! S:ANS]"" I=9999999.999 Q:ANS]""
 Q
SELECT S ANS="" W !,"Select 1 to "_K_",",!," [RETURN] to continue to search,",!,"  OR ""^"" to QUIT.   " R ANS:DTIME Q:ANS=U!(ANS="")!('$T)
 I ANS'?1.3N!(ANS<1)!(ANS>K) W !!,*7,"Must be between 1 and "_K_" ,RETURN, or ""^""",!! H 2 G SELECT
 Q
 ;
D I '$D(^DPT(DFN,"DIS")) W !!,*7,"This veteran has no log-ins on file.",!! H 2 S Y=-1,OUT=1 Q
 S DIC="^DPT(DFN,""DIS"",",DIC(0)="AEQM",DIC("A")="Enter Disposition Log-in time: " D ^DIC I X=""!(X=U) S Y=-1,AROWOUT=1 Q
 S APPDT=$E($P(Y,U,2),1,7),Y=-1
 Q
 ;
S I '$D(^SDV("ADT",DFN)) W !!,*7,"This veteran has no stop codes on file.",!! H 2 S OUT=1,Y=-1 Q
 S DIC="^SDV(",DIC(0)="EQM",X=$P(^DPT(DFN,0),U,9) D ^DIC I Y=-1 S OUT=1 Q
 S APPDT=$E($P(Y,U,2),1,7),Y=-1
 Q
 ;
CHECK ;check what choices are available
 W @IOF,!!,"The following choices are available for this Veteran:",!!
 I $D(^DPT(DFN,"S")) W "Appointments",!
 I $D(^SDV("ADT",DFN)) W "Stop codes",!
 I $D(^DPT(DFN,"DIS")) W "Disposition Log-in dates",!
 W !!,"Press [RETURN] to continue or ""^"" to quit   " R ANS1:DTIME S:ANS1=U AROWOUT=1 Q:ANS1=U  I '$T S DVBAQUIT=1 Q
 G EN1
