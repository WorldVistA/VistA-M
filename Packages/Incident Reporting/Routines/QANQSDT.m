QANQSDT ;HISC/GJC-FM report for quarterly data rolled to region ;9/3/93  12:19
 ;;2.0;Incident Reporting;**21**;08/07/1992
 ;
 ;-----------------------------------------------------------------------
EN1 ;Enter at this point (1)                                               |
 ;-----------------------------------------------------------------------
 D KILL W @IOF ;Ensure a clean partition for EN1^DIP, clear screen.
 K DIR S DIR(0)="Y",DIR("B")="Yes"
 S DIR("A",1)="Do you wish generate a report which compiles"
 S DIR("A")="Incident Event Data for a given quarter"
 S DIR("?")="Enter 'Y' to create a report, 'N' to exit without a report."
 D ^DIR K DIR
 I +Y=0 D  Q
 . W !!?5,$C(7),"Incident Event Data Compilation Report will not be"
 . W !?5,"generated, exiting."
 . D KILL
 S QAQDATE="'Q" D ^QAQDATE
 I QAQQUIT D KILL Q
 S BY=".02",DIC="^QA(742.6,",FLDS="[CAPTIONED]",FR=QAQNBEG
 S DIASKHD="",TO=QAQNEND
 S DHD="Incident Event Data Compilation For: "_$G(QAQ2HED)
 D EN1^DIP
 ;-----------------------------------------------------------------------
KILL ;Kill and exit the option                                              |
 ;-----------------------------------------------------------------------
 K %,B,BY,DA,DCC,DG,DHD,DIASKHD,DIC,DIE,DIJ,DINS,DIPT,DK,DP,DR
 K FLDS,FR,TO D K^QAQDATE,KILL^QAQDATE,HOME^%ZIS
 Q
