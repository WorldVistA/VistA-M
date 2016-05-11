IBDEI1RP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30044,1,3,0)
 ;;=3^Carcinoma in situ of other parts of cervix
 ;;^UTILITY(U,$J,358.3,30044,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,30044,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,30045,0)
 ;;=D66.^^118^1496^16
 ;;^UTILITY(U,$J,358.3,30045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30045,1,3,0)
 ;;=3^Hereditary factor VIII deficiency
 ;;^UTILITY(U,$J,358.3,30045,1,4,0)
 ;;=4^D66.
 ;;^UTILITY(U,$J,358.3,30045,2)
 ;;=^5002353
 ;;^UTILITY(U,$J,358.3,30046,0)
 ;;=D67.^^118^1496^15
 ;;^UTILITY(U,$J,358.3,30046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30046,1,3,0)
 ;;=3^Hereditary factor IX deficiency
 ;;^UTILITY(U,$J,358.3,30046,1,4,0)
 ;;=4^D67.
 ;;^UTILITY(U,$J,358.3,30046,2)
 ;;=^5002354
 ;;^UTILITY(U,$J,358.3,30047,0)
 ;;=D68.1^^118^1496^17
 ;;^UTILITY(U,$J,358.3,30047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30047,1,3,0)
 ;;=3^Hereditary factor XI deficiency
 ;;^UTILITY(U,$J,358.3,30047,1,4,0)
 ;;=4^D68.1
 ;;^UTILITY(U,$J,358.3,30047,2)
 ;;=^5002355
 ;;^UTILITY(U,$J,358.3,30048,0)
 ;;=D68.2^^118^1496^14
 ;;^UTILITY(U,$J,358.3,30048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30048,1,3,0)
 ;;=3^Hereditary deficiency of other clotting factors
 ;;^UTILITY(U,$J,358.3,30048,1,4,0)
 ;;=4^D68.2
 ;;^UTILITY(U,$J,358.3,30048,2)
 ;;=^5002356
 ;;^UTILITY(U,$J,358.3,30049,0)
 ;;=D68.0^^118^1496^26
 ;;^UTILITY(U,$J,358.3,30049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30049,1,3,0)
 ;;=3^Von Willebrand's disease
 ;;^UTILITY(U,$J,358.3,30049,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,30049,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,30050,0)
 ;;=D68.311^^118^1496^2
 ;;^UTILITY(U,$J,358.3,30050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30050,1,3,0)
 ;;=3^Acquired hemophilia
 ;;^UTILITY(U,$J,358.3,30050,1,4,0)
 ;;=4^D68.311
 ;;^UTILITY(U,$J,358.3,30050,2)
 ;;=^340502
 ;;^UTILITY(U,$J,358.3,30051,0)
 ;;=D68.312^^118^1496^4
 ;;^UTILITY(U,$J,358.3,30051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30051,1,3,0)
 ;;=3^Antiphospholipid antibody with hemorrhagic disorder
 ;;^UTILITY(U,$J,358.3,30051,1,4,0)
 ;;=4^D68.312
 ;;^UTILITY(U,$J,358.3,30051,2)
 ;;=^340503
 ;;^UTILITY(U,$J,358.3,30052,0)
 ;;=D68.318^^118^1496^13
 ;;^UTILITY(U,$J,358.3,30052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30052,1,3,0)
 ;;=3^Hemorrhagic disord d/t intrns circ anticoag,antib,inhib NEC
 ;;^UTILITY(U,$J,358.3,30052,1,4,0)
 ;;=4^D68.318
 ;;^UTILITY(U,$J,358.3,30052,2)
 ;;=^340504
 ;;^UTILITY(U,$J,358.3,30053,0)
 ;;=D65.^^118^1496^7
 ;;^UTILITY(U,$J,358.3,30053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30053,1,3,0)
 ;;=3^Disseminated intravascular coagulation
 ;;^UTILITY(U,$J,358.3,30053,1,4,0)
 ;;=4^D65.
 ;;^UTILITY(U,$J,358.3,30053,2)
 ;;=^5002352
 ;;^UTILITY(U,$J,358.3,30054,0)
 ;;=D68.32^^118^1496^12
 ;;^UTILITY(U,$J,358.3,30054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30054,1,3,0)
 ;;=3^Hemorrhagic disord d/t extrinsic circulating anticoagulants
 ;;^UTILITY(U,$J,358.3,30054,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,30054,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,30055,0)
 ;;=D68.4^^118^1496^1
 ;;^UTILITY(U,$J,358.3,30055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30055,1,3,0)
 ;;=3^Acquired coagulation factor deficiency
 ;;^UTILITY(U,$J,358.3,30055,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,30055,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,30056,0)
 ;;=D68.8^^118^1496^5
 ;;^UTILITY(U,$J,358.3,30056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30056,1,3,0)
 ;;=3^Coagulation Defects NEC
 ;;^UTILITY(U,$J,358.3,30056,1,4,0)
 ;;=4^D68.8
 ;;^UTILITY(U,$J,358.3,30056,2)
 ;;=^5002363
 ;;^UTILITY(U,$J,358.3,30057,0)
 ;;=D68.9^^118^1496^6
