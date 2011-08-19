ORB3TIM1 ; slc/CLA - Routine to trigger time-related notifications ;6/28/00 12:00 [ 04/02/97  11:12 AM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**31,64,74,88,102,143,179**;Dec 17, 1997
TNOTIFS ;process time-driven notifications - called by ORMTIM01
 ;
 ;Do not process DIV for param - ORMTIM01 is initiated by postmaster:
 Q:$$GET^XPAR("SYS^PKG","ORB SYSTEM ENABLE/DISABLE",1,"I")="D"
 N ORLASTQ,ORNOW,ORERR
 S ORNOW=$$NOW^XLFDT
 S ORLASTQ=$$GET^XPAR("SYS","ORB LAST QUEUE DATE",1,"I")
 ;
 D NPO
 D UNVER
 D UVMED
 D EXPIR^ORB3TIM2
 D PUT^XPAR("SYS","ORB LAST QUEUE DATE",1,ORNOW,.ORERR)
 Q
NPO ;trigger NPO diet > 72 hours notifications
 N ORNPO,ORPT,INVDT,ORDG,ORNUM,ORBDT,OREDT
 N OIFILE,ORBY,ORBI,ORST,ORSDT
 ;
 S ^XTMP("ORBNPO",0)=$$FMADD^XLFDT(ORNOW,1,"","","")_"^"_ORNOW
 ;
 ;get NPO OIs:
 S OIFILE=$$TERMLKUP^ORB31(.ORBY,"NPO")
 ;
 Q:'$D(ORBY)  ;quit if no link between NPO and local OI
 S:'$G(ORLASTQ) ORLASTQ=$$FMADD^XLFDT(ORNOW,"","-96","","")
 S ORBDT=$$FMADD^XLFDT(ORLASTQ,"","-72","","")
 S OREDT=$$FMADD^XLFDT(ORNOW,"","-72","","")
 F  S ORBDT=$O(^OR(100,"AF",ORBDT)) Q:(ORBDT="")!(ORBDT>OREDT)  D
 .S ORNUM="" F  S ORNUM=$O(^OR(100,"AF",ORBDT,ORNUM)) Q:ORNUM=""  D
 ..Q:$D(^XTMP("ORBNPO",ORNUM))
 ..; determine if NPO order:
 ..I +$G(OIFILE)=101.43 F ORBI=1:1:ORBY D
 ...S ORNPO=$P(ORBY(ORBI),U) I ORNPO=$$OI^ORQOR2(ORNUM) D
 ....S ORSDT=$P($G(^OR(100,ORNUM,0)),U,8)
 ....S ^XTMP("ORBNPO",ORNUM)=$S($L(ORSDT):ORSDT,1:ORBDT)_U_0
 ;
 ;loop thru XTMP looking for NPO orders with start d/t > 72
 S ORNUM=0 F  S ORNUM=$O(^XTMP("ORBNPO",ORNUM)) Q:+$G(ORNUM)<1  D
 .S ORSDT=$P(^XTMP("ORBNPO",ORNUM),U)
 .I $P(^XTMP("ORBNPO",ORNUM),U,2)=0 D  ;if alert not already triggered
 ..Q:ORSDT>OREDT  ;quit if start date more recent than 72 hours ago
 ..S ORPT=$P($G(^OR(100,ORNUM,0)),U,2) I ORPT]"" D
 ...S ORST=$P($$STATUS^ORQOR2(ORNUM),U,2)
 ...I ORST'="DISCONTINUED",ORST'="COMPLETE",ORST'="EXPIRED",ORST'="UNRELEASED",ORST'="CHANGED",ORST'="CANCELLED",ORST'="LAPSED",ORST'="SCHEDULED" D
 ....D EN^ORB3(31,+ORPT,ORNUM,"","",ORNUM_"@") ;trigger NPO>72 notif
 ....S $P(^XTMP("ORBNPO",ORNUM),U,2)=1  ;alert triggered
 .;
 .I $G(ORSDT)<$$FMADD^XLFDT(ORNOW,"-7","","","") D
 ..K ^XTMP("ORBNPO",ORNUM) ;kill XTMP if order start d/t > 7 days
 Q
UNVER ;trigger unverified order (by nurse) notif
 N ORPT,INVDT,ORDG,ORNUM,ORBDT,OREDT,ORST,ORX,ORACT,ORDELAY
 ;
 ;if not queued via ORMTIM01 recently, look for past 48 hours:
 S:'$G(ORLASTQ) ORLASTQ=$$FMADD^XLFDT(ORNOW,"","-48","","")
 ;
 ;get number of hours delay before trigger:
 S ORDELAY=$$GET^XPAR("ALL","ORB UNVERIFIED ORDER",1,"I")
 ;
 ;look for orders unverified after <parameter value> hours:
 S ORBDT=$$FMADD^XLFDT(ORLASTQ,"",-ORDELAY,"","")
 S OREDT=$$FMADD^XLFDT(ORNOW,"",-ORDELAY,"","")
 ;
 F  S ORBDT=$O(^OR(100,"AF",ORBDT)) Q:(ORBDT="")!(ORBDT>OREDT)  D
 .S ORNUM="" F  S ORNUM=$O(^OR(100,"AF",ORBDT,ORNUM)) Q:ORNUM=""  D
 ..S ORPT=$P($G(^OR(100,ORNUM,0)),U,2) I ORPT]"" D
 ...;The following filters match those in UVN1^ORQ11 so notif triggers
 ...;and orders displayed via alert follow-up action are in sync:
 ...S ORX=$G(^OR(100,ORNUM,0))
 ...Q:'$L(ORX)
 ...Q:$P(ORX,U,12)="O"  ;quit if outpatient order
 ...Q:$L($P(ORX,U,17))  ;quit if someone has released order
 ...S ORST=$P($$STATUS^ORQOR2(ORNUM),U,2)
 ...I ORST'="DISCONTINUED",ORST'="COMPLETE",ORST'="EXPIRED",ORST'="UNRELEASED",ORST'="CHANGED",ORST'="CANCELLED",ORST'="LAPSED" D
 ....Q:'$D(^OR(100,ORNUM,8))
 ....Q:$P(^OR(100,ORNUM,8,$P(^OR(100,ORNUM,8,0),U,3),0),U,8)  ;quit if someone has verified order
 ....D EN^ORB3(59,+ORPT,ORNUM,"","",ORNUM_"@")
 Q
UVMED ;trigger unverified med (by nurse) notif
 N DG,ORGRP,ORPT,INVDT,ORNUM,ORBDT,OREDT,ORST,ORX,ORACT,ORDELAY
 ;
 ;if not queued via ORMTIM01 recently, look for past 48 hours:
 S:'$G(ORLASTQ) ORLASTQ=$$FMADD^XLFDT(ORNOW,"","-48","","")
 ;
 ;get number of hours delay before trigger:
 S ORDELAY=$$GET^XPAR("ALL","ORB UNVERIFIED MED ORDER",1,"I")
 ;
 ;look for meds unverified after <parameter value> hours:
 S ORBDT=$$FMADD^XLFDT(ORLASTQ,"",-ORDELAY,"","")
 S OREDT=$$FMADD^XLFDT(ORNOW,"",-ORDELAY,"","")
 ;
 F  S ORBDT=$O(^OR(100,"AF",ORBDT)) Q:(ORBDT="")!(ORBDT>OREDT)  D
 .S ORNUM="" F  S ORNUM=$O(^OR(100,"AF",ORBDT,ORNUM)) Q:ORNUM=""  D
 ..S ORPT=$P($G(^OR(100,ORNUM,0)),U,2) I ORPT]"" D
 ...;The following filters match those in UVN1^ORQ11 so notif triggers
 ...;and orders displayed via alert follow-up action are in sync:
 ...S ORX=$G(^OR(100,ORNUM,0))
 ...Q:'$L(ORX)
 ...Q:'$L($$DGRX^ORQOR2(+ORNUM))  ;quit if not a pharmacy order
 ...Q:$P(ORX,U,12)="O"  ;quit if outpatient order
 ...Q:$L($P(ORX,U,17))  ;quit if someone has released order
 ...S ORST=$P($$STATUS^ORQOR2(ORNUM),U,2)
 ...I ORST'="DISCONTINUED",ORST'="COMPLETE",ORST'="EXPIRED",ORST'="UNRELEASED",ORST'="CHANGED",ORST'="CANCELLED",ORST'="LAPSED" D
 ....Q:'$D(^OR(100,ORNUM,8))
 ....Q:$P(^OR(100,ORNUM,8,$P(^OR(100,ORNUM,8,0),U,3),0),U,8)  ;quit if someone has verified order
 ....D EN^ORB3(48,+ORPT,ORNUM,"","",ORNUM_"@")
 Q
GRP(DG) ;Setup display groups
 ;DG=Display group to expand
 N STK,MEM,I
 S ORGRP(DG)="",STK=1,STK(STK)=DG_"^0",STK(0)=0,MEM=0
 F I=0:0 S MEM=$O(^ORD(100.98,+STK(STK),1,MEM)) D @$S(+MEM'>0:"POP",1:"PROC") Q:STK<1
 Q
POP S STK=STK-1,MEM=$P(STK(STK),"^",2) Q
PROC S $P(STK(STK),"^",2)=MEM,DG=$P(^ORD(100.98,+STK(STK),1,MEM,0),"^",1)
 S ORGRP(DG)="",STK=STK+1,STK(STK)=DG_"^0",MEM=0
 Q
