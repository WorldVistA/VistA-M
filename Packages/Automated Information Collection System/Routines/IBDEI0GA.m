IBDEI0GA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7227,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mod Nonprlf Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,7227,1,4,0)
 ;;=4^E10.331
 ;;^UTILITY(U,$J,358.3,7227,2)
 ;;=^5002596
 ;;^UTILITY(U,$J,358.3,7228,0)
 ;;=E10.339^^49^479^41
 ;;^UTILITY(U,$J,358.3,7228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7228,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mod Nonprlf Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,7228,1,4,0)
 ;;=4^E10.339
 ;;^UTILITY(U,$J,358.3,7228,2)
 ;;=^5002597
 ;;^UTILITY(U,$J,358.3,7229,0)
 ;;=E11.319^^49^479^60
 ;;^UTILITY(U,$J,358.3,7229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7229,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,7229,1,4,0)
 ;;=4^E11.319
 ;;^UTILITY(U,$J,358.3,7229,2)
 ;;=^5002633
 ;;^UTILITY(U,$J,358.3,7230,0)
 ;;=E11.311^^49^479^59
 ;;^UTILITY(U,$J,358.3,7230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7230,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,7230,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,7230,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,7231,0)
 ;;=E10.311^^49^479^13
 ;;^UTILITY(U,$J,358.3,7231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7231,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,7231,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,7231,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,7232,0)
 ;;=E10.319^^49^479^14
 ;;^UTILITY(U,$J,358.3,7232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7232,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,7232,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,7232,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,7233,0)
 ;;=E10.351^^49^479^44
 ;;^UTILITY(U,$J,358.3,7233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7233,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,7233,1,4,0)
 ;;=4^E10.351
 ;;^UTILITY(U,$J,358.3,7233,2)
 ;;=^5002600
 ;;^UTILITY(U,$J,358.3,7234,0)
 ;;=E10.359^^49^479^45
 ;;^UTILITY(U,$J,358.3,7234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7234,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,7234,1,4,0)
 ;;=4^E10.359
 ;;^UTILITY(U,$J,358.3,7234,2)
 ;;=^5002601
 ;;^UTILITY(U,$J,358.3,7235,0)
 ;;=E10.40^^49^479^25
 ;;^UTILITY(U,$J,358.3,7235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7235,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,7235,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,7235,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,7236,0)
 ;;=E10.41^^49^479^21
 ;;^UTILITY(U,$J,358.3,7236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7236,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Mononeuropathy
 ;;^UTILITY(U,$J,358.3,7236,1,4,0)
 ;;=4^E10.41
 ;;^UTILITY(U,$J,358.3,7236,2)
 ;;=^5002605
 ;;^UTILITY(U,$J,358.3,7237,0)
 ;;=E10.42^^49^479^29
 ;;^UTILITY(U,$J,358.3,7237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7237,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,7237,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,7237,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,7238,0)
 ;;=E10.43^^49^479^17
 ;;^UTILITY(U,$J,358.3,7238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7238,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,7238,1,4,0)
 ;;=4^E10.43
 ;;^UTILITY(U,$J,358.3,7238,2)
 ;;=^5002607
 ;;^UTILITY(U,$J,358.3,7239,0)
 ;;=E10.44^^49^479^15
 ;;^UTILITY(U,$J,358.3,7239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7239,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Amyotrophy
