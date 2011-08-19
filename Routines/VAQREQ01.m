VAQREQ01 ;ALB/JFP - PDX, REQUEST PATIENT DATA, STATUS SCREEN;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Main entry point for the list processor
 K XQORS,VALMEVL
 D EN^VALM("VAQ STATUS PDX1")
 QUIT
 ;
INIT ; -- Builds array of PDX transactions for the patient entered (SSN) or name
 K ^TMP("VAQR1",$J),^TMP("VAQIDX",$J)
 S TRDE="",(VAQECNT,VALMCNT)=0
 I (VAQISSN="")&(VAQNM="") D  QUIT
 .S TRNO=0,X=$$SETSTR^VALM1(" ","",1,79) D TMP
 .S X=$$SETSTR^VALM1(" ** Insufficient Information for Patient Look-up...","",1,80) D TMP
 F  S TRDE=$O(^VAT(394.61,$S(VAQISSN'="":"SSN",1:"NAME"),$S(VAQISSN'="":VAQISSN,1:VAQNM),TRDE))  Q:TRDE=""  D SETD
 I VAQECNT=0 D
 .S TRNO=0,X=$$SETSTR^VALM1(" ","",1,79) D TMP
 .S X=$$SETSTR^VALM1(" ** No PDX transactions found for this patient... ","",1,80) D TMP
 QUIT
 ;
SETD ; -- Set data for display in list processor
 F ND=0,"RQST1","RQST2","ATHR1","ATHR2" S NODE(ND)=$G(^VAT(394.61,TRDE,ND))
 ; -- Filters out transactions marked as purged OR excides life cap
 S VAQFLAG=$$EXPTRN^VAQUTL97(TRDE) ; -- naked set at SETD+1
 Q:VAQFLAG=1
 ;
 S TRNO=$P(NODE(0),U,1)
 S STDE=$P(NODE(0),U,2)
 S STATUS=$S(STDE'="":$P($G(^VAT(394.85,STDE,0)),U,2),1:" ")
 S VAQTDTE=$P(NODE("ATHR1"),U,1) ; -- response
 I VAQTDTE'="" S Y=VAQTDTE X ^DD("DD") S DATETIME=Y_" (Rs)"
 I VAQTDTE="" S (Y,VAQTDTE)=$P(NODE("RQST1"),U,1) X ^DD("DD") S DATETIME=Y_" (Rq)"
 ;
 S DOMKEY=$$DOMKEY^VAQUTL94(STDE)
 S:DOMKEY=-1 DOMAIN="Error extracting domain"
 S:DOMKEY="R" DOMAIN=$P(NODE("RQST2"),U,1)
 S:DOMKEY="A" DOMAIN=$P(NODE("ATHR2"),U,1)
 S VAQECNT=VAQECNT+1 W:(VAQECNT#10)=0 "."
 D:$D(^VAT(394.61,TRDE,"SEG",0)) SEG^VAQEXT06 ; -- gather segments
 ;
 S X=$$SETSTR^VALM1("Entry #  : "_VAQECNT,"",1,30)
 S X=$$SETSTR^VALM1("Trans #  : "_TRNO,X,58,21) D TMP
 S X=$$SETSTR^VALM1("Date/Time: "_DATETIME,"",1,80) D TMP
 S X=$$SETSTR^VALM1("Domain   : "_DOMAIN,"",1,80) D TMP
 S X=$$SETSTR^VALM1("Status   : "_STATUS,"",1,80) D TMP
 F K=0:0 S K=$O(SEGMENT($J,K))  Q:K=""  D
 .S SEGMENT=SEGMENT($J,K)
 .I K=1 S X=$$SETSTR^VALM1("Segments : "_SEGMENT,"",1,80) D TMP
 .I K'=1 S X=$$SETSTR^VALM1("         : "_SEGMENT,"",1,80) D TMP
 S X=$$SETSTR^VALM1(" ","",1,80) D TMP ; -- null line
 QUIT
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQR1",$J,VALMCNT,0)=$E(X,1,79)
 S ^TMP("VAQR1",$J,"IDX",VALMCNT,VAQECNT)=""
 S ^TMP("VAQIDX",$J,VAQECNT)=VALMCNT_"^"_TRNO
 Q
 ;
HD ; -- Make header line for list processor
 S SP50=$J("",50)
 S VALMHDR(1)="Patient    : "_$E(VAQNM_SP50,1,38)_"Type: "_VAQEELG
 S VALMHDR(2)="Patient SSN: "_$E(VAQESSN_SP50,1,39)_"DOB: "_VAQEDOB
 QUIT
 ;
DIS ; -- Display PDX data
 N VALMY,SDI,SDAT,VAQRSLT,VAQUNSOL,VAQTRN,VAQBCK
 D STATPTR^VAQUTL95
 S VAQBCK=1
 D EN^VALM2($G(XQORNOD(0)),"S")
 Q:'$D(VALMY)
 S SDI=""
 S SDI=$O(VALMY(SDI))  Q:SDI=""
 S SDAT=$G(^TMP("VAQIDX",$J,SDI))
 S VAQTRN=$P(SDAT,U,2),DFN=""
 S (VAQDFN,DFN)=$O(^VAT(394.61,"B",VAQTRN,DFN))
 I $P($G(^VAT(394.61,DFN,0)),U,4)=1 D WORKLD^VAQDIS11
 I ($P($G(^VAT(394.61,DFN,0)),U,2)'=VAQRSLT)&($P($G(^VAT(394.61,DFN,0)),U,2)'=VAQUNSOL) D  QUIT
 .W !,"   NO Results for transaction selected"
 .D PAUSE^VAQUTL95
 .S VALMBCK="R"
 D EP^VAQDIS15 ; -- Display segments
 I VAQBCK=1 K VALMBCK QUIT
 D INIT
 S VALMBCK="R"
 QUIT
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 K ^TMP("VAQR1",$J),^TMP("VAQIDX",$J)
 K DIC,DIR,NODE,DOMAIN,SEGMENT,SEGMENT($J)
 K TRDE,TRNO,ND,STDE,STATUS,DATETIME,SEGDE,SEG,SP50,VAQECNT,X,K,J
 K VAQFLAG,VAQTDTE,DOMKEY
 Q
 ;
END ; -- End of code
 QUIT
