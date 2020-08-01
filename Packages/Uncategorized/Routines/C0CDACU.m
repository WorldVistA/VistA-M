C0CDACU ; GPL - Patient Portal - CCDA Utility Routines ;8/29/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License Affero GPL V3
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 ;
 Q
 ;
UNJSON(IN,OUT) ; assemble json from global and then decode into OUT 
 ; IN and OUT are passed by name
 Q:'$D(@IN)
 N %,%1,%J,ERR
 S (%,%1,%J)=""
 F  S %=$O(@IN@(%)) Q:%=""  D  ;
 . S %J=%J_$G(@IN@(%))
 . F  S %1=$O(@IN@(%,%1)) Q:%1=""  D  ;
 . . S %J=%J_$G(@IN@(%,%1))
 D DECODE^HMPJSON("%J",OUT,"ERR")
 Q
 ;
GETNMAP(OUTXML,INXML,IARY) ; Retrieves XML stored in Mumps routines and maps
 ; them using IARY, passed by name. Maps use @@var@@ protocol
 ; with @IARY@("var")=value for the map values
 ; OUTXML is passed by name and will hold the result
 ; INXML is the name of the storage place ie "HEADER^C0CDAC2"
 N GTAG,GRT,GI
 S GTAG=$P(INXML,"^",1)
 S GRT=$P(INXML,"^",2)
 ; first get all of the lines of the XML
 N TXML ; temp var for xml
 S GN=1
 F  S GI=GTAG_"+"_GN_"^"_GRT  Q:$T(@GI)'[";;"  D  ;
 . S TXML(GN)=$P($T(@GI),";;",2)
 . I $G(CCDADEBUG) W !,GN," ",TXML(GN)
 . S GN=GN+1
 ; next call MAP to resolve mappings and place result directly in OUTXML
 D MAP^MXMLTMPL("TXML",IARY,OUTXML)
 Q
 ;
GNMAPWP(OUTXML,INXML,IARY) ; Retrieves XML stored in Mumps routines and maps
 ; them using IARY, passed by name. Maps use @@var@@ protocol
 ; with @IARY@("var")=value for the map values
 ; OUTXML is passed by name and will hold the result
 ; INXML is the name of the storage place ie "HEADER^C0CDAC2"
 N GTAG,GRT,GI
 S GTAG=$P(INXML,"^",1)
 S GRT=$P(INXML,"^",2)
 ; first get all of the lines of the XML
 N TXML ; temp var for xml
 S GN=1
 F  S GI=GTAG_"+"_GN_"^"_GRT  Q:$T(@GI)'[";;"  D  ;
 . S TXML(GN)=$P($T(@GI),";;",2)
 . I $G(CCDADEBUG) W !,GN," ",TXML(GN)
 . S GN=GN+1
 ; 
 ; unlike GETNMAP above, this routine supports one multi-line text
 ; field per xml template. it is on it's own line and marked like @@var@@
 ; the array should have the text lines as var(1) var(2) etc
 ;
 ;
 N ZI,LIN S ZI=0 S LIN=1
 F  S ZI=$O(TXML(ZI)) Q:+ZI=0  D  ;
 . I TXML(ZI)'["@@" S @OUTXML@(LIN)=TXML(ZI) S LIN=LIN+1 Q  ;
 . N VAR
 . S VAR=$P($P(TXML(ZI),"@@",2),"@@",1)
 . I $D(@IARY@(VAR,1)) D  ;
 . . N ZJ S ZJ=0
 . . F  S ZJ=$O(@IARY@(VAR,ZJ)) Q:+ZJ=0  D  ;
 . . . I $L(@IARY@(VAR,ZJ))>4000 D  ;
 . . . . S @OUTXML@(LIN)=$E(@IARY@(VAR,ZJ),1,4000)
 . . . . S LIN=LIN+1
 . . . . S @OUTXML@(LIN)=$E(@IARY@(VAR,ZJ),4001,$L(@IARY@(VAR,ZJ)))
 . . . E  S @OUTXML@(LIN)=@IARY@(VAR,ZJ)
 . . . S LIN=LIN+1
 . E  I $D(@IARY@(VAR)) D  ;
 . . N VAR2 S VAR2="@@"_VAR_"@@"
 . . S @OUTXML@(LIN)=$P(TXML(ZI),VAR2,1)_$G(@IARY@(VAR))_$P(TXML(ZI),VAR2,2)
 . . S LIN=LIN+1
 S @OUTXML@(0)=$O(@OUTXML@(" "),-1)
 Q
 ;
JUSTMAP(IXML,INARY,OXML) ; SUBSTITUTE MULTIPLE @@X@@ VARS WITH VALUES IN INARY
 ; AND PUT THE RESULTS IN OXML - gpl DOES NOT MAKE VARS SAFE
 N XCNT
 I '$D(DEBUG) S DEBUG=0
 I '$D(IXML) W "MALFORMED XML PASSED TO MAP",! Q
 I '$D(@IXML@(0)) D  ; INITIALIZE COUNT
 . S XCNT=$O(@IXML@(""),-1)
 E  S XCNT=@IXML@(0) ;COUNT
 I $O(@INARY@(""))="" W "EMPTY ARRAY PASSED TO MAP",! Q
 N I,J,TNAM,TVAL,TSTR
 S @OXML@(0)=XCNT ; TOTAL LINES IN OUTPUT
 F I=1:1:XCNT  D   ; LOOP THROUGH WHOLE ARRAY
 . S @OXML@(I)=@IXML@(I) ; COPY THE LINE TO OUTPUT
 . I @OXML@(I)?.E1"@@".E D  ; IS THERE A VARIABLE HERE?
 . . S TSTR=$P(@IXML@(I),"@@",1) ; INIT TO PART BEFORE VARS
 . . F J=2:2:10  D  Q:$P(@IXML@(I),"@@",J+2)=""  ; QUIT IF NO MORE VARS
 . . . I DEBUG W "IN MAPPING LOOP: ",TSTR,!
 . . . S TNAM=$P(@OXML@(I),"@@",J) ; EXTRACT THE VARIABLE NAME
 . . . S TVAL="@@"_$P(@IXML@(I),"@@",J)_"@@" ; DEFAULT UNCHANGED
 . . . I $D(@INARY@(TNAM))  D  ; IS THE VARIABLE IN THE MAP?
 . . . . I '$D(@INARY@(TNAM,"F")) D  ; NOT A SPECIAL FIELD
 . . . . . S TVAL=@INARY@(TNAM) ; PULL OUT MAPPED VALUE
 . . . . E  D DOFLD ; PROCESS A FIELD
 . . . ;S TVAL=$$SYMENC^MXMLUTL(TVAL) ;MAKE SURE THE VALUE IS XML SAFE
 . . . S TSTR=TSTR_TVAL_$P(@IXML@(I),"@@",J+1) ; ADD VAR AND PART AFTER
 . . S @OXML@(I)=TSTR ; COPY LINE WITH MAPPED VALUES
 . . I DEBUG W TSTR
 I DEBUG W "MAPPED",!
 Q
 ;
GET(OUTXML,INXML) ; GET ONLY Retrieves XML stored in Mumps routines 
 ; OUTXML is passed by name and will hold the result
 ; INXML is the name of the storage place ie "HEADER^C0CDAC2"
 N GTAG,GRT,GI
 S GTAG=$P(INXML,"^",1)
 S GRT=$P(INXML,"^",2)
 ; first get all of the lines of the XML
 S GN=1
 F  S GI=GTAG_"+"_GN_"^"_GRT  Q:$T(@GI)'[";;"  D  ;
 . S @OUTXML@(GN)=$P($T(@GI),";;",2)
 . S @OUTXML@(0)=GN
 . I $G(CCDADEBUG) W !,GN," ",@OUTXML@(GN)
 . S GN=GN+1
 Q
 ;
TEST ;
 N GV S GV("test")="TEST"
 K G
 D GETNMAP("G","THEADER^C0CDAC2","GV")
 ZWR G
 Q
 ;
OUTLOG(ZTXT) ; add text to the log
 I '$D(C0LOGLOC) S C0LOGLOC=$NA(^TMP("CCDA",$J,"LOG"))
 N LN S LN=$O(@C0LOGLOC@(""),-1)+1
 S @C0LOGLOC@(LN)=ZTXT
 Q
 ;
LOGARY(ARY) ; LOG AN ARRAY
 N II S II=""
 F  S II=$O(@ARY@(II)) Q:II=""  D  ;
 . D OUTLOG(ARY_" "_II_" = "_$G(@ARY@(II)))
 Q
 ;
UUID()  ; thanks to Wally for this.
 N R,I,J,N 
 S N="",R="" F  S N=N_$R(100000) Q:$L(N)>64 
 F I=1:2:64 S R=R_$E("0123456789abcdef",($E(N,I,I+1)#16+1)) 
 Q $E(R,1,8)_"-"_$E(R,9,12)_"-4"_$E(R,14,16)_"-"_$E("89ab",$E(N,17)#4+1)_$E(R,18,20)_"-"_$E(R,21,32)
 ;
 ; the following was borrowed from the C0CUTIL and adapted for the CCDA
 ;
FMDTOUTC(DATE,FORMAT) ; Convert Fileman Date to UTC Date Format; PUBLIC; Extrinsic
 ; FORMAT is Format of Date. Can be either D (Day) or DT (Date and Time)
 ; If not passed, or passed incorrectly, it's assumed that it is D.
 ; FM Date format is "YYYMMDD.HHMMSS" HHMMSS may not be supplied.
 ; UTC date is formatted as follows: YYYY-MM-DDThh:mm:ss_offsetfromUTC
 ; UTC, Year, Month, Day, Hours, Minutes, Seconds, Time offset (obtained from Mailman Site Parameters)
 N UTC,Y,M,D,H,MM,S,OFF
 S Y=1700+$E(DATE,1,3)
 S M=$E(DATE,4,5)
 S D=$E(DATE,6,7)
 S H=$E(DATE,9,10)
 I $L(H)=1 S H="0"_H
 S MM=$E(DATE,11,12)
 I $L(MM)=1 S MM="0"_MM
 S S=$E(DATE,13,14)
 I $L(S)=1 S S="0"_S
 S OFF=$$TZ^XLFDT ; See Kernel Manual for documentation.
 S OFFS=$E(OFF,1,1)
 S OFF0=$TR(OFF,"+-")
 S OFF1=$E(OFF0+10000,2,3)
 S OFF2=$E(OFF0+10000,4,5)
 ;S OFF=OFFS_OFF1_":"_OFF2
 S OFF=OFFS_OFF1_OFF2
 ;S OFF2=$E(OFF,1,2) ;
 ;S OFF2=$E(100+OFF2,2,3) ; GPL 11/08 CHANGED TO -05:00 FORMAT
 ;S OFF3=$E(OFF,3,4) ;MINUTES
 ;S OFF=$S(OFF2="":"00",0:"00",1:OFF2)_"."_$S(OFF3="":"00",1:OFF3)
 ; If H, MM and S are empty, it means that the FM date didn't supply the time.
 ; In this case, set H, MM and S to "00"
 ; S:('$L(H)&'$L(MM)&'$L(S)) (H,MM,S)="00" ; IF ONLY SOME ARE MISSING?
 S:'$L(H) H="00"
 S:'$L(MM) MM="00"
 S:'$L(S) S="00"
 S UTC=Y_M_D_H_MM_$S(S="":"00",1:S)_OFF ; Skip's code to fix hanging colon if no seconds
 ;S UTC=Y_"-"_M_"-"_D_"T"_H_":"_MM_$S(S="":":00",1:":"_S)_OFF ; Skip's code to fix hanging colon if no seconds
 I $E(UTC,9,14)="000000" S UTC=$E(UTC,1,8) ; admit our precision gpl 9/2013
 I $L($G(FORMAT)),FORMAT="DT" Q UTC ; Date with time.
 E  Q $P(UTC,"T")
 ;
HTMLDT(FMDT) ; extrinsic returns date format MM/DD/YYYY for display in html
 ;
 N TMP,TMP2
 S TMP=$$FMDTOUTC(FMDT)
 S TMP2=$E(TMP,5,6)_"/"_$E(TMP,7,8)_"/"_$E(TMP,1,4)
 I $E(TMP,9,14)'="000000" D  ;
 . I $L(TMP)=8 Q  ; no time
 . S TMP2=TMP2_" "_$E(TMP,9,10)_":"
 . S TMP2=TMP2_$E(TMP,11,12)_":"
 . S TMP2=TMP2_$E(TMP,13,19)
 Q TMP2
 ;
TESTDATE ; test the above transform
 N GT
 S GT=$$FMDTOUTC($$NOW^XLFDT,"DT")
 W !,GT
 Q
 ; 
GENHTML(HOUT,HARY) ; generate an HTML table from array HARY
 ; HOUT AND HARY are passed by name
 ;
 ; format of the table:
 ;  HARY("TITLE")="Problem List"
 ;  HARY("HEADER",1)="column 1 header"
 ;  HARY("HEADER",2)="col 2 header"
 ;  HARY(1,1)="row 1 col1 value"
 ;  HARY(1,2)="row 1 col2 value"
 ;  HARY(1,2,"ID")="the ID of the element" 
 ;  etc...
 ;
 N C0I,C0J
 I $D(@HARY@("TITLE")) D  ;
 . N X
 . S X="<title>"_@HARY@("TITLE")_"</title>"
 . D ADDTO(HOUT,X)
 D ADDTO(HOUT,"<text>")
 D ADDTO(HOUT,"<table border=""1"" width=""100%"">")
 I $D(@HARY@("HEADER")) D  ;
 . D ADDTO(HOUT,"<thead>")
 . D ADDTO(HOUT,"<tr>")
 . S C0I=0
 . F  S C0I=$O(@HARY@("HEADER",C0I)) Q:+C0I=0  D  ;
 . . D ADDTO(HOUT,"<th>"_@HARY@("HEADER",C0I)_"</th>")
 . D ADDTO(HOUT,"</tr>")
 . D ADDTO(HOUT,"</thead>")
 D ADDTO(HOUT,"<tbody>")
 I $D(@HARY@(1)) D  ;
 . S C0I=0 S C0J=0
 . F  S C0I=$O(@HARY@(C0I)) Q:+C0I=0  D  ;
 . . D ADDTO(HOUT,"<tr>")
 . . F  S C0J=$O(@HARY@(C0I,C0J)) Q:+C0J=0  D  ;
 . . . N UID S UID=$G(@HARY@(C0I,C0J,"ID"))
 . . . I UID'="" D ADDTO(HOUT,"<td ID="""_UID_""">"_@HARY@(C0I,C0J)_"</td>")
 . . . E  D ADDTO(HOUT,"<td>"_@HARY@(C0I,C0J)_"</td>")
 . . D ADDTO(HOUT,"</tr>")
 D ADDTO(HOUT,"</tbody>")
 D ADDTO(HOUT,"</table>")
 D ADDTO(HOUT,"</text>")
 Q
 ;
TESTHTML ;
 N HTML
 S HTML("TITLE")="Problem List"
 S HTML("HEADER",1)="column 1 header"
 S HTML("HEADER",2)="col 2 header"
 S HTML(1,1)="row 1 col1 value"
 S HTML(1,2)="row 1 col2 value"
 N GHTML
 D GENHTML("GHTML","HTML")
 ZWR GHTML
 Q
 ;
ADDTO(DEST,WHAT) ; adds string WHAT to list DEST 
 ; DEST is passed by name
 N GN
 S GN=$O(@DEST@("AAAAAA"),-1)+1
 S @DEST@(GN)=WHAT
 S @DEST@(0)=GN ; count
 Q
 ;
ORGOID() ; extrinsic which returns the Organization OID
 Q "2.16.840.1.113883.5.83" ; WORLDVISTA HL7 OID - 
 ; REPLACE WITH OID LOOKUP FROM INSTITUTION FILE
 ;
DA2SNO(RTN,DNAME)       ; LOOK UP DRUG ALLERGY CODE IN ^LEX
        ; RETURNS AN ARRAY RTN PASSED BY REFERENCE
        ; THIS ROUTINE CAN BE USED AS AN RPC
        ; RTN(0) IS THE NUMBER OF ELEMENTS IN THE ARRAY
        ; RTN(1) IS THE SNOMED CODE FOR THE DRUG ALLERGY
        ;
        N LEXIEN
        I $O(^LEX(757.21,"ADIS",DNAME,""))'="" D  ; IEN FOUND FOR THIS DRUG
        . S LEXIEN=$O(^LEX(757.21,"ADIS",DNAME,"")) ; GET THE IEN IN THE LEXICON
        . W LEXIEN,!
        . S RTN(1)=$P(^LEX(757.02,LEXIEN,0),"^",2) ; SNOMED CODE IN P2
        . S RTN(0)=1 ; ONE THING RETURNED
        E  S RTN(0)=0 ; NOT FOUND
        Q
        ;
LOWCASE(X) ; extrinsic returns lowercase of X
 N Y
 S Y=$TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 Q Y
 ;
LOOKUP(RTN,PARM) ; generalized lookup routine which hides the
 ; messiness of code lookups
 I $G(PARM("table"))="Primary Language" D  ;
 . I $D(^JJOHcodeMap) D  ; on an Oroville system
 . . N LNM S LNM=$G(PARM("name"))
 . . Q:LNM=""
 . . N LANIEN S LANIEN=$O(^DI(.85,"B",LNM,""))
 . . Q:'LANIEN
 . . N CTMP,CDEU
 . . S CTMP=$G(^DI(.85,LANIEN,0))
 . . Q:CTMP=""
 . . S CDEU=$P(CTMP,"^",2) ; should be a 3 letter code for the language
 . . Q:$L(CDEU)'=3
 . . S RTN("code")=$$LOWCASE(CDEU)
 Q
 ;
SUBLIST(RTN,SRC,COUNT,START) ; returns a sublist of SRC starting at START
 ; and containing COUNT elements. RTN and SRC passed by name
 ; default is COUNT=10 and START=1
 I '$D(COUNT) S COUNT=10
 I '$D(START) S START=1
 N I S I=""
 N OCNT S OCNT=0
 N ICNT S ICNT=0
 F  S I=$O(@SRC@(I)) Q:I=""  D  Q:ICNT=COUNT  ;
 . S OCNT=OCNT+1 ; outer count
 . I OCNT<START Q  ; not there yet
 . S ICNT=ICNT+1 ; inner count
 . S @RTN@(I)="" ; add this one
 Q
 ;
FMX(RTN,FILE,IEN,CAMEL) ; return an array of a fileman record for external use in RTN,
 ; which is passed by name. input is file number and ien. CAMEL is 1 or 2 for camel case
 ;
 K @RTN
 I $D(PTR) D  ;
 . S FILE=$P($P(PTR,"(",2),",",1)
 . S IEN=$P(PTR,";",1)
 N TREC,FILENM
 D GETS^DIQ(FILE,IEN_",","**","ENR","TREC")
 S FILENM=$O(^DD(FILE,0,"NM",""))
 S FILENM=$TR(FILENM," ","_")
 ;ZWR TREC
 I $G(DEBUG)=1 B
 N % S %=$Q(TREC(""))
 F  D  Q:%=""  ;
 . N FNUM,FNAME,IENS,FIELD,VAL
 . S FNUM=$QS(%,1)
 . I $D(^DD(FNUM,0,"NM")) D  ;
 . . S FNAME=$O(^DD(FNUM,0,"NM",""))
 . . S FNAME=$TR(FNAME," ","_")
 . E  S FNAME=FNUM
 . S IENS=$QS(%,2)
 . S FIELD=$QS(%,3)
 . S FIELD=$TR(FIELD," ","_")
 . S VAL=@%
 . I FNUM=FILE D  ; not a subfile
 . . S @RTN@(FNAME,FIELD)=VAL
 . . S @RTN@(FNAME,"ien")=$P(IENS,",",1)
 . E  D  ;
 . . N I2 S I2=$O(@RTN@(FNAME,""),-1)+1
 . . I $L(IENS,",")>2 D  ;
 . . . S @RTN@(FNAME,IENS,FIELD)=VAL
 . . E  D  ;
 . . . S @RTN@(FNAME,$P(IENS,","),FIELD)=VAL
 . . ;S @RTN@(FNAME,I2,FIELD)=VAL
 . . ;S @RTN@(FNAME,I2,"iens")=IENS
 . W:$G(DEBUG)=1 !,%,"=",@%
 . S %=$Q(@%)
 Q
 ;
