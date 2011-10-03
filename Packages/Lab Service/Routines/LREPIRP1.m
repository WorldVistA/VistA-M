LREPIRP1 ;DALOI/CKA-EMERGING PATHOGENS HL7 REPORT CONVERSION ;5/14/03
 ;;5.2;LAB SERVICE;**281**;Sep 27, 1994
 ; Reference to $$SITE^VASITE supported by IA # 10112
 ; Reference to ^DIC(21 supported by IA #2504
 Q
 ;SUMMARY VERIFICATION REPORT HEADING
SUMHD1 S SITE=$$SITE^VASITE
 S MSG="SUMMARY VERIFICATION REPORT OF EPI EXTRACTED DATA"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1,MSG=""
 S MSG="FROM STATION "_$P(SITE,U,3)_" "_$P(SITE,U,2)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1,MSG=""
SUMHD2 S MSG="",^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1,MSG=""
 S MSG="Processing Month "_LRHDGL2
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1,MSG=""
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1,MSG=""
 S MSG=LRSP_LRSP_$E(LRSP,1,7)_"Number of"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG=LRSP_$E(LRSP,1,24)_"Number of    Persons with"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG=$E(LRSP,1,2)_"Emerging Pathogen"_LRSP_$E(LRSP,1,3)_"Occurrences    Occurrence"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="________________________________________________________________________________"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 Q
NOTE1 S MSG="",^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="For definitions of case ascertainment for each category, please refer to"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="documentation in Laboratory EPI Patch LR*5.2*281 Technical and"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="User Guide in conjunction with your local parameter set-up of this process."
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG=""
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="If you feel that these numbers are in error, please verify with the local"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="facility personnel responsible for setting the EPI Laboratory Search/Extract"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="parameters.  However, do not change these parameters if they are incorrect"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="without fully reading the documentation;  this will be crucial in order to"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="avoid any misalignment with the concomitant Hepatitis C Extract patches"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="(PXRM*1.5*1, VA-National EPI DB Update, LR*5.2*260, PSJ*5*48, Hepatitis C"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Initiative, and PSO*7*45, Hepatitis C Initiative).  In particular, the"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="hepatitis C antibody positive, hepatitis C antibody negative, hepatitis A"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="antibody positive and hepatitis B positive will be especially sensitive to"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="changes, and concomitant changes of all of the patches may need to occur."
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 Q
SUMHD3 S MSG=LRSP_LRSP_$E(LRSP,1,1)_"Number of Persons"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG=LRSP_LRSP_$E(LRSP,1,1)_"with the Term and"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG=LRSP_LRSP_$E(LRSP,1,1)_"Transmitted For"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG=$E(LRSP,1,18)_"Nationally rolled-up resolution term"_$E(LRSP,1,7)_"National Roll-up"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="_______________________________________________________________________________"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 Q
NOTE2 S MSG="This table represents only those who had a once-lifetime resolution of the"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="National Clinical Reminder for Risk Assessment for Hepatitis C.  This"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="resolution will only occur once during the care of a patient (unless actively"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="changed by a point-of-care practitioner at a later date)."
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 Q
NOTE3 S MSG="1. For Microbiology Lab Package Organism results/isolates (e.g."
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Enterococcus, or Streptococcus pneumoniae), the number corresponding"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="to the name represents the total number reported from your local"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="microbiology package during the processing month.  The number"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="corresponding to the line 'Patients with...<Microbiology Lab"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Result/isolates> (e.g. Patients with Enterococcus or Patients with"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Streptococcus pneumoniae) represents the number of individual"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="patients from whom the results were isolated."
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="2. For non-microbiology results (e.g. chemistry/serology results such"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="as Hepatitis C antibody), the number corresponding to the name"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="represents the TOTAL number of <named> tests done at your facility"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="during the processing month.  The number corresponding to the line"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="<Patients with...<non-Microbiology test> (e.g. Hepatitis C antibody)"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
        S MSG="represents the number of individuals on whom the test(s) was/were"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="performed.  This does not represent the number of persons who had a positive"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG=" test result."
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="3.  These results have been obtained based on specimen accession"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="date and not results reported dating."
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 Q
