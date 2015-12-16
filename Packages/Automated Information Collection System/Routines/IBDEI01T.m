IBDEI01T ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,292,1,3,0)
 ;;=3^Myelophthisis
 ;;^UTILITY(U,$J,358.3,292,1,4,0)
 ;;=4^D61.82
 ;;^UTILITY(U,$J,358.3,292,2)
 ;;=^334037
 ;;^UTILITY(U,$J,358.3,293,0)
 ;;=D61.9^^2^12^14
 ;;^UTILITY(U,$J,358.3,293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,293,1,3,0)
 ;;=3^Aplastic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,293,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,293,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,294,0)
 ;;=D62.^^2^12^3
 ;;^UTILITY(U,$J,358.3,294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,294,1,3,0)
 ;;=3^Acute posthemorrhagic anemia
 ;;^UTILITY(U,$J,358.3,294,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,294,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,295,0)
 ;;=D63.1^^2^12^7
 ;;^UTILITY(U,$J,358.3,295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,295,1,3,0)
 ;;=3^Anemia in chronic kidney disease
 ;;^UTILITY(U,$J,358.3,295,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,295,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,296,0)
 ;;=D63.0^^2^12^8
 ;;^UTILITY(U,$J,358.3,296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,296,1,3,0)
 ;;=3^Anemia in neoplastic disease
 ;;^UTILITY(U,$J,358.3,296,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,296,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,297,0)
 ;;=D63.8^^2^12^9
 ;;^UTILITY(U,$J,358.3,297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,297,1,3,0)
 ;;=3^Anemia in other chronic diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,297,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,297,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,298,0)
 ;;=D64.81^^2^12^4
 ;;^UTILITY(U,$J,358.3,298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,298,1,3,0)
 ;;=3^Anemia due to antineoplastic chemotherapy
 ;;^UTILITY(U,$J,358.3,298,1,4,0)
 ;;=4^D64.81
 ;;^UTILITY(U,$J,358.3,298,2)
 ;;=^5002349
 ;;^UTILITY(U,$J,358.3,299,0)
 ;;=D64.89^^2^12^11
 ;;^UTILITY(U,$J,358.3,299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,299,1,3,0)
 ;;=3^Anemias NEC
 ;;^UTILITY(U,$J,358.3,299,1,4,0)
 ;;=4^D64.89
 ;;^UTILITY(U,$J,358.3,299,2)
 ;;=^5002350
 ;;^UTILITY(U,$J,358.3,300,0)
 ;;=D64.9^^2^12^10
 ;;^UTILITY(U,$J,358.3,300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,300,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,300,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,300,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,301,0)
 ;;=Z93.0^^2^13^9
 ;;^UTILITY(U,$J,358.3,301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,301,1,3,0)
 ;;=3^Tracheostomy status
 ;;^UTILITY(U,$J,358.3,301,1,4,0)
 ;;=4^Z93.0
 ;;^UTILITY(U,$J,358.3,301,2)
 ;;=^5063642
 ;;^UTILITY(U,$J,358.3,302,0)
 ;;=Z93.1^^2^13^7
 ;;^UTILITY(U,$J,358.3,302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,302,1,3,0)
 ;;=3^Gastrostomy status
 ;;^UTILITY(U,$J,358.3,302,1,4,0)
 ;;=4^Z93.1
 ;;^UTILITY(U,$J,358.3,302,2)
 ;;=^5063643
 ;;^UTILITY(U,$J,358.3,303,0)
 ;;=Z93.2^^2^13^8
 ;;^UTILITY(U,$J,358.3,303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,303,1,3,0)
 ;;=3^Ileostomy status
 ;;^UTILITY(U,$J,358.3,303,1,4,0)
 ;;=4^Z93.2
 ;;^UTILITY(U,$J,358.3,303,2)
 ;;=^5063644
 ;;^UTILITY(U,$J,358.3,304,0)
 ;;=Z93.3^^2^13^5
 ;;^UTILITY(U,$J,358.3,304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,304,1,3,0)
 ;;=3^Colostomy status
 ;;^UTILITY(U,$J,358.3,304,1,4,0)
 ;;=4^Z93.3
 ;;^UTILITY(U,$J,358.3,304,2)
 ;;=^5063645
 ;;^UTILITY(U,$J,358.3,305,0)
 ;;=Z93.4^^2^13^3
 ;;^UTILITY(U,$J,358.3,305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,305,1,3,0)
 ;;=3^Artificial openings of gastrointestinal tract status NEC
 ;;^UTILITY(U,$J,358.3,305,1,4,0)
 ;;=4^Z93.4
 ;;^UTILITY(U,$J,358.3,305,2)
 ;;=^5063646
 ;;^UTILITY(U,$J,358.3,306,0)
 ;;=Z93.50^^2^13^6
 ;;^UTILITY(U,$J,358.3,306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,306,1,3,0)
 ;;=3^Cystostomy Status,Unspec
