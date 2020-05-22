YSCLTST9 ; HEC/hrubovcak - transmit demographics to Clozapine data server ;8 Nov 2019 15:21:58
 ;;5.01;MENTAL HEALTH;**154**;Dec 30, 1994;Build 48
 Q
 ;
DEMOG ; transmit demographic data to RUCL server
 ;
 D DT^DICRW K ^TMP($J,"YSFMPTS"),^TMP($J,"YSCLXMSG"),^TMP($J,"YSDFNSENT")
 ; YSREC - record to be sent in MailMan message
 N X,XMSUB,XMY,YSIEN,YSREC,YSV,YSXMZ
 S YSV("ptCount")=0,YSV("siteZipCode")="zip+4"
 ; 59,.05 MAILING FRANK ZIP+4 CODE
 S X=$$GET1^DIQ(59,1,.05) S:X]"" YSV("siteZipCode")=X
 D LIST^DIC(603.01,,".01;1;2;3","I",,,,,,,$NA(^TMP($J,"YSFMPTS")))  ; get snapshot of file
 S YSIEN=0 F  S YSIEN=$O(^TMP($J,"YSFMPTS","DILIST","ID",YSIEN)) Q:'YSIEN  D
 . N YSNTRY,DFN
 . M YSNTRY=^TMP($J,"YSFMPTS","DILIST","ID",YSIEN)
 . S DFN=+$G(YSNTRY(1)),^TMP($J,"YSDFNSENT",DFN)=0  ; set to zero, demographics not sent
 . Q:'$L($$GET1^DIQ(55,DFN,53))  ; no CLOZAPINE REGISTRATION NUMBER
 . Q:$$GET1^DIQ(55,DFN,56,"I")   ; DEMOGRAPHICS SENT, don't retransmit
 . N PHYS,VADM,VAPA,VAERR
 . D DEM^VADPT,ADD^VADPT
 . S YSREC=$G(YSNTRY(.01))  ; 603.01,.01 CLOZAPINE REGISTRATION NUMBER
 . S $P(YSREC,U,2)=$E($P(VADM(1),",",2))_$E(VADM(1))  ; initials
 . S $P(YSREC,U,3)=$P(VADM(3),U)  ; date of birth
 . S $P(YSREC,U,4)=$P(VADM(2),U)  ; ssn
 . S $P(YSREC,U,5)=$P(VADM(5),U)  ; sex
 . S $P(YSREC,U,6)=VAPA(6)  ; patient zip
 . S $P(YSREC,U,7)=DT  ; today
 . S $P(YSREC,U,8)=$E($P($G(VADM(12,1)),U,2),1,32)  ; race
 . S PHYS=+$$GET1^DIQ(55,DFN,57,"I")
 . S $P(YSREC,U,9)=$E($$GET1^DIQ(200,PHYS,.01),1,30)  ; physician
 . S $P(YSREC,U,10)=$$GET1^DIQ(200,PHYS,53.2)  ; dea #
 . S $P(YSREC,U,11)=YSV("siteZipCode")  ; site zip
 . D ADD2TXT^YSCLSERV(YSREC)
 . S YSV("ptCount")=YSV("ptCount")+1,^TMP($J,"YSDFNSENT",DFN)=1  ; set to 1, demographics sent
 ;
 I 'YSV("ptCount") D ADD2TXT^YSCLSERV("0^No Patient data to send.")  ; put a zero in front of "^"
 D TRANSMIT(.YSXMZ)  ; send and get message number
 S YSV("1stMsg")=YSXMZ
 ;
 S DFN=0 F  S DFN=$O(^TMP($J,"YSDFNSENT",DFN)) Q:'DFN  D:$G(^TMP($J,"YSDFNSENT",DFN))  ; only if sent
 . N DA,DIE,DR
 . S DIE="^PS(55,",DA=DFN,DR="56///1" D ^DIE  ; (#56) DEMOGRAPHICS SENT
 ;
 D  ; 603.03,6 - LAST DEMOGRAPHICS TRANSMISSION
 . N DA,DIE,DR
 . S DIE="^YSCL(603.03,",DA=1,DR="6///"_$$NOW^XLFDT D ^DIE
 ;
 K ^TMP($J,"YSCLXMSG")  ; get rid of 1st message text
 K XMY
 S XMSUB=$S(+$$GET1^DIQ(603.03,1,3):"DEBUG ",1:"")_"Clozapine demographics"
 S X=YSV("ptCount")_" record"_$S(YSV("ptCount")=1:" was",1:"s were")
 D ADD2TXT^YSCLSERV("Clozapine demographic data was transmitted, "_X_" sent,")
 D ADD2TXT^YSCLSERV("in message number "_YSV("1stMsg")_".")
 S XMY("G.PSOCLOZ")=""
 ;
 ; send the 2nd message
 D SENDMSG^XMXAPI(DUZ,XMSUB,$NA(^TMP($J,"YSCLXMSG")),.XMY,"",.YSXMZ)
 D XTMPZRO^YSCLTST5
 ;
 K ^TMP($J,"YSFMPTS"),^TMP($J,"YSDFNSENT")  ; clean up
 Q
 ;
TRANSMIT(YSXMZ) ; trasmit demographics, YSXMZ passed by ref.
 ; YSCLSUB set in YSCLSERV
 N XMDUN,XMY,XMSUB
 S YSXMZ=0  ; message number to return
 S YSDEBUG=+$$GET1^DIQ(603.03,1,3,"I")  ; 603.03,3 DEBUG MODE
 S X=$P($$SITE^VASITE,U,3)  ; site number
 S XMDUN="NCCC LOGGER",XMDUZ=".5",XMSUB=$S(YSDEBUG:"DEBUG ",$G(YSCLSUB)["DEBUG":"DEBUG ",1:"")_X_" NCCC ENROLLER ("_$$NOW^XLFDT_")"
 ;
 D SETXMY(.XMY)
 ; send the message
 D SENDMSG^XMXAPI(DUZ,XMSUB,$NA(^TMP($J,"YSCLXMSG")),.XMY,"",.YSXMZ)
 ;
 K ^TMP($J,"YSCLXMSG")
 Q
 ;
SETXMY(YSXMY) ; set mail recipients, YSXMY passed by ref.
 ;
 N RCPNT,YSDEBUG,YSPROD
 S YSPROD=+$$GET1^DIQ(8989.3,1,501,"I")  ; 8989.3,501 PRODUCTION
 S YSDEBUG=+$$GET1^DIQ(603.03,1,3)  ; (#3) DEBUG MODE
 ;
 D:YSPROD  ; production account
 . S RCPNT=$$GET1^DIQ(603.03,1,9)  ; (#9) DEMOGRAPHIC PROD LISTENER
 . S:$L(RCPNT) YSXMY(RCPNT)="" Q:'YSDEBUG
 . S YSXMY("G.YSCLOZ DEBUG")=""  ; local only in debug mode
 ;
 D:'YSPROD  ; test account
 . S RCPNT=$$GET1^DIQ(603.03,1,11)  ; (#11) DEMOGRAPHIC TEST LISTENER
 . S:$L(RCPNT) YSXMY(RCPNT)=""
 . S YSXMY("G.YSCLOZ DEBUG")=""  ; local always
 . S RCPNT=$$FIND1^DIC(19,"","","RUCLDEM")  ; local RUCL server?
 . S:RCPNT>0 YSXMY("S.RUCLDEM")=""
 ;
 Q
 ;
