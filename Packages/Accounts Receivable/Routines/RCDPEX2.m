RCDPEX2 ;ALB/TMK/KML/PJH - ELECTRONIC EOB DETAIL EXCEPTION MAIN LIST TEMPLATE ;20 Dec 2018 17:20:51
 ;;4.5;Accounts Receivable;**173,269,298,304,326,345,409,424,439**;Mar 20, 1995;Build 29
 ;Per VA Directive 6402, this routine should not be modified.
 ;
INIT ;EP from listman template RCDPEX EOB_SUM EXCEPTION LIST
 ; set up initial variables
 S U="^",VALMCNT=0,VALMBG=1
 D BLD
 Q
 ;
REBLD ; Set up formatted global
 ;
BLD ;EP from RCDPEX3,RCDPEX31,RCDEPEX32
 ; Build list of messages from file 344.4
 ; Input:   RCDWLIEN  - Optional set to a selected ERA if the user opts to see
 ;                      exceptions after receiving an 'ACCESS DENIED' message
 ;                      in the ERA WORKLIST when they tried to create a scratch
 ;                      pad for the ERA (EXCDENY^RCDPEWLP).  Otherwise, undefined
 ;          RCPAY       'R' = RANGE, 'S' = SELECTED, 'A' = ALL
 ;          RCTYPE   -  'M' - Only display Medical Exceptions
 ;                      'P' - Only display Pharmacy Exceptions
 ;                      'T' - Tricare
 ;                      'A' - Display Medical and Pharmacy and Tricare Exceptions
 ;          ^TMP(^TMP("RCDPEU1",$J) holds selected payers to display.
 ;
 N DA,DR,ERAIEN,RC0,RCBILL,RCDECME,RCDPDATA,RCPYRIEN,RCER,RCEXC,RCMSG1,RCS,RCSEQ,RCSUB
 N RCX,RCX1,RCX2,X,XX,Y,YY                      ;PRCA*4.5*409 Added ERAIEN,RCX2
 K ^TMP("RCDPEX_SUM-EOB",$J),^TMP("RCDPEX_SUM-EOBDX",$J)
 K ^TMP("RCDPEADP",$J)                          ; Temp insurance array
 S (RCSEQ,VALMCNT)=0
 ;
 ; Extract data from 344.4
 S RCER=0
 F  D  Q:'RCER
 . S RCER=$O(^RCY(344.4,"AEXC",RCER))
 . Q:'RCER
 . S RCMSG=0
 . F  D  Q:'RCMSG
 . . S RCMSG=$O(^RCY(344.4,"AEXC",RCER,RCMSG))
 . . Q:'RCMSG
 . . S RCSUB=RCMSG_",",DR=".02:.06;.16;.17;.18",DA=RCMSG K DA(1)    ;PRCA*4.5*409 Added ;.16;.17;.18
 . . ;
 . . I RCPAY'="A" D  Q:'XX
 . . . S XX=$$ISSEL^RCDPEU1(344.4,DA)           ; PRCA*4.5*326 Check if payer was selected
 . . E  I RCTYPE'="A" D  Q:'XX                  ; If all of a give type of payer selected
 . . . S XX=$$ISTYPE^RCDPEU1(344.4,DA,RCTYPE)   ; Check that payer matches type
 . . ;
 . . D DIQ3444(DA,DR,.RCDPDATA)                 ; Extract Trace #, Payer Name/TIN, ERA Date
 . . ;
 . . ; HIPPA 5010 - display of the Trace # on a separate line due to the increased
 . . ; length from 30 to 50 characters   
 . . S RCX("TRACE")=$G(RCDPDATA(344.4,RCSUB,.02,"E"))
 . . S RCX("INCOID")=$G(RCDPDATA(344.4,RCSUB,.03,"E"))
 . . S RCX("PAYFROM")=$G(RCDPDATA(344.4,RCSUB,.06,"E"))
 . . ;
 . . ; Quit if the exception is not for a specified ERA (when called from the ERA worklist)
 . . I $G(RCDWLIEN)'="",(RCDWLIEN'=+RCSUB) Q
 . . ;
 . . S RCDECME=0 ; PRCA*4.5*326 - no point looking for ECME# on data exception.  It is not present.
 . . S RCS=0,ERAIEN=RCSUB                       ; PRCA*4.5*409 Added ,ERAIEN=RCSUB
 . . F  D  Q:'RCS
 . . . S RCS=$O(^RCY(344.4,"AEXC",RCER,RCMSG,RCS))
 . . . Q:'RCS
 . . . S RC0=$G(^RCY(344.4,RCMSG,1,RCS,0))
 . . . S DA(1)=RCMSG,DA=RCS,RCSUB=DA_","_DA(1)_","
 . . . S DR=".01;.02;.03;.05;.07;.08;.1;.11;.12;.15;.24;9.01",DA=RCS
 . . . D DIQ3444(.DA,DR,.RCDPDATA)
 . . . S RCX1=$$SETSTR^VALM1($E(RCX("PAYFROM"),1,25)_"/"_$E(RCX("INCOID"),1,20),"",9,78)
 . . . S RCX("SVCDT")=$$SDATE^RCDPEX4(RCMSG,RCS),RCX("SVCDT")=$E(RCX("SVCDT"),5,6)_"/"_$E(RCX("SVCDT"),7,8)_"/"_$E(RCX("SVCDT"),3,4)
 . . . S RCX1=$$SETSTR^VALM1(RCX("SVCDT"),RCX1,63,8)
 . . . S RCSEQ=RCSEQ+1
 . . . S RCX=$$SETSTR^VALM1($E(RCSEQ_$J("",4),1,4)_"  "_$G(RCX("TRACE")),"",1,80)
 . . . S XX=$G(RCDPDATA(344.4,RCMSG_",",.04,"I"))     ; ERA Date
 . . . S RCX=$$SETSTR^VALM1("  "_$$FMTE^XLFDT(XX,"2DZ"),RCX,70,10)
 . . . D SET(RCX,RCSEQ,RCMSG,RCS)
 . . . D SET(RCX1,RCSEQ,RCMSG,RCS)
 . . . ;
 . . . ; PRCA*4.5*409 Start
 . . . I $G(RCDPDATA(344.4,ERAIEN,.18,"E"))'="" D
 . . . . S RCX2="      ***ERA Removed from Worklist on "
 . . . . S XX=$G(RCDPDATA(344.4,ERAIEN,.17,"I"))
 . . . . S XX=$$FMTE^XLFDT(XX,"2DZ"),RCX2=RCX2_XX
 . . . . S RCX2=RCX2_" By: "_$G(RCDPDATA(344.4,ERAIEN,.16,"E"))_"***"
 . . . E  S RCX2=""
 . . . D:RCX2'="" SET(RCX2,RCSEQ,RCMSG,RCS)
 . . . S X=$$SETSTR^VALM1($J("",6)_"S: "_$G(RCDPDATA(344.41,RCSUB,.01,"E")),"",1,13)
 . . . S XX=$G(RCDPDATA(344.41,RCSUB,.02,"E"))
 . . . S RCBILL=$S(XX'="":XX,1:"*"_$G(RCDPDATA(344.41,RCSUB,.05,"E")))
 . . . S X=$$SETSTR^VALM1(" Bill: "_RCBILL,X,14,25)
 . . . S X=$$SETSTR^VALM1(" Pt: "_$G(RCDPDATA(344.41,RCSUB,.15,"E")),X,39,25)
 . . . S X=$$SETSTR^VALM1(" Pd: "_$J(+$G(RCDPDATA(344.41,RCSUB,.03,"E")),"",2),X,65,15)
 . . . ;
 . . . ; PRCA*4.5*409 End
 . . . D SET(X,RCSEQ,RCMSG,RCS)
 . . . ;
 . . . I +RCDECME D  ;PRCA*4.5*298 Display pharmacy data when ECME number is present
 . . . . S X=$$SETSTR^VALM1($J("",6)_"ECME #: "_$G(RCDPDATA(344.41,RCSUB,.24,"E")),X,1,28)
 . . . . N RCOMMNT,RCRLSDT  ; comment & release date
 . . . . ; IA #4701, RELEASE DATE for the prescription/fill
 . . . . S RCRLSDT=$$RXRLDT^PSOBPSUT($G(RCDPDATA(344.41,RCSUB,.24,"E")))   ; get release date
 . . . . S X=$$SETSTR^VALM1(" Release Date: "_$$FMTE^XLFDT(RCRLSDT),X,29,51)
 . . . . D SET(X,RCSEQ,RCMSG,RCS)
 . . . . S RCOMMNT=$G(RCDPDATA(344.41,RCSUB,9.01,"E"))  ; Rx comment
 . . . . S X=$$SETSTR^VALM1("      Comment: "_RCOMMNT,X,1,80)
 . . . . D SET(X,RCSEQ,RCMSG,RCS)
 . . . ;
 . . . ;I $P(RC0,U,11) D  ; removed PRCA*4.5*345
 . . . ;. S X=$J("",10)_"Transferred To: "_$G(RCDPDATA(344.41,RCSUB,.11,"E"))
 . . . ;. S XX=$$FMTE^XLFDT($G(RCDPDATA(344.41,RCSUB,.12,"I")),"2DZ")
 . . . ;. S X=$$SETSTR^VALM1("  On: "_XX,X,$L(X)+1,25)
 . . . ;. D SET(X,RCSEQ,RCMSG,RCS)
 . . . S XX=$G(RCDPDATA(344.41,RCSUB,.08,"E"))
 . . . S RCEXC=$S($G(RCDPDATA(344.41,RCSUB,.07,"I"))=99:$S(XX'="":XX,1:"UNKNOWN"),1:$G(RCDPDATA(344.41,RCSUB,.07,"E")))
 . . . ; PRCA*4.5*298 Remove comment " (TRANSFER NEEDED IF NOT YOURS)"
 . . . S X=$J("",10)_"**Exception: "_RCEXC
 . . . ;I $P(RC0,U,7)=1 D  ; removed PRCA*4.5*345
 . . . ; I $P(RC0,U,10)=0 S X=X_" (TRANSFER REJECTED)" Q
 . . . ; I $P(RC0,U,16) S X=X_" (TRANSFER ACKNOWLEDGED)" Q
 . . . ; S X=X_" (TRANSFER NOT ACKNOWLEDGED)"
 . . . D SET(X,RCSEQ,RCMSG,RCS)
 ;
 I '$D(^TMP("RCDPEX_SUM-EOB",$J)) D
 . S VALMCNT=2,^TMP("RCDPEX_SUM-EOB",$J,1,0)=" "
 . S ^TMP("RCDPEX_SUM-EOB",$J,2,0)="   There Are No EEOB Detail Exceptions On File"
 Q
 ;
FNL ;EP from listman template RCDPEX EOB_SUM EXCEPTION LIST 
 ; Clean up list
 K ^TMP("RCDPEX_SUM-EOBDX",$J)
 D CLEAN^VALM10
 K RCFASTXT
 Q
 ;
SET(X,RCSEQ,RCMSG,RCS) ; Set arrays for EOB exception records
 ; Input:   X       - Data to set into the global
 ;          RCSEQ   - Listman line #
 ;          RCMSG   - IEN for 344.41 multiple
 ;          RCS     - IEN for 344.4
 ; Output:  Line added to the listman body
 S VALMCNT=VALMCNT+1,^TMP("RCDPEX_SUM-EOB",$J,VALMCNT,0)=X
 S ^TMP("RCDPEX_SUM-EOB",$J,"IDX",VALMCNT,RCSEQ)=""
 S ^TMP("RCDPEX_SUM-EOBDX",$J,RCSEQ)=VALMCNT_U_RCMSG_U_RCS
 Q
 ;
HDR ;EP from listman template RCDPEX EOB_SUM EXCEPTION LIST
 N X,Y
 S VALMHDR(1)=$J("",19)_"EEOB DETAIL DATA WITH EXCEPTION CONDITIONS"
 ;Add second header line to show filter selection, PRCA*4.5*439
 S X="INSURANCE CO.: "_$S(RCPAY="R":"RANGE",RCPAY="S":"SELECTED",1:"ALL")
 S X=X_"     CHAMPVA/MEDICAL/PHARM/TRICARE: "_$S(RCTYPE="P":"PHARMACY",RCTYPE="T":"TRICARE",RCTYPE="C":"CHAMPVA",RCTYPE="M":"MEDICAL",1:"ALL")
 S Y="",$P(Y," ",((79-$L(X))/2))="",X=Y_X
 S VALMHDR(2)=X
 ; 
 ; HIPPA 5010 - display of the following headers on a separate line due to the
 ; increased length of Trace # from 30 to 50 characters
 S VALMHDR(3)="  #   Trace #"_$J("",58)_"EOB Date"  ;PRCA*4.5*439 Change from line 2 to line 3
 Q
 ;
DIQ3444(DA,DR,RCPDATA) ; DIQ call to retrieve data for DR fields in file 344.4/344.41
 ; Input:   DA      - IEN for file 344.4
 ;          DR      - Semi-colon delimitted list of fields to be retrieved
 ; Output:  RCPDATA - Array of selected fields
 N %I,D0,DIC,DIQ,DIQ2,FILE,YY
 S FILE=$S($D(DA(1)):344.41,1:344.4)
 K RCDPDATA(FILE)
 D GETS^DIQ(FILE,DA_","_$S($G(DA(1)):DA(1)_",",1:""),DR,"EI","RCDPDATA")
 Q
 ;
