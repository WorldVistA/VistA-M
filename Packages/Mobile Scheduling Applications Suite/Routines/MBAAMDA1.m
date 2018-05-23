MBAAMDA1 ;OIT-PD/CBR - APPOINTMENT API ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1,5**;Feb 13, 2015;Build 6
 ;
 ;Associated ICRs
 ;  ICR#
 ;  10038 HOLIDAY FILE
 ;  6044 SC(
 ;  10103 XLFDT
 ;
GETCLN(RETURN,CLN,INT,EXT,REZ) ; Get clinic detail Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT, MBAA PATIENT PENDING APPT
 N FILE,SFILES,FLDS
 S FILE=44
 S FLDS("*")=""
 S SFILES("2501")="",SFILES("2501","N")="PRIVILEGED USER",SFILES("2501","F")="44.04"
 S SFILES("1910")="",SFILES("1910","N")="SI",SFILES("1910","F")="44.03"
 S ROUT=1
 D GETREC^MBAAMDAL(.RETURN,CLN,FILE,.FLDS,.SFILES,$G(INT),$G(EXT),$G(REZ))
 Q
 ;
GETCLNX(RETURN,SC) ; Get clinic detailx Called by RPC MBAA APPOINTMENT MAKE
 N IND
 F IND=0:0 S IND=$O(RETURN(IND)) Q:IND=""  D
 . S RETURN(IND)=$$GET1^DIQ(44,SC_",",IND,"I")
 S RETURN=1
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;LSTCLNS(RETURN,SEARCH,START,NUMBER) ; Return clinics filtered by name.
 ; N FILE,FIELDS,RET,SCR
 ; S FILE="44",FIELDS="@;.01"
 ; S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 ; S SCR="I $P(^(0),U,3)=""C"",'$G(^(""OOS""))"
 ; D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"B",.SCR,"","RETURN")
 ; Q
 ; ;
GETCSC(FLDS,CSC) ; Get Clinic Stop Code MBAA RPC: MBAA APPOINTMENT MAKE
 N FLD,C
 D GETS^DIQ(40.7,CSC,"*","I","C")
 S FLD=""
 F  S FLD=$O(C(40.7,""_CSC_",",FLD)) Q:FLD=""  D
 . S FLDS(FLD)=C(40.7,""_CSC_",",FLD,"I")
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;CLNURGHT(CLN,USR,DATA) ; Return user right
 ; S DATA=$G(^SC(CLN,"SDPRIV",USR,0))
 ; Q
 ;
 ;LSTTMPL(RETURN,CLN) ; List defined day template
 ; N FILE,SFILES,FLDS
 ; S FILE=44
 ; S SFILES("1922")="",SFILES("1922","N")="SUNDAY TEMPLATE",SFILES("1922","F")="44.06"
 ; S SFILES("1923")="",SFILES("1923","N")="MONDAY TEMPLATE",SFILES("1923","F")="44.07"
 ; S SFILES("1924")="",SFILES("1924","N")="TUESDAY TEMPLATE",SFILES("1924","F")="44.08"
 ; S SFILES("1925")="",SFILES("1925","N")="WEDNESDAY TEMPLATE",SFILES("1925","F")="44.09"
 ; S SFILES("1926")="",SFILES("1926","N")="THURSDAY TEMPLATE",SFILES("1926","F")="44.08"
 ; S SFILES("1927")="",SFILES("1927","N")="FRIDAY TEMPLATE",SFILES("1927","F")="44.09"
 ; S SFILES("1928")="",SFILES("1928","N")="SATURDAY TEMPLATE",SFILES("1928","F")="44.0001"
 ; D GETREC^MBAAMDAL(.RETURN,CLN,FILE,.FLDS,.SFILES)
 ; Q
 ;
 ;NXTAV(CLN,SD) ; Get next available day.
 ; Q $O(^SC(CLN,"ST",SD))
 ; ;
GETHOL(RETURN,SDATE) ; Get holiday. Called by RPC MBAA APPOINTMENT MAKE
 S RETURN=0
 ;S:$D(^HOLIDAY(SDATE)) RETURN(0)=$G(^HOLIDAY(SDATE,0))
 N X,X1
 S X=$$GET1^DIQ(40.5,SDATE,.01,"I")  ;ICR#: 10038 HOLIDAY FILE
 S X1=$$GET1^DIQ(40.5,SDATE,2,"I")  ;ICR#: 10038 HOLIDAY FILE
 I $G(X)'="" S RETURN(0)=X_"^"_X1
 K X,X1
 S RETURN=1
 Q
 ;
 ;GETPATT(RETURN,SC,SD) ; Get date pattern Called by RPC MBAA APPOINTMENT MAKE
GETPATT(RETURN,SC,SD) ; Get date pattern Called by RPC MBAA APPOINTMENT MAKE
 S RETURN=0
 ;T13 change to use FM reads
 N X S IENS=$P(SD,".")_","_SC_",",X=$$GET1^DIQ(44.005,IENS,1),RETURN(0)=$G(X)
 ;S:$D(^SC(SC,"ST",$P(SD,"."),1)) RETURN(0)=^SC(SC,"ST",$P(SD,"."),1)  ;ICR#: 6044 SC(
 ;N X S IENS=$P(SD,".")_","_SC_",",X=$$GET1^DIQ(44.005,IENS,"CAN"),RETURN(0)=$G(X)
 ;T13 the line below is removed as this node is not defined in the DD.
 ;S:$D(^SC(SC,"ST",$P(SD,"."),"CAN")) RETURN(1)=^SC(SC,"ST",$P(SD,"."),"CAN")  ;ICR#: 6044 SC(
 S RETURN=1
 Q
 ;
GETSCAP(RETURN,SC,DFN,SD) ; Get clinic appointment Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT, MBAA PATIENT PENDING APPT
 N ZL,CO
 I $D(^SC(SC,"S",SD))  D  ;ICR#: 6044 SC(
 . S ZL=0
 . F  S ZL=$O(^SC(SC,"S",SD,1,ZL)) Q:'ZL  D  ;ICR#: 6044 SC(
 . . I '$D(^SC(SC,"S",SD,1,ZL,0)) Q  ;ICR#: 6044 SC(
 . . S IENS=$G(ZL)_","_$G(SD)_","_$G(SC)_",",FLDS=".01;1;2;3;4;7;8;10;310;30;9;688"
 . . N LEN,XRAY,OTHER,WARD,CLERK,DTMADE,XRAYRST,APTCAN,ELIG,OB,ARRAY,ERR,CON1
 . . N ARRAY,ERR D GETS^DIQ(44.003,IENS,FLDS,"IE","ARRAY","ERR")
 . . I $G(ARRAY(44.003,IENS,.01,"I"))'=DFN Q
 . . S LEN=$G(ARRAY(44.003,IENS,1,"I")),XRAY=$G(ARRAY(44.003,IENS,2,"I")),OTHER=$G(ARRAY(44.003,IENS,3,"I"))
 . . S WARD=$G(ARRAY(44.003,IENS,4,"I")),CLERK=$G(ARRAY(44.003,IENS,7,"I")),DTMADE=$G(ARRAY(44.003,IENS,8,"I")),OB=$G(ARRAY(44.003,IENS,9,"I"))
 . . S XRAYRST=$G(ARRAY(44.003,IENS,10,"I")),APTCAN=$G(ARRAY(44.003,IENS,310,"I")),ELIG=$G(ARRAY(44.003,IENS,30,"I")),CON1=$G(ARRAY(44.003,IENS,688,"I"))
 . . ;N CON1 S CON1=$$GET1^DIQ(44,IENS,688)
 . . S RETURN(0)=$G(DFN)_U_$G(LEN)_U_$G(XRAY)_U_$G(OTHER)_U_$G(WARD)_U_$G(CLERK)_U_$G(DTMADE)_U_$G(XRAYRST)_U_$G(APTCAN)_U_$G(ELIG)_U_$G(CON1)
 . . S:$G(OB)'="" RETURN("OB")=$G(OB)
 . . S RETURN=ZL
 . Q
 Q
 ;
GETCAPT(RETURN,SC,SD,IFN,FLAG) ; Get clinic appointment by IFN Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT
 N CAPT
 S DIQ="CAPT(",DIC="^SC(SC,""S"",SD,1,",DIQ(0)=$G(FLAG)  ;ICR#: 6044 SC(
 S DA=IFN,DR=".01;1;3;7;8;9;30;309;302;303;304;306;688"
 D EN^DIQ1
 M RETURN=CAPT(44.003,IFN)
 S RETURN(222)=SC
 S RETURN(333)=IFN
 Q
 ;
LOCKST(SC,SD) ; Lock availability node Called by RPC MBAA APPOINTMENT MAKE
 L +^SC(SC,"ST",$P(SD,"."),1):5 Q:'$T 0  ;ICR#: 6044 SC(
 Q 1
 ;
UNLCKST(SC,SD) ; Lock availability node  Called by RPC MBAA APPOINTMENT MAKE
 L -^SC(SC,"ST",$P(SD,"."),1)  ;ICR#: 6044 SC(
 Q
 ;
LOCKS(SC,SD) ; Lock clinic date node Called by RPC MBAA APPOINTMENT MAKE
 L +^SC(SC,"S",$P(SD,"."),1):5 Q:'$T 0  ;ICR#: 6044 SC(
 Q 1
 ;
UNLCKS(SC,SD) ; Unlock clinic date node Called by RPC MBAA APPOINTMENT MAKE
 L -^SC(SC,"S",$P(SD,"."),1)  ;ICR#: 6044 SC(
 Q
 ;
SETST(SC,SD,S) ; Set availability Called by RPC MBAA APPOINTMENT MAKE
 ;S ^SC(SC,"ST",$P(SD,".",1),1)=S  ;ICR#: 6044 SC(
 ;T13 CHANGE
 N ERR,FDA,IENS
 S IENS=$P(SD,".")_","_SC_","
 ;S IENS(2)=$P(SD,".")
 ;S FDA(44.005,IENS,.01)=$P(SD,".")
 S FDA(44.005,IENS,1)=$G(S)
 D FILE^DIE("","FDA","ERR")
 Q
 ;
 ;MAKE(SC,SD,DFN,LEN,SM,USR,OTHR,RQXRAY) ; Make clinic appointment Called by RPC MBAA APPOINTMENT MAKE
MAKE(SC,SD,DFN,LEN,SM,USR,OTHR,RQXRAY)  ; Make clinic appointment Called by the RPC MBAA APPOINTMENT MAKE
 N ERR,FDA,IENS
 S IENS="+2,"_SC_","
 S IENS(2)=+SD
 S FDA(44.001,IENS,.01)=+SD
 D UPDATE^DIE("","FDA","IENS","ERR")
 S SD=$G(IENS(2))
 K FDA,IENS
 S IENS="+1,"_+SD_","_SC_","
 S FDA(44.003,IENS,.01)=DFN
 S FDA(44.003,IENS,1)=LEN
 S FDA(44.003,IENS,3)=$G(OTHR)
 S FDA(44.003,IENS,7)=USR
 S FDA(44.003,IENS,8)=$P($$NOW^XLFDT,".")  ;ICR#: 10103 XLFDT
 S:$G(SM) FDA(44.003,IENS,9)="O"
 ;T13 change
 ;I $D(RQXRAY),RQXRAY>0 S ^SC("ARAD",SC,SD,DFN)=""  ;ICR#: 6044 SC(
 I $D(RQXRAY),RQXRAY>0 S FDA(44.003,IENS,10)="Y"  ;ICR#: 6044 SC(
 D UPDATE^DIE("","FDA","IENS","ERR")
 Q
 ;
CANCEL(SC,SD,DFN,CIFN) ; Kill clinic appointment Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT
 ;S SDNODE=^SC(SC,"S",SD,1,CIFN,0)
 N HSI,SB,SDDIF,SI,SL,SS,ST,STARTDAY,STR
 S SC1=SC
 S ^SC("ARAD",SC,SD,DFN)="N"  ;ICR#: 6044 SC(
 ;S TLNK=$P($G(^SC(SC,"S",SD,1,CIFN,"CONS")),U)  ;ICR#: 6044 SC(
 K ^SC(SC,"S",SD,1,CIFN)  ;ICR#: 6044 SC(
 K:$O(^SC(SC,"S",SD,0))'>0 ^SC(SC,"S",SD,0)  ;ICR#: 6044 SC(
 ;T13 CHANGE
 ;K:TLNK'="" ^SC("AWAS1",TLNK),TLNK  ;ICR#: 6044 SC(
 Q:'$D(^SC(SC,"ST",SD\1,1))  ;ICR#: 6044 SC(
 ;T13 Change
 N XL1,IENS
 S IENS=SC_"," D GETS^DIQ(44,IENS,"1914;1917","I","XL1") S SL=$G(XL1(44,IENS,1917,"I")),X=$G(XL1(44,IENS,1914,"I"))
 ;MBAA*1*5 - correct cancellation - calculation of X value
 S SL=$$GET1^DIQ(44,SC,1917,"I"),STARTDAY=$S($L(X):X,1:8),SB=STARTDAY-1/100,X=SL,HSI=$S(X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4),STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2) K Y  ;ICR#: 6044 SC(
 ;S SL=$$GET1^DIQ(44,SC,1917,"I"),STARTDAY=$S($L(X):X,1:8),SB=STARTDAY-1/100,X=$P(SL,U,6),HSI=$S(X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4),STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2) K Y  ;ICR#: 6044 SC(
 ;S SL=^SC(SC,"SL"),X=$P(SL,U,3),STARTDAY=$S($L(X):X,1:8),SB=STARTDAY-1/100,X=$P(SL,U,6),HSI=$S(X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4),STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2) K Y  ;ICR#: 6044 SC(
 N IENS
 S:$G(CAPT("LENGTH")) SL=CAPT("LENGTH") ;MBAA*1*5 - include length of appointment in calculation
 S IENS=$P(SD,".")_","_SC_",",S=$$GET1^DIQ(44.005,IENS,1),Y=SD#1-SB*100,ST=Y#1*SI\.6+(Y\1*SI),SS=SL*HSI/60
 ;S S=^SC(SC,"ST",SD\1,1),Y=SD#1-SB*100,ST=Y#1*SI\.6+(Y\1*SI),SS=SL*HSI/60  ;ICR#: 6044 SC(
 I Y'<1 F I=ST+ST:SDDIF S Y=$E(STR,$F(STR,$E(S,I+1))) Q:Y=""  S S=$E(S,1,I)_Y_$E(S,I+2,999),SS=SS-1 Q:SS'>0
 ;Code below changed to correct the naked global reference
 ;S ^(1)=S
 ;S ^SC(SC,"ST",SD\1,1)=S  ;ICR#: 6044 SC(
 ;T13 CHANGE
 S SC=SC1 K SC1
 D SETST(SC,SD,S)
 Q
 ;
COVERB(SC,SD,IFN) ; Kill first overbook appointment Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT
 I $D(^SC(SC,"S",SD,1,IFN,"OB")) Q 0  ;ICR#: 6044 SC(
 N X,OIFN
 S X=IFN,OIFN=0
 F  S X=$O(^SC(SC,"S",SD,1,X)) Q:X=""!(OIFN>0)  D  ;ICR#: 6044 SC(
 . I $D(^SC(SC,"S",SD,1,X,"OB")) K ^SC(SC,"S",SD,1,X,"OB") S OIFN=X  ;ICR#: 6044 SC(
 Q OIFN
 ;
GETFSTA(SC) ; Get first available day. Called by RPC MBAA APPOINTMENT MAKE
 N I
 S I=0
 Q $O(^SC(SC,"T",I))  ;ICR#: 6044 SC(
 ;
GETDAYA(RETURN,SC,SD) ; Get all day appointments Called by RPC MBAA APPOINTMENT MAKE
 N IND,I,D
 S I=$P(SD,".",1)
 F D=I-.01:0 S D=$O(^SC(SC,"S",D)) Q:$P(D,".",1)-I  D  ;ICR#: 6044 SC(
 . S %=0
 . F  S %=$O(^SC(SC,"S",D,1,%)) Q:%'>0  D  ;ICR#: 6044 SC(
 . . Q:'$D(^SC(SC,"S",D,1,%,0))  ;ICR#: 6044 SC(
 . . ; next two lines changed to correct the naked global reference
 . . ;S RETURN(%,"STATUS")=$P(^(0),U,9)
 . . ;S RETURN(%,"OB")=$D(^("OB"))
 . . ;T13 Change
 . . S DIQ="CAPT(",DIC="^SC(SC,""S"",D,1,",DA=%,DR="310;9" D EN^DIQ1
 . . S %=DA
 . . S RETURN(%,"STATUS")=$G(CAPT(44.003,%,310))
 . . S RETURN(%,"OB")=$G(CAPT(44.003,%,9))
 . . K DIQ,DA,DR,DIC,CAPT
 . . I $G(I)="" S I=$P(SD,".",1)
 . . ;S RETURN(%,"STATUS")=$P(^SC(SC,"S",D,1,%,0),U,9)
 . . ;S RETURN(%,"OB")=$D(^SC(SC,"S",D,1,%,"OB"))
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;LSTCAPTS(RETURN,SC,SDBEG,SDEND) ; 
 ; N SDT,SDDA,CNT,APT,SDATA,CNSTLNK
 ; S CNT=0 S:'$D(SDBEG) SDBEG=1 S:'$D(SDEND) SDEND=99999999
 ; F SDT=SDBEG:0 S SDT=$O(^SC(SC,"S",SDT)) Q:'SDT!($P(SDT,".",1)>SDEND)  D
 ; . F SDDA=0:0 S SDDA=$O(^SC(SC,"S",SDT,1,SDDA)) Q:'SDDA  D
 ; . . S CNSTLNK=$P($G(^SC(SC,"S",SDT,1,SDDA,"CONS")),U)
 ; . . Q:'$D(^SC(SC,"S",SDT,1,SDDA,0))
 ; . . ; next line changed to correct the naked global reference
 ; . . ;S APT=^(0)
 ; . . S APT=$G(^SC(SC,"S",SDT,1,SDDA,0))
 ; . . S CNT=CNT+1
 ; . . S SDATA=^DPT(+APT,"S",SDT,0)
 ; . . S RETURN(CNT,"CONS")=$G(CNSTLNK)
 ; . . S RETURN(CNT,"SD")=SDT
 ; . . S RETURN(CNT,"SC")=+SDATA
 ; . . S RETURN(CNT,"DFN")=+APT
 ; . . S RETURN(CNT,"SDDA")=SDDA
 ; . . S RETURN(CNT,"SDATA")=SDATA
 ; . . S RETURN(CNT,"CDATA")=APT
 ; Q
 ; ;
 ;LSTPAPTS(RETURN,DFN,SDBEG,SDEND) ; Get patient appointments
 ; N SDT,CNT,SDDA,SC,CN,CNPAT
 ; S CNT=0 S:'$D(SDBEG) SDBEG=DT S:'$D(SDEND) SDEND=99999999
 ; F SDT=SDBEG:0 S SDT=$O(^DPT(DFN,"S",SDT)) Q:'SDT!($P(SDT,".",1)>SDEND)  D
 ; . Q:'$D(^(SDT,0))
 ; . S CNT=CNT+1
 ; . S SDATA=^DPT(+DFN,"S",SDT,0)
 ; . S SC=+SDATA
 ; . S RETURN(CNT,"CONS")=$G(CNSTLNK)
 ; . S RETURN(CNT,"SD")=SDT
 ; . S RETURN(CNT,"SC")=SC
 ; . S RETURN(CNT,"DFN")=DFN
 ; . S SDDA="",CN=0
 ; . F  S CN=$O(^SC(SC,"S",SDT,1,CN)) Q:'+CN!(SDDA>0)  D
 ; . . S CNPAT=$P($G(^SC(SC,"S",SDT,1,CN,0)),U)
 ; . . Q:CNPAT'=DFN
 ; . . S SDDA=CN
 ; . S RETURN(CNT,"SDDA")=SDDA
 ; . S RETURN(CNT,"SDATA")=SDATA
 ; . S:SDDA>0 RETURN(CNT,"CDATA")=$G(^SC(SC,"S",SDT,1,SDDA,0))
 ; Q
 ;
GETDST(SC,SD) ; Get day slot  Called by RPC MBAA APPOINTMENT MAKE
 ;T13 change to use a FM call to get the data from the file
 N X S IENS=$P(SD,".")_","_SC_",",X=$$GET1^DIQ(44.005,IENS,1)
 Q X    ;ICR#: 6044 SC(
 ;Q $G(^SC(SC,"ST",SD,1))  ;ICR#: 6044 SC(
 ;
GETDPATT(RETURN,SC,SD,DAY) ; Called by RPC MBAA APPOINTMENT MAKE
 S RETURN("IEN")=$O(^SC(SC,"T"_DAY,SD))  ;ICR#: 6044 SC(
 S:RETURN("IEN")'="" RETURN("PAT")=$G(^SC(SC,"T"_DAY,RETURN("IEN"),1))  ;ICR#: 6044 SC(
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;UPDPATT(DATA,SC,SD) ; Update day pattern
 ; N IENS,I
 ; S IENS=SD_","_SC_","
 ; N FDA
 ; F I=0:0 S I=$O(DATA(I)) Q:I=""  D
 ; . S FDA(44.005,IENS,I)=DATA(I)
 ; N ERR
 ; D UPDATE^DIE("","FDA",,"ERR")
 ; Q
 ;
ADDPATT(DATA,SC,SD) ; Add day pattern Called by RPC MBAA APPOINTMENT MAKE
 N IENS,I,FDA,ERR
 S IENS="+1,"_SC_","
 S IENS(1)=SD
 F I=0:0 S I=$O(DATA(I)) Q:I=""  D
 . S FDA(44.005,IENS,I)=DATA(I)
 D UPDATE^DIE("","FDA","IENS","ERR")
 Q
 ;
LSTAENC(RETURN,SEARCH,START,NUMBER) ; Returns active encounters. MBAA RPC: MBAA APPOINTMENT MAKE
 N FILE,FIELDS,RET,SCR
 S FILE="409.68",FIELDS="@;.01I;.04I;.06"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S SCR="I $P(^(0),""^"",2)="_SEARCH_"&($D(^SCE(""ADFN"","_SEARCH_",$P(^(0),""^"",1))))"
 K SEARCH
 D LIST^DIC(FILE,"",.FIELDS,"",$G(NUMBER),.START,.SEARCH,"B",.SCR,"","RETURN","ERR")
 Q
