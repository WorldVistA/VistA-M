IBDEI01W ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,333,1,3,0)
 ;;=3^Hereditary deficiency of other clotting factors
 ;;^UTILITY(U,$J,358.3,333,1,4,0)
 ;;=4^D68.2
 ;;^UTILITY(U,$J,358.3,333,2)
 ;;=^5002356
 ;;^UTILITY(U,$J,358.3,334,0)
 ;;=D68.0^^2^15^26
 ;;^UTILITY(U,$J,358.3,334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,334,1,3,0)
 ;;=3^Von Willebrand's disease
 ;;^UTILITY(U,$J,358.3,334,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,334,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,335,0)
 ;;=D68.311^^2^15^2
 ;;^UTILITY(U,$J,358.3,335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,335,1,3,0)
 ;;=3^Acquired hemophilia
 ;;^UTILITY(U,$J,358.3,335,1,4,0)
 ;;=4^D68.311
 ;;^UTILITY(U,$J,358.3,335,2)
 ;;=^340502
 ;;^UTILITY(U,$J,358.3,336,0)
 ;;=D68.312^^2^15^4
 ;;^UTILITY(U,$J,358.3,336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,336,1,3,0)
 ;;=3^Antiphospholipid antibody with hemorrhagic disorder
 ;;^UTILITY(U,$J,358.3,336,1,4,0)
 ;;=4^D68.312
 ;;^UTILITY(U,$J,358.3,336,2)
 ;;=^340503
 ;;^UTILITY(U,$J,358.3,337,0)
 ;;=D68.318^^2^15^13
 ;;^UTILITY(U,$J,358.3,337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,337,1,3,0)
 ;;=3^Hemorrhagic disord d/t intrns circ anticoag,antib,inhib NEC
 ;;^UTILITY(U,$J,358.3,337,1,4,0)
 ;;=4^D68.318
 ;;^UTILITY(U,$J,358.3,337,2)
 ;;=^340504
 ;;^UTILITY(U,$J,358.3,338,0)
 ;;=D65.^^2^15^7
 ;;^UTILITY(U,$J,358.3,338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,338,1,3,0)
 ;;=3^Disseminated intravascular coagulation
 ;;^UTILITY(U,$J,358.3,338,1,4,0)
 ;;=4^D65.
 ;;^UTILITY(U,$J,358.3,338,2)
 ;;=^5002352
 ;;^UTILITY(U,$J,358.3,339,0)
 ;;=D68.32^^2^15^12
 ;;^UTILITY(U,$J,358.3,339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,339,1,3,0)
 ;;=3^Hemorrhagic disord d/t extrinsic circulating anticoagulants
 ;;^UTILITY(U,$J,358.3,339,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,339,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,340,0)
 ;;=D68.4^^2^15^1
 ;;^UTILITY(U,$J,358.3,340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,340,1,3,0)
 ;;=3^Acquired coagulation factor deficiency
 ;;^UTILITY(U,$J,358.3,340,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,340,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,341,0)
 ;;=D68.8^^2^15^5
 ;;^UTILITY(U,$J,358.3,341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,341,1,3,0)
 ;;=3^Coagulation Defects NEC
 ;;^UTILITY(U,$J,358.3,341,1,4,0)
 ;;=4^D68.8
 ;;^UTILITY(U,$J,358.3,341,2)
 ;;=^5002363
 ;;^UTILITY(U,$J,358.3,342,0)
 ;;=D68.9^^2^15^6
 ;;^UTILITY(U,$J,358.3,342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,342,1,3,0)
 ;;=3^Coagulation Defects,Unspec
 ;;^UTILITY(U,$J,358.3,342,1,4,0)
 ;;=4^D68.9
 ;;^UTILITY(U,$J,358.3,342,2)
 ;;=^5002364
 ;;^UTILITY(U,$J,358.3,343,0)
 ;;=D69.1^^2^15^22
 ;;^UTILITY(U,$J,358.3,343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,343,1,3,0)
 ;;=3^Qualitative platelet defects
 ;;^UTILITY(U,$J,358.3,343,1,4,0)
 ;;=4^D69.1
 ;;^UTILITY(U,$J,358.3,343,2)
 ;;=^101922
 ;;^UTILITY(U,$J,358.3,344,0)
 ;;=D47.3^^2^15^8
 ;;^UTILITY(U,$J,358.3,344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,344,1,3,0)
 ;;=3^Essential (hemorrhagic) thrombocythemia
 ;;^UTILITY(U,$J,358.3,344,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,344,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,345,0)
 ;;=D69.0^^2^15^3
 ;;^UTILITY(U,$J,358.3,345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,345,1,3,0)
 ;;=3^Allergic purpura
 ;;^UTILITY(U,$J,358.3,345,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,345,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,346,0)
 ;;=D69.2^^2^15^19
 ;;^UTILITY(U,$J,358.3,346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,346,1,3,0)
 ;;=3^Nonthrombocytopenic purpura NEC
 ;;^UTILITY(U,$J,358.3,346,1,4,0)
 ;;=4^D69.2
 ;;^UTILITY(U,$J,358.3,346,2)
 ;;=^5002366
