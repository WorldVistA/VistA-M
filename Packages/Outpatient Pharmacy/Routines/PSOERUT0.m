PSOERUT0 ;ALB/MFR - eRx Patient - ListMan Utilities; 06/03/2023 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**700,750,746,769,770**;DEC 1997;Build 145
 ;
SETPAT(MODE,ERXIEN,DFN,NMSPC,PENFLG,SDFLG) ; Set ListMan Side-By-Side Section for Patient
 ;Input: MODE   - Display Mode: "RS": Roll & Scroll | "LM": ListMan
 ;       ERXIEN - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;       DFN    - Matched/Suggested VistA Patient - Pointer to PATIENT file (#2)
 ;    (o)NMSPC  - ListMan Temp Global Namespace (e.g., "PSOERXP1") - Required for LM Mode only
 ;    (o)PENFLG - Pending Order Flag - 1: Pending Order Interface | 0: eRx Holding Queue Interface
 ;    (o)SDFLG  - Single eRx View/Display Flag - 1: Single eRx View/Display Interface | 0: eRx Holding Queue Interface
 ;       Input Global Variable: LINE - Current ListMan Line # (Default)
 ;       Output Global Variable: (ListMan Mode ONly)
 ;          REVLN - Array Indicating Reverse Video for Line, position and size of the string
 ;          HIGLN - Array Indicating Highlight for Line, position and size of the string
 S:'$G(LINE) LINE=1 S NMSPC=$G(NMSPC)
 N ERXPAT,X,XE,XV,DATA,ERXDM,ERR,ERXNAME,ERXDOB,ERXSEX,ERXSSN,ERXPHON1,ERXPHON2,ERXPHON3,ERXADDR,ERXCITY,ERXZIP
 N ERXSTATE,ERXCNTRY,VADM,VAPA,VANAME,VADOB,VASEX,VASSN,VAPHONE1,VAPHONE2,VAADDR,VASTATE,VACNTRY,DIFFADDR,VAZIP
 N ERXPHS,VAPHS,VACITY,ADDLN,DIWL,DIWR,DIWF
 ;
 ;eRx Patient Data
 S ERXPAT=+$$GET1^DIQ(52.49,ERXIEN,.04,"I") I 'ERXPAT Q
 D GETS^DIQ(52.46,ERXPAT_",",".01;.07;.08;1.4;1.6;3.1;3.2;3.3;3.4;3.5","EI","DATA","ERR") I '$D(DATA) Q
 M ERXDM=DATA(52.46,ERXPAT_",")
 S ERXNAME=$E(ERXDM(.01,"E"),1,33),ERXDOB=ERXDM(.08,"E"),ERXSEX=ERXDM(.07,"E")
 S ERXSSN=ERXDM(1.4,"E"),ERXPHON1=$$ERXPHONE(ERXPAT,"HT"),ERXPHON2=$$ERXPHONE(ERXPAT,"CP")
 S ERXPHON3=$$ERXPHONE(ERXPAT,"PT")
 S ERXADDR=$$TRIM^XLFSTR(ERXDM(3.1,"E"))_$S($$TRIM^XLFSTR(ERXDM(3.2,"E"))'="":" "_ERXDM(3.2,"E"),1:"")
 S ERXCITY=ERXDM(3.3,"E"),ERXSTATE=$$GET1^DIQ(5,+ERXDM(3.4,"I"),1)
 S ERXZIP=ERXDM(3.5,"E"),ERXCNTRY=ERXDM(1.6,"E") S:ERXCNTRY="US" ERXCNTRY=""
 ;VistA Patient Data
 I '$G(DFN) S DFN=+$$GET1^DIQ(52.49,ERXIEN,.05,"I")
 S (VANAME,VADOB,VASSN,VASEX,VAADDR,VACITY,VASTATE,VAZIP,VACNTRY,VAPHONE1,VAPHONE2)=""
 I $G(DFN) D
 . D DEM^VADPT,ADD^VADPT
 . S VANAME=$E($P(VADM(1),"^"),1,33),VADOB=$P(VADM(3),"^",2),VASEX=$P(VADM(5),"^",2),VASSN=$P(VADM(2),"^",2)
 . S VAPHONE1=$P(VAPA(8),"^"),VAPHONE2=$$GET1^DIQ(2,DFN,.134,"E"),VACITY=$P(VAPA(4),"^")
 . S VAZIP=$P(VAPA(11),"^"),VAADDR=$$TRIM^XLFSTR(VAPA(1))_$S($$TRIM^XLFSTR(VAPA(2))'="":" "_VAPA(2),1:"")
 . S VAADDR=VAADDR_$S($$TRIM^XLFSTR(VAPA(3))'="":" "_VAPA(3),1:"")
 . S VASTATE=$$GET1^DIQ(5,+VAPA(5),1),VACNTRY=$$GET1^DIQ(779.004,+$G(VAPA(25)),1.2)
 . S VACNTRY=$S(VACNTRY="US":"",VACNTRY="CA":"CN",1:VACNTRY)
 ;
 ; - Patient Matching Header Line
 I $G(PENFLG)!$G(SDFLG) D
 . N AMATCH,VPATIEN,VALUSER,VALDTTM,MATCH,HDR
 . S AMATCH=$$GET1^DIQ(52.49,ERXIEN,1.6,"I"),VPATIEN=$$GET1^DIQ(52.49,ERXIEN,.05,"I")
 . S VALUSER=$$GET1^DIQ(52.49,ERXIEN,1.13,"E"),VALDTTM=$$GET1^DIQ(52.49,ERXIEN,1.14,"I")
 . I $$GET1^DIQ(52.49,ERXIEN,.08,"I")="RE",'VALDTTM D
 . . S MATCH="PREVIOUSLY MATCHED/VALIDATED (RENEWAL)"
 . E  D
 . . S MATCH=$S(AMATCH=1:"AUTO-MATCHED",AMATCH=2:"AUTO-MATCHED/EDITED",VPATIEN:"MANUALLY-MATCHED",1:"")
 . . I VALUSER'="",MATCH'="" S MATCH=MATCH_" | VALIDATED by "_$E(VALUSER,1,19)_" on "_$$FMTE^XLFDT(VALDTTM*10000\1/10000,"2Y")
 . . I MATCH="" S MATCH="NOT MATCHED"
 . S MATCH="PATIENT "_MATCH I $L(MATCH)>80 S MATCH=$E(MATCH,1,78)
 . S HDR="",$E(HDR,(80-$L(MATCH))\2+1)=MATCH,$E(HDR,81)=""
 . S $E(MATCH,81)=""
 . S UNDERLN(LINE,1)=100 I HDR["/EDITED" S BLINKLN(LINE,$F(HDR,"/EDITED")-6)=6
 . D ADDLINE(MODE,NMSPC,HDR,"")
 ;
 S XE="Name: "_$$COMPARE(MODE,$E(ERXNAME,1,33),VANAME,7,,,'DFN)
 S XV="|Name: "_$$COMPARE(MODE,VANAME,ERXNAME,47)
 D ADDLINE(MODE,NMSPC,XE,XV)
 I $L(ERXNAME)>33 D
 . S XE=$$COMPARE(MODE,$E(ERXNAME,34,99),"",7,,,'DFN)
 . D ADDLINE(MODE,NMSPC,XE)
 S XE="DOB : "_$$COMPARE(MODE,ERXDOB,VADOB,7,,,'DFN)
 S XV="|DOB : "_$$COMPARE(MODE,VADOB,ERXDOB,47)
 D ADDLINE(MODE,NMSPC,XE,XV)
 I $G(SDFLG) S LINE=LINE-1
 S XE=$S('$G(SDFLG):"SSN : ",1:XE_"   SSN : ")_$$COMPARE(MODE,ERXSSN,VASSN,$S('$G(SDFLG):7,1:28),,,'DFN)
 S XV=$S('$G(SDFLG):"|SSN : ",1:XV_"      SSN : ")_$$COMPARE(MODE,VASSN,ERXSSN,$S('$G(SDFLG):47,1:$S($L(VADOB)>10:70,1:69)))
 D ADDLINE(MODE,NMSPC,XE,XV)
 I '$G(SDFLG) D
 . S XE="Sex : "_$$COMPARE(MODE,ERXSEX,VASEX,7,,,'DFN)
 . S XV="|Sex : "_$$COMPARE(MODE,VASEX,ERXSEX,47)
 . D ADDLINE(MODE,NMSPC,XE,XV) ;
 ; Pending Order Interface only shows Name,DOB, SSN and Sex
 I $G(PENFLG) D  Q
 . D BLANKLN(MODE)
 ;
 I '$G(SDFLG) D
 . S XE="Address:",XV="|Address:" D ADDLINE(MODE,NMSPC,XE,XV)
 . F ADDLN=1:1:5 D
 . . I $$ADDRESS(ERXADDR,ADDLN)'=""!($$ADDRESS(VAADDR,ADDLN)'="") D
 . . . S XE=" "_$$COMPARE(MODE,$$ADDRESS(ERXADDR,ADDLN),$$ADDRESS(VAADDR,ADDLN),2,"ADD",,'DFN)
 . . . S XV="| "_$$COMPARE(MODE,$$ADDRESS(VAADDR,ADDLN),$$ADDRESS(ERXADDR,ADDLN),42,"ADD")
 . . . D ADDLINE(MODE,NMSPC,XE,XV)
 . S XE=" "_$$COMPARE(MODE,ERXCITY,VACITY,2,,,'DFN)
 . S XE=XE_$S(ERXCITY'="":",",1:"")_$$COMPARE(MODE,ERXSTATE,VASTATE,$L(XE)+2,,,'DFN)
 . S XE=XE_"  "_$$COMPARE(MODE,ERXZIP,VAZIP,$L(XE)+3,"ZIP",,'DFN)
 . S XV="| "_$$COMPARE(MODE,VACITY,ERXCITY,42)
 . S XV=XV_$S(VACITY'="":",",1:"")_$$COMPARE(MODE,VASTATE,ERXSTATE,$L(XV)+41)
 . S XV=XV_"  "_$$COMPARE(MODE,VAZIP,ERXZIP,$L(XV)+42,"ZIP")
 . D ADDLINE(MODE,NMSPC,XE,XV)
 . I $G(ERXCNTRY)'=""!(VACNTRY'="") D
 . . S XE=" "_$$COMPARE(MODE,ERXCNTRY,VACNTRY,2),XV="| "_$$COMPARE(MODE,VACNTRY,ERXCNTRY,42)
 . . D ADDLINE(MODE,NMSPC,XE,XV)
 ;
 S ERXPHS=$$CLNSTR(ERXPHON1)_","_$$CLNSTR(ERXPHON2)_","_$$CLNSTR(ERXPHON3)
 S VAPHS=$$CLNSTR(VAPHONE1)_","_$$CLNSTR(VAPHONE2)
 ;
 I $G(SDFLG) D  Q  ;display the patient phone,address,allergy and pharmacy narrative in the Single eRx View/Display mode
 . D PTPHONE,PTADDRS
 . D NARRATIV^PSOERUT6($G(DFN),NMSPC,MODE)
 ;
 I ERXPHON3'="" D
 . S XE="Primary Phone: "_$$COMPARE(MODE,ERXPHON3,$S(VAPHS[$$CLNSTR(ERXPHON3):ERXPHON3,1:""),16,,,'DFN),XV="|"
 . D ADDLINE(MODE,NMSPC,XE,XV)
 I ERXPHON1'=""!(VAPHONE1'="") D
 . S XE="Home Phone: "_$$COMPARE(MODE,ERXPHON1,$S(VAPHS[$$CLNSTR(ERXPHON1):ERXPHON1,1:""),13,,,'DFN)
 . S XV="|Home Phone: "_$$COMPARE(MODE,VAPHONE1,$S(ERXPHS[$$CLNSTR(VAPHONE1):VAPHONE1,1:""),53)
 . D ADDLINE(MODE,NMSPC,XE,XV)
 I ERXPHON2'=""!(VAPHONE2'="") D
 . S XE="Cell Phone: "_$$COMPARE(MODE,ERXPHON2,$S(VAPHS[$$CLNSTR(ERXPHON2):ERXPHON2,1:""),13,,,'DFN)
 . S XV="|Cell Phone: "_$$COMPARE(MODE,VAPHONE2,$S(ERXPHS[$$CLNSTR(VAPHONE2):VAPHONE2,1:""),53)
 . D ADDLINE(MODE,NMSPC,XE,XV)
 ;
 I MODE="LM" D
 . I '$G(SDFLG) D
 . . D BLANKLN(MODE)
 . . S XV="|Pharmacy Narrative: " D ADDLINE(MODE,NMSPC,,XV)
 . . I $G(DFN) D
 . . . S X=$$GET1^DIQ(55,DFN,1,"E") K ^UTILITY($J,"W") S DIWL=1,DIWR=38,DIWF="|" D ^DIWP
 . . . F I=1:1 Q:'$D(^UTILITY($J,"W",1,I))  D
 . . . . S XV="| "_$$COMPARE(MODE,^UTILITY($J,"W",1,I,0),^UTILITY($J,"W",1,I,0),42) D ADDLINE(MODE,NMSPC,,XV)
 . . D BLANKLN(MODE)
 . . D ALLERGY^PSOERUT3(MODE,NMSPC,ERXIEN,$G(DFN))
 . . D BLANKLN(MODE)
 . . D WTHT(MODE,ERXIEN,DFN)
 . . D BLANKLN(MODE)
 . . D SETDIAGS^PSOERUT3(MODE,NMSPC,ERXIEN,"VP")
 . . D BLANKLN(MODE)
 E  D BLANKLN(MODE)
 Q
 ;
WTHT(MODE,ERXIEN,DFN) ; Adds eRx Weight & Height
 ; Input: MODE   - Display Mode: "RS": Roll & Scroll | "LM": ListMan
 ;        ERXIEN - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;        DFN    - Pointer to PATIENT File(#2)
 N ERXWT,ERXHT,VAWT,VAHT,X,XE,XV
 S ERXWT=$$ERXWTHT(ERXIEN,"WT"),ERXHT=$$ERXWTHT(ERXIEN,"HT")
 S VAWT=$$VAWTHT(DFN,"WT"),VAHT=$$VAWTHT(DFN,"HT")
 ;
 S XE="Weight(kg): "_$$COMPARE(MODE,ERXWT,VAWT,13,,,'DFN)
 S XV="|Weight(kg): "_$$COMPARE(MODE,VAWT,ERXWT,53,,,'DFN)
 D ADDLINE(MODE,NMSPC,XE,XV)
 S XE="Height(cm): "_$$COMPARE(MODE,ERXHT,VAHT,13,,,'DFN)
 S XV="|Height(cm): "_$$COMPARE(MODE,VAHT,ERXHT,53,,,'DFN)
 D ADDLINE(MODE,NMSPC,XE,XV)
 Q
 ;
COMPARE(MODE,STR1,STR2,POS,TYPE,LMLINE,IGNNULL) ; Compare two strings and Sets Reverse/Highlight Video Array if different
 ; Input: MODE    - Display Mode: "RS": Roll & Scroll | "LM": ListMan
 ;        STR1    - String 1 to be compared with String 2
 ;        STR2    - String 2 to be compared with String 1
 ;        POS     - Position to start the Reverse Video
 ;     (o)TYPE     - Zipcode field ("ADD": Address | "ZIP": Zip Code)
 ;     (o)LMLINE  - Current ListMan line (LM Mode only)
 ;     (o)IGNNULL - Ignore when STR2 is null/blank
 ;Output: COMPARE - String to be displayed
 N COMPARE,CLNSTR1,CLNSTR2 S COMPARE=STR1,TYPE=$G(TYPE)
 I COMPARE="" Q ""
 I TYPE="ADD" S STR1=$$CLNADD(STR1),STR2=$$CLNADD(STR2)
 I TYPE="ZIP" S STR1=$E(STR1,1,5),STR2=$E(STR2,1,5)
 S CLNSTR1=$$CLNSTR(STR1),CLNSTR2=$$CLNSTR(STR2)
 I ('$G(IGNNULL)!(CLNSTR2'="")),CLNSTR1'=CLNSTR2,'$$EQDATES(STR1,STR2) D
 . I (CLNSTR1'?.N),(CLNSTR2'?.N),CLNSTR1'="MALE",CLNSTR2'="MALE",CLNSTR1[CLNSTR2!(CLNSTR2[CLNSTR1) D
 . . I MODE="RS" S COMPARE=$G(IOINHI)_COMPARE_$G(IOINORM)
 . . I MODE="LM" S HIGHLN($S($G(LMLINE):LMLINE,1:LINE),POS)=$L(COMPARE)
 . E  D
 . . I MODE="RS" S COMPARE=$G(IORVON)_COMPARE_$G(IORVOFF)
 . . I MODE="LM" S REVLN($S($G(LMLINE):LMLINE,1:LINE),POS)=$L(COMPARE)
 E  D
 . I MODE="RS" S COMPARE=$G(IOINHI)_COMPARE_$G(IOINORM)
 . I MODE="LM" S HIGHLN($S($G(LMLINE):LMLINE,1:LINE),POS)=$L(COMPARE)
 Q COMPARE
 ;
BLANKLN(MODE,NOVB) ; Add a Blank Line
 ;Input: MODE - Display Mode: "RS": Roll & Scroll | "LM": ListMan 
 ;    (o)NOVB - No Vertical Bar - 1: No Vertical Bar | 0/"" - Include Bar
 N XE,XV
 S XE="",$P(XE,"_",41)="",XV="",$P(XV,"_",$S($G(MODE)="LM":42,1:41))="" I '$G(NOVB) S $E(XV)="|"
 D ADDLINE(MODE,NMSPC,XE,XV)
 Q
 ;
ADDLINE(MODE,NMSPC,ETEXT,VTEXT) ;Adds a New Line to the list
 ;Input: MODE   - Display Mode: "RS": Roll & Scroll | "LM": ListMan
 ;       NMSPC  - ListMan Temp Global Namespace (e.g., "PSOERXP1")
 ;       ETEXT  - eRx Text to be added
 ;       VTEXT  - VistA Text to be added
 N TEXT S TEXT=""
 I MODE="RS" D
 . N Y S Y=$S($G(IOSL):IOSL,1:24)-3
 . I '(LINE#Y) D
 . . D PAUSE
 . E  W !
 . W $G(ETEXT),?40,$G(VTEXT)
 I MODE="LM" D
 . S LINE=+$G(LINE)
 . I $G(ETEXT)'="" S TEXT=$G(ETEXT)
 . I $G(VTEXT)'="" S $E(TEXT,40)=$G(VTEXT)
 . S ^TMP(NMSPC,$J,LINE,0)=TEXT
 S LINE=LINE+1
 Q
 ;
PAUSE ; Page break + erases the "Press Return..." 
 N DIR,I,XX S DIR("A")="Press Return to continue",DIR(0)="E" D ^DIR
 F I=1:1:26 W $C(8)
 S $P(XX," ",26)="" W XX
 F I=1:1:26 W $C(8)
 Q
 ;
EQDATES(DATE1,DATE2) ;Checks if the fields are valid dates and are the same
 ; Input: DATE1 - Date 1 to be compared with Date 2
 ;        DATE2 - Date 2 to be compared with Date 1
 ;Output: 1 if DATE1 and DATE@ are equal | 0 if different
 N X,Y,DT1,DT2
 S X=DATE1 D ^%DT Q:(Y<1) 0 S DT1=Y
 S X=DATE2 D ^%DT Q:(Y<1) 0 S DT2=Y
 I DT1=DT2 Q 1
 Q 0
 ;
CLNADD(ADD) ; Cleans an Address String
 ; Input: ADD - Address Line string to be cleaned
 ;Output: Cleaned Address Line string
 N REPS,REP,FIND,LIST,SYN,I,J
 S ADD=" "_$$UP^XLFSTR(ADD)_" "
 F I=1:1 S LIST=$T(USPSABBS+I^PSOERUT1) Q:(LIST'[";")  D
 . F J=3:1 Q:($P(LIST,";",J)="")  S SYN=$P(LIST,";",J),REPS($P(SYN,"^",1))=$P(SYN,"^",2)
 S REP="" F  S REP=$O(REPS(REP)) Q:REP=""  D
 . S FIND=$F(ADD,REP) I FIND S ADD=$E(ADD,1,FIND-$L(REP)-1)_REPS(REP)_$E(ADD,FIND,9999)
 S $E(ADD,$L(ADD))=""
 Q ADD
 ;
CLNSTR(STR) ; Cleans String (Removes any characters different than a-A & 1-9)
 ; Input: STR - String to be cleaned
 ;Output: Cleaned string
 N CHR,CLNSTR,I S CLNSTR=""
 S STR=$$UP^XLFSTR(STR) I STR?.P Q STR
 F I=1:1:$L(STR) S CHR=$E(STR,I) I (CHR?1N)!(($A(CHR)>64)&($A(CHR)<91)) S CLNSTR=CLNSTR_CHR
 Q CLNSTR
 ;
RESET() ; Reset Video Atributes
 ; - Resetting list to NORMAL video attributes
 N I
 I $D(VALMEVL) F I=1:1:$G(LASTLINE) D RESTORE^VALM10(I)
 K REVLN,HIGHLN,UNDERLN,BLINKLN,HIGUNDLN
 Q
 ;
VIDEO() ; Changes the Video Attributes for the list
 N I,LN,POS
 ;
 I '$D(IORVOFF)!'$D(VALMEVL) Q
 F I=0:1:$G(LINE) D CNTRL^VALM10(I,1,80,IORVOFF_IOINORM,IORVOFF_IOINORM)
 S LN=0 F  S LN=$O(REVLN(LN)) Q:'LN  D
 . S POS=0 F  S POS=$O(REVLN(LN,POS)) Q:'POS  D
 . . D CNTRL^VALM10(LN,POS,REVLN(LN,POS),IORVON,IORVOFF_IOINORM)
 S LN=0 F  S LN=$O(HIGHLN(LN)) Q:'LN  D
 . S POS=0 F  S POS=$O(HIGHLN(LN,POS)) Q:'POS  D
 . . D CNTRL^VALM10(LN,POS,HIGHLN(LN,POS),IOINHI,IOINORM)
 S LN=0 F  S LN=$O(UNDERLN(LN)) Q:'LN  D
 . S POS=0 F  S POS=$O(UNDERLN(LN,POS)) Q:'POS  D
 . . D CNTRL^VALM10(LN,POS,UNDERLN(LN,POS),IOUON,IOUOFF)
 S LN=0 F  S LN=$O(BLINKLN(LN)) Q:'LN  D
 . S POS=0 F  S POS=$O(BLINKLN(LN,POS)) Q:'POS  D
 . . D CNTRL^VALM10(LN,POS,BLINKLN(LN,POS),IOBON,IOBOFF)
 S LN=0 F  S LN=$O(HIGUNDLN(LN)) Q:'LN  D
 . S POS=0 F  S POS=$O(HIGUNDLN(LN,POS)) Q:'POS  D
 . . D CNTRL^VALM10(LN,POS,HIGUNDLN(LN,POS),IOINHI_IOUON,IOUOFF_IOINORM)
 Q
 ;
ERXPHONE(ERXPAT,TYPE) ; Return the eRx Patient Phone # (if there is one)
 ; Input: ERXPAT - Pointer to ERX PATIENT (#52.46)
 ;        TYPE   - "PT": Primary Telephone | "HT": Home Telephone
 ;
 N ERXPHONE,COMM,Z S ERXPHONE=""
 S COMM=0 F  S COMM=$O(^PS(52.46,ERXPAT,13,COMM)) Q:'COMM  D  I ERXPHONE'="" Q
 . S Z=$G(^PS(52.46,ERXPAT,13,COMM,0))
 . I $P(Z,"^",2)=TYPE S ERXPHONE=$P(Z,"^",3)
 Q ERXPHONE
 ;
ADDRESS(VALUE,ADDLINE) ; Returns Address Line1, Line2, Line3... (max 39 characters)
 ; Input: VALUE   - Complete Address (Line1+Line2+Line3)
 ;        ADDLINE - Line of the formatted address
 ;Output: ADDRESS - Returns the Line # Address Text for 39-char fields
 N ADDRESS,DIWL,DIWR,X,I
 K ^UTILITY($J,"W") S X=$$TRIM^XLFSTR(VALUE),DIWL=1,DIWR=39 D ^DIWP
 S ADDRESS=$$TRIM^XLFSTR($G(^UTILITY($J,"W",1,ADDLINE,0)))
 K ^UTILITY($J,"W")
 Q ADDRESS
 ;
ERXWTHT(ERXIEN,TYPE)  ; eRx Patient Weight/Height
 ; Input: ERXIEN - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;        TYPE   - "WT": Weight in Kg | "HT": Height in cm
 ;Output: Value or ""
 N ERXWTHT,OBS,IENS,LCODE,LDATA,HUOM,WUOM,HOBDT,WOBDT,RET,IEN
 S IEN=0,ERXWTHT=""
 F  S IEN=$O(^PS(52.49,ERXIEN,306,IEN)) Q:'IEN  D
 . S IENS=IEN_","_ERXIEN_","
 . S LCODE=$$GET1^DIQ(52.49306,IENS,1,"E")
 . Q:'LCODE
 . D CSDATA^ETSLNC(LCODE,"LNC",DT,.LDATA)
 . I TYPE="HT",$G(LDATA("LEX",1))["BODY HEIGHT" D
 . . S ERXWTHT=$$GET1^DIQ(52.49306,IENS,3,"E")
 . . S HUOM=$$UP^XLFSTR($$GET1^DIQ(52.49306,IENS,4,"E"))
 . . S HOBDT=$P($$GET1^DIQ(52.49306,IENS,6,"I"),"."),HOBDT=$$FMTE^XLFDT(HOBDT,"5Z")
 . . I HUOM["IN" S ERXWTHT=ERXWTHT*2.54,$P(ERXWTHT,".",2)=$E($P(ERXWTHT,".",2),1,2)
 . I TYPE="WT",$G(LDATA("LEX",1))["BODY WEIGHT" D
 . . S ERXWTHT=$$GET1^DIQ(52.49306,IENS,3,"E")
 . . S WOBDT=$P($$GET1^DIQ(52.49306,IENS,6,"I"),"."),WOBDT=$$FMTE^XLFDT(WOBDT,"5Z")
 . . S WUOM=$$UP^XLFSTR($$GET1^DIQ(52.49306,IENS,4,"E"))
 . . I WUOM["LB" S ERXWTHT=ERXWTHT/2.2046,$P(ERXWTHT,".",2)=$E($P(ERXWTHT,".",2),1,2)
 . . I WUOM="G" S ERXWTHT=ERXWTHT/1000,$P(ERXWTHT,".",2)=$E($P(ERXWTHT,".",2),1,2)
 Q ERXWTHT
 ;
VAWTHT(DFN,TYPE) ; VistA Patient Weight/Height
 ; Input: DFN - Pointer to PATIENT File(#2)
 ;        TYPE   - "WT": Weight in Kg | "HT": Height in cm
 ;Output: Value or ""
 N WT,HT,X,Y,GMRVSTR,VM
 I '$G(DFN) Q ""
 S (WT,HT)="",X="GMRVUTL" X ^%ZOSF("TEST") I $T D
 . F GMRVSTR="WT","HT" S VM=GMRVSTR D EN6^GMRVUTL S @VM=X,$P(@VM,"^")=$E($P(@VM,"^"),4,5)_"/"_$E($P(@VM,"^"),6,7)_"/"_($E($P(@VM,"^"),1,3)+1700)
 . S X=$P(WT,"^",8),Y=$J(X/2.2046226,0,2),$P(WT,"^",9)=Y,X=$P(HT,"^",8),Y=$J(2.54*X,0,2),$P(HT,"^",9)=Y
 ;
 I TYPE="WT",$P(WT,"^",8) Q $P(WT,"^",9)
 I TYPE="HT",$P(HT,"^",8) Q $P(HT,"^",9)
 Q ""
PTPHONE ;display phone in the Single eRx View/Display mode
 N EPTPHONE,VPTPHONE
 S EPTPHONE=$S(VAPHS[$$CLNSTR(ERXPHON3)&(ERXPHON3'=""):ERXPHON3,VAPHS[$$CLNSTR(ERXPHON1)&(ERXPHON1'=""):ERXPHON1,VAPHS[$$CLNSTR(ERXPHON2)&(ERXPHON2'=""):ERXPHON2,1:$S(ERXPHON2'="":ERXPHON2,ERXPHON1'="":ERXPHON1,1:ERXPHON3))
 S VPTPHONE=$S(ERXPHS[$$CLNSTR(VAPHONE2)&(VAPHONE2'=""):VAPHONE2,ERXPHS[$$CLNSTR(VAPHONE1)&(VAPHONE1'=""):VAPHONE1,1:$S(VAPHONE2'="":VAPHONE2,1:VAPHONE1))
 S XE="Phone: "_$$COMPARE(MODE,EPTPHONE,VPTPHONE,8,,,'DFN)
 S XV="|Phone: "_$$COMPARE(MODE,VPTPHONE,EPTPHONE,48)
 D ADDLINE(MODE,NMSPC,XE,XV)
 Q
 ;
PTADDRS ;display the patient address in the Single eRx View/Display mode
 Q:($G(ERXADDR)="")&($G(VAADDR)="")
 N XE,XV,EFULLADD,VFULLADD S (XE,XV,VFULLADD)=""
 S:$G(ERXADDR)'="" XE=ERXADDR
 S XE=XE_" "_ERXCITY
 S XE=XE_$S(ERXCITY'="":",",1:"")_ERXSTATE
 I $G(ERXCNTRY)'="" S XE=XE_" "_ERXCNTRY
 S EFULLADD=$$CLNSTR($$CLNADD(XE_$E(ERXZIP,1,5)))
 I $L(XE_" "_$E(ERXZIP,1,5))>38 S XE=$E(XE,1,30)_"..."_$E(ERXZIP,1,5)
 E  S XE=XE_" "_$E(ERXZIP,1,5)
 I $G(DFN) D
 . S XV=VAADDR
 . S XV=XV_" "_VACITY
 . S XV=XV_$S(VACITY'="":",",1:"")_VASTATE
 . I $G(VACNTRY)'="" S XV=XV_" "_VACNTRY
 . S VFULLADD=$$CLNSTR($$CLNADD(XV_$E(VAZIP,1,5)))
 . I $L(XV_" "_$E(VAZIP,1,5))>38 S XV=$E(XV,1,30)_"..."_$E(VAZIP,1,5)
 . E  S XV=XV_" "_$E(VAZIP,1,5)
 I XE'="" S XE=" "_$$COMPARE(MODE,XE,$S(EFULLADD=VFULLADD:XE,1:XV),2,"ADD",,'DFN)
 I XV'="" S XV="| "_$$COMPARE(MODE,XV,$S(EFULLADD=VFULLADD:XV,1:XE),42,"ADD")
 D ADDLINE(MODE,NMSPC,XE,XV)
 Q
