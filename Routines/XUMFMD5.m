XUMFMD5 ;ISS/RAM - MD5 Handler ;06/28/00
 ;;8.0;KERNEL;**407**;Jul 10, 1995;Build 8
 ;
 ;
 Q
 ;
MAIN ; -- main
 ;
 N ERROR,CNT,HLFS,HLCS,MFI,QRD
 ;
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
 ;
 D EN^XUMF5I(MFI)
 ;
 S QRD=HLNODE
 ;
 Q
 ;
MFR ; -- response
 ;
 D MSA,QRD1
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
