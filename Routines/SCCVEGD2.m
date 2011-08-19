SCCVEGD2 ;ALB/MJK - Estimate Summary ; 30-NOV-1998
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
EN ; -- main entry point for SCCV GLOBAL ESTIMATE SUMMARY
 N SCDET,DIR
 S DIR(0)="YA",DIR("B")="No",DIR("A")="Include CST Detail? "
 D ^DIR
 K DIR
 IF $D(DIRUT) G ENQ
 S SCDET=+Y
 D EN^VALM("SCCV CONV ESTIMATE SUMMARY")
ENQ Q
 ;
HDR ; -- header code
 ;S VALMHDR(1)=" "
 Q
 ;
INIT ; -- init variables and list array
 N SCLINE,SCNT
 S (SCNT,SCLINE)=0
 D GLOBAL
 D ENTRY
 D MOD
 D PER
 D FOOTER
 S VALMCNT=SCNT,VALMBG=1
 IF 'SCDET D
 . D CHGCAP^VALM("CST","    ")
 . D CHGCAP^VALM("START DATE","          ")
 Q
 ;
SET(STR) ; -- set line in array
 S SCLINE=SCLINE+1
 S SCNT=SCNT+1
 D SET^VALM10(SCLINE,STR)
 Q
 ;
SECT(STR) ; -- set section hdr in array
 N Y
 S Y=""
 S Y=$$SETSTR^VALM1(STR,Y,2,$L(STR))
 D SET(Y)
 D CNTRL^VALM10(SCLINE,2,$L(STR),IORVON,IORVOFF)
 Q
 ;
GLOBAL ; -- build global growth lines
 N SCI,DIC,DR,DIQ,DA,X,Y,Z,SCTOT,SCSTDT,FLD
 S DIC=404.98,DR=".03;207:211",DIQ="SCDATA",DIQ(0)="IE"
 S SCI=0
 ;
 D SECT("Global Block Growth")
 ;
 S SCSTDT=0
 F  S SCSTDT=$O(^SD(404.98,"C",SCSTDT)) Q:'SCSTDT  D
 . F  S SCI=$O(^SD(404.98,"C",SCSTDT,SCI)) Q:'SCI  S X=$G(^SD(404.98,SCI,0)) D
 . . N SCDATA
 . . IF $P(X,U,9) Q  ; -- canceled
 . . S DA=SCI D EN^DIQ1
 . . S Y=""
 . . S Y=$$SETFLD^VALM1($J(SCI,4),Y,"CST")
 . . S Y=$$SETFLD^VALM1($$FMTE^XLFDT(SCDATA(404.98,SCI,.03,"I"),"5ZD"),Y,"START DATE")
 . . D FLDUPD("SCE",207,.Y)
 . . D FLDUPD("AUPNVSIT",208,.Y)
 . . D FLDUPD("AUPNVPRV",209,.Y)
 . . D FLDUPD("AUPNVPOV",210,.Y)
 . . D FLDUPD("AUPNVCPT",211,.Y)
 . . IF SCDET D SET(Y)
 ;
 S Y=" Total Blocks"
 D TOTUPD("SCE",207,.Y)
 D TOTUPD("AUPNVSIT",208,.Y)
 D TOTUPD("AUPNVPRV",209,.Y)
 D TOTUPD("AUPNVPOV",210,.Y)
 D TOTUPD("AUPNVCPT",211,.Y)
 D SET(Y)
 D CNTRL^VALM10(SCLINE,1,79,IOINHI,IOINORM)
 ;
 S Z=0 F FLD=207:1:211 S Z=Z+$G(SCTOT(FLD))
 D SET(" (Grand Total:  "_$FN(Z,",")_")")
 D CNTRL^VALM10(SCLINE,1,79,IOINHI,IOINORM)
 D SET(" ")
 Q
 ;
ENTRY ; -- build new entry lines
 N SCI,DIC,DR,DIQ,DA,X,Y,Z,SCTOT,SCSTDT
 S DIC=404.98,DR=".03;2.07:2.11",DIQ="SCDATA",DIQ(0)="IE"
 S SCI=0
 ;
 D SECT("New Entries")
 ;
 S SCSTDT=0
 F  S SCSTDT=$O(^SD(404.98,"C",SCSTDT)) Q:'SCSTDT  D
 . F  S SCI=$O(^SD(404.98,"C",SCSTDT,SCI)) Q:'SCI  S X=$G(^SD(404.98,SCI,0)) D
 . . N SCDATA
 . . IF $P(X,U,9) Q  ; -- canceled
 . . S DA=SCI D EN^DIQ1
 . . S Y=""
 . . S Y=$$SETFLD^VALM1($J(SCI,4),Y,"CST")
 . . S Y=$$SETFLD^VALM1($$FMTE^XLFDT(SCDATA(404.98,SCI,.03,"I"),"5ZD"),Y,"START DATE")
 . . D FLDUPD("SCE",2.07,.Y)
 . . D FLDUPD("AUPNVSIT",2.08,.Y)
 . . D FLDUPD("AUPNVPRV",2.09,.Y)
 . . D FLDUPD("AUPNVPOV",2.10,.Y)
 . . D FLDUPD("AUPNVCPT",2.11,.Y)
 . . IF SCDET D SET(Y)
 ;
 S Y=" Total Entries"
 D TOTUPD("SCE",2.07,.Y)
 D TOTUPD("AUPNVSIT",2.08,.Y)
 D TOTUPD("AUPNVPRV",2.09,.Y)
 D TOTUPD("AUPNVPOV",2.10,.Y)
 D TOTUPD("AUPNVCPT",2.11,.Y)
 D SET(Y)
 D CNTRL^VALM10(SCLINE,1,79,IOINHI,IOINORM)
 D SET(" ")
 Q
MOD ; -- build modified entry lines
 N SCI,DIC,DR,DIQ,DA,X,Y,Z,SCTOT,SCSTDT
 S DIC=404.98,DR=".03;2.07:2.08",DIQ="SCDATA",DIQ(0)="IE"
 S SCI=0
 ;
 D SECT("Modified Entries")
 ;
 S SCSTDT=0
 F  S SCSTDT=$O(^SD(404.98,"C",SCSTDT)) Q:'SCSTDT  D
 . F  S SCI=$O(^SD(404.98,"C",SCSTDT,SCI)) Q:'SCI  S X=$G(^SD(404.98,SCI,0)) D
 . . N SCDATA,Z
 . . IF $P(X,U,9) Q  ; -- canceled
 . . S DA=SCI D EN^DIQ1
 . . S Y=""
 . . S Y=$$SETFLD^VALM1($J(SCI,4),Y,"CST")
 . . S Y=$$SETFLD^VALM1($$FMTE^XLFDT(SCDATA(404.98,SCI,.03,"I"),"5ZD"),Y,"START DATE")
 . . S Z=SCDATA(404.98,SCI,2.08,"E")-SCDATA(404.98,SCI,2.07,"E")
 . . S Y=$$SETFLD^VALM1($J($FN(Z,","),11),Y,"SCE")
 . . S SCTOT(2.07)=$G(SCTOT(2.07))+Z
 . . IF SCDET D SET(Y)
 ;
 S Y=" Total Entries"
 D TOTUPD("SCE",2.07,.Y)
 D SET(Y)
 D CNTRL^VALM10(SCLINE,1,79,IOINHI,IOINORM)
 D SET(" ")
 Q
 ;
PER ; -- build blocks per records lines
 N Y,SCDATA
 D ESTGROW^SCCVEGU1("SCDATA")
 ;
 D SECT("Global Block Estimates per Entry")
 ;
 S Y=" New Entries"
 S Y=$$SETFLD^VALM1($J(SCDATA("SCE","NEW"),11),Y,"SCE")
 S Y=$$SETFLD^VALM1($J(SCDATA("AUPNVSIT"),11),Y,"AUPNVSIT")
 S Y=$$SETFLD^VALM1($J(SCDATA("AUPNVPRV"),11),Y,"AUPNVPRV")
 S Y=$$SETFLD^VALM1($J(SCDATA("AUPNVPOV"),11),Y,"AUPNVPOV")
 S Y=$$SETFLD^VALM1($J(SCDATA("AUPNVCPT"),11),Y,"AUPNVCPT")
 D SET(Y)
 D CNTRL^VALM10(SCLINE,1,79,IOINHI,IOINORM)
 ;
 S Y=" Updated Entries"
 S Y=$$SETFLD^VALM1($J(SCDATA("SCE","UPD"),11),Y,"SCE")
 D SET(Y)
 D CNTRL^VALM10(SCLINE,1,79,IOINHI,IOINORM)
 Q
 ;
FOOTER ; -- build general info footer
 D SET(" ")
 D SET(" ")
 D SET(" Note: Estimates are assuming the following:")
 D SET("                  Block Size: "_$$BLKSIZE^SCCVEGU1()_" bytes")
 D SET("           Global Efficiency: 70%")
 Q
 ;
FLDUPD(NAME,FLD,STR) ; -- update line with field info
 N Z
 S Z=SCDATA(404.98,SCI,FLD,"E")
 S STR=$$SETFLD^VALM1($J($FN(Z,","),11),STR,NAME)
 S SCTOT(FLD)=$G(SCTOT(FLD))+Z
 Q
 ;
TOTUPD(NAME,FLD,STR) ; -- update total line with field total
 S STR=$$SETFLD^VALM1($J($FN(+$G(SCTOT(FLD)),","),11),STR,NAME)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("SCCV GESTIMATE",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
