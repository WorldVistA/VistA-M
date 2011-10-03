MAGQE2 ;WOIFO/RMP - Support for MAG Enterprise ; 08/22/2003  13:44
 ;;3.0;IMAGING;**27,29,20,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
AHISU(START,STOP) ;
 N ADHOC
 S ADHOC=1
 ;
ISU ;IMAGING SITE USAGE - SERVER
 N INST,LOC,PLACE,TMP
 I $$CONSOLID^MAGQE5() D
 . S INST="" F  S INST=$O(^MAG(2006.1,"B",INST)) Q:INST=""  D
 . . S PLACE=$O(^MAG(2006.1,"B",INST,"")) Q:'PLACE
 . . Q:($P($G(^MAG(2006.1,PLACE,0)),U)'=INST)  ;Screen Associated Institutions
 . . D ISU1(PLACE,INST)
 . . Q
 . Q
 E  D ISU1($O(^MAG(2006.1," "),-1),$$KSP^XUPARAM("INST"))
 D:'$G(ADHOC) TASK^MAGQE4
 K ^TMP($J,"MAGQ")
 Q
 ;
ISU1(PLACE,INST) ;
 I '$G(ADHOC) D TASK Q  ; We are already in a TaskMan task...
 ;
 S ZTDTH=$$NOW^XLFDT()
 S ZTRTN="TASK^"_$T(+0)
 S ZTDESC="Ad-Hoc Imaging Usage Report ("_$$FMTE^XLFDT(START\1)_" - "_$$FMTE^XLFDT(STOP\1)_")"
 S ZTIO=""
 S ZTSAVE("START")=START
 S ZTSAVE("STOP")=STOP
 S ZTSAVE("PLACE")=PLACE
 S ZTSAVE("INST")=INST
 S:$G(ADHOC) ZTSAVE("ADHOC")=1
 S:$D(MAGDUZ) ZTSAVE("MAGDUZ")=MAGDUZ
 D ^%ZTLOAD
 K ZTDTH,ZTRTN,ZTDESC,ZTIO,ZTSAVE
 Q
 ;
MSG(TXT) N I
 S I=$O(^TMP($J,"MAGQ",PLACE,"SITE_REPORT"," "),-1)+1
 S ^TMP($J,"MAGQ",PLACE,"SITE_REPORT",I)=TXT
 Q
 ;
TASK N DM,I,LOC,OCONS,PCNT,REC,VR,XMSUB,Y,X
 S:'$D(INST) INST=$$KSP^XUPARAM("INST")
 K ^TMP($J,"MAGQ")
 I '$G(START)!'$G(STOP) D
 . S STOP=$$FMADD^XLFDT($$NOW^XLFDT()\100_"01",-1)
 . S START=STOP\100_"01"
 . Q
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 S U="^",LOC=$$GET1^DIQ(4,INST,.01)_"^"_INST
 D MSG("            SITE: "_LOC)
 D MSG("Reporting Period: "_$$FMTE^XLFDT(START\1)_" - "_$$FMTE^XLFDT(STOP\1))
 D MSG("            DATE: "_Y_" "_$G(^XMB("TIMEZONE")))
 D MSG("          DOMAIN: "_$$KSP^XUPARAM("WHERE"))
 D MSG("    2005 ENTRIES: "_$P($G(^MAG(2005,0)),"^",4))
 D MSG(" 2006.81 ENTRIES: "_$$WSP^MAGQE5(PLACE))
 D MSG(" Production Account: "_$$PROD^XUPROD("1"))
 ; Distribute an array each of the capture and display versions
 D IWSV^MAGQE1(PLACE)
 ; VistaRad version
 S VR=$$VERSION^XPDUTL("MAGJ RADIOLOGY") D:VR'="" MSG("VistaRad Version: "_VR)
 I $D(^MAGD(2006.599,0)) D MSG("DICOM Error Log:"_+$P(^MAGD(2006.599,0),"^",4))
 I $D(^MAGD(2006.575,0)) D MSG("DICOM FAILED IMAGES:"_+$P(^MAGD(2006.575,0),"^",4))
 ; Queue File count & Unprocessed Queue entries
 D MSG("Queue File count: "_$$QCNT^MAGQE5(.PCNT,PLACE))
 D MSG("Unprocessed Queue entries: "_PCNT)
 D ISU2^MAGQE5
 S X=""
 S:'$G(ADHOC) X=" ("_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",START\100#100)_" "_(START\10000+1700)_")"
 S XMSUB=$S($G(ADHOC):"Ad Hoc",1:"Monthly")_" Image Site Usage: "_LOC_X
 D MAILSHR^MAGQBUT1(PLACE,"SITE_REPORT",XMSUB)
 Q
 ;
