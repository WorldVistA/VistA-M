YTQRRPT ;SLC/LLH - Report Builder ; 08/13/2018
 ;;5.01;MENTAL HEALTH;**130,141,172**;Dec 30, 1994;Build 10
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; DIQ                   2056
 ; XLFDT                10103
 ; XLFNAME               3065
 ; XLFSTR               10104
 ;
BLDRPT(RESULTS,ADMIN,MAXWIDTH) ;
 N ADATA,ANS,INST,LP,PDATA,RPT,RSTR,SCL,SWAP,YSDATA,YS,TSTNM
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Not Found: "_ADMIN) Q
 S INST=$P(^YTT(601.84,ADMIN,0),U,3)
 I $P($G(^YTT(601.71,INST,8)),U,3)="Y" D  QUIT  ; call legacy report
 . N I,J
 . S YS("AD")=ADMIN
 . D LEGACY^YTQAPI8(.YSDATA,.YS)
 . ; only have 1 empty line at the top
 . S I=0 F  S I=$O(^TMP("YSDATA",$J,1,I)) Q:'I  Q:$L(^TMP("YSDATA",$J,1,I))
 . S I=I-2,J=0 F  S I=$O(^TMP("YSDATA",$J,1,I)) Q:'I  S J=J+1,RESULTS(J)=^(I)
 ; continue here if not legacy report
 I '$D(^YTT(601.93,"C",INST)) D SETERROR^YTQRUTL(404,"Not Found: "_INST) Q
 S RPT=$O(^YTT(601.93,"C",INST,"")) I '$G(RPT) D SETERROR^YTQRUTL(404,"Not Found: "_INST) Q 
 S YS("AD")=ADMIN
 S TSTNM=$P($G(^YTT(601.71,$P(^YTT(601.84,ADMIN,0),U,3),0)),U)
 K ^TMP($J)
 D ADMINFO(.ADATA,ADMIN)          ;get Administration information
 D PATINFO(.PDATA,ADATA("DFN"))   ;get Patient demographic information
 D SWAPIT                         ;load report variables with data
 D GETSCORE^YTQAPI8(.YSDATA,.YS)  ;get scale scores
 D SETSCL                         ;put in array to swap values
 D ALLANS^YTQAPI2(.YSDATA,.YS)    ;get answers
 D SWAPANS                        ;load report answer vars with data
 D LOADTLT(.RSTR,RPT)             ;load the report template
 I '$D(RSTR) D SETERROR^YTQRUTL(404,"Not Found: "_RPT) Q
 I $P(^YTT(601.71,+$P(^YTT(601.93,RPT,0),U,2),0),U)="AUDC" D VARYAUDC(.RSTR,ADMIN)
 D GETDATA                        ;insert the data from the answer vars
 I $G(MAXWIDTH)>1 D WRAPTLT(.RSTR,MAXWIDTH) ; wrap for progress notes
 ;Loop back through completed array to replace "|" (line feeds) with a blank line with a space
 D FIXP(.RSTR,.RESULTS)
 Q
LOADTLT(TLT,RPT) ; Load template for RPT into .TLT split by "|" chars
 ; resulting TLT array uses $C(10) to represent line breaks
 N LP,LN,LF,FRAG,X,START,END
 S LF=$C(10),LN=0,FRAG=" "
 S LP=0 F  S LP=$O(^YTT(601.93,RPT,1,LP)) Q:'LP  D
 . S X=^YTT(601.93,RPT,1,LP,0)
 . I LP=1 S X=$$RMVDOTS(X)              ; drop initial dots, linefeeds
 . I X["$~" S X=$P(X,"$~"),LP=9999999   ; $~ marks end of report
 . S START=0 F  S END=$F(X,"|",START) D  Q:'START
 . . I END D  Q
 . . . S LN=LN+1
 . . . S TLT(LN)=FRAG_$E(X,START,END-2)_LF
 . . . S FRAG=" ",START=END
 . . E  D
 . . . S FRAG=FRAG_$E(X,START,$L(X))
 . . . S START=0
 I $L(FRAG) S LN=LN+1,TLT(LN)=FRAG_LF
 Q
RMVDOTS(X) ; Return X with the initial line feed / dots removed
 N I,FVC S FVC=0 F I=1:1 D  Q:FVC
 . Q:$E(X,I)="|"  Q:$E(X,I)=" "  Q:$E(X,I)="."
 . S FVC=I
 F I=FVC:-1:0 Q:$E(X,I)="|"
 Q $E(X,I+1,$L(X))
 ;
WRAPTLT(TLT,MAX) ; Wrap lines in TLT that are >WIDTH by adding $C(10)
 N I
 S I=0 F  S I=$O(TLT(I)) Q:'I  I $L(TLT(I))'<MAX S TLT(I)=$$WRAP(TLT(I),MAX)
 Q
FIXP(RSTR,RESULTS) ;
 N LP,LN,LF,FRAG,START,END
 S LN=0,LF=$C(10),FRAG=""
 S LP=0 F  S LP=$O(RSTR(LP)) Q:'LP  D
 . S START=0 F  S END=$F(RSTR(LP),LF,START) D  Q:'START
 . . I END D  Q
 . . . S LN=LN+1
 . . . S RESULTS(LN)=FRAG_$E(RSTR(LP),START,END-2)
 . . . I RESULTS(LN)="." S RESULTS(LN)=" "
 . . . S FRAG="",START=END
 . . E  D
 . . . S FRAG=FRAG_$E(RSTR(LP),START,$L(RSTR(LP)))
 . . . S START=0
 Q
GETDATA ;
 N LP
 S LP=0 F  S LP=$O(RSTR(LP)) Q:'LP  S RSTR(LP)=$$REPLACE^XLFSTR(RSTR(LP),.SWAP)
 Q
ADMINFO(ADATA,ADMIN) ;
 N CLIN,DATA,MYNAME
 S DATA=^YTT(601.84,ADMIN,0)
 S CLIN=$$GET1^DIQ(601.84,ADMIN_",",5,"I")
 S MYNAME("FILE")=200
 S MYNAME("FIELD")=.01
 S MYNAME("IENS")=CLIN_","
 S ADATA("DFN")=$P($G(^YTT(601.84,ADMIN,0)),U,2)
 S ADATA("DATE")=$$FMTE^XLFDT($P($G(^YTT(601.84,ADMIN,0)),U,4),"5DZ")
 S ADATA("ORDERED")=$$NAMEFMT^XLFNAME(.MYNAME,"F","MCXc")         ;Ordered by
 S ADATA("LOC")=$$TITLE^XLFSTR($$GET1^DIQ(601.84,ADMIN_",",13))   ;Location
 Q
PATINFO(PDATA,DFN) ;
 N YS,YSDATA,MYNAME,DOB
 I '$G(DFN) Q
 S YS("DFN")=DFN
 S MYNAME("FILE")=2
 S MYNAME("FIELD")=.01
 S MYNAME("IENS")=DFN_","
 D PATSEL^YTQAPI9(.YSDATA,.YS)
 S DOB=$P(YSDATA(4),U,2),$E(DOB,2,3)=$$LOW^XLFSTR($E(DOB,2,3))
 S PDATA("NM")=$$NAMEFMT^XLFNAME(.MYNAME,"F","MCXc")
 S PDATA("SSN")="xxx-xx-"_$P($P(YSDATA(3),U,2),"-",3)
 S PDATA("DOB")=DOB
 S PDATA("AGE")=$P(YSDATA(5),U)
 S PDATA("GENDER")=$$SENTENCE^XLFSTR($P(YSDATA(6),U,2))
 K VA
 Q
SWAPIT ;
 N LP,TXT
 F LP=1:1 S TXT=$T(SWAP+LP) Q:TXT["zzzzz"  S SWAP($P(TXT,";;",2))=@($P(TXT,";;",3))
 S SWAP("<.DLL_String.>")="Complex Instrument"
 Q 
SWAP ;
 ;;<.Date_Given.>;;ADATA("DATE")
 ;;<.Staff_Ordered_By.>;;ADATA("ORDERED")
 ;;<.Location.>;;ADATA("LOC")
 ;;<.Patient_Name_Last_First.>;;PDATA("NM")
 ;;<.Patient_SSN.>;;PDATA("SSN")
 ;;<.Patient_Date_Of_Birth.>;;PDATA("DOB")
 ;;<.Patient_Age.>;;PDATA("AGE")
 ;;<.Patient_Gender.>;;PDATA("GENDER")
 ;;zzzzz
 Q
SWAPANS ;
 N QSTN,SEQ,ANS,ANSID,LP,STR,MAX,X
 I '$D(YSDATA)!($G(YSDATA(1))'="[DATA]") Q
 S MAX=$S($G(MAXWIDTH):MAXWIDTH,1:80)
 F QSTN=7771:1:7787 S SWAP("<*Answer_"_QSTN_"*>")=""  ; default for computed
 S LP=2 F  S LP=$O(YSDATA(LP)) Q:'LP  D
 . S QSTN=$P(YSDATA(LP),U),SEQ=$P(YSDATA(LP),U,2),ANS=$P(YSDATA(LP),U,3)
 . S ANSID="<*Answer_"_QSTN_"*>"
 . I ANS["|" S ANS=$$FMTANS(ANS) ; replace "|" chars with LF_"   "
 . ; <*Answer_999999999999*> is the DLL string (special code for MMPI-2-RF)
 . I QSTN=999999999999 S SWAP(ANSID)=$S(TSTNM="MMPI-2-RF":$TR(ANS,":","|"),1:ANS) Q
 . ; text answers (and 7771:7787) have ";" in the sequence
 . I SEQ[";" S SWAP(ANSID)=$G(SWAP(ANSID))_ANS Q
 . ; capitalize skipped, special text for AUDC
 . I ANS=1155 S SWAP(ANSID)="SKIPPED" Q
 . I ANS=1156 D  Q
 . . I TSTNM="AUDC" S SWAP(ANSID)="Not asked (patient reports no drinking in past year)" I 1
 . . E  S SWAP(ANSID)="Not asked (due to responses to other questions)"
 . I ANS=1157 S SWAP(ANSID)="Skipped, but required" Q
 . ; get text for multiple choice questions
 . I $P($G(^YTT(601.72,QSTN,2)),U,2)=1 S SWAP(ANSID)=$P($G(^YTT(601.75,ANS,1)),U) Q
 . ; unanswered date question 
 . I ANS="12/30/1899" S SWAP(ANSID)="" Q
 . ; bad data answer
 . I ANS="[BAD DATA]" S SWAP(ANSID)="Not Specified" Q
 . ; otherwise
 . S SWAP(ANSID)=ANS
 ;
 ; loop thru SWAP array & make sure all responses wrapped to MAX chars
 S X="<*" F  S X=$O(SWAP(X)) Q:'$L(X)  Q:$E(X,1,2)'="<*"  D
 . I $L(SWAP(X))'>MAX Q             ; already under max chars
 . I X="<*Answer_999999999999*>" Q  ; DLLStr already wrapped
 . S SWAP(X)=$$WRAP(SWAP(X),MAX)    ; wrap by adding | chars
 Q
FMTANS(ANS) ; return answer string with $C(10))_"   " for "|" chars
 N SWITCH S SWITCH("|")=$C(10)_"   "
 Q $$REPLACE^XLFSTR(ANS,.SWITCH)
 ;
SETSCL ;
 N LP,STR
 I '$D(^TMP($J,"YSCOR")) Q
 F LP=2:1 Q:('$D(^TMP($J,"YSCOR",LP)))!($G(^TMP($J,"YSCOR",1))="[ERROR]")  D
 .S STR=$G(^TMP($J,"YSCOR",LP))
 .S SWAP("<-"_$P(STR,"=")_"->")=$P($P(STR,"=",2),U) ; use raw score
 Q
WRAP(TX,MAX) ; If length of TX > MAX, wrap by adding $C(10)
 N OUT,I,J,X,Y,YNEW,LF
 S LF=$C(10)
 F I=1:1:$L(TX,LF) S X=$P(TX,LF,I) D
 . I $L(X)'>MAX D ADDOUT(X) QUIT
 . S Y=""
 . F J=1:1:$L(X," ") D
 . . S YNEW=Y_$S(J=1:"",1:" ")_$P(X," ",J)
 . . I $L(YNEW)>MAX D ADDOUT(Y) S Y=$P(X," ",J) I 1
 . . E  S Y=YNEW
 . D ADDOUT(Y) ; add any remaining
 S X="",I=0 F  S I=$O(OUT(I)) Q:'I  S X=X_$S(I=1:"",1:LF)_OUT(I)
 Q X
 ;
ADDOUT(S) ; add string to out array (expects OUT)
 S OUT=+$G(OUT)+1,OUT(OUT)=S
 Q
 ;
 ; special for AUDC -- hope to come up with a more general solution
 ;
VARYAUDC(TLT,ADMIN) ; modify .TLT for AUDC based on patient sex
 N DFN,I,DONE,X1,X2,ENSRC
 S DFN=+$P($G(^YTT(601.84,ADMIN,0)),U,2) QUIT:'DFN
 I $P($G(^DPT(DFN,0)),U,2)'="F" QUIT  ; only change if female
 S ENSRC=+$P($G(^YTT(601.84,ADMIN,0)),U,13) Q:'ENSRC        ; not from MHA
 ; looking for the 3rd question, so start checked at about line 8
 S DONE=0,I=8 F  S I=$O(TLT(I)) Q:'I  D  Q:DONE
 . I TLT(I)'["six or more" QUIT
 . S X1=$P(TLT(I),"six or more"),X2=$P(TLT(I),"six or more",2)
 . S TLT(I)=X1_"4 or more"_X2,DONE=1
 Q
