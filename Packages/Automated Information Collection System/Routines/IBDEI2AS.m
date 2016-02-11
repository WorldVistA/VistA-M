IBDEI2AS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38595,1,4,0)
 ;;=4^H90.8
 ;;^UTILITY(U,$J,358.3,38595,2)
 ;;=^5006927
 ;;^UTILITY(U,$J,358.3,38596,0)
 ;;=H90.3^^180^1979^8
 ;;^UTILITY(U,$J,358.3,38596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38596,1,3,0)
 ;;=3^Snsrnrl hear loss, bilateral
 ;;^UTILITY(U,$J,358.3,38596,1,4,0)
 ;;=4^H90.3
 ;;^UTILITY(U,$J,358.3,38596,2)
 ;;=^335328
 ;;^UTILITY(U,$J,358.3,38597,0)
 ;;=H90.42^^180^1979^9
 ;;^UTILITY(U,$J,358.3,38597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38597,1,3,0)
 ;;=3^Snsrnrl hear loss, left ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,38597,1,4,0)
 ;;=4^H90.42
 ;;^UTILITY(U,$J,358.3,38597,2)
 ;;=^5006922
 ;;^UTILITY(U,$J,358.3,38598,0)
 ;;=H90.41^^180^1979^10
 ;;^UTILITY(U,$J,358.3,38598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38598,1,3,0)
 ;;=3^Snsrnrl hear loss, right ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,38598,1,4,0)
 ;;=4^H90.41
 ;;^UTILITY(U,$J,358.3,38598,2)
 ;;=^5006921
 ;;^UTILITY(U,$J,358.3,38599,0)
 ;;=H93.13^^180^1979^11
 ;;^UTILITY(U,$J,358.3,38599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38599,1,3,0)
 ;;=3^Tinnitus, bilateral
 ;;^UTILITY(U,$J,358.3,38599,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,38599,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,38600,0)
 ;;=H93.12^^180^1979^12
 ;;^UTILITY(U,$J,358.3,38600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38600,1,3,0)
 ;;=3^Tinnitus, left ear
 ;;^UTILITY(U,$J,358.3,38600,1,4,0)
 ;;=4^H93.12
 ;;^UTILITY(U,$J,358.3,38600,2)
 ;;=^5006965
 ;;^UTILITY(U,$J,358.3,38601,0)
 ;;=H93.11^^180^1979^13
 ;;^UTILITY(U,$J,358.3,38601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38601,1,3,0)
 ;;=3^Tinnitus, right ear
 ;;^UTILITY(U,$J,358.3,38601,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,38601,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,38602,0)
 ;;=M48.12^^180^1980^1
 ;;^UTILITY(U,$J,358.3,38602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38602,1,3,0)
 ;;=3^Ankylosing hyperostosis, cervical region
 ;;^UTILITY(U,$J,358.3,38602,1,4,0)
 ;;=4^M48.12
 ;;^UTILITY(U,$J,358.3,38602,2)
 ;;=^5012098
 ;;^UTILITY(U,$J,358.3,38603,0)
 ;;=M48.16^^180^1980^3
 ;;^UTILITY(U,$J,358.3,38603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38603,1,3,0)
 ;;=3^Ankylosing hyperostosis, lumbar region
 ;;^UTILITY(U,$J,358.3,38603,1,4,0)
 ;;=4^M48.16
 ;;^UTILITY(U,$J,358.3,38603,2)
 ;;=^5012102
 ;;^UTILITY(U,$J,358.3,38604,0)
 ;;=M48.17^^180^1980^4
 ;;^UTILITY(U,$J,358.3,38604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38604,1,3,0)
 ;;=3^Ankylosing hyperostosis, lumbosacral region
 ;;^UTILITY(U,$J,358.3,38604,1,4,0)
 ;;=4^M48.17
 ;;^UTILITY(U,$J,358.3,38604,2)
 ;;=^5012103
 ;;^UTILITY(U,$J,358.3,38605,0)
 ;;=M48.19^^180^1980^5
 ;;^UTILITY(U,$J,358.3,38605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38605,1,3,0)
 ;;=3^Ankylosing hyperostosis, multiple sites in spine
 ;;^UTILITY(U,$J,358.3,38605,1,4,0)
 ;;=4^M48.19
 ;;^UTILITY(U,$J,358.3,38605,2)
 ;;=^5012105
 ;;^UTILITY(U,$J,358.3,38606,0)
 ;;=M48.11^^180^1980^6
 ;;^UTILITY(U,$J,358.3,38606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38606,1,3,0)
 ;;=3^Ankylosing hyperostosis, occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,38606,1,4,0)
 ;;=4^M48.11
 ;;^UTILITY(U,$J,358.3,38606,2)
 ;;=^5012097
 ;;^UTILITY(U,$J,358.3,38607,0)
 ;;=M48.18^^180^1980^7
 ;;^UTILITY(U,$J,358.3,38607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38607,1,3,0)
 ;;=3^Ankylosing hyperostosis, sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,38607,1,4,0)
 ;;=4^M48.18
 ;;^UTILITY(U,$J,358.3,38607,2)
 ;;=^5012104
 ;;^UTILITY(U,$J,358.3,38608,0)
 ;;=M48.15^^180^1980^9
 ;;^UTILITY(U,$J,358.3,38608,1,0)
 ;;=^358.31IA^4^2
