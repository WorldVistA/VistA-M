DGPMTSR ;ALB/LM - TREATING SPECIALTY REPORT PRINT ; 3/12/93
 ;;5.3;Registration;**34,134**;Aug 13, 1993
 ;
A ; This will output ^TMP totals by treating specialty ; by service ; by division ; and finally by grand total
 ;
START ;
 K ^TMP("TSR",$J),^TMP("TSRS",$J),^TMP("TSRD",$J),^TMP("TSRG",$J) ; cleans out temp global.
 I '$D(^DG(40.8,"ATS")) G END
 I TSRI>RD Q  ; If report date is not greater than TSR Initialization date quit
 ;
 S PAGE=0
 S D=0 F D1=0:0 S D=$O(^DG(40.8,"ATS",D)) Q:'D  S ORDER=0 F O1=0:0 S ORDER=$O(^DG(40.8,"ATS",D,ORDER)) Q:ORDER=""  F I=0:0 S I=$O(^DG(40.8,"ATS",D,ORDER,I)) Q:'I  I ORDER>0 D START^DGPMTSR1,START^DGPMTSR2
 ;
 D HEAD I $D(END) Q
 D PRINT
 D KILL
 ;
END Q
 ;
HEAD I PAGE,$E(IOST,1,2)="C-" W !,"Press RETURN to continue or '^' to exit: " R X:DTIME S:X='$T!(X="^") END=1 Q:$D(END)
 W:'($E(IOST,1,2)'="C-"&'$D(PAGE)) @IOF
 S PAGE=PAGE+1
 W !?94,"Date/Time Printed: ",DGNOW
 W !?RM-26\2,"TREATING SPECIALTY REPORT"
 W ?(IOM-10),"PAGE ",$J(PAGE,3)
 S X=$$NAME^VASITE(RD)
 I X']"" D
 .S X="VA MEDICAL CENTER"
 .S DGPM("GL")=$S($D(^DG(43,1,"GL")):^("GL"),1:"")
 .S:$D(^DG(40.8,+$P(DGPM("GL"),"^",3),0)) X=X_", "_$P(^(0),"^")
 W !?RM-$L(X)\2,X
 S X=RD
 D DW^%DTC
 S X1=X,X="PERIOD ENDING MIDNIGHT "_X1_", "
 S Y=RD X ^DD("DD") S X=X_Y
 W !?RM-$L(X)\2,X,!
 S X="T O T A L S   B Y   T R E A T I N G   S P E C I A L T Y"
 ;
 W ! W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 W !?0,"|",?(RM-$L(X)\2),X,?130,"|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 ;
HEAD2 W !?0,"|","DIVISION",?44,"PREVIOUS",?74,"CURRENT",?109,"AVERAGE",?118,"CUMULATIVE",?130,"|"
 W !?0,"|",?2,"SERVICE",?44,"PATIENTS",?74,"PATIENT",?109,"DAILY",?118,"PATIENT",?130,"|"
 W !?0,"|",?3,"FACILITY TREATING SPECIALTY",?44,"REMAINING",?57,"GAINS",?65,"LOSSES",?74,"REMAINING",?86,"PASS",?93,"AA",?98,"UA",?103,"ASIH",?109,"CENSUS",?118,"DAYS OF CARE",?130,"|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 Q
 ;
PRINT ; Output
 S TAB="3^44^57^65^74^86^93^98^103^109^118"
 S JUS="1^5^3^4^5^3^2^2^3^6^7"
 ;
 F D=0:0 S D=$O(^TMP("TSR",$J,D)) Q:'D!$D(END)  S DIVISION=D W !?1,$P(^TMP("TSRD",$J,D)," TOTALS") D S Q:$D(END)  D TSRD Q:$D(END)
 I $D(END) Q
 D TSRG
PEND Q  ; print end
 ;
S S S="" F S1=0:0 S S=$O(^TMP("TSR",$J,D,S)) Q:S=""  S SERVICE=S W !?2,$P(^TMP("TSRS",$J,D,S)," TOTALS")  D ORDER Q:$D(END)  D TSRS Q:$D(END)
 Q
 ;
ORDER S ORDER=0 F ORDER1=0:0 S ORDER=$O(^TMP("TSR",$J,D,S,ORDER)) Q:'ORDER  D TS Q:$D(END)
 Q
TS F TS=0:0 S TS=$O(^TMP("TSR",$J,D,S,ORDER,TS)) Q:'TS  D TSR Q:$D(END)
 Q
 ;
TSR ; print treating specialty total
 I $Y+5>IOSL D HEAD Q:$D(END)
 W !
 F I=1:1:11 W ?+$P(TAB,"^",I),$J($P(^TMP("TSR",$J,D,S,ORDER,TS),"^",I),$P(JUS,"^",I))
 Q
 ;
TSRS ; print service total
 I $Y+7>IOSL D HEAD Q:$D(END)
 W !
 F L=1:1:(IOM-3) W "-"
 W !
 F I=1:1:11 W ?+$P(TAB,"^",I),$J($P(^TMP("TSRS",$J,D,SERVICE),"^",I),$P(JUS,"^",I))
 W !
 F L=1:1:(IOM-3) W "-"
 Q
 ;
TSRD ; print division total
 I $Y+6>IOSL D HEAD Q:$D(END)
 W !
 F I=1:1:11 W ?+$P(TAB,"^",I),$J($P(^TMP("TSRD",$J,DIVISION),"^",I),$P(JUS,"^",I))
 W !
 F L=1:1:(IOM-3) W "-"
 Q
 ;
TSRG ; print grand total
 I $Y+6>IOSL D HEAD Q:$D(END)
 W !
 F I=1:1:11 W ?+$P(TAB,"^",I),$J($P(^TMP("TSRG",$J),"^",I),$P(JUS,"^",I))
 W !
 F L=1:1:(IOM-3) W "-"
 Q
 ;
KILL ;  Kills Variables
 K ^TMP("TSR",$J),^TMP("TSRS",$J),^TMP("TSRD",$J),^TMP("TSRG",$J)
 K ADC,BD,CN,D,D,D1,DIVISION,DGPM("GL"),FY("D"),I,JUS,L,ORDER,ORDER1,O1,PD,RD,RM,S,SERVICE,S,S1,T,TAB,TS,UL,X,X,X1,X2,Y,TSR,DGNOW,END,PAGE,SV,TSRI
 Q
