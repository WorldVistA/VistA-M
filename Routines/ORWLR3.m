ORWLR3 ; slc/dcm - VBEC Blood Bank Report cont. ;11/13/07  15:19
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**212,309**;Dec 17, 1997;Build 26
RPT ;Pull report data from VBECS
 N ORI,ORJ,ORK,ORT,ORL,ORRY,REQX,CMT,C,ID,T,CFAG,CNTR,BUMP,OR4
 K ^TMP("VBDATA",$J),^TMP("ORCAN",$J)
 ;Antibodies
 D ABID^VBECA1(PATID,PATNAM,PATDOB,.ORPARENT,.ORRY)
 I $O(ORRY("ABID",0)) D
 . D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(0,.CCNT,"ANTIBODIES IDENTIFIED: ",.CCNT),ID=0
 . D LN F  S ID=$O(ORRY("ABID",ID)) Q:'ID  D
 .. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(0,.CCNT,$G(ORRY("ABID",ID)),.CCNT)
 .. I $O(ORRY("ABID",ID,0)) D
 ... D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,"COMMENT:",.CCNT) D LN
 ... S CMT=0 F  S CMT=$O(ORRY("ABID",ID,CMT)) Q:'CMT  S C=ORRY("ABID",ID,CMT) D
 .... D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,C,.CCNT)
 ... D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 ;Transfusion reactions 
 D TRRX^VBECA1(PATID,PATNAM,PATDOB,.ORPARENT,.ORRY)
 I $O(ORRY("TRRX",0)) D
 . D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(0,.CCNT,"TRANSFUSION REACTIONS:",.CCNT) D LN
 . S ID=0 F  S ID=$O(ORRY("TRRX",ID)) Q:'ID  S X=ORRY("TRRX",ID) D
 .. S Y=$TR($$FMTE^XLFDT(+X,"M"),"@"," ") D LN
 .. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(3,.CCNT,"Type:  "_$S($P(X,U,2)]"":$P(X,U,2),1:"Unknown"),.CCNT) D LN
 .. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(6,.CCNT,"Date/Time",.CCNT)_$$S^ORU4(35,.CCNT,"Unit ID",.CCNT)_$$S^ORU4(66,.CCNT,"Component",.CCNT) D LN
 .. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(6,.CCNT,"---------",.CCNT)_$$S^ORU4(35,.CCNT,"-------",.CCNT)_$$S^ORU4(66,.CCNT,"---------",.CCNT) D LN
 .. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(6,.CCNT,$S(Y]"":Y,1:"Unknown"),.CCNT)_$$S^ORU4(35,.CCNT,$S($P(X,U,3)]"":$P(X,U,3),1:"Unknown"),.CCNT)_$$S^ORU4(66,.CCNT,$S($P(X,U,4)]"":$P(X,U,4),1:"Unknown"),.CCNT)
 .. I $O(ORRY("TRRX",ID,0)) D
 ... D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(6,.CCNT,"Comment:",.CCNT) D LN
 ... S CMT=0 F  S CMT=$O(ORRY("TRRX",ID,CMT)) Q:'CMT  S C=ORRY("TRRX",ID,CMT) D
 .... D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(6,.CCNT,C,.CCNT)
 .. D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 ;Xmatched units, Component requests, Diagnostic test results
 D DFN^VBECA3A(DFN)
 ;Available Units
 D AVUNIT^VBECA4(DFN,"LRB") ;New Improved Format
 I $O(^TMP("LRB",$J,0)) D
 . D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(0,.CCNT,"AVAILABLE/ISSUED UNITS:",.CCNT) D LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,"Date/Time Assigned",.CCNT)_$$S^ORU4(22,.CCNT,"Unit ID",.CCNT)_$$S^ORU4(34,.CCNT,"Component",.CCNT)_$$S^ORU4(51,.CCNT,"ABO/Rh",.CCNT)
 . S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(61,.CCNT,"Exp. Date",.CCNT)_$$S^ORU4(73,.CCNT,"Location",.CCNT)_$$S^ORU4(105,.CCNT,"Division",.CCNT)
 . D LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,"------------------",.CCNT)_$$S^ORU4(22,.CCNT,"-------",.CCNT)_$$S^ORU4(34,.CCNT,"---------",.CCNT)_$$S^ORU4(51,.CCNT,"------",.CCNT)
 . S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(61,.CCNT,"---------",.CCNT)_$$S^ORU4(73,.CCNT,"--------",.CCNT)_$$S^ORU4(105,.CCNT,"--------",.CCNT)
 . D LN
 . N ORI,ORL,ORDIV,ORASSDT
 . S ORI=0 F  S ORI=$O(^TMP("LRB",$J,ORI)) Q:ORI<1  S ID=^(ORI) D
 .. S T=9999999-ORI D T^ORWLR2 S ORASSDT=T
 .. S T=$P(ID,"^",2),X=$S($P(ID,"^",7)="P":"Pos",$P(ID,"^",7)="N":"Neg",1:$P(ID,"^",7)),ORDIV="",ORL=""
 .. I $L($P(ID,"^",9)) S ORDIV=$E($P(ID,"^",9),1,20)
 .. I $L($P(ID,"^",10)) S ORL=$E($P(ID,"^",10),1,20)
 .. D T^ORWLR2,LN
 .. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,ORASSDT,.CCNT)_$$S^ORU4(22,.CCNT,$P(ID,"^",3),.CCNT)_$$S^ORU4(34,.CCNT,$P(ID,"^",4),.CCNT)_$$S^ORU4(51,.CCNT,$P(ID,"^",6)_"  "_X,.CCNT)
 .. S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(61,.CCNT,T,.CCNT)_$$S^ORU4(73,.CCNT,ORL,.CCNT)_$$S^ORU4(105,.CCNT,ORDIV,.CCNT)
 K ^TMP("LRB",$J)
 ;I $O(^TMP("VBDATA",$J,"UNIT",0)) D  ;Old Format
 ;. D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 ;. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(0,.CCNT,"AVAILABLE UNITS:",.CCNT) D LN
 ;. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,"Unit ID",.CCNT)_$$S^ORU4(14,.CCNT,"Product",.CCNT)_$$S^ORU4(37,.CCNT,"ABO/Rh",.CCNT)_$$S^ORU4(47,.CCNT,"Location",.CCNT)_$$S^ORU4(67,.CCNT,"Exp. Date/Time",.CCNT) D LN
 ;. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,"-------",.CCNT)_$$S^ORU4(14,.CCNT,"-------",.CCNT)_$$S^ORU4(37,.CCNT,"------",.CCNT)_$$S^ORU4(47,.CCNT,"--------",.CCNT)_$$S^ORU4(67,.CCNT,"--------------",.CCNT) D LN
 ;. K ^TMP("ORTMP",$J) N ORI,ORJ,ORL
 ;. S ORI="" F  S ORI=$O(^TMP("VBDATA",$J,"UNIT",ORI)) Q:ORI=""  S ID=^(ORI) I $L($P(ID,"^",7)) D
 ;.. S ^TMP("ORTMP",$J,$P(ID,"^",7),ORI)=ID
 ;. S ORJ="" F  S ORJ=$O(^TMP("ORTMP",$J,ORJ)) Q:ORJ=""  S ORI="" F  S ORI=$O(^TMP("ORTMP",$J,ORJ,ORI)) Q:ORI=""  D
 ;.. S ID=^TMP("VBDATA",$J,"UNIT",ORI)
 ;.. Q:'$L($P(ID,"^"))
 ;.. S T=$P(ID,"^"),X=$S($P(ID,"^",4)="P":"Pos",$P(ID,"^",4)="N":"Neg",1:$P(ID,"^",4)),ORL=""
 ;.. I $L($P(ID,"^",5)) S ORL=$S($O(^DIC(4,"D",$$TRIM($P(ID,"^",5)),0)):$P(^DIC(4,$O(^(0)),0),"^"),1:"")
 ;.. D T^ORWLR2,LN
 ;.. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,$P(ID,"^",8),.CCNT)_$$S^ORU4(14,.CCNT,$P(ID,"^",2),.CCNT)_$$S^ORU4(37,.CCNT,$P(ID,"^",3)_"  "_X,.CCNT)_$$S^ORU4(47,.CCNT,ORL,.CCNT)_$$S^ORU4(67,.CCNT,T,.CCNT)
 ;K ^TMP("ORTMP",$J)
 ;Specimen Tests
 D SPEC^ORWLR4
 ;Component Requests
 N A,F,%DT,Y,SORT
 I $O(^TMP("VBDATA",$J,"COMPONENT REQUEST",0)) D
 . D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(0,.CCNT,"COMPONENT REQUESTS:",.CCNT) D LN
 . S X="Component Type"
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,X,.CCNT)_$$S^ORU4(22,.CCNT,"Units",.CCNT)_$$S^ORU4(28,.CCNT,"Request date",.CCNT)_$$S^ORU4(48,.CCNT,"Date wanted",.CCNT)_$$S^ORU4(68,.CCNT,"Requestor",.CCNT)_$$S^ORU4(78,.CCNT,"By",.CCNT) D LN
 . S Y="--------------"
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,Y,.CCNT)_$$S^ORU4(22,.CCNT,"-----",.CCNT)_$$S^ORU4(28,.CCNT,"------------",.CCNT)_$$S^ORU4(48,.CCNT,"-----------",.CCNT)_$$S^ORU4(68,.CCNT,"---------",.CCNT)_$$S^ORU4(78,.CCNT,"--",.CCNT) D LN
 . S A=0 F  S A=$O(^TMP("VBDATA",$J,"COMPONENT REQUEST",A)) Q:'A  D
 .. S F=^TMP("VBDATA",$J,"COMPONENT REQUEST",A),T="",%DT="T",X=$P(F,"^",3),Y=-1
 .. I $L(X) D ^%DT
 .. I Y'=-1 S T=Y D T^ORWLR2
 .. S SORT=$S($P(F,"^",3):$P(F,"^",3),$P(F,"^",4):$P(F,"^",4),1:0),^TMP("ORTMP",$J,9999999-SORT,0)=F
 . S ORI=0 F  S ORI=$O(^TMP("ORTMP",$J,ORI)) Q:'ORI  I $D(^(ORI,0)) S F=^(0) D
 .. D LN
 .. S T="",%DT="T",X=$P(F,"^",3),Y=-1
 .. I $L(X) D ^%DT
 .. I Y'=-1 S T=Y D T^ORWLR2
 .. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,$E($P(F,"^"),1,25),.CCNT)_$$S^ORU4(22,.CCNT,$J($P(F,"^",2),3),.CCNT)_$$S^ORU4(28,.CCNT,T,.CCNT)
 .. S T="",%DT="T",X=$P(F,"^",4),Y=-1
 .. I $L(X) D ^%DT
 .. I Y'=-1 S T=Y D T^ORWLR2
 .. S X=$S($P(F,"^",6):$P(F,"^",6)_",",1:""),X=$S($L(X):$$GET1^DIQ(200,X,1),1:$P(F,"^",6))
 .. S REQX=$S($P(F,"^",5):$P(F,"^",5)_",",1:""),REQX=$S($L(REQX):$$GET1^DIQ(200,REQX,1),1:$P(F,"^",5))
 .. S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(48,.CCNT,T,.CCNT)_$$S^ORU4(68,.CCNT,REQX,.CCNT)_$$S^ORU4(78,.CCNT,X,.CCNT)
 K ^TMP("ORTMP",$J)
 ;Transfused Units
 D TRAN^ORWLR2
 Q
CAN ;Process Canned comments
 ;Comments are subscripted in 1-6
 ;1-3 are user comments
 ;4-6 are canned comments
 ;Either one, both, or neither may be present
 N CNT,CCNT
 S CCNT=1,CNT=$S($O(^TMP("ORCAN",$J,0)):$O(^TMP("ORCAN",$J,99999999),-1),1:0)
 I ORK=4 S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,CFAG,.CCNT)
 S CZ="" F CI=1:1:$L(CX," ") S CY=$P(CX," ",CI) D
 . ;I ORK>3,$O(^TMP("VBDATA",$J,"SPECIMEN",ORI,ORK))>3,CI=$L(CX," ") S CZ=CY Q
 . I CI=$L(CX," ") S CZ=CY Q
 . I $L(CY)>80 D  S CZ="" Q
 .. F CJ=1:80 S CZ=$E(CY,CJ,CJ+79) Q:'$L(CZ)  S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,CZ,.CCNT)
 . I $L(CZ)+$L(CY)>80 S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,CZ,.CCNT),CZ="" D  Q
 .. I $L(CY)>80 D
 ... F CJ=1:80 S CZ=$E(CY,CJ,CJ+79) Q:'$L(CZ)  S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,CZ,.CCNT)
 ... S CZ=""
 .. E  S CZ=CY D
 ... I CI=$L(CX," ") S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,CZ,.CCNT),CZ=""
 . S CZ=$S($L(CZ):CZ_" "_CY,1:CY) I $L(CZ)>80 S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,CZ,.CCNT),CZ=""
 . I CI=$L(CX," ") S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,CZ,.CCNT),CZ=""
 Q
LN ;Increment counts
 S GCNT=GCNT+1,CCNT=1
 Q
TRIM(X) ;Trim leading and trailing spaces
 S X=$RE(X) F  S:$E(X)=" " X=$E(X,2,999) Q:$E(X)'=" "  Q:'$L(X)  ;trail
 S X=$RE(X) F  S:$E(X)=" " X=$E(X,2,999) Q:$E(X)'=" "  Q:'$L(X)  ;lead
 Q X
