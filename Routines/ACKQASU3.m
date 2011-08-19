ACKQASU3 ;HCIOFO/BH-New/Edit Visit Utilities  ;  04/01/99
 ;;3.0;QUASAR;**2**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
PCESEND(ACKVIEN) ;  This function is called from within the New Visit
 ; and Edit visit processing.  It calls the send to PCE function.
 ; The SEND to PCE function returns either true or false depending on
 ; whether the visit has been sent successfully. It the SEND function
 ; returns true this function quits returning a true value.  If the 
 ; SEND function returns false the error is displayed (contained in the 
 ; error multiple of the A&SP visit file).  The user is then offered
 ; the option to either quit processing this visit and leave it with an
 ; error or to return back into the visit entry function - thus 
 ; enabling the user to edit the erroreous field.
 ;
 ;    Input  : ACKVIEN=IEN of visit to be processed
 ;    Output : '1' or '0'
 ;
 N X,Y,DA,D,D0,DA,DI,DIC,DIE,DIFLD,DK,DL,DR
 I $$SENDPCE^ACKQPCE(ACKVIEN) Q 1
 ;  If here transmission was unsucceful - Error text will in field 6.5
 ;
 ; Display transmission Error
 D ERORDISP(ACKVIEN)
 ;
 ; Prompt user if they wish to re-edit the visit
 ;
TEST S DIR("A")=" Do you wish to Re-edit this Visit "
 S DIR("B")="Y"
 S DIR("?")=" Do you wish to Re-edit this visit or Quit ?  Enter (Y) or (N)."
 S DIR(0)="Y"
 D ^DIR K DIR
 I $D(DIRUT) Q 1
 I X="Y"!(X="y") Q 0
 I X="N"!(X="n") Q 1
 ;
 Q
 ;
ERORDISP(ACKVIEN) ;   Display text that defines the reason for the 
 ;  transmission failiure to PCE.
 ;  Passed in Visit IEN, Displays error multiple (6.5) of the associated
 ;  visit.
 N ACKNUM,ACKK1,ACKTGT,ACKFLD,ACKVAL,ACKERR
 ;
 W @IOF
 I $O(^ACK(509850.6,ACKVIEN,6.5,0))="" D HEADING W !!!," No Error information returned for display.",!! Q
 ;
 S ACKK1=0  D HEADING
 F  S ACKK1=$O(^ACK(509850.6,ACKVIEN,6.5,ACKK1)) Q:'+ACKK1  D
 . D GETS^DIQ(509850.65,ACKK1_","_ACKVIEN_",",".02;.04;1","I","ACKTGT")
 . S ACKFLD=$G(ACKTGT(509850.65,ACKK1_","_ACKVIEN_",",.02,"I"))
 . S ACKVAL=$G(ACKTGT(509850.65,ACKK1_","_ACKVIEN_",",.04,"I"))
 . S ACKERR=$G(ACKTGT(509850.65,ACKK1_","_ACKVIEN_",",1,"I"))
 . S ACKNUM=$E("Error #"_ACKK1,1,10),ACKFLD=$E("Field: "_ACKFLD,1,28)
 . S ACKVAL=$E("Value: "_ACKVAL,1,21),ACKERR=$E("Message: "_ACKERR,1,72)
 . W !!,?2,ACKNUM,?20,ACKFLD,?50,ACKVAL,!
 . W ?2,ACKERR
 ;
 W !!
 Q
 ;
HEADING ;
 W "There has been an Error during the Transmission of this QUASAR visit.",!
 W "The PCE system has return the following Errors for this visit."
 Q
 ;
DATACHK(ACKVIEN) ; PCE Data integrity check.  
 ; Only called if Quasar visit has a value within the PCE VISIT IEN 
 ; field.  This routine check the Clinic,Patient,Appointment time and 
 ; Visit date values on the quasar file and compares them to the same 
 ; fields on the associated PCE record.  If the values are all the same
 ; the routine Quits.  If the Clinic,Patient or Visit Date are different 
 ; then a message is displayed to the user detailing which field(s) are
 ; different and then deletes the PCE VISIT IEN.If just the Appointment
 ; Time is different a message is displayed the user then has the choice
 ; to either overwrite the Quasar time with the PCE time or to leave the 
 ; Quasar time as it is and Quasar will delete the PCE VISIT IEN.
 N ACKARR,ACKTEST,ACKSTAT,ACKOUT
 S ACKTEST=$$PCECHKV^ACKQUTL3(ACKVIEN)
 S ACKSTAT=$P(ACKTEST,"^",1)
 ;
 I ACKSTAT=2 Q 1              ;  Everything is okay
 ;
 I ACKSTAT=0 D  Q ACKOUT      ;  Clinic, Patient or Visit Date different
 . W !!,"The following fields within the PCE Visit entry linked to this Quasar visit no"
 . W !,"longer match.",!
 . I '$P(ACKTEST,U,2) W !,"   CLINIC LOCATION"
 . I '$P(ACKTEST,U,3) W !,"   PATIENT"
 . I '$P(ACKTEST,U,4) W !,"   VISIT DATE"
 . W !!,"Due to this mismatch the link between this Quasar visit and the PCE visit will"
 . W !,"be broken.",!
 . S ACKARR(509850.6,ACKVIEN_",",125)="" D FILE^DIE("","ACKARR")
 . W !,"Enter <RETURN> to continue processing this visit or '^' to Quit."
 . S DIR(0)="E" D ^DIR I $D(DUOUT)!($D(DTOUT)) S ACKOUT=0 Q
 . S ACKOUT=1 Q
 ;
 I ACKSTAT=1 D  Q ACKOUT
 . W !!,"The Appointment Time of "_$$FMT^ACKQUTL6(ACKTEST)_" within the PCE Visit no longer matches the"
 . W !,"Appointment Time of "_$$FMT^ACKQUTL6($$GET1^DIQ(509850.6,ACKVIEN_",",55,"I"))_" within the linked Quasar visit.",!
 . K DIR S DIR(0)="Y",DIR("B")="YES"
 . S DIR("A")="Update this Quasar Visit with PCE Appointment Time "
 . S DIR("?")="Enter YES to Update Quasar with the linked PCE visits Appointment Time, 'NO' to break the link between the Quasar visit and the PCE Visit or '^' to Quit with no action."
 . D ^DIR K DIR I $D(DTOUT) S X=U
 . I X="^" S ACKOUT=0 Q
 . I $E(X)="N" S ACKARR(509850.6,ACKVIEN_",",125)="" D FILE^DIE("","ACKARR") S ACKOUT=1 Q
 . I $E(X)="Y" S ACKARR(509850.6,ACKVIEN_",",55)=$P(ACKTEST,U,2) D FILE^DIE("","ACKARR") S ACKOUT=1 Q
 Q
 ;
