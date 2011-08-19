EAS1043A ;ALB/RMM - PRE-INSTALL ROUTINE FOR EAS*1.0*43 ; 11/07/2003
 ;;2.0;INCOME VERIFICATION MATCH;**43**;JUL 8,1996
 ;
EN ; Entry point for the EAS*1.0*43 Pre-Install
 ;
 ; This routine will update the EAS MT LETTER (#713.3) File
 ; INITIAL SECTION OF LETTER, WORD-PROCESSING #713.33 (NOWRAP) field,
 ; for the 0-DAY LETTER, the 30-DAY LETTER, and the 60-DAY LETTER.
 ;
ZERO ; Update the 0-DAY LETTER
 ;
 N EASIEN,DGMSG
 S EASIEN=$O(^EAS(713.3,"B","0-DAY LETTER",""))
 S DGMSG(1)="Updating '0-DAY LETTER' in the EAS MT LETTER File (#713.3)"
 S DGMSG(2)="IEN = "_EASIEN
 D MES^XPDUTL(.DGMSG)
 ;
 ; Set up description array.
 N DGNEW,DGERR,DGOUT
 S DGNEW("WP",1)="According to our records you have not responded to our previous requests"
 S DGNEW("WP",2)="to complete the financial section of VA Form 10-10EZ, Application for"
 S DGNEW("WP",3)="Health Benefits.  This is to inform you that your current financial"
 S DGNEW("WP",4)="assessment (means test) has expired."
 S DGNEW("WP",5)=" "
 S DGNEW("WP",6)="How Does This Affect Your Eligibility for Cost Free Care?"
 S DGNEW("WP",7)="  o We do not have a current means test for you on file as is required to"
 S DGNEW("WP",8)="    determine your eligibility for either cost-free care or reduced"
 S DGNEW("WP",9)="    inpatient copayments."
 S DGNEW("WP",10)=" "
 S DGNEW("WP",11)="How Does This Affect Your Enrollment?"
 S DGNEW("WP",12)="  o We are unable to determine your priority for enrollment in the VA"
 S DGNEW("WP",13)="    health care system."
 S DGNEW("WP",14)=" "
 S DGNEW("WP",15)="What Do You Need To Do?"
 S DGNEW("WP",16)="  o Complete, sign and return a new VA Form 10-10EZ, including the"
 S DGNEW("WP",17)="    financial section."
 S DGNEW("WP",18)="  o Read the enclosed VA Form 4107VHA, Your Rights to Appeal our Decision."
 S DGNEW("WP",19)="    If you disagree with our decision, you or your representative may"
 S DGNEW("WP",20)="    complete a Notice of Disagreement and return it to the Enrollment"
 S DGNEW("WP",21)="    Coordinator or Health Benefits Advisor at your local VA health care"
 S DGNEW("WP",22)="    facility."
 S DGNEW("WP",23)=" "
 S DGNEW("WP",24)="What If You Have Questions?"
 ;
 ; Update the Word Processing Field
 D WP^DIE(713.3,EASIEN_",",3,"K","DGNEW(""WP"")","DGERR")
 ;
 ; Check for and Report any Errors
 I $D(DGERR) D
 . D BMES^XPDUTL("NOTE: An error occurred when updating the 0-DAY LETTER")
 . D MSG^DIALOG("AS",.DGOUT,"","","DGERR")
 . D MES^XPDUTL(.DGOUT)
 . D BMES^XPDUTL("Please contact the VistA Help Desk.")
 ;
 ; Cleanup after each Letter is updated
 K DGNEW,DGERR,DGOUT,EASIEN,DGMSG
 ;
THIRTY ; Update the 30-DAY LETTER
 ;
 N EASIEN,DGMSG
 S EASIEN=$O(^EAS(713.3,"B","30-DAY LETTER",""))
 S DGMSG(1)="Updating '30-DAY LETTER' in the EAS MT LETTER File (#713.3)"
 S DGMSG(2)="IEN = "_EASIEN
 D MES^XPDUTL(.DGMSG)
 ;
 ; Set up description array.
 N DGNEW,DGERR,DGOUT
 S DGNEW("WP",1)="Each year VA requires most nonservice-connected veterans and 0% service-"
 S DGNEW("WP",2)="connected veterans to complete a financial assessment (means test).  Our"
 S DGNEW("WP",3)="records show that your annual means test is due."
 S DGNEW("WP",4)=" "
 S DGNEW("WP",5)="As of this date we have not received the updated financial income"
 S DGNEW("WP",6)="information we requested in a previous letter."
 S DGNEW("WP",7)=" "
 S DGNEW("WP",8)="What Does This Mean To You?"
 S DGNEW("WP",9)="  o An updated means test is needed to determine your ability to pay"
 S DGNEW("WP",10)="    copayments for your medical care and medications and your priority for"
 S DGNEW("WP",11)="    enrollment in the VA health care system."
 S DGNEW("WP",12)="  o Failure to complete the means test by the anniversary date will cause"
 S DGNEW("WP",13)="    your priority for enrollment in the VA health care system to lapse."
 S DGNEW("WP",14)=" "
 S DGNEW("WP",15)="What Do You Need To Do?"
 S DGNEW("WP",16)="  o Complete and sign the enclosed Financial Assessment portion of the"
 S DGNEW("WP",17)="    enclosed VA Form 10-10EZ, Application for Health Benefits, reporting"
 S DGNEW("WP",18)="    income and assets for the previous calendar year."
 S DGNEW("WP",19)="  o Return the completed and signed form in the enclosed envelope before"
 S DGNEW("WP",20)="    your means test anniversary date."
 S DGNEW("WP",21)="  o When you report to your next health care appointment, bring your health"
 S DGNEW("WP",22)="    insurance card so we may update your health insurance information. "
 S DGNEW("WP",23)="  o Notify us if you feel you received this letter in error."
 S DGNEW("WP",24)=" "
 S DGNEW("WP",25)="What If You Have Questions?"
 ;
 ; Update the Word Processing Field
 D WP^DIE(713.3,EASIEN_",",3,"K","DGNEW(""WP"")","DGERR")
 ;
 ; Check for and Report any Errors
 I $D(DGERR) D
 . D BMES^XPDUTL("NOTE: An error occurred when updating the 30-DAY LETTER")
 . D MSG^DIALOG("AS",.DGOUT,"","","DGERR")
 . D MES^XPDUTL(.DGOUT)
 . D BMES^XPDUTL("Please contact the VistA Help Desk.")
 ;
 ; Cleanup after each Letter is updated
 K DGNEW,DGERR,DGOUT,EASIEN,DGMSG
 ;
SIXTY ; Update the 60-DAY LETTER
 ;
 N EASIEN,DGMSG
 S EASIEN=$O(^EAS(713.3,"B","60-DAY LETTER",""))
 S DGMSG(1)="Updating '60-DAY LETTER' in the EAS MT LETTER File (#713.3)"
 S DGMSG(2)="IEN = "_EASIEN
 D MES^XPDUTL(.DGMSG)
 ;
 ; Set up description array.
 N DGNEW,DGERR,DGOUT
 S DGNEW("WP",1)="Each year VA requires most nonservice-connected veterans and 0% service-"
 S DGNEW("WP",2)="connected veterans to complete a financial assessment (means test).  Our"
 S DGNEW("WP",3)="records show that your annual means test is due."
 S DGNEW("WP",4)=" "
 S DGNEW("WP",5)="What Does This Mean To You?"
 S DGNEW("WP",6)="  o An updated means test is needed to determine your ability to pay"
 S DGNEW("WP",7)="    copayments for your medical care and medications and your priority for"
 S DGNEW("WP",8)="    enrollment in the VA health care system."
 S DGNEW("WP",9)="  o Failure to complete the means test by the anniversary date will cause"
 S DGNEW("WP",10)="    your priority for enrollment in the VA health care system to lapse."
 S DGNEW("WP",11)=" "
 S DGNEW("WP",12)="What Do You Need To Do?"
 S DGNEW("WP",13)="  o Complete and sign the Financial Assessment portion of the enclosed VA"
 S DGNEW("WP",14)="    Form 10-10EZ, Application for Health Benefits, reporting income and"
 S DGNEW("WP",15)="    assets for the previous calendar year."
 S DGNEW("WP",16)="  o Return the completed and signed form in the enclosed envelope before"
 S DGNEW("WP",17)="    your means test anniversary date."
 S DGNEW("WP",18)="  o When you report to your next health care appointment, bring your health"
 S DGNEW("WP",19)="    insurance card so we may update your health insurance information."
 S DGNEW("WP",20)="  o Notify us if you feel you received this letter in error. "
 S DGNEW("WP",21)=" "
 S DGNEW("WP",22)="What If You Have Questions?"
 ;
 ; Update the Word Processing Field
 D WP^DIE(713.3,EASIEN_",",3,"K","DGNEW(""WP"")","DGERR")
 ;
 ; Check for and Report any Errors
 I $D(DGERR) D
 . D BMES^XPDUTL("NOTE: An error occurred when updating the 60-DAY LETTER")
 . D MSG^DIALOG("AS",.DGOUT,"","","DGERR")
 . D MES^XPDUTL(.DGOUT)
 . D BMES^XPDUTL("Please contact the VistA Help Desk.")
 ;
 ; Cleanup after each Letter is updated
 K DGNEW,DGERR,DGOUT,EASIEN,DGMSG
 ;
 D BMES^XPDUTL("Pre-Installation Complete, the EAS MT Letters have been updated.")
 ;
 Q
