ORY301 ; BP/TC - Pre-install routine for patch OR*3*301 ;09/10/08
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**301**;Dec 17, 1997;Build 12
 ;
PRE ; initiate pre-install process
 ; this process sets the Anatomic Pathology (AP) results notification
 ; to Mandatory at the User, Division, & System levels if defined.
 ;
 S (ERADDIV,ERADSYS)=""
 D CHG^XPAR("DIV","ORB PROCESSING FLAG","ANATOMIC PATHOLOGY RESULTS","MANDATORY",.ERRDIV)
 D CHG^XPAR("SYS","ORB PROCESSING FLAG","ANATOMIC PATHOLOGY RESULTS","MANDATORY",.ERRSYS)
 ; Parameter instance does not exist, add it.
 I $P(ERRDIV,U)="89895008" D ADD^XPAR("DIV","ORB PROCESSING FLAG","ANATOMIC PATHOLOGY RESULTS","MANDATORY",.ERADDIV)
 I $P(ERRSYS,U)="89895008" D ADD^XPAR("SYS","ORB PROCESSING FLAG","ANATOMIC PATHOLOGY RESULTS","MANDATORY",.ERADSYS)
 I $P(ERRDIV,U)="89895009"!($P(ERRSYS,U)="89895009")!($P(ERADDIV,U)="89895009")!($P(ERADSYS,U)="89895009") D MAIL  ; Filing error.
 I ERRDIV="" K ERRDIV
 I ERRSYS="" K ERRSYS
 I ERADDIV="" K ERADDIV
 I ERADSYS="" K ERADSYS
 N ORPAR,ORENT,ORINST,ORVAL S ORPAR="48",ORENT=0,ORINST=""
 F  S ORENT=$O(^XTV(8989.5,"AC",ORPAR,ORENT)) Q:ORENT=""  D  ;DBIA #2686
 .I ORENT["VA(200," F  S ORINST=$O(^XTV(8989.5,"AC",ORPAR,ORENT,ORINST)) Q:ORINST'>0  D
 ..S ORVAL=^XTV(8989.5,"AC",ORPAR,ORENT,ORINST) I ORINST="71"&((ORVAL="E")!(ORVAL="D")) D
 ...N ORPIEN S ORPIEN="",ORPIEN=$O(^XTV(8989.5,"AC",ORPAR,ORENT,ORINST,ORPIEN)) Q:ORPIEN=""
 ...N DIE,DA,DR S DIE="^XTV(8989.5,",DR="1///M",DA=ORPIEN D ^DIE K DIE,DA,DR
 K ORPAR,ORENT,ORINST,ORVAL,ORPIEN
 Q
 ;
MAIL ;
 ; setup, create, and send a mailman message to the installer
 ; instructing him/her on how to manually set the AP results
 ; notfication to Mandatory at the Division/System level in VistA when
 ; the pre-install process has failed.
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,ORTXT,I
 S XMDUZ="PATCH OR*3*301 PRE-INIT" S:$G(DUZ) XMY(DUZ)=""
 S I=0,I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="A filing error has occurred in the process of modifying the ORB PROCESSING FLAG"
 S I=I+1,^TMP($J,"ORTXT",I)="parameter and setting the ANATOMIC PATHOLOGY (AP) RESULTS notification to"
 S I=I+1,^TMP($J,"ORTXT",I)="MANDATORY at the Division & System levels programmatically.",I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="Attached are some instructions on how to manually change these parameter settings"
 S I=I+1,^TMP($J,"ORTXT",I)="in VistA. Please follow the below instructions to make this change."
 S I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="If the ANATOMIC PATHOLOGY RESULTS instance currently exists for this parameter"
 S I=I+1,^TMP($J,"ORTXT",I)="at the Division/System level, please follow these steps to change the value:"
 S I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="  1)In VistA, access the General Parameter Tools menu [XPAR MENU TOOLS]."
 S I=I+1,^TMP($J,"ORTXT",I)="  2)Select EP, Edit Parameter Values [XPAR EDIT PARAMETER]."
 S I=I+1,^TMP($J,"ORTXT",I)="  3)At the Select PARAMETER DEFINITION NAME: prompt, "
 S I=I+1,^TMP($J,"ORTXT",I)="    enter in ORB PROCESSING FLAG."
 S I=I+1,^TMP($J,"ORTXT",I)="  4)At the next prompt, select the Division (DIV)/System (SYS) level setting."
 S I=I+1,^TMP($J,"ORTXT",I)="  5)At the Select Notification: prompt, "
 S I=I+1,^TMP($J,"ORTXT",I)="    enter in ANATOMIC PATHOLOGY RESULTS."
 S I=I+1,^TMP($J,"ORTXT",I)="  6)At the next prompt, Notification: ANATOMIC PATHOLOGY RESULTS// hit enter."
 S I=I+1,^TMP($J,"ORTXT",I)="  7)At the next prompt, Value: Enabled// change this value to MANDATORY if it"
 S I=I+1,^TMP($J,"ORTXT",I)="    is not already set to so."
 S I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="If the ANATOMIC PATHOLOGY RESULTS instance DOES NOT currently exists for this"
 S I=I+1,^TMP($J,"ORTXT",I)="parameter at the Division/System level, please follow these steps to add this instance:"
 S I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="  1)In VistA, access the General Parameter Tools menu [XPAR MENU TOOLS]."
 S I=I+1,^TMP($J,"ORTXT",I)="  2)Select EP, Edit Parameter Values [XPAR EDIT PARAMETER]."
 S I=I+1,^TMP($J,"ORTXT",I)="  3)At the Select PARAMETER DEFINITION NAME: prompt, "
 S I=I+1,^TMP($J,"ORTXT",I)="    enter in ORB PROCESSING FLAG."
 S I=I+1,^TMP($J,"ORTXT",I)="  4)At the next prompt, select the Division (DIV)/System (SYS) level setting."
 S I=I+1,^TMP($J,"ORTXT",I)="  5)At the Select Notification: prompt, "
 S I=I+1,^TMP($J,"ORTXT",I)="    enter in ANATOMIC PATHOLOGY RESULTS."
 S I=I+1,^TMP($J,"ORTXT",I)="  6)Are you adding ANATOMIC PATHOLOGY RESULTS as a new Notification? Yes//"
 S I=I+1,^TMP($J,"ORTXT",I)="    at this prompt, select YES or hit enter."
 S I=I+1,^TMP($J,"ORTXT",I)="  7)At the next prompt, Notification: ANATOMIC PATHOLOGY RESULTS// hit enter."
 S I=I+1,^TMP($J,"ORTXT",I)="  8)At the Value: prompt, enter in MANDATORY."
 S I=I+1,^TMP($J,"ORTXT",I)="",XMTEXT="^TMP($J,""ORTXT"",",XMSUB="PATCH OR*3*301 Pre-init FAILED!"
 D ^XMD
 Q
