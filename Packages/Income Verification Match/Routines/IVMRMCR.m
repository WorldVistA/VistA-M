IVMRMCR ;ALB/ESD - IVM Means Test Comparison Report ; 3 May 93
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;
 ; Reports IVMRMCR and IVMRMCR1 will print patient data (if requested
 ; by user), and summary statistics of Cat A and Cat C patients for
 ; 2 selected years.
 ;
EN ; Get current year to display as part of user prompt.
 D NOW^%DTC S IVMCURDT=X,IVMCURYR=1700+$E(X,1,3)
 ;
 W !!!?24,"IVM MEANS TEST COMPARISON REPORT"
 W !!?3,"This report will be used to analyze consecutive years' Means Test data",!?3,"(e.g., 1991-1992).  Please enter the first year for the two year period",!?3,"which you would like to analyze.",!
 ;
BEGYR ; Ask user for year 1 of report.
 S %DT("A")="Enter first means test YEAR (1986 - "_(IVMCURYR-1)_"): ",%DT(0)=2860000,%DT="AE" D ^%DT K %DT G:$D(DTOUT)!(Y<0) ENQ
 I $E(Y,1,3)'<($E(IVMCURDT,1,3)) W !,"Invalid year entered. Enter a year less than the current year.",*7 G BEGYR
 ;
 ; Compute year 2 of report.
 S IVMBEGYR=$E(Y,1,3),IVMENDYR=IVMBEGYR+1
 W !?3,"Means Test YEAR 1: ",1700+IVMBEGYR,!?3,"Means Test YEAR 2: ",1700+IVMENDYR,!!
 ;
 ; Ask user if printing of patient information is desired.
 ; IVMOUT = 1 for '^', 2 for time-out, 0 otherwise
 S IVMOUT=0,DIR(0)="YO",DIR("A")="Would you like to print patient data",DIR("B")="NO" D ^DIR K DIR S IVMOUT=$S($D(DTOUT):2,$D(DUOUT):1,$D(DIRUT):1,1:0) G:IVMOUT ENQ
 S IVMPFLAG=Y
 ;
 ; Select an output device.
 W !?3,"NOTE: The output is designed to use 80 columns."
 S IVMRTN="^IVMRMCR1",ZTDESC="IVM MEANS TEST COMPARISON REPORT"
 S (ZTSAVE("IVMBEGYR"),ZTSAVE("IVMCURDT"),ZTSAVE("IVMCURYR"),ZTSAVE("IVMENDYR"),ZTSAVE("IVMPFLAG"))=""
 D EN^IVMUTQ
 ;
ENQ K DIRUT,DTOUT,DUOUT,IVMBEGYR,IVMCURDT,IVMCURYR,IVMENDYR,IVMOUT,IVMPFLAG,X,Y
 Q
