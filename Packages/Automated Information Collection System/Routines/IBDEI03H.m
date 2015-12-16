IBDEI03H ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1091,1,3,0)
 ;;=3^Chronic hepatitis, unspecified
 ;;^UTILITY(U,$J,358.3,1091,1,4,0)
 ;;=4^K73.9
 ;;^UTILITY(U,$J,358.3,1091,2)
 ;;=^5008815
 ;;^UTILITY(U,$J,358.3,1092,0)
 ;;=K73.0^^3^37^25
 ;;^UTILITY(U,$J,358.3,1092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1092,1,3,0)
 ;;=3^Chronic persistent hepatitis, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,1092,1,4,0)
 ;;=4^K73.0
 ;;^UTILITY(U,$J,358.3,1092,2)
 ;;=^5008811
 ;;^UTILITY(U,$J,358.3,1093,0)
 ;;=K74.60^^3^37^30
 ;;^UTILITY(U,$J,358.3,1093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1093,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,1093,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,1093,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,1094,0)
 ;;=K74.0^^3^37^61
 ;;^UTILITY(U,$J,358.3,1094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1094,1,3,0)
 ;;=3^Hepatic fibrosis
 ;;^UTILITY(U,$J,358.3,1094,1,4,0)
 ;;=4^K74.0
 ;;^UTILITY(U,$J,358.3,1094,2)
 ;;=^5008816
 ;;^UTILITY(U,$J,358.3,1095,0)
 ;;=K76.0^^3^37^48
 ;;^UTILITY(U,$J,358.3,1095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1095,1,3,0)
 ;;=3^Fatty (change of) liver, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,1095,1,4,0)
 ;;=4^K76.0
 ;;^UTILITY(U,$J,358.3,1095,2)
 ;;=^5008831
 ;;^UTILITY(U,$J,358.3,1096,0)
 ;;=K75.9^^3^37^64
 ;;^UTILITY(U,$J,358.3,1096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1096,1,3,0)
 ;;=3^Inflammatory liver disease, unspecified
 ;;^UTILITY(U,$J,358.3,1096,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,1096,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,1097,0)
 ;;=K71.6^^3^37^95
 ;;^UTILITY(U,$J,358.3,1097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1097,1,3,0)
 ;;=3^Toxic liver disease with hepatitis, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,1097,1,4,0)
 ;;=4^K71.6
 ;;^UTILITY(U,$J,358.3,1097,2)
 ;;=^5008801
 ;;^UTILITY(U,$J,358.3,1098,0)
 ;;=K80.20^^3^37^16
 ;;^UTILITY(U,$J,358.3,1098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1098,1,3,0)
 ;;=3^Calculus of gallbladder w/o cholecystitis w/o obstruction
 ;;^UTILITY(U,$J,358.3,1098,1,4,0)
 ;;=4^K80.20
 ;;^UTILITY(U,$J,358.3,1098,2)
 ;;=^5008846
 ;;^UTILITY(U,$J,358.3,1099,0)
 ;;=K81.9^^3^37^20
 ;;^UTILITY(U,$J,358.3,1099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1099,1,3,0)
 ;;=3^Cholecystitis, unspecified
 ;;^UTILITY(U,$J,358.3,1099,1,4,0)
 ;;=4^K81.9
 ;;^UTILITY(U,$J,358.3,1099,2)
 ;;=^87388
 ;;^UTILITY(U,$J,358.3,1100,0)
 ;;=K85.9^^3^37^5
 ;;^UTILITY(U,$J,358.3,1100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1100,1,3,0)
 ;;=3^Acute pancreatitis, unspecified
 ;;^UTILITY(U,$J,358.3,1100,1,4,0)
 ;;=4^K85.9
 ;;^UTILITY(U,$J,358.3,1100,2)
 ;;=^5008887
 ;;^UTILITY(U,$J,358.3,1101,0)
 ;;=K86.1^^3^37^24
 ;;^UTILITY(U,$J,358.3,1101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1101,1,3,0)
 ;;=3^Chronic pancreatitis NEC
 ;;^UTILITY(U,$J,358.3,1101,1,4,0)
 ;;=4^K86.1
 ;;^UTILITY(U,$J,358.3,1101,2)
 ;;=^5008889
 ;;^UTILITY(U,$J,358.3,1102,0)
 ;;=K86.3^^3^37^86
 ;;^UTILITY(U,$J,358.3,1102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1102,1,3,0)
 ;;=3^Pseudocyst of pancreas
 ;;^UTILITY(U,$J,358.3,1102,1,4,0)
 ;;=4^K86.3
 ;;^UTILITY(U,$J,358.3,1102,2)
 ;;=^5008891
 ;;^UTILITY(U,$J,358.3,1103,0)
 ;;=K92.1^^3^37^74
 ;;^UTILITY(U,$J,358.3,1103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1103,1,3,0)
 ;;=3^Melena
 ;;^UTILITY(U,$J,358.3,1103,1,4,0)
 ;;=4^K92.1
 ;;^UTILITY(U,$J,358.3,1103,2)
 ;;=^5008914
 ;;^UTILITY(U,$J,358.3,1104,0)
 ;;=K92.2^^3^37^56
 ;;^UTILITY(U,$J,358.3,1104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1104,1,3,0)
 ;;=3^Gastrointestinal hemorrhage, unspecified
