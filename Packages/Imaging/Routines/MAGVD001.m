MAGVD001 ;WOIFO/BT,NST,DAC,PMK - Delete Study By Accession Number ; Feb 15, 2022@10:23:58
 ;;3.0;IMAGING;**118,138,231,305**;Mar 19, 2002;Build 3
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
DELSTUDY ; Delete Study by Accession Number (option MAG SYS-DELETE STUDY)
 N ACCNUM,SENSEMP,ERR,MAGDFN,REASON
 N OUT,MAGARR,SSEP,RES,Y,DG1,DGOPT,DIC
 S SSEP=$$STATSEP^MAGVRS41
 ;
 F  S ACCNUM=$$GETACC^MAGVD001() Q:ACCNUM=""  D
 . D GIBYACC^MAGVD007(.OUT,ACCNUM,.MAGARR)  ; Get Images to be deleted
 . I OUT<0 D EN^DDIOL($P(OUT,SSEP,2),"","!!") Q 
 . I '$D(MAGARR) D EN^DDIOL("No image found for this accession number","","!!") Q 
 . S MAGDFN=MAGARR(1,"MAGDFN")  ; get the patient
 . S SENSEMP=$$ISPATSEN^MAGVD001(MAGDFN) ;is sensitive patient?
 . I SENSEMP,'$$CONFSENS^MAGVD001() D EN^DDIOL("Deletion Canceled. Study was not deleted.","","!!") Q
 . S Y=MAGDFN,DG1="",DGOPT="MAG SYS-DELETE STUDY",DIC(0)=""
 . D:SENSEMP SETLOG^DGSEC ; IA #2242 - Log sensitive patient access
 . D SHOWINFO^MAGVD004(ACCNUM,.MAGARR)
 . S REASON=$$GETRSN^MAGVD001()
 . I REASON="" D EN^DDIOL("Deletion Canceled. Study was not deleted.","","!!") Q
 . I '$$CONFIRM^MAGVD001(ACCNUM) D EN^DDIOL("Deletion Canceled. Study was not deleted.","","!!") Q
 . D DELACC^MAGVD002(.OUT,.MAGARR,REASON)  ; delete images provided
 . S RES=$P(OUT,SSEP)
 . S ERR=$P(OUT,SSEP,2)
 . I RES=0 D EN^DDIOL("Deletion successfully completed!","","!!") Q
 . D EN^DDIOL(ERR,"","!!")
 . Q
 Q
 ;
GETACC() ; Get Accession Number
 N DIR,X,Y
 S DIR(0)="FO^^K:'$$ISMSKOK^MAGVD001(X) X"
 S DIR("A")="Enter an Accession Number"
 S DIR("A",1)=""
 S DIR("??")="^D GETACCHELP^MAGVD001"
 S DIR("?",1)="Enter Accession Number, e.g. 660-GMR-123, 111231-345, 660-111231-345," ; P231 PMK 4/4/2020
 S DIR("?",2)="GMRC-123, SP 21 12345 or ""^"" to exit."  ; P305 PMK 01/04/2022
 S DIR("?")=" "
 D ^DIR
 S:Y="^" Y=""
 Q Y
 ;
GETACCHELP ; double quote help message
 W !,"By Entering Accession Number, all Studies with this Accession Number"
 W !,"will be deleted."
 Q
 ;
ISMSKOK(Y) ; Verify accession number format - 0 invalid; 1 - valid
 N OK
 S OK=0
 S Y=$$UP^MAGDFCNV(Y)
 D  ; needed for QUITs
 . I $L(Y,"-")=3 I Y?3N.N1"-"6N1"-"1.N S OK=1 Q  ; radiology SSS-MMDDYY-NNNNN format
 . I $L(Y,"-")=2 I Y?6N1"-"1.N S OK=1 Q  ; radiology MMDDYY-NNNNN format
 . I $$GMRCIEN^MAGDFCNV(Y) S OK=1 Q  ; consult format
 . I $L(Y," ")=3 I Y?.E1" "2N1" "1N.N S OK=1 Q  ; anatomic pathology format - P305 PMK 01/03/2022
 . Q
 Q OK
 ;
ISPATSEN(MAGDFN) ; Return 1 if patient for the study is a sensitive, 0 otherwise
 N SENSEMP
 S SENSEMP=$$SENSEMP^MAGUPSE(MAGDFN)
 Q (SENSEMP>0)
 ;
CONFSENS() ; Continue processing confirmation for sensitive patient
 N DIR,X,Y
 S DIR(0)="FO",DIR("A")="Sensitive Patient. Enter 'OK' to continue"
 S DIR("?")="Enter 'OK' to continue or '^' to skip"
 D ^DIR
 Q ($$UC^MAGVD001(Y)="OK")
 ;
GETRSN() ; Select reason for deletion
 N DIC,DTOUT,DUOUT,TODAY,X,Y
 S TODAY=+$$NOW^XLFDT
 W !
 S DIC="^MAG(2005.88,",DIC(0)="AEQVZN",DIC("S")="I ($P(^(0),U,2)[""D""&(($P(^(0),U,3)="""")!(TODAY<($P(^(0),U,3)))))",DIC("W")=""
 S DIC("A")="Select a reason for deletion: "
 D ^DIC
 I $D(DTOUT)!$D(DUOUT) Q ""
 I (Y="")!(Y="^") Q ""
 Q $P(Y,U,2) ; Return reason for deletion
CONFIRM(ACCNUM) ; Confirmation - last chance to cancel
 N DIR,X,Y
 S DIR(0)="Y",DIR("A")="ARE YOU SURE YOU WANT TO DELETE STUDIES FOR ACCESSION #: "_ACCNUM
 S DIR("B")="NO"
 D ^DIR
 Q Y
 ;
UC(STR) ;Convert to upper case
 N X,Y
 S X=STR X ^%ZOSF("UPPERCASE")
 Q Y
 ;
