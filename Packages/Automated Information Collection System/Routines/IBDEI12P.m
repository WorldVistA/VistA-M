IBDEI12P ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18242,1,4,0)
 ;;=4^I80.12
 ;;^UTILITY(U,$J,358.3,18242,2)
 ;;=^5007826
 ;;^UTILITY(U,$J,358.3,18243,0)
 ;;=I80.212^^79^874^136
 ;;^UTILITY(U,$J,358.3,18243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18243,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Left Iliac Vein
 ;;^UTILITY(U,$J,358.3,18243,1,4,0)
 ;;=4^I80.212
 ;;^UTILITY(U,$J,358.3,18243,2)
 ;;=^5007832
 ;;^UTILITY(U,$J,358.3,18244,0)
 ;;=I80.11^^79^874^138
 ;;^UTILITY(U,$J,358.3,18244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18244,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,18244,1,4,0)
 ;;=4^I80.11
 ;;^UTILITY(U,$J,358.3,18244,2)
 ;;=^5007825
 ;;^UTILITY(U,$J,358.3,18245,0)
 ;;=I80.211^^79^874^139
 ;;^UTILITY(U,$J,358.3,18245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18245,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Right Iliac Vein
 ;;^UTILITY(U,$J,358.3,18245,1,4,0)
 ;;=4^I80.211
 ;;^UTILITY(U,$J,358.3,18245,2)
 ;;=^5007831
 ;;^UTILITY(U,$J,358.3,18246,0)
 ;;=I80.203^^79^874^134
 ;;^UTILITY(U,$J,358.3,18246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18246,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Bilateral Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,18246,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,18246,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,18247,0)
 ;;=I80.202^^79^874^137
 ;;^UTILITY(U,$J,358.3,18247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18247,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Left Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,18247,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,18247,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,18248,0)
 ;;=I80.201^^79^874^140
 ;;^UTILITY(U,$J,358.3,18248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18248,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Right Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,18248,1,4,0)
 ;;=4^I80.201
 ;;^UTILITY(U,$J,358.3,18248,2)
 ;;=^5007828
 ;;^UTILITY(U,$J,358.3,18249,0)
 ;;=I73.00^^79^874^141
 ;;^UTILITY(U,$J,358.3,18249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18249,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,18249,1,4,0)
 ;;=4^I73.00
 ;;^UTILITY(U,$J,358.3,18249,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,18250,0)
 ;;=I77.1^^79^874^143
 ;;^UTILITY(U,$J,358.3,18250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18250,1,3,0)
 ;;=3^Stricture of Artery
 ;;^UTILITY(U,$J,358.3,18250,1,4,0)
 ;;=4^I77.1
 ;;^UTILITY(U,$J,358.3,18250,2)
 ;;=^114763
 ;;^UTILITY(U,$J,358.3,18251,0)
 ;;=I71.2^^79^874^144
 ;;^UTILITY(U,$J,358.3,18251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18251,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,18251,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,18251,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,18252,0)
 ;;=I71.5^^79^874^145
 ;;^UTILITY(U,$J,358.3,18252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18252,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,18252,1,4,0)
 ;;=4^I71.5
 ;;^UTILITY(U,$J,358.3,18252,2)
 ;;=^5007790
 ;;^UTILITY(U,$J,358.3,18253,0)
 ;;=I71.6^^79^874^146
 ;;^UTILITY(U,$J,358.3,18253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18253,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,18253,1,4,0)
 ;;=4^I71.6
 ;;^UTILITY(U,$J,358.3,18253,2)
 ;;=^5007791
 ;;^UTILITY(U,$J,358.3,18254,0)
 ;;=E10.620^^79^874^52
 ;;^UTILITY(U,$J,358.3,18254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18254,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,18254,1,4,0)
 ;;=4^E10.620
 ;;^UTILITY(U,$J,358.3,18254,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,18255,0)
 ;;=E10.40^^79^874^53
