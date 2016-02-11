MPIFP61 ;OAK/ELZ - MPIF PATCH 61 ROUTINE ;07 MAY 2015
 ;;1.0;MASTER PATIENT INDEX VISTA;**61**;30 Apr 99;Build 3
 ;
ENV ; - environment check for patch (needs to stay on top of routine)
 ;   This is to double check the site correctly setup the WSDL
 ;   when patch MPIF*1*56 was released.  This may cause a hard
 ;   M error when executing but it is better we catch this during
 ;   the patch load process than after the patch is installed and
 ;   registration users are getting errors.
 ;
 N RETURN
 ; - check for production system, these checks can only be done there
 I '$$PROD^XUPROD Q
 ;
 ; - call to MVI HWSC query for a production test patient
 D PATIENT^MPIFXMLS(.RETURN,"1011478921V055178^NI^200M^USVHA")
 ;
 ; - if return <1 patch can not be installed be installed
 ;   they need to setup the MVI HWSC with the WSDL released.
 I $G(RETURN)<1 D  S XPDQUIT=1
 . W !!,"The setup that was to be done with prior patch MPIF*1.0*56"
 . W !,"was NOT completed.  Review the install guide from that patch"
 . W !,"to make sure everything is done prior to installing this patch."
 ;
 Q
