ORWLR1 ; slc/dcm -  VBEC Blood Bank Report ;01/16/03  15:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**172,212,309**;Dec 17, 1997;Build 26
 ;Re-write of ^LR7OSBR
EN(DFN) ;Get Blood Bank Report
 Q:'$G(DFN)
 N GCNT,CCNT,GIOSL,GIOM,ORABORH,PATID,PATNAM,PATDOB,ORN
 S PATID="`"_DFN,PATNAM=$P(^DPT(DFN,0),"^"),PATDOB=$P(^(0),"^",3) ;Why PATNAM and PATDOB???
 K ^TMP("ORLRC",$J)
 S GCNT=0,CCNT=1,GIOSL=999999,GIOM=80
 S ORABORH=$$ABORH^VBECA1(PATID,PATNAM,PATDOB) ;Get ABO/RH
 S ORN(2.91)="DIRECT AHG TEST COMMENT",ORN(8)="ANTIBODY SCREEN COMMENT"
 S ORN(10.3)="ABO TESTING COMMENT",ORN(11.3)="RH TESTING COMMENT"
 D EN^ORWLR2
 Q
REPORT ;Blood Bank Report for M reports menu
 Q:'$G(DFN)
 N DIC,ID,ORDFN,ORY,PAGE,XQORNOD,ORDAYSBK
 S ORDFN=DFN,ID=2
 D BLR^ORWRP1(.ORY,.ORDFN,.ID,.ORALPHA,.OROMEGA,.ORDAYSBK,.REMOTE)
 Q:'$L(ORY)
 S PAGE=1
 D HEAD^ORWRPP1(ORDFN,PAGE,"PATIENT BLOOD BANK REPORT",$G(STATION))
 D HURL^ORWRPP1(.ORY,ORDFN,"PATIENT BLOOD BANK REPORT",,,1)
 Q
GETPAT(ERR) ;Setup Patient Variables
 N ORPNM
 S ERR=0
 D EN2^ORUDPA
 I 'ORVP S ERR=1 Q
 S PATID="`"_+ORVP,PATNAM=ORPNM,PATDOB=$P(^DPT(+ORVP,0),"^",3)
 D PAT^VBECA1A
 W !,LRDFN
 I $O(VBECERR(0)) D  S ERR=1 Q
 . S ERR=0 F  S ERR=$O(VBECERR(ERR)) Q:'ERR  W !?5," ERR:"_VBECERR(1)
 Q
TEST ;Test calls
 N ORVP,PATID,PATNAM,PATDOB,LRDFN,ERR,ABORH,ID,ID1,ID2,ARR,GMI,DI2,BPN,VBECERR,ERROR
 D GETPAT(.ERROR)
 I $G(ERROR) W !,"Error on Patient lookup" Q
 D ABORH,ABID,TRRX,DFN,CPRS,TRAN
 I $O(^TMP("VBDATA",$J,"CROSSMATCH",0)) D
 . W !,"Crossmatched Units: " S ID=0 F  S ID=$O(^TMP("VBDATA",$J,"CROSSMATCH",ID)) Q:'ID  W !?2,^(ID)
 K ^TMP("VBDATA",$J),^TMP("TRRX",$J),^TMP("TRAN",$J)
 Q
OEAPI ;Test call to OEAPI^VBECA3
 N DIV,ORSTN,ERROR,ORVB
 D GETPAT^ORWLR1(.ERROR)
 I $G(ERROR) W !,"Error on Patient lookup" Q
 S DIV=+$P($G(^SC(+$G(ORL),0)),U,15),ORSTN=$P($$SITE^VASITE(DT,DIV),U,3)
 D OEAPI^VBECA3(.ORVB,+ORVP,ORSTN)
 I $O(ORVB(0)) D
 . W !,"Array returned from OEAPI^VBECA3 API in ORVB():",!
 . ;ZW ORVB
 K ^TMP("OR",$J),^TMP("VBECRPC",$J),^TMP("VBECS_XML_RES",$J),^TMP("VBEC_OE_DATA",$J)
 Q
ABORH ;Test call to ABORH^VBECA1 for ABO/Rh - DBIA 3181
 N ERROR
 I '$G(ORVP) D GETPAT(.ERROR)
 I $G(ERROR) W !,"Error on Patient lookup" Q
 S ABORH=$$ABORH^VBECA1(PATID,PATNAM,PATDOB) W !,"ABO/RH: "_ABORH
 Q
ABID ;Test call to ABID^VBECA1 for Antibodies Identified - DBIA 3181, 3184
 N ID,ERROR,PARENT
 I '$G(ORVP) D GETPAT(.ERROR)
 I $G(ERROR) W !,"Error on Patient lookup" Q
 D ABID^VBECA1(PATID,PATNAM,PATDOB,.PARENT,.ARR) I $O(ARR("ABID",0)) D
 . W !,"Antibodies Identified: " S ID=0 F  S ID=$O(ARR("ABID",ID)) Q:'ID  W !?2,ARR("ABID",ID)
 Q
DFN ;Test call to DFN^VBECA3A - DBIA 3879
 N ID,ID1,ID2,ERROR
 K ^TMP("VBDATA",$J)
 I '$G(ORVP) D GETPAT(.ERROR)
 I $G(ERROR) W !,"Error on Patient lookup" Q
 D DFN^VBECA3A(DFN)
 I $O(^TMP("VBDATA",$J,"COMPONENT REQUEST",0)) D
 . W !,"Component request: " S ID=0 F  S ID=$O(^TMP("VBDATA",$J,"COMPONENT REQUEST",ID)) Q:'ID  W !?2,^(ID) D
 .. S ID1=0 F  S ID1=$O(^TMP("VBDATA",$J,"COMPONENT REQUEST",ID,ID1)) Q:'ID1  W !,"."_^(ID1)
 I $O(^TMP("VBDATA",$J,"SPECIMEN",0)) D
 . W !,"Specimen: " S ID=0 F  S ID=$O(^TMP("VBDATA",$J,"SPECIMEN",ID)) Q:'ID  W !?2,^(ID) D
 .. S ID1=0 F  S ID1=$O(^TMP("VBDATA",$J,"SPECIMEN",ID,ID1)) Q:'ID1  W:$D(^(ID1))#2 !,"."_^(ID1) D
 ... S ID2=0 F  S ID2=$O(^TMP("VBDATA",$J,"SPECIMEN",ID,ID1,ID2)) Q:'ID2  W:$D(^(ID2))#2 !,".."_^(ID2)
 I $O(^TMP("VBDATA",$J,"UNIT",0)) D
 . W !,"Available Units: "
 . S ID=0 F  S ID=$O(^TMP("VBDATA",$J,"UNIT",ID)) Q:'ID  W !?2,^(ID)
 Q
CPRS ;Test call to CPRS^VBECA3B - DBIA 3880
 N ID,ID1,ID2,ERROR
 K ^TMP("BBD",$J)
 I '$G(ORVP) D GETPAT(.ERROR)
 I $G(ERROR) W !,"Error on Patient lookup" Q
 D CPRS^VBECA3B
 I $O(^TMP("BBD",$J,"SPECIMEN",0)) D
 . W !,"Specimen: " S ID=0 F  S ID=$O(^TMP("BBD",$J,"SPECIMEN",ID)) Q:'ID  W !?2,^(ID) D
 .. S ID1=0 F  S ID1=$O(^TMP("BBD",$J,"SPECIMEN",ID,ID1)) Q:'ID1  W:$D(^(ID1))#2 !,"."_^(ID1) D
 ... S ID2=0 F  S ID2=$O(^TMP("BBD",$J,"SPECIMEN",ID,ID1,ID2)) Q:'ID2  W:$D(^(ID2))#2 !,".."_^(ID2)
 Q
TRAN ;Test call to TRAN^VBECA4 for Tranfused Units - DBIA 3176
 N BPN,ID,GMI,GMR,ERROR,CNT,ORAY,COMP,COMPSEQ,X
 K ^TMP("TRAN",$J),^TMP("ZTRAN",$J)
 I '$G(ORVP) D GETPAT(.ERROR)
 I $G(ERROR) W !,"Error on Patient lookup" Q
 D TRAN^VBECA4(+ORVP,"TRAN")
 ;^TMP("TRAN",$J,InverseDate)="Date^Number of Units\Product Type"
 ;^TMP("TRAN",$J,"Product Type")="Product Type Print Name"
 S CNT=0 F ID="RBC","FFP","PLT","CRY","PLA","SER","GRA","WB" S CNT=CNT+1,ORAY(ID)=CNT
 S ID=0 F  S ID=$O(^TMP("TRAN",$J,ID)) Q:'ID  S GMR=^(ID),COMP=$P(GMR,"^",2),COMP=$P(COMP,"\",2),COMP=$E($P(COMP,";"),1,3),COMPSEQ=$S($D(ORAY(COMP)):ORAY(COMP),1:99) D
 . I '$D(^TMP("ZTRAN",$J,$P(ID,"."),COMPSEQ)) S ^TMP("ZTRAN",$J,$P(ID,"."),COMPSEQ)=GMR_"^"_1 Q
 . S CNT=$P(^TMP("ZTRAN",$J,$P(ID,"."),COMPSEQ),"^",3),$P(^(COMPSEQ),"^",3)=CNT+1
 I $O(^TMP("ZTRAN",$J,0)) D
 . W !,"Sorted/grouped Transfused Units: ",! S ID=0
 . F  S ID=$O(^TMP("ZTRAN",$J,ID)) Q:'ID  S COMP="" F  S COMP=$O(^TMP("ZTRAN",$J,ID,COMP)) Q:COMP=""  S GMR=^(COMP) D
 .. I $P(GMR,"^",3) S $P(GMR,"^",2)=$P(GMR,"^",3)_"\"_$P($P(GMR,"^",2),"\",2)
 .. D PARSE,WRT
 I $O(^TMP("TRAN",$J,0)) D
 . W !,"Transfused Units (from VBECS API): ",! S ID=0
 . F  S ID=$O(^TMP("TRAN",$J,ID)) Q:'ID  S GMR=^(ID) D
 .. D PARSE,WRT
 . I $O(^TMP("TRAN",$J,"A"))'="" D
 .. W !," Blood Product Key: "
 . S GMI="A" F  S GMI=$O(^TMP("TRAN",$J,GMI)) Q:GMI=""  D
 .. W ?22,GMI," = ",$G(^TMP("TRAN",$J,GMI)),!
 Q
TRRX ;Test call to TRRX^VBECA1 for Transfusion Reactions - DBIA 3181, 3187
 N ARR,ID,ERROR,PARENT
 I '$G(ORVP) D GETPAT(.ERROR)
 I $G(ERROR) W !,"Error on Patient lookup" Q
 D TRRX^VBECA1(PATID,PATNAM,PATDOB,.PARENT,.ARR) I $O(ARR("TRRX",0)) D
 . W !,"Transfusion reactions: " S ID=0 F  S ID=$O(ARR("TRRX",ID)) Q:'ID  W !?2,ARR("TRRX",ID)
 Q
PARSE ;Parse Record
 N GMI,X
 S TD=$$FMTE^XLFDT(+GMR)
 S GMA(1)=$P(GMR,U,2),BPN=$L(GMA(1),";")
 I $P(GMA(1),";",BPN)="" S BPN=BPN-1
 F GMI=2:1:BPN S GMA(GMI)="("_$P($P(GMA(1),";",GMI),"\")_") "_$P($P(GMA(1),";",GMI),"\",2)
 S GMA(1)="("_$P($P(GMA(1),";",1),"\")_") "_$P($P(GMA(1),";",1),"\",2)
 Q
WRT ; Writes the Transfusion Record for each day
 N GML,GMI1,GMI2,GMM,GMJ
 S GMM=$S(BPN#4:1,1:0),GML=BPN\4+GMM
 W TD
 F GMI1=1:1:GML D
 . F GMI2=1:1:($S((GMI1=GML)&(BPN#4):BPN#4,1:4)) D
 .. S GMJ=((GMI1-1)*4)+GMI2
 .. W ?(((GMI2-1)*15)+13),GMA(GMJ)
 .. I $S(GMI2#4=0:1,GMI2=BPN:1,GMI2+(4*(GMI1-1))=BPN:1,1:0) W !
 Q
