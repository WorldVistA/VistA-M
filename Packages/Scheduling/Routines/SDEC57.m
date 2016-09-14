SDEC57 ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**627,642**;Aug 13, 1993;Build 23
 ;
 Q
 ;APPSLOTS - return appt slots and availability
 ;SDECY=Return global array
 ;  FM DATE ^ SLOT START TIME ^ SLOT STOP TIME ^ AVAILABILITY CODE
 ;  Availability codes 0-9,j-z for 0 to 26 available appts, A-W for overbooks 1-23
 ;SDECRES=Resource name
 ;SDECSTRT=Start date/time
 ;SDECEND=End date/time
APPSLOTS(SDECY,SDECRES,SDECSTART,SDECEND) ;GET Create Assigned Slot Schedule
 N CNT
 N SDECAD,SDECALO,SDECBS,SDECDEP,SDECERR,SDECI,SDECIEN,SDECK,SDECL,SDECNEND,SDECNOD
 N SDECNOT,SDECNSTART,SDECPEND,SDECQ,SDECRESD,SDECRESN,SDECS,SDECSUBCD,SDECTMP
 N SDAB,SDECTYPE,SDECTYPED,SDECZ
 N %DT,X,Y
 S SDECERR=""
 S SDECY="^TMP(""SDEC57"","_$J_",""APPSLOTS"")"
 K @SDECY
 S SDECALO=0,SDECI=0
 S @SDECY@(SDECI)="T00030DATE^T00030START_TIME^T00030END_TIME^I00010AVAILABILITY"_$C(30)
 S %DT="T",X=$P($P(SDECSTART,"@",1),".",1) D ^%DT
 S SDECSTART=Y
 S %DT="T",X=$P($P(SDECEND,"@",1),".",1) D ^%DT
 S SDECEND=Y
 ;validate SDECRES
 S SDECRES=$G(SDECRES)
 I SDECRES']"" S @SDECY@(1)="-1^Resource ID is required"_$C(30)_$C(31) Q
 I +SDECRES,'$D(^SDEC(409.831,+SDECRES,0)) S @SDECY@(1)="-1^Resource ID is required"_$C(30)_$C(31) Q
 I '+SDECRES S SDECRES=$O(^SDEC(409.831,"B",SDECRES,0)) I '+SDECRES S @SDECY@(1)="-1^Invalid Resource ID"_$C(30)_$C(31) Q
 S SDAB="^TMP("_$J_",""SDEC57"",""BLKS"")"
 K @SDAB
 D GETSLOTS(SDAB,SDECRES,SDECSTART,SDECEND)
 ;Get Access Type IDs
 N SD1,SD2,SD3,SD4,SDI,SDNOD,SDENDDT
 N SDSTRTDT,SDSLOTS,SDSTOPTM,SDSTRTTM
 S SDI=0 F  S SDI=$O(@SDAB@(SDI)) Q:SDI'>0  D
 .S SDNOD=@SDAB@(SDI)
 .S SD1=$P(SDNOD,U,2) ;start DT
 .S SD2=$P(SDNOD,U,3) ;end DT
 .S SD3=+$P(SDNOD,U,4) ;slots
 .S SD4=$P(SDNOD,U,5) ;access type(1=avail,2=not avail,3=canc)
 .S SDSTRTDT=$P(SD1,".")
 .S SDENDDT=$P(SD2,".")
 .S SDSTRTTM=$E($P(SD1_"0000",".",2),1,4)
 .S SDSTOPTM=$E($P(SD2_"0000",".",2),1,4)
 .S SDSLOTS=$P(SDNOD,U,4)
 .S SDSLOTS=$S(SDSLOTS=" ":"",1:SDSLOTS)
 .S SDSLOTS=$S(SD4=2:"",SD4=3:"X",1:SDSLOTS)
 .S SDECI=SDECI+1,@SDECY@(SDECI)=SDSTRTDT_U_SDSTRTTM_U_SDSTOPTM_U_SDSLOTS_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 K @SDAB
 Q
 ;
GETSLOTS(SDAB,SDECRES,SDECSTART,SDECEND)  ;load SDEC ACCESS BLOCKS from file 44
 N SDCL,SDI,SDJ
 S SDECRES=$G(SDECRES) Q:SDECRES=""
 I +SDECRES,'$D(^SDEC(409.831,+SDECRES,0)) Q
 I '+SDECRES S SDECRES=$O(^SDEC(409.831,"B",SDECRES,0))
 Q:'SDECRES
 S %DT="T",X=$P($P(SDECSTART,"@",1),".",1) D ^%DT
 Q:Y=-1
 S SDECSTART=Y
 S %DT="T",X=$P($P(SDECEND,"@",1),".",1) D ^%DT
 Q:Y=-1
 S SDECEND=Y
 S SDCL=$$GET1^DIQ(409.831,SDECRES_",",.04,"I")
 Q:SDCL=""
 S SDI=$$FMADD^XLFDT(SDECSTART,-1)
 F  S SDI=$$FMADD^XLFDT(SDI,1) Q:SDI>$P(SDECEND,".",1)  D
 .I ($O(^SC(SDCL,"T",0))="")!($O(^SC(SDCL,"T",0))>SDI) Q
 .I $$GET1^DIQ(44,SDCL_",",1918.5,"I")'="Y",$D(^HOLIDAY("B",SDI)) Q   ;do not schedule on holidays
 .;Q:$G(^SC(SDCL,"ST",SDI,1))["**CANCELLED**"
 .Q:$$INACTIVE^SDEC32(SDCL,$P(SDI,".",1))   ;don't get availability if clinic inactive on day SDI
 .D RESAB(SDAB,SDCL,SDI,SDI_"."_2359,SDECRES)
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
 S:SDCLS="" SDCLS=8 ;apply default start time of 0800
 ;SDSI=DISPLAY INCREMENTS PER HOUR (1-60min,2-30min,3-20min,4-15min,6-10min)
 S SDSI=SDDATA(44,SDCL_",",1917,"I")
 D TDAY(SDAB,SDCL,SDCLS,SDLEN,SDSI,SDBEG,SDEND)
 Q
 ;
TDAY(SDAB,SDCL,SDCLS,SDLEN,SDSI,SDBEG,SDEND) ;add/update access blocks for day template SDT
 ;SDBEG  = (optional) Start date in fileman format; defaults to 'today'
 ;SDEND = (optional) Stop date in fileman format; defaults to 365 days
 N SDAY,SDAY1,SDBLKS,SDE,SDE1,SDJ,SDPAT,SDPAT1,SDSIM
 S SDCL=$G(SDCL)
 Q:SDCL=""
 S SDLEN=$G(SDLEN)
 ;LENGTH OF APP'T
 I SDLEN="" S SDLEN=$$GET1^DIQ(44,SDCL_",",1912)
 S SDCLS=$G(SDCLS)
 ;HOUR CLINIC DISPLAY BEGINS
 I SDCLS="" S SDCLS=$$GET1^DIQ(44,SDCL_",",1914)   ;SDCLS=8
 S SDSI=$G(SDSI)
 ;DISPLAY INCREMENTS PER HOUR
 I SDSI="" S SDSI=$$GET1^DIQ(44,SDCL_",",1917,"I")   ;SDDATA(44,SDCL_",",1917,"I")
 S SDBEG=$G(SDBEG)
 D TDAY1
 Q
TDAY1 ;
 N D,SDA,SDTP,SS,ST,Y
 ;SDA=begin position of pattern on template
 S SDA=$S(SDSI=3:6,SDSI=6:12,1:8)
 S SDTP=""
 ;if no CURRENT AVAILABILITY pattern, try to build it
 I '$D(^SC(SDCL,"ST",$P(SDBEG,".",1),1)) S ST='$$ST(SDCL,SDBEG) Q:ST
 S SDTP=$G(^SC(SDCL,"ST",$P(SDBEG,".",1),1)) S SDTP=$E(SDTP,SDA,$L(SDTP))
 Q:SDTP=""
 K SDBLKS
 D GETBLKS^SDEC57A(.SDBLKS,SDTP,$P(SDBEG,".",1),SDCLS,SDLEN,SDSI,SDCL)
 D RESNB^SDECUTL1(SDAB,.SDBLKS,SDCL,$P(SDBEG,".",1))
 K SDBLKS
 Q
 ;
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
DAY ;;^SUN^MON^TUES^WEDNES^THURS^FRI^SATUR
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
