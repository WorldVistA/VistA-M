IBDEI0IA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8205,0)
 ;;=K73.9^^55^536^23
 ;;^UTILITY(U,$J,358.3,8205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8205,1,3,0)
 ;;=3^Chronic hepatitis, unspecified
 ;;^UTILITY(U,$J,358.3,8205,1,4,0)
 ;;=4^K73.9
 ;;^UTILITY(U,$J,358.3,8205,2)
 ;;=^5008815
 ;;^UTILITY(U,$J,358.3,8206,0)
 ;;=K73.0^^55^536^25
 ;;^UTILITY(U,$J,358.3,8206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8206,1,3,0)
 ;;=3^Chronic persistent hepatitis, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,8206,1,4,0)
 ;;=4^K73.0
 ;;^UTILITY(U,$J,358.3,8206,2)
 ;;=^5008811
 ;;^UTILITY(U,$J,358.3,8207,0)
 ;;=K74.60^^55^536^30
 ;;^UTILITY(U,$J,358.3,8207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8207,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,8207,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,8207,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,8208,0)
 ;;=K74.0^^55^536^61
 ;;^UTILITY(U,$J,358.3,8208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8208,1,3,0)
 ;;=3^Hepatic fibrosis
 ;;^UTILITY(U,$J,358.3,8208,1,4,0)
 ;;=4^K74.0
 ;;^UTILITY(U,$J,358.3,8208,2)
 ;;=^5008816
 ;;^UTILITY(U,$J,358.3,8209,0)
 ;;=K76.0^^55^536^48
 ;;^UTILITY(U,$J,358.3,8209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8209,1,3,0)
 ;;=3^Fatty (change of) liver, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,8209,1,4,0)
 ;;=4^K76.0
 ;;^UTILITY(U,$J,358.3,8209,2)
 ;;=^5008831
 ;;^UTILITY(U,$J,358.3,8210,0)
 ;;=K75.9^^55^536^64
 ;;^UTILITY(U,$J,358.3,8210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8210,1,3,0)
 ;;=3^Inflammatory liver disease, unspecified
 ;;^UTILITY(U,$J,358.3,8210,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,8210,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,8211,0)
 ;;=K71.6^^55^536^95
 ;;^UTILITY(U,$J,358.3,8211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8211,1,3,0)
 ;;=3^Toxic liver disease with hepatitis, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,8211,1,4,0)
 ;;=4^K71.6
 ;;^UTILITY(U,$J,358.3,8211,2)
 ;;=^5008801
 ;;^UTILITY(U,$J,358.3,8212,0)
 ;;=K80.20^^55^536^16
 ;;^UTILITY(U,$J,358.3,8212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8212,1,3,0)
 ;;=3^Calculus of gallbladder w/o cholecystitis w/o obstruction
 ;;^UTILITY(U,$J,358.3,8212,1,4,0)
 ;;=4^K80.20
 ;;^UTILITY(U,$J,358.3,8212,2)
 ;;=^5008846
 ;;^UTILITY(U,$J,358.3,8213,0)
 ;;=K81.9^^55^536^20
 ;;^UTILITY(U,$J,358.3,8213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8213,1,3,0)
 ;;=3^Cholecystitis, unspecified
 ;;^UTILITY(U,$J,358.3,8213,1,4,0)
 ;;=4^K81.9
 ;;^UTILITY(U,$J,358.3,8213,2)
 ;;=^87388
 ;;^UTILITY(U,$J,358.3,8214,0)
 ;;=K85.9^^55^536^5
 ;;^UTILITY(U,$J,358.3,8214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8214,1,3,0)
 ;;=3^Acute pancreatitis, unspecified
 ;;^UTILITY(U,$J,358.3,8214,1,4,0)
 ;;=4^K85.9
 ;;^UTILITY(U,$J,358.3,8214,2)
 ;;=^5008887
 ;;^UTILITY(U,$J,358.3,8215,0)
 ;;=K86.1^^55^536^24
 ;;^UTILITY(U,$J,358.3,8215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8215,1,3,0)
 ;;=3^Chronic pancreatitis NEC
 ;;^UTILITY(U,$J,358.3,8215,1,4,0)
 ;;=4^K86.1
 ;;^UTILITY(U,$J,358.3,8215,2)
 ;;=^5008889
 ;;^UTILITY(U,$J,358.3,8216,0)
 ;;=K86.3^^55^536^86
 ;;^UTILITY(U,$J,358.3,8216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8216,1,3,0)
 ;;=3^Pseudocyst of pancreas
 ;;^UTILITY(U,$J,358.3,8216,1,4,0)
 ;;=4^K86.3
 ;;^UTILITY(U,$J,358.3,8216,2)
 ;;=^5008891
 ;;^UTILITY(U,$J,358.3,8217,0)
 ;;=K92.1^^55^536^74
 ;;^UTILITY(U,$J,358.3,8217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8217,1,3,0)
 ;;=3^Melena
 ;;^UTILITY(U,$J,358.3,8217,1,4,0)
 ;;=4^K92.1
 ;;^UTILITY(U,$J,358.3,8217,2)
 ;;=^5008914
 ;;^UTILITY(U,$J,358.3,8218,0)
 ;;=K92.2^^55^536^56
 ;;^UTILITY(U,$J,358.3,8218,1,0)
 ;;=^358.31IA^4^2
