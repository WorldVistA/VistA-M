ORRHCQ ; SLC/KCM/JLI - CPRS Query Tools - Utilities ;2/1/03  11:10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**153,174**;Dec 17, 1997
 ;
SETUP(ITR,QRY) ; Setup the query
 ; use ^TMP("ORRHCQ",$J,"QRY") for the query
 ; use ^TMP("ORRHCQ",$J,"COL") for the columns
 ; use ^TMP("ORRHCQD",$J) for the query data
 D CLEAR(.OK)
 N I,X,NAM,VAL,CID,ICOL,QROOT,DTRNG,CSLTGRP S ICOL=0,ITR=0,CSLTGRP=0
 S I=0 F  S I=$O(QRY(I)) Q:'I  D
 . S NAM=$P(QRY(I),"="),VAL=$P(QRY(I),"=",2,99)
 . ; if time range, convert relative to actual fileman times
 . S CID=+$O(^ORD(102.22,"B",NAM,0))
 . I +CID S:$P(^ORD(102.22,CID,0),U,2)=2 VAL=$$RNG2FM^ORRHCU(VAL)
 . I $L(VAL) S ^TMP("ORRHCQ",$J,"QRY",$P(NAM,"."),$P(NAM,".",2),VAL)=""
 . I NAM="Report.Column" S ICOL=ICOL+1,^TMP("ORRHCQ",$J,"COL",ICOL)=VAL
 ; when looking for combination of items, create full list to pass to query
 S QROOT="^TMP(""ORRHCQ"",$J,""QRY"")"
 I $D(@QROOT@("Order","ItemCombo1"))>1 D
 . M @QROOT@("Order","Orderable")=@QROOT@("Order","ItemCombo1")
 . M @QROOT@("Order","Orderable")=@QROOT@("Order","ItemCombo2")
 I $D(@QROOT@("Consult","ItemCombo1"))>1 D
 . M @QROOT@("Consult","Orderable")=@QROOT@("Consult","ItemCombo1")
 . M @QROOT@("Consult","Orderable")=@QROOT@("Consult","ItemCombo2")
 I $D(@QROOT@("Consult","DisplayGroup"))>1 D
 . S CSLTGRP=$O(^ORD(100.98,"B","CSLT",0))
 . I CSLTGRP=$O(@QROOT@("Consult","DisplayGroup",0)) Q
 . M @QROOT@("Consult","Orderable")=@QROOT@("Consult","DisplayGroup")
 . K @QROOT@("Consult","DisplayGroup")
 ; set up actual dates for clinic list sources
 S X=""
 F  S X=$O(@QROOT@("Patient","ListSource",X)) Q:X=""  I $E(X)="c" D
 . S DTRNG=$P(X,":",3,4),DTRNG=$$RNG2FM^ORRHCU(DTRNG)
 . K @QROOT@("Patient","ListSource",X)
 . S @QROOT@("Patient","ListSource",$P(X,":",1,2)_":"_DTRNG)=""
 ; set up date ranges for search items based on general date range
 S DTRNG=$O(@QROOT@("Search","DateRange",0))
 I $D(@QROOT@("Document")) S @QROOT@("Document","Reference",DTRNG)=""
 I $D(@QROOT@("Order"))    S @QROOT@("Order","TimeFrame",DTRNG)=""
 I $D(@QROOT@("Consult"))  S @QROOT@("Consult","TimeFrame",DTRNG)=""
 I $D(@QROOT@("Visit"))    S @QROOT@("Visit","TimeFrame",DTRNG)=""
 S ^TMP("ORRHCQ",$J,"TOT")=0
 S ITR=$$NXTITER("")
 Q
ADDTO(IEN,CLINDT) ;Add active location to lst
 N IEN42
 S IEN42=0
 I ($P($G(^SC(IEN,0)),U,3)="C"),$$ACTLOC^ORWU(IEN) D
 . S @QROOT@("Patient","ListSource","c:"_IEN_":"_CLINDT)=""
 I ($P($G(^SC(IEN,0)),U,3)="W"),$$ACTLOC^ORWU(IEN) D
 . S IEN42=$G(^SC(IEN,42))
 . S:IEN42 @QROOT@("Patient","ListSource","w:"_IEN42_":")=""
 Q
WCFDIV(DIVLST) ;Get wards/clinics for division
 N XXI,XXJ,NNN,CDTR
 S (XXI,NNN)=0,CDTR=""
 F  S XXI=$O(DIVLST(XXI)) Q:'XXI  D
 . S CDTR=$P(DIVLST(XXI),":",2,3)
 . S XXJ=0
 . F  S XXJ=$O(^SC(XXJ)) Q:'XXJ  D
 . . I $P(^SC(XXJ,0),U,4)=+DIVLST(XXI) D ADDTO(XXJ,CDTR)
 Q
DODIV ; find Wards/Clinics for divisions
 N XI,XJ,NN,WCLST,DIVLST,DIVPTR
 S (XI,XJ,DIVLST)="",(NN,DIVPTR)=0
 F  S XI=$O(@QROOT@("Patient","ListSource",XI)) Q:XI=""  I $E(XI)="d" D
 . S NN=NN+1,DIVLST(NN)=$P(XI,":",2,4)
 . K @QROOT@("Patient","ListSource",XI)
 Q:$D(DIVLST)=1
 S XI=""
 F  S XJ=$O(@QROOT@("Patient","ListSource",XJ)) Q:XJ=""  I "cw"[$E(XJ) D
 . S DIVPTR=$P($G(^SC($P(XJ,":",2),0)),U,4) Q:'DIVPTR
 . F  S XI=$O(DIVLST(XI)) Q:'XI  D
 . . I DIVPTR=+DIVLST(XI) K @QROOT@("Patient","ListSource",XJ)
 D WCFDIV(.DIVLST)
 Q
CLEAR(OK) ; Clear/Cancel the query
 K ^TMP("ORRHCQ",$J),^TMP("ORRHCQD",$J)  ;LW UNCOMMENT
 K ^TMP("ORRHCQB",$J),^TMP("ORRHCQS",$J) ;LW UNCOMMENT
 S OK=1
 Q
NXTITER(X) ; Return the iterator for the next patient
 ; ITER=Subscript;DFN;Item#
 N SUB,ITM,DFNITM
 S SUB=$P(X,";",1),ITM=$P(X,";",3)
 F  D  Q:+DFNITM  Q:SUB=""  ; loop until DFN or no subscripts
 . S DFNITM=$$NXTDFN(SUB,ITM)
 . Q:+DFNITM
 . S SUB=$O(^TMP("ORRHCQ",$J,"QRY","Patient","ListSource",SUB))
 . Q:SUB=""
 . D SETPTS(SUB)
 . S ITM=0
 Q:+DFNITM=0 ""
 Q SUB_";"_DFNITM
 ;
NXTDFN(SUB,ITM) ; Return the next patient^item within a subscript
 Q:SUB="" 0
 N DFN S DFN=""
 I $E(SUB)="r" D
 . N RC,ITR
 . M ITR=^TMP("ORRHCQ",$J,"PTLST",SUB,"ITR")
 . S RC=$$NEXTPAT^RORAPI01(.ITR)
 . M ^TMP("ORRHCQ",$J,"PTLST",SUB,"ITR")=ITR
 . S DFN=$P(RC,U),ITM=0
 E  D
 . S ITM=$O(^TMP("ORRHCQ",$J,"PTLST",SUB,+ITM))
 . I ITM S DFN=+^TMP("ORRHCQ",$J,"PTLST",SUB,ITM)
 Q DFN_";"_ITM
 ;
SETPTS(SUB) ; Set up to iterate through a patient list
 N LST
 I $E(SUB)="c" D CLINPTS^ORQRY01(.LST,$P(SUB,":",2),$P(SUB,":",3),$P(SUB,":",4)) M:$D(@LST)>1 ^TMP("ORRHCQ",$J,"PTLST",SUB)=@LST Q
 I $E(SUB)="w" D BYWARD^ORWPT(.LST,$P(SUB,":",2))
 I $E(SUB)="t" D TEAMPTS^ORQPTQ1(.LST,$P(SUB,":",2))
 I $E(SUB)="s" D SPECPTS^ORQPTQ2(.LST,$P(SUB,":",2))
 I $E(SUB)="p" D PROVPTS^ORQPTQ2(.LST,$P(SUB,":",2))
 I $D(LST)>1 M ^TMP("ORRHCQ",$J,"PTLST",SUB)=LST Q
 ;
 N ITR
 I ($E(SUB)="r"),'($$PATITER^RORAPI01(.ITR,$P(SUB,":",2),$P(SUB,":",3))) D
 . M ^TMP("ORRHCQ",$J,"PTLST",SUB,"ITR")=ITR
 Q
QRYITR(VAL,ORRITR) ; Do query for the current iterator
 ; VAL=PtSearched^RecordsFound^Iterator
 S VAL=$$PTSCRN($P(ORRITR,";",2))
 I VAL S $P(VAL,U,2)=$$QRYPT($P(ORRITR,";",2))
 S $P(VAL,U,3)=$$NXTITER(ORRITR)
 Q
 ;
PTSCRN(PATID) ; Return 1 if should continue with this patient
 Q:$D(^TMP("ORRHCQ",$J,"DFN",PATID)) 0
 N PRILST,LOCLST,DATRNG,CONT
 M PRILST=^TMP("ORRHCQ",$J,"QRY","Patient","Primary")
 M LOCLST=^TMP("ORRHCQ",$J,"QRY","Patient","Location")
 S DATRNG=$O(^TMP("ORRHCQ",$J,"QRY","Patient","DateRange",0)),CONT=1
 ;
 ; check if pt has primary provider in the list
 I $D(PRILST)>1 D
 . N FND,IPP S FND=0,IPP=0
 . F  S IPP=$O(PRILST(IPP)) Q:'IPP  S FND=$$PP^ORQRY(PATID,IPP) Q:FND
 . I 'FND S CONT=0
 Q:CONT=0 0
 ;
 ; check if pt has visit at during date range at optional location
 I $L(DATRNG) D
 . S:$D(LOCLST) CONT=$$ACT^ORQRY(PATID,$P(DATRNG,":"),$P(DATRNG,":",2),.LOCLST)
 . S:'$D(LOCLST) CONT=$$ACT^ORQRY(PATID,$P(DATRNG,":"),$P(DATRNG,":",2))
 I CONT S ^TMP("ORRHCQ",$J,"DFN",PATID)=""
 Q CONT
 ;
QRYPT(PATID) ; Search for records and return the number found
 N QRY,ROOT,CNT
 K ^TMP("ORRHCQP",$J)
 S ROOT="^TMP(""ORRHCQP"",$J)"
 M QRY=^TMP("ORRHCQ",$J,"QRY")
 D BYPT^ORQRY(ROOT,PATID,.QRY)
 S CNT=$G(^TMP("ORRHCQP",$J,0,"Documents"))+$G(^("Orders"))+$G(^("Visits"))+$G(^("Consults"))
 S ^TMP("ORRHCQ",$J,"TOT")=^TMP("ORRHCQ",$J,"TOT")+CNT
 M ^TMP("ORRHCQD",$J)=^TMP("ORRHCQP",$J)
 K ^TMP("ORRHCQP",$J)
 Q CNT
SORTBY(SEQ,FNM,FWD) ; Sort by a particular field
 N ID,KEY
 K ^TMP("ORRHCQB",$J),^TMP("ORRHCQS",$J)
 S SEQ=0 I 'FWD S SEQ=^TMP("ORRHCQ",$J,"TOT")+1
 S ID=0 F  S ID=$O(^TMP("ORRHCQD",$J,ID)) Q:ID=""  D
 . S KEY=$E($G(^TMP("ORRHCQD",$J,ID,FNM),"~~~~~~~~~~~~~~~~"),1,64)
 . S KEY=$TR(KEY,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 . S:KEY="" KEY=" "
 . S ^TMP("ORRHCQB",$J,KEY,ID)=""
 S KEY="" F  S KEY=$O(^TMP("ORRHCQB",$J,KEY)) Q:KEY=""  D
 . S ID="" F  S ID=$O(^TMP("ORRHCQB",$J,KEY,ID)) Q:ID=""  D
 . . S:FWD SEQ=SEQ+1 S:'FWD SEQ=SEQ-1
 . . S ^TMP("ORRHCQS",$J,SEQ)=ID
 Q
SUBDTA(LST,FIRST,LAST) ; Return name-value pairs for subset of query data
 N SEQ,COL,ID,ICOL,ILST S ILST=0
 M COL=^TMP("ORRHCQ",$J,"COL")
 F SEQ=FIRST:1:LAST D
 . Q:'$D(^TMP("ORRHCQS",$J,SEQ))
 . S ID=^TMP("ORRHCQS",$J,SEQ)
 . S ILST=ILST+1,LST(ILST)="RowItemID="_ID
 . S ICOL=0 F  S ICOL=$O(COL(ICOL)) Q:'ICOL  D
 . . S ILST=ILST+1
 . . S LST(ILST)=COL(ICOL)_"="_$G(^TMP("ORRHCQD",$J,ID,COL(ICOL)))
 Q
DETAIL(REF,ID) ; Return results of order identified by ID
 K ^TMP("ORXPND",$J)
 N ORESULTS,ORVP,LCNT,ORID S ORESULTS=1,LCNT=0
 I ID[":" S ID=$P(ID,":",2) ;strip off prefix
 S ORVP=$P(^OR(100,+ID,0),U,2),ORID=ID
 D ORDERS^ORCXPND1 S ID=ORID
 D ORDERS^ORCXPND2
 K ^TMP("ORXPND",$J,"VIDEO")
 S REF=$NA(^TMP("ORXPND",$J))
 Q
PTINFO(VAL,ID) ; Return patient info given an order, consult, or note
 N DFN,X,X0,X1,X101
 S VAL="",DFN=0,X=$P(ID,":")
 I X="ORD"!(X="CST") S DFN=+$P(^OR(100,+$P(ID,":",2),0),U,2)
 I X="DOC" S DFN=+$P(^TIU(8925,+$P(ID,":",2),0),U,2)
 ;I X="VST" visits too?
 Q:'DFN
 S X0=^DPT(DFN,0),X1=$G(^(.1)),X101=$G(^(.101))
 S VAL=$P(X0,U)_U_$P(X0,U,9)_U_X1_" "_X101
 Q
RNGFM(ORY,RNG)        ;Return FM date range string
 Q:'$L(RNG)
 S ORY=$$RNG2FM^ORRHCU(RNG)
 Q
