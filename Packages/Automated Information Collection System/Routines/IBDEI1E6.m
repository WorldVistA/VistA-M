IBDEI1E6 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22514,0)
 ;;=R60.0^^76^970^6
 ;;^UTILITY(U,$J,358.3,22514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22514,1,3,0)
 ;;=3^Edema,Localized
 ;;^UTILITY(U,$J,358.3,22514,1,4,0)
 ;;=4^R60.0
 ;;^UTILITY(U,$J,358.3,22514,2)
 ;;=^5019532
 ;;^UTILITY(U,$J,358.3,22515,0)
 ;;=L53.0^^76^970^14
 ;;^UTILITY(U,$J,358.3,22515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22515,1,3,0)
 ;;=3^Erythema Toxic
 ;;^UTILITY(U,$J,358.3,22515,1,4,0)
 ;;=4^L53.0
 ;;^UTILITY(U,$J,358.3,22515,2)
 ;;=^5009207
 ;;^UTILITY(U,$J,358.3,22516,0)
 ;;=L53.1^^76^970^9
 ;;^UTILITY(U,$J,358.3,22516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22516,1,3,0)
 ;;=3^Erythema Annulare Centrifugum
 ;;^UTILITY(U,$J,358.3,22516,1,4,0)
 ;;=4^L53.1
 ;;^UTILITY(U,$J,358.3,22516,2)
 ;;=^5009208
 ;;^UTILITY(U,$J,358.3,22517,0)
 ;;=L51.9^^76^970^12
 ;;^UTILITY(U,$J,358.3,22517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22517,1,3,0)
 ;;=3^Erythema Multiforme,Unspec
 ;;^UTILITY(U,$J,358.3,22517,1,4,0)
 ;;=4^L51.9
 ;;^UTILITY(U,$J,358.3,22517,2)
 ;;=^336759
 ;;^UTILITY(U,$J,358.3,22518,0)
 ;;=L12.35^^76^970^8
 ;;^UTILITY(U,$J,358.3,22518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22518,1,3,0)
 ;;=3^Epidermolysis Bullosa,Acquired
 ;;^UTILITY(U,$J,358.3,22518,1,4,0)
 ;;=4^L12.35
 ;;^UTILITY(U,$J,358.3,22518,2)
 ;;=^5009100
 ;;^UTILITY(U,$J,358.3,22519,0)
 ;;=L52.^^76^970^13
 ;;^UTILITY(U,$J,358.3,22519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22519,1,3,0)
 ;;=3^Erythema Nodosum
 ;;^UTILITY(U,$J,358.3,22519,1,4,0)
 ;;=4^L52.
 ;;^UTILITY(U,$J,358.3,22519,2)
 ;;=^42065
 ;;^UTILITY(U,$J,358.3,22520,0)
 ;;=L49.0^^76^970^26
 ;;^UTILITY(U,$J,358.3,22520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22520,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ < 10% Body Surface
 ;;^UTILITY(U,$J,358.3,22520,1,4,0)
 ;;=4^L49.0
 ;;^UTILITY(U,$J,358.3,22520,2)
 ;;=^5009190
 ;;^UTILITY(U,$J,358.3,22521,0)
 ;;=L49.1^^76^970^17
 ;;^UTILITY(U,$J,358.3,22521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22521,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 10-19% Body Surface
 ;;^UTILITY(U,$J,358.3,22521,1,4,0)
 ;;=4^L49.1
 ;;^UTILITY(U,$J,358.3,22521,2)
 ;;=^5009191
 ;;^UTILITY(U,$J,358.3,22522,0)
 ;;=L49.2^^76^970^18
 ;;^UTILITY(U,$J,358.3,22522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22522,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 20-29% Body Surface
 ;;^UTILITY(U,$J,358.3,22522,1,4,0)
 ;;=4^L49.2
 ;;^UTILITY(U,$J,358.3,22522,2)
 ;;=^5009192
 ;;^UTILITY(U,$J,358.3,22523,0)
 ;;=L49.3^^76^970^19
 ;;^UTILITY(U,$J,358.3,22523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22523,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 30-39% Body Surface
 ;;^UTILITY(U,$J,358.3,22523,1,4,0)
 ;;=4^L49.3
 ;;^UTILITY(U,$J,358.3,22523,2)
 ;;=^5009193
 ;;^UTILITY(U,$J,358.3,22524,0)
 ;;=L49.4^^76^970^20
 ;;^UTILITY(U,$J,358.3,22524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22524,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 40-49% Body Surface
 ;;^UTILITY(U,$J,358.3,22524,1,4,0)
 ;;=4^L49.4
 ;;^UTILITY(U,$J,358.3,22524,2)
 ;;=^5009194
 ;;^UTILITY(U,$J,358.3,22525,0)
 ;;=L49.5^^76^970^21
 ;;^UTILITY(U,$J,358.3,22525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22525,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 50-59% Body Surface
 ;;^UTILITY(U,$J,358.3,22525,1,4,0)
 ;;=4^L49.5
 ;;^UTILITY(U,$J,358.3,22525,2)
 ;;=^5009195
 ;;^UTILITY(U,$J,358.3,22526,0)
 ;;=L49.6^^76^970^22
