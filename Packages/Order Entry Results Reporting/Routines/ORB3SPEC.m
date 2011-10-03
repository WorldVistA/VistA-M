ORB3SPEC ; slc/CLA - Support routine for ORB3 ;07/15/10  13:11
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**139,220,215,280**;Dec 17, 1997;Build 85
SPECIAL(ORN,ORBASPEC,ORBU,ORBUI,ORNUM,ORDFN,ORDATA,ORBSMSG,ORBMSG,ORBSDEV,ORBPRIM,ORBATTD) ;
 ;process special notifs to get recips (users,teams,devices)
 ; ORN: notif ien
 ; ORBASPEC: recip DUZ array
 ; ORBU: recip debug array
 ; ORBUI: ORBU cntr
 ; ORNUM: order no
 ; ORDFN: pt id
 ; ORDATA: pkg data
 ; ORBSMSG: special notif msg rtn by SPECIAL
 ; ORBMSG: original notif msg
 ; ORBSDEV: array of recip devices
 ; ORBPRIM: pt's inpt primary care provider
 ; ORBATTD: pt's attending physician
 ;
 N ORPAR,ORPTLOC
 S ORPTLOC=$S($L($G(^DPT(ORDFN,.1))):"I",1:"O")  ;DBIA #10035
 ;
 I ORPTLOC="I" D  ;inpt flagged OI notifs
 .I ORN=32 S ORPAR="ORB OI RESULTS - INPT" D OI
 .I ORN=41 S ORPAR="ORB OI ORDERED - INPT" D OI
 .I ORN=64 S ORPAR="ORB OI EXPIRING - INPT" D OI
 ;
 I ORPTLOC="O" D  ;outpt flagged OI notifs
 .I ORN=60 S ORPAR="ORB OI RESULTS - OUTPT" D OI
 .I ORN=61 S ORPAR="ORB OI ORDERED - OUTPT" D OI
 .I ORN=65 S ORPAR="ORB OI EXPIRING - OUTPT" D OI
 ;
 I ORN=3!(ORN=14)!(ORN=44)!(ORN=57) D  ;lab results notifs
 .D LRALRTS(ORN,ORDFN,ORDATA,.ORBSMSG,ORBMSG)
 ;
 I ORN=33 D  ;requested results notif
 .I $D(ORBU) D
 ..S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 ..S ORBU(ORBUI)="Potential Orderer-flagged Results recipient: ",ORBUI=ORBUI+1
 .N RECIP
 .S RECIP=$$RSLTFLG^ORQOR2(ORNUM)
 .I +$G(RECIP)>0 D
 ..S ORBASPEC(+$G(RECIP))=""
 ..I $D(ORBU) N NODE S NODE=$G(^VA(200,+$G(RECIP),0)) I $L(NODE) D
 ...S ORBU(ORBUI)="   "_$P(NODE,U)_" is a potential recipient.",ORBUI=ORBUI+1
 Q
OI ;get potential recips for OI-flagged notifs
 N OROI,ORLST,ORERR,ORBX,ORBZ,ORBE,ORBDUZ,ORBDEV,ORBUF
 S OROI=+$G(^OR(100,+$G(ORNUM),.1,1,0))  ;get oi
 Q:+$G(OROI)<0
 I $D(ORBU) D
 .S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 .S ORBU(ORBUI)="Special potential recipients from parameter: "_ORPAR,ORBUI=ORBUI+1
 S ORBE=0,ORBX=0
 ;
 ;process special recip users, teams and devices:
 D ENVAL^XPAR(.ORLST,ORPAR,"`"_OROI,.ORERR)
 I 'ORERR,$G(ORLST)>0 D
 .F ORBX=1:1:ORLST S ORBE=$O(ORLST(ORBE)),ORBZ=$P(ORBE,";",2),ORBUF=0 D
 ..;
 ..; process USERS:
 ..I ORBZ="VA(200," S ORBDUZ=$P(ORBE,";") I $L(ORBDUZ) D
 ...I ORLST(ORBE,OROI)=1 S ORBASPEC(ORBDUZ)="",ORBUF=1
 ...I ORLST(ORBE,OROI)=0,$$PPLINK^ORQPTQ1(ORBDUZ,ORDFN) S ORBASPEC(ORBDUZ)="",ORBUF=1
 ...I $D(ORBU),ORBUF=1 N NODE S NODE=$G(^VA(200,ORBDUZ,0)) I $L(NODE) D
 ....S ORBU(ORBUI)="   "_$P(NODE,U)_" is a potential recipient.",ORBUI=ORBUI+1
 ..;
 ..; process DEVICES:
 ..I ORBZ="%ZIS(1," S ORBDEV=$P(ORBE,";") I $L(ORBDEV),$D(^%ZIS(1,ORBDEV))>0 D
 ...S ORBDEV=$G(^%ZIS(1,ORBDEV,0)) I $D(ORBDEV) D
 ....I ORLST(ORBE,OROI)=1 S ORBSDEV($P(ORBDEV,U))="",ORBUF=1
 ....I ORLST(ORBE,OROI)=0,$$PDLINK^ORQPTQ1(ORBDEV,ORDFN) S ORBSDEV($P(ORBDEV,U))="",ORBUF=1
 ....I $D(ORBU),ORBUF=1 D
 .....S ORBU(ORBUI)="   "_$P(ORBDEV,U)_" is a device recipient.",ORBUI=ORBUI+1
 ..;
 ..; process TEAMS:
 ..I ORBZ="OR(100.21," D SPECTEAM(ORBE)
 D TITLE(OROI,ORPAR)
 Q
SPECTEAM(ORBE) ;get special team recips
 N ORBLST,IJ,ORBTM
 S ORBTM=$P(ORBE,";")
 D TEAMPROV^ORQPTQ1(.ORBLST,ORBTM)
 I $D(ORBU) N TNODE S TNODE=$G(^OR(100.21,ORBTM,0)) I $L(TNODE) D
 .S ORBU(ORBUI)="   Team potential recipients from team "_$P(TNODE,U)_":",ORBUI=ORBUI+1
 I +$G(ORBLST(1))>0 S IJ="" F  S IJ=$O(ORBLST(IJ)) Q:IJ=""  D
 .S ORBDUZ=$P(ORBLST(IJ),U),ORBUF=0 I $L(ORBDUZ) D
 ..I ORLST(ORBE,OROI)=1 S ORBASPEC(ORBDUZ_U_ORBTM)="",ORBUF=1
 ..I ORLST(ORBE,OROI)=0,$D(^OR(100.21,ORBTM,10,"B",ORDFN_";DPT(")) S ORBASPEC(ORBDUZ_U_ORBTM)="",ORBUF=1
 ..I $D(ORBU),ORBUF=1 N NODE S NODE=$G(^VA(200,ORBDUZ,0)) I $L(NODE) D
 ...S ORBU(ORBUI)="     "_$P(NODE,U),ORBUI=ORBUI+1
 ;
 S ORBTD=$P($$TMDEV^ORB31(ORBTM),U,2)  ;tm's device
 I $L(ORBTD) D
 .S ORBSDEV(ORBTD)=""
 .I $D(ORBU) D
 ..S ORBU(ORBUI)="   Team's Device "_ORBTD_" is a recipient",ORBUI=ORBUI+1
 Q
LRALRTS(ORN,ORDFN,ORDATA,ORBSMSG,ORBMSG) ;find & delete matching alerts and gather recips
 ; ORN: notif ien
 ; ORDFN: pt id
 ; ORDATA: pkg data
 ; ORBSMSG: special notif msg rtn by LRALRTS
 ; ORBMSG: original notif msg
 ;
 Q:+$G(ORN)<1
 Q:+$G(ORDFN)<1
 Q:+$G(ORDATA)<1
 N LRID,ORY,I,J,XQAID,XQ0,XQ1,ORNE,RECIP,ORDATAE,LRIDE,STDATE
 N ORTST,ORBMSGE,ORBMSGX,TXQAID,XQF,ORBHX,ORX,ORBI,ORTSTE
 ;
 S LRID=$P($P(ORDATA,"|",2),"@")  ;get lab unique results id (OE IDE)
 Q:+$G(LRID)<1
 ;
 ;get pt's alerts within 24 hours:
 S STDATE=$$FMADD^XLFDT($$NOW^XLFDT,"","-24","","")
 D PATIENT^XQALERT("ORY",ORDFN,STDATE,"") ;get pt's alerts
 ;
 ;look for pt's alerts with same notif ien and unique lab results id:
 F I=1:1:ORY D
 .S XQAID=$P(ORY(I),U,2)
 .S ORBMSGX=$P(ORY(I),U)
 .S ORNE=$P($P(XQAID,";"),",",3)  ;get notif ien
 .Q:ORNE'=ORN
 .;
 .;find matching alert:
 .D AHISTORY^XQALBUTL(XQAID,"ORBHX")
 .S ORDATAE=$G(ORBHX(2))
 .Q:'$L(ORDATAE)
 .S LRIDE=$P($P(ORDATAE,"|",2),"@")  ;get lab rslts id from existng alert
 .Q:LRIDE'=LRID
 .;
 .S:ORBMSG["[" ORTST=$P($P(ORBMSG,"[",2),"]")
 .I ORBMSG'["[" D
 ..S:ORBMSG["labs: " ORTST=$P(ORBMSG,"labs: ",2)
 ..S:ORBMSG["results: " ORTST=$P(ORBMSG,"results: ",2)
 .;
 .S ORBMSGE=$P(ORBMSGX,"): ",2)
 .S:ORBMSGE["[" ORTSTE=$P($P(ORBMSGE,"[",2),"]")  ;added to fix CQ #17548 (Part A) for CPRS v28.1 (TC).
 .;added to fix CQ #19497: undefined ORTSTE variable [v28.17] (TC)
 .I ORBMSGE'["[" D
 ..S:ORBMSGE["labs: " ORTSTE=$P(ORBMSGE,"labs: ",2)
 ..S:ORBMSGE["results: " ORTSTE=$P(ORBMSGE,"results: ",2)
 .E  S ORTSTE=""
 .;
 .S ORX=0
 .;if alert has recips, get recips from existing alert:
 .S:$L($G(ORBHX(20,0))) ORX=$P(ORBHX(20,0),U,4)
 .F ORBI=1:1:ORX D
 ..S RECIP=+ORBHX(20,ORBI,0)
 ..S ORBASPEC(RECIP)=""  ;add recip to new alert recip list
 .;
 .;delete existing alert:
 .S XQAKILL=0  ;delete for all recips
 .D DELETE^XQALERT
 .K XQAKILL,XQAID
 ;
 ;if NO prev alert msg for this pt, notif, lab unique id:
 I '$L($G(ORBMSGE)) S ORBSMSG=ORBMSG
 ;
 ;if prev alert msg for this pt, notif, lab unique id:
 I $L($G(ORBMSGE)) D
 .;S:ORBMSGE["[" ORBSMSG=$P(ORBMSGE,"]")_", "_ORTST_"]"
 .S ORBSMSG=$S(ORBMSGE["["&(ORTSTE'=ORTST):$P(ORBMSGE,"]")_", "_ORTST_"]",(ORBMSGE'["[")&(ORTSTE'=ORTST):ORBMSGE_", "_ORTST,1:ORBMSGE) ;added to fix CQ #17548 (Part A) for CPRS v28.1 (TC).
 .;S:ORBMSGE'["[" ORBSMSG=ORBMSGE_", "_ORTST
 ;
 Q
 ;
TITLE(OROI,ORPAR) ;get provider recips
 N ORTIT
 I $D(ORBU) D
 .S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 .S ORBU(ORBUI)="Special potential recipients from parameter: "_ORPAR_" PR",ORBUI=ORBUI+1
 ;
 ;process special recip users, teams and devices for Provider Recipients
 S ORTIT=$$GET^XPAR("ALL",ORPAR_" PR","`"_OROI,"E")
 Q:'$L(ORTIT)
 I ORTIT["P" D PRIMARY
 I ORTIT["A" D ATTEND
 I ORTIT["T" D TEAMS
 I ORTIT["O" D ORDERER
 I ORTIT["E" D ENTERBY
 I ORTIT["R" D PCMMPRIM
 I ORTIT["S" D PCMMASSC
 I ORTIT["M" D PCMMTEAM
 Q
PRIMARY ;
 I $D(ORBU),+$G(ORBPRIM)>0 S ORBU(ORBUI)=" Flagged OI Inpt primary provider:",ORBUI=ORBUI+1
 I $D(ORBU),+$G(ORBPRIM)<1 S ORBU(ORBUI)=" Flagged OI Inpt primary provider: option cannot determine without A/D/T event data.",ORBUI=ORBUI+1
 I +$G(ORBPRIM)>0 S ORBASPEC(ORBPRIM)=""
 Q
ATTEND ;
 I $D(ORBU),+$G(ORBATTD)>0 S ORBU(ORBUI)=" Flagged OI Attending physician:",ORBUI=ORBUI+1
 I $D(ORBU),+$G(ORBATTD)<1 S ORBU(ORBUI)=" Flagged OI Attending physician: option cannot determine without A/D/T event data.",ORBUI=ORBUI+1
 I +$G(ORBATTD)>0 S ORBASPEC(ORBATTD)=""
 Q
TEAMS ;
 N ORBLST,ORBI,ORBJ,ORBTM,ORBTNAME,ORBTTYPE,ORBTD
 I $D(ORBU) S ORBU(ORBUI)=" Flagged OI Teams/Personal Lists related to patient:",ORBUI=ORBUI+1
 D TMSPT^ORQPTQ1(.ORBLST,ORDFN)
 Q:+$G(ORBLST(1))<1
 S ORBI="" F  S ORBI=$O(ORBLST(ORBI)) Q:ORBI=""  D
 .S ORBTM=$P(ORBLST(ORBI),U),ORBTNAME=$P(ORBLST(ORBI),U,2)
 .S ORBTTYPE=$P(ORBLST(ORBI),U,3)
 .I $D(ORBU) D
 ..S ORBU(ORBUI)="  Patient list "_ORBTNAME_" ["_ORBTTYPE_"]:",ORBUI=ORBUI+1
 .N ORBLST2 D TEAMPROV^ORQPTQ1(.ORBLST2,ORBTM)
 .Q:+$G(ORBLST2(1))<1
 .S ORBJ="" F  S ORBJ=$O(ORBLST2(ORBJ)) Q:ORBJ=""  D
 ..S ORBDUZ=$P(ORBLST2(ORBJ),U)_U_ORBTM I +$G(ORBDUZ)>0 S ORBASPEC(ORBDUZ)=""
 .S ORBTD=$P($$TMDEV^ORB31(ORBTM),U,2)  ;tm's device
 .I $L(ORBTD) D
 ..S ORBSDEV(ORBTD)=""
 ..I $D(ORBU) D
 ...S ORBU(ORBUI)="   Team's Device "_ORBTD_" is a recipient",ORBUI=ORBUI+1
 Q
ORDERER ;
 N ORBDUZ
 I $D(ORBU) S ORBU(ORBUI)=" Flagged OI Ordering provider:",ORBUI=ORBUI+1
 Q:+$G(ORNUM)<1
 S ORBDUZ=$$ORDERER^ORQOR2(ORNUM)
 I +$G(ORBDUZ)>0 D
 .S ORBASPEC(ORBDUZ)=""
 Q
ENTERBY ;
 N ORBDUZ
 I $D(ORBU) S ORBU(ORBUI)=" Flagged OI User entering order's most recent activity:",ORBUI=ORBUI+1
 Q:+$G(ORNUM)<1
 I $D(^OR(100,ORNUM,8,0)) D
 .S ORBDUZ=$P(^OR(100,ORNUM,8,$P(^OR(100,ORNUM,8,0),U,3),0),U,13)
 I +$G(ORBDUZ)>0 S ORBASPEC(ORBDUZ)=""
 Q
PCMMPRIM ;
 N ORBDUZ
 I $D(ORBU) S ORBU(ORBUI)=" Flagged OI PCMM Primary Care Practitioner:",ORBUI=ORBUI+1
 S ORBDUZ=+$$OUTPTPR^SDUTL3(ORDFN,$$NOW^XLFDT,1)  ;DBIA #1252
 I +$G(ORBDUZ)>0 S ORBASPEC(ORBDUZ)=""
 Q
PCMMASSC ;
 N ORBDUZ
 I $D(ORBU) S ORBU(ORBUI)=" Flagged OI PCMM Associate Provider:",ORBUI=ORBUI+1
 S ORBDUZ=+$$OUTPTAP^SDUTL3(ORDFN,$$NOW^XLFDT)  ;DBIA #1252
 I +$G(ORBDUZ)>0 S ORBASPEC(ORBDUZ)=""
 Q
PCMMTEAM ;
 N ORPCMM,ORPCMMDZ,ORBDUZ
 I $D(ORBU) S ORBU(ORBUI)=" Flagged OI PCMM Team Position Assignments:",ORBUI=ORBUI+1
 S ORPCMM=$$PRPT^SCAPMC(ORDFN,,,,,,"^TMP(""ORPCMM"",$J)",)  ;DBIA #1916
 S ORPCMMDZ=0
 F  S ORPCMMDZ=$O(^TMP("ORPCMM",$J,"SCPR",ORPCMMDZ)) Q:'ORPCMMDZ  D
 .S ORBDUZ=ORPCMMDZ S ORBASPEC(ORBDUZ)=""
 K ^TMP("ORPCMM",$J)
 Q
