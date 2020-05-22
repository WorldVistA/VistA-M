IBDEI2H8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39551,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,39552,0)
 ;;=I49.9^^152^1999^2
 ;;^UTILITY(U,$J,358.3,39552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39552,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,39552,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,39552,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,39553,0)
 ;;=R00.1^^152^1999^1
 ;;^UTILITY(U,$J,358.3,39553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39553,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,39553,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,39553,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,39554,0)
 ;;=I34.1^^152^1999^14
 ;;^UTILITY(U,$J,358.3,39554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39554,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,39554,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,39554,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,39555,0)
 ;;=D68.4^^152^2000^1
 ;;^UTILITY(U,$J,358.3,39555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39555,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,39555,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,39555,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,39556,0)
 ;;=D59.9^^152^2000^2
 ;;^UTILITY(U,$J,358.3,39556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39556,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,39556,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,39556,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,39557,0)
 ;;=C91.00^^152^2000^5
 ;;^UTILITY(U,$J,358.3,39557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39557,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,39557,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,39557,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,39558,0)
 ;;=C91.01^^152^2000^4
 ;;^UTILITY(U,$J,358.3,39558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39558,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,39558,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,39558,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,39559,0)
 ;;=C92.01^^152^2000^7
 ;;^UTILITY(U,$J,358.3,39559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39559,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,39559,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,39559,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,39560,0)
 ;;=C92.00^^152^2000^8
 ;;^UTILITY(U,$J,358.3,39560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39560,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,39560,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,39560,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,39561,0)
 ;;=C92.61^^152^2000^9
 ;;^UTILITY(U,$J,358.3,39561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39561,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,39561,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,39561,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,39562,0)
 ;;=C92.60^^152^2000^10
 ;;^UTILITY(U,$J,358.3,39562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39562,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,39562,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,39562,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,39563,0)
 ;;=C92.A1^^152^2000^11
 ;;^UTILITY(U,$J,358.3,39563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39563,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,39563,1,4,0)
 ;;=4^C92.A1
