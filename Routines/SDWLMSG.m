SDWLMSG ;IOFO BAY PINES/DMR - EWL-SC PRIORITY BACKGROUND MESSAGES;09/02/2004 2:10 PM [5/12/05 2:58pm]  ; Compiled June 7, 2006 11:07:43  ; Compiled May 1, 2007 15:08:25
 ;;5.3;scheduling;**327,394,446**;AUG 13, 1993;Build 77
 ;
MESS ;Send message 1
 S ^TMP("SDWLQSC1",$J,.01)="Patient Name                    SSN   OLD-EWL/SC %  NEW-EWL/SC %  PRIORITY"
 S ^TMP("SDWLQSC1",$J,.02)="------------                    ---   ------------  ------------  --------"
 S ^TMP("SDWLQSC1",$J,.03)=""
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="EWL SC Patient Update with SC Priority"
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWLQSC1"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWLQSC1",$J)
 Q
MESS1 ;Send message 2    
 S ^TMP("SDWLQSC2",$J,.01)="Patient Name                    SSN   OLD-EWL/SC %  NEW-EWL/SC % MULTI-ENTRIES"
 S ^TMP("SDWLQSC2",$J,.02)="------------                    ---   ------------  ------------ -------------"
 S ^TMP("SDWLQSC2",$J,.03)=""
 S ^TMP("SDWLQSC2",$J,.04)="** NOTE: EWL SC PRIORITY MAY REQUIRE MANUAL UPDATE. PLEASE REVIEW **"
 S ^TMP("SDWLQSC2",$J,.05)=""
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="EWL SC Patient Update with SC Percentage Change"
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWLQSC2"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWLQSC2",$J)
 Q
MESS2 ;
 S ^TMP("SDWLQSC3",$J,.01)="This message displays any pending appointments in the EWL file which have"
 S ^TMP("SDWLQSC3",$J,.02)="a status of 'CANCELED BY CLINIC', there may be further action required if"
 S ^TMP("SDWLQSC3",$J,.03)="the patient still needs an appointment."
 S ^TMP("SDWLQSC3",$J,.04)=""
 N SDFORM S SDFORM=$$FORM^SDFORM("PATIENT NAME",32,"CLINIC",27,"DATE/TIME of APPT",21) D  ;added
 .S ^TMP("SDWLQSC3",$J,.05)=SDFORM
 S ^TMP("SDWLQSC3",$J,.06)="-------------------------------------------------------------------------------"
 S ^TMP("SDWLQSC3",$J,.07)=""
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="EWL appointment entries with a status of 'CANCELED BY CLINIC'."
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWLQSC3"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWLQSC3",$J)
 Q
MESS3 ;
 S ^TMP("SDWLQSC4",$J,.01)="This message displays the number of open Wait List entries that are tied to"
 S ^TMP("SDWLQSC4",$J,.02)="an Inactive Clinic. These Wait List entries may require further action,"
 S ^TMP("SDWLQSC4",$J,.03)="please review."
 S ^TMP("SDWLQSC4",$J,.04)=""
 S ^TMP("SDWLQSC4",$J,.05)="CLINIC and NUMBER of WAIT LIST entries"
 S ^TMP("SDWLQSC4",$J,.06)=""
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="INACTIVE CLINICS with OPEN WAIT LIST entries."
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWLQSC4"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWLQSC4",$J)
 Q
MESS4 ;PCMM Inactivative Team Report
 S ^TMP("SDWLQSC5",$J,.01)="This message displays any PCMM Teams that have been inactivated"
 S ^TMP("SDWLQSC5",$J,.02)="and have patients waiting on the Wait List.  The PCMM Teams"
 S ^TMP("SDWLQSC5",$J,.03)="are displayed along with the number of open Wait List entries."
 S ^TMP("SDWLQSC5",$J,.04)=""
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="Wait List PCMM Inactive Team Report"
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWLQSC5"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWLQSC5",$J)
 Q
MESS5 ;PCMM Position Inactivation Report
 S ^TMP("SDWLQSC6",$J,.01)="This message displays any PCMM Positions that have been inactivated"
 S ^TMP("SDWLQSC6",$J,.02)="and have patients waiting on the Wait List.  The PCMM Positions"
 S ^TMP("SDWLQSC6",$J,.03)="are displayed along with the number of open Wait List entries."
 S ^TMP("SDWLQSC6",$J,.04)=""
 S ^TMP("SDWLQSC6",$J,.05)="Team Position                  Team                      Open EWL Entries"
 S ^TMP("SDWLQSC6",$J,.06)=""
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="Wait List PCMM Inactive Position Report"
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWLQSC6"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWLQSC6",$J)
 Q
MESS6 ;Date of Death error message
 S ^TMP("SDWLQSC7",$J,.01)="This message displays any patient on the Wait List who had "
 S ^TMP("SDWLQSC7",$J,.02)="a Date of Death entered in error.  The Wait List entry is"
 S ^TMP("SDWLQSC7",$J,.03)="reopened and may require additional follow-up."
 S ^TMP("SDWLQSC7",$J,.04)=""
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="Wait List Date of Death Error Report"
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWLQSC7"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWLQSC7",$J)
 Q
MESS7 ;PCMM Team available slots
 S ^TMP("SDWLQSC8",$J,.01)="This message displays any PCMM Teams that have open EWL entries"
 S ^TMP("SDWLQSC8",$J,.02)="waiting - and now have open slots available.  Message displays"
 S ^TMP("SDWLQSC8",$J,.03)="PCMM Team and number of open slots and number of EWL entries waiting"
 S ^TMP("SDWLQSC8",$J,.04)="for that PCMM Team."
 S ^TMP("SDWLQSC8",$J,.05)=""
 S ^TMP("SDWLQSC8",$J,.07)=""
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="PCMM Team Report of Available Slots"
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWLQSC8"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWLQSC8",$J)
 Q
MESS8 ;PCMM Position available open slots
 S ^TMP("SDWLQSC9",$J,.01)="This message displays any PCMM Positions that have open EWL entries"
 S ^TMP("SDWLQSC9",$J,.02)="waiting - and now have open slots available.  Message displays"
 S ^TMP("SDWLQSC9",$J,.03)="PCMM Position and number of open slots and number of EWL entries waiting"
 S ^TMP("SDWLQSC9",$J,.04)="for that PCMM Position."
 S ^TMP("SDWLQSC9",$J,.05)=""
 S ^TMP("SDWLQSC9",$J,.07)=""
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="PCMM Positions Report of Available Slots"
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWLQSC9"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWLQSC9",$J)
 Q
MESS9(DFN) ;
 S ^TMP("ENC",$J,.01)="This message displays any open EWL Clinic (C) or Specialty (S) type entries"
 S ^TMP("ENC",$J,.02)="along with the date/time of the first identified encounter or appointment for"
 S ^TMP("ENC",$J,.03)="that patient (in the same Clinic or Specialty) entered after the origination"
 S ^TMP("ENC",$J,.04)="date of the EWL entry."
 S ^TMP("ENC",$J,.05)=""
 S ^TMP("ENC",$J,.06)="Please review, and Disposition the EWL entry if the encounter/appointment has"
 S ^TMP("ENC",$J,.07)="satisfied the need for the EWL entry."
 N SDFORM S SDFORM=$$FORM^SDFORM("PATIENT NAME",22,"CLINIC",18,"EWL Type-Org. Date",25,"Date/Time of Appt",21) D  ;added
 .S ^TMP("ENC",$J,.08)=SDFORM
 S ^TMP("ENC",$J,.09)="-------------------------------------------------------------------------------"
 N SSN S SSN=$$GET1^DIQ(2,DFN_",",.09,"I"),SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)
 S ^TMP("ENC",$J,.1)=SSN
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="EWL entries with existing, related appointment/encounter."
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""ENC"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("ENC",$J)
 Q
