ORWLR3 ; slc/dcm - VBEC Blood Bank Report cont. ;11/13/07  15:19
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**212,309,332**;Dec 17, 1997;Build 44
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
 N INDEX,UNT,ORY,I,CNT,J,K,L,M,X,T,ORASSDT,OREXPDT,ORI,ID,PARAM,ORLOCAB
 S CNT=0,PARAM=+$$GET^XPAR("DIV^SYS^PKG","OR VBECS AVAIL UNITS FORMAT"),ORLOCAB=0
 I $D(ORPRTING)!(+$$GET^XPAR("DIV^SYS^PKG","OR VBECS LOC ABBREV BB REPORT")),PARAM'=1 S ORLOCAB=1 ;Location Abbreviation flag
 K ^TMP("ORUTMP",$J)
 I $O(^TMP("LRB",$J,0)) D
 . K ^TMP("ORUTMP",$J)
 . N ORI,ORL,ORDIV,ORASSDT,ORX,X,ORCNT,ORM,I,C1,C2,C3,C4,C5,C6,C7,C8,Y,H1,H2,H3,H4,H5,H6,H7,H8
 . N ROWSIZ,ORSPLIT
 . S ORSPLIT=0
 . S ORM(1)=14,ORM(2)=7,ORM(3)=7,ORM(4)=9,ORM(5)=6,ORM(6)=9,ORM(7)=$S(ORLOCAB:6,1:8),ORM(8)=8
 . S ORM(1,1)=14,ORM(1,2)=11,ORM(1,4)=9,ORM(2,5)=6,ORM(2,6)=9,ORM(2,7)=$S(ORLOCAB:6,1:8),ORM(2,8)=8
 . S (ORCNT,ORI)=0 F  S ORI=$O(^TMP("LRB",$J,ORI)) Q:ORI<1  S ID=^(ORI) D
 .. S ORX(1)=$$FMTE^XLFDT(9999999-ORI,"5M") ;Assigned Date/Time
 .. S ORX(2)=$P(ID,"^",3) ;Unit ID
 .. S ORX(3)=$P(ID,"^",11) ; Product ID
 .. S ORX(4)=$P(ID,"^",4) ;Component
 .. S X=$S($P(ID,"^",7)="P":"Pos",$P(ID,"^",7)="N":"Neg",1:$P(ID,"^",7)) S ORX(5)=$P(ID,"^",6)_" "_X ;ABO/Rh
 .. S ORX(6)=$P(ID,"^",2) ;Expiration Date
 .. S ORX(7)=$P(ID,"^",10) ;Location
 .. S ORX(8)=$P(ID,"^",9) ;Division NAME
 .. I ORLOCAB D
 ... S X=ORX(7)
 ... I $L(X) S Y=$O(^SC("B",X,0)) I Y S X=$S($L($P($G(^SC(Y,0)),"^",2)):$P(^(0),"^",2),1:$E(X,1,7)) S ORX(7)=X ;Location
 ... E  S ORX(7)=$E(X,1,7)
 .. S X=$$LKUP^XUAF4(ORX(8)) I X,PARAM'=1,$D(ORPRTING) S X=$$NS^XUAF4(X) I $L($P(X,"^",2)) S ORX(8)=$P(X,"^",2) ;Get Division #
 .. S ORCNT=ORCNT+1,^TMP("ORUTMP",$J,ORCNT)=ORX(1)_"^"_ORX(2)_"^"_ORX(3)_"^"_ORX(4)_"^"_ORX(5)_"^"_ORX(6)_"^"_ORX(7)_"^"_ORX(8)
 .. F I=1:1:8 I $L(ORX(I))>ORM(I) S:ORM(I)<$L(ORX(I)) ORM(I)=$L(ORX(I)) ;Expand column width to fit data size
 .. S C1=1,C2=C1+ORM(1),C3=C2+ORM(2),C4=C3+ORM(3),C5=C4+ORM(4),C6=C5+ORM(5),C7=C6+ORM(6),C8=C7+ORM(7)
 .. S ROWSIZ=C8+$L(ORX(8))+8
 .. I ROWSIZ>79,'ORSPLIT S:PARAM=0 ORSPLIT=0 S:PARAM=2 ORSPLIT=1 S:$D(ORPRTING) ORSPLIT=1
 .. I ORSPLIT D
 ... F I=1,2,4 I $L(ORX(I))>ORM(1,I) S ORM(1,I)=$L(ORX(I)) ;Expand 1st Row column width to fit data
 ... I $L(ORX(3))>$L(ORX(2)) S:$L(ORX(3))>ORM(1,2) ORM(1,2)=$L(ORX(3)) ;Get larger of 2 stacked columns
 ... I $L(ORX(2))>$L(ORX(3)) S:$L(ORX(2))>ORM(1,2) ORM(1,2)=$L(ORX(2))
 ... F I=5:1:8 I $L(ORX(I))>ORM(2,I) S ORM(2,I)=$L(ORX(I)) ;Expand 2nd Row column width to fit data
 . D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(0,.CCNT,"AVAILABLE/ISSUED UNITS:",.CCNT)
 . I PARAM'=1 D
 .. D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 .. I 'ORSPLIT D
 ... F I=1:1:8 S ORM(I)=ORM(I)+1 ;Add 1 space between columns
 ... S C1=1,C2=C1+ORM(1),C3=C2+ORM(2),C4=C3+ORM(3),C5=C4+ORM(4),C6=C5+ORM(5),C7=C6+ORM(6),C8=C7+ORM(7)
 ... D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 ... S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(C1,.CCNT,"Date Assigned",.CCNT)_$$S^ORU4(C2,.CCNT,"Unit ID",.CCNT)_$$S^ORU4(C3,.CCNT,"Prod ID",.CCNT)_$$S^ORU4(C4,.CCNT,"Component",.CCNT)_$$S^ORU4(C5,.CCNT,"ABO/Rh",.CCNT)
 ... S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(C6,.CCNT,"Exp. Date",.CCNT)_$$S^ORU4(C7,.CCNT,$S(ORLOCAB:"Locale",1:"Location"),.CCNT)_$$S^ORU4(C8,.CCNT,$S($D(ORPRTING):"Div #",1:"Division"),.CCNT)
 ... D LN
 ... S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(C1,.CCNT,"-------------",.CCNT)_$$S^ORU4(C2,.CCNT,"-------",.CCNT)_$$S^ORU4(C3,.CCNT,"-------",.CCNT)_$$S^ORU4(C4,.CCNT,"---------",.CCNT)_$$S^ORU4(C5,.CCNT,"------",.CCNT)
 ... S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(C6,.CCNT,"---------",.CCNT)_$$S^ORU4(C7,.CCNT,$S(ORLOCAB:"------",1:"--------"),.CCNT)_$$S^ORU4(C8,.CCNT,$S($D(ORPRTING):"-----",1:"--------"),.CCNT)
 ... D LN
 .. I ORSPLIT D
 ... F I=1,2,4 S ORM(1,I)=ORM(1,I)+1 ;Add 1 spaces between columns 1st Row
 ... F I=5:1:8 S ORM(2,I)=ORM(2,I)+1 ;Add 1 spaces between columns 2nd Row
 ... S H1=1,H2=H1+ORM(1,1)+1,H3=H2+ORM(1,2),H4=H3+17,H5=H4+ORM(2,5),H6=H5+ORM(2,6),H7=H6+ORM(2,7),H8=H7+ORM(2,8)
 ... D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 ... S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(H1,.CCNT,"Date Assigned",.CCNT)_$$S^ORU4(H2,.CCNT,"Unit/Prod #",.CCNT)_$$S^ORU4(H3,.CCNT,"Component",.CCNT)_$$S^ORU4($S(CCNT<29:29,1:H4),.CCNT,"ABO/Rh",.CCNT)
 ... S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4($S(CCNT<46:46,1:H5),.CCNT,"Exp. Date",.CCNT)_$$S^ORU4($S(CCNT<57:57,1:H6),.CCNT,$S(ORLOCAB:"Locale",1:"Location"),.CCNT)
 ... S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4($S(CCNT<65:65,1:H7),.CCNT,$S($D(ORPRTING):"Div #",1:"Division"),.CCNT)
 ... D LN
 ... S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(H1,.CCNT,"---------------",.CCNT)_$$S^ORU4(H2,.CCNT,"-----------",.CCNT)_$$S^ORU4(H3,.CCNT,"---------",.CCNT)_$$S^ORU4($S(CCNT<29:29,1:H4),.CCNT,"------",.CCNT)
 ... S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4($S(CCNT<46:46,1:H5),.CCNT,"----------",.CCNT)_$$S^ORU4($S(CCNT<57:57,1:H6),.CCNT,$S(ORLOCAB:"------",1:"--------"),.CCNT)
 ... S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4($S(CCNT<65:65,1:H7),.CCNT,$S($D(ORPRTING):"-----",1:"--------"),.CCNT)
 ... D LN
 . S ORI=0 F  S ORI=$O(^TMP("ORUTMP",$J,ORI)) Q:'ORI  S ID=^(ORI) D
 .. I PARAM'=1 D
 ... I 'ORSPLIT D
 .... D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 .... S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(C1,.CCNT,$P(ID,"^"),.CCNT)_$$S^ORU4(C2,.CCNT,$P(ID,"^",2),.CCNT)_$$S^ORU4(C3,.CCNT,$P(ID,"^",3),.CCNT)_$$S^ORU4(C4,.CCNT,$P(ID,"^",4),.CCNT)_$$S^ORU4(C5,.CCNT,$P(ID,"^",5),.CCNT)
 .... S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(C6,.CCNT,$P(ID,"^",6),.CCNT)_$$S^ORU4(C7,.CCNT,$P(ID,"^",7),.CCNT)_$$S^ORU4(C8,.CCNT,$P(ID,"^",8),.CCNT)
 ... I ORSPLIT D
 .... D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 .... S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(H1,.CCNT,$P(ID,"^"),.CCNT)_$$S^ORU4(H2,.CCNT,$P(ID,"^",2),.CCNT)_$$S^ORU4(H3,.CCNT,$P(ID,"^",4),.CCNT)
 .... D LN
 .... S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(H1,.CCNT,"",.CCNT)_$$S^ORU4(H2,.CCNT,$P(ID,"^",3),.CCNT)_$$S^ORU4(H3,.CCNT,"",.CCNT)_$$S^ORU4($S(CCNT<29:29,1:H4),.CCNT,$P(ID,"^",5),.CCNT)
 .... S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4($S(CCNT<46:46,1:H5),.CCNT,$P(ID,"^",6),.CCNT)_$$S^ORU4($S(CCNT<57:57,1:H6),.CCNT,$P(ID,"^",7),.CCNT)_$$S^ORU4($S(CCNT<65:65,1:H7),.CCNT,$P(ID,"^",8),.CCNT)
 .... D LN
 .. I PARAM=1 D
 ... D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 ... D LN S ^TMP("ORLRC",$J,GCNT,0)=" Date/Time Assigned: "_$$S^ORU4(1,.CCNT,$P(ID,"^",1),.CCNT)
 ... D LN S ^TMP("ORLRC",$J,GCNT,0)=" Unit ID           : "_$$S^ORU4(1,.CCNT,$P(ID,"^",2),.CCNT)
 ... D LN S ^TMP("ORLRC",$J,GCNT,0)=" Product ID        : "_$$S^ORU4(1,.CCNT,$P(ID,"^",3),.CCNT)
 ... D LN S ^TMP("ORLRC",$J,GCNT,0)=" Component         : "_$$S^ORU4(1,.CCNT,$P(ID,"^",4),.CCNT)
 ... D LN S ^TMP("ORLRC",$J,GCNT,0)=" ABO/Rh            : "_$$S^ORU4(1,.CCNT,$P(ID,"^",5),.CCNT)
 ... D LN S ^TMP("ORLRC",$J,GCNT,0)=" Expiration Date   : "_$$S^ORU4(1,.CCNT,$P(ID,"^",6),.CCNT)
 ... D LN S ^TMP("ORLRC",$J,GCNT,0)=" Location          : "_$$S^ORU4(1,.CCNT,$P(ID,"^",7),.CCNT)
 ... D LN S ^TMP("ORLRC",$J,GCNT,0)=" Division          : "_$$S^ORU4(1,.CCNT,$P(ID,"^",8),.CCNT)
 D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 K ^TMP("LRB",$J),^TMP("ORUTMP",$J)
 ;Specimen Tests
 D SPEC^ORWLR4
 ;Component Requests
 N A,F,%DT,Y,SORT,CNT
 I $O(^TMP("VBDATA",$J,"COMPONENT REQUEST",0)) D
 . D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 . D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(0,.CCNT,"COMPONENT REQUESTS:",.CCNT)
 . D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 . S X="Component Type"
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,X,.CCNT)_$$S^ORU4(22,.CCNT,"Units",.CCNT)_$$S^ORU4(28,.CCNT,"Request date",.CCNT)_$$S^ORU4(48,.CCNT,"Date wanted",.CCNT)_$$S^ORU4(68,.CCNT,"Requestor",.CCNT)_$$S^ORU4(78,.CCNT,"By",.CCNT) D LN
 . S Y="--------------"
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,Y,.CCNT)_$$S^ORU4(22,.CCNT,"-----",.CCNT)_$$S^ORU4(28,.CCNT,"------------",.CCNT)_$$S^ORU4(48,.CCNT,"-----------",.CCNT)_$$S^ORU4(68,.CCNT,"---------",.CCNT)_$$S^ORU4(78,.CCNT,"--",.CCNT) D LN
 . S CNT=0,A=0 F  S A=$O(^TMP("VBDATA",$J,"COMPONENT REQUEST",A)) Q:'A  D
 .. S F=^TMP("VBDATA",$J,"COMPONENT REQUEST",A),T="",%DT="T",X=$P(F,"^",3),Y=-1
 .. I $L(X) D ^%DT
 .. I Y'=-1 S T=Y D T^ORWLR2
 .. S CNT=CNT+1,SORT=$S($P(F,"^",3):$P(F,"^",3),$P(F,"^",4):$P(F,"^",4),1:0),^TMP("ORTMP",$J,9999999-SORT,CNT,0)=F
 . S ORI=0 F  S ORI=$O(^TMP("ORTMP",$J,ORI)) Q:'ORI  S CNT=0 F  S CNT=$O(^TMP("ORTMP",$J,ORI,CNT)) Q:'CNT  I $D(^(CNT,0)) S F=^(0) D
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
 D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 D TRAN^ORWLR2
 Q
CAN(OROOT,COL) ;Take data from OROOT and build ^TMP("ORCAN",$J)
 N START,STOP,INPUT,OUTPUT,CCNT,CNT,WORD,ORX,NEX,CJ,CTR,ORX,ICNT
 D SPACE(OROOT)
 S CCNT=1,CNT=$S($O(^TMP("ORCAN",$J,0)):$O(^TMP("ORCAN",$J,99999999),-1),1:0)
 S OUTPUT="",ORK=3
 F  S ORK=$O(@OROOT@(ORK)) Q:'ORK  S X=@OROOT@(ORK) D
 . I ORK=4 S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,CFAG,.CCNT)
 . S INPUT=OUTPUT_X,START=$S($E(INPUT)=" ":2,1:1),OUTPUT="",STOP=$L(INPUT," ")
 . I $L(INPUT) F ICNT=START:1:STOP S WORD=$P(INPUT," ",ICNT) D
 .. I $L(WORD)<1,$L(OUTPUT) S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,OUTPUT,.CCNT),OUTPUT="" Q
 .. I ICNT=$L(INPUT," "),+$O(@OROOT@(ORK))<1,'$L($P(INPUT," ",ICNT+1)),$L(OUTPUT) D  Q
 ... S OUTPUT=$S($L(OUTPUT):OUTPUT_" "_WORD,1:WORD),CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,OUTPUT,.CCNT),OUTPUT=""
 .. I $L(WORD)>COL D  S OUTPUT="" Q
 ... I $L(WORD," ")=1 S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,WORD,.CCNT) Q
 ... F CJ=1:COL S OUTPUT=$E(WORD,CJ,CJ+99) Q:'$L(OUTPUT)  S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,OUTPUT,.CCNT)
 .. I $L(OUTPUT)+$L(WORD)>COL S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,OUTPUT,.CCNT),OUTPUT="" D  Q
 ... I $L(WORD)>COL D
 .... I $L(WORD," ")=1 S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,WORD,.CCNT) Q
 .... F CJ=1:COL S OUTPUT=$E(WORD,CJ,CJ+99) Q:'$L(OUTPUT)  S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,OUTPUT,.CCNT)
 .... S OUTPUT=""
 ... E  S OUTPUT=OUTPUT_$S($L(OUTPUT):" ",1:"")_WORD D
 .... I ICNT=$L(INPUT," ") D
 ..... I +$O(@OROOT@(ORK))<1 S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,OUTPUT,.CCNT),OUTPUT="" Q
 .. S OUTPUT=$S($L(OUTPUT):OUTPUT_" "_WORD,1:WORD)
 .. I $L(OUTPUT)>COL S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,OUTPUT,.CCNT),OUTPUT=""
 .. I ICNT=$L(INPUT," ") D
 ... I +$O(@OROOT@(ORK))<1 S CNT=CNT+1,^TMP("ORCAN",$J,CNT,0)=$$S^ORU4(1,.CCNT,OUTPUT,.CCNT),OUTPUT=""
 Q
SPACE(OROOT) ;Move Trailing spaces to next line
 N ORI,CTR,X
 S ORI=0
 F  S ORI=$O(@OROOT@(ORI)) Q:'ORI  D
 . S X=$RE(@OROOT@(ORI)),CTR=0 F  S:$E(X)=" " X=$E(X,2,999),CTR=CTR+1 Q:$E(X)'=" "  Q:'$L(X)  ;trailing spaces removed
 . I CTR S @OROOT@(ORI)=$RE(X) I $O(@OROOT@(ORI)) S NEX=$O(@OROOT@(ORI)),ORX(NEX)=$E("               ",1,CTR)_ORX(NEX) ;move spaces to front of next line
 Q
LN ;Increment counts
 S GCNT=GCNT+1,CCNT=1
 Q
TRIM(X) ;Trim leading and trailing spaces
 S X=$RE(X) F  S:$E(X)=" " X=$E(X,2,999) Q:$E(X)'=" "  Q:'$L(X)  ;trail
 S X=$RE(X) F  S:$E(X)=" " X=$E(X,2,999) Q:$E(X)'=" "  Q:'$L(X)  ;lead
 Q X
