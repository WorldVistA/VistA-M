IBDEI0TB ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14186,0)
 ;;=250.81^^74^867^8
 ;;^UTILITY(U,$J,358.3,14186,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14186,1,3,0)
 ;;=3^250.81
 ;;^UTILITY(U,$J,358.3,14186,1,5,0)
 ;;=5^Diabetic Foot Ulcer, Type I
 ;;^UTILITY(U,$J,358.3,14186,2)
 ;;=^331812
 ;;^UTILITY(U,$J,358.3,14187,0)
 ;;=443.9^^74^868^1
 ;;^UTILITY(U,$J,358.3,14187,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14187,1,3,0)
 ;;=3^443.9
 ;;^UTILITY(U,$J,358.3,14187,1,5,0)
 ;;=5^Vascular Disease, Peripheral
 ;;^UTILITY(U,$J,358.3,14187,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,14188,0)
 ;;=459.81^^74^868^2
 ;;^UTILITY(U,$J,358.3,14188,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14188,1,3,0)
 ;;=3^459.81
 ;;^UTILITY(U,$J,358.3,14188,1,5,0)
 ;;=5^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,14188,2)
 ;;=^125826
 ;;^UTILITY(U,$J,358.3,14189,0)
 ;;=078.10^^74^868^3
 ;;^UTILITY(U,$J,358.3,14189,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14189,1,3,0)
 ;;=3^078.10
 ;;^UTILITY(U,$J,358.3,14189,1,5,0)
 ;;=5^Verruca
 ;;^UTILITY(U,$J,358.3,14189,2)
 ;;=^295787
 ;;^UTILITY(U,$J,358.3,14190,0)
 ;;=706.8^^74^869^1
 ;;^UTILITY(U,$J,358.3,14190,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14190,1,3,0)
 ;;=3^706.8
 ;;^UTILITY(U,$J,358.3,14190,1,5,0)
 ;;=5^Xerosis
 ;;^UTILITY(U,$J,358.3,14190,2)
 ;;=^271931
 ;;^UTILITY(U,$J,358.3,14191,0)
 ;;=V87.39^^74^870^1
 ;;^UTILITY(U,$J,358.3,14191,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14191,1,3,0)
 ;;=3^V87.39
 ;;^UTILITY(U,$J,358.3,14191,1,5,0)
 ;;=5^Cont/Exp Hazard Sub NEC
 ;;^UTILITY(U,$J,358.3,14191,2)
 ;;=^336815
 ;;^UTILITY(U,$J,358.3,14192,0)
 ;;=V60.0^^74^870^2
 ;;^UTILITY(U,$J,358.3,14192,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14192,1,3,0)
 ;;=3^V60.0
 ;;^UTILITY(U,$J,358.3,14192,1,5,0)
 ;;=5^Homelessness
 ;;^UTILITY(U,$J,358.3,14192,2)
 ;;=^295539
 ;;^UTILITY(U,$J,358.3,14193,0)
 ;;=10060^^75^871^1
 ;;^UTILITY(U,$J,358.3,14193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14193,1,2,0)
 ;;=2^Incision and Drainage of abscess, simple or single
 ;;^UTILITY(U,$J,358.3,14193,1,3,0)
 ;;=3^10060
 ;;^UTILITY(U,$J,358.3,14194,0)
 ;;=10061^^75^871^2
 ;;^UTILITY(U,$J,358.3,14194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14194,1,2,0)
 ;;=2^Incision and Drainage of abscess; complicated or multiple
 ;;^UTILITY(U,$J,358.3,14194,1,3,0)
 ;;=3^10061
 ;;^UTILITY(U,$J,358.3,14195,0)
 ;;=10120^^75^871^3
 ;;^UTILITY(U,$J,358.3,14195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14195,1,2,0)
 ;;=2^Incision & Removal FB,Subq Tissue;Simple
 ;;^UTILITY(U,$J,358.3,14195,1,3,0)
 ;;=3^10120
 ;;^UTILITY(U,$J,358.3,14196,0)
 ;;=10121^^75^871^4
 ;;^UTILITY(U,$J,358.3,14196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14196,1,2,0)
 ;;=2^Incision & Removal FB,Subq Tissue;Complicated
 ;;^UTILITY(U,$J,358.3,14196,1,3,0)
 ;;=3^10121
 ;;^UTILITY(U,$J,358.3,14197,0)
 ;;=10140^^75^871^5
 ;;^UTILITY(U,$J,358.3,14197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14197,1,2,0)
 ;;=2^Incision and Drainage of hematoma, seroma or fluid collection
 ;;^UTILITY(U,$J,358.3,14197,1,3,0)
 ;;=3^10140
 ;;^UTILITY(U,$J,358.3,14198,0)
 ;;=10160^^75^871^6
 ;;^UTILITY(U,$J,358.3,14198,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14198,1,2,0)
 ;;=2^Puncture aspiration of abscess, hemtoma, bulla, or cyst
 ;;^UTILITY(U,$J,358.3,14198,1,3,0)
 ;;=3^10160
 ;;^UTILITY(U,$J,358.3,14199,0)
 ;;=10180^^75^871^7
 ;;^UTILITY(U,$J,358.3,14199,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14199,1,2,0)
 ;;=2^Incision and Drainage, complex, postoperative wound infection
 ;;^UTILITY(U,$J,358.3,14199,1,3,0)
 ;;=3^10180
 ;;^UTILITY(U,$J,358.3,14200,0)
 ;;=11000^^75^872^4
