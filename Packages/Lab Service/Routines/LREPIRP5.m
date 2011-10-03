LREPIRP5 ;DALOI/CKA-EMERGING PATHOGENS HL7 REPORT CONVERSION ;5/13/03
 ;;5.2;LAB SERVICE;**281,320**;Sep 27, 1994
 Q
SUMMARY ;BUILD SUMMARY REPORT
 ; BUILD SUMMARY INFO
 F LRPATH=1:1:23 S LRTOT(LRPATH)=0
 S LRPATH=0
 F  S LRPATH=$O(^XTMP("LREPIREP"_LRDATE,"TOTAL",LRPATH)) Q:LRPATH=""  D
 .S LRTOT(LRPATH)=^XTMP("LREPIREP"_LRDATE,"TOTAL",LRPATH)
 S MSG="NTE~1-Vancomycin-resistant Enterococcus"
 S MSG=MSG_$E(LRSP,1,17)_$J($P(LRTOT(1),U),5)_"   "_$J($P(LRTOT(1),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~2-Hepatitis C antibody Positive"
 S MSG=MSG_$E(LRSP,1,21)_$J($P(LRTOT(2),U),5)_"   "_$J($P(LRTOT(2),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~3-Penicillin-Resistant Streptococcus pneumoniae"
 S MSG=MSG_$E(LRSP,1,5)_$J($P(LRTOT(3),U),5)_"   "_$J($P(LRTOT(3),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~4-Clostridium difficile"
 S MSG=MSG_$E(LRSP,1,29)_$J($P(LRTOT(4),U),5)_"   "_$J($P(LRTOT(4),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~5-Tuberculosis"
 S MSG=MSG_LRSP_$E(LRSP,1,8)_$J($P(LRTOT(5),U),5)_"   "_$J($P(LRTOT(5),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~6-Streptococcus, Group A"
 S MSG=MSG_$E(LRSP,1,28)_$J($P(LRTOT(6),U),5)_"   "_$J($P(LRTOT(6),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~7-Legionella/Legionaire's Disease"
 S MSG=MSG_$E(LRSP,1,19)_$J($P(LRTOT(7),U),5)_"   "_$J($P(LRTOT(7),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~8-Candida bloodstream infections"
 S MSG=MSG_$E(LRSP,1,20)_$J($P(LRTOT(8),U),5)_"   "_$J($P(LRTOT(8),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~9-Crytosporidium"
 S MSG=MSG_LRSP_$E(LRSP,1,6)_$J($P(LRTOT(9),U),5)_"   "_$J($P(LRTOT(9),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~10-Escherichia coli O157"
 S MSG=MSG_$E(LRSP,1,28)_$J($P(LRTOT(10),U),5)_"   "_$J($P(LRTOT(10),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~11-Malaria"
 S MSG=MSG_LRSP_$E(LRSP,1,12)_$J($P(LRTOT(11),U),5)_"   "_$J($P(LRTOT(11),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~12-Dengue"
 S MSG=MSG_LRSP_$E(LRSP,1,13)_$J($P(LRTOT(12),U),5)_"   "_$J($P(LRTOT(12),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~13-Creutzfeldt-Jakob Disease"
 S MSG=MSG_$E(LRSP,1,24)_$J($P(LRTOT(13),U),5)_"   "_$J($P(LRTOT(13),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~14-Leishmaniasis"
 S MSG=MSG_LRSP_$E(LRSP,1,6)_$J($P(LRTOT(14),U),5)_"   "_$J($P(LRTOT(14),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~15-Hepatitis C antibody negative"
 S MSG=MSG_$E(LRSP,1,20)_$J($P(LRTOT(15),U),5)_"   "_$J($P(LRTOT(15),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~16-Hepatitis A antibody positive"
 S MSG=MSG_$E(LRSP,1,20)_$J($P(LRTOT(16),U),5)_"   "_$J($P(LRTOT(16),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~17-Hepatitis B positive"
 S MSG=MSG_$E(LRSP,1,29)_$J($P(LRTOT(17),U),5)_"   "_$J($P(LRTOT(17),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~18-All Staphylococcus Aureus"
 S MSG=MSG_$E(LRSP,1,24)_$J($P(LRTOT(18),U),5)_"   "_$J($P(LRTOT(18),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~19-Methicillin-Resistant Staphylococcus Aureus (Mrsa)"
 S MSG=MSG_$J($P(LRTOT(19),U),4)_"   "_$J($P(LRTOT(19),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~20-Vancomycin-Resistant Staphylococcus Aureus (Vrsa)"
 S MSG=MSG_$J($P(LRTOT(20),U),5)_"   "_$J($P(LRTOT(20),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~21-Vancomycin-Resistant Coagulase Negative"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="       Staphylococci/Staph EPI (Vrse)"
 S MSG=MSG_$E(LRSP,1,19)_$J($P(LRTOT(21),U),5)_"   "_$J($P(LRTOT(21),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~22-All Streptococcus Pneumoniae"
 S MSG=MSG_$E(LRSP,1,21)_$J($P(LRTOT(22),U),5)_"   "_$J($P(LRTOT(22),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="NTE~23-All Enterococci"
 S MSG=MSG_LRSP_$E(LRSP,1,4)_$J($P(LRTOT(23),U),5)_"   "_$J($P(LRTOT(23),U,2),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 Q
PRTTOT ;Print totals on summary report
 S MSG="",^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Processing Month: "_LRHDGL2_" for site # "_$P(SITE,U,3)_" "_$P(SITE,U,2)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Site totals"
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="",^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S LRNUM=0
 F  S LRNUM=$O(^XTMP("LREPIREP"_LRDATE,"TOTAL1",LRNUM)) Q:LRNUM=""  D
 .S MSG=$P($P(^XTMP("LREPIREP"_LRDATE,"TOTAL1",LRNUM),HLFS,3),LRCS,3)
 .I 60-$L(MSG)>30 S MSG=MSG_LRSP
 .I 60-$L(MSG)>30 S MSG=MSG_LRSP
 .S MSG=MSG_$E(LRSP,1,60-$L(MSG))
 .S MSG=MSG_$J($P($P(^XTMP("LREPIREP"_LRDATE,"TOTAL1",LRNUM),HLFS,3),LRCS,4),5)
 .S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 Q
PRTHEP ;PRINT HEP C RISK ASSESSMENT TOTALS
 F LRNUM=1:1:7 S LRTOT(LRNUM)=+$G(^XTMP("LREPIREP"_LRDATE,"HEPTOT",LRNUM))
 S MSG="Resolved term-1-Declined Assessment for Hepatitis C"
 S MSG=MSG_$E(LRSP,1,9)_$J($P(LRTOT(1),U),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Resolved term-2-No Risk Factors for Hepatitis C"
 S MSG=MSG_$E(LRSP,1,13)_$J($P(LRTOT(2),U),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Resolved term-3-Previously Assessed for Hepatitis C"
 S MSG=MSG_$E(LRSP,1,9)_$J($P(LRTOT(3),U),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Resolved term-4-Risk Factors for Hepatitis C"
 S MSG=MSG_$E(LRSP,1,16)_$J($P(LRTOT(4),U),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Resolved term-5-Positive Test for Hepatitis C antibody"
 S MSG=MSG_$E(LRSP,1,6)_$J($P(LRTOT(5),U),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Resolved term-6-Negative Test for Hepatitis C antibody"
 S MSG=MSG_$E(LRSP,1,6)_$J($P(LRTOT(6),U),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S MSG="Resolved term-7-Hepatitis C diagnosis (ICD-9 based)"
 S MSG=MSG_$E(LRSP,1,9)_$J($P(LRTOT(7),U),5)
 S ^TMP($J,"MSG",MSGCNT)=MSG,MSGCNT=MSGCNT+1
 S ^TMP($J,"MSG",MSGCNT)=LRSP_LRSP_"-----"
 S MSGCNT=MSGCNT+1
 S LRTOT=LRTOT(1)+LRTOT(2)+LRTOT(3)+LRTOT(4)+LRTOT(5)+LRTOT(6)+LRTOT(7)
 S ^TMP($J,"MSG",MSGCNT)="Total Hepatitis C Risk Assessment Resolution"_$E(LRSP,1,16)_$J(LRTOT,5)
 S MSGCNT=MSGCNT+1
 ;
 Q
