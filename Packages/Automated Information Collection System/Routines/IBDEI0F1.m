IBDEI0F1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6928,1,4,0)
 ;;=4^K76.0
 ;;^UTILITY(U,$J,358.3,6928,2)
 ;;=^5008831
 ;;^UTILITY(U,$J,358.3,6929,0)
 ;;=K76.89^^30^399^18
 ;;^UTILITY(U,$J,358.3,6929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6929,1,3,0)
 ;;=3^Liver Disease NEC
 ;;^UTILITY(U,$J,358.3,6929,1,4,0)
 ;;=4^K76.89
 ;;^UTILITY(U,$J,358.3,6929,2)
 ;;=^5008835
 ;;^UTILITY(U,$J,358.3,6930,0)
 ;;=K71.6^^30^399^32
 ;;^UTILITY(U,$J,358.3,6930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6930,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,6930,1,4,0)
 ;;=4^K71.6
 ;;^UTILITY(U,$J,358.3,6930,2)
 ;;=^5008801
 ;;^UTILITY(U,$J,358.3,6931,0)
 ;;=K75.9^^30^399^17
 ;;^UTILITY(U,$J,358.3,6931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6931,1,3,0)
 ;;=3^Inflammatory Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6931,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,6931,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,6932,0)
 ;;=K71.0^^30^399^24
 ;;^UTILITY(U,$J,358.3,6932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6932,1,3,0)
 ;;=3^Toxic Liver Disease w/ Cholestasis
 ;;^UTILITY(U,$J,358.3,6932,1,4,0)
 ;;=4^K71.0
 ;;^UTILITY(U,$J,358.3,6932,2)
 ;;=^5008793
 ;;^UTILITY(U,$J,358.3,6933,0)
 ;;=K71.10^^30^399^30
 ;;^UTILITY(U,$J,358.3,6933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6933,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/o Coma
 ;;^UTILITY(U,$J,358.3,6933,1,4,0)
 ;;=4^K71.10
 ;;^UTILITY(U,$J,358.3,6933,2)
 ;;=^5008794
 ;;^UTILITY(U,$J,358.3,6934,0)
 ;;=K71.11^^30^399^31
 ;;^UTILITY(U,$J,358.3,6934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6934,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/ Coma
 ;;^UTILITY(U,$J,358.3,6934,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,6934,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,6935,0)
 ;;=K71.2^^30^399^23
 ;;^UTILITY(U,$J,358.3,6935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6935,1,3,0)
 ;;=3^Toxic Liver Disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,6935,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,6935,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,6936,0)
 ;;=K71.3^^30^399^28
 ;;^UTILITY(U,$J,358.3,6936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6936,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,6936,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,6936,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,6937,0)
 ;;=K71.4^^30^399^27
 ;;^UTILITY(U,$J,358.3,6937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6937,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,6937,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,6937,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,6938,0)
 ;;=K75.81^^30^399^19
 ;;^UTILITY(U,$J,358.3,6938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6938,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,6938,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,6938,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,6939,0)
 ;;=K75.89^^30^399^16
 ;;^UTILITY(U,$J,358.3,6939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6939,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,6939,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,6939,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,6940,0)
 ;;=K76.4^^30^399^21
 ;;^UTILITY(U,$J,358.3,6940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6940,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,6940,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,6940,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,6941,0)
 ;;=K71.50^^30^399^25
 ;;^UTILITY(U,$J,358.3,6941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6941,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
