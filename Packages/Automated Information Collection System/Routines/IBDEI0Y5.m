IBDEI0Y5 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15209,1,3,0)
 ;;=3^Hyperbilirubinemia,Familial nonhemolytic
 ;;^UTILITY(U,$J,358.3,15209,1,4,0)
 ;;=4^E80.4
 ;;^UTILITY(U,$J,358.3,15209,2)
 ;;=^5002987
 ;;^UTILITY(U,$J,358.3,15210,0)
 ;;=C24.1^^85^843^25
 ;;^UTILITY(U,$J,358.3,15210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15210,1,3,0)
 ;;=3^Malignant neoplasm,Ampulla
 ;;^UTILITY(U,$J,358.3,15210,1,4,0)
 ;;=4^C24.1
 ;;^UTILITY(U,$J,358.3,15210,2)
 ;;=^267100
 ;;^UTILITY(U,$J,358.3,15211,0)
 ;;=C22.1^^85^843^23
 ;;^UTILITY(U,$J,358.3,15211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15211,1,3,0)
 ;;=3^Intrahepatic Bile Duct Carcinoma
 ;;^UTILITY(U,$J,358.3,15211,1,4,0)
 ;;=4^C22.1
 ;;^UTILITY(U,$J,358.3,15211,2)
 ;;=^5000934
 ;;^UTILITY(U,$J,358.3,15212,0)
 ;;=C24.8^^85^843^28
 ;;^UTILITY(U,$J,358.3,15212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15212,1,3,0)
 ;;=3^Malignant neoplasm,Overlapping bile duct
 ;;^UTILITY(U,$J,358.3,15212,1,4,0)
 ;;=4^C24.8
 ;;^UTILITY(U,$J,358.3,15212,2)
 ;;=^5000941
 ;;^UTILITY(U,$J,358.3,15213,0)
 ;;=K83.1^^85^843^29
 ;;^UTILITY(U,$J,358.3,15213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15213,1,3,0)
 ;;=3^Obstruction,Ampulla or Bile duct
 ;;^UTILITY(U,$J,358.3,15213,1,4,0)
 ;;=4^K83.1
 ;;^UTILITY(U,$J,358.3,15213,2)
 ;;=^5008876
 ;;^UTILITY(U,$J,358.3,15214,0)
 ;;=K82.9^^85^843^20
 ;;^UTILITY(U,$J,358.3,15214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15214,1,3,0)
 ;;=3^Disease of Gallbladder,unspec
 ;;^UTILITY(U,$J,358.3,15214,1,4,0)
 ;;=4^K82.9
 ;;^UTILITY(U,$J,358.3,15214,2)
 ;;=^5008875
 ;;^UTILITY(U,$J,358.3,15215,0)
 ;;=K80.36^^85^843^6
 ;;^UTILITY(U,$J,358.3,15215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15215,1,3,0)
 ;;=3^Calculus,Bile Duct w/ Chr Cholangitis No Obstruction,Acute/Chr
 ;;^UTILITY(U,$J,358.3,15215,1,4,0)
 ;;=4^K80.36
 ;;^UTILITY(U,$J,358.3,15215,2)
 ;;=^5008854
 ;;^UTILITY(U,$J,358.3,15216,0)
 ;;=K80.37^^85^843^5
 ;;^UTILITY(U,$J,358.3,15216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15216,1,3,0)
 ;;=3^Calculus,Bile Duct w/ Chr Cholangitis & Obstruction,Acute/Chr
 ;;^UTILITY(U,$J,358.3,15216,1,4,0)
 ;;=4^K80.37
 ;;^UTILITY(U,$J,358.3,15216,2)
 ;;=^5008855
 ;;^UTILITY(U,$J,358.3,15217,0)
 ;;=K80.51^^85^843^7
 ;;^UTILITY(U,$J,358.3,15217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15217,1,3,0)
 ;;=3^Calculus,Bile Duct w/ Obstruction no cholangitis
 ;;^UTILITY(U,$J,358.3,15217,1,4,0)
 ;;=4^K80.51
 ;;^UTILITY(U,$J,358.3,15217,2)
 ;;=^5008864
 ;;^UTILITY(U,$J,358.3,15218,0)
 ;;=K80.50^^85^843^8
 ;;^UTILITY(U,$J,358.3,15218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15218,1,3,0)
 ;;=3^Calculus,Bile Duct,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15218,1,4,0)
 ;;=4^K80.50
 ;;^UTILITY(U,$J,358.3,15218,2)
 ;;=^5008863
 ;;^UTILITY(U,$J,358.3,15219,0)
 ;;=K82.4^^85^843^16
 ;;^UTILITY(U,$J,358.3,15219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15219,1,3,0)
 ;;=3^Cholesterolosis of Gallbladder
 ;;^UTILITY(U,$J,358.3,15219,1,4,0)
 ;;=4^K82.4
 ;;^UTILITY(U,$J,358.3,15219,2)
 ;;=^265888
 ;;^UTILITY(U,$J,358.3,15220,0)
 ;;=K83.8^^85^843^18
 ;;^UTILITY(U,$J,358.3,15220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15220,1,3,0)
 ;;=3^Dilated bile duct,Acquired
 ;;^UTILITY(U,$J,358.3,15220,1,4,0)
 ;;=4^K83.8
 ;;^UTILITY(U,$J,358.3,15220,2)
 ;;=^5008880
 ;;^UTILITY(U,$J,358.3,15221,0)
 ;;=K83.09^^85^843^14
 ;;^UTILITY(U,$J,358.3,15221,1,0)
 ;;=^358.31IA^4^2
