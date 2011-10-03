RCRCVLB ;ALB/CMS - RC VIEW ACTIVE LIST BUILD ; 09-AUG-97
V ;;4.5;Accounts Receivable;**63,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
EN ; entry point from RCRCVL
 ; Returns: RCSBN,RCSBN(CNT,PRCABN)
 ;      or: RCCAT(catname),RCSI(dbt#),RCSPT,RCSIA,RCSIF,RCSIL,RCSAGN,RCSAGX,RCSAMT,RCSRC
 ;      or: if muti-divisions RCDIV(0),RCDIV(selected 40.8IEN)
 ;      or: RCOUT
 N CNT,DA,DIC,PRCA,PRCABN,RCLQ,RCLQA,RCY,RCS,TCNT,T,X,Y
 N RCDIV,RCCNT,RCSD,RCRN,RCSN,RCSNF,RCLCNT,RCSNL,RCSNA,RCSAR,RCSH
 N DIR,DIROUT,DTOUT,DUOUT,DIRUT
 K RCSBN,RCCAT,RCSI,RCSIF,RCSIL,RCSAGN,RCSAGX,RCSAMT,RCSPT,RCSRC,RCOUT
 ;
 ;Get Divisions
 D RCDIV^RCRCDIV(.RCDIV)
 ;Select one division if multiple
 I $O(RCDIV(0)) D DIVS^RCRCDIV I $G(RCOUT)=1 G ENQ
 ;
 W !!,"Build List of Possible Third Party Referrals"
 S DIR("A",1)="Build a list by"
 S DIR("A",2)="1.  Selected AR Third Party Bill(s)"
 S DIR("A",3)="2.  Selected Patient(s)"
 S DIR("A",4)="3.  Selected AR Insurance Debtor(s) or"
 S DIR("A",5)="               Insurance Range"
 S DIR("A",6)=" "
 S DIR("A")=" Select Number: "
 S DIR(0)="SAXB^1:Third Party Bills;2:Patients;3:Insurance Debtors"
 S DIR("B")=1
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) S RCOUT=1 G ENQ
 I $E(Y)="^" S RCOUT=1 G ENQ
 S RCRN=Y
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 I RCRN=1 D BILL G ENQ
 I RCRN=2 D PT I '$G(RCOUT) D ASK
 I RCRN=3 D INS I '$G(RCOUT) D ASK
ENQ W !
 I $G(RCOUT)=1 K RCSBN,RCCAT,RCDIV,RCSI,RCSIA,RCSIF,RCSIL,RCSAGN,RCSAGX,RCSPT,RCSAMT,RCSRC
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 Q
 ;
 ;
BILL ; - issue prompt for AR Bill Selection(s)
 ; - also called from Modify List Protocol
 K DIC,DA,X,Y,%Y W !
 S DIC("A")="Select Active TP Accounts Receivable Bill No.: "
 S DIC="^PRCA(430,",DIC(0)="AQMEZ"
 S DIC("S")="I $P(^(0),U,8)=16,$P($G(^PRCA(430.2,+$P(^(0),U,2),0)),U,6)=""T"""
 S CNT=0 F  D  Q:($G(PRCABN)<0)!($G(RCOUT))
 .D ^DIC S PRCABN=Y
 .I $G(PRCABN)<0 Q
 .I $G(PRCABN)="^" S RCOUT=1 Q
 .I +$G(RCDIV(0)),'$$DIV^RCRCDIV(PRCABN) W !,"     <<Bill is not in selected division.>>",!
 .S CNT=CNT+1,RCSBN=CNT
 .S RCSBN(+PRCABN)=CNT
 .S DIC("A")="Select another Active TP Accounts Receivable Bill No.: "
 .QUIT
 I '$O(RCSBN(0)) S RCOUT=1
 K PRCABN,DIC,DA,X,Y,%Y
BILLQ Q
 ;
PT ;  - Issue prompt for Patients
 N DIC,X,Y
 I $O(RCSPT(0)) S DIC("A")="Select another PATIENT: "
 S DIC="^DPT(",DIC(0)="QMEAZ"
 W ! D ^DIC K DIC I $E(Y)="^" S RCOUT=1 G PTQ
 I Y<0,'$O(RCSPT(0)) S RCOUT=1
 I Y<0 G PTQ
 S RCSPT(+Y)=Y G PT
PTQ Q
 ;
INS ; - determine range of carriers
 R !!,"Build List for (S)elected Third Party Debtor(s) or a (R)ange: Range// ",X:DTIME
 I ('$T)!(X["^") S RCOUT=1 G INSQ
 S:X="" X="R" S X=$E(X)
 I "SRsr"'[X W !!,?15,"Enter 'S' or 'R' or '^' to exit." G INS
 W $S("sS"[X:"  Selected",1:"  Range") S RCSI=X
 I "Rr"[RCSI G INS1
 ;
 S DIC("A")="Select THIRD PARTY AR DEBTOR: "
INSA S DIC="^RCD(340,",DIC(0)="QEAZ",DIC("S")="I $P(^(0),U,1)[""DIC(36,"""
 W ! D ^DIC K DIC I $E(Y)="^" S RCOUT=1 G INSQ
 I Y<0,$O(RCSI(0)) G INSQ
 I Y<0,'$O(RCSI(0)) G INS
 S RCSI(+Y)=Y
 S DIC("A")="Select another THIRD PARTY AR DEBTOR: "
 G INSA
 ;
INS1 W !!!,"   START WITH DEBTOR: FIRST// " R X:DTIME
 I ('$T)!(X["^") S RCOUT=1 G INSQ
 I $E(X)="?" W !,?5,"Enter the name of the Insurance Company to start with." G INS1
 S RCSIF=X
INS2 W !,"   GO TO DEBTOR: LAST// " R X:DTIME
 I ('$T)!(X["^") S RCOUT=1 G INSQ
 I $E(X)="?" W !,?5,"Enter the name of the Insurance Company to end with." G INS2
 I X="" S RCSIL="zzzzz" S:RCSIF="" RCSIA="ALL" G INSQ
 I X="@",RCSIF="@" S RCSIL="@",RCSIA="NULL" G INSQ
 I RCSIF'="@",RCSIF]X W *7,!!,"  The LAST value must follow the FIRST.",! G INS1
 S RCSIL=X
INSQ Q
 ;
ASK ;Ask optional questions
 ;
 ; - Build list for Selected Categories
 S RCCAT="" D RCCAT^RCRCUTL(.RCCAT)
 S (CNT,X)=0 K DIR
 F  S X=$O(RCCAT(X)) Q:'X  D
 .S CNT=CNT+1 S DIR("A",CNT)=CNT_"  "_$P(RCCAT(X),U,2)
 S TCNT=CNT,CNT=CNT+1,DIR("A",CNT)=" "
 S CNT=CNT+1,DIR("A",CNT)="  *Only Reimburs.Health Bills can be electronically referred at this time."
 S CNT=CNT+1,DIR("A",CNT)=" "
 S DIR("A")=" Enter response"
 W !!,"AR Categories to Include in Build List"
 W !," Select from the following:",!
 S DIR(0)="L^1:"_TCNT
 D ^DIR I $E(Y)="^" S RCOUT=1 G ASKQ
 K RCCAT F I=1:1:TCNT I $P(Y,",",I) S RCCAT($P(DIR("A",$P(Y,",",I)),"  ",2))=""
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ASKQ
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
AGE ; - determine the active receivable min age
 S DIR(0)="NOA^1:99999",DIR("?")="Enter a number between (1-99999) or press return"
 S DIR("A")="  (Optional) Enter the minimum age of the receivables: "
 W !! D ^DIR S RCSAGN=+Y I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S RCOUT=1 G ASKQ
 W:+RCSAGN !,"  -Bill age over ",RCSAGN," days."
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ; - determine the active receivable max age
 S DIR(0)="NOA^1:99999",DIR("?")="Enter a number between (1-99999) or press return"
 S DIR("A")="  (Optional) Enter the maximum age of the receivables: "
 W !! D ^DIR S RCSAGX=+Y I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S RCOUT=1 G ASKQ
 W:+RCSAGX !,"  -Bill age under ",RCSAGX," days."
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 I $G(RCSAGX),+$G(RCSAGN)>+$G(RCSAGX) W !!,"Minimum age should be less than the Max. age.",!! G AGE
 ;
 ; - determine the active receivable minimum Amount
 S DIR(0)="NOA^1:99999:2",DIR("?")="Enter a number between (1-99999) or press return"
 S DIR("A")="  (Optional) Enter the minimum amount of the receivables: "
 W !! D ^DIR S RCSAMT=+Y I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S RCOUT=1 G ASKQ
 W:RCSAMT !,"  -Current Balance Over $",RCSAMT
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ; - exclude receivables currently referred to Regional Counsel?
 S DIR(0)="Y",DIR("B")="Yes"
 S DIR("?")="Include receivables with a Referral Date in List"
 S DIR("A")="Include currently referred receivables"
 W !! D ^DIR S RCSRC=+Y
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) S RCOUT=1 G ASKQ
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
ASKQ Q
 ;
 ;RCRCVLB
