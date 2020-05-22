IBDEI1FR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22968,2)
 ;;=^5008346
 ;;^UTILITY(U,$J,358.3,22969,0)
 ;;=K91.81^^105^1166^105
 ;;^UTILITY(U,$J,358.3,22969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22969,1,3,0)
 ;;=3^Intraop Complications of Digestive System
 ;;^UTILITY(U,$J,358.3,22969,1,4,0)
 ;;=4^K91.81
 ;;^UTILITY(U,$J,358.3,22969,2)
 ;;=^5008907
 ;;^UTILITY(U,$J,358.3,22970,0)
 ;;=K91.82^^105^1166^211
 ;;^UTILITY(U,$J,358.3,22970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22970,1,3,0)
 ;;=3^Postproc Hepatic Failure
 ;;^UTILITY(U,$J,358.3,22970,1,4,0)
 ;;=4^K91.82
 ;;^UTILITY(U,$J,358.3,22970,2)
 ;;=^5008908
 ;;^UTILITY(U,$J,358.3,22971,0)
 ;;=K91.83^^105^1166^212
 ;;^UTILITY(U,$J,358.3,22971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22971,1,3,0)
 ;;=3^Postproc Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,22971,1,4,0)
 ;;=4^K91.83
 ;;^UTILITY(U,$J,358.3,22971,2)
 ;;=^5008909
 ;;^UTILITY(U,$J,358.3,22972,0)
 ;;=K91.89^^105^1166^182
 ;;^UTILITY(U,$J,358.3,22972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22972,1,3,0)
 ;;=3^Postproc Compl/Disorders of Digestive System
 ;;^UTILITY(U,$J,358.3,22972,1,4,0)
 ;;=4^K91.89
 ;;^UTILITY(U,$J,358.3,22972,2)
 ;;=^5008912
 ;;^UTILITY(U,$J,358.3,22973,0)
 ;;=N99.89^^105^1166^183
 ;;^UTILITY(U,$J,358.3,22973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22973,1,3,0)
 ;;=3^Postproc Compl/Disorders of GU System
 ;;^UTILITY(U,$J,358.3,22973,1,4,0)
 ;;=4^N99.89
 ;;^UTILITY(U,$J,358.3,22973,2)
 ;;=^5015971
 ;;^UTILITY(U,$J,358.3,22974,0)
 ;;=N99.81^^105^1166^106
 ;;^UTILITY(U,$J,358.3,22974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22974,1,3,0)
 ;;=3^Intraop Complications of GU System
 ;;^UTILITY(U,$J,358.3,22974,1,4,0)
 ;;=4^N99.81
 ;;^UTILITY(U,$J,358.3,22974,2)
 ;;=^5015967
 ;;^UTILITY(U,$J,358.3,22975,0)
 ;;=D78.01^^105^1166^134
 ;;^UTILITY(U,$J,358.3,22975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22975,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Spleen Complicating Spleen Procedure
 ;;^UTILITY(U,$J,358.3,22975,1,4,0)
 ;;=4^D78.01
 ;;^UTILITY(U,$J,358.3,22975,2)
 ;;=^5002397
 ;;^UTILITY(U,$J,358.3,22976,0)
 ;;=D78.21^^105^1166^209
 ;;^UTILITY(U,$J,358.3,22976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22976,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Spleen After Spleen Proc
 ;;^UTILITY(U,$J,358.3,22976,1,4,0)
 ;;=4^D78.21
 ;;^UTILITY(U,$J,358.3,22976,2)
 ;;=^5002401
 ;;^UTILITY(U,$J,358.3,22977,0)
 ;;=D78.22^^105^1166^208
 ;;^UTILITY(U,$J,358.3,22977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22977,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Spleen After Oth Proc
 ;;^UTILITY(U,$J,358.3,22977,1,4,0)
 ;;=4^D78.22
 ;;^UTILITY(U,$J,358.3,22977,2)
 ;;=^5002402
 ;;^UTILITY(U,$J,358.3,22978,0)
 ;;=E36.01^^105^1166^118
 ;;^UTILITY(U,$J,358.3,22978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22978,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Endo Sys Complicating Endo Sys Procedure
 ;;^UTILITY(U,$J,358.3,22978,1,4,0)
 ;;=4^E36.01
 ;;^UTILITY(U,$J,358.3,22978,2)
 ;;=^5002779
 ;;^UTILITY(U,$J,358.3,22979,0)
 ;;=E36.02^^105^1166^119
 ;;^UTILITY(U,$J,358.3,22979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22979,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Endo Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,22979,1,4,0)
 ;;=4^E36.02
 ;;^UTILITY(U,$J,358.3,22979,2)
 ;;=^5002780
 ;;^UTILITY(U,$J,358.3,22980,0)
 ;;=G97.31^^105^1166^126
 ;;^UTILITY(U,$J,358.3,22980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22980,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Nervous Sys Complicating Nervous Sys Procedure
