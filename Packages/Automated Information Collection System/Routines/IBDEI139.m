IBDEI139 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18502,1,3,0)
 ;;=3^Methicillin Resist Staph Infct in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,18502,1,4,0)
 ;;=4^B95.62
 ;;^UTILITY(U,$J,358.3,18502,2)
 ;;=^5000842
 ;;^UTILITY(U,$J,358.3,18503,0)
 ;;=B95.7^^79^880^91
 ;;^UTILITY(U,$J,358.3,18503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18503,1,3,0)
 ;;=3^Staphylococcus in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,18503,1,4,0)
 ;;=4^B95.7
 ;;^UTILITY(U,$J,358.3,18503,2)
 ;;=^5000843
 ;;^UTILITY(U,$J,358.3,18504,0)
 ;;=B96.1^^79^880^70
 ;;^UTILITY(U,$J,358.3,18504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18504,1,3,0)
 ;;=3^Klebsiella Pneumoniae in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,18504,1,4,0)
 ;;=4^B96.1
 ;;^UTILITY(U,$J,358.3,18504,2)
 ;;=^5000846
 ;;^UTILITY(U,$J,358.3,18505,0)
 ;;=B96.20^^79^880^49
 ;;^UTILITY(U,$J,358.3,18505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18505,1,3,0)
 ;;=3^Escherichia Coli in Diseases Classified Elsewhere,Unspec
 ;;^UTILITY(U,$J,358.3,18505,1,4,0)
 ;;=4^B96.20
 ;;^UTILITY(U,$J,358.3,18505,2)
 ;;=^5000847
 ;;^UTILITY(U,$J,358.3,18506,0)
 ;;=B96.29^^79^880^50
 ;;^UTILITY(U,$J,358.3,18506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18506,1,3,0)
 ;;=3^Escherichia Coli in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,18506,1,4,0)
 ;;=4^B96.29
 ;;^UTILITY(U,$J,358.3,18506,2)
 ;;=^5000851
 ;;^UTILITY(U,$J,358.3,18507,0)
 ;;=B20.^^79^880^58
 ;;^UTILITY(U,$J,358.3,18507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18507,1,3,0)
 ;;=3^HIV Disease
 ;;^UTILITY(U,$J,358.3,18507,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,18507,2)
 ;;=^5000555
 ;;^UTILITY(U,$J,358.3,18508,0)
 ;;=B02.9^^79^880^108
 ;;^UTILITY(U,$J,358.3,18508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18508,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,18508,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,18508,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,18509,0)
 ;;=A60.9^^79^880^14
 ;;^UTILITY(U,$J,358.3,18509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18509,1,3,0)
 ;;=3^Anogenital Herpesviral Infection,Unspec
 ;;^UTILITY(U,$J,358.3,18509,1,4,0)
 ;;=4^A60.9
 ;;^UTILITY(U,$J,358.3,18509,2)
 ;;=^5000359
 ;;^UTILITY(U,$J,358.3,18510,0)
 ;;=A60.04^^79^880^65
 ;;^UTILITY(U,$J,358.3,18510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18510,1,3,0)
 ;;=3^Herpesviral Vulvovaginitis
 ;;^UTILITY(U,$J,358.3,18510,1,4,0)
 ;;=4^A60.04
 ;;^UTILITY(U,$J,358.3,18510,2)
 ;;=^5000356
 ;;^UTILITY(U,$J,358.3,18511,0)
 ;;=A60.01^^79^880^63
 ;;^UTILITY(U,$J,358.3,18511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18511,1,3,0)
 ;;=3^Herpesviral Infection of Penis
 ;;^UTILITY(U,$J,358.3,18511,1,4,0)
 ;;=4^A60.01
 ;;^UTILITY(U,$J,358.3,18511,2)
 ;;=^5000353
 ;;^UTILITY(U,$J,358.3,18512,0)
 ;;=B00.1^^79^880^64
 ;;^UTILITY(U,$J,358.3,18512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18512,1,3,0)
 ;;=3^Herpesviral Vesicular Dermatitis
 ;;^UTILITY(U,$J,358.3,18512,1,4,0)
 ;;=4^B00.1
 ;;^UTILITY(U,$J,358.3,18512,2)
 ;;=^5000468
 ;;^UTILITY(U,$J,358.3,18513,0)
 ;;=B00.2^^79^880^62
 ;;^UTILITY(U,$J,358.3,18513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18513,1,3,0)
 ;;=3^Herpesviral Gingivostomatitis/Pharyngotonsillitis
 ;;^UTILITY(U,$J,358.3,18513,1,4,0)
 ;;=4^B00.2
 ;;^UTILITY(U,$J,358.3,18513,2)
 ;;=^5000469
 ;;^UTILITY(U,$J,358.3,18514,0)
 ;;=B15.9^^79^880^59
 ;;^UTILITY(U,$J,358.3,18514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18514,1,3,0)
 ;;=3^Hepatitis A w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,18514,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,18514,2)
 ;;=^5000536
