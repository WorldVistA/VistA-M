IBDEI00D ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,145,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oral Complications
 ;;^UTILITY(U,$J,358.3,145,1,4,0)
 ;;=4^E11.638
 ;;^UTILITY(U,$J,358.3,145,2)
 ;;=^5002660
 ;;^UTILITY(U,$J,358.3,146,0)
 ;;=E11.628^^1^1^76
 ;;^UTILITY(U,$J,358.3,146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,146,1,3,0)
 ;;=3^Diabetes Type 2 w/ Skin Complications
 ;;^UTILITY(U,$J,358.3,146,1,4,0)
 ;;=4^E11.628
 ;;^UTILITY(U,$J,358.3,146,2)
 ;;=^5002658
 ;;^UTILITY(U,$J,358.3,147,0)
 ;;=E11.622^^1^1^77
 ;;^UTILITY(U,$J,358.3,147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,147,1,3,0)
 ;;=3^Diabetes Type 2 w/ Skin Ulcer
 ;;^UTILITY(U,$J,358.3,147,1,4,0)
 ;;=4^E11.622
 ;;^UTILITY(U,$J,358.3,147,2)
 ;;=^5002657
 ;;^UTILITY(U,$J,358.3,148,0)
 ;;=E11.69^^1^1^66
 ;;^UTILITY(U,$J,358.3,148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,148,1,3,0)
 ;;=3^Diabetes Type 2 w/ Complications NEC
 ;;^UTILITY(U,$J,358.3,148,1,4,0)
 ;;=4^E11.69
 ;;^UTILITY(U,$J,358.3,148,2)
 ;;=^5002664
 ;;^UTILITY(U,$J,358.3,149,0)
 ;;=E11.630^^1^1^75
 ;;^UTILITY(U,$J,358.3,149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,149,1,3,0)
 ;;=3^Diabetes Type 2 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,149,1,4,0)
 ;;=4^E11.630
 ;;^UTILITY(U,$J,358.3,149,2)
 ;;=^5002659
 ;;^UTILITY(U,$J,358.3,150,0)
 ;;=I83.223^^1^1^149
 ;;^UTILITY(U,$J,358.3,150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,150,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Ankle Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,150,1,4,0)
 ;;=4^I83.223
 ;;^UTILITY(U,$J,358.3,150,2)
 ;;=^5008006
 ;;^UTILITY(U,$J,358.3,151,0)
 ;;=I83.222^^1^1^150
 ;;^UTILITY(U,$J,358.3,151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,151,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Calf Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,151,1,4,0)
 ;;=4^I83.222
 ;;^UTILITY(U,$J,358.3,151,2)
 ;;=^5008005
 ;;^UTILITY(U,$J,358.3,152,0)
 ;;=I83.224^^1^1^151
 ;;^UTILITY(U,$J,358.3,152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,152,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Heel/Midfoot Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,152,1,4,0)
 ;;=4^I83.224
 ;;^UTILITY(U,$J,358.3,152,2)
 ;;=^5008007
 ;;^UTILITY(U,$J,358.3,153,0)
 ;;=I83.229^^1^1^152
 ;;^UTILITY(U,$J,358.3,153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,153,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,153,1,4,0)
 ;;=4^I83.229
 ;;^UTILITY(U,$J,358.3,153,2)
 ;;=^5008010
 ;;^UTILITY(U,$J,358.3,154,0)
 ;;=I83.225^^1^1^153
 ;;^UTILITY(U,$J,358.3,154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,154,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Foot Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,154,1,4,0)
 ;;=4^I83.225
 ;;^UTILITY(U,$J,358.3,154,2)
 ;;=^5008008
 ;;^UTILITY(U,$J,358.3,155,0)
 ;;=I83.228^^1^1^154
 ;;^UTILITY(U,$J,358.3,155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,155,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Ulcer/Inflammation NEC
 ;;^UTILITY(U,$J,358.3,155,1,4,0)
 ;;=4^I83.228
 ;;^UTILITY(U,$J,358.3,155,2)
 ;;=^5008009
 ;;^UTILITY(U,$J,358.3,156,0)
 ;;=I83.222^^1^1^155
 ;;^UTILITY(U,$J,358.3,156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,156,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Calf Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,156,1,4,0)
 ;;=4^I83.222
 ;;^UTILITY(U,$J,358.3,156,2)
 ;;=^5008005
 ;;^UTILITY(U,$J,358.3,157,0)
 ;;=I83.12^^1^1^156
 ;;^UTILITY(U,$J,358.3,157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,157,1,3,0)
 ;;=3^Varicose Veins of Left Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,157,1,4,0)
 ;;=4^I83.12
 ;;^UTILITY(U,$J,358.3,157,2)
 ;;=^5007989
 ;;^UTILITY(U,$J,358.3,158,0)
 ;;=I83.214^^1^1^157
 ;;^UTILITY(U,$J,358.3,158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,158,1,3,0)
 ;;=3^Varicosse Veins of Right Lower Extrem w/ Heel/Midfoot Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,158,1,4,0)
 ;;=4^I83.214
 ;;^UTILITY(U,$J,358.3,158,2)
 ;;=^5008000
 ;;^UTILITY(U,$J,358.3,159,0)
 ;;=I83.215^^1^1^158
 ;;^UTILITY(U,$J,358.3,159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,159,1,3,0)
 ;;=3^Varicosse Veins of Right Lower Extrem w/ Foot Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,159,1,4,0)
 ;;=4^I83.215
 ;;^UTILITY(U,$J,358.3,159,2)
 ;;=^5008001
 ;;^UTILITY(U,$J,358.3,160,0)
 ;;=I83.218^^1^1^159
 ;;^UTILITY(U,$J,358.3,160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,160,1,3,0)
 ;;=3^Varicosse Veins of Right Lower Extrem w/ Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,160,1,4,0)
 ;;=4^I83.218
 ;;^UTILITY(U,$J,358.3,160,2)
 ;;=^5008002
 ;;^UTILITY(U,$J,358.3,161,0)
 ;;=I83.219^^1^1^160
 ;;^UTILITY(U,$J,358.3,161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,161,1,3,0)
 ;;=3^Varicosse Veins of Right Lower Extrem w/ Ulcer/Inflammation,Unspec Site
 ;;^UTILITY(U,$J,358.3,161,1,4,0)
 ;;=4^I83.219
 ;;^UTILITY(U,$J,358.3,161,2)
 ;;=^5008003
 ;;^UTILITY(U,$J,358.3,162,0)
 ;;=I83.211^^1^1^161
 ;;^UTILITY(U,$J,358.3,162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,162,1,3,0)
 ;;=3^Varicosse Veins of Right Lower Extrem w/ Thigh Ulcer/Inflammation
 ;;^UTILITY(U,$J,358.3,162,1,4,0)
 ;;=4^I83.211
 ;;^UTILITY(U,$J,358.3,162,2)
 ;;=^5007997
 ;;^UTILITY(U,$J,358.3,163,0)
 ;;=I83.11^^1^1^162
 ;;^UTILITY(U,$J,358.3,163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,163,1,3,0)
 ;;=3^Varicosse Veins of Right Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,163,1,4,0)
 ;;=4^I83.11
 ;;^UTILITY(U,$J,358.3,163,2)
 ;;=^5007988
 ;;^UTILITY(U,$J,358.3,164,0)
 ;;=I83.019^^1^1^163
 ;;^UTILITY(U,$J,358.3,164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,164,1,3,0)
 ;;=3^Varicosse Veins of Right Lower Extrem w/ Ulcer
 ;;^UTILITY(U,$J,358.3,164,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,164,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,165,0)
 ;;=K55.9^^1^1^165
 ;;^UTILITY(U,$J,358.3,165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,165,1,3,0)
 ;;=3^Vascular Intestinal Disorders,Unspec
 ;;^UTILITY(U,$J,358.3,165,1,4,0)
 ;;=4^K55.9
 ;;^UTILITY(U,$J,358.3,165,2)
 ;;=^5008710
 ;;^UTILITY(U,$J,358.3,166,0)
 ;;=I87.2^^1^1^166
 ;;^UTILITY(U,$J,358.3,166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,166,1,3,0)
 ;;=3^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,166,1,4,0)
 ;;=4^I87.2
 ;;^UTILITY(U,$J,358.3,166,2)
 ;;=^5008047
 ;;^UTILITY(U,$J,358.3,167,0)
 ;;=R10.9^^1^2^2
 ;;^UTILITY(U,$J,358.3,167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,167,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,167,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,167,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,168,0)
 ;;=R10.11^^1^2^9
 ;;^UTILITY(U,$J,358.3,168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,168,1,3,0)
 ;;=3^Right Upper Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,168,1,4,0)
 ;;=4^R10.11
 ;;^UTILITY(U,$J,358.3,168,2)
 ;;=^5019206
 ;;^UTILITY(U,$J,358.3,169,0)
 ;;=R10.12^^1^2^5
 ;;^UTILITY(U,$J,358.3,169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,169,1,3,0)
 ;;=3^Left Upper Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,169,1,4,0)
 ;;=4^R10.12
 ;;^UTILITY(U,$J,358.3,169,2)
 ;;=^5019207
 ;;^UTILITY(U,$J,358.3,170,0)
 ;;=R10.31^^1^2^8
 ;;^UTILITY(U,$J,358.3,170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,170,1,3,0)
 ;;=3^Right Lower Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,170,1,4,0)
 ;;=4^R10.31
 ;;^UTILITY(U,$J,358.3,170,2)
 ;;=^5019211
 ;;^UTILITY(U,$J,358.3,171,0)
 ;;=R10.32^^1^2^4
 ;;^UTILITY(U,$J,358.3,171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,171,1,3,0)
 ;;=3^Left Lower Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,171,1,4,0)
 ;;=4^R10.32
 ;;^UTILITY(U,$J,358.3,171,2)
 ;;=^5019212
 ;;^UTILITY(U,$J,358.3,172,0)
 ;;=R10.33^^1^2^7
 ;;^UTILITY(U,$J,358.3,172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,172,1,3,0)
 ;;=3^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,172,1,4,0)
 ;;=4^R10.33
 ;;^UTILITY(U,$J,358.3,172,2)
 ;;=^5019213
 ;;^UTILITY(U,$J,358.3,173,0)
 ;;=R10.13^^1^2^3
 ;;^UTILITY(U,$J,358.3,173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,173,1,3,0)
 ;;=3^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,173,1,4,0)
 ;;=4^R10.13
 ;;^UTILITY(U,$J,358.3,173,2)
 ;;=^5019208
 ;;^UTILITY(U,$J,358.3,174,0)
 ;;=R10.84^^1^2^1
 ;;^UTILITY(U,$J,358.3,174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,174,1,3,0)
 ;;=3^Abdominal Pain,Generalized
 ;;^UTILITY(U,$J,358.3,174,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,174,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,175,0)
 ;;=R10.2^^1^2^6
 ;;^UTILITY(U,$J,358.3,175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,175,1,3,0)
 ;;=3^Pelvic/Perineal Pain
 ;;^UTILITY(U,$J,358.3,175,1,4,0)
 ;;=4^R10.2
 ;;^UTILITY(U,$J,358.3,175,2)
 ;;=^5019209
 ;;^UTILITY(U,$J,358.3,176,0)
 ;;=Z48.01^^1^3^1
 ;;^UTILITY(U,$J,358.3,176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,176,1,3,0)
 ;;=3^Change/Removal of Surgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,176,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,176,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,177,0)
 ;;=Z48.02^^1^3^3
 ;;^UTILITY(U,$J,358.3,177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,177,1,3,0)
 ;;=3^Removal of Sutures
 ;;^UTILITY(U,$J,358.3,177,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,177,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,178,0)
 ;;=Z48.812^^1^3^4
 ;;^UTILITY(U,$J,358.3,178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,178,1,3,0)
 ;;=3^Surgical Aftercare Following Surgery on Circulatory System
 ;;^UTILITY(U,$J,358.3,178,1,4,0)
 ;;=4^Z48.812
 ;;^UTILITY(U,$J,358.3,178,2)
 ;;=^5063049
 ;;^UTILITY(U,$J,358.3,179,0)
 ;;=Z09.^^1^3^2
 ;;^UTILITY(U,$J,358.3,179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,179,1,3,0)
 ;;=3^F/U Exam After Treatment for Condition Other Than Malig Neop
 ;;^UTILITY(U,$J,358.3,179,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,179,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,180,0)
 ;;=I25.10^^1^4^5
 ;;^UTILITY(U,$J,358.3,180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,180,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/o Ang Pctrs
