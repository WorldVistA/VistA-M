IBDEI0HG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8075,1,4,0)
 ;;=4^S42.92XA
 ;;^UTILITY(U,$J,358.3,8075,2)
 ;;=^5027650
 ;;^UTILITY(U,$J,358.3,8076,0)
 ;;=S42.101A^^33^431^95
 ;;^UTILITY(U,$J,358.3,8076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8076,1,3,0)
 ;;=3^Fx of unsp part of scapula, right shoulder, init
 ;;^UTILITY(U,$J,358.3,8076,1,4,0)
 ;;=4^S42.101A
 ;;^UTILITY(U,$J,358.3,8076,2)
 ;;=^5026530
 ;;^UTILITY(U,$J,358.3,8077,0)
 ;;=S42.102A^^33^431^94
 ;;^UTILITY(U,$J,358.3,8077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8077,1,3,0)
 ;;=3^Fx of unsp part of scapula, left shoulder, init
 ;;^UTILITY(U,$J,358.3,8077,1,4,0)
 ;;=4^S42.102A
 ;;^UTILITY(U,$J,358.3,8077,2)
 ;;=^5026537
 ;;^UTILITY(U,$J,358.3,8078,0)
 ;;=S92.201A^^33^431^107
 ;;^UTILITY(U,$J,358.3,8078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8078,1,3,0)
 ;;=3^Fx of unsp tarsal bone(s) of right foot, init
 ;;^UTILITY(U,$J,358.3,8078,1,4,0)
 ;;=4^S92.201A
 ;;^UTILITY(U,$J,358.3,8078,2)
 ;;=^5044822
 ;;^UTILITY(U,$J,358.3,8079,0)
 ;;=S92.202A^^33^431^106
 ;;^UTILITY(U,$J,358.3,8079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8079,1,3,0)
 ;;=3^Fx of unsp tarsal bone(s) of left foot, init
 ;;^UTILITY(U,$J,358.3,8079,1,4,0)
 ;;=4^S92.202A
 ;;^UTILITY(U,$J,358.3,8079,2)
 ;;=^5044829
 ;;^UTILITY(U,$J,358.3,8080,0)
 ;;=S62.501A^^33^431^105
 ;;^UTILITY(U,$J,358.3,8080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8080,1,3,0)
 ;;=3^Fx of unsp phalanx of right thumb, init for clos fx
 ;;^UTILITY(U,$J,358.3,8080,1,4,0)
 ;;=4^S62.501A
 ;;^UTILITY(U,$J,358.3,8080,2)
 ;;=^5034284
 ;;^UTILITY(U,$J,358.3,8081,0)
 ;;=S62.502A^^33^431^100
 ;;^UTILITY(U,$J,358.3,8081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8081,1,3,0)
 ;;=3^Fx of unsp phalanx of left thumb, init for clos fx
 ;;^UTILITY(U,$J,358.3,8081,1,4,0)
 ;;=4^S62.502A
 ;;^UTILITY(U,$J,358.3,8081,2)
 ;;=^5034291
 ;;^UTILITY(U,$J,358.3,8082,0)
 ;;=S82.201A^^33^431^85
 ;;^UTILITY(U,$J,358.3,8082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8082,1,3,0)
 ;;=3^Fx of right tibia shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8082,1,4,0)
 ;;=4^S82.201A
 ;;^UTILITY(U,$J,358.3,8082,2)
 ;;=^5041102
 ;;^UTILITY(U,$J,358.3,8083,0)
 ;;=S82.202A^^33^431^72
 ;;^UTILITY(U,$J,358.3,8083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8083,1,3,0)
 ;;=3^Fx of left tibia shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8083,1,4,0)
 ;;=4^S82.202A
 ;;^UTILITY(U,$J,358.3,8083,2)
 ;;=^5041118
 ;;^UTILITY(U,$J,358.3,8084,0)
 ;;=S92.911A^^33^431^86
 ;;^UTILITY(U,$J,358.3,8084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8084,1,3,0)
 ;;=3^Fx of right toe(s) unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8084,1,4,0)
 ;;=4^S92.911A
 ;;^UTILITY(U,$J,358.3,8084,2)
 ;;=^5045592
 ;;^UTILITY(U,$J,358.3,8085,0)
 ;;=S92.912A^^33^431^73
 ;;^UTILITY(U,$J,358.3,8085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8085,1,3,0)
 ;;=3^Fx of left toe(s) unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8085,1,4,0)
 ;;=4^S92.912A
 ;;^UTILITY(U,$J,358.3,8085,2)
 ;;=^5045599
 ;;^UTILITY(U,$J,358.3,8086,0)
 ;;=S52.201A^^33^431^87
 ;;^UTILITY(U,$J,358.3,8086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8086,1,3,0)
 ;;=3^Fx of right ulna shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8086,1,4,0)
 ;;=4^S52.201A
 ;;^UTILITY(U,$J,358.3,8086,2)
 ;;=^5029260
 ;;^UTILITY(U,$J,358.3,8087,0)
 ;;=S52.202A^^33^431^74
 ;;^UTILITY(U,$J,358.3,8087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8087,1,3,0)
 ;;=3^Fx of left ulna shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8087,1,4,0)
 ;;=4^S52.202A
 ;;^UTILITY(U,$J,358.3,8087,2)
 ;;=^5029276
 ;;^UTILITY(U,$J,358.3,8088,0)
 ;;=T59.91XA^^33^431^245
