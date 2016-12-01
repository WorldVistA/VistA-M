IBDEI002 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358)
 ;;=^IBE(358,
 ;;^UTILITY(U,$J,358,0)
 ;;=IMP/EXP ENCOUNTER FORM^358I^51^50
 ;;^UTILITY(U,$J,358,1,0)
 ;;=NATIONAL ADDICTION FY16-Q4^1^National Addiction form August 2016^1^0^1^1^^133^80^12^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,1,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,1,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,1,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,2,0)
 ;;=NATIONAL ANESTHESIA FY16-Q4^0^National Anesthesia August 2016^1^0^1^1^^133^80^6^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,3,0)
 ;;=NATL CARDIOLOGY/CATH FY16-Q4^1^National Cardiology/Card Cath July 2016^1^0^1^1^^133^80^8^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,4,0)
 ;;=NATIONAL CHIROPRACTIC FY16-Q4^2^National Chiropractic August 2016^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,4,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,4,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,5,0)
 ;;=NATIONAL CIH FY16-Q4^1^National Complementary and Integrative Health (CIH) July 2016^1^0^1^1^^133^80^6^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,5,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,5,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,5,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,5,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,5,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,5,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,5,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,6,0)
 ;;=NATIONAL CRITICAL CARE FY16-Q4^1^National Critical Care Form August 2016^1^0^1^1^^133^80^4^1^^1^p^1^2.1
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
 ;;=NATIONAL DAY SURGERY FY16-Q4^0^National Minor Procedures August 2016^1^0^1^1^^133^80^19^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,7,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,7,2,1,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,8,0)
 ;;=NATIONAL DERMATOLOGY FY16-Q4^0^National Derm Form-August 2016^1^0^^1^^133^80^10^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,9,0)
 ;;=NATIONAL ED FY16-Q4^1^National Emergency Dept Form August 2016^1^0^1^1^^133^80^31^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,9,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,9,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,9,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,9,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,9,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,9,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,9,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,10,0)
 ;;=NATIONAL EMP HEALTH FY16-Q4^1^National Employee Health August 2016^1^0^1^1^^133^80^5^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,10,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,10,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,10,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,10,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,10,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,10,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,10,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,11,0)
 ;;=NATIONAL EYE TECH FY16-Q4^1^National Eye Technician July 2016^1^0^1^1^^133^80^8^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,11,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,11,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,11,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,11,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,11,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,12,0)
 ;;=NATIONAL EYE FY16-Q4^1^National Eye July 2016^1^0^1^1^^133^80^9^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,12,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,12,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,12,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,12,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,12,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,13,0)
 ;;=NATIONAL GEN SURG FY16-Q4^0^National Surgery August 2016^1^0^1^1^^133^80^18^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,14,0)
 ;;=NATIONAL GERIATRICS FY16-Q4^2^National Geriatric Care July 2016^1^0^1^1^^133^80^20^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,14,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,14,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,14,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,15,0)
 ;;=NATL HBPC CLIN FY16-Q4^1^National HBPC Clinician August 2016^1^0^1^1^^133^80^30^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,15,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,15,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,15,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,15,2,3,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,15,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,16,0)
 ;;=NATL HBPC PSYCHOLOGIST FY16-Q4^0^National HBPC Psychologist August 2016^1^0^1^1^^133^80^11^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,16,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,16,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,16,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,17,0)
 ;;=NATL HBPC REHAB FY16-Q4^2^National HBPC Rehab Therapy August 2016^1^0^1^1^^133^80^20^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,17,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,17,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,17,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,17,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,18,0)
 ;;=NATIONAL INFECTIOUS DX FY16-Q4^1^National Infectious Disease July 2016^1^0^1^1^^133^80^6^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,18,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,18,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,18,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,18,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,18,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,18,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,18,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,19,0)
 ;;=NATIONAL INPATIENT FY16-Q4^0^National Inpatient Form July 2016^1^0^1^1^^133^80^12^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,19,2,0)
 ;;=^358.02I^7^7
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
 ;;^UTILITY(U,$J,358,19,2,7,0)
 ;;=6^1
 ;;^UTILITY(U,$J,358,20,0)
 ;;=NATL MED FOSTER HOME FY16-Q4^1^National Medical Foster Home-August 2016^1^0^1^1^^133^80^30^1^^1^p^1^2.1
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
 ;;=NATIONAL MEDICINE FY16-Q4^1^National Medicine Form August 2016^1^0^1^1^^133^80^30^1^^1^p^1^2.1
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
 ;;=NATIONAL MH MHICM FY16-Q4^1^National MH Intensive Program August 2016^1^0^1^1^^133^80^12^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,22,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,22,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,22,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,22,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,23,0)
 ;;=NATIONAL MH NURSE FY16-Q4^0^National Mental Health Nurse August 2016^1^0^1^1^^133^80^11^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,23,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,23,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,23,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,24,0)
 ;;=NATIONAL MH PHARM FY16-Q4^2^NATIONAL MHS CLINICAL PHARMACISTS-REVIEWED/REVISED August 2016^1^0^1^1^^133^80^11^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,24,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,24,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,24,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,25,0)
 ;;=NATL MH PSYCHIATRIST FY16-Q4^0^National Mental Health Psychiatrist August 2016^1^0^1^1^^133^80^12^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,25,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,25,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,25,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,26,0)
 ;;=NATL MH PSYCHOLOGIST FY16-Q4^0^National Mental Health Psychologist August 2016^1^0^1^1^^133^80^12^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,26,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,26,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,26,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,27,0)
 ;;=NATIONAL NEUROLOGY FY16-Q4^0^National Neurology August 2016^1^0^1^1^^133^80^6^1^^1^p^1
 ;;^UTILITY(U,$J,358,28,0)
 ;;=NATIONAL NEUROSURGERY FY16-Q4^0^National Neurosurgery August 2016^1^0^0^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,28,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,28,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,28,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,29,0)
 ;;=NATL NURSING CLINIC FY16-Q4^1^National Nursing Clinic EEF-July 2016^1^0^1^1^^133^80^8^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,29,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,29,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,29,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,29,2,3,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,29,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,30,0)
 ;;=NATIONAL OB/GYN FY16-Q4^2^NATIONAL OB/GYN August 2016^1^0^1^1^^133^80^14^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,31,0)
 ;;=NATIONAL ORTHOPEDICS FY16-Q4^0^National Orthopedics August 2016^1^0^1^1^^133^80^10^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,31,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,31,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,31,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,31,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,31,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,31,2,5,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,31,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,32,0)
 ;;=NATIONAL PAIN FY16-Q4^0^National Pain July 2016^1^0^1^1^^133^80^4^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,33,0)
 ;;=NATIONAL PEER SUPPORT FY16-Q4^1^National Peer Specialist August 2016^1^0^1^1^^133^80^11^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,33,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,33,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,33,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,33,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,34,0)
 ;;=NATL PHYSIATRIST INPT FY16-Q4^2^National Inpatient Rehab Physiatrist August 2016^1^0^1^1^^133^80^10^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,34,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,34,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,34,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,34,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,36,0)
 ;;=NATIONAL PRIMARY CARE FY16-Q4^1^National Primary Care Form August 2016^1^0^1^1^^133^80^30^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,36,2,0)
 ;;=^358.02I^6^6
