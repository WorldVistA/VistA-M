IBDEI1UF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31301,1,3,0)
 ;;=3^11302
 ;;^UTILITY(U,$J,358.3,31302,0)
 ;;=11305^^125^1580^1
 ;;^UTILITY(U,$J,358.3,31302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31302,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand;0.5cm or less
 ;;^UTILITY(U,$J,358.3,31302,1,3,0)
 ;;=3^11305
 ;;^UTILITY(U,$J,358.3,31303,0)
 ;;=11306^^125^1580^2
 ;;^UTILITY(U,$J,358.3,31303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31303,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand;0.6cm-1.0cm
 ;;^UTILITY(U,$J,358.3,31303,1,3,0)
 ;;=3^11306
 ;;^UTILITY(U,$J,358.3,31304,0)
 ;;=11307^^125^1580^3
 ;;^UTILITY(U,$J,358.3,31304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31304,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand;1.1cm-2.0cm
 ;;^UTILITY(U,$J,358.3,31304,1,3,0)
 ;;=3^11307
 ;;^UTILITY(U,$J,358.3,31305,0)
 ;;=11308^^125^1580^4
 ;;^UTILITY(U,$J,358.3,31305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31305,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand > 2.0cm
 ;;^UTILITY(U,$J,358.3,31305,1,3,0)
 ;;=3^11308
 ;;^UTILITY(U,$J,358.3,31306,0)
 ;;=11303^^125^1580^8^^^^1
 ;;^UTILITY(U,$J,358.3,31306,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31306,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;> 2.0cm
 ;;^UTILITY(U,$J,358.3,31306,1,3,0)
 ;;=3^11303
 ;;^UTILITY(U,$J,358.3,31307,0)
 ;;=11719^^125^1581^10^^^^1
 ;;^UTILITY(U,$J,358.3,31307,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31307,1,2,0)
 ;;=2^Trimming Nondystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,31307,1,3,0)
 ;;=3^11719
 ;;^UTILITY(U,$J,358.3,31308,0)
 ;;=G0127^^125^1581^9^^^^1
 ;;^UTILITY(U,$J,358.3,31308,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31308,1,2,0)
 ;;=2^Trimming Dystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,31308,1,3,0)
 ;;=3^G0127
 ;;^UTILITY(U,$J,358.3,31309,0)
 ;;=11720^^125^1581^4^^^^1
 ;;^UTILITY(U,$J,358.3,31309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31309,1,2,0)
 ;;=2^Debridement of Nail(s)any method(s); 1-5 
 ;;^UTILITY(U,$J,358.3,31309,1,3,0)
 ;;=3^11720
 ;;^UTILITY(U,$J,358.3,31310,0)
 ;;=11721^^125^1581^5^^^^1
 ;;^UTILITY(U,$J,358.3,31310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31310,1,2,0)
 ;;=2^Debridement of Nails any method; 6 or more
 ;;^UTILITY(U,$J,358.3,31310,1,3,0)
 ;;=3^11721
 ;;^UTILITY(U,$J,358.3,31311,0)
 ;;=11730^^125^1581^1^^^^1
 ;;^UTILITY(U,$J,358.3,31311,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31311,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,single
 ;;^UTILITY(U,$J,358.3,31311,1,3,0)
 ;;=3^11730
 ;;^UTILITY(U,$J,358.3,31312,0)
 ;;=11732^^125^1581^2^^^^1
 ;;^UTILITY(U,$J,358.3,31312,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31312,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,ea addl nail
 ;;^UTILITY(U,$J,358.3,31312,1,3,0)
 ;;=3^11732
 ;;^UTILITY(U,$J,358.3,31313,0)
 ;;=11740^^125^1581^6^^^^1
 ;;^UTILITY(U,$J,358.3,31313,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31313,1,2,0)
 ;;=2^Evacuation Subungual Hematoma
 ;;^UTILITY(U,$J,358.3,31313,1,3,0)
 ;;=3^11740
 ;;^UTILITY(U,$J,358.3,31314,0)
 ;;=11750^^125^1581^7^^^^1
 ;;^UTILITY(U,$J,358.3,31314,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31314,1,2,0)
 ;;=2^Excision of Nail and Nail Matrx, partial or complete, for permanent removal
 ;;^UTILITY(U,$J,358.3,31314,1,3,0)
 ;;=3^11750
 ;;^UTILITY(U,$J,358.3,31315,0)
 ;;=11755^^125^1581^3^^^^1
 ;;^UTILITY(U,$J,358.3,31315,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31315,1,2,0)
 ;;=2^Biopsy of Nail Unit
 ;;^UTILITY(U,$J,358.3,31315,1,3,0)
 ;;=3^11755
 ;;^UTILITY(U,$J,358.3,31316,0)
 ;;=11760^^125^1581^8^^^^1
