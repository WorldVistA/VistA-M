DVBCPWCK ;ALB/GTS-557/THM-PRISONER OF WAR PROTOCOL EXAM  ; 5/6/91  9:38 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9="Full Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1705 Worksheet" S HD7="PRISONER OF WAR PROTOCOL",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:  "
 S LX="TXT" F I=1:1 S LY=$T(@LX+I) Q:LY["$END"  D:LY["|TOP|" HD2 W:LY'["|TOP|" ?13,$P(LY,";;",2),!
 W !,"A. Medical history (include childhood and adult illnesses and",!?3,"operations):",!!!!!!!!!!!!!,"B. Past history (include civilian and military occupation, military)",!
 W ?3,"history including geographic locations and dates, habits",!?3,"such as alcohol, tobacco and drugs, family history):",!!!!!!!! D HD2^DVBCPWCK
 S CNT=0 W "C. System review (comment specifically if positive symptom):",!!?4,"a. General:",!! F I="weight change","fever or chills","night sweats","polydipsia" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! I $Y>55 D HD2
 G ^DVBCPWC1
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
 ;
TXT ;
 ;;The protocol for conducting examinations on former
 ;;POWs should include the following and be faxed in
 ;;in its entirety to the regional office.
 ;;
 ;;1.  The veteran completes VAF 10-0048, Former POW
 ;;Medical History, which the examiners should review.
 ;;
 ;;2.  The examination should include an exam for all
 ;;presumptive POW disabilities, as well as any other
 ;;disabilities claimed by the veteran.  All laboratory
 ;;and diagnostic tests should be completed and reviewed
 ;;prior to completing the summary of findings.
 ;;
 ;;3.  A mental disorders examination should be conducted.
 ;;An appropriate worksheet is attached.
 ;;
 ;;4.  A social survey should be conducted.  An appropriate
 ;;worksheet is also attached.
 ;;
 ;;5.  The POW Physician Coordinator should complete
 ;;summary of findings, diagnoses, and recommendations.
 ;;The POW Physician Coordinator may express his or
 ;;her judgement about the possible epidemiological
 ;;factors and/or etiological origins of any noted
 ;;disabilities.
 ;;
 ;;6.  The following conditions are presumptive POW
 ;;disabilities:
 ;;
 ;;Avitaminosis
 ;;Beriberi (including beriberi heart disease)
 ;;Chronic dysentery
 ;;Helminthiasis
 ;;Malnutrition (including optic atrophy associated with
 ;;              malnutrition)
 ;;Pellagra
 ;;any other nutritional dificiency
 ;;Psychosis
 ;;Any of the anxiety states
 ;;Post-traumatic osteoarthritis
 ;;Organic residuals of frostbite
 ;;Peptic ulcer disease
 ;;Irritable bowel syndrome
 ;;Peripheral neuropathy
 ;;|TOP|
 ;;7.  Because the term "irritable bowel syndrome", as
 ;;applied to former POWs, includes a number of other
 ;;conditions, and because the rating schedule places
 ;;restrictions on the evaluation of co-existing gastro-
 ;;intestinal conditions, it is important that all
 ;;gastrointestinal disorders found be described in
 ;;detail.  The term "peptic ulcer" is not proper for
 ;;evaluation purposes.  You should specify "gastric",
 ;;"marginal", or "duodenal" as appropriate.
 ;;
 ;;8.  In many cases, the contemporary treatment records
 ;;for the initial manifestation of POW presumptive
 ;;diseases will no longer be available because of the
 ;;passage of time, death of the physician, etc.  Histories
 ;;of specific diseases should include whether the
 ;;veteran recalls his symptoms at the time so the
 ;;rating board can determine whether conditions now
 ;;present, but non-compensable, were of compensable degree
 ;;in the past.
 ;;$END
