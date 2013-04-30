EDPQDBS ;SLC/KCM - Display Board Specs ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
GET(AREA,BOARD) ; Get Display Board Specs
 ;N I S I=0
 ;F  S I=$O(^EDPB(231.9,AREA,2,I)) Q:'I  D XML^EDPX(^EDPB(231.9,AREA,2,I,0))
 I '$L($G(BOARD)) S BOARD="Main (default)"
 S BOARD=$O(^EDPB(231.9,AREA,4,"B",BOARD,0))
 D LOADBRD^EDPBCF(AREA,BOARD)
 ;
 D XML^EDPX("<colorSpec>")
 D CLRBED(AREA)
 D CLRSTAFF(AREA,"md","P")
 D CLRSTAFF(AREA,"res","R")
 D CLRSTAFF(AREA,"rn","N")
 N I S I=0
 F  S I=$O(^EDPB(231.9,AREA,3,I)) Q:'I  D XML^EDPX(^EDPB(231.9,AREA,3,I,0))
 D XML^EDPX("</colorSpec>")
 Q
CLRBED(AREA) ; add bed colors
 D XML^EDPX("<colors id='bed' type='bed' >")
 N BED,X0
 S BED=0 F  S BED=$O(^EDPB(231.8,"C",EDPSITE,AREA,BED)) Q:'BED  D
 . S X0=^EDPB(231.8,BED,0)
 . I $P(X0,U,12)="" Q
 . N X
 . S X("att")="@bed"
 . S X("clr")=$P(X0,U,12)
 . S X("val")=BED
 . D XML^EDPX($$XMLA^EDPX("map",.X))
 D XML^EDPX("</colors>")
 Q
CLRSTAFF(AREA,ROLEID,ROLE) ; add staff colors
 D XML^EDPX("<colors id='"_ROLEID_"' type='staff' >")
 N IEN
 S IEN="" F  S IEN=$O(^EDPB(231.7,"AC",EDPSITE,AREA,ROLE,IEN)) Q:'IEN  D
 . S X0=^EDPB(231.7,IEN,0) Q:'$P(X0,U,8)
 . N X
 . S X("att")=$S(ROLE="P":"@md",ROLE="N":"@rn",ROLE="R":"@res",1:"nop")
 . S X("clr")=$P(X0,U,8)
 . S X("val")=$P(X0,U)
 . D XML^EDPX($$XMLA^EDPX("map",.X))
 D XML^EDPX("</colors>")
 Q
