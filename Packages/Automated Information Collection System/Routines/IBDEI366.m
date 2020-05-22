IBDEI366 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50611,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,50612,0)
 ;;=I49.9^^193^2496^2
 ;;^UTILITY(U,$J,358.3,50612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50612,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,50612,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,50612,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,50613,0)
 ;;=R00.1^^193^2496^1
 ;;^UTILITY(U,$J,358.3,50613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50613,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,50613,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,50613,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,50614,0)
 ;;=I34.1^^193^2496^14
 ;;^UTILITY(U,$J,358.3,50614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50614,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,50614,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,50614,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,50615,0)
 ;;=D68.4^^193^2497^1
 ;;^UTILITY(U,$J,358.3,50615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50615,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,50615,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,50615,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,50616,0)
 ;;=D59.9^^193^2497^2
 ;;^UTILITY(U,$J,358.3,50616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50616,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,50616,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,50616,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,50617,0)
 ;;=C91.00^^193^2497^5
 ;;^UTILITY(U,$J,358.3,50617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50617,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,50617,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,50617,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,50618,0)
 ;;=C91.01^^193^2497^4
 ;;^UTILITY(U,$J,358.3,50618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50618,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,50618,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,50618,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,50619,0)
 ;;=C92.01^^193^2497^7
 ;;^UTILITY(U,$J,358.3,50619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50619,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,50619,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,50619,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,50620,0)
 ;;=C92.00^^193^2497^8
 ;;^UTILITY(U,$J,358.3,50620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50620,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,50620,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,50620,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,50621,0)
 ;;=C92.61^^193^2497^9
 ;;^UTILITY(U,$J,358.3,50621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50621,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,50621,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,50621,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,50622,0)
 ;;=C92.60^^193^2497^10
 ;;^UTILITY(U,$J,358.3,50622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50622,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,50622,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,50622,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,50623,0)
 ;;=C92.A1^^193^2497^11
 ;;^UTILITY(U,$J,358.3,50623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50623,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,50623,1,4,0)
 ;;=4^C92.A1
