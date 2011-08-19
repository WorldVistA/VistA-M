IVMRUTL ;ALB/ESD,KCL - IVM Report Utility Routines; 01-JUN-93
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;
 ;
RANGE ; Read starting and ending dates for a report
 ;  Input - None.
 ; Output - IVMBEG is the starting date
 ;          IVMEND is the ending date
 ;
 S (IVMBEG,IVMEND)=""
SDT ; Select starting date for report
 S DIR(0)="DO^::EX",DIR("A")="Enter BEGINNING DATE",DIR("?")="^D HELP^%DTC" D ^DIR K DIR G:'Y RANGEQ S IVMBEG=+Y G:$D(DIRUT) RANGEQ
 I IVMBEG>DT W !,?5,"Future dates are not allowed.",*7 K IVMBEG G SDT
EDT    ; Select ending date for report
 S DIR(0)="D^"_IVMBEG_":NOW:EX",DIR("A")="Enter ENDING DATE",DIR("?")="^D HELP^%DTC" D ^DIR K DIR G:'Y RANGEQ S IVMEND=+Y G:$D(DIRUT) RANGEQ
RANGEQ ;
 K DIRUT,Y
 Q
 ;
PAUSE ;
 Q:$E(IOST,1,2)'["C-"
 F IVMI=$Y:1:(IOSL-4) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IVMQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
