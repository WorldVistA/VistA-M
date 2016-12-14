HMPUTILS ;SLC/AGP,ASMR/RRB,CK -- HMP utilities routine ;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XLFCRC                        3156
 ; XLFDT                        10103
 ; XLFUTL                        2622
 ; XUPARAM                       2541
 ;
 ; DE2818/RRB: SQA findings 1st 3 lines
 Q
 ;
CHKSP(HMPFHMP) ; -- ^XTMP check before patient subscription starts to cache   *BEGIN*S68-PJH
 ; Input HMPFHMP - server name
 N HMPOK
 S HMPOK=0
 F  D  Q:HMPOK
 . ; -- if ok to run, reset DISK USAGE STATUS to 'WITHIN LIMIT' and continue ; US8228
 . I $$OKTORUN^HMPDJFSP("subscribe") S HMPOK=1 D STATUS^HMPMETA(HMPOK,HMPFHMP) Q  ; US8228
 . ; -- otherwise make sure DISK USAGE STATUS is 'EXCEEDED LIMIT' and wait ; US8228
 . D STATUS^HMPMETA(HMPOK,HMPFHMP) H $$GETSECS^HMPDJFSP  ; US8228
 Q  ;  *END*S68-PJH
 ;
SETERROR(RESULT,ERROR,EXTERROR,DATA) ; -- error text for JSON
 N CNT,TEMP,HMPTEMP,XCNT
 S HMPTEMP="HMPXTEMP ERRORS"
 I '$D(^XTMP(HMPTEMP,0)) S ^XTMP(HMPTEMP,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"HMP ERROR GLOBAL"
 S RESULT("success")="false"
 I $D(DATA) S XCNT=$O(^XTMP(HMPTEMP,""),-1)+1 M ^XTMP(HMPTEMP,XCNT,"ERROR")=DATA
 I $D(ERROR) D SETERRTX(.TEMP,.ERROR) S RESULT("error","code")=TEMP
 I +$G(XCNT)>0 S RESULT("error","code")=$G(RESULT("error","code"))_" See ^XTMP("_HMPTEMP_","_XCNT_",DATA) for data"
 I $D(EXTERROR) D SETERRTX(.TEMP,.EXTERROR) I TEMP'="" S RESULT("error","message")=TEMP
 ;
 Q
 ;
SETERRTX(TEMP,ERROR) ;
 S TEMP=""
 S CNT=0 F  S CNT=$O(ERROR(CNT)) Q:CNT'>0  D
 .S TEMP=$S(TEMP'="":TEMP=TEMP_$C(13,10)_ERROR(CNT),1:ERROR(CNT))
 Q
 ;
SETTEXT(X,VALUE) ; -- format word processing
 N FIRST,I,LINE
 S FIRST=1
 S I=0 F  S I=$O(@X@(I)) Q:I<1  D
 .S LINE=$S($D(@X@(I,0)):@X@(I,0),1:@X@(I))
 .; FIRST=1 S @VALUE@(I)=LINE,FIRST=0 Q
 .S @VALUE@(I)=LINE_$C(13)_$C(10)
 Q
 ;
SPLITVAL(NODE,ARRAY) ; -- split a value into a list
 N CNT,NAME,VALUE,FIELD
 S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  D
 .S CNT=+ARRAY(NAME)
 .S VALUE=$P($G(NODE),U,CNT)
 .I NAME="Code" S FIELD=$P(ARRAY(NAME),U,2) S VALUE=$$SETVURN(FIELD,VALUE)
 .S ARRAY(NAME)=VALUE
 Q
 ;
SETPROV(NODE,PROV) ; -- providers
 S PROV("providerUid")=$$SETUID("user",,+NODE)
 S PROV("providerName")=$P(NODE,U,2)
 Q
 ;
SETUID(DOMAIN,PAT,ID,ADDDATA) ; -- create uid string
 N RESULT,SYS
 S SYS=$S($D(HMPSYS):HMPSYS,1:$$SYS)
 S RESULT="urn:va:"_DOMAIN_":"_SYS_":"_$S($G(PAT):PAT_":",1:"")_ID
 I $L($G(ADDDATA)) S RESULT=RESULT_":"_ADDDATA
 Q RESULT
 ;
SETFCURN(DOMAIN,FACILITY,VALUE) ; -- create facility urn
 Q "urn:va:"_DOMAIN_":"_FACILITY_":"_VALUE
 ;
SETVURN(DOMAIN,VALUE) ; -- create VA urn
 N RESULT S RESULT=""
 S RESULT="urn:va:"_DOMAIN_":"_VALUE
 Q RESULT
 ;
SYS(NAME) ; -- return hashed system name from HMP SYSTEM NAME parameter, or calculate from NAME parameter if it exists
 ; DE4463 4/22/2016 CK - changed HMP routines to all call this function
 ;  SYS^HMPUTILS returns a 4 digit hashed site, padded with leading zeros
 I '$L($G(NAME)) Q $$GET^XPAR("SYS","HMP SYSTEM NAME")
 Q $TR($J($$BASE^XLFUTL($$CRC16^XLFCRC(NAME),10,16),4)," ",0)
 ;
SETNCS(CODESET,VALUE) ; -- create national codeset urn
 Q "urn:"_CODESET_":"_VALUE
 ;
JSONDT(X) ; -- convert FileMan DT to HL7 DT for JSON
 N HL7DT,T,Y
 ;DE3116 4/12/16 ASF,JC function updated to handle FM date problems
 ; T indicates that a time was included
 S T=0 I $E(X,8)=".",$E(X,6,7) S T=1  ; if there's a time it must be a precise date
 S Y=$S(T:X,1:X\1)  ; strip time if imprecise date
 I T,($E(Y,9,10)>23)!($E(Y,11,12)>59)!($E(Y,13,14)>59) S Y=$$FMADD^XLFDT(Y,0,0,0,0) ;DE3116 ASF 04/09/16 allows for hrs >24 and mins >60
 S HL7DT=$P($$FMTHL7^XLFDT(Y),"-")  ; remove time zone offset
 S:T HL7DT=$E(HL7DT_"000000",1,14)  ; if time passed, result must be 14 chars.
 Q HL7DT
 ;
FACILITY(X,Y) ; -- add facility info to array for JSON
 ;  X=STATION NUMBER^STATION NAME
 ;  Y=Variable array name
 ; >D FACILITY^HMPUTILS("500^CAMP MASTER","LAB")
 ;
 S @Y@("facilityCode")=$P(X,"^")
 S @Y@("facilityName")=$P(X,"^",2)
 Q
VERSRV()   ; Return server version of option name
 N HMPLST,VAL
 D FIND^DIC(19,"",1,"X","HMP UI CONTEXT",1,,,,"HMPLST")
 S VAL=$G(HMPLST("DILIST","ID",1,1))
 Q $$UP^XLFSTR($P(VAL,"version ",2))
 ;
VERCMP(CUR,VAL) ; Returns 1 if CUR<VAL, -1 if CUR>VAL, 0 if equal
 N CURMAJOR,CURMINOR,CURSNAP,VALMAJOR,VALMINOR,VALSNAP
 S CURMAJOR=$P(CUR,"-"),CURMINOR=$P(CUR,"-",2),CURSNAP=$E($P(CUR,"-",3),1,4)="SNAP"
 S VALMAJOR=$P(VAL,"-"),VALMINOR=$P(VAL,"-",2),VALSNAP=$E($P(VAL,"-",3),1,4)="SNAP"
 I $E(VALMINOR)="P" S VALMINOR=$E(VALMINOR,2,99)     ; "P"ilot versions (old)
 I $E(CURMINOR)="P" S CURMINOR=$E(VALMINOR,2,99)
 I $E(VALMINOR)="S" S VALMINOR=$E(VALMINOR,2,99)*10  ; "S"print versions
 I $E(CURMINOR)="S" S CURMINOR=$E(CURMINOR,2,99)*10
 Q:VALMAJOR>CURMAJOR 1   Q:VALMAJOR<CURMAJOR -1  ; compare major versions
 Q:VALMINOR>CURMINOR 1   Q:VALMINOR<CURMINOR -1  ; compare minor versions
 Q:(CURSNAP&'VALSNAP) 1  Q:(VALSNAP&'CURSNAP) -1 ; "SNAPSHOT" < released
 Q 0
 ;
WDWH() ; What kind of data exists?
 ; HMPA   = loop counter
 ; HMPB   = dummy variable
 ; HMPOPD = 1 if operational data exists
 ;         "" otherwise
 ; HMPPAT = 1 if patient data exists
 ;         "" otherwise
 ; HMPRET = return variable - 0 if no data exists
 ;                            1 if ONLY patient data exists
 ;                            2 if ONLY operational data exists
 ;                            3 if BOTH patient and operational data exist
 N HMPA,HMPOPD,HMPPAT,HMPRET
 S (HMPOPD,HMPPAT)="",HMPA="HMPFX",HMPRET=0
 F  S HMPA=$O(^XTMP(HMPA)) Q:HMPA']""  D
 .S HMPB=$P(HMPA,"~",3)
 .I HMPB="OPD" S HMPOPD=1 Q
 .I HMPB=+HMPB S HMPPAT=1
 I HMPPAT,'HMPOPD S HMPRET=1
 I 'HMPPAT,HMPOPD S HMPRET=2
 I HMPPAT,HMPOPD S HMPRET=3
 Q HMPRET
 ;
NODATA(A) ; Is there any patient data; JD - 2/23/15
 ; Returns 1 if there is no patient data
 ;          0 Otherwise
 ; HMPA = Loop counter
 ; HMPF = Dummy variable
 N HMPA,HMPF
 S HMPF=0,HMPA=""
 F  S HMPA=$O(^XTMP(A,0,"count",HMPA)) Q:HMPF!(HMPA']"")  D
 .I +$G(^XTMP(A,0,"count",HMPA))>0 S HMPF=1 Q
 Q $S(HMPF:0,1:1)
 ;
GETSIZE(HMPMODE,HMPSRVN) ; -- returns current aggregate extract size for extracts waiting to be sent to HMP servers
 ; input: HMPMODE := [ estimate - use estimated domain average sizes (default) |
 ;                     actual - walk though object nodes to calculate using $LENGTH ]
 ;        HMPSRVN := name of HMP server [optional - defaults to all HMP servers]
 ; returns: total size ^ object count
 ;
 ; -- loop thru extracts for server(s) 
 N ROOT,BATCH,TASK,DOMAIN,OBJS,OBJCNT,OBJSIZES,TOTAL
 S HMPMODE=$G(HMPMODE,"estimate")
 I HMPMODE="estimate" D GETLST^XPAR(.OBJSIZES,"PKG","HMP DOMAIN SIZES","I")
 S (OBJCNT,TOTAL)=0
 S ROOT="HMPFX~"_$S($G(HMPSRVN)]"":HMPSRVN_"~",1:"")
 S BATCH=ROOT
 F  S BATCH=$O(^XTMP(BATCH)) Q:$E(BATCH,1,$L(ROOT))'=ROOT  D
 . S TASK=0 F  S TASK=$O(^XTMP(BATCH,TASK)) Q:'TASK  D
 . . S DOMAIN="" F  S DOMAIN=$O(^XTMP(BATCH,TASK,DOMAIN)) Q:DOMAIN=""  D
 . . . S OBJS=+$O(^XTMP(BATCH,TASK,DOMAIN," "),-1)
 . . . S OBJCNT=OBJCNT+OBJS
 . . . I HMPMODE="actual" S TOTAL=TOTAL+$$WALK(BATCH,TASK,DOMAIN) Q
 . . . S TOTAL=TOTAL+(OBJS*$G(OBJSIZES($P(DOMAIN,"#")),1000))
 Q TOTAL_"^"_OBJCNT
 ;
WALK(BATCH,TASK,DOMAIN) ; -- walk through domain objectS in task to get actual size
 N OBJ,SIZE,NODE
 S (OBJ,SIZE)=0
 F  S OBJ=$O(^XTMP(BATCH,TASK,DOMAIN,OBJ)) Q:'OBJ  D
 . S NODE=0 F  S NODE=$O(^XTMP(BATCH,TASK,DOMAIN,OBJ,NODE)) Q:'NODE  S SIZE=SIZE+$L(^(NODE))
 Q SIZE
