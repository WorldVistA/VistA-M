IBDEI002 ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358)
 ;;=^IBE(358,
 ;;^UTILITY(U,$J,358,0)
 ;;=IMP/EXP ENCOUNTER FORM^358I^66^66
 ;;^UTILITY(U,$J,358,1,0)
 ;;=NATIONAL ADDICTION FY13-Q2^1^National Addiction form January 2013^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,1,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,1,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,1,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,2,0)
 ;;=NATIONAL ADHC FY13-Q2^2^National Adult Day Health Care January 2013^1^0^1^1^^133^80^1^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,3,0)
 ;;=NATIONAL ALLERGY FY13-Q2^1^National Allergy Clinic February 2013^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,3,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,3,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,3,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,3,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,3,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,3,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,3,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,4,0)
 ;;=NATIONAL AUDIO FY13-Q2^1^National Audiology February 2013^1^0^1^1^^133^80^2^1^^1^p^1
 ;;^UTILITY(U,$J,358,4,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,4,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,4,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,4,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,5,0)
 ;;=NATIONAL BLIND REHAB FY13-Q2^0^National Blind Rehab Service Encounter form-Updated January 2013^1^0^0^1^^133^80^1^1^^1^p^1
 ;;^UTILITY(U,$J,358,5,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,5,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,6,0)
 ;;=NATIONAL CARD CATH/IR FY13-Q2^1^National Cardiac Cath/Interventional Rad February 2013^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,7,0)
 ;;=NATIONAL CARDIOLOGY FY13-Q2^1^National Cardiology/EKG/Echo February 2013^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,8,0)
 ;;=NATL CCHT CLINICIAN FY13-Q2^0^National CCHT Clinician February 2013^1^0^^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,9,0)
 ;;=NATL CCHT SWS FY13-Q2^0^National CCHT Social Work Services February 2013^1^0^^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,10,0)
 ;;=NATIONAL CHEMO INFUSN FY13-Q2^0^National Chemotherapy Infusion January 2013^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,10,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,10,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,10,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,11,0)
 ;;=NATIONAL CHIROPRACTIC FY13-Q2^2^National Chiropractic February 2013^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,11,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,11,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,12,0)
 ;;=NATIONAL C&P FY13-Q2^2^NATIONAL COMPENSATION AND PENSION-December 2012^1^0^1^1^^133^80^1^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,12,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,12,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,13,0)
 ;;=NATIONAL CRITICAL CARE FY13-Q2^1^National Critical Care Form January 2013^1^0^1^1^^133^80^8^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,13,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,13,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,13,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,13,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,13,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,13,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,13,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,14,0)
 ;;=NATIONAL DAY SURGERY FY13-Q2^0^National Minor Procedures November 2012^1^0^1^1^^133^80^5^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,14,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,14,2,1,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,15,0)
 ;;=NATIONAL DEMENTIA FY13-Q2^1^National Dementia Clinic February 2013^1^0^1^1^^133^80^1^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,15,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,15,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,15,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,15,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,15,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,15,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,15,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,16,0)
 ;;=NATIONAL DERMATOLOGY FY13-Q2^0^National Derm Form-February 2013^1^0^^1^^133^80^6^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,17,0)
 ;;=NATIONAL DIABETES FY13-Q2^2^NATIONAL DIABETES-February 2013^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,17,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,17,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,17,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,18,0)
 ;;=NATIONAL DIALYSIS FY13-Q2^2^National Dialysis February 2013^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,18,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,18,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,18,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,19,0)
 ;;=NATIONAL E-CONSULT FY13-Q2^1^National E-Consult Form December 2012^1^0^1^1^^133^80^9^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,19,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,19,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,19,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,19,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,19,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,19,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,19,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,20,0)
 ;;=NATIONAL EMP HEALTH FY13-Q2^1^National Employee Health Ferbruary 2013^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,20,2,0)
 ;;=^358.02I^6^6
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
 ;;^UTILITY(U,$J,358,21,0)
 ;;=NATIONAL ENDOCRINOLOGY FY13-Q2^0^National Endocrinology February 2013^1^0^1^1^^133^80^1^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,22,0)
 ;;=NATIONAL ENT FY13-Q2^2^NATIONAL ENT-REVIEWED/REVISED January 2013^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,22,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,22,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,22,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,23,0)
 ;;=NATIONAL ECOE FY13-Q2^2^NATIONAL EPILEPSY CENTER OF EXCELLENCE January 2013^1^0^0^1^^133^80^1^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,23,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,23,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,24,0)
 ;;=NATIONAL ED FY13-Q2^1^National Emergency Dept Form February 2013^1^0^1^1^^133^80^10^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,24,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,24,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,24,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,24,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,24,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,24,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,24,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,25,0)
 ;;=NATIONAL EYE FY13-Q2^1^National Eye January 2013^1^0^1^1^^133^80^4^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,25,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,25,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,25,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,25,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,25,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,26,0)
 ;;=NATIONAL EYE TECH FY13-Q2^1^National Eye Technician January 2013^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,26,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,26,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,26,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,26,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,26,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,27,0)
 ;;=NATIONAL GEN SURG FY13-Q2^0^National Surgery November 2012^1^0^1^1^^133^80^4^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,28,0)
 ;;=NATIONAL GI FY13-Q2^0^National GI form February 2013^1^0^^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,29,0)
 ;;=NATIONAL HBPC PT/OT FY13-Q2^2^National HBPC Rehab PT/OT January 2013^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,29,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,29,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,29,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,29,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,30,0)
 ;;=NATL HOSP/PALL INPT FY13-Q2^2^NATIONAL INPATIENT HOSPICE AND PALLIATIVE CARE February 2013^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,31,0)
 ;;=NATL HOSP/PALL OTPT FY13-Q2^2^NATIONAL HOSPICE AND PALLIATIVE CARE February 2013^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,32,0)
 ;;=NATIONAL INFECTIOUS DX FY13-Q2^1^National Infectious Disease January 2013^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,32,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,32,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,32,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,32,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,32,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,32,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,32,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,33,0)
 ;;=NATIONAL INPATIENT FY13-Q2^0^National Inpatient Form December 2012^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,33,2,0)
 ;;=^358.02I^7^7
 ;;^UTILITY(U,$J,358,33,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,33,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,33,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,33,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,33,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,33,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,33,2,7,0)
 ;;=6^1
 ;;^UTILITY(U,$J,358,34,0)
 ;;=NATL LOW VISION-OPTOM FY13-Q2^1^National Low Vision Optometry January 2013^1^0^1^1^^133^80^2^1^^1^p^1
 ;;^UTILITY(U,$J,358,34,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,34,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,34,2,2,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,34,2,3,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,35,0)
 ;;=NATL MED FOSTER HOME FY13-Q2^1^National Medical Foster Home-February 2013^1^0^1^1^^133^80^9^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,35,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,35,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,35,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,35,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,35,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,35,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,35,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,36,0)
 ;;=NATIONAL MEDICINE FY13-Q2^1^National Medicine Form December 2012^1^0^1^1^^133^80^9^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,36,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,36,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,36,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,36,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,36,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,36,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,36,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,37,0)
 ;;=NATL MH PSYCHIATRIST FY13-Q2^0^National Mental Health Psychiatrist February 2013^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,37,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,37,2,1,0)
 ;;=1^1
