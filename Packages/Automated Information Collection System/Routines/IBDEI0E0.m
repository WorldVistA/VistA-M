IBDEI0E0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6439,1,3,0)
 ;;=3^Post-Traumatic Headache,Unspec,Intractable
 ;;^UTILITY(U,$J,358.3,6439,1,4,0)
 ;;=4^G44.301
 ;;^UTILITY(U,$J,358.3,6439,2)
 ;;=^5003941
 ;;^UTILITY(U,$J,358.3,6440,0)
 ;;=G44.209^^30^393^8
 ;;^UTILITY(U,$J,358.3,6440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6440,1,3,0)
 ;;=3^Tension-Type Headache,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,6440,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,6440,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,6441,0)
 ;;=I50.32^^30^394^5
 ;;^UTILITY(U,$J,358.3,6441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6441,1,3,0)
 ;;=3^Diastolic Heart Failure,Chronic
 ;;^UTILITY(U,$J,358.3,6441,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,6441,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,6442,0)
 ;;=I50.33^^30^394^4
 ;;^UTILITY(U,$J,358.3,6442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6442,1,3,0)
 ;;=3^Diastolic Heart Failure,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6442,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,6442,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,6443,0)
 ;;=I50.40^^30^394^9
 ;;^UTILITY(U,$J,358.3,6443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6443,1,3,0)
 ;;=3^Systolic & Diastolic Congestive Heart Failure,Combined Unspec
 ;;^UTILITY(U,$J,358.3,6443,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,6443,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,6444,0)
 ;;=I51.7^^30^394^2
 ;;^UTILITY(U,$J,358.3,6444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6444,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,6444,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,6444,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,6445,0)
 ;;=I42.6^^30^394^1
 ;;^UTILITY(U,$J,358.3,6445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6445,1,3,0)
 ;;=3^Alcoholic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,6445,1,4,0)
 ;;=4^I42.6
 ;;^UTILITY(U,$J,358.3,6445,2)
 ;;=^5007197
 ;;^UTILITY(U,$J,358.3,6446,0)
 ;;=I50.1^^30^394^8
 ;;^UTILITY(U,$J,358.3,6446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6446,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,6446,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,6446,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,6447,0)
 ;;=I50.20^^30^394^13
 ;;^UTILITY(U,$J,358.3,6447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6447,1,3,0)
 ;;=3^Systolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,6447,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,6447,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,6448,0)
 ;;=I50.21^^30^394^10
 ;;^UTILITY(U,$J,358.3,6448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6448,1,3,0)
 ;;=3^Systolic Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,6448,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,6448,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,6449,0)
 ;;=I50.22^^30^394^12
 ;;^UTILITY(U,$J,358.3,6449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6449,1,3,0)
 ;;=3^Systolic Heart Failure,Chronic
 ;;^UTILITY(U,$J,358.3,6449,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,6449,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,6450,0)
 ;;=I50.23^^30^394^11
 ;;^UTILITY(U,$J,358.3,6450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6450,1,3,0)
 ;;=3^Systolic Heart Failure,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6450,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,6450,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,6451,0)
 ;;=I50.30^^30^394^6
 ;;^UTILITY(U,$J,358.3,6451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6451,1,3,0)
 ;;=3^Diastolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,6451,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,6451,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,6452,0)
 ;;=I50.9^^30^394^7
 ;;^UTILITY(U,$J,358.3,6452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6452,1,3,0)
 ;;=3^Heart Failure,Unspec (CHF Unspec)
