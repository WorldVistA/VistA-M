VBECHLRT ;HOIFO/BNT - VBECS HL7 ADT Messaging Routing routine;July 13, 2004
 ;;1.0;VBECS;**10**;Apr 14, 2005;Build 15
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to ^%ZTLOAD supported by IA #10063
 ; Reference to INIT^HLFNC2 supported by IA #2161
 ; Reference to GENERATE^HLMA supported by IA #2164
 ; Reference to GETDFN^MPIF001 supported by IA #2701
 ;
 QUIT
 ;
EN ; Get Message and queue TaskMan to send it on.
 ;
 ; Only send ADT A08 Message Types
 N VBECEVNT,HLA,MSG,VBI,VBJ,SG,VBECSEND
 D INIT^HLFNC2("VAFC ADT-A08 SERVER",.HL) ;Initialize HL7 variables
 S VBECEVNT=HL("ETN")
 S VBECSEND=0
 Q:VBECEVNT'[$E("A08")
 F VBI=1:1 X HLNEXT Q:HLQUIT'>0  S MSG=HLNODE,SG=$E(HLNODE,1,3) D
 . S HLA("HLS",VBI)=MSG
 . S VBJ=0 F  S VBJ=$O(HLNODE(VBJ)) Q:'VBJ  S MSG(VBJ)=HLNODE(VBJ),HLA("HLS",VBI,VBJ)=HLNODE(VBJ)
 . I $T(@SG)]"" D @SG
 Q:'VBECSEND
 ;
 S ZTIO=""
 S ZTRTN="SNDMSG^VBECHLRT"
 S ZTSAVE("HLA(""HLS"",")=""
 S ZTSAVE("VBECEVNT")=""
 S ZTDESC="VBECS HL7 Message Router"
 S ZTDTH=$H
 D ^%ZTLOAD
 D EXIT
 Q
 ;
ZFF ; This segment contains the edited fields
 N X,VBECFLDS
 S VBECFLDS=$P(MSG,HL("FS"),3)
 F I=1:1 S X=$P(VBECFLDS,";",I) Q:X']""  D  Q:VBECSEND
 . S VBECSEND=$S(X=".01":1,X=".02":1,X=".03":1,X=".09":1,X=".351":1,X="991.01":1,1:0)
 Q
 ;
SNDMSG ; Create the ^TMP("HLS",$J global array and send the message
 S:$D(ZTQUEUED) ZTREQ="@"
 N EID
 S EID=$O(^ORD(101,"B","VBECS ADT-"_VBECEVNT_" SERVER",0))
 N HL,INT,HLRESLT,HLP
 S HL="HL",INT=0
 D INIT^HLFNC2(EID,.HL,INT)
 D GENERATE^HLMA(EID,"LM",1,.HLRESLT,"",.HLP)
 K HLA,VBECEVNT
 Q
 ;
EXIT ; Kill variables and quit
 K SG,ZTIO,ZTSAVE,ZTDESC,ZTRTN,ZTDTH
 Q
