IBDEI0IH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8579,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, left ear
 ;;^UTILITY(U,$J,358.3,8579,1,4,0)
 ;;=4^H91.22
 ;;^UTILITY(U,$J,358.3,8579,2)
 ;;=^5006938
 ;;^UTILITY(U,$J,358.3,8580,0)
 ;;=H90.0^^39^462^21
 ;;^UTILITY(U,$J,358.3,8580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8580,1,3,0)
 ;;=3^Conductive hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,8580,1,4,0)
 ;;=4^H90.0
 ;;^UTILITY(U,$J,358.3,8580,2)
 ;;=^335257
 ;;^UTILITY(U,$J,358.3,8581,0)
 ;;=H90.11^^39^462^20
 ;;^UTILITY(U,$J,358.3,8581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8581,1,3,0)
 ;;=3^Condctv hear loss, uni, right ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,8581,1,4,0)
 ;;=4^H90.11
 ;;^UTILITY(U,$J,358.3,8581,2)
 ;;=^5006918
 ;;^UTILITY(U,$J,358.3,8582,0)
 ;;=H90.12^^39^462^19
 ;;^UTILITY(U,$J,358.3,8582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8582,1,3,0)
 ;;=3^Condctv hear loss, uni, left ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,8582,1,4,0)
 ;;=4^H90.12
 ;;^UTILITY(U,$J,358.3,8582,2)
 ;;=^5006919
 ;;^UTILITY(U,$J,358.3,8583,0)
 ;;=H90.3^^39^462^53
 ;;^UTILITY(U,$J,358.3,8583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8583,1,3,0)
 ;;=3^Sensorineural hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,8583,1,4,0)
 ;;=4^H90.3
 ;;^UTILITY(U,$J,358.3,8583,2)
 ;;=^335328
 ;;^UTILITY(U,$J,358.3,8584,0)
 ;;=H90.41^^39^462^55
 ;;^UTILITY(U,$J,358.3,8584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8584,1,3,0)
 ;;=3^Snsrnrl hear loss, uni, right ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,8584,1,4,0)
 ;;=4^H90.41
 ;;^UTILITY(U,$J,358.3,8584,2)
 ;;=^5006921
 ;;^UTILITY(U,$J,358.3,8585,0)
 ;;=H90.42^^39^462^54
 ;;^UTILITY(U,$J,358.3,8585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8585,1,3,0)
 ;;=3^Snsrnrl hear loss, uni, left ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,8585,1,4,0)
 ;;=4^H90.42
 ;;^UTILITY(U,$J,358.3,8585,2)
 ;;=^5006922
 ;;^UTILITY(U,$J,358.3,8586,0)
 ;;=H90.6^^39^462^44
 ;;^UTILITY(U,$J,358.3,8586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8586,1,3,0)
 ;;=3^Mixed conductive and sensorineural hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,8586,1,4,0)
 ;;=4^H90.6
 ;;^UTILITY(U,$J,358.3,8586,2)
 ;;=^5006924
 ;;^UTILITY(U,$J,358.3,8587,0)
 ;;=H90.71^^39^462^43
 ;;^UTILITY(U,$J,358.3,8587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8587,1,3,0)
 ;;=3^Mix cndct/snrl hear loss,uni,r ear,w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,8587,1,4,0)
 ;;=4^H90.71
 ;;^UTILITY(U,$J,358.3,8587,2)
 ;;=^5006925
 ;;^UTILITY(U,$J,358.3,8588,0)
 ;;=H90.72^^39^462^42
 ;;^UTILITY(U,$J,358.3,8588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8588,1,3,0)
 ;;=3^Mix cndct/snrl hear loss,uni,l ear,w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,8588,1,4,0)
 ;;=4^H90.72
 ;;^UTILITY(U,$J,358.3,8588,2)
 ;;=^5006926
 ;;^UTILITY(U,$J,358.3,8589,0)
 ;;=H61.001^^39^462^50
 ;;^UTILITY(U,$J,358.3,8589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8589,1,3,0)
 ;;=3^Perichondritis of right external ear
 ;;^UTILITY(U,$J,358.3,8589,1,4,0)
 ;;=4^H61.001
 ;;^UTILITY(U,$J,358.3,8589,2)
 ;;=^5006499
 ;;^UTILITY(U,$J,358.3,8590,0)
 ;;=H61.002^^39^462^49
 ;;^UTILITY(U,$J,358.3,8590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8590,1,3,0)
 ;;=3^Perichondritis of left external ear
 ;;^UTILITY(U,$J,358.3,8590,1,4,0)
 ;;=4^H61.002
 ;;^UTILITY(U,$J,358.3,8590,2)
 ;;=^5006500
 ;;^UTILITY(U,$J,358.3,8591,0)
 ;;=H65.111^^39^462^8
 ;;^UTILITY(U,$J,358.3,8591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8591,1,3,0)
 ;;=3^Acute/subacute allergic otitis media, r ear
