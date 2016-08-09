IBJTEP1 ;ALB/TJB - TP ERA/835 INFORMATION SCREEN ;01-MAY-2015
 ;;2.0;INTEGRATED BILLING;**530**;21-MAR-94;Build 71
 ;;Per VA Directive 6402, this routine should not be modified.
 ;; ;
 Q
 ; Utility Routine for the IBJTEP & IBJTPE routines
EEOB(ARRAY,IENERA,KBILL,SPLIT) ; Return all of the EEOBs with this KBILL for the ERA IEN in 344.4
 N ZZ,IBZZ,CNT,IBI,IBDG,AA
 S CNT=0
 D GETS^DIQ(344.4,IENERA_",","1*;","IE","IBZZ")
 S ZZ="" F  S ZZ=$O(IBZZ(344.41,ZZ)) Q:ZZ=""  D:IBZZ(344.41,ZZ,.02,"E")=KBILL
 . Q:$P($G(^IBM(361.1,IBZZ(344.41,ZZ,.02,"I"),0)),U,4)=1  ; Don't count, it is a MRA
 . S CNT=CNT+1,@ARRAY@(CNT,IBZZ(344.41,ZZ,.02,"I"))=1,AA(IBZZ(344.41,ZZ,.02,"I"))=1
 . ; See if any splits are associated with this KBILL
 . D:+$G(SPLIT)'=0
 .. S IBI=0,IBDG=$$FIND1^DIC(399,,,IBZZ(344.41,ZZ,.02,"E"),"B",)
 .. I IBDG'="" F  S IBI=$O(^IBM(361.1,"C",IBDG,IBI)) Q:'IBI  S:$G(AA(IBI))'=1 CNT=CNT+1,@ARRAY@(CNT,IBI)=1 ; EOB has been reapportioned at the site
 S @ARRAY=CNT
 Q
 ;
 ; IEN = IEN for File 399, CODE = Revenue Code, CPT = the procedure code for this line
 ; Return the billed amount for this line
BILLN(IEN,CODE,CPT) ; Get the line item information from the Bill
 N RCOUT,II,RET
 S RET=0
 K RCOUT D FIND^DIC(399.042,","_IEN_",",".01;.02;.03;.04;.06","",CODE,"","","","","RCOUT")
 S II="" F  S II=$O(RCOUT("DILIST","ID",II)) Q:II=""  I RCOUT("DILIST","ID",II,.06)=CPT S RET=RCOUT("DILIST","ID",II,.04) Q
 Q RET
 ;
ADJU(TYPE,ARR1,END) ; Get the Deduction information from the line level
 ; TYPE = "DEDUCT" or "COINS", pass array by reference, END - quit condition
 N RCOUT,AA,BB,RET
 S RET=0
 S AA=END F  S AA=$O(ARR1(361.1151,AA)) Q:$E(AA,1,$L(END))'=END  D:ARR1(361.1151,AA,.01,"I")="PR"
 . S BB=AA F  S BB=$O(ARR1(361.11511,BB)) Q:$E(BB,1,$L(AA))'=AA  D  Q:RET'=0
 .. I TYPE="DEDUCT" S:ARR1(361.11511,BB,.01,"E")=1 RET=ARR1(361.11511,BB,.02,"E") ; Deductable
 .. I TYPE="COINS" S:ARR1(361.11511,BB,.01,"E")=2 RET=ARR1(361.11511,BB,.02,"E") ; Co-Insurance
 Q RET
 ;
RESORT(ZAR,ZIDX) ; Resort the subscripts from GETS so items collate correctly while walking the array
 ; Pass ZAR through indirection
 ; Take the second subscript and reverse the pieces, put them in right order
 Q:$G(ZIDX)']""
 N II,XX,YY,ZZ,Z1,ZN,A S ZZ="",ZN=""
 F  S ZZ=$O(@ZAR@(ZIDX,ZZ)) Q:ZZ=""  D
 . S ZN="" F II=1:1:($L(ZZ,",")-1) S ZN=$P(ZZ,",",II)_","_ZN
 . S XX="" F  S XX=$O(@ZAR@(ZIDX,ZZ,XX)) Q:XX=""  D
 .. I $D(@ZAR@(ZIDX,ZZ,XX,"E"))=1 S YY=@ZAR@(ZIDX,ZZ,XX,"E") K @ZAR@(ZIDX,ZZ,XX,"E") S QQ(ZN,XX,"E")=YY
 .. I $D(@ZAR@(ZIDX,ZZ,XX,"I"))=1 S YY=@ZAR@(ZIDX,ZZ,XX,"I") K @ZAR@(ZIDX,ZZ,XX,"I") S QQ(ZN,XX,"I")=YY
 M @ZAR@(ZIDX)=QQ
 K QQ
 Q
 ;
RECEIPT ; Go to Receipt profile
 ; Build the ^TMP(RCDPDPLM,$J,"IDX",#,#)=# array if we have a receipt on this ERA
 ; ERALST, IBIFN is passed in by IBJTEP and will be cleaned up there
 N IBERA,IBEPB,IBRP,DIR,DTOUT,DUOUT,DZX,EPIEN,I,IX,INDEX,X,Y,IBARR,IBAR2,IBAR3,RCDEPTDA,RCRECTDA,RCDPFXIT
 D FULL^VALM1
 S VALMBCK="R"
RC1 ;
 S IBRP(U)=", "
 I $L(ERALST,U)=1 S IBERA=ERALST G RC2
 S DIR("A")="Enter ERA for receipt review: ",DIR(0)="FA^1:10"
 S DIR("A",1)="Enter an ERA# from the following list for additional information."
 S DIR("A",2)="Available ERAs: "_$$REPLACE^XLFSTR(ERALST,.IBRP)
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G RCQ
 S IBERA=Y I (U_ERALST_U)'[(U_Y_U) W !!,"ERA: "_Y_" not a valid selection. Please try again...",! S X="",IBERA="" G RC1
 ;
RC2 ;
 I $G(IBERA)="" S DIR("A",1)="No ERAs for this K-Bill exist.",DIR(0)="EA",DIR("A")="Press ENTER to continue: " W ! D ^DIR K DIR G RCQ
 ; Get zero node of ERA
 S ZN=$G(^RCY(344.4,IBERA,0))
 ; Get Reciept for this Bill
 K IBEPB,^TMP("RCDPDPLM",$J) D GETS^DIQ(344.4,IBERA_",","1*;","IE","IBEPB")
 ; No Receipt then report and quit
 I $P(ZN,U,8)="",$D(^RCY(344.4,IBERA,1,"RECEIPT"))=0 S DIR("A",1)="No receipts exist for this ERA.",DIR(0)="EA",DIR("A")="Press ENTER to continue: " W ! D ^DIR K DIR G RCQ
 ; Reciept, build temp global and call RECEIPTS
 S I=0,IX="" F  S IX=$O(IBEPB(344.41,IX)) Q:IX=""  I $G(IBEPB(344.41,IX,.02,"E"))=EPBILL D
 . ; Add Reciept to list if not already on this list
 . I $G(IBEPB(344.41,IX,.25,"I"))'="" S:'$D(^TMP("RCDPDPLM",$J,"RCPT",IBEPB(344.41,IX,.25,"I"))) I=I+1,^TMP("RCDPDPLM",$J,"IDX",I,I)=$G(IBEPB(344.41,IX,.25,"I")),^TMP("RCDPDPLM",$J,"RCPT",IBEPB(344.41,IX,.25,"I"))=""
 ;  if no receipts, then set the single Receipt from the zero node.
 I '$D(^TMP("RCDPDPLM",$J,"IDX")) S:$P(ZN,U,8)'="" ^TMP("RCDPDPLM",$J,"IDX",1,1)=$P(ZN,U,8),^TMP("RCDPDPLM",$J,"RCPT",$P(ZN,U,8))="" I $P(ZN,U,8)="" D  G RCQ
 . S DIR("A",1)="Issue with ERA: "_IBERA_" and Bill No.: "_EPBILL,DIR(0)="EA",DIR("A")="Press ENTER to continue: " W ! D ^DIR K DIR
 ;
 S RCRECTDA=$$GETRCPT($NA(^TMP("RCDPDPLM",$J,"IDX")))
 I RCRECTDA=-1 G RCQ ; no selection, "^" or read timeout
 D EN^VALM("RCDP RECEIPT PROFILE")
 ;
RCQ ;
 ; If RCDPFXIT is set, exit option entirely was selected so quit back to the menu
 I $G(RCDPFXIT) S VALMBCK="Q"
 K ^TMP("RCDPDPLM",$J)
 Q
 ;
GETRCPT(ARRAY) ; If only one receipt return with the single receipt, otherwise user selects receipt
 I '$O(@ARRAY@(1)) Q $S($G(@ARRAY@(1,1))'="":$G(@ARRAY@(1,1)),1:-1)
 N ZX,ZY,ZZ,ZAR,DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT,QQ
 S ZZ=0,QQ="",ZX="" F  S ZX=$O(@ARRAY@(ZX)) Q:ZX=""  S:QQ'="" QQ=QQ_";" S ZZ=ZZ+1,QQ=QQ_ZZ_":"_$P($G(^RCY(344,@ARRAY@(ZX,ZX),0)),U,1),ZAR(ZZ)=@ARRAY@(ZX,ZX)
 S DIR(0)="S^"_QQ
 S DIR("A")="Enter index number for Receipt" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1 ; no selection/timeout quit
 Q ZAR(Y)
 ;
GETRX(IBIEN,IBARRY) ;return pharmacy data to about EEOB items
 ;   input -    IBIEN = ien to record in 361.1
 ;              IBARRY = Array name that will be used to store and return pharmacy data elements
 ;   output -   IBARRY = holds pharmacy data 
 ; IA 6033 (controlled subscription) - read access of file 362.4.  status is pending
 ; ICR 1878 (supported) - usage of EN^PSOORDER
 ;
 N IB0,RXDATA,RXIEN,IBDFN,PRIEN,RXFILL
 K IBARRY
 Q:IBIEN=""
 S PRIEN=$P(^IBM(361.1,IBIEN,0),U,1) Q:PRIEN=""
 S IBDFN=$P(^PRCA(430,PRIEN,0),U,7)
 S IB0=+$O(^IBA(362.4,"C",PRIEN,0))
 Q:IB0=0
 S RXDATA=$G(^IBA(362.4,IB0,0))
 S IBARRY("DOS")=$$FMTE^XLFDT($P(RXDATA,U,3),"2Z")
 S IBARRY("FILL")=+$P(RXDATA,U,10)          ; rx fill#
 S RXIEN=+$P(RXDATA,U,5)            ; RX ien ptr file 52
 D EN^PSOORDER(IBDFN,RXIEN)
 S IBARRY("RX")=$P(^TMP("PSOR",$J,RXIEN,0),U,5)
 I IBARRY("FILL")=0 S IBARRY("RELEASED STATUS")=$S($P(^TMP("PSOR",$J,RXIEN,0),U,13)]"":"Released",1:"Not Released")   ; Release status from Rx on the first fill (no refills)
 I IBARRY("FILL")>0 S IBARRY("RELEASED STATUS")=$S($P(^TMP("PSOR",$J,RXIEN,"REF",IBARRY("FILL"),0),U,8)]"":"Released",1:"Not Released")  ; Release status from Rx refill #
 Q
 ;
