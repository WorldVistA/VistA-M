ORB31 ; slc/CLA - Routine to support OE/RR 3 notifications ;6/28/00  12:00 [ 04/02/97  11:12 AM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6,31,88,105,139,173,220,215**;Dec 17, 1997
QUEUE(ORN,ORBDFN,ORNUM,ORBADUZ,ORBPMSG,ORBPDATA,ORBH,ORBD,ORDGPMA) ;
 ;queue up notif for Taskman processing
 ;ORN       notification ien from file 100.9
 ;ORBDFN    patient dfn from file 2
 ;ORNUM     order number from file 100
 ;ORBADUZ   array of potential user recipients (iens from file 100)
 ;ORBPMSG   alert message from triggering process
 ;ORBPDATA  data potentially used in alert follow-up action
 ;ORBH      $H formatted time to begin Taskman process
 ;ORBD      process description for Taskman
 ;ORDGPMA   DGPMA if alert triggered by A/D/T event
 ;
 N ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTPAR,ZTPRE,ZTPRI,ZTREQ,ZTRTN,ZTSAVE,ZTSK,ZTUCI,X,Y,DIC
 ;
 S DIC="3.5",X="ORB NOTIFICATION RESOURCE",DIC(0)="X" D ^DIC
 I (Y) S ZTIO=$P(Y,U,2)
 E  S ZTIO=""
 S ZTDTH=ORBH,ZTRTN="ZTSK^ORB3"
 S ZTDESC=ORBD
 S ZTDESC=ZTDESC_"for ("_ORBDFN_") "_$P($G(^DPT(+ORBDFN,0)),U,1)
 K ZTSAVE,ZTCPU,ZTUCI,ZTPRI,ZTPAR,ZTPRE,DIC,Y,DTOUT,DUOUT
 ;
 S ZTSAVE("ORN")=""
 S ZTSAVE("ORBDFN")=""
 S ZTSAVE("ORNUM")=""
 S ZTSAVE("ORBADUZ(")=""
 S ZTSAVE("ORBPMSG")=""
 S ZTSAVE("ORBPDATA")=""
 S ZTSAVE("ORDGPMA")=""
 D ^%ZTLOAD
 Q
DUP(ORN,ORBDFN,ORBPMSG,ORNUM) ;ext funct return "1" if a duplicate notif w/in 1 min.
 N ORBDUP,ORBNOW,ORBLAST,ORLNUM,ORSAMEP
 S ORBDUP=0
 S ORSAMEP=0
 S ORBNOW=$$NOW^XLFDT
 S ^XTMP("ORBDUP",0)=$$FMADD^XLFDT(ORBNOW,1,"","","")_"^"_ORBNOW
 I '$L($G(^XTMP("ORBDUP",ORBDFN_";"_ORN_";"_ORBPMSG))) S ^XTMP("ORBDUP",ORBDFN_";"_ORN_";"_ORBPMSG)=ORBNOW_"^"_$G(ORNUM)
 E  D
 .S ORBLAST=$G(^XTMP("ORBDUP",ORBDFN_";"_ORN_";"_ORBPMSG))
 .S ORLNUM=$P(ORBLAST,"^",2)
 .S ORBLAST=$P(ORBLAST,"^")
 .I $L($G(ORNUM)),$L($G(ORLNUM)),($$ORDERER^ORQOR2(ORNUM)=$$ORDERER^ORQOR2(ORLNUM)) S ORSAMEP=1 ;same provider as last order that triggered this notif
 .;if last occurrence of this "NOT" notif was w/in past 1 min, its a dup
 .I ORBNOW<$$FMADD^XLFDT(ORBLAST,"","",1,""),ORSAMEP=1 S ORBDUP=1  ;dup
 .E  S ^XTMP("ORBDUP",ORBDFN_";"_ORN_";"_ORBPMSG)=ORBNOW_"^"_ORNUM  ;refresh last pt/noti occ.
 D DUPCLN(ORBNOW)  ;clean up old ^XTMP("ORBUP") entries
 Q ORBDUP
REGDEV(ORBDA) ;send to regular recipient devices
 N ORBDT,ORBD
 S ORBD=""
 S ORBDT=$$NOW^XLFDT
 F   S ORBD=$O(ORBDA(ORBD)) Q:ORBD=""  D
 .S ZTRTN="PRINTD^ORB31",ZTDESC="Print Notification to Device",ZTDTH=$H
 .S ZTIO=ORBD,ZTSAVE("XQAMSG")="",ZTSAVE("ORBDT")=""
 .D ^%ZTLOAD
 Q
PRINTD ;print queued notification to device - setup via REGDEV^ORB3
 I $G(ZTSK) D KILL^%ZTLOAD
 I IOT="HFS" W XQAMSG Q  ;write msg to a file then quit
 W !!!,"          ***** NOTIFICATION PROCESSED *****",!!
 W $$FMTE^XLFDT(ORBDT),"   "
 W XQAMSG
 I $E(IOST,1,2)'="C-" W @IOF
 Q
FWD(ORY,ORBLST,ORBRECIP,ORBTYPE,ORBCOMNT) ; forward a notification
 I ORBLST="" S ORY=0 Q
 S ORBLST(1)=ORBLST
 D FORWARD^XQALFWD(.ORBLST,.ORBRECIP,ORBTYPE,ORBCOMNT)
 S ORY=1
 Q
RENEW(ORY,XQAID) ; renew/restore an alert/notification
 Q:$L($G(XQAID))<1
 K XQAKILL
 I '$D(^XTV(8992,"AXQA",XQAID,DUZ)) D RESTORE^XQALERT1 ;DBIA #4100
 S ORY=1
 Q
TERMLKUP(OCXARR,OCXTERM) ; extrinsic function returns the local terms
 ; linked to the nat'l OCX term in an array and the file where those
 ; array terms can be found. The value of the extrinsic function is the
 ; file pointed to for the local terms.
 ;
 ; OCXARR  - Array of local terms
 ; OCXTERM - OCX nat'l term from file ^OCXS(860.9
 ;
 N OCXI,OCXJ,FILE,I
 S OCXI="",OCXJ=0,FILE="",I=1
 S OCXI=$O(^OCXS(860.9,"B",OCXTERM,OCXI))
 I +$G(OCXI)>0 D
 .S FILE=$P(^OCXS(860.9,OCXI,0),U,2)
 .F  S OCXJ=$O(^OCXS(860.9,OCXI,1,OCXJ)) Q:+OCXJ<1  D
 ..S OCXARR(I)=$P(^OCXS(860.9,OCXI,1,OCXJ,0),U,2)_U_$P(^(0),U)
 ..S OCXARR=I,I=I+1
 Q FILE
DUPCLN(ORBNOW) ;clean up old entires in ^XTMP("ORBDUP")
 N ORBX,ORBDT,ORNDT
 S ORNDT=$$FMADD^XLFDT(ORBNOW,"","",-5,"")  ;entries older than 5 minutes
 S ORBX=0
 F  S ORBX=$O(^XTMP("ORBDUP",ORBX)) Q:ORBX=""  D
 .S ORBDT=+$G(^XTMP("ORBDUP",ORBX))
 .I $L(ORBDT),(ORBDT<ORNDT) K ^XTMP("ORBDUP",ORBX)
 Q
TMDEV(ORBTM) ;returns Device for a team in format device ien^device name
 N ORBTDEV,ORBTDEVN
 S ORBTDEVN=""
 Q:'$L($G(ORBTM)) ""
 Q:'$D(^OR(100.21,ORBTM,0)) ""
 S ORBTDEV=$P(^OR(100.21,ORBTM,0),U,4)  ;get Team's device
 Q:+$G(ORBTDEV)<1 ""
 S X="`"_ORBTDEV,DIC=3.5,DIC(0)="" D ^DIC  ;DBIA #10114
 Q:+Y<1 ""
 S ORBTDEVN=$P(Y,U,2)
 K DIC,Y,X
 Q ORBTDEV_U_ORBTDEVN
ENTITY(ORNUM) ;ext funct. rtns entity for parameter use
 N ORBENT
 S ORBENT="DIV^SYS^PKG"
 I $L($G(ORNUM)) D  ;if order number use pt's location division
 .N ORDIV
 .S ORDIV=0,ORDIV=$$ORDIV(ORNUM)
 .I +$G(ORDIV)>0 S ORBENT=ORDIV_";DIC(4,^SYS^PKG"
 Q ORBENT
 ;
ADT(ORN,ORBDFN,ORBPRIM,ORBATTD,ORDGPMA) ;get inpt primary and attending for ADT notifs
 N ORBADTDT,VAINDT
 ;if notif is deceased or discharge use prev visit d/t:
 I (ORN=20)!(ORN=35) D
 .S ORBADTDT=$S($D(ORDGPMA):$P(ORDGPMA,U),1:$P($G(^DPT(ORBDFN,.35)),U))
 .I $L(ORBADTDT) S VAINDT=$$FMADD^XLFDT(ORBADTDT,"","","","-1")
 ;
 I ORN=18 S VAINDT=$P($G(ORDGPMA),U)  ;if admission use this visit d/t
 ;
 I $L($G(VAINDT)) D
 .D INP^VADPT  ;get new VAIN array for appropriate visit
 .S ORBPRIM=+$P(VAIN(2),U),ORBATTD=+$P(VAIN(11),U)
 Q
 ;
DEFDIV(ORDUZ) ; Return user's default division, if specified.
 ;
 N ORDD,ORDIV,ORGOOD,ORZ,ORZERR
 ;
 S ORDIV=""
 S Y=0,(ORDD,ORGOOD)=0             ; Initialize variables.
 ;
 ; Get list of divisions from NEW PERSON file multiple:
 D LIST^DIC(200.02,","_ORDUZ_",","@;.01;1","QP","","","","","","","ORZ","ORZERR")
 I $P(ORZ("DILIST",0),U)=0 Q       ; No Divisions listed.
 ;
 F  S ORDD=$O(ORZ("DILIST",ORDD)) Q:+ORDD=0!'($L(ORDD))  D  Q:ORGOOD
 .; See if current entry being processed is "Default" (done if so):
 .I $P(ORZ("DILIST",ORDD,0),U,3)["Y" S ORDIV=$P(ORZ("DILIST",ORDD,0),U,1,2),ORGOOD=1
 Q ORDIV
 ;
ORDIV(ORNUM) ; Return order's division based upon patient's location when order was placed
 ;
 Q:+$G(ORNUM)<1 ""
 Q:'$D(^OR(100,ORNUM,0)) ""
 N ORDIV,PTLOC
 S ORDIV=""
 S PTLOC=+$P(^OR(100,ORNUM,0),U,10)
 Q:$G(PTLOC)<1 ""
 S ORDIV=$P(^SC(PTLOC,0),U,4)  ;DBIA #10040
 Q ORDIV
