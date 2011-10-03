DVBCGMCK ;ALB/GTS-557/THM-GENERAL MEDICAL EXAM ; 5/16/91  2:20 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 K LINE S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
 S $P(LINE,"-",75)="-"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0505 Worksheet" S HD7="GENERAL MEDICAL",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________"
 W !!,"Type of Exam: ",HD7,!!!!,"Narrative:",!!
 S TXT="TXT10" D PTXT W !!!,"A. Occupational history (List most current first):",!
 W LINE,!,"Name/Address of employer     Type      Monthly     Emp dates      Time lost",!,"(if unemployed, enter none)",?29,"Work      Wages       from/to        Last 12 mo",!!!
 W "1. ",$E(LINE,2,75),!!,"2. ",$E(LINE,2,75),!!,"3. ",$E(LINE,2,75),!!!,"State if time from employment was lost and give reasons.",!!!?3,$E(LINE,2,75),!!!,"B. Medical history (since last rating exam):",!
 D HD2 W "C. Present complaints (symptoms only, NOT diagnosis):",!!!!!!!!!!!!,"D. Examination data:",!!!!,"Height:",?25,"Weight:",?45,"Max wgt past year:",!!!
 W "Build and state of nutrition:",!!!,"Temperature:",?23,"Time:",?35,"AM/PM",?50,"Carriage:",!!!,"Posture:",?23,"Gait:",?45,"Right- or left-handed:",!?45,"(How determined)",!!!!!!
 W "E. Skin, including appendages " S TXT="TXT2" D PTXT,HD2 W "F. Lymphatic and hemic systems " S TXT="TXT3" D PTXT W !!!!!!!!!!,"G. Head, face and neck:",!!!!!!!!!!
 W "H. Nose, sinuses, mouth and throat (include gross dental findings):"
 W !! D HD2 W "I. Ears (describe canals, drums, perforations, discharge):",!!!!!!!!,"J. Eyes (describe external eye, pupil reaction, movements,",!
 W ?3,"field of vision, any uncorrectable refractive error or",!?3,"any retinopathy):",!!!!!!!!,"K. Cardiovascular system "
 W "(describe thrust, size, rhythm, sounds and condition",!,"   of peripheral vessels):",!!!!!!!!!!!!!!!?25,"Pulse",?39,"Blood pressure",?60,"Respiration",!,LINE,! S LNH="|            |                     |"
 W "Sitting",?21,LNH,!,LINE,!,"Recumbent",?21,LNH,!,LINE,!,"Standing",?21,LNH,!,LINE,!,"Sitting after exerc. ",LNH,!,LINE,!,"2 min after exercise ",LNH,!,LINE,! D HD2
 W "L. Varicose veins (describe location, size, extent, ulcers, scars, and",!,"   competency of deep circulation):",!
 W !!!!!!,"M. Respiratory system " S TXT="TXT9" D PTXT W !!!!!!!!!,"N. Digestive system " S TXT="TXT4" D PTXT W !!!!!!!!,"O. Hernia" S TXT="TXT5" D PTXT,HD2 W "P. Genito-urinary system " S TXT="TXT6" D PTXT W !
 W !!!!!!!!!,"Q. Musculo-skeletal system",!! S TXT="TXT7" D PTXT,HD2 W "R. Endocrine system (describe disease of thyroid, pituitary, adrenals",!?3,"gonads, other body systems affected, etc.):",!!!!!!!!
 W "S. Nervous system",!! S TXT="TXT8" D PTXT W !!!!!!!!!!,"T. Remarks:",!!!!!!!!!! D HD2 W "U. Other tests/exams recommended:",!!!!!!!!!!,"V. Diagnostic/clinical test results:",!!!!!!!!!
 W "W. Diagnosis:",!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 W !!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 W !!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 W !!!?16,"Reviewing Official: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2,LINE
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam "_HD8_" for ",!,NAME,!!!
 Q
 ;
PTXT D PTXT^DVBCGMC1
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
