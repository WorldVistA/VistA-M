IBDEI07G ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7366,1,3,0)
 ;;=3^Chronic Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,7366,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,7366,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,7367,0)
 ;;=N18.6^^42^494^32
 ;;^UTILITY(U,$J,358.3,7367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7367,1,3,0)
 ;;=3^End Stage Renal Disease (ESRD)
 ;;^UTILITY(U,$J,358.3,7367,1,4,0)
 ;;=4^N18.6
 ;;^UTILITY(U,$J,358.3,7367,2)
 ;;=^303986
 ;;^UTILITY(U,$J,358.3,7368,0)
 ;;=N52.9^^42^494^48
 ;;^UTILITY(U,$J,358.3,7368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7368,1,3,0)
 ;;=3^Erectile Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,7368,1,4,0)
 ;;=4^N52.9
 ;;^UTILITY(U,$J,358.3,7368,2)
 ;;=^5015763
 ;;^UTILITY(U,$J,358.3,7369,0)
 ;;=N32.81^^42^494^81
 ;;^UTILITY(U,$J,358.3,7369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7369,1,3,0)
 ;;=3^Overactive Bladder
 ;;^UTILITY(U,$J,358.3,7369,1,4,0)
 ;;=4^N32.81
 ;;^UTILITY(U,$J,358.3,7369,2)
 ;;=^5015652
 ;;^UTILITY(U,$J,358.3,7370,0)
 ;;=Q61.2^^42^494^85
 ;;^UTILITY(U,$J,358.3,7370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7370,1,3,0)
 ;;=3^Polycystic Kidney,Adult Type
 ;;^UTILITY(U,$J,358.3,7370,1,4,0)
 ;;=4^Q61.2
 ;;^UTILITY(U,$J,358.3,7370,2)
 ;;=^5018796
 ;;^UTILITY(U,$J,358.3,7371,0)
 ;;=N41.1^^42^494^89
 ;;^UTILITY(U,$J,358.3,7371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7371,1,3,0)
 ;;=3^Prostatitis,Chronic
 ;;^UTILITY(U,$J,358.3,7371,1,4,0)
 ;;=4^N41.1
 ;;^UTILITY(U,$J,358.3,7371,2)
 ;;=^186931
 ;;^UTILITY(U,$J,358.3,7372,0)
 ;;=N11.9^^42^494^97
 ;;^UTILITY(U,$J,358.3,7372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7372,1,3,0)
 ;;=3^Pyelonephritis,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,7372,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,7372,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,7373,0)
 ;;=N20.9^^42^494^108
 ;;^UTILITY(U,$J,358.3,7373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7373,1,3,0)
 ;;=3^Urinary Calculus,Unspec
 ;;^UTILITY(U,$J,358.3,7373,1,4,0)
 ;;=4^N20.9
 ;;^UTILITY(U,$J,358.3,7373,2)
 ;;=^5015610
 ;;^UTILITY(U,$J,358.3,7374,0)
 ;;=N30.81^^42^494^22
 ;;^UTILITY(U,$J,358.3,7374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7374,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Other
 ;;^UTILITY(U,$J,358.3,7374,1,4,0)
 ;;=4^N30.81
 ;;^UTILITY(U,$J,358.3,7374,2)
 ;;=^5134089
 ;;^UTILITY(U,$J,358.3,7375,0)
 ;;=N30.21^^42^494^23
 ;;^UTILITY(U,$J,358.3,7375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7375,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Other,Chronic
 ;;^UTILITY(U,$J,358.3,7375,1,4,0)
 ;;=4^N30.21
 ;;^UTILITY(U,$J,358.3,7375,2)
 ;;=^5134088
 ;;^UTILITY(U,$J,358.3,7376,0)
 ;;=N30.20^^42^494^27
 ;;^UTILITY(U,$J,358.3,7376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7376,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Other,Chronic
 ;;^UTILITY(U,$J,358.3,7376,1,4,0)
 ;;=4^N30.20
 ;;^UTILITY(U,$J,358.3,7376,2)
 ;;=^5015636
 ;;^UTILITY(U,$J,358.3,7377,0)
 ;;=N30.80^^42^494^26
 ;;^UTILITY(U,$J,358.3,7377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7377,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Other
 ;;^UTILITY(U,$J,358.3,7377,1,4,0)
 ;;=4^N30.80
 ;;^UTILITY(U,$J,358.3,7377,2)
 ;;=^5015641
 ;;^UTILITY(U,$J,358.3,7378,0)
 ;;=N30.10^^42^494^64
 ;;^UTILITY(U,$J,358.3,7378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7378,1,3,0)
 ;;=3^Interstitial Cystitis,Chr,w/o Hematuria
 ;;^UTILITY(U,$J,358.3,7378,1,4,0)
 ;;=4^N30.10
 ;;^UTILITY(U,$J,358.3,7378,2)
 ;;=^5015634
 ;;^UTILITY(U,$J,358.3,7379,0)
 ;;=N30.11^^42^494^63
 ;;^UTILITY(U,$J,358.3,7379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7379,1,3,0)
 ;;=3^Interstitial Cystitis,Chr,w/ Hematuria
 ;;^UTILITY(U,$J,358.3,7379,1,4,0)
 ;;=4^N30.11
 ;;^UTILITY(U,$J,358.3,7379,2)
 ;;=^5015635
 ;;^UTILITY(U,$J,358.3,7380,0)
 ;;=R51.^^42^495^2
 ;;^UTILITY(U,$J,358.3,7380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7380,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,7380,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,7380,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,7381,0)
 ;;=G44.1^^42^495^9
 ;;^UTILITY(U,$J,358.3,7381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7381,1,3,0)
 ;;=3^Vascular Headache NEC
 ;;^UTILITY(U,$J,358.3,7381,1,4,0)
 ;;=4^G44.1
 ;;^UTILITY(U,$J,358.3,7381,2)
 ;;=^5003934
 ;;^UTILITY(U,$J,358.3,7382,0)
 ;;=G43.909^^42^495^5
 ;;^UTILITY(U,$J,358.3,7382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7382,1,3,0)
 ;;=3^Migraine,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,7382,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,7382,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,7383,0)
 ;;=G44.009^^42^495^1
 ;;^UTILITY(U,$J,358.3,7383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7383,1,3,0)
 ;;=3^Cluster Headache,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,7383,1,4,0)
 ;;=4^G44.009
 ;;^UTILITY(U,$J,358.3,7383,2)
 ;;=^5003921
 ;;^UTILITY(U,$J,358.3,7384,0)
 ;;=G44.40^^42^495^4
 ;;^UTILITY(U,$J,358.3,7384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7384,1,3,0)
 ;;=3^Medication Overuse Headache,Not Intractable
 ;;^UTILITY(U,$J,358.3,7384,1,4,0)
 ;;=4^G44.40
 ;;^UTILITY(U,$J,358.3,7384,2)
 ;;=^5003947
 ;;^UTILITY(U,$J,358.3,7385,0)
 ;;=G44.89^^42^495^3
 ;;^UTILITY(U,$J,358.3,7385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7385,1,3,0)
 ;;=3^Headache Syndrome NEC
 ;;^UTILITY(U,$J,358.3,7385,1,4,0)
 ;;=4^G44.89
 ;;^UTILITY(U,$J,358.3,7385,2)
 ;;=^5003954
 ;;^UTILITY(U,$J,358.3,7386,0)
 ;;=G44.84^^42^495^7
 ;;^UTILITY(U,$J,358.3,7386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7386,1,3,0)
 ;;=3^Primary Exertional Headache
 ;;^UTILITY(U,$J,358.3,7386,1,4,0)
 ;;=4^G44.84
 ;;^UTILITY(U,$J,358.3,7386,2)
 ;;=^336563
 ;;^UTILITY(U,$J,358.3,7387,0)
 ;;=G44.301^^42^495^6
 ;;^UTILITY(U,$J,358.3,7387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7387,1,3,0)
 ;;=3^Post-Traumatic Headache,Unspec,Intractable
 ;;^UTILITY(U,$J,358.3,7387,1,4,0)
 ;;=4^G44.301
 ;;^UTILITY(U,$J,358.3,7387,2)
 ;;=^5003941
 ;;^UTILITY(U,$J,358.3,7388,0)
 ;;=G44.209^^42^495^8
 ;;^UTILITY(U,$J,358.3,7388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7388,1,3,0)
 ;;=3^Tension-Type Headache,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,7388,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,7388,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,7389,0)
 ;;=I50.32^^42^496^5
 ;;^UTILITY(U,$J,358.3,7389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7389,1,3,0)
 ;;=3^Diastolic Heart Failure,Chronic
 ;;^UTILITY(U,$J,358.3,7389,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,7389,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,7390,0)
 ;;=I50.33^^42^496^4
 ;;^UTILITY(U,$J,358.3,7390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7390,1,3,0)
 ;;=3^Diastolic Heart Failure,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,7390,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,7390,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,7391,0)
 ;;=I50.40^^42^496^9
 ;;^UTILITY(U,$J,358.3,7391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7391,1,3,0)
 ;;=3^Systolic & Diastolic Congestive Heart Failure,Combined Unspec
 ;;^UTILITY(U,$J,358.3,7391,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,7391,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,7392,0)
 ;;=I51.7^^42^496^2
 ;;^UTILITY(U,$J,358.3,7392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7392,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,7392,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,7392,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,7393,0)
 ;;=I42.6^^42^496^1
 ;;^UTILITY(U,$J,358.3,7393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7393,1,3,0)
 ;;=3^Alcoholic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,7393,1,4,0)
 ;;=4^I42.6
 ;;^UTILITY(U,$J,358.3,7393,2)
 ;;=^5007197
 ;;^UTILITY(U,$J,358.3,7394,0)
 ;;=I50.1^^42^496^8
 ;;^UTILITY(U,$J,358.3,7394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7394,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,7394,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,7394,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,7395,0)
 ;;=I50.20^^42^496^13
 ;;^UTILITY(U,$J,358.3,7395,1,0)
 ;;=^358.31IA^4^2
