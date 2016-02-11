IBDEI1D8 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22765,1,3,0)
 ;;=3^Myeloid Leukemia,BCR/ABL-Positive,Chr,Not in Remission
 ;;^UTILITY(U,$J,358.3,22765,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,22765,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,22766,0)
 ;;=C91.40^^104^1062^7
 ;;^UTILITY(U,$J,358.3,22766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22766,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22766,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,22766,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,22767,0)
 ;;=C81.90^^104^1062^19
 ;;^UTILITY(U,$J,358.3,22767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22767,1,3,0)
 ;;=3^Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,22767,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,22767,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,22768,0)
 ;;=C81.99^^104^1062^26
 ;;^UTILITY(U,$J,358.3,22768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22768,1,3,0)
 ;;=3^Lymphoma,Extrnod & Solid Org Sites,Unspec
 ;;^UTILITY(U,$J,358.3,22768,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,22768,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,22769,0)
 ;;=C81.00^^104^1062^16
 ;;^UTILITY(U,$J,358.3,22769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22769,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Lymphocyte,Unspec Site
 ;;^UTILITY(U,$J,358.3,22769,1,4,0)
 ;;=4^C81.00
 ;;^UTILITY(U,$J,358.3,22769,2)
 ;;=^5001391
 ;;^UTILITY(U,$J,358.3,22770,0)
 ;;=C81.09^^104^1062^15
 ;;^UTILITY(U,$J,358.3,22770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22770,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Lymphocyte,Extrnod & Solid Org Site
 ;;^UTILITY(U,$J,358.3,22770,1,4,0)
 ;;=4^C81.09
 ;;^UTILITY(U,$J,358.3,22770,2)
 ;;=^5001400
 ;;^UTILITY(U,$J,358.3,22771,0)
 ;;=C81.40^^104^1062^12
 ;;^UTILITY(U,$J,358.3,22771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22771,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte-Rich,Unspec Site
 ;;^UTILITY(U,$J,358.3,22771,1,4,0)
 ;;=4^C81.40
 ;;^UTILITY(U,$J,358.3,22771,2)
 ;;=^5001431
 ;;^UTILITY(U,$J,358.3,22772,0)
 ;;=C81.49^^104^1062^11
 ;;^UTILITY(U,$J,358.3,22772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22772,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte-Rich,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,22772,1,4,0)
 ;;=4^C81.49
 ;;^UTILITY(U,$J,358.3,22772,2)
 ;;=^5001440
 ;;^UTILITY(U,$J,358.3,22773,0)
 ;;=C81.30^^104^1062^10
 ;;^UTILITY(U,$J,358.3,22773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22773,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte Depleted,Unspec Site
 ;;^UTILITY(U,$J,358.3,22773,1,4,0)
 ;;=4^C81.30
 ;;^UTILITY(U,$J,358.3,22773,2)
 ;;=^5001421
 ;;^UTILITY(U,$J,358.3,22774,0)
 ;;=C81.39^^104^1062^9
 ;;^UTILITY(U,$J,358.3,22774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22774,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte Depleted,Extrnod & Solid Org Site
 ;;^UTILITY(U,$J,358.3,22774,1,4,0)
 ;;=4^C81.39
 ;;^UTILITY(U,$J,358.3,22774,2)
 ;;=^5001430
 ;;^UTILITY(U,$J,358.3,22775,0)
 ;;=C81.20^^104^1062^14
 ;;^UTILITY(U,$J,358.3,22775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22775,1,3,0)
 ;;=3^Hodgkin Lymphoma,Mixed Cellularity,Unspec Site
 ;;^UTILITY(U,$J,358.3,22775,1,4,0)
 ;;=4^C81.20
 ;;^UTILITY(U,$J,358.3,22775,2)
 ;;=^5001411
 ;;^UTILITY(U,$J,358.3,22776,0)
 ;;=C81.29^^104^1062^13
 ;;^UTILITY(U,$J,358.3,22776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22776,1,3,0)
 ;;=3^Hodgkin Lymphoma,Mixed Cellularity,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,22776,1,4,0)
 ;;=4^C81.29
 ;;^UTILITY(U,$J,358.3,22776,2)
 ;;=^5001420
 ;;^UTILITY(U,$J,358.3,22777,0)
 ;;=C81.10^^104^1062^18
 ;;^UTILITY(U,$J,358.3,22777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22777,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Sclerosis,Unspec Site
