XUMFP4C ;CIOFO-SF/RAM - Master File C/S Params INSTITUTION ;06/28/00
 ;;8.0;KERNEL;**206,209,217,270,294,335,390,416**;Jul 10, 1995;Build 5
 ;
 ; this routine is a called by XUMFP4 and is a continuation of that
 ; routine
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
 .S ^TMP("XUMF MFS",$J,"PARAM","QID")="Z04 "_$S(ARRAY:"ARRAY",1:"FILE")
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
 ;Who Subject Filter - sta#, D x-ref, assigning facility
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WHO")) D
 .N X S X=$S(ALL:"ALL",IEN:$P($G(^DIC(4,+IEN,99)),U),1:"IEN ARRAY")
 .S $P(X,HLCS,9,10)="D"_HLCS_"045A4"
 .S:$G(CDSYS)'="" $P(X,HLCS,9,10)=CDSYS_HLCS_""
 .S ^TMP("XUMF MFS",$J,"PARAM","WHO")=X
 ;
 ;What Subject Filter
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WHAT")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","WHAT")="4"_HLCS_"IFN"_HLCS_"VA FM"
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
PRE ; -- pre-update record
 ;
 D PRE^XUMFR
 ;
 D IFF(IEN)
 ;
 Q
 ;
POST ; -- post-update record
 ;
 D POST^XUMFR
 ;
 Q
 ;
GROUP ; -- query group
 ;
 S IEN=0
 F  S IEN=$O(^TMP("XUMF MFS",$J,"PARAM","IEN",IEN)) Q:'IEN  D
 .I '$G(^DIC(4,IEN,99)) D
 ..S PKV="NEW"_HLCS_"STATION NUMBER"_HLCS_"D"
 .I $G(^DIC(4,IEN,99)) D
 ..S PKV=$P(^DIC(4,IEN,99),U)_HLCS_"STATION NUMBER"_HLCS_"D"
 .I CDSYS'="" D
 ..S $P(PKV,HLCS,1)=^TMP("XUMF MFS",$J,"PARAM","IEN",IEN)
 ..S $P(PKV,HLCS,2)=$P($G(^DIC(4,+IEN,0)),U),$P(PKV,HLCS,3)=CDSYS
 .S ^TMP("XUMF MFS",$J,"PARAM",IEN,"PKV")=PKV
 .I '$P($G(^DIC(4,+IEN,99)),U,4) D
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",8)="1,"_IEN_","
 ..;S ^TMP("XUMF MFS",$J,"PARAM",IEN,"KEY","ZIN",4.014,"1,"_IEN_",")="VISN"
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",9)="2,"_IEN_","
 ..;S ^TMP("XUMF MFS",$J,"PARAM",IEN,"KEY","ZIN",4.014,"2,"_IEN_",")="PARENT FACILITY"
 .S RF=$$RF^XUAF4(IEN) D:RF
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",10)=$P(RF,U,3)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",11)=$P(RF,U,3)_","_IEN_","
 ..;S ^TMP("XUMF MFS",$J,"PARAM",IEN,"KEY","ZIN",4.999,$P(RF,U,3)_","_IEN_",")=$P(RF,U,3)
 .S RT=$$RT^XUAF4(IEN) D:RT
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",12)=$P(RT,U,3)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",13)=$P(RT,U,3)_","_IEN_","
 ..;S ^TMP("XUMF MFS",$J,"PARAM",IEN,"KEY","ZIN",4.999,$P(RT,U,3)_","_IEN_",")=$P(RT,U,3)
 .S NPI=$$NPI^XUSNPI("Organization_ID",IEN) D:NPI
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",17)=$O(^DIC(4,IEN,"NPISTATUS","C",+NPI,999),-1)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",18)=$O(^DIC(4,IEN,"NPISTATUS","C",+NPI,999),-1)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",19)=$O(^DIC(4,IEN,"NPISTATUS","C",+NPI,999),-1)_","_IEN_","
 .S TAX=$$TAXORG^XUSTAX(IEN) D:TAX
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",20)=$O(^DIC(4,IEN,"TAXONOMY","B",+$P(TAX,U,2),999),-1)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",21)=$O(^DIC(4,IEN,"TAXONOMY","B",+$P(TAX,U,2),999),-1)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZIN",22)=$O(^DIC(4,IEN,"TAXONOMY","B",+$P(TAX,U,2),999),-1)_","_IEN_","
 ;
 Q
 ;
IFF(IEN) ; -- inactive facility remove VISN and parent association
 ;
 N FDA,IENS,XUMF
 ;
 S XUMF=1
 ;
 S IENS="1,"_IEN_","
 S FDA(4.014,IENS,.01)="@"
 S IENS="2,"_IEN_","
 S FDA(4.014,IENS,.01)="@"
 D FILE^DIE("E","FDA")
 ;
 Q
 ;
