IBDEI26Z ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35007,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Sacral/Sacrocycgl Region
 ;;^UTILITY(U,$J,358.3,35007,1,4,0)
 ;;=4^M47.818
 ;;^UTILITY(U,$J,358.3,35007,2)
 ;;=^5012075
 ;;^UTILITY(U,$J,358.3,35008,0)
 ;;=M47.814^^137^1791^55
 ;;^UTILITY(U,$J,358.3,35008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35008,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,35008,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,35008,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,35009,0)
 ;;=M47.815^^137^1791^56
 ;;^UTILITY(U,$J,358.3,35009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35009,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Thoracolumb Region
 ;;^UTILITY(U,$J,358.3,35009,1,4,0)
 ;;=4^M47.815
 ;;^UTILITY(U,$J,358.3,35009,2)
 ;;=^5012072
 ;;^UTILITY(U,$J,358.3,35010,0)
 ;;=M47.813^^137^1791^50
 ;;^UTILITY(U,$J,358.3,35010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35010,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Cervicothor Region
 ;;^UTILITY(U,$J,358.3,35010,1,4,0)
 ;;=4^M47.813
 ;;^UTILITY(U,$J,358.3,35010,2)
 ;;=^5012070
 ;;^UTILITY(U,$J,358.3,35011,0)
 ;;=M48.32^^137^1791^57
 ;;^UTILITY(U,$J,358.3,35011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35011,1,3,0)
 ;;=3^Traumatic Spondylopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,35011,1,4,0)
 ;;=4^M48.32
 ;;^UTILITY(U,$J,358.3,35011,2)
 ;;=^5012116
 ;;^UTILITY(U,$J,358.3,35012,0)
 ;;=M48.36^^137^1791^59
 ;;^UTILITY(U,$J,358.3,35012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35012,1,3,0)
 ;;=3^Traumatic Spondylopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,35012,1,4,0)
 ;;=4^M48.36
 ;;^UTILITY(U,$J,358.3,35012,2)
 ;;=^5012120
 ;;^UTILITY(U,$J,358.3,35013,0)
 ;;=M48.37^^137^1791^60
 ;;^UTILITY(U,$J,358.3,35013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35013,1,3,0)
 ;;=3^Traumatic Spondylopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,35013,1,4,0)
 ;;=4^M48.37
 ;;^UTILITY(U,$J,358.3,35013,2)
 ;;=^5012121
 ;;^UTILITY(U,$J,358.3,35014,0)
 ;;=M48.31^^137^1791^61
 ;;^UTILITY(U,$J,358.3,35014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35014,1,3,0)
 ;;=3^Traumatic Spondylopathy,Occipito-Atlanto-Axial Region
 ;;^UTILITY(U,$J,358.3,35014,1,4,0)
 ;;=4^M48.31
 ;;^UTILITY(U,$J,358.3,35014,2)
 ;;=^5012115
 ;;^UTILITY(U,$J,358.3,35015,0)
 ;;=M48.38^^137^1791^62
 ;;^UTILITY(U,$J,358.3,35015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35015,1,3,0)
 ;;=3^Traumatic Spondylopathy,Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,35015,1,4,0)
 ;;=4^M48.38
 ;;^UTILITY(U,$J,358.3,35015,2)
 ;;=^5012122
 ;;^UTILITY(U,$J,358.3,35016,0)
 ;;=M48.35^^137^1791^64
 ;;^UTILITY(U,$J,358.3,35016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35016,1,3,0)
 ;;=3^Traumatic Spondylopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,35016,1,4,0)
 ;;=4^M48.35
 ;;^UTILITY(U,$J,358.3,35016,2)
 ;;=^5012119
 ;;^UTILITY(U,$J,358.3,35017,0)
 ;;=M48.33^^137^1791^58
 ;;^UTILITY(U,$J,358.3,35017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35017,1,3,0)
 ;;=3^Traumatic Spondylopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,35017,1,4,0)
 ;;=4^M48.33
 ;;^UTILITY(U,$J,358.3,35017,2)
 ;;=^5012117
 ;;^UTILITY(U,$J,358.3,35018,0)
 ;;=M48.34^^137^1791^63
 ;;^UTILITY(U,$J,358.3,35018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35018,1,3,0)
 ;;=3^Traumatic Spondylopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,35018,1,4,0)
 ;;=4^M48.34
 ;;^UTILITY(U,$J,358.3,35018,2)
 ;;=^5012118
