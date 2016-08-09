IBDEI0S0 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28160,2)
 ;;=^5001928
 ;;^UTILITY(U,$J,358.3,28161,0)
 ;;=D05.11^^105^1371^8
 ;;^UTILITY(U,$J,358.3,28161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28161,1,3,0)
 ;;=3^Intraductal carcinoma in situ of right breast
 ;;^UTILITY(U,$J,358.3,28161,1,4,0)
 ;;=4^D05.11
 ;;^UTILITY(U,$J,358.3,28161,2)
 ;;=^5001930
 ;;^UTILITY(U,$J,358.3,28162,0)
 ;;=D05.12^^105^1371^7
 ;;^UTILITY(U,$J,358.3,28162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28162,1,3,0)
 ;;=3^Intraductal carcinoma in situ of left breast
 ;;^UTILITY(U,$J,358.3,28162,1,4,0)
 ;;=4^D05.12
 ;;^UTILITY(U,$J,358.3,28162,2)
 ;;=^5001931
 ;;^UTILITY(U,$J,358.3,28163,0)
 ;;=D06.9^^105^1371^3
 ;;^UTILITY(U,$J,358.3,28163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28163,1,3,0)
 ;;=3^Carcinoma in situ of cervix, unspecified
 ;;^UTILITY(U,$J,358.3,28163,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,28163,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,28164,0)
 ;;=D06.0^^105^1371^4
 ;;^UTILITY(U,$J,358.3,28164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28164,1,3,0)
 ;;=3^Carcinoma in situ of endocervix
 ;;^UTILITY(U,$J,358.3,28164,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,28164,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,28165,0)
 ;;=D06.1^^105^1371^5
 ;;^UTILITY(U,$J,358.3,28165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28165,1,3,0)
 ;;=3^Carcinoma in situ of exocervix
 ;;^UTILITY(U,$J,358.3,28165,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,28165,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,28166,0)
 ;;=D06.7^^105^1371^6
 ;;^UTILITY(U,$J,358.3,28166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28166,1,3,0)
 ;;=3^Carcinoma in situ of other parts of cervix
 ;;^UTILITY(U,$J,358.3,28166,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,28166,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,28167,0)
 ;;=D66.^^105^1372^16
 ;;^UTILITY(U,$J,358.3,28167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28167,1,3,0)
 ;;=3^Hereditary factor VIII deficiency
 ;;^UTILITY(U,$J,358.3,28167,1,4,0)
 ;;=4^D66.
 ;;^UTILITY(U,$J,358.3,28167,2)
 ;;=^5002353
 ;;^UTILITY(U,$J,358.3,28168,0)
 ;;=D67.^^105^1372^15
 ;;^UTILITY(U,$J,358.3,28168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28168,1,3,0)
 ;;=3^Hereditary factor IX deficiency
 ;;^UTILITY(U,$J,358.3,28168,1,4,0)
 ;;=4^D67.
 ;;^UTILITY(U,$J,358.3,28168,2)
 ;;=^5002354
 ;;^UTILITY(U,$J,358.3,28169,0)
 ;;=D68.1^^105^1372^17
 ;;^UTILITY(U,$J,358.3,28169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28169,1,3,0)
 ;;=3^Hereditary factor XI deficiency
 ;;^UTILITY(U,$J,358.3,28169,1,4,0)
 ;;=4^D68.1
 ;;^UTILITY(U,$J,358.3,28169,2)
 ;;=^5002355
 ;;^UTILITY(U,$J,358.3,28170,0)
 ;;=D68.2^^105^1372^14
 ;;^UTILITY(U,$J,358.3,28170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28170,1,3,0)
 ;;=3^Hereditary deficiency of other clotting factors
 ;;^UTILITY(U,$J,358.3,28170,1,4,0)
 ;;=4^D68.2
 ;;^UTILITY(U,$J,358.3,28170,2)
 ;;=^5002356
 ;;^UTILITY(U,$J,358.3,28171,0)
 ;;=D68.0^^105^1372^26
 ;;^UTILITY(U,$J,358.3,28171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28171,1,3,0)
 ;;=3^Von Willebrand's disease
 ;;^UTILITY(U,$J,358.3,28171,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,28171,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,28172,0)
 ;;=D68.311^^105^1372^2
 ;;^UTILITY(U,$J,358.3,28172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28172,1,3,0)
 ;;=3^Acquired hemophilia
 ;;^UTILITY(U,$J,358.3,28172,1,4,0)
 ;;=4^D68.311
 ;;^UTILITY(U,$J,358.3,28172,2)
 ;;=^340502
 ;;^UTILITY(U,$J,358.3,28173,0)
 ;;=D68.312^^105^1372^4
 ;;^UTILITY(U,$J,358.3,28173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28173,1,3,0)
 ;;=3^Antiphospholipid antibody with hemorrhagic disorder
 ;;^UTILITY(U,$J,358.3,28173,1,4,0)
 ;;=4^D68.312
 ;;^UTILITY(U,$J,358.3,28173,2)
 ;;=^340503
 ;;^UTILITY(U,$J,358.3,28174,0)
 ;;=D68.318^^105^1372^13
 ;;^UTILITY(U,$J,358.3,28174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28174,1,3,0)
 ;;=3^Hemorrhagic disord d/t intrns circ anticoag,antib,inhib NEC
 ;;^UTILITY(U,$J,358.3,28174,1,4,0)
 ;;=4^D68.318
 ;;^UTILITY(U,$J,358.3,28174,2)
 ;;=^340504
 ;;^UTILITY(U,$J,358.3,28175,0)
 ;;=D65.^^105^1372^7
 ;;^UTILITY(U,$J,358.3,28175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28175,1,3,0)
 ;;=3^Disseminated intravascular coagulation
 ;;^UTILITY(U,$J,358.3,28175,1,4,0)
 ;;=4^D65.
 ;;^UTILITY(U,$J,358.3,28175,2)
 ;;=^5002352
 ;;^UTILITY(U,$J,358.3,28176,0)
 ;;=D68.32^^105^1372^12
 ;;^UTILITY(U,$J,358.3,28176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28176,1,3,0)
 ;;=3^Hemorrhagic disord d/t extrinsic circulating anticoagulants
 ;;^UTILITY(U,$J,358.3,28176,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,28176,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,28177,0)
 ;;=D68.4^^105^1372^1
 ;;^UTILITY(U,$J,358.3,28177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28177,1,3,0)
 ;;=3^Acquired coagulation factor deficiency
 ;;^UTILITY(U,$J,358.3,28177,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,28177,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,28178,0)
 ;;=D68.8^^105^1372^5
 ;;^UTILITY(U,$J,358.3,28178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28178,1,3,0)
 ;;=3^Coagulation Defects NEC
 ;;^UTILITY(U,$J,358.3,28178,1,4,0)
 ;;=4^D68.8
 ;;^UTILITY(U,$J,358.3,28178,2)
 ;;=^5002363
 ;;^UTILITY(U,$J,358.3,28179,0)
 ;;=D68.9^^105^1372^6
 ;;^UTILITY(U,$J,358.3,28179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28179,1,3,0)
 ;;=3^Coagulation Defects,Unspec
 ;;^UTILITY(U,$J,358.3,28179,1,4,0)
 ;;=4^D68.9
 ;;^UTILITY(U,$J,358.3,28179,2)
 ;;=^5002364
 ;;^UTILITY(U,$J,358.3,28180,0)
 ;;=D69.1^^105^1372^22
 ;;^UTILITY(U,$J,358.3,28180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28180,1,3,0)
 ;;=3^Qualitative platelet defects
 ;;^UTILITY(U,$J,358.3,28180,1,4,0)
 ;;=4^D69.1
 ;;^UTILITY(U,$J,358.3,28180,2)
 ;;=^101922
 ;;^UTILITY(U,$J,358.3,28181,0)
 ;;=D47.3^^105^1372^8
 ;;^UTILITY(U,$J,358.3,28181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28181,1,3,0)
 ;;=3^Essential (hemorrhagic) thrombocythemia
 ;;^UTILITY(U,$J,358.3,28181,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,28181,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,28182,0)
 ;;=D69.0^^105^1372^3
 ;;^UTILITY(U,$J,358.3,28182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28182,1,3,0)
 ;;=3^Allergic purpura
 ;;^UTILITY(U,$J,358.3,28182,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,28182,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,28183,0)
 ;;=D69.2^^105^1372^19
 ;;^UTILITY(U,$J,358.3,28183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28183,1,3,0)
 ;;=3^Nonthrombocytopenic purpura NEC
 ;;^UTILITY(U,$J,358.3,28183,1,4,0)
 ;;=4^D69.2
 ;;^UTILITY(U,$J,358.3,28183,2)
 ;;=^5002366
 ;;^UTILITY(U,$J,358.3,28184,0)
 ;;=D69.3^^105^1372^18
 ;;^UTILITY(U,$J,358.3,28184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28184,1,3,0)
 ;;=3^Immune thrombocytopenic purpura
 ;;^UTILITY(U,$J,358.3,28184,1,4,0)
 ;;=4^D69.3
 ;;^UTILITY(U,$J,358.3,28184,2)
 ;;=^332746
 ;;^UTILITY(U,$J,358.3,28185,0)
 ;;=D69.41^^105^1372^9
 ;;^UTILITY(U,$J,358.3,28185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28185,1,3,0)
 ;;=3^Evans syndrome
 ;;^UTILITY(U,$J,358.3,28185,1,4,0)
 ;;=4^D69.41
 ;;^UTILITY(U,$J,358.3,28185,2)
 ;;=^332747
 ;;^UTILITY(U,$J,358.3,28186,0)
 ;;=D69.51^^105^1372^21
 ;;^UTILITY(U,$J,358.3,28186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28186,1,3,0)
 ;;=3^Posttransfusion purpura
 ;;^UTILITY(U,$J,358.3,28186,1,4,0)
 ;;=4^D69.51
 ;;^UTILITY(U,$J,358.3,28186,2)
 ;;=^5002368
 ;;^UTILITY(U,$J,358.3,28187,0)
 ;;=D69.59^^105^1372^23
 ;;^UTILITY(U,$J,358.3,28187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28187,1,3,0)
 ;;=3^Secondary thrombocytopenia NEC
 ;;^UTILITY(U,$J,358.3,28187,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,28187,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,28188,0)
 ;;=D69.8^^105^1372^10
 ;;^UTILITY(U,$J,358.3,28188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28188,1,3,0)
 ;;=3^Hemorrhagic Conditions NEC
 ;;^UTILITY(U,$J,358.3,28188,1,4,0)
 ;;=4^D69.8
