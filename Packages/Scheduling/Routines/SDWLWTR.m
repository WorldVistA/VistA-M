SDWLWTR ;IOFO BAY PINES/DMR - EWL WAIT TIME REPORT 8/1/06 ;1/11/16 10:21am
 ;;5.3;scheduling;**419,645**;AUG 13 1993;Build 7
START ;
 W !,"EWL Wait Time Statistics"
 W !,"The following fields from file SD WAIT LIST (#409.3) are included in this report."
 W !!,"   Originating Date"
 W !,"   Scheduling Date of Appt"
 W !,"   Date Appt Made"
 W !,"   Date of Disposition"
 ; SD*5.3*645 - replaced Desired Date with CID/Preferred Date
 ;W !,"   Desired Date of Appointment"
 W !,"   CID/Preferred Date of Appointment"
 W !!
CAL W !,"The following fields are computed calculations included in the report."
 W !,"Refer to the following report key to translate field values:"
 W !!,"   a = Scheduled Date of Appt - Originating Date"
 ; SD*5.3*645 replaced Desired Date with CID/Preferred Date
 ;W !,"   b = Desired Date of Appointment - Originating Date"
 W !,"   b = CID/Preferred Date of Appointment - Originating Date"
 ;W !,"   c = Desired Date of Appointment - Scheduled Date of Appt"
 W !,"   c = CID/Preferred Date of Appointment - Scheduled Date of Appt"
 W !,"   d = Date of Disposition - Originating Date"
 W !,"   e = Originating Date - Date Appt Made"
