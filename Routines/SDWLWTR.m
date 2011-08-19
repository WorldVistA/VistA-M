SDWLWTR ;;IOFO BAY PINES/DMR - EWL WAIT TIME REPORT 8/1/06; 29 Aug 2002  2:54 PM
 ;;5.3;scheduling;**419**;AUG 13 1993;Build 16
START ;
 W !,"EWL Wait Time Statistics"
 W !,"The following fields from file SD WAIT LIST (#409.3) are included in this report."
 W !!,"   Originating Date"
 W !,"   Scheduling Date of Appt"
 W !,"   Date Appt Made"
 W !,"   Date of Disposition"
 W !,"   Desired Date of Appointment"
 W !!
CAL W !,"The following fields are computed calculations included in the report."
 W !,"Refer to the following report key to translate field values:"
 W !!,"   a = Scheduled Date of Appt - Originating Date"
 W !,"   b = Desired Date of Appointment - Originating Date"
 W !,"   c = Desired Date of Appointment - Scheduled Date of Appt"
 W !,"   d = Date of Disposition - Originating Date"
 W !,"   e = Originating Date - Date Appt Made"
