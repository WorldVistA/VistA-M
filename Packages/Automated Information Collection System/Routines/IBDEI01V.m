IBDEI01V ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,320,0)
 ;;=D05.01^^2^14^10
 ;;^UTILITY(U,$J,358.3,320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,320,1,3,0)
 ;;=3^Lobular carcinoma in situ of right breast
 ;;^UTILITY(U,$J,358.3,320,1,4,0)
 ;;=4^D05.01
 ;;^UTILITY(U,$J,358.3,320,2)
 ;;=^5001927
 ;;^UTILITY(U,$J,358.3,321,0)
 ;;=D05.92^^2^14^1
 ;;^UTILITY(U,$J,358.3,321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,321,1,3,0)
 ;;=3^Carcinoma in Situ of Left Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,321,1,4,0)
 ;;=4^D05.92
 ;;^UTILITY(U,$J,358.3,321,2)
 ;;=^5001937
 ;;^UTILITY(U,$J,358.3,322,0)
 ;;=D05.91^^2^14^2
 ;;^UTILITY(U,$J,358.3,322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,322,1,3,0)
 ;;=3^Carcinoma in Situ of Right Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,322,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,322,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,323,0)
 ;;=D05.02^^2^14^9
 ;;^UTILITY(U,$J,358.3,323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,323,1,3,0)
 ;;=3^Lobular carcinoma in situ of left breast
 ;;^UTILITY(U,$J,358.3,323,1,4,0)
 ;;=4^D05.02
 ;;^UTILITY(U,$J,358.3,323,2)
 ;;=^5001928
 ;;^UTILITY(U,$J,358.3,324,0)
 ;;=D05.11^^2^14^8
 ;;^UTILITY(U,$J,358.3,324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,324,1,3,0)
 ;;=3^Intraductal carcinoma in situ of right breast
 ;;^UTILITY(U,$J,358.3,324,1,4,0)
 ;;=4^D05.11
 ;;^UTILITY(U,$J,358.3,324,2)
 ;;=^5001930
 ;;^UTILITY(U,$J,358.3,325,0)
 ;;=D05.12^^2^14^7
 ;;^UTILITY(U,$J,358.3,325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,325,1,3,0)
 ;;=3^Intraductal carcinoma in situ of left breast
 ;;^UTILITY(U,$J,358.3,325,1,4,0)
 ;;=4^D05.12
 ;;^UTILITY(U,$J,358.3,325,2)
 ;;=^5001931
 ;;^UTILITY(U,$J,358.3,326,0)
 ;;=D06.9^^2^14^3
 ;;^UTILITY(U,$J,358.3,326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,326,1,3,0)
 ;;=3^Carcinoma in situ of cervix, unspecified
 ;;^UTILITY(U,$J,358.3,326,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,326,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,327,0)
 ;;=D06.0^^2^14^4
 ;;^UTILITY(U,$J,358.3,327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,327,1,3,0)
 ;;=3^Carcinoma in situ of endocervix
 ;;^UTILITY(U,$J,358.3,327,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,327,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,328,0)
 ;;=D06.1^^2^14^5
 ;;^UTILITY(U,$J,358.3,328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,328,1,3,0)
 ;;=3^Carcinoma in situ of exocervix
 ;;^UTILITY(U,$J,358.3,328,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,328,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,329,0)
 ;;=D06.7^^2^14^6
 ;;^UTILITY(U,$J,358.3,329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,329,1,3,0)
 ;;=3^Carcinoma in situ of other parts of cervix
 ;;^UTILITY(U,$J,358.3,329,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,329,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,330,0)
 ;;=D66.^^2^15^16
 ;;^UTILITY(U,$J,358.3,330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,330,1,3,0)
 ;;=3^Hereditary factor VIII deficiency
 ;;^UTILITY(U,$J,358.3,330,1,4,0)
 ;;=4^D66.
 ;;^UTILITY(U,$J,358.3,330,2)
 ;;=^5002353
 ;;^UTILITY(U,$J,358.3,331,0)
 ;;=D67.^^2^15^15
 ;;^UTILITY(U,$J,358.3,331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,331,1,3,0)
 ;;=3^Hereditary factor IX deficiency
 ;;^UTILITY(U,$J,358.3,331,1,4,0)
 ;;=4^D67.
 ;;^UTILITY(U,$J,358.3,331,2)
 ;;=^5002354
 ;;^UTILITY(U,$J,358.3,332,0)
 ;;=D68.1^^2^15^17
 ;;^UTILITY(U,$J,358.3,332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,332,1,3,0)
 ;;=3^Hereditary factor XI deficiency
 ;;^UTILITY(U,$J,358.3,332,1,4,0)
 ;;=4^D68.1
 ;;^UTILITY(U,$J,358.3,332,2)
 ;;=^5002355
 ;;^UTILITY(U,$J,358.3,333,0)
 ;;=D68.2^^2^15^14
 ;;^UTILITY(U,$J,358.3,333,1,0)
 ;;=^358.31IA^4^2
