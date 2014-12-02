IBDEI09E ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4340,1,5,0)
 ;;=5^626.2
 ;;^UTILITY(U,$J,358.3,4340,2)
 ;;=^75895
 ;;^UTILITY(U,$J,358.3,4341,0)
 ;;=V76.19^^37^334^27
 ;;^UTILITY(U,$J,358.3,4341,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4341,1,4,0)
 ;;=4^Screen Breast Exam
 ;;^UTILITY(U,$J,358.3,4341,1,5,0)
 ;;=5^V76.19
 ;;^UTILITY(U,$J,358.3,4341,2)
 ;;=^295652
 ;;^UTILITY(U,$J,358.3,4342,0)
 ;;=174.9^^37^334^4
 ;;^UTILITY(U,$J,358.3,4342,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4342,1,4,0)
 ;;=4^Cancer, Breast, Female
 ;;^UTILITY(U,$J,358.3,4342,1,5,0)
 ;;=5^174.9
 ;;^UTILITY(U,$J,358.3,4342,2)
 ;;=Cancer, Breast, Femal^267202
 ;;^UTILITY(U,$J,358.3,4343,0)
 ;;=174.0^^37^334^8
 ;;^UTILITY(U,$J,358.3,4343,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4343,1,4,0)
 ;;=4^Cancer, Nipple, Female
 ;;^UTILITY(U,$J,358.3,4343,1,5,0)
 ;;=5^174.0
 ;;^UTILITY(U,$J,358.3,4343,2)
 ;;=Cancer, Nipple, Female^73528
 ;;^UTILITY(U,$J,358.3,4344,0)
 ;;=174.6^^37^334^3
 ;;^UTILITY(U,$J,358.3,4344,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4344,1,4,0)
 ;;=4^Cancer Of Breast Axillary
 ;;^UTILITY(U,$J,358.3,4344,1,5,0)
 ;;=5^174.6
 ;;^UTILITY(U,$J,358.3,4344,2)
 ;;=Cancer of Breast Axillary^267200
 ;;^UTILITY(U,$J,358.3,4345,0)
 ;;=174.1^^37^334^5
 ;;^UTILITY(U,$J,358.3,4345,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4345,1,4,0)
 ;;=4^Cancer, Central Breast
 ;;^UTILITY(U,$J,358.3,4345,1,5,0)
 ;;=5^174.1
 ;;^UTILITY(U,$J,358.3,4345,2)
 ;;=Cancer, Central Breast^267195
 ;;^UTILITY(U,$J,358.3,4346,0)
 ;;=174.3^^37^334^6
 ;;^UTILITY(U,$J,358.3,4346,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4346,1,4,0)
 ;;=4^Cancer, Lower Inner Breast
 ;;^UTILITY(U,$J,358.3,4346,1,5,0)
 ;;=5^174.3
 ;;^UTILITY(U,$J,358.3,4346,2)
 ;;=Cancer, Lower Inner Breast^267197
 ;;^UTILITY(U,$J,358.3,4347,0)
 ;;=174.5^^37^334^7
 ;;^UTILITY(U,$J,358.3,4347,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4347,1,4,0)
 ;;=4^Cancer, Lower Outer Breast
 ;;^UTILITY(U,$J,358.3,4347,1,5,0)
 ;;=5^174.5
 ;;^UTILITY(U,$J,358.3,4347,2)
 ;;=Cancer, Lower outer Breast^267199
 ;;^UTILITY(U,$J,358.3,4348,0)
 ;;=174.8^^37^334^9
 ;;^UTILITY(U,$J,358.3,4348,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4348,1,4,0)
 ;;=4^Cancer, Other Breast
 ;;^UTILITY(U,$J,358.3,4348,1,5,0)
 ;;=5^174.8
 ;;^UTILITY(U,$J,358.3,4348,2)
 ;;=Cancer, Other Breast^267201
 ;;^UTILITY(U,$J,358.3,4349,0)
 ;;=174.2^^37^334^11
 ;;^UTILITY(U,$J,358.3,4349,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4349,1,4,0)
 ;;=4^Cancer, Upper Inner Breast
 ;;^UTILITY(U,$J,358.3,4349,1,5,0)
 ;;=5^174.2
 ;;^UTILITY(U,$J,358.3,4349,2)
 ;;=Cancer, Upper Inner Breast^267196
 ;;^UTILITY(U,$J,358.3,4350,0)
 ;;=174.4^^37^334^12
 ;;^UTILITY(U,$J,358.3,4350,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4350,1,4,0)
 ;;=4^Cancer, Upper Outer Breast
 ;;^UTILITY(U,$J,358.3,4350,1,5,0)
 ;;=5^174.4
 ;;^UTILITY(U,$J,358.3,4350,2)
 ;;=Cancer, Upper Outer Breast^267198
 ;;^UTILITY(U,$J,358.3,4351,0)
 ;;=610.0^^37^334^13
 ;;^UTILITY(U,$J,358.3,4351,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4351,1,4,0)
 ;;=4^Cyst,Breast
 ;;^UTILITY(U,$J,358.3,4351,1,5,0)
 ;;=5^610.0
 ;;^UTILITY(U,$J,358.3,4351,2)
 ;;=^112247
 ;;^UTILITY(U,$J,358.3,4352,0)
 ;;=625.3^^37^334^14
 ;;^UTILITY(U,$J,358.3,4352,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4352,1,4,0)
 ;;=4^Dysmenorrhea
 ;;^UTILITY(U,$J,358.3,4352,1,5,0)
 ;;=5^625.3
 ;;^UTILITY(U,$J,358.3,4352,2)
 ;;=^37592
 ;;^UTILITY(U,$J,358.3,4353,0)
 ;;=610.1^^37^334^18
 ;;^UTILITY(U,$J,358.3,4353,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4353,1,4,0)
 ;;=4^Fibrocystic Disease,Breast
 ;;^UTILITY(U,$J,358.3,4353,1,5,0)
 ;;=5^610.1
