SD53P504 ;BP/DMR - Check PCMM OIF/OEF entries. 6/23/2009 ; 9/22/09 11:14am
 ;;5.3;Scheduling;**504**;AUG 13, 1993;Build 21
PRE ;
 N ZZ
 S ZZ=$$GET1^DIQ(404.91,1_",",803,"I") I ZZ'="" D
 .IF ZZ=1 S $P(^SD(404.91,1,"PCMM"),"^",3)=0
 I $$INIT()=0 D   ;run config checks for OIF OEF
 . D BMES^XPDUTL("The OIF OEF team is not set up correctly.")
 . D MES^XPDUTL("Installation aborted.")
 . S XPDABORT=1
 Q
POST ;
 D CLEAN(1)
 Q
INIT() ;
 ;inputs    none
 ;outputs   0=fail
 ;          1=success
 S (DFN,IEN,JJ,TEAM,TIEN,TPOS,TPOSC,TPIEN,TPUR,PUR,ROLE,COUNT,PC,STAT)="" S HOLD=0
 K ^TMP("SCMMT"),^TMP("SCMMR")
 N SCTFG    ;success/fail team config
 N SCRFG    ;success/fail role config
 S SCTFG=$$TEAM()
 S SCRFG=$$ROLE()
 D EXIT
 Q $S(SCTFG=0:0,SCRFG=0:0,1:1)
TEAM() ;
 ;if only one active team w/oif oef purp and pc=no count=9
 S TEAM="" S COUNT=8 F  S TEAM=$O(^SCTM(404.51,"B",TEAM)) Q:TEAM=""  D
 .S TIEN="" F  S TIEN=$O(^SCTM(404.51,"B",TEAM,TIEN)) Q:TIEN=""  D
 ..D HISTM Q:STAT'=1
 ..S TPUR="" S TPUR=$$GET1^DIQ(404.51,TIEN_",",.03,"E")
 ..IF TPUR["OIF"!(TPUR["OEF") D
 ...S COUNT=COUNT+1
 ...S PC="" S PC=$$GET1^DIQ(404.51,TIEN_",",.05)
 ...IF PC="YES" S COUNT=COUNT+1
 ...S ^TMP("SCMMT",$J,COUNT)="TEAM: "_TEAM
 ...S COUNT=COUNT+1 S ^TMP("SCMMT",$J,COUNT)="PRIMARY CARE TEAM: "_PC
 ...S COUNT=COUNT+1 S ^TMP("SCMMT",$J,COUNT)=""
 ...Q
 IF COUNT>11 D MESS1 Q 0  ;oif oef team set to pc
 IF COUNT=8 D MESS1 Q 0   ;no active oif oef team
 Q 1
ROLE() ;
 S (TEAM,TPUR,ROIF,TOIF,TPOIF,TPHS,TPHN,STAT,TPH,STAT,RIEN,APC)="",CC=6
 S TPOS="" F  S TPOS=$O(^SCTM(404.57,"B",TPOS)) Q:TPOS=""  D
 .S TPIEN="" F  S TPIEN=$O(^SCTM(404.57,"B",TPOS,TPIEN)) Q:TPIEN=""  D
 ..D HIST
 ..Q:STAT=0
 ..S RIEN="" S RIEN=$$GET1^DIQ(404.57,TPIEN_",",.03,"I")
 ..S ROLE="" S ROLE=$$GET1^DIQ(404.57,TPIEN_",",.03,"E")
 ..S ROIF="" IF ROLE["OIF"!(ROLE["OEF") S ROIF="Y"
 ..S TEAM=$$GET1^DIQ(404.57,TPIEN_",",.02),TIEN=$$GET1^DIQ(404.57,TPIEN_",",.02,"I")
 ..D HISTM Q:STAT'=1  ;exclude positions on inactive teams
 ..S (TOIF,TPOIF)="" S TPUR=$$GET1^DIQ(404.51,TIEN_",",.03) IF TPUR["OIF"!(TPUR["OEF") S (TOIF,TPOIF)="Y"
 ..S PPP=$$GET1^DIQ(404.57,TPIEN_",",.04,"E")
 ..D SAVE IF SAVE="Y" D
 ...S CC=CC+1 S ^TMP("SCMMR",$J,CC)=""
 ...S CC=CC+1 S ^TMP("SCMMR",$J,CC)="TEAM: "_TEAM
 ...S CC=CC+1 S ^TMP("SCMMR",$J,CC)="TEAM POSITION: "_TPOS
 ...S CC=CC+1 S ^TMP("SCMMR",$J,CC)="TEAM PURPOSE: "_TPUR
 ...S CC=CC+1 S ^TMP("SCMMR",$J,CC)="ROLE: "_ROLE
 ...S CC=CC+1 S ^TMP("SCMMR",$J,CC)="POSSIBLE PRIMARY PRACTITIONER: "_PPP
 ...Q
 IF CC>6 D MESS2 Q 0
 Q 1
HIST ;Get TEAM POSITION HISTORY status.
 S (STAT,TPH,TPHN)=""
 S TPHN="" F  S TPHN=$O(^SCTM(404.59,"B",TPIEN,TPHN)) Q:TPHN=""  D
 .S TPH="" S STAT=$$GET1^DIQ(404.59,TPHN_",",.03,"I")
 .S TPHDT=$$GET1^DIQ(404.59,TPHN_",",.02,"I")
 .IF TPHDT>DT S STAT='STAT
 .Q
 Q
HISTM ;Get TEAM HISTORY status
 S IEN="" F  S IEN=$O(^SCTM(404.58,"B",TIEN,IEN)) Q:IEN=""  D
 .S STAT=$$GET1^DIQ(404.58,IEN_",",.03,"I")
 .S THDT=$$GET1^DIQ(404.58,IEN_",",.02,"I")
 .IF THDT>DT S STAT='STAT
 Q
SAVE ;
 S SAVE=""
 Q:ROIF=""&(TOIF=""&(TPOIF=""))
 IF ROIF="Y"&(TOIF=""!(TPOIF="")) S SAVE="Y"
 IF ROIF=""&(TOIF="Y"!(TPOIF="Y")) S SAVE="Y"
 IF TOIF="Y"&(ROIF=""!(TPOIF="")) S SAVE="Y"
 IF TOIF=""&(ROIF="Y"!(TPOIF="Y")) S SAVE="Y"
 IF TPOIF="Y"&(ROIF=""!(TOIF="")) S SAVE="Y"
 IF TPOIF=""&(ROIF="Y"!(TOIF="")) S SAVE="Y"
 Q
 ;
MESS1 ;Create message if more than 1 oif oef team.
 S ^TMP("SCMMT",$J,1)="The setup of the OIF OEF team at this site is incorrect."
 S ^TMP("SCMMT",$J,2)="The business rules governing PCMM OIF OEF teams state that each"
 S ^TMP("SCMMT",$J,3)="site can have only one OIF OEF team. That team cannot provide primary care."
 S ^TMP("SCMMT",$J,4)="Please correct errors as soon as possible; you will continue "
 S ^TMP("SCMMT",$J,5)="to receive this message until all errors are resolved."
 S ^TMP("SCMMT",$J,6)=""
 S ^TMP("SCMMT",$J,7)="THE FOLLOWING IS A LIST OF OIF OEF TEAMS AT THIS INSTITUTION:"
 S ^TMP("SCMMT",$J,8)=""
 N XMSUB,XMY,XMTEST,XMDUZ
 S XMSUB="PCMM OIF OEF TEAMS"
 S XMY("G.PCMM HL7 MESSAGES")=""
 S XMTEXT="^TMP(""SCMMT"",$J,"
 D ^XMD
 S HOLD="Y"
 Q
MESS2 ;Create message for bad entries involving oif oef teams.
 S ^TMP("SCMMR",$J,1)="The PCMM TEAM POSITIONS listed below have inconsistencies"
 S ^TMP("SCMMR",$J,2)="in the set up of OIF OEF Teams and Positions in the PCMM package."
 S ^TMP("SCMMR",$J,3)="Please review the business rules pertaining to the set up of"
 S ^TMP("SCMMR",$J,4)="OIF OEF Teams and Positions. The PCMM HL7 Transmission will not"
 S ^TMP("SCMMR",$J,5)="transmit until these errors are corrected. If additional assistance"
 S ^TMP("SCMMR",$J,6)="is needed please contact the national helpdesk."
 N XMSUB,XMY,XMTEST,XMDUZ
 S XMSUB="PCMM OIF OEF ERROR MESSAGE"
 S XMY("G.PCMM HL7 MESSAGES")=""
 S XMTEXT="^TMP(""SCMMR"",$J,"
 D ^XMD
 S HOLD="Y"
 Q
CLEAN(SCOIFG) ;clean up errors in transmission log
 ;inputs
 ;  0=bad OIF OEF config
 ;  1=good OIF OEF config
 ;
 ;error profile
 ;  patient=null
 ;  practitioner=null
 ;  status=rj
 ;  ZPC ID exists
 ;
 N SCI,SCJ,SCK,SCA,DFN,SC1
 N SC0            ;0 node 404.471
 N SC043          ;0 node 404.43
 N SCT,SCT1,SCT2  ;counters
 N SCTP           ;position ien
 N SCEPS          ;return value 
 N SCSTAT         ;return value
 N SCERR          ;error text
 N SCARRAY        ;array of ZPC segments
 N SCIENS         ;ien 404.47141
 ;;;
 S (SC043,SCK,SCT,SCT1,SCT2)=0
 D BMES^XPDUTL("Cleaning PCMM Transmission Log")
 F SCI=0:0 S SCI=$O(^SCPT(404.471,"ASTAT","RJ",SCI)) Q:SCI'>0  D
 . S SC0=$G(^SCPT(404.471,SCI,0))  ;get 0 node
 . I (+$P(SC0,U,2)_U_(+$P(SC0,U,8)))'="0^0" Q  ;exclude
 . S SCA=0 F SCK=0:0 S SCK=$O(^SCPT(404.471,SCI,"ZPC",SCK)) Q:SCK=""!(+SCA>0)  D
 .. S SCIENS=SCK_","_SCI,SCA=+($$GET1^DIQ(404.47141,SCIENS,.02))
 . Q:SCA=0  ;exclude if no ZPC ID
 . S SC043=$G(^SCPT(404.43,SCA,0))
 . ;close log entry
 . F SCK=0:0 S SCK=$O(^SCPT(404.471,SCI,"ERR",SCK)) Q:SCK'>0  D
 .. S SCEPS=$$UPDEPS^SCMCHLA(SCI,SCK,2,.SCERR)
 . S SCSTAT=$$UPDSTAT^SCMCHLA(SCI,"RT",.SCERR)
 . I SCERR'="" D  Q
 .. S SCT2=SCT2+1
 .. S SCARRAY(SCI)=SCERR
 . S SCT1=SCT1+1 W:SCT1\5 "."
 . Q:SC043=0  ;stop processing log entries with no 404.43
 . S DFN=+$P($G(^SCPT(404.42,+SC043,0)),U)
 . S SCTP=+$P(SC043,U,2)
 . ;only re-send if good 404.43 record and no OIF OEF errors
 . I DFN>0&(SCOIFG) D
 .. D ADD^SCMCHLE("NOW",+SCA_";SCPT(404.43,",DFN,SCTP)
 .. S SCT=SCT+1
 I SCT_U_SCT1'=(0_U_0) D MSG(SCT_U_SCT1_U_SCT2,.SCARRAY)
 K ^TMP("SCOIF",$J)
 Q
MSG(SC1,SCARRAY) ;
 ;inputs
 N XMY,XMDUZ,XMSUB,XMTEXT
 N SCIX,SCI
 S XMDUZ="PCMM Module"
 S XMY("G.PCMM HL7 MESSAGES")=""
 S XMSUB="PCMM Transmission Log Clean Up"
 S XMTEXT="^TMP(""SCOIF"",$J,"
 K ^TMP("SCOIF",$J)
 S ^TMP("SCOIF",$J,1)=""
 S ^TMP("SCOIF",$J,2)="Number of transmission log entries that were closed: "_+$P(SC1,U,2)
 S ^TMP("SCOIF",$J,3)="Number of OIF OEF patient assignments that will be re-transmitted: "_+$P(SC1,U)
 S ^TMP("SCOIF",$J,4)=""
 I +$P(SC1,U,3) D
 . S ^TMP("SCOIF",$J,5)="The following transmission log entries could not be closed: "
 . S ^TMP("SCOIF",$J,6)="IEN"_$J(" ",7)_"Msg ID"_$J(" ",11)_"Error"
 . S SCI="" F SCIX=7:1 S SCI=$O(SCARRAY(SCI)) Q:SCI=""  D
 .. S ^TMP("SCOIF",$J,SCIX)=SCI_$J(" ",10-$L(SCI))_$$GET1^DIQ(404.471,SCI,.01,"E")_$J(" ",7)_SCARRAY(SCI)
 ..S ^TMP("SCOIF",$J,SCIX+1)=""
 D ^XMD
 Q
EXIT ;End routine
 K DFN,IEN,JJ,TEAM,TIEN,TPOS,TPOSC,TPIEN,TPUR,PUR,ROLE,COUNT
 K TEAM,TPUR,TIEN,ROIF,TOIF,TPOIF,TPHS,TPHN,STAT,RIEN,APC
 K CC,PC,PPP,SAVE,THDT,TPH,TPHDT,XMTEXT,HOLD,IENS
 K ^TMP("SCMMT",$J),^TMP("SCMMR",$J)
 Q
