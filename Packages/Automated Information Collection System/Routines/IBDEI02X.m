IBDEI02X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,607,1,3,0)
 ;;=3^Hemiplegia Following CVD,Left Dominant Side
 ;;^UTILITY(U,$J,358.3,607,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,607,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,608,0)
 ;;=I69.953^^6^73^8
 ;;^UTILITY(U,$J,358.3,608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,608,1,3,0)
 ;;=3^Hemiplegia Following CVD,Right Nondomiant Side
 ;;^UTILITY(U,$J,358.3,608,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,608,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,609,0)
 ;;=I69.954^^6^73^6
 ;;^UTILITY(U,$J,358.3,609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,609,1,3,0)
 ;;=3^Hemiplegia Following CVD,Left Nondomiant Side
 ;;^UTILITY(U,$J,358.3,609,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,609,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,610,0)
 ;;=K21.9^^6^74^4
 ;;^UTILITY(U,$J,358.3,610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,610,1,3,0)
 ;;=3^GERD w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,610,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,610,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,611,0)
 ;;=K21.0^^6^74^3
 ;;^UTILITY(U,$J,358.3,611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,611,1,3,0)
 ;;=3^GERD w/ Esophagitis
 ;;^UTILITY(U,$J,358.3,611,1,4,0)
 ;;=4^K21.0
 ;;^UTILITY(U,$J,358.3,611,2)
 ;;=^5008504
 ;;^UTILITY(U,$J,358.3,612,0)
 ;;=N40.0^^6^74^2
 ;;^UTILITY(U,$J,358.3,612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,612,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,612,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,612,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,613,0)
 ;;=B35.1^^6^74^5
 ;;^UTILITY(U,$J,358.3,613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,613,1,3,0)
 ;;=3^Tinea Unguium
 ;;^UTILITY(U,$J,358.3,613,1,4,0)
 ;;=4^B35.1
 ;;^UTILITY(U,$J,358.3,613,2)
 ;;=^119748
 ;;^UTILITY(U,$J,358.3,614,0)
 ;;=R54.^^6^74^1
 ;;^UTILITY(U,$J,358.3,614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,614,1,3,0)
 ;;=3^Age-related Physical Debility
 ;;^UTILITY(U,$J,358.3,614,1,4,0)
 ;;=4^R54.
 ;;^UTILITY(U,$J,358.3,614,2)
 ;;=^5019521
 ;;^UTILITY(U,$J,358.3,615,0)
 ;;=J44.9^^6^75^2
 ;;^UTILITY(U,$J,358.3,615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,615,1,3,0)
 ;;=3^COPD,Unspec
 ;;^UTILITY(U,$J,358.3,615,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,615,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,616,0)
 ;;=J45.909^^6^75^1
 ;;^UTILITY(U,$J,358.3,616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,616,1,3,0)
 ;;=3^Asthma,Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,616,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,616,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,617,0)
 ;;=F02.81^^6^76^11
 ;;^UTILITY(U,$J,358.3,617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,617,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,617,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,617,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,618,0)
 ;;=F02.80^^6^76^12
 ;;^UTILITY(U,$J,358.3,618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,618,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,618,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,618,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,619,0)
 ;;=F03.91^^6^76^13
 ;;^UTILITY(U,$J,358.3,619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,619,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,619,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,619,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,620,0)
 ;;=G31.83^^6^76^14
 ;;^UTILITY(U,$J,358.3,620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,620,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,620,1,4,0)
 ;;=4^G31.83
