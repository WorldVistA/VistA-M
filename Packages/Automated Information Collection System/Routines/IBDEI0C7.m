IBDEI0C7 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5416,0)
 ;;=12001^^26^334^1^^^^1
 ;;^UTILITY(U,$J,358.3,5416,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5416,1,2,0)
 ;;=2^12001
 ;;^UTILITY(U,$J,358.3,5416,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,5417,0)
 ;;=12002^^26^334^2^^^^1
 ;;^UTILITY(U,$J,358.3,5417,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5417,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,5417,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5418,0)
 ;;=12004^^26^334^3^^^^1
 ;;^UTILITY(U,$J,358.3,5418,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5418,1,2,0)
 ;;=2^12004
 ;;^UTILITY(U,$J,358.3,5418,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,5419,0)
 ;;=12005^^26^334^4^^^^1
 ;;^UTILITY(U,$J,358.3,5419,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5419,1,2,0)
 ;;=2^12005
 ;;^UTILITY(U,$J,358.3,5419,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,5420,0)
 ;;=12006^^26^334^5^^^^1
 ;;^UTILITY(U,$J,358.3,5420,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5420,1,2,0)
 ;;=2^12006
 ;;^UTILITY(U,$J,358.3,5420,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,5421,0)
 ;;=12007^^26^334^6^^^^1
 ;;^UTILITY(U,$J,358.3,5421,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5421,1,2,0)
 ;;=2^12007
 ;;^UTILITY(U,$J,358.3,5421,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,5422,0)
 ;;=12031^^26^335^1^^^^1
 ;;^UTILITY(U,$J,358.3,5422,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5422,1,2,0)
 ;;=2^12031
 ;;^UTILITY(U,$J,358.3,5422,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,5423,0)
 ;;=12032^^26^335^2^^^^1
 ;;^UTILITY(U,$J,358.3,5423,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5423,1,2,0)
 ;;=2^12032
 ;;^UTILITY(U,$J,358.3,5423,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5424,0)
 ;;=12034^^26^335^3^^^^1
 ;;^UTILITY(U,$J,358.3,5424,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5424,1,2,0)
 ;;=2^12034
 ;;^UTILITY(U,$J,358.3,5424,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,5425,0)
 ;;=12035^^26^335^4^^^^1
 ;;^UTILITY(U,$J,358.3,5425,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5425,1,2,0)
 ;;=2^12035
 ;;^UTILITY(U,$J,358.3,5425,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,5426,0)
 ;;=12036^^26^335^5^^^^1
 ;;^UTILITY(U,$J,358.3,5426,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5426,1,2,0)
 ;;=2^12036
 ;;^UTILITY(U,$J,358.3,5426,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,5427,0)
 ;;=12037^^26^335^6^^^^1
 ;;^UTILITY(U,$J,358.3,5427,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5427,1,2,0)
 ;;=2^12037
 ;;^UTILITY(U,$J,358.3,5427,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,5428,0)
 ;;=17270^^26^336^1^^^^1
 ;;^UTILITY(U,$J,358.3,5428,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5428,1,2,0)
 ;;=2^17270
 ;;^UTILITY(U,$J,358.3,5428,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5429,0)
 ;;=17271^^26^336^2^^^^1
 ;;^UTILITY(U,$J,358.3,5429,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5429,1,2,0)
 ;;=2^17271
 ;;^UTILITY(U,$J,358.3,5429,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5430,0)
 ;;=17272^^26^336^3^^^^1
 ;;^UTILITY(U,$J,358.3,5430,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5430,1,2,0)
 ;;=2^17272
 ;;^UTILITY(U,$J,358.3,5430,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
