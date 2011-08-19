KMPSUTL1        ;OAK/KAK - SAGG Utilities ;5/1/07  10:30
 ;;2.0;SAGG;;Jul 02, 2007
 ;
MPLTF() ;-- returns the type of M platform
 ;---------------------------------------------------------------------
 ; Returns:  CVMS   for Cache for OpenVMS platform
 ;           CWINNT for Cache for Windows NT platform
 ;---------------------------------------------------------------------
 ;
 N MPLTF,ZV
 ;
 S ZV=$ZV
 S MPLTF=$S(ZV["VMS":"CVMS",ZV["Windows":"CWINNT",1:"UNK")
 Q MPLTF
 ;
TSKSTAT(OPT)       ;-- status of scheduled task option
 ;---------------------------------------------------------------------
 ; input  OPT = option name
 ; output RTN = status code^literal condition
 ;              ...^scheduled date@time (day)^numeric day-of-week
 ;              ...^expanded scheduled frequency^short form frequency
 ;              ...^task id^queued by^user status
 ;
 ; where status code^condition:
 ;            = 0^SCHEDULED
 ;            = 1^NOT SCHEDULED and 'scheduled date@time' will
 ;                   be UNKNOWN and 'numeric day of week' will be -1
 ;            = 2^NOT RESCHEDULED
 ;            = 3^MISSING when OPT does not exist
 ;            = 9^UNKNOWN
 ;
 ; where user status = ACTIVE or NOT ACTIVE
 ;---------------------------------------------------------------------
 ;
 N ACTV,DA,DAY,DOW,FREQ,RTN,TSK,TSKINFO,USER,Y
 ;
 S (DOW,FREQ)=-1
 S RTN="9^UNKNOWN^NO DATE^-1^UNKNOWN^^^UNKNOWN^NOT ACTIVE"
 ;
 I '$D(^DIC(19,"B",OPT)) S $P(RTN,U,1,2)="3^MISSING" Q RTN
 S DA=$O(^DIC(19,"B",OPT,0)),DA=+$O(^DIC(19.2,"B",DA,0))
 S TSKINFO=$G(^DIC(19.2,DA,0)),(DOW,Y)=$P(TSKINFO,U,2),FREQ=$P(TSKINFO,U,6)
 S:+Y $P(TSKINFO,U,2)=$$FMTE^XLFDT(Y)
 I DOW'="" S DAY=$$DOW^XLFDT(DOW),DOW=$$DOW^XLFDT(DOW,1)
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
