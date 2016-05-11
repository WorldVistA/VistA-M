IBDEI1BB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22313,0)
 ;;=I49.5^^87^980^23
 ;;^UTILITY(U,$J,358.3,22313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22313,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,22313,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,22313,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,22314,0)
 ;;=I49.8^^87^980^3
 ;;^UTILITY(U,$J,358.3,22314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22314,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,22314,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,22314,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,22315,0)
 ;;=I49.9^^87^980^2
 ;;^UTILITY(U,$J,358.3,22315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22315,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,22315,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,22315,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,22316,0)
 ;;=R00.1^^87^980^1
 ;;^UTILITY(U,$J,358.3,22316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22316,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,22316,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,22316,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,22317,0)
 ;;=I34.1^^87^980^14
 ;;^UTILITY(U,$J,358.3,22317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22317,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,22317,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,22317,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,22318,0)
 ;;=D68.4^^87^981^1
 ;;^UTILITY(U,$J,358.3,22318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22318,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,22318,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,22318,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,22319,0)
 ;;=D59.9^^87^981^2
 ;;^UTILITY(U,$J,358.3,22319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22319,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,22319,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,22319,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,22320,0)
 ;;=C91.00^^87^981^5
 ;;^UTILITY(U,$J,358.3,22320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22320,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22320,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,22320,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,22321,0)
 ;;=C91.01^^87^981^4
 ;;^UTILITY(U,$J,358.3,22321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22321,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,22321,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,22321,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,22322,0)
 ;;=C92.01^^87^981^7
 ;;^UTILITY(U,$J,358.3,22322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22322,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,22322,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,22322,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,22323,0)
 ;;=C92.00^^87^981^8
 ;;^UTILITY(U,$J,358.3,22323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22323,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22323,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,22323,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,22324,0)
 ;;=C92.61^^87^981^9
 ;;^UTILITY(U,$J,358.3,22324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22324,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,22324,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,22324,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,22325,0)
 ;;=C92.60^^87^981^10
 ;;^UTILITY(U,$J,358.3,22325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22325,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,22325,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,22325,2)
 ;;=^5001807
