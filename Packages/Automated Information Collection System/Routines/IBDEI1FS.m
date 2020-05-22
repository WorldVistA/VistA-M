IBDEI1FS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22980,1,4,0)
 ;;=4^G97.31
 ;;^UTILITY(U,$J,358.3,22980,2)
 ;;=^5004204
 ;;^UTILITY(U,$J,358.3,22981,0)
 ;;=G97.32^^105^1166^127
 ;;^UTILITY(U,$J,358.3,22981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22981,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Nervous Sys Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,22981,1,4,0)
 ;;=4^G97.32
 ;;^UTILITY(U,$J,358.3,22981,2)
 ;;=^5004205
 ;;^UTILITY(U,$J,358.3,22982,0)
 ;;=H59.111^^105^1166^130
 ;;^UTILITY(U,$J,358.3,22982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22982,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Right Eye/Adnexa Complicating Ophth Procedure
 ;;^UTILITY(U,$J,358.3,22982,1,4,0)
 ;;=4^H59.111
 ;;^UTILITY(U,$J,358.3,22982,2)
 ;;=^5006401
 ;;^UTILITY(U,$J,358.3,22983,0)
 ;;=H59.112^^105^1166^122
 ;;^UTILITY(U,$J,358.3,22983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22983,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Left Eye/Adnexa Complicating Ophth Procedure
 ;;^UTILITY(U,$J,358.3,22983,1,4,0)
 ;;=4^H59.112
 ;;^UTILITY(U,$J,358.3,22983,2)
 ;;=^5006402
 ;;^UTILITY(U,$J,358.3,22984,0)
 ;;=H59.113^^105^1166^108
 ;;^UTILITY(U,$J,358.3,22984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22984,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Bilateral Eyes/Adnexa Complicating Ophth Procedure
 ;;^UTILITY(U,$J,358.3,22984,1,4,0)
 ;;=4^H59.113
 ;;^UTILITY(U,$J,358.3,22984,2)
 ;;=^5006403
 ;;^UTILITY(U,$J,358.3,22985,0)
 ;;=H59.121^^105^1166^131
 ;;^UTILITY(U,$J,358.3,22985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22985,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Right Eye/Adnexa Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,22985,1,4,0)
 ;;=4^H59.121
 ;;^UTILITY(U,$J,358.3,22985,2)
 ;;=^5006405
 ;;^UTILITY(U,$J,358.3,22986,0)
 ;;=H59.122^^105^1166^123
 ;;^UTILITY(U,$J,358.3,22986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22986,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Left Eye/Adnexa Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,22986,1,4,0)
 ;;=4^H59.122
 ;;^UTILITY(U,$J,358.3,22986,2)
 ;;=^5006406
 ;;^UTILITY(U,$J,358.3,22987,0)
 ;;=H59.123^^105^1166^109
 ;;^UTILITY(U,$J,358.3,22987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22987,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Bilateral Eyes/Adnexa Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,22987,1,4,0)
 ;;=4^H59.123
 ;;^UTILITY(U,$J,358.3,22987,2)
 ;;=^5006407
 ;;^UTILITY(U,$J,358.3,22988,0)
 ;;=H95.21^^105^1166^116
 ;;^UTILITY(U,$J,358.3,22988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22988,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Ear/Mastoid Complicating Ear/Mastoid Procedure
 ;;^UTILITY(U,$J,358.3,22988,1,4,0)
 ;;=4^H95.21
 ;;^UTILITY(U,$J,358.3,22988,2)
 ;;=^5007026
 ;;^UTILITY(U,$J,358.3,22989,0)
 ;;=H95.22^^105^1166^117
 ;;^UTILITY(U,$J,358.3,22989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22989,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Ear/Mastoid Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,22989,1,4,0)
 ;;=4^H95.22
 ;;^UTILITY(U,$J,358.3,22989,2)
 ;;=^5007027
 ;;^UTILITY(U,$J,358.3,22990,0)
 ;;=I97.410^^105^1166^110
 ;;^UTILITY(U,$J,358.3,22990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22990,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Circ Sys Complicating Card Catheterization
 ;;^UTILITY(U,$J,358.3,22990,1,4,0)
 ;;=4^I97.410
 ;;^UTILITY(U,$J,358.3,22990,2)
 ;;=^5008093
 ;;^UTILITY(U,$J,358.3,22991,0)
 ;;=I97.411^^105^1166^111
 ;;^UTILITY(U,$J,358.3,22991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22991,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Circ Sys Complicating Cardiac Bypass
