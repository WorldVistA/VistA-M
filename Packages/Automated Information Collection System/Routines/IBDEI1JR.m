IBDEI1JR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24728,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,24728,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,24728,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,24729,0)
 ;;=I34.1^^107^1210^14
 ;;^UTILITY(U,$J,358.3,24729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24729,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,24729,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,24729,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,24730,0)
 ;;=D68.4^^107^1211^1
 ;;^UTILITY(U,$J,358.3,24730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24730,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,24730,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,24730,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,24731,0)
 ;;=D59.9^^107^1211^2
 ;;^UTILITY(U,$J,358.3,24731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24731,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,24731,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,24731,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,24732,0)
 ;;=C91.00^^107^1211^5
 ;;^UTILITY(U,$J,358.3,24732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24732,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,24732,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,24732,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,24733,0)
 ;;=C91.01^^107^1211^4
 ;;^UTILITY(U,$J,358.3,24733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24733,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,24733,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,24733,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,24734,0)
 ;;=C92.01^^107^1211^7
 ;;^UTILITY(U,$J,358.3,24734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24734,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,24734,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,24734,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,24735,0)
 ;;=C92.00^^107^1211^8
 ;;^UTILITY(U,$J,358.3,24735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24735,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,24735,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,24735,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,24736,0)
 ;;=C92.61^^107^1211^9
 ;;^UTILITY(U,$J,358.3,24736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24736,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,24736,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,24736,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,24737,0)
 ;;=C92.60^^107^1211^10
 ;;^UTILITY(U,$J,358.3,24737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24737,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,24737,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,24737,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,24738,0)
 ;;=C92.A1^^107^1211^11
 ;;^UTILITY(U,$J,358.3,24738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24738,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,24738,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,24738,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,24739,0)
 ;;=C92.A0^^107^1211^12
 ;;^UTILITY(U,$J,358.3,24739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24739,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,24739,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,24739,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,24740,0)
 ;;=C92.51^^107^1211^13
