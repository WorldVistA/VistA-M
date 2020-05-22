IBDEI0D9 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32442,1,2,0)
 ;;=2^99397
 ;;^UTILITY(U,$J,358.3,32443,0)
 ;;=99385^^97^1263^1
 ;;^UTILITY(U,$J,358.3,32443,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,32443,1,1,0)
 ;;=1^Preventive Med,New Pt,18-39
 ;;^UTILITY(U,$J,358.3,32443,1,2,0)
 ;;=2^99385
 ;;^UTILITY(U,$J,358.3,32444,0)
 ;;=99386^^97^1263^2
 ;;^UTILITY(U,$J,358.3,32444,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,32444,1,1,0)
 ;;=1^Preventive Med,New Pt,40-64
 ;;^UTILITY(U,$J,358.3,32444,1,2,0)
 ;;=2^99386
 ;;^UTILITY(U,$J,358.3,32445,0)
 ;;=99387^^97^1263^3
 ;;^UTILITY(U,$J,358.3,32445,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,32445,1,1,0)
 ;;=1^Preventive Med,New Pt > 64
 ;;^UTILITY(U,$J,358.3,32445,1,2,0)
 ;;=2^99387
 ;;^UTILITY(U,$J,358.3,32446,0)
 ;;=Z77.010^^98^1264^3
 ;;^UTILITY(U,$J,358.3,32446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32446,1,3,0)
 ;;=3^Contact/Suspected Exposure to Arsenic
 ;;^UTILITY(U,$J,358.3,32446,1,4,0)
 ;;=4^Z77.010
 ;;^UTILITY(U,$J,358.3,32446,2)
 ;;=^5063305
 ;;^UTILITY(U,$J,358.3,32447,0)
 ;;=Z77.011^^98^1264^10
 ;;^UTILITY(U,$J,358.3,32447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32447,1,3,0)
 ;;=3^Contact/Suspected Exposure to Lead
 ;;^UTILITY(U,$J,358.3,32447,1,4,0)
 ;;=4^Z77.011
 ;;^UTILITY(U,$J,358.3,32447,2)
 ;;=^5063306
 ;;^UTILITY(U,$J,358.3,32448,0)
 ;;=Z77.012^^98^1264^21
 ;;^UTILITY(U,$J,358.3,32448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32448,1,3,0)
 ;;=3^Contact/Suspected Exposure to Uranium
 ;;^UTILITY(U,$J,358.3,32448,1,4,0)
 ;;=4^Z77.012
 ;;^UTILITY(U,$J,358.3,32448,2)
 ;;=^5063307
 ;;^UTILITY(U,$J,358.3,32449,0)
 ;;=Z77.018^^98^1264^8
 ;;^UTILITY(U,$J,358.3,32449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32449,1,3,0)
 ;;=3^Contact/Suspected Exposure to Hazardous Materials
 ;;^UTILITY(U,$J,358.3,32449,1,4,0)
 ;;=4^Z77.018
 ;;^UTILITY(U,$J,358.3,32449,2)
 ;;=^5063308
 ;;^UTILITY(U,$J,358.3,32450,0)
 ;;=Z77.020^^98^1264^2
 ;;^UTILITY(U,$J,358.3,32450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32450,1,3,0)
 ;;=3^Contact/Suspected Exposure to Aromatic Amines
 ;;^UTILITY(U,$J,358.3,32450,1,4,0)
 ;;=4^Z77.020
 ;;^UTILITY(U,$J,358.3,32450,2)
 ;;=^5063309
 ;;^UTILITY(U,$J,358.3,32451,0)
 ;;=Z77.021^^98^1264^5
 ;;^UTILITY(U,$J,358.3,32451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32451,1,3,0)
 ;;=3^Contact/Suspected Exposure to Benzene
 ;;^UTILITY(U,$J,358.3,32451,1,4,0)
 ;;=4^Z77.021
 ;;^UTILITY(U,$J,358.3,32451,2)
 ;;=^5063310
 ;;^UTILITY(U,$J,358.3,32452,0)
 ;;=Z77.028^^98^1264^14
 ;;^UTILITY(U,$J,358.3,32452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32452,1,3,0)
 ;;=3^Contact/Suspected Exposure to Oth Hazardous Aromatics
 ;;^UTILITY(U,$J,358.3,32452,1,4,0)
 ;;=4^Z77.028
 ;;^UTILITY(U,$J,358.3,32452,2)
 ;;=^5063311
 ;;^UTILITY(U,$J,358.3,32453,0)
 ;;=Z77.090^^98^1264^4
 ;;^UTILITY(U,$J,358.3,32453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32453,1,3,0)
 ;;=3^Contact/Suspected Exposure to Asbestos
 ;;^UTILITY(U,$J,358.3,32453,1,4,0)
 ;;=4^Z77.090
 ;;^UTILITY(U,$J,358.3,32453,2)
 ;;=^5063312
 ;;^UTILITY(U,$J,358.3,32454,0)
 ;;=Z77.098^^98^1264^15
 ;;^UTILITY(U,$J,358.3,32454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32454,1,3,0)
 ;;=3^Contact/Suspected Exposure to Oth Hazardous Chemicals
 ;;^UTILITY(U,$J,358.3,32454,1,4,0)
 ;;=4^Z77.098
 ;;^UTILITY(U,$J,358.3,32454,2)
 ;;=^5063313
 ;;^UTILITY(U,$J,358.3,32455,0)
 ;;=Z77.110^^98^1264^1
 ;;^UTILITY(U,$J,358.3,32455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32455,1,3,0)
 ;;=3^Contact/Suspected Exposure to Air Pollution
 ;;^UTILITY(U,$J,358.3,32455,1,4,0)
 ;;=4^Z77.110
 ;;^UTILITY(U,$J,358.3,32455,2)
 ;;=^5063314
 ;;^UTILITY(U,$J,358.3,32456,0)
 ;;=Z77.111^^98^1264^22
 ;;^UTILITY(U,$J,358.3,32456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32456,1,3,0)
 ;;=3^Contact/Suspected Exposure to Water Pollution
 ;;^UTILITY(U,$J,358.3,32456,1,4,0)
 ;;=4^Z77.111
 ;;^UTILITY(U,$J,358.3,32456,2)
 ;;=^5063315
 ;;^UTILITY(U,$J,358.3,32457,0)
 ;;=Z77.112^^98^1264^20
 ;;^UTILITY(U,$J,358.3,32457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32457,1,3,0)
 ;;=3^Contact/Suspected Exposure to Soil Pollution
 ;;^UTILITY(U,$J,358.3,32457,1,4,0)
 ;;=4^Z77.112
 ;;^UTILITY(U,$J,358.3,32457,2)
 ;;=^5063316
 ;;^UTILITY(U,$J,358.3,32458,0)
 ;;=Z77.118^^98^1264^13
 ;;^UTILITY(U,$J,358.3,32458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32458,1,3,0)
 ;;=3^Contact/Suspected Exposure to Oth Environmental Pollution
 ;;^UTILITY(U,$J,358.3,32458,1,4,0)
 ;;=4^Z77.118
 ;;^UTILITY(U,$J,358.3,32458,2)
 ;;=^5063317
 ;;^UTILITY(U,$J,358.3,32459,0)
 ;;=Z77.120^^98^1264^11
 ;;^UTILITY(U,$J,358.3,32459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32459,1,3,0)
 ;;=3^Contact/Suspected Exposure to Mold (Toxic)
 ;;^UTILITY(U,$J,358.3,32459,1,4,0)
 ;;=4^Z77.120
 ;;^UTILITY(U,$J,358.3,32459,2)
 ;;=^5063318
 ;;^UTILITY(U,$J,358.3,32460,0)
 ;;=Z77.121^^98^1264^7
 ;;^UTILITY(U,$J,358.3,32460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32460,1,3,0)
 ;;=3^Contact/Suspected Exposure to Harmful Algae/Algae Toxins
 ;;^UTILITY(U,$J,358.3,32460,1,4,0)
 ;;=4^Z77.121
 ;;^UTILITY(U,$J,358.3,32460,2)
 ;;=^5063319
 ;;^UTILITY(U,$J,358.3,32461,0)
 ;;=Z77.123^^98^1264^19
 ;;^UTILITY(U,$J,358.3,32461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32461,1,3,0)
 ;;=3^Contact/Suspected Exposure to Radon/Natual Radiation
 ;;^UTILITY(U,$J,358.3,32461,1,4,0)
 ;;=4^Z77.123
 ;;^UTILITY(U,$J,358.3,32461,2)
 ;;=^5063321
 ;;^UTILITY(U,$J,358.3,32462,0)
 ;;=Z77.122^^98^1264^12
 ;;^UTILITY(U,$J,358.3,32462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32462,1,3,0)
 ;;=3^Contact/Suspected Exposure to Noise
 ;;^UTILITY(U,$J,358.3,32462,1,4,0)
 ;;=4^Z77.122
 ;;^UTILITY(U,$J,358.3,32462,2)
 ;;=^5063320
 ;;^UTILITY(U,$J,358.3,32463,0)
 ;;=Z77.128^^98^1264^16
 ;;^UTILITY(U,$J,358.3,32463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32463,1,3,0)
 ;;=3^Contact/Suspected Exposure to Oth Hazards in Physcl Environment
 ;;^UTILITY(U,$J,358.3,32463,1,4,0)
 ;;=4^Z77.128
 ;;^UTILITY(U,$J,358.3,32463,2)
 ;;=^5063322
 ;;^UTILITY(U,$J,358.3,32464,0)
 ;;=Z77.21^^98^1264^9
 ;;^UTILITY(U,$J,358.3,32464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32464,1,3,0)
 ;;=3^Contact/Suspected Exposure to Hazardous Body Fluids
 ;;^UTILITY(U,$J,358.3,32464,1,4,0)
 ;;=4^Z77.21
 ;;^UTILITY(U,$J,358.3,32464,2)
 ;;=^5063323
 ;;^UTILITY(U,$J,358.3,32465,0)
 ;;=Z77.22^^98^1264^6
 ;;^UTILITY(U,$J,358.3,32465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32465,1,3,0)
 ;;=3^Contact/Suspected Exposure to Environ Tobacco Smoke
 ;;^UTILITY(U,$J,358.3,32465,1,4,0)
 ;;=4^Z77.22
 ;;^UTILITY(U,$J,358.3,32465,2)
 ;;=^5063324
 ;;^UTILITY(U,$J,358.3,32466,0)
 ;;=Z77.29^^98^1264^17
 ;;^UTILITY(U,$J,358.3,32466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32466,1,3,0)
 ;;=3^Contact/Suspected Exposure to Oth Hazardous Substances
 ;;^UTILITY(U,$J,358.3,32466,1,4,0)
 ;;=4^Z77.29
 ;;^UTILITY(U,$J,358.3,32466,2)
 ;;=^5063325
 ;;^UTILITY(U,$J,358.3,32467,0)
 ;;=Z77.9^^98^1264^18
 ;;^UTILITY(U,$J,358.3,32467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32467,1,3,0)
 ;;=3^Contact/Suspected Exposure to Oth Hazards to Health
 ;;^UTILITY(U,$J,358.3,32467,1,4,0)
 ;;=4^Z77.9
 ;;^UTILITY(U,$J,358.3,32467,2)
 ;;=^5063326
