IBDEI0Z0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16445,0)
 ;;=G30.1^^64^749^3
 ;;^UTILITY(U,$J,358.3,16445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16445,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,16445,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,16445,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,16446,0)
 ;;=G30.9^^64^749^4
 ;;^UTILITY(U,$J,358.3,16446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16446,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,16446,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,16446,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,16447,0)
 ;;=G10.^^64^749^19
 ;;^UTILITY(U,$J,358.3,16447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16447,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,16447,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,16447,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,16448,0)
 ;;=G10.^^64^749^20
 ;;^UTILITY(U,$J,358.3,16448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16448,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,16448,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,16448,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,16449,0)
 ;;=G90.3^^64^749^21
 ;;^UTILITY(U,$J,358.3,16449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16449,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,16449,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,16449,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,16450,0)
 ;;=G91.2^^64^749^22
 ;;^UTILITY(U,$J,358.3,16450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16450,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,16450,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,16450,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,16451,0)
 ;;=G91.2^^64^749^23
 ;;^UTILITY(U,$J,358.3,16451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16451,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,16451,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,16451,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,16452,0)
 ;;=G30.8^^64^749^5
 ;;^UTILITY(U,$J,358.3,16452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16452,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,16452,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,16452,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,16453,0)
 ;;=G31.09^^64^749^16
 ;;^UTILITY(U,$J,358.3,16453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16453,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,16453,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,16453,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,16454,0)
 ;;=G20.^^64^749^24
 ;;^UTILITY(U,$J,358.3,16454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16454,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,16454,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,16454,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,16455,0)
 ;;=G20.^^64^749^25
 ;;^UTILITY(U,$J,358.3,16455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16455,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,16455,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,16455,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,16456,0)
 ;;=G31.01^^64^749^26
 ;;^UTILITY(U,$J,358.3,16456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16456,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,16456,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,16456,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,16457,0)
 ;;=G23.1^^64^749^28
 ;;^UTILITY(U,$J,358.3,16457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16457,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,16457,1,4,0)
 ;;=4^G23.1
