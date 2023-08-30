PSO7P684 ;WILM/BDB - Pre Install routine for patch PSO*7*684 ;4/22/2022
 ;;7.0;OUTPATIENT PHARMACY;**684,545**;DEC 1997;Build 270
 Q
 ;
PRE ; Pre-Install Entry Point
 N HANDPSO S HANDPSO="PSO70684-INSTALL"
 ;
 I '$D(ZTQUEUED) D  Q
 .N PSOASTER S $P(PSOASTER,"*",74)="*"
 .S XPDABORT=1
 .D BMES^XPDUTL(PSOASTER)
 .D MES^XPDUTL("  Patch Install must be Queued. Please unload this distribution")
 .D MES^XPDUTL("   and run install again with Queueing.")
 .D MES^XPDUTL(PSOASTER)
 ;
 L +^XTMP(HANDPSO):0 I '$T D  Q
 . S XPDABORT=1
 . D BMES^XPDUTL("PSO*7*684 DEA Migration job is already running.  Halting...")
 . D MES^XPDUTL("")
 ;
 ;The doj/dea file should NOT be loaded in prod if PSO*7*545 installed more than 7 days ago
 I $$PROD^XUPROD,$$P545CHK7^PSO7E684() L -^XTMP(HANDPSO) Q
 ;
 ;check if the doj/dea file should be loaded based on the install question
 I '$$PROD^XUPROD(),($G(XPDQUES("PRE1","B"))["N") D  Q
 . S ^XTMP(HANDPSO,"STATUS")="Install Completed"
 . L -^XTMP(HANDPSO)
 ;
 S ^XTMP(HANDPSO,"STATUS")="In Progress"
 ;
 ;delete the new DEA data in files #200 and #8991.9
 N DEA,NPIEN,DA,DEAIEN
 D BMES^XPDUTL("******")
 D MES^XPDUTL("Deleting the DEA profile data for the DEA multiple fields in the")
 D MES^XPDUTL("New Person file (#200) and in the DEA Numbers file (#8991.9).")
 D MES^XPDUTL("Performing the DOJ DEA migration.")
 D MES^XPDUTL("******")
 S DEA="A"
 F  S DEA=$O(^VA(200,"PS4",DEA)) Q:DEA=""  D 
 .S NPIEN=0 S NPIEN=$O(^VA(200,"PS4",DEA,NPIEN)) Q:NPIEN=""  D
 ..S DA=$O(^VA(200,"PS4",DEA,NPIEN,0)) Q:DA=""
 ..S DA(1)=NPIEN,DIK="^VA(200,"_DA(1)_",""PS4""," D ^DIK K DIK
 S DEAIEN=0 F  S DEAIEN=$O(^XTV(8991.9,DEAIEN)) Q:DEAIEN=""  D
 .S DA=DEAIEN,DIK="^XTV(8991.9," D ^DIK K DIK,DA
 ;run the initial load of the DOJ DEA data
 ;
 D INITLOAD(90)
 S ^XTMP(HANDPSO,"STATUS")="Install Completed"
 L -^XTMP(HANDPSO)
 ;
 Q
 ;
INITLOAD(LIFE) ; -- main entry point for DEA INITIAL IMPORT
 N DEA,FG,NPIEN,NPDATA,NPNAME,DEAIEN,PHANDLE,PSOLDHNDL,HANDPSO,MIGRCNT,EXCNT
 S HANDPSO="PSO70684-INSTALL"
 S MIGRCNT=0,EXCNT=0
 S PSOLDHNDL=$O(^XTMP("PSODEAWB-")) I PSOLDHNDL["PSODEAWB" K ^XTMP(PSOLDHNDL) ; Remove oldest batch of Exceptions from ^XTMP
 S:'$D(LIFE) LIFE=90
 S PHANDLE=$$INITXTMP("PSODEAWB","DEA INITIAL IMPORT",LIFE)
 S ^TMP($J,"PSODEAWB")=1
 S DEA="A"
 F  S DEA=$O(^VA(200,"PS1",DEA)) Q:DEA=""  D
 . S NPIEN=0 F  S NPIEN=$O(^VA(200,"PS1",DEA,NPIEN)) Q:'NPIEN  D
 .. N FILERR,ERRCODE,FG
 .. S NPNAME=$$GET1^DIQ(200,NPIEN,.01)
 .. I NPNAME']"" D  Q
 ... N PSOASTER
 ... S $P(PSOASTER,"*",74)="*"
 ... D BMES^XPDUTL(PSOASTER)
 ... D BMES^XPDUTL("Database error for the New Person file #200.")
 ... D BMES^XPDUTL("DEA Number "_DEA_",   IEN= "_NPIEN)
 ... D BMES^XPDUTL(PSOASTER)
 .. D BMES^XPDUTL(DEA_"     "_NPNAME)
 .. S SC=$$GET(.FG,DEA)
 .. S ERRCODE=SC
 .. I 'SC I ERRCODE'[404 D LOG(.FG,NPIEN,PHANDLE,"WEB SERVICE ISSUE",DEA,.EXCNT) Q
 .. I 'SC I $G(ERRCODE)[404 D LOG(.FG,NPIEN,PHANDLE,"DEA# NOT FOUND IN DOJ FILE",DEA,.EXCNT) Q
 .. I $P(FG("name"),",",1)'=$P(NPNAME,",",1) D LOG(.FG,NPIEN,PHANDLE,"NAME MISMATCH",DEA,.EXCNT) Q
 .. I ($E($G(FG("businessActivityCode")))'="")&($E($G(FG("businessActivityCode")))'="M")&($E($G(FG("businessActivityCode")))'="C") D LOG(.FG,NPIEN,PHANDLE,"INSTITUTIONAL DEA# REQUIRES INDIVIDUAL DEA SUFFIX",DEA,.EXCNT) Q
 .. I $D(^XTV(8991.9,"B",DEA)) D LOG(.FG,NPIEN,PHANDLE,"DUPLICATE DEA NUMBER",DEA,.EXCNT) Q
 .. K DEAIEN S SC=$$DEAFILE(DEA,NPIEN,PHANDLE,.FG,.DEAIEN,.EXCNT) I 'SC  D LOG(.FG,NPIEN,PHANDLE,"DATA FILING ISSUE. "_$P($G(SC),"^",2),DEA,.EXCNT) Q
 .. D NPFILE(DEA,NPIEN,DEAIEN,.FILERR) D  Q
 ... I $G(FILERR)'="" D LOG(.FG,NPIEN,PHANDLE,"MIGRATION DATA NOT FILED. "_FILERR,DEA,.EXCNT) Q
 ... S MIGRCNT=$G(MIGRCNT)+1
 K ^TMP($J,"PSODEAWB")
 D TMPMSG(EXCNT,MIGRCNT,LIFE)
 D BMES^XPDUTL("     *******************************************************")
 D BMES^XPDUTL("     The patch post installation process is complete.       ")
 D BMES^XPDUTL("          The DEA data migration was successful.            ")
 D BMES^XPDUTL("     *******************************************************")
 Q
 ;
GET(FG,DEA) ; Function to Get the Remote DEA information, Return in FG.
 N DATA,ERRORS,PATH,REQUEST,RESOURCE,RESPJSON,RESPONSE,SC,SERVER,SERVICE,PSOERR
 Q:$G(DEA)="" "0^No DEA Number Entered."
 S SERVER="PSO DOJ/DEA WEB SERVER"
 S SERVICE="PSO DOJ/DEA WEB SERVICE"
 S RESOURCE=DEA
 ;
 ; Get an instance of the REST request object.
 S REQUEST=$$GETREST^XOBWLIB(SERVICE,SERVER)
 ;
 ; Execute the HTTP Get method.
 S SC=$$GET^XOBWLIB(REQUEST,RESOURCE,.PSOERR,0)
 I 'SC Q "0^General Service Error"_PSOERR.code
 ;
 ; Process the response.
 S RESPONSE=REQUEST.HttpResponse
 S DATA=RESPONSE.Data
 S RESPJSON=""
 F  Q:DATA.AtEnd  Set RESPJSON=RESPJSON_DATA.ReadLine()
 S RESPJSON=$TR(RESPJSON,$C(10),"")
 I RESPJSON="" Q "0^No DEA Found."
 ;
 ; Decode the JSON format into a MUMPS global in FG
 D DECODE^XLFJSON("RESPJSON","FG","ERRORS")
 ;
 ; Default the businessActivitySubcode.
 I $G(FG("businessActivitySubcode"))="" S FG("businessActivitySubcode")=0
 ;
 Q "1^Success"
 ;
LOG(FG,NPIEN,PHANDLE,REASON,DEA,EXCNT) ; -- Log import issues
 N CNT,FLD,IENS,TR
 ;
 N EXCNUM S EXCNUM=$O(^XTMP(PHANDLE,"PROVIDER",NPIEN,"DEA",DEA,999),-1)+1
 S ^XTMP(PHANDLE,"PROVIDER",NPIEN,"DEA",DEA,EXCNUM)=REASON
 S EXCNT=$G(EXCNT)+1
 ;
 Q
 ;
DEAFILE(DEA,NPIEN,PHANDLE,FG,DEAIEN,EXCNT) ; -- File the import data in DEA NUMBERS FILE #8991.9
 ; POSTAL^XIPUTL used in agreement with Integration Agreement: 3618
 N ED,FDA,IENS,IENROOT,MSGROOT,NPDETOX,SC,XIP,XSTATE,SCH200,SCHFLD,SCHCNT,BAC,SCH200ST,DUPDXDEA
 N DS S DS=$$UP^XLFSTR($G(FG("drugSchedule")))
 S SC="1^SUCCESS"
 S IENS=$S($D(DEAIEN):DEAIEN_",",1:"+1,")
 S FDA(1,8991.9,IENS,.01)=DEA
 S FDA(1,8991.9,IENS,.02)=$G(FG("businessActivityCode"))_$G(FG("businessActivitySubcode")) ; Pointer to file #8991.8
 S BAC=$G(FG("businessActivityCode"))_$G(FG("businessActivitySubcode"))
 S FDA(1,8991.9,IENS,.03)=$S($$DETOXCHK^PSODEAUT(BAC):"X"_$E(DEA,2,9),1:"")    ; DETOX NUMBER
 ;
 ; DETOX DIFFERENCE LOGGING BUT NOT QUITTING
 S NPDETOX=$$GET1^DIQ(200,NPIEN_",",53.11)
 I NPDETOX'="",'$$DETOXCHK^PSODEAUT(BAC) D LOG(.FG,NPIEN,PHANDLE,"DETOX NUMBER "_NPDETOX_" DOESN'T MATCH BUSINESS ACTIVITY CODE.",DEA)
 I NPDETOX'="",$$DETOXCHK^PSODEAUT(BAC),NPDETOX'=("X"_$E(DEA,2,9)) D LOG(.FG,NPIEN,PHANDLE,"DETOX MISMATCH-LOCAL:'"_NPDETOX_"' CALCULATED:'"_"X"_$E(DEA,2,9)_"'",DEA,.EXCNT)
 N CMPDETOX S CMPDETOX=$G(FDA(1,8991.9,IENS,.03))
 I CMPDETOX'="" I $$DETOXDUP^PSODEAUT(DEA,CMPDETOX,.DUPDXDEA) D LOG(.FG,NPIEN,PHANDLE,"DETOX number duplicate "_CMPDETOX_" not filed.",DEA,.EXCNT) D
 . S FDA(1,8991.9,IENS,.03)=""   ; Don't file duplicate DETOX
 ;
 S FDA(1,8991.9,IENS,.04)=$G(FG("expirationDate"))
 S FDA(1,8991.9,IENS,.06)=1  ; Setting all providers = INPATIENT for initial load.
 S FDA(1,8991.9,IENS,.07)=2  ; Setting all providers = INDIVIDUAL for initial load.
 S FDA(1,8991.9,IENS,1.1)=$G(FG("name"))
 S FDA(1,8991.9,IENS,1.2)=$G(FG("additionalCompanyInfo"))
 S FDA(1,8991.9,IENS,1.3)=$G(FG("address1"))
 S FDA(1,8991.9,IENS,1.4)=$G(FG("address2"))
 S FDA(1,8991.9,IENS,1.5)=$G(FG("city"))
 ;
 ; Special State Processing
 D POSTAL^XIPUTIL($G(FG("zipCode")),.XIP)
 S XSTATE=$G(XIP("STATE"))
 I XSTATE'="" S FDA(1,8991.9,IENS,1.6)=XSTATE ; Pointer to the State File #5.
 ;
 S FDA(1,8991.9,IENS,1.7)=$G(FG("zipCode"))
 ;
 D GETS^DIQ(200,NPIEN_",","55.1:55.6","I","SCH200")
 S SCH200ST=""
 S SCHCNT=0 F SCHFLD=55.1:.1:55.6 S SCHCNT=SCHCNT+SCH200(200,NPIEN_",",SCHFLD,"I")
 S $E(SCH200ST)=$S($G(SCH200(200,NPIEN_",",55.1,"I")):2,1:" ")
 S $E(SCH200ST,2,3)=$S($G(SCH200(200,NPIEN_",",55.2,"I")):"2N",1:"  ")
 S $E(SCH200ST,4)=$S($G(SCH200(200,NPIEN_",",55.3,"I")):3,1:" ")
 S $E(SCH200ST,5,6)=$S($G(SCH200(200,NPIEN_",",55.4,"I")):"3N",1:"  ")
 S $E(SCH200ST,7)=$S($G(SCH200(200,NPIEN_",",55.5,"I")):4,1:" ")
 S $E(SCH200ST,8)=$S($G(SCH200(200,NPIEN_",",55.6,"I")):5,1:" ")
 ;
 D:SCHCNT
 . S FDA(1,8991.9,IENS,2.1)=$S(SCH200(200,NPIEN_",",55.1,"I"):"Y",1:"N")    ; SCHEDULE II NARCOTIC
 . S FDA(1,8991.9,IENS,2.2)=$S(SCH200(200,NPIEN_",",55.2,"I"):"Y",1:"N")    ; SCHEDULE II NON-NARCOTIC
 . S FDA(1,8991.9,IENS,2.3)=$S(SCH200(200,NPIEN_",",55.3,"I"):"Y",1:"N")    ; SCHEDULE III NARCOTIC
 . S FDA(1,8991.9,IENS,2.4)=$S(SCH200(200,NPIEN_",",55.4,"I"):"Y",1:"N")    ; SCHEDULE III NON-NARCOTIC
 . S FDA(1,8991.9,IENS,2.5)=$S(SCH200(200,NPIEN_",",55.5,"I"):"Y",1:"N")    ; SCHEDULE IV
 . S FDA(1,8991.9,IENS,2.6)=$S(SCH200(200,NPIEN_",",55.6,"I"):"Y",1:"N")    ; SCHEDULE V
 . I $TR(SCH200ST," ")'=$TR(DS," ") D LOG(.FG,NPIEN,PHANDLE,"SCHEDULE MISMATCH-LOCAL:'"_$TR(SCH200ST," ")_"' DOJ:'"_$TR(DS," ")_"'",DEA,.EXCNT)
 ;
 D:'SCHCNT
 . S FDA(1,8991.9,IENS,2.1)=$S(DS["22N":"Y",(DS["2"&(DS'["2N")):"Y",1:"N") ; SCHEDULE II NARCOTIC
 . S FDA(1,8991.9,IENS,2.2)=$S(DS["2N":"Y",1:"N")                          ; SCHEDULE II NON-NARCOTIC
 . S FDA(1,8991.9,IENS,2.3)=$S(DS["33N":"Y",(DS["3"&(DS'["3N")):"Y",1:"N") ; SCHEDULE III NARCOTIC
 . S FDA(1,8991.9,IENS,2.4)=$S(DS["3N":"Y",1:"N")                          ; SCHEDULE III NON-NARCOTIC
 . S FDA(1,8991.9,IENS,2.5)=$S(DS["4":"Y",1:"N")                           ; SCHEDULE IV
 . S FDA(1,8991.9,IENS,2.6)=$S(DS["5":"Y",1:"N")                           ; SCHEDULE V
 . I $TR(DS," ") D LOG(.FG,NPIEN,PHANDLE,"SCHEDULE MISMATCH-LOCAL:'"_$TR(SCH200ST," ")_"' DOJ:'"_$TR(DS," ")_"'",DEA,.EXCNT)
 ;
 S FDA(1,8991.9,IENS,10.2)="N"  ; LAST UPDATED DATE/TIME
 ; LAST DOJ UPDATE DATE/TIME not sent by DOJ - presence indicates DOJ update (not manually entered)
 S FDA(1,8991.9,IENS,10.3)="N"   ; LAST DOJ UPDATE DATE/TIME
 ;
 D UPDATE^DIE("E","FDA(1)","IENROOT","MSGROOT")
 I $D(MSGROOT) S SC="0^DATA NOT FILED. "_$G(MSGROOT("DIERR",1,"TEXT",1)) Q SC
 S DEAIEN=$S($D(IENROOT(1)):IENROOT(1),1:IENS)
 I 'DEAIEN S SC="0^DATA NOT FILED." Q SC
 S FDA(2,8991.9,DEAIEN,10.1)=DUZ D FILE^DIE("","FDA(2)","MSGROOT")
 Q SC
 ;
NPFILE(DEA,NPIEN,DEAIEN,FILERR) ; -- File the DEA NUMBER in the NEW PERSON FILE #200.
 N FDA,IENROOT,MSGROOT
 Q:'$G(NPIEN)  Q:'$G(DEAIEN)
 S FDA(1,200.5321,"+1,"_NPIEN_",",.01)=DEA
 S FDA(1,200.5321,"+1,"_NPIEN_",",.02)=""
 S FDA(1,200.5321,"+1,"_NPIEN_",",.03)=+DEAIEN
 D UPDATE^DIE("","FDA(1)","IENROOT","MSGROOT")
 I $D(MSGROOT) S FILERR=$G(MSGROOT("DIERR",1,"TEXT",1)) I FILERR="" S FILERR="MIGRATION DATA NOT FILED"
 Q
 ;
INITXTMP(NAMESPC,TITLE,LIFE)  ; -- Initialize ^XTMP according to SAC standards.
 N BEGDT,PURGDT
 S BEGDT=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGDT,LIFE)
 S NAMESPC=NAMESPC_"-"_BEGDT_"-"_$J
 S ^XTMP(NAMESPC,0)=PURGDT_"^"_BEGDT_"^"_TITLE
 S ^XTMP(NAMESPC,"START")=BEGDT
 Q NAMESPC
 ;
TMPMSG(EXCNT,MIGRCNT,LIFE)  ; Send MailMan LOG REPORT
 N CNT,OBJ,PHANDLE,XMSUB,XMDUZ,PSOCNT,PSODASH,EXREAS,PSOXMD,PSOLDXMD,PSOSTART,PSODONE
 S $P(PSODASH,"-",80)=""
 S PHANDLE=$O(^XTMP("PSODEAWB"_"-"_($H+1)),-1)
 S ^XTMP(PHANDLE,"COMPLETE")=$$NOW^XLFDT
 S PSOXMD=$$INITXTMP("PSOXMD","DEA INITIAL IMPORT",$S($G(LIFE):LIFE,1:90))
 S PSOLDXMD=$O(^XTMP("PSOXMD")) I PSOLDXMD["PSOXMD" K ^XTMP(PSOLDXMD)
 S XMSUB="DEA Migration Complete "_$$FMTE^XLFDT(DT,"5DZ"),XMDUZ=.5
 K XMY S NPIEN=0 F  S NPIEN=$O(^XUSEC("PSDMGR",NPIEN)) Q:'+NPIEN  S XMY(NPIEN)=""
 K PSOTEXT
 ;
 S PSOSTART=$G(^XTMP(PHANDLE,"START")) I PSOSTART S PSOSTART=$$FMTE^XLFDT(PSOSTART)
 S PSODONE=$G(^XTMP(PHANDLE,"COMPLETE")) I PSODONE S PSODONE=$$FMTE^XLFDT(PSODONE)
 S ^XTMP(PSOXMD,$J,1,0)=$S($L(PSOSTART):"   DEA Migration Started: "_$$FMTE^XLFDT(PSOSTART),1:"")
 S ^XTMP(PSOXMD,$J,2,0)=$S($L(PSODONE):" DEA Migration Completed: "_$$FMTE^XLFDT(PSODONE),1:"")
 S ^XTMP(PSOXMD,$J,3,0)=""
 S ^XTMP(PSOXMD,$J,4,0)=" "_MIGRCNT_" DEA numbers were migrated from the NEW PERSON (#200) file"
 S ^XTMP(PSOXMD,$J,5,0)=" to the DEA NUMBERS (#8991.9) file. "
 S ^XTMP(PSOXMD,$J,6,0)=" "
 S ^XTMP(PSOXMD,$J,7,0)=" "_EXCNT_" exceptions were logged during the DEA migration."
 S ^XTMP(PSOXMD,$J,8,0)=" Use the DEA Migration Report [PSO DEA MIGRATION REPORT] option"
 S ^XTMP(PSOXMD,$J,9,0)=" to view migration and exception details."
 ;
 S XMY(DUZ)="" N DIFROM S XMTEXT="^XTMP("""_PSOXMD_""","_$J_"," D ^XMD K DIFROM
 K PSOTEXT,XMTEXT
 ;
 Q
