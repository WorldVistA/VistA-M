GMTSP82 ;BP CHY20/RJT - GMTS*2.7*82 POST INIT: ; 2/22/07 1:56pm
 ;;2.7;HEALTH SUMMARY;**82**;Oct 20, 1995;Build 21
 Q
EN ;UPDATES DESCRIPTION OF HEALTH FACTOR COMPONENT IN ^GMT(142.1) AND CORRECTS A SPELLING MISTAKE IN THE CLINICAL REMINDERS SUMMARY DESCRIPTION
 N GMTSIEN,GMTSHS D BMES^XPDUTL("Updating the Health Summary component description file")
 S GMTSHS=$$FIND1^DIC(9.4,"","X","HEALTH SUMMARY","B","") I +GMTSHS=0 W !,"Health Summary package not found!  Aborting file updates...",! G END
 S GMTSIEN=$$FIND1^DIC(9.49,","_GMTSHS_",","X","2.7","B","") I +GMTSIEN=0 W !,"Health Summary version 2.7 not found!  Aborting file updates...",! G END
 K ^TMP($J,"WP")
 I $$PATCH^XPDUTL("GMTS*2.7*82")=0 D
 . S ^TMP($J,"WP",1,0)=""
 . S ^TMP($J,"WP",2,0)="Note: Health Factors have a DISPLAY ON HEALTH SUMMARY "
 . S ^TMP($J,"WP",3,0)="option that determines whether or not they will show on a Health Summary "
 . S ^TMP($J,"WP",4,0)="report."
 . S GMTSIEN=$$FIND1^DIC(142.1,"","X","PCE HEALTH FACTORS ALL","B","") G:+GMTSIEN=0 2
 . D WP^DIE(142.1,GMTSIEN_",",3.5,"AK","^TMP($J,""WP"")")
2 . S GMTSIEN=$$FIND1^DIC(142.1,"","X","PCE HEALTH FACTORS SELECTED","B","") G:+GMTSIEN=0 3
 . D WP^DIE(142.1,GMTSIEN_",",3.5,"AK","^TMP($J,""WP"")")
3 K ^TMP($J,"WP")
 S ^TMP($J,"WP",1,0)="This component is similar to PCE CLINICAL REMINDERS DUE except that it "
 S ^TMP($J,"WP",2,0)="shows all reminders, not just those that are due. The information will "
 S ^TMP($J,"WP",3,0)="include the NEXT due date, or N/A, and the LAST DATE. N/A reminders "
 S ^TMP($J,"WP",4,0)="will be displayed unless the IGNORE ON N/A field is set."
 S GMTSIEN=$$FIND1^DIC(142.1,"","X","CLINICAL REMINDERS SUMMARY","B","") G:+GMTSIEN=0 END
 D WP^DIE(142.1,GMTSIEN_",",3.5,"K","^TMP($J,""WP"")")
END K ^TMP($J,"WP")
 D BMES^XPDUTL("Update Complete")
 Q
