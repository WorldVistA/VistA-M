IBDEI0KL ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10056,1,3,0)
 ;;=3^Anoscopy HRA w/ Biopsy
 ;;^UTILITY(U,$J,358.3,10057,0)
 ;;=46601^^59^653^3^^^^1
 ;;^UTILITY(U,$J,358.3,10057,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10057,1,2,0)
 ;;=2^46601
 ;;^UTILITY(U,$J,358.3,10057,1,3,0)
 ;;=3^Anoscopy HRA w/ Specimen Collection
 ;;^UTILITY(U,$J,358.3,10058,0)
 ;;=45346^^59^653^13^^^^1
 ;;^UTILITY(U,$J,358.3,10058,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10058,1,2,0)
 ;;=2^45346
 ;;^UTILITY(U,$J,358.3,10058,1,3,0)
 ;;=3^Flex Sig w/Ablation of Tumor
 ;;^UTILITY(U,$J,358.3,10059,0)
 ;;=45378^^59^654^13^^^^1
 ;;^UTILITY(U,$J,358.3,10059,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10059,1,2,0)
 ;;=2^45378
 ;;^UTILITY(U,$J,358.3,10059,1,3,0)
 ;;=3^Colonoscopy, Diagnostic
 ;;^UTILITY(U,$J,358.3,10060,0)
 ;;=45380^^59^654^5^^^^1
 ;;^UTILITY(U,$J,358.3,10060,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10060,1,2,0)
 ;;=2^45380
 ;;^UTILITY(U,$J,358.3,10060,1,3,0)
 ;;=3^Colonoscopy w/Biopsy
 ;;^UTILITY(U,$J,358.3,10061,0)
 ;;=45384^^59^654^11^^^^1
 ;;^UTILITY(U,$J,358.3,10061,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10061,1,2,0)
 ;;=2^45384
 ;;^UTILITY(U,$J,358.3,10061,1,3,0)
 ;;=3^Colonoscopy w/Tumor Removal by hot forceps
 ;;^UTILITY(U,$J,358.3,10062,0)
 ;;=45385^^59^654^12^^^^1
 ;;^UTILITY(U,$J,358.3,10062,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10062,1,2,0)
 ;;=2^45385
 ;;^UTILITY(U,$J,358.3,10062,1,3,0)
 ;;=3^Colonoscopy w/Tumor removal by snare
 ;;^UTILITY(U,$J,358.3,10063,0)
 ;;=45379^^59^654^8^^^^1
 ;;^UTILITY(U,$J,358.3,10063,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10063,1,2,0)
 ;;=2^45379
 ;;^UTILITY(U,$J,358.3,10063,1,3,0)
 ;;=3^Colonoscopy w/FB Removal
 ;;^UTILITY(U,$J,358.3,10064,0)
 ;;=45382^^59^654^6^^^^1
 ;;^UTILITY(U,$J,358.3,10064,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10064,1,2,0)
 ;;=2^45382
 ;;^UTILITY(U,$J,358.3,10064,1,3,0)
 ;;=3^Colonoscopy w/Control hemorrhage
 ;;^UTILITY(U,$J,358.3,10065,0)
 ;;=45386^^59^654^3^^^^1
 ;;^UTILITY(U,$J,358.3,10065,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10065,1,2,0)
 ;;=2^45386
 ;;^UTILITY(U,$J,358.3,10065,1,3,0)
 ;;=3^Colonoscopy w/Balloon Dilation Stricture
 ;;^UTILITY(U,$J,358.3,10066,0)
 ;;=45391^^59^654^7^^^^1
 ;;^UTILITY(U,$J,358.3,10066,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10066,1,2,0)
 ;;=2^45391
 ;;^UTILITY(U,$J,358.3,10066,1,3,0)
 ;;=3^Colonoscopy w/EUS
 ;;^UTILITY(U,$J,358.3,10067,0)
 ;;=45392^^59^654^1^^^^1
 ;;^UTILITY(U,$J,358.3,10067,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10067,1,2,0)
 ;;=2^45392
 ;;^UTILITY(U,$J,358.3,10067,1,3,0)
 ;;=3^Colonos w/Intramural/transmural FNA/BX
 ;;^UTILITY(U,$J,358.3,10068,0)
 ;;=45381^^59^654^14^^^^1
 ;;^UTILITY(U,$J,358.3,10068,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10068,1,2,0)
 ;;=2^45381
 ;;^UTILITY(U,$J,358.3,10068,1,3,0)
 ;;=3^Colonoscopy,Submucosal Inj
 ;;^UTILITY(U,$J,358.3,10069,0)
 ;;=45389^^59^654^10^^^^1
 ;;^UTILITY(U,$J,358.3,10069,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10069,1,2,0)
 ;;=2^45389
 ;;^UTILITY(U,$J,358.3,10069,1,3,0)
 ;;=3^Colonoscopy w/Stent Placement
 ;;^UTILITY(U,$J,358.3,10070,0)
 ;;=45355^^59^654^2^^^^1
 ;;^UTILITY(U,$J,358.3,10070,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10070,1,2,0)
 ;;=2^45355
 ;;^UTILITY(U,$J,358.3,10070,1,3,0)
 ;;=3^Colonoscopy Transabdominal,Single/Multi
 ;;^UTILITY(U,$J,358.3,10071,0)
 ;;=45390^^59^654^9^^^^1
 ;;^UTILITY(U,$J,358.3,10071,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10071,1,2,0)
 ;;=2^45390
 ;;^UTILITY(U,$J,358.3,10071,1,3,0)
 ;;=3^Colonoscopy w/Resection
 ;;^UTILITY(U,$J,358.3,10072,0)
 ;;=45398^^59^654^4^^^^1
