IBDEI0JC ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8702,1,3,0)
 ;;=3^Sickle-Cell/Hb-C Disease w/o Crisis
 ;;^UTILITY(U,$J,358.3,8702,1,4,0)
 ;;=4^D57.20
 ;;^UTILITY(U,$J,358.3,8702,2)
 ;;=^330080
 ;;^UTILITY(U,$J,358.3,8703,0)
 ;;=D57.211^^39^401^196
 ;;^UTILITY(U,$J,358.3,8703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8703,1,3,0)
 ;;=3^Sickle-Cell/Hb-C Disease w/ Acute Chest Syndrome
 ;;^UTILITY(U,$J,358.3,8703,1,4,0)
 ;;=4^D57.211
 ;;^UTILITY(U,$J,358.3,8703,2)
 ;;=^5002310
 ;;^UTILITY(U,$J,358.3,8704,0)
 ;;=D57.212^^39^401^200
 ;;^UTILITY(U,$J,358.3,8704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8704,1,3,0)
 ;;=3^Sickle-Cell/Hb-C Disease w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,8704,1,4,0)
 ;;=4^D57.212
 ;;^UTILITY(U,$J,358.3,8704,2)
 ;;=^5002311
 ;;^UTILITY(U,$J,358.3,8705,0)
 ;;=D57.213^^39^401^197
 ;;^UTILITY(U,$J,358.3,8705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8705,1,3,0)
 ;;=3^Sickle-Cell/Hb-C Disease w/ Cerebral Vascular Involvement
 ;;^UTILITY(U,$J,358.3,8705,1,4,0)
 ;;=4^D57.213
 ;;^UTILITY(U,$J,358.3,8705,2)
 ;;=^5159080
 ;;^UTILITY(U,$J,358.3,8706,0)
 ;;=D57.218^^39^401^198
 ;;^UTILITY(U,$J,358.3,8706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8706,1,3,0)
 ;;=3^Sickle-Cell/Hb-C Disease w/ Crisis w/ Oth Complication
 ;;^UTILITY(U,$J,358.3,8706,1,4,0)
 ;;=4^D57.218
 ;;^UTILITY(U,$J,358.3,8706,2)
 ;;=^5159081
 ;;^UTILITY(U,$J,358.3,8707,0)
 ;;=D57.219^^39^401^199
 ;;^UTILITY(U,$J,358.3,8707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8707,1,3,0)
 ;;=3^Sickle-Cell/Hb-C Disease w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,8707,1,4,0)
 ;;=4^D57.219
 ;;^UTILITY(U,$J,358.3,8707,2)
 ;;=^5002312
 ;;^UTILITY(U,$J,358.3,8708,0)
 ;;=D57.3^^39^401^195
 ;;^UTILITY(U,$J,358.3,8708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8708,1,3,0)
 ;;=3^Sickle-Cell Trait
 ;;^UTILITY(U,$J,358.3,8708,1,4,0)
 ;;=4^D57.3
 ;;^UTILITY(U,$J,358.3,8708,2)
 ;;=^5002313
 ;;^UTILITY(U,$J,358.3,8709,0)
 ;;=D57.40^^39^401^192
 ;;^UTILITY(U,$J,358.3,8709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8709,1,3,0)
 ;;=3^Sickle-Cell Thalassemia w/o Crisis
 ;;^UTILITY(U,$J,358.3,8709,1,4,0)
 ;;=4^D57.40
 ;;^UTILITY(U,$J,358.3,8709,2)
 ;;=^329908
 ;;^UTILITY(U,$J,358.3,8710,0)
 ;;=D57.411^^39^401^193
 ;;^UTILITY(U,$J,358.3,8710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8710,1,3,0)
 ;;=3^Sickle-Cell Thalassemia,Unspec w/ Acute Chest Syndrome
 ;;^UTILITY(U,$J,358.3,8710,1,4,0)
 ;;=4^D57.411
 ;;^UTILITY(U,$J,358.3,8710,2)
 ;;=^5002314
 ;;^UTILITY(U,$J,358.3,8711,0)
 ;;=D57.412^^39^401^194
 ;;^UTILITY(U,$J,358.3,8711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8711,1,3,0)
 ;;=3^Sickle-Cell Thalassemia,Unspec w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,8711,1,4,0)
 ;;=4^D57.412
 ;;^UTILITY(U,$J,358.3,8711,2)
 ;;=^5002315
 ;;^UTILITY(U,$J,358.3,8712,0)
 ;;=M31.10^^39^401^215
 ;;^UTILITY(U,$J,358.3,8712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8712,1,3,0)
 ;;=3^Thrombotic Microangiopathy,Unspec
 ;;^UTILITY(U,$J,358.3,8712,1,4,0)
 ;;=4^M31.10
 ;;^UTILITY(U,$J,358.3,8712,2)
 ;;=^5161189
 ;;^UTILITY(U,$J,358.3,8713,0)
 ;;=Z85.818^^39^402^86
 ;;^UTILITY(U,$J,358.3,8713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8713,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Lip,Oral Cavity & Pharynx
 ;;^UTILITY(U,$J,358.3,8713,1,4,0)
 ;;=4^Z85.818
 ;;^UTILITY(U,$J,358.3,8713,2)
 ;;=^5063439
 ;;^UTILITY(U,$J,358.3,8714,0)
 ;;=Z85.819^^39^402^87
