EDPQPPS ;SLC/KCM - Display Board Specs ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;**6**;Feb 24, 2012;Build 200
 ;
GET(AREA,BOARD) ; Get Display Board Specs
 ;N I S I=0
 ;F  S I=$O(^EDPB(231.9,AREA,2,I)) Q:'I  D XML^EDPX(^EDPB(231.9,AREA,2,I,0))
 N ROLEIEN,R0,RNAME,RABBR,RXML
 I '$L($G(BOARD)) S BOARD="Main (default)"
 S BOARD=$O(^EDPB(231.9,AREA,4,"B",BOARD,0))
 D LOADBRD^EDPBCF(AREA,BOARD)
 ;
 D XML^EDPX("<colorSpec>")
 D CLRBED(AREA)
 ;D CLRSTAFF(AREA,"md","P")
 ;D CLRSTAFF(AREA,"res","R")
 ;D CLRSTAFF(AREA,"rn","N")
 S ROLEIEN=0 F  S ROLEIEN=$O(^EDPB(232.5,ROLEIEN)) Q:'ROLEIEN  D
 .S R0=$G(^EDPB(232.5,ROLEIEN,0)),RNAME=$P(R0,U),RABBR=$P(R0,U,2),RXML=$P(R0,U,3)
 .D CLRSTAFF(AREA,RXML,ROLEIEN)
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
CLRSTAFF(AREA,ROLEID,ROLEIEN) ; add staff colors
 D XML^EDPX("<colors id='"_ROLEID_"' type='staff' >")
 N IEN,X0
 S IEN="" F  S IEN=$O(^EDPB(231.7,"AC",EDPSITE,AREA,ROLEIEN,IEN)) Q:'IEN  D
 . S X0=^EDPB(231.7,IEN,0) Q:'$P(X0,U,8)
 . N X
 . S X("att")=$S(ROLEID'="":ROLEID,1:"nop")
 . ;S X("att")=$S(ROLE="P":"@md",ROLE="N":"@rn",ROLE="R":"@res",1:"nop")
 . S X("clr")=$P(X0,U,8)
 . S X("val")=$P(X0,U)
 . D XML^EDPX($$XMLA^EDPX("map",.X))
 D XML^EDPX("</colors>")
 Q
