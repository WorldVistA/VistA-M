ORB3FUP1 ; slc/CLA - Routine to support notification follow-up actions ; 4/8/08 9:32am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,64,74,105,139,243**;Dec 17, 1997;Build 242
 Q
TYPE(ORBY,ORXQAID) ; return notif follow-up action type
 N NIEN
 S NIEN=$P($P(ORXQAID,";"),",",3)
 S ORBY=$G(^ORD(100.9,NIEN,3))
 I ORBY="" S ORBY="INFO^"
 E  S ORBY=$P(ORBY,U,2)
 Q
GUI(ORBY,ORXQAID) ; Notification follow-up for GUI called via API: ORB FOLLOW-UP
 ; called by ORB FOLLOW-UP api:
 S ORENVIR="GUI"
 D PROCESS
 Q
PROCESS ; main process for notification follow-up
 ;ORXQAID = OR,dfn,nien;
 ;XQADATA = placer num^placer id;filler num^filler id
 ;XQAKILL = value of parameter ORB DELETE MECHANISM for notif in 100.9
 N ORPDIEN,ORN,ORDFN,ORSITE,ORFID,ORFIEN,ORKILL
 D GETACT^XQALERT(ORXQAID)  ;return follow-up action info
 ;Q:'($D(XQADATA))  Q:'($D(XQAID))
 ;Q:($P(XQAID,",")'="OR")
 ;call function rpc stored in xqarou with params from xqadata
 D @XQAROU
 K ORENVIR
 Q
MSG ; display msg re: alert being processed for non-GUI follow-up actions
 I $G(ORENVIR)'="GUI" D
 .I $L($G(XQX)) W !!,"Processing alert: ",$P(XQX,U,3) H 1.5
 Q
DEL(ORBY,XQAID,ORKILL) ; delete an alert
 N ORN
 S ORN=$P($P(XQAID,";"),",",3)
 I $G(ORKILL)=1!($G(ORKILL)=0) S XQAKILL=ORKILL
 I $G(XQAKILL)="" S XQAKILL=$$XQAKILL^ORB3F1(ORN)
 I $G(XQAKILL)="" S XQAKILL=1
 S ORBY="FALSE"
 I $L($G(XQAID)) D DELETE^XQALERT S ORBY="TRUE"
 K XQAKILL
 Q
CSORD ;co-sign order(s) follow-up
 K XQAKILL
 N ORPT,ORDG,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;the FLG code for orders requiring CO-SIGNATURE in ORQ1 is 'to be determined when ASU is available'
 D DEL(.ORY,XQAID)  ;until ASU is implemented, delete the alert and quit
 Q  ;quit until ASU is implemented
 ;I $G(ORENVIR)="GUI" D LIST^ORQOR1(.ORBY,ORPT,"ALL",???,"","")
 ;I $G(ORENVIR)'="GUI" D 
 ;.D MSG
 ;.S ORDG=$$DG^ORQOR1("ALL")  ;get Display Group ien
 ;.D EN^ORCB(ORPT,???,ORDG,???)
 ;.K ^TMP("ORR",$J)
 ;.D EN^ORQ1(ORPT_";DPT(",ORDG,???,"","","",0,0)
 ;.S X="",X=$O(^TMP("ORR",$J,X)) Q:X=""  I +$G(^TMP("ORR",$J,X,"TOT"))<1 D
 ;..D DEL(.ORY,ORBXQAID)  ;if no more orders req. co-sign, delete the alert
 ;.K ^TMP("ORR",$J)
 Q
EXDNR ;expiring dnr follow-up
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 N DNRORD,DNRY S DNRORD=$P(XQADATA,"@")
 I $G(ORENVIR)="GUI" D
 .S ORBY(1)=DNRY
 I $G(ORENVIR)'="GUI" D
 .D MSG
 .D EN1^ORCB(DNRORD,"RENEW")  ;display order, allow renewing, then delete
 .D DEL(.ORY,ORBXQAID)
 Q
UNLINKED ;unlinked provider follow-up
 K XQAKILL
 N ORPT,ORBXQAID,ORY S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 N ORNUM,ORUNY S ORNUM=$P(XQADATA,"@")
 I $G(ORENVIR)="GUI" D 
 .S ORBY(1)=ORUNY
 I $G(ORENVIR)'="GUI" D
 .D MSG
 .D EN1^ORCB(ORNUM,"REPLACE")  ;display order, allow replace, then delete
 .D DEL(.ORY,ORBXQAID)
 Q
FLORD ;flagged order(s) follow-up
 K XQAKILL
 N ORPT,ORDG,X,ORBXQAID,ORY,ORBLMDEL
 S ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;the FLG code for "FLAGGED" in ORQ1 is '12'
 I $G(ORENVIR)="GUI" D LIST^ORQOR1(.ORBY,ORPT,"ALL",12,"","")
 I $G(ORENVIR)'="GUI" D 
 .D MSG
 .S ORDG=$$DG^ORQOR1("ALL")  ;get Display Group ien
 .D EN^ORCB(ORPT,12,ORDG,.ORBLMDEL)
 .K ^TMP("ORR",$J)
 .Q:$G(ORBLMDEL)=1  ;if EN^ORCB rtns ORBLMDEL=1, alert was removed in LM
 .D EN^ORQ1(ORPT_";DPT(",ORDG,12,"","","",0,0)
 .S X="",X=$O(^TMP("ORR",$J,X)) Q:X=""  I +$G(^TMP("ORR",$J,X,"TOT"))<1 D
 ..D DEL(.ORY,ORBXQAID)  ;if no more flagged orders found, delete alert
 .K ^TMP("ORR",$J)
 Q
NEWORD ;new order(s) follow-up
 K XQAKILL
 N ORPT,ORDG,ORSDT,OREDT,ENT,X,ORBXQAID,ORY,ORBLMDEL
 S ORSDT="",OREDT="",ENT="USR",ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;the FLG code for NEW orders since last reviewed orders in ORQ1 is '6'
 I $G(ORENVIR)="GUI" D LIST^ORQOR1(.ORBY,ORPT,"ALL",6,"","")
 I $G(ORENVIR)'="GUI" D 
 .D MSG
 .S ORDG=$$DG^ORQOR1("ALL")  ;get Display Group ien
 .D EN^ORCB(ORPT,6,ORDG,.ORBLMDEL)
 .Q:$G(ORBLMDEL)=1  ;if EN^ORCB rtns ORBLMDEL=1, alert was removed in LM
 .D DEL(.ORY,ORBXQAID) ;delete the alert
 Q
DCORD ;DC order(s) follow-up
 K XQAKILL
 N ORPT,ORDG,ORSDT,OREDT,ENT,X,ORBXQAID,ORY,ORBLMDEL
 S ORSDT="",OREDT="",ENT="USR",ORBXQAID=XQAID
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;the FLG code for DC orders is '3'
 I $G(ORENVIR)="GUI" D LIST^ORQOR1(.ORBY,ORPT,"ALL",6,"","")
 I $G(ORENVIR)'="GUI" D 
 .D MSG
 .S ORDG=$$DG^ORQOR1("ALL")  ;get Display Group ien
 .D EN^ORCB(ORPT,6,ORDG,.ORBLMDEL)
 .Q:$G(ORBLMDEL)=1  ;if EN^ORCB rtns ORBLMDEL=1, alert was removed in LM
 .D DEL(.ORY,ORBXQAID) ;delete the alert
 Q
NUMORD ;detailed order display follow-up - return order number
 K XQAKILL
 N ORBXQAID,ORY S ORBXQAID=XQAID
 S ORNUM=$P(XQADATA,"@")
 I $G(ORENVIR)="GUI" D
 .Q
 I $G(ORENVIR)'="GUI" D
 .D MSG
 .D EN1^ORCB(+ORNUM,"NEW")  ;display order, allow new order then delete
 .D DEL(.ORY,ORBXQAID)
 Q
ESORD ;order(s) requiring electronic signature follow-up
 K XQAKILL
 N ORPT,ORDG,ORBXQAID,ORY,ORX,ORZ,ORDERS,ORDNUM,ORQUIT,ORBLMDEL
 S ORBXQAID=XQAID,ORDERS=0,ORQUIT=0
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 ;the FLG code for UNSIGNED orders in ORQ1 is '11'
 I $G(ORENVIR)="GUI" D LIST^ORQOR1(.ORBY,ORPT,"ALL",11,"","")
 I $G(ORENVIR)'="GUI" D 
 .D MSG
 .S ORDG=$$DG^ORQOR1("ALL")  ;get Display Group ien
 .D EN^ORCB(ORPT,11,ORDG,.ORBLMDEL)
 .K ^TMP("ORR",$J)  ;clean up array
 .Q:$G(ORBLMDEL)=1  ;if EN^ORCB rtns ORBLMDEL=1, alert was removed in LM
 .I $L($G(XQAID)) D  ;EN^ORCB may kill XQAID in its follow-up
 ..;
 ..;get unsigned orders - if none exist, delete alert then quit:
 ..D EN^ORQ1(ORPT_";DPT(",ORDG,11,"","","",0,0)
 ..S ORX="",ORX=$O(^TMP("ORR",$J,ORX)) Q:ORX=""  I +$G(^TMP("ORR",$J,ORX,"TOT"))<1 D DEL(.ORY,ORBXQAID) K ^TMP("ORR",$J) Q
 ..;
 ..;user does not have ORES key, delete user's alert:
 ..I '$D(^XUSEC("ORES",DUZ)) S XQAKILL=1 D DEL(.ORY,ORBXQAID) K ^TMP("ORR",$J) Q
 ..;
 ..;if prov is NOT linked to pt via attending, primary, teams or PCMM:
 ..I $$PPLINK^ORQPTQ1(DUZ,ORPT)=0 D
 ...S ORX="" F  S ORX=$O(^TMP("ORR",$J,ORX)) Q:ORX=""!(ORDERS=1)  D
 ....S ORZ="" F  S ORZ=$O(^TMP("ORR",$J,ORX,ORZ)) Q:ORZ=""!(ORDERS=1)  D
 .....S ORDNUM=^TMP("ORR",$J,ORX,ORZ)
 .....;quit if this unsigned order's last action was made by the user
 .....I DUZ=+$$UNSIGNOR^ORQOR2(ORDNUM) S ORDERS=1
 ...I ORDERS'=1 D  ;provider has no outstanding unsiged orders for pt
 ....S XQAKILL=1 D DEL(.ORY,ORBXQAID) ;delete alert for this user
 ..K ^TMP("ORR",$J)
 Q
UNFLAG(ORPT) ;order unflagged - delete alert if no more flagged orders
 N ORDG,ORDOIT,ORQUIT,X,XQAID,XQAKILL,XQAUSER
 S ORDOIT=1,ORQUIT=0
 S ORDG=$$DG^ORQOR1("ALL")  ;get Display Group ien
 K ^TMP("ORR",$J)
 D EN^ORQ1(ORPT_";DPT(",ORDG,12,"","","",0,0)
 ;========DELETE ALERT (FOR ALL USERS) IF NO FLAGGED ORDERS AT ALL=====
 S X="",X=$O(^TMP("ORR",$J,X)) Q:X=""  I +$G(^TMP("ORR",$J,X,"TOT"))<1 D
 .;if no more flagged orders found, delete alert:
 .S XQAKILL=$$XQAKILL^ORB3F1(6)
 .I $G(XQAKILL)="" S XQAKILL=1
 .S XQAID="OR,"_ORPT_",6" D DELETEA^XQALERT K XQAID,XQAKILL S ORQUIT=1
 Q:ORQUIT
 ;========DELETE ALERT IF NO FLAGGED ORDERS LEFT RELATED TO THE USER THAT IS UNFLAGGING=====
 S X="",X=$O(^TMP("ORR",$J,X)) Q:X=""  D
 .N Y S Y="" F  S Y=$O(^TMP("ORR",$J,X,Y)) Q:'Y  D
 ..N ORDER S ORDER=$G(^TMP("ORR",$J,X,Y))
 ..I $$FLAGRULE^ORWORR1(+ORDER)=0 S ORDOIT=0 ; FOUND A FLAGGED ORDER THAT THE USER SHOULD GET
 I ORDOIT D
 .;if no more flagged orders found for this user, delete alert only for this user:
 .S XQAKILL=1
 .S XQAID="OR,"_ORPT_",6" D DELETEA^XQALERT K XQAID,XQAKILL
 ;========DELETE ALERT IF NO FLAGGED ORDERS LEFT RELATED TO THE USER THAT WAS THE ALERTED PROVIDER OF THE CURRENT ORDER=====
 S ORDOIT=1
 ;get the alerted provider
 I $G(ORIFN) D
 .N ORD,ORACT S ORD=+$G(ORIFN),ORACT=$P($G(ORIFN),";",2)
 .N ORUSR S ORUSR=$P($G(^OR(100,ORD,8,ORACT,3)),U,9)
 .I ORUSR D
 ..S X="",X=$O(^TMP("ORR",$J,X)) Q:X=""  D
 ...N Y S Y="" F  S Y=$O(^TMP("ORR",$J,X,Y)) Q:'Y  D
 ....N ORDER S ORDER=$G(^TMP("ORR",$J,X,Y))
 ....I $$FLAGRULE^ORWORR1(+ORDER,ORUSR)=0 S ORDOIT=0 ; FOUND A FLAGGED ORDER THAT THE USER SHOULD GET
 ..I ORDOIT D
 ...;if no more flagged orders found for this user, delete alert only for this user:
 ...S XQAKILL=1,XQAUSER=ORUSR
 ...S XQAID="OR,"_ORPT_",6" D DELETEA^XQALERT K XQAID,XQAKILL,XQAUSER
 K ^TMP("ORR",$J)
 Q
