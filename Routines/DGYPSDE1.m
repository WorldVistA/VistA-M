DGYPSDE1 ;ALB/MJK/LSM - DGYP Global Estimator ; 03/19/2004
 ;;5.3;REGISTRATION;**568**;Aug 13, 1993
 ;
INTRO ; -- display text
 W @IOF
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="END"  W X,! I $Y>20 S DIR(0)="E" D ^DIR K DIR Q:'Y  W @IOF
 Q
 ;
MAIL ; -- put in mm
 W !
 S DIR(0)="Y",DIR("A")="Place above text in a Mailman Message",DIR("B")="No"
 D ^DIR K DIR G MAILQ:'Y
 K ^UTILITY("DGYPEST",$J)
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="END"  S ^UTILITY("DGYPEST",$J,I,0)=X
 S XMSUB="SCE Global Estimator",XMDUZ=.5,XMY(DUZ)="",XMTEXT="^UTILITY(""DGYPEST"",$J,"
 D ^XMD W !,"...mailed"
MAILQ K XMY,XMDUZ,XMTEXT,XMSUB,^UTILITY("DGYPEST",$J)
 Q
 ;
TEXT ;
 ;;               *** ^SCE & ^SDD(409.42) Global Estimators ***
 ;;
 ;;Purpose:
 ;;--------
 ;;In previous versions of PIMS, a patient's outpatient information has
 ;;been stored in various files in the VistA database. With the
 ;;requirement to check out all outpatient encounters, it was necessary
 ;;to consolidate much of the common outpatient information into one
 ;;outpatient encounter file.
 ;;
 ;;In PIMS v5.3, the data will reside in the new OUTPATIENT
 ;;ENCOUNTER(#409.68) file as well as in the old data structures.
 ;;This file will hold encounter data for all checked out encounters.
 ;;This will include information from the following:
 ;;         o appointments: SDAPI - Scheduling API
 ;;         o add/edits:    ^SDV
 ;;         o dispositions: ^DPT(patient,"DIS",date/time)
 ;;
 ;;The MUMPS global for this file is ^SCE.
 ;;
 ;;
 ;;Also, as part of the check out process, questions regarding
 ;;whether the encounter was related to a service connected disability,
 ;;agent orange, ionization or environmental contaminants from the
 ;;Persian Gulf war, will be asked when appropriate.
 ;;
 ;;This data will be stored in the new OUTPATIENT CLASSIFICATION(#409.42)
 ;;file in the ^SDD(409.42) global.
 ;;
 ;;
 ;;The purpose of this utility is the following:
 ;;             1. estimate a one year rate of growth for
 ;;                ^SCE using as a base the encounter data
 ;;                for the previous 365 days
 ;;
 ;;             2. estimate a one year rate of growth for
 ;;                ^SDD(409.42) using as a base the encounter data
 ;;                for the previous 365 and the patient demographic
 ;;                information
 ;;
 ;;Using these estimates, you can make a better determination
 ;;as to where to place this new ^SCE global and how large the
 ;;existing ^SDD global will grow.
 ;;
 ;;
 ;;
 ;;Algorithms:
 ;;-----------
 ;;1. Outpatient Encounters - ^SCE:
 ;;
 ;;This utility will scan your site's encounter database for
 ;;the previous 365 days. It will count the number of appointments,
 ;;add/edits and dispositions.
 ;;
 ;;Appointments that were cancelled or no-showed are not included
 ;;in the calculations. Dispositions with a status of 'APPLICATION
 ;;WITHOUT EXAM' are also not included.
 ;;
 ;;After obtaining these counts, they will be applied against
 ;;the estimated block size needed for each type of encounter.
 ;;Each type of encounter is estimated to use .16 1K blocks.
 ;;
 ;;
 ;;2. Outpatient Classifications - ^SDD(409.42):
 ;;The classifications estimate looks at the patient's demographic
 ;;data as it scans the outpatient encounter database in #1 above.
 ;;If the demographic data indicates a classification question
 ;;would have been required for the encounter then a counter for the
 ;;specific classification is incremented.
 ;;
 ;;For example, if the patient is a service connected veteran, the
 ;;SC counter will be incremented.
 ;;
 ;;After obtaining these counts, they will be applied against
 ;;the estimated block size needed for each type of classification.
 ;;Each type of classification is estimated to use .08 1K blocks.
 ;;
 ;;NOTE: Encounters with stop codes 104 thru 170 do not, at this time,
 ;;      require any classification questions to be asked. As a result,
 ;;      they are not included in the classification counts.
 ;;
 ;;
 ;;3. The estimation algorithm takes into account the following factors:
 ;;         o pointer blocks needed
 ;;         o blocks needed for actual data
 ;;         o blocks needed for cross references
 ;;
 ;;   Also, the algorithm is based on a global efficiency of 74%.
 ;;
 ;;
 ;;
 ;;Results Reporting:
 ;;------------------
 ;;After the estimations are calculated, the results will be
 ;;reported to the user via a MailMan message.
 ;;END
