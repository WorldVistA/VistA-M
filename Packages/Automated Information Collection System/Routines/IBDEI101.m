IBDEI101 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16945,1,4,0)
 ;;=4^M79.604
 ;;^UTILITY(U,$J,358.3,16945,2)
 ;;=^5013328
 ;;^UTILITY(U,$J,358.3,16946,0)
 ;;=M79.605^^70^798^19
 ;;^UTILITY(U,$J,358.3,16946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16946,1,3,0)
 ;;=3^Pain in left leg
 ;;^UTILITY(U,$J,358.3,16946,1,4,0)
 ;;=4^M79.605
 ;;^UTILITY(U,$J,358.3,16946,2)
 ;;=^5013329
 ;;^UTILITY(U,$J,358.3,16947,0)
 ;;=F60.2^^70^799^1
 ;;^UTILITY(U,$J,358.3,16947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16947,1,3,0)
 ;;=3^Antisocial personality disorder
 ;;^UTILITY(U,$J,358.3,16947,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,16947,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,16948,0)
 ;;=F60.6^^70^799^2
 ;;^UTILITY(U,$J,358.3,16948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16948,1,3,0)
 ;;=3^Avoidant personality disorder
 ;;^UTILITY(U,$J,358.3,16948,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,16948,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,16949,0)
 ;;=F60.3^^70^799^3
 ;;^UTILITY(U,$J,358.3,16949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16949,1,3,0)
 ;;=3^Borderline personality disorder
 ;;^UTILITY(U,$J,358.3,16949,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,16949,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,16950,0)
 ;;=F34.0^^70^799^4
 ;;^UTILITY(U,$J,358.3,16950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16950,1,3,0)
 ;;=3^Cyclothymic disorder
 ;;^UTILITY(U,$J,358.3,16950,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,16950,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,16951,0)
 ;;=F60.7^^70^799^5
 ;;^UTILITY(U,$J,358.3,16951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16951,1,3,0)
 ;;=3^Dependent personality disorder
 ;;^UTILITY(U,$J,358.3,16951,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,16951,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,16952,0)
 ;;=F60.4^^70^799^6
 ;;^UTILITY(U,$J,358.3,16952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16952,1,3,0)
 ;;=3^Histrionic personality disorder
 ;;^UTILITY(U,$J,358.3,16952,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,16952,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,16953,0)
 ;;=F60.81^^70^799^7
 ;;^UTILITY(U,$J,358.3,16953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16953,1,3,0)
 ;;=3^Narcissistic personality disorder
 ;;^UTILITY(U,$J,358.3,16953,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,16953,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,16954,0)
 ;;=F60.5^^70^799^8
 ;;^UTILITY(U,$J,358.3,16954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16954,1,3,0)
 ;;=3^Obsessive-compulsive personality disorder
 ;;^UTILITY(U,$J,358.3,16954,1,4,0)
 ;;=4^F60.5
 ;;^UTILITY(U,$J,358.3,16954,2)
 ;;=^331918
 ;;^UTILITY(U,$J,358.3,16955,0)
 ;;=F60.0^^70^799^9
 ;;^UTILITY(U,$J,358.3,16955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16955,1,3,0)
 ;;=3^Paranoid personality disorder
 ;;^UTILITY(U,$J,358.3,16955,1,4,0)
 ;;=4^F60.0
 ;;^UTILITY(U,$J,358.3,16955,2)
 ;;=^5003635
 ;;^UTILITY(U,$J,358.3,16956,0)
 ;;=F60.89^^70^799^10
 ;;^UTILITY(U,$J,358.3,16956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16956,1,3,0)
 ;;=3^Personality disorders, spec, other
 ;;^UTILITY(U,$J,358.3,16956,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,16956,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,16957,0)
 ;;=F60.1^^70^799^11
 ;;^UTILITY(U,$J,358.3,16957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16957,1,3,0)
 ;;=3^Schizoid personality disorder
 ;;^UTILITY(U,$J,358.3,16957,1,4,0)
 ;;=4^F60.1
 ;;^UTILITY(U,$J,358.3,16957,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,16958,0)
 ;;=F21.^^70^799^12
 ;;^UTILITY(U,$J,358.3,16958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16958,1,3,0)
 ;;=3^Schizotypal disorder
 ;;^UTILITY(U,$J,358.3,16958,1,4,0)
 ;;=4^F21.
 ;;^UTILITY(U,$J,358.3,16958,2)
 ;;=^5003477
