IBDEI0DM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6252,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,6253,0)
 ;;=D12.2^^30^391^11
 ;;^UTILITY(U,$J,358.3,6253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6253,1,3,0)
 ;;=3^Benign Neop of Ascending Colon
 ;;^UTILITY(U,$J,358.3,6253,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,6253,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,6254,0)
 ;;=D12.5^^30^391^16
 ;;^UTILITY(U,$J,358.3,6254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6254,1,3,0)
 ;;=3^Benign Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,6254,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,6254,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,6255,0)
 ;;=D12.4^^30^391^14
 ;;^UTILITY(U,$J,358.3,6255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6255,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,6255,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,6255,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,6256,0)
 ;;=D73.2^^30^391^19
 ;;^UTILITY(U,$J,358.3,6256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6256,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,6256,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,6256,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,6257,0)
 ;;=I85.00^^30^391^47
 ;;^UTILITY(U,$J,358.3,6257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6257,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6257,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,6257,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,6258,0)
 ;;=K20.9^^30^391^48
 ;;^UTILITY(U,$J,358.3,6258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6258,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,6258,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,6258,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,6259,0)
 ;;=K21.9^^30^391^56
 ;;^UTILITY(U,$J,358.3,6259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6259,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,6259,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,6259,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,6260,0)
 ;;=K25.7^^30^391^51
 ;;^UTILITY(U,$J,358.3,6260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6260,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,6260,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,6260,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,6261,0)
 ;;=K26.9^^30^391^44
 ;;^UTILITY(U,$J,358.3,6261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6261,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,6261,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,6261,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,6262,0)
 ;;=K27.9^^30^391^74
 ;;^UTILITY(U,$J,358.3,6262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6262,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,6262,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,6262,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,6263,0)
 ;;=K29.70^^30^391^52
 ;;^UTILITY(U,$J,358.3,6263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6263,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,6263,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,6263,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,6264,0)
 ;;=K29.90^^30^391^53
 ;;^UTILITY(U,$J,358.3,6264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6264,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,6264,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,6264,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,6265,0)
 ;;=K30.^^30^391^45
 ;;^UTILITY(U,$J,358.3,6265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6265,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,6265,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,6265,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,6266,0)
 ;;=K31.89^^30^391^34
