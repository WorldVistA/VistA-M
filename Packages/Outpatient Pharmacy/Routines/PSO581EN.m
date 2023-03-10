PSO581EN ;ALB/BWF^PSO*7*581 ENV CHECK ; 10/25/2019 12:14pm
 ;;7.0;OUTPATIENT PHARMACY;**581**;DEC 1997;Build 126
 I '$D(^TMP("PSO581PO")) D  Q
 .D EN^DDIOL("The file PSO_7_581.GBL must be loaded before installation.")
 .S DIR(0)="E",DIR("A")="Press enter to continue" D ^DIR
 .S XPDABORT=1,XPDQUIT=1,XPDQUIT("PSO*7.0*581")=1
 Q
