FBPHON1 ;AISC/CMR-LIST PAYMENTS CONT. ;5/13/1999
 ;;3.5;FEE BASIS;**4,69**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
GATHER(DFN,FBV) ;gather vendor/veteran specific payment info
 ;required input DFN = veteran ien
 ;               FBV = vendor ien
 ;output ^TMP($J,"FBPHON", containing pmnts for all programs
 N FBCNT,FBI,FBJ,FBK,FBSDI,FBAADT,FBAACPI,FBX,FBMODLE,FBXAD,FBXADJC
 Q:'$G(DFN)!('$G(FBV))
 S FBCNT=0
OPT ;gather opt payments
 S FBSDI=0 F  S FBSDI=$O(^FBAAC(DFN,1,FBV,1,FBSDI)) Q:'FBSDI  S FBAADT=+^(FBSDI,0),FBAACPI=0 F  S FBAACPI=$O(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI)) Q:'FBAACPI  D
 .S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,"_FBAACPI_",""M"")","E")
 .S FBX=^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,0),FBFL=$S($P(FBX,U,20)="R":"*",1:""),FBFL=FBFL_$S($P(FBX,U,21)="VP":"#",1:""),FBCNT=FBCNT+1
 .S FBXAD=$$ADJLRA^FBAAFA(FBAACPI_","_FBSDI_","_FBV_","_DFN_",")
 .S FBXADJC=$P(FBXAD,U,1) ;Adjustment code list
 .I FBXADJC["," S FBXADJC=$P(FBXADJC,",",1)_"&" ;More than one adj code
 .I FBXADJC="" S FBXADJC=$P(FBX,U,5) ;No adj codes use Suspense code
 .S ^TMP($J,"FBPHON",-FBAADT,FBCNT)="OPT"_"^"_FBAADT_"^"_$$CPT^FBAAUTL4(+FBX)_$S($G(FBMODLE)]"":"-"_FBMODLE,1:"")_"^"_$P(FBX,U,2)_"^"_$P(FBX,U,3)_"^"_FBXADJC_"^"_$P(FBX,U,16)_"^"_$P(FBX,U,8)_"^"_DFN_","_FBV_","_FBSDI_","_FBAACPI_"^"_FBFL
 .K FBX,FBFL
 K FBSDI,FBAACPI,FBAADT
INP ;gather inpt payments
 S FBI=0 F  S FBI=$O(^FBAAI("AK",DFN,FBV,FBI)) Q:'FBI  I $D(^FBAAI(FBI,0)) S FBX=^FBAAI(FBI,0),FBCNT=FBCNT+1,FBFL=$S($P(FBX,U,13)="R":"*",1:""),FBFL=FBFL_$S($P(FBX,U,14)="VP":"#",1:"") D
 .S FBXAD=$$ADJLRA^FBCHFA(FBI_",")
 .S FBXADJC=$P(FBXAD,U)
 .I FBXADJC["," S FBXADJC=$P(FBXADJC,",",1)_"&" ;More than one adj code
 .I FBXADJC="" S FBXADJC=$P(FBX,U,11) ;No adj codes use Suspense code
 .S ^TMP($J,"FBPHON",-$P(FBX,U,6),FBCNT)=$S($P(FBX,U,12)=6:"CH",$P(FBX,U,12)=7:"CNH",1:"")_"^"_$P(FBX,U,6)_"-"_$P(FBX,U,7)_"^^"_$P(FBX,U,8)_"^"_$P(FBX,U,9)_"^"_FBXADJC_"^"_+FBX_"^"_$P(FBX,U,17)_"^"_FBI_"^"_FBFL
 .K FBX,FBFL
 K FBI
PHARM ;gather pharm payments
 S FBAADT=0 F  S FBAADT=$O(^FBAA(162.1,"AD",DFN,FBAADT)) Q:'FBAADT  S FBI=0 F  S FBI=$O(^FBAA(162.1,"AD",DFN,FBAADT,FBI)) Q:'FBI  I $D(^FBAA(162.1,"AN",FBV,FBI)) D
 .S FBJ=0 F  S FBJ=$O(^FBAA(162.1,"AD",DFN,FBAADT,FBI,FBJ)) Q:'FBJ  I $D(^FBAA(162.1,FBI,"RX",FBJ,0)) S FBX=^(0),FBFL=$S($P(FBX,U,20)="R":"*",1:""),FBFL=FBFL_$S($P($G(^FBAA(162.1,FBI,"RX",FBJ,2)),U,3)="VP":"#",1:"") D
 ..S FBCNT=FBCNT+1
 ..S FBXAD=$$ADJLRA^FBRXFA(FBJ_","_FBI_",")
 ..S FBXADJC=$P(FBXAD,U,1) ;Adjustment code list
 ..I FBXADJC["," S FBXADJC=$P(FBXADJC,",",1)_"&" ;More than one adj code
 ..I FBXADJC="" S FBXADJC=$P(FBX,U,8)
 ..S ^TMP($J,"FBPHON",-(9999999-FBAADT),FBCNT)="PHAR^"_(9999999-FBAADT)_"^"_$P(FBX,U)_"^"_$P(FBX,U,4)_"^"_$P(FBX,U,16)_"^"_FBXADJC_"^"_+$G(^FBAA(162.1,FBI,0))_"^"_$P(FBX,U,17)_"^"_FBI_","_FBJ_"^"_FBFL
 .K FBX,FBFL
 K FBAADT,FBI,FBJ
 Q
