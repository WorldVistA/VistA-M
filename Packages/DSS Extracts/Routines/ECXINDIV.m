ECXINDIV ;ALB/DAN - Print institution and division information ;6/24/19  16:17
 ;;3.0;DSS EXTRACTS;**174**;Dec 22, 1997;Build 33
 ;
 N QFLG,TYPE,SITE,ECXPORT,DIC,DR,BY,FLDS,DHD,DIOBEG,HEADER,FR,TO
 S QFLG=0
 D CHOICE Q:QFLG
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1
 S DIC=$S(TYPE=1:"^DIC(4,",1:"^DG(40.8,")
 S BY=$S(TYPE=1:"STATION NUMBER["_$E(+$$GET1^DIQ(4,SITE,99,"E"),1,3),1:"@FACILITY NUMBER")
 I TYPE=2 S (FR,TO)=""
 S FLDS="[ECX "_$S(TYPE=1:"INST",1:"DIV")_" "_$S(ECXPORT:"EXPORT",1:"PRINT")
 I 'ECXPORT S DIOBEG="W @IOF",DHD=$S(TYPE=1:"Institution",1:"Medical Center Division")_" file listing" D EN1^DIP Q
 I ECXPORT D
 .W !!,"To ensure all data is captured during the export:"
 .W !!,"1. In reflections, change the row margin by clicking on one of the change margin",!,"   icons with a value of 225 or higher if you have them."
 .W !,"   You may also set the margin manually by clicking on appearance, expanded",!,"   terminal settings (arrow in lower right corner), set up display settings."
 .W !,"   Scroll to the bottom and change the number of characters per row to 225"
 .W !,"   or higher.  Click 'OK' to save your change."
 .W !,"2. Click on 'capture setup' or 'tools, logging (arrow in lower right corner)'",!,"   depending on your setup.  Ensure the logging settings form only has 'to disk'",!,"   selected and enter"
 .W " the path and filename where the output should be stored."
 .W !,"3. Click 'start capture' or 'start logging', depending on your interface."
 .W !,"4. The DEVICE input for the columns should also contain a large enough",!,"   parameter (e.g. 225).  The DEVICE prompt is defaulted to 0;225;99999 for you.",!,"   You may change it if need be."
 .W !,"Example: DEVICE: 0;225;99999 *Where 0 is your screen, 225 is the margin width",!?17,"and 99999 is the screen length."
 .W !!,"NOTE:  In order for all number fields, such as SSN and Feeder Key, to be",!,"displayed correctly in the spreadsheet, these fields must be formatted as Text",!,"when importing the data into the spreadsheet.",!
 .S HEADER="NUMBER^NAME^"_$S(TYPE=1:"STATION NUMBER^INACTIVE FACILITY FLAG",1:"FACILITY NUMBER")
 .S DIOBEG="W HEADER"
 .S %ZIS="N",%ZIS("B")="0;225;99999" D ^%ZIS Q:POP  S IOP=ION_";"_IOM_";"_IOSL
 .D EN1^DIP
 .I '$G(POP) D
 ..W !!,"Click 'stop capture' or 'tools, stop logging' to end logging..."
 ..W !,"...Then, pull your export text file into your spreadsheet.",!
 .Q
 D HOME^%ZIS
 Q
 Q
 ;
CHOICE ;Choose institution or division.  If institution, select one
 N DIR,DIRUT,DTOUT,DUOUT,Y,DIC
 S DIR(0)="SO^1:Institution/Station (file #4);2:Medical Center Division (file #40.8)"
 S DIR("?",1)="Selecting 1 will display all entries in the INSTITUTION file that contain",DIR("?",2)="the base station number of the location selected at the next prompt."
 S DIR("?",3)=" "
 S DIR("?")="Selecting 2 will display all entries in the MEDICAL CENTER DIVISION file."
 D ^DIR
 I '+Y S QFLG=1 Q
 S TYPE=Y
 I TYPE=1 S DIC="^DIC(4,",DIC(0)="AEMQ",DIC("S")="I $P($G(^DIC(4,Y,99)),U)'=""""" D ^DIC S SITE=+Y I SITE'>0 S QFLG=1 Q
 Q
