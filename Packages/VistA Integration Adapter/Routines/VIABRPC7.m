VIABRPC7 ;AAC/JMC - VIA RPCs ;04/05/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**7,8,9,12**;06-FEB-2014;Build 28
 ;
 ; ICR 1365    DSELECT^GMPLENFM   ^TMP("IB",$J)
 ; ICR 2467    ^ORX8 (Controlled)
 ; ICR 10141   PATCH^XPDUTL (Supported)
 ; ICR 3459    PSBMLHS (Supported)
 ; ICR 3889    PSBO (Controlled)
 ; ICR 5771    100 (Controlled)
 ; ICR 6484    100.98 (Controlled)
 ; ICR 10048   DIC(9.4 (Supported)
 ; ICR 1889    $$DATA2PCE^PXAPI
 ; ICR 3540    FILE^TIUSRVP (Controlled)
 ; ICR 5680    $$EXP^LEXCODE (Supported) 
 ; ICR 5699    $$ICDDATA^ICDXCODE (Supported)
 ; ICR 1995    $$CODEN^ICPTCOD (Supported)
 ; ICR 5679    $$IMPDATE^LEXU (Supported)
 ;
 Q
 ;
DQSAVE ; Background Call to DATA2PCE
 N PKG,SRC,TYP,CODE,IEN,OK,I,X,VIAPXAPI,VIAPXDEL
 N CAT,NARR,ROOT,ROOT2,VIAAVST,VIAENCDT,IMPLDT,PXERRORS,PXPROBS
 N PRV,CPT,ICD,IMM,SK,PED,HF,XAM,TRT,MOD,MODCNT,MODIDX,MODS
 N COM,COMMENT,COMMENTS,SVCAT
 N DFN,PROBLEMS,PXAPREDT,VIACPTDE,PXERRZ,VIASAVV
 S IMPLDT=$$IMPDATE^LEXU("10D")
 I $D(ZTQUEUED) S ZTREQ="@"
 S PKG=$O(^DIC(9.4,"B","VISTA INTEGRATION ADAPTER",0))
 S SRC=$TR(VIALOC,",./;'<>?:`~!@#$%^&*()-=_+[]{}\|","                                    ")
 S (PRV,CPT,ICD,IMM,SK,PED,HF,XAM,TRT)=0
 S I="" F  S I=$O(PCELIST(I)) Q:'I  S X=PCELIST(I) D
 . S TYP=$P(X,U),CODE=$P(X,U,2),CAT=$P(X,U,3),NARR=$P(X,U,4)
 . I $E(TYP,1,3)="PRV" D  Q
 . . Q:'$L(CODE)
 . . S PRV=PRV+1
 . . S ROOT="VIAPXAPI(""PROVIDER"","_PRV_")"
 . . S ROOT2="VIAPXDEL(""PROVIDER"","_PRV_")"
 . . I $E(TYP,4)'="-" D
 . . . S @ROOT@("NAME")=CODE
 . . . S @ROOT@("PRIMARY")=$P(X,U,6)
 . . S @ROOT2@("NAME")=CODE
 . . S @ROOT2@("DELETE")=1
 . . S PXAPREDT=1 ;Allow edit of primary flag
 . I TYP="VST" D  Q
 . . S ROOT="VIAPXAPI(""ENCOUNTER"",1)"
 . . I CODE="DT" S (VIAENCDT,@ROOT@("ENC D/T"))=$P(X,U,3) Q
 . . I CODE="PT" S @ROOT@("PATIENT")=$P(X,U,3),DFN=$P(X,U,3) Q
 . . I CODE="HL" S @ROOT@("HOS LOC")=$P(X,U,3) Q
 . . I CODE="PR" S @ROOT@("PARENT")=$P(X,U,3) Q
 . . ;prevents checkout!
 . . I CODE="VC" S (SVCAT,@ROOT@("SERVICE CATEGORY"))=$P(X,U,3) Q
 . . I CODE="SC" S @ROOT@("SC")=$P(X,U,3) Q
 . . I CODE="AO" S @ROOT@("AO")=$P(X,U,3) Q
 . . I CODE="IR" S @ROOT@("IR")=$P(X,U,3) Q
 . . I CODE="EC" S @ROOT@("EC")=$P(X,U,3) Q
 . . I CODE="MST" S @ROOT@("MST")=$P(X,U,3) Q
 . . I CODE="HNC" S @ROOT@("HNC")=$P(X,U,3) Q
 . . I CODE="CV" S @ROOT@("CV")=$P(X,U,3) Q
 . . I CODE="SHD" S @ROOT@("SHAD")=$P(X,U,3) Q
 . . I CODE="OL" D  Q
 . . . I +$P(X,U,3) S @ROOT@("INSTITUTION")=$P(X,U,3)
 . . . E  I $P(X,U,4)'="",$P(X,U,4)'="0" D
 . . . . I $$PATCH^XPDUTL("PX*1.0*96") S @ROOT@("OUTSIDE LOCATION")=$P(X,U,4)
 . . . . E  S @ROOT@("COMMENT")="OUTSIDE LOCATION:  "_$P(X,U,4)
 . I $E(TYP,1,3)="CPT" D  Q
 . . Q:'$L(CODE)
 . . S CPT=CPT+1,ROOT="VIAPXAPI(""PROCEDURE"","_CPT_")"
 . . S IEN=$$CODEN^ICPTCOD(CODE) ;ICR #1995
 . . S @ROOT@("PROCEDURE")=IEN
 . . I +$P(X,U,9) D
 . . . S MODS=$P(X,U,9),MODCNT=+MODS
 . . . F MODIDX=1:1:MODCNT D
 . . . . S MOD=$P($P(MODS,";",MODIDX+1),"/")
 . . . . S @ROOT@("MODIFIERS",MOD)=""
 . . S:$L(CAT) @ROOT@("CATEGORY")=CAT
 . . S:$L(NARR) @ROOT@("NARRATIVE")=NARR
 . . S:$L($P(X,U,5)) @ROOT@("QTY")=$P(X,U,5)
 . . S:$P(X,U,6)>0 @ROOT@("ENC PROVIDER")=$P(X,U,6)
 . . S:$L($P(X,U,10))>0 COMMENT($P(X,U,10))="PROCEDURE^"_CPT
 . . I $E(TYP,4)="-" S @ROOT@("DELETE")=1,@ROOT@("QTY")=0,VIACPTDE=CPT
 . I $E(TYP,1,3)="POV" D  Q
 . . N VIADXI,VIADX
 . . Q:'$L(CODE)
 . . F VIADXI=1:1:$L(CODE,"/") D
 . . . N CSYS,CDT,IEN,LEXIEN
 . . . S VIADX=$P(CODE,"/",VIADXI)
 . . . S ICD=ICD+1,ROOT="VIAPXAPI(""DX/PL"","_ICD_")"
 . . . S CDT=$S($G(SVCAT)="E":DT,1:VIAENCDT)
 . . . S CSYS=$S(CDT'<IMPLDT:"10D",1:"ICD")
 . . . I (VIADX]""),(VIADX'[".") S VIADX=VIADX_"."
 . . . S IEN=+$$ICDDATA^ICDXCODE(CSYS,VIADX,CDT,"E")
 . . . I IEN'>0 Q
 . . . S @ROOT@("DIAGNOSIS")=IEN
 . . . S @ROOT@("PRIMARY")=$S(VIADXI=1:$P(X,U,5),1:0)
 . . . S LEXIEN=$P($$EXP^LEXCODE(VIADX,CSYS,CDT),U),@ROOT@("LEXICON TERM")=$S(LEXIEN>0:LEXIEN,1:"")
 . . . S:$L(CAT) @ROOT@("CATEGORY")=CAT
 . . . S:$L(NARR) @ROOT@("NARRATIVE")=NARR
 . . . S:$P(X,U,6)>0 @ROOT@("ENC PROVIDER")=$P(X,U,6)
 . . . I $L($P(X,U,7)),($P(X,U,7)=1),(VIADXI=1) S @ROOT@("PL ADD")=$P(X,U,7),PROBLEMS(ICD)=NARR_U_CODE
 . . . S:$L($P(X,U,10))>0&(VIADXI=1) COMMENT($P(X,U,10))="DX/PL^"_ICD
 . . . I $E(TYP,4)="-" S @ROOT@("DELETE")=1
 . I $E(TYP,1,3)="IMM" D  Q
 . . Q:'$L(CODE)
 . . S IMM=IMM+1,ROOT="VIAPXAPI(""IMMUNIZATION"","_IMM_")"
 . . S @ROOT@("IMMUN")=CODE
 . . S:$L($P(X,U,5)) @ROOT@("SERIES")=$P(X,U,5)
 . . S:$L($P(X,U,5)) @ROOT@("REACTION")=$P(X,U,7)
 . . S:$L($P(X,U,8)) @ROOT@("CONTRAINDICATED")=$P(X,U,8)
 . . S:$L($P(X,U,9)) @ROOT@("REFUSED")=$P(X,U,9)
 . . S:$P(X,U,6)>0 @ROOT@("ENC PROVIDER")=$P(X,U,6)
 . . S:$L($P(X,U,10))>0 COMMENT($P(X,U,10))="IMMUNIZATION^"_IMM
 . . I $E(TYP,4)="-" S @ROOT@("DELETE")=1
 . I $E(TYP,1,2)="SK" D  Q
 . . Q:'$L(CODE)
 . . S SK=SK+1,ROOT="VIAPXAPI(""SKIN TEST"","_SK_")"
 . . S @ROOT@("TEST")=CODE
 . . S:$L($P(X,U,5)) @ROOT@("RESULT")=$P(X,U,5)
 . . S:$L($P(X,U,7)) @ROOT@("READING")=$P(X,U,7)
 . . S:$L($P(X,U,8)) @ROOT@("D/T READ")=$P(X,U,8)
 . . S:$L($P(X,U,9)) @ROOT@("EVENT D/T")=$P(X,U,9)
 . . S:$P(X,U,6)>0 @ROOT@("ENC PROVIDER")=$P(X,U,6)
 . . S:$L($P(X,U,10))>0 COMMENT($P(X,U,10))="SKIN TEST^"_SK
 . . I $E(TYP,3)="-" S @ROOT@("DELETE")=1
 . I $E(TYP,1,3)="PED" D  Q
 . . Q:'$L(CODE)
 . . S PED=PED+1,ROOT="VIAPXAPI(""PATIENT ED"","_PED_")"
 . . S @ROOT@("TOPIC")=CODE
 . . S:$L($P(X,U,5)) @ROOT@("UNDERSTANDING")=$P(X,U,5)
 . . S:$P(X,U,6)>0 @ROOT@("ENC PROVIDER")=$P(X,U,6)
 . . S:$L($P(X,U,10))>0 COMMENT($P(X,U,10))="PATIENT ED^"_PED
 . . I $E(TYP,4)="-" S @ROOT@("DELETE")=1
 . I $E(TYP,1,2)="HF" D  Q
 . . Q:'$L(CODE)
 . . S HF=HF+1,ROOT="VIAPXAPI(""HEALTH FACTOR"","_HF_")"
 . . S @ROOT@("HEALTH FACTOR")=CODE
 . . S:$L($P(X,U,5)) @ROOT@("LEVEL/SEVERITY")=$P(X,U,5)
 . . S:$P(X,U,6)'>0 $P(X,U,6)=$G(VIAPXAPI("PROVIDER",1,"NAME"))
 . . S:$P(X,U,6)>0 @ROOT@("ENC PROVIDER")=$P(X,U,6)
 . . S:$L($P(X,U,11)) @ROOT@("EVENT D/T")=$P($P(X,U,11),";",1)
 . . S:$L($P(X,U,11)) SRC=$P($P(X,U,11),";",2)
 . . S:$L($P(X,U,10))>0 COMMENT($P(X,U,10))="HEALTH FACTOR^"_HF
 . . I $E(TYP,3)="-" S @ROOT@("DELETE")=1
 . I $E(TYP,1,3)="XAM" D  Q
 . . Q:'$L(CODE)
 . . S XAM=XAM+1,ROOT="VIAPXAPI(""EXAM"","_XAM_")"
 . . S @ROOT@("EXAM")=CODE
 . . S:$L($P(X,U,5)) @ROOT@("RESULT")=$P(X,U,5)
 . . S:$P(X,U,6)>0 @ROOT@("ENC PROVIDER")=$P(X,U,6)
 . . S:$L($P(X,U,10))>0 COMMENT($P(X,U,10))="EXAM^"_XAM
 . . I $E(TYP,4)="-" S @ROOT@("DELETE")=1
 . I $E(TYP,1,3)="TRT" D  Q
 . . Q:'$L(CODE)
 . . S TRT=TRT+1,ROOT="VIAPXAPI(""TREATMENT"","_TRT_")"
 . . S @ROOT@("IMMUN")=CODE
 . . S:$L(CAT) @ROOT@("CATEGORY")=CAT
 . . S:$L(NARR) @ROOT@("NARRATIVE")=NARR
 . . S:$L($P(X,U,5)) @ROOT@("QTY")=$P(X,U,5)
 . . S:$P(X,U,6)>0 @ROOT@("ENC PROVIDER")=$P(X,U,6)
 . . S:$L($P(X,U,10))>0 COMMENT($P(X,U,10))="TREATMENT^"_TRT
 . . I $E(TYP,4)="-" S @ROOT@("DELETE")=1,@ROOT@("QTY")=0
 . I $E(TYP,1,3)="COM" D  Q
 . . Q:'$L(CODE)
 . . Q:'$L(CAT)
 . . S COMMENTS(CODE)=$P(X,U,3,999)
 ;Store the comments
 S COM=""
 F  S COM=$O(COMMENT(COM)) Q:COM=""  S:$D(COMMENTS(COM)) VIAPXAPI($P(COMMENT(COM),"^",1),$P(COMMENT(COM),"^",2),"COMMENT")=COMMENTS(COM)
 ;
 ;Remove any problems to add that the patient already has as active problems
 I $D(PROBLEMS),$D(DFN) D
 . N VIAWPROB,VIAPROBI
 . K ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS")
 . D DSELECT^GMPLENFM  ;DBIA 1365
 . S VIAPROBI=0
 . F  S VIAPROBI=$O(^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",VIAPROBI)) Q:'VIAPROBI  D  ;DBIA 1365
 .. S VIAWPROB=$P(^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",VIAPROBI),"^",2,3)
 .. S VIAWPROB($S($E(VIAWPROB,1)="$":$E(VIAWPROB,2,255),1:VIAWPROB))=""
 . K ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS")
 . Q:'$D(VIAWPROB)
 . S VIAPROBI=""
 . F  S VIAPROBI=$O(PROBLEMS(VIAPROBI)) Q:'VIAPROBI  D
 .. S:$D(VIAWPROB(PROBLEMS(VIAPROBI))) VIAPXAPI("DX/PL",VIAPROBI,"PL ADD")=0
 ;
 S VIAPXAPI("ENCOUNTER",1,"ENCOUNTER TYPE")="P"
DATA2PCE ;
 N VSTR
 S VSTR=$P(PCELIST(1),U,4) K ^TMP("VIAPCE",$J,VSTR)
 S (VIASAVV,VIAAVST)=$$GETVSIT^VIABRPC(VSTR,DFN)
 I $G(PXAPREDT)!($G(VIACPTDE)) D
 . M VIAPXDEL("ENCOUNTER")=VIAPXAPI("ENCOUNTER")
 . I $G(VIACPTDE) M VIAPXDEL("PROCEDURE",VIACPTDE)=VIAPXAPI("PROCEDURE",VIACPTDE)
 . S OK=$$DATA2PCE^PXAPI("VIAPXDEL",PKG,SRC,.VIAAVST)
 S VIAAVST=VIASAVV,PXERRZ=""
 S OK=$$DATA2PCE^PXAPI("VIAPXAPI",PKG,SRC,.VIAAVST,,1,.PXERRORS,1,.PXPROBS)
 I OK>0,+NOTEIEN,+VIAAVST D  ; NOTEIEN only set on inpatient encounters
 .N VIAOK,VIAX
 .S VIAX(1207)=VIAAVST
 .D FILE^TIUSRVP(.VIAOK,NOTEIEN,.VIAX,1)
 S ZTSTAT=0  ; clear sync flag
 K NOTEIEN,PCELIST
 Q
 ;
MEDHIST(RESULT,DFN,VIAIFN) ; -- show admin history for a med  (RV)
 ; ICR#2467,#10141,#3459,#3889,#6479,#6484
 ;RPC VIAB MEDHIST
 ;This RPC is a similar to ORWPS MEDHIST
 N VIAPSID,HPIV,ISIV,CKPKG,VIAPHMID
 N CLIVDISP,DGP
 S VIAPSID=+$P($$OI^ORX8(VIAIFN),U,3),ISIV=0,HPIV=0
 S RESULT=$NA(^TMP("VIAHIST",$J)) K @RESULT
 S VIAPHMID=$$GET1^DIQ(100,+VIAIFN,4,"I")  ;Pharmacy order number
 S ISIV=$O(^ORD(100.98,"B","IV RX",ISIV))
 S HPIV=$O(^ORD(100.98,"B","TPN",HPIV))
 S CLIVDISP=$O(^ORD(100.98,"B","CI RX",""))
 S CKPKG=$$PATCH^XPDUTL("PSB*2.0*19")
 ;if the order is pending or the order has no pharmacy #
 ;or the order is not in the Display Group IV MEDICATION
 ; then use the Orderable item number to get the MAH.
 I (VIAPHMID["P")!(VIAPHMID="") D  Q
 . I '$L($T(HISTORY^PSBMLHS)) D  Q
 . . S @RESULT@(0)="This report is only available using BCMA version 2.0."
 . D HISTORY^PSBMLHS(.RESULT,DFN,VIAPSID)  ; DBIA #3459 for BCMA v2.0
 ; If the order has a Display Group of IV MEDICATION the use the Pharmacy order number to get the MA
 S DGP=$$GET1^DIQ(100,+VIAIFN,23,"I")
 I (DGP=ISIV)!(DGP=HPIV)!(DGP=CLIVDISP) D  Q
 . I 'CKPKG S @RESULT@(0)="Medication Administration History is not available at this time for IV fluids."
 . I CKPKG D
 . . D RPC^PSBO(.RESULT,"PM",DFN,"","","","","","","","","",VIAPHMID)  ;DBIA #3889
 . . I '$D(@RESULT) S @RESULT@(0)="No Medication Administration History found for the IV order."
 I '$L($T(HISTORY^PSBMLHS)) D  Q
 . S @RESULT@(0)="This report is only available using BCMA version 2.0."
 D HISTORY^PSBMLHS(.RESULT,DFN,VIAPSID)  ; DBIA #3459 for BCMA v2.0
 Q
 ;
