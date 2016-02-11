IBDEI18K ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20667,0)
 ;;=96120^^98^975^10^^^^1
 ;;^UTILITY(U,$J,358.3,20667,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20667,1,2,0)
 ;;=2^96120
 ;;^UTILITY(U,$J,358.3,20667,1,3,0)
 ;;=3^Neuropsych Tst admin by Computer
 ;;^UTILITY(U,$J,358.3,20668,0)
 ;;=96125^^98^975^20^^^^1
 ;;^UTILITY(U,$J,358.3,20668,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20668,1,2,0)
 ;;=2^96125
 ;;^UTILITY(U,$J,358.3,20668,1,3,0)
 ;;=3^Standardized Cognitive Performance Tst,per hr
 ;;^UTILITY(U,$J,358.3,20669,0)
 ;;=Q3014^^98^975^21^^^^1
 ;;^UTILITY(U,$J,358.3,20669,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20669,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,20669,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,20670,0)
 ;;=90887^^98^975^5^^^^1
 ;;^UTILITY(U,$J,358.3,20670,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20670,1,2,0)
 ;;=2^90887
 ;;^UTILITY(U,$J,358.3,20670,1,3,0)
 ;;=3^Consultation w/Family
 ;;^UTILITY(U,$J,358.3,20671,0)
 ;;=90889^^98^975^13^^^^1
 ;;^UTILITY(U,$J,358.3,20671,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20671,1,2,0)
 ;;=2^90889
 ;;^UTILITY(U,$J,358.3,20671,1,3,0)
 ;;=3^Preparation of Report
 ;;^UTILITY(U,$J,358.3,20672,0)
 ;;=96118^^98^975^11^^^^1
 ;;^UTILITY(U,$J,358.3,20672,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20672,1,2,0)
 ;;=2^96118
 ;;^UTILITY(U,$J,358.3,20672,1,3,0)
 ;;=3^Neuropsych Tst admin by Psychologist/MD,per hr
 ;;^UTILITY(U,$J,358.3,20673,0)
 ;;=97150^^98^975^7^^^^1
 ;;^UTILITY(U,$J,358.3,20673,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20673,1,2,0)
 ;;=2^97150
 ;;^UTILITY(U,$J,358.3,20673,1,3,0)
 ;;=3^Group Therapeutic Procedures
 ;;^UTILITY(U,$J,358.3,20674,0)
 ;;=G0177^^98^975^24^^^^1
 ;;^UTILITY(U,$J,358.3,20674,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20674,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,20674,1,3,0)
 ;;=3^Train & Ed for Disabiling MH Problem 45+ min
 ;;^UTILITY(U,$J,358.3,20675,0)
 ;;=96116^^98^975^8^^^^1
 ;;^UTILITY(U,$J,358.3,20675,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20675,1,2,0)
 ;;=2^96116
 ;;^UTILITY(U,$J,358.3,20675,1,3,0)
 ;;=3^Neurobehavioral Status Exam
 ;;^UTILITY(U,$J,358.3,20676,0)
 ;;=G0396^^98^975^1^^^^1
 ;;^UTILITY(U,$J,358.3,20676,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20676,1,2,0)
 ;;=2^G0396
 ;;^UTILITY(U,$J,358.3,20676,1,3,0)
 ;;=3^Alc/Drug Abuse Assm,Brief Intvn 15-30min
 ;;^UTILITY(U,$J,358.3,20677,0)
 ;;=G0397^^98^975^2^^^^1
 ;;^UTILITY(U,$J,358.3,20677,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20677,1,2,0)
 ;;=2^G0397
 ;;^UTILITY(U,$J,358.3,20677,1,3,0)
 ;;=3^Alc/Drug Abuse Assm,Brief Intvn > 30min
 ;;^UTILITY(U,$J,358.3,20678,0)
 ;;=G0409^^98^975^17^^^^1
 ;;^UTILITY(U,$J,358.3,20678,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20678,1,2,0)
 ;;=2^G0409
 ;;^UTILITY(U,$J,358.3,20678,1,3,0)
 ;;=3^SW & Psych Svcs R/T Pt rehab goals,ea 15min
 ;;^UTILITY(U,$J,358.3,20679,0)
 ;;=G0410^^98^975^6^^^^1
 ;;^UTILITY(U,$J,358.3,20679,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20679,1,2,0)
 ;;=2^G0410
 ;;^UTILITY(U,$J,358.3,20679,1,3,0)
 ;;=3^Group Psychtx,Partial Hosp Setting 45-50min
 ;;^UTILITY(U,$J,358.3,20680,0)
 ;;=S9453^^98^975^19^^^^1
 ;;^UTILITY(U,$J,358.3,20680,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20680,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,20680,1,3,0)
 ;;=3^Smoking Cessation Class
 ;;^UTILITY(U,$J,358.3,20681,0)
 ;;=G0436^^98^975^23^^^^1
 ;;^UTILITY(U,$J,358.3,20681,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20681,1,2,0)
 ;;=2^G0436
 ;;^UTILITY(U,$J,358.3,20681,1,3,0)
 ;;=3^Tob/Smoking Cess Counsel Asymp Pt,3-10min
 ;;^UTILITY(U,$J,358.3,20682,0)
 ;;=G0437^^98^975^22^^^^1
