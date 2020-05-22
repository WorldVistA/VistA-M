IBDEI10U ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16424,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,16425,0)
 ;;=I49.9^^88^878^2
 ;;^UTILITY(U,$J,358.3,16425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16425,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,16425,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,16425,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,16426,0)
 ;;=R00.1^^88^878^1
 ;;^UTILITY(U,$J,358.3,16426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16426,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,16426,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,16426,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,16427,0)
 ;;=I34.1^^88^878^14
 ;;^UTILITY(U,$J,358.3,16427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16427,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,16427,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,16427,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,16428,0)
 ;;=D68.4^^88^879^1
 ;;^UTILITY(U,$J,358.3,16428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16428,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,16428,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,16428,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,16429,0)
 ;;=D59.9^^88^879^2
 ;;^UTILITY(U,$J,358.3,16429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16429,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,16429,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,16429,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,16430,0)
 ;;=C91.00^^88^879^5
 ;;^UTILITY(U,$J,358.3,16430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16430,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,16430,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,16430,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,16431,0)
 ;;=C91.01^^88^879^4
 ;;^UTILITY(U,$J,358.3,16431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16431,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,16431,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,16431,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,16432,0)
 ;;=C92.01^^88^879^7
 ;;^UTILITY(U,$J,358.3,16432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16432,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,16432,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,16432,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,16433,0)
 ;;=C92.00^^88^879^8
 ;;^UTILITY(U,$J,358.3,16433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16433,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,16433,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,16433,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,16434,0)
 ;;=C92.61^^88^879^9
 ;;^UTILITY(U,$J,358.3,16434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16434,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,16434,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,16434,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,16435,0)
 ;;=C92.60^^88^879^10
 ;;^UTILITY(U,$J,358.3,16435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16435,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,16435,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,16435,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,16436,0)
 ;;=C92.A1^^88^879^11
 ;;^UTILITY(U,$J,358.3,16436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16436,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,16436,1,4,0)
 ;;=4^C92.A1
