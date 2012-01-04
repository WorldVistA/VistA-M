DVBCQDRV ;;ALB-CIOFO/SBW - Generic Driver for DBQ ; 11/AUG/2011
 ;;2.7;AMIE;**175**;Apr 10, 1995;Build 6
EN ;
 N DVBAX,TT,PG
 D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 ;
 ; TNAM is defined in routine DVBCADE1 which is used in the processing of
 ; the following options:
 ;     DVBA C PRINT WORKSHEETS
 ;     DVBA C ADD ADDITIONAL EXAM  
 ; CPNO is defined in routine DVBACPPB which is used by the 
 ;     DVBA C PRINT BLANK C&P WORKSHE option 
 I $G(TNAM)']"",+$G(CPNO)>0 S TNAM=$P($G(^DVB(396.6,+CPNO,0)),U,1)
 I $G(TNAM)']"" W !,"*** Error, DBQ Name Not Defined. ***",!! Q
 S DVBAX=TNAM,TT=40-($L(DVBAX)\2),PG=1
 W !,?TT,DVBAX
 W !?40-($L("Disability Benefits Questionnaire")\2),"Disability Benefits Questionnaire",!!
 W !?1,"Name of patient/Veteran: ",$S($G(NAME)]"":NAME,1:"_______________________")
 W ?45,"   SSN: ",$S($G(SSN)]"":SSN,1:"________________"),!!
 W !?3,"For a printed copy of the Disability Benefit Questionnaire (DBQ) form,"
 W !?3,"please visit the DBQ Switchboard, http://go.va.gov/DBQ.  This page"
 W !?3,"serves as a switchboard for DBQ-related information.  For comments,"
 W !?3,"questions, or suggestions regarding DBQ policy, content, or use,"
 W !?3,"please contact the Disability Examination Management Office (DEMO)"
 W !?3,"Corporate Mailbox by sending an email to:"
 W !?8,"CorporateMailbox.DEMO@va.gov.",!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
