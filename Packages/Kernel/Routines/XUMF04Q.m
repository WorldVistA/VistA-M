XUMF04Q ;BP/RAM - INSTITUTION QUERY ;06/28/00
 ;;8.0;KERNEL;**549,678**;Jul 10, 1995;Build 13
 ;;Per VA Directive 6402, this routine should not be modified
 Q
 ;
EN ; -- QUERY and PROCESS RESPONSE
 ;
 Q:$$KSP^XUPARAM("INST")=12000
 Q:$P($$PARAM^HLCS2,U,3)="T"
 ;
 N XUMFCD
 ;
 M ^TMP("XUMF 04",$$NOW^XLFDT,$J,4)=^DIC(4)
 ;
 W !!!,"GET FACILITY TYPE",!!!
 ; load facility type
 D LOAD^XUMF(4.1)
 ;
 W !!!,"GET INSTITUTION BY STATION NUMBER - PLEASE WAIT",!!!
 ; load va station number
 D MAIN^XUMF04Q
 W !!!,"PROCESS STATION NUMBER",!!!
 D MAIN^XUMF04H
 ;
 W !!!,"GET INSTITUTUION BY NPI",!!!
 ; load NPI
 S XUMFCD="NPI"
 D MAIN^XUMF04Q
 W !!!,"PROCESS NPI",!!!
 D MAIN^XUMF04H
 W !!!,"DONE",!!!
 ;
 Q
 ;
BG ; -- background job
 ;
 N ZTRTN,ZTDESC,ZTDTH
 ;
 S ZTRTN="EN^XUMF04Q"
 S ZTDESC="XUMF load all national Institution data"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 ;
 D ^%ZTLOAD
 ;
 Q
 ;
MAIN ; -- QUERY MESSAGE
 ;
 N CNT,ERR,I,X,HLFS,HLCS,ERROR,HLRESLTA,IFN,IEN,TYPE
 N VALUE,HLSCS,PROTOCOL,TEST
 ;
 D INIT,BUILD,SEND,EXIT
 ;
 Q
 ;
INIT ; -- initialize
 ;
 K ^TMP("HLS",$J)
 ;
 K HL,HLCS,HLDOM,HLECH,HLFS,HLINST,HLINSTN,HLL,HLMTIEN,HLNEXT
 K HLNODE,HLP,HLPARAM,HLPROD,HLQ,HLQUIT,HLRESLT,HLSCS
 ;
 S PROTOCOL=$O(^ORD(101,"B","XUMF 04 MFQ",0))
 D INIT^HLFNC2(PROTOCOL,.HL)
 S TEST=$S($P($$PARAM^HLCS2,U,3)="T":1,1:0)
 S HLL("LINKS",1)="XUMF 04 MFR^XUMF "_$S('TEST:"FORUM",1:"TEST")
 ;
 S ERROR=0,CNT=1
 S HLFS=HL("FS"),HLCS=$E(HL("ECH")),HLSCS=$E(HL("ECH"),4)
 ;
 Q
 ;
BUILD ; -- build message
 ;
 D QRD
 ;
 Q
 ;
MSA ; -- MSA segment
 ;
 S ^TMP("HLS",$J,CNT)=$$MSA^XUMF04(ERROR,HLFS,.HL)
 S CNT=CNT+1
 ;
 Q
 ;
QRD ; -- QRD segment
 ;
 S ^TMP("HLS",$J,CNT)=$$QRD^XUMF04(HLFS,$G(XUMFCD))
 S CNT=CNT+1
 ;
 Q
 ;
 ;
 ;
SEND ; -- send HL7 message
 ;
 S HLP("PRIORITY")="I"
 ;
 D DIRECT^HLMA(PROTOCOL,"GM",1,.HLRESLT,"",.HLP)
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
 K ^TMP("HLS",$J)
 ;
 Q
 ;
DMIS ; - load DMIS
 ;
 Q:$$KSP^XUPARAM("INST")=12000
 Q:$P($$PARAM^HLCS2,U,3)="T"
 ;
 N XUMFCD
 S XUMFCD="DMIS"
 D MAIN^XUMF04Q
 D MAIN^XUMF04H
 ;
 Q
 ;
