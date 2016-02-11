IBDEI0BZ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5160,0)
 ;;=C50.212^^40^355^24
 ;;^UTILITY(U,$J,358.3,5160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5160,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,5160,1,4,0)
 ;;=4^C50.212
 ;;^UTILITY(U,$J,358.3,5160,2)
 ;;=^5001172
 ;;^UTILITY(U,$J,358.3,5161,0)
 ;;=C50.311^^40^355^15
 ;;^UTILITY(U,$J,358.3,5161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5161,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,5161,1,4,0)
 ;;=4^C50.311
 ;;^UTILITY(U,$J,358.3,5161,2)
 ;;=^5001177
 ;;^UTILITY(U,$J,358.3,5162,0)
 ;;=C50.312^^40^355^14
 ;;^UTILITY(U,$J,358.3,5162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5162,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,5162,1,4,0)
 ;;=4^C50.312
 ;;^UTILITY(U,$J,358.3,5162,2)
 ;;=^5133333
 ;;^UTILITY(U,$J,358.3,5163,0)
 ;;=C50.411^^40^355^27
 ;;^UTILITY(U,$J,358.3,5163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5163,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,5163,1,4,0)
 ;;=4^C50.411
 ;;^UTILITY(U,$J,358.3,5163,2)
 ;;=^5001179
 ;;^UTILITY(U,$J,358.3,5164,0)
 ;;=C50.412^^40^355^26
 ;;^UTILITY(U,$J,358.3,5164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5164,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,5164,1,4,0)
 ;;=4^C50.412
 ;;^UTILITY(U,$J,358.3,5164,2)
 ;;=^5133335
 ;;^UTILITY(U,$J,358.3,5165,0)
 ;;=C50.511^^40^355^17
 ;;^UTILITY(U,$J,358.3,5165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5165,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,5165,1,4,0)
 ;;=4^C50.511
 ;;^UTILITY(U,$J,358.3,5165,2)
 ;;=^5001181
 ;;^UTILITY(U,$J,358.3,5166,0)
 ;;=C50.512^^40^355^16
 ;;^UTILITY(U,$J,358.3,5166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5166,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,5166,1,4,0)
 ;;=4^C50.512
 ;;^UTILITY(U,$J,358.3,5166,2)
 ;;=^5133337
 ;;^UTILITY(U,$J,358.3,5167,0)
 ;;=C50.611^^40^355^10
 ;;^UTILITY(U,$J,358.3,5167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5167,1,3,0)
 ;;=3^Malig Neop of Axillary Tail of Right Breast
 ;;^UTILITY(U,$J,358.3,5167,1,4,0)
 ;;=4^C50.611
 ;;^UTILITY(U,$J,358.3,5167,2)
 ;;=^5001183
 ;;^UTILITY(U,$J,358.3,5168,0)
 ;;=C50.612^^40^355^9
 ;;^UTILITY(U,$J,358.3,5168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5168,1,3,0)
 ;;=3^Malig Neop of Axillary Tail of Left Breast
 ;;^UTILITY(U,$J,358.3,5168,1,4,0)
 ;;=4^C50.612
 ;;^UTILITY(U,$J,358.3,5168,2)
 ;;=^5001184
 ;;^UTILITY(U,$J,358.3,5169,0)
 ;;=C50.811^^40^355^21
 ;;^UTILITY(U,$J,358.3,5169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5169,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Right Breast
 ;;^UTILITY(U,$J,358.3,5169,1,4,0)
 ;;=4^C50.811
 ;;^UTILITY(U,$J,358.3,5169,2)
 ;;=^5001189
 ;;^UTILITY(U,$J,358.3,5170,0)
 ;;=C50.812^^40^355^20
 ;;^UTILITY(U,$J,358.3,5170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5170,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Left Breast
 ;;^UTILITY(U,$J,358.3,5170,1,4,0)
 ;;=4^C50.812
 ;;^UTILITY(U,$J,358.3,5170,2)
 ;;=^5001190
 ;;^UTILITY(U,$J,358.3,5171,0)
 ;;=C50.911^^40^355^22
 ;;^UTILITY(U,$J,358.3,5171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5171,1,3,0)
 ;;=3^Malig Neop of Right Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,5171,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,5171,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,5172,0)
 ;;=C50.912^^40^355^13
 ;;^UTILITY(U,$J,358.3,5172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5172,1,3,0)
 ;;=3^Malig Neop of Left Breast,Unspec Site
