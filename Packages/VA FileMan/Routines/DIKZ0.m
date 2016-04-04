DIKZ0 ;SFISC/XAK-XREF COMPILER ;23AUG2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**140**
 ;
 S DIK0=" I X'=""""" D DD^DIK,A,SD Q:DIKZQ
RET I $D(DK1) S A=A+1,DIKA=1,DH=0 F  S DH=$O(DK1(DH)) Q:DH'>0  D E^DIK
 S:DH="" DH=-1 I $D(DK1) K DK1 D SD Q:DIKZQ  G RET
 Q
SD F DH=DH(1):0 S DH=$O(DU(DH)) Q:DH'>0  S:$D(^DD(DH,"SB")) DK1(DH)="" D DD1^DIK,0 Q:DIKZQ  S:$D(^DD(DH,"IX"))!$D(^TMP("DIKC",$J,DH)) DIK(X,DH)="A1^"_DNM_DRN K:'$D(^DD(DH,"IX"))&'$D(^TMP("DIKC",$J,DH)) DIK(X,DH) K DU(DH)
 Q
0 ;
 D SV^DIKZ Q:DIKZQ  S DIK1=""
 I $D(DIKA) S DIK1=" S DA("_A_")=DA"_$S(A=1:"",1:"("_(A-1)_")")
 F DIKL2=A-1:-1:1 S DIK1=DIK1_" S DA("_DIKL2_")=0"
 S ^UTILITY($J,DIKR+1)=DIK1_" S DA=0",DIKR=DIKR+2,^(DIKR)="A1 ;"
 D ^DIKZ2 K DIKA S DIKLW=1
 S DIKR=DIKR+1,DIK=DIK2_DIK8(DH),^UTILITY($J,DIKR)=A_" ;",DIKR=DIKR+1
A ;
 K DIK6 F DIKQ=0:0 S DIKQ=$O(^UTILITY("DIK",$J,DH,DIKQ)) Q:DIKQ'>0  I $G(DIKVR)="DISET"!(DIKQ'=.01) S %=^(DIKQ) S:+%'=% %=""""_%_"""" D PUT
 I $G(DIKVR)="DIKILL",$D(^UTILITY("DIK",$J,DH,.01)) S DIKQ=.01,%=^(.01) S:+%'=% %=""""_%_"""" D PUT
 D INDEX
 K ^UTILITY("DIK",$J),DIK6
 Q
PUT N DIKSET I '$D(DIK6(%)) S ^UTILITY($J,DIKR)=" S DIKZ("_%_")=$G("_DIK_"DA,"_%_"))",DIK6(%)=""
 S DIKR=DIKR+1,(DIKSET,^UTILITY($J,DIKR))=" "_$P(^UTILITY("DIK",$J,DH,DIKQ,0),"^(X)")_"DIKZ("_%_")"_$P(^(0),"^(X)",2,9)
 F DIKC=0:0 S DIKC=$O(^UTILITY("DIK",$J,DH,DIKQ,DIKC)) S DIKR=DIKR+1 Q:DIKC'>0  D
 .S %=^(DIKC) S:$O(^(0))'=DIKC ^UTILITY($J,DIKR)=DIKSET,DIKR=DIKR+1
 .I %["Q:"!(%[" Q") K DIK6 S ^UTILITY($J,DIKR)=DIK0_" X ^DD("_DH_","_DIKQ_",1,"_DIKC_","_X_")" Q
 .I %["D RCR" K DIK6 S ^UTILITY($J,DIKR)=DIK0_" D",DIKR=DIKR+2,^(DIKR-1)=" .N DIK,DIV,DIU,DIN",^UTILITY($J,DIKR)=" ."_^UTILITY("DIK",$J,DH,DIKQ,DIKC,0) Q
 .I %["S XMB=" S ^UTILITY($J,DIKR)=DIK0_",$D(DIK(0)),DIK(0)[""B"" S DIKZR="_DIKC_",DIKZZ="_DIKQ_" D BUL^"_DNM,DIKR=DIKR+1,^UTILITY($J,DIKR)=DIK0_",'$D(DIKOZ) "_$S($L(%)<225:%,1:"X ^DD("_DH_","_DIKQ_",1,"_DIKC_","_X_")") Q
 .S ^UTILITY($J,DIKR)=DIK0_" "_$S(%[" AUDIT":"S DH="_DH_",DV="_DIKQ_",DU="_A_" ",1:"")_%_$S(%[" AUDIT":"^DIK1",1:"")
 Q
 ;
 ;
INDEX ;Loop through ^TMP and pick up cross references for file DH
 N DIKO,DIKCTAG
 S DIKCTAG=0
 ;
 ;Build code for each xref
 S DIKC=0 F  S DIKC=$O(^TMP("DIKC",$J,DH,DIKC)) Q:'DIKC  D GETINDEX
 D:DIKCTAG LINE("CR"_(DIKCTAG+1)_" K X")
 Q
 ;
GETINDEX ;Get code for one index DIKC in file DH
 I DIKVR="DIKILL",$G(^TMP("DIKC",$J,DH,DIKC,"K"))?."^" Q
 I DIKVR="DISET",$G(^TMP("DIKC",$J,DH,DIKC,"S"))?."^" Q
 ;
 N DIKF,DIKCOD,DIKO,DIK01
 S DIKCTAG=DIKCTAG+1
 D LINE("CR"_DIKCTAG_" S DIXR="_DIKC)
 ;
 ;Build code to set X array
 S DIKF=$O(^TMP("DIKC",$J,DH,DIKC,0)) Q:'DIKF
 D LINE(" K X")
 S DIKO=0 F  S DIKO=$O(^TMP("DIKC",$J,DH,DIKC,DIKO)) Q:'DIKO  D XARR
 D LINE(" S X=$G(X("_DIKF_"))")
 ;
 ;Build code to check for null subscripts
 S DIKCOD="",DIKO=0
 F  S DIKO=$O(^TMP("DIKC",$J,DH,DIKC,DIKO)) Q:'DIKO  D:$G(^(DIKO,"SS"))
 . S DIKCOD=DIKCOD_$E(",",DIKCOD]"")_"$G(X("_DIKO_"))]"""""
 D LINE($S(DIKCOD]"":" I "_DIKCOD_" D",1:" D")) ;**GFT -- NOIS ISL-0604-50146 **
 D LINE(" . K X1,X2 M X1=X,X2=X")
 ;
 I DIKVR="DIKILL" D
 . ;Adjust .01 values X2 array if we're deleting a record
 . I $D(DIK01) D
 ..S DIKCOD="",DIKO=0 F  S DIKO=$O(DIK01(DIKO)) Q:'DIKO  D  ;**GFT -- NOIS ISL-0604-50146 **
 ... S DIKCOD=DIKCOD_$E(",",DIKCOD]"")_"X2("_DIKO_")"
 .. Q:DIKCOD=""
 .. S:DIKF=$O(DIK01(0)) DIKCOD="X2,"_DIKCOD
 .. S:DIKCOD["," DIKCOD="("_DIKCOD_")"
 .. D LINE(" . S:$D(DIKIL) "_DIKCOD_"=""""")
 . ;
 . ;Get kill condition code
 . S DIKCOD=$G(^TMP("DIKC",$J,DH,DIKC,"KC"))
 . I DIKCOD'?."^" D
 .. D LINE(" . N DIKXARR M DIKXARR=X S DIKCOND=1")
 .. D LINE(" . "_DIKCOD)
 .. D LINE(" . S DIKCOND=$G(X) K X M X=DIKXARR")
 .. D LINE(" . Q:'DIKCOND")
 . ;Get kill logic
 . D LINE(" . "_$G(^TMP("DIKC",$J,DH,DIKC,"K")))
 ;
 I DIKVR="DISET" D
 . ;Get set condition code
 . S DIKCOD=$G(^TMP("DIKC",$J,DH,DIKC,"SC"))
 . I DIKCOD'?."^" D
 .. D LINE(" . N DIKXARR M DIKXARR=X S DIKCOND=1")
 .. D LINE(" . "_DIKCOD)
 .. D LINE(" . S DIKCOND=$G(X) K X M X=DIKXARR")
 .. D LINE(" . Q:'DIKCOND")
 . ;Get set logic
 . D LINE(" . "_$G(^TMP("DIKC",$J,DH,DIKC,"S")))
 K DIK6 Q
 ;
XARR ;Build code to set X array
 ;Also return DIK01(order#)="" if crv is .01 field
 N CODE,NODE,REF,LINE,TRANS
 ;K DIK01
 ;
 ;Build data extraction code
 S CODE=$G(^TMP("DIKC",$J,DH,DIKC,DIKO)) Q:CODE?."^"
 I $D(^TMP("DIKC",$J,DH,DIKC,DIKO,"F"))#2 D
 . S DIK01(DIKO)=""
 . S REF=$P($P(CODE,",",1,$L(CODE,",")-2),"(",2,999)
 . S NODE=$P($P(REF,",",$L(REF,",")),"))")
 . I '$D(DIK6(NODE)) D
 .. D LINE(" S DIKZ("_NODE_")="_REF)
 .. S DIK6(NODE)=""
 . S LINE=" "_$P(CODE,REF)_"DIKZ("_NODE_")"_$P(CODE,REF,2,999)
 E  S LINE=" "_CODE
 ;
 S TRANS=$G(^TMP("DIKC",$J,DH,DIKC,DIKO,"T"))
 I TRANS'?."^" D
 . D LINE(LINE)
 . D DOTLINE(" I $G(X)]"""" "_TRANS)
 . D LINE(" S:$D(X)#2 X("_DIKO_")=X")
 E  I $G(NODE)]"",LINE?1" S X=".E D
 . D LINE(" S X("_DIKO_")"_$E(LINE,5,999))
 E  D
 . D LINE(LINE)
 . D LINE(" S:$D(X)#2 X("_DIKO_")=X")
 Q
 ;
DOTLINE(CODE) ;Add code to ^UTILITY. If the code looks like it contains
 ;a Quit command, put the code under a do-dot structure.
 I CODE[" Q"!(CODE["Q:") D
 . D LINE(" D")
 . D LINE(" . "_CODE)
 E  D LINE(CODE)
 Q
 ;
LINE(CODE) ;Add line of code to ^UTILITY, increment DIKR
 S ^UTILITY($J,DIKR)=CODE
 S DIKR=DIKR+1
 Q
