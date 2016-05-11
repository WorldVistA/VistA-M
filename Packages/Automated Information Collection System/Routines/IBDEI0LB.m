IBDEI0LB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9944,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Bilateral,Mild Stage
 ;;^UTILITY(U,$J,358.3,9944,1,4,0)
 ;;=4^H40.63X1
 ;;^UTILITY(U,$J,358.3,9944,2)
 ;;=^5005915
 ;;^UTILITY(U,$J,358.3,9945,0)
 ;;=H40.63X2^^44^496^31
 ;;^UTILITY(U,$J,358.3,9945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9945,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Bilateral,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9945,1,4,0)
 ;;=4^H40.63X2
 ;;^UTILITY(U,$J,358.3,9945,2)
 ;;=^5005916
 ;;^UTILITY(U,$J,358.3,9946,0)
 ;;=H40.63X3^^44^496^32
 ;;^UTILITY(U,$J,358.3,9946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9946,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Bilateral,Severe Stage
 ;;^UTILITY(U,$J,358.3,9946,1,4,0)
 ;;=4^H40.63X3
 ;;^UTILITY(U,$J,358.3,9946,2)
 ;;=^5005917
 ;;^UTILITY(U,$J,358.3,9947,0)
 ;;=H40.63X4^^44^496^29
 ;;^UTILITY(U,$J,358.3,9947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9947,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Bilateral,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9947,1,4,0)
 ;;=4^H40.63X4
 ;;^UTILITY(U,$J,358.3,9947,2)
 ;;=^5005918
 ;;^UTILITY(U,$J,358.3,9948,0)
 ;;=H40.51X0^^44^496^54
 ;;^UTILITY(U,$J,358.3,9948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9948,1,3,0)
 ;;=3^Glaucoma Sec to Oth Eye Disorder,Right Eye,Unspec Stage
 ;;^UTILITY(U,$J,358.3,9948,1,4,0)
 ;;=4^H40.51X0
 ;;^UTILITY(U,$J,358.3,9948,2)
 ;;=^5005888
 ;;^UTILITY(U,$J,358.3,9949,0)
 ;;=H40.51X1^^44^496^55
 ;;^UTILITY(U,$J,358.3,9949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9949,1,3,0)
 ;;=3^Glaucoma Sec to Oth Eye Disorder,Right Eye,Mild Stage
 ;;^UTILITY(U,$J,358.3,9949,1,4,0)
 ;;=4^H40.51X1
 ;;^UTILITY(U,$J,358.3,9949,2)
 ;;=^5005889
 ;;^UTILITY(U,$J,358.3,9950,0)
 ;;=H40.51X2^^44^496^56
 ;;^UTILITY(U,$J,358.3,9950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9950,1,3,0)
 ;;=3^Glaucoma Sec to Oth Eye Disorder,Right Eye,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9950,1,4,0)
 ;;=4^H40.51X2
 ;;^UTILITY(U,$J,358.3,9950,2)
 ;;=^5005890
 ;;^UTILITY(U,$J,358.3,9951,0)
 ;;=H40.51X3^^44^496^57
 ;;^UTILITY(U,$J,358.3,9951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9951,1,3,0)
 ;;=3^Glaucoma Sec to Oth Eye Disorder,Right Eye,Severe Stage
 ;;^UTILITY(U,$J,358.3,9951,1,4,0)
 ;;=4^H40.51X3
 ;;^UTILITY(U,$J,358.3,9951,2)
 ;;=^5133507
 ;;^UTILITY(U,$J,358.3,9952,0)
 ;;=H40.51X4^^44^496^58
 ;;^UTILITY(U,$J,358.3,9952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9952,1,3,0)
 ;;=3^Glaucoma Sec to Oth Eye Disorder,Right Eye,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9952,1,4,0)
 ;;=4^H40.51X4
 ;;^UTILITY(U,$J,358.3,9952,2)
 ;;=^5005891
 ;;^UTILITY(U,$J,358.3,9953,0)
 ;;=H40.52X0^^44^496^49
 ;;^UTILITY(U,$J,358.3,9953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9953,1,3,0)
 ;;=3^Glaucoma Sec to Oth Eye Disorder,Left Eye,Unspec Stage
 ;;^UTILITY(U,$J,358.3,9953,1,4,0)
 ;;=4^H40.52X0
 ;;^UTILITY(U,$J,358.3,9953,2)
 ;;=^5005892
 ;;^UTILITY(U,$J,358.3,9954,0)
 ;;=H40.52X1^^44^496^50
 ;;^UTILITY(U,$J,358.3,9954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9954,1,3,0)
 ;;=3^Glaucoma Sec to Oth Eye Disorder,Left Eye,Mild Stage
 ;;^UTILITY(U,$J,358.3,9954,1,4,0)
 ;;=4^H40.52X1
 ;;^UTILITY(U,$J,358.3,9954,2)
 ;;=^5005893
 ;;^UTILITY(U,$J,358.3,9955,0)
 ;;=H40.52X2^^44^496^51
 ;;^UTILITY(U,$J,358.3,9955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9955,1,3,0)
 ;;=3^Glaucoma Sec to Oth Eye Disorder,Left Eye,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9955,1,4,0)
 ;;=4^H40.52X2
 ;;^UTILITY(U,$J,358.3,9955,2)
 ;;=^5005894
 ;;^UTILITY(U,$J,358.3,9956,0)
 ;;=H40.52X3^^44^496^52
 ;;^UTILITY(U,$J,358.3,9956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9956,1,3,0)
 ;;=3^Glaucoma Sec to Oth Eye Disorder,Left Eye,Severe Stage
