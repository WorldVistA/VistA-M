EAS132PT ;ALB/SCK - POST INSTALL ROUTINE PATCH EAS*1*32 ;29-APR-2003
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**32**;MAR 15,2001
 ;
EN ; Main entry point for the Post Installation routine
 N EASIEN,EASTYP,MSG
 ;
 ; EAS Letter types (TYPE Field, #2, EAS MT LETTERS File, #713.3)
 ; Set of Codes: 1 -  60-Day Letter
 ;               2 -  30-Day Letter 
 ;               4 -   0-Day Letter
 ;
 ;
 D BMES^XPDUTL("Beginning the Post-Install update of EAS MT Letters File")
 F EASTYP=1,2,4 D
 . S EASIEN=0
 . F  S EASIEN=$O(^EAS(713.3,"C",EASTYP,EASIEN)) Q:'EASIEN  D
 . . D UPDLTR(EASIEN,EASTYP)
 D BMES^XPDUTL("Update of EAS MT Letters File with revised text complete")
 S MSG(1)="If any errors were reported during the text updates, please contact"
 S MSG(2)="the VistA Help Desk"
 D MES^XPDUTL(.MSG)
 Q
 ;
UPDLTR(EASIEN,EASTYP) ; Update specific letter with new text from text updates below.
 N LTRTYPE,MSG,WPR
 ;
 S LTRTYPE=$S(EASTYP=1:"UPD1",EASTYP=2:"UPD2",EASTYP=4:"UPD4",1:"")
 I LTRTYPE']"" D  Q
 . D BMES^XPDUTL(">>> UNIDENTIFIED LETTER TYPE PASSED IN")
 ;
 S MSG="Updating the "_$S(EASTYP=1:"60",EASTYP=2:"30",1:"0")_"-Day Letter..."
 D BMES^XPDUTL(MSG)
 ;
 N LINE,EAX,EASOUT,EASER
 ;
 F EAX=1:1  D  Q:$G(LINE)="$$END"
 . S LINE=$P($T(@LTRTYPE+EAX),";;",2)
 . Q:LINE="$$END"
 . S WPR("WP",EAX)=LINE
 ;
 D WP^DIE(713.3,EASIEN_",",3,"K","WPR(""WP"")","EASER")
 I $D(EASER) D
 . D BMES^XPDUTL("An error occurred while updating the initial section of the "_LTRTYPE_" letter")
 . D MSG^DIALOG("AS",.EASOUT,"","","EASER")
 . D MES^XPDUTL(.EASOUT)
 E  D
 . D BMES^XPDUTL(LTRTYPE_" Letter text updated.")
 ; 
 K WPR
 Q
 ;
 ; Updated text for the Means Test Letters, per VHA Directive published
 ; by the Chief Buisness Office
 ;
UPD1 ;;60-Day Letter text
 ;;Each year the VA requires nonservice-connected veterans and 0% service-
 ;;connected veterans to complete a financial assessment (means test). Our
 ;;records show that your annual means test is due |ANNVDT|.
 ;;
 ;;What Does This Mean To You?
 ;;  o The means test you completed last year exempted you from copayments
 ;;    for health care provided for your nonservice-connected conditions.
 ;;  o Failure to complete the means test by the anniversary date will
 ;;    cause your priority for enrollment in the VA health care system to 
 ;;    lapse.
 ;;
 ;;What Do You Need To Do?
 ;;  o Complete and sign the Financial Assessment portion of the enclosed VA
 ;;    Form l0-10EZ, Application for Health Benefits, reporting income and
 ;;    assets for the previous calendar year.
 ;;  o Return the completed and signed form in the enclosed envelope before
 ;;    your means test anniversary date.
 ;;  o When you report to your next health care appointment, bring your
 ;;    health insurance card so we may update your health insurance 
 ;;    information.
 ;;  o Notify us if you feel you received this letter in error.
 ;;
 ;;What If You Have Questions?
 ;;$$END
UPD2 ;;30-Day Letter txt
 ;;Each year the VA requires nonservice-connected veterans and 0% service-
 ;;connected veterans to complete a financial assessment (means test). Our
 ;;records show that your annual means test is due |ANNVDT|.
 ;;
 ;;As of this date we have not received the updated financial income
 ;;information we requested in a previous letter.
 ;;
 ;;What Does This Mean To You?
 ;;  o The means test you completed last year exempted you from copayments
 ;;    for health care provided for your nonservice-connected conditions.
 ;;  o Failure to complete the means test by the anniversary date will 
 ;;    cause your priority for enrollment in the VA health care system to 
 ;;    lapse.
 ;;
 ;;What Do You Need To Do?
 ;;  o Complete and sign the enclosed Financial Assessment portion of the
 ;;    enclosed VA Form l0-10EZ, Application for Health Benefits, reporting
 ;;    income and assets for the previous calendar year.
 ;;  o Return the completed and signed form in the enclosed envelope before
 ;;    your means test anniversary date.
 ;;  o When you report to your next health care appointment, bring your
 ;;    health insurance card so we may update your health insurance 
 ;;    information.
 ;;  o Notify us if you feel you received this letter in error.
 ;;
 ;;What If You Have Questions?
 ;;$$END
UPD4 ;;0-Day Letter txt
 ;;According to our records you have not responded to our previous requests
 ;;to complete the financial section of VA Form l0-10EZ, Application for
 ;;Health Benefits. This is to inform you that your current financial 
 ;;assessment (means test) has expired.
 ;;
 ;;How Does This Affect Your Eligibility for Cost Free Care?
 ;;  o We do not have a current means test for you on file as is required to
 ;;    determine your eligibility for cost-free care.
 ;;
 ;;How Does This Affect Your Enrollment?
 ;;  o We are unable to determine your priority for enrollment in the VA
 ;;    health care system.
 ;;
 ;;What Do You Need To Do?
 ;;  o Complete, sign and return a new VA Form l0-10EZ, including the
 ;;    financial section.
 ;;  o Read the enclosed VA Form 4107VHA, Your Rights to Appeal our 
 ;;    Decision. If you disagree with our decision, you or your 
 ;;    representative may complete a Notice of Disagreement and return it
 ;;    to the Enrollment Coordinator or Health Benefits Advisor at your 
 ;;    local VA health care facility.
 ;;
 ;;What If You Have Questions?
 ;;$$END
