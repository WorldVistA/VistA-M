ORWPS ;SLC/KCM,JLI,REV,CLA - MEDS TAB;12/04/2014  13:06 ;08/31/15  10:47
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,116,132,141,173,203,190,195,265,275,243,280,350**;Dec 17, 1997;Build 77
 ;;Per VHA Directive 6402, this routine should not be modified.
COVER(LST,DFN,FILTER) ; retrieve meds for cover sheet
 S FILTER=$G(FILTER,0)
 K ^TMP("PS",$J)
 D OCL^PSOORRL(DFN,"","")
 N ILST,ITMP,X,VAIN,VAERR S ILST=0
 D:FILTER INP^VADPT
 S ITMP="" F  S ITMP=$O(^TMP("PS",$J,ITMP)) Q:'ITMP  D
 . I FILTER,$G(VAIN(1))>0,$P(^TMP("PS",$J,ITMP,0),U)["N;O" Q
 . S X=^TMP("PS",$J,ITMP,0)
 . I '$L($P(X,U,2)) S X="??"  ; show something if drug empty
 . I $D(^TMP("PS",$J,ITMP,"CLINIC",0)) S LST($$NXT)=$P(X,U,1,2)_U_$P(X,U,8,9)_U_"C"
 . E  S LST($$NXT)=$P(X,U,1,2)_U_$P(X,U,8,9)
 K ^TMP("PS",$J)
 Q
DT(X) ; -- Returns FM date for X
 N Y,%DT S %DT="T",Y="" D:X'="" ^%DT
 Q Y
 ;
ACTIVE(LST,DFN,USER,VIEW,UPDATE) ; retrieve active inpatient & outpatient meds
 K ^TMP("PS",$J)
 K ^TMP("ORACT",$J)
 N BEG,DATE,END,ERROR,CTX,STVIEW
 S (BEG,END,CTX)=""
 S VIEW=+$G(VIEW)
 S UPDATE=+$G(UPDATE)
 I VIEW=0,UPDATE=0 S VIEW=1
 S CTX=$$GET^XPAR("ALL","ORCH CONTEXT MEDS")
 I CTX=";" D DEL^XPAR("USR.`"_DUZ,"ORCH CONTEXT MEDS")
 S CTX=$$GET^XPAR("ALL","ORCH CONTEXT MEDS")
 S BEG=$$DT($P(CTX,";")),END=$$DT($P(CTX,";",2))
 I +$G(USER)=0 S USER=DUZ
 I UPDATE=1 D
 .S STVIEW=$$GET^XPAR($G(USER)_";VA(200,","OR MEDS TAB SORT",1,"I")
 .I VIEW>0,+STVIEW'=VIEW D PUT^XPAR(DUZ_";VA(200,","OR MEDS TAB SORT",,VIEW,.ERROR) S STVIEW=VIEW
 .I VIEW=0,+STVIEW=0 D PUT^XPAR(DUZ_";VA(200,","OR MEDS TAB SORT",,"1",.ERROR) S STVIEW=1,VIEW=1
 .I VIEW=0,+STVIEW'=VIEW S VIEW=+STVIEW
 .S LST(0)=STVIEW_U
 .S DATE=""
 .I BEG>0,END>0 S DATE=" ("_$$FMTE^XLFDT(BEG,2)_"-"_$$FMTE^XLFDT(END,2)_")"
 .;I +BEG=0!(+END=0) S DATE=" (To set a specific date range go to Tools|Options|Other Parameters)"
 .S LST(0)=LST(0)_DATE
 D OCL^PSOORRL(DFN,BEG,END,VIEW)
 N ITMP,FIELDS,INSTRUCT,COMMENTS,REASON,NVSDT,TYPE,ILST,J S ILST=0
 S ITMP="" F  S ITMP=$O(^TMP("PS",$J,ITMP)) Q:'ITMP  D
 . K INSTRUCT,COMMENTS,REASON
 . K ^TMP("ORACT",$J,"COMMENTS")
 . S COMMENTS="^TMP(""ORACT"",$J,""COMMENTS"")"
 . S (INSTRUCT,@COMMENTS)="",FIELDS=^TMP("PS",$J,ITMP,0)
 . I +$P(FIELDS,"^",8),$D(^OR(100,+$P(FIELDS,"^",8),8,"C","XX")) D
 . . S $P(^TMP("PS",$J,ITMP,0),"^",2)="*"_$P(^TMP("PS",$J,ITMP,0),"^",2) ;dan testing
 . S TYPE=$S($P($P(FIELDS,U),";",2)="O":"OP",1:"UD")
 . I $D(^TMP("PS",$J,ITMP,"CLINIC",0)) S TYPE="CP"
 . N LOC,LOCEX S (LOC,LOCEX)=""
 . I TYPE="CP" S LOC=$G(^TMP("PS",$J,ITMP,"CLINIC",0))
 . S:LOC LOCEX=$P($G(^SC(+LOC,0)),U)_":"_+LOC ;IMO NEW
 . I TYPE="OP",$P(FIELDS,";")["N" S TYPE="NV"          ;non-VA med
 . I $O(^TMP("PS",$J,ITMP,"A",0))>0 S TYPE="IV"
 . I $O(^TMP("PS",$J,ITMP,"B",0))>0 S TYPE="IV"
 . I (TYPE="UD")!(TYPE="CP") D UDINST(.INSTRUCT,ITMP)
 . I TYPE="OP" D OPINST(.INSTRUCT,ITMP)
 . I TYPE="IV" D IVINST(.INSTRUCT,ITMP)
 . I TYPE="NV" D NVINST(.INSTRUCT,ITMP),NVREASON(.REASON,.NVSDT,ITMP)
 . I (TYPE="UD")!(TYPE="IV")!(TYPE="NV")!(TYPE="CP") D SETMULT(COMMENTS,ITMP,"SIO")
 . M COMMENTS=@COMMENTS
 . I $D(COMMENTS(1)) S COMMENTS(1)="\"_COMMENTS(1)
 . S:TYPE="NV" $P(FIELDS,U,4)=$G(NVSDT)
 . I LOC S LST($$NXT)="~CP:"_LOCEX_U_FIELDS
 . E  S LST($$NXT)="~"_TYPE_U_FIELDS
 . S J=0 F  S J=$O(INSTRUCT(J)) Q:'J  S LST($$NXT)=INSTRUCT(J)
 . S J=0 F  S J=$O(COMMENTS(J)) Q:'J  S LST($$NXT)="t"_COMMENTS(J)
 . S J=0 F  S J=$O(REASON(J)) Q:'J  S LST($$NXT)="t"_REASON(J)
 K ^TMP("PS",$J)
 K ^TMP("ORACT",$J)
 Q
NXT() ; increment ILST
 S ILST=ILST+1
 Q ILST
 ;
UDINST(Y,INDEX) ; assembles instructions for a unit dose order
 N I,X,RST
 S X=^TMP("PS",$J,INDEX,0)
 S RST="^TMP(""ORACT"",$J,""INSTRUCT"")"
 S @RST@(1)=" "_$P(X,U,2),@RST=1
 S X=$S($L($P(X,U,6)):$P(X,U,6),1:$P(X,U,7))
 I $L(X) S @RST=2,@RST@(2)=X
 E  S @RST=1 D SETMULT(.RST,INDEX,"SIG")
 S @RST@(2)="\Give: "_$G(@RST@(2)),@RST=$G(@RST,2)
 D SETMULT(RST,INDEX,"MDR"),SETMULT(RST,INDEX,"SCH")
 F I=3:1:@RST S @RST@(I)=" "_@RST@(I)
 M Y=@RST K @RST
 Q
OPINST(Y,INDEX) ; assembles instructions for an outpatient prescription
 N I,X,RST
 S X=^TMP("PS",$J,INDEX,0)
 S RST="^TMP(""ORACT"",$J,""INSTRUCT"")"
 S @RST@(1)=" "_$P(X,U,2),@RST=1
 I $L($P(X,U,12)) S @RST@(1)=@RST@(1)_"  Qty: "_$P(X,U,12)
 I $L($P(X,U,11)) S @RST@(1)=@RST@(1)_" for "_$P(X,U,11)_" days"
 D SETMULT(RST,INDEX,"SIG")
 I @RST=1 D
 . D SETMULT(RST,INDEX,"SIO")
 . D SETMULT(RST,INDEX,"MDR")
 . D SETMULT(RST,INDEX,"SCH")
 S @RST@(2)="\ Sig: "_$G(@RST@(2))
 F I=3:1:@RST S @RST@(I)=" "_@RST@(I)
 M Y=@RST K @RST
 Q
IVINST(Y,INDEX) ; assembles instructions for an IV order
 N SOLN1,I,RST,IVDUR,CNT
 S IVDUR=""
 S RST="^TMP(""ORACT"",$J,""INSTRUCT"")"
 S @RST=0 D SETMULT(RST,INDEX,"A") S SOLN1=@RST+1
 D SETMULT(RST,INDEX,"B")
 I $D(@RST@(SOLN1)),$L($P(FIELDS,U,2)) S @RST@(SOLN1)="in "_@RST@(SOLN1)
 S SOLN1=@RST+1
 S CNT=@RST
 D SETMULT(RST,INDEX,"MDR")
 I $D(^TMP("PS",$J,INDEX,"SCH",1,0)) S @RST@(@RST)=@RST@(@RST)_" "_^TMP("PS",$J,INDEX,"SCH",1,0)
 F I=1:1:@RST S @RST@(I)="\"_$TR(@RST@(I),U," ")
 I $D(@RST@(1)) S @RST@(1)=" "_$E(@RST@(1),2,999)
 S @RST@(@RST)=@RST@(@RST)_" "_$P(^TMP("PS",$J,INDEX,0),U,3)
 S:$D(^TMP("PS",$J,INDEX,"IVLIM",0)) IVDUR=$G(^TMP("PS",$J,INDEX,"IVLIM",0))
 I $L(IVDUR) D
 . N DURU,DURV S DURU="",DURV=0
 . I IVDUR["dose" D  Q
 . .S DURV=$P(IVDUR,"doses",2)
 . .S IVDUR="for a total of "_+DURV_$S(+DURV=1:"dose",+DURV>1:" doses",1:" dose")
 . .S @RST@(@RST)=@RST@(@RST)_" "_IVDUR
 . S DURU=$E(IVDUR,1),DURV=$E(IVDUR,2,$L(IVDUR))
 . I (DURU="D")!(DURU="d") S IVDUR="for "_+DURV_$S(+DURV=1:" day",+DURV>1:" days",1:" day")
 . I (DURU="H")!(DURU="h") S IVDUR="for "_+DURV_$S(+DURV=1:" hours",+DURV>1:" hours",1:" hour")
 . I (DURU="M")!(DURU="m") S IVDUR="with total volume "_+DURV_" ml"
 . I (DURU="L")!(DURU="l") S IVDUR="with total volume "_+DURV_" L"
 . S @RST@(@RST)=@RST@(@RST)_" "_IVDUR
 M Y=@RST K @RST
 Q
NVINST(Y,INDEX) ; assembles instructions for a non-VA med
 N I,X,RST
 S X=^TMP("PS",$J,INDEX,0)
 S RST="^TMP(""ORACT"",$J,""INSTRUCT"")"
 S @RST@(1)=" "_$P(X,U,2),@RST=1
 D SETMULT(RST,INDEX,"SIG")
 I @RST=1 D
 . D SETMULT(RST,INDEX,"SIO")
 . D SETMULT(RST,INDEX,"MDR")
 . D SETMULT(RST,INDEX,"SCH")
 S @RST@(2)="\ "_$G(@RST@(2))
 F I=3:1:@RST S @RST@(I)=" "_@RST@(I)
 M Y=@RST K @RST
 Q
NVREASON(ORR,NVSDT,INDEX) ; assembles start date and reasons for a non-VA med
 N ORI,J,X,ORN,ORA
 S ORI=0 K ORR
 S X=^TMP("PS",$J,INDEX,0)
 S ORN=+$P(X,U,8)
 I $D(^OR(100,ORN,0)) D
 .S NVSDT=$P(^OR(100,ORN,0),U,8)
 .D WPVAL^ORWDXR(.ORA,ORN,"STATEMENTS") I $D(ORA) D
 ..S J=0 F  S J=$O(ORA(J)) Q:J<1  S ORI=ORI+1,ORR(ORI)=ORA(J)
 Q
SETMULT(Y,INDEX,SUB) ; appends the multiple at the subscript to Y
 N I,X,J
 S J=$G(@Y)
 S I=0 F  S I=$O(^TMP("PS",$J,INDEX,SUB,I)) Q:'I  S X=$G(^(I,0)) D
 . I SUB="B",$L($P(X,U,3)) S X=$P(X,U)_" "_$P(X,U,3)_"^"_$P(X,U,2)
 . S J=J+1,@Y@(J)=X
 S @Y=J
 Q
COMPRESS(Y) ; concatenate Y subscripts into smallest possible number
 N I,J,X S J=1,X(J)=""
 S I=0 F  S I=$O(Y(I)) Q:'I  D
 . I ($L(Y(I))+$L(X(J)))>245 S J=J+1,X(J)=""
 . S X(J)=X(J)_$S($L(X(J)):" ",1:"")_Y(I)
 K Y M Y=X
 Q
DETAIL(ROOT,DFN,ID) ; -- show details for a med order
 K ^TMP("ORXPND",$J)
 N LCNT,ORVP
 S LCNT=0,ORVP=DFN_";DPT("
 D MEDS^ORCXPND1
 S ROOT=$NA(^TMP("ORXPND",$J))
 Q
MEDHIST(ORROOT,DFN,ORIFN) ; -- show admin history for a med  (RV)
 N ORPSID,HPIV,ISIV,CKPKG,ORPHMID
 N CLIVDISP
 S ORPSID=+$P($$OI^ORX8(ORIFN),U,3),ISIV=0,HPIV=0
 S ORROOT=$NA(^TMP("ORHIST",$J)) K @ORROOT
 S ORPHMID=$G(^OR(100,+ORIFN,4))  ;Pharmacy order number
 S ISIV=$O(^ORD(100.98,"B","IV RX",ISIV))
 S HPIV=$O(^ORD(100.98,"B","TPN",HPIV))
 S CLIVDISP=$O(^ORD(100.98,"B","CI RX",""))
 S CKPKG=$$PATCH^XPDUTL("PSB*2.0*19")
 ;if the order is pending or the order has no pharmacy #
 ;or the order is not in the Display Group IV MEDICATION
 ; then use the Orderable item number to get the MAH.
 I (ORPHMID["P")!(ORPHMID="") D  Q
 . I '$L($T(HISTORY^PSBMLHS)) D  Q
 . . S @ORROOT@(0)="This report is only available using BCMA version 2.0."
 . D HISTORY^PSBMLHS(.ORROOT,DFN,ORPSID)  ; DBIA #3459 for BCMA v2.0
 ; If the order has a Display Group of IV MEDICATION the use the Pharmacy order number to get the MA
 I ($P($G(^OR(100,+ORIFN,0)),U,11)=ISIV)!($P($G(^OR(100,+ORIFN,0)),U,11)=HPIV)!($P($G(^OR(100,+ORIFN,0)),U,11)=CLIVDISP) D  Q
 . I 'CKPKG S @ORROOT@(0)="Medication Administration History is not available at this time for IV fluids."
 . I CKPKG D
 . . D RPC^PSBO(.ORROOT,"PM",DFN,"","","","","","","","","",ORPHMID)  ;DBIA #3955
 . . I '$D(@ORROOT) S @ORROOT@(0)="No Medication Administration History found for the IV order."
 I '$L($T(HISTORY^PSBMLHS)) D  Q
 . S @ORROOT@(0)="This report is only available using BCMA version 2.0."
 D HISTORY^PSBMLHS(.ORROOT,DFN,ORPSID)  ; DBIA #3459 for BCMA v2.0
 Q
 ;
REASON(ORY) ; -- Return Non-VA Med Statement/Reasons
 N ORE
 D GETLST^XPAR(.ORY,"ALL","ORWD NONVA REASON","E")
 Q
