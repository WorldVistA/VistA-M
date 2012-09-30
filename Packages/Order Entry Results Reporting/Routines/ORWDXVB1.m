ORWDXVB1 ;slc/dcm - Order dialog utilities for Blood Bank Cont.;3/2/04  09:31 ;12/7/05  17:20
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215,243,309,332**;Dec 17 1997;Build 44
 ;
PTINFO ;Format patient BB info
 N GCNT,CCNT,GIOSL,GIOM,I,TYPE,ORUA,VBERROR,ABFND,LINE1,LINE2,NOABO,NOPAT,TREQFND
 S (GCNT,NOPAT,NOABO)=0,CCNT=1,GIOSL=999999,GIOM=80
 S OROOT=$NA(^TMP("ORVBEC",$J))
 K ^TMP("ORVBEC",$J)
 ;
 I +$G(ORX("ERROR")) D ERROR^ORWDXVB2("^TMP(""ORVBEC"",$J)") Q
 ; Patient Demographics
 D LN
 I '$D(ORX("PATIENT")) D  Q
 . D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM),LN
 . S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(10,CCNT,"There is no previous record of this patient in VBECS.",.CCNT) Q
 ;
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"Name",.CCNT)_$$S^ORU4(27,CCNT,"SSN",.CCNT)_$$S^ORU4(42,CCNT,"ABO/Rh",.CCNT)
 D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"----",.CCNT)_$$S^ORU4(27,CCNT,"---",.CCNT)_$$S^ORU4(42,CCNT,"------",.CCNT) D
 . D LN
 . S X=ORX("PATIENT"),^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,$P(X,"^",3)_", "_$P(X,"^",2),.CCNT)_$$S^ORU4(27,CCNT,$P(X,"^",4),.CCNT)
 . I $P(ORX("ABORH"),"^")']"" S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(42,CCNT,"unknown",.CCNT) Q
 . S X=ORX("ABORH"),^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(42,CCNT,$$STRIP^XLFSTR($P(X,"^")," ")_" "_$S($$STRIP^XLFSTR($P(X,"^",2)," ")="P":"Pos",$$STRIP^XLFSTR($P(X,"^",2)," ")="N":"Neg",1:"unknown"),.CCNT) Q
 D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM),LN
 ;
 ; Available Specimens
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"Lab Specimen ID",.CCNT)_$$S^ORU4(27,CCNT,"Expiration Date",.CCNT)
 D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"----------------------",.CCNT)_$$S^ORU4(27,CCNT,"---------------",.CCNT) D
 . I '$D(ORX("SPECIMEN")) D LN S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT," none",.CCNT) Q
 . D LN
 . S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,$P(ORX("SPECIMEN"),"^",2),.CCNT)_$$S^ORU4(27,CCNT,$$DATETIME^ORCHTAB($P(ORX("SPECIMEN"),"^")),.CCNT) Q
 D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM),LN
 D UNITS
 ; Antibodies Identified section
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"Antibodies Identified",.CCNT)
 D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"---------------------",.CCNT) D
 . I '$O(ORX("ABHIS",0)) D LN S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT," none",.CCNT) Q
 . D LN
 . S ABFND=0
 . S I=0 F  S I=$O(ORX("ABHIS",I)) Q:I<1  D
 .. S X=ORX("ABHIS",I)
 .. I ABFND S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(2,CCNT,", "_$P(X,"^"),.CCNT) Q
 .. S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,$P(X,"^"),.CCNT),ABFND=1
 D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM),LN
 ;
 ; Transfusion Requirements section
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"Transfusion Requirements",.CCNT)
 D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"------------------------",.CCNT) D
 . I '$O(ORX("TRREQ",0)) D LN S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT," none",.CCNT) Q
 . D LN
 . S TREQFND=0
 . S I=0 F  S I=$O(ORX("TRREQ",I)) Q:I<1  D
 .. S X=ORX("TRREQ",I)
 .. I TREQFND S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(2,CCNT,", "_X,.CCNT) Q
 .. S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,X,.CCNT),TREQFND=1
 D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM),LN
 ;
 ; Transfusion Reactions section
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"Transfusion Reactions",.CCNT)_$$S^ORU4(27,CCNT,"Date/Time",.CCNT)
 D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"---------------------",.CCNT)_$$S^ORU4(27,CCNT,"---------",.CCNT) D
 . I '$O(ORX("TRHX",0)) D LN S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT," none",.CCNT) Q
 . S I=0 F  S I=$O(ORX("TRHX",I)) Q:I<1  D
 .. D LN
 .. S X=ORX("TRHX",I),^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,$P(X,"^"),.CCNT)_$$S^ORU4(27,CCNT,$$DATETIME($P(X,"^",2)),.CCNT)
 D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM),LN
 ;
 Q
UNITS ; New Units section
 N INDEX,UNT,ORY,I,CNT,J,K,L,M,X,T,ORASSDT,OREXPDT,ORI,ID,PARAM,ORLOCAB
 S CNT=0,PARAM=+$$GET^XPAR("DIV^SYS^PKG","OR VBECS AVAIL UNITS FORMAT"),ORLOCAB=0
 I +$$GET^XPAR("DIV^SYS^PKG","OR VBECS LOC ABBREV BB REPORT"),PARAM'=1 S ORLOCAB=1 ;Location Abbreviation flag
 K ^TMP("ORUTMP",$J)
 F INDEX="A","D","C","S" I $O(ORX("UNIT",INDEX,0)) D  ; A:Autologous D:Directed C:Crossmatched A:Assigned
 . S I=0 F  S I=$O(ORX("UNIT",INDEX,I)) Q:I<1  D
 .. S X=ORX("UNIT",INDEX,I),CNT=CNT+1,ORY("~"_$P(X,"^"),"~"_$P(X,"^",2),"~"_INDEX,"~"_$P(X,"^",4),CNT)=X
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"Units Available",.CCNT)
 D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(1,CCNT,"---------------",.CCNT)
 D LN
 ;ORM(i)=Minimum column width
 D AVUNIT^VBECA4(DFN,"LRB") ;New Improved Format
 I $O(^TMP("LRB",$J,0)) D
 . K ^TMP("ORUTMP",$J)
 . N ORI,ORL,ORDIV,ORASSDT,ORX,X,ORCNT,ORM,I,C1,C2,C3,C4,C5,C6,C7,C8,Y
 . S ORM(1)=13,ORM(2)=7,ORM(3)=7,ORM(4)=9,ORM(5)=6,ORM(6)=9,ORM(7)=$S(ORLOCAB:6,1:8),ORM(8)=8
 . S (ORCNT,ORI)=0 F  S ORI=$O(^TMP("LRB",$J,ORI)) Q:ORI<1  S ID=^(ORI) D
 .. S ORX(1)=$$FMTE^XLFDT(9999999-ORI,"5M") ;Assigned Date/Time
 .. S ORX(2)=$P(ID,"^",3) ; Unit ID
 .. S ORX(3)=$P(ID,"^",11) ; Product ID
 .. S ORX(4)=$P(ID,"^",4) ; Component
 .. S X=$S($P(ID,"^",7)="P":"Pos",$P(ID,"^",7)="N":"Neg",1:$P(ID,"^",7)) S ORX(5)=$P(ID,"^",6)_" "_X ;ABO/Rh
 .. S ORX(6)=$P(ID,"^",2) ;Expiration Date
 .. S ORX(7)=$P(ID,"^",10)
 .. I ORLOCAB D
 ... S X=ORX(7)
 ... I $L(X) S Y=$O(^SC("B",X,0)) I Y S X=$S($L($P($G(^SC(Y,0)),"^",2)):$P(^(0),"^",2),1:$E(X,1,7)) S ORX(7)=X ;Location
 ... E  S ORX(7)=$E(X,1,7)
 .. S ORX(8)=$P(ID,"^",9) ;Division
 .. S ORCNT=ORCNT+1,^TMP("ORUTMP",$J,ORCNT)=ORX(1)_"^"_ORX(2)_"^"_ORX(3)_"^"_ORX(4)_"^"_ORX(5)_"^"_ORX(6)_"^"_ORX(7)_"^"_ORX(8)
 .. F I=1:1:8 I $L(ORX(I))>ORM(I) S ORM(I)=$L(ORX(I)) ;Expand column width to fit data size
 . I PARAM'=1 D
 .. F I=1:1:8 S ORM(I)=ORM(I)+1 ;Add 1 space between columns
 .. S C1=2,C2=C1+ORM(1),C3=C2+ORM(2),C4=C3+ORM(3),C5=C4+ORM(4),C6=C5+ORM(5),C7=C6+ORM(6),C8=C7+ORM(7)
 .. D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM)
 .. S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(C1,.CCNT,"Date Assigned",.CCNT)_$$S^ORU4(C2,.CCNT,"Unit ID",.CCNT)_$$S^ORU4(C3,.CCNT,"Prod ID",.CCNT)_$$S^ORU4(C4,.CCNT,"Component",.CCNT)_$$S^ORU4(C5,.CCNT,"ABO/Rh",.CCNT)
 .. S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(C6,.CCNT,"Exp. Date",.CCNT)_$$S^ORU4(C7,.CCNT,$S(ORLOCAB:"Locale",1:"Location"),.CCNT)_$$S^ORU4(C8,.CCNT,"Division",.CCNT)
 .. D LN
 .. S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(C1,.CCNT,"-------------",.CCNT)_$$S^ORU4(C2,.CCNT,"-------",.CCNT)_$$S^ORU4(C3,.CCNT,"-------",.CCNT)_$$S^ORU4(C4,.CCNT,"---------",.CCNT)_$$S^ORU4(C5,.CCNT,"------",.CCNT)
 .. S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(C6,.CCNT,"---------",.CCNT)_$$S^ORU4(C7,.CCNT,$S(ORLOCAB:"------",1:"--------"),.CCNT)_$$S^ORU4(C8,.CCNT,"--------",.CCNT)
 .. D LN
 . S ORI=0 F  S ORI=$O(^TMP("ORUTMP",$J,ORI)) Q:'ORI  S ID=^(ORI) D
 .. I PARAM'=1 D
 ... D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM)
 ... S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(C1,.CCNT,$P(ID,"^"),.CCNT)_$$S^ORU4(C2,.CCNT,$P(ID,"^",2),.CCNT)_$$S^ORU4(C3,.CCNT,$P(ID,"^",3),.CCNT)_$$S^ORU4(C4,.CCNT,$P(ID,"^",4),.CCNT)_$$S^ORU4(C5,.CCNT,$P(ID,"^",5),.CCNT)
 ... S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(C6,.CCNT,$P(ID,"^",6),.CCNT)_$$S^ORU4(C7,.CCNT,$P(ID,"^",7),.CCNT)_$$S^ORU4(C8,.CCNT,$P(ID,"^",8),.CCNT)
 .. I PARAM=1 D
 ... D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM)
 ... D LN S ^TMP("ORVBEC",$J,GCNT,0)=" Date/Time Assigned: "_$$S^ORU4(1,.CCNT,$P(ID,"^",1),.CCNT)
 ... D LN S ^TMP("ORVBEC",$J,GCNT,0)=" Unit ID           : "_$$S^ORU4(1,.CCNT,$P(ID,"^",2),.CCNT)
 ... D LN S ^TMP("ORVBEC",$J,GCNT,0)=" Product ID        : "_$$S^ORU4(1,.CCNT,$P(ID,"^",3),.CCNT)
 ... D LN S ^TMP("ORVBEC",$J,GCNT,0)=" Component         : "_$$S^ORU4(1,.CCNT,$P(ID,"^",4),.CCNT)
 ... D LN S ^TMP("ORVBEC",$J,GCNT,0)=" ABO/Rh            : "_$$S^ORU4(1,.CCNT,$P(ID,"^",5),.CCNT)
 ... D LN S ^TMP("ORVBEC",$J,GCNT,0)=" Expiration Date   : "_$$S^ORU4(1,.CCNT,$P(ID,"^",6),.CCNT)
 ... D LN S ^TMP("ORVBEC",$J,GCNT,0)=" Location          : "_$$S^ORU4(1,.CCNT,$P(ID,"^",7),.CCNT)
 ... D LN S ^TMP("ORVBEC",$J,GCNT,0)=" Division          : "_$$S^ORU4(1,.CCNT,$P(ID,"^",8),.CCNT)
 D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM),LN
 K ^TMP("LRB",$J),^TMP("ORUTMP",$J)
 Q
LN ;Increment counts
 S GCNT=GCNT+1,CCNT=1
 Q
DATETIME(X) ; -- Return external form of YYYYMMDDHHNNSS date
 N Y
 S Y=$$HL7TFM^XLFDT(X),Y=$$DATETIME^ORCHTAB(Y)
 Q Y
