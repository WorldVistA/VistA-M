SDECDEV ;ALB/SAT - VISTA SCHEDULING RPCS ;JUN 21, 2017
 ;;5.3;Scheduling;**627,658,665**;Aug 13, 1993;Build 14
 ;
 Q
 ;
DEVICE(SDECY) ;EP List of printers
 ; OUTPUT:
 ;       SDECY(n)=REPORT TEXT
 ;
 N SDECI,FROM,DIR,ARR
 S SDECI=0
 S SDECY=$NA(^TMP("SDECDEV",$J,"DEVICE")) K @SDECY
 S @SDECY@(SDECI)="I00030PRINTER_IEN^T00040PRINTER_NAME"_$C(30)
 N CNT,IEN,X,Y,X0,XLOC,XSEC,XTYPE,XSTYPE,XTIME,XOSD,MW,PL,DEV
 S FROM="",DIR=1
 F  S FROM=$O(^%ZIS(1,"B",FROM),DIR),IEN=0 Q:FROM=""  D
 .F  S IEN=$O(^%ZIS(1,"B",FROM,IEN)) Q:'IEN  D
 ..Q:$D(ARR(IEN))
 ..S ARR(IEN)=""
 ..S DEV="",X0=$G(^%ZIS(1,IEN,0)),XLOC=$P($G(^(1)),U),XOSD=+$G(^(90)),MW=$G(^(91)),XSEC=$G(^(95)),XSTYPE=+$G(^("SUBTYPE")),XTIME=$P($G(^("TIME")),U),XTYPE=$P($G(^("TYPE")),U)
 ..Q:$E($G(^%ZIS(2,XSTYPE,0)))'="P"                ; Printers only
 ..Q:"^TRM^HG^CHAN^OTH^"'[(U_XTYPE_U)
 ..Q:$P(X0,U,2)="0"!($P(X0,U,12)=2)                ; Queuing allowed
 ..I XOSD,XOSD'>DT Q                               ; Out of Service
 ..I $L(XTIME) D  Q:'$L(XTIME)                     ; Prohibited Times
 ...S Y=$P($H,",",2),Y=Y\60#60+(Y\3600*100),X=$P(XTIME,"-",2)
 ...S:X'<XTIME&(Y'>X&(Y'<XTIME))!(X<XTIME&(Y'<XTIME!(Y'>X))) XTIME=""
 ..I $L(XSEC),$G(DUZ(0))'="@",$TR(XSEC,$G(DUZ(0)))=XSEC Q
 ..S PL=$P(MW,U,3),MW=$P(MW,U),X=$G(^%ZIS(2,XSTYPE,1))
 ..S:'MW MW=$P(X,U)
 ..S:'PL PL=$P(X,U,3)
 ..S X=$P(X0,U)
 ..Q:$E(X,1,4)["NULL"
 ..S:X'=FROM X=FROM_"  <"_X_">"
 ..S SDECI=SDECI+1,@SDECY@(SDECI)=IEN_U_$P(X0,U)_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
DEV(RET,TYPE,MAX,LSUB,PARTIAL) ;GET devices of the given type   ;alb/sat 658
 ;INPUT:
 ; TYPE - (optional) Device type
 ;                   A:All Printers (default)
 ;                   P:Printers only on current namespace
 ;                   C:Complete Device Listing             (not supported)
 ;                   D:Devices only on current namespace   (not supported)
 ;                   N:New Format for Device Specification (not supported)
 ;                   E:Extended Help                       (not supported)
 ; MAX  - (optional) Max records to return
 ; LSUB - (optional) Last subscripts used to continue from last call
 ;                   Use LASTSUB (return piece 3) from previous call
 ; PARTIAL - (optional) - partial device name lookup
 ;RETURN:
 ; DIEN  = Device IEN pointer to DEVICE file (#3.5) OR -1 if error
 ; DNAME = Device Name OR message if error
 ; LOCT  = Location of Terminal text
 ; LASTSUB = Last subscripts to continue with next call
 ;           Pass in as LSUB input
 N SDCNT,SDSUB,SDTMP
 S SDSUB=""
 S SDCNT=0
 S RET=$NA(^TMP("SDECDEV",$J,"DEV"))
 K @RET
 S SDTMP="T00030DIEN^T00030DNAME^T00050LOCT^T00100LASTSUB"
 S @RET@(0)=SDTMP_$C(30)
 ;validate TYPE
 S TYPE=$G(TYPE)
 I TYPE="" S TYPE="A"
 I "AP"'[TYPE S @RET@(1)="-1^Invalid Device Type - "_TYPE_"."_$C(30,31) Q   ;"APCDNE"
 ;validate MAX
 S MAX=$G(MAX)
 I MAX'="",MAX'=+MAX S @RET@(1)="-1^Invalid max records value - "_MAX_"."_$C(30,31) Q
 S:MAX="" MAX=9999999
 ;validate LSUB
 S LSUB=$G(LSUB)
 ;validate PARTIAL
 S PARTIAL=$G(PARTIAL)
 ;
 D @TYPE
 ;
 I SDSUB'="" S SDTMP=$P(@RET@(SDCNT),$C(30),1),$P(SDTMP,U,4)=SDSUB,@RET@(SDCNT)=SDTMP_$C(30)
 S @RET@(SDCNT)=@RET@(SDCNT)_$C(31)
 Q
A ;All Printers
 N DN,SDID
 S DN=$S($P(LSUB,"|",1)'="":$P(LSUB,"|",1),PARTIAL'="":$$GETSUB^SDECU(PARTIAL),1:"")
 F  S DN=$O(^%ZIS(1,"B",DN)) Q:DN=""  Q:(PARTIAL'="")&(DN'[PARTIAL)  D  I SDCNT>MAX S SDSUB=DN_"|"_SDID Q
 .S SDID=$S($P(LSUB,"|",2)'="":$P(LSUB,"|",2),1:0)
 .S LSUB=""
 .F  S SDID=$O(^%ZIS(1,"B",DN,SDID)) Q:SDID=""  D  I SDCNT>MAX S SDSUB=DN_"|"_SDID Q
 ..Q:'$D(^%ZIS(1,SDID,0))  ;existence check
 ..Q:$P($G(^%ZIS(2,+$G(^%ZIS(1,SDID,"SUBTYPE")),0)),U)'?1"P".E  ;subtype check
 ..Q:+$G(^%ZIS(1,SDID,90))   ;out of service
 ..S SDCNT=SDCNT+1 S @RET@(SDCNT)=SDID_U_DN_U_$$GET1^DIQ(3.5,SDID_",",.02,"E")_$C(30)
 Q
P ;Printers only on current namespace
 N DN,SDID
 K ^UTILITY("ZIS",$J)  ;^UTILITY is already used in device processing
 D LCPU
 S DN=$S($P(LSUB,"|",1)'="":$P(LSUB,"|",1),PARTIAL'="":$$GETSUB^SDECU(PARTIAL),1:"")
 F  S DN=$O(^UTILITY("ZIS",$J,"DEVLST","B",DN)) Q:DN=""  Q:(PARTIAL'="")&(DN'[PARTIAL)  D  I SDCNT>MAX S SDSUB=DN_"|"_SDID Q
 .S SDID=$S($P(LSUB,"|",2)'="":$P(LSUB,"|",2),1:0)
 .S LSUB=""
 .F  S SDID=$O(^UTILITY("ZIS",$J,"DEVLST","B",DN,SDID)) Q:SDID=""  D  I SDCNT>MAX S SDSUB=DN_"|"_SDID Q
 ..Q:'$D(^%ZIS(1,SDID,0))  ;existence check
 ..Q:$P($G(^%ZIS(2,+$G(^%ZIS(1,SDID,"SUBTYPE")),0)),U)'?1"P".E  ;subtype check
 ..Q:+$G(^%ZIS(1,SDID,90))   ;out of service
 ..S SDCNT=SDCNT+1 S @RET@(SDCNT)=SDID_U_DN_U_$$GET1^DIQ(3.5,SDID_",",.02,"E")_$C(30)
 K ^UTILITY("ZIS",$J)
 Q
LCPU ;build list of local devices  (namespace text needs to be in VOLUME SET(CPU) field)
 N %ZISV
 ;S %ZISV=$G(^%ZOSF("VOL"))
 S %ZISV="TIS"
 Q:%ZISV=""
 D LCPU^%ZIS5
 Q
 ;
 ;===
 ;
PRINT(RET,APID,TYPE,SDID)  ;Print patient letters
 ;INPUT:
 ;  APID - (required) Appointment ID pointer to SDEC APPOINTMENT file (#409.84)
 ;  TYPE - (required) Letter type
 ;                     P:Pre-Appointment
 ;                     C:Cancel Appointment
 ;                     N:No Show
 ;  SDID  - (required) Printer Device ID pointer to DEVICE file (#3.5)
 ;RETURN:
 ;  CODE ^ MESSAGE
 ;  CODE - 0=Success; -1=error
 ;  MESSAGE
 N A,DFN,J,L,L0,L2,S,S1,SC,ZTS
 N SD9,SDAMTYP,SDBD,SDCL,SDC,SDCLN,SDED,SDFN,SDFIRST,SDFORM,SDLET,SDLET1,SDLT,SDNOD,SDRES,SDT,SDTTM,SDV1,SDWH,SDX,SDY
 N VAUTNALL,VAUTNI
 S SDFIRST=1
 S RET=$NA(^TMP("SDECDEV",$J,"PRINT"))
 K @RET
 S @RET@(0)="I00030CODE^T00500MESSAGE"_$C(30)
 ;validate APID
 S APID=$G(APID)
 I APID="" S @RET@(1)="-1^Appointment ID is required."_$C(30,31) Q
 I '$D(^SDEC(409.84,APID,0)) S @RET@(1)="-1^Invalid Appointment ID."_$C(30,31) Q
 ;validate TYPE
 S TYPE=$G(TYPE)
 I TYPE="" S @RET@(1)="-1^Letter Type is required."_$C(30,31) Q
 I "PCN"'[TYPE S @RET@(1)="-1^Invalid Letter Type."_$C(30,31) Q
 ;validate SDID
 S SDID=$G(SDID)
 I SDID="" S @RET@(1)="-1^Device ID is required."_$C(30,31) Q
 I '$D(^%ZIS(1,SDID,0)) S @RET@(1)="-1^Invalid Device ID."_$C(30,31) Q
 ;
 S SDNOD=$G(^SDEC(409.84,APID,0))
 I SDNOD="" S @RET@(1)="-1^Error getting Appointment data."_$C(30,31) Q
 S DFN=$P(SDNOD,U,5)
 ;check bad address
 I $$BADADR^DGUTL3(+DFN) S @RET@(1)="-1^THIS PATIENT HAS BEEN FLAGGED WITH A BAD ADDRESS INDICATOR, NO LETTER WILL BE PRINTED."_$C(30,31) Q
 ;
 S SDRES=$P(SDNOD,U,7)
 I SDRES="" S @RET@(1)="-1^Resource is not defined for this appointment."_$C(30,31) Q
 S SC=$$GET1^DIQ(409.831,SDRES_",",.04,"I")
 I SC="" S @RET@(1)="-1^Clinic is not defined for the resource."_$C(30,31) Q
 S (SDT,SDTTM)=$P(SDNOD,U,1)
 S SDWH=$P(SDNOD,U,17)
 S @RET@(1)="0^SUCCESS"_$C(30)
 D PRE:TYPE="P",CAN:TYPE="C",NS:TYPE="N"
 S @RET@(1)=@RET@(1)_$C(31)
 Q
 ;
 ;
PRE ;print pre-appointment letter
 S SDY=0 F  S SDY=$O(^SC(SC,"S",SDTTM,1,SDY)) Q:SDY=""  Q:$P($G(^SC(SC,"S",SDTTM,1,SDY,0)),U,1)=DFN
 I SDY="" S @RET@(1)="-1^Clinic appointment not found."_$C(30) Q
 ;check for a PRE-APPT letter defined
 I $P($G(^SC(SC,"LTR")),U,2)="" S @RET@(1)="-1^A pre-appointment letter is not defined for "_$$GET1^DIQ(44,SC_",",.01)_"."_$C(30) Q
 ;
 ; pre-define letter type (P), the division, date for appt, etc.
 S (SDBD,SDED)=SDTTM,L0="P",SD9=0,VAUTNALL=1,VAUTNI=2,S1="P",SDLT=1,SDV1=1,SDFORM=""
 S L2=$S(L0="P":"^SDL1",1:"^SDL1"),J=SDBD
 S (A,SDFN,S)=DFN,L="^SDL1",SDCL=+$P(^SC(SC,0),U,1),SDC=SC,SDX=SDTTM
 S SDLET=$P(^SC(SC,"LTR"),U,2) ; letter IEN
 S SDLET1=SDLET
 S SDAMTYP="P"   ;always by patient
 ;I SDY["DPT(" S SDAMTYP="P",SDFN=+SDY
 ;I SDY["SC(" S SDAMTYP="C",SDCLN=+SDY
 ; prepare to queue the letter if the user so desires
 N %ZIS,IOP,POP,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S IOP="`"_SDID
 S %ZIS("B")="",POP=0,%ZIS="MQ" D ^%ZIS
 I POP S @RET@(1)="-1^Print error."_$C(30) Q
 S ZTIO=ION,ZTRTN="QUE^SDM1A",ZTDESC="PRINT PRE-APPT LETTER",ZTDTH=$$NOW^XLFDT   ;,ZTSAVE("*")=""
 F ZTS="A","AUTO(","DFN","DUZ","S","SC","SDCL","SDFORM","SDLET","SDWH","SDX" S ZTSAVE(ZTS)=""
 D ^%ZTLOAD K IO("Q")
 Q
 ;
CAN  ;print cancel-appointment letter
 N A,SDCL,SDL
 S SDL=""
 S A=DFN
 S SDCL(1)=SC_U_SDTTM
 I $D(^SC(SC,"LTR")) S:SDWH["P" SDL=$P(^SC(SC,"LTR"),"^",4) S:SDWH'["P" SDL=$P(^SC(SC,"LTR"),"^",3)
 I SDL="" S @RET@(1)="-1^Clinic is not assigned a "_$S(SDWH["P":"clinic",1:"appointment")_" cancellation letter"_$C(30) Q
 ;
 N %ZIS,POP,ZTDESC,ZTIO,ZTRTN,ZTSAVE
 S SDWH=$G(SDWH)
 I SDWH'="C",SDWH'="PC" S @RET@(1)="-1^Invalid Cancel Status"_$C(30) Q
 S IOP="`"_SDID
 S %ZIS("B")="",POP=0,%ZIS="MQ" D ^%ZIS   ;alb/sat 665 - change ^%ZIS params to match PRE
 I POP S @RET@(1)="-1^Print error."_$C(30) Q
 S ZTIO=ION,ZTRTN="SDLET^SDCNP1A",ZTDESC="PRINT CANCEL APPOINTMENT LETTER",ZTDTH=$$NOW^XLFDT F ZTS="SDCL(","DUZ","DFN","DT","A","SDWH","AUTO(" S ZTSAVE(ZTS)=""
 K ZTS D ^%ZTLOAD K IO("Q")
 Q
 ;
NS   ;print no-show appointment letter
 N ALS,ANS,C,DATEND,SDDT,SDLET,SDLT1,SDMSG,SDNSACT,SDTIME,SDV1
 I SDT="" S @RET@(1)="-1^Print error."_$C(30) Q
 S SDT=$P(SDT,".",1)
 S ALS="Y",ANS="N",C=SC,SDDT=DT
 S DATEND=SDT+.9
 S (SDLT1,SDLET)=""
 S SDNSACT=0
 S SDV1=$O(^DG(40.8,0))
 S SDTIME=$P(SDNOD,U,23)
 S:SDTIME="" SDTIME="*"
 S SDMSG=" DOES NOT HAVE A NO-SHOW LETTER ASSIGNED TO IT!"
 I '$D(^SC(C,"LTR")) S @RET@(1)="-1^"_$P(^SC(C,0),"^")_SDMSG Q
 I $D(^SC(C,"LTR")),'+^SC(C,"LTR") S @RET@(1)="-1^"_$P(^SC(C,0),"^")_SDMSG Q
 I $D(^SC(C,"LTR")),+^SC(C,"LTR") S SDLET=+^("LTR")
 I SDLET="" S @RET@(1)="-1^"_$P(^SC(C,0),"^")_SDMSG Q
 S IOP="`"_SDID
 S %ZIS("B")="",POP=0,%ZIS="MQ" D ^%ZIS   ;alb/sat 665 - change ^%ZIS params to match PRE
 I POP S @RET@(1)="-1^Print error."_$C(30) Q
 S ZTIO=ION,ZTRTN="START^SDN0",ZTDESC="PRINT NO SHOW APPOINTMENT LETTER",ZTDTH=$$NOW^XLFDT F ZTS="SC","SDDT","ALS","ANS","SDLET","SDV1","SDT","C","DATEND","SDTIME","SDLT1","AUTO(","SDNSACT" S ZTSAVE(ZTS)=""
 K ZTS D ^%ZTLOAD K IO("Q")
 Q
