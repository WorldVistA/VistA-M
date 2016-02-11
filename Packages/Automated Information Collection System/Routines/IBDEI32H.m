IBDEI32H ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51417,1,3,0)
 ;;=3^Arteritis, unspec
 ;;^UTILITY(U,$J,358.3,51417,1,4,0)
 ;;=4^I77.6
 ;;^UTILITY(U,$J,358.3,51417,2)
 ;;=^5007813
 ;;^UTILITY(U,$J,358.3,51418,0)
 ;;=M31.6^^222^2478^2
 ;;^UTILITY(U,$J,358.3,51418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51418,1,3,0)
 ;;=3^Arteritis, giant cell, oth
 ;;^UTILITY(U,$J,358.3,51418,1,4,0)
 ;;=4^M31.6
 ;;^UTILITY(U,$J,358.3,51418,2)
 ;;=^5011748
 ;;^UTILITY(U,$J,358.3,51419,0)
 ;;=D69.0^^222^2478^1
 ;;^UTILITY(U,$J,358.3,51419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51419,1,3,0)
 ;;=3^Allergic purpura
 ;;^UTILITY(U,$J,358.3,51419,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,51419,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,51420,0)
 ;;=M31.0^^222^2478^4
 ;;^UTILITY(U,$J,358.3,51420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51420,1,3,0)
 ;;=3^Hypersensitivity angiitis
 ;;^UTILITY(U,$J,358.3,51420,1,4,0)
 ;;=4^M31.0
 ;;^UTILITY(U,$J,358.3,51420,2)
 ;;=^60279
 ;;^UTILITY(U,$J,358.3,51421,0)
 ;;=M35.3^^222^2478^5
 ;;^UTILITY(U,$J,358.3,51421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51421,1,3,0)
 ;;=3^Polymyalgia rheumatica
 ;;^UTILITY(U,$J,358.3,51421,1,4,0)
 ;;=4^M35.3
 ;;^UTILITY(U,$J,358.3,51421,2)
 ;;=^96292
 ;;^UTILITY(U,$J,358.3,51422,0)
 ;;=G90.59^^222^2479^3
 ;;^UTILITY(U,$J,358.3,51422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51422,1,3,0)
 ;;=3^Cmplx regnl pain syndr I of oth spec site
 ;;^UTILITY(U,$J,358.3,51422,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,51422,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,51423,0)
 ;;=G73.7^^222^2479^8
 ;;^UTILITY(U,$J,358.3,51423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51423,1,3,0)
 ;;=3^Myopathy in diseases clasfd elswhr
 ;;^UTILITY(U,$J,358.3,51423,1,4,0)
 ;;=4^G73.7
 ;;^UTILITY(U,$J,358.3,51423,2)
 ;;=^5004103
 ;;^UTILITY(U,$J,358.3,51424,0)
 ;;=N08.^^222^2479^6
 ;;^UTILITY(U,$J,358.3,51424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51424,1,3,0)
 ;;=3^Glomerular disord in diseases clasfd elswhr
 ;;^UTILITY(U,$J,358.3,51424,1,4,0)
 ;;=4^N08.
 ;;^UTILITY(U,$J,358.3,51424,2)
 ;;=^5015569
 ;;^UTILITY(U,$J,358.3,51425,0)
 ;;=M87.00^^222^2479^7
 ;;^UTILITY(U,$J,358.3,51425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51425,1,3,0)
 ;;=3^Idiopath aseptic necrosis of unspec bone
 ;;^UTILITY(U,$J,358.3,51425,1,4,0)
 ;;=4^M87.00
 ;;^UTILITY(U,$J,358.3,51425,2)
 ;;=^5014657
 ;;^UTILITY(U,$J,358.3,51426,0)
 ;;=M21.41^^222^2479^5
 ;;^UTILITY(U,$J,358.3,51426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51426,1,3,0)
 ;;=3^Flat foot [pes planus] (acq), rt foot
 ;;^UTILITY(U,$J,358.3,51426,1,4,0)
 ;;=4^M21.41
 ;;^UTILITY(U,$J,358.3,51426,2)
 ;;=^5011114
 ;;^UTILITY(U,$J,358.3,51427,0)
 ;;=M21.42^^222^2479^4
 ;;^UTILITY(U,$J,358.3,51427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51427,1,3,0)
 ;;=3^Flat foot [pes planus] (acq), lft foot
 ;;^UTILITY(U,$J,358.3,51427,1,4,0)
 ;;=4^M21.42
 ;;^UTILITY(U,$J,358.3,51427,2)
 ;;=^5011115
 ;;^UTILITY(U,$J,358.3,51428,0)
 ;;=M21.6X1^^222^2479^2
 ;;^UTILITY(U,$J,358.3,51428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51428,1,3,0)
 ;;=3^Acq deformities of rt foot, oth
 ;;^UTILITY(U,$J,358.3,51428,1,4,0)
 ;;=4^M21.6X1
 ;;^UTILITY(U,$J,358.3,51428,2)
 ;;=^5011128
 ;;^UTILITY(U,$J,358.3,51429,0)
 ;;=M21.6X2^^222^2479^1
 ;;^UTILITY(U,$J,358.3,51429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51429,1,3,0)
 ;;=3^Acq deformities of lft foot, oth
 ;;^UTILITY(U,$J,358.3,51429,1,4,0)
 ;;=4^M21.6X2
 ;;^UTILITY(U,$J,358.3,51429,2)
 ;;=^5011129
 ;;^UTILITY(U,$J,358.3,51430,0)
 ;;=M22.41^^222^2480^2
 ;;^UTILITY(U,$J,358.3,51430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51430,1,3,0)
 ;;=3^Chondromalacia patellae, rt knee
