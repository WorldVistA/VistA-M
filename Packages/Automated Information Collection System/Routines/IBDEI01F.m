IBDEI01F ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,110,1,4,0)
 ;;=4^T16.2XXA
 ;;^UTILITY(U,$J,358.3,110,2)
 ;;=^5046420
 ;;^UTILITY(U,$J,358.3,111,0)
 ;;=T16.2XXD^^1^6^3
 ;;^UTILITY(U,$J,358.3,111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,111,1,3,0)
 ;;=3^Foreign body in left ear, subsequent encounter
 ;;^UTILITY(U,$J,358.3,111,1,4,0)
 ;;=4^T16.2XXD
 ;;^UTILITY(U,$J,358.3,111,2)
 ;;=^5046421
 ;;^UTILITY(U,$J,358.3,112,0)
 ;;=T16.2XXS^^1^6^2
 ;;^UTILITY(U,$J,358.3,112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,112,1,3,0)
 ;;=3^Foreign body in left ear, sequela
 ;;^UTILITY(U,$J,358.3,112,1,4,0)
 ;;=4^T16.2XXS
 ;;^UTILITY(U,$J,358.3,112,2)
 ;;=^5046422
 ;;^UTILITY(U,$J,358.3,113,0)
 ;;=H90.0^^1^7^3
 ;;^UTILITY(U,$J,358.3,113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,113,1,3,0)
 ;;=3^Conductive hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,113,1,4,0)
 ;;=4^H90.0
 ;;^UTILITY(U,$J,358.3,113,2)
 ;;=^335257
 ;;^UTILITY(U,$J,358.3,114,0)
 ;;=H90.12^^1^7^1
 ;;^UTILITY(U,$J,358.3,114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,114,1,3,0)
 ;;=3^Condctv hear loss, uni, left ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,114,1,4,0)
 ;;=4^H90.12
 ;;^UTILITY(U,$J,358.3,114,2)
 ;;=^5006919
 ;;^UTILITY(U,$J,358.3,115,0)
 ;;=H90.11^^1^7^2
 ;;^UTILITY(U,$J,358.3,115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,115,1,3,0)
 ;;=3^Condctv hear loss, uni, right ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,115,1,4,0)
 ;;=4^H90.11
 ;;^UTILITY(U,$J,358.3,115,2)
 ;;=^5006918
 ;;^UTILITY(U,$J,358.3,116,0)
 ;;=H93.223^^1^7^4
 ;;^UTILITY(U,$J,358.3,116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,116,1,3,0)
 ;;=3^Diplacusis, bilateral
 ;;^UTILITY(U,$J,358.3,116,1,4,0)
 ;;=4^H93.223
 ;;^UTILITY(U,$J,358.3,116,2)
 ;;=^5006974
 ;;^UTILITY(U,$J,358.3,117,0)
 ;;=H93.222^^1^7^5
 ;;^UTILITY(U,$J,358.3,117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,117,1,3,0)
 ;;=3^Diplacusis, left ear
 ;;^UTILITY(U,$J,358.3,117,1,4,0)
 ;;=4^H93.222
 ;;^UTILITY(U,$J,358.3,117,2)
 ;;=^5006973
 ;;^UTILITY(U,$J,358.3,118,0)
 ;;=H93.221^^1^7^6
 ;;^UTILITY(U,$J,358.3,118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,118,1,3,0)
 ;;=3^Diplacusis, right ear
 ;;^UTILITY(U,$J,358.3,118,1,4,0)
 ;;=4^H93.221
 ;;^UTILITY(U,$J,358.3,118,2)
 ;;=^5006972
 ;;^UTILITY(U,$J,358.3,119,0)
 ;;=H91.8X3^^1^7^7
 ;;^UTILITY(U,$J,358.3,119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,119,1,3,0)
 ;;=3^Hearing Loss,Bilateral NEC
 ;;^UTILITY(U,$J,358.3,119,1,4,0)
 ;;=4^H91.8X3
 ;;^UTILITY(U,$J,358.3,119,2)
 ;;=^5006942
 ;;^UTILITY(U,$J,358.3,120,0)
 ;;=H91.8X2^^1^7^9
 ;;^UTILITY(U,$J,358.3,120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,120,1,3,0)
 ;;=3^Hearing Loss,Left Ear NEC
 ;;^UTILITY(U,$J,358.3,120,1,4,0)
 ;;=4^H91.8X2
 ;;^UTILITY(U,$J,358.3,120,2)
 ;;=^5133556
 ;;^UTILITY(U,$J,358.3,121,0)
 ;;=H91.8X1^^1^7^11
 ;;^UTILITY(U,$J,358.3,121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,121,1,3,0)
 ;;=3^Hearing Loss,Right Ear NEC
 ;;^UTILITY(U,$J,358.3,121,1,4,0)
 ;;=4^H91.8X1
 ;;^UTILITY(U,$J,358.3,121,2)
 ;;=^5006941
 ;;^UTILITY(U,$J,358.3,122,0)
 ;;=H91.03^^1^7^13
 ;;^UTILITY(U,$J,358.3,122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,122,1,3,0)
 ;;=3^Ototoxic hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,122,1,4,0)
 ;;=4^H91.03
 ;;^UTILITY(U,$J,358.3,122,2)
 ;;=^5006930
 ;;^UTILITY(U,$J,358.3,123,0)
 ;;=H91.02^^1^7^14
 ;;^UTILITY(U,$J,358.3,123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,123,1,3,0)
 ;;=3^Ototoxic hearing loss, left ear
 ;;^UTILITY(U,$J,358.3,123,1,4,0)
 ;;=4^H91.02
 ;;^UTILITY(U,$J,358.3,123,2)
 ;;=^5006929
 ;;^UTILITY(U,$J,358.3,124,0)
 ;;=H91.01^^1^7^15
 ;;^UTILITY(U,$J,358.3,124,1,0)
 ;;=^358.31IA^4^2
