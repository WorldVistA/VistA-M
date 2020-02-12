YTQRRPT ;SLC/LLH - Report Builder ; 08/13/2018
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; DIQ                   2056
 ; XLFDT                10103
 ; XLFNAME               3065
 ; XLFSTR               10104
 ;
BLDRPT(RESULTS,ADMIN,MAXWIDTH) ;
 N ADATA,ANS,INST,LP,PDATA,RPT,RSTR,SCL,SWAP,YSDATA,YS
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
 I $G(MAXWIDTH)>1 D WRAPTLT(.RSTR,MAXWIDTH) ; wrap for progress notes
 D GETDATA                        ;insert the data from the answer vars
 ;Loop back through completed array to replace "|" (line feeds) with a blank line with a space
 D FIXP(.RSTR,.RESULTS)
 Q
LOADTLT(TLT,RPT) ; Load template for RPT into .TLT split by "|" chars
 N LP,LN,FRAG,X,START,END
 S LN=0,FRAG=""
 S LP=0 F  S LP=$O(^YTT(601.93,RPT,1,LP)) Q:'LP  D
 . S X=^YTT(601.93,RPT,1,LP,0)
 . I LP=1,($E(X)="|") S X=$E(X,2,$L(X)) ; drop initial line feed
 . I X["$~" S X=$P(X,"$~"),LP=9999999   ; $~ marks end of report
 . S START=0 F  S END=$F(X,"|",START) D  Q:'START
 . . I END D  Q
 . . . S LN=LN+1
 . . . S TLT(LN)=FRAG_$E(X,START,END-2)
 . . . I TLT(LN)="." S TLT(LN)=" "
 . . . S TLT(LN)=TLT(LN)_"|"
 . . . S FRAG="",START=END
 . . E  D
 . . . S FRAG=FRAG_$E(X,START,$L(X))
 . . . S START=0
 I $L(FRAG) S LN=LN+1,TLT(LN)=FRAG_"|"
 Q
WRAPTLT(TLT,MAX) ; Wrap lines in TLT that are >WIDTH by adding "|" chars
 N I
 S I=0 F  S I=$O(TLT(I)) Q:'I  I $L(TLT(I))'<MAX S TLT(I)=$$WRAP(TLT(I),MAX)
 Q
FIXP(RSTR,RESULTS) ;
 N LP,LN,FRAG,START,END
 S LN=0,FRAG=""
 S LP=0 F  S LP=$O(RSTR(LP)) Q:'LP  D
 . S START=0 F  S END=$F(RSTR(LP),"|",START) D  Q:'START
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
 S ADATA("DATE")=$$FMTE^XLFDT($P($P($G(^YTT(601.84,ADMIN,0)),U,4),"."),1)  ; Date Given
 S ADATA("ORDERED")=$$NAMEFMT^XLFNAME(.MYNAME,"F","MCXc")         ;Ordered by
 S ADATA("LOC")=$$TITLE^XLFSTR($$GET1^DIQ(601.84,ADMIN_",",13))   ;Location
 Q
PATINFO(PDATA,DFN) ;
 N YS,YSDATA,MYNAME
 I '$G(DFN) Q
 S YS("DFN")=DFN
 S MYNAME("FILE")=2
 S MYNAME("FIELD")=.01
 S MYNAME("IENS")=DFN_","
 D PATSEL^YTQAPI9(.YSDATA,.YS)
 S PDATA("NM")=$$NAMEFMT^XLFNAME(.MYNAME,"F","MCXc")
 S PDATA("SSN")="xxx-xx-"_$P($P(YSDATA(3),U,2),"-",3)
 S PDATA("DOB")=$P(YSDATA(4),U,2)
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
 N ANS,LP,STR
 F ANS=7771:1:7787 S SWAP("<*Answer_"_ANS_"*>")=""  ; default for computed
 I '$D(YSDATA)!($G(YSDATA(1))'="[DATA]") Q
 S LP=2 F  S LP=$O(YSDATA(LP)) Q:'LP  D
 .S STR=YSDATA(LP)
 .S ANS=$P(STR,U)
 .I ANS=999999999999 S SWAP("<*Answer_"_ANS_"*>")=$P(STR,U,3) Q
 .I $P(STR,U,2)[";" S SWAP("<*Answer_"_ANS_"*>")=$G(SWAP("<*Answer_"_ANS_"*>"))_$P(STR,U,3) Q
 .S SWAP("<*Answer_"_ANS_"*>")=$$GET1^DIQ(601.75,$P(STR,U,3)_",",3)
 ; loop thru SWAP array & make sure all responses wrapped to 80 chars
 S ANS="" F  S ANS=$O(SWAP(ANS)) Q:'$L(ANS)  D
 . I $L(SWAP(ANS))'>80 Q              ; already under 80 chars
 . I ANS="<*Answer_999999999999*>" Q  ; DLLStr already wrapped
 . S SWAP(ANS)=$$WRAP(SWAP(ANS),80)   ; wrap by adding | chars
 Q
SETSCL ;
 N LP,STR
 I '$D(^TMP($J,"YSCOR")) Q
 F LP=2:1 Q:('$D(^TMP($J,"YSCOR",LP)))!($G(^TMP($J,"YSCOR",1))="[ERROR]")  D
 .S STR=$G(^TMP($J,"YSCOR",LP))
 .S SWAP("<-"_$P(STR,"=")_"->")=$P($P(STR,"=",2),U) ; use raw score
 Q
WRAP(TX,MAX) ; If length of TX > MAX, wrap by adding | chars
 N OUT,I,J,X,Y,YNEW
 F I=1:1:$L(TX,"|") S X=$P(TX,"|",I) D
 . I $L(X)'>MAX D ADDOUT(X) QUIT
 . S Y=""
 . F J=1:1:$L(X," ") D
 . . S YNEW=Y_$S(J=1:"",1:" ")_$P(X," ",J)
 . . I $L(YNEW)>MAX D ADDOUT(Y) S Y=$P(X," ",J) I 1
 . . E  S Y=YNEW
 . D ADDOUT(Y) ; add any remaining
 S X="",I=0 F  S I=$O(OUT(I)) Q:'I  S X=X_$S(I=1:"",1:"|")_OUT(I)
 Q X
 ;
ADDOUT(S) ; add string to out array (expects OUT)
 S OUT=+$G(OUT)+1,OUT(OUT)=S
 Q
