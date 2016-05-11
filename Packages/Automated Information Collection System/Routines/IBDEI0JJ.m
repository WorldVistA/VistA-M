IBDEI0JJ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9076,1,3,0)
 ;;=3^Diab w/ Unspec Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,9076,1,4,0)
 ;;=4^E13.311
 ;;^UTILITY(U,$J,358.3,9076,2)
 ;;=^5002673
 ;;^UTILITY(U,$J,358.3,9077,0)
 ;;=E09.339^^41^473^32
 ;;^UTILITY(U,$J,358.3,9077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9077,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Moderate Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,9077,1,4,0)
 ;;=4^E09.339
 ;;^UTILITY(U,$J,358.3,9077,2)
 ;;=^5002557
 ;;^UTILITY(U,$J,358.3,9078,0)
 ;;=E09.349^^41^473^36
 ;;^UTILITY(U,$J,358.3,9078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9078,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Severe Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,9078,1,4,0)
 ;;=4^E09.349
 ;;^UTILITY(U,$J,358.3,9078,2)
 ;;=^5002559
 ;;^UTILITY(U,$J,358.3,9079,0)
 ;;=E13.319^^41^473^50
 ;;^UTILITY(U,$J,358.3,9079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9079,1,3,0)
 ;;=3^Diab w/ Unspec Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,9079,1,4,0)
 ;;=4^E13.319
 ;;^UTILITY(U,$J,358.3,9079,2)
 ;;=^5002674
 ;;^UTILITY(U,$J,358.3,9080,0)
 ;;=H52.4^^41^474^57
 ;;^UTILITY(U,$J,358.3,9080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9080,1,3,0)
 ;;=3^Presbyopia
 ;;^UTILITY(U,$J,358.3,9080,1,4,0)
 ;;=4^H52.4
 ;;^UTILITY(U,$J,358.3,9080,2)
 ;;=^98095
 ;;^UTILITY(U,$J,358.3,9081,0)
 ;;=H01.004^^41^474^6
 ;;^UTILITY(U,$J,358.3,9081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9081,1,3,0)
 ;;=3^Blepharitis,Left Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,9081,1,4,0)
 ;;=4^H01.004
 ;;^UTILITY(U,$J,358.3,9081,2)
 ;;=^5004241
 ;;^UTILITY(U,$J,358.3,9082,0)
 ;;=H01.005^^41^474^5
 ;;^UTILITY(U,$J,358.3,9082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9082,1,3,0)
 ;;=3^Blepharitis,Left Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,9082,1,4,0)
 ;;=4^H01.005
 ;;^UTILITY(U,$J,358.3,9082,2)
 ;;=^5133380
 ;;^UTILITY(U,$J,358.3,9083,0)
 ;;=H02.105^^41^474^24
 ;;^UTILITY(U,$J,358.3,9083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9083,1,3,0)
 ;;=3^Ectropion,Left Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,9083,1,4,0)
 ;;=4^H02.105
 ;;^UTILITY(U,$J,358.3,9083,2)
 ;;=^5133409
 ;;^UTILITY(U,$J,358.3,9084,0)
 ;;=H02.104^^41^474^25
 ;;^UTILITY(U,$J,358.3,9084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9084,1,3,0)
 ;;=3^Ectropion,Left Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,9084,1,4,0)
 ;;=4^H02.104
 ;;^UTILITY(U,$J,358.3,9084,2)
 ;;=^5004305
 ;;^UTILITY(U,$J,358.3,9085,0)
 ;;=H02.101^^41^474^27
 ;;^UTILITY(U,$J,358.3,9085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9085,1,3,0)
 ;;=3^Ectropion,Right Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,9085,1,4,0)
 ;;=4^H02.101
 ;;^UTILITY(U,$J,358.3,9085,2)
 ;;=^5004303
 ;;^UTILITY(U,$J,358.3,9086,0)
 ;;=H02.102^^41^474^26
 ;;^UTILITY(U,$J,358.3,9086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9086,1,3,0)
 ;;=3^Ectropion,Right Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,9086,1,4,0)
 ;;=4^H02.102
 ;;^UTILITY(U,$J,358.3,9086,2)
 ;;=^5133407
 ;;^UTILITY(U,$J,358.3,9087,0)
 ;;=H04.121^^41^474^23
 ;;^UTILITY(U,$J,358.3,9087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9087,1,3,0)
 ;;=3^Dry Eye Syndrome,Right Lacrimal Gland
 ;;^UTILITY(U,$J,358.3,9087,1,4,0)
 ;;=4^H04.121
 ;;^UTILITY(U,$J,358.3,9087,2)
 ;;=^5004463
 ;;^UTILITY(U,$J,358.3,9088,0)
 ;;=H04.122^^41^474^22
 ;;^UTILITY(U,$J,358.3,9088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9088,1,3,0)
 ;;=3^Dry Eye Syndrome,Left Lacrimal Gland
 ;;^UTILITY(U,$J,358.3,9088,1,4,0)
 ;;=4^H04.122
 ;;^UTILITY(U,$J,358.3,9088,2)
 ;;=^5004464
