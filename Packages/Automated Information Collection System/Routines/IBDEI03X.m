IBDEI03X ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1302,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,1303,0)
 ;;=D58.9^^3^39^38
 ;;^UTILITY(U,$J,358.3,1303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1303,1,3,0)
 ;;=3^Hereditary hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,1303,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,1303,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,1304,0)
 ;;=D59.0^^3^39^29
 ;;^UTILITY(U,$J,358.3,1304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1304,1,3,0)
 ;;=3^Drug-induced autoimmune hemolytic anemia
 ;;^UTILITY(U,$J,358.3,1304,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,1304,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,1305,0)
 ;;=D59.9^^3^39^2
 ;;^UTILITY(U,$J,358.3,1305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1305,1,3,0)
 ;;=3^Acquired hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,1305,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,1305,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,1306,0)
 ;;=D61.82^^3^39^89
 ;;^UTILITY(U,$J,358.3,1306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1306,1,3,0)
 ;;=3^Myelophthisis
 ;;^UTILITY(U,$J,358.3,1306,1,4,0)
 ;;=4^D61.82
 ;;^UTILITY(U,$J,358.3,1306,2)
 ;;=^334037
 ;;^UTILITY(U,$J,358.3,1307,0)
 ;;=D61.9^^3^39^16
 ;;^UTILITY(U,$J,358.3,1307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1307,1,3,0)
 ;;=3^Aplastic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,1307,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,1307,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,1308,0)
 ;;=D62.^^3^39^10
 ;;^UTILITY(U,$J,358.3,1308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1308,1,3,0)
 ;;=3^Acute posthemorrhagic anemia
 ;;^UTILITY(U,$J,358.3,1308,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,1308,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,1309,0)
 ;;=D63.1^^3^39^11
 ;;^UTILITY(U,$J,358.3,1309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1309,1,3,0)
 ;;=3^Anemia in chronic kidney disease
 ;;^UTILITY(U,$J,358.3,1309,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,1309,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,1310,0)
 ;;=D63.0^^3^39^12
 ;;^UTILITY(U,$J,358.3,1310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1310,1,3,0)
 ;;=3^Anemia in neoplastic disease
 ;;^UTILITY(U,$J,358.3,1310,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,1310,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,1311,0)
 ;;=D63.8^^3^39^13
 ;;^UTILITY(U,$J,358.3,1311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1311,1,3,0)
 ;;=3^Anemia in other chronic diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,1311,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,1311,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,1312,0)
 ;;=D64.9^^3^39^14
 ;;^UTILITY(U,$J,358.3,1312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1312,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,1312,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,1312,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,1313,0)
 ;;=D68.0^^3^39^133
 ;;^UTILITY(U,$J,358.3,1313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1313,1,3,0)
 ;;=3^Von Willebrand's disease
 ;;^UTILITY(U,$J,358.3,1313,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,1313,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,1314,0)
 ;;=D68.4^^3^39^1
 ;;^UTILITY(U,$J,358.3,1314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1314,1,3,0)
 ;;=3^Acquired coagulation factor deficiency
 ;;^UTILITY(U,$J,358.3,1314,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,1314,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,1315,0)
 ;;=D68.32^^3^39^36
 ;;^UTILITY(U,$J,358.3,1315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1315,1,3,0)
 ;;=3^Hemorrhagic disord d/t extrinsic circulating anticoagulants
 ;;^UTILITY(U,$J,358.3,1315,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,1315,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,1316,0)
 ;;=D68.9^^3^39^28
 ;;^UTILITY(U,$J,358.3,1316,1,0)
 ;;=^358.31IA^4^2
