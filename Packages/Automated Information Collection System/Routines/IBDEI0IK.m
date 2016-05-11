IBDEI0IK ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8618,1,3,0)
 ;;=3^Enlarged lymph nodes, unspecified
 ;;^UTILITY(U,$J,358.3,8618,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,8618,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,8619,0)
 ;;=R05.^^39^463^4
 ;;^UTILITY(U,$J,358.3,8619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8619,1,3,0)
 ;;=3^Cough
 ;;^UTILITY(U,$J,358.3,8619,1,4,0)
 ;;=4^R05.
 ;;^UTILITY(U,$J,358.3,8619,2)
 ;;=^5019179
 ;;^UTILITY(U,$J,358.3,8620,0)
 ;;=R04.2^^39^463^7
 ;;^UTILITY(U,$J,358.3,8620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8620,1,3,0)
 ;;=3^Hemoptysis
 ;;^UTILITY(U,$J,358.3,8620,1,4,0)
 ;;=4^R04.2
 ;;^UTILITY(U,$J,358.3,8620,2)
 ;;=^5019175
 ;;^UTILITY(U,$J,358.3,8621,0)
 ;;=Z43.0^^39^463^2
 ;;^UTILITY(U,$J,358.3,8621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8621,1,3,0)
 ;;=3^Attention to Tracheostomy
 ;;^UTILITY(U,$J,358.3,8621,1,4,0)
 ;;=4^Z43.0
 ;;^UTILITY(U,$J,358.3,8621,2)
 ;;=^5062958
 ;;^UTILITY(U,$J,358.3,8622,0)
 ;;=G51.0^^39^463^3
 ;;^UTILITY(U,$J,358.3,8622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8622,1,3,0)
 ;;=3^Bell's palsy
 ;;^UTILITY(U,$J,358.3,8622,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,8622,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,8623,0)
 ;;=C77.9^^39^464^1
 ;;^UTILITY(U,$J,358.3,8623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8623,1,3,0)
 ;;=3^Secondary and unsp malignant neoplasm of lymph node, unsp
 ;;^UTILITY(U,$J,358.3,8623,1,4,0)
 ;;=4^C77.9
 ;;^UTILITY(U,$J,358.3,8623,2)
 ;;=^5001333
 ;;^UTILITY(U,$J,358.3,8624,0)
 ;;=C77.0^^39^464^2
 ;;^UTILITY(U,$J,358.3,8624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8624,1,3,0)
 ;;=3^Secondary and unsp malignant neoplasm of nodes of head,face and neck
 ;;^UTILITY(U,$J,358.3,8624,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,8624,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,8625,0)
 ;;=92015^^40^465^1^^^^1
 ;;^UTILITY(U,$J,358.3,8625,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8625,1,2,0)
 ;;=2^Refraction
 ;;^UTILITY(U,$J,358.3,8625,1,3,0)
 ;;=3^92015
 ;;^UTILITY(U,$J,358.3,8626,0)
 ;;=92311^^40^466^3^^^^1
 ;;^UTILITY(U,$J,358.3,8626,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8626,1,2,0)
 ;;=2^Contact Lens-Aphakia OD/OS
 ;;^UTILITY(U,$J,358.3,8626,1,3,0)
 ;;=3^92311
 ;;^UTILITY(U,$J,358.3,8627,0)
 ;;=92312^^40^466^4^^^^1
 ;;^UTILITY(U,$J,358.3,8627,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8627,1,2,0)
 ;;=2^Contact Lens-Aphakia OU
 ;;^UTILITY(U,$J,358.3,8627,1,3,0)
 ;;=3^92312
 ;;^UTILITY(U,$J,358.3,8628,0)
 ;;=92340^^40^466^6^^^^1
 ;;^UTILITY(U,$J,358.3,8628,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8628,1,2,0)
 ;;=2^Glasses Fitting, Monofocal
 ;;^UTILITY(U,$J,358.3,8628,1,3,0)
 ;;=3^92340
 ;;^UTILITY(U,$J,358.3,8629,0)
 ;;=92341^^40^466^5^^^^1
 ;;^UTILITY(U,$J,358.3,8629,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8629,1,2,0)
 ;;=2^Glasses Fitting, Bifocal
 ;;^UTILITY(U,$J,358.3,8629,1,3,0)
 ;;=3^92341
 ;;^UTILITY(U,$J,358.3,8630,0)
 ;;=92342^^40^466^8^^^^1
 ;;^UTILITY(U,$J,358.3,8630,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8630,1,2,0)
 ;;=2^Glasses Fitting, Multifocal
 ;;^UTILITY(U,$J,358.3,8630,1,3,0)
 ;;=3^92342
 ;;^UTILITY(U,$J,358.3,8631,0)
 ;;=92352^^40^466^7^^^^1
 ;;^UTILITY(U,$J,358.3,8631,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8631,1,2,0)
 ;;=2^Glasses Fitting, Monofocal for Aphakia
 ;;^UTILITY(U,$J,358.3,8631,1,3,0)
 ;;=3^92352
 ;;^UTILITY(U,$J,358.3,8632,0)
 ;;=92353^^40^466^9^^^^1
 ;;^UTILITY(U,$J,358.3,8632,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8632,1,2,0)
 ;;=2^Glasses Fitting, Multifocal, for Aphakia
 ;;^UTILITY(U,$J,358.3,8632,1,3,0)
 ;;=3^92353
 ;;^UTILITY(U,$J,358.3,8633,0)
 ;;=92354^^40^466^10^^^^1
