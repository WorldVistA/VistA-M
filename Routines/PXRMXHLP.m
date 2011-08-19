PXRMXHLP ; SLC/PJH - Reminder Reports Help Routine;12/30/2002
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C70",DIWL=0,DIWR=70
 ;
 I CALL=0 D
 .S HTEXT(1)="Individual Patient: Run a report against an individual patients."
 .S HTEXT(2)="Reminder Patient List: Run a report against a store patient list."
 .S HTEXT(3)="Location: Run a report for a single location or multiple locations."
 .S HTEXT(4)="OE/RR Team: Run a report against a OE/RR team"
 .S HTEXT(5)="PCMM Provider: Run a report for patient assigned to a PCMMprovider."
 .S HTEXT(6)="PCMM Team: Run a report against a PCMM Team."
 I CALL=1 D
 .S HTEXT(1)="Summary reports total the number of reminders applicable "
 .S HTEXT(2)="and due for the above patient samples."
 .S HTEXT(3)="Detailed reports list patients with reminders due in "
 .S HTEXT(4)="name order or by appointment date."
 I CALL=2 D
 .S HTEXT(1)="DETAILED reports list in alpha order patients in the"
 .S HTEXT(2)="selected patient sample with reminders due."
 .S HTEXT(3)="SUMMARY reports give totals of reminders due for the"
 .S HTEXT(4)="selected patient sample."
 I CALL=3 D
 .S HTEXT(1)="PREVIOUS will report on patients who visited the selected"
 .S HTEXT(2)="locations in the date range specified"
 .S HTEXT(3)="FUTURE will report on patients who have appointments at"
 .S HTEXT(4)="selected locations in the date range specified."
 I CALL=4 D
 .S HTEXT(1)="PRIMARY CARE ONLY excludes patients who are not assigned"
 .S HTEXT(2)="to the PCMM team as primary care. ALL displays all patients"
 .S HTEXT(3)="assigned to the provider in PCMM."
 I CALL=5 D
 .S HTEXT(1)="Selecting Y will display all future appointments for"
 .S HTEXT(2)="patients with reminders due. Selecting N will display"
 .S HTEXT(3)="for patients with due reminders only the next appointment"
 .I PXRMSEL="L" D
 ..S HTEXT(4)="AT THE SELECTED LOCATION"
 I CALL=6 D
 .S HTEXT(1)="Selecting Y will display patients with reminders in"
 .S HTEXT(2)="appointment date order. Selecting N will display patients"
 .S HTEXT(3)="with reminders in patient name order."
 I CALL=7 D
 .S HTEXT(1)="ADMISSIONS will report on inpatients admitted in the"
 .S HTEXT(2)="selected locations in the date range specified. "
 .S HTEXT(3)="CURRENT INPATIENTS will report on inpatients currently at"
 .S HTEXT(4)="selected locations."
 I CALL=8 D
 .S HTEXT(1)="Reports for ALL OUTPATIENT LOCATIONS, ALL INPATIENT LOCATIONS and ALL "
 .S HTEXT(2)="CLINIC STOPS produce a combined list of reminders due for"
 .S HTEXT(3)="for all locations in each facility selected."
 .S HTEXT(4)=""
 .S HTEXT(5)="Reports for SELECTED HOSPITAL LOCATIONS, SELECTED CLINIC STOPS and"
 .S HTEXT(6)="SELECTED CLINIC GROUPS list reminders due by location for "
 .S HTEXT(7)="each location selected."
 I CALL=9 D
 .I LIT="Facilities" D
 ..S HTEXT(1)="Selecting Y will display one report for all facilities combining"
 ..S HTEXT(2)="locations/teams with the same name. Selecting N will create a"
 ..S HTEXT(3)="separate report for each facility."
 .I LIT'="Facilities" D
 ..S HTEXT(1)="Selecting Y will display one report for all "_LIT_" selected."
 ..S HTEXT(2)="Selecting N will create a separate report for each "_LIT_"."
 I CALL=10 D
 .S HTEXT(1)="This option is only available if more than one location, team or provider is selected."
 .S HTEXT(2)="Selecting I prints only the individual reports. Selecting R prints"
 .S HTEXT(3)="the individual report plus overall totals for all locations, teams or providers."
 .S HTEXT(4)="Selecting T prints only the overall totals for all locations, teams or providers."
 I CALL=11 D
 .S HTEXT(1)="Selecting Y will display patients with reminders in ward/bed"
 .S HTEXT(2)="order. Selecting N will display patients with reminders in"
 .S HTEXT(3)="patient name order."
 I CALL=12 D
 .S HTEXT(1)="Selecting Y will display the full patient SSN. Selecting N"
 .S HTEXT(2)=" will display only the last 4 digits of the patient SSN."
 I CALL=13 D
 .S HTEXT(1)="Selecting Y will display the report as fields separated by"
 .S HTEXT(2)="a selected delimiter character. Headings are suppressed. This"
 .S HTEXT(3)="format of report is intended for import into PC spreadsheet (e.g. MS Excl)."
 .S HTEXT(4)="Selecting N will display the normal report with headings"
 I CALL=14 D
 .S HTEXT(1)="Select the character to be output as a delimiter in the report."
 I CALL=15 D
 .S HTEXT(1)="Selecting Y will display the clinic name for the appointment date/time"
 K ^UTILITY($J,"W")
 S IC=""
 F  S IC=$O(HTEXT(IC)) Q:IC=""  D
 . S X=HTEXT(IC)
 . D ^DIWP
 W !
 S IC=0
 F  S IC=$O(^UTILITY($J,"W",0,IC)) Q:IC=""  D
 . W !,^UTILITY($J,"W",0,IC,0)
 K ^UTILITY($J,"W")
 W !
 Q
