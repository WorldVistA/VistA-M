IBDEI0IF ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18558,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,18558,1,4,0)
 ;;=4^E10.618
 ;;^UTILITY(U,$J,358.3,18558,2)
 ;;=^5002614
 ;;^UTILITY(U,$J,358.3,18559,0)
 ;;=E10.638^^84^962^59
 ;;^UTILITY(U,$J,358.3,18559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18559,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oral Complications
 ;;^UTILITY(U,$J,358.3,18559,1,4,0)
 ;;=4^E10.638
 ;;^UTILITY(U,$J,358.3,18559,2)
 ;;=^5002620
 ;;^UTILITY(U,$J,358.3,18560,0)
 ;;=E10.628^^84^962^61
 ;;^UTILITY(U,$J,358.3,18560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18560,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Complications
 ;;^UTILITY(U,$J,358.3,18560,1,4,0)
 ;;=4^E10.628
 ;;^UTILITY(U,$J,358.3,18560,2)
 ;;=^5002618
 ;;^UTILITY(U,$J,358.3,18561,0)
 ;;=E10.622^^84^962^62
 ;;^UTILITY(U,$J,358.3,18561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18561,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Ulcer
 ;;^UTILITY(U,$J,358.3,18561,1,4,0)
 ;;=4^E10.622
 ;;^UTILITY(U,$J,358.3,18561,2)
 ;;=^5002617
 ;;^UTILITY(U,$J,358.3,18562,0)
 ;;=E10.69^^84^962^50
 ;;^UTILITY(U,$J,358.3,18562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18562,1,3,0)
 ;;=3^Diabetes Type 1 w/ Complications NEC
 ;;^UTILITY(U,$J,358.3,18562,1,4,0)
 ;;=4^E10.69
 ;;^UTILITY(U,$J,358.3,18562,2)
 ;;=^5002624
 ;;^UTILITY(U,$J,358.3,18563,0)
 ;;=E10.630^^84^962^60
 ;;^UTILITY(U,$J,358.3,18563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18563,1,3,0)
 ;;=3^Diabetes Type 1 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,18563,1,4,0)
 ;;=4^E10.630
 ;;^UTILITY(U,$J,358.3,18563,2)
 ;;=^5002619
 ;;^UTILITY(U,$J,358.3,18564,0)
 ;;=E11.620^^84^962^65
 ;;^UTILITY(U,$J,358.3,18564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18564,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,18564,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,18564,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,18565,0)
 ;;=E11.40^^84^962^66
 ;;^UTILITY(U,$J,358.3,18565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18565,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,18565,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,18565,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,18566,0)
 ;;=E11.51^^84^962^67
 ;;^UTILITY(U,$J,358.3,18566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18566,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,18566,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,18566,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,18567,0)
 ;;=E11.621^^84^962^68
 ;;^UTILITY(U,$J,358.3,18567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18567,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,18567,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,18567,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,18568,0)
 ;;=E11.65^^84^962^69
 ;;^UTILITY(U,$J,358.3,18568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18568,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,18568,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,18568,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,18569,0)
 ;;=E11.649^^84^962^70
 ;;^UTILITY(U,$J,358.3,18569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18569,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hypoglycemia w/o Coma
 ;;^UTILITY(U,$J,358.3,18569,1,4,0)
 ;;=4^E11.649
 ;;^UTILITY(U,$J,358.3,18569,2)
 ;;=^5002662
 ;;^UTILITY(U,$J,358.3,18570,0)
 ;;=E11.618^^84^962^64
 ;;^UTILITY(U,$J,358.3,18570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18570,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,18570,1,4,0)
 ;;=4^E11.618
 ;;^UTILITY(U,$J,358.3,18570,2)
 ;;=^5002654
 ;;^UTILITY(U,$J,358.3,18571,0)
 ;;=E11.638^^84^962^71
 ;;^UTILITY(U,$J,358.3,18571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18571,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oral Complications
 ;;^UTILITY(U,$J,358.3,18571,1,4,0)
 ;;=4^E11.638
 ;;^UTILITY(U,$J,358.3,18571,2)
 ;;=^5002660
 ;;^UTILITY(U,$J,358.3,18572,0)
 ;;=E11.628^^84^962^73
 ;;^UTILITY(U,$J,358.3,18572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18572,1,3,0)
 ;;=3^Diabetes Type 2 w/ Skin Complications
 ;;^UTILITY(U,$J,358.3,18572,1,4,0)
 ;;=4^E11.628
 ;;^UTILITY(U,$J,358.3,18572,2)
 ;;=^5002658
 ;;^UTILITY(U,$J,358.3,18573,0)
 ;;=E11.622^^84^962^74
 ;;^UTILITY(U,$J,358.3,18573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18573,1,3,0)
 ;;=3^Diabetes Type 2 w/ Skin Ulcer
 ;;^UTILITY(U,$J,358.3,18573,1,4,0)
 ;;=4^E11.622
 ;;^UTILITY(U,$J,358.3,18573,2)
 ;;=^5002657
 ;;^UTILITY(U,$J,358.3,18574,0)
 ;;=E11.69^^84^962^63
 ;;^UTILITY(U,$J,358.3,18574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18574,1,3,0)
 ;;=3^Diabetes Type 2 w/ Complications NEC
 ;;^UTILITY(U,$J,358.3,18574,1,4,0)
 ;;=4^E11.69
 ;;^UTILITY(U,$J,358.3,18574,2)
 ;;=^5002664
 ;;^UTILITY(U,$J,358.3,18575,0)
 ;;=E11.630^^84^962^72
 ;;^UTILITY(U,$J,358.3,18575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18575,1,3,0)
 ;;=3^Diabetes Type 2 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,18575,1,4,0)
 ;;=4^E11.630
 ;;^UTILITY(U,$J,358.3,18575,2)
 ;;=^5002659
 ;;^UTILITY(U,$J,358.3,18576,0)
 ;;=I83.223^^84^962^147
 ;;^UTILITY(U,$J,358.3,18576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18576,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Ankle Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,18576,1,4,0)
 ;;=4^I83.223
 ;;^UTILITY(U,$J,358.3,18576,2)
 ;;=^5008006
 ;;^UTILITY(U,$J,358.3,18577,0)
 ;;=I83.222^^84^962^148
 ;;^UTILITY(U,$J,358.3,18577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18577,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Calf Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,18577,1,4,0)
 ;;=4^I83.222
 ;;^UTILITY(U,$J,358.3,18577,2)
 ;;=^5008005
 ;;^UTILITY(U,$J,358.3,18578,0)
 ;;=I83.224^^84^962^149
 ;;^UTILITY(U,$J,358.3,18578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18578,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Heel/Midfoot Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,18578,1,4,0)
 ;;=4^I83.224
 ;;^UTILITY(U,$J,358.3,18578,2)
 ;;=^5008007
 ;;^UTILITY(U,$J,358.3,18579,0)
 ;;=I83.229^^84^962^150
 ;;^UTILITY(U,$J,358.3,18579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18579,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,18579,1,4,0)
 ;;=4^I83.229
 ;;^UTILITY(U,$J,358.3,18579,2)
 ;;=^5008010
 ;;^UTILITY(U,$J,358.3,18580,0)
 ;;=I83.225^^84^962^151
 ;;^UTILITY(U,$J,358.3,18580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18580,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Foot Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,18580,1,4,0)
 ;;=4^I83.225
 ;;^UTILITY(U,$J,358.3,18580,2)
 ;;=^5008008
 ;;^UTILITY(U,$J,358.3,18581,0)
 ;;=I83.228^^84^962^152
 ;;^UTILITY(U,$J,358.3,18581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18581,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Ulcer/Inflammation NEC
 ;;^UTILITY(U,$J,358.3,18581,1,4,0)
 ;;=4^I83.228
 ;;^UTILITY(U,$J,358.3,18581,2)
 ;;=^5008009
 ;;^UTILITY(U,$J,358.3,18582,0)
 ;;=I83.222^^84^962^153
 ;;^UTILITY(U,$J,358.3,18582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18582,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Calf Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,18582,1,4,0)
 ;;=4^I83.222
 ;;^UTILITY(U,$J,358.3,18582,2)
 ;;=^5008005
 ;;^UTILITY(U,$J,358.3,18583,0)
 ;;=I83.12^^84^962^154
 ;;^UTILITY(U,$J,358.3,18583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18583,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,18583,1,4,0)
 ;;=4^I83.12
 ;;^UTILITY(U,$J,358.3,18583,2)
 ;;=^5007989
 ;;^UTILITY(U,$J,358.3,18584,0)
 ;;=I83.214^^84^962^155
 ;;^UTILITY(U,$J,358.3,18584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18584,1,3,0)
 ;;=3^Varicosse Veins of Right Lower Extrem w/ Heel/Midfoot Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,18584,1,4,0)
 ;;=4^I83.214
