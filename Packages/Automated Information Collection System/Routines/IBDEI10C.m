IBDEI10C ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16203,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,16203,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,16204,0)
 ;;=D73.2^^88^875^19
 ;;^UTILITY(U,$J,358.3,16204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16204,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,16204,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,16204,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,16205,0)
 ;;=I85.00^^88^875^53
 ;;^UTILITY(U,$J,358.3,16205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16205,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,16205,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,16205,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,16206,0)
 ;;=K20.9^^88^875^54
 ;;^UTILITY(U,$J,358.3,16206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16206,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,16206,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,16206,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,16207,0)
 ;;=K21.9^^88^875^62
 ;;^UTILITY(U,$J,358.3,16207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16207,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,16207,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,16207,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,16208,0)
 ;;=K25.7^^88^875^57
 ;;^UTILITY(U,$J,358.3,16208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16208,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,16208,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,16208,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,16209,0)
 ;;=K26.9^^88^875^49
 ;;^UTILITY(U,$J,358.3,16209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16209,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,16209,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,16209,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,16210,0)
 ;;=K27.9^^88^875^82
 ;;^UTILITY(U,$J,358.3,16210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16210,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,16210,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,16210,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,16211,0)
 ;;=K29.70^^88^875^58
 ;;^UTILITY(U,$J,358.3,16211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16211,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,16211,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,16211,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,16212,0)
 ;;=K29.90^^88^875^59
 ;;^UTILITY(U,$J,358.3,16212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16212,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,16212,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,16212,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,16213,0)
 ;;=K30.^^88^875^50
 ;;^UTILITY(U,$J,358.3,16213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16213,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,16213,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,16213,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,16214,0)
 ;;=K31.89^^88^875^39
 ;;^UTILITY(U,$J,358.3,16214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16214,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,16214,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,16214,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,16215,0)
 ;;=K31.9^^88^875^38
 ;;^UTILITY(U,$J,358.3,16215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16215,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,16215,1,4,0)
 ;;=4^K31.9
