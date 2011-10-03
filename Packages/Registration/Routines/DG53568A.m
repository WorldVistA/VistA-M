DG53568A ;ALB/RMM - POST-INSTALL ROUTINE FOR SD ENCAP ; 03/24/2004
 ;;5.3;Registration;**568**;AUG 13, 1993
 ;
EN ; Entry point for the DG*5.3*568 Post-Install
 ;
 ; This routine will update the WORD-PROCESSING #3.5 field, in the 
 ; OPTION (#19) File for the following options (if present):
 ;  [ZDGYP SD GLOBAL ESTIMATOR] Global Estimator for Scheduling
 ;  [DGYP SD GLOBAL ESTIMATOR]  Global Estimator for Scheduling
 ;
 ; Get IENs from OPTION File
 N DGYP,ZDGYP,DGMSG,MCNT,DGNEW,DGERR,DGOUT
 S DGYP=+$O(^DIC(19,"B","DGYP SD GLOBAL ESTIMATOR",""))
 S ZDGYP=+$O(^DIC(19,"B","ZDGYP SD GLOBAL ESTIMATOR",""))
 ;
 S MCNT=1,DGMSG(MCNT)="Updating the description for option: Global Estimator for Scheduling"
 S:DGYP>0 MCNT=MCNT+1,DGMSG(MCNT)="IEN = "_DGYP
 S:ZDGYP>0 MCNT=MCNT+1,DGMSG(MCNT)="IEN = "_ZDGYP
 D MES^XPDUTL(.DGMSG)
 ;
 D NEWTXT
 D:DGYP>0 TXTUPDT(DGYP)
 D:ZDGYP>0 TXTUPDT(ZDGYP)
 ;
 D BMES^XPDUTL("Post-Install Complete, the option text has been updated.")
 Q
NEWTXT ;
 ; Set up description array.
 S DGNEW("WP",1)="In previous versions of PIMS, a patient's outpatient information has"
 S DGNEW("WP",2)="been stored in various files in the VistA database. With the"
 S DGNEW("WP",3)="requirement to checkout all outpatient encounters, it was necessary"
 S DGNEW("WP",4)="to consolidate much of the common outpatient information into one"
 S DGNEW("WP",5)="outpatient encounter file."
 S DGNEW("WP",6)=" "
 S DGNEW("WP",7)="In PIMS v5.3, the data will reside in the new OUTPATIENT"
 S DGNEW("WP",8)="ENCOUNTER(#409.68) file as well as in the old data structures."
 S DGNEW("WP",9)="This file will hold encounter data for all checked out encounters."
 S DGNEW("WP",10)="This will include information from the following:"
 S DGNEW("WP",11)=" "
 S DGNEW("WP",12)="         o appointments:  SDAPI - Appointment API"
 S DGNEW("WP",13)="         o add/edits   :  ^SDV()"
 S DGNEW("WP",14)="         o dispositions:  ^DPT(patient,""DIS"",date/time)"
 S DGNEW("WP",15)=" "
 S DGNEW("WP",16)="The MUMPS global for this file is ^SCE."
 S DGNEW("WP",17)=" "
 S DGNEW("WP",18)=" "
 S DGNEW("WP",19)="Also, as part of the checkout process, questions regarding"
 S DGNEW("WP",20)="whether the encounter was related to a service-connected disability,"
 S DGNEW("WP",21)="Agent Orange, ionization and environmental contaminants from the"
 S DGNEW("WP",22)="Persian Gulf war, will be asked when appropriate."
 S DGNEW("WP",23)=" "
 S DGNEW("WP",24)="This data will be stored in the new OUTPATIENT CLASSIFICATION"
 S DGNEW("WP",25)="(#409.42) file in the ^SDD(409.42) global node."
 S DGNEW("WP",26)=" "
 S DGNEW("WP",27)=" "
 S DGNEW("WP",28)="The purpose of this utility is the following:"
 S DGNEW("WP",29)="             1. estimate a one year rate of growth for"
 S DGNEW("WP",30)="                ^SCE using as a base the encounter data"
 S DGNEW("WP",31)="                for the previous 365 days"
 S DGNEW("WP",32)=" "
 S DGNEW("WP",33)="             2. estimate a one year rate of growth for"
 S DGNEW("WP",34)="                ^SDD(409.42) using as a base the encounter data"
 S DGNEW("WP",35)="                for the previous 365 and the patient demographic"
 S DGNEW("WP",36)="                information"
 S DGNEW("WP",37)=" "
 S DGNEW("WP",38)="Using these estimates, you can make a better determination"
 S DGNEW("WP",39)="as to where to place this new ^SCE global and how large the"
 S DGNEW("WP",40)="existing ^SDD global will grow."
 S DGNEW("WP",41)=" "
 S DGNEW("WP",42)="This utility will not affect the current v5.2 functionality in any"
 S DGNEW("WP",43)="way. However, it is recommended that it be queued to run at non-peak"
 S DGNEW("WP",44)="hours.  After the estimations are calculated, the results will be"
 S DGNEW("WP",45)="reported to the user via a MailMan message."
 S DGNEW("WP",46)=" "
 S DGNEW("WP",47)="Finally, in v5.3, the site will have the ability to capture provider"
 S DGNEW("WP",48)="and diagnostic data as part of the checkout process. Capturing this"
 S DGNEW("WP",49)="data will be site selectable. It is estimated that each provider and"
 S DGNEW("WP",50)="each diagnosis captured for an encounter will use .05 1K blocks."
 S DGNEW("WP",51)=" "
 S DGNEW("WP",52)="NOTE: If the site does choose to capture provider data then nurses,"
 S DGNEW("WP",53)="social workers and other providers of care will need to have entries"
 S DGNEW("WP",54)="in the NEW PERSON file and be assigned the PROVIDER security key."
 S DGNEW("WP",55)="Assigning this key will allow selection of these providers during the"
 S DGNEW("WP",56)="checkout process."
 S DGNEW("WP",57)=" "
 S DGNEW("WP",58)=" "
 S DGNEW("WP",59)="The option should be executed by the IRM staff and is locked with the"
 S DGNEW("WP",60)="DGYP IRM security key."
 Q
TXTUPDT(OPTIEN) ;
 ; Update the Word Processing Field
 D WP^DIE(19,OPTIEN_",",3.5,"K","DGNEW(""WP"")","DGERR")
 ;
 ; Check for and Report any Errors
 I $D(DGERR) D
 . D BMES^XPDUTL("NOTE: An error occurred when updating the OPTION text.")
 . D MSG^DIALOG("AS",.DGOUT,"","","DGERR")
 . D MES^XPDUTL(.DGOUT)
 . D BMES^XPDUTL("Please contact the VistA Help Desk.")
 ;
 ; Cleanup after each OPTION is updated
 K DGNEW,DGERR,DGOUT,EASIEN,DGMSG
 ;
 Q
