IBDEI007 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358,55,0)
 ;;=NATL HT SWS FY15-Q4^0^National CCHT Social Work Services July 2015^1^0^^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,56,0)
 ;;=NATL MH PSYCHIATRIST FY15-Q4^0^National Mental Health Psychiatrist August 2015^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,56,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,56,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,56,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,57,0)
 ;;=NATL MH PSYCHOLOGIST FY15-Q4^0^National Mental Health Psychologist August 2015^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,57,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,57,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,57,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,58,0)
 ;;=NATL PHYSIATRIST INPT FY15-Q4^2^National Inpatient Rehab Physiatrist August 2015^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,58,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,58,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,58,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,58,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,59,0)
 ;;=NATL PHYSIATRIST OTPT FY15-Q4^2^National Rehab Physiatrist Outpatient August 2015^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,59,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,59,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,59,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,59,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,60,0)
 ;;=NATL PREVENTIVE HEALTH FY15-Q4^1^National Preventive Health July 2015^1^0^1^1^^133^80^9^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,60,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,60,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,60,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,60,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,60,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,60,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,60,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,61,0)
 ;;=NATL RADIATION ONC FY15-Q4^2^NATIONAL RADIATION THERAPY July 2015^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,61,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,61,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,61,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,61,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,62,0)
 ;;=NATL REC THERAPY GRP FY15-Q4^2^National Recreation Therapy Group July 2015^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,62,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,62,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,62,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,62,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,63,0)
 ;;=NATL REC THERAPY IND FY15-Q4^2^National Recreation Therapy July 2015^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,63,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,63,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,63,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,63,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,64,0)
 ;;=NATL REHAB-PT/OT/KT FY15-Q4^2^National Rehab PT/OT/KT July 2015^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,64,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,64,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,64,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,64,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,65,0)
 ;;=NEUROSURGERY ICD-10^1^National Neurosurgery w/ ICD-10 Codes May 2014^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,65,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,65,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,65,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,65,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,65,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,65,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,65,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,66,0)
 ;;=NURSING ICD-10 V2^2^NURSING ICD-10 CODES June 2014^1^0^^1^^133^80^5^0^^1^p^1^3
 ;;^UTILITY(U,$J,358,67,0)
 ;;=OB-GYN ICD-10^1^NATIONAL OB-GYN WITH ICD-10 CODES^1^0^1^1^^133^80^11^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,67,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,67,2,1,0)
 ;;=1^1
