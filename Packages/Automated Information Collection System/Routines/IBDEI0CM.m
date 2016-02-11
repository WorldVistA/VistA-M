IBDEI0CM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5465,0)
 ;;=C25.3^^40^367^73
 ;;^UTILITY(U,$J,358.3,5465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5465,1,3,0)
 ;;=3^Malig Neop of Pancreatic Duct
 ;;^UTILITY(U,$J,358.3,5465,1,4,0)
 ;;=4^C25.3
 ;;^UTILITY(U,$J,358.3,5465,2)
 ;;=^267107
 ;;^UTILITY(U,$J,358.3,5466,0)
 ;;=C25.4^^40^367^58
 ;;^UTILITY(U,$J,358.3,5466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5466,1,3,0)
 ;;=3^Malig Neop of Endocrine Pancreas
 ;;^UTILITY(U,$J,358.3,5466,1,4,0)
 ;;=4^C25.4
 ;;^UTILITY(U,$J,358.3,5466,2)
 ;;=^5000943
 ;;^UTILITY(U,$J,358.3,5467,0)
 ;;=C25.7^^40^367^71
 ;;^UTILITY(U,$J,358.3,5467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5467,1,3,0)
 ;;=3^Malig Neop of Pancreas NEC
 ;;^UTILITY(U,$J,358.3,5467,1,4,0)
 ;;=4^C25.7
 ;;^UTILITY(U,$J,358.3,5467,2)
 ;;=^5000944
 ;;^UTILITY(U,$J,358.3,5468,0)
 ;;=C25.8^^40^367^69
 ;;^UTILITY(U,$J,358.3,5468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5468,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Pancreas
 ;;^UTILITY(U,$J,358.3,5468,1,4,0)
 ;;=4^C25.8
 ;;^UTILITY(U,$J,358.3,5468,2)
 ;;=^5000945
 ;;^UTILITY(U,$J,358.3,5469,0)
 ;;=C25.9^^40^367^72
 ;;^UTILITY(U,$J,358.3,5469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5469,1,3,0)
 ;;=3^Malig Neop of Pancreas,Unspec
 ;;^UTILITY(U,$J,358.3,5469,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,5469,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,5470,0)
 ;;=D12.0^^40^367^8
 ;;^UTILITY(U,$J,358.3,5470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5470,1,3,0)
 ;;=3^Benign Neop of Cecum
 ;;^UTILITY(U,$J,358.3,5470,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,5470,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,5471,0)
 ;;=D12.1^^40^367^6
 ;;^UTILITY(U,$J,358.3,5471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5471,1,3,0)
 ;;=3^Benign Neop of Appendix
 ;;^UTILITY(U,$J,358.3,5471,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,5471,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,5472,0)
 ;;=D12.2^^40^367^7
 ;;^UTILITY(U,$J,358.3,5472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5472,1,3,0)
 ;;=3^Benign Neop of Ascending Colon
 ;;^UTILITY(U,$J,358.3,5472,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,5472,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,5473,0)
 ;;=D12.3^^40^367^12
 ;;^UTILITY(U,$J,358.3,5473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5473,1,3,0)
 ;;=3^Benign Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,5473,1,4,0)
 ;;=4^D12.3
 ;;^UTILITY(U,$J,358.3,5473,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,5474,0)
 ;;=D12.4^^40^367^10
 ;;^UTILITY(U,$J,358.3,5474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5474,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,5474,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,5474,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,5475,0)
 ;;=D12.5^^40^367^11
 ;;^UTILITY(U,$J,358.3,5475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5475,1,3,0)
 ;;=3^Benign Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,5475,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,5475,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,5476,0)
 ;;=D12.6^^40^367^9
 ;;^UTILITY(U,$J,358.3,5476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5476,1,3,0)
 ;;=3^Benign Neop of Colon,Unspec
 ;;^UTILITY(U,$J,358.3,5476,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,5476,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,5477,0)
 ;;=E66.01^^40^367^85
 ;;^UTILITY(U,$J,358.3,5477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5477,1,3,0)
 ;;=3^Morbid Obesity d/t Excess Calories
 ;;^UTILITY(U,$J,358.3,5477,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,5477,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,5478,0)
 ;;=E66.9^^40^367^86
 ;;^UTILITY(U,$J,358.3,5478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5478,1,3,0)
 ;;=3^Obesity,Unspec
