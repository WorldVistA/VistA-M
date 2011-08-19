ORB3TIM2 ; slc/CLA - Routine to trigger time-related notifications ;3/30/01  07:41 [1/3/05 8:21am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**102,215,251,265**;Dec 17, 1997;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EXPIR ;trigger expiring order notifs
 N EDT,EXDT,EXORN,ORBDNR,ORPT,ORBRSLT,RXORD,ORLASTDT,X,Y,%DT
 N OIFILE,ORBY,ORBZ,ORBI,ORSCH,ORSCHFIL,ONETIME,ORST,ORNG,ORDT,ORDW,ORHOL
 N EXOI,ORBLST,ORBERR,OITXT,PTLOC,ORSDT,ORNOW,ORLDT
 ;
 S ORNOW=$$NOW^XLFDT
 ;
 I '$D(^XTMP("ORB LAST EXPIRE")) D  ;holds last dt EXPIR processed
 .S ^XTMP("ORB LAST EXPIRE",0)=$$FMADD^XLFDT(ORNOW,7,"","","")_U
 ;
 ;determine number of days to return orders using day of week & holidays
 F ORNG=1:1 D  I ORHOL=0,ORDW=0 Q
 .S ORDW=$S($H-4+ORNG#7>4:1,1:0)          ;if Sat or Sun, ORDW=0
 .S ORDT=$$FMADD^XLFDT(DT,ORNG)
 .K DIC S DIC="^HOLIDAY(",X=ORDT D ^DIC
 .S ORHOL=$S(+$G(Y)>0:1,1:0)              ;if ORDT is a holiday, ORHOL=0
 S %DT="",X="T+"_ORNG D ^%DT
 S EDT=Y_".2400"
 K DIC
 ;
 ;get DNR OIs:
 S OIFILE=$$TERMLKUP^ORB31(.ORBY,"DNR")
 ;
 ;get local admin schedules for ONE TIME MED:
 S ORSCHFIL=$$TERMLKUP^ORB31(.ORBZ,"ONE TIME MED")
 ;
 ;examine expiring orders:
 S ORLASTDT=$P(^XTMP("ORB LAST EXPIRE",0),U,2)
 S EXDT=$S($L(ORLASTDT):ORLASTDT,1:ORNOW)
 F  S EXDT=$O(^OR(100,"AE",EXDT)) Q:(EXDT="")  D  Q:ORBRSLT<0
 .S ORBRSLT=$$FMDIFF^XLFDT(EDT,$P(EXDT,".")_".2400",2)  ;diff in seconds
 .Q:ORBRSLT<0
 .S EXORN="" F  S EXORN=$O(^OR(100,"AE",EXDT,EXORN)) Q:EXORN=""  D
 ..;
 ..;Quit if isn't at least next day after order's Date of Last Activity:
 ..S ORLDT=$P(^OR(100,EXORN,3),U)
 ..Q:$$FMDIFF^XLFDT(ORNOW,ORLDT)<1
 ..;
 ..Q:$D(^XTMP("ORB LAST EXPIRE",EXORN))  ;quit if order already processed
 ..S ^XTMP("ORB LAST EXPIRE",EXORN)=EXDT
 ..;
 ..S ORPT=$$PT^ORQOR2(EXORN)   ; get pt assoc w/order
 ..Q:+$G(ORPT)<1
 ..;
 ..Q:+$G(^DPT(ORPT,.35))>0  ; quit if pt deceased - DBIA #10035
 ..;
 ..S PTLOC=$G(^DPT(+$G(ORPT),.1)),PTLOC=$S($L(PTLOC):PTLOC,1:"OUTPT")
 ..;
 ..; is expiring order a DNR order:
 ..I $D(ORBY),(+$G(OIFILE)=101.43) D
 ...F ORBI=1:1:ORBY D
 ....S ORBDNR=$P(ORBY(ORBI),U) I ORBDNR=$$OI^ORQOR2(EXORN) D
 .....S ORST=$P($$STATUS^ORQOR2(EXORN),U,2)
 .....I ORST'="DISCONTINUED",ORST'="COMPLETE",ORST'="EXPIRED",ORST'="CANCELLED",ORST'="DISCONTINUED/EDIT" D
 ......D EN^ORB3(45,ORPT,EXORN,"","",EXORN_"@") ;trigger DNR notif
 ..;
 ..; is expiring order a flagged oi:
 ..S EXOI=$$OI^ORQOR2(EXORN) I +$G(EXOI)>0 D
 ...I $L(PTLOC),PTLOC'="OUTPT" D
 ....D ENVAL^XPAR(.ORBLST,"ORB OI EXPIRING - INPT","`"_EXOI,.ORBERR)
 ....I 'ORBERR,'$G(ORBLST) D ENVAL^XPAR(.ORBLST,"ORB OI EXPIRING - INPT PR","`"_EXOI,.ORBERR)
 ....I 'ORBERR,$G(ORBLST)>0 D
 .....S OITXT=$P(^ORD(101.43,EXOI,0),U)
 .....S ORSDT=$P(^OR(100,EXORN,0),U,8),ORSDT=$$FMTE^XLFDT(ORSDT,"2P")
 .....D EN^ORB3(64,ORPT,EXORN,"","["_PTLOC_"] Order expiring: "_OITXT_" "_ORSDT,EXORN_"@") ;trigger Expiring Flagged OI - INPT notification
 ...;
 ...I $L(PTLOC),PTLOC="OUTPT" D
 ....D ENVAL^XPAR(.ORBLST,"ORB OI EXPIRING - OUTPT","`"_EXOI,.ORBERR)
 ....I 'ORBERR,$G(ORBLST)>0 D
 .....S OITXT=$P(^ORD(101.43,EXOI,0),U)
 .....S ORSDT=$P(^OR(100,EXORN,0),U,8),ORSDT=$$FMTE^XLFDT(ORSDT,"2P")
 .....D EN^ORB3(65,ORPT,EXORN,"","["_PTLOC_"] Order expiring: "_OITXT_" "_ORSDT,EXORN_"@") ;trigger Expiring Flagged OI - OUTPT notification
 ..;
 ..;is expiring order a med order:
 ..S RXORD=$$DGRX^ORQOR2(EXORN)
 ..I $L(RXORD) D  ;if expiring order is a med order
 ...;
 ...N DFN S DFN=ORPT
 ...D ADM^VADPT2
 ...;
 ...I (RXORD="OUTPATIENT MEDICATIONS")!(+$G(VADMVT)<1&(RXORD'="CLINIC ORDERS")) D
 ....D EN^ORB3(72,ORPT,EXORN,"","",EXORN_"@")  ;trigger outpt notif
 ...;
 ...Q:RXORD="OUTPATIENT MEDICATIONS"  ;quit if an outpt med
 ...Q:+$G(VADMVT)<1&(RXORD'="CLINIC ORDERS")  ;quit if an outpt
 ...;
 ...K VADMVT
 ...;
 ...;is schedule for the order a ONE TIME MED:
 ...S ONETIME=0
 ...I $D(ORBZ),(+$G(ORSCHFIL)=51.1) F ORBI=1:1:ORBZ D
 ....S ORSCH=$P(ORBZ(ORBI),U,2)
 ....I ORSCH=$$VALUE^ORCSAVE2(EXORN,"SCHEDULE") S ONETIME=1 Q
 ...Q:+$G(ONETIME)=1  ;quit if one time med
 ...;
 ...;check if this is an IMO order and what it is,send an M.E.-OUTPT alert
 ...I RXORD="CLINIC ORDERS" D  Q
 ....N ORDLG,ORDG,ORDLGNM,FLAG,ORX
 ....S FLAG=0
 ....S ORDLG=$P($G(^OR(100,EXORN,0)),U,5) Q:$P(ORDLG,";",2)'="ORD(101.41,"
 ....S ORDLGNM=$P($G(^ORD(101.41,+ORDLG,0)),U)
 ....S ORDG=$P($G(^ORD(101.41,+ORDLG,0)),U,2)
 ....I ORDLGNM="PSJ OR PAT OE"!(ORDLGNM="PSJI OR PAT FLUID OE") S FLAG=1
 ....I 'FLAG F ORX="INPATIENT MEDICATIONS","IV MEDICATIONS","UNIT DOSE MEDICATIONS","CLINIC ORDERS" I $$UPPER^ORU(ORDG)=ORX D
 .....S FLAG=1
 .....I ORX="IV MEDICATIONS",(+$$IVRENEW(EXORN)=0) S FLAG=0
 .....I ORX="UNIT DOSE MEDICATIONS",(+$$UDRENEW(EXORN,EXDT)=0) S FLAG=0
 ....I FLAG D EN^ORB3(72,ORPT,EXORN,"","",EXORN_"@")  ;trigger outpt notif
 ...;
 ...;quit if inpt/unit dose med and med is not renewable:
 ...I RXORD="UNIT DOSE MEDICATIONS",(+$$UDRENEW(EXORN,EXDT)=0) Q
 ...;
 ...;quit if IV med and med is not renewable:
 ...I RXORD="IV MEDICATIONS",(+$$IVRENEW(EXORN)=0) Q
 ...;
 ...D EN^ORB3(47,ORPT,EXORN,"","",EXORN_"@")  ;trigger notif
 S ^XTMP("ORB LAST EXPIRE",0)=$$FMADD^XLFDT(ORNOW,7,"","","")_U_$$NOW^XLFDT
 D EXCLN(ORNOW)
 Q
UDRENEW(EXORN,EXDT) ;extr function returns 1 if med is renewable, 0 if not
 N ORNOW,ORSLT,ORSTATUS
 S ORSLT=0
 S ORSTATUS=$P($$STATUS^ORQOR2(EXORN),U,2)
 I ORSTATUS="ACTIVE" Q 1  ;renewable if "active"
 I ORSTATUS="HOLD" Q 1   ;renewable if "on hold"
 I ORSTATUS="EXPIRED" D
 .S ORNOW=$$NOW^XLFDT
 .;renewable if expired w/in past 4 days:
 .I $$FMDIFF^XLFDT(ORNOW,EXDT,1)<4 S ORSLT=1
 Q ORSLT
 ;
IVRENEW(EXORN) ;extr function returns 1 if med is renewable, 0 if not
 N ORSLT,ORSTATUS
 S ORSLT=0
 S ORSTATUS=$P($$STATUS^ORQOR2(EXORN),U,2)
 I ORSTATUS="ACTIVE" Q 1   ;renewable if "active"
 I ORSTATUS="HOLD" Q 1   ;renewable if "on hold"
 I ORSTATUS="EXPIRED" Q 1  ;renewable if "expired"
 Q ORSLT
 ;
EXCLN(ORNOW) ;clean up old entires in ^XTMP("ORB LAST EXPIRE")
 N ORN,ORDT
 S ORN=1
 F  S ORN=$O(^XTMP("ORB LAST EXPIRE",ORN)) Q:ORN=""  D
 .S ORDT=$G(^XTMP("ORB LAST EXPIRE",ORN))
 .I $L(ORDT),(ORDT<ORNOW) D
 ..K ^XTMP("ORB LAST EXPIRE",ORN)
 Q
