SDEC665 ;ALB/SAT/JSM - VISTA SCHEDULING PRE/POST ;JUN 21, 2017
 ;;5.3;Scheduling;**665**;Aug 13, 1993;Build 14
 ;
 Q
 ;
PRE ;
 Q
 ;
POST ;alb/sat 665
 D NOTE
 Q
 ;
NOTE  ;sync OTHER in HOSPITAL LOCATION appointment record and NOTE in SDEC APPOINTMENT
 ;per Irene Smith, Debbie Malkovich 2/8/2017
 ; If NOTE is empty AND OTHER is defined, OTHER data will be set to NOTE.
 ; If NOTE is defined AND OTHER is defined, OTHER data will be set to NOTE - NOTE data is replaced by OTHER data. (VistA wins!)
 ; If NOTE is defined AND OTHER is empty, NOTE data will be set to OTHER
 N Y
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,"Syncing OTHER in clinic appointments with NOTE in SDEC APPOINTMENTs ..."
 W !,Y
 N ZTDESC,ZTDTH,ZTIO,ZTRTN
 S ZTRTN="N2^SDEC665"
 S ZTIO=""
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,1)
 S ZTDESC="SD*5.3*665 NOTE UPDATE REPORT DATA"
 D ^%ZTLOAD
 Q
N2  ;called by background job
 ;GET conflicts
 N AIEN,AIEN2,ANOD,CNOT,ARR,CNT,LCNT,LINE,SC,SCN,SDR,SDT,SDTMP,SDX,SID,SNOD,SNOT,SSC,X,XMSUB,XMTEXT,XMY,SDECSDT
 K ^XTMP("VSGUI_OI")
 S ^XTMP("VSGUI_OI",0)=$$FMADD^XLFDT(DT,7)_U_$$DT^XLFDT S $P(LINE,"=",78)="="
 S (CNT,LCNT)=0
 S SDX="^XTMP(""SDEC665M"")"
 K @SDX
 S @SDX@(0)=$$FMADD^XLFDT(DT,7)_U_$$DT^XLFDT
 S SDECSDT=$O(^SDEC(409.84,"B",0))  ;alb/jsm set very first starttime of SDEC APPOINTMENTS
 D BLD("CONFLICTS:"),BLD("=========")
 D BLD(LINE)
 S SCN="" F  S SCN=$O(^SC("AG","C",SCN)) Q:SCN=""  D
 .S SC=0 F  S SC=$O(^SC("AG","C",SCN,SC)) Q:SC=""  D
 ..S SDT=$P(SDECSDT,".",1) F  S SDT=$O(^SC(SC,"S",SDT)) Q:SDT'>0  D  ;alb/jsm reset SDT to the starttime from SDEC APPOINTMENTS
 ...S AIEN=0 F  S AIEN=$O(^SC(SC,"S",SDT,1,AIEN)) Q:AIEN'>0  D
 ....S ANOD=$G(^SC(SC,"S",SDT,1,AIEN,0))
 ....S CNOT=$P(ANOD,U,4)
 ....S AIEN2=$$FIND^SDAM2($P(ANOD,U,1),SDT,SC)  ;665
 ....I AIEN2=AIEN D  ;665
 .....S SID=0 F  S SID=$O(^SDEC(409.84,"B",SDT,SID)) Q:SID=""  D
 ......S SNOD=$G(^SDEC(409.84,SID,0))
 ......S SDR=$P(SNOD,U,7),SSC=$$GET1^DIQ(409.831,SDR_",",.04,"I")
 ......I $P(SNOD,U,5)=$P(ANOD,U,1),SC=SSC D
 .......K ARR
 .......S SNOT=""
 .......S X=$$GET1^DIQ(409.84,SID_",",1,,"ARR")
 .......S SNOT=$$WPSTR^SDECUTL(.ARR)
 .......S SNOT=$E(SNOT,1,150)
 .......I SNOT["^" D STRIP K ARR S X=$$GET1^DIQ(409.84,SID_",",1,,"ARR") S SNOT=$$WPSTR^SDECUTL(.ARR) S SNOT=$E(SNOT,1,150)
 .......I CNOT'=SNOT D
 ........S CNT=CNT+1,(XSTR,^XTMP("VSGUI_OI","DIFF",SCN,CNT))=SDT_U_SC_U_SCN_U_AIEN_U_$P(SNOD,U,5)_U_CNOT_U_SID_U_SNOT
 ........S SDTMP=$$GET1^DIQ(2,+$P(XSTR,U,5),.01)_" ("_$P(XSTR,U,5)_")"
 ........D BLD(SDTMP)
 ........S SDTMP="CLINIC: "_$E("("_$P(XSTR,U,2)_") "_$P(XSTR,U,3),1,39),SDTMP=SDTMP_$$FILL^SDECU(49-$L(SDTMP))_"APPT TIME: "_$$FMTE^XLFDT($P(XSTR,U,1))
 ........D BLD(SDTMP)
 ........S SDTMP="OTHER:"
 ........D BLD(SDTMP)
 ........D BLD($P(XSTR,U,6)),BLD("")
 ........S SDTMP="NOTE ("_$P(XSTR,U,7)_"):"
 ........D BLD(SDTMP)
 ........D BLD($P(XSTR,U,8)),BLD(LINE)
 ;FIX conflicts
 K ANOD,CNOT,CNT,IENS,LINE,SCN,SNOT,X,XSTR
 S $P(LINE,"=",78)="="
 D BLD(""),BLD(""),BLD(""),BLD("RESOLUTIONS:"),BLD("===========")
 D BLD(LINE)
 S SCN="" F  S SCN=$O(^XTMP("VSGUI_OI","DIFF",SCN)) Q:SCN=""  D
 .S CNT=0 F  S CNT=$O(^XTMP("VSGUI_OI","DIFF",SCN,CNT)) Q:CNT=""  D
 ..K ARR,FDA
 ..S XSTR=$G(^XTMP("VSGUI_OI","DIFF",SCN,CNT))
 ..S CNOT=$P(XSTR,U,6)
 ..S SNOT=$P(XSTR,U,8)
 ..S IENS=$P(XSTR,U,4)_","_$P(XSTR,U,1)_","_$P(XSTR,U,2)_","
 ..D:(CNOT="")&(SNOT'="") WP^DIE(409.84,$P(XSTR,U,7)_",",1,"","@")   ;FDA(44.003,IENS,3)=SNOT
 ..D:(CNOT'="")&(SNOT="") WP^SDECUTL(.ARR,CNOT)
 ..D:(CNOT'="")&(SNOT'="")&(CNOT'=SNOT) WP^SDECUTL(.ARR,CNOT)
 ..;D:$D(FDA) UPDATE^DIE("","FDA")
 ..D:$D(ARR) WP^DIE(409.84,$P(XSTR,U,7)_",",1,"","ARR")
 ..S ANOD=$G(^SC($P(XSTR,U,2),"S",$P(XSTR,U,1),1,$P(XSTR,U,4),0))
 ..S CNOT=$P(ANOD,U,4)
 ..K ARR
 ..S X=$$GET1^DIQ(409.84,$P(XSTR,U,7)_",",1,,"ARR")
 ..S SNOT=$$WPSTR^SDECUTL(.ARR)
 ..S SNOT=$E(SNOT,1,150)
 ..S SDTMP=$$GET1^DIQ(2,+$P(XSTR,U,5),.01)_" ("_$P(XSTR,U,5)_")"
 ..D BLD(SDTMP)
 ..S SDTMP="CLINIC: "_$E("("_$P(XSTR,U,2)_") "_$P(XSTR,U,3),1,39),SDTMP=SDTMP_$$FILL^SDECU(49-$L(SDTMP))_"APPT TIME: "_$$FMTE^XLFDT($P(XSTR,U,1))
 ..D BLD(SDTMP)
 ..S SDTMP="OTHER:"
 ..D BLD(SDTMP)
 ..D BLD(CNOT)
 ..D BLD("")
 ..S SDTMP="NOTE ("_$P(XSTR,U,7)_"):"
 ..D BLD(SDTMP)
 ..D BLD(SNOT)
 ..D BLD(LINE)
 ;SEND message
 S XMY(DUZ)="",XMSUB="SD*5.3*665 NOTE UPDATE REPORT DATA for "_$$FMTE^XLFDT($$NOW^XLFDT)
 S XMTEXT=$P(SDX,")")_","
 D ^XMD
 Q
 ;
BLD(TXT)  ;build output text for email
 S LCNT=LCNT+1
 S @SDX@(LCNT)=TXT
 Q
STRIP ;
 N FDA
 Q:SNOT'["^"
 S SNOT=$TR(SNOT,"^"," ")
 D WP^SDECUTL(.ARR,SNOT)
 D WP^DIE(409.84,SID_",",1,"","ARR")
 Q
