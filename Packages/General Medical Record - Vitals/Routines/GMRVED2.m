GMRVED2 ;HIOFO/RM,YH,FT-VITAL SIGNS EDIT SHORT FORM ;11/15/04  10:30
 ;;5.0;GEN. MED. REC. - VITALS;**2**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10035 - ^DPT( references       (supported)
 ; #10061 - ^VADPT calls           (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ; #10104 - ^XLFSTR calls          (supported)
 ; 
EN1 ; SORT PATIENTS ON WARD
 K ^TMP($J)
WSA1 ; SET ^TMP($J, FOR SORT
 D DEM^VADPT,INP^VADPT S GMRRMBD=$S(VAIN(5)'="":VAIN(5),1:"  BLANK"),GMRNAM=$S(VADM(1)'="":VADM(1),1:"  BLANK") D KVAR^VADPT K VA
 S:$S("Aa"[GMREDB:1,$D(GMRROOM($P(GMRRMBD,"-"))):1,1:0) ^TMP($J,GMRRMBD,GMRNAM,DFN)=""
 S DFN=$O(^DPT("CN",GMRWARD(1),DFN))
 Q:DFN=""  G WSA1
EN2 ; BEGIN EDITING WARD VITALS
 I $O(^TMP($J,0))="" S GMROUT=1 Q
 W !,"Begin entering patient vitals." S GMRDT0=GMRVIDT
 S GMRRMBD="" F GMRI=0:0 S GMRRMBD=$O(^TMP($J,GMRRMBD)) Q:GMRRMBD=""!GMROUT  S GMRNAM="" F GMRI=0:0 S GMRNAM=$O(^TMP($J,GMRRMBD,GMRNAM)) Q:GMRNAM=""!GMROUT  F DFN=0:0 S DFN=$O(^TMP($J,GMRRMBD,GMRNAM,DFN)) Q:DFN'>0  D V1 Q:GMROUT
 W !,"Enter return to continue" R X:DTIME Q
V1 ;
 W !!,$S(GMRNAM'="  BLANK":GMRNAM,1:DFN),?$X+10,$S(GMRRMBD'="  BLANK":GMRRMBD,1:""),"  OK? YES// " R GMRX:DTIME
 I GMRX="^"!('$T) S GMROUT=1 Q
 S GMRX=$$UP^XLFSTR(GMRX) I ((GMRX="")!($E(GMRX)="Y")) K GMRTO S GDT=GMRVIDT D EN1^GMRVADM G:GMROUT&'$D(GMRTO) V2 D EN2^GMRVED3 G:GMROUT&'$D(GMRTO) V2 Q
 G:GMRX?1"N".E V2
 W !,"ANSWER YES OR NO" G V1
V2 ;
 W !!,"Do you wish to stop looping through names? YES//" R GMRX:DTIME
 S GMRX=$$UP^XLFSTR(GMRX) I (('$T)!(GMRX="")!($E(GMRX)="Y")!(GMRX="^")) S GMROUT=1 Q
 I GMRX?1"N".E S GMROUT=0 Q
 W !,"ANSWER YES OR NO" G V2
EN4 ; ENTRY FROM GMRVED0 TO ADD THE PATIENT DATA TO THE 120.5 FILE
 D NOW^%DTC S GMRDATE=%
 F GMRX=2:1:$L(GMRSTR(0),";")-1 S GMRVITY=$P(GMRSTR(0),";",GMRX) D
 . S GMRVIT=$S(GMRVITY="T":"TEMPERATURE",GMRVITY="P":"PULSE",GMRVITY="R":"RESPIRATION",GMRVITY="BP":"BLOOD PRESSURE",GMRVITY="HT":"HEIGHT",GMRVITY="CG":"CIRCUMFERENCE/GIRTH",1:"")
 . S:GMRVIT="" GMRVIT=$S(GMRVITY="WT":"WEIGHT",GMRVITY="CVP":"CENTRAL VENOUS PRESSURE",GMRVITY="PO2":"PULSE OXIMETRY",GMRVITY="PN":"PAIN",1:"")
 . D:$G(GMRDAT(GMRVITY))'=""&(GMRVIT'="") ADDNODE
 Q
ADDNODE ; add data to the 120.5 file
 N GMVDTDUN,GMVFDA,GMVIEN
 S GMVDTDUN=GMRVIDT
 S GMRVIT(1)=$O(^GMRD(120.51,"B",GMRVIT,0))
 S GMVDTDUN=$$CHKDT(GMRVIDT,GMRVIT(1))
 S GMVFDA(120.5,"+1,",.01)=GMVDTDUN ;Date/Time
 S GMVFDA(120.5,"+1,",.02)=DFN ;Patient
 S GMVFDA(120.5,"+1,",.03)=GMRVIT(1) ;Vital Type
 S GMVFDA(120.5,"+1,",.04)=GMRDATE ;Date Time entered
 S GMVFDA(120.5,"+1,",.05)=GMRVHLOC ;Hospital
 S GMVFDA(120.5,"+1,",.06)=DUZ ;Entered by (DUZ)
 S GMVFDA(120.5,"+1,",1.2)=GMRDAT(GMRVITY) ;Rate
 S GMVFDA(120.5,"+1,",1.4)=$G(GMRO2(GMRVITY)) ;Sup 02
 S GMVIEN=""
 D UPDATE^DIE("","GMVFDA","GMVIEN")
 ;file any qualifiers
 I $D(GMRSITE(GMRVITY))!$D(GMRINF(GMRVITY)) D
 .I $G(GMRSITE(GMRVITY))'="" D
 ..S GDATA=+$P(GMRSITE(GMRVITY),U,2)
 ..Q:'GDATA
 ..D ADDQUAL(GMVIEN(1)_"^"_GDATA)
 ..Q
 .I $D(GMRINF(GMRVITY)) D
 ..S I=0
 ..F  S I=$O(GMRINF(GMRVITY,I)) Q:I'>0  D
 ...S I(1)=""
 ...F  S I(1)=$O(GMRINF(GMRVITY,I,I(1))) Q:I(1)=""  D
 ....S GDATA=+$P(GMRINF(GMRVITY,I,I(1)),"^")
 ....Q:'GDATA
 ....D ADDQUAL(GMVIEN(1)_"^"_GDATA)
 ....Q
 ...Q
 ..Q
 .Q
 S DA=+GMVIEN(1)
 I GMREDB="P1" S GMRVIEN(GMRVITY)=DA_"^"_GMRDAT(GMRVITY)_"^"_$G(GMRSITE(GMRVITY))
 S:GMRENTY>4 GLAST=GMRVIDT,GLAST(1)=$G(GLAST(1))+1
 Q
XREF(DA) ; Set cross-references for FILE 120.5 entry
 ; Execute SET logic only.  Set's all cross-references for this entry.
 ; DA is the record number
 N DIC,DIK,X,Y
 Q:'DA
 S DIK="^GMR(120.5,"
 D IX1^DIK
 Q
XREF1(DA) ; Set cross-references for FILE 120.5 entry
 ; Execute SET logic only.  Set's all cross-references for this entry.
 ; DA is the record number
 N DIC,DIK,GMRVDA,GMRVIEN,X,Y
 Q:'DA
 S GMRVIEN=0,GMRVDA=DA
 F  S GMRVIEN=$O(^GMR(120.5,GMRVDA,5,GMRVIEN)) Q:'GMRVIEN  D
 .S DA(1)=GMRVDA,DA=GMRVIEN
 .S DIK="^GMR(120.5,DA(1),5,"
 .D IX1^DIK
 .Q
 Q
SETPRMT ; SET VITAL TYPE PATTERN MATCH
 S G=$P(GMRSTR(0),";",GMRX)
 S GMRHELP=GMRHELP_$S(G="P":"PPP",G="WT":"WWW.WW",G="R":"RR",G="CG":"NNN.NN",G="CVP":"NN",G="PO2":"NNN",G="HT":"HH",G="BP":"BBB/BBB/BBB (or BBB/BBB)",G="T":"TTT.T",G="PN":"NN",1:"")_$S(GMRX'=($L(GMRSTR(0),";")-1):"-",1:"")
 S GMRHELP(1)=GMRHELP(1)_$S(GMRHELP(1)'="":",",1:"")_$P(GMRSTR(0),";",GMRX)_"^GMRVUT1"
 S GMRPRMT=GMRPRMT_$S(G="T":"Temp",G="P":"Pulse",G="WT":"Wt.",G="R":"Resp",G="HT":"Ht.",G="BP":"BP",G="CG":"Circumference/Girth",G="CVP":"CVP",G="PO2":"PO2",G="PN":"Pain",1:"")_$S(GMRX'=($L(GMRSTR(0),";")-1):"-",1:"")
 Q
CHKDT(GMVDT,GMVSAV) ;Check if there is an entry for that date & time
 N GMVA,GMVTY
 S GMVA=0
 F  S GMVA=$O(^GMR(120.5,"B",GMVDT,GMVA)) Q:'GMVA  D
 .I DFN'=$P($G(^GMR(120.5,GMVA,0)),U,2) Q
 .S GMVTY=$P($G(^GMR(120.5,GMVA,0)),"^",3)
 .I GMVTY=GMVSAV D
 ..S GMVDT=$$FMADD^XLFDT(GMVDT,"","","",1)
 ..Q
 .Q
 Q GMVDT
 ;
ADDQUAL(GMRVDATA) ; Add qualifiers to FILE 120.5 entry
 ; ADD QUALIFIER TO 120.505 SUBFILE
 ; Input:
 ;    GMRVDATA=120.5 IEN^QUALIFIER (120.52) IEN
 ;
 N GMVCNT,GMVERR,GMVFDA,GMVOKAY,GMRVIEN,GMRVQUAL
 S GMRVIEN=+$P(GMRVDATA,"^",1) ;File 120.5 ien
 S GMRVQUAL=+$P(GMRVDATA,"^",2) ;File 120.52 ien
 ; Does File 120.5 entry exist?
 I '$D(^GMR(120.5,GMRVIEN,0)) Q
 ; Is the qualifier already stored?
 I $O(^GMR(120.5,GMRVIEN,5,"B",GMRVQUAL,0))>0 Q
 ; Legitimate Qualifier?
 I '$D(^GMRD(120.52,GMRVQUAL,0)) Q
 S GMVCNT=0 ;counter for number of tries to lock an entry
B2 ; Lock the entry
 I GMVCNT>3 Q  ;4 strikes and you're out
 L +^GMR(120.5,GMRVIEN,0):1
 S GMVCNT=GMVCNT+1
 I '$T L -^GMR(120.5,GMRVIEN,0) G B2
 ; Store the  qualifier
 S GMVFDA(120.505,"+1,"_GMRVIEN_",",.01)=GMRVQUAL
 D UPDATE^DIE("","GMVFDA","GMVOKAY","GMVERR")
 L -^GMR(120.5,GMRVIEN,0)
 Q
