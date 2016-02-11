IBDEI2N5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44325,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,44325,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,44325,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,44326,0)
 ;;=R00.1^^200^2227^1
 ;;^UTILITY(U,$J,358.3,44326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44326,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,44326,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,44326,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,44327,0)
 ;;=I34.1^^200^2227^14
 ;;^UTILITY(U,$J,358.3,44327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44327,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,44327,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,44327,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,44328,0)
 ;;=D68.4^^200^2228^1
 ;;^UTILITY(U,$J,358.3,44328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44328,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,44328,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,44328,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,44329,0)
 ;;=D59.9^^200^2228^2
 ;;^UTILITY(U,$J,358.3,44329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44329,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,44329,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,44329,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,44330,0)
 ;;=C91.00^^200^2228^5
 ;;^UTILITY(U,$J,358.3,44330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44330,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,44330,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,44330,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,44331,0)
 ;;=C91.01^^200^2228^4
 ;;^UTILITY(U,$J,358.3,44331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44331,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,44331,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,44331,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,44332,0)
 ;;=C92.01^^200^2228^7
 ;;^UTILITY(U,$J,358.3,44332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44332,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,44332,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,44332,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,44333,0)
 ;;=C92.00^^200^2228^8
 ;;^UTILITY(U,$J,358.3,44333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44333,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,44333,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,44333,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,44334,0)
 ;;=C92.61^^200^2228^9
 ;;^UTILITY(U,$J,358.3,44334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44334,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,44334,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,44334,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,44335,0)
 ;;=C92.60^^200^2228^10
 ;;^UTILITY(U,$J,358.3,44335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44335,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,44335,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,44335,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,44336,0)
 ;;=C92.A1^^200^2228^11
 ;;^UTILITY(U,$J,358.3,44336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44336,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,44336,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,44336,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,44337,0)
 ;;=C92.A0^^200^2228^12
 ;;^UTILITY(U,$J,358.3,44337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44337,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
