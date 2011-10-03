IBYCPT ;ALB/CPM - PATCH IB*2*34 POST-INITIALIZATION ; 21-JUN-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**34**; 21-MAR-94
 ;
EN ; Patch IB*2*34 post initialization.
 ;
 D LTR ;  add reminder letter to file #354.6
 D OPT ;  add new option to the Copay Exemption menu
 Q
 ;
 ;
LTR ; Add the reminder letter to the IB FORM LETTER (#354.6) file.
 Q:$D(^IBE(354.6,"B","IB INCOME TEST REMINDER"))
 W !!,">>> Adding the Reminder Letter into the IB FORM LETTER (#354.6) file..."
 S DIC(0)="",DIC="^IBE(354.6,",X="IB INCOME TEST REMINDER"
 K DO,DD D FILE^DICN S IBLET=+Y
 I IBLET'>0 W !?4,*7,"Unable to add the letter!  Contact your supporting ISC for assistance." G LTRQ
 ;
 S $P(^IBE(354.6,IBLET,0),"^",2,4)="Income Test Reminder Letter^2^15"
 ;
 ; - build letter body
 S ^IBE(354.6,IBLET,1,0)="^^13^13^"_DT_"^^^^"
 S ^IBE(354.6,IBLET,1,1,0)="The VA is required by law to charge veterans who receive medications"
 S ^IBE(354.6,IBLET,1,2,0)="on an outpatient basis for the treatment of nonservice-connected"
 S ^IBE(354.6,IBLET,1,3,0)="conditions, a copayment of $2.00 for each 30-day (or less) supply"
 S ^IBE(354.6,IBLET,1,4,0)="of medication provided.  Based on the income information requested"
 S ^IBE(354.6,IBLET,1,5,0)="each year, some veterans may be exempt from the copayment."
 S ^IBE(354.6,IBLET,1,6,0)=" "
 S ^IBE(354.6,IBLET,1,7,0)="Our records indicate that your medication copayment exemption"
 S ^IBE(354.6,IBLET,1,8,0)="status will expire on |VAR(""IBEXPD"")|."
 S ^IBE(354.6,IBLET,1,9,0)=" "
 S ^IBE(354.6,IBLET,1,10,0)="<enter a third paragraph which provides instructions to the veteran>"
 S ^IBE(354.6,IBLET,1,11,0)=" "
 S ^IBE(354.6,IBLET,1,12,0)=" "
 S ^IBE(354.6,IBLET,1,13,0)="<enter a signature title if desired>"
 ;
 ; - build letter header
 S ^IBE(354.6,IBLET,2,0)="^^6^6^"_DT_"^^^^"
 S ^IBE(354.6,IBLET,2,1,0)="Department of Veterans Affairs Medical Center"
 S ^IBE(354.6,IBLET,2,2,0)="<enter the facility street here>"
 S ^IBE(354.6,IBLET,2,3,0)="<enter the facility city/state/zip here>"
 S ^IBE(354.6,IBLET,2,4,0)=" "
 S ^IBE(354.6,IBLET,2,5,0)=" "
 S ^IBE(354.6,IBLET,2,6,0)=" "
 ;
LTRQ K DIC,IBLET,X,Y
 Q
 ;
OPT ; Add the option to reprint a reminder to the Copay Exemption menu.
 S Y=$O(^DIC(19,"B","IB RX EXEMPTION MENU",0)) I Y="" G OPTQ
 S X=$O(^DIC(19,"B","IB RX REPRINT REMINDER",0)) I X="" G OPTQ
 W !!,">>> Adding IB RX REPRINT REMINDER option to the IB RX EXEMPTION MENU..."
 I '$D(^DIC(19,+Y,10,0)) S ^DIC(19,+Y,10,0)="^19.01IP^0^0"
 S (DA,D0)=+Y,DIC="^DIC(19,"_+Y_",10,",DIC(0)="L",DA(1)=+Y,DLAYGO=19.01,X="IB RX REPRINT REMINDER" D ^DIC
 S DA=+Y,DIE="^DIC(19,"_DA(1)_",10,",DR="2///^S X=""REPR""" D ^DIE
OPTQ K DIC,DIE,DA,DR,X,Y
 Q
