IBDEI1ZB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33135,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33135,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,33135,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,33136,0)
 ;;=F18.20^^146^1617^2
 ;;^UTILITY(U,$J,358.3,33136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33136,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33136,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,33136,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,33137,0)
 ;;=F18.21^^146^1617^3
 ;;^UTILITY(U,$J,358.3,33137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33137,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,33137,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,33137,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,33138,0)
 ;;=F18.14^^146^1617^4
 ;;^UTILITY(U,$J,358.3,33138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33138,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33138,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,33138,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,33139,0)
 ;;=F18.24^^146^1617^5
 ;;^UTILITY(U,$J,358.3,33139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33139,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,33139,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,33139,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,33140,0)
 ;;=F70.^^146^1618^1
 ;;^UTILITY(U,$J,358.3,33140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33140,1,3,0)
 ;;=3^Intellectual Disabilities,Mild
 ;;^UTILITY(U,$J,358.3,33140,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,33140,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,33141,0)
 ;;=F71.^^146^1618^2
 ;;^UTILITY(U,$J,358.3,33141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33141,1,3,0)
 ;;=3^Intellectual Disabilities,Moderate
 ;;^UTILITY(U,$J,358.3,33141,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,33141,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,33142,0)
 ;;=F72.^^146^1618^3
 ;;^UTILITY(U,$J,358.3,33142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33142,1,3,0)
 ;;=3^Intellectual Disabilities,Severe
 ;;^UTILITY(U,$J,358.3,33142,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,33142,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,33143,0)
 ;;=F73.^^146^1618^4
 ;;^UTILITY(U,$J,358.3,33143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33143,1,3,0)
 ;;=3^Intellectual Disabilities,Profound
 ;;^UTILITY(U,$J,358.3,33143,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,33143,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,33144,0)
 ;;=F78.^^146^1618^5
 ;;^UTILITY(U,$J,358.3,33144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33144,1,3,0)
 ;;=3^Intellectual Disabilities,Oth Specified
 ;;^UTILITY(U,$J,358.3,33144,1,4,0)
 ;;=4^F78.
 ;;^UTILITY(U,$J,358.3,33144,2)
 ;;=^5003672
 ;;^UTILITY(U,$J,358.3,33145,0)
 ;;=F79.^^146^1618^6
 ;;^UTILITY(U,$J,358.3,33145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33145,1,3,0)
 ;;=3^Intellectual Disabilities,Unspec
 ;;^UTILITY(U,$J,358.3,33145,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,33145,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,33146,0)
 ;;=Z00.6^^146^1619^1
 ;;^UTILITY(U,$J,358.3,33146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33146,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,33146,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,33146,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,33147,0)
 ;;=F45.22^^146^1620^1
 ;;^UTILITY(U,$J,358.3,33147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33147,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,33147,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,33147,2)
 ;;=^5003588
