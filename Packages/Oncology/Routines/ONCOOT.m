ONCOOT ;HIRMFO/GWB - Miscellaneous Output Transforms ;7/10/96
 ;;2.11;ONCOLOGY;**6,11,15,18,22,24,25,27,29,34,35,36,37,39,40,42,46**;Mar 07, 1995;Build 39
 ;
RNE ;REGIONAL LYMPH NODES EXAMINED (165.5,33)
 S DXDT=$P($G(^ONCO(165.5,D0,0)),U,16)
 I DXDT<2980000 D
 .I Y=0 S Y="No nodes were examined" Q
 .I (+Y>0)&(+Y<97) S:$L(Y)=1 Y=0_Y Q
 .I Y=97 S Y="97 or more nodes examined" Q
 .I Y=98 S Y="Nodes examined, # not specified" Q
 .I Y=99 S Y="Unknown if nodes examined, NA" Q
 I DXDT>2971231 D
 .I Y=0 S Y="No nodes examined" Q
 .I (+Y>0)&(+Y<90) S:$L(Y)=1 Y=0_Y Q
 .I Y=90 S Y="90 or more nodes examined" Q
 .I Y=95 S Y="No nodes removed, aspiration performed" Q
 .I Y=96 S Y="Node removal as sampling, # unknown" Q
 .I Y=97 S Y="Node removal as dissection, # unknown" Q
 .I Y=98 S Y="Nodes surgically removed, # unknown" Q
 .I Y=99 S Y="Unknown, NA or -, not stated" Q
 Q
 ;
RNP ;REGIONAL LYMPH NODES POSITIVE (165.5,32)
 I Y=0 S Y="All nodes examined are negative" Q
 I (+Y>0)&(+Y<90) S:$L(Y)=1 Y=0_Y Q
 I Y=90 S Y="90 or more nodes are positive" Q
 I Y=95 S Y="95 Positive aspiration was performed" Q
 I Y=97 S Y="Positive nodes, # not specified" Q
 I Y=98 S Y="No nodes were examined" Q
 I Y=99 S Y="Unknown if nodes +, NA, not stated" Q
 Q
 ;
BP ;BIOPSY PROCEDURE (165.5,141)
 Q:Y=""
 D BPGUCHK^ONCOTNE
 I BPSITE="" Q
 S Y=$S($P($G(^ONCO(164,BPSITE,"BP5",Y,0)),U,1)'="":$P($G(^ONCO(164,BPSITE,"BP5",Y,0)),U,1),1:Y)
 Q
 ;
 ;1998 Prostate Cancer Study 
 ;
PSA ;PSA (165.5,684)
 I Y=999.6 S Y=Y_" or higher"
 I Y=999.7 S Y="No PSA test performed"
 I Y=999.8 S Y="Done, results unknown or not reported"
 I Y=999.9 S Y="Unknown if test performed"
 Q
 ;
DCISIT ;DCIS PRESENT (165.5,930) INPUT TRANSFORM
 I X'?1N K X Q
 I X=5!(X=6)!(X=7) K X Q
 I X=0 D EN^DDIOL("  No, DCIS not present")
 I X=1 D EN^DDIOL("  Yes, separate tumor")
 I X=2 D EN^DDIOL("  Yes, mixed histology component")
 I X=3 D EN^DDIOL("  Yes, separate tumor and mixed histology")
 I X=4 D EN^DDIOL("  Yes, unk if separate tumor/mixed histology")
 I X=8 D EN^DDIOL("  NA, reported tumor not invasive DC")
 I X=9 D EN^DDIOL("  Unknown if DCIS present")
 Q
DCISOT ;DCIS PRESENT (165.5,930) OUTPUT TRANSFORM
 I Y=0 S Y="No, DCIS not present"
 I Y=1 S Y="Yes, separate tumor"
 I Y=2 S Y="Yes, mixed histology component"
 I Y=3 S Y="Yes, separate tumor and mixed histology"
 I Y=4 S Y="Yes, unk if separate tumor/mixed histology"
 I Y=8 S Y="NA, reported tumor not invasive DC"
 I Y=9 S Y="Unknown if DCIS present"
 Q
DCISHP ;DCIS PRESENT (165.5,930) HELP
 W !!?6,"Choose from:"
 W !?8,"0     No, DCIS not present"
 W !?8,"1     Yes, separate tumor"
 W !?8,"2     Yes, mixed histology component"
 W !?8,"3     Yes, separate tumor and mixed histology"
 W !?8,"4     Yes, unk if separate tumor/mixed histology"
 W !?8,"8     NA, reported tumor not invasive DC"
 W !?8,"9     Unknown if DCIS present"
 Q
DCSZIT ;
 I +X=0 D EN^DDIOL("  Invasive DC reported, DCIS not present")
 I X="888" D EN^DDIOL("  NA, invasive DC not reported")
 I X="988" D EN^DDIOL("  Invasive DC reported, DCIS present, size unknown")
 I X="999" D EN^DDIOL("  Invasive DC reported, unknown if DCIS present")
 Q
DCSZOT ;
 S Y=$S($L(Y)=1:"00"_Y,$L(Y)=2:"0"_Y,1:Y)
 I Y="000" S Y="Invasive DC reported, DCIS not present"
 I Y="888" S Y="NA, invasive DC not reported"
 I Y="988" S Y="Invasive DC reported, DCIS present, size unknown"
 I Y="999" S Y="Invasive DC reported, unknown if DCIS present"
 Q
CGYIT ;
 I +X=0 D EN^DDIOL("  No radiation given")
 I X=88888 D EN^DDIOL("  Radiation given, dose unknown")
 I X=99999 D EN^DDIOL("  Unknown if radiation given")
 Q
CGYOT ;
 S Y=$S($L(Y)=1:"0000"_Y,$L(Y)=2:"000"_Y,$L(Y)=3:"00"_Y,$L(Y)=4:"0"_Y,1:Y)
 I Y="00000" S Y="No radiation given"
 I Y=88888 S Y="Radiation given, dose unknown"
 I Y=99999 S Y="Unknown if radiation given"
 Q
STIT ;Tumor Size (165.5,29)
 S TOP=$P($G(^ONCO(165.5,D0,2)),U,1)
 I '$D(X) Q
 I (X>999)!(X<0) K X Q
 I X="000" W "  No mass or tumor found" Q
 I X=990 W "  Microscopic focus, no size given" Q
 I X=999 W "  Unknown; not stated; NA" Q
 I $$MELANOMA^ONCOU55(D0),TOP'=67691,TOP'=67692,TOP'=67693,TOP'=67694,TOP'=67698,TOP'=67699 D  Q
 .I X=989 W "  Melanoma > or = 9.89 mm in depth" Q
 .I X>9.89 W "  Use code 989 for melanomas > 9.89 mm in depth" K X Q
 .I X?1N S X=X_"00" Q                               ;    1 -> 100
 .I X?1P1N S X="0"_$P(X,".",2)_"0" Q                ;   .1 -> 010
 .I X?1P2N S X="0"_$P(X,".",2) Q                    ;  .01 -> 001
 .I X?1N1P1N S X=$P(X,".",1)_$P(X,".",2)_0 Q        ;  0.1 -> 010
 .I X?1N1P2N S X=$P(X,".",1)_$P(X,".",2) Q          ; 0.01 -> 001
 .I X?1N1P3N W "  Too many decimal places" K X Q    ;0.012
 .K X
 I X=989 W "  989 mm or larger" Q
 I X["." W "  No decimal point allowed" K X Q
 I X=998 D  Q
 .I TOP="" W "  No PRIMARY SITE specified" K X Q
 .I TOP>67149,TOP<67160 W "  Entire circumference" Q
 .I TOP>67159,TOP<67170 W "  Diffuse; widespread; linitis plastica" Q
 .I TOP>67179,TOP<67210 W "  Familial/multiple polyposis" Q
 .I TOP>67339,TOP<67350 W "  Diffuse, entire lobe of lung" Q
 .I TOP>67499,TOP<67510 W "  Diffuse; widespread; inflam carcinoma" Q
 .W !
 .W !," Code 998 may only be used with the following sites:"
 .W !
 .W !,"  Esophagus (C15.0-C15.9)"
 .W !,"  Stomach (C16.0-C16.9)"
 .W !,"  Colorectal (C18.0-C20.9)"
 .W !,"  Lung (C34.0-C34.9)"
 .W !,"  Breast (C50.0-C50.9)"
 .W !
 .K X
 S X=$S($L(X)=1:"00"_X,$L(X)=2:"0"_X,1:X)
 I X'?3N K X Q
 I (X=991)!(X=992)!(X=993)!(X=994)!(X=995)!(X=996)!(X=997) K X
 Q
 ;
STOT ;Size of Tumor (165.5,29)
 S TOP=$P($G(^ONCO(165.5,D0,2)),U,1)
 I Y="000" S Y="No mass or tumor found" Q
 I Y=990 S Y="Microscopic focus, no size given" Q
 I Y=999 S Y="Unknown; not stated; NA" Q
 I $$MELANOMA^ONCOU55(D0),TOP'=67691,TOP'=67692,TOP'=67693,TOP'=67694,TOP'=67698,TOP'=67699,Y=989 D  Q
 .S Y="Melanoma > or = 9.89 mm in depth"
 I $$MELANOMA^ONCOU55(D0),TOP'=67691,TOP'=67692,TOP'=67693,TOP'=67694,TOP'=67698,TOP'=67699,Y'="" D
 .S Y=$E(Y,1)_"."_$E(Y,2,3)
 I Y=989 S Y="989 mm or larger" Q
 I Y=998 D  Q
 .I TOP="" S Y="" Q
 .I TOP>67149,TOP<67160 S Y="Entire circumference" Q
 .I TOP>67159,TOP<67170 S Y="Diffuse; widespread; linitis plastica" Q
 .I TOP>67179,TOP<67210 S Y="Familial/multiple polyposis" Q
 .I TOP>67339,TOP<67350 S Y="Diffuse, entire lobe of lung" Q
 .I TOP>67499,TOP<67510 S Y="Diffuse; widespread; inflam carcinoma" Q
 .S:Y'="" Y=Y_" mm"
 S:Y'="" Y=Y_" mm"
 Q
 ;
STMIT ;Size of Tumor (Melanoma) Item #23 1999 Melanoma PCE Study
 I X'?1.3N K X Q
 S X=+X
 I X=998 D EN^DDIOL("  Mucosal melanoma") Q
 I X=999 D EN^DDIOL("  Unknown; not recorded; NA")
 Q
 ;
STMOT ;Size of Tumor (Melanoma) Item #23 1999 Melanoma PCE Study
 I Y=998 S Y="Mucosal melanoma" Q
 I Y=999 S Y="Unknown; not recorded; NA" Q
 S Y=Y_" mm"
 Q
 ;
 ;2000 Primary Intracranial/CNS Tumors PCE Study
TSIT ;Item 33. Tumor Size
 I X'?1.3N K X Q
 S X=+X
 I X=999 D EN^DDIOL("  Unknown, cannot be determined, not recorded")
 Q
TSOT ;Item 33. Tumor Size
 I Y=999 S Y="Unknown, cannot be determined, not recorded" Q
 S Y=Y_" mm"
 Q
SRPTIT ;Item 46. Size of Residual Primary Tumor Following Cancer-Directed
 ;Surgery
 I X'?1.3N K X Q
 S X=+X
 I X=0 D EN^DDIOL("  No residual tumor") Q
 I X=995 D EN^DDIOL("  Size not specified, tumor judged smaller") Q
 I X=996 D EN^DDIOL("  Size not specified, tumor judged unchanged") Q
 I X=997 D EN^DDIOL("  Size not specified, tumor judged larger") Q
 I X=998 D EN^DDIOL("  NA, surgical treatment not administered") Q
 I X=999 D EN^DDIOL("  Unknown, tumor not evaluated")
 Q
SRPTOT ;Item 46. Size of Residual Primary Tumor Following Cancer-Directed
 ;Surgery
 I Y="000" S Y="No residual tumor" Q
 I Y=995 S Y="Size not specified, tumor judged smaller" Q
 I Y=996 S Y="Size not specified, tumor judged unchanged" Q
 I Y=997 S Y="Size not specified, tumor judged larger" Q
 I Y=998 S Y="NA, surgical treatment not administered" Q
 I Y=999 S Y="Unknown, tumor not evaluated" Q
 S Y=Y_" mm"
 Q
 ;
SOC ;Sets of codes
 Q:Y=""
 S SOC=$P(^DD(FILNUM,FLDNUM,0),U,3),YY=Y_":"
 S J=$F(SOC,YY),JJ=$F(SOC,";",J)-2,Y=Y_" "_$E(SOC,J,JJ)
 K FILNUM,FLDNUM,J,JJ,SOC,YY
 Q
 ;
TAHIST ;Screen for TOBACCO HISTORY (160,38) and ALCOHOL HISTORY (160,39)
 S ACDT=0,NUM=0,ACY=$O(^ONCO(165.5,"AC",DA,""))
 I ACY="" Q
 S ACN=$E(ACY,1,4)
 I (ACN>1998) S ACDT=1999
 I Y?1N S NUM=1
 Q
 ;
RE ;2001 Lung (NSCLC) Cancers PCE Study
 ; Item 9. Radiological Evaluation
 ; LNG TUMOR SIZE (BONE SCAN)     (165.5,1409.4)
 ; LNG NUM OF TUMORS (BONE SCAN)  (165.5,1409.5)
 ; LNG TUMOR SIZE (CHEST CT)      (165.5,1410.4)
 ; LNG NUM OF TUMORS (CHEST CT)   (165.5,1410.5)
 ; LNG TUMOR SIZE (BRAIN CT)      (165.5,1411.4)
 ; LNG NUM OF TUMORS (BRAIN CT)   (165.5,1411.5)
 ; LNG TUMOR SIZE (CHEST MRI)     (165.5,1412.4)
 ; LNG NUM OF TUMORS (CHEST MRI)  (165.5,1412.5)
 ; LNG TUMOR SIZE (BRAIN MRI)     (165.5,1413.4)
 ; LNG NUM OF TUMORS (BRAIN MRI)  (165.5,1413.5)
 ; LNG TUMOR SIZE (PET SCAN)      (165.5,1414.4)
 ; LNG NUM OF TUMORS (PET SCAN)   (165.5,1414.5)
 ; LNG TUMOR SIZE (CHEST XRAY)    (165.5,1415.4)
 ; LNG NUM OF TUMORS (CHEST XRAY) (165.5,1415.5)
 I +Y=0 S Y="Test not performed"
 I Y=999!(Y=99) S Y="Test performed, not documented"
 Q
