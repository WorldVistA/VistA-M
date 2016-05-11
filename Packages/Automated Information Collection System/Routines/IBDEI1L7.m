IBDEI1L7 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26909,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,26909,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,26909,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,26910,0)
 ;;=F11.220^^100^1295^1
 ;;^UTILITY(U,$J,358.3,26910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26910,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,26910,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,26910,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,26911,0)
 ;;=F11.188^^100^1295^3
 ;;^UTILITY(U,$J,358.3,26911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26911,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26911,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,26911,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,26912,0)
 ;;=F11.288^^100^1295^4
 ;;^UTILITY(U,$J,358.3,26912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26912,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26912,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,26912,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,26913,0)
 ;;=F11.988^^100^1295^5
 ;;^UTILITY(U,$J,358.3,26913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26913,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26913,1,4,0)
 ;;=4^F11.988
 ;;^UTILITY(U,$J,358.3,26913,2)
 ;;=^5003154
 ;;^UTILITY(U,$J,358.3,26914,0)
 ;;=F11.921^^100^1295^6
 ;;^UTILITY(U,$J,358.3,26914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26914,1,3,0)
 ;;=3^Opioid Induced Delirium
 ;;^UTILITY(U,$J,358.3,26914,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,26914,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,26915,0)
 ;;=F11.94^^100^1295^7
 ;;^UTILITY(U,$J,358.3,26915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26915,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26915,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,26915,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,26916,0)
 ;;=F11.181^^100^1295^8
 ;;^UTILITY(U,$J,358.3,26916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26916,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26916,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,26916,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,26917,0)
 ;;=F11.281^^100^1295^9
 ;;^UTILITY(U,$J,358.3,26917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26917,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26917,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,26917,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,26918,0)
 ;;=F11.981^^100^1295^10
 ;;^UTILITY(U,$J,358.3,26918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26918,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26918,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,26918,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,26919,0)
 ;;=F11.282^^100^1295^11
 ;;^UTILITY(U,$J,358.3,26919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26919,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26919,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,26919,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,26920,0)
 ;;=F11.982^^100^1295^12
 ;;^UTILITY(U,$J,358.3,26920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26920,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26920,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,26920,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,26921,0)
 ;;=F11.121^^100^1295^13
 ;;^UTILITY(U,$J,358.3,26921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26921,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
