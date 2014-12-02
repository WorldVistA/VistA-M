IBDEI0MX ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11262,1,2,0)
 ;;=2^46608
 ;;^UTILITY(U,$J,358.3,11262,1,3,0)
 ;;=3^Anoscopy w/Removal FB
 ;;^UTILITY(U,$J,358.3,11263,0)
 ;;=46610^^72^732^7^^^^1
 ;;^UTILITY(U,$J,358.3,11263,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11263,1,2,0)
 ;;=2^46610
 ;;^UTILITY(U,$J,358.3,11263,1,3,0)
 ;;=3^Anoscopy w/Rem of Tumor,Biopsy Forceps
 ;;^UTILITY(U,$J,358.3,11264,0)
 ;;=46611^^72^732^8^^^^1
 ;;^UTILITY(U,$J,358.3,11264,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11264,1,2,0)
 ;;=2^46611
 ;;^UTILITY(U,$J,358.3,11264,1,3,0)
 ;;=3^Anoscopy w/Rem of Tumor,Snare
 ;;^UTILITY(U,$J,358.3,11265,0)
 ;;=46612^^72^732^10^^^^1
 ;;^UTILITY(U,$J,358.3,11265,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11265,1,2,0)
 ;;=2^46612
 ;;^UTILITY(U,$J,358.3,11265,1,3,0)
 ;;=3^Anoscopy w/Removal of Mult Tumors
 ;;^UTILITY(U,$J,358.3,11266,0)
 ;;=46614^^72^732^6^^^^1
 ;;^UTILITY(U,$J,358.3,11266,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11266,1,2,0)
 ;;=2^46614
 ;;^UTILITY(U,$J,358.3,11266,1,3,0)
 ;;=3^Anoscopy w/Control of Bleeding
 ;;^UTILITY(U,$J,358.3,11267,0)
 ;;=45378^^72^733^12^^^^1
 ;;^UTILITY(U,$J,358.3,11267,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11267,1,2,0)
 ;;=2^45378
 ;;^UTILITY(U,$J,358.3,11267,1,3,0)
 ;;=3^Colonoscopy, Diagnostic
 ;;^UTILITY(U,$J,358.3,11268,0)
 ;;=45380^^72^733^6^^^^1
 ;;^UTILITY(U,$J,358.3,11268,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11268,1,2,0)
 ;;=2^45380
 ;;^UTILITY(U,$J,358.3,11268,1,3,0)
 ;;=3^Colonoscopy w/Biopsy
 ;;^UTILITY(U,$J,358.3,11269,0)
 ;;=45384^^72^733^10^^^^1
 ;;^UTILITY(U,$J,358.3,11269,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11269,1,2,0)
 ;;=2^45384
 ;;^UTILITY(U,$J,358.3,11269,1,3,0)
 ;;=3^Colonoscopy w/Tumor Removal by hot forceps
 ;;^UTILITY(U,$J,358.3,11270,0)
 ;;=45385^^72^733^11^^^^1
 ;;^UTILITY(U,$J,358.3,11270,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11270,1,2,0)
 ;;=2^45385
 ;;^UTILITY(U,$J,358.3,11270,1,3,0)
 ;;=3^Colonoscopy w/Tumor removal by snare
 ;;^UTILITY(U,$J,358.3,11271,0)
 ;;=45379^^72^733^9^^^^1
 ;;^UTILITY(U,$J,358.3,11271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11271,1,2,0)
 ;;=2^45379
 ;;^UTILITY(U,$J,358.3,11271,1,3,0)
 ;;=3^Colonoscopy w/FB Removal
 ;;^UTILITY(U,$J,358.3,11272,0)
 ;;=45383^^72^733^4^^^^1
 ;;^UTILITY(U,$J,358.3,11272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11272,1,2,0)
 ;;=2^45383
 ;;^UTILITY(U,$J,358.3,11272,1,3,0)
 ;;=3^Colonoscopy w/Ablation of tumor
 ;;^UTILITY(U,$J,358.3,11273,0)
 ;;=45382^^72^733^7^^^^1
 ;;^UTILITY(U,$J,358.3,11273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11273,1,2,0)
 ;;=2^45382
 ;;^UTILITY(U,$J,358.3,11273,1,3,0)
 ;;=3^Colonoscopy w/Control hemorrhage
 ;;^UTILITY(U,$J,358.3,11274,0)
 ;;=45386^^72^733^5^^^^1
 ;;^UTILITY(U,$J,358.3,11274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11274,1,2,0)
 ;;=2^45386
 ;;^UTILITY(U,$J,358.3,11274,1,3,0)
 ;;=3^Colonoscopy w/Balloon Dilation Stricture
 ;;^UTILITY(U,$J,358.3,11275,0)
 ;;=45387^^72^733^2^^^^1
 ;;^UTILITY(U,$J,358.3,11275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11275,1,2,0)
 ;;=2^45387
 ;;^UTILITY(U,$J,358.3,11275,1,3,0)
 ;;=3^Colonos w/Stent Placement inc dilation
 ;;^UTILITY(U,$J,358.3,11276,0)
 ;;=45391^^72^733^8^^^^1
 ;;^UTILITY(U,$J,358.3,11276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11276,1,2,0)
 ;;=2^45391
 ;;^UTILITY(U,$J,358.3,11276,1,3,0)
 ;;=3^Colonoscopy w/EUS
 ;;^UTILITY(U,$J,358.3,11277,0)
 ;;=45392^^72^733^1^^^^1
 ;;^UTILITY(U,$J,358.3,11277,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11277,1,2,0)
 ;;=2^45392
 ;;^UTILITY(U,$J,358.3,11277,1,3,0)
 ;;=3^Colonos w/Intramural/transmural FNA/BX
