ORQQXQA ; slc/CLA - Functions which return patient/user alert and mailman data ;5/27/98
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9**;Dec 17, 1997
ALLPAT(ORY,ORPT) ;return all patient's alerts regardless of recipient
 N STRTDATE,STOPDATE S STRTDATE="",STOPDATE=""
 D PATIENT^XQALERT("^TMP(""ORB"",$J)",ORPT,STRTDATE,STOPDATE)
 N ORX,ORTOT
 S ORTOT=^TMP("ORB",$J)
 I ORTOT=0 S ORY(1)="^No notifications found."
 E  F I=1:1:ORTOT S ORX=$P(^TMP("ORB",$J,I),U,2) I $P(ORX,";")["OR" D
 .S ORY(I)=ORX_U_$P(^TMP("ORB",$J,I),U)_U_$P($P(ORX,";"),",",2)
 K ^TMP("ORB",$J),I
 Q
PATIENT(ORY,ORPT) ;return current user's notifications for patient ORPT
 Q:'$L($G(ORPT))
 N STRTDATE,STOPDATE S STRTDATE="",STOPDATE=""
 D USER^XQALERT("^TMP(""ORB"",$J)",DUZ,STRTDATE,STOPDATE)
 N I,J,INFO,ORX,URG,ORN,ORPTN,SORT,SVAL,TVAL,MSG,ORNAME,INVDT,PT,NODE,ORT
 N ORTOT
 S ORTOT=^TMP("ORB",$J)
 S J=0,NODE="",TVAL=""
 F I=1:1:ORTOT S ORX=$P(^TMP("ORB",$J,I),U,2) I ($P(ORX,";")["OR"),($P(ORX,",",2)=ORPT) D
 .S ORN=$P($P(ORX,";"),",",3)
 .S INVDT=9999999-$P(ORX,";",3)
 .D SORT^ORQORB(.SORT) S SORT=$S($L($G(SORT)):SORT,1:"P") ;sort method
 .I SORT'="P" D 
 ..D URGENCY^ORQORB(.URG,ORN) S URG=$S($G(URG)>0:URG,1:2)
 ..S ORNAME=$P(^ORD(100.9,ORN,0),U)
 .S INFO=$P(^TMP("ORB",$J,I),"  ")
 .S MSG=$S(INFO="I":INFO,1:" ")_" "_$P($P(^TMP("ORB",$J,I),U),"):",2)
 .I SORT="U" S SVAL=URG_U_ORNAME
 .I SORT="T" S SVAL=ORNAME
 .I SORT="P" S SVAL=""
 .S ^TMP("ORB2",$J,SVAL_U_INVDT)=ORX_U_MSG_U_ORPT_U_$P(ORX,";",3)
 F  S NODE=$O(^TMP("ORB2",$J,NODE)) Q:NODE=""  S J=J+1 D
 .S SVAL=$P(NODE,U)
 .I SORT'="P",(TVAL'=SVAL) D
 ..S ORY(J)=U_$S(SORT="U":$S(SVAL=1:"HIGH",SVAL=3:"LOW",1:"MODERATE"),1:SVAL)_":",TVAL=SVAL,J=J+1
 .S ORY(J)=^TMP("ORB2",$J,NODE)
 I J=0 S ORY(1)="^No notifications found."
 K ^TMP("ORB",$J),^TMP("ORB2",$J)
 Q
USER(ORY) ;return current user's notifications across all patients
 N STRTDATE,STOPDATE S STRTDATE="",STOPDATE=""
 D USER^XQALERT("^TMP(""ORB"",$J)",DUZ,STRTDATE,STOPDATE)
 N I,J,INFO,ORX,URG,ORN,ORNAME,ORPT,ORPTN,SORT,SVAL,TVAL,SVAL2,TVAL2
 N MSG,NODE,ORT,ORTOT,INVDT
 S NODE="",TVAL="",TVAL2=""
 D SORT^ORQORB(.SORT) S SORT=$S($L($G(SORT)):SORT,1:"P") ;sort method
 S ORTOT=^TMP("ORB",$J)
 F I=1:1:ORTOT S ORX=$P(^TMP("ORB",$J,I),U,2) I $P(ORX,";")["OR" D
 .S ORN=$P($P(ORX,";"),",",3) ;type of notification (ien)
 .S ORPT=$P($P(ORX,";"),",",2) ;DFN
 .S INVDT=9999999-$P(ORX,";",3) ;reverse d/t
 .D URGENCY^ORQORB(.URG,ORN) S URG=$S($G(URG)>0:URG,1:2) ;urgency of notification type
 .S ORNAME=$P(^ORD(100.9,ORN,0),U) ;name of notification type (external)
 .S ORPTN=$$LOWER^VALM1($P(^DPT(ORPT,0),U)) ;change patient's name to mixed case
 .S INFO=$P(^TMP("ORB",$J,I),"  ")
 .S MSG=$S(INFO="I":INFO,1:" ")_" "_$P($P(^TMP("ORB",$J,I),U),"):",2)
 .;sorting
 .I SORT="U" S SVAL=URG_U_ORPTN_U_ORNAME ;by urgency
 .I SORT="T" S SVAL=ORNAME_U_ORPTN ;by type
 .I SORT="P" S SVAL=ORPTN_U_URG_U_ORNAME ;by patient
 .;below is set to:  XQAID^  notification name^DFN^date/time
 .S ^TMP("ORB2",$J,SVAL_U_INVDT)=ORX_U_"  "_MSG_U_ORPT_U_$P(ORX,";",3)
 S J=0
 F  S NODE=$O(^TMP("ORB2",$J,NODE)) Q:NODE=""  S J=J+1 D
 .S SVAL=$P(NODE,U),SVAL2=$P(NODE,U,2)
 .;set sorting heading
 .I TVAL'=SVAL D
 ..S ORY(J)=U_$S(SORT="U":$S(SVAL=1:"HIGH",SVAL=3:"LOW",1:"MODERATE"),1:SVAL)_":",TVAL=SVAL,TVAL2="",J=J+1
 .I SORT'="P",TVAL2'=SVAL2 S ORY(J)=U_"  "_SVAL2,TVAL2=SVAL2,J=J+1
 .;set to alert information to return
 .S ORY(J)=^TMP("ORB2",$J,NODE)
 I J=0 S ORY(1)="^No notifications found."
 K ^TMP("ORB",$J),^TMP("ORB2",$J)
 Q
MAILG(ORY) ; return mail groups in a system
 N ORI S ORI=1
 ;DIC access to MAIL GROUPS FILE [#3.8] granted via DBIA #10111
 D LIST^DIC(3.8,"","","","","","","","","","ORBMG($J)")
 F ORI=1:1:$P(ORBMG($J,"DILIST",0),U) S ORY(ORI)=ORBMG($J,"DILIST",2,ORI)_U_ORBMG($J,"DILIST",1,ORI)
 D CLEAN^DILF
 K ORBMG
 Q
