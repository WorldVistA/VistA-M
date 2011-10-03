PRSROT11 ;HISC/JH-IND. OR ALL EMPLOYEE OT/CT REPORT (Continued) ;7/18/97
 ;;4.0;PAID;**2,21,28,34,114,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; CP = "|"  CP = column PIPE character (used for vertical columns)
 ;
 N CP
 S CP="|"
 S ORG=$S($D(ORG):$E(ORG,1,12),1:"")
 D HDR1
 S (PP(1),NAM(1),DAY(1),DATT(1))="",DATE(1)=0
 F I=1:1:2 S (SAL(I),COMP(I),COMPU(I),OTH(I),OTP(I))=0
 S PP=""
 F I=0:0 S PP=$O(^TMP($J,"OT/CP",PP)) Q:PP=""  S SW(1)=0 D  Q:POUT
 .;
 .  S DATT=0
 .  F I=0:0 S DATT=$O(^TMP($J,"OT/CP",PP,DATT)) Q:DATT'>0  D  Q:POUT
 ..;
 ..  S INX=0
 ..  F I=0:0 S INX=$O(^TMP($J,"OT/CP",PP,DATT,INX)) Q:INX']""  D  Q:POUT
 ...;
 ...  S NAM=""
 ...  F I=0:0 S NAM=$O(^TMP($J,"OT/CP",PP,DATT,INX,NAM)) Q:NAM=""  S SW(3)=0 D  Q:POUT
 ....  S D0=0
 ....  F I=0:0 S D0=$O(^TMP($J,"OT/CP",PP,DATT,INX,NAM,D0)) Q:D0'>0  S TIME=$G(^(D0)) Q:TIME=""  D  Q:POUT
 .....;
 .....  D:($Y>(IOSL-5)) HDR Q:POUT
 .....  D VLIN0:PP'=PP(1)
 .....  W !,CP,$S(PP'=PP(1):$J($P(PP,"-",2),2),1:""),?4,CP,$S(DATT'=DATT(1):DATT,1:""),?14,CP,NAM,?39,CP
 .....  I PRSTLV=3 W $E($P(TIME,"^")),"XX-XX-",$E($P(TIME,"^"),8,11),?52,CP
 .....  I PRSTLV=7 W $P(TIME,"^"),?52,CP
 .....  W $J($P(TIME,"^",2),10,2),?64,CP,$J($P(TIME,"^",3),12,2),?79,CP,$J($P(TIME,"^",4),12,2),?94,CP
 .....  W $J($P(TIME,"^",5),12,2),?109,CP,$J($P(TIME,"^",6),17,2),?131,CP
 .....  S SAL(1)=SAL(1)+$P(TIME,"^",2),COMPU(1)=COMPU(1)+$P(TIME,"^",3),COMP(1)=COMP(1)+$P(TIME,"^",4),OTH(1)=OTH(1)+$P(TIME,"^",5),OTP(1)=OTP(1)+$P(TIME,"^",6),SW(1)=SW(1)+1
 .....  S SAL(2)=SAL(2)+$P(TIME,"^",2),COMPU(2)=COMPU(2)+$P(TIME,"^",3),COMP(2)=COMP(2)+$P(TIME,"^",4),OTH(2)=OTH(2)+$P(TIME,"^",5),OTP(2)=OTP(2)+$P(TIME,"^",6)
 .....  Q
 ....  S PP(1)=PP,DATT(1)=DATT,NAM(1)=NAM,DATE(1)=DATE Q
 ....  Q
 ...  Q
 ..  Q
 .  Q:POUT  I SW(1) D
 ..    W !
 ..    D TABLANK0,ROWSEP
 .  D TABLANK0
 .  W " P/P-Totals:"
 .  D WTOT(1)
 .  S (SAL(1),COMPU(1),COMP(1),OTH(1),OTP(1))=0
 .  Q
 Q:POUT
 I SW(1) D
 .  D VLIN0
 .  D VLINUND
 ;
 D TABLANK0
 W ?44,"TOTALS:"
 D WTOT(2)
 I IOSL<66 D VLIN0
 Q
WTOT(PERIOD) ;Write out pay period totals (1) OR running totals.
 S I=PERIOD
 W ?53,$J(SAL(I),10,2)
 W ?65,$J(COMPU(I),12,2)
 W ?80,$J(COMP(I),12,2)
 W ?95,$J(OTH(I),12,2)
 W ?110,$J(OTP(I),17,2),?131,CP
 Q
CHK S X1=DATE,X2=DATE(1) D ^%DTC Q
HDR S CODE="O001",FOOT="VA TIME & ATTENDANCE SYSTEM"
 D VLIDSH0,FOOT1^PRSRUT0
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I $D(DIRUT) S POUT=1
 Q:POUT
 W @IOF
HDR1 N CP S CP="|"
 W !?(IOM-$L(^TMP($J,"OT/CP")))/2,^TMP($J,"OT/CP"),?(IOM-14),"DATE: ",DAT
 S X="T&L: "_$P(TLE(1),U)_"  Employee: "_$S(SW:"ALL",1:$P(PRSRY,U,2))
 S X=X_"  Year: "_YEAR_"  Payperiod"
 S X=X_$S(PPE(1)=PPE(2):": "_PPE(1),1:"s: "_PPE(1)_" to "_PPE(2))
 W !,?(IOM-$L(X)/2-1),X,!
 W !,CP,"P/P",?4,CP,?7,"DATE",?14,CP,?25,"NAME",?39,CP,?44,"SSN",?52,CP,?54,"GROSS PAY",?64,CP,?67,"CT/CH USED",?79,CP,?82,"CT/CH BAL",?94,CP,?97,"OVER/T HRS",?109,CP,?118,"OVER/T PAY",?131,CP D VLIDSH0 Q
 ;
VLIDSH0 ;
 W !,"|---|---------|------------------------|------------|-----------|--------------|--------------|--------------|---------------------|" Q
 ;
VLIN0 ;
 W !
 D TABLANK0,TABLANK1
 Q
 ;
VLINUND ;use leading blank columns & trailing row separator.
 W ! D TABLANK0,ROWSEP Q
 ;
TABLANK0 ;leading blank columns with vertical slash for column breaks.
 N CP S CP="|"
 W CP,?4,CP,?14,CP,?39,CP Q
 ;
TABLANK1 ;2nd half of blank columns w/ vertical slash for column breaks.
 N CP S CP="|"
 W ?52,CP,?64,CP,?79,CP,?94,CP,?109,CP,?131,CP Q
 ;
ROWSEP ;row separator (2nd half of line)
 N CP S CP="|"
 W ?52,CP," --------- ",CP,"     ------- "
 W ?79,CP,"     ------- "
 W ?94,CP,"     ------- "
 W ?109,CP,"       ---------- "
 W ?131,CP,!
 Q
