ORWLR4 ; slc/dcm - VBEC Blood Bank Report cont. ;1/15/09  06:56
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**309**;Dec 17, 1997;Build 26
SPEC ;Specimen Tests (cont.) from ORWLR3
 ;D VERT,HORZ ;Format could be a parameter except that it would make RDV inconsistent between sites.
 D HORZ
 Q
VERT ;Vertical display of results
 K ^TMP("ORTMP",$J),^TMP("ORCOM",$J)
 I $O(^TMP("VBDATA",$J,"SPECIMEN",0)) D
 . D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(0,.CCNT,"DIAGNOSTIC TESTS:",.CCNT) D LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,"Test Name",.CCNT)_$$S^ORU4(35,.CCNT,"Result",.CCNT)_$$S^ORU4(55,.CCNT,"Date/Time",.CCNT)_$$S^ORU4(75,.CCNT,"Division",.CCNT) D LN
 . S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,"---------",.CCNT)_$$S^ORU4(35,.CCNT,"------",.CCNT)_$$S^ORU4(55,.CCNT,"---------",.CCNT)_$$S^ORU4(75,.CCNT,"--------",.CCNT) D LN
 . K ^TMP("ORTMP",$J)
 . N ORI,ORJ,TST,ORT,CI,CJ,CX,CY,CZ,BUMP,CNUM
 . S ORI="",CNUM=0
 . F  S ORI=$O(^TMP("VBDATA",$J,"SPECIMEN",ORI),-1) Q:ORI=""  S ID=^(ORI) I $L($P(ID,"^",8)) D
 .. S X=$P(ID,"^",5),TST=$S($E(X,1,3)="ABO":"a_",$E(X,1,3)="Rh ":"b_",1:"z_"),^TMP("ORTMP",$J,(9999999-$P(ID,"^",8)),TST,ORI)=ID
 . S ORJ="" F  S ORJ=$O(^TMP("ORTMP",$J,ORJ)) Q:ORJ=""  S ORT="" F  S ORT=$O(^TMP("ORTMP",$J,ORJ,ORT)) Q:ORT=""  S ORI="" F  S ORI=$O(^TMP("ORTMP",$J,ORJ,ORT,ORI)) Q:ORI=""  D
 .. S CFAG="",ID=^TMP("VBDATA",$J,"SPECIMEN",ORI) ; ID=CPRS Order#^Division^Tech ID^Test Name^Print Name^Requestor ID^Result^Date/time
 .. I $O(^TMP("VBDATA",$J,"SPECIMEN",ORI,3))>3 D  ;Flag canned comment
 ... S CNTR=$S($O(^TMP("ORCOM",$J,99999999),-1):$O(^(99999999),-1),1:0),BUMP=0,OR4=$G(^TMP("VBDATA",$J,"SPECIMEN",ORI,4))
 ... S ORK="" F  S ORK=$O(^TMP("ORCOM",$J,ORK)) Q:'ORK  I ^(ORK)=OR4 S BUMP=ORK Q
 ... I BUMP S CNUM=BUMP,CFAG="("_CNUM_")*" Q
 ... I $L(OR4) S CNTR=CNTR+1,^TMP("ORCOM",$J,CNTR)=^TMP("VBDATA",$J,"SPECIMEN",ORI,4)
 ... S CNUM=CNUM+1,CFAG="("_CNUM_")*"
 .. Q:'$L($P(ID,"^",5))  S T=$P(ID,"^",8) D T^ORWLR2,LN
 .. S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,$P(ID,"^",5),.CCNT)_$$S^ORU4(35,.CCNT,$P(ID,"^",7),.CCNT)_$$S^ORU4(55,.CCNT,T,.CCNT)_$$S^ORU4(78,.CCNT,$P(ID,"^",2),.CCNT)_" "_CFAG
 .. S ORK="",CZ="" F  S ORK=$O(^TMP("VBDATA",$J,"SPECIMEN",ORI,ORK)) Q:'ORK  S CX=CZ_^(ORK) I $L(CX) D
 ... I ORK>3 D:'$G(BUMP) CAN^ORWLR3 Q
 ... S CZ="" F CI=1:1:$L(CX," ") S CY=$P(CX," ",CI) D
 .... I $L(CY)>80 D  S CZ="" Q
 ..... F CJ=1:80 S CZ=$E(CY,CJ,CJ+79) Q:'$L(CZ)  D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(4,.CCNT,CZ,.CCNT)
 .... I $L(CZ)+$L(CY)>80 D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(4,.CCNT,CZ,.CCNT),CZ="" D  Q
 ..... I $L(CY)>80 D
 ...... F CJ=1:80 S CZ=$E(CY,CJ,CJ+79) Q:'$L(CZ)  D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(4,.CCNT,CZ,.CCNT)
 ...... S CZ=""
 ..... E  S CZ=CY D
 ...... I CI=$L(CX," ") D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(4,.CCNT,CZ,.CCNT),CZ=""
 .... S CZ=$S($L(CZ):CZ_" "_CY,1:CY) I $L(CZ)>80 D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(4,.CCNT,CZ,.CCNT),CZ=""
 .... I CI=$L(CX," ") D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(4,.CCNT,CZ,.CCNT),CZ=""
 . I $O(^TMP("ORCAN",$J,0)) D
 .. D LN S ^TMP("ORLRC",$J,GCNT,0)=" " D LN S ^TMP("ORLRC",$J,GCNT,0)="   ----- STANDARD COMMENTS FOR DIAGNOSTIC TESTS ABOVE -----"
 .. S ORI="" F  S ORI=$O(^TMP("ORCAN",$J,ORI)) Q:'ORI  I $D(^(ORI,0)) D LN S X=^(0),^TMP("ORLRC",$J,GCNT,0)=X
 K ^TMP("ORTMP",$J),^TMP("ORCAN",$J)
 Q
HORZ ;Horizontal display of results
 Q:'$O(^TMP("VBDATA",$J,"SPECIMEN",0))
 K ^TMP("ORTMP",$J),^TMP("ORCOM",$J)
 N SCOL,ALPHA,ORI,ORJ,TST,ORT,CI,CJ,CX,CY,CZ,X,Y,ORY,ORAY,CNT,IDT,ID,ORX,ORCL,CNTR,BUMP,CNUM,ORTM,COM
 N C,I,ORCOL,ORCNT,ORINIT,ORNAM,ORNAME,C1,C2,C3,C4,C6,C8,LINE,FRONT
 K ^TMP("ORTMP",$J)
 F ORI=1:1 S X=$P($T(TXT+ORI),";",3) Q:X=""  S ORAY(X)=ORI
 S SCOL=24,ORI="",BUMP=0,CNUM="",CFAG="",ALPHA=0,ORTM=$S(ALPHA:96,1:0),C=1,ORINIT="5,5,5,6,7,6,7,6,7" ;Change Alpha to 1 for Alpha comment flag
 F I=3,3,3,5,5,4,5,5,5,0,8 S C=C+1,ORCOL(C)=I ;Initialize column size
 F  S ORI=$O(^TMP("VBDATA",$J,"SPECIMEN",ORI),-1) Q:ORI=""  S ID=^(ORI) I $L($P(ID,"^",8)),$L($P(ID,"^",5)) D
 . S IDT=9999999-$P(ID,"^",8)
 . I $P(ID,"^",7)="No Agglutination" S $P(ID,"^",7)="0" ; Translate result: "No Agg..." to 0 (zero)
 . I '$D(^TMP("ORTMP",$J,IDT)) S ^(IDT)=ORI
 . S $P(^TMP("ORTMP",$J,IDT),"^",12)=$P(ID,"^",2) ;*******
 . I $D(ORAY($P(ID,"^",5))) S $P(^TMP("ORTMP",$J,IDT),"^",ORAY($P(ID,"^",5))+1)=$P(ID,"^",7),^(IDT,"IFN",ORI)=$P(ID,"^",5)
 . ; ID=CPRS Order#^Division^Tech ID^Test Name^Print Name^Requestor ID^Result^Date/time
 . I $O(^TMP("VBDATA",$J,"SPECIMEN",ORI,3))>3 D  ;Flag canned comment
 .. S CNTR=$S($O(^TMP("ORCOM",$J,99999999),-1):$O(^(99999999),-1),1:0),BUMP=0,OR4=$G(^TMP("VBDATA",$J,"SPECIMEN",ORI,4))
 .. S ORK="" F  S ORK=$O(^TMP("ORCOM",$J,ORK)) Q:'ORK  I ^(ORK)=OR4 S BUMP=ORK Q
 .. I BUMP S CNUM=$S(ALPHA:$C(BUMP+96),1:BUMP),CFAG=$S($L(CFAG)&(CFAG'[CNUM):CFAG_",("_CNUM_")*",1:"("_CNUM_")*"),$P(^TMP("ORTMP",$J,IDT),"^",11)=CFAG Q
 .. I $L(OR4) S CNTR=CNTR+1,^TMP("ORCOM",$J,CNTR)=^TMP("VBDATA",$J,"SPECIMEN",ORI,4)
 .. S ORTM=ORTM+1,CNUM=$S(ALPHA:$C(ORTM),1:ORTM),CFAG=$S($L(CFAG)&(CFAG'[CNUM):CFAG_",("_CNUM_")*",1:"("_CNUM_")*"),$P(^TMP("ORTMP",$J,IDT),"^",11)=CFAG
 . S ORK="",CZ="" F  S ORK=$O(^TMP("VBDATA",$J,"SPECIMEN",ORI,ORK)) Q:'ORK  S CX=CZ_^(ORK) I $L(CX) D
 .. I ORK>3 D:'$G(BUMP) CAN^ORWLR3 Q
 S ORI="" F  S ORI=$O(^TMP("ORTMP",$J,ORI)) Q:ORI=""  S X=^(ORI) F I=2:1:10 S:$L($P(X,"^",I))>ORCOL(I) ORCOL(I)=($L($P(X,"^",I)))
 S ORCNT=SCOL+$L(CFAG),ORCL="",ORI="",$P(ORCL,";")=ORCNT+1
 F  S ORI=$O(ORCOL(ORI)) Q:ORI=""  S $P(ORCL,";",ORI)=(ORCOL(ORI)+ORCNT+2),ORCNT=$P(ORCL,";",ORI)
 D LINE^ORU4("^TMP(""ORLRC"",$J)",GIOM),LN
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(0,.CCNT,"DIAGNOSTIC TESTS:",.CCNT) D LN
 S C8=$$COL(5,10),C4=$$COL(2,4)
 S X="",$P(X," ",C4)="",I="",$P(I," ",24)="",FRONT=$E("            ",1,$L(CFAG))_I_X
 S I=C8-7\2,X="",$P(X,"-",I)="",Y="|"_X_" DAT "_X_"|",Y=FRONT_Y
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,Y,.CCNT) D LN
 S C1=$$COL(5,6),C2=$$COL(7,8),C3=$$COL(9,10),LINE=FRONT
 S I=C1-7/2,X="",$P(X,"-",I)="",Y="|"_X_" Poly "_X_"|  ",LINE=LINE_Y
 S I=C2-7/2,X="",$P(X,"-",I)="",Y="|"_X_" IgG "_X_"|  ",LINE=LINE_Y
 S I=C3-7/2,X="",$P(X,"-",I)="",Y="|"_X_" Comp "_X_"|",LINE=LINE_Y
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,LINE,.CCNT) D LN
 S I=1,X=$E("            ",1,$L(CFAG))_"  Date/Time           ",ORY=$E("            ",1,$L(CFAG))_"                     "
 F ORI="ABO","Rh ","ABS","Test","Intrp","Test ","Intrp","Test","Intrp","Division" S I=I+1,X=X_ORI_$E(ORY,1,ORCOL(I)-$L(ORI)+2)
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,X,.CCNT) D LN
 S I=1,X=$E("            ",1,$L(CFAG))_"  ------------------  "
 F ORI="---","---","---","----","-----","----","-----","----","-----","--------" S I=I+1,X=X_ORI_$E(ORY,1,ORCOL(I)-$L(ORI)+2)
 S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,X,.CCNT) D LN
 S ORJ=""
 F  S ORJ=$O(^TMP("ORTMP",$J,ORJ)) Q:ORJ=""  S ORX=^(ORJ) D
 . S COM=$P(ORX,"^",11) D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(2,.CCNT,COM_$S($L(COM):$E("       ",1,$L(COM)-5),1:"  "),.CCNT)
 . S T=9999999-ORJ D T^ORWLR2
 . S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4($L(COM)+3,.CCNT,T,.CCNT) ;,ORCL="28;31;36;41;59;77;95;113;131;149;156"
 . F ORT=1:1:9,11 S ^TMP("ORLRC",$J,GCNT,0)=^TMP("ORLRC",$J,GCNT,0)_$$S^ORU4($P(ORCL,";",ORT),.CCNT,$P($P(ORX,"^",2,99),"^",ORT),.CCNT)
 . S ORI="",ORNAME="" F  S ORI=$O(^TMP("ORTMP",$J,ORJ,"IFN",ORI)) Q:ORI=""  S ORNAM=^(ORI) D
 .. F I=1:1 S X=$P($T(TXT+I),";",3) Q:X=""  I X=ORNAM S ORNAME=$P($T(TXT+I),";",4) Q
 .. S ORK="",CZ="" F  S ORK=$O(^TMP("VBDATA",$J,"SPECIMEN",ORI,ORK)) Q:'ORK  S CX=CZ_^(ORK) I $L(CX) D
 ... I ORK>3 Q
 ... S CZ="" F CI=1:1:$L(CX," ") S CY=$P(CX," ",CI) D
 .... I $L(CY)>80 D  S CZ="" Q
 ..... F CJ=1:80 S CZ=$E(CY,CJ,CJ+79) Q:'$L(CZ)  D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(9,.CCNT,"Comment ("_ORNAME_"): "_CZ,.CCNT)
 .... I $L(CZ)+$L(CY)>80 D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(9,.CCNT,"Comment ("_ORNAME_"): "_CZ,.CCNT),CZ="" D  Q
 ..... I $L(CY)>80 D
 ...... F CJ=1:80 S CZ=$E(CY,CJ,CJ+79) Q:'$L(CZ)  D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(9,.CCNT,"Comment ("_ORNAME_"): "_CZ,.CCNT)
 ...... S CZ=""
 ..... E  S CZ=CY D
 ...... I CI=$L(CX," ") D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(9,.CCNT,"Comment ("_ORNAME_"): "_CZ,.CCNT),CZ=""
 .... S CZ=$S($L(CZ):CZ_" "_CY,1:CY) I $L(CZ)>80 D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(9,.CCNT,"Comment ("_ORNAME_"): "_CZ,.CCNT),CZ=""
 .... I CI=$L(CX," ") D LN S ^TMP("ORLRC",$J,GCNT,0)=$$S^ORU4(9,.CCNT,"Comment ("_ORNAME_"): "_CZ,.CCNT),CZ=""
 I $O(^TMP("ORCAN",$J,0)) D
 . D LN S ^TMP("ORLRC",$J,GCNT,0)=" " D LN S ^TMP("ORLRC",$J,GCNT,0)="   ----- STANDARD COMMENTS FOR DIAGNOSTIC TESTS ABOVE -----"
 . S ORI="" F  S ORI=$O(^TMP("ORCAN",$J,ORI)) Q:'ORI  I $D(^(ORI,0)) D LN S X=^(0),^TMP("ORLRC",$J,GCNT,0)=X
 K ^TMP("ORTMP",$J),^TMP("ORCAN",$J)
 Q
COL(A,B) ; Calculate Column Width
 ;A=Beginning column, B=Ending Column, COL=Width of column (depends on length of data)
 Q:'$G(A) 1 Q:'$G(B) 1
 N I,C
 S C=0 F I=A:1:B S C=C+ORCOL(I)+2
 Q C
LN ;Increment counts
 S GCNT=GCNT+1,CCNT=1
 Q
TXT ;Test Names passed in from VBECS API - Sequence of this list is significant
 ;;ABO Interp;ABO
 ;;Rh Interp;Rh
 ;;Antibody Screen Interp;ABS
 ;;DAT Poly AHG;DAT Poly
 ;;DAT Poly Interp;Poly INTRP
 ;;DAT IgG  AHG;DAT IgG
 ;;DAT IgG Interp;IgG INTRP
 ;;DAT Comp AHG;DAT Comp
 ;;DAT Comp Interp;Comp INTRP
 ;;
 Q
