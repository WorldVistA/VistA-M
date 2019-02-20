RCDPEAR3 ;AITC/CJE - ERA Unmatched Aging Report ;
 ;;4.5;Accounts Receivable;**321**;;Build 48
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; PRCA*4.5*321 overflow routine for and RCDPEAR2
 ; SELPAY and RLOAD moved from RCDPEAR1 to meet SAC size limit
SELPAY(RCRESPYR,RCJOB,RCPAY) ;localize the payer filters for header display
 ; Input:
 ;   RCRESPYR (pass-by-val/required) - payer filter response indicator (2=ALL, 3=SPECIFIC)
 ;   RCJOB - job number to access the populated temporary global array in case report was tasked to run
 ; Output:
 ;   RCPAY (pass-by-ref/required) - local array of payers e.g. RCPAY="ALL", RCPAY(1)="Aetna",
 ;                                  or RCPAY="start payer = end payer"
 N CNT,I
 I RCRESPYR=2 S RCPAY="ALL" Q
 S:RCJOB="" RCJOB=$J   ; RCJOB should not be null
 I RCRESPYR=3 D  Q
 .S CNT=0
 .F  S CNT=$O(^TMP("RCSELPAY",RCJOB,CNT)) Q:'CNT  D
 ..S RCPAY(CNT)=^TMP("RCSELPAY",RCJOB,CNT)
 ; RCRESPYR indicates a range of payers
 S I=$O(^TMP("RCSELPAY",RCJOB,"")),RCPAY=^(I)_" - "
 S I=$O(^TMP("RCSELPAY",RCJOB,""),-1),RCPAY=RCPAY_^(I)
 Q
 ;
RLOAD(FILE) ; PRCA*4.5*284 - Load Payer temp global AFTER queued job starts
 ; Load Selected payers from local array end exit
 ; Input: FILE to load payers from (344.31 passed from RCDPEAR2)
 ; Output: ^TMP("RCPAYER") and ^TMP("RCSELPAY") arrays
 ;
 I +RCRESPYR=3 M ^TMP("RCSELPAY",$J)=RCPYRLST Q
 N CNT,INDX,NUM,RCINSF,RCINST,RCPAY
 ;
 ; Load ALL payers and exit
 I +RCRESPYR=2 D  Q
 .S CNT=0,RCPAY="" F  S RCPAY=$O(^RCY(FILE,"C",RCPAY)) Q:RCPAY=""  S CNT=CNT+1,^TMP("RCSELPAY",$J,CNT)=RCPAY
 ;
 ; Range of Payers
 ; Build list of available stations
 K ^TMP("RCPAYER",$J)  ; Clear residual list data
 S CNT=0,RCPAY=""
 F  S RCPAY=$O(^RCY(FILE,"C",RCPAY)) Q:RCPAY=""  S CNT=CNT+1,^TMP("RCPAYER",$J,CNT)=RCPAY,^TMP("RCPAYER",$J,"B",RCPAY,CNT)=""
 ;
 S RCINSF=$P(RCRESPYR,"^",2),RCINST=$P(RCRESPYR,"^",3),INDX=1
 F  S RCINSF=$O(^TMP("RCPAYER",$J,"B",RCINSF)) Q:RCINSF=""  Q:RCINSF]RCINST  D
 .S NUM=$O(^TMP("RCPAYER",$J,"B",RCINSF,""))
 .S ^TMP("RCSELPAY",$J,INDX)=$G(^TMP("RCPAYER",$J,NUM)),INDX=INDX+1
 Q
 ;
