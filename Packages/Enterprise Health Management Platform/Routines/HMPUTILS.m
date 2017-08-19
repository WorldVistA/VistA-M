HMPUTILS ;SLC/AGP,ASMR/ASF,JC-HMP utilities ;Jan 20, 2017 17:18:18
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2,3**;Sep 01, 2011;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6644, 7 September 2016, updated comments, corrected variables in stack, optimized code
 ;
 ; integration agreements:
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XLFCRC                        3156
 ; XLFDT                        10103
 ; XLFUTL                        2622
 ; XUPARAM                       2541
 ;
 ;
 ;
CHKSP(HMPFHMP) ; ^XTMP check before patient subscription starts to cache   *BEGIN*S68-PJH
 ; HMPFHMP - server name
 N HMPOK S HMPOK=0
 F  D  Q:HMPOK
 . I $$GETMAX>$$GETSIZE("estimate",HMPFHMP) S HMPOK=1 D STATUS^HMPMETA(HMPOK,HMPFHMP) Q  ; set DISK USAGE STATUS to 'WITHIN LIMIT' and continue, US8228
 . D STATUS^HMPMETA(HMPOK,HMPFHMP) H $$GETSECS^HMPDJFSP  ; DISK USAGE STATUS is 'EXCEEDED LIMIT' and wait, US8228
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
SETERRTX(TEMP,ERROR) ; concatenate errors from ERROR array, put CR, LF between them
 S TEMP="",CNT=0  ; CNT, TEMP from SETERROR
 F  S CNT=$O(ERROR(CNT)) Q:CNT'>0  S TEMP=$S(TEMP'="":TEMP=TEMP_$C(13,10)_ERROR(CNT),1:ERROR(CNT))
 Q
 ;
 ;
SETTEXT(X,VALUE) ; -- format word processing text
 N FIRST,I,LINE
 S FIRST=1
 S I=0 F  S I=$O(@X@(I)) Q:I<1  D
 .S LINE=$S($D(@X@(I,0)):@X@(I,0),1:@X@(I))
 .; FIRST=1 S @VALUE@(I)=LINE,FIRST=0 Q
 .S @VALUE@(I)=LINE_$C(13)_$C(10)
 Q
 ;
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
 ;
SETPROV(NODE,PROV) ; -- providers
 S PROV("providerUid")=$$SETUID("user",,+NODE),PROV("providerName")=$P(NODE,U,2) Q
 ;
SETUID(DOMAIN,PAT,ID,ADDDATA) ; function, UID string
 N RESULT,SYS
 S SYS=$S($D(HMPSYS):HMPSYS,1:$$SYS^HMPUTILS)
 S RESULT="urn:va:"_DOMAIN_":"_SYS_":"_$S($G(PAT):PAT_":",1:"")_ID
 I $L($G(ADDDATA)) S RESULT=RESULT_":"_ADDDATA
 Q RESULT
 ;
 ;
SETFCURN(DOMAIN,FACILITY,VALUE) ; function, create facility URN
 Q "urn:va:"_DOMAIN_":"_FACILITY_":"_VALUE
 ;
 ;
SETVURN(DOMAIN,VALUE) ; function, create VA urn
 Q "urn:va:"_DOMAIN_":"_VALUE
 ;
SYS(NAME) ; -- return hashed system name from HMP SYSTEM NAME parameter, or calculate from NAME parameter if it exists
 ; DE4463 4/22/2016 CK - changed HMP routines to all call this function
 ;  SYS^HMPUTILS returns a 4 digit hashed site, padded with leading zeros
 N SYS
 S SYS=$$GET^XPAR("SYS","HMP SYSTEM NAME")
 I '$L($G(NAME)),'$L(SYS) Q $$SYS($$KSP^XUPARAM("WHERE"))       ; r2.0 install workaround: if no parameter AND no HMP SYSTEM NAME, then calculate and return using domain name
 I '$L($G(NAME)) Q SYS                                        ; else return HMP SYSTEM NAME parameter
 Q $TR($J($$BASE^XLFUTL($$CRC16^XLFCRC(NAME),10,16),4)," ",0) ; else calculate from parameter
 ;
 ;
SETNCS(CODESET,VALUE) ; -- create national codeset URN
 Q "urn:"_CODESET_":"_VALUE
 ;
JSONDT(X) ; function, convert FileMan date-time to HL7 date-time for JSON
 N HL7DT,T,Y
 ;DE3116, 12 April 2016 function updated to handle FM date problems
 ; T indicates that a time was included
 S T=0 I $E(X,8)=".",$E(X,6,7) S T=1  ; if there's a time it must be a precise date
 S Y=$S(T:X,1:X\1)  ; strip time if imprecise date
 I T,($E(Y,9,10)>23)!($E(Y,11,12)>59)!($E(Y,13,14)>59) S Y=$$FMADD^XLFDT(Y,0,0,0,0) ;DE3116 ASF 04/09/16 allows for hrs >24 and mins >60
 S HL7DT=$$FMTHL7^HMPSTMP(Y)  ; DE5016
 S:T HL7DT=$E(HL7DT_"000000",1,14)  ; if time passed, result must be 14 chars.
 Q HL7DT
 ;
 ;
FACILITY(X,Y) ; -- add facility info to array for JSON
 ;  X=STATION NUMBER^STATION NAME
 ;  Y=Variable array name
 ; >D FACILITY^HMPUTILS("500^CAMP MASTER","LAB")
 ;
 S @Y@("facilityCode")=$P(X,"^")
 S @Y@("facilityName")=$P(X,"^",2)
 Q
 ;
 ;
VERSRV()   ; function, Return server version of option name
 N HMPLST,VAL
 D FIND^DIC(19,"",1,"X","HMP UI CONTEXT",1,,,,"HMPLST")
 S VAL=$G(HMPLST("DILIST","ID",1,1))
 Q $$UP^XLFSTR($P(VAL,"version ",2))
 ;
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
 ;
WDWH() ; What kind of data exist?, DE6644, 7 September 2016
 ; HMPA   = loop counter
 ; HMPB   = node information
 ; HMPOPD = 1 if operational data exists, 0 otherwise
 ; HMPPAT = 1 if patient data exist, 0 otherwise
 ; HMPRET = return variable - 0 if no data exist
 ;                            1 if ONLY patient data exist
 ;                            2 if ONLY operational data exist
 ;                            3 if BOTH patient and operational data exist
 N HMPA,HMPB,HMPOPD,HMPPAT,HMPRET
 S (HMPOPD,HMPPAT,HMPRET)=0,HMPA="HMPFX"
 ; iterate through HMP* data only
 F  S HMPA=$O(^XTMP(HMPA)) Q:'($E(HMPA,1,3)="HMP")  D  Q:HMPOD&HMPPAT  ; no need to continue if both flags set
 . S HMPB=$P(HMPA,"~",3) I HMPB="OPD" S HMPOPD=1 Q  ; operational data
 . S:HMPB=+HMPB HMPPAT=1  ; patient data
 I HMPPAT,'HMPOPD S HMPRET=1  ; ONLY patient data
 I 'HMPPAT,HMPOPD S HMPRET=2  ; ONLY operational data
 I HMPPAT,HMPOPD S HMPRET=3   ; patient & operational data
 Q HMPRET
 ;
NODATA(A) ; boolean function, is there any patient data for stream in A?; JD - 2/23/15
 ; Returns 1 if there is no patient data, 0 Otherwise, DE6644, 7 September 2016
 ; HMPA = Loop counter
 ; HMPF = Flag indicating data found
 N HMPA,HMPF
 S HMPF=0,HMPA=""
 F  S HMPA=$O(^XTMP(A,0,"count",HMPA)) Q:HMPF!(HMPA="")  S:+$G(^XTMP(A,0,"count",HMPA))>0 HMPF=1
 Q 'HMPF  ; return opposite of flag
 ;
GETSIZE(HMPMODE,HMPSRVN) ; function, returns aggregate extract size for extracts waiting to be sent to HMP servers
 ; returns: total size ^ object count
 ; HMPMODE = estimate - use estimated domain average sizes (default)
 ;           actual - walk though object nodes to calculate using $LENGTH
 ; HMPSRVN = name of HMP server [optional - defaults to all HMP servers]
 ; DE7401, move function here, 20 January 2017
 ; loop through extracts for server(s) 
 N BATCH,DOMAIN,L,OBJCNT,OBJS,OBJSIZES,ROOT,TASK,TOTAL
 S HMPMODE=$G(HMPMODE,"estimate")  ; default to estimate
 S:'("^estimate^actual^")[U_HMPMODE_U HMPMODE="estimate"  ; valid mode check
 I HMPMODE="estimate" D GETLST^XPAR(.OBJSIZES,"PKG","HMP DOMAIN SIZES","I")  ; domain sizes needed for estimate
 ; object counter, total, root node, batch to check, L is length of ROOT for loop exit
 S (OBJCNT,TOTAL)=0,ROOT="HMPFX~"_$S($G(HMPSRVN)]"":HMPSRVN_"~",1:""),BATCH=ROOT,L=$L(ROOT)
 F  S BATCH=$O(^XTMP(BATCH)) Q:$E(BATCH,1,L)'=ROOT  D
 . S TASK=0 F  S TASK=$O(^XTMP(BATCH,TASK)) Q:'TASK  S DOMAIN="" F  S DOMAIN=$O(^XTMP(BATCH,TASK,DOMAIN)) Q:DOMAIN=""  D
 ..  S OBJS=+$O(^XTMP(BATCH,TASK,DOMAIN," "),-1),OBJCNT=OBJCNT+OBJS
 ..  I HMPMODE="estimate" S TOTAL=TOTAL+(OBJS*$G(OBJSIZES($P(DOMAIN,"#")),1000)) Q  ; use domain sizes for estimate & quit
 ..  S TOTAL=TOTAL+$$WALK(BATCH,TASK,DOMAIN)  ; fall through for actual
 Q TOTAL_"^"_OBJCNT
 ;
WALK(BATCH,TASK,DOMAIN) ; function, walk through domain objects in task to get actual size
 N NODE,OBJ,SIZE
 S (OBJ,SIZE)=0
 F  S OBJ=$O(^XTMP(BATCH,TASK,DOMAIN,OBJ)) Q:'OBJ  D
 . S NODE=0 F  S NODE=$O(^XTMP(BATCH,TASK,DOMAIN,OBJ,NODE)) Q:'NODE  S SIZE=SIZE+$L(^(NODE))
 Q SIZE  ; return size in bytes
 ;
GETMAX() ; function, return the max allowable aggregate extract size in bytes
 ;
 N HMPLIM S HMPLIM=$$GET^XPAR("SYS","HMP EXTRACT DISK SIZE LIMIT")*1000000
 Q $S(HMPLIM>999999:HMPLIM,1:20000000)  ; if not set to 1 million minimum, return 20mb characters
 ;
