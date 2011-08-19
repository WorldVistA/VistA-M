XUMFXP1 ;ISS/RAM - MFS parameters ;06/28/00
 ;;8.0;KERNEL;**299**;Jul 10, 1995
 ;
 ;
 ; This routine sets up the parameters required by the
 ; Master File server mechanism.
 ;
 ;  ** This routine is not a supported interface -- use XUMFXP **
 ;
 ;  See XUMFXP for parameter list documentation
 ;
 Q
 ;
MAIN ; -- main
 ;
 N PKV,HLFS,HLCS,RT,RF,SEQ,PRE,POST,LKUP,RDF,NUM,HLREP,IDX,XXX,YYY,X,Y
 ;
 I 'PROTOCOL D
 .;S:UPDATE PROTOCOL=$$FIND1^DIC(101,,"B","DS Pub Man~~L")
 .S:UPDATE PROTOCOL=$$FIND1^DIC(101,,"B","XUMFX SERVER")
 .S:QUERY PROTOCOL=$$FIND1^DIC(101,,"B","XUMF MFQ")
 S:'PROTOCOL ERROR="1^invalid protocol" Q:ERROR
 S ^TMP("XUMF MFS",$J,"PARAM","PROTOCOL")=PROTOCOL
 ;
 I $O(HL(""))="" D
 .D INIT^HLFNC2(PROTOCOL,.HL)
 I $O(HL(""))="" S ERROR="1^"_$P(HL,U,2) Q
 S HLFS=HL("FS"),HLCS=$E(HL("ECH")),HLREP=$E(HL("ECH"),2)
 ;
 Q:$G(MFK)
 ;
 I QUERY D QRD^XUMFXP2
 ;
 ; MFI -- Master File Identification
 ;
 ;Master File Identifier
 ;S ^TMP("XUMF MFS",$J,"PARAM","MFI")=$P($G(^DIC(4.001,+IFN,0)),U,3)
 S ^TMP("XUMF MFS",$J,"PARAM","MFI")=+IFN
 ;Application Identifier
 S ^TMP("XUMF MFS",$J,"PARAM","MFAI")=$G(^TMP("XUMF MFS",$J,"PARAM","MFAI"))
 ;File-Level Event Code
 S ^TMP("XUMF MFS",$J,"PARAM","FLEC")="UPD"
 ;Entered Data/Time
 S ^TMP("XUMF MFS",$J,"PARAM","ENDT")=""
 ;Effective Date/Time
 S ^TMP("XUMF MFS",$J,"PARAM","MFIEDT")=""
 ;Response Level Code
 S ^TMP("XUMF MFS",$J,"PARAM","RLC")="NE"
 ;
 ; MFE -- Master File Entry
 ;
 ;Record-Level Event Code
 I $G(^TMP("XUMF MFS",$J,"PARAM","RLEC"))="" D
 .S ^TMP("XUMF MFS",$J,"PARAM","RLEC")="MUP"
 ;MFN Control ID
 S ^TMP("XUMF MFS",$J,"PARAM","MFNCID")=""
 ;Effective Date/Time
 I $G(^TMP("XUMF MFS",$J,"PARAM","MFEEDT"))="" D
 .S ^TMP("XUMF MFS",$J,"PARAM","MFEEDT")=$$HLDATE^HLFNC($$NOW^XLFDT)
 ;
SEG ; -- data segment
 ;
 ;FOR MULTIPLE FIELDS
 ;
 ; MKEY is defined only when .01 is not passed in HL7 segment
 ; but is some constant string (like VISN in INSTITUTION assoc mult).
 ; MKEY and MULT evaluate FALSE.
 ;
 ; MULT is set to field number # for SEQ.  SEQ=.01 set to itself.
 ; MULT set to .01 field #.  MULT is TRUE.  MKEY undefined.
 ;
 I IEN D
 .S PKV=$$PKV^XUMFX(IFN,IEN,HLCS)
 .S ^TMP("XUMF MFS",$J,"PARAM","PKV")=PKV
 I NEW D
 .S PKV=$$PKV^XUMFX(IFN,"NEW",HLCS)
 .S ^TMP("XUMF MFS",$J,"PARAM","PKV")=PKV
 ;
 S (IDX,SEQ,NUM,CNT)=0,RDF(0)=""
 F  S IDX=$O(^DIC(4.001,IFN,1,IDX)) Q:'IDX  D
 .S Y=$G(^DIC(4.001,+IFN,1,IDX,0))
 .;
 .N FLD,TYP,SUBFILE,COLUMN,WIDTH
 .S COLUMN=$P(Y,U),WIDTH=$P(Y,U,9),NUM=NUM+1,SEQ=SEQ+1
 .S FLD=$P(Y,U,2),SUBFILE=$P(Y,U,4),LKUP=$P(Y,U,7)
 .S TYP=$P(Y,U,3),TYP=$$GET1^DIQ(771.4,(+TYP_","),.01)
 .S YYY(COLUMN,SEQ)=""
 .;
 .I $L(RDF(CNT)_(COLUMN_HLCS_TYP_HLCS_WIDTH_HLREP))>200 D
 ..S CNT=CNT+1,RDF(CNT)=""
 .S RDF(CNT)=RDF(CNT)_COLUMN_HLCS_TYP_HLCS_WIDTH_HLREP
 .;
 .I 'SUBFILE D  Q
 ..S ^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ,FLD)=TYP_U_LKUP
 .;
 .; -- multiple
 .;
 .I $P(Y,U,6)'="" D  ;.01 is a field
 ..;S ^TMP("XUMF MFS",$J,"PARAM","MULT",SEQ)=$P(Y,U,6)
 ..S XXX(SEQ)=$P(Y,U,6)
 .I $P(Y,U,6)="" D  ;.01 is lkup on MKEY literal
 ..S ^TMP("XUMF MFS",$J,"PARAM","MULT",SEQ)=""
 ..S ^TMP("XUMF MFS",$J,"PARAM","MKEY",SEQ)=$P(Y,U,5)
 .;
 .N LKUP,FUNC
 .S LKUP=$P(Y,U,7),FUNC=$P(Y,U,8)
 .S ^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ,"FILE")=SUBFILE
 .S ^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ,"FIELD")=FLD
 .S ^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ,"DTYP")=TYP
 .S ^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ,"LKUP")=LKUP
 .Q:'IEN
 .I 'FUNC,FUNC'="" D
 ..I FUNC'["(" S FUNC="$$"_FUNC_"^XUMFF" Q
 ..S FUNC="$$"_$P(FUNC,"(")_"^XUMFF("_$P(FUNC,"(",2)
 .S X="S X="_FUNC X:X["$$" X
 .Q:'X
 .S ^TMP("XUMF MFS",$J,"PARAM","IENS",SEQ)=X_","_IEN_","
 ;
 S SEQ=0
 F  S SEQ=$O(XXX(SEQ)) Q:'SEQ  D
 .S X=XXX(SEQ),Y=$O(YYY(X,0))
 .S ^TMP("XUMF MFS",$J,"PARAM","MULT",SEQ)=Y
 ;
 S RDF="RDF"_HLFS_NUM_HLFS_RDF(0) K RDF(0)
 M ^TMP("XUMF MFS",$J,"PARAM","RDF")=RDF
 ;
GROUP ; -- query group
 ;
 D GROUP^XUMFXP2
 ;
 Q
 ;
 ;
