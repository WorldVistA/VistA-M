IBDEI02N ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,472,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,472,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,472,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,473,0)
 ;;=F18.21^^3^59^3
 ;;^UTILITY(U,$J,358.3,473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,473,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,473,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,473,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,474,0)
 ;;=F18.14^^3^59^4
 ;;^UTILITY(U,$J,358.3,474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,474,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,474,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,474,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,475,0)
 ;;=F18.24^^3^59^5
 ;;^UTILITY(U,$J,358.3,475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,475,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,475,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,475,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,476,0)
 ;;=F70.^^3^60^1
 ;;^UTILITY(U,$J,358.3,476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,476,1,3,0)
 ;;=3^Intellectual Disabilities,Mild
 ;;^UTILITY(U,$J,358.3,476,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,476,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,477,0)
 ;;=F71.^^3^60^2
 ;;^UTILITY(U,$J,358.3,477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,477,1,3,0)
 ;;=3^Intellectual Disabilities,Moderate
 ;;^UTILITY(U,$J,358.3,477,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,477,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,478,0)
 ;;=F72.^^3^60^3
 ;;^UTILITY(U,$J,358.3,478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,478,1,3,0)
 ;;=3^Intellectual Disabilities,Severe
 ;;^UTILITY(U,$J,358.3,478,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,478,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,479,0)
 ;;=F73.^^3^60^4
 ;;^UTILITY(U,$J,358.3,479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,479,1,3,0)
 ;;=3^Intellectual Disabilities,Profound
 ;;^UTILITY(U,$J,358.3,479,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,479,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,480,0)
 ;;=F78.^^3^60^5
 ;;^UTILITY(U,$J,358.3,480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,480,1,3,0)
 ;;=3^Intellectual Disabilities,Oth Specified
 ;;^UTILITY(U,$J,358.3,480,1,4,0)
 ;;=4^F78.
 ;;^UTILITY(U,$J,358.3,480,2)
 ;;=^5003672
 ;;^UTILITY(U,$J,358.3,481,0)
 ;;=F79.^^3^60^6
 ;;^UTILITY(U,$J,358.3,481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,481,1,3,0)
 ;;=3^Intellectual Disabilities,Unspec
 ;;^UTILITY(U,$J,358.3,481,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,481,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,482,0)
 ;;=Z00.6^^3^61^1
 ;;^UTILITY(U,$J,358.3,482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,482,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,482,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,482,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,483,0)
 ;;=F45.22^^3^62^1
 ;;^UTILITY(U,$J,358.3,483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,483,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,483,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,483,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,484,0)
 ;;=F45.20^^3^62^2
 ;;^UTILITY(U,$J,358.3,484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,484,1,3,0)
 ;;=3^Hypochondiacal Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,484,1,4,0)
 ;;=4^F45.20
 ;;^UTILITY(U,$J,358.3,484,2)
 ;;=^5003586
 ;;^UTILITY(U,$J,358.3,485,0)
 ;;=F45.21^^3^62^4
 ;;^UTILITY(U,$J,358.3,485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,485,1,3,0)
 ;;=3^Hypochondriasis
 ;;^UTILITY(U,$J,358.3,485,1,4,0)
 ;;=4^F45.21
