BPSUSCR4 ;BHAM ISC/FLS - USER SCREEN ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ; COLLECT - Compile stranded claims
 ;   Input:
 ;     BPARR - Date Range
 ;   Output:
 ;     ^TMP("BPSUSCR",$J)
 ;     ^TMP("BPSUSCR-1",$J)
 ;     ^TMP("BPSUSCR-2",$J)
COLLECT(BPARR) ;
 N TFILE,CFILE,SDT,STATUS,IEN59,VART,LSTUDT,CD0,DATA
 N RX,REFILL,NAME,SSN,INSCO,FILLDT,SEQ,ITEM,MESSAGE
 N BPIEN77,BPSTATUS
 K BPBDT,BPEDT
 K ^TMP("BPSUSCR-1",$J),^TMP("BPSUSCR-2",$J),^TMP("BPSUSCR",$J)
 S VALMCNT=0,TFILE=9002313.59,CFILE=9002313.02
 S BPBDT=BPARR("BDT") ;start date and time
 S BPEDT=BPARR("EDT") ;end date and time
 ;
 ; Loop through all statii from 0 to 98
 S STATUS=-1
 F  S STATUS=$O(^BPST("AD",STATUS)) Q:STATUS>98!(STATUS="")  D
 . ; Status of 31 is Insurer Asleep - these will process when insurer wakes up
 . ; Insurer asleep disabled for Phase III so these should appear on the report for now
 . ;I STATUS=31 Q
 . S IEN59=0
 . F  S IEN59=$O(^BPST("AD",STATUS,IEN59)) Q:'IEN59  D
 .. S VART=$G(^BPST(IEN59,0)) Q:VART=""
 .. S LSTUDT=$$GET1^DIQ(TFILE,IEN59,7,"I")
 .. I LSTUDT<BPBDT!(LSTUDT>BPEDT) Q
 .. S LSTUDT=$P(LSTUDT,".",1)
 .. I LSTUDT="" Q
 .. S RX=$$GET1^DIQ(TFILE,IEN59,1.11)
 .. S REFILL=$$GET1^DIQ(TFILE,IEN59,9)
 .. S CD0=$$GET1^DIQ(TFILE,IEN59,3,"I")
 .. I CD0'="" D
 ... S FILLDT=$$GET1^DIQ(CFILE,CD0,401),FILLDT=$$HL7TFM^XLFDT(FILLDT)
 .. I CD0="" D
 ... S FILLDT=$P($G(^BPST(IEN59,12)),"^",2)
 .. S NAME=$$GET1^DIQ(TFILE,IEN59,5,"E")
 .. S SSN="",VART=$G(^BPST(IEN59,0))
 .. I $P(VART,"^",6)]"" S SSN=$P($G(^DPT($P(VART,"^",6),0)),"^",9),SSN=$E(SSN,$L(SSN)-3,$L(SSN))
 .. S INSCO=$P($G(^BPST(IEN59,10,1,0)),"^",7)
 .. S ^TMP("BPSUSCR-1",$J,LSTUDT,IEN59)=NAME_U_SSN_U_RX_U_REFILL_U_FILLDT_U_INSCO_U_STATUS
 ;
 ;look for stranded requests
 D COLACTRQ^BPSUSCR2(.BPARR)
 ;
 ; Now that the data is sorted, format it and build list for display
 S (SEQ,ITEM)=0
 S SDT="" F  S SDT=$O(^TMP("BPSUSCR-1",$J,SDT)) Q:SDT=""  D
 . S IEN59="" F  S IEN59=$O(^TMP("BPSUSCR-1",$J,SDT,IEN59)) Q:IEN59=""  D
 .. S DATA=$G(^TMP("BPSUSCR-1",$J,SDT,IEN59))
 .. S LSTUDT=$$FORMAT($$FMTE^XLFDT(SDT,"5Z"),10)
 .. S NAME=$$FORMAT($P(DATA,U,1),20)
 .. S SSN=$$FORMAT($P(DATA,U,2),4)
 .. S RX=$$FORMAT($P(DATA,U,3),12)
 .. S REFILL=$J($P(DATA,U,4),2)
 .. S FILLDT=$$FMTE^XLFDT($P(DATA,U,5),"5Z")
 .. S INSCO=$$FORMAT($P(DATA,U,6),12)
 .. S BPSTATUS=+$P(DATA,U,7)
 .. S BPIEN77=$P(DATA,U,8)
 .. S SEQ=SEQ+1
 .. S ITEM=ITEM+1
 .. S ^TMP("BPSUSCR",$J,SEQ,0)=$J(ITEM,3)_" "_LSTUDT_" "_NAME_" "_SSN_" "_RX_" "_REFILL_" "_FILLDT_" "_INSCO
 .. S ^TMP("BPSUSCR-2",$J,ITEM,IEN59)=BPIEN77
 .. S SEQ=SEQ+1
 .. S MESSAGE=$$STATI^BPSOSU($P(DATA,U,7))
 .. I $E(MESSAGE,1)="?" S MESSAGE="Unknown Status"
 .. S ^TMP("BPSUSCR",$J,SEQ,0)="    In Progress - "_MESSAGE
 S VALMCNT=SEQ
 Q
 ;
FORMAT(D1,LEN) ;
 N OUT
 S D1=$G(D1),LEN=$G(LEN)
 S D1=$$NOSPACE(D1)
 S OUT=$E($E(D1,1,LEN)_$J("",LEN),1,LEN)
 Q OUT
NOSPACE(VAR) ;
 N RTN,SEQ,I
 S RTN=""
 F I=1:1:$L(VAR," ") I $P(VAR," ",I)'="" S SEQ=$G(SEQ)+1,$P(RTN," ",SEQ)=$P(VAR," ",I)
 Q RTN
