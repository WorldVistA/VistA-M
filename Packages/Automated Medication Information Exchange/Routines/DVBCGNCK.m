DVBCGNCK ;ALB/GTS-557/THM-GYNECOLOGICAL EXAM ; 4/29/91  11:31 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0705 Worksheet" S HD7="GYNECOLOGICAL",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",?14,HD7
 W !!!!,"Narrative:"
 W ?13,"An evaluation of the female reproductive system depends",!?13,"on a complete physical examination, a thorough medical",!
 W ?13,"history and all appropriate laboratory studies.",!!
 W:$D(CMBN) "Note: " I '$D(CMBN) W "A. Medical history "
 S TXT=$S($D(CMBN):"TXT1",1:"TXT2") F AW=0:1 S AX=$T(@TXT+AW) S AY=$P(AX,";;",2) W:AY="END" !! Q:AY="END"  W AY,!
 I '$D(CMBN) W !!!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",!!!!!!!!!! D HD2
 W:$D(CMBN) !! W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):"
 W !!!?8,"1. Uterus",!!?11,"a. Removal of, complete/imcomplete (if incomplete,",!?14,"state if pregnancy is prevented) -",!!!!!!
 W ?11,"b. Prolapse of, complete through vulva/imcomplete -",!!!!!!?11,"c. Displacement of; also identify adhesions and irregular",!?14,"menstruation -",!!!!!!
 D:$D(CMBN) HD2 W ?8,"2. Ovaries",!!?11,"a. Removal of both -",!!!!!!?11,"b. Removal of one with or without partial removal",!?14,"of the other -",!!!!!!?11,"c. Atrophy of one or both ovaries, complete -",!!!!!!
 W ?8,"3. Rectal and rectovaginal; identify any surgical complications",!?11,"of pregnancy -",!!!!!! D:'$D(CMBN) HD2 W ?8,"4. If a malignant process has been present within the past year,",!
 W ?11,"give the date of the last surgical, radiation or chemical",!?11,"therapy -",!!!!!!
 W ?8,"5. If a tubercular or other mycobacterial infection has been treated",!?11,"within the past year, give the date of inactivity -",!!!!!!?8,"6. Has a voluntary sterilization procedure been performed? -",!!!!!!
 D:$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!,HD8,!!!
 Q
TXT2 ;;(it is very important that in claims for establishing
 ;;service connection that the past medical history, menstrual history, marital
 ;;and pregnancy history and urinary history be as complete as possible):
 ;;END
 ;
TXT1 ;;In completing the medical history for the primary examination to
 ;;which this supplemental examination is attached, it is very important
 ;;that in claims for establishing service connection that the past medical
 ;;history, menstrual history, marital and pregnancy history and urinary
 ;;history be as complete as possible.
 ;;END
