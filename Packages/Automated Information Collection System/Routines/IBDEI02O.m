IBDEI02O ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,485,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,486,0)
 ;;=F45.29^^3^62^3
 ;;^UTILITY(U,$J,358.3,486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,486,1,3,0)
 ;;=3^Hypochondriacal Disorders NEC
 ;;^UTILITY(U,$J,358.3,486,1,4,0)
 ;;=4^F45.29
 ;;^UTILITY(U,$J,358.3,486,2)
 ;;=^5003589
 ;;^UTILITY(U,$J,358.3,487,0)
 ;;=F45.8^^3^62^9
 ;;^UTILITY(U,$J,358.3,487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,487,1,3,0)
 ;;=3^Somatoform Disorders NEC
 ;;^UTILITY(U,$J,358.3,487,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,487,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,488,0)
 ;;=F45.41^^3^62^5
 ;;^UTILITY(U,$J,358.3,488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,488,1,3,0)
 ;;=3^Pain Disorder Exclusively Related to Psychological Factors
 ;;^UTILITY(U,$J,358.3,488,1,4,0)
 ;;=4^F45.41
 ;;^UTILITY(U,$J,358.3,488,2)
 ;;=^5003590
 ;;^UTILITY(U,$J,358.3,489,0)
 ;;=F45.42^^3^62^6
 ;;^UTILITY(U,$J,358.3,489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,489,1,3,0)
 ;;=3^Pain Disorder w/ Related Psychological Factors
 ;;^UTILITY(U,$J,358.3,489,1,4,0)
 ;;=4^F45.42
 ;;^UTILITY(U,$J,358.3,489,2)
 ;;=^5003591
 ;;^UTILITY(U,$J,358.3,490,0)
 ;;=F45.0^^3^62^7
 ;;^UTILITY(U,$J,358.3,490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,490,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,490,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,490,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,491,0)
 ;;=F45.9^^3^62^8
 ;;^UTILITY(U,$J,358.3,491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,491,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,491,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,491,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,492,0)
 ;;=F45.1^^3^62^10
 ;;^UTILITY(U,$J,358.3,492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,492,1,3,0)
 ;;=3^Undifferntiated Somatoform Disorder
 ;;^UTILITY(U,$J,358.3,492,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,492,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,493,0)
 ;;=99211^^4^63^1
 ;;^UTILITY(U,$J,358.3,493,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,493,1,1,0)
 ;;=1^Face-to-Face Visit
 ;;^UTILITY(U,$J,358.3,493,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,494,0)
 ;;=99377^^5^64^3^^^^1
 ;;^UTILITY(U,$J,358.3,494,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,494,1,2,0)
 ;;=2^Hospice Care 15-29min
 ;;^UTILITY(U,$J,358.3,494,1,3,0)
 ;;=3^99377
 ;;^UTILITY(U,$J,358.3,495,0)
 ;;=99378^^5^64^4^^^^1
 ;;^UTILITY(U,$J,358.3,495,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,495,1,2,0)
 ;;=2^Hospice Care >30min
 ;;^UTILITY(U,$J,358.3,495,1,3,0)
 ;;=3^99378
 ;;^UTILITY(U,$J,358.3,496,0)
 ;;=99374^^5^64^1^^^^1
 ;;^UTILITY(U,$J,358.3,496,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,496,1,2,0)
 ;;=2^Home Health Agency 15-29min
 ;;^UTILITY(U,$J,358.3,496,1,3,0)
 ;;=3^99374
 ;;^UTILITY(U,$J,358.3,497,0)
 ;;=99375^^5^64^2^^^^1
 ;;^UTILITY(U,$J,358.3,497,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,497,1,2,0)
 ;;=2^Home Health Agency > 30min
 ;;^UTILITY(U,$J,358.3,497,1,3,0)
 ;;=3^99375
 ;;^UTILITY(U,$J,358.3,498,0)
 ;;=S5100^^5^65^1^^^^1
 ;;^UTILITY(U,$J,358.3,498,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,498,1,2,0)
 ;;=2^Day Care Svcs,ea 15min
 ;;^UTILITY(U,$J,358.3,498,1,3,0)
 ;;=3^S5100
 ;;^UTILITY(U,$J,358.3,499,0)
 ;;=S5101^^5^65^2^^^^1
 ;;^UTILITY(U,$J,358.3,499,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,499,1,2,0)
 ;;=2^Day Care Svcs,per half day
 ;;^UTILITY(U,$J,358.3,499,1,3,0)
 ;;=3^S5101
 ;;^UTILITY(U,$J,358.3,500,0)
 ;;=S5102^^5^65^3^^^^1
 ;;^UTILITY(U,$J,358.3,500,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,500,1,2,0)
 ;;=2^Day Care Svcs,per diem
 ;;^UTILITY(U,$J,358.3,500,1,3,0)
 ;;=3^S5102
