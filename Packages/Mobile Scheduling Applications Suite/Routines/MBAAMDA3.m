MBAAMDA3 ;OIT-PD/CBR - APPOINTMENT API ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1**;Feb 13, 2015;Build 85
 ;
 ;Associated ICRs
 ;  ICR#
 ;  6053 DPT
 ;  10076 XUSEC
 ;
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;GETPATS(RETURN,SEARCH,START,NUMBER) ; Get patients
 ; N FILE,FIELDS,RET,SCR,INDX
 ; S FILE="2",FIELDS="@;.01;.03;.09;391;1901",INDX="B"
 ; S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 ; I $D(SEARCH),SEARCH?4N S INDX="BS"
 ; I $L(SEARCH)>1,SEARCH?.N S INDX="SSN"
 ; I $L(SEARCH)>0,SEARCH?1A4N S INDX="BS5"
 ; D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,INDX,.SCR,"","RETURN")
 ; Q
 ;
GETPAT(RETURN,PAT,INT,EXT,REZ) ; Get patient detail Called by RPC MBAA APPOINTMENT MAKE
 N FILE,SFILES,FLDS
 S FILE=2
 S FLDS("*")=""
 S SFILES(".3721")="",SFILES(".3721","N")="RATED DISABILITIES",SFILES(".3721","F")="2.04"
 S SFILES("2")="",SFILES("2","N")="RACE INFORMATION",SFILES("2","F")="2.02"
 S SFILES("6")="",SFILES("6","N")="ETHNICITY INFORMATION",SFILES("6","F")="2.06"
 S ROUT=2
 D GETREC^MBAAMDAL(.RETURN,PAT,FILE,.FLDS,.SFILES,$G(INT),$G(EXT),$G(REZ))
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;LSTETNS(RETURN,SEARCH,START,NUMBER) ; Return ethnicity information.
 ; N FILE,FIELDS,RET,SCR
 ; S FILE="10.2",FIELDS="@;.01"
 ; S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 ; S SCR="I $S('$D(^(.02)):1,$P(^(.02),U,1)=1:0,1:1)"
 ; D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"B",.SCR,"","RETURN")
 ; Q
 ; ;
 ;SETETN(PAT,ETN) ; Set patient ethnicity.
 ; N IENS,FDA,MSG
 ; S IENS="?+1,"_PAT_","
 ; S FDA(2.06,IENS,".01")=ETN
 ; S FDA(2.06,IENS,".02")=1
 ; D UPDATE^DIE("","FDA","IENS","MSG")
 ; Q
 ;
 ;LSTRACES(RETURN,SEARCH,START,NUMBER) ; Return races.
 ; N FILE,FIELDS,RET,SCR
 ; S FILE="10",FIELDS="@;.01"
 ; S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 ; S SCR="I $S('$D(^(.02)):1,$P(^(.02),U,1)=1:0,1:1)"
 ; D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"B",.SCR,"","RETURN")
 ; Q
 ; ;
 ;GETPRES(RETURN,PAT) ; Get patient races
 ; N FILE,SFILES,FLDS
 ; S FILE=2
 ; S SFILES("2")="",SFILES("2","N")="RACE INFORMATION",SFILES("2","F")="2.02"
 ; D GETREC^MBAAMDAL(.RETURN,PAT,FILE,.FLDS,.SFILES,$G(INT),$G(EXT),$G(REZ))
 ; Q
 ;
 ;ADDRACE(PAT,RACE) ; Set patient race.
 ; N IENS,FDA,MSG
 ; S IENS="?+2,"_PAT_","
 ; S IENS(2)=RACE
 ; S FDA(2.02,IENS,".01")=RACE
 ; S FDA(2.02,IENS,".02")=1
 ; D UPDATE^DIE("","FDA","IENS","MSG")
 ; Q
 ;
MAKE(DFN,SD,SC,TYPE,STYP,STAT,RSN,USR,DT,SRT,NAAI,LAB,XRAY,EKG,DESDT) ; Make patient appointment Called by RPC MBAA APPOINTMENT MAKE
 N ERR,FDA,IENS
 I $D(^DPT(DFN,"S",+SD,0)),$P(^DPT(DFN,"S",+SD,0),U,2)["C" D   ;ICR#: 6053 DPT
 . S IENS=SD_","_DFN_","
 . S FDA(2.98,IENS,".01")=SC
 . S FDA(2.98,IENS,"3")="@"
 . S FDA(2.98,IENS,"9")=$G(RSN)
 . S FDA(2.98,IENS,"9.5")=$G(TYPE)
 . S FDA(2.98,IENS,"17")="@"
 . S FDA(2.98,IENS,"20")=DT
 . S FDA(2.98,IENS,"27")=$G(DESDT)
 . D FILE^DIE("","FDA","ERR")
 E  D
 . S IENS="?+2,"_DFN_","
 . S IENS(2)=+SD
 . S FDA(2.98,IENS,.01)=SC
 . S FDA(2.98,IENS,"3")=STAT
 . S FDA(2.98,IENS,"5")=$G(LAB)
 . S FDA(2.98,IENS,"6")=$G(XRAY)
 . S FDA(2.98,IENS,"7")=$G(EKG)
 . S FDA(2.98,IENS,"9")=$G(RSN)
 . S FDA(2.98,IENS,"9.5")=$G(TYPE)
 . S FDA(2.98,IENS,"19")=USR
 . S FDA(2.98,IENS,"20")=DT
 . S FDA(2.98,IENS,"24")=$G(STYP)
 . S FDA(2.98,IENS,"25")=$G(SRT)
 . S FDA(2.98,IENS,"26")=$G(NAAI)
 . S FDA(2.98,IENS,"27")=$G(DESDT)
 . D UPDATE^DIE("","FDA","IENS","ERR")
 Q
 ;
CANCEL(RETURN,DFN,SD,TYP,RSN,RMK,CDT,USR,OUSR,ODT) ; Cancel appointment. Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT
 N IENS,FDA
 S IENS=SD_","_DFN_","
 S FDA(2.98,IENS,3)=TYP
 S FDA(2.98,IENS,14)=USR
 S FDA(2.98,IENS,15)=CDT
 S FDA(2.98,IENS,16)=RSN
 S FDA(2.98,IENS,19)=OUSR
 S FDA(2.98,IENS,20)=ODT
 S:$G(RMK)]"" FDA(2.98,IENS,17)=$E(RMK,1,160)
 D FILE^DIE("","FDA","RETURN")
 Q
 ;
GETXUS(RETURN,KEYS,USR) ; Get user access Called by RPC MBAA APPOINTMENT MAKE
 N KEY
 K RETURN S KEY=""
 F  S KEY=$O(KEYS(KEY)) Q:KEY=""  S:$D(^XUSEC(KEY,USR)) RETURN(KEY)=""  ;ICR#: 10076 XUSEC
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;GETCENRL(RETURN,DFN,SC) ; Get clinic enrolls
 ; N IND,EC,SSC
 ; K RETURN S RETURN=0
 ; F SSC=0:0 S SSC=$O(^DPT(DFN,"DE","B",SSC)) Q:SSC=""  D
 ; . Q:$G(SC)>0&(SSC'=$G(SC))
 ; . S EC=$O(^DPT(DFN,"DE","B",SSC,"")) Q:'EC
 ; . S RETURN(SSC,0)=EC_U_^DPT(DFN,"DE",EC,0)
 ; . F IND=0:0 S IND=$O(^DPT(DFN,"DE",EC,1,IND)) Q:IND=""  D
 ; . . S RETURN(SSC,IND)=^DPT(DFN,"DE",EC,1,IND,0)
 ; S RETURN=1
 ; Q
 ;
 ;UPDENRL(ENS,DFN) ;
 ; N IENS,FDA,ERR,IND,SC
 ; S SC=$O(ENS(""))
 ; S IENS=ENS(SC,"IEN")_","_DFN_","
 ; S FDA(2.001,IENS,2)="I"
 ; D UPDATE^DIE("","FDA",,"ERR")
 ; F IND=0:0 S IND=$O(ENS(SC,"EN",IND)) Q:IND=""  D
 ; . Q:(IND'>0)
 ; . S IENS=IND_","_ENS(SC,"IEN")_","_DFN_","
 ; . S:$D(ENS(SC,"EN",IND,"DISCHARGE")) FDA(2.011,IENS,3)=ENS(SC,"EN",IND,"DISCHARGE")
 ; . S:$D(ENS(SC,"EN",IND,"REASON")) FDA(2.011,IENS,4)=ENS(SC,"EN",IND,"REASON")
 ; . D UPDATE^DIE("","FDA",,"ERR")
 ; Q
 ;
