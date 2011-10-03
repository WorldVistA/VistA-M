XUMFXP2 ;ISS/RAM - MFS parameters query/group ;06/28/00
 ;;8.0;KERNEL;**299**;Jul 10, 1995
 ;
 ; this routine is a called by XUMFXP1 and is a continuation of that
 ; routine
 ;
 Q
 ;
MAIN ; -- main
 ;
 N X
 ;
QRD ; -- query definition segment
 ;
 ;Query Date/Time
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QDT")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QDT")=$$HLDATE^HLFNC($$NOW^XLFDT)
 ;
 ;Query Format Code
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QFC")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QFC")="R"
 ;
 ;Query Priority
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QP")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QP")="I"
 ;
 ;Query ID
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QID")) D
 .S X=$P($G(^DIC(4.001,+IFN,0)),U,3)
 .S ^TMP("XUMF MFS",$J,"PARAM","QID")=X_$S(ARRAY:" ARRAY",1:" FILE")
 ;
 ;Deferred Response Type (optional)
 I '$D(^TMP("XUMF MFS",$J,"PARAM","DRT")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","DRT")=""
 ;
 ;Deferred Response Date/Time (optional)
 I '$D(^TMP("XUMF MFS",$J,"PARAM","DRDT")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","DRDT")=""
 ;
 ;Quantity Limited Request
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QLR")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QLR")="RD"_HLCS_999
 ;
 ;Who Subject Filter - ID, source table (use x-ref), assigning authority
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WHO")) D
 .N PKV,XREF,AA
 .S PKV=$$PKV^XUMFX(IFN,IEN,HLCS)
 .S XREF=$P($G(^DIC(4.001,+IFN,"MFE")),U,8)
 .S AA=$P($G(^DIC(4.001,+IFN,"MFE")),U,9)
 .N X S X=$S(ALL:"ALL",IEN:$P(PKV,HLCS),1:"IEN ARRAY")
 .S $P(X,HLCS,9,10)=XREF_HLCS_AA
 .S ^TMP("XUMF MFS",$J,"PARAM","WHO")=X
 ;
 ;What Subject Filter
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WHAT")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","WHAT")=IFN_HLCS_"IFN"_HLCS_"VA FM"
 ;
 ;What Department Data Code
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WDDC")) D
 .N X S X="INFRASTRUCTURE"_HLCS_"INFORMATION INFRASTRUCTURE"
 .S X=X_HLCS_"VA TS"
 .S ^TMP("XUMF MFS",$J,"PARAM","WDDC")=X
 ;
 ;What Data Code Value Qual (optional)
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WDCVQ")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","WDCVQ")=""
 ;
 ;Query Results Level (optional)
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QRL")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QRL")=""
 ;
 Q
 ;
GROUP ; -- query group
 ;
 N XXX,IDX,SEQ
 ;
 S (IDX,SEQ)=0
 F  S IDX=$O(^DIC(4.001,IFN,1,IDX)) Q:'IDX  D
 .S SEQ=SEQ+1
 .N FUNC,SUBFILE,X,Y
 .S Y=$G(^DIC(4.001,+IFN,1,+IDX,0))
 .S SUBFILE=$P(Y,U,4)
 .Q:'SUBFILE
 .S FUNC=$P(Y,U,8)
 .I 'FUNC,FUNC'="" D
 ..I FUNC'["(" S FUNC="$$"_FUNC_"^XUMFF" Q
 ..S FUNC="$$"_$P(FUNC,"(")_"^XUMFF("_$P(FUNC,"(",2)
 ..S XXX(SEQ)=FUNC
 ;
 S IEN=0
 F  S IEN=$O(^TMP("XUMF MFS",$J,"PARAM","IEN",IEN)) Q:'IEN  D
 .S PKV=$$PKV^XUMFX(IFN,IEN,HLCS)
 .I CDSYS'="" D
 ..S $P(PKV,HLCS,1)=^TMP("XUMF MFS",$J,"PARAM","IEN",IEN)
 ..S $P(PKV,HLCS,2)=$P($G(@ROOT@(+IEN,0)),U)
 ..S $P(PKV,HLCS,3)=CDSYS
 .S ^TMP("XUMF MFS",$J,"PARAM",IEN,"PKV")=PKV
 .;
 .S SEQ=0
 .F  S SEQ=$O(XXX(SEQ)) Q:'SEQ  D
 ..S FUNC=XXX(SEQ)
 ..S X="S X="_FUNC X X
 ..Q:'X
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS",SEQ)=X_","_IEN_","
 ;
 Q
 ;
