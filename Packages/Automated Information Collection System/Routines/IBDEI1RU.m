IBDEI1RU ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31668,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,31669,0)
 ;;=I49.9^^190^1942^2
 ;;^UTILITY(U,$J,358.3,31669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31669,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,31669,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,31669,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,31670,0)
 ;;=R00.1^^190^1942^1
 ;;^UTILITY(U,$J,358.3,31670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31670,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,31670,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,31670,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,31671,0)
 ;;=D68.4^^190^1943^1
 ;;^UTILITY(U,$J,358.3,31671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31671,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,31671,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,31671,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,31672,0)
 ;;=D59.9^^190^1943^2
 ;;^UTILITY(U,$J,358.3,31672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31672,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,31672,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,31672,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,31673,0)
 ;;=C91.00^^190^1943^4
 ;;^UTILITY(U,$J,358.3,31673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31673,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,31673,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,31673,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,31674,0)
 ;;=C91.01^^190^1943^3
 ;;^UTILITY(U,$J,358.3,31674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31674,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,31674,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,31674,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,31675,0)
 ;;=C92.01^^190^1943^5
 ;;^UTILITY(U,$J,358.3,31675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31675,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,31675,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,31675,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,31676,0)
 ;;=C92.00^^190^1943^6
 ;;^UTILITY(U,$J,358.3,31676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31676,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,31676,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,31676,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,31677,0)
 ;;=C92.61^^190^1943^7
 ;;^UTILITY(U,$J,358.3,31677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31677,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,31677,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,31677,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,31678,0)
 ;;=C92.60^^190^1943^8
 ;;^UTILITY(U,$J,358.3,31678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31678,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,31678,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,31678,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,31679,0)
 ;;=C92.A1^^190^1943^9
 ;;^UTILITY(U,$J,358.3,31679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31679,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,31679,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,31679,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,31680,0)
 ;;=C92.A0^^190^1943^10
 ;;^UTILITY(U,$J,358.3,31680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31680,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,31680,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,31680,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,31681,0)
 ;;=C92.51^^190^1943^11
 ;;^UTILITY(U,$J,358.3,31681,1,0)
 ;;=^358.31IA^4^2
