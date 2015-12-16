IBDEI1RS ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31255,1,3,0)
 ;;=3^Tinnitus, right ear
 ;;^UTILITY(U,$J,358.3,31255,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,31255,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,31256,0)
 ;;=M48.12^^180^1951^1
 ;;^UTILITY(U,$J,358.3,31256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31256,1,3,0)
 ;;=3^Ankylosing hyperostosis [Forestier], cervical region
 ;;^UTILITY(U,$J,358.3,31256,1,4,0)
 ;;=4^M48.12
 ;;^UTILITY(U,$J,358.3,31256,2)
 ;;=^5012098
 ;;^UTILITY(U,$J,358.3,31257,0)
 ;;=M48.16^^180^1951^3
 ;;^UTILITY(U,$J,358.3,31257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31257,1,3,0)
 ;;=3^Ankylosing hyperostosis [Forestier], lumbar region
 ;;^UTILITY(U,$J,358.3,31257,1,4,0)
 ;;=4^M48.16
 ;;^UTILITY(U,$J,358.3,31257,2)
 ;;=^5012102
 ;;^UTILITY(U,$J,358.3,31258,0)
 ;;=M48.17^^180^1951^4
 ;;^UTILITY(U,$J,358.3,31258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31258,1,3,0)
 ;;=3^Ankylosing hyperostosis [Forestier], lumbosacral region
 ;;^UTILITY(U,$J,358.3,31258,1,4,0)
 ;;=4^M48.17
 ;;^UTILITY(U,$J,358.3,31258,2)
 ;;=^5012103
 ;;^UTILITY(U,$J,358.3,31259,0)
 ;;=M48.19^^180^1951^5
 ;;^UTILITY(U,$J,358.3,31259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31259,1,3,0)
 ;;=3^Ankylosing hyperostosis [Forestier], multiple sites in spine
 ;;^UTILITY(U,$J,358.3,31259,1,4,0)
 ;;=4^M48.19
 ;;^UTILITY(U,$J,358.3,31259,2)
 ;;=^5012105
 ;;^UTILITY(U,$J,358.3,31260,0)
 ;;=M48.11^^180^1951^8
 ;;^UTILITY(U,$J,358.3,31260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31260,1,3,0)
 ;;=3^Ankylosing hyperostosis, occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,31260,1,4,0)
 ;;=4^M48.11
 ;;^UTILITY(U,$J,358.3,31260,2)
 ;;=^5012097
 ;;^UTILITY(U,$J,358.3,31261,0)
 ;;=M48.18^^180^1951^9
 ;;^UTILITY(U,$J,358.3,31261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31261,1,3,0)
 ;;=3^Ankylosing hyperostosis, sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,31261,1,4,0)
 ;;=4^M48.18
 ;;^UTILITY(U,$J,358.3,31261,2)
 ;;=^5012104
 ;;^UTILITY(U,$J,358.3,31262,0)
 ;;=M48.15^^180^1951^6
 ;;^UTILITY(U,$J,358.3,31262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31262,1,3,0)
 ;;=3^Ankylosing hyperostosis [Forestier], thoracolumbar region
 ;;^UTILITY(U,$J,358.3,31262,1,4,0)
 ;;=4^M48.15
 ;;^UTILITY(U,$J,358.3,31262,2)
 ;;=^5012101
 ;;^UTILITY(U,$J,358.3,31263,0)
 ;;=M48.13^^180^1951^2
 ;;^UTILITY(U,$J,358.3,31263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31263,1,3,0)
 ;;=3^Ankylosing hyperostosis [Forestier], cervicothoracic region
 ;;^UTILITY(U,$J,358.3,31263,1,4,0)
 ;;=4^M48.13
 ;;^UTILITY(U,$J,358.3,31263,2)
 ;;=^5012099
 ;;^UTILITY(U,$J,358.3,31264,0)
 ;;=M48.14^^180^1951^7
 ;;^UTILITY(U,$J,358.3,31264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31264,1,3,0)
 ;;=3^Ankylosing hyperostosis [Forestier], thoracic region
 ;;^UTILITY(U,$J,358.3,31264,1,4,0)
 ;;=4^M48.14
 ;;^UTILITY(U,$J,358.3,31264,2)
 ;;=^5012100
 ;;^UTILITY(U,$J,358.3,31265,0)
 ;;=M45.2^^180^1951^10
 ;;^UTILITY(U,$J,358.3,31265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31265,1,3,0)
 ;;=3^Ankylosing spondylitis of cervical region
 ;;^UTILITY(U,$J,358.3,31265,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,31265,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,31266,0)
 ;;=M45.3^^180^1951^11
 ;;^UTILITY(U,$J,358.3,31266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31266,1,3,0)
 ;;=3^Ankylosing spondylitis of cervicothoracic region
 ;;^UTILITY(U,$J,358.3,31266,1,4,0)
 ;;=4^M45.3
 ;;^UTILITY(U,$J,358.3,31266,2)
 ;;=^5011963
 ;;^UTILITY(U,$J,358.3,31267,0)
 ;;=M45.7^^180^1951^13
 ;;^UTILITY(U,$J,358.3,31267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31267,1,3,0)
 ;;=3^Ankylosing spondylitis of lumbosacral region
