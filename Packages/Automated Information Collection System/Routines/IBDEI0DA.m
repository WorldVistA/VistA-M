IBDEI0DA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6091,1,3,0)
 ;;=3^Varicose Veins of Lower Extremity w/ Ulcer
 ;;^UTILITY(U,$J,358.3,6091,1,4,0)
 ;;=4^I83.009
 ;;^UTILITY(U,$J,358.3,6091,2)
 ;;=^5007972
 ;;^UTILITY(U,$J,358.3,6092,0)
 ;;=H65.03^^30^386^3
 ;;^UTILITY(U,$J,358.3,6092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6092,1,3,0)
 ;;=3^Acute Serous Otitis Media,Bilateral
 ;;^UTILITY(U,$J,358.3,6092,1,4,0)
 ;;=4^H65.03
 ;;^UTILITY(U,$J,358.3,6092,2)
 ;;=^5006572
 ;;^UTILITY(U,$J,358.3,6093,0)
 ;;=H65.01^^30^386^5
 ;;^UTILITY(U,$J,358.3,6093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6093,1,3,0)
 ;;=3^Acute Serous Otitis Media,Right Ear
 ;;^UTILITY(U,$J,358.3,6093,1,4,0)
 ;;=4^H65.01
 ;;^UTILITY(U,$J,358.3,6093,2)
 ;;=^5006570
 ;;^UTILITY(U,$J,358.3,6094,0)
 ;;=H65.23^^30^386^15
 ;;^UTILITY(U,$J,358.3,6094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6094,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Bilateral
 ;;^UTILITY(U,$J,358.3,6094,1,4,0)
 ;;=4^H65.23
 ;;^UTILITY(U,$J,358.3,6094,2)
 ;;=^5006596
 ;;^UTILITY(U,$J,358.3,6095,0)
 ;;=H65.22^^30^386^16
 ;;^UTILITY(U,$J,358.3,6095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6095,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Left Ear
 ;;^UTILITY(U,$J,358.3,6095,1,4,0)
 ;;=4^H65.22
 ;;^UTILITY(U,$J,358.3,6095,2)
 ;;=^5006595
 ;;^UTILITY(U,$J,358.3,6096,0)
 ;;=H65.21^^30^386^17
 ;;^UTILITY(U,$J,358.3,6096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6096,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Right Ear
 ;;^UTILITY(U,$J,358.3,6096,1,4,0)
 ;;=4^H65.21
 ;;^UTILITY(U,$J,358.3,6096,2)
 ;;=^5006594
 ;;^UTILITY(U,$J,358.3,6097,0)
 ;;=H66.012^^30^386^6
 ;;^UTILITY(U,$J,358.3,6097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6097,1,3,0)
 ;;=3^Acute Suppr Otitis Media w/ Spon Rupt Ear Drum,Left Ear
 ;;^UTILITY(U,$J,358.3,6097,1,4,0)
 ;;=4^H66.012
 ;;^UTILITY(U,$J,358.3,6097,2)
 ;;=^5133534
 ;;^UTILITY(U,$J,358.3,6098,0)
 ;;=H66.011^^30^386^7
 ;;^UTILITY(U,$J,358.3,6098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6098,1,3,0)
 ;;=3^Acute Suppr Otitis Media w/ Spon Rupt Ear Drum,Right Ear
 ;;^UTILITY(U,$J,358.3,6098,1,4,0)
 ;;=4^H66.011
 ;;^UTILITY(U,$J,358.3,6098,2)
 ;;=^5006621
 ;;^UTILITY(U,$J,358.3,6099,0)
 ;;=H66.91^^30^386^36
 ;;^UTILITY(U,$J,358.3,6099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6099,1,3,0)
 ;;=3^Otitis Media,Unspec,Right Ear
 ;;^UTILITY(U,$J,358.3,6099,1,4,0)
 ;;=4^H66.91
 ;;^UTILITY(U,$J,358.3,6099,2)
 ;;=^5006640
 ;;^UTILITY(U,$J,358.3,6100,0)
 ;;=H66.92^^30^386^35
 ;;^UTILITY(U,$J,358.3,6100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6100,1,3,0)
 ;;=3^Otitis Media,Unspec,Left Ear
 ;;^UTILITY(U,$J,358.3,6100,1,4,0)
 ;;=4^H66.92
 ;;^UTILITY(U,$J,358.3,6100,2)
 ;;=^5006641
 ;;^UTILITY(U,$J,358.3,6101,0)
 ;;=H66.93^^30^386^34
 ;;^UTILITY(U,$J,358.3,6101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6101,1,3,0)
 ;;=3^Otitis Media,Unspec,Bilateral
 ;;^UTILITY(U,$J,358.3,6101,1,4,0)
 ;;=4^H66.93
 ;;^UTILITY(U,$J,358.3,6101,2)
 ;;=^5006642
 ;;^UTILITY(U,$J,358.3,6102,0)
 ;;=H81.10^^30^386^37
 ;;^UTILITY(U,$J,358.3,6102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6102,1,3,0)
 ;;=3^Paroxysmal Veritgo,Benign,Unspec Ear
 ;;^UTILITY(U,$J,358.3,6102,1,4,0)
 ;;=4^H81.10
 ;;^UTILITY(U,$J,358.3,6102,2)
 ;;=^5006864
 ;;^UTILITY(U,$J,358.3,6103,0)
 ;;=H93.13^^30^386^38
 ;;^UTILITY(U,$J,358.3,6103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6103,1,3,0)
 ;;=3^Tinnitus,Bilateral
 ;;^UTILITY(U,$J,358.3,6103,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,6103,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,6104,0)
 ;;=H93.12^^30^386^39
