IBCE277 ;ALB/TMP - 277 EDI CLAIM STATUS MESSAGE PROCESSING ;15-JUL-98
 ;;2.0;INTEGRATED BILLING;**137,155,368,403**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; MESSAGE HEADER DATA STRING =
 ;   type of message^msg queue^msg #^bill #^REF NUM/Batch #^date/time
 ;
HDR(ENTITY,ENTVAL,IBTYPE,IBD) ;Process header data
 ; INPUT:
 ;   ENTITY = "BATCH" or "CLAIM" for batch/claim level messages respectively
 ;   ENTVAL = claim #
 ;   IBTYPE = the type of status msg this piece of the message represents
 ;             (837REC1, 837REJ1)
 ;   ^TMP("IBMSGH",$J,0) = header message text
 ;
 ; OUTPUT:
 ;   IBD array returned with processed data
 ;      "DATE" = Date/Time of status (Fileman format)
 ;      "MRA" =  1 if MRA, 0 if not         "X12" = 1 if X12, 0 if not
 ;      "BATCH" = Batch ien for batch level calls
 ;      "SOURCE" = Source of message code^source name, if known
 ;
 ;   ^TMP("IBMSG",$J,"BATCH",batch #,0)=MESSAGE HEADER DATA STRING
 ;                                      if batch level message
 ;                                  ,"D",0,1)=header record raw data
 ;                                  ,line #)=batch status message lines
 ;
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,0)=MESSAGE HEADER DATA STRING
 ;                                      if claim level message
 ;                                  ,"D",0,1)=header record raw data
 ;                                  ,line #)=claim status message lines
 ;
 N DATA,IBD0,L,PC,X,Y
 S IBD0=$G(^TMP("IBMSGH",$J,0)) Q:IBD0=""
 S Y=0,L=1
 ; Convert claim date/time
 S X=$$DATE($P(IBD0,U,3))_"@"_$E($P(IBD0,U,4)_"0000",1,4) I X S %DT="XTS" D ^%DT
 ; populate IBD array
 S IBD("DATE")=$S(Y>0:Y,1:""),IBD("MRA")=$P(IBD0,U,5),IBD("X12")=($P(IBD0,U,2)="X")
 S IBD("SOURCE")=$P(IBD0,U,12,13),IBD("BATCH")=$P(IBD0,U,14)
 I +$TR($P(IBD0,U,6,9),U) F PC=6:1:9 D
 .I $P(IBD0,U,PC)'="" S DATA=$P("# Claims Submitted^# Claims Rejected^Total Charges Submitted^Total Charges Rejected",U,PC-5)_": "_$S(PC<8:+$P(IBD0,U,PC),1:$FNUMBER($P(IBD0,U,PC)/100,"",2))_"  "
 .I $L($G(^TMP("IBMSG-H",$J,ENTITY,ENTVAL,L)))+$L(DATA)>70 S L=L+1 ; if data doesn't fit into current line, go to the next line
 .S ^TMP("IBMSG-H",$J,ENTITY,ENTVAL,L)=$G(^TMP("IBMSG-H",$J,ENTITY,ENTVAL,L))_DATA ; file this piece of data
 .Q
 ; file batch ref. number
 S:IBD("BATCH")'="" L=L+1,^TMP("IBMSG-H",$J,ENTITY,ENTVAL,L)="Batch Reference Number: "_IBD("BATCH")
 I $TR($P(IBD0,U,10,13),U)'="" D
 .S L=L+1
 .; generate and file Payer Name / Payer Id line
 .S DATA="Payer Name: "_$S($P(IBD0,U,10)'="":$P(IBD0,U,10),1:"N/A")_"  Payer ID: "_$S($P(IBD0,U,11)'="":$P(IBD0,U,11),1:"N/A")
 .S ^TMP("IBMSG-H",$J,ENTITY,ENTVAL,L)=DATA
 .I $P(IBD0,U,12)'=""!($P(IBD0,U,13)'="") D
 ..; generate and file Message Source line
 ..S DATA="Source: "_$S($P(IBD0,U,12)="Y":"Sent by payer",$P(IBD0,U,13)'="":"Sent by non-payer ("_$P(IBD0,U,13)_")",1:"UNKNOWN")
 ..S L=L+1,^TMP("IBMSG-H",$J,ENTITY,ENTVAL,L)=DATA
 ..Q
 .Q
 S ^TMP("IBMSG",$J,ENTITY,ENTVAL,0)=IBTYPE_U_$G(IBD("MSG#"))_U_$G(IBD("SUBJ"))_U_$$GETBILL(ENTVAL)_U_U_IBD("DATE")_U_IBD("SOURCE")
 ; file raw data
 S ^TMP("IBMSG",$J,ENTITY,ENTVAL,"D",0,1)="##RAW DATA: "_IBD0
 Q
 ;
9(IBD) ; Process Message Header record
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ; OUTPUT:
 ;   IBD array returned with processed data
 ;      "CLAIM" = claim #
 ;      "LINE" = last line # populated in the message
 ;
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,line#)= message data lines
 ;                                  ,"D",9,msg seq #)= raw data
 N ENTITY,ERR,FLD,IBCLM,IBIFN,L
 D STRTREC Q:IBCLM=""  ; if no claim/batch number, bail out
 ; make sure that we have data to file
 S ERR=$P(IBD,U,4) Q:ERR=""
 ; file error along with corresponding field number (if available)
 S L=L+1,FLD=$P(IBD,U,5),^TMP("IBMSG",$J,ENTITY,IBCLM,L)="Error"_$S(FLD'="":" in field "_FLD,1:"")_":"
 S L=L+1,^TMP("IBMSG",$J,ENTITY,IBCLM,L)=ERR
 D ENDREC(9)
 Q
 ;
10(IBD) ; Process message data
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ; OUTPUT:
 ;   IBD array returned with processed data
 ;      "CLAIM" = claim #
 ;      "LINE" = last line # populated in the message
 ;
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,line#)= message data lines
 ;                                  ,"D",10,msg seq #)= raw data
 ;   ^TMP("IBCONF",$J,claim #")="" for invalid claims within the batch
 ;
 N CODE,DATA,ENTITY,IBCLM,IBIFN,IBTYPE,L,Z
 D STRTREC Q:IBCLM=""  ; if no claim number, bail out
 S:$P(IBD,U,3)="R" ^TMP("IBCONF",$J,IBIFN)=""
 S IBTYPE=$S($P(IBD,U,3)="R":"837REJ1",1:"837REC1")
 ;Process header data if not already done
 I '$D(^TMP("IBMSG",$J,ENTITY,IBCLM,0)) D HDR(ENTITY,IBCLM,IBTYPE,.IBD)
 I IBTYPE="837REJ1",$P($G(^TMP("IBMSG",$J,ENTITY,IBCLM,0)),U,1)'="837REJ1" D HDR(ENTITY,IBCLM,IBTYPE,.IBD)
 S CODE=$P(IBD,U,4) I CODE'="",$TR($P(IBD,U,5,6),U)'="" D
 .S Z=CODE_$P(IBD,U,5) I Z'=$G(IBD("SCODE")) D
 ..; determine type of status code and file it
 ..S L=L+1,DATA=$S(CODE="W":"Warning",CODE="E":"Error",1:"Informational")_" "
 ..I $P(IBD,U,5)'="" S ^TMP("IBMSG",$J,ENTITY,IBCLM,L)=DATA_"Code: "_$P(IBD,U,5)
 ..I $P(IBD,U,6)'="" S:$P(IBD,U,5)'="" L=L+1 S ^TMP("IBMSG",$J,ENTITY,IBCLM,L)=DATA_"Message:",L=L+1
 ..S IBD("SCODE")=Z
 ..Q
 .; file status message
 .I $P(IBD,U,6)'="" S ^TMP("IBMSG",$J,ENTITY,IBCLM,L)=$P(IBD,U,6),L=L+1,^TMP("IBMSG",$J,ENTITY,IBCLM,L)=" "
 .Q
 D ENDREC(10)
 Q
 ;
13(IBD) ; Process claim data
 ; Claim must have been referenced by a previous '10' level
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;
 ; OUTPUT:
 ;      IBD("LINE") = The last line # populated in the message
 ;
 ;     ^TMP("IBMSG",$J,"CLAIM",claim #,line#)=claim data lines
 ;                                    ,"D",13,msg seq #)=raw data
 ;
 N CTYPE,ENTITY,IBCLM,IBIFN,L,Z1,Z2
 D STRTREC
 ; quit if no claim number or no previous 'line 10' record
 Q:$S(IBCLM="":1,1:'$D(^TMP("IBMSG",$J,"CLAIM",IBCLM)))
 ; file clearinghouse trace number
 I $P(IBD,U,3)'="" S L=L+1,^TMP("IBMSG",$J,ENTITY,IBCLM,L)="Clearinghouse Trace Number: "_$P(IBD,U,3)
 ; file payer status date
 I $P(IBD,U,4)'="" S L=L+1,^TMP("IBMSG",$J,ENTITY,IBCLM,L)="         Payer Status Date: "_$$DATE($P(IBD,U,4))
 ; file payer claim number
 I $P(IBD,U,5)'="" S L=L+1,^TMP("IBMSG",$J,ENTITY,IBCLM,L)="        Payer Claim Number: "_$P(IBD,U,5)
 ; file split claim indicator
 I +$P(IBD,U,6)'=0 S L=L+1,^TMP("IBMSG",$J,ENTITY,IBCLM,L)="               Split Claim: "_$S(+$P(IBD,U,6)=1:"No",1:"Yes ("_+$P(IBD,U,6)_" parts)")
 ; file claim type if it either doesn't match value in VistA or if it's a dental claim
 S Z1=$P(IBD,U,7),Z2=$$FT^IBCEF(IBIFN),CTYPE=$S(Z1="P"&(Z2'=2):"Professional",Z1="I"&(Z2'=3):"Institutional",Z1="D":"Dental",1:"")
 S:CTYPE'="" L=L+1,^TMP("IBMSG",$J,ENTITY,IBCLM,L)="                Claim Type: "_CTYPE
 D ENDREC(13)
 Q
 ;
15(IBD) ; Process subscriber/patient data
 ; Claim must have been referenced by a previous '10' level
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;
 ; OUTPUT:
 ;      IBD("LINE") = The last line # populated in the message
 ;
 ;     ^TMP("IBMSG",$J,"CLAIM",claim #,line#)=formatted service dates
 ;                                    ,"D",15,msg seq #)=
 ;                                         subscr/patient raw data
 ;
 N ENTITY,DATA,IBCLM,IBIFN,IBNM,IBNUM,IBDFN,L
 D STRTREC
 ; quit if no claim number or no previous 'line 10' record
 Q:$S(IBCLM="":1,1:'$D(^TMP("IBMSG",$J,"CLAIM",IBCLM)))
 S IBDFN=+$P(^DGCR(399,IBIFN,0),U,2)
 S IBNM=$S($P(IBD,U,3)'="":$P(IBD,U,3)_","_$P(IBD,U,4)_$S($P(IBD,U,5)'="":" "_$P(IBD,U,5),1:""),1:$P($G(^DPT(IBDFN,0)),U))
 S IBNUM=$S($P(IBD,U,6)'="":$P(IBD,U,6),1:$P($G(^DPT(IBDFN,0)),U,9))
 S L=L+1,^TMP("IBMSG",$J,ENTITY,IBCLM,L)="Patient: "_IBNM_"   "_IBNUM
 I $P(IBD,U,11) D
 .S DATA=$$DATE($P(IBD,U,11)),L=L+1
 .S ^TMP("IBMSG",$J,ENTITY,IBCLM,L)="Service Dates: "_DATA_" - "_$S($P(IBD,U,12):$$DATE($P(IBD,U,12)),1:DATA)
 .Q
 D ENDREC(15)
 Q
 ;
STRTREC ; start processing of the record
 ;           
 ; OUTPUT:
 ;   sets the following variables
 ;   IBCLM = claim #
 ;   ENTITY = "CLAIM" (all 277STAT messages are on claim level)
 ;   L = last populated line number
 ;
 S IBCLM=$$GETCLM($P(IBD,U,2)),ENTITY="CLAIM",L=+$G(IBD("LINE"))
 S IBIFN=+$O(^DGCR(399,"B",IBCLM,0))
 Q
 ;
ENDREC(TYPE) ; finish processing of the record
 ; INPUT:
 ;   TYPE = record type (line type)
 ;   
 ; OUTPUT:
 ;   IBD("LINE") = is updated with last populated line number
 ;
 ;make sure all variables are set properly
 Q:$G(ENTITY)=""
 Q:$G(IBCLM)=""
 Q:$G(TYPE)=""
 ; file raw data
 S ^TMP("IBMSG",$J,ENTITY,IBCLM,"D",TYPE,$O(^TMP("IBMSG",$J,ENTITY,IBCLM,"D",TYPE,""),-1)+1)="##RAW DATA: "_IBD
 ; update line count
 S IBD("LINE")=$G(IBD("LINE"))+L
 Q
 ;
GETBILL(CLAIM) ; Extract transmission #
 N PREC,STATUS,TRANS
 S TRANS=$$LAST364^IBCEF4(IBIFN),PREC=0
 ; if status of the last transmission is "X" or "P", keep searching backwards through file 364 until record
 ; with different status is found; if there's only one "P" record present, save it off in PREC
 I TRANS F  S STATUS=$P(^IBA(364,TRANS,0),U,3) Q:"XP"'[STATUS  S:STATUS="P" PREC=$S(PREC=0:+TRANS,1:-1) S TRANS=$O(^IBA(364,"B",IBIFN,TRANS),-1) Q:TRANS=""  ;
 ; if we didn't find any good records, and there's only one "P" record present, use this "P" record
 I TRANS="",PREC>0 S TRANS=PREC
 Q +TRANS
 ;
DATE(DT) ; Convert YYMMDD Date into MM/DD/YY or YYYYMMDD into MM/DD/YYYY
 N D,Y
 S D=DT,Y=""
 I $L(DT)=8 S D=$E(DT,3,8),Y=$E(DT,1,2)
 Q ($E(D,3,4)_"/"_$E(D,5,6)_"/"_Y_$E(D,1,2))
 ;
GETCLM(X) ; Extract the claim # without site id from the data in X
 N IBCLM
 S IBCLM=$P(X,"-",2) I IBCLM="",X'="" S IBCLM=$E(X,$S($L(X)>7:4,1:1),$L(X))
 Q IBCLM
 ;
