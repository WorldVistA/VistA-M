ORB3FUP2 ; slc/CLA - Routine to support notification follow-up actions ;6/28/00  12:00
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**31,64,88,112,243**;Dec 17, 1997;Build 242
RESULT ;STAT, orderer-flagged and site-flagged result follow-up
 ;determine what pkg to get report/results from then do RPTLAB or RPTRAD
 N ORBFILL S ORBFILL=$P($P(XQADATA,"|",2),"@",2)
 I ORBFILL["LR" D RPTLAB
 I ORBFILL["RA" D RPTRAD
 I ORBFILL["GMRC" D RPTCON
 Q
CSPN ;co-sign progress note(s) follow-up
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 I $G(ORENVIR)="GUI" ;entry pt to get notes req co-sign then quit
 ;joel rtn to display notes req co-signature and allow co-sign on vt
 ;if lm fup action completed D DEL^ORB3FUP1(.ORY,ORBXQAID)
 Q
USPN ;unsigned progress note(s) follow-up
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 I $G(ORENVIR)="GUI" ;entry pt to get unsigned notes then quit
 ;joel rtn to display notes req signature and allow signature on vt
 ;if lm fup action completed D DEL^ORB3FUP1(.ORY,ORBXQAID)
 Q
EXMED ;expiring med(s) follow-up
 K XQAKILL
 N ORPT,ORDG,ORBXQAID,ORY,ORBLMDEL
 S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;the FLG code for EXPIRING orders in ORQ1 is '5'
 I $G(ORENVIR)="GUI" D LIST^ORQOR1(.ORBY,ORPT,"RX",5,"","")
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .S ORDG=$$DG^ORQOR1("RX")  ;get Display Group ien
 .D EN^ORCB(ORPT,5,ORDG,.ORBLMDEL)
 .K ^TMP("ORR",$J)
 .Q:$G(ORBLMDEL)=1  ;if EN^ORCB rtns ORBLMDEL=1, alert was removed in LM
 .D EN^ORQ1(ORPT_";DPT(",ORDG,5,"","","",0,0)
 .S X="",X=$O(^TMP("ORR",$J,X)) Q:X=""  I +$G(^TMP("ORR",$J,X,"TOT"))<1 D
 ..D DEL^ORB3FUP1(.ORY,ORBXQAID)  ;if no more EXPIRING orders found, delete the alert
 .K X,^TMP("ORR",$J)
 Q
UVMED ;unverified med(s) follow-up
 K XQAKILL
 N ORPT,ORDG,ORBXQAID,ORY,ORBLMDEL,ORADT
 S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;the FLG code for UNVERIFIED (NURSE) orders in ORQ1 is '9'
 I $G(ORENVIR)="GUI" D LIST^ORQOR1(.ORBY,ORPT,"RX",9,"","")
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .S ORDG=$$DG^ORQOR1("RX")  ;get Display Group ien
 .D EN^ORCB(ORPT,9,ORDG,.ORBLMDEL)
 .K ^TMP("ORR",$J)
 .Q:$G(ORBLMDEL)=1  ;if EN^ORCB rtns ORBLMDEL=1, alert was removed in LM
 .;
 .;if user doesn't have ORELSE or ORMAS keys (can't verify),
 .;   delete user's alert after display:
 .I '$D(^XUSEC("ORELSE",DUZ)),('$D(^XUSEC("OREMAS",DUZ))) S XQAKILL=1 D DEL^ORB3FUP1(.ORY,ORBXQAID) Q
 .;
 .;get current admission date/time:
 .N DFN S DFN=ORPT,VA200="" D INP^VADPT
 .S ORADT=$P($G(VAIN(7)),U)
 .S ORADT=$S('$L($G(ORADT)):$$FMADD^XLFDT($$NOW^XLFDT,"-30"),1:ORADT)
 .;
 .;if no more UNVERIFIED MED orders found (within current admission or
 .; past 30 days), delete the alert:
 .D EN^ORQ1(ORPT_";DPT(",ORDG,9,"",ORADT,$$NOW^XLFDT,0,0)
 .S X="",X=$O(^TMP("ORR",$J,X)) Q:X=""  I +$G(^TMP("ORR",$J,X,"TOT"))<1 D
 ..D DEL^ORB3FUP1(.ORY,ORBXQAID)
 .K X,^TMP("ORR",$J),VA200,VAIN
 Q
UNVER ;unverified order(s) follow-up
 K XQAKILL
 N ORPT,ORDG,ORBXQAID,ORY,ORBLMDEL,ORADT
 S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;the FLG code for UNVERIFIED (NURSE) orders in ORQ1 is '9'
 I $G(ORENVIR)="GUI" D LIST^ORQOR1(.ORBY,ORPT,"ALL",9,"","")
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .S ORDG=$$DG^ORQOR1("ALL")  ;get Display Group ien
 .D EN^ORCB(ORPT,9,ORDG,.ORBLMDEL)
 .K ^TMP("ORR",$J)
 .Q:$G(ORBLMDEL)=1  ;if EN^ORCB rtns ORBLMDEL=1, alert was removed in LM
 .;
 .;if user doesn't have ORELSE or ORMAS keys (can't verify),
 .;   delete user's alert after display:
 .I '$D(^XUSEC("ORELSE",DUZ)),('$D(^XUSEC("OREMAS",DUZ))) S XQAKILL=1 D DEL^ORB3FUP1(.ORY,ORBXQAID) Q
 .;
 .;get current admission date/time:
 .N DFN S DFN=ORPT,VA200="" D INP^VADPT
 .S ORADT=$P($G(VAIN(7)),U)
 .S ORADT=$S('$L($G(ORADT)):$$FMADD^XLFDT($$NOW^XLFDT,"-30"),1:ORADT)
 .;
 .;if no more UNVERIFIED orders found (within current admission or past
 .; 30 days), delete the alert:
 .D EN^ORQ1(ORPT_";DPT(",ORDG,9,"",ORADT,$$NOW^XLFDT,0,0)
 .S X="",X=$O(^TMP("ORR",$J,X)) Q:X=""  I +$G(^TMP("ORR",$J,X,"TOT"))<1 D
 ..D DEL^ORB3FUP1(.ORY,ORBXQAID)
 .K X,^TMP("ORR",$J),VA200,VAIN
 Q
NEWCON ;new consult/request follow-up
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;I $G(ORENVIR)="GUI" D  ;comment out until GUI follow-up
 ;.entry pt to get new consults then quit
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .D EN^GMRCALRT(XQADATA,XQAID) ;display new c/r and allow action
 .;D DEL^ORB3FUP1(.ORY,ORBXQAID) ;Dwight does the delete in GMRC
 Q
UPCON ;updated consult/request follow-up
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .D EN^GMRCALRT(XQADATA,XQAID) ;display updated c/r and allow action
 Q
DCCON ;cancelled, held or DCed consult/request follow-up
 K XQAKILL
 N ORPT,NXQADATA
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;I $G(ORENVIR)="GUI" D  ;comment out until GUI follow-up
 ;.entry pt to get new consults then quit
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .I XQADATA["GMRC" S NXQADATA=$P($P(XQADATA,"|",2),"@") D EN^GMRCEDIT(NXQADATA,XQAID)
 .I +$G(NXQADATA)<1 D EN^GMRCEDIT(XQADATA,XQAID)
 Q
RPTCON ;consult result follow-up
 K XQAKILL
 N NXQADATA
 ;N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 ;S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 I $G(ORENVIR)="GUI" D DETAIL^ORQQCN(.ORBY,XQADATA)
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .D EN^GMRCALRT(XQADATA,XQAID)
 .;I XQADATA["GMRC" S NXQADATA=$P($P(XQADATA,"|",2),"@") D EN^GMRCALRT(NXQADATA,XQAID)
 .;I +$G(NXQADATA)<1 D EN^GMRCALRT(XQADATA,XQAID)
 .;D DEL^ORB3FUP1(.ORY,ORBXQAID) ;Dwight does the delete in GMRC
 Q
RPTAP ; AP lab result follow-up
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(ORBXQAID,";"),",",2)  ;get pt dfn from xqaid
 N ORACCNUM,ORDTSTKN S ORACCNUM=$P(XQADATA,U,2),ORDTSTKN=$P(XQADATA,U,3)
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .D EN1^ORCXPND(ORPT,ORACCNUM_"-"_ORDTSTKN,"LABS")
 .D DEL^ORB3FUP1(.ORY,ORBXQAID)
 Q
RPTLAB ;lab result follow-up
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 N ORDER,ORLAB S ORDER=$P(XQADATA,"@")
 I $G(ORENVIR)="GUI" D DETAIL^ORQQLR(.ORBY,ORPT,ORDER)
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .;S ORLAB=$$OETOLAB^ORQQLR1(ORDER)
 .;Q:'$L($G(ORLAB))
 .;D EN1^ORCXPND(ORPT,ORLAB,"LABS")  ;api used lab # pre-6/97
 .D EN1^ORCXPND(ORPT,ORDER,"LABS")
 .D DEL^ORB3FUP1(.ORY,ORBXQAID)
 Q
RPTRAD ;radiology result follow-up for HL7-triggered notifications
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 N INVDT,CASE S INVDT="",CASE=""
 ;XQADATA is different for HL7-triggered vs. radiology pkg triggered
 S INVDT=$P(XQADATA,"~",2),CASE=$P($P(XQADATA,"~",3),"@")
 I $G(ORENVIR)="GUI" D DETAIL^ORQQRA(.ORBY,ORPT,INVDT,CASE)
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .D EN1^ORCXPND(ORPT,INVDT_"-"_CASE,"XRAYS")
 .D DEL^ORB3FUP1(.ORY,ORBXQAID)
 Q
RPTRAD2 ;radiology result follow-up for radiology pkg-triggered notifications
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 N INVDT,CASE S INVDT="",CASE=""
 ;XQADATA is different for HL7-triggered vs. radiology pkg triggered
 S INVDT=$P(XQADATA,"~",1),CASE=$P(XQADATA,"~",2)
 I $G(ORENVIR)="GUI" D DETAIL^ORQQRA(.ORBY,ORPT,INVDT,CASE)
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .D EN1^ORCXPND(ORPT,INVDT_"-"_CASE,"XRAYS")
 .D DEL^ORB3FUP1(.ORY,ORBXQAID)
 Q
EXOI ;expiring flagged orderable items follow-up
 K XQAKILL
 N ORPT,ORDG,ORBXQAID,ORY,ORBLMDEL
 S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;the FLG code for EXPIRING orders in ORQ1 is '5'
 I $G(ORENVIR)="GUI" D LIST^ORQOR1(.ORBY,ORPT,"ALL",5,"","")
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .S ORDG=$$DG^ORQOR1("ALL")  ;get Display Group ien
 .D EN^ORCB(ORPT,5,ORDG,.ORBLMDEL)
 .K ^TMP("ORR",$J)
 .Q:$G(ORBLMDEL)=1  ;if EN^ORCB rtns ORBLMDEL=1, alert was removed in LM
 .D EN^ORQ1(ORPT_";DPT(",ORDG,5,"","","",0,0)
 .S X="",X=$O(^TMP("ORR",$J,X)) Q:X=""  I +$G(^TMP("ORR",$J,X,"TOT"))<1 D
 ..D DEL^ORB3FUP1(.ORY,ORBXQAID)  ;if no more EXPIRING orders found, delete the alert
 .K X,^TMP("ORR",$J)
 Q
INTCON ;consult interpretation follow-up
 K XQAKILL
 N NXQADATA
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .R !!?5,"This alert must be processed in the CPRS GUI.",X:10
 .K X
 Q
CHGRAD ;radiology follow-up for #67 Imaging Request Changed
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 I $G(ORENVIR)'="GUI" D
 .D MSG^ORB3FUP1
 .I $L($T(EN1^RAO7PC4))>0 D
 ..D EN1^RAO7PC4  ;display before and after change(s)
 ..D DEL^ORB3FUP1(.ORY,ORBXQAID)
 Q
INFODEL ;follow-up action to delete "informational" alerts
 K XQAKILL
 N ORY,ORBXQAID
 S ORBXQAID=XQAID
 D MSG^ORB3FUP1
 D DEL^ORB3FUP1(.ORY,ORBXQAID)
 Q
