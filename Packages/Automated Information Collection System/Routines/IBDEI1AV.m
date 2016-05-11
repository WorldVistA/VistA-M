IBDEI1AV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22104,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,22104,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,22104,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,22105,0)
 ;;=D73.2^^87^976^19
 ;;^UTILITY(U,$J,358.3,22105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22105,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,22105,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,22105,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,22106,0)
 ;;=I85.00^^87^976^46
 ;;^UTILITY(U,$J,358.3,22106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22106,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,22106,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,22106,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,22107,0)
 ;;=K20.9^^87^976^47
 ;;^UTILITY(U,$J,358.3,22107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22107,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,22107,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,22107,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,22108,0)
 ;;=K21.9^^87^976^55
 ;;^UTILITY(U,$J,358.3,22108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22108,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,22108,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,22108,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,22109,0)
 ;;=K25.7^^87^976^50
 ;;^UTILITY(U,$J,358.3,22109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22109,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,22109,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,22109,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,22110,0)
 ;;=K26.9^^87^976^44
 ;;^UTILITY(U,$J,358.3,22110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22110,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,22110,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,22110,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,22111,0)
 ;;=K27.9^^87^976^72
 ;;^UTILITY(U,$J,358.3,22111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22111,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,22111,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,22111,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,22112,0)
 ;;=K29.70^^87^976^51
 ;;^UTILITY(U,$J,358.3,22112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22112,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,22112,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,22112,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,22113,0)
 ;;=K29.90^^87^976^52
 ;;^UTILITY(U,$J,358.3,22113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22113,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,22113,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,22113,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,22114,0)
 ;;=K30.^^87^976^45
 ;;^UTILITY(U,$J,358.3,22114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22114,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,22114,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,22114,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,22115,0)
 ;;=K31.89^^87^976^34
 ;;^UTILITY(U,$J,358.3,22115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22115,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,22115,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,22115,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,22116,0)
 ;;=K31.9^^87^976^33
 ;;^UTILITY(U,$J,358.3,22116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22116,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,22116,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,22116,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,22117,0)
 ;;=K40.90^^87^976^68
 ;;^UTILITY(U,$J,358.3,22117,1,0)
 ;;=^358.31IA^4^2
