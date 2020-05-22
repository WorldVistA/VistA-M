IBDEI002 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358)
 ;;=^IBE(358,
 ;;^UTILITY(U,$J,358,0)
 ;;=IMP/EXP ENCOUNTER FORM^358I^38^38
 ;;^UTILITY(U,$J,358,1,0)
 ;;=NATIONAL ECOE E&M FY20-Q3^2^National Epilepsy Center of Excellence Office Visits April 2020^1^0^0^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,1,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,1,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,2,0)
 ;;=NATIONAL ECOE E-CON FY20-Q3^2^National Epilepsy Center of Excellence E-Consults March 2020^1^0^0^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,2,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,2,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,3,0)
 ;;=NATIONAL ECOE PROC FY20-Q3^2^National Epilepsy Center of Excellence Procedures April 2020^1^0^0^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,3,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,3,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,4,0)
 ;;=NATIONAL ECOE TELE FY20-Q3^2^National Epilepsy Center of Excellence Telephone April 2020^1^0^0^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,4,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,4,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,5,0)
 ;;=NATIONAL HEMATOLOGY FY20-Q3^0^National Hematology April 2020^1^0^0^1^^133^80^6^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,5,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,5,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,5,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,6,0)
 ;;=NATIONAL EMP HEALTH FY20-Q3^1^National Employee Health April 2020^1^0^1^1^^133^80^6^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,6,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,6,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,6,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,6,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,6,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,6,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,6,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,7,0)
 ;;=NATIONAL NEUROLOGY FY20-Q3^0^National Neurology April 2020^1^0^1^1^^133^80^6^1^^1^p^1
 ;;^UTILITY(U,$J,358,8,0)
 ;;=NATIONAL AUDIO FY20-Q3^1^National Audiology April 2020^1^0^1^1^^133^80^6^1^^1^p^1
 ;;^UTILITY(U,$J,358,8,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,8,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,8,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,8,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,9,0)
 ;;=NATIONAL BLIND REHAB FY20-Q3^0^National Blind Rehab Service April 2020^1^0^0^1^^133^80^3^1^^1^p^1
 ;;^UTILITY(U,$J,358,9,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,9,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,10,0)
 ;;=NATIONAL CHIROPRACTIC FY20-Q3^2^National Chiropractic April 2020^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,10,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,10,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,11,0)
 ;;=NATL CIH/WHOLE HLTH FY20-Q3^1^National Complementary & Integrative Health (CIH)/Whole Health February 2020^1^0^1^1^^133^80^7^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,11,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,11,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,11,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,11,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,11,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,11,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,11,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,12,0)
 ;;=NATIONAL DIALYSIS FY20-Q3^2^National Dialysis April 2020^1^0^1^1^^133^80^7^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,12,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,12,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,12,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,13,0)
 ;;=NATIONAL E-CONSULT FY20-Q3^1^National E-Consult March 2020^1^0^1^1^^133^80^19^1^^1^p^1^2.1
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
 ;;=NATIONAL ED FY20-Q3^1^National Emergency Dept April 2020^1^0^1^1^^133^80^11^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,14,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,14,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,14,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,14,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,14,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,14,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,14,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,15,0)
 ;;=NATIONAL EYE TECH FY20-Q3^1^National Eye Technician April 2020^1^0^1^1^^133^80^10^1^^1^p^1^2.1
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
 ;;=NATIONAL EYE FY20-Q3^1^National Eye April 2020^1^0^1^1^^133^80^11^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,16,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,16,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,16,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,16,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,16,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,17,0)
 ;;=NATL GI/HEPATOLOGY FY20-Q3^0^National GI and Hepatology April 2020^1^0^0^1^^133^80^10^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,18,0)
 ;;=NATL HBPC CLIN FY20-Q3^1^National HBPC Clinician April 2020^1^0^1^1^^133^80^35^1^^1^p^1^2.1
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
 ;;=NATL HBPC NURSING FY20-Q3^1^National HBPC Nursing April 2020^1^0^1^1^^133^80^9^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,19,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,19,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,19,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,19,2,3,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,19,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,20,0)
 ;;=NATL HT CLINICIAN FY20-Q3^0^National CCHT Clinician April 2020^1^0^^1^^133^80^9^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,21,0)
 ;;=NATL HT NURSE FY20-Q3^0^National CCHT Nursing April 2020^1^0^^1^^133^80^9^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,22,0)
 ;;=NATIONAL INFECTIOUS DX FY20-Q3^1^National Infectious Disease April 2020^1^0^1^1^^133^80^6^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,22,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,22,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,22,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,22,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,22,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,22,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,22,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,23,0)
 ;;=NATL MED FOSTER HOME FY20-Q3^1^National Medical Foster Home April 2020^1^0^1^1^^133^80^35^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,23,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,23,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,23,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,23,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,23,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,23,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,23,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,24,0)
 ;;=NATIONAL MEDICINE FY20-Q3^1^National Medicine April 2020^1^0^1^1^^133^80^36^1^^1^p^1^2.1
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
 ;;=NATL MH PSYCHOLOGIST FY20-Q3^0^National MH Psychologist April 2020^1^0^1^1^^133^80^11^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,25,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,25,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,25,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,26,0)
 ;;=NATL NURSING CLINIC FY20-Q3^1^National Nursing Clinic April 2020^1^0^1^1^^133^80^10^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,26,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,26,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,26,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,26,2,3,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,26,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,27,0)
 ;;=NATIONAL PRIMARY CARE FY20-Q3^1^National Primary Care April 2020^1^0^1^1^^133^80^36^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,27,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,27,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,27,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,27,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,27,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,27,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,27,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,28,0)
 ;;=NATL REHAB-PT/OT/KT FY20-Q3^2^National Rehab PT/OT/KT April 2020^1^0^1^1^^133^80^23^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,28,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,28,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,28,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,28,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,29,0)
 ;;=NATIONAL TELEPHONE FY20-Q3^2^National Telephone April 2020^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,29,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,29,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,29,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,30,0)
 ;;=NATIONAL URGENT CARE FY20-Q3^2^National Urgent Care April 2020^1^0^0^1^^133^80^36^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,30,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,30,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,30,2,2,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,30,2,3,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,31,0)
 ;;=NATIONAL UROLOGY FY20-Q3^0^National Urology April 2020^1^0^1^1^^133^80^6^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,31,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,31,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,31,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,32,0)
 ;;=NATL HOSP/PALL INPT FY20-Q3^2^National Inpatient Hospice & Palliative Care April 2020^1^0^1^1^^133^80^5^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,33,0)
 ;;=NATL HOSP/PALL OTPT FY20-Q3^2^National Outpatient Hospice & Palliative Care April 2020^1^0^1^1^^133^80^5^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,34,0)
 ;;=NATL GTWY TO HLTHY LIV FY20-Q3^1^National Gateway to Healthy Living April 2020^1^0^1^1^^133^80^35^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,34,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,34,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,34,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,34,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,34,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,34,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,34,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,35,0)
 ;;=NATIONAL TELESTROKE FY20-Q3^0^National TeleStroke April 2020^1^0^^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,36,0)
 ;;=NATL WHLE HLTH SPLMNTL FY20-Q3^1^National Whole Health Supplemental Form February 2020^1^0^1^1^^133^80^1^1^^1^p^1^2.1
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
 ;;=NATL COVID19 SPLMNTL FY20-Q3^0^National COVID-19 ICD Supplemental Form April 2020^1^0^0^1^^133^80^1^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,38,0)
 ;;=NATL ENVRMNTL HLTH REG FY20-Q3^0^National Environmental Health Registry Form April 2020^1^0^0^1^^133^80^1^0^^1^p^1^2.1
