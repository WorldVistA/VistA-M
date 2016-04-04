DIKZ2 ;SFISC/XAK-XREF COMPILER ;1:52 PM  7 Jan 2000
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**27**
 ;
 S DIKR=DIKR+1
 S DIK1=" I $D("_DIKVR_") K DIKLM S:DIKM1="_A_" DIKLM=1"
 I A>1 D
 . S DIK1=DIK1_" S:DIKM1'="_A_"&'$G(DIKPUSH("_A_")) DIKPUSH("_A_")=1,"
 . F DIK4=A:-1:2 S DIK8=DIK4-1,DIK1=DIK1_"DA("_DIK4_")=DA("_DIK8_"),"
 . S DIK1=DIK1_"DA(1)=DA,DA=0"
 . F DIK4=2:1:A-1 S DIK1=DIK1_" S:DIKM1<"_DIK4_" DA("_(A-DIK4)_")=0"
 S ^UTILITY($J,DIKR)=DIK1_" G @DIKM1"
 S DIKR=DIKR+1,DIKCT=0 I A>1 D DAR
 S ^UTILITY($J,DIKR)=A-1_" ;",DIKR=DIKR+1
 D:DIKVR="DIKILL" WFK
 S DIKCT=DIKCT+1,DIKL2=A-1,DIK1=$C(64+DIKCT)_" S DA=$O("_DIK2_DIK8(DH)_"DA))"
 S ^UTILITY($J,DIKR)=DIK1_" I DA'>0 S DA=0 "_$S(DIKL2=0:"",1:"Q:DIKM1="_DIKL2_"  ")_"G "_$S(A'<2:$C(64+A-1),1:"END"),DIKR=DIKR+1
 K DIK6
 Q
CRT ;
 I '$D(^DD(DV,"IX")),'$D(^TMP("DIKC",$J,DV)) K DU(DV) Q
 S DIK(X,DV)="",DIK4(DV)=DW,DIK2(DV)="DA("_A_"),,DIKM1="_A_",DIKUM'<"_A
 I A=1 S DIK8(DV)=$P(DIK2(DV),",",1,2)_DIK4(DV)_","
 E  I $D(DIK2(DH)) S DIKC=DV,DIK8(DV)="" F DIK8=1:1:A D
 . S DIK8(DV)="DA("_DIK8_"),"_DIK4(DIKC)_","_DIK8(DV)
 . S DIKC=^DD(DIKC,0,"UP")
 Q
DAR ;
 S (DIKC,DIK1,%,DIKL2)=1,DIKQ=0
 F DIK8=A-1:-1:1 S DIKC=DIKC+2,DIKCT=DIKCT+1,DIK4=" S DA("_DIK8_")=$O("_DIK2_$P(DIK8(DH),",",1,DIKC)_"))" S:'$D(%) ^UTILITY($J,DIKR)=DIKL2_" ;",DIKR=DIKR+1,DIKL2=DIKL2+1 K % D DAR2 K DIK1
 Q
DAR2 ;
 S ^UTILITY($J,DIKR)=$C(64+DIKCT)_DIK4_" I DA("_DIK8_")'>0 S DA("_DIK8_")=0 "_$S($D(DIK6)&('$D(DIK1)):"Q:DIKM1="_DIKQ_"  ",1:"")_"G "_$S($D(DIK1):"END",1:$C(64+DIKCT-1)),DIKR=DIKR+1,DIKQ=DIKQ+1,DIK6=1
 Q
 ;
WFK ;Get whole file kill xrefs
 N DIKXR,DIKKW,DIKKW0,DIKCODE
 S DIKXR=0 F  S DIKXR=$O(^TMP("DIKC",$J,"KW",DH,DIKXR)) Q:'DIKXR  D
 . S DIKKW=$G(^TMP("DIKC",$J,"KW",DH,DIKXR))
 . Q:DIKKW?."^"!(DIKKW="Q")
 . S DIKKW0=$G(^TMP("DIKC",$J,"KW",DH,DIKXR,0))
 . I DIKKW0="" D DOTLINE^DIKZ0(" "_DIKKW) Q
 . Q:$P(DIKKW0,U)'="W"
 . ;
 . ;Build code to push down DA array
 . S DIKCODE=$$BCPDA(A,$P(DIKKW0,U,2))
 . I DIKCODE]"" D LINE^DIKZ0(" "_DIKCODE)
 . D DOTLINE^DIKZ0(" "_DIKKW)
 . I DIKCODE]"" D LINE^DIKZ0(" K DA M DA=DIKSVDA")
 Q
 ;
BCPDA(LEV,RFILE) ;Build code to push down DA array
 N DIFF,COD,I,RLEV
 S RLEV=$$FLEV^DIKCU(RFILE)
 S DIFF=RLEV-LEV
 Q:DIFF<1 ""
 ;
 S COD=""
 F I=RLEV:-1:DIFF S COD=COD_"DA("_I_")=DA("_(I-DIFF)_"),"
 F I=DIFF-1:-1:0 S COD=COD_"DA("_I_")=0,"
 I COD]"" D
 . S COD=$E(COD,1,$L(COD)-1)
 . F  Q:COD'["DA(0)"  S COD=$P(COD,"DA(0)")_"DA"_$P(COD,"DA(0)",2,999)
 . S COD="K DIKSVDA M DIKSVDA=DA S "_COD
 Q COD
