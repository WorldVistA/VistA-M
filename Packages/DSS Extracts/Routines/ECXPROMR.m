ECXPROMR ;ALB/DAN Prosthetics Montly Rental report ;3/3/17  12:54
 ;;3.0;DSS EXTRACTS;**166**;Dec 22, 1997;Build 24
 ;
 N ECXPORT,DIOBEG,FLDS,BY,DIC,L,%ZIS,POP,IOP,ION,IOM,IOSL,DIRUT,DUOUT,DTOUT,X,ECXSD,ECXED,DIR,Y
 W !!,"This report will identify all prosthetic monthly rental items over a user",!,"selected time frame.  Enter the delivery start and end dates for the report.",!
 D GETDATE
 I '$D(ECXSD)!('$D(ECXED)) Q  ;No dates selected for sort
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1
 S FR=ECXSD,TO=ECXED
 S DIC="^RMPR(660,",L=0
 S BY="[ECX PRO RENTAL SORT"
 S FLDS="[ECX PRO RENTAL "_$S(ECXPORT:"EXPORT",1:"PRINT")
 I 'ECXPORT S DIOBEG="W @IOF" D EN1^DIP Q
 ;User wants report in exportable format
 I ECXPORT D
 .W !!,"To ensure all data is captured during the export:" ;144
 .W !!,"1. Select 'Logging...' from the File Menu. Select your file, and where to save." ;144
 .W !,"2. On the Setup menu, select 'Display...',then 'screen' tab and modify 'columns'",!,"   setting to at least 225 characters." ;144
 .W !,"3. The DEVICE input for the columns should also contain a large enough",!,"   parameter (e.g. 225).  The DEVICE prompt is defaulted to 0;225;99999 for you.",!,"   You may change it if need be." ;144
 .W !,"Example: DEVICE: 0;225;99999 *Where 0 is your screen, 225 is the margin width",!?17,"and 99999 is the screen length."
 .W !!,"NOTE:  In order for all number fields, such as SSN and Feeder Key, to be",!,"displayed correctly in the spreadsheet, these fields must be formatted as Text",!,"when importing the data into the spreadsheet.",! ;144
 .S DIOBEG="W ""PATIENT NAME^QUANTITY^PSAS HCPCS^INITIATOR"""
 .S %ZIS="N",%ZIS("B")="0;225;99999" D ^%ZIS Q:POP  S IOP=ION_";"_IOM_";"_IOSL
 .D EN1^DIP
 .Q
 D HOME^%ZIS
 Q
 ;
GETDATE ;Get starting and ending date for sort
 S DIR(0)="DO^::AEX",DIR("A")="Enter starting delivery date",DIR("?")="Enter date to begin searching from" D ^DIR Q:$D(DIRUT)  S ECXSD=Y
 S DIR(0)="DOA^"_ECXSD_"::AEX",DIR("A")="Enter ending delivery date: ",DIR("?")="Enter date to stop searching.  Must be after "_$$FMTE^XLFDT(ECXSD,2) D ^DIR Q:$D(DIRUT)
 S ECXED=Y
 Q
