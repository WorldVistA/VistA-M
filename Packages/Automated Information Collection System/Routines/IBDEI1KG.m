IBDEI1KG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26185,1,3,0)
 ;;=3^Acute Pharyngitis,Unspec
 ;;^UTILITY(U,$J,358.3,26185,1,4,0)
 ;;=4^J02.9
 ;;^UTILITY(U,$J,358.3,26185,2)
 ;;=^5008130
 ;;^UTILITY(U,$J,358.3,26186,0)
 ;;=J03.90^^127^1272^10
 ;;^UTILITY(U,$J,358.3,26186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26186,1,3,0)
 ;;=3^Acute Tonsillitis,Unspec
 ;;^UTILITY(U,$J,358.3,26186,1,4,0)
 ;;=4^J03.90
 ;;^UTILITY(U,$J,358.3,26186,2)
 ;;=^5008135
 ;;^UTILITY(U,$J,358.3,26187,0)
 ;;=J04.0^^127^1272^5
 ;;^UTILITY(U,$J,358.3,26187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26187,1,3,0)
 ;;=3^Acute Laryngitis
 ;;^UTILITY(U,$J,358.3,26187,1,4,0)
 ;;=4^J04.0
 ;;^UTILITY(U,$J,358.3,26187,2)
 ;;=^5008137
 ;;^UTILITY(U,$J,358.3,26188,0)
 ;;=J06.9^^127^1272^11
 ;;^UTILITY(U,$J,358.3,26188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26188,1,3,0)
 ;;=3^Acute Upper Respiratory Infection,Unspec
 ;;^UTILITY(U,$J,358.3,26188,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,26188,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,26189,0)
 ;;=J20.9^^127^1272^4
 ;;^UTILITY(U,$J,358.3,26189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26189,1,3,0)
 ;;=3^Acute Bronchitis,Unspec
 ;;^UTILITY(U,$J,358.3,26189,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,26189,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,26190,0)
 ;;=J32.9^^127^1272^35
 ;;^UTILITY(U,$J,358.3,26190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26190,1,3,0)
 ;;=3^Chronic Sinusitis,Unspec
 ;;^UTILITY(U,$J,358.3,26190,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,26190,2)
 ;;=^5008207
 ;;^UTILITY(U,$J,358.3,26191,0)
 ;;=J18.9^^127^1272^86
 ;;^UTILITY(U,$J,358.3,26191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26191,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,26191,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,26191,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,26192,0)
 ;;=J11.00^^127^1272^55
 ;;^UTILITY(U,$J,358.3,26192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26192,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type of Pneumonia
 ;;^UTILITY(U,$J,358.3,26192,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,26192,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,26193,0)
 ;;=J10.1^^127^1272^53
 ;;^UTILITY(U,$J,358.3,26193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26193,1,3,0)
 ;;=3^Flu d/t Indentified Flu Virus w/ Respiratory Manifestations
 ;;^UTILITY(U,$J,358.3,26193,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,26193,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,26194,0)
 ;;=J11.1^^127^1272^54
 ;;^UTILITY(U,$J,358.3,26194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26194,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Respiratory Manifestations NEC
 ;;^UTILITY(U,$J,358.3,26194,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,26194,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,26195,0)
 ;;=K52.9^^127^1272^80
 ;;^UTILITY(U,$J,358.3,26195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26195,1,3,0)
 ;;=3^Noninfective Gastroenteritis/Colitis,Unspec
 ;;^UTILITY(U,$J,358.3,26195,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,26195,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,26196,0)
 ;;=K52.89^^127^1272^79
 ;;^UTILITY(U,$J,358.3,26196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26196,1,3,0)
 ;;=3^Noninfective Gastroenteritis/Colitis NEC
 ;;^UTILITY(U,$J,358.3,26196,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,26196,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,26197,0)
 ;;=K57.32^^127^1272^46
 ;;^UTILITY(U,$J,358.3,26197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26197,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,26197,1,4,0)
 ;;=4^K57.32
