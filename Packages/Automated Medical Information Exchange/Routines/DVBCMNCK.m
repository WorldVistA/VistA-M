DVBCMNCK ;ALB/GTS-557/THM-MENTAL DISORDERS EXAM ; 2/11/91  10:44 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9="Full Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0905 Worksheet" S HD7="MENTAL DISORDERS",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 S LX="TXT" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W ?13,$P(LY,";;",2),!
 D HD2 W "A. Medical and occupational history " S LX="TXT1" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),! I $Y>50 D HD2
 W !!!!!!!!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!!!!!!!!,"C. Objective findings:" D HD2
 W "D. Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 S LX="TXT2" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),!
 W !!!!!!!!!,"E. Diagnostic tests (including psychological testing if deemed necessary):",!!!!!!!!!!!!!!,"F.  Diagnosis:",!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7," for ",!,NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
 ;
TXT ;
 ;;The severity of disability is based upon actual symptomatology,
 ;;as it affects social and industrial adaptability.  Two of the
 ;;most important determinants of disability are time lost from
 ;;gainful work and decrease in efficiency.  The rating board must
 ;;not underevaluate the emotionally sick veteran with a good work
 ;;record, nor must it overevaluate his or her condition on the
 ;;basis of a poor work record not supported by the psychiatric
 ;;disability picture.  It is for this reason that great emphasis
 ;;is placed upon the full report of the examiner, descriptive of
 ;;actual symptomatology.  The record of the history and complaints
 ;;is only preliminary to the examination.  The objective findings
 ;;and the examiner's analysis of the symptomatology are the
 ;;essentials.  The examiner's classification of the disease
 ;;as "mild", "moderate", or "severe" is not determinative of the
 ;;degree of disability, but the report and the analysis of the
 ;;symptomatology and full consideration of the history by the
 ;;rating agency will be.  In evaluating disability from psychotic
 ;;disorders it is necessary to consider, in addition to present
 ;;symptomatology or its absence, the frequency, severity and
 ;;duration of previous psychotic periods, and the veteran's
 ;;capacity for adjustment during periods of remission.  Repeated
 ;;psychotic periods, without long remissions, may be expected
 ;;to have a sustained effect upon employability until elapsed
 ;;time in good remission and with good capacity for adjustment
 ;;establishes the contrary.  Ratings are to be assigned which
 ;;represent the impairment of social and industrial adaptability
 ;;based on all evidence of record.
 ;;END
 ;
TXT1 ;
 ;;(since the historical data covering the
 ;;veteran's life up to the time of the last examination are generally in the
 ;;claim file, only the time between such last rating examination and the present
 ;;need be accounted for, unless the purpose of this examination is to ESTABLISH
 ;;service connection):
 ;;END
 ;
TXT2 ;
 ;;   1.  State whether the veteran is capable of managing his/her
 ;;       benefit payments in the individual's own best interests (a
 ;;       physical disability which prevents the veteran from attending
 ;;       to financial matters in person is not a proper basis for a
 ;;       finding of incompetency unless the veteran is, by reason of that
 ;;       disability, incapable of directing someone else in handling
 ;;       the individual's financial affairs) -
 ;;END
