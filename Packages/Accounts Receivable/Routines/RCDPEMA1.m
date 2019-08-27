RCDPEMA1 ;EDE/FA - LIST ALL AUTO-POSTED RECEIPTS REPORT ;Nov 17, 2016
 ;;4.5;Accounts Receivable;**332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q   ; no direct entry
 ;
RPTOUT(INPUT) ;EP from RCDPEMAP
 ; Output the report to paper/screen, listman or excel
 ; Input:   INPUT   - See REPORT^RCDPEMAP for a complete description
 ;          ^TMP($J,A1,"SEL",A2)=External Auto-Post Date
 ;          ^TMP($J,A1,"SEL",A3)=External lower cased sort value (Payer or User)
 ;          ^TMP($J,A1,"SEL",A2,A3,A4,A5)=B1^B2^B3^B4^B5 - if record passed filters Where:
 ;                                 A1 - "RCDPE_MAP"
 ;                                 A2 - Internal Auto-Post Date (primary sort)
 ;                                 A3 - Secondary Sort Value (Payer or User Name)
 ;                                 A4 - IEN for file 344.4
 ;                                 A5 - IEN for file 344.41
 ;                                 B1 - Payer Name
 ;                                 B2 - User Name
 ;                                 B3 - ERA #
 ;                                 B4 - Claim #
 ;                                 B5 - Trace #
 ; Output:  ^TMP("RCDPE_MAP",$J,CTR)=Line - Array of display lines (no headers)
 ;                                          for output to Listman
 ;                                          Only set when A7-1
 ;
 N A1,ADATE,DATA,EXCEL,FIRST,LNCNT,LSTMAN,OUTYPE,PAGE,PAYER,SORT,STOP,SVAL
 S (LNCNT,PAGE)=0                           ; Initialize Line/Page counters
 S $P(INPUT,"^",9)=0                        ; Line Counter for Listman output
 S SORT=$P(INPUT,"^",6)                     ; Secondary Sort by Payer or User?
 S EXCEL=$P(INPUT,"^",8)                    ; Output to Excel?
 S LSTMAN=$P(INPUT,"^",7)                   ; Output to Listman?
 S OUTYPE=$S(EXCEL:2,LSTMAN:1,1:0)
 S DATA=0,FIRST=1
 I OUTYPE=2 D                               ; Excel Ouput - Print header line
 . S XX="Auto-Post Date^"
 . S XX=XX_$S(SORT=2:"Payer",1:"User")_"^"
 . S XX=XX_$S(SORT=2:"User",1:"Payer")_"^"
 . S XX=XX_"ERA #^Claim #^Trace #"
 . W !,XX
 . ;
 S A1="RCDPE_MAP",STOP=0
 S ADATE=""
 F  D  Q:ADATE=""  Q:STOP
 . S ADATE=$O(^TMP($J,A1,"SEL",ADATE))
 . Q:ADATE=""
 . I OUTYPE=1 D                             ; Listman Output
 . . S XX=$P(INPUT,"^",9),XX=XX+1
 . . I FIRST D  ;
 . . . S FIRST=0
 . . E  D  ;
 . . . S ^TMP(A1,$J,XX)="",XX=XX+1
 . . S ^TMP(A1,$J,XX)="Auto-Post Date: "_^TMP($J,A1,"SEL",ADATE)
 . . S $P(INPUT,"^",9)=XX
 . ;
 . I 'OUTYPE D  Q:STOP                      ; Output to Screen/Paper
 . . I FIRST D  Q                           ; Initial Page Header
 . . . S FIRST=0
 . . . D PHEADER(INPUT,.LNCNT,.PAGE)
 . . . W !,"Auto-Post Date: "_^TMP($J,A1,"SEL",ADATE)
 . . . S LNCNT=LNCNT+1
 . . I (LNCNT+6)>IOSL D  Q:STOP             ; Page break
 . . . S STOP=$$ASKSTOP^RCDPEMAP()
 . . . Q:STOP
 . . . D PHEADER(INPUT,.LNCNT,.PAGE)        ; Page Header
 . . I LNCNT>7 W ! S LNCNT=LNCNT+1
 . . W !,"Auto-Post Date: "_^TMP($J,A1,"SEL",ADATE)
 . . S LNCNT=LNCNT+1
 . D RPT2(.INPUT,A1,ADATE,SORT,OUTYPE,.LNCNT,.STOP,.DATA)
 I 'DATA,'EXCEL,'LSTMAN D
 . D PHEADER(INPUT,.LNCNT,.PAGE)
 I 'EXCEL D
 . S XX=$$ENDORPRT^RCDPEARL
 . I OUTYPE=1 D  Q
 . . S YY=$P(INPUT,"^",9)+1
 . . S $P(INPUT,"^",9)=YY
 . . S ^TMP(A1,$J,YY)=XX
 . W !,XX
 I (OUTYPE'=1),'STOP,$$ASKSTOP^RCDPEMAP()
 Q
 ;
RPT2(INPUT,A1,ADATE,SORT,OUTYPE,LNCNT,STOP,DATA) ; Report Output Continued
 ; Input:   INPUT   - See REPORT^RCDPEMAP for detail
 ;          ADATE   - Internal Auto-Post Date
 ;          SORT    - 2 - Sort by User, 1 - Sort by Payer
 ;          OUTYPE  - 2 - Excel, 1 - Listman, 0 - Paper/Screen
 ;          LNCNT   - Current line count (only if OUTYPE=0)
 ;          ^TMP($J,A1,"SEL",...) - See RPTOUT for details
 ; Output:  LNCNT   - Updated line count (only if OUTYPE=0)
 ;          STOP    - 1 if user quit out (only if OUTYPE=0)
 ;          INPUT   - 9th '^' piece update with current line # is OUTYPE=1
 ;          DATA    - 1 if at least one line of data is fount
 ;          ^TMP("RCDPE_MAP",$J,CTR) - Output lines for Listman (only if OUTYPE=1)
 N CURS,SVAL,LASTS,XX
 S SVAL="",XX=$O(^TMP($J,A1,"SEL",ADATE,""))
 S LASTS=^TMP($J,A1,"SEL",ADATE,XX)
 F  D  Q:SVAL=""  Q:STOP
 . S SVAL=$O(^TMP($J,A1,"SEL",ADATE,SVAL))
 . Q:SVAL=""
 . S CURS=^TMP($J,A1,"SEL",ADATE,SVAL)      ; Current lower case Payer or User Name
 . I OUTYPE=1 D                             ; Listman output
 . . S XX=$P(INPUT,"^",9)
 . . I CURS'=LASTS D
 . . . S XX=XX+1,^TMP(A1,$J,XX)=""
 . . S XX=XX+1,^TMP(A1,$J,XX)="  "_$S(SORT=2:"Payer: ",1:"User: ")_CURS
 . . S $P(INPUT,"^",9)=XX
 . ;
 . I 'OUTYPE D  Q:STOP                      ; Output to Paper/Screen
 . . I (LNCNT+4)>IOSL D  Q:STOP             ; Page break
 . . . S STOP=$$ASKSTOP^RCDPEMAP()
 . . . Q:STOP
 . . . D PHEADER(INPUT,.LNCNT,.PAGE)         ; Print Page Header
 . . . W !,"Auto-Post Date: "_^TMP($J,A1,"SEL",ADATE)
 . . . ; W !,CURS
 . . . S LNCNT=LNCNT+3
 . . I CURS'=LASTS D
 . . . S LNCNT=LNCNT+1,LASTS=CURS
 . . . W !
 . . W !,"  ",$S(SORT=2:"Payer: ",1:"User: "),CURS
 . . S LNCNT=LNCNT+1
 . D RPT3(.INPUT,A1,ADATE,SORT,SVAL,OUTYPE,.LNCNT,.STOP,.DATA)
 Q
 ;
RPT3(INPUT,A1,ADATE,SORT,SVAL,OUTYPE,LNCNT,STOP,DATA) ;  Report Output Continued
 ; Input:   INPUT   - See REPORT^RCDPEMAP for detail
 ;          ADATE   - Internal Auto-Post Date
 ;          SORT    - 1 - Sort by User, 2 - Sort by Payer
 ;          SVAL    - Current sort value (Upper cased Payer or User Name)
 ;          OUTYPE  - 2 - Excel, 1 - Listman, 0 - Paper/Screen
 ;          LNCNT   - Current line count (only if OUTYPE=0)
 ;          ^TMP($J,A1,"SEL",...2) - See RPTOUT for details
 ; Output:  LNCNT    - Updated line count (only if OUTYPE=0)
 ;          STOP    - 1 if user quit out (only if OUTYPE=0)
 ;          INPUT   - 9th '^' piece update with current line # is OUTYPE=1
 ;          DATA    - 1 if at least one line of data is found
 ;          ^TMP("RCDPE_MAP",$J,CTR) - Output lines for Listman (only if OUTYPE=1)
 N DATAR,FIRSTS,IEN3444,IEN34441,LN1,LN2,LN3,UORP,UORPF,UORPL,XX,YY
 S IEN3444="",FIRSTS=1,UORPF=1
 F  D  Q:IEN3444=""  Q:STOP
 . S IEN3444=$O(^TMP($J,A1,"SEL",ADATE,SVAL,IEN3444))
 . Q:IEN3444=""
 . S IEN34441=""
 . S XX=$O(^TMP($J,A1,"SEL",ADATE,SVAL,IEN3444,""))
 . S XX=^TMP($J,A1,"SEL",ADATE,SVAL,IEN3444,XX)
 . S UORPL=$P(XX,"^",SORT)
 . F  D  Q:IEN34441=""
 . . S IEN34441=$O(^TMP($J,A1,"SEL",ADATE,SVAL,IEN3444,IEN34441))
 . . Q:IEN34441=""
 . . S DATA=1                               ; found data
 . . ;
 . . S DATAR=^TMP($J,A1,"SEL",ADATE,SVAL,IEN3444,IEN34441)
 . . S:SORT=2 LN1="  Payer: "_$P(DATAR,"^",1),LN2="    User: "_$P(DATAR,"^",2)
 . . S:SORT=1 LN1="  User: "_$P(DATAR,"^",2),LN2="    Payer: "_$P(DATAR,"^",1)
 . . S LN3=$P(DATAR,"^",3)                  ; ERA #
 . . S YY=$P(DATAR,"^",4)                   ; Claim #
 . . S LN3=$$SETSTR^VALM1(YY,LN3,13,10)
 . . S YY=$P(DATAR,"^",5)                   ; Trace #
 . . S LN3=$$SETSTR^VALM1(YY,LN3,25,50)
 . . S UORP=$P(DATAR,"^",SORT)
 . . I OUTYPE=2 D  Q                        ; Excel Output
 . . . S XX=^TMP($J,A1,"SEL",ADATE)_"^"
 . . . I SORT=1 D
 . . . . S XX=XX_$P(DATAR,"^",2)_"^"_$P(DATAR,"^",1)
 . . . E  D
 . . . . S XX=XX_$P(DATAR,"^",1,2)
 . . . S XX=XX_"^"_$P(DATAR,"^",3,5)
 . . . W !,XX
 . . ;
 . . ; Listman output
 . . I OUTYPE=1 D RPT3LM(A1,.INPUT,.FIRSTS,.UORP,.UORPL,.UORPF,LN2,LN3) Q
 . . ;
 . . ; Output to Paper/Screen - check if we need a page break
 . . I (LNCNT+2)>IOSL D  Q:STOP
 . . . S STOP=$$ASKSTOP^RCDPEMAP()
 . . . Q:STOP
 . . . D PHEADER(INPUT,.LNCNT,.PAGE)
 . . . W !,"Auto-Post Date: "_^TMP($J,A1,"SEL",ADATE)
 . . . S LNCNT=LNCNT+1
 . . . W !,LN1
 . . . S LNCNT=LNCNT+1
 . . . W !,LN2
 . . . S LNCNT=LNCNT+1
 . . I UORP'=UORPL D
 . . . S UORPL=UORP,LNCNT=LNCT+2,UORPF=0
 . . . I LNCNT>7 W ! S LNCNT=LNCNT+1
 . . . W !,LN2 S LNCNT=LNCNT+1
 . . I UORPF D
 . . . S LNCNT=LNCNT+1,UORPF=0
 . . . W !,LN2 S LNCNT=LNCNT+1
 . . W !,LN3
 . . S LNCNT=LNCNT+1
 Q
 ;
RPT3LM(A1,INPUT,FIRSTS,UORP,UORPL,UORPF,LN2,LN3) ; Continue listman output
 ; Input:   A1      - "RCDPE_MAP"
 ;          INPUT   - 9th piece contains the current listman line counter
 ;          FIRSTS  - 1 if this is the first Payer for the current date, 0 otherwise
 ;          UORP    - Current User or Payer Name (whichever we're not sorting by)
 ;          UORPL   - Current last User or Payer Name (whichever we're not sorting by)
 ;          UORPF   - 1 if this is the first user or payer for the current sor value
 ;                    0 otherwise
 ;          LN2     - Payer or User Name (whatever is not the sort) display line
 ;          LN3     - ERA display line
 ;          ^TMP(A1,$J,XX)  - Current listman display lines
 ; Output:  INPUT   - Updated 9th piece contains the current listman line counter
 ;          FIRSTS  - Updated to 0 (potentially)
 ;          UORP    - Updated User or Payer Name (potentially)
 ;          UORPL   - Updated last User or Payer Name (potentially)
 ;          UORPF   - Updated
 ;          ^TMP(A1,$J,XX)  - Current listman display lines
 N XX
 S XX=$P(INPUT,"^",9)
 I UORPF D                                  ; first User or Payer for sort value and date
 . S UORPF=0,XX=XX+1,UORPL=UORP
 . S ^TMP(A1,$J,XX)=LN2
 I UORP'=UORPL D                            ; Different User or Payer for date
 . S UORPL=UORP,UORPF=0
 . S XX=XX+1
 . S ^TMP(A1,$J,XX)=""
 . S XX=XX+1
 . S ^TMP(A1,$J,XX)=LN2
 S XX=XX+1
 S ^TMP(A1,$J,XX)=LN3
 S $P(INPUT,"^",9)=XX
 Q
 ;
PHEADER(INPUT,LNCNT,PAGE) ; Display a Page Header
 ; Input:   INPUT   - See REPORT for a complete description
 ;          LNCNT   - Current Line Count
 ;          PAGE    - Current Page Count
 ; Output:  LNCNT   - Updated Line Count
 ;          PAGE    - Updated Page Count
 N XX,YY,ZZ
 S YY="EEOBs Marked for Auto-Post Audit Report",PAGE=PAGE+1
 S XX=$$NOW^XLFDT(),XX=$$FMTE^XLFDT(XX)
 S XX=$$SETSTR^VALM1(XX,YY,42,21)
 S YY="Page: "_$J(PAGE,3)
 S XX=$$SETSTR^VALM1(YY,XX,69,$L(YY))
 W @IOF,XX
 S LNCNT=1
 ;
 S XX=$$HDRLN2(INPUT)
 W !,XX
 S LNCNT=LNCNT+1
 ;
 S XX=$$HDRLN3(INPUT)
 W !,XX
 S LNCNT=LNCNT+1
 ; 
 S XX=$$HDRLN4(INPUT)
 W !,XX
 S LNCNT=LNCNT+1
 ;
 S LNCNT=LNCNT+1
 W !,"ERA #       Claim #     Trace #"
 S LNCNT=LNCNT+1
 W !,"--------------------------------------------------------------------------------"
 S LNCNT=LNCNT+1
 Q 
 ;
HDRLN2(INPUT) ; Build the 2nd header line
 ; Input:   INPUT   - See REPORT^RCDPEMAP for a complete description
 ; Returns: Text for 2nd header line
 N XX
 S XX="Divs : "_$S($P(INPUT,"^",1)=1:"All",1:$$DIVS(.RCVAUTD))
 Q XX
 ;
HDRLN3(INPUT) ; Build the 3rd header line
 ; Input:   INPUT   - See REPORT^RCDPEMAP for a complete description
 ; Returns: Text for 3rd header line
 N XX,YY,ZZ
 S YY=$P(INPUT,"^",3)
 S XX="M/P/T: "_$S(YY="A":"All",YY="M":"Medical",YY="P":"Pharmacy ",1:"Tricare")_" - "
 S XX=XX_$S($P(INPUT,"^",4)="A":" All",1:" Sel")_" Payers"
 S YY=$P($P(INPUT,"^",2),"|",1),YY="Auto-Post Date: "_$$FMTE^XLFDT(YY,"2Z")
 S ZZ=$P($P(INPUT,"^",2),"|",2),ZZ=$$FMTE^XLFDT(ZZ,"2Z")
 S YY=YY_"-"_ZZ
 S XX=$$SETSTR^VALM1(YY,XX,40,$L(YY))
 Q XX
 ;
HDRLN4(INPUT) ; Build the 4th header line
 ; Input:   INPUT   - See REPORT^RCDPEMAP for a complete description
 ; Returns: Text for 4th header line
 N XX,YY,ZZ
 S YY=$P(INPUT,"^",4)
 S XX="Users: "_$S($P(INPUT,"^",5)=1:"All ",1:"Selected")
 S YY="Sort: "_$S($P(INPUT,"^",6)=1:"User ",1:"Payer ")_"Name"
 S XX=$$SETSTR^VALM1(YY,XX,50,$L(YY))
 Q XX
 ;
DIVS(VAUTD) ;
 ; Input - VAUTD array of divisions selected
 ; Returns - List of station numbers
 N RETURN,XX,Z0,Z1
 S Z1=""
 S Z0=0
 F  D  Q:'Z0
 . S Z0=$O(VAUTD(Z0))
 . Q:'Z0
 . S XX=$$GET1^DIQ(40.8,Z0,1,"I") ;Facility Number   ;PRCA*4.5*321
 . S Z1=Z1_XX_", "
 S RETURN=$E(Z1,1,$L(Z1)-2)
 Q RETURN
