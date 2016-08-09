IBDEI0A1 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10041,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10041,1,4,0)
 ;;=4^E08.311
 ;;^UTILITY(U,$J,358.3,10041,2)
 ;;=^5002510
 ;;^UTILITY(U,$J,358.3,10042,0)
 ;;=E08.319^^51^587^40
 ;;^UTILITY(U,$J,358.3,10042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10042,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10042,1,4,0)
 ;;=4^E08.319
 ;;^UTILITY(U,$J,358.3,10042,2)
 ;;=^5002511
 ;;^UTILITY(U,$J,358.3,10043,0)
 ;;=E08.321^^51^587^41
 ;;^UTILITY(U,$J,358.3,10043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10043,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Mild Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10043,1,4,0)
 ;;=4^E08.321
 ;;^UTILITY(U,$J,358.3,10043,2)
 ;;=^5002512
 ;;^UTILITY(U,$J,358.3,10044,0)
 ;;=E08.329^^51^587^42
 ;;^UTILITY(U,$J,358.3,10044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10044,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10044,1,4,0)
 ;;=4^E08.329
 ;;^UTILITY(U,$J,358.3,10044,2)
 ;;=^5002513
 ;;^UTILITY(U,$J,358.3,10045,0)
 ;;=E08.331^^51^587^43
 ;;^UTILITY(U,$J,358.3,10045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10045,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Moderate Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10045,1,4,0)
 ;;=4^E08.331
 ;;^UTILITY(U,$J,358.3,10045,2)
 ;;=^5002514
 ;;^UTILITY(U,$J,358.3,10046,0)
 ;;=E08.339^^51^587^44
 ;;^UTILITY(U,$J,358.3,10046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10046,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Moderate Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10046,1,4,0)
 ;;=4^E08.339
 ;;^UTILITY(U,$J,358.3,10046,2)
 ;;=^5002515
 ;;^UTILITY(U,$J,358.3,10047,0)
 ;;=E08.341^^51^587^47
 ;;^UTILITY(U,$J,358.3,10047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10047,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Severe Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10047,1,4,0)
 ;;=4^E08.341
 ;;^UTILITY(U,$J,358.3,10047,2)
 ;;=^5002516
 ;;^UTILITY(U,$J,358.3,10048,0)
 ;;=E08.349^^51^587^48
 ;;^UTILITY(U,$J,358.3,10048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10048,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Severe Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10048,1,4,0)
 ;;=4^E08.349
 ;;^UTILITY(U,$J,358.3,10048,2)
 ;;=^5002517
 ;;^UTILITY(U,$J,358.3,10049,0)
 ;;=E09.311^^51^587^37
 ;;^UTILITY(U,$J,358.3,10049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10049,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Unspec Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10049,1,4,0)
 ;;=4^E09.311
 ;;^UTILITY(U,$J,358.3,10049,2)
 ;;=^5002552
 ;;^UTILITY(U,$J,358.3,10050,0)
 ;;=E09.319^^51^587^38
 ;;^UTILITY(U,$J,358.3,10050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10050,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Unspec Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10050,1,4,0)
 ;;=4^E09.319
 ;;^UTILITY(U,$J,358.3,10050,2)
 ;;=^5002553
 ;;^UTILITY(U,$J,358.3,10051,0)
 ;;=E09.321^^51^587^29
 ;;^UTILITY(U,$J,358.3,10051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10051,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Mild Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10051,1,4,0)
 ;;=4^E09.321
 ;;^UTILITY(U,$J,358.3,10051,2)
 ;;=^5002554
 ;;^UTILITY(U,$J,358.3,10052,0)
 ;;=E09.329^^51^587^30
 ;;^UTILITY(U,$J,358.3,10052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10052,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10052,1,4,0)
 ;;=4^E09.329
 ;;^UTILITY(U,$J,358.3,10052,2)
 ;;=^5002555
 ;;^UTILITY(U,$J,358.3,10053,0)
 ;;=E09.351^^51^587^33
 ;;^UTILITY(U,$J,358.3,10053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10053,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10053,1,4,0)
 ;;=4^E09.351
 ;;^UTILITY(U,$J,358.3,10053,2)
 ;;=^5002560
 ;;^UTILITY(U,$J,358.3,10054,0)
 ;;=E09.359^^51^587^34
 ;;^UTILITY(U,$J,358.3,10054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10054,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10054,1,4,0)
 ;;=4^E09.359
 ;;^UTILITY(U,$J,358.3,10054,2)
 ;;=^5002561
 ;;^UTILITY(U,$J,358.3,10055,0)
 ;;=E08.351^^51^587^45
 ;;^UTILITY(U,$J,358.3,10055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10055,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Prolif Diab Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10055,1,4,0)
 ;;=4^E08.351
 ;;^UTILITY(U,$J,358.3,10055,2)
 ;;=^5002518
 ;;^UTILITY(U,$J,358.3,10056,0)
 ;;=E08.359^^51^587^46
 ;;^UTILITY(U,$J,358.3,10056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10056,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Prolif Diab Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10056,1,4,0)
 ;;=4^E08.359
 ;;^UTILITY(U,$J,358.3,10056,2)
 ;;=^5002519
 ;;^UTILITY(U,$J,358.3,10057,0)
 ;;=E13.351^^51^587^27
 ;;^UTILITY(U,$J,358.3,10057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10057,1,3,0)
 ;;=3^DM w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10057,1,4,0)
 ;;=4^E13.351
 ;;^UTILITY(U,$J,358.3,10057,2)
 ;;=^5002680
 ;;^UTILITY(U,$J,358.3,10058,0)
 ;;=E13.359^^51^587^28
 ;;^UTILITY(U,$J,358.3,10058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10058,1,3,0)
 ;;=3^DM w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10058,1,4,0)
 ;;=4^E13.359
 ;;^UTILITY(U,$J,358.3,10058,2)
 ;;=^5002681
 ;;^UTILITY(U,$J,358.3,10059,0)
 ;;=E09.331^^51^587^31
 ;;^UTILITY(U,$J,358.3,10059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10059,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Moderate Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10059,1,4,0)
 ;;=4^E09.331
 ;;^UTILITY(U,$J,358.3,10059,2)
 ;;=^5002556
 ;;^UTILITY(U,$J,358.3,10060,0)
 ;;=E09.341^^51^587^35
 ;;^UTILITY(U,$J,358.3,10060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10060,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Severe Nonprolif Diab Retinopathy w/ Macula Edema
 ;;^UTILITY(U,$J,358.3,10060,1,4,0)
 ;;=4^E09.341
 ;;^UTILITY(U,$J,358.3,10060,2)
 ;;=^5002558
 ;;^UTILITY(U,$J,358.3,10061,0)
 ;;=E13.311^^51^587^49
 ;;^UTILITY(U,$J,358.3,10061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10061,1,3,0)
 ;;=3^Diab w/ Unspec Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10061,1,4,0)
 ;;=4^E13.311
 ;;^UTILITY(U,$J,358.3,10061,2)
 ;;=^5002673
 ;;^UTILITY(U,$J,358.3,10062,0)
 ;;=E09.339^^51^587^32
 ;;^UTILITY(U,$J,358.3,10062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10062,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Moderate Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10062,1,4,0)
 ;;=4^E09.339
 ;;^UTILITY(U,$J,358.3,10062,2)
 ;;=^5002557
 ;;^UTILITY(U,$J,358.3,10063,0)
 ;;=E09.349^^51^587^36
 ;;^UTILITY(U,$J,358.3,10063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10063,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Severe Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10063,1,4,0)
 ;;=4^E09.349
 ;;^UTILITY(U,$J,358.3,10063,2)
 ;;=^5002559
 ;;^UTILITY(U,$J,358.3,10064,0)
 ;;=E13.319^^51^587^50
 ;;^UTILITY(U,$J,358.3,10064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10064,1,3,0)
 ;;=3^Diab w/ Unspec Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10064,1,4,0)
 ;;=4^E13.319
 ;;^UTILITY(U,$J,358.3,10064,2)
 ;;=^5002674
 ;;^UTILITY(U,$J,358.3,10065,0)
 ;;=H52.4^^51^588^57
 ;;^UTILITY(U,$J,358.3,10065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10065,1,3,0)
 ;;=3^Presbyopia
 ;;^UTILITY(U,$J,358.3,10065,1,4,0)
 ;;=4^H52.4
 ;;^UTILITY(U,$J,358.3,10065,2)
 ;;=^98095
 ;;^UTILITY(U,$J,358.3,10066,0)
 ;;=H01.004^^51^588^6
 ;;^UTILITY(U,$J,358.3,10066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10066,1,3,0)
 ;;=3^Blepharitis,Left Upper Eyelid,Unspec
