ORB3USER ; slc/CLA - Alert recipient algorithms for OE/RR 3 notifications; 1/19/00 14:45 [8/16/05 9:53am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**74,91,105,139,200,220**;Dec 17, 1997
USER(XQA,ORBDUZ,ORN,ORBU,ORBUI,ORBDFN,ORNUM) ;called from ORB3
 ;check to see if potential recip (ORBDUZ) should be an alert recip
 ;XQA     array of alert recips passed to Kernel Alert Utility
 ;ORBDUZ  duz of current potential alert recipient
 ;ORN     notif ien from file 100.9
 ;ORBU    array of info for utility displaying recip who and why
 ;ORBUI   counter for utility array
 ;ORBDFN  patient ien from Patient file [#2]
 ;ORNUM   order number to base division params on[optional]
 ;
 N ORBNODE,ORBSUR,ORBTM,ORBTMF,ORBTEAM,ORBON,ORBDUP
 I $G(ORBDUZ)["G." S XQA(ORBDUZ)="" Q
 Q:+$G(ORBDUZ)<.5
 ;
 S ORBTM=$P(ORBDUZ,U,2) I $L(ORBTM) D  ;if user recip via team
 .S ORBTMF=$$GET^XPAR(ORBTM_";OR(100.21,","ORB PROCESSING FLAG",ORN,"I")
 .S ORBTEAM=ORBTMF_U_$P(^OR(100.21,ORBTM,0),U)
 .I $D(ORBU) D
 ..S ORBU(ORBUI)="   User "_$P(^VA(200,+ORBDUZ,0),U)_" is a potential recipient via team "_$P(ORBTEAM,U,2),ORBUI=ORBUI+1
 ;
 I '$D(ORBU) D
 .I $L($G(ORBTMF))=0 D
 ..S:$D(^XTMP("ORBUSER",$J,+ORBDUZ)) ORBDUP=1
 ..S ^XTMP("ORBUSER",$J,+ORBDUZ)=""
 Q:$G(ORBDUP)=1  ;quit if user already processed and no team param value
 ;
 S ORBDUZ=$P(ORBDUZ,U)
 ;
 S:$G(ORBTEAM)="" ORBTEAM="^"
 S ORBON=$$ONOFF(ORN,ORBDUZ,ORBDFN,ORBTEAM,$G(ORNUM))
 I $D(ORBU) D
 .S ORBNODE=$G(^VA(200,ORBDUZ,0)) I $L($G(ORBNODE)) D
 ..S ORBU(ORBUI)="   "_$P(ORBNODE,U)_": "_$P(ORBON,U)_" because ",ORBUI=ORBUI+1
 ..S ORBU(ORBUI)="     "_$P(ORBON,U,2),ORBUI=ORBUI+1
 I $D(ORBU),($P(ORBON,U)="ON"),($G(ORBDUZ)'["G.") D
 .S ORBSUR=$$ACTVSURO^XQALSURO(ORBDUZ)  ;DBIA 2790 Alert surrogate
 .I +$G(ORBSUR)>0 D
 ..S ORBU(ORBUI)="     [Surrogate "_$$GET1^DIQ(200,ORBSUR_",",.01)_" will receive alert for user]",ORBUI=ORBUI+1
 Q:$P(ORBON,U)="OFF"  ;quit if user is disabled for this notif
 Q:$D(ORBU)           ;quit if entered rtn via UTL (do not sent alert)
 D PREALERT(ORBDUZ,ORN,ORBDFN)  ;if user has undel prev alert, delete it
 S XQA(ORBDUZ)=""  ;send alert to the user
 Q
 ;
PREALERT(ORBDUZ,ORN,ORBDFN) ;if user (ORBDUZ) has an undeleted previous
 ;version of this alert (ORN) for patient (ORBDFN), delete it
 ;
 Q:$P(^ORD(100.9,ORN,0),U,4)'="NOT"  ;quit if not a "NOT" notif/alert
 N XQAID,XQAKILL,XQAUSER,ORBDT
 S XQAID="OR,"_ORBDFN_","_ORN
 I $D(^XTV(8992,"AXQAN",XQAID,ORBDUZ)) D  ;DBIA# 2689
 .S ORBDT=0,ORBDT=$O(^XTV(8992,"AXQAN",XQAID,ORBDUZ,ORBDT))
 .I $G(ORBDT)>0 D
 ..S XQAUSER=ORBDUZ
 ..S XQAKILL=1
 ..D DELETEA^XQALERT
 Q
 ;
ONOFF(ORN,ORBUSR,ORBPT,ORBTEAM,ORNUM) ;Extrinsic function to check param file
 ;determines if user ORBUSR should receive notification ORN for patient
 ;patient ORBPT. If ORBUSR was derived via teams, ORBTEAM may be used.
 ;ORN      notification ien from file 100.9 (req'd)
 ;ORBUSR   user ien from file 200 (req'd)
 ;ORBPT    patient ien from file 2 (not req'd)
 ;ORBTEAM  processing flag^name for team assoc. w/ORBUSR (not req'd)
 ;ORNUM    order number to base division params on (not req'd)
 N NODE,ORBPTN,ORBNOTN,ORBUSRF,ORBUSRN,ORBLOC,ORBLOCF,ORBLOCN
 S (ORBPTN,ORBNOTN,ORBUSRF,ORBUSRN,ORBLOC,ORBLOCF,ORBLOCN)=""
 N ORBSRV,ORBSRVF,ORBSRVN,ORBTEA,ORBTEAF,ORBTEAN,ORBTEAD,ORBTEAE
 S (ORBSRV,ORBSRVF,ORBSRVN,ORBTEA,ORBTEAF,ORBTEAN,ORBTEAD,ORBTEAE)=""
 N ORBCLS,ORBCLSF,ORBCLSN,ORBLST,ORBI
 S (ORBCLS,ORBCLSF,ORBCLSN)=""
 N ORBDIV,ORBDIVF,ORBDIVN,ORBSYSF,ORBPKGF
 S (ORBDIV,ORBDIVF,ORBDIVN,ORBSYSF,ORBPKGF)=""
 ;
 ;get notification name:
 S NODE=$G(^ORD(100.9,ORN,0)) S:$L($G(NODE)) ORBNOTN=$P(NODE,U)
 ;
 ;get user name:
 S NODE=$G(^VA(200,ORBUSR,0)) S:$L($G(NODE)) ORBUSRN=$P(NODE,U)
 ;
 ;get patient name:
 S:$L($G(ORBPT)) NODE=$G(^DPT(ORBPT,0)) S:$L($G(NODE)) ORBPTN=$P(NODE,U)
 ;
 ;get division flag and name:
 S ORBDIV=$$DIVF(ORBUSR,ORN,$G(ORNUM))
 I $L(ORBDIV) D
 .S ORBDIVF=$P(ORBDIV,U,2),ORBDIV=$P(ORBDIV,U),NODE=$G(^DIC(4,ORBDIV,0))
 .S:$L($G(NODE)) ORBDIVN=$P(NODE,U)
 ;
 ;get system flag:
 S ORBSYSF=$$GET^XPAR("SYS","ORB PROCESSING FLAG",ORN,"I")
 ;
 ;get OE/RR package-export flag:
 S ORBPKGF=$$GET^XPAR("PKG","ORB PROCESSING FLAG",ORN,"I")
 ;
 ;get patient's location flag (INPATIENT ONLY - outpt locations cannot be
 ;reliably determined, and many simultaneous outpt locations can occur):
 I +$G(ORBPT)>0 D
 .N DFN S DFN=ORBPT,VA200="" D OERR^VADPT
 .S ORBLOC=+$G(^DIC(42,+VAIN(4),44)) I +$G(ORBLOC)>0 D
 ..S ORBLOCN=$P(^SC(+ORBLOC,0),U)
 ..S ORBLOCF=$$GET^XPAR(+$G(ORBLOC)_";SC(","ORB PROCESSING FLAG",ORN,"I")
 K VA200,VAIN
 ;
 ;get user's service/section flag:
 S ORBSRV=$G(^VA(200,ORBUSR,5)) I +ORBSRV>0 S ORBSRV=$P(ORBSRV,U) D
 .S NODE=$G(^DIC(49,ORBSRV,0)) S:$L($G(NODE)) ORBSRVN=$P(NODE,U)
 .S:+$G(ORBSRV)>0 ORBSRVF=$$GET^XPAR(ORBSRV_";DIC(49,","ORB PROCESSING FLAG",ORN,"I")
 ;
 ;get user's team flag:
 I $L($G(ORBTEAM)) S ORBTEAF=$P(ORBTEAM,U),ORBTEAN=$P(ORBTEAM,U,2)
 ;
 ;get class flag for the user's most recently active ASU class
 ;S ORBCLS=$$RECENT(ORBUSR) I $L($G(ORBCLS))>0 D
 ;.S ORBCLSN=$P(ORBCLS,U,2),ORBCLS=$P(ORBCLS,U)
 ;.S:+$G(ORBCLS)>0 ORBCLSF=$$GET^XPAR(ORBCLS_";USR(8930,","ORB PROCESSING FLAG",ORN,"I")
 ;
 ;get user's flag:
 S ORBUSRF=$$GET^XPAR(ORBUSR_";VA(200,","ORB PROCESSING FLAG",ORN,"I")
 ;
 ;determine overall flag:
 I $G(ORBUSRF)="M" Q "ON^User "_ORBUSRN_" is Mandatory.^User value is Mandatory"
 I $G(ORBUSRF)="E" Q "ON^User "_ORBUSRN_" is Enabled.^User value is Enabled"
 ;I $G(ORBCLSF)="M" Q "ON^User's class "_ORBCLSN_" is Mandatory.^User's class "_ORBCLSN_" value is Mandatory"
 I $G(ORBTEAF)="M" Q "ON^User's team "_ORBTEAN_" is Mandatory.^User's team "_ORBTEAN_" value is Mandatory"
 I $G(ORBTEAF)="D" Q "OFF^User's team "_ORBTEAN_" is Disabled.^User's team "_ORBTEAN_" value is Disabled"
 I $G(ORBSRVF)="M" Q "ON^User's service "_ORBSRVN_" is Mandatory.^User's service "_ORBSRVN_" value is Mandatory"
 I $G(ORBLOCF)="M" Q "ON^Patient's location "_ORBLOCN_" is Mandatory.^Pt's location "_ORBLOCN_" value is Mandatory"
 I $G(ORBLOCF)="D" Q "OFF^Patient's location "_ORBLOCN_" is Disabled.^Pt's location "_ORBLOCN_" value is Disabled"
 I $G(ORBDIVF)="M",($G(ORBLOCF)="") Q "ON^Division "_ORBDIVN_" is Mandatory, no Pt Location value.^Division "_ORBDIVN_" value is Mandatory"
 I $G(ORBSYSF)="M",($G(ORBDIVF)=""),($G(ORBLOCF)="") Q "ON^System default is Mandatory, no Division or Pt Location values.^System value is Mandatory"
 I $G(ORBPKGF)="M",($G(ORBSYSF)=""),($G(ORBDIVF)=""),($G(ORBLOCF)="") Q "ON^OERR default is Mandatory, no Division, System, or Pt Location values.^OERR value is Mandatory"
 I $G(ORBUSRF)="D" Q "OFF^User "_ORBUSRN_" is Disabled - no Mandatory values found.^User value is Disabled"
 ;I $G(ORBCLSF)="D" Q "OFF^User's class "_ORBCLSN_" is Disabled - no Mandatory values found.^User's class "_ORBCLSN_" value is Disabled""
 I $G(ORBTEAF)="E" Q "ON^User's team "_ORBTEAN_" is Enabled.^User's team "_ORBTEAN_" value is Enabled"
 I $G(ORBSRVF)="D" Q "OFF^User's service "_ORBSRVN_" is Disabled.^User's service "_ORBSRVN_" value is Disabled"
 I $G(ORBSRVF)="E" Q "ON^User's service "_ORBSRVN_" is Enabled.^User's service "_ORBSRVN_" value is Enabled"
 I $G(ORBLOCF)="E" Q "ON^Patient's location "_ORBLOCN_" is Enabled.^Pt's location "_ORBLOCN_" value is Enabled"
 I $G(ORBDIVF)="D" Q "OFF^Division "_ORBDIVN_" is Disabled.^Division "_ORBDIVN_" value is Disabled"
 I $G(ORBDIVF)="E" Q "ON^Division "_ORBDIVN_" is Enabled.^Division "_ORBDIVN_" value is Enabled"
 I $G(ORBSYSF)="D" Q "OFF^System default is Disabled.^System value is Disabled"
 I $G(ORBSYSF)="E" Q "ON^System default is Enabled.^System value is Enabled"
 I $G(ORBPKGF)="D" Q "OFF^OERR default is Disabled.^OERR value is Disabled"
 I $G(ORBPKGF)="E" Q "ON^OERR default is Enabled.^OERR value is Enabled"
 Q "OFF^No Mandatory, Disabled or Enabled values found.^No Mandatory/Disabled/Enabled values"
 ;
RECENT(USER) ;ext funct rtns a user's most recent, active user class
 Q:+$G(USER)<1 "^Error: User not identified."
 N CLS,CLASS,INACT,ACT,ORX,INVDT,RESULT
 ;call api to determine user's class(es)
 Q:'$L($G(CLS(0))) "^No user classes found."
 D NOW^%DTC
 S CLASS="" F  S CLASS=$O(CLS(CLASS)) Q:CLASS=""  D
 .S INACT=$P(CLS(CLASS),U,5),ACT=$P(CLS(CLASS),U,4)
 .I INACT,(INACT<%) Q  ;quit if class has an inactive date before now
 .Q:'ACT     ;quit if class has no active date
 .S ORX("DT",9999999-ACT)=$P(CLS(CLASS),U)_U_CLASS
 S INVDT="",INVDT=$O(ORX("DT",INVDT))
 I INVDT S RESULT=ORX("DT",INVDT)
 E  S RESULT="^No user classes found."
 K %
 Q RESULT
DIVF(USER,ORN,ORNUM) ;ext funct rtns user's division value for ORB PROCESSING FLAG
 N DIV,DIVF,MDIVF,EDIVF,DDIVF
 I +$G(ORNUM) D  Q DIVF
 .S DIVF=""
 .S DIV=$$ORDIV^ORB31(ORNUM)
 .I +$G(DIV)'>0 Q
 .S DIVF=$$GET^XPAR(DIV_";DIC(4,","ORB PROCESSING FLAG",ORN,"I")
 .I $L(DIVF) S DIVF=DIV_U_DIVF
 S DIV=0,(DIVF,MDIVF,EDIVF,DDIVF)=""
 F  S DIV=$O(^VA(200,USER,2,"B",DIV)) Q:+$G(DIV)<1!(DIVF="M")  D
 .S DIVF=$$GET^XPAR(DIV_";DIC(4,","ORB PROCESSING FLAG",ORN,"I")
 .I DIVF="M" S MDIVF=DIV_U_DIVF
 .I DIVF="E" S EDIVF=DIV_U_DIVF
 .I DIVF="D" S DDIVF=DIV_U_DIVF
 Q:$L(MDIVF) MDIVF
 Q:$L(EDIVF) EDIVF
 Q:$L(DDIVF) DDIVF
 Q ""
