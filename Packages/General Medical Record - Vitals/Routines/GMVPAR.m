GMVPAR ; HOIFO/DP - XPARameter RPC ; 31-MAY-2002 10:06:18
 ;;5.0;GEN. MED. REC. - VITALS;**3**;Oct 31, 2002
 ; Integration Agreements:
 ; IA# 2263  [Supported] XPAR parameter call.
 ; IA# 2541  [Supported] Call to XUPARAM.
 ; IA# 10060 [Supported] FILE 200 fields
 ; IA# 10090 [Supported] FILE 4 references
 ;
 ; This routine supports the following IAs:
 ; #4367 - GMV PARAMETER RPC is called at RPC (private)
 ; 
 ;DELLST; [Procedure] Delete list of parameters
 ;D NDEL^XPAR(ENT,PAR,.ERR)
 ;S:'$G(ERR) @RESULTS@(0)="1^All instances removed"
 ;Q
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
 ;GETHDR; [Procedure] Returns common header format
 ;S X=$$FIND1^DIC(8989.51,,"QX",PAR)
 ;I X S @RESULTS@(0)=X_";8989.51^"_PAR
 ;E  S @RESULTS@(0)="-1^No such parameter ["_PAR_"]"
 ;Q
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
 ;GETWP; [Procedure] Returns WP text for a parameter
 ;D GETWP^XPAR(.RET,ENT,PAR,INST,.ERR)
 ;Q:$G(ERR,0)
 ;S TMP="RET"
 ;F  S TMP=$Q(@TMP) Q:TMP=""  D
 ;.S @RESULTS@($O(@RESULTS@(""),-1)+1)=@TMP
 ;S @RESULTS@(0)=$O(@RESULTS@(""),-1)_U_INST
 ;Q
 ;
RPC(RESULTS,OPTION,ENT,PAR,INST,VAL) ; [Procedure] Main RPC Hit Point
 ; RPC: [GMV PARAMETER]
 ;
 ; Requires that the parameter name in PAR
 ; be in the GMV namespace.
 ;
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. OPTION [Literal/Required] No description
 ;  3. ENT [Literal/Required] No description
 ;  4. PAR [Literal/Required] No description
 ;  5. INST [Literal/Required] No description
 ;  6. VAL [Literal/Required] No description
 ;
 N ERR,TMP,RET,TXT,IEN,IENS,ROOT
 S INST=$G(INST,1)
 S PAR=$G(PAR,"GMV")
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 I PAR'?1"GMV".E S ^TMP($J,0)="-1^Non Vitals Measurements Parameter" Q
 D:$T(@OPTION)]"" @OPTION
 I +$G(ERR) K @RESULTS S @RESULTS@(0)="-1^Error: "_(+ERR)_" "_$P(ERR,U,2)
 I '$D(^TMP($J)) S @RESULTS@(0)="-1^No date returned"
 D CLEAN^DILF
 Q
 ;
 ;SETLST; [Procedure] Build list of parameters
 ;N GMVINS ; Instance Counter
 ;D DELLST(ENT,PAR)
 ;S GMVINS=""
 ;F  S GMVINS=$O(VAL(GMVINS)) Q:GMVINS=""  D
 ;.D EN^XPAR(ENT,PAR,GMVINS,VAL(GMVINS),.ERR)
 ;S:'$G(ERR) @RESULTS@(0)="1^List "_PAR_" rebuilt"
 ;Q
 ;
SETPAR ; [Procedure] Set single value into a parameter
 D EN^XPAR(ENT,PAR,INST,VAL,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^Parameter updated"
 Q
 ;
 ;SETWP; [Procedure] Set WP text into a parameter
 ;S TXT=INST,TMP=""
 ;F  S TMP=$O(VAL(TMP)) Q:TMP=""  D
 ;.S TXT($O(TXT(""),-1)+1,0)=VAL(TMP)
 ;D EN^XPAR(ENT,PAR,INST,.TXT,.ERR)
 ;S:'$G(ERR) @RESULTS@(0)="1^WP Text Saved"
 ;Q
 ;
