IBDEI0BR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5319,1,3,0)
 ;;=3^Nephrotic syndrome w/ other morphologic changes
 ;;^UTILITY(U,$J,358.3,5319,1,4,0)
 ;;=4^N04.8
 ;;^UTILITY(U,$J,358.3,5319,2)
 ;;=^5015539
 ;;^UTILITY(U,$J,358.3,5320,0)
 ;;=N04.9^^27^344^62
 ;;^UTILITY(U,$J,358.3,5320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5320,1,3,0)
 ;;=3^Nephrotic syndrome w/ unspecified morphologic changes
 ;;^UTILITY(U,$J,358.3,5320,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,5320,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,5321,0)
 ;;=N05.0^^27^344^50
 ;;^UTILITY(U,$J,358.3,5321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5321,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,5321,1,4,0)
 ;;=4^N05.0
 ;;^UTILITY(U,$J,358.3,5321,2)
 ;;=^5015541
 ;;^UTILITY(U,$J,358.3,5322,0)
 ;;=N05.1^^27^344^49
 ;;^UTILITY(U,$J,358.3,5322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5322,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ focal & segmental glomerular lesions
 ;;^UTILITY(U,$J,358.3,5322,1,4,0)
 ;;=4^N05.1
 ;;^UTILITY(U,$J,358.3,5322,2)
 ;;=^5015542
 ;;^UTILITY(U,$J,358.3,5323,0)
 ;;=N05.2^^27^344^46
 ;;^UTILITY(U,$J,358.3,5323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5323,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,5323,1,4,0)
 ;;=4^N05.2
 ;;^UTILITY(U,$J,358.3,5323,2)
 ;;=^5015543
 ;;^UTILITY(U,$J,358.3,5324,0)
 ;;=N05.3^^27^344^47
 ;;^UTILITY(U,$J,358.3,5324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5324,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,5324,1,4,0)
 ;;=4^N05.3
 ;;^UTILITY(U,$J,358.3,5324,2)
 ;;=^5015544
 ;;^UTILITY(U,$J,358.3,5325,0)
 ;;=N05.4^^27^344^45
 ;;^UTILITY(U,$J,358.3,5325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5325,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,5325,1,4,0)
 ;;=4^N05.4
 ;;^UTILITY(U,$J,358.3,5325,2)
 ;;=^5015545
 ;;^UTILITY(U,$J,358.3,5326,0)
 ;;=N05.5^^27^344^48
 ;;^UTILITY(U,$J,358.3,5326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5326,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,5326,1,4,0)
 ;;=4^N05.5
 ;;^UTILITY(U,$J,358.3,5326,2)
 ;;=^5015546
 ;;^UTILITY(U,$J,358.3,5327,0)
 ;;=N05.6^^27^344^43
 ;;^UTILITY(U,$J,358.3,5327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5327,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,5327,1,4,0)
 ;;=4^N05.6
 ;;^UTILITY(U,$J,358.3,5327,2)
 ;;=^5015547
 ;;^UTILITY(U,$J,358.3,5328,0)
 ;;=N05.7^^27^344^44
 ;;^UTILITY(U,$J,358.3,5328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5328,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,5328,1,4,0)
 ;;=4^N05.7
 ;;^UTILITY(U,$J,358.3,5328,2)
 ;;=^5015548
 ;;^UTILITY(U,$J,358.3,5329,0)
 ;;=N05.8^^27^344^51
 ;;^UTILITY(U,$J,358.3,5329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5329,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ oth morphologic changes
 ;;^UTILITY(U,$J,358.3,5329,1,4,0)
 ;;=4^N05.8
 ;;^UTILITY(U,$J,358.3,5329,2)
 ;;=^5134085
 ;;^UTILITY(U,$J,358.3,5330,0)
 ;;=N05.9^^27^344^52
 ;;^UTILITY(U,$J,358.3,5330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5330,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ unspec morphologic changes
 ;;^UTILITY(U,$J,358.3,5330,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,5330,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,5331,0)
 ;;=N06.0^^27^344^40
 ;;^UTILITY(U,$J,358.3,5331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5331,1,3,0)
 ;;=3^Isolated proteinuria w/ minor glomerular abnormality
