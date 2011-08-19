XUMFXR ;ISS/RAM - MFS param pre/post update;04/15/02
 ;;8.0;KERNEL;**299**;Jul 10, 1995
 ;
 Q
 ;
NULL ; -- do nothing
 ;
 Q
 ;
PRE ; -- pre update
 ;
 N ARRAY
 ;
 K ^TMP("XUMF PRE",$J)
 ;
 D DATA(.ARRAY)
 ;
 M ^TMP("XUMF PRE",$J)=ARRAY
 ;
 Q
 ;
POST ; -- post update
 ;
 N ARRAY,I,X,FLAG
 ;
 D DATA(.ARRAY)
 ;
 S (FLAG,I)=0
 F  S I=$O(ARRAY(I)) Q:'I  D  Q:FLAG
 .I ARRAY(I)'=^TMP("XUMF PRE",$J,I) S FLAG=1 Q
 ;
 I FLAG D
 .S I=0
 .F  S I=$O(ARRAY(I)) Q:'I  D
 ..S X(I+100)=ARRAY(I) K ARRAY(I)
 .M X=^TMP("XUMF PRE",$J)
 .D XM(.X,$G(KEY))
 ;
 K ^TMP("XUMF PRE",$J)
 ;
 Q
 ;
DATA(ARRAY) ; -- array(sequence)=fieldLabel_": "_value
 ;
 N SEG,SEQ,FLD,FILE,IENS,FIELD,VALUE,LKUP,IDX
 ;
 S SEG="",SEQ=0
 F  S SEQ=$O(^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ)) Q:'SEQ  D
 .;
 .S FLD=$O(^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ,0))
 .;
 .I 'FLD D
 ..S FILE=^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ,"FILE")
 ..S IENS=$G(^TMP("XUMF MFS",$J,"PARAM","IENS",SEQ))
 ..S FIELD=^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ,"FIELD")
 ..S LKUP=$G(^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ,"LKUP"))
 ..I LKUP S FIELD=FIELD_":"_LKUP
 ..S VALUE=$$GET1^DIQ(FILE,IENS,FIELD)
 ..S ARRAY(SEQ)=$$FIELD^XUMF(FILE,$P(FIELD,":"),"LABEL")_": "_VALUE
 .I FLD D
 ..S ZDTYP=$G(^TMP("XUMF MFS",$J,"PARAM","SEQ",SEQ,FLD))
 ..S LKUP=$P(ZDTYP,U,2)
 ..I LKUP S FLD=FLD_":"_LKUP
 ..S VALUE=$$GET1^DIQ(IFN,IEN_",",FLD)
 ..S ARRAY(SEQ)=$$FIELD^XUMF(IFN,$P(FLD,":"),"LABEL")_": "_VALUE
 ;
 Q
 ;
MFP ; -- get Master File Parameters from server
 ;
 N X
 ;
 S EXIT=1
 S IEN=$$FIND1^DIC(1,,"BX",$P(KEY,HLCS))
 ;
 D MAIN^XUMF299
 ;
 S X(1)="Query sent to MFS to get "_$P(KEY,HLCS)_" parameters"
 D XM1(.X)
 ;
 Q
 ;
XM(X,XUMFKEY) ; -- MailMan notification
 ;
 N GROUP
 ;
 S HLCS=$G(HLCS) S:HLCS="" HLCS="~"
 S XUMFKEY=" "_$P($G(XUMFKEY),HLCS)
 ;
 S GROUP=$$GET1^DIQ(4.001,IEN_",",.06)
 S:GROUP'="" GROUP="G."_GROUP
 S X(.1)="HL7 message ID: "_$G(HL("MID")),X(.2)=""
 S X(.3)="PRE UPDATE VALUES:",X(.4)=""
 S X(99.1)="",X(99.2)="POST UPDATE VALUES:",X(99.3)=""
 S XMSUB="XUMF MFS UPDATE - "_$$FILE^XUMF(IFN,"NAME")_XUMFKEY
 S XMY("G.XUMF SERVER")="",XMDUZ=.5
 S:GROUP'="" XMY(GROUP)=""
 S XMTEXT="X("
 ;
 D ^XMD
 ;
XM1(X) ; -- MailMan notification
 ;
 N GROUP
 ;
 S GROUP=$$GET1^DIQ(4.001,IEN_",",.06)
 S:GROUP'="" GROUP="G."_GROUP
 S X(.1)="HL7 message ID: "_$G(HL("MID")),X(.2)=""
 S XMSUB="XUMF MFE - "_$$FILE^XUMF(IFN,"NAME")
 S XMY("G.XUMF SERVER")="",XMDUZ=.5
 S:GROUP'="" XMY(GROUP)=""
 S XMTEXT="X("
 ;
 D ^XMD
 ;
 Q
 ;
