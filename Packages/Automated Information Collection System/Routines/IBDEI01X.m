IBDEI01X ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,347,0)
 ;;=D69.3^^2^15^18
 ;;^UTILITY(U,$J,358.3,347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,347,1,3,0)
 ;;=3^Immune thrombocytopenic purpura
 ;;^UTILITY(U,$J,358.3,347,1,4,0)
 ;;=4^D69.3
 ;;^UTILITY(U,$J,358.3,347,2)
 ;;=^332746
 ;;^UTILITY(U,$J,358.3,348,0)
 ;;=D69.41^^2^15^9
 ;;^UTILITY(U,$J,358.3,348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,348,1,3,0)
 ;;=3^Evans syndrome
 ;;^UTILITY(U,$J,358.3,348,1,4,0)
 ;;=4^D69.41
 ;;^UTILITY(U,$J,358.3,348,2)
 ;;=^332747
 ;;^UTILITY(U,$J,358.3,349,0)
 ;;=D69.51^^2^15^21
 ;;^UTILITY(U,$J,358.3,349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,349,1,3,0)
 ;;=3^Posttransfusion purpura
 ;;^UTILITY(U,$J,358.3,349,1,4,0)
 ;;=4^D69.51
 ;;^UTILITY(U,$J,358.3,349,2)
 ;;=^5002368
 ;;^UTILITY(U,$J,358.3,350,0)
 ;;=D69.59^^2^15^23
 ;;^UTILITY(U,$J,358.3,350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,350,1,3,0)
 ;;=3^Secondary thrombocytopenia NEC
 ;;^UTILITY(U,$J,358.3,350,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,350,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,351,0)
 ;;=D69.8^^2^15^10
 ;;^UTILITY(U,$J,358.3,351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,351,1,3,0)
 ;;=3^Hemorrhagic Conditions NEC
 ;;^UTILITY(U,$J,358.3,351,1,4,0)
 ;;=4^D69.8
 ;;^UTILITY(U,$J,358.3,351,2)
 ;;=^88074
 ;;^UTILITY(U,$J,358.3,352,0)
 ;;=D69.6^^2^15^24
 ;;^UTILITY(U,$J,358.3,352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,352,1,3,0)
 ;;=3^Thrombocytopenia, unspecified
 ;;^UTILITY(U,$J,358.3,352,1,4,0)
 ;;=4^D69.6
 ;;^UTILITY(U,$J,358.3,352,2)
 ;;=^5002370
 ;;^UTILITY(U,$J,358.3,353,0)
 ;;=M31.1^^2^15^25
 ;;^UTILITY(U,$J,358.3,353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,353,1,3,0)
 ;;=3^Thrombotic microangiopathy
 ;;^UTILITY(U,$J,358.3,353,1,4,0)
 ;;=4^M31.1
 ;;^UTILITY(U,$J,358.3,353,2)
 ;;=^119061
 ;;^UTILITY(U,$J,358.3,354,0)
 ;;=D69.9^^2^15^11
 ;;^UTILITY(U,$J,358.3,354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,354,1,3,0)
 ;;=3^Hemorrhagic condition, unspecified
 ;;^UTILITY(U,$J,358.3,354,1,4,0)
 ;;=4^D69.9
 ;;^UTILITY(U,$J,358.3,354,2)
 ;;=^5002371
 ;;^UTILITY(U,$J,358.3,355,0)
 ;;=I80.9^^2^15^20
 ;;^UTILITY(U,$J,358.3,355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,355,1,3,0)
 ;;=3^Phlebitis and thrombophlebitis of unspecified site
 ;;^UTILITY(U,$J,358.3,355,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,355,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,356,0)
 ;;=Z31.5^^2^16^4
 ;;^UTILITY(U,$J,358.3,356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,356,1,3,0)
 ;;=3^Genetic Counseling
 ;;^UTILITY(U,$J,358.3,356,1,4,0)
 ;;=4^Z31.5
 ;;^UTILITY(U,$J,358.3,356,2)
 ;;=^5062838
 ;;^UTILITY(U,$J,358.3,357,0)
 ;;=Z51.11^^2^16^2
 ;;^UTILITY(U,$J,358.3,357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,357,1,3,0)
 ;;=3^Antineoplastic Chemotherapy
 ;;^UTILITY(U,$J,358.3,357,1,4,0)
 ;;=4^Z51.11
 ;;^UTILITY(U,$J,358.3,357,2)
 ;;=^5063061
 ;;^UTILITY(U,$J,358.3,358,0)
 ;;=Z71.3^^2^16^3
 ;;^UTILITY(U,$J,358.3,358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,358,1,3,0)
 ;;=3^Dietary counseling and surveillance
 ;;^UTILITY(U,$J,358.3,358,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,358,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,359,0)
 ;;=Z71.89^^2^16^8
 ;;^UTILITY(U,$J,358.3,359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,359,1,3,0)
 ;;=3^Specified Counseling NEC
 ;;^UTILITY(U,$J,358.3,359,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,359,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,360,0)
 ;;=Z51.89^^2^16^1
 ;;^UTILITY(U,$J,358.3,360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,360,1,3,0)
 ;;=3^Aftercare NEC
 ;;^UTILITY(U,$J,358.3,360,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,360,2)
 ;;=^5063065
