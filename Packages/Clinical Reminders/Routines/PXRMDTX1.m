PXRMDTX1 ; SLC/AGP - Reminder Dialog Taxonomy Field editor/List Manager ;Jun 22, 2021@08:09:50
 ;;2.0;CLINICAL REMINDERS;**65**;Feb 04, 2005;Build 438
 ;
HELP(HTEXT) ;
 N CNT S CNT=1
 S HTEXT(CNT)="Set the taxonomy pick list display for the codes marked to be used in a dialog."
 S CNT=CNT+1,HTEXT(CNT)="\\\\   A: To display a pick list for all coding systems "
 S CNT=CNT+1,HTEXT(CNT)="\\\\   D: To display a pick list for the diagnosis codes."
 S CNT=CNT+1,HTEXT(CNT)="\\\\      Other coding system values will automatically be filed to the encounter."
 S CNT=CNT+1,HTEXT(CNT)="\\\\   P: To display a pick list for the procedure codes."
 S CNT=CNT+1,HTEXT(CNT)="\\\\      Other coding system values will automatically be filed to the encounter."
 S CNT=CNT+1,HTEXT(CNT)="\\\\   S: To display a pick list for standard codes."
 S CNT=CNT+1,HTEXT(CNT)="\\\\      Other coding system values will automatically be filed to the encounter."
 S CNT=CNT+1,HTEXT(CNT)="\\\\   N: To not display a pick list all codes will automatically be filed to the encounter."
 Q
 ;
