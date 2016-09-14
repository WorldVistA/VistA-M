SDECUTL2 ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**627,642**;Aug 13, 1993;Build 23
 ;
 Q
 ;
RESAB(SDAB,SDCL,SDBEG,SDEND,SDECRES)   ;build access blocks for 1 clinic
 ; SDECRES (optional) Resource pointer to SDEC RESOURCE file
 ;                    used to build access blocks from clinic availability
 ;                    for only this resource; all resources are build if null
 ;  .01    name
 ;    2    type (clinic)
 ;   1912  length of app't
 ;   1914  hour clinic display begins default is 8am; whole number 0-16
 ;   1917  display increments per hour
 ;   2505  inactive date
 ;   2506  reactivate date
 N SDAY,SDCLS,SDDATA,SDFIELDS,SDIN,SDLEN,SDRA,SDSI,SDT
 I $P($G(SDBEG),".",1)'?7N S SDBEG=$$FMADD^XLFDT($P($$NOW^XLFDT,".",1),-1)
 I $P($G(SDEND),".",1)'?7N S SDEND=$$FMADD^XLFDT($P($$NOW^XLFDT,".",1),365)
 S SDECRES=$G(SDECRES) I SDECRES'="",'$D(^SDEC(409.831,+SDECRES,0)) S SDECRES=""
 S SDFIELDS=".01;2;1912;1914;1917;2505;2506"
 D GETS^DIQ(44,SDCL_",",SDFIELDS,"IE","SDDATA","SDMSG")
 Q:SDDATA(44,SDCL_",",2,"I")'="C"   ;only clinic
 I $$INACTIVE(SDCL,.SDBEG,.SDEND,SDDATA(44,SDCL_",",2505,"I"),SDDATA(44,SDCL_",",2506,"I")) Q   ;only active
 S SDLEN=SDDATA(44,SDCL_",",1912,"I")  ;length of app't is required in file 44
 S SDCLS=SDDATA(44,SDCL_",",1914,"I")   ;hour clinic display begins
 S:SDCLS="" SDCLS=8
 S SDSI=SDDATA(44,SDCL_",",1917,"I")
 ;add to SDEC ACCESS BLOCK from AVAILABILITY in file 44
 I 0 S SDAY=$$FMADD^XLFDT(SDBEG,-1) F  S SDAY=$O(^SC(SDCL,"T",SDAY)) Q:SDAY'>0  Q:SDAY>SDEND  D
 .D RESABDAY(SDAB,SDCL,SDAY,SDLEN,SDCLS,+SDECRES)
 ;add to SDEC ACCESS BLOCK from day templates in file 44
 ;F SDT="T0","T1","T2","T3","T4","T5","T6" D
 D TDAY(SDAB,SDCL,SDCLS,SDLEN,SDSI,SDBEG,SDEND)
 Q
 ;
TDAY(SDAB,SDCL,SDCLS,SDLEN,SDSI,SDBEG,SDEND)   ;add/update access blocks for day template SDT
 ;SDBEG  = (optional) Start date in fileman format; defaults to 'today'
 ;SDEND = (optional) Stop date in fileman format; defaults to 365 days
 N SDAY,SDAY1,SDBLKS,SDE,SDE1,SDJ,SDPAT,SDPAT1,SDSIM
 S SDCL=$G(SDCL)
 Q:SDCL=""
 ;S SDT=$G(SDT)
 ;Q:SDT'?1"T"1N
 S SDLEN=$G(SDLEN)
 I SDLEN="" S SDLEN=$$GET1^DIQ(44,SDCL_",",1912)
 S SDCLS=$G(SDCLS)
 I SDCLS="" S SDCLS=$$GET1^DIQ(44,SDCL_",",1914)   ;SDCLS=8
 S SDSI=$G(SDSI)
 I SDSI="" S SDSI=$$GET1^DIQ(44,SDCL_",",1917,"I")   ;SDDATA(44,SDCL_",",1917,"I")
 S SDBEG=$G(SDBEG)
 ;S STDAT=$O(^SC(SDCL,"T",0)) S:STDAT<1 STDAT=DT
 ;S SDBEG=$S(SDBEG'?7N:STDAT,SDBEG<STDAT:STDAT,1:SDBEG)
 ;S SDAY1=$$FMADD^XLFDT(SDBEG,-1)
 ;S SDEND=$G(SDEND) I SDEND="" S SDEND=SDBEG_".2359"
 ;
 ;SDBEG - SDEND
 ;F  S SDAY1=$$FMADD^XLFDT(SDAY1,1) Q:$P(SDAY1,".",1)>$P(SDEND,".",1)  D TDAY1
 D TDAY1
 Q
TDAY1 ;
 N D,SDA,SDTP,SS,ST,Y
 S SDA=$S(SDSI=3:6,SDSI=6:12,1:8)
 S SDTP=""
 I '$D(^SC(SDCL,"ST",$P(SDBEG,".",1),1)) S ST='$$ST(SDCL,SDBEG) Q:ST
 ;Q:'$D(^SC(SDCL,"ST",$P(SDBEG,".",1),1))
 I $D(^SC(SDCL,"ST",$P(SDBEG,".",1),9)) S SDTP=$G(^SC(SDCL,"OST",$P(SDBEG,".",1),1)) S SDTP=$E(SDTP,SDA,$L(SDTP))
 E  D
 .S D=$$DOW^XLFDT($P(SDBEG,".",1),1)
 .S Y=D#7
 .S SS=$$FDT(SDCL,Y)
 .Q:SS=""
 .S SDTP=SS
 Q:SDTP=""
 K SDBLKS
 D GETBLKS^SDECUTL1(.SDBLKS,SDTP,$P(SDBEG,".",1),SDCLS,SDLEN,SDSI,SDCL)
 D RESNB^SDECUTL1(SDAB,.SDBLKS,SDCL,$P(SDBEG,".",1))
 K SDBLKS
 Q
 ;
 S SDPAT1=$E($P($T(DAY),U,$E(SDT,2)+2),1,2)
 S SDAY=$S(SDAY1'="":$$FMADD^XLFDT(SDAY1,-1),1:$P($$NOW^XLFDT,".",1))   ;$$FMADD^XLFDT(SDE,-1)
 S SDE1=$$FMADD^XLFDT(SDAY,1)   ;$S(SDEND'="":SDEND,1:$$FMADD^XLFDT(SDAY,365))   ;$S(SDAY1'="":SDAY1,1:$$FMADD^XLFDT(SDAY,365))
 F  S SDAY=$$FMADD^XLFDT($P($$SCH^XLFDT($E("UMTWRFS",$E(SDT,2)+1),SDAY),".",1),1) Q:SDAY'>0  Q:SDAY>SDE1  D
 .I $$GET1^DIQ(44,SDCL_",",1918.5,"I")'="Y",$D(^HOLIDAY("B",SDAY)) Q   ;do not schedule on holidays
 .Q:$D(^SC(SDCL,"T",SDAY,2,1))  ;if AVAILABILITY defined, this day is already built
 .S SDSIM=$S(SDSI="":4,SDSI<3:4,SDSI:SDSI,1:4)
 .S SDPAT=SDPAT1_" "_$E(SDAY,6,7)_$J("",SDSIM+SDSIM-6)_SDTP
 .K SDBLKS
 .D GETBLKS^SDECUTL1(.SDBLKS,SDPAT,SDAY,SDCLS,SDLEN,SDSI,SDCL)
 .D RESNB^SDECUTL1(SDAB,.SDBLKS,SDCL,SDAY)
 .K SDBLKS
 Q
ST(SDCL,SDBEG) ;build ST
 ;RETURN - 0=not buildable or built as holiday ;1=buildable
 N D,SC,SDDT,SS,Y
 S SDDT=$P(SDBEG,".",1)
 S SC=SDCL
 S D=$$DOW^XLFDT(SDDT,1)
 S Y=D#7
 I $D(^HOLIDAY(SDDT))&($$GET1^DIQ(44,SDCL_",",1918.5,"I")'="Y") D H Q 0
 S SS=$$FDT(SDCL,Y)
 Q:+SS="" 0
 S ^SC(+SDCL,"ST",SDDT,1)=$E($P($T(DAY),U,Y+2),1,2)_" "_$E(SDDT,6,7)_$S(SDSI=3:"",SDSI=6:"      ",1:"  ")_SS,^SC(+SDCL,"ST",SDDT,0)=SDDT
 Q 1
FDT(SDCL,Y)  ;find day template pattern
 N SDE,SDTP
 S SDTP=""
 S SDE=$O(^SC(SDCL,"T"_Y,99999999),-1)
 Q:'SDE ""
 S SDTP=$G(^SC(SDCL,"T"_Y,SDE,1))
 Q:SDTP="" ""
 F  S SDE=$O(^SC(SDCL,"T"_Y,SDE),-1) Q:SDE'>0  Q:$P(SDBEG,".",1)'<SDE  S SDTP=$G(^SC(SDCL,"T"_Y,SDE,1))
 Q SDTP
H ;update ST as holiday
 S ^SC(+SC,"ST",X,1)="   "_$E(X,6,7)_"    "_$P(^HOLIDAY(X,0),U,2),^SC(+SC,"ST",X,0)=X
 Q
 ;
RESABDAY(SDAB,SDCL,SDAY,SDLEN,SDCLS,SDECRES)  ;add/update access blocks for AVAILABILITY on a specific day
 ;INPUT:
 ; SDAB  - (required) global name for access blocks - "^TMP("_$J_",""SDEC"",""BLKS"")"
 ; SDCL  - (required) clinic ID
 ; SDAY  - (required) date in fm format (no time)
 ; SDLEN - (optional) length of appointment
 ; SDCLS - (optional) hour schedule starts; default to 8
 ; SDECRES - (optional) pointer to SDEC RESOURCE file
 N SDBLKS
 S SDCL=$G(SDCL)
 Q:SDCL=""
 S SDECRES=$G(SDECRES)
 S SDAY=$G(SDAY)
 Q:SDAY'?7N
 S SDLEN=$G(SDLEN)
 I SDLEN="" S SDLEN=$$GET1^DIQ(44,SDCL_",",1912)
 S SDCLS=$G(SDCLS)
 I SDCLS="" S SDCLS=$$GET1^DIQ(44,SDCL_",",1914)   ;SDCLS=8
 D SDAY(.SDBLKS,SDCL,SDAY,SDLEN,SDCLS)
 I $D(SDBLKS) D RESNB^SDECUTL1(SDAB,.SDBLKS,SDCL,SDAY,SDECRES)
 ;D CA^SDEC12(SDCL,SDAY)
 Q
 ;
SDAY(SDBLKS,SDCL,SDAY,SDLEN,SDCLS)   ;build blocks for the day
 ;INPUT:
 ; SDCL  - clinic pointer to HOSPITAL LOCATION file
 ; SDAY  - date (no time) in FM format
 ; SDLEN - length of appointment in minutes
 ; SDCLS - hour clinic display begins default is 8am; whole number 0-16
 N SDATAV,SDATUN,SDB1,SDBI,SDDH,SDEND,SDEND1,SDNOD2,SDSI,SDTIME
 N SDAV,SDCLS4
 N PSLOT,PTIME
 S:$G(SDCLS)="" SDCLS=8
 S SDCLS4=$S($L(SDCLS)=1:"0",1:"")_SDCLS_"00"
 S SDATAV=$O(^SDEC(409.823,"B","AVAILABLE",0))
 S SDATUN=$O(^SDEC(409.823,"B","UNAVAILABLE",0))
 S SDDH=$$GET1^DIQ(44,SDCL_",",1917,"E")   ;display increments per hour
 S SDDH=$E(SDDH,1,2)
 S SDSI=$$GET1^DIQ(44,SDCL_",",1917,"I")   ;display increments per hour (internal)
 S (PTIME,PSLOT,SDB1)=""
 S SDBI=0
 K SDBLKS
 S SDTIME=$O(^SC(SDCL,"T",SDAY,2,0))
 Q:SDTIME=""
 D SDAV(.SDAV,SDCL,SDAY,SDLEN,SDCLS,SDSI)
 S SDNOD2=$G(SDAV(2,SDTIME,0)) I $$COMPARE(SDCLS4,$P(SDNOD2,U,1))=2 D
 .S SDBI=SDBI+1 S SDBLKS(SDBI)=$$FM(SDAY_"."_SDCLS4)_U_$$FM(SDAY_"."_$P(SDNOD2,U,1))_U_U_SDATUN
 S SDTIME=0 F  S SDTIME=$O(SDAV(2,SDTIME)) Q:SDTIME'>0  D
 .S SDNOD2=$G(SDAV(2,SDTIME,0))
 .S:SDB1="" SDB1=$P(SDNOD2,U,1)
 .I PTIME'="" D
 ..I (PSLOT'=$P(SDNOD2,U,2))!(($$ADD(PTIME,SDLEN)'=$P(SDNOD2,U,1))) D   ;new block
 ...S SDEND=$$ADD(PTIME,SDLEN) S SDEND=$S(SDEND<$P(SDNOD2,U,1):SDEND,1:$P(SDNOD2,U,1))  ;use the lesser of the 2
 ...S SDEND1=$S($E(SDEND,1,2)>23:"2359",1:SDEND)
 ...;S SDEND1=$S($E(SDEND,1,2)>23:"0000",1:SDEND)
 ...S SDBI=SDBI+1 S SDBLKS(SDBI)=$$FM(SDAY_"."_SDB1)_U_$$FM(SDAY_"."_SDEND1)_U_PSLOT_U_SDATAV
 ...I SDEND'=$P(SDNOD2,U,1) D
 ....S SDBI=SDBI+1 S SDBLKS(SDBI)=$$FM(SDAY_"."_SDEND)_U_$$FM(SDAY_"."_$P(SDNOD2,U,1))_U_0_U_SDATUN
 ...S SDB1=$P(SDNOD2,U,1)
 .S PTIME=$P(SDNOD2,U,1)
 .S PSLOT=$P(SDNOD2,U,2)
 I SDB1'="" D   ;setup last block
 .S SDEND=$$ADD(PTIME,$S(SDLEN>SDDH:SDLEN,1:SDDH))
 .S SDEND1=$S($E(SDEND,1,2)>23:"2359",1:SDEND)
 .;S SDEND1=$S($E(SDEND,1,2)>23:"0000",1:SDEND)
 .I $E(SDEND,1,2)>23 S SDEND="2359"
 .;I $E(SDEND,1,2)>23 S SDEND="0000"
 .S SDBI=SDBI+1 S SDBLKS(SDBI)=$$FM(SDAY_"."_SDB1)_U_$$FM(SDAY_"."_SDEND)_U_PSLOT_U_SDATAV
 I PTIME<1800 D
 .S SDBI=SDBI+1 S SDBLKS(SDBI)=$$FM(SDAY_"."_SDEND)_U_$$FM(SDAY_".1800")_U_0_U_SDATUN
 K SDAV
 Q
 ;
COMPARE(T1,T2)   ;compare time
 ;RETURN:
 ;  0 = same
 ;  1 = T1 is greater than
 ;  2 = T1 is less than
 N T1M,T2M
 S T1M=+T1,T2M=+T2
 Q:T1M=T2M 0
 Q:T1M>T2M 1
 Q:T1M<T2M 2
 Q -1   ;sanity check should not happen
 ;
ADD(HM,M)  ;add minutes M to HourMinute HM and return with 4 digit military time
 N H1,M1
 S H1=$E(HM,1,2)
 S M1=$E(HM,3,4)
 S M1=M1+M
AGAIN  I M1>59 S M1=M1-60,H1=H1+1 G:M1>59 AGAIN
 I $L(H1)=1 S H1="0"_H1
 I $L(M1)=1 S M1="0"_M1
 Q H1_M1
 ;
FM(SDDATE)  ;use to strip zeros off of the end of the time
 N %DT,X,Y
 S %DT="DT",X=SDDATE D ^%DT
 Q Y
 ;
DAY ;;^SUN^MON^TUES^WEDNES^THURS^FRI^SATUR
 ;
SDB(SDEC)  ;add/update access blocks after clinic modifications using SDBUILD in routine SDB
 ; SDEC = array of modified days or day templates
 ;         SDEC(<clinic ID>,<day/template>)=""
 ;              day      = date in FM format
 ;              template = T#
 N %,SDCL,SDCLN,SDT
 S SDCL="" F  S SDCL=$O(SDEC(SDCL)) Q:SDCL=""  D
 .D SDRES(SDCL)
 .S SDT="" F  S SDT=$O(SDEC(SDCL,SDT)) Q:SDT=""  D
 ..I $E(SDT,1)="T" D TDAY(SDCL,SDT)
 ..I SDT?7N D RESABDAY(SDCL,SDT)
 K SDEC
 Q
 ;
SDRES(SDCL)  ;add clinic resource
 N SDDATA,SDDI,SDFDA,SDFOUND,SDI,SDNOD,SDRT
 S SDFOUND=0
 S SDI="" F  S SDI=$O(^SDEC(409.831,"ALOC",SDCL,SDI)) Q:SDI=""  D  Q:SDFOUND=1
 .S SDNOD=$G(^SDEC(409.831,SDI,0))
 .S SDRT=$P(SDNOD,U,11)
 .I $P(SDRT,";",2)="SC(",$P(SDRT,";",1)=SDCL S SDFOUND=1
 Q:SDFOUND=1
 S SDFIELDS=".01;1917"
 D GETS^DIQ(44,SDCL_",",SDFIELDS,"IE","SDDATA")
 S SDFDA(409.831,"+1,",.01)=SDDATA(44,SDCL_",",.01,"E")
 S SDDI=SDDATA(44,SDCL_",",1917,"E") S SDFDA(409.831,"+1,",.03)=$E(SDDI,1,2)
 S SDFDA(409.831,"+1,",.04)=SDCL
 S SDFDA(409.831,"+1,",.012)=SDCL_";SC("
 S SDFDA(409.831,"+1,",.015)=$E($$NOW^XLFDT,1,12)
 S SDFDA(409.831,"+1,",.016)=DUZ
 D UPDATE^DIE("","SDFDA")
 Q
 ;
INACTIVE(SDCL,SDBEG,SDEND,IDATE,RDATE)  ;
 ;INPUT:
 ;  SDCL  - clinic ID
 ; .SDBEG - begin date in FM format, no time
 ; .SDEND - end date in FM format, no time
 ;  IDATE - clinic's inactivation date
 ;  RDATE - clinic's reactivation date
 ;RETURN:
 ; 0=Clinic is active
 ; 1=Clinic is inactive
 ; active  0 0
 I IDATE="" Q 0
 ;  active but inactivated in future
 I IDATE>SDBEG S SDEND=IDATE Q 0
 ; inactive 1 0
 I IDATE<=SDBEG,RDATE="" Q 1
 ; inactive 1 1 inactive but reactivated
 ;  inactive now reactive now
 I IDATE<=SDBEG,RDATE<=SDBEG Q 0
 ;  inactive now reactive future
 I IDATE<=SDBEG,RDATE>IDATE S SDBEG=RDATE Q 0
 Q 1
 ;
DEL ;
 N H
 S H=0 F  S H=$O(^SDEC(409.821,H)) Q:H'>0  W !,H,"   ",$G(^SDEC(409.821,H,0)) S SDFDA(409.821,H_",",.01)="@" D UPDATE^DIE("","SDFDA")
 K ^SDEC(409.821,"ARSCT")
 Q
DEL1 ;
 N H
 S H=0 F  S H=$O(^SDEC(409.821,H)) Q:H'>0  S SDFDA(409.821,H_",",.01)="@" D UPDATE^DIE("","SDFDA")
 K ^SDEC(409.821,"ARSCT")
 Q
 ;
ARRAY(DTARRAY,SDPAT,SDAY,SDLEN,SDCLS,SDSI,SDF)  ;build date/time array from pattern
 ; .DTARRAY   - Array of cancelled date/times
 ;             CARRAY(FMDATE,TIME)=<slots>
 ;  SDPAT - (required) pattern
 ;  SDAY  - (required) date in FM format (no time)
 ;  SDLEN - (required) length of appointment
 ;  SDCLS - (required) hour schedule starts; default to 8
 ;  SDSI  - (required) display increments per hour
 N SDA,SDI,SDSIM
 ;SDSIM - calculated using DISPLAY INCREMENTS PER HOUR field from file 44
 ;          $S(X="":4,X<3:4,X:X,1:4)
 S SDF=$G(SDF,0)  ;cancelled flag
 S SDA=$S(SDSI=3:6,SDSI=6:12,1:8)
 S SDSIM=$S(SDSI="":4,SDSI<3:4,SDSI:SDSI,1:4)
 S:$E(SDPAT)?1A SDPAT=$E(SDPAT,SDA,$L(SDPAT))
 ;1 2 3 4 OR 6
 D @SDSI
 Q
1  ;1 increments per hour (60 min)
 N BSTART,CNT,HOUR,SDI
 S BSTART=""
 S SDI=0
 S HOUR=SDCLS-1
 F CNT=2:8 Q:CNT>$L(SDPAT)  D
 .I (CNT#8)=2 S HOUR=HOUR+1
 .S BSTART=SDAY_"."_$S($L(HOUR)=1:"0"_HOUR,1:HOUR)
 .S DTARRAY($P(BSTART,".",1),$P(BSTART,".",2))=$S(+SDF:"X",1:$E(SDPAT,CNT))
 Q
2  ;2 increments per hour (30 min)
 N BSTART,CNT,HOUR
 S BSTART=""
 S SDI=0
 S HOUR=SDCLS-1
 F CNT=2:4 Q:CNT>$L(SDPAT)  D
 .I (CNT#8)=2 S HOUR=HOUR+1
 .S BSTART=SDAY_"."_$S($L(HOUR)=1:"0"_HOUR,1:HOUR)_$S((CNT#8)=6:30,1:"00")
 .S DTARRAY($P(BSTART,".",1),$P(BSTART,".",2))=$S(+SDF:"X",1:$E(SDPAT,CNT))
 Q
3  ;3 increments per hour (20 min)
 N BSTART,CNT,HOUR
 S BSTART=""
 S SDI=0
 S HOUR=SDCLS-1
 F CNT=2:2 Q:CNT>$L(SDPAT)  D
 .I (CNT#6)=2 S HOUR=HOUR+1
 .S BSTART=SDAY_"."_$S($L(HOUR)=1:"0"_HOUR,1:HOUR)_$S((CNT#6)=4:20,(CNT#6)=0:40,1:"00")
 .S DTARRAY($P(BSTART,".",1),$P(BSTART,".",2))=$S(+SDF:"X",1:$E(SDPAT,CNT))
 Q
4  ;4 increments per hour (15 min)
 N BSTART,CNT,HOUR
 S BSTART=""
 S SDI=0
 S HOUR=SDCLS-1
 F CNT=2:2 Q:CNT>$L(SDPAT)  D
 .I (CNT#8)=2 S HOUR=HOUR+1
 .S BSTART=SDAY_"."_$S($L(HOUR)=1:"0"_HOUR,1:HOUR)_$S((CNT#8)=4:15,(CNT#8)=6:30,(CNT#8)=0:45,1:"00")
 .S DTARRAY($P(BSTART,".",1),$P(BSTART,".",2))=$S(+SDF:"X",1:$E(SDPAT,CNT))
 Q
6  ;6 increments per hour (10 min)
 N BSTART,CNT,HOUR
 S BSTART=""
 S SDI=0
 S HOUR=SDCLS-1
 F CNT=2:2 Q:CNT>$L(SDPAT)  D
 .I (CNT#12)=2 S HOUR=HOUR+1
 .S BSTART=SDAY_"."_$S($L(HOUR)=1:"0"_HOUR,1:HOUR)_$S((CNT#12)=4:10,(CNT#12)=6:20,(CNT#12)=8:30,(CNT#12)=10:40,(CNT#12)=0:50,1:"00")
 .S DTARRAY($P(BSTART,".",1),$P(BSTART,".",2))=$S(+SDF:"X",1:$E(SDPAT,CNT))
 Q
SDAV(SDAV,SDCL,SDAY,SDLEN,SDCLS,SDSI)  ;build modified availability array from AVAILABILITY in 44
 N DTARRAY
 N SDCAN,SDI,SDPAT,SDTIME
 K SDAV
 M SDAV=^SC(SDCL,"T",SDAY)
 S SDPAT=$G(^SC(SDCL,"ST",SDAY,1))   ;get PATTERN from file 44
 Q:SDPAT=""
 D ARRAY(.DTARRAY,SDPAT,SDAY,SDLEN,SDCLS,SDSI)  ;convert pattern to array
 S SDTIME=0 F  S SDTIME=$O(SDAV(2,SDTIME)) Q:SDTIME'>0  D
 .S SDNOD2=$G(SDAV(2,SDTIME,0))
 .I $G(DTARRAY(SDAY,$P(SDNOD2,U,1)))="X" D
 ..K SDAV(2,SDTIME,0)
 Q
