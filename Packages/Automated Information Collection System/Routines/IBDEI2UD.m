IBDEI2UD ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45328,1,3,0)
 ;;=3^Hereditary & idiopathic neuropathy, unspecified
 ;;^UTILITY(U,$J,358.3,45328,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,45328,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,45329,0)
 ;;=G62.9^^172^2264^13
 ;;^UTILITY(U,$J,358.3,45329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45329,1,3,0)
 ;;=3^Polyneuropathy, unspecified
 ;;^UTILITY(U,$J,358.3,45329,1,4,0)
 ;;=4^G62.9
 ;;^UTILITY(U,$J,358.3,45329,2)
 ;;=^5004079
 ;;^UTILITY(U,$J,358.3,45330,0)
 ;;=G81.90^^172^2264^7
 ;;^UTILITY(U,$J,358.3,45330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45330,1,3,0)
 ;;=3^Hemiplegia, unspecified 
 ;;^UTILITY(U,$J,358.3,45330,1,4,0)
 ;;=4^G81.90
 ;;^UTILITY(U,$J,358.3,45330,2)
 ;;=^5004120
 ;;^UTILITY(U,$J,358.3,45331,0)
 ;;=G81.91^^172^2264^6
 ;;^UTILITY(U,$J,358.3,45331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45331,1,3,0)
 ;;=3^Hemiplegia, affecting right dominant side
 ;;^UTILITY(U,$J,358.3,45331,1,4,0)
 ;;=4^G81.91
 ;;^UTILITY(U,$J,358.3,45331,2)
 ;;=^5004121
 ;;^UTILITY(U,$J,358.3,45332,0)
 ;;=G81.92^^172^2264^5
 ;;^UTILITY(U,$J,358.3,45332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45332,1,3,0)
 ;;=3^Hemiplegia, affecting left dominant side
 ;;^UTILITY(U,$J,358.3,45332,1,4,0)
 ;;=4^G81.92
 ;;^UTILITY(U,$J,358.3,45332,2)
 ;;=^5004122
 ;;^UTILITY(U,$J,358.3,45333,0)
 ;;=K21.9^^172^2265^14
 ;;^UTILITY(U,$J,358.3,45333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45333,1,3,0)
 ;;=3^GERD w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,45333,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,45333,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,45334,0)
 ;;=K29.70^^172^2265^18
 ;;^UTILITY(U,$J,358.3,45334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45334,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,45334,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,45334,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,45335,0)
 ;;=K52.9^^172^2265^19
 ;;^UTILITY(U,$J,358.3,45335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45335,1,3,0)
 ;;=3^Gastroenteritis & Colitis Noninfective,Unspec
 ;;^UTILITY(U,$J,358.3,45335,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,45335,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,45336,0)
 ;;=K82.9^^172^2265^16
 ;;^UTILITY(U,$J,358.3,45336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45336,1,3,0)
 ;;=3^Gallbladder Disease,Unspec
 ;;^UTILITY(U,$J,358.3,45336,1,4,0)
 ;;=4^K82.9
 ;;^UTILITY(U,$J,358.3,45336,2)
 ;;=^5008875
 ;;^UTILITY(U,$J,358.3,45337,0)
 ;;=K92.2^^172^2265^20
 ;;^UTILITY(U,$J,358.3,45337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45337,1,3,0)
 ;;=3^Gastrointestinal Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,45337,1,4,0)
 ;;=4^K92.2
 ;;^UTILITY(U,$J,358.3,45337,2)
 ;;=^5008915
 ;;^UTILITY(U,$J,358.3,45338,0)
 ;;=K25.9^^172^2265^17
 ;;^UTILITY(U,$J,358.3,45338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45338,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,45338,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,45338,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,45339,0)
 ;;=K20.9^^172^2265^10
 ;;^UTILITY(U,$J,358.3,45339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45339,1,3,0)
 ;;=3^Esophagitis, unspecified
 ;;^UTILITY(U,$J,358.3,45339,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,45339,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,45340,0)
 ;;=K22.10^^172^2265^12
 ;;^UTILITY(U,$J,358.3,45340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45340,1,3,0)
 ;;=3^Esophagus ulcer w/o bleeding
