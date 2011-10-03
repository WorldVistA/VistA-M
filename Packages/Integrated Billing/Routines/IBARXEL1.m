IBARXEL1 ;ALB/CPM - RX COPAY EXEMPTION REMINDER REPRINT ;14-APR-95
 ;;2.0;INTEGRATED BILLING;**34,199,217**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
REPR ; Reprint a single income test reminder letter.
 S IBLET=$O(^IBE(354.6,"B","IB INCOME TEST REMINDER",0))
 I 'IBLET W !!,"You do not have the Income Test Reminder letter defined!" G REPRQ
 ;
 S DIC="^DPT(",DIC("S")="I $D(^IBA(354,+Y,0))",DIC(0)="AEQMZ",DIC("A")="Select BILLING PATIENT: "
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 D ^DIC K DIC S DFN=+Y G:Y<0 REPRQ
 ;
 ; - find the most recent active exemption
 S IBEX=+$O(^(+$O(^IBA(354.1,"AIVDT",1,DFN,-(DT+.00001))),0))
 S IBEXD=$G(^IBA(354.1,IBEX,0))
 I 'IBEXD W !!,"This veteran has never had an active copayment exemption status!" G REPR
 ;
 I $G(^DPT(DFN,.35)) W !!,*7,"Please note that this veteran died on ",$$DAT1^IBOUTL(+^(.35)),"."
 ;
 ; - display the veteran's current exemption status
 S IBEXREA=$$ACODE^IBARXEU0(IBEXD)
 W !!,$TR($J("",80)," ","=")
 W !?10,"Exemption Status: ",$$TEXT^IBARXEU0(+$P(IBEXD,"^",4)),"  (",$P($G(^IBE(354.2,+$P(IBEXD,"^",5),0)),"^"),")"
 W !?12,"Exemption Date: ",$$DAT1^IBOUTL(+IBEXD)
 ;
 ; - display the previous status if the veteran has not reported income
 I IBEXREA=210 D
 .S IBCHK=1
 .S IBEX=+$O(^(+$O(^IBA(354.1,"AIVDT",1,DFN,-IBEXD)),0))
 .S IBEXD=$G(^IBA(354.1,IBEX,0)) Q:'IBEXD
 .S IBEXREA=$$ACODE^IBARXEU0(IBEXD)
 .W !!?4,"Prior Exemption Status: ",$$TEXT^IBARXEU0(+$P(IBEXD,"^",4)),"  (",$P($G(^IBE(354.2,+$P(IBEXD,"^",5),0)),"^"),")"
 .W !?6,"Prior Exemption Date: ",$$DAT1^IBOUTL(+IBEXD)
 ;
 ; - if a letter has already been printed, display the print date
 I $P(IBEXD,"^",16) D
 .W !!?12,"Letter Printed: ",$$DAT1^IBOUTL($P(IBEXD,"^",16))
 .S X=$P($$LST^DGMTCOU1(DFN,$$FMADD^XLFDT(DT,60),3),"^",2)
 .W ?41,"Current Income Test Date: ",$S(X:$$DAT1^IBOUTL(X),1:"<none>")
 W !,$TR($J("",80)," ","=")
 ;
 ; - exemption must be based on income
 I IBEXREA'=110,IBEXREA'=120 W !!,"You may only generate a letter for an exemption based on income!",! K IBCHK G REPR
 ;
 I '$G(IBCHK),+IBEXD>$$FMADD^XLFDT(DT,-305) W !!,"Please note that this exemption is not due to expire for ",$$FMDIFF^XLFDT(+IBEXD+10000,DT)," days!"
 ;
 ; check for Cat C or Pending Adj. and has agreed to pay deductible
 I $$BIL^DGMTUB(DFN,DT) W !!,"**Please note that this veteran no longer requires a Means Test**"
 ;
 ; - okay to print letter?
 S DIR(0)="Y",DIR("A")="Okay to print the reminder letter",DIR("?")="To print the income test reminder letter, answer 'YES.'  Otherwise, answer 'NO.'"
 W ! D ^DIR K DIR,DIRUT,DTOUT,DUOUT,DIROUT I 'Y G REPRQ
 ;
 W !!,"*** Please note that the reminder letter prints in 80 columns. ***",!
 S %ZIS="QM" D ^%ZIS G:POP REPRQ
 I $D(IO("Q")) D  G REPRQ
 .S ZTRTN="DQ^IBARXEL1",ZTDESC="IB - PRINT INCOME TEST REMINDER LETTER"
 .F I="IBEX","IBLET" S ZTSAVE(I)=""
 .D ^%ZTLOAD K IO("Q") D HOME^%ZIS
 .W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q")
 ;
 U IO
 ;
DQ ; Queued entry point.
 D PRINT^IBARXEL
 I $D(ZTQUEUED) S ZTREQ="@" Q
 ;
REPRQ D ^%ZISC
 K DFN,IBLET,IBEX,IBEXD,IBEXREA,IBCHK,IBEXPD,IBQUIT,IBDATA,IBNAM,IBALIN
 Q
