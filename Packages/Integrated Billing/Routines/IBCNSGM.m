IBCNSGM ;ALB/ESG - Insurance Company Billing Provider Flag Rpt/Msg ;06-APR-2009
 ;;2.0;INTEGRATED BILLING;**400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; entry point also from the top
 I '$$PROD^XUPROD(1) G EX     ; production account only
 D COMPILE
 D EMAIL
EX ;
 Q
 ;
COMPILE ; Build a sorted scratch global of payers in switchback mode
 N IEN,Z,FLGP,FLGI,DATA,ADDR,EDI,PROFID,INSTID,NAME,STREET,CITY,STATE,TRANS,SWBCK,TMP
 K ^TMP($J,"IBCNSGM")
 S IEN=0 F  S IEN=$O(^DIC(36,IEN)) Q:'IEN  D
 . I '$$ACTIVE^IBCNEUT4(IEN) Q     ; skip inactive insurance companies
 . S Z=$G(^DIC(36,IEN,4))
 . S FLGP=+$P(Z,U,11)              ; prof switchback flag
 . S FLGI=+$P(Z,U,12)              ; inst switchback flag
 . I 'FLGP,'FLGI Q                 ; both switchback flags are off
 . S DATA=$G(^DIC(36,IEN,0))
 . S ADDR=$G(^DIC(36,IEN,.11))
 . S EDI=$G(^DIC(36,IEN,3))
 . S PROFID=$P(EDI,U,2)
 . S INSTID=$P(EDI,U,4)
 . S NAME=$P(DATA,U,1) S:NAME="" NAME="~UNK"
 . S STREET=$P(ADDR,U,1)
 . S CITY=$P(ADDR,U,4)
 . S STATE=+$P(ADDR,U,5)
 . S STATE=$S(STATE:$P($G(^DIC(5,STATE,0)),U,2),1:"")
 . S TRANS=$$EXTERNAL^DILFD(36,3.01,,$P(EDI,U,1))
 . S SWBCK=""
 . I FLGP,FLGI S SWBCK="BOTH"
 . I FLGP,'FLGI S SWBCK="PROF"
 . I 'FLGP,FLGI S SWBCK="INST"
 . ;
 . S TMP=STREET_U_CITY_U_STATE_U_SWBCK_U_TRANS_U_INSTID_U_PROFID
 . S ^TMP($J,"IBCNSGM",1,NAME,IEN)=TMP
 . S ^TMP($J,"IBCNSGM",1)=$G(^TMP($J,"IBCNSGM",1))+1
 . Q
COMPX ;
 Q
 ;
EMAIL ; Construct the subject and text of the message and send it
 N MSG,LN,SITE,ZNP,XMSUBJ,XMTO,NM,IEN,TMP,DISP,CITY,SUBJ,GLO,GLB,KEY,IBX,XMINSTR
 S SITE=$$SITE^VASITE
 S ZNP=+$G(^TMP($J,"IBCNSGM",1))
 S XMSUBJ="Switchback Mode - "_$P(SITE,U,3)_" - "_ZNP_" Payer"_$S(ZNP=1:"",1:"s")_" - "_$P(SITE,U,2)
 S XMSUBJ=$E(XMSUBJ,1,65)
 S MSG=$NA(^TMP($J,"IBCNSGM",2))
 K @MSG
 S LN=0
 S LN=LN+1,@MSG@(LN)="This report shows VistA insurance companies which are in IB patch 400 switchback mode for the following site."
 S LN=LN+1,@MSG@(LN)=""
 S LN=LN+1,@MSG@(LN)="        Name: "_$P(SITE,U,2)
 S LN=LN+1,@MSG@(LN)="    Station#: "_$P(SITE,U,3)
 S LN=LN+1,@MSG@(LN)="      Domain: "_$G(^XMB("NETNAME"))
 S LN=LN+1,@MSG@(LN)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"5ZPM")
 S LN=LN+1,@MSG@(LN)=""
 S LN=LN+1,@MSG@(LN)=""
 S LN=LN+1,@MSG@(LN)="Insurance                Street                                Switch  Electron  Inst     Prof"
 S LN=LN+1,@MSG@(LN)="Company Name             Address            City                Back   Transmit   ID       ID"
 S LN=LN+1,@MSG@(LN)="---------------------------------------------------------------------------------------------------"
 ;
 S NM="" F  S NM=$O(^TMP($J,"IBCNSGM",1,NM)) Q:NM=""  S IEN=0 F  S IEN=$O(^TMP($J,"IBCNSGM",1,NM,IEN)) Q:'IEN  D
 . S TMP=$G(^TMP($J,"IBCNSGM",1,NM,IEN))
 . S DISP=$$FO^IBCNEUT1(NM,24)_" "                       ; ins co name
 . S DISP=DISP_$$FO^IBCNEUT1($P(TMP,U,1),18)_" "         ; street address
 . S CITY=$E($P(TMP,U,2),1,16)
 . I CITY'="",$P(TMP,U,3)'="" S CITY=CITY_","
 . S CITY=CITY_$P(TMP,U,3)
 . S DISP=DISP_$$FO^IBCNEUT1(CITY,19)_" "                ; city, state
 . S DISP=DISP_$$FO^IBCNEUT1($P(TMP,U,4),4)_"   "        ; switchback flag value
 . S DISP=DISP_$$FO^IBCNEUT1($P(TMP,U,5),8)_"  "         ; electronic transmit flag
 . S DISP=DISP_$$FO^IBCNEUT1($P(TMP,U,6),8)_" "          ; inst payer ID
 . S DISP=DISP_$$FO^IBCNEUT1($P(TMP,U,7),8)              ; prof payer ID
 . S LN=LN+1,@MSG@(LN)=DISP
 . Q
 ;
 I 'ZNP D
 . S LN=LN+1,@MSG@(LN)=""
 . S LN=LN+1,@MSG@(LN)="        No Data Found"
 . Q
 ;
 S LN=LN+1,@MSG@(LN)=""
 S LN=LN+1,@MSG@(LN)="Total number of companies in switchback mode: "_ZNP
 S LN=LN+1,@MSG@(LN)=""
 S LN=LN+1,@MSG@(LN)="*** End of Report ***"
 ;
 ; display taskman schedule information for server request
 I $G(IBSNDRSQ)'="" D
 . N OPTNM,IBZ,T
 . S OPTNM="IBCN INS BILL PROV FLAG RPT"
 . D OPTSTAT^XUTMOPT(OPTNM,.IBZ)
 . S T=$G(IBZ(1))
 . S LN=LN+1,@MSG@(LN)=""
 . S LN=LN+1,@MSG@(LN)=""
 . S LN=LN+1,@MSG@(LN)="TaskManager Schedule Report for server request"
 . S LN=LN+1,@MSG@(LN)="----------------------------------------------"
 . S LN=LN+1,@MSG@(LN)="           Option: "_OPTNM
 . S LN=LN+1,@MSG@(LN)="      Task Number: "_$P(T,U,1)
 . S LN=LN+1,@MSG@(LN)="    Queued to Run: "_$$FMTE^XLFDT($P(T,U,2),"5ZPM")
 . S LN=LN+1,@MSG@(LN)="Rescheduling Freq: "_$P(T,U,3)
 . Q
 ;
 ; Address the message
 I $G(IBSNDRSQ)="" S XMTO("vhacoebilpm@va.gov")=""
 I $G(IBSNDRSQ)'="" S XMTO(IBSNDRSQ)=""
 ;
 S XMINSTR("FROM")="VistA-eBilling"
 ;
 D SENDMSG^XMXAPI(DUZ,XMSUBJ,MSG,.XMTO,.XMINSTR)
 K ^TMP($J,"IBCNSGM")                ; clean-up scratch global
 I '$D(^TMP("XMERR",$J)) G EMAILX    ; no email problems so get out
 ;
 S SUBJ="IB*2*400 - MailMan Error - Ins Co Billing Provider Flag Rpt/Msg"
 K MSG S LN=0
 S LN=LN+1,MSG(LN)="MailMan reported the following error(s) when attempting to send the"
 S LN=LN+1,MSG(LN)="Insurance Company Billing Provider Flag Report."
 S LN=LN+1,MSG(LN)=""
 S (GLO,GLB)="^TMP(""XMERR"","_$J
 S GLO=GLO_")"
 F  S GLO=$Q(@GLO) Q:GLO'[GLB  S LN=LN+1,MSG(LN)="   "_GLO_" = "_$G(@GLO)
 S LN=LN+1,MSG(LN)=""
 S LN=LN+1,MSG(LN)="This report should be automatically run on a regular schedule through"
 S LN=LN+1,MSG(LN)="TaskManager.  The VistA option name is IBCN INS BILL PROV FLAG RPT."
 S LN=LN+1,MSG(LN)=""
 S LN=LN+1,MSG(LN)="Please correct the MailMan problem and re-run this report.  If you"
 S LN=LN+1,MSG(LN)="need help, please enter a Remedy ticket or call the help desk at"
 S LN=LN+1,MSG(LN)="1-888-596-4357."
 ;
 K XMTO,XMINSTR
 S XMTO(DUZ)=""
 S XMINSTR("FROM")="VistA routine IBCNSGM"
 ;
 ; send this local msg to holders of these security keys so they can fix the problems (IA# 10076)
 F KEY="XUMGR","XUPROG" S IBX=0 F  S IBX=$O(^XUSEC(KEY,IBX)) Q:'IBX  S XMTO(IBX)=""
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 K MSG
 ;
EMAILX ;
 Q
 ;
SRV ; server entry point
 ; send the report and the TaskManager schedule at the site back to the sender of the server request
 N MMHD,IBSNDRSQ
 I '$G(XMZ) G SRVX                      ; only for processing incoming server requests
 S MMHD=$$NET^XMRENT(XMZ)               ; mailman header information
 S IBSNDRSQ=$TR($P(MMHD,U,3),"<>")      ; sender of server request
 D EN                                   ; send message
 D ZAPSERV^XMXAPI("S.IBCNSRVBP",XMZ)    ; delete msg from server basket
SRVX ;
 Q
 ;
