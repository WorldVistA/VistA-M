IBDEI0WJ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15264,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,15264,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,15265,0)
 ;;=90887^^57^652^7^^^^1
 ;;^UTILITY(U,$J,358.3,15265,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15265,1,2,0)
 ;;=2^90887
 ;;^UTILITY(U,$J,358.3,15265,1,3,0)
 ;;=3^Consult w/ Family,Interp/Expl Exam/Test Results
 ;;^UTILITY(U,$J,358.3,15266,0)
 ;;=90889^^57^652^19^^^^1
 ;;^UTILITY(U,$J,358.3,15266,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15266,1,2,0)
 ;;=2^90889
 ;;^UTILITY(U,$J,358.3,15266,1,3,0)
 ;;=3^Preparation of Report for Indiv/Agency/Insurance
 ;;^UTILITY(U,$J,358.3,15267,0)
 ;;=96118^^57^652^16^^^^1
 ;;^UTILITY(U,$J,358.3,15267,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15267,1,2,0)
 ;;=2^96118
 ;;^UTILITY(U,$J,358.3,15267,1,3,0)
 ;;=3^Neuropsych Tst admin by PhD/MD,per hr
 ;;^UTILITY(U,$J,358.3,15268,0)
 ;;=97150^^57^652^13^^^^1
 ;;^UTILITY(U,$J,358.3,15268,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15268,1,2,0)
 ;;=2^97150
 ;;^UTILITY(U,$J,358.3,15268,1,3,0)
 ;;=3^Group Therapeutic Procedures
 ;;^UTILITY(U,$J,358.3,15269,0)
 ;;=G0177^^57^652^32^^^^1
 ;;^UTILITY(U,$J,358.3,15269,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15269,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,15269,1,3,0)
 ;;=3^Train & Ed for Disabiling MH Problem 45+ min
 ;;^UTILITY(U,$J,358.3,15270,0)
 ;;=96116^^57^652^14^^^^1
 ;;^UTILITY(U,$J,358.3,15270,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15270,1,2,0)
 ;;=2^96116
 ;;^UTILITY(U,$J,358.3,15270,1,3,0)
 ;;=3^Neurobehavioral Status Exam by PhD/MD,per hr
 ;;^UTILITY(U,$J,358.3,15271,0)
 ;;=G0396^^57^652^1^^^^1
 ;;^UTILITY(U,$J,358.3,15271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15271,1,2,0)
 ;;=2^G0396
 ;;^UTILITY(U,$J,358.3,15271,1,3,0)
 ;;=3^Alc/Drug Abuse Assm,Brief Intvn 15-30min
 ;;^UTILITY(U,$J,358.3,15272,0)
 ;;=G0397^^57^652^2^^^^1
 ;;^UTILITY(U,$J,358.3,15272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15272,1,2,0)
 ;;=2^G0397
 ;;^UTILITY(U,$J,358.3,15272,1,3,0)
 ;;=3^Alc/Drug Abuse Assm,Brief Intvn > 30min
 ;;^UTILITY(U,$J,358.3,15273,0)
 ;;=G0409^^57^652^25^^^^1
 ;;^UTILITY(U,$J,358.3,15273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15273,1,2,0)
 ;;=2^G0409
 ;;^UTILITY(U,$J,358.3,15273,1,3,0)
 ;;=3^SW & Psych Svcs R/T Pt rehab goals,ea 15min
 ;;^UTILITY(U,$J,358.3,15274,0)
 ;;=G0410^^57^652^12^^^^1
 ;;^UTILITY(U,$J,358.3,15274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15274,1,2,0)
 ;;=2^G0410
 ;;^UTILITY(U,$J,358.3,15274,1,3,0)
 ;;=3^Group Psychtx,Partial Hosp Setting 45-50min
 ;;^UTILITY(U,$J,358.3,15275,0)
 ;;=S9453^^57^652^27^^^^1
 ;;^UTILITY(U,$J,358.3,15275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15275,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,15275,1,3,0)
 ;;=3^Smoking Cessation Class per session
 ;;^UTILITY(U,$J,358.3,15276,0)
 ;;=G0436^^57^652^31^^^^1
 ;;^UTILITY(U,$J,358.3,15276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15276,1,2,0)
 ;;=2^G0436
 ;;^UTILITY(U,$J,358.3,15276,1,3,0)
 ;;=3^Tob/Smoking Cess Counsel Asymp Pt,3-10min
 ;;^UTILITY(U,$J,358.3,15277,0)
 ;;=G0437^^57^652^30^^^^1
 ;;^UTILITY(U,$J,358.3,15277,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15277,1,2,0)
 ;;=2^G0437
 ;;^UTILITY(U,$J,358.3,15277,1,3,0)
 ;;=3^Tob/Smoking Cess Counsel Asymp Pt > 10min
 ;;^UTILITY(U,$J,358.3,15278,0)
 ;;=96101^^57^652^20^^^^1
 ;;^UTILITY(U,$J,358.3,15278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15278,1,2,0)
 ;;=2^96101
 ;;^UTILITY(U,$J,358.3,15278,1,3,0)
 ;;=3^Psych Test by Psychologist,per hr
 ;;^UTILITY(U,$J,358.3,15279,0)
 ;;=96105^^57^652^3^^^^1
 ;;^UTILITY(U,$J,358.3,15279,1,0)
 ;;=^358.31IA^3^2
