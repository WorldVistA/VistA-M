ORWRP2 ; dcm/slc - Health Summary adhoc RPC's
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,109,212,309,332**Dec 17, 1997;;Build 44
BB ;Continuation of Blood Bank Report
 N DFN,ORY,ORSBHEAD,GCNT,GIOM
 S DFN=ORDFN,GCNT=0,GIOM=80
 K ^TMP("LRC",$J)
 S ROOT=$NA(^TMP("LRC",$J))
 D BLEG
 Q
BLEG ;Legacy VISTA Blood Bank Report
 S ORSBHEAD("BLOOD BANK")=""
 D EN^LR7OSUM(.ORY,DFN,,,,GIOM,.ORSBHEAD),TRAN
 I '$O(^TMP("LRC",$J,0)) S GCNT=GCNT+1,^TMP("LRC",$J,GCNT,0)="",GCNT=GCNT+1,^TMP("LRC",$J,GCNT,0)="No Blood Bank report available..."
 Q
COMP(ORY) ;Get ADHOC sub components (FILE 142.1)
 ;RPC => ORWRP2 HS COMPONENTS
 ;Y(i)=(1)I;IFN^(2)Component Name [Abb]^(3)Occ Limit^(4)Time Limit^(5)Header Name^
 ;     (6)Hosp Loc Disp^(7)ICD Text Disp^(8)Prov Narr Disp^(9)Summary Order
 D COMP^GMTSADH5(.ORY)
 Q
 ;
COMPABV(ORY) ;Get ADHOD sub components listed by Abbreviation
 N I,X,X1,X2,X3
 D COMP^GMTSADH5(.ORY)
 S I=0
 F  S I=$O(ORY(I)) Q:'I  S X=ORY(I) D
 . S X1=$P($P(X,"^",2),"["),X1=$E(X1,1,$L(X1)-1),X2=$P($P(X,"^",2),"[",2),X2=$E(X2,1,$L(X2)-1)
 . S X3=X2_"   - "_$P(X,"^",5)_" ",$P(ORY(I),"^",2)=X3
 Q
COMPDISP(ORY) ;Get ADHOD sub components listed by Display Name
 N I,X,X1,X2,X3
 D COMP^GMTSADH5(.ORY)
 S I=0
 F  S I=$O(ORY(I)) Q:'I  S X=ORY(I) D
 . S X1=$P($P(X,"^",2),"["),X1=$E(X1,1,$L(X1)-1),X2=$P($P(X,"^",2),"[",2),X2=$E(X2,1,$L(X2)-1)
 . S X3=$P(X,"^",5)_"   ["_X2_"]",$P(ORY(I),"^",2)=X3
 Q
COMPSUB(ORY,ORSUB) ;Get subitems from a predefined Adhoc component
 I '$L($T(COMPSUB^GMTSADH5)) Q
 D COMPSUB^GMTSADH5(.ORY,ORSUB)
 Q
 ;
SAVLKUP(OK,VAL) ;save Adhoc lookup selection
 N ORERR
 S OK=""
 D EN^XPAR(DUZ_";VA(200,","ORWRP ADHOC LOOKUP",1,VAL,.ORERR)
 I ORERR S OK=VAL_":"_ORERR
 Q
GETLKUP(ORY) ;Get Adhoc lookup selection
 S ORY=$$GET^XPAR("ALL","ORWRP ADHOC LOOKUP",1,"I")
 Q
FILES(ORY,ORCOMP) ;Get Files to select from for a component
 ;RPC => ORWRP2 HS COMP FILES
 D FILES^GMTSADH5(.ORY,ORCOMP)
 Q
 ;
FILESEL(OROOT,ORFILE,ORFROM,ORDIR) ;Get file entries for Combobox
 ;RPC => ORWRP2 HS FILE LOOKUP
 D FILESEL^GMTSADH5(.OROOT,ORFILE,ORFROM,ORDIR)
 Q
 ;
REPORT(OROOT,ORCOMPS,ORDFN) ;Build Report from array of Components passed in COMPS
 ;RPC => ORWRP2 HS REPORT TEXT
 ;ORCOMPS(i)=array of subcomponents chosen, value is pointer at ^GMT(142,DA(1),1,DA)
 Q:'$G(ORDFN)
 N GMTSEGC,GMTSEG,ORGMTSEG,ORSEGC,ORSEGI
 K ^TMP("ORDATA",$J)
 D REPORT^GMTSADH5(.ORGMTSEG,.ORSEGC,.ORSEGI,.ORCOMPS,.ORDFN)
 Q:'$O(ORGMTSEG(0))
 D START^ORWRP(80,"REPORT1^ORWRP2(.ORGMTSEG,.ORSEGC,.ORSEGI,ORDFN)")
 S OROOT=$NA(^TMP("ORDATA",$J,1))
 Q
REPORT1(GMTSEG,GMTSEGC,GMTSEGI,DFN) ;
 N GMTS,GMTS1,GMTS2,GMTSAGE,GMTSDOB,GMTSDTM,GMTSLO,GMTSLPG,GMTSPHDR,GMTSPNM,GMTSRB,GMTSSN,GMTSWRD
 N CNT,INC,ORVP,ROOT,SEX,VADM,VAERR,VAIN
 S ORVP=DFN
 D ADHOC^ORPRS13
 Q
 ;
SUBITEM(ORY,ORTEST) ;Get Subitems for a Test Panel
 ;RPC => ORWRP2 HS SUBITEMS
 D SUBITEM^GMTSADH5(.ORY,ORTEST)
 Q
PREPORT(OROOT,ORCOMPS,ORDFN) ;Build Report & Print
 ;Called from File|Print on Reports Tab after selecting ADHOC Health Summary
 ;COMPS(i)=array of subcomponents chosen, value is pointer at ^GMT(142,DA(1),1,DA)
 Q:'$G(ORDFN)
 N GMTSEGC,GMTSEG,ORGMTSEG,ORSEGC,ORSEGI
 D REPORT^GMTSADH5(.ORGMTSEG,.ORSEGC,.ORSEGI,.ORCOMPS,.ORDFN)
 Q:'$O(ORGMTSEG(0))
 M GMTSEG=ORGMTSEG,GMTSEGC=ORSEGC,GMTSEGI=ORSEGI
 N GMTS,GMTS1,GMTS2,GMTSAGE,GMTSDOB,GMTSDTM,GMTSLO,GMTSLPG,GMTSPHDR,GMTSPNM,GMTSRB,GMTSSN,GMTSWRD
 N CNT,INC,ORVP,ROOT,SEX,VADM,VAERR,VAIN
 S ORVP=ORDFN
 D ADHOC^ORPRS13
 Q
TRAN ;Get Transfused Units
 N LRDFN,IDT,CNTR,TR,PN,PRODUCT,IX,GMI,X,BPN
 S:'$D(GMTS1) GMTS1=6666666 S:'$D(GMTS2) GMTS2=9999999
 K ^TMP("LRT",$J)
 Q:'$D(^DPT(DFN,"LR"))  S LRDFN=+^DPT(DFN,"LR"),IDT=GMTS1-1
 I '$D(^LR(LRDFN)) Q
 S IDT=0 F  S IDT=$O(^LR(LRDFN,1.6,IDT)) Q:+IDT'>0  D
 . S TR=$G(^LR(LRDFN,1.6,IDT,0)) D SET
 S IDT=0 F  S IDT=$O(CNTR(IDT)) Q:+IDT'>0  D
 . S ^TMP("LRT",$J,IDT)=9999999-IDT_U,PN=0
 . F  S PN=$O(CNTR(IDT,PN)) Q:PN'>0  D
 .. S PRODUCT=$G(^LAB(66,+PN,0)),^TMP("LRT",$J,$P(PRODUCT,U,2))=$P(PRODUCT,U)
 .. S ^TMP("LRT",$J,IDT)=^TMP("LRT",$J,IDT)_CNTR(IDT,PN)_"\"_$P(PRODUCT,U,2)_";"
 Q:'$O(^TMP("LRT",$J,0))
 S GCNT=+$O(^TMP("LRC",$J,999999999),-1)
 D LINE,LN
 S ^TMP("LRC",$J,GCNT,0)=$$S(0,CCNT,"Transfused Units"),IX=""
 F  S IX=$O(^TMP("LRT",$J,IX)) Q:IX=""  D
 . S GMR=^TMP("LRT",$J,IX),TD=$$FMTE^XLFDT(+GMR)
 . Q:TD=0
 . S GMA(1)=$P(GMR,U,2),BPN=$L(GMA(1),";")
 . I $P(GMA(1),";",BPN)="" S BPN=BPN-1
 . F GMI=2:1:BPN S GMA(GMI)="("_$P($P(GMA(1),";",GMI),"\")_") "_$P($P(GMA(1),";",GMI),"\",2)
 . S GMA(1)="("_$P($P(GMA(1),";",1),"\")_") "_$P($P(GMA(1),";",1),"\",2)
 . D WRT
 D KEY
 K ^TMP("LRT",$J)
 Q
WRT ; Writes the Transfusion Record for each day
 N GML,GMI1,GMI2,GMM,GMJ,CL
 S GMM=$S(BPN#4:1,1:0),GML=BPN\4+GMM
 D LN S ^TMP("LRC",$J,GCNT,0)=$$S(2,.CCNT,TD)
 F GMI1=1:1:GML D
 . F GMI2=1:1:($S((GMI1=GML)&(BPN#4):BPN#4,1:4)) D
 .. S GMJ=((GMI1-1)*4)+GMI2,CL=(((GMI2-1)*15)+14)
 .. S ^TMP("LRC",$J,GCNT,0)=$G(^TMP("LRC",$J,GCNT,0))_$$S(CL,.CCNT,GMA(GMJ))
 .. I $S(GMI2#4=0:1,GMI2=BPN:1,GMI2+(4*(GMI1-1))=BPN:1,1:0) D LN
 Q
SET ; Save Appropriate Data
 N COMP,UNITS,TDT,ITDT
 S TDT=9999999-IDT,ITDT=9999999-$P(TDT,".")
 S UNITS=+$P(TR,U,7) S:UNITS'>0 UNITS=1
 S CNTR(ITDT,+$P(TR,U,2))=+$G(CNTR(ITDT,+$P(TR,U,2)))+UNITS
 Q
KEY ;
 I $O(^TMP("LRT",$J,"A"))'="" D
 . D LN
 . S ^TMP("LRC",$J,GCNT,0)=$$S(0,CCNT,"  Blood Product Key: ")
 S GMI="A" F  S GMI=$O(^TMP("LRT",$J,GMI)) Q:GMI=""  D
 . S ^TMP("LRC",$J,GCNT,0)=^TMP("LRC",$J,GCNT,0)_$$S(22,CCNT,GMI_" = "_$G(^TMP("LRT",$J,GMI)))
 . D LN
 . S ^TMP("LRC",$J,GCNT,0)=""
 Q
LN ;
 S GCNT=GCNT+1,CCNT=1
 Q
LINE ;Fill in the global with bank lines
 N X
 D LN
 S X="",$P(X," ",GIOM)="",^TMP("LRC",$J,GCNT,0)=X
 Q
S(X,Y,Z) ;Pad over
 ;X=Column #
 ;Y=Current length
 ;Z=Text
 ;SP=TEXT SENT
 ;CCNT=Line position after input text
 I '$D(Z) Q ""
 S SP=Z I X,Y,X>Y S SP=$E("                                ",1,X-Y)_Z
 S CCNT=$$INC(CCNT,SP)
 Q SP
INC(X,Y) ;Character position count
 ;X=Current count
 ;Y=Text
 S INC=X+$L(Y)
 Q INC
