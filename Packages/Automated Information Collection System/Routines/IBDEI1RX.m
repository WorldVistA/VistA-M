IBDEI1RX ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31318,0)
 ;;=M12.521^^180^1951^63
 ;;^UTILITY(U,$J,358.3,31318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31318,1,3,0)
 ;;=3^Traumatic arthropathy, right elbow
 ;;^UTILITY(U,$J,358.3,31318,1,4,0)
 ;;=4^M12.521
 ;;^UTILITY(U,$J,358.3,31318,2)
 ;;=^5010622
 ;;^UTILITY(U,$J,358.3,31319,0)
 ;;=M12.541^^180^1951^64
 ;;^UTILITY(U,$J,358.3,31319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31319,1,3,0)
 ;;=3^Traumatic arthropathy, right hand
 ;;^UTILITY(U,$J,358.3,31319,1,4,0)
 ;;=4^M12.541
 ;;^UTILITY(U,$J,358.3,31319,2)
 ;;=^5010628
 ;;^UTILITY(U,$J,358.3,31320,0)
 ;;=M12.551^^180^1951^65
 ;;^UTILITY(U,$J,358.3,31320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31320,1,3,0)
 ;;=3^Traumatic arthropathy, right hip
 ;;^UTILITY(U,$J,358.3,31320,1,4,0)
 ;;=4^M12.551
 ;;^UTILITY(U,$J,358.3,31320,2)
 ;;=^5010631
 ;;^UTILITY(U,$J,358.3,31321,0)
 ;;=M12.561^^180^1951^66
 ;;^UTILITY(U,$J,358.3,31321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31321,1,3,0)
 ;;=3^Traumatic arthropathy, right knee
 ;;^UTILITY(U,$J,358.3,31321,1,4,0)
 ;;=4^M12.561
 ;;^UTILITY(U,$J,358.3,31321,2)
 ;;=^5010634
 ;;^UTILITY(U,$J,358.3,31322,0)
 ;;=M12.511^^180^1951^67
 ;;^UTILITY(U,$J,358.3,31322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31322,1,3,0)
 ;;=3^Traumatic arthropathy, right shoulder
 ;;^UTILITY(U,$J,358.3,31322,1,4,0)
 ;;=4^M12.511
 ;;^UTILITY(U,$J,358.3,31322,2)
 ;;=^5010619
 ;;^UTILITY(U,$J,358.3,31323,0)
 ;;=M12.531^^180^1951^68
 ;;^UTILITY(U,$J,358.3,31323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31323,1,3,0)
 ;;=3^Traumatic arthropathy, right wrist
 ;;^UTILITY(U,$J,358.3,31323,1,4,0)
 ;;=4^M12.531
 ;;^UTILITY(U,$J,358.3,31323,2)
 ;;=^5010625
 ;;^UTILITY(U,$J,358.3,31324,0)
 ;;=M48.32^^180^1951^69
 ;;^UTILITY(U,$J,358.3,31324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31324,1,3,0)
 ;;=3^Traumatic spondylopathy, cervical region
 ;;^UTILITY(U,$J,358.3,31324,1,4,0)
 ;;=4^M48.32
 ;;^UTILITY(U,$J,358.3,31324,2)
 ;;=^5012116
 ;;^UTILITY(U,$J,358.3,31325,0)
 ;;=M48.36^^180^1951^71
 ;;^UTILITY(U,$J,358.3,31325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31325,1,3,0)
 ;;=3^Traumatic spondylopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,31325,1,4,0)
 ;;=4^M48.36
 ;;^UTILITY(U,$J,358.3,31325,2)
 ;;=^5012120
 ;;^UTILITY(U,$J,358.3,31326,0)
 ;;=M48.37^^180^1951^72
 ;;^UTILITY(U,$J,358.3,31326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31326,1,3,0)
 ;;=3^Traumatic spondylopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,31326,1,4,0)
 ;;=4^M48.37
 ;;^UTILITY(U,$J,358.3,31326,2)
 ;;=^5012121
 ;;^UTILITY(U,$J,358.3,31327,0)
 ;;=M48.31^^180^1951^73
 ;;^UTILITY(U,$J,358.3,31327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31327,1,3,0)
 ;;=3^Traumatic spondylopathy, occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,31327,1,4,0)
 ;;=4^M48.31
 ;;^UTILITY(U,$J,358.3,31327,2)
 ;;=^5012115
 ;;^UTILITY(U,$J,358.3,31328,0)
 ;;=M48.38^^180^1951^74
 ;;^UTILITY(U,$J,358.3,31328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31328,1,3,0)
 ;;=3^Traumatic spondylopathy, sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,31328,1,4,0)
 ;;=4^M48.38
 ;;^UTILITY(U,$J,358.3,31328,2)
 ;;=^5012122
 ;;^UTILITY(U,$J,358.3,31329,0)
 ;;=M48.35^^180^1951^76
 ;;^UTILITY(U,$J,358.3,31329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31329,1,3,0)
 ;;=3^Traumatic spondylopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,31329,1,4,0)
 ;;=4^M48.35
 ;;^UTILITY(U,$J,358.3,31329,2)
 ;;=^5012119
 ;;^UTILITY(U,$J,358.3,31330,0)
 ;;=M48.33^^180^1951^70
 ;;^UTILITY(U,$J,358.3,31330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31330,1,3,0)
 ;;=3^Traumatic spondylopathy, cervicothoracic region
