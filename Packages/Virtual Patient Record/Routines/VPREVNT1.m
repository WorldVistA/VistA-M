VPREVNT1 ;SLC/MKB -- VistA event listeners ;04/25/22  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**30**;Apr 05, 2022;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References               DBIA#
 ; -------------------               -----
 ; DG PTF ICD DIAGNOSIS NOTIFIER      6850
 ; DG PTF ICD PROCEDURE NOTIFIER      7354
 ; DIC                                2051
 ; XLFDT                             10103
 ;
 ;
OPEVT ; -- DG PTF ICD PROCEDURE NOTIFIER protocol listener
 N DFN,TYPE,IEN,PTF,ADM,VST,ROOT,FLD,FILE
 S DFN=+$G(^TMP("DG PTF ICD OP NOTIFIER",$J,"DFN")) Q:DFN<1
 F TYPE="PROCEDURE" D  ;"DISCHARGE","SURGERY"
 . S IEN=$G(^TMP("DG PTF ICD OP NOTIFIER",$J,TYPE,"IENS"))
 . S:$E(IEN,$L(IEN))="," IEN=$E(IEN,1,$L(IEN)-1) ;strip final comma
 . S PTF=$P(IEN,",",$L(IEN,",")) Q:PTF<1
 . S ADM=$$FIND1^DIC(405,,"Q",PTF,"APTF"),VST=$$VNUM^VPRSDAV(ADM) Q:VST<1
 . S ROOT=$NA(^TMP("DG PTF ICD OP NOTIFIER",$J,TYPE))
 . S FLD="OPC" F  S FLD=$O(@ROOT@(FLD)) Q:FLD'?1"OPC"2N  D
 .. S FILE=$S(TYPE="DISCHARGE":45,TYPE="PROCEDURE":45.05,TYPE="SURGERY":45.01,1:0)
 .. D:FILE ICD("Procedure",FILE)
 Q
 ;
DXEVT ; -- DG PTF ICD DIAGNOSIS NOTIFIER protocol listener
 N DFN,IEN,ADM,VST,ROOT,FLD
 S DFN=+$G(^TMP("DG PTF ICD NOTIFIER",$J,"DFN")) Q:DFN<1
 S IEN=+$G(^TMP("DG PTF ICD NOTIFIER",$J,"DISCHARGE","IENS")) Q:IEN<1
 S ADM=$$FIND1^DIC(405,,"Q",IEN,"APTF"),VST=$$VNUM^VPRSDAV(ADM) Q:VST<1
 S ROOT=$NA(^TMP("DG PTF ICD NOTIFIER",$J,"DISCHARGE"))
 I $D(@ROOT@("PDX")) S FLD="PDX" D ICD("Diagnosis",45) ;DXLS
 ; look for secondary dx
 S FLD="SDX" F  S FLD=$O(@ROOT@(FLD)) Q:FLD'?1"SDX"2N  D ICD("Diagnosis",45)
 Q
 ;
ICD(NAME,FN) ; -- process each ICD code
 N ACT,ID,N,OLD,VPRSQ
 S ACT="",ID=IEN,N=+$E(FLD,4,5) S:N ID=IEN_"-"_N
 I $G(@ROOT@(FLD,"NEW"))="" S OLD=$G(@ROOT@(FLD,"OLD")),ACT="@"
 D POST^VPRHS(DFN,NAME,ID_";"_FN,ACT,VST,.VPRSQ)
 I ACT="@",$G(VPRSQ) D  ;save ICD code for delete msg
 . S ^XTMP("VPR-"_VPRSQ,ID)=DFN_U_NAME_U_ID_";"_FN_"^D^"_VST
 . S ^XTMP("VPR-"_VPRSQ,ID,0)=OLD_U_U_VST
 . S ^XTMP("VPR-"_VPRSQ,0)=$$FMADD^XLFDT(DT,14)_U_DT_"^Deleted record for AVPR"
 Q
