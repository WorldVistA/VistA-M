IBCNEMS1 ;AITC/DM - Consolidated Mailman messages; 12-JUNE-2018
 ;;2.0;INTEGRATED BILLING;**621,631,659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; 
 ; These routines are being consolidated in one area for ease in maintenance 
 ; The calling routine is responsible for setting the target MAILGROUP, Subject text 
 ; and finally calling MSG^IBCNEUT5(...) to send the actual Mailman message
 ; 
MSG001(MSG,EXNAME) ; error msg for $$SDAPI^SDAMA301 appointment api issue from an extract 
 ; MSG is the global that will be populated with message text.
 ; EXNAME is the extract that had the issue (e.g. "EICD") 
 ; It is assumed that ^TMP($J,"SDAMA301") has been populated by the failed call
 ;
 N IBMSG,IBII
 S MSG(1)="On "_$$FMTE^XLFDT(DT)_" the "_EXNAME_" Extract for eIV encountered"
 S MSG(2)="one or more errors while attempting to get Appointment data"
 S MSG(3)="from the scheduling package."
 S MSG(4)=""
 S MSG(5)="Error(s) encountered: "
 S MSG(6)=""
 S MSG(7)="  Error Code   Error Message"
 S MSG(8)="  ----------   -------------"
 S IBMSG=8,IBII=0
 F  S IBII=$O(^TMP($J,"SDAMA301",IBII)) Q:IBII=""  S IBMSG=IBMSG+1,MSG(IBMSG)="  "_$$LJ^XLFSTR(IBII,13)_$G(^TMP($J,"SDAMA301",IBII))
 S IBMSG=IBMSG+1,MSG(IBMSG)=""
 S IBMSG=IBMSG+1,MSG(IBMSG)="As a result of this error the extract was not done.  The extract"
 S IBMSG=IBMSG+1,MSG(IBMSG)="will be attempted again the next night automatically.  If you"
 S IBMSG=IBMSG+1,MSG(IBMSG)="continue to receive error messages you should contact your IRM"
 S IBMSG=IBMSG+1,MSG(IBMSG)="and possibly call the Help Desk for assistance."
 ;
 Q
 ;
MSG002(MSG,ERRGB,TQ) ; error msg when writing to EIV EICD TRACKING (#365.18) from IBCNEDE4
 ; MSG is the global that will be populated with message text.
 ; ERRBG is the ERROR global that was passed to a Fileman ^DIE call
 ; TQ IEN of the associated IIV Transmission Queue
 ; The user should verify that there is an existing error before making this call  
 ; Set to IB site parameter MAILGROUP
 ;
 S MSG(1)="Tried to create an entry in the EIV EICD TRACKING file #365.18"
 S MSG(2)="without success."
 S MSG(3)=""
 S MSG(4)="Error encountered: "_$G(ERRGB("DIERR",1,"TEXT",1))
 S MSG(5)=""
 S MSG(6)="The associated IIV Transmission Queue IEN: "_TQ
 S MSG(7)=""
 S MSG(8)="If you continue to receive this error message, you should contact"
 S MSG(9)="your IRM and possibly call the Help Desk for assistance."
 Q
 ;
MSG003(MSG,ERRGB,TQN,RESP,BUFF) ;  Create and send a response processing error warning message
 ; Output Variables
 ; ERFLG=1
 ;
 S MSG(1)="Tried to create an entry in the CREATION TO PROCESSING TRACKING file #355.36"
 S MSG(2)="without success."
 S MSG(3)=""
 S MSG(4)="Error encountered: "_$G(ERRGB("DIERR",1,"TEXT",1))
 S MSG(5)=""
 S MSG(6)="The associated IIV Transmission Queue IEN: "_$G(TQN)
 S MSG(7)="The associated IIV Repsonse IEN: "_$G(RESP)
 S MSG(8)="The associated INSURANCE VERIFICATION PROCESSOR IEN: "_$G(BUFF)
 S MSG(9)=""
 S MSG(10)="If you continue to receive this error message, you should contact"
 S MSG(11)="your IRM and possibly call the Help Desk for assistance."
 Q
 ;
 ;/vd-IB*2*659 - The following module of code was added.
MSG004(MSG,SITE) ;  Create a message that the IIV EC logical link is stuck/down.
 ;
 S MSG(1)="Check of IIV EC Logical Link: No activity seen in link"
 S MSG(2)="for site: "_SITE_"."
 S MSG(3)="The IIV EC logical link needs to be bounced or turned on."
 Q
 ;
