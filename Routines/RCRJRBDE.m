RCRJRBDE ;WISC/RFJ,TJK-bad debt edit the report ;1 Feb 98
 ;;4.5;Accounts Receivable;**101,191,184,239**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EDIT ;  over-ride values, called from menu option
 ;W !!,"This option will allow you to over-ride the current month allowance"
 ;W !,"estimate for the Bad Debt Report.  If you change the allowance estimate,"
 ;W !,"it will change the value sent to FMS (on the last workday of the month).",!
 ;
 ; - deactivate the over-ride option with patch PRCA*4.5*239
 W !!,"This option will no longer allow you to over-ride the current"
 W !,"month Bad Debt allowance estimates.  These estimates are"
 W !,"automatically transmitted to FMS when they are calculated"
 W !,"by the AR Data Collector on the third to the last business"
 W !,"day of the month.",!!
 ;
 S DIR(0)="E" D ^DIR K DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 ;
 Q
 ;
 ;
 ;
 N DIR,X,Y
 ;I $E(DT,6,7)'<$$WD3^RCRJRBD D  Q
 I $E(DT,6,7)<$E($$LDATE^RCRJR(DT)+1,6,7)!($E(DT,6,7)'<$E($$LDAY^RCRJR(DT),6,7)) D  Q
 .   W !,"The Bad Debt Report is submitted to FMS on the next to last workday of the"
 .   W !,"month.  You can only use this option to change the data from the day"
 .   W !,"after the EOAM cut off date to the next to last workday of the month."
 .   ;  ask to print report
 .   S DIR(0)="YO",DIR("B")="NO"
 .   S DIR("A")="  Do you want to print the report for last month"
 .   W ! D ^DIR
 .   I Y=1 D PRINT^RCRJRBDR
 ;
 N CHANGED,D,D0,DA,DATA,DI,DIC,DIE,DQ,DR,RCRJALLO,RCRJFEND,X,Y
 F  D  Q:$G(RCRJFEND)
 .   ;  check to see if report is running
 .   L +^RC(348.1):5
 .   I '$T W !,"The Bad Debt Report is currently running or being edit by another user.",!,"Try again later." S RCRJFEND=1 Q
 .   ;
 .   S (DIC,DIE)="^RC(348.1,",DIC(0)="QEAM"
 .   W ! D ^DIC
 .   I Y<1 L -^RC(348.1) S RCRJFEND=1 Q
 .   S DA=+Y
 .   ;  store current estimate allowance and show report
 .   S RCRJALLO=+$P(^RC(348.1,+Y,0),"^",8)
 .   W !!?20,"This what the CURRENT report looks like:"
 .   W !?20,"========================================"
 .   D SHOW(DA)
 .   W !!,"You now have the option to over-ride the estimated allowance:"
 .   S DR=".08;" D ^DIE
 .   L -^RC(348.1)
 .   ;  no changes to data
 .   I +$P(^RC(348.1,DA,0),"^",8)=RCRJALLO W "...No changes made." Q
 .   ;  set flag to show changes made
 .   S DR=".1////1;" D ^DIE
 .   ;  show new report
 .   W !!?20,"This is what the NEW report looks like:"
 .   W !?20,"======================================="
 .   D SHOW(DA)
 Q
 ;
 ;
SHOW(DA) ;  show the values for entry
 S DATA=$G(^RC(348.1,DA,0))
 W !!,"Allowance for Bad Debt - SGL ",$P(DATA,"^"),":"
 W !,"----------------------------------------------------"
 S CHANGED="  " I $P(DATA,"^",10) S CHANGED="**"
 W !,"Allowance Estimate for Month",?35,":",$J($P(DATA,"^",8),16,2)," ",CHANGED," (Normally Credit Value)"
 W !,"Bad Debt Write-Off FYTD (Plus)",?35,":",$J($P(DATA,"^",9),16,2),"    (Normally Debit Value )"
 W !,"----------------------------------------------------"
 W !,"Transmitted Amount to FMS for Month",?35,":",$J($P(DATA,"^",8)+$P(DATA,"^",9),16,2)," ",CHANGED," (Normally Credit Value)"
 I $P(DATA,"^",10) W !?53,"**  Changed Locally"
 Q
