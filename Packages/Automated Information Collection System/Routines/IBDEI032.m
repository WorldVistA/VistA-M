IBDEI032 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,887,1,3,0)
 ;;=3^Type 2 diab w diabetic neuropathy, unsp
 ;;^UTILITY(U,$J,358.3,887,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,887,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,888,0)
 ;;=E10.40^^3^33^2
 ;;^UTILITY(U,$J,358.3,888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,888,1,3,0)
 ;;=3^Type 1 diab w diabetic neuropathy, unsp
 ;;^UTILITY(U,$J,358.3,888,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,888,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,889,0)
 ;;=E11.51^^3^33^15
 ;;^UTILITY(U,$J,358.3,889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,889,1,3,0)
 ;;=3^Type 2 diab w diabetic peripheral angiopath w/o gangrene
 ;;^UTILITY(U,$J,358.3,889,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,889,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,890,0)
 ;;=E11.52^^3^33^16
 ;;^UTILITY(U,$J,358.3,890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,890,1,3,0)
 ;;=3^Type 2 diab w diabetic peripheral angiopathy w gangrene
 ;;^UTILITY(U,$J,358.3,890,1,4,0)
 ;;=4^E11.52
 ;;^UTILITY(U,$J,358.3,890,2)
 ;;=^5002651
 ;;^UTILITY(U,$J,358.3,891,0)
 ;;=E10.51^^3^33^3
 ;;^UTILITY(U,$J,358.3,891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,891,1,3,0)
 ;;=3^Type 1 diab w diabetic peripheral angiopath w/o gangrene
 ;;^UTILITY(U,$J,358.3,891,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,891,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,892,0)
 ;;=E10.52^^3^33^4
 ;;^UTILITY(U,$J,358.3,892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,892,1,3,0)
 ;;=3^Type 1 diab w diabetic peripheral angiopathy w gangrene
 ;;^UTILITY(U,$J,358.3,892,1,4,0)
 ;;=4^E10.52
 ;;^UTILITY(U,$J,358.3,892,2)
 ;;=^5002611
 ;;^UTILITY(U,$J,358.3,893,0)
 ;;=E11.649^^3^33^18
 ;;^UTILITY(U,$J,358.3,893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,893,1,3,0)
 ;;=3^Type 2 diab w hypoglycemia without coma
 ;;^UTILITY(U,$J,358.3,893,1,4,0)
 ;;=4^E11.649
 ;;^UTILITY(U,$J,358.3,893,2)
 ;;=^5002662
 ;;^UTILITY(U,$J,358.3,894,0)
 ;;=E11.641^^3^33^17
 ;;^UTILITY(U,$J,358.3,894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,894,1,3,0)
 ;;=3^Type 2 diab w hypoglycemia with coma
 ;;^UTILITY(U,$J,358.3,894,1,4,0)
 ;;=4^E11.641
 ;;^UTILITY(U,$J,358.3,894,2)
 ;;=^5002661
 ;;^UTILITY(U,$J,358.3,895,0)
 ;;=E11.9^^3^34^2
 ;;^UTILITY(U,$J,358.3,895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,895,1,3,0)
 ;;=3^Type 2 diabetes mellitus without complications
 ;;^UTILITY(U,$J,358.3,895,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,895,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,896,0)
 ;;=E10.9^^3^34^1
 ;;^UTILITY(U,$J,358.3,896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,896,1,3,0)
 ;;=3^Type 1 diabetes mellitus without complications
 ;;^UTILITY(U,$J,358.3,896,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,896,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,897,0)
 ;;=J02.0^^3^35^115
 ;;^UTILITY(U,$J,358.3,897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,897,1,3,0)
 ;;=3^Streptococcal pharyngitis
 ;;^UTILITY(U,$J,358.3,897,1,4,0)
 ;;=4^J02.0
 ;;^UTILITY(U,$J,358.3,897,2)
 ;;=^114607
 ;;^UTILITY(U,$J,358.3,898,0)
 ;;=J03.00^^3^35^13
 ;;^UTILITY(U,$J,358.3,898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,898,1,3,0)
 ;;=3^Acute streptococcal tonsillitis, unspecified
 ;;^UTILITY(U,$J,358.3,898,1,4,0)
 ;;=4^J03.00
 ;;^UTILITY(U,$J,358.3,898,2)
 ;;=^5008131
 ;;^UTILITY(U,$J,358.3,899,0)
 ;;=B37.0^^3^35^33
 ;;^UTILITY(U,$J,358.3,899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,899,1,3,0)
 ;;=3^Candidal stomatitis
 ;;^UTILITY(U,$J,358.3,899,1,4,0)
 ;;=4^B37.0
 ;;^UTILITY(U,$J,358.3,899,2)
 ;;=^5000612
 ;;^UTILITY(U,$J,358.3,900,0)
 ;;=B37.83^^3^35^32
 ;;^UTILITY(U,$J,358.3,900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,900,1,3,0)
 ;;=3^Candidal cheilitis
