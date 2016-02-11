IBDEI034 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,712,1,3,0)
 ;;=3^Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,712,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,712,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,713,0)
 ;;=T78.3XXA^^9^88^43
 ;;^UTILITY(U,$J,358.3,713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,713,1,3,0)
 ;;=3^Angioneurotic Edema,Initial
 ;;^UTILITY(U,$J,358.3,713,1,4,0)
 ;;=4^T78.3XXA
 ;;^UTILITY(U,$J,358.3,713,2)
 ;;=^5054281
 ;;^UTILITY(U,$J,358.3,714,0)
 ;;=T78.3XXS^^9^88^44
 ;;^UTILITY(U,$J,358.3,714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,714,1,3,0)
 ;;=3^Angioneurotic Edema,Sequela
 ;;^UTILITY(U,$J,358.3,714,1,4,0)
 ;;=4^T78.3XXS
 ;;^UTILITY(U,$J,358.3,714,2)
 ;;=^5054283
 ;;^UTILITY(U,$J,358.3,715,0)
 ;;=T78.3XXD^^9^88^45
 ;;^UTILITY(U,$J,358.3,715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,715,1,3,0)
 ;;=3^Angioneurotic Edema,Subsequent
 ;;^UTILITY(U,$J,358.3,715,1,4,0)
 ;;=4^T78.3XXD
 ;;^UTILITY(U,$J,358.3,715,2)
 ;;=^5054282
 ;;^UTILITY(U,$J,358.3,716,0)
 ;;=J45.901^^9^88^47
 ;;^UTILITY(U,$J,358.3,716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,716,1,3,0)
 ;;=3^Asthma w/ Acute Exacerbation,Unspec
 ;;^UTILITY(U,$J,358.3,716,1,4,0)
 ;;=4^J45.901
 ;;^UTILITY(U,$J,358.3,716,2)
 ;;=^5008254
 ;;^UTILITY(U,$J,358.3,717,0)
 ;;=J45.902^^9^88^48
 ;;^UTILITY(U,$J,358.3,717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,717,1,3,0)
 ;;=3^Asthma w/ Status Asthmaticus,Unspec
 ;;^UTILITY(U,$J,358.3,717,1,4,0)
 ;;=4^J45.902
 ;;^UTILITY(U,$J,358.3,717,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,718,0)
 ;;=J45.909^^9^88^46
 ;;^UTILITY(U,$J,358.3,718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,718,1,3,0)
 ;;=3^Asthma Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,718,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,718,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,719,0)
 ;;=L20.89^^9^88^49
 ;;^UTILITY(U,$J,358.3,719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,719,1,3,0)
 ;;=3^Atopic Dermatitis,Other
 ;;^UTILITY(U,$J,358.3,719,1,4,0)
 ;;=4^L20.89
 ;;^UTILITY(U,$J,358.3,719,2)
 ;;=^5009112
 ;;^UTILITY(U,$J,358.3,720,0)
 ;;=L20.81^^9^88^50
 ;;^UTILITY(U,$J,358.3,720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,720,1,3,0)
 ;;=3^Atopic Neurodermatitis
 ;;^UTILITY(U,$J,358.3,720,1,4,0)
 ;;=4^L20.81
 ;;^UTILITY(U,$J,358.3,720,2)
 ;;=^5009108
 ;;^UTILITY(U,$J,358.3,721,0)
 ;;=R44.0^^9^88^51
 ;;^UTILITY(U,$J,358.3,721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,721,1,3,0)
 ;;=3^Auditory Hallucinations
 ;;^UTILITY(U,$J,358.3,721,1,4,0)
 ;;=4^R44.0
 ;;^UTILITY(U,$J,358.3,721,2)
 ;;=^5019455
 ;;^UTILITY(U,$J,358.3,722,0)
 ;;=H01.005^^9^88^54
 ;;^UTILITY(U,$J,358.3,722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,722,1,3,0)
 ;;=3^Blepharitis Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,722,1,4,0)
 ;;=4^H01.005
 ;;^UTILITY(U,$J,358.3,722,2)
 ;;=^5133380
 ;;^UTILITY(U,$J,358.3,723,0)
 ;;=H01.004^^9^88^55
 ;;^UTILITY(U,$J,358.3,723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,723,1,3,0)
 ;;=3^Blepharitis Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,723,1,4,0)
 ;;=4^H01.004
 ;;^UTILITY(U,$J,358.3,723,2)
 ;;=^5004241
 ;;^UTILITY(U,$J,358.3,724,0)
 ;;=H01.002^^9^88^56
 ;;^UTILITY(U,$J,358.3,724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,724,1,3,0)
 ;;=3^Blepharitis Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,724,1,4,0)
 ;;=4^H01.002
 ;;^UTILITY(U,$J,358.3,724,2)
 ;;=^5004239
 ;;^UTILITY(U,$J,358.3,725,0)
 ;;=H01.001^^9^88^57
 ;;^UTILITY(U,$J,358.3,725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,725,1,3,0)
 ;;=3^Blepharitis Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,725,1,4,0)
 ;;=4^H01.001
 ;;^UTILITY(U,$J,358.3,725,2)
 ;;=^5004238
