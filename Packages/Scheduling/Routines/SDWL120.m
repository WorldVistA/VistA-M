SDWL120 ;IOFO BAY PINES/esw- EWL- 120 delay appt message;05/28/2006  ; Compiled April 9, 2007 14:19:00
 ;;5.3;scheduling;**446**;AUG 13, 1993;Build 77
 ;
MESS(DFN,SDWLDA,SDPR) ;
 ; SDWLDA - EWL IEN to 409.3
 ; SDPR - flag indicating creation of 409.32 clinic entry
 ;        0 - no entry
 ;        1 - entry created
 S ^TMP("SDWL120",$J,.01)="An open Wait List entry was created with a 120 days flag, indicating that it"
 S ^TMP("SDWL120",$J,.02)="was not possible to schedule an appointment for the listed clinic within"
 S ^TMP("SDWL120",$J,.03)="120 days of the desired date."
 S ^TMP("SDWL120",$J,.04)=""
 N SDAPPT,Y
 S ^TMP("SDWL120",$J,.05)="An EWL Entry was created for the following patient,"
 S ^TMP("SDWL120",$J,.06)=""
 S ^TMP("SDWL120",$J,.07)=$$FORM^SDFORM("PATIENT NAME",23,"SSN",12,"EWL",35)
 S ^TMP("SDWL120",$J,.08)="--------------------------------------------------------------------------"
 S ^TMP("SDWL120",$J,.09)=$$FORM^SDFORM($E($$GET1^DIQ(2,DFN_",",.01,"I"),1,25),23,$$GET1^DIQ(2,DFN_",",.09,"I"),12,$$GET1^DIQ(409.3,SDWLDA_",",8),35)
 S ^TMP("SDWL120",$J,.1)=""
 I SDPR S ^TMP("SDWL120",$J,.11)="SD WL CLINIC LOCATION parameter entry created."
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="EWL opened entry with a 120 days flag"
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWL120"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWL120",$J)
 Q
 ;
MESS2(SC) ;
 ; SC - pointer to file 44
 S ^TMP("SDWL120",$J,.01)="An attempt has been made to create an EWL Entry after the lack of"
 S ^TMP("SDWL120",$J,.02)="any availability on the clinic,"
 S ^TMP("SDWL120",$J,.03)=$$GET1^DIQ(44,SC,.01)
 S ^TMP("SDWL120",$J,.04)="within 120 days of a patient's desired date."
 S ^TMP("SDWL120",$J,.05)=""
 S ^TMP("SDWL120",$J,.06)="The clinic has no linked Institution or Division which are required"
 S ^TMP("SDWL120",$J,.07)="to create the association with a Wait List."
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="EWL Location entry could not be created"
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWL120"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD
 K ^TMP("SDWL120",$J)
 Q
