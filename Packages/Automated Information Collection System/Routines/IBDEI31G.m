IBDEI31G ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50940,1,3,0)
 ;;=3^Disorders of tendon, lft wrist, oth, spec
 ;;^UTILITY(U,$J,358.3,50940,1,4,0)
 ;;=4^M67.834
 ;;^UTILITY(U,$J,358.3,50940,2)
 ;;=^5012997
 ;;^UTILITY(U,$J,358.3,50941,0)
 ;;=M67.841^^222^2466^115
 ;;^UTILITY(U,$J,358.3,50941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50941,1,3,0)
 ;;=3^Disorders of synovium, rt hand, oth, spec
 ;;^UTILITY(U,$J,358.3,50941,1,4,0)
 ;;=4^M67.841
 ;;^UTILITY(U,$J,358.3,50941,2)
 ;;=^5012999
 ;;^UTILITY(U,$J,358.3,50942,0)
 ;;=M67.842^^222^2466^108
 ;;^UTILITY(U,$J,358.3,50942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50942,1,3,0)
 ;;=3^Disorders of synovium, lft hand, oth, spec
 ;;^UTILITY(U,$J,358.3,50942,1,4,0)
 ;;=4^M67.842
 ;;^UTILITY(U,$J,358.3,50942,2)
 ;;=^5013000
 ;;^UTILITY(U,$J,358.3,50943,0)
 ;;=M67.843^^222^2466^129
 ;;^UTILITY(U,$J,358.3,50943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50943,1,3,0)
 ;;=3^Disorders of tendon, rt hand, oth, spec
 ;;^UTILITY(U,$J,358.3,50943,1,4,0)
 ;;=4^M67.843
 ;;^UTILITY(U,$J,358.3,50943,2)
 ;;=^5013001
 ;;^UTILITY(U,$J,358.3,50944,0)
 ;;=M67.844^^222^2466^122
 ;;^UTILITY(U,$J,358.3,50944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50944,1,3,0)
 ;;=3^Disorders of tendon, lft hand, oth, spec
 ;;^UTILITY(U,$J,358.3,50944,1,4,0)
 ;;=4^M67.844
 ;;^UTILITY(U,$J,358.3,50944,2)
 ;;=^5013002
 ;;^UTILITY(U,$J,358.3,50945,0)
 ;;=M67.851^^222^2466^116
 ;;^UTILITY(U,$J,358.3,50945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50945,1,3,0)
 ;;=3^Disorders of synovium, rt hip, oth, spec
 ;;^UTILITY(U,$J,358.3,50945,1,4,0)
 ;;=4^M67.851
 ;;^UTILITY(U,$J,358.3,50945,2)
 ;;=^5013004
 ;;^UTILITY(U,$J,358.3,50946,0)
 ;;=M67.852^^222^2466^109
 ;;^UTILITY(U,$J,358.3,50946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50946,1,3,0)
 ;;=3^Disorders of synovium, lft hip, oth, spec
 ;;^UTILITY(U,$J,358.3,50946,1,4,0)
 ;;=4^M67.852
 ;;^UTILITY(U,$J,358.3,50946,2)
 ;;=^5013005
 ;;^UTILITY(U,$J,358.3,50947,0)
 ;;=M67.853^^222^2466^130
 ;;^UTILITY(U,$J,358.3,50947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50947,1,3,0)
 ;;=3^Disorders of tendon, rt hip, oth, spec
 ;;^UTILITY(U,$J,358.3,50947,1,4,0)
 ;;=4^M67.853
 ;;^UTILITY(U,$J,358.3,50947,2)
 ;;=^5013006
 ;;^UTILITY(U,$J,358.3,50948,0)
 ;;=M67.854^^222^2466^123
 ;;^UTILITY(U,$J,358.3,50948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50948,1,3,0)
 ;;=3^Disorders of tendon, lft hip, oth, spec
 ;;^UTILITY(U,$J,358.3,50948,1,4,0)
 ;;=4^M67.854
 ;;^UTILITY(U,$J,358.3,50948,2)
 ;;=^5013007
 ;;^UTILITY(U,$J,358.3,50949,0)
 ;;=M67.861^^222^2466^117
 ;;^UTILITY(U,$J,358.3,50949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50949,1,3,0)
 ;;=3^Disorders of synovium, rt knee, oth, spec
 ;;^UTILITY(U,$J,358.3,50949,1,4,0)
 ;;=4^M67.861
 ;;^UTILITY(U,$J,358.3,50949,2)
 ;;=^5013009
 ;;^UTILITY(U,$J,358.3,50950,0)
 ;;=M67.862^^222^2466^110
 ;;^UTILITY(U,$J,358.3,50950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50950,1,3,0)
 ;;=3^Disorders of synovium, lft knee
 ;;^UTILITY(U,$J,358.3,50950,1,4,0)
 ;;=4^M67.862
 ;;^UTILITY(U,$J,358.3,50950,2)
 ;;=^5013010
 ;;^UTILITY(U,$J,358.3,50951,0)
 ;;=M67.863^^222^2466^131
 ;;^UTILITY(U,$J,358.3,50951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50951,1,3,0)
 ;;=3^Disorders of tendon, rt knee, oth, spec
 ;;^UTILITY(U,$J,358.3,50951,1,4,0)
 ;;=4^M67.863
 ;;^UTILITY(U,$J,358.3,50951,2)
 ;;=^5013011
 ;;^UTILITY(U,$J,358.3,50952,0)
 ;;=M67.864^^222^2466^124
 ;;^UTILITY(U,$J,358.3,50952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50952,1,3,0)
 ;;=3^Disorders of tendon, lft knee, oth, spec
 ;;^UTILITY(U,$J,358.3,50952,1,4,0)
 ;;=4^M67.864
