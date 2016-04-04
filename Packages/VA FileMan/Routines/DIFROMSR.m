DIFROMSR ;SFISC/DCL,TKW-RESOLVE POINTERS ON TARGET SYSTEM ;5/14/98  12:29
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
RP(DIFRFLG,DIFRFIA,DIFRSA,DIFRMSGR) ; Resolve Pointers on Target System
 ;The "FRV1" and "FRVL" structures within the
 ;transport array are used.
 ;FILE,FLAGS,FIAROOT,SOURCE_ARRAY,MSG_ROOT
 ;*
 ;FLAGS=(RESERVED FOR LATER USE)
 ;    (Optional)
 ;                 None
 ;*
 ;FIA_ARRAY="FIA"_ARRAY_INPUT_ARRAY_ROOT
 ;    (Optional) - Close Input Array Reference
 ;    See DIFROM SERVER documentation for FIA array structure
 ;    definitions.  If undefined SOURCE_ARRAY will be used
 ;    by appending "FIA" to the source array root subscript.
 ;*
 ;SOURCE_ARRAY=CLOSED_INPUT_ARRAY_ROOT
 ;    (Required) - Closed Input Array Reference where the file data
 ;    is temporarily stored for distribution.
 ;*
 ;MSG_ROOT=CLOSED ARRAY REFERENCE
 ;    (Optional) - Closed array reference where messages such as
 ;    errors will be returned.  If not passed, decendents of ^TMP
 ;    will be used.
 ;*
 I '$D(DIQUIET) N DIQUIET S DIQUIET=1
 I '$D(DIFM) N DIFM S DIFM=1
 I $G(U)'="^"!($G(DT)'>0)!($G(DTIME)'>0)!('$D(DUZ)) D DT^DICRW
 I $G(DIFRSA)']"" D ERR(6) G EXIT
 S DIFRFIA=$G(DIFRFIA) S:DIFRFIA="" DIFRFIA=$NA(@DIFRSA@("FIA"))
 ;
 I '$D(DIFRFIA) D ERR(2) G EXIT
 N DIFRFRVX,DIFRFILE
 S DIFRFRVX="FRV1",DIFRFILE=0 F  S DIFRFILE=$O(@DIFRSA@(DIFRFRVX,DIFRFILE)) Q:DIFRFILE'>0  D FILE
 G EXIT
 ;
FILE N DIFRTART,DIFRDNSC,DIFRPCE,DIFRSDA,DIFRY,DIFRPRV,DIFRPTF,DIFRPTFR,DIFRPRVL,DIFR2DD,DIFRTARL
 N C,D0,DA,DIC,DIK,F,G,I,R1,R2,R3,X,Y
 S DIFRTART=$NA(@DIFRSA@(DIFRFRVX,DIFRFILE))
 S DIFRTARL=$NA(@DIFRSA@("FRVL",DIFRFILE))
 S DIFRSDA=$$OREF^DILF($NA(@DIFRSA@("DATA",DIFRFILE))),DIFRDNSC=""
 F  S DIFRDNSC=$O(@DIFRTART@(DIFRDNSC)) Q:DIFRDNSC=""  D
 .K R1
 .S R2=DIFRDNSC,C=$P(R2,","),F=1,R1=0
 .F I=1:1 Q:I>C  S G=$P(R2,",",F,I) Q:G=""  I G'[""""!($L(G,"""")#2&($E(G)="""")&($E(G,$L(G))="""")) S F=F+$L(G,","),I=F-1,R1(R1)=G,R1=R1+1,C=C+($L(G,",")-1)
 .I R1'>3 S DIFR2DD=DIFRFILE
 .E  D
 ..S R3=""
 ..F I=0:1:R1-3 S R3=R3_R1(I)_","
 ..S DIFR2DD=+$P($G(@(DIFRSDA_R3_"0)")),"^",2)
 ..Q
 .;
 .S DIFRPCE=""
 .F  S DIFRPCE=$O(@DIFRTART@(DIFRDNSC,DIFRPCE)) Q:DIFRPCE'>0  D
 ..S DIFRPRV=$G(@DIFRTART@(DIFRDNSC,DIFRPCE)),DIFRPTF=$G(^(DIFRPCE,"F"))
 ..S DIFRPRVL=$G(@DIFRTARL@(DIFRDNSC)),DIFRPTFR=$P(DIFRPTF,";",2)
 ..I DIFRPRVL="" D ERR(7," (^"_DIFRPTFR_"/"_DIFRPRV_")") Q
 ..I DIFRPTFR="" D ERR(8," ("_DIFRPRVL_"/"_DIFRPRV_")") Q
 ..I DIFRPRV="" D ERR(9," (^"_DIFRPTFR_"/"_DIFRPRVL_")") Q
 ..I '$D(@("^"_DIFRPTFR_"0)")) D ERR(10," (^"_DIFRPTFR_"/"_DIFRPRV_")") Q
 ..D LOOKUP
 ..I +Y'>0 D ERR(11," ("_DIC_"  Entry:"_DIFRPRV_")") S Y=-1
 ..S DIFRY=+Y S:DIFRPTF DIFRY=+Y_";"_DIFRPTFR
 ..S $P(@DIFRPRVL,"^",DIFRPCE)=DIFRY
 ..Q
 ;
 S DIK=@DIFRFIA@(DIFRFILE,0),DIK(0)="AB"
 D IXALL^DIK:$O(@(DIK_"0)"))
 ;
 Q
 ;
LOOKUP ; Lookup entry on pointed-to file
 N DIFRS S DIFRS=$NA(@DIFRSA@("FRV1K",DIFRFILE,DIFRDNSC,DIFRPCE))
 S DIC="^"_DIFRPTFR
 I '$O(@DIFRS@(0)) S DIC(0)="X",X=DIFRPRV D ^DIC Q
 N DIFL,DIKEY,I,DIFRVAL
 S DIKEY=@DIFRS
 S DIFL=+$P(@("^"_DIFRPTFR_"0)"),U,2) I 'DIFL S Y=-1 Q
 F I=0:0 S I=$O(@DIFRS@(I)) Q:'I  S DIFRVAL(I)=@DIFRS@(I)
 S Y=$$FIND1^DIC(DIFL,",","X",.DIFRVAL,DIKEY)
 S:'Y Y=-1 Q
 ;
EXIT I $G(DIFRMSGR)]"" D CALLOUT^DIEFU(DIFRMSGR)
 Q
ERR(X,Y) S X=$P($T(ERR+X),";",5) S:$D(Y) Y(1)=Y Q:'X  D BLD^DIALOG(X,.Y) Q
 ;;FIA Node Is Set To "No Data";1;9509
 ;;FIA Array Does Not Exist;2;9501
 ;;;3;
 ;;Records Do Not Exist;4;9510
 ;;FIA File Number Invalid;5;9502
 ;;Source Array Root Missing;6;9533
 ;;Resolved Value Data Link Missing;7;9534
 ;;Pointed Too File Missing;8;9535
 ;;Pointer Resolved Value Missing;9;9538
 ;;Pointed Too File NOT on Target System;10;9536
 ;;Unable To Find Exact Match And Resolve Pointer;11;9537
