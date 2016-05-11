IBDEI0XQ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15813,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15813,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,15813,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,15814,0)
 ;;=F18.288^^58^694^9
 ;;^UTILITY(U,$J,358.3,15814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15814,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15814,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,15814,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,15815,0)
 ;;=F18.988^^58^694^10
 ;;^UTILITY(U,$J,358.3,15815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15815,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15815,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,15815,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,15816,0)
 ;;=F18.159^^58^694^11
 ;;^UTILITY(U,$J,358.3,15816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15816,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15816,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,15816,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,15817,0)
 ;;=F18.259^^58^694^12
 ;;^UTILITY(U,$J,358.3,15817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15817,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15817,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,15817,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,15818,0)
 ;;=F18.959^^58^694^13
 ;;^UTILITY(U,$J,358.3,15818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15818,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15818,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,15818,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,15819,0)
 ;;=F18.99^^58^694^20
 ;;^UTILITY(U,$J,358.3,15819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15819,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15819,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,15819,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,15820,0)
 ;;=F70.^^58^695^1
 ;;^UTILITY(U,$J,358.3,15820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15820,1,3,0)
 ;;=3^Intellectual Disabilities,Mild
 ;;^UTILITY(U,$J,358.3,15820,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,15820,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,15821,0)
 ;;=F71.^^58^695^2
 ;;^UTILITY(U,$J,358.3,15821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15821,1,3,0)
 ;;=3^Intellectual Disabilities,Moderate
 ;;^UTILITY(U,$J,358.3,15821,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,15821,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,15822,0)
 ;;=F72.^^58^695^3
 ;;^UTILITY(U,$J,358.3,15822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15822,1,3,0)
 ;;=3^Intellectual Disabilities,Severe
 ;;^UTILITY(U,$J,358.3,15822,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,15822,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,15823,0)
 ;;=F73.^^58^695^4
 ;;^UTILITY(U,$J,358.3,15823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15823,1,3,0)
 ;;=3^Intellectual Disabilities,Profound
 ;;^UTILITY(U,$J,358.3,15823,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,15823,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,15824,0)
 ;;=F78.^^58^695^5
 ;;^UTILITY(U,$J,358.3,15824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15824,1,3,0)
 ;;=3^Intellectual Disabilities,Oth Specified
 ;;^UTILITY(U,$J,358.3,15824,1,4,0)
 ;;=4^F78.
 ;;^UTILITY(U,$J,358.3,15824,2)
 ;;=^5003672
 ;;^UTILITY(U,$J,358.3,15825,0)
 ;;=F79.^^58^695^6
 ;;^UTILITY(U,$J,358.3,15825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15825,1,3,0)
 ;;=3^Intellectual Disabilities,Unspec
