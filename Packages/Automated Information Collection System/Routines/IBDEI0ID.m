IBDEI0ID ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8265,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,8265,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,8266,0)
 ;;=K63.5^^39^397^84
 ;;^UTILITY(U,$J,358.3,8266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8266,1,3,0)
 ;;=3^Polyp of Colon
 ;;^UTILITY(U,$J,358.3,8266,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,8266,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,8267,0)
 ;;=D12.3^^39^397^17
 ;;^UTILITY(U,$J,358.3,8267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8267,1,3,0)
 ;;=3^Benign Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,8267,1,4,0)
 ;;=4^D12.3
 ;;^UTILITY(U,$J,358.3,8267,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,8268,0)
 ;;=D12.2^^39^397^11
 ;;^UTILITY(U,$J,358.3,8268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8268,1,3,0)
 ;;=3^Benign Neop of Ascending Colon
 ;;^UTILITY(U,$J,358.3,8268,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,8268,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,8269,0)
 ;;=D12.5^^39^397^16
 ;;^UTILITY(U,$J,358.3,8269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8269,1,3,0)
 ;;=3^Benign Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,8269,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,8269,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,8270,0)
 ;;=D12.4^^39^397^14
 ;;^UTILITY(U,$J,358.3,8270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8270,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,8270,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,8270,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,8271,0)
 ;;=D73.2^^39^397^19
 ;;^UTILITY(U,$J,358.3,8271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8271,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,8271,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,8271,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,8272,0)
 ;;=I85.00^^39^397^53
 ;;^UTILITY(U,$J,358.3,8272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8272,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8272,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,8272,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,8273,0)
 ;;=K21.9^^39^397^63
 ;;^UTILITY(U,$J,358.3,8273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8273,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,8273,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,8273,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,8274,0)
 ;;=K25.7^^39^397^58
 ;;^UTILITY(U,$J,358.3,8274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8274,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,8274,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,8274,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,8275,0)
 ;;=K26.9^^39^397^49
 ;;^UTILITY(U,$J,358.3,8275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8275,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,8275,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,8275,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,8276,0)
 ;;=K27.9^^39^397^83
 ;;^UTILITY(U,$J,358.3,8276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8276,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,8276,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,8276,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,8277,0)
 ;;=K29.70^^39^397^59
 ;;^UTILITY(U,$J,358.3,8277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8277,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,8277,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,8277,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,8278,0)
 ;;=K29.90^^39^397^60
