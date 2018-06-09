PXRRPRSC ;ISL/PKR - PCE reports provider selection criteria routines. ;01/30/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**12,18,211**;Aug 12, 1996;Build 244
 ;
 ;=======================================================================
PRTYPE ;Select the type of report.
 N X,Y
 K DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"S:Summary;D:Detail by clinic and date"
 S DIR("A")="Which type of report"
 S DIR("B")="S"
 S DIR("?",1)="Choose between a detailed report that gives the number of encounters by clinic"
 S DIR("?",2)="and date for each provider or the summary report that gives only the total"
 S DIR("?")="encounters for each provider."
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S PXRRPRTY=Y_U_Y(0)
 Q
 ;
 ;=======================================================================
 ;
PRV ;Establish the Provider selection criteria.
 N X,Y
 K DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"A:All Providers (with encounters);"
 S DIR(0)=DIR(0)_"P:Primary Providers (with encounters);"
 S DIR(0)=DIR(0)_"S:Selected Providers;"
 S DIR(0)=DIR(0)_"C:Selected Person Classes;"
 S DIR(0)=DIR(0)_"T:Select Providers by CPRS Team (OE/RR List)"
 S DIR("A")="Select ENCOUNTER PROVIDER CRITERIA"
 S DIR("B")="S"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S PXRRPRSC=Y_U_Y(0)
 ;
 ;If Providers are to be selected individually, by class, or by team
 ;get the list.
 I Y="S" D PRV^PXRRPRPL
 I $D(DTOUT) Q
 I $D(DUOUT) G PRV
 I Y="C" D PCLASS^PXRRPECS
 I $D(DTOUT) Q
 I $D(DUOUT) G PRV
 I Y="T" D TEAM^PXRRPRPL
 I $D(DTOUT) Q
 I $D(DUOUT) G PRV
 Q
 ;
