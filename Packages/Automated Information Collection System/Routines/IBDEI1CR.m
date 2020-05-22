IBDEI1CR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21612,1,3,0)
 ;;=3^Panic disorder w/o agoraphobia [episodic paroxysmal anxiety]
 ;;^UTILITY(U,$J,358.3,21612,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,21612,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,21613,0)
 ;;=F41.1^^99^1098^3
 ;;^UTILITY(U,$J,358.3,21613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21613,1,3,0)
 ;;=3^Anxiety disorder, generalized
 ;;^UTILITY(U,$J,358.3,21613,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,21613,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,21614,0)
 ;;=F40.01^^99^1098^1
 ;;^UTILITY(U,$J,358.3,21614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21614,1,3,0)
 ;;=3^Agoraphobia w/ panic disorder
 ;;^UTILITY(U,$J,358.3,21614,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,21614,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,21615,0)
 ;;=F40.02^^99^1098^2
 ;;^UTILITY(U,$J,358.3,21615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21615,1,3,0)
 ;;=3^Agoraphobia w/o panic disorder
 ;;^UTILITY(U,$J,358.3,21615,1,4,0)
 ;;=4^F40.02
 ;;^UTILITY(U,$J,358.3,21615,2)
 ;;=^5003543
 ;;^UTILITY(U,$J,358.3,21616,0)
 ;;=F43.10^^99^1098^9
 ;;^UTILITY(U,$J,358.3,21616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21616,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspec
 ;;^UTILITY(U,$J,358.3,21616,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,21616,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,21617,0)
 ;;=F43.12^^99^1098^8
 ;;^UTILITY(U,$J,358.3,21617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21617,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,21617,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,21617,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,21618,0)
 ;;=F42.8^^99^1098^5
 ;;^UTILITY(U,$J,358.3,21618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21618,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder,Other
 ;;^UTILITY(U,$J,358.3,21618,1,4,0)
 ;;=4^F42.8
 ;;^UTILITY(U,$J,358.3,21618,2)
 ;;=^5138447
 ;;^UTILITY(U,$J,358.3,21619,0)
 ;;=F42.9^^99^1098^6
 ;;^UTILITY(U,$J,358.3,21619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21619,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21619,1,4,0)
 ;;=4^F42.9
 ;;^UTILITY(U,$J,358.3,21619,2)
 ;;=^5138448
 ;;^UTILITY(U,$J,358.3,21620,0)
 ;;=E53.8^^99^1099^1
 ;;^UTILITY(U,$J,358.3,21620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21620,1,3,0)
 ;;=3^B Vitamin Deficiency
 ;;^UTILITY(U,$J,358.3,21620,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,21620,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,21621,0)
 ;;=R00.1^^99^1099^10
 ;;^UTILITY(U,$J,358.3,21621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21621,1,3,0)
 ;;=3^Bradycardia, unspec
 ;;^UTILITY(U,$J,358.3,21621,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,21621,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,21622,0)
 ;;=J20.9^^99^1099^11
 ;;^UTILITY(U,$J,358.3,21622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21622,1,3,0)
 ;;=3^Bronchitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,21622,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,21622,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,21623,0)
 ;;=N32.0^^99^1099^9
 ;;^UTILITY(U,$J,358.3,21623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21623,1,3,0)
 ;;=3^Bladder-neck obstruction
 ;;^UTILITY(U,$J,358.3,21623,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,21623,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,21624,0)
 ;;=N40.0^^99^1099^3
 ;;^UTILITY(U,$J,358.3,21624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21624,1,3,0)
 ;;=3^BPH w/o lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,21624,1,4,0)
 ;;=4^N40.0
