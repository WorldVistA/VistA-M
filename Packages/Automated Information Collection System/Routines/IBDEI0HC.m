IBDEI0HC ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17421,1,3,0)
 ;;=3^Hyperkalemia
 ;;^UTILITY(U,$J,358.3,17421,1,4,0)
 ;;=4^E87.5
 ;;^UTILITY(U,$J,358.3,17421,2)
 ;;=^60041
 ;;^UTILITY(U,$J,358.3,17422,0)
 ;;=E87.6^^76^895^32
 ;;^UTILITY(U,$J,358.3,17422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17422,1,3,0)
 ;;=3^Hypokalemia
 ;;^UTILITY(U,$J,358.3,17422,1,4,0)
 ;;=4^E87.6
 ;;^UTILITY(U,$J,358.3,17422,2)
 ;;=^60610
 ;;^UTILITY(U,$J,358.3,17423,0)
 ;;=G81.91^^76^895^11
 ;;^UTILITY(U,$J,358.3,17423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17423,1,3,0)
 ;;=3^Hemiplegia affecting rt dominant side, unspec
 ;;^UTILITY(U,$J,358.3,17423,1,4,0)
 ;;=4^G81.91
 ;;^UTILITY(U,$J,358.3,17423,2)
 ;;=^5004121
 ;;^UTILITY(U,$J,358.3,17424,0)
 ;;=G81.92^^76^895^9
 ;;^UTILITY(U,$J,358.3,17424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17424,1,3,0)
 ;;=3^Hemiplegia affecting lft dominant side, unspec
 ;;^UTILITY(U,$J,358.3,17424,1,4,0)
 ;;=4^G81.92
 ;;^UTILITY(U,$J,358.3,17424,2)
 ;;=^5004122
 ;;^UTILITY(U,$J,358.3,17425,0)
 ;;=G81.93^^76^895^12
 ;;^UTILITY(U,$J,358.3,17425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17425,1,3,0)
 ;;=3^Hemiplegia affecting rt nondom side, unspec
 ;;^UTILITY(U,$J,358.3,17425,1,4,0)
 ;;=4^G81.93
 ;;^UTILITY(U,$J,358.3,17425,2)
 ;;=^5004123
 ;;^UTILITY(U,$J,358.3,17426,0)
 ;;=G81.94^^76^895^10
 ;;^UTILITY(U,$J,358.3,17426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17426,1,3,0)
 ;;=3^Hemiplegia affecting lft nondom side, unspec
 ;;^UTILITY(U,$J,358.3,17426,1,4,0)
 ;;=4^G81.94
 ;;^UTILITY(U,$J,358.3,17426,2)
 ;;=^5004124
 ;;^UTILITY(U,$J,358.3,17427,0)
 ;;=H91.90^^76^895^7
 ;;^UTILITY(U,$J,358.3,17427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17427,1,3,0)
 ;;=3^Hearing loss, unspec ear, unspec
 ;;^UTILITY(U,$J,358.3,17427,1,4,0)
 ;;=4^H91.90
 ;;^UTILITY(U,$J,358.3,17427,2)
 ;;=^5006943
 ;;^UTILITY(U,$J,358.3,17428,0)
 ;;=I10.^^76^895^27
 ;;^UTILITY(U,$J,358.3,17428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17428,1,3,0)
 ;;=3^Hypertension, essential (primary)
 ;;^UTILITY(U,$J,358.3,17428,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,17428,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,17429,0)
 ;;=K64.8^^76^895^15
 ;;^UTILITY(U,$J,358.3,17429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17429,1,3,0)
 ;;=3^Hemorrhoids, oth
 ;;^UTILITY(U,$J,358.3,17429,1,4,0)
 ;;=4^K64.8
 ;;^UTILITY(U,$J,358.3,17429,2)
 ;;=^5008774
 ;;^UTILITY(U,$J,358.3,17430,0)
 ;;=K64.4^^76^895^14
 ;;^UTILITY(U,$J,358.3,17430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17430,1,3,0)
 ;;=3^Hemorrhoidal Skin Tags,Residual
 ;;^UTILITY(U,$J,358.3,17430,1,4,0)
 ;;=4^K64.4
 ;;^UTILITY(U,$J,358.3,17430,2)
 ;;=^269834
 ;;^UTILITY(U,$J,358.3,17431,0)
 ;;=I95.9^^76^895^33
 ;;^UTILITY(U,$J,358.3,17431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17431,1,3,0)
 ;;=3^Hypotension, unspec
 ;;^UTILITY(U,$J,358.3,17431,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,17431,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,17432,0)
 ;;=K40.90^^76^895^37
 ;;^UTILITY(U,$J,358.3,17432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17432,1,3,0)
 ;;=3^Uniltrl Ing hernia, w/o obst/ganr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,17432,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,17432,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,17433,0)
 ;;=K40.20^^76^895^4
 ;;^UTILITY(U,$J,358.3,17433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17433,1,3,0)
 ;;=3^Biltrl Ing hernia, w/o obst/ganr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,17433,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,17433,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,17434,0)
 ;;=K42.9^^76^895^36
 ;;^UTILITY(U,$J,358.3,17434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17434,1,3,0)
 ;;=3^Umbilical hernia w/o obst/gangr or gangrene
 ;;^UTILITY(U,$J,358.3,17434,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,17434,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,17435,0)
 ;;=K43.2^^76^895^35
 ;;^UTILITY(U,$J,358.3,17435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17435,1,3,0)
 ;;=3^Incisional hernia w/o obstr/gangr
 ;;^UTILITY(U,$J,358.3,17435,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,17435,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,17436,0)
 ;;=K44.9^^76^895^5
 ;;^UTILITY(U,$J,358.3,17436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17436,1,3,0)
 ;;=3^Diaphragmatic hernia w/o obstr/gangr
 ;;^UTILITY(U,$J,358.3,17436,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,17436,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,17437,0)
 ;;=K46.9^^76^895^1
 ;;^UTILITY(U,$J,358.3,17437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17437,1,3,0)
 ;;=3^Abdominal hernia w/o obstr/gangr, unspec
 ;;^UTILITY(U,$J,358.3,17437,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,17437,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,17438,0)
 ;;=K73.9^^76^895^20
 ;;^UTILITY(U,$J,358.3,17438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17438,1,3,0)
 ;;=3^Hepatitis C,Chronic Unspec
 ;;^UTILITY(U,$J,358.3,17438,1,4,0)
 ;;=4^K73.9
 ;;^UTILITY(U,$J,358.3,17438,2)
 ;;=^5008815
 ;;^UTILITY(U,$J,358.3,17439,0)
 ;;=R31.9^^76^895^8
 ;;^UTILITY(U,$J,358.3,17439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17439,1,3,0)
 ;;=3^Hematuria, unspec
 ;;^UTILITY(U,$J,358.3,17439,1,4,0)
 ;;=4^R31.9
 ;;^UTILITY(U,$J,358.3,17439,2)
 ;;=^5019328
 ;;^UTILITY(U,$J,358.3,17440,0)
 ;;=N43.3^^76^895^23
 ;;^UTILITY(U,$J,358.3,17440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17440,1,3,0)
 ;;=3^Hydrocele, unspec
 ;;^UTILITY(U,$J,358.3,17440,1,4,0)
 ;;=4^N43.3
 ;;^UTILITY(U,$J,358.3,17440,2)
 ;;=^5015700
 ;;^UTILITY(U,$J,358.3,17441,0)
 ;;=R51.^^76^895^6
 ;;^UTILITY(U,$J,358.3,17441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17441,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,17441,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,17441,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,17442,0)
 ;;=Z22.52^^76^895^19
 ;;^UTILITY(U,$J,358.3,17442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17442,1,3,0)
 ;;=3^Hepatitis C Carrier
 ;;^UTILITY(U,$J,358.3,17442,1,4,0)
 ;;=4^Z22.52
 ;;^UTILITY(U,$J,358.3,17442,2)
 ;;=^5062790
 ;;^UTILITY(U,$J,358.3,17443,0)
 ;;=Z21.^^76^895^3
 ;;^UTILITY(U,$J,358.3,17443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17443,1,3,0)
 ;;=3^Asymptomatic HIV infection status
 ;;^UTILITY(U,$J,358.3,17443,1,4,0)
 ;;=4^Z21.
 ;;^UTILITY(U,$J,358.3,17443,2)
 ;;=^5062777
 ;;^UTILITY(U,$J,358.3,17444,0)
 ;;=I69.959^^76^895^17
 ;;^UTILITY(U,$J,358.3,17444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17444,1,3,0)
 ;;=3^Hemplga/Hempris folwng Cerebvasc Dz Aff Unspec Side
 ;;^UTILITY(U,$J,358.3,17444,1,4,0)
 ;;=4^I69.959
 ;;^UTILITY(U,$J,358.3,17444,2)
 ;;=^5007563
 ;;^UTILITY(U,$J,358.3,17445,0)
 ;;=K62.5^^76^895^13
 ;;^UTILITY(U,$J,358.3,17445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17445,1,3,0)
 ;;=3^Hemorrhage of Anus & Rectum
 ;;^UTILITY(U,$J,358.3,17445,1,4,0)
 ;;=4^K62.5
 ;;^UTILITY(U,$J,358.3,17445,2)
 ;;=^5008755
 ;;^UTILITY(U,$J,358.3,17446,0)
 ;;=I69.359^^76^895^16
 ;;^UTILITY(U,$J,358.3,17446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17446,1,3,0)
 ;;=3^Hemplga/Hempris d/t Cerebvasc Infrc Aff Unspec Side
 ;;^UTILITY(U,$J,358.3,17446,1,4,0)
 ;;=4^I69.359
 ;;^UTILITY(U,$J,358.3,17446,2)
 ;;=^5007508
 ;;^UTILITY(U,$J,358.3,17447,0)
 ;;=B88.9^^76^896^3
 ;;^UTILITY(U,$J,358.3,17447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17447,1,3,0)
 ;;=3^Infestation, unspec
 ;;^UTILITY(U,$J,358.3,17447,1,4,0)
 ;;=4^B88.9
 ;;^UTILITY(U,$J,358.3,17447,2)
 ;;=^5000821
 ;;^UTILITY(U,$J,358.3,17448,0)
 ;;=T81.4XXA^^76^896^2
 ;;^UTILITY(U,$J,358.3,17448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17448,1,3,0)
 ;;=3^Infection folwng a procedure, Init Encntr
 ;;^UTILITY(U,$J,358.3,17448,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,17448,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,17449,0)
 ;;=J11.1^^76^896^7
 ;;^UTILITY(U,$J,358.3,17449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17449,1,3,0)
 ;;=3^Influenza d/t unident influ virus w/ oth resp manifst
