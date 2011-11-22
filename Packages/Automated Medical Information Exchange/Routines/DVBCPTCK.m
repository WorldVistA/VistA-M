DVBCPTCK ;ALB/GTS-557/THM-POST-TRAUMATIC STRESS DISORDER ; 4/29/91  12:09 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9="Full Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0910 Worksheet" S HD7="POST-TRAUMATIC STRESS DISORDER",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:  "
 S LX="TXT2" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),!
 W !!,"A. Medical and occupational history:",!!
 W ?8,"1. Immediate pre-military events and details of training -",!!!!!!!!!?8,"2. Events in the war zone -",!!!!!!!!!?8,"3. Post-active service events (to present) -",!!!!!!!!!
 W ?8,"4. Employment history prior to and following",!?11,"active service -" D HD2
 W "B. Subjective complaints (include the veteran's history of unusually ",!?27,"traumatic stressors)",!!!!!!!!!!!!!!!!!! W "C. Objective findings:",! D HD2
 ;W !!,"1) Describe the duration of the disturbance from the symptoms shown above.",!! D HD2
 W "D. Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 S LX="TXT1" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),!
 W !!!!!!!!!!!!,"E. Diagnostic tests (including psychological testing if deemed necessary):",!!!!!!!!!!,"F. Diagnosis:",!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 D EN^DVBCPTS1 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
 ;
TXT1 ;
 ;;   1.  State if the veteran is capable of managing his/her benefit
 ;;       payments in the individual's own best interests without restriction
 ;;       (a physical disability which prevents the veteran from attending
 ;;       to financial matters in person is not a proper basis for a finding
 ;;       of incompetency unless the veteran is, by reason of that disability,
 ;;       incapable of directing someone else in handling the individual's
 ;;       his financial affairs) -
 ;;END
 ;
TXT2 ;
 ;;No diagnosis of PTSD can be adequately documented or ruled
 ;;            out without obtaining a detailed military history.  This
 ;;            requirement means that interviewing of cases of PTSD will
 ;;            often require more time than for other disorders.  The
 ;;            history should be obtained for the three categories under
 ;;            the medical history.  Subjective complaints and objective
 ;;            findings should be related to the diagnosis criteria.  PTSD
 ;;            must be due to military service.
 ;;END
