IBDEI0IQ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8415,1,3,0)
 ;;=3^Sickle-cell disease without crisis
 ;;^UTILITY(U,$J,358.3,8415,1,4,0)
 ;;=4^D57.1
 ;;^UTILITY(U,$J,358.3,8415,2)
 ;;=^5002309
 ;;^UTILITY(U,$J,358.3,8416,0)
 ;;=D57.00^^55^538^35
 ;;^UTILITY(U,$J,358.3,8416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8416,1,3,0)
 ;;=3^Hb-SS disease with crisis, unspecified
 ;;^UTILITY(U,$J,358.3,8416,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,8416,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,8417,0)
 ;;=D58.9^^55^538^38
 ;;^UTILITY(U,$J,358.3,8417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8417,1,3,0)
 ;;=3^Hereditary hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,8417,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,8417,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,8418,0)
 ;;=D59.0^^55^538^29
 ;;^UTILITY(U,$J,358.3,8418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8418,1,3,0)
 ;;=3^Drug-induced autoimmune hemolytic anemia
 ;;^UTILITY(U,$J,358.3,8418,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,8418,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,8419,0)
 ;;=D59.9^^55^538^2
 ;;^UTILITY(U,$J,358.3,8419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8419,1,3,0)
 ;;=3^Acquired hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,8419,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,8419,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,8420,0)
 ;;=D61.82^^55^538^89
 ;;^UTILITY(U,$J,358.3,8420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8420,1,3,0)
 ;;=3^Myelophthisis
 ;;^UTILITY(U,$J,358.3,8420,1,4,0)
 ;;=4^D61.82
 ;;^UTILITY(U,$J,358.3,8420,2)
 ;;=^334037
 ;;^UTILITY(U,$J,358.3,8421,0)
 ;;=D61.9^^55^538^16
 ;;^UTILITY(U,$J,358.3,8421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8421,1,3,0)
 ;;=3^Aplastic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,8421,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,8421,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,8422,0)
 ;;=D62.^^55^538^10
 ;;^UTILITY(U,$J,358.3,8422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8422,1,3,0)
 ;;=3^Acute posthemorrhagic anemia
 ;;^UTILITY(U,$J,358.3,8422,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,8422,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,8423,0)
 ;;=D63.1^^55^538^11
 ;;^UTILITY(U,$J,358.3,8423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8423,1,3,0)
 ;;=3^Anemia in chronic kidney disease
 ;;^UTILITY(U,$J,358.3,8423,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,8423,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,8424,0)
 ;;=D63.0^^55^538^12
 ;;^UTILITY(U,$J,358.3,8424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8424,1,3,0)
 ;;=3^Anemia in neoplastic disease
 ;;^UTILITY(U,$J,358.3,8424,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,8424,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,8425,0)
 ;;=D63.8^^55^538^13
 ;;^UTILITY(U,$J,358.3,8425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8425,1,3,0)
 ;;=3^Anemia in other chronic diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,8425,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,8425,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,8426,0)
 ;;=D64.9^^55^538^14
 ;;^UTILITY(U,$J,358.3,8426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8426,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,8426,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,8426,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,8427,0)
 ;;=D68.0^^55^538^133
 ;;^UTILITY(U,$J,358.3,8427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8427,1,3,0)
 ;;=3^Von Willebrand's disease
 ;;^UTILITY(U,$J,358.3,8427,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,8427,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,8428,0)
 ;;=D68.4^^55^538^1
 ;;^UTILITY(U,$J,358.3,8428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8428,1,3,0)
 ;;=3^Acquired coagulation factor deficiency
