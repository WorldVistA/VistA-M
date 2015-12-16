IBDEI018 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13,2)
 ;;=^5006984
 ;;^UTILITY(U,$J,358.3,14,0)
 ;;=H93.223^^1^2^9
 ;;^UTILITY(U,$J,358.3,14,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14,1,3,0)
 ;;=3^Diplacusis, bilateral
 ;;^UTILITY(U,$J,358.3,14,1,4,0)
 ;;=4^H93.223
 ;;^UTILITY(U,$J,358.3,14,2)
 ;;=^5006974
 ;;^UTILITY(U,$J,358.3,15,0)
 ;;=H93.222^^1^2^10
 ;;^UTILITY(U,$J,358.3,15,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15,1,3,0)
 ;;=3^Diplacusis, left ear
 ;;^UTILITY(U,$J,358.3,15,1,4,0)
 ;;=4^H93.222
 ;;^UTILITY(U,$J,358.3,15,2)
 ;;=^5006973
 ;;^UTILITY(U,$J,358.3,16,0)
 ;;=H93.221^^1^2^11
 ;;^UTILITY(U,$J,358.3,16,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16,1,3,0)
 ;;=3^Diplacusis, right ear
 ;;^UTILITY(U,$J,358.3,16,1,4,0)
 ;;=4^H93.221
 ;;^UTILITY(U,$J,358.3,16,2)
 ;;=^5006972
 ;;^UTILITY(U,$J,358.3,17,0)
 ;;=R42.^^1^2^12
 ;;^UTILITY(U,$J,358.3,17,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,17,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,17,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,18,0)
 ;;=Z45.49^^1^2^4
 ;;^UTILITY(U,$J,358.3,18,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18,1,3,0)
 ;;=3^Adjust/Mgmt of Implanted Nervous System Device
 ;;^UTILITY(U,$J,358.3,18,1,4,0)
 ;;=4^Z45.49
 ;;^UTILITY(U,$J,358.3,18,2)
 ;;=^5063006
 ;;^UTILITY(U,$J,358.3,19,0)
 ;;=Z46.1^^1^2^17
 ;;^UTILITY(U,$J,358.3,19,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19,1,3,0)
 ;;=3^Fit/Adjust of Hearing Aid
 ;;^UTILITY(U,$J,358.3,19,1,4,0)
 ;;=4^Z46.1
 ;;^UTILITY(U,$J,358.3,19,2)
 ;;=^5063014
 ;;^UTILITY(U,$J,358.3,20,0)
 ;;=Z46.2^^1^2^15
 ;;^UTILITY(U,$J,358.3,20,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20,1,3,0)
 ;;=3^Fit/Adjust Device Rel to Nervous System/Special Senses
 ;;^UTILITY(U,$J,358.3,20,1,4,0)
 ;;=4^Z46.2
 ;;^UTILITY(U,$J,358.3,20,2)
 ;;=^5063015
 ;;^UTILITY(U,$J,358.3,21,0)
 ;;=Z44.8^^1^2^16
 ;;^UTILITY(U,$J,358.3,21,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21,1,3,0)
 ;;=3^Fit/Adjust of External Prosthetic Devices
 ;;^UTILITY(U,$J,358.3,21,1,4,0)
 ;;=4^Z44.8
 ;;^UTILITY(U,$J,358.3,21,2)
 ;;=^5062992
 ;;^UTILITY(U,$J,358.3,22,0)
 ;;=Z82.2^^1^2^13
 ;;^UTILITY(U,$J,358.3,22,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22,1,3,0)
 ;;=3^Family history of deafness and hearing loss
 ;;^UTILITY(U,$J,358.3,22,1,4,0)
 ;;=4^Z82.2
 ;;^UTILITY(U,$J,358.3,22,2)
 ;;=^5063366
 ;;^UTILITY(U,$J,358.3,23,0)
 ;;=Z83.52^^1^2^14
 ;;^UTILITY(U,$J,358.3,23,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23,1,3,0)
 ;;=3^Family history of ear disorders
 ;;^UTILITY(U,$J,358.3,23,1,4,0)
 ;;=4^Z83.52
 ;;^UTILITY(U,$J,358.3,23,2)
 ;;=^5063384
 ;;^UTILITY(U,$J,358.3,24,0)
 ;;=H93.233^^1^2^18
 ;;^UTILITY(U,$J,358.3,24,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24,1,3,0)
 ;;=3^Hyperacusis, bilateral
 ;;^UTILITY(U,$J,358.3,24,1,4,0)
 ;;=4^H93.233
 ;;^UTILITY(U,$J,358.3,24,2)
 ;;=^5006978
 ;;^UTILITY(U,$J,358.3,25,0)
 ;;=H93.232^^1^2^19
 ;;^UTILITY(U,$J,358.3,25,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25,1,3,0)
 ;;=3^Hyperacusis, left ear
 ;;^UTILITY(U,$J,358.3,25,1,4,0)
 ;;=4^H93.232
 ;;^UTILITY(U,$J,358.3,25,2)
 ;;=^5006977
 ;;^UTILITY(U,$J,358.3,26,0)
 ;;=H93.231^^1^2^20
 ;;^UTILITY(U,$J,358.3,26,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26,1,3,0)
 ;;=3^Hyperacusis, right ear
 ;;^UTILITY(U,$J,358.3,26,1,4,0)
 ;;=4^H93.231
 ;;^UTILITY(U,$J,358.3,26,2)
 ;;=^5006976
 ;;^UTILITY(U,$J,358.3,27,0)
 ;;=H92.03^^1^2^22
 ;;^UTILITY(U,$J,358.3,27,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27,1,3,0)
 ;;=3^Otalgia, bilateral
 ;;^UTILITY(U,$J,358.3,27,1,4,0)
 ;;=4^H92.03
 ;;^UTILITY(U,$J,358.3,27,2)
 ;;=^5006947
