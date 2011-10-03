XUMFQR ;ISS/RAM - Master File Query Response ;06/28/00
 ;;8.0;KERNEL;**407**;Jul 10, 1995;Build 8
 ;
 Q
 ;
MAIN ; -- main
 ;
 N FIELD1,IDX,IDX1,NAME1,SUBFILE1,DATA1,IEN1,TYP1,MKEY,MKEY1,TYP,VUID,VUID1
 N MFI,SEQ,NAME,QRD,SEQ,SUBFILE,IEN,CNT,DATA,ERROR
 ;
 D INIT,PROCESS,MFR,SEND,EXIT
 ;
 Q
 ;
INIT ; -- initialize
 ;
 K ^TMP("HLA",$J)
 ;
 S ERROR=0,CNT=1
 ;
 S HLFS=HL("FS"),HLCS=$E(HL("ECH")),HLSCS=$E(HL("ECH"),4)
 ;
 Q
 ;
PROCESS ; -- pull message text
 ;
 F  X HLNEXT Q:HLQUIT'>0  D
 .Q:$P(HLNODE,HLFS)=""
 .Q:"^MSH^MSA^QRD^"'[(U_$P(HLNODE,HLFS)_U)
 .D @($P(HLNODE,HLFS))
 ;
 Q
 ;
MSH ; -- MSH segment
 ;
 Q
 ;
QRD ; -- QRD segment
 ;
 S MFI=$P(HLNODE,HLFS,10)
 I MFI="" S ERROR="1^MFI not resolved HLNODE: "_$TR(HLNODE,HLFS,"#") Q
 S IFN=$O(^DIC(4.001,"MFID",MFI,0))
 I 'IFN S ERROR="1^IFN not resolved HLNODE: "_$TR(HLNODE,HLFS,"#") Q
 I '$$VFILE^DILFD(IFN) S ERROR="1^invalid file number" Q
 ;
 ; -- get root of file
 S ROOT=$$ROOT^DILFD(IFN,,1)
 ;
 S QRD=HLNODE
 ;
 Q
 ;
MFR ; -- response
 ;
 D MSA,QRD1,MFI,MFE
 ;
 Q
 ;
MSA ; -- Acknowledgement
 ;
 N X
 S X="MSA"_HLFS_$S(ERROR:"AE",1:"AA")_HLFS_HL("MID")_HLFS_$P(ERROR,U,2)
 S ^TMP("HLA",$J,CNT)=X
 S CNT=CNT+1
 ;
 Q
 ;
QRD1 ; -- query definition segment
 ;
 S ^TMP("HLA",$J,CNT)=QRD
 S CNT=CNT+1
 ;
 Q
 ;
MFI ; master file identifier segment
 ;
 S ^TMP("HLA",$J,CNT)=$$MFI^XUMFMFI(MFI,"Standard Terminology","MUP",$$NOW^XLFDT,$$NOW^XLFDT,"NE")
 S CNT=CNT+1
 ;
 Q
 ;
MFE ; master file entry segment
 ;
 S VUID=0 F  S VUID=$O(@ROOT@("AMASTERVUID",VUID)) Q:'VUID  D
 .S IEN=$O(@ROOT@("AMASTERVUID",VUID,1,0)) Q:'IEN
 .S ^TMP("HLA",$J,CNT)=$$MFE^XUMFMFE("MUP","",$$NOW^XLFDT,MFI_"@"_VUID)
 .S CNT=CNT+1
 .D ZRT
 ;
 Q
 ;
ZRT ; data segments
 ;
 S SEQ=0
 F  S SEQ=$O(^DIC(4.001,IFN,1,"ASEQ",SEQ)) Q:'SEQ  D
 .S IDX=$O(^DIC(4.001,IFN,1,"ASEQ",SEQ,0)) Q:'IDX
 .S DATA=$G(^DIC(4.001,+IFN,1,+IDX,0)),NAME=$P(DATA,U)
 .S TYP=$P(DATA,U,3),TYP=$$GET1^DIQ(771.4,(+TYP_","),.01)
 .S FIELD=$P(DATA,U,2),SUBFILE=$P(DATA,U,4),MKEY=$P(DATA,U,6)
 .S VUID1=$P(DATA,U,13),WP=$P(DATA,U,16)
 .;
 .I NAME="Status" D  Q
 ..S ^TMP("HLA",$J,CNT)="ZRT"_HLFS_NAME_HLFS_(+$P($$GETSTAT^XTID(IFN,,IEN_","),U))
 ..S CNT=CNT+1
 .;
 .I WP D WP Q
 .;
 .I SUBFILE D SUBFILE Q
 .;
 .S VALUE=$$VALUE(IFN,IEN_",",FIELD,VUID1,TYP) ;Q:VALUE=""
 .;
 .S ^TMP("HLA",$J,CNT)="ZRT"_HLFS_NAME_HLFS_VALUE
 .S CNT=CNT+1
 ;
 Q
 ;
SUBFILE ;
 ;
 I NAME="Status" D  Q
 .S ^TMP("HLA",$J,CNT)="ZRT"_HLFS_NAME_HLFS_+$$GETSTAT^XTID(IFN,,IEN_",")
 .S CNT=CNT+1
 ;
 N ROOT
 ;
 S ROOT=$$ROOT^DILFD(SUBFILE,(","_IEN_","),1)
 ;
 I MKEY="" S ERROR="1^null lookup column parameter for subfile: "_SUBFILE Q
 ;
 S IEN1=0
 F  S IEN1=$O(@ROOT@(IEN1)) Q:'IEN1  D  Q:ERROR
 .;
 .I $D(^DIC(4.001,IFN,1,IDX,1,"ASEQ1")) D SUBREC Q
 .;
 .S VALUE=$$VALUE(SUBFILE,IEN1_","_IEN_",",FIELD,VUID1,TYP) ;Q:VALUE=""
 .;
 .S ^TMP("HLA",$J,CNT)="ZRT"_HLFS_NAME_HLFS_VALUE
 .S CNT=CNT+1
 ;
 Q
 ;
SUBREC ; -- sub-records
 ;
 N SEQ1,FIELD1,NAME1,VUID2,TYP2
 ;
 S SEQ1=0
 F  S SEQ1=$O(^DIC(4.001,IFN,1,IDX,1,"ASEQ1",SEQ1)) Q:'SEQ1  D  Q:ERROR
 .S IDX1=$O(^DIC(4.001,IFN,1,IDX,1,"ASEQ1",SEQ1,0))
 .;
 .S NAME1=$P(^DIC(4.001,IFN,1,IDX,1,IDX1,0),U,2)
 .I NAME1="" S ERROR="1^subrecord sequence name missing SUBFILE : "_SUBFILE Q
 .S FIELD1=$P(^DIC(4.001,IFN,1,IDX,1,IDX1,0),U,3)
 .I FIELD1="" S ERROR="1^subrecord sequence number missing SUBFILE : "_SUBFILE Q
 .S VUID2=$P(^DIC(4.001,IFN,1,IDX,1,IDX1,0),U,4)
 .S TYP2=$P(^DIC(4.001,IFN,1,IDX,1,IDX1,0),U,5)
 .;
 .S VALUE=$$VALUE(SUBFILE,IEN1_","_IEN_",",FIELD1,VUID2,TYP2) ;Q:VALUE=""
 .;
 .S ^TMP("HLA",$J,CNT)="ZRT"_HLFS_NAME1_HLFS_VALUE
 .S CNT=CNT+1
 ;
 Q
 ;
SEND ; -- send HL7 message
 ;
 S HLP("PRIORITY")="I"
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"GM",1,.HLRESLT)
 ;
 ; check for error
 I ($P($G(HLRESLT),U,3)'="") D  Q
 .S ERROR=1_U_$P(HLRESLT,HLFS,3)_U_$P(HLRESLT,HLFS,2)_U_$P(HLRESLT,U)
 ;
 ; successful call, message ID returned
 S ERROR="0^"_$P($G(HLRESLT),U,1)
 ;
 Q
 ;
EXIT ; -- exit
 ;
 D CLEAN^DILF
 ;
 K ^TMP("HLA",$J)
 ;
 Q
 ;
WP ;
 ;
 N WP,I,J
 ;
 S I=$$GET1^DIQ(IFN,IEN_",",FIELD,,"WP")
 ;
 Q:'$D(WP)
 ;
 S ^TMP("HLA",$J,CNT)="ZRT"_HLFS_NAME_HLFS_$G(WP(1))
 ;
 S I=1,J=1
 F  S I=$O(WP(I)) Q:'I  D
 .S ^TMP("HLA",$J,CNT,J)=WP(I)
 .S J=J+1
 ;
 S CNT=CNT+1
 ;
 Q
 ;
ESC(VALUE) ;
 ;
 I VALUE["^" F  Q:VALUE'["^"  D
 .S VALUE=$P(VALUE,"^")_"\F\"_$P(VALUE,"^",2,9999)
 I VALUE["&" F  Q:VALUE'["&"  D
 .S VALUE=$P(VALUE,"&")_"\T\"_$P(VALUE,"&",2,9999)
 ;
 Q VALUE
 ;
VALUE(IFN,IENS,FIELD,VUID,TYP) ;
 ;
 Q:IFN="" "" Q:FIELD="" "" Q:IENS="" ""
 ;
 S:$G(TYP)="" TYP="ST"
 ;S VUID=$S($G(VUID)'="":":99.99",1:"")
 ;
 ;S VALUE=$$GET1^DIQ(IFN,IENS,FIELD_VUID) Q:VALUE="" ""
 S VALUE=$$GET1^DIQ(IFN,IENS,FIELD) Q:VALUE="" ""
 S VALUE=$$DTYP^XUMFP(VALUE,TYP,HLCS,1)
 S VALUE=$$ESC(VALUE)
 ;
 Q VALUE
 ;
