IBDEI1SR ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32094,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,32094,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,32094,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,32095,0)
 ;;=K76.4^^190^1946^21
 ;;^UTILITY(U,$J,358.3,32095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32095,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,32095,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,32095,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,32096,0)
 ;;=K71.50^^190^1946^24
 ;;^UTILITY(U,$J,358.3,32096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32096,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,32096,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,32096,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,32097,0)
 ;;=K71.51^^190^1946^25
 ;;^UTILITY(U,$J,358.3,32097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32097,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,32097,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,32097,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,32098,0)
 ;;=K71.7^^190^1946^28
 ;;^UTILITY(U,$J,358.3,32098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32098,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,32098,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,32098,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,32099,0)
 ;;=K71.8^^190^1946^32
 ;;^UTILITY(U,$J,358.3,32099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32099,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,32099,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,32099,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,32100,0)
 ;;=K71.9^^190^1946^33
 ;;^UTILITY(U,$J,358.3,32100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32100,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,32100,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,32100,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,32101,0)
 ;;=K75.2^^190^1946^20
 ;;^UTILITY(U,$J,358.3,32101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32101,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,32101,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,32101,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,32102,0)
 ;;=K75.3^^190^1946^13
 ;;^UTILITY(U,$J,358.3,32102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32102,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,32102,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,32102,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,32103,0)
 ;;=F02.80^^190^1947^9
 ;;^UTILITY(U,$J,358.3,32103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32103,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavrl Disturb
 ;;^UTILITY(U,$J,358.3,32103,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,32103,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,32104,0)
 ;;=F02.81^^190^1947^10
 ;;^UTILITY(U,$J,358.3,32104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32104,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavrl Disturb
 ;;^UTILITY(U,$J,358.3,32104,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,32104,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,32105,0)
 ;;=F20.3^^190^1947^26
 ;;^UTILITY(U,$J,358.3,32105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32105,1,3,0)
 ;;=3^Undifferentiated Schizophrenia
 ;;^UTILITY(U,$J,358.3,32105,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,32105,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,32106,0)
 ;;=F20.9^^190^1947^23
 ;;^UTILITY(U,$J,358.3,32106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32106,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,32106,1,4,0)
 ;;=4^F20.9
