IBDEI002 ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358)
 ;;=^IBE(358,
 ;;^UTILITY(U,$J,358,0)
 ;;=IMP/EXP ENCOUNTER FORM^358I^37^36
 ;;^UTILITY(U,$J,358,1,0)
 ;;=NATIONAL ECOE TELE FY22-Q4^2^National Epilepsy Center of Excellence Telephone July 2022^1^0^0^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,1,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,1,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,2,0)
 ;;=NATL PREVENTIVE HEALTH FY22-Q4^1^National Preventive Health July 2022^1^0^1^1^^133^80^4^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,2,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,2,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,2,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,2,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,2,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,2,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,2,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,3,0)
 ;;=NATIONAL SLEEP MED FY22-Q4^0^National Sleep Medicine July 2022^1^0^1^1^^133^80^3^0^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,3,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,3,2,1,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,3,2,2,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,4,0)
 ;;=NATL ONC/CHEMO INF FY22-Q4^0^National Oncology & Chemotherapy Infusion July 2022^1^0^1^1^^133^80^9^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,4,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,4,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,4,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,5,0)
 ;;=NATIONAL NEUROLOGY FY22-Q4^0^National Neurology July 2022^1^0^1^1^^133^80^7^1^^1^p^1
 ;;^UTILITY(U,$J,358,6,0)
 ;;=NATIONAL ADHC FY22-Q4^2^National Adult Day Health Care July 2022 ^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,7,0)
 ;;=NATIONAL BLIND REHAB FY22-Q4^0^National Blind Rehab Service July 2022^1^0^0^1^^133^80^3^1^^1^p^1
 ;;^UTILITY(U,$J,358,7,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,7,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,8,0)
 ;;=NATL CARDIOLOGY/CATH FY22-Q4^1^National Cardiology/Card Cath July 2022^1^0^1^1^^133^80^13^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,9,0)
 ;;=NATIONAL CHIROPRACTIC FY22-Q4^2^National Chiropractic July 2022^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,9,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,9,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,10,0)
 ;;=NATIONAL CLIN PHARM FY22-Q4^2^National Clinical Pharmacist July 2022^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,10,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,10,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,11,0)
 ;;=NATIONAL DIABETES FY22-Q4^2^National Diabetes July 2022^1^0^1^1^^133^80^6^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,11,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,11,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,11,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,12,0)
 ;;=NATIONAL ED FY22-Q4^1^National Emergency Dept July 2022^1^0^1^1^^133^80^13^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,12,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,12,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,12,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,12,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,12,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,12,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,12,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,13,0)
 ;;=NATIONAL ENDOCRINOLOGY FY22-Q4^0^National Endocrinology July 2022^1^0^1^1^^133^80^4^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,14,0)
 ;;=NATIONAL EYE TECH FY22-Q4^1^National Eye Technician July 2022^1^0^1^1^^133^80^11^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,14,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,14,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,14,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,14,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,14,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,15,0)
 ;;=NATIONAL EYE FY22-Q4^1^National Eye July 2022^1^0^1^1^^133^80^13^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,15,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,15,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,15,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,15,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,15,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,16,0)
 ;;=NATL GI/HEPATOLOGY FY22-Q4^0^National GI and Hepatology July 2022^1^0^0^1^^133^80^11^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,17,0)
 ;;=NATL HBPC CLIN FY22-Q4^1^National HBPC Clinician July 2022^1^0^1^1^^133^80^36^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,17,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,17,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,17,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,17,2,3,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,17,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,18,0)
 ;;=NATL HBPC NURSING FY22-Q4^1^National HBPC Nursing July 2022^1^0^1^1^^133^80^9^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,18,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,18,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,18,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,18,2,3,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,18,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,19,0)
 ;;=NATL HBPC REHAB FY22-Q4^2^National HBPC Rehab Therapy July 2022 ^1^0^1^1^^133^80^19^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,19,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,19,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,19,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,19,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,20,0)
 ;;=NATIONAL INPATIENT FY22-Q4^0^National Inpatient July 2022^1^0^1^1^^133^80^16^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,20,2,0)
 ;;=^358.02I^7^7
 ;;^UTILITY(U,$J,358,20,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,20,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,20,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,20,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,20,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,20,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,20,2,7,0)
 ;;=6^1
 ;;^UTILITY(U,$J,358,21,0)
 ;;=NATIONAL MEDICINE FY22-Q4^1^National Medicine July 2022^1^0^1^1^^133^80^36^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,21,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,21,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,21,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,21,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,21,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,21,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,21,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,22,0)
 ;;=NATL NURSING CLINIC FY22-Q4^1^National Nursing Clinic July 2022^1^0^1^1^^133^80^10^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,22,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,22,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,22,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,22,2,3,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,22,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,23,0)
 ;;=NATIONAL OB/GYN FY22-Q4^2^National OB/GYN July 2022^1^0^1^1^^133^80^16^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,24,0)
 ;;=NATL PHYSIATRIST INPT FY22-Q4^2^National Inpatient Physiatrist July 2022^1^0^1^1^^133^80^13^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,24,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,24,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,24,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,24,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,25,0)
 ;;=NATL PHYSIATRIST OTPT FY22-Q4^2^National Outpatient Physiatrist July 2022^1^0^1^1^^133^80^13^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,25,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,25,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,25,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,25,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,26,0)
 ;;=NATIONAL PRIMARY CARE FY22-Q4^1^National Primary Care June 2022^1^0^1^1^^133^80^37^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,26,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,26,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,26,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,26,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,26,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,26,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,26,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,27,0)
 ;;=NATIONAL PULMONARY FY22-Q4^0^National Pulmonary July 2022^1^0^0^1^^133^80^13^1^^1^p^1
 ;;^UTILITY(U,$J,358,27,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,27,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,27,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,28,0)
 ;;=NATIONAL SCI FY22-Q4^1^National Spinal Cord Injury July 2022^1^0^1^1^^133^80^6^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,28,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,28,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,28,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,28,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,28,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,28,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,28,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,29,0)
 ;;=NATIONAL TELEPHONE FY22-Q4^2^National Telephone July 2022^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,29,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,29,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,29,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,30,0)
 ;;=NATIONAL TELE-EYE FY22-Q4^2^National Tele-Eye Exams July 2022^1^0^1^1^^133^80^10^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,30,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,30,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,30,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,31,0)
 ;;=NATIONAL ANESTHESIA FY22-Q4^0^National Anesthesia July 2022^1^0^1^1^^133^80^8^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,32,0)
 ;;=NATL HOSP/PALL INPT FY22-Q4^2^National Inpatient Hospice & Palliative Care July 2022^1^0^1^1^^133^80^6^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,33,0)
 ;;=NATL HOSP/PALL OTPT FY22-Q4^2^National Outpatient Hospice & Palliative Care July 2022^1^0^1^1^^133^80^5^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,34,0)
 ;;=NATL COVID19 SPLMNTL FY22-Q4^0^National COVID-19 ICD Supplemental Form July 2022^1^0^0^1^^133^80^1^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,35,0)
 ;;=NATL TEL COVID19 SPMTL FY22-Q4^0^National Telephone COVID-19 Supplemental Form July 2022^1^0^0^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,37,0)
 ;;=NATL REMOTE MONITORING FY22-Q4^2^National Remote Monitoring July 2022^1^0^1^1^^133^80^1^0^^1^p^1^3
 ;;^UTILITY(U,$J,358,37,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,37,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,37,2,2,0)
 ;;=2^1
