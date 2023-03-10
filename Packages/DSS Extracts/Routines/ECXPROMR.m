ECXPROMR ;ALB/DAN Prosthetics Rental report ;8/15/19  14:12
 ;;3.0;DSS EXTRACTS;**166,170,174,184**;Dec 22, 1997;Build 124
 ;
 N ECXPORT,DIOBEG,FLDS,BY,DIC,L,%ZIS,POP,IOP,ION,IOM,IOSL,DIRUT,DUOUT,DTOUT,X,ECXSD,ECXED,DIR,Y,STAST,STAEND,QFLG,DHD,FR,TO ;174
 W !!,"This report will identify all prosthetic rental items over a user",!,"selected time frame.  Enter the delivery start and end dates for the report.",! ;174
 D GETDATE
 I '$D(ECXSD)!('$D(ECXED)) Q  ;No dates selected for sort
 D GETSTA Q:$G(QFLG)  ;174 Get stations to search for (one or all)
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1
 S FR(1)=STAST,FR(2)=ECXSD,TO(1)=STAEND,TO(2)=ECXED ;174
 S DIC="^RMPR(660,",L=0
 S BY="[ECX PRO RENTAL SORT"_$S(ECXPORT:" EXPORT",1:"")
 S FLDS="[ECX PRO RENTAL "_$S(ECXPORT:"EXPORT",1:"PRINT")
 I 'ECXPORT S DIOBEG="W @IOF",DHD="Prosthetics rental listing from "_$$FMTE^XLFDT(ECXSD)_" through "_$$FMTE^XLFDT(ECXED) D EN1^DIP Q  ;174
 ;User wants report in exportable format
 I ECXPORT D
 .W !!,"To ensure all data is captured during the export:" ;144
 .;174 Logging instructions updated
 .W !!,"1. In reflections, change the row margin by clicking on one of the change margin",!,"   icons with a value of 225 or higher if you have them."
 .W !,"   You may also set the margin manually by clicking on appearance, expanded",!,"   terminal settings (arrow in lower right corner), set up display settings."
 .W !,"   Scroll to the bottom and change the number of characters per row to 225"
 .W !,"   or higher.  Click 'OK' to save your change."
 .W !,"2. Click on 'capture setup' or 'tools, logging (arrow in lower right corner)'",!,"   depending on your setup.  Ensure the logging settings form only has 'to disk'",!,"   selected and enter"
 .W " the path and filename where the output should be stored."
 .W !,"3. Click 'start capture' or 'start logging', depending on your interface."
 .W !,"4. The DEVICE input for the columns should also contain a large enough",!,"   parameter (e.g. 225).  The DEVICE prompt is defaulted to 0;225;99999 for you.",!,"   You may change it if need be." ;144
 .W !,"Example: DEVICE: 0;225;99999 *Where 0 is your screen, 225 is the margin width",!?17,"and 99999 is the screen length."
 .W !!,"NOTE:  In order for all number fields, such as SSN and Feeder Key, to be",!,"displayed correctly in the spreadsheet, these fields must be formatted as Text",!,"when importing the data into the spreadsheet.",! ;144
 .S DIOBEG="W ""DIV #^DIVISION NAME^PATIENT NAME^SSN^UNIT OF ISSUE^QUANTITY^PSAS HCPCS^DATE OF SERVICE^INITIATOR^ITEM DESCRIPTION^DATE FROM^DATE TO""" ;170,174,184 - Added SSN and Date of Service
 .S %ZIS="N",%ZIS("B")="0;225;99999" D ^%ZIS Q:POP  S IOP=ION_";"_IOM_";"_IOSL
 .D EN1^DIP
 .I '$G(POP) D  ;174
 ..W !!,"Click 'stop capture' or 'tools, stop logging' to end logging..." ;174
 ..W !,"...Then, pull your export text file into your spreadsheet.",! ;174
 .Q
 D HOME^%ZIS
 Q
 ;
GETDATE ;Get starting and ending date for sort
 S DIR(0)="DO^::AEX",DIR("A")="Enter starting delivery date",DIR("?")="Enter date to begin searching from" D ^DIR Q:$D(DIRUT)  S ECXSD=Y
 S DIR(0)="DOA^"_ECXSD_"::AEX",DIR("A")="Enter ending delivery date: ",DIR("?")="Enter date to stop searching.  Must be after "_$$FMTE^XLFDT(ECXSD,2) D ^DIR Q:$D(DIRUT)
 S ECXED=Y
 Q
 ;
GETSTA ;174 Section added to get station to search for (1 or all)
 N DIR,DIC,X,Y
 W !
 S (STAST,STAEND)=""
 S DIR(0)="Y",DIR("A")="Do you want to run the report for all divisions",DIR("B")="Y",DIR("?")="Enter Yes to see results for all divisions. Enter No to select one division."
 D ^DIR
 I Y Q  ;If all selected, quit
 I Y'=1,Y'=0 S QFLG=1 Q  ;If user didn't select yes or no then stop
 I Y=0 D
 .S DIC=40.8,DIC(0)="AEQ" D ^DIC
 .I Y=-1 S QFLG=1 Q  ;If no location selected then exit
 .S (STAST,STAEND)=$$GET1^DIQ(40.8,+Y,.07,"E") ;Get institution associated with medical center division
 .S (STAST,STAEND)=$$GET1^DIQ(4,STAST,99) ;Get Station Number
 Q
