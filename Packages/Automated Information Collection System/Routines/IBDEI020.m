IBDEI020 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,449,0)
 ;;=F10.27^^3^49^9
 ;;^UTILITY(U,$J,358.3,449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,449,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,449,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,449,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,450,0)
 ;;=F10.97^^3^49^10
 ;;^UTILITY(U,$J,358.3,450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,450,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,450,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,450,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,451,0)
 ;;=F10.288^^3^49^5
 ;;^UTILITY(U,$J,358.3,451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,451,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,451,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,451,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,452,0)
 ;;=F10.988^^3^49^6
 ;;^UTILITY(U,$J,358.3,452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,452,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,452,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,452,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,453,0)
 ;;=F10.159^^3^49^11
 ;;^UTILITY(U,$J,358.3,453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,453,1,3,0)
 ;;=3^Alcohol Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,453,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,453,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,454,0)
 ;;=F10.259^^3^49^12
 ;;^UTILITY(U,$J,358.3,454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,454,1,3,0)
 ;;=3^Alcohol Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,454,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,454,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,455,0)
 ;;=F10.959^^3^49^13
 ;;^UTILITY(U,$J,358.3,455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,455,1,3,0)
 ;;=3^Alcohol Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,455,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,455,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,456,0)
 ;;=F10.181^^3^49^14
 ;;^UTILITY(U,$J,358.3,456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,456,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,456,1,4,0)
 ;;=4^F10.181
 ;;^UTILITY(U,$J,358.3,456,2)
 ;;=^5003077
 ;;^UTILITY(U,$J,358.3,457,0)
 ;;=F10.282^^3^49^18
 ;;^UTILITY(U,$J,358.3,457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,457,1,3,0)
 ;;=3^Alcohol Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,457,1,4,0)
 ;;=4^F10.282
 ;;^UTILITY(U,$J,358.3,457,2)
 ;;=^5003098
 ;;^UTILITY(U,$J,358.3,458,0)
 ;;=F10.982^^3^49^19
 ;;^UTILITY(U,$J,358.3,458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,458,1,3,0)
 ;;=3^Alcohol Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,458,1,4,0)
 ;;=4^F10.982
 ;;^UTILITY(U,$J,358.3,458,2)
 ;;=^5003112
 ;;^UTILITY(U,$J,358.3,459,0)
 ;;=F10.281^^3^49^15
 ;;^UTILITY(U,$J,358.3,459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,459,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,459,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,459,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,460,0)
 ;;=F10.981^^3^49^16
 ;;^UTILITY(U,$J,358.3,460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,460,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,460,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,460,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,461,0)
 ;;=F10.182^^3^49^17
