XUMFP4 ;CIOFO-SF/RAM - Master File C/S Params INSTITUTION ;06/28/00
 ;;8.0;KERNEL;**206,217,294,335,416**;Jul 10, 1995;Build 5
 ;
 ;
 ; This routine sets up the parameters required by the INSTITUTION (#4)
 ; file for the Master File server mechanism.
 ;
 ;  ** This routine is not a supported interface -- use XUMFP **
 ;
 ;  See XUMFP for parameter list documentation
 ;
 N PKV,HLFS,HLCS,RT,RF,NPI,TAX
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","PRE")="PRE^XUMFP4C"
 S ^TMP("XUMF MFS",$J,"PARAM","POST")="POST^XUMFP4C"
 ;
 I $O(HL(""))="" D
 .I 'PROTOCOL D
 ..S:UPDATE PROTOCOL=$O(^ORD(101,"B","XUMF MFN",0))
 ..S:QUERY PROTOCOL=$O(^ORD(101,"B","XUMF MFQ",0))
 .S:'PROTOCOL ERROR="1^invalid protocol" Q:ERROR
 .S ^TMP("XUMF MFS",$J,"PARAM","PROTOCOL")=PROTOCOL
 .D INIT^HLFNC2(PROTOCOL,.HL)
 ;
 I $O(HL(""))="" S ERROR="1^"_$P(HL,U,2) Q
 S HLFS=HL("FS"),HLCS=$E(HL("ECH"))
 ;
 I QUERY D QRD^XUMFP4C
 ;
 ; MFI -- Master File Identification Segment
 S ^TMP("XUMF MFS",$J,"PARAM","MFI")="Z04"  ;Master File Identifier
 S ^TMP("XUMF MFS",$J,"PARAM","MFAI")=""  ;Application Identifier
 S ^TMP("XUMF MFS",$J,"PARAM","FLEC")="UPD"  ;File-Level Event Code
 S ^TMP("XUMF MFS",$J,"PARAM","ENDT")=""  ;Entered Data/Time
 S ^TMP("XUMF MFS",$J,"PARAM","MFIEDT")=""  ;Effective Date/Time
 S ^TMP("XUMF MFS",$J,"PARAM","RLC")="NE"  ;Response Level Code
 ;
 ; MFE -- Master File Entry
 I $G(^TMP("XUMF MFS",$J,"PARAM","RLEC"))="" D  ;Record-Level Event Code
 .S ^TMP("XUMF MFS",$J,"PARAM","RLEC")="MUP"
 S ^TMP("XUMF MFS",$J,"PARAM","MFNCID")=""  ;MFN Control ID
 I $G(^TMP("XUMF MFS",$J,"PARAM","MFEEDT"))="" D  ;Effective Date/Time
 .S ^TMP("XUMF MFS",$J,"PARAM","MFEEDT")=$$HLDATE^HLFNC($$NOW^XLFDT)
 ;
SEG ; -- ZIN segment
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",8)=""
 S ^TMP("XUMF MFS",$J,"PARAM","MKEY","ZIN",8)="VISN"
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",9)=""
 S ^TMP("XUMF MFS",$J,"PARAM","MKEY","ZIN",9)="PARENT FACILITY"
 ;history
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",10)=10
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",11)=10
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",12)=12
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",13)=12
 ;npi
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",17)=17
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",18)=17
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",19)=17
 ;taxonomy
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",20)=20
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",21)=20
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZIN",22)=20
 ;
 I IEN D
 .I $G(^DIC(4,IEN,99)) D
 ..S PKV=$P(^DIC(4,IEN,99),U)_HLCS_"STATION NUMBER"_HLCS_"D"
 .I 'PKV,CDSYS'="" D
 ..I CDSYS="NPI" D
 ...S $P(PKV,HLCS,1)=+$$NPI^XUSNPI("Organization_ID",IEN)
 ..S $P(PKV,HLCS,2)=$P($G(^DIC(4,+IEN,0)),U),$P(PKV,HLCS,3)=CDSYS
 .S ^TMP("XUMF MFS",$J,"PARAM","PKV")=PKV  ; Primary Key Value
 .S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",8)="1,"_IEN_","
 .;S ^TMP("XUMF MFS",$J,"PARAM","KEY","ZIN",4.014,"1,"_IEN_",")="VISN"
 .S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",9)="2,"_IEN_","
 .;S ^TMP("XUMF MFS",$J,"PARAM","KEY","ZIN",4.014,"2,"_IEN_",")="PARENT FACILITY"
 .S RF=$$RF^XUAF4(IEN) D:RF
 ..S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",10)=$P(RF,U,3)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",11)=$P(RF,U,3)_","_IEN_","
 ..;S ^TMP("XUMF MFS",$J,"PARAM","KEY","ZIN",4.999,$P(RF,U,3)_","_IEN_",")=$P(RF,U,3)
 .S RT=$$RT^XUAF4(IEN) D:RT
 ..S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",12)=$P(RT,U,3)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",13)=$P(RT,U,3)_","_IEN_","
 ..;S ^TMP("XUMF MFS",$J,"PARAM","KEY","ZIN",4.999,$P(RT,U,3)_","_IEN_",")=$P(RT,U,3)
 .S NPI=$$NPI^XUSNPI("Organization_ID",IEN) D:NPI
 ..S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",17)=$O(^DIC(4,IEN,"NPISTATUS","C",+NPI,999),-1)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",18)=$O(^DIC(4,IEN,"NPISTATUS","C",+NPI,999),-1)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",19)=$O(^DIC(4,IEN,"NPISTATUS","C",+NPI,999),-1)_","_IEN_","
 .S TAX=$$TAXORG^XUSTAX(IEN) D:TAX
 ..S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",20)=$O(^DIC(4,IEN,"TAXONOMY","B",+$P(TAX,U,2),999),-1)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",21)=$O(^DIC(4,IEN,"TAXONOMY","B",+$P(TAX,U,2),999),-1)_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM","IENS","ZIN",22)=$O(^DIC(4,IEN,"TAXONOMY","B",+$P(TAX,U,2),999),-1)_","_IEN_","
 ;
 I NEW D
 .S PKV="NEW"_HLCS_"STATION NUMBER"_HLCS_"D"
 .S ^TMP("XUMF MFS",$J,"PARAM","PKV")=PKV  ; Primary Key Value
 ;
 D ^XUMFP4Z
 ;
GROUP ; -- query group
 ;
 D GROUP^XUMFP4C
 ;
 Q
 ;
