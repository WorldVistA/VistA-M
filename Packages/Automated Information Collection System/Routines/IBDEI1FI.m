IBDEI1FI ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23112,1,3,0)
 ;;=3^Nonrheumatic aortic valve stenosis
 ;;^UTILITY(U,$J,358.3,23112,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,23112,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,23113,0)
 ;;=I35.2^^78^1000^18
 ;;^UTILITY(U,$J,358.3,23113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23113,1,3,0)
 ;;=3^Nonrheumatic aortic valve stenosis w/ insufficiency
 ;;^UTILITY(U,$J,358.3,23113,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,23113,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,23114,0)
 ;;=I42.8^^78^1000^7
 ;;^UTILITY(U,$J,358.3,23114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23114,1,3,0)
 ;;=3^Cardiomyopathies, other
 ;;^UTILITY(U,$J,358.3,23114,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,23114,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,23115,0)
 ;;=I48.91^^78^1000^3
 ;;^UTILITY(U,$J,358.3,23115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23115,1,3,0)
 ;;=3^Atrial fibrillation, unspec
 ;;^UTILITY(U,$J,358.3,23115,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,23115,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,23116,0)
 ;;=I48.92^^78^1000^4
 ;;^UTILITY(U,$J,358.3,23116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23116,1,3,0)
 ;;=3^Atrial flutter, unspec
 ;;^UTILITY(U,$J,358.3,23116,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,23116,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,23117,0)
 ;;=I49.3^^78^1000^23
 ;;^UTILITY(U,$J,358.3,23117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23117,1,3,0)
 ;;=3^Ventricular premature depolarization
 ;;^UTILITY(U,$J,358.3,23117,1,4,0)
 ;;=4^I49.3
 ;;^UTILITY(U,$J,358.3,23117,2)
 ;;=^5007233
 ;;^UTILITY(U,$J,358.3,23118,0)
 ;;=I50.9^^78^1000^6
 ;;^UTILITY(U,$J,358.3,23118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23118,1,3,0)
 ;;=3^CHF,Unspec
 ;;^UTILITY(U,$J,358.3,23118,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,23118,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,23119,0)
 ;;=I69.928^^78^1000^22
 ;;^UTILITY(U,$J,358.3,23119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23119,1,3,0)
 ;;=3^Speech/lang deficits following unsp cerebvasc disease
 ;;^UTILITY(U,$J,358.3,23119,1,4,0)
 ;;=4^I69.928
 ;;^UTILITY(U,$J,358.3,23119,2)
 ;;=^5007557
 ;;^UTILITY(U,$J,358.3,23120,0)
 ;;=I69.910^^78^1000^5
 ;;^UTILITY(U,$J,358.3,23120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23120,1,3,0)
 ;;=3^Attention/Concentration Deficit Following Cerebrvasc Disease
 ;;^UTILITY(U,$J,358.3,23120,1,4,0)
 ;;=4^I69.910
 ;;^UTILITY(U,$J,358.3,23120,2)
 ;;=^5138660
 ;;^UTILITY(U,$J,358.3,23121,0)
 ;;=I69.911^^78^1000^15
 ;;^UTILITY(U,$J,358.3,23121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23121,1,3,0)
 ;;=3^Memory Deficit Following Cerebvasc Disease
 ;;^UTILITY(U,$J,358.3,23121,1,4,0)
 ;;=4^I69.911
 ;;^UTILITY(U,$J,358.3,23121,2)
 ;;=^5138661
 ;;^UTILITY(U,$J,358.3,23122,0)
 ;;=I69.912^^78^1000^24
 ;;^UTILITY(U,$J,358.3,23122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23122,1,3,0)
 ;;=3^Visospatial Deficit Following Cerebvasc Disease
 ;;^UTILITY(U,$J,358.3,23122,1,4,0)
 ;;=4^I69.912
 ;;^UTILITY(U,$J,358.3,23122,2)
 ;;=^5138662
 ;;^UTILITY(U,$J,358.3,23123,0)
 ;;=I69.913^^78^1000^21
 ;;^UTILITY(U,$J,358.3,23123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23123,1,3,0)
 ;;=3^Psychomotor Deficit Following Cerebvasc Disease
 ;;^UTILITY(U,$J,358.3,23123,1,4,0)
 ;;=4^I69.913
 ;;^UTILITY(U,$J,358.3,23123,2)
 ;;=^5138663
 ;;^UTILITY(U,$J,358.3,23124,0)
 ;;=I69.914^^78^1000^11
