MAGUSIT ;WOIFO/SRR/RMP - IMAGE SITE PARAMETERS COMPANION [ 06/29/2001 18:28 ]
 ;;3.0;IMAGING;**3,8,20**;Apr 12, 2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
INI ;
 N NAME,D0,MAGDA,CNMSP,PLACE
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 I $D(^MAG(2006.1,PLACE,0)),$L($P(^(0),U,2))=3 Q
 S NAME=$$KSP^XUPARAM("WHERE")
 I NAME[".MED" S NAME=$P(NAME,".MED",1)_$P(NAME,".MED",2)
 S MAGDA=$O(^MAG(2006.19,"B",NAME,""))
 S FN=$S('MAGDA:$$UNDEF(NAME),1:$P($G(^MAG(2006.19,MAGDA,0)),U,4))
 I FN="" D LNOIS Q
 D PNMSP(PLACE,FN)
 Q
PNMSP(PLACE,FN) ;
 S CNMSP=$P(^MAG(2006.1,PLACE,0),U,2)
 I $L(CNMSP)>0 D  ;UPDATE MULTI NAMESPACE
 . K DIE,DINUM,FDA,DIERR
 . S FDA(2006.11,"+1,"_PLACE_",",.01)=CNMSP
 . D UPDATE^DIE("U","FDA")
 . K FDA Q
 I $D(DIERR) D LNOIS Q
 D BMES^XPDUTL("Imaging SITE is: "_NAME_" Namespace: "_FN)
 K FDA,DIE,DINUM,DIERR
 S FDA(2006.1,PLACE_",",.02)=FN
 D UPDATE^DIE("U","FDA")
 K FDA
 I $D(DIERR) D LNOIS
 Q
LNOIS ;
 D BMES^XPDUTL(" Contact the National Help desk to update a namespace!") Q
UNDEF(NAME) ;The domain is undefined in the Image site file (2006.19)
 N ASK,Y,FN
 S DIR("A")="Enter the type of account"
 S DIR("?")="Enter either T for a test account or P for a production account",DIR("B")="T"
 S DIR(0)="S0^T:Test;P:PRODUCTION"
 D ^DIR S ASK=Y
 K DIR
 I ASK="T" S FN="ZZT"
 I ASK="P" D
 . S FN=$$ONE^MAGQAI(NAME)
 . D UI(NAME,FN) ;MAIL MESSAGE TO LAVC-SERVER/IMAGE DEVELOPERS
 Q FN
EXIT ;EXIT
 K DIC,DIE,DA,DR,MAM,NET,WORK
 Q
UI(DOMAIN,INIT) ;UPDATE IMAGING DISTRIBUTION
 N Y,LOC
 D NOW^%DTC S Y=% D DD^%DT
 S LOC=$$KSP^XUPARAM("WHERE")
 S ^TMP($J,"MAGQ",1)="            SITE: "_LOC
 S ^TMP($J,"MAGQ",2)="            DATE: "_Y_" "_$G(^XMB("TIMEZONE"))
 S ^TMP($J,"MAGQ",3)="          DOMAIN: "_DOMAIN
 S ^TMP($J,"MAGQ",4)="        INITIALS: "_INIT
 D MAILIT
 K ^TMP($J,"MAGQ")
 Q
MAILIT ;Send the report to the Clinical Application Time
 N XMSUB
 S XMSUB="Update Site file from "_LOC
MAILSHR ;Shared Mail server code
 ;If droping in...must manage XMSUB
 N XMY,XMTEXT,D,D0,D1,D2,DG,DIC,DICR,DIW,INDX
 S XMTEXT="^TMP($J,""MAGQ"")"
 I $G(DUZ) S XMY(DUZ)="",XMDUZ=DUZ
 E  S XMY(.5)="",XMDUZ=.5
 S XMY("G.MAG SERVER")=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 S XMSUBJ=XMSUB
 S XMBODY=XMTEXT
 S INDX=""
 F  S INDX=$O(XMY(INDX)) Q:INDX=""  S XMTO(INDX)=""
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ,)
 K XMBODY,XMSUBJ,XMTO,XMZ
 Q
ISN(RESULT,FILENAME,NETSIZE,JBSIZE) ; Image File Size variance Notice
 N Y,LOC,XMSUB,DIS,CAP,CNT,I,VR,DM,INST
 K ^TMP($J,"MAGQ")
 D NOW^%DTC S Y=% D DD^%DT
 S INST=$S($$CONSOLID^MAGBAPI():$$GET1^DIQ(2006.1,$$PLACE^MAGBAPI(+$G(DUZ(2))),.01),1:$$KSP^XUPARAM("INST"))
 S XMSUB="Image File Size Variance: "_$$GET1^DIQ(4,INST,.01)
 S ^TMP($J,"MAGQ",1)="            SITE: "_$$GET1^DIQ(4,INST,.01)_"^"_INST
 S ^TMP($J,"MAGQ",2)="            DATE: "_Y_" "_$G(^XMB("TIMEZONE"))
 S ^TMP($J,"MAGQ",3)="          DOMAIN: "_$$KSP^XUPARAM("WHERE")
 S ^TMP($J,"MAGQ",4)="        Filename: "_FILENAME
 S ^TMP($J,"MAGQ",5)="Vista Cache Size: "_NETSIZE
 S ^TMP($J,"MAGQ",6)="    Jukebox Size: "_JBSIZE
 D MAILSHR
 S RESULT="1"
 K ^TMP($J,"MAGQ")
 Q
 ;
