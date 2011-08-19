ORWLR2 ; slc/dcm -  VBEC Blood Bank Report ;2/11/08  11:05
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**172,212,309**;Dec 17, 1997;Build 26
 ;from ORWLR1 - Re-write of ^LR7OSBR1
EN ;
 N %DT,A,B,C,CMT,H,ID,J,ORI,T,X,X0,Y,ORPARENT,ORRY
 D H,RPT^ORWLR3
 Q
T ;Date/time format
 S T=$TR($$FMTE^XLFDT(T,"M"),"@"," ")
 Q
CX ;Crossmatch
 N A,CNT,F,LOCAT
 I '$O(^TMP("BBD",$J,"CROSSMATCH",0)) D  Q
 . D LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(1,.CCNT,"No UNITS assigned/xmatched",.CCNT)
 . D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(6,.CCNT,"Unit assigned/xmatched:",.CCNT)_$$S^ORU4(46,.CCNT,"Exp date",.CCNT)_$$S^ORU4(64,.CCNT,"Loc",.CCNT)
 S (CNT,A)=0 F  S A=$O(^TMP("BBD",$J,"CROSSMATCH",A)) Q:'A  D
 . S F=^TMP("BBD",$J,"CROSSMATCH",A),CNT=CNT+1,LOCAT=$S($L($P(F,"^",7)):$P(F,"^",7),1:"BB-"_$P(F,"^",6))
 . D LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(1,.CCNT,$J(CNT,2)_")",.CCNT)_$$S^ORU4(6,.CCNT,$P(F,"^"),.CCNT)_$$S^ORU4(17,.CCNT,$E($P(F,"^",2),1,19),.CCNT)_$$S^ORU4(38,.CCNT,$P(F,"^",3)_" "_$E($P(F,"^",4),1,3),.CCNT)
 . S ^(0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(45,.CCNT,$P(F,"^",5),.CCNT)_$$S^ORU4(64,.CCNT,LOCAT,.CCNT)
 D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM)
 Q
C ;Component Request
 N %DT,A,F,T,X,Y
 I '$O(^TMP("BBD",$J,"COMPONENT REQUEST",0)) D  Q
 . D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(1,.CCNT,"No component requests",.CCNT)
 D LN S X="Component requests"
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(1,.CCNT,X,.CCNT)_$$S^ORU4(25,.CCNT,"Units",.CCNT)_$$S^ORU4(31,.CCNT,"Request date",.CCNT)_$$S^ORU4(52,.CCNT,"Date wanted",.CCNT)_$$S^ORU4(68,.CCNT,"Requestor",.CCNT)_$$S^ORU4(77,.CCNT,"By",.CCNT)
 S A=0 F  S A=$O(^TMP("BBD",$J,"COMPONENT REQUEST",A)) Q:'A  D
 . S F=^TMP("BBD",$J,"COMPONENT REQUEST",A),T="",%DT="T",X=$P(F,"^",3),Y=-1
 . I $L(X) D ^%DT
 . I Y'=-1 S T=Y D T
 . D LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(1,.CCNT,$E($P(F,"^"),1,25),.CCNT)_$$S^ORU4(25,.CCNT,$J($P(F,"^",2),3),.CCNT)_$$S^ORU4(31,.CCNT,T,.CCNT)
 . S T="",%DT="T",X=$P(F,"^",4),Y=-1
 . I $L(X) D ^%DT
 . I Y'=-1 S T=Y D T
 . S X=$S($P(F,"^",6):$P(F,"^",6)_",",1:""),X=$S($L(X):$$GET1^DIQ(200,X,1),1:$P(F,"^",6))
 . S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(52,.CCNT,T,.CCNT)_$$S^ORU4(68,.CCNT,$E($P(F,"^",5),1,10),.CCNT)_$$S^ORU4(77,.CCNT,X,.CCNT)
 Q
TRAN ;Transfusion Data
 K ^TMP("TRAN",$J),^TMP("ZTRAN",$J)
 D TRAN^VBECA4(DFN,"TRAN")
 ;^TMP("TRAN",$J,InverseDate)="Date^Number of Units\Product Type"
 ;^TMP("TRAN",$J,"Product Type")="Product Type Print Name"
 Q:'$O(^TMP("TRAN",$J,0))
 N ID,GMR,GMA,TD,C,BPN,GMI,COMP,COMPSEQ
 D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 S X="Transfused Units ",^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(1,.CCNT,X,.CCNT),ID=0 D LN
 ;
 S CNT=0 F ID="RBC","FFP","PLT","CRY","PLA","SER","GRA","WB" S CNT=CNT+1,ORAY(ID)=CNT
 S ID=0 F  S ID=$O(^TMP("TRAN",$J,ID)) Q:'ID  S GMR=^(ID),COMP=$P(GMR,"^",2),COMP=$P(COMP,"\",2),COMP=$E($P(COMP,";"),1,3),COMPSEQ=$S($D(ORAY(COMP)):ORAY(COMP),1:99) D
 . I '$D(^TMP("ZTRAN",$J,$P(ID,"."),COMPSEQ)) S ^TMP("ZTRAN",$J,$P(ID,"."),COMPSEQ)=GMR_"^"_1 Q
 . S CNT=$P(^TMP("ZTRAN",$J,$P(ID,"."),COMPSEQ),"^",3),$P(^(COMPSEQ),"^",3)=CNT+1
 I $O(^TMP("ZTRAN",$J,0)) D
 . S ID=0
 . F  S ID=$O(^TMP("ZTRAN",$J,ID)) Q:'ID  S COMP="" F  S COMP=$O(^TMP("ZTRAN",$J,ID,COMP)) Q:COMP=""  S GMR=^(COMP) D
 .. I $P(GMR,"^",3) S $P(GMR,"^",2)=$P(GMR,"^",3)_"\"_$P($P(GMR,"^",2),"\",2)
 .. D PARSE^ORWLR1,WRT
 ;
 ;F  S ID=$O(^TMP("TRAN",$J,ID)) Q:'ID  S GMR=^(ID) D
 ;. D PARSE^ORWLR1,WRT
 I $O(^TMP("TRAN",$J,"A"))'="" D
 . D LN
 . S X="  Blood Product Key: ",^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(1,.CCNT,X,.CCNT)
 S GMI="A",C=0
 F  S GMI=$O(^TMP("TRAN",$J,GMI)) Q:GMI=""  D
 . S X=GMI_" = "_$G(^TMP("TRAN",$J,GMI))
 . I C>0 D LN
 . S C=C+1,^TMP("ORLRC",$J,GCNT,0)=$G(^TMP("ORLRC",$J,GCNT,0))_$$S^ORU4(22,.CCNT,X,.CCNT)
 K ^TMP("TRAN",$J),^TMP("ZTRAN",$J)
 Q
WRT ;Transfusion Record for each day
 N GML,GMI1,GMI2,GMM,GMJ,CL
 S GMM=$S(BPN#4:1,1:0),GML=BPN\4+GMM D LN
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,TD,.CCNT)
 F GMI1=1:1:GML D
 . F GMI2=1:1:($S((GMI1=GML)&(BPN#4):BPN#4,1:4)) D
 .. S GMJ=((GMI1-1)*4)+GMI2,CL=(((GMI2-1)*15)+14)
 .. S ^TMP("ORLRC",$J,GCNT,0)=$G(^TMP("ORLRC",$J,GCNT,0))_$$S^ORU4(CL,.CCNT,GMA(GMJ),.CCNT)
 .. I $S(GMI2#4=0:1,GMI2=BPN:1,GMI2+(4*(GMI1-1))=BPN:1,1:0) D LN
 Q
H ;Header
 N X D LN
 S X=GIOM/2-(10/2+5),^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(X,.CCNT,"---- BLOOD BANK ----",.CCNT)
 Q:$G(ORABORH)=-1  Q:$G(ORABORH)=""
 D LN
 S X=$E(ORABORH,$L(ORABORH)),X=$S(X="P":"Pos",X="N":"Neg",1:X),ORABORH=$E(ORABORH,1,($L(ORABORH)-1))_X
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(1,.CCNT,"ABO Rh: "_ORABORH,.CCNT)
 Q
ERRH ;Error Header
 N X D LN
 S X=GIOM/2-(10/2+5),^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(X,.CCNT,"---- BLOOD BANK REPORT IS UNAVAILABLE----",.CCNT)
 Q
AHG ;AHG Data
 D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(30,.CCNT,"|---",.CCNT)_$$S^ORU4(39,.CCNT,"AHG(direct)",.CCNT)_$$S^ORU4(55,.CCNT,"---|",.CCNT)_$$S^ORU4(62,.CCNT,"|-AHG(indirect)-|",.CCNT)
 D LN
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(4,.CCNT,"Date/time",.CCNT)_$$S^ORU4(20,.CCNT,"ABO",.CCNT)_$$S^ORU4(24,.CCNT,"Rh",.CCNT)_$$S^ORU4(30,.CCNT,"POLY",.CCNT)_$$S^ORU4(35,.CCNT,"IgG",.CCNT)_$$S^ORU4(40,.CCNT,"C3",.CCNT)
 S ^(0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(45,.CCNT,"Interpretation",.CCNT)_$$S^ORU4(62,.CCNT,"(Antibody screen)",.CCNT)
 D LN
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(4,.CCNT,"---------",.CCNT)_$$S^ORU4(20,.CCNT,"---",.CCNT)_$$S^ORU4(24,.CCNT,"--",.CCNT)_$$S^ORU4(30,.CCNT,"----",.CCNT)_$$S^ORU4(35,.CCNT,"---",.CCNT)
 S ^(0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4(40,.CCNT,"---",.CCNT)_$$S^ORU4(45,.CCNT,"--------------",.CCNT)_$$S^ORU4(62,.CCNT,"-----------------",.CCNT)
 Q
LN ;Increment counts
 S GCNT=GCNT+1,CCNT=1
 Q
