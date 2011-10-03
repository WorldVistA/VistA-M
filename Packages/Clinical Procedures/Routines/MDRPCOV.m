MDRPCOV ; HOIFO/DP - Object RPCs (TMDParameter) ; [04-15-2003 12:42]
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
 ; Integration Agreements:
 ; IA# 2263 [Supported] XPAR parameter call.
 ; IA# 2541 [Supported] Call to XUPARAM.
 ;
DELLST ; [Procedure] Delete list of parameters
 D NDEL^XPAR(ENT,PAR,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^All instances removed"
 Q
 ;
DELPAR ; [Procedure] Delete single parameter value
 D DEL^XPAR(ENT,PAR,INST,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^Instance deleted"
 Q
 ;
ENTVAL ; [Procedure] Return value of the entity
 I ENT="SYS" S ENT=$$KSP^XUPARAM("WHERE")
 E  I ENT="DIV" S ENT=$$GET1^DIQ(4,DUZ(2)_",",.01)
 E  I ENT="USR" S ENT=$$GET1^DIQ(200,DUZ_",",.01)
 E  S ENT=$$GET1^DIQ(+$P(ENT,"(",2),+ENT_",",.01)
 S @RESULTS@(0)=ENT
 Q
 ;
GETHDR ; [Procedure] Returns common header format for TMDRecordID
 S X=$$FIND1^DIC(8989.51,,"QX",PAR)
 I X S @RESULTS@(0)=X_";8989.51^"_PAR
 E  S @RESULTS@(0)="-1^No such parameter ["_PAR_"]"
 Q
 ;
GETLST ; [Procedure] Return all instances of a parameter
 D GETLST^XPAR(.RET,ENT,PAR,"E",.ERR)
 Q:$G(ERR,0)
 S TMP="RET"
 F  S TMP=$Q(@TMP) Q:TMP=""  D
 .S @RESULTS@($O(@RESULTS@(""),-1)+1)=@TMP
 S @RESULTS@(0)=$O(@RESULTS@(""),-1)
 Q
 ;
GETPAR ; [Procedure] Returns external value of a parameter
 S @RESULTS@(0)=$$GET^XPAR(ENT,PAR,INST,"E")
 Q
 ;
GETWP ; [Procedure] Returns WP text for a parameter
 D GETWP^XPAR(.RET,ENT,PAR,INST,.ERR)
 Q:$G(ERR,0)
 S TMP="RET"
 F  S TMP=$Q(@TMP) Q:TMP=""  D
 .S @RESULTS@($O(@RESULTS@(""),-1)+1)=@TMP
 S @RESULTS@(0)=$O(@RESULTS@(""),-1)_U_INST
 Q
 ;
LOCK ; [Procedure] Gain exclusive access to the CP Parameters
 L +(^MDD("CP PARAMETERS")):5 S @RESULTS@(0)=$T
 Q
 ;
PARLST ; [Procedure] Returns list of all parameters
 F Y=1:1 Q:$P($T(PARS+Y),";;",2)["**EOD**"  D
 .S @RESULTS@(Y)=$P($T(PARS+Y),";;",2)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
RPC(RESULTS,OPTION,ENT,PAR,INST,VAL) ; [Procedure] Main RPC Hit Point
 ; RPC: [MD TMDPARAMETER]
 ;
 ; Requires that the parameter name in PAR
 ; be in the Clinical Procedures namespace.
 ;
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. OPTION [Literal/Required] No description
 ;  3. ENT [Literal/Required] No description
 ;  4. PAR [Literal/Required] No description
 ;  5. INST [Literal/Required] No description
 ;  6. VAL [Literal/Required] No description
 ;
 N ERR,TMP,RET,TXT,IEN,IENS,ROOT,MDD
 S INST=$G(INST,1)
 S PAR=$G(PAR,"MD")
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 I PAR'?1"MD".E S ^TMP($J,0)="-1^Non Clinical Procedures Parameter" Q
 D:$T(@OPTION)]"" @OPTION
 I +$G(ERR) K ^TMP($J,0) S ^(0)="-1^Error: "_(+ERR)_" "_$P(ERR,U,2)
 D:'$D(^TMP($J)) BADRPC^MDRPCU("MD TMDPARAMETER",$T(+0),OPTION)
 D CLEAN^DILF
 Q
 ;
SETLST ; [Procedure] Build list of parameters
 N MDINS ; Instance Counter
 D DELLST(ENT,PAR)
 S MDINS=""
 F  S MDINS=$O(VAL(MDINS)) Q:MDINS=""  D
 .D EN^XPAR(ENT,PAR,MDINS,VAL(MDINS),.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^List "_PAR_" rebuilt"
 Q
 ;
SETPAR ; [Procedure] Set single value into a parameter
 D EN^XPAR(ENT,PAR,INST,VAL,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^Parameter updated"
 Q
 ;
SETWP ; [Procedure] Set WP text into a parameter
 S TXT=INST,TMP=""
 F  S TMP=$O(VAL(TMP)) Q:TMP=""  D
 .S TXT($O(TXT(""),-1)+1,0)=VAL(TMP)
 D EN^XPAR(ENT,PAR,INST,.TXT,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^WP Text Saved"
 Q
 ;
UNLOCK ; [Procedure] Relinquish exclusive access to CP Parameters
 L -(^MDD("CP PARAMETERS")) S @RESULTS@(0)=$T
 Q
 ;
PARS ; [Data Module] All Parameters
 ;;1^MD ALLOW EXTERNAL ATTACHMENTS^Allow non-instrument attachments^yes/no^No
 ;;2^MD CRC BYPASS^Bypass CRC Checking^yes/no^No
 ;;3^MD CRC VALUES^Clinical Procedures CRC Values^free text^Yes
 ;;4^MD DAYS FOR INSTRUMENT DATA^Temporary instrument data life (Days)^numeric^No
 ;;5^MD FILE EXTENSIONS^Imaging File Types^free text^Yes
 ;;6^MD HFS SCRATCH^VistA Scratch HFS Directory^free text^No
 ;;7^MD IMAGING XFER^Imaging Network Share^free text^No
 ;;8^MD OFFLINE MESSAGE^Offline message^word processing^No
 ;;9^MD ONLINE^Clinical Procedure Online/Offline^yes/no^No
 ;;10^MD VERSION CHK^Version Compatibility^yes/no^Yes
 ;;11^MD WEBLINK^Clinical Procedures Home Page^free text^No
 ;;**EOD**
