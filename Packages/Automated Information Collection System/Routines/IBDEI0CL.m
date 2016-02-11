IBDEI0CL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5451,1,3,0)
 ;;=3^Malig Neop of Appendix
 ;;^UTILITY(U,$J,358.3,5451,1,4,0)
 ;;=4^C18.1
 ;;^UTILITY(U,$J,358.3,5451,2)
 ;;=^5000927
 ;;^UTILITY(U,$J,358.3,5452,0)
 ;;=C18.2^^40^367^51
 ;;^UTILITY(U,$J,358.3,5452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5452,1,3,0)
 ;;=3^Malig Neop of Ascending Colon
 ;;^UTILITY(U,$J,358.3,5452,1,4,0)
 ;;=4^C18.2
 ;;^UTILITY(U,$J,358.3,5452,2)
 ;;=^267085
 ;;^UTILITY(U,$J,358.3,5453,0)
 ;;=C18.3^^40^367^63
 ;;^UTILITY(U,$J,358.3,5453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5453,1,3,0)
 ;;=3^Malig Neop of Hepatic Flexure
 ;;^UTILITY(U,$J,358.3,5453,1,4,0)
 ;;=4^C18.3
 ;;^UTILITY(U,$J,358.3,5453,2)
 ;;=^267079
 ;;^UTILITY(U,$J,358.3,5454,0)
 ;;=C18.4^^40^367^82
 ;;^UTILITY(U,$J,358.3,5454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5454,1,3,0)
 ;;=3^Malig Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,5454,1,4,0)
 ;;=4^C18.4
 ;;^UTILITY(U,$J,358.3,5454,2)
 ;;=^267080
 ;;^UTILITY(U,$J,358.3,5455,0)
 ;;=C18.5^^40^367^79
 ;;^UTILITY(U,$J,358.3,5455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5455,1,3,0)
 ;;=3^Malig Neop of Splenic Flexure
 ;;^UTILITY(U,$J,358.3,5455,1,4,0)
 ;;=4^C18.5
 ;;^UTILITY(U,$J,358.3,5455,2)
 ;;=^267086
 ;;^UTILITY(U,$J,358.3,5456,0)
 ;;=C18.6^^40^367^57
 ;;^UTILITY(U,$J,358.3,5456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5456,1,3,0)
 ;;=3^Malig Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,5456,1,4,0)
 ;;=4^C18.6
 ;;^UTILITY(U,$J,358.3,5456,2)
 ;;=^267081
 ;;^UTILITY(U,$J,358.3,5457,0)
 ;;=C18.7^^40^367^78
 ;;^UTILITY(U,$J,358.3,5457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5457,1,3,0)
 ;;=3^Malig Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,5457,1,4,0)
 ;;=4^C18.7
 ;;^UTILITY(U,$J,358.3,5457,2)
 ;;=^267082
 ;;^UTILITY(U,$J,358.3,5458,0)
 ;;=C18.8^^40^367^67
 ;;^UTILITY(U,$J,358.3,5458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5458,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Colon
 ;;^UTILITY(U,$J,358.3,5458,1,4,0)
 ;;=4^C18.8
 ;;^UTILITY(U,$J,358.3,5458,2)
 ;;=^5000928
 ;;^UTILITY(U,$J,358.3,5459,0)
 ;;=C18.9^^40^367^56
 ;;^UTILITY(U,$J,358.3,5459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5459,1,3,0)
 ;;=3^Malig Neop of Colon,Unspec
 ;;^UTILITY(U,$J,358.3,5459,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,5459,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,5460,0)
 ;;=C19.^^40^367^76
 ;;^UTILITY(U,$J,358.3,5460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5460,1,3,0)
 ;;=3^Malig Neop of Rectosigmoid Junction
 ;;^UTILITY(U,$J,358.3,5460,1,4,0)
 ;;=4^C19.
 ;;^UTILITY(U,$J,358.3,5460,2)
 ;;=^267089
 ;;^UTILITY(U,$J,358.3,5461,0)
 ;;=C20.^^40^367^77
 ;;^UTILITY(U,$J,358.3,5461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5461,1,3,0)
 ;;=3^Malig Neop of Rectum
 ;;^UTILITY(U,$J,358.3,5461,1,4,0)
 ;;=4^C20.
 ;;^UTILITY(U,$J,358.3,5461,2)
 ;;=^267090
 ;;^UTILITY(U,$J,358.3,5462,0)
 ;;=C25.0^^40^367^62
 ;;^UTILITY(U,$J,358.3,5462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5462,1,3,0)
 ;;=3^Malig Neop of Head of Pancreas
 ;;^UTILITY(U,$J,358.3,5462,1,4,0)
 ;;=4^C25.0
 ;;^UTILITY(U,$J,358.3,5462,2)
 ;;=^267104
 ;;^UTILITY(U,$J,358.3,5463,0)
 ;;=C25.1^^40^367^52
 ;;^UTILITY(U,$J,358.3,5463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5463,1,3,0)
 ;;=3^Malig Neop of Body of Pancreas
 ;;^UTILITY(U,$J,358.3,5463,1,4,0)
 ;;=4^C25.1
 ;;^UTILITY(U,$J,358.3,5463,2)
 ;;=^267105
 ;;^UTILITY(U,$J,358.3,5464,0)
 ;;=C25.2^^40^367^81
 ;;^UTILITY(U,$J,358.3,5464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5464,1,3,0)
 ;;=3^Malig Neop of Tail of Pancreas
 ;;^UTILITY(U,$J,358.3,5464,1,4,0)
 ;;=4^C25.2
 ;;^UTILITY(U,$J,358.3,5464,2)
 ;;=^267106
