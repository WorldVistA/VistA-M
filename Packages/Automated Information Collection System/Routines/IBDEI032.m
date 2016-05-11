IBDEI032 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,980,0)
 ;;=Z00.00^^6^107^4
 ;;^UTILITY(U,$J,358.3,980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,980,1,3,0)
 ;;=3^Medical Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,980,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,980,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,981,0)
 ;;=G35.^^6^107^7
 ;;^UTILITY(U,$J,358.3,981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,981,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,981,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,981,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,982,0)
 ;;=M79.1^^6^107^8
 ;;^UTILITY(U,$J,358.3,982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,982,1,3,0)
 ;;=3^Myalgia
 ;;^UTILITY(U,$J,358.3,982,1,4,0)
 ;;=4^M79.1
 ;;^UTILITY(U,$J,358.3,982,2)
 ;;=^5013321
 ;;^UTILITY(U,$J,358.3,983,0)
 ;;=I25.2^^6^107^10
 ;;^UTILITY(U,$J,358.3,983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,983,1,3,0)
 ;;=3^Myocardial Infarction,Old
 ;;^UTILITY(U,$J,358.3,983,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,983,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,984,0)
 ;;=R35.0^^6^107^5
 ;;^UTILITY(U,$J,358.3,984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,984,1,3,0)
 ;;=3^Mictrurition Frequency
 ;;^UTILITY(U,$J,358.3,984,1,4,0)
 ;;=4^R35.0
 ;;^UTILITY(U,$J,358.3,984,2)
 ;;=^5019334
 ;;^UTILITY(U,$J,358.3,985,0)
 ;;=I35.0^^6^108^8
 ;;^UTILITY(U,$J,358.3,985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,985,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,985,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,985,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,986,0)
 ;;=I35.2^^6^108^9
 ;;^UTILITY(U,$J,358.3,986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,986,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,986,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,986,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,987,0)
 ;;=D47.4^^6^108^17
 ;;^UTILITY(U,$J,358.3,987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,987,1,3,0)
 ;;=3^Osteomyelofibrosis
 ;;^UTILITY(U,$J,358.3,987,1,4,0)
 ;;=4^D47.4
 ;;^UTILITY(U,$J,358.3,987,2)
 ;;=^5002259
 ;;^UTILITY(U,$J,358.3,988,0)
 ;;=I34.1^^6^108^10
 ;;^UTILITY(U,$J,358.3,988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,988,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,988,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,988,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,989,0)
 ;;=E66.9^^6^108^12
 ;;^UTILITY(U,$J,358.3,989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,989,1,3,0)
 ;;=3^Obesity,Unspec
 ;;^UTILITY(U,$J,358.3,989,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,989,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,990,0)
 ;;=E66.01^^6^108^11
 ;;^UTILITY(U,$J,358.3,990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,990,1,3,0)
 ;;=3^Obesity,Morbid
 ;;^UTILITY(U,$J,358.3,990,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,990,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,991,0)
 ;;=G60.9^^6^108^3
 ;;^UTILITY(U,$J,358.3,991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,991,1,3,0)
 ;;=3^Neuropathy,Hereditary & Idiopathic Unspec
 ;;^UTILITY(U,$J,358.3,991,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,991,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,992,0)
 ;;=H60.311^^6^108^24
 ;;^UTILITY(U,$J,358.3,992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,992,1,3,0)
 ;;=3^Otitis Externa Diffused,Right Ear
 ;;^UTILITY(U,$J,358.3,992,1,4,0)
 ;;=4^H60.311
 ;;^UTILITY(U,$J,358.3,992,2)
 ;;=^5006447
 ;;^UTILITY(U,$J,358.3,993,0)
 ;;=H60.312^^6^108^23
 ;;^UTILITY(U,$J,358.3,993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,993,1,3,0)
 ;;=3^Otitis Externa Diffused,Left Ear
 ;;^UTILITY(U,$J,358.3,993,1,4,0)
 ;;=4^H60.312
 ;;^UTILITY(U,$J,358.3,993,2)
 ;;=^5006448
