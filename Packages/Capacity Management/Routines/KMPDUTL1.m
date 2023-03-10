KMPDUTL1 ;OAK/RAK,KAK,JML - CM TOOLS Utilities ;2/17/04
 ;;4.0;CAPACITY MANAGEMENT;;11/15/2017;Build 38
 ;
CONT(KMPDEXT)  ;-- function displays 'return to continue' message at bottom of page
 ;--------------------------------------------------------------------
 ; KMPDEXT 0 = do not show 'to exit' text
 ;         1 = show 'to exit' text
 ;
 ; Return: 0 = continue
 ;         1 = quit
 ;--------------------------------------------------------------------
 ;
 N DIR,X,Y
 ;
 S KMPDEXT=+$G(KMPDEXT)
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="EA"
 S DIR("A")="Press RETURN to continue"_$S(KMPDEXT:" or '^' to exit: ",1:": ")
 D ^DIR
 Q +$G(Y)
 ;
CURSTAT(STAT)   ;-- current status
 ;---------------------------------------------------------------------
 ; input:  STAT (optional) = data from $$TSKSTAT^KMPSUTL1
 ; output: See codes below
 ;---------------------------------------------------------------------
 ;
 N RESULT,SITNUM,STRTDT
 ;
 S RESULT="",SITNUM=^DD("SITE",1),STRTDT=$G(^XTMP("KMPS",SITNUM,0))
 ;
 I $D(^XTMP("KMPS","ERROR")) Q "6^ERRORS RECORDED"
 I $D(^XTMP("KMPS","STOP")) Q "7^STOPPING"
 I $D(^XTMP("KMPS","START")) L +^XTMP("KMPS"):0 I $T L -^XTMP("KMPS") Q "5^DID NOT COMPLETE"
 I +STRTDT I +$H-STRTDT>2 Q "5^DID NOT COMPLETE"
 I +STRTDT I +$H-STRTDT>1 Q "4^RUNNING TOO LONG"
 I $D(^XTMP("KMPS","START")) Q "0^RUNNING"
 I $D(STAT) Q $P(STAT,U,1,2)
 E  Q "3^NOT RUNNING"
 Q "9^UNKNOWN"
 ;
SYSINFO() ;-- returns system information
 ;---------------------------------------------------------------------
 ; Returns:
 ;         "^" piece 1 - type of M platform
 ;         "^" piece 2 - $ZV => name and version of M system
 ;         "^" piece 3 - operating system version
 ;
 ;---------------------------------------------------------------------
 ;
 N MPLTF,OSVER,SYSINFO
 ;
 S MPLTF=$$MPLTF(),OSVER=$$OSVER(MPLTF)
 S SYSINFO=MPLTF_U_$ZV_U_OSVER
 Q SYSINFO
 ;
MPLTF() ;-- returns the type of M platform
 ;---------------------------------------------------------------------
 ; Returns:  DSM    for DSM platform
 ;           CVMS   for Cache for OpenVMS platform
 ;           CWINNT for Cache for Windows NT platform
 ;---------------------------------------------------------------------
 ;
 N MPLTF,ZV
 ;
 S ZV=$ZV
 S MPLTF=$S(ZV["DSM":"DSM",ZV["VMS":"CVMS",ZV["Windows":"CWINNT",1:"UNK")
 Q MPLTF
 ;
OSVER(MPLTF) ;-- returns the operating system version
 ;---------------------------------------------------------------------
 ; input: MPLTF = type of M platform
 ;---------------------------------------------------------------------
 ;
 I $G(MPLTF)="" Q ""
 ;
 I MPLTF["DSM" Q $ZC(%GETSYI,"VERSION")
 I MPLTF["CVMS" Q $$CVMSVER^KMPDUTL5()
 I MPLTF["CWINNT" Q $$CWNTVER^KMPDUTL5()
 Q ""
 ;
TSKSTAT(OPT) ;-- status of scheduled task option
 ;---------------------------------------------------------------------
 ; input  OPT = option name
 ; 
 ; output RTN = by "^" piece
 ;               1 - status code
 ;               2 - literal condition
 ;               3 - scheduled date@time (day)
 ;               4 - numeric day-of-week
 ;               5 - expanded scheduled frequency
 ;               6 - short form frequency
 ;               7 - task id
 ;               8 - queued by
 ;               9 - user status
 ;
 ; where status code^condition:
 ;            = 0^SCHEDULED
 ;            = 1^NOT SCHEDULED and 'scheduled date@time' will
 ;                   be UNKNOWN and 'numeric day of week' will be -1
 ;            = 2^NOT RESCHEDULED
 ;            = 3^MISSING when OPT does not exist
 ;            = 9^UNKNOWN
 ;            = ""^UNDEFINED
 ;
 ; where user status = ACTIVE or NOT ACTIVE
 ;---------------------------------------------------------------------
 ;
 Q:$G(OPT)="" "^UNDEFINED"
 ;
 N ACTV,DA,DAY,DOW,FREQ,RTN,TSK,TSKINFO,USER
 ;
 S (DOW,FREQ)=-1
 S RTN="9^UNKNOWN^NO DATE^-1^UNKNOWN^^^UNKNOWN^NOT ACTIVE"
 ;
 I '$D(^DIC(19,"B",OPT)) S $P(RTN,U,1,2)="3^MISSING" Q RTN
 S DA=$O(^DIC(19,"B",OPT,0)),DA=+$O(^DIC(19.2,"B",DA,0))
 S TSKINFO=$G(^DIC(19.2,DA,0)),(DOW,Y)=$P(TSKINFO,U,2),FREQ=$P(TSKINFO,U,6)
 S $P(TSKINFO,U,2)=$$FMTE^XLFDT($P(TSKINFO,U,2))
 I DOW'="" S DAY=$$DOW^XLFDT(DOW),DOW=$$DOW^XLFDT(DOW,1)
 K:$G(DAY)="day" DAY
 S TSK=+$G(^DIC(19.2,+DA,1))
 I (DOW="")!(TSK="") S $P(RTN,U,1,2)="1^NOT SCHEDULED"
 E  D
 .S $P(RTN,U,1,2)="0^SCHEDULED"
 .I FREQ="" S $P(RTN,U,1,2)="2^NOT RESCHEDULED"
 .; queued to run at
 .S $P(RTN,U,3,4)=$S($P(TSKINFO,U,2)="":"NO DATE",1:$P(TSKINFO,U,2))_$S($D(DAY):" ("_DAY_")",1:"")_U_DOW
 ; rescheduling frequency
 I FREQ?1.3N1A D
 .S $P(RTN,U,5,6)=+FREQ_" "_$S(FREQ["D":"day",FREQ["M":"month",1:FREQ)_$S(+FREQ>1:"s",1:"")_U_FREQ
 E  S $P(RTN,U,5,6)=$S(FREQ="":"UNKNOWN",1:FREQ)_U_FREQ
 ; task id
 S $P(RTN,U,7)=TSK
 ; find if the user is active
 I TSK D
 .S TSKINFO=$G(^%ZTSK(TSK,0))
 .S USER=+$P(TSKINFO,U,3)
 .S ACTV=+$$ACTIVE^XUSER(USER)
 .; queued by
 .S $P(RTN,U,8)=$P($G(^VA(200,USER,0)),U)
 I $G(ACTV) S $P(RTN,U,9)="ACTIVE"
 Q RTN
 ;
VERPTCH(PKG,RTNARRY)    ;-- returns current version and patch status of specified CM package
 ;---------------------------------------------------------------------
 ; input PKG = 'D' for CM TOOLS
 ;             'R' for RUM - DECOMMISSIONED
 ;             'S' for SAGG
 ; Return array (passed by reference) in format:
 ; output RTNARRY = -1 for error
 ;        RTNARRY(0) = number of routines^total rtns ok^total rtns bad^total rtns missing
 ;        RTNARRY(rtn name) = {0=good 1=bad 2=missing routine}^released version^released patch(es)^site version^site patch(es)
 ;
 ; This code will reference line tag PTCHINFO^KMP_pkg_UTL for the
 ; following patch information text starting at PTCHINFO+1:
 ;
 ;        ;;routine name ^ current version ^ current patch(es)
 ;
 ; Example:    
 ;           PATCHINFO  ;-- patch information
 ;                      ;;KMPSGE^1.8^**1,2**
 ;                      ;;KMPSUTL^1.8^**1,2**
 ;  last line >         ;;
 ;---------------------------------------------------------------------
 ;
 K RTNARRY
 ;
 N BAD,I,INFO,INFOSITE,OK,OUT,PTCH,PTCHSITE,RTN
 N TAG,TOTBAD,TOTMISS,TOTOK,TOTRTN,X,VER,VERSITE
 ;
 I $G(PKG)=""!("DS"'[$G(PKG))!($L(PKG)'=1) S RTNARRY=-1 Q
 S X="KMP"_PKG_"UTL"
 X ^%ZOSF("TEST") I '$T S RTNARRY=-1 Q
 ;
 S (OUT,TOTBAD,TOTMISS,TOTOK,TOTRTN)=0
 F I=1:1 D  Q:OUT
 .S TAG="PTCHINFO+"_I_"^KMP"_PKG_"UTL"
 .S INFO=$P($T(@TAG),";;",2)
 .I INFO="" S OUT=1 Q
 .S RTN=$P(INFO,U),VER=$P(INFO,U,2),PTCH=$P(INFO,U,3)
 .; if routine is missing
 .I $T(@(RTN_"^"_RTN))="" D  Q
 ..S TOTMISS=TOTMISS+1,TOTRTN=TOTRTN+1
 ..S RTNARRY(RTN)="2^"_VER_U_PTCH_"^^"
 .X "ZL @RTN S INFOSITE=$T(+2)"
 .S VERSITE=$P(INFOSITE,";",3),PTCHSITE=$P(INFOSITE,";",5)
 .I VERSITE'=VER!(PTCHSITE'=PTCH) S BAD=1,OK=0
 .E  S BAD=0,OK=1
 .S TOTBAD=TOTBAD+BAD,TOTOK=TOTOK+OK,TOTRTN=TOTRTN+1
 .S RTNARRY(RTN)=BAD_U_VER_U_PTCH_U_VERSITE_U_PTCHSITE
 S RTNARRY(0)=TOTRTN_U_TOTOK_U_TOTBAD_U_TOTMISS
 Q
