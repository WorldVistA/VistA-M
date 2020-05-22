IBDEI26V ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34959,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,34959,1,4,0)
 ;;=4^M48.16
 ;;^UTILITY(U,$J,358.3,34959,2)
 ;;=^5012102
 ;;^UTILITY(U,$J,358.3,34960,0)
 ;;=M48.17^^137^1791^4
 ;;^UTILITY(U,$J,358.3,34960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34960,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,34960,1,4,0)
 ;;=4^M48.17
 ;;^UTILITY(U,$J,358.3,34960,2)
 ;;=^5012103
 ;;^UTILITY(U,$J,358.3,34961,0)
 ;;=M48.19^^137^1791^5
 ;;^UTILITY(U,$J,358.3,34961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34961,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Mult Sites in Spine
 ;;^UTILITY(U,$J,358.3,34961,1,4,0)
 ;;=4^M48.19
 ;;^UTILITY(U,$J,358.3,34961,2)
 ;;=^5012105
 ;;^UTILITY(U,$J,358.3,34962,0)
 ;;=M48.11^^137^1791^6
 ;;^UTILITY(U,$J,358.3,34962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34962,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Occipito-Atlanto-Axial Region
 ;;^UTILITY(U,$J,358.3,34962,1,4,0)
 ;;=4^M48.11
 ;;^UTILITY(U,$J,358.3,34962,2)
 ;;=^5012097
 ;;^UTILITY(U,$J,358.3,34963,0)
 ;;=M48.18^^137^1791^7
 ;;^UTILITY(U,$J,358.3,34963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34963,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,34963,1,4,0)
 ;;=4^M48.18
 ;;^UTILITY(U,$J,358.3,34963,2)
 ;;=^5012104
 ;;^UTILITY(U,$J,358.3,34964,0)
 ;;=M48.15^^137^1791^9
 ;;^UTILITY(U,$J,358.3,34964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34964,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,34964,1,4,0)
 ;;=4^M48.15
 ;;^UTILITY(U,$J,358.3,34964,2)
 ;;=^5012101
 ;;^UTILITY(U,$J,358.3,34965,0)
 ;;=M48.13^^137^1791^2
 ;;^UTILITY(U,$J,358.3,34965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34965,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,34965,1,4,0)
 ;;=4^M48.13
 ;;^UTILITY(U,$J,358.3,34965,2)
 ;;=^5012099
 ;;^UTILITY(U,$J,358.3,34966,0)
 ;;=M48.14^^137^1791^8
 ;;^UTILITY(U,$J,358.3,34966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34966,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Thoracic Region
 ;;^UTILITY(U,$J,358.3,34966,1,4,0)
 ;;=4^M48.14
 ;;^UTILITY(U,$J,358.3,34966,2)
 ;;=^5012100
 ;;^UTILITY(U,$J,358.3,34967,0)
 ;;=M45.2^^137^1791^10
 ;;^UTILITY(U,$J,358.3,34967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34967,1,3,0)
 ;;=3^Ankylosing Spondylitis,Cervical Region
 ;;^UTILITY(U,$J,358.3,34967,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,34967,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,34968,0)
 ;;=M45.3^^137^1791^11
 ;;^UTILITY(U,$J,358.3,34968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34968,1,3,0)
 ;;=3^Ankylosing Spondylitis,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,34968,1,4,0)
 ;;=4^M45.3
 ;;^UTILITY(U,$J,358.3,34968,2)
 ;;=^5011963
 ;;^UTILITY(U,$J,358.3,34969,0)
 ;;=M45.7^^137^1791^13
 ;;^UTILITY(U,$J,358.3,34969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34969,1,3,0)
 ;;=3^Ankylosing Spondylitis,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,34969,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,34969,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,34970,0)
 ;;=M45.0^^137^1791^14
 ;;^UTILITY(U,$J,358.3,34970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34970,1,3,0)
 ;;=3^Ankylosing Spondylitis,Mult Sites in Spine
 ;;^UTILITY(U,$J,358.3,34970,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,34970,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,34971,0)
 ;;=M45.1^^137^1791^15
