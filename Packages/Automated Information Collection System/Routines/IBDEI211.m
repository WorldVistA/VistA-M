IBDEI211 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34384,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,34384,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,34384,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,34385,0)
 ;;=M45.4^^131^1686^7
 ;;^UTILITY(U,$J,358.3,34385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34385,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,34385,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,34385,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,34386,0)
 ;;=M45.7^^131^1686^4
 ;;^UTILITY(U,$J,358.3,34386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34386,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,34386,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,34386,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,34387,0)
 ;;=M45.8^^131^1686^5
 ;;^UTILITY(U,$J,358.3,34387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34387,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,34387,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,34387,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,34388,0)
 ;;=M47.22^^131^1686^172
 ;;^UTILITY(U,$J,358.3,34388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34388,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,34388,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,34388,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,34389,0)
 ;;=M47.24^^131^1686^174
 ;;^UTILITY(U,$J,358.3,34389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34389,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,34389,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,34389,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,34390,0)
 ;;=M47.27^^131^1686^173
 ;;^UTILITY(U,$J,358.3,34390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34390,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,34390,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,34390,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,34391,0)
 ;;=M47.812^^131^1686^169
 ;;^UTILITY(U,$J,358.3,34391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34391,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,34391,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,34391,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,34392,0)
 ;;=M47.814^^131^1686^170
 ;;^UTILITY(U,$J,358.3,34392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34392,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,34392,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,34392,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,34393,0)
 ;;=M47.817^^131^1686^171
 ;;^UTILITY(U,$J,358.3,34393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34393,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,34393,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,34393,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,34394,0)
 ;;=M48.50XA^^131^1686^21
 ;;^UTILITY(U,$J,358.3,34394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34394,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,34394,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,34394,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,34395,0)
 ;;=M48.50XD^^131^1686^22
 ;;^UTILITY(U,$J,358.3,34395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34395,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,34395,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,34395,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,34396,0)
 ;;=M48.52XA^^131^1686^23
 ;;^UTILITY(U,$J,358.3,34396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34396,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
