IBDEI0RP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12713,1,4,0)
 ;;=4^H71.92
 ;;^UTILITY(U,$J,358.3,12713,2)
 ;;=^5006740
 ;;^UTILITY(U,$J,358.3,12714,0)
 ;;=H91.21^^77^737^57
 ;;^UTILITY(U,$J,358.3,12714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12714,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, right ear
 ;;^UTILITY(U,$J,358.3,12714,1,4,0)
 ;;=4^H91.21
 ;;^UTILITY(U,$J,358.3,12714,2)
 ;;=^5006937
 ;;^UTILITY(U,$J,358.3,12715,0)
 ;;=H91.22^^77^737^56
 ;;^UTILITY(U,$J,358.3,12715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12715,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, left ear
 ;;^UTILITY(U,$J,358.3,12715,1,4,0)
 ;;=4^H91.22
 ;;^UTILITY(U,$J,358.3,12715,2)
 ;;=^5006938
 ;;^UTILITY(U,$J,358.3,12716,0)
 ;;=H90.0^^77^737^21
 ;;^UTILITY(U,$J,358.3,12716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12716,1,3,0)
 ;;=3^Conductive hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,12716,1,4,0)
 ;;=4^H90.0
 ;;^UTILITY(U,$J,358.3,12716,2)
 ;;=^335257
 ;;^UTILITY(U,$J,358.3,12717,0)
 ;;=H90.11^^77^737^20
 ;;^UTILITY(U,$J,358.3,12717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12717,1,3,0)
 ;;=3^Condctv hear loss, uni, right ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,12717,1,4,0)
 ;;=4^H90.11
 ;;^UTILITY(U,$J,358.3,12717,2)
 ;;=^5006918
 ;;^UTILITY(U,$J,358.3,12718,0)
 ;;=H90.12^^77^737^19
 ;;^UTILITY(U,$J,358.3,12718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12718,1,3,0)
 ;;=3^Condctv hear loss, uni, left ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,12718,1,4,0)
 ;;=4^H90.12
 ;;^UTILITY(U,$J,358.3,12718,2)
 ;;=^5006919
 ;;^UTILITY(U,$J,358.3,12719,0)
 ;;=H90.3^^77^737^53
 ;;^UTILITY(U,$J,358.3,12719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12719,1,3,0)
 ;;=3^Sensorineural hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,12719,1,4,0)
 ;;=4^H90.3
 ;;^UTILITY(U,$J,358.3,12719,2)
 ;;=^335328
 ;;^UTILITY(U,$J,358.3,12720,0)
 ;;=H90.41^^77^737^55
 ;;^UTILITY(U,$J,358.3,12720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12720,1,3,0)
 ;;=3^Snsrnrl hear loss, uni, right ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,12720,1,4,0)
 ;;=4^H90.41
 ;;^UTILITY(U,$J,358.3,12720,2)
 ;;=^5006921
 ;;^UTILITY(U,$J,358.3,12721,0)
 ;;=H90.42^^77^737^54
 ;;^UTILITY(U,$J,358.3,12721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12721,1,3,0)
 ;;=3^Snsrnrl hear loss, uni, left ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,12721,1,4,0)
 ;;=4^H90.42
 ;;^UTILITY(U,$J,358.3,12721,2)
 ;;=^5006922
 ;;^UTILITY(U,$J,358.3,12722,0)
 ;;=H90.6^^77^737^44
 ;;^UTILITY(U,$J,358.3,12722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12722,1,3,0)
 ;;=3^Mixed conductive and sensorineural hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,12722,1,4,0)
 ;;=4^H90.6
 ;;^UTILITY(U,$J,358.3,12722,2)
 ;;=^5006924
 ;;^UTILITY(U,$J,358.3,12723,0)
 ;;=H90.71^^77^737^43
 ;;^UTILITY(U,$J,358.3,12723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12723,1,3,0)
 ;;=3^Mix cndct/snrl hear loss,uni,r ear,w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,12723,1,4,0)
 ;;=4^H90.71
 ;;^UTILITY(U,$J,358.3,12723,2)
 ;;=^5006925
 ;;^UTILITY(U,$J,358.3,12724,0)
 ;;=H90.72^^77^737^42
 ;;^UTILITY(U,$J,358.3,12724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12724,1,3,0)
 ;;=3^Mix cndct/snrl hear loss,uni,l ear,w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,12724,1,4,0)
 ;;=4^H90.72
 ;;^UTILITY(U,$J,358.3,12724,2)
 ;;=^5006926
 ;;^UTILITY(U,$J,358.3,12725,0)
 ;;=H61.001^^77^737^50
 ;;^UTILITY(U,$J,358.3,12725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12725,1,3,0)
 ;;=3^Perichondritis of right external ear
 ;;^UTILITY(U,$J,358.3,12725,1,4,0)
 ;;=4^H61.001
