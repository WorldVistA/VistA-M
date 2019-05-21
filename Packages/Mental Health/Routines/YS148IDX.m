YS148IDX ;SLC/KCM - Re-index "AC" in MH RESULTS and MH ANSWERS ; 03/28/2019
 ;;5.01;MENTAL HEALTH;**148**;Dec 30, 1994;Build 8
 ;
REIDX ; Re-indexing Task
 N YS148CNT,YS148MSG
 S YS148CNT=0
 K ^XTMP("YTS-RE-INDEX")
 S ^XTMP("YTS-RE-INDEX",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Re-Index Results"
 D UPD("Removing bad nodes from MH RESULTS AC index"),FIX92
 D UPD("Removing bad nodes from MH ANSWERS AC index"),FIX85AC
 D UPD("Removing bad nodes from MH ANSWERS AD index"),FIX85AD
 D UPD("Adding missing nodes to MH RESULTS AC index"),RESET92
 D UPD("Adding missing nodes to MH ANSWERS AC index"),RESET85C
 D UPD("Adding missing nodes to MH ANSWERS AD index"),RESET85D
 S YS148MSG=$$FMTE^XLFDT($$NOW^XLFDT)
 S YS148MSG=YS148CNT_" index errors found & resolved on: "_YS148MSG
 D UPD(YS148MSG)
 D NOTIFY(YS148MSG)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 ; -- these tags remove any index nodes that are incorrect
 ;
FIX85AC ; Remove bad "AC" indexes from MH ANSWERS
 N ADMIN,QSTN,IEN,X0
 S ADMIN=0 F  S ADMIN=$O(^YTT(601.85,"AC",ADMIN)) Q:'ADMIN  D
 . S QSTN=0 F  S QSTN=$O(^YTT(601.85,"AC",ADMIN,QSTN)) Q:'QSTN  D
 . . S IEN=0 F  S IEN=$O(^YTT(601.85,"AC",ADMIN,QSTN,IEN)) Q:'IEN  D
 . . . ; if IEN doesn't exist, remove index
 . . . I '$D(^YTT(601.85,IEN,0)) D RM85AC(ADMIN,QSTN,IEN) QUIT
 . . . S X0=$G(^YTT(601.85,IEN,0))
 . . . ; if ADMIN doesn't match, remove index
 . . . I $P(X0,U,2)'=ADMIN D RM85AC(ADMIN,QSTN,IEN) QUIT
 . . . ; if QSTN doesn't match, remove index
 . . . I $P(X0,U,3)'=QSTN D RM85AC(ADMIN,QSTN,IEN) QUIT
 Q
RM85AC(ADMIN,QSTN,IEN) ; remove bad index
 K ^YTT(601.85,"AC",ADMIN,QSTN,IEN)
 D LOG("85AC",ADMIN,QSTN,IEN)
 Q
FIX85AD ; Remove bad "AD" indexes from MH ANSWERS
 N ADMIN,IEN,X0
 S ADMIN=0 F  S ADMIN=$O(^YTT(601.85,"AD",ADMIN)) Q:'ADMIN  D
 . S IEN=0 F  S IEN=$O(^YTT(601.85,"AD",ADMIN,IEN)) Q:'IEN  D
 . . ; if IEN doesn't exist, remove index
 . . I '$D(^YTT(601.85,IEN,0)) D RM85AD(ADMIN,IEN) QUIT
 . . S X0=$G(^YTT(601.85,IEN,0))
 . . ; if ADMIN doesn't match, remove index
 . . I $P(X0,U,2)'=ADMIN D RM85AD(ADMIN,IEN) QUIT
 Q
RM85AD(ADMIN,IEN) ; remove bad index
 K ^YTT(601.85,"AD",ADMIN,IEN)
 D LOG("85AD",ADMIN,"",IEN)
 Q
FIX92 ; Remove bad indexes from MH RESULTS
 N ADMIN,IEN
 S ADMIN=0 F  S ADMIN=$O(^YTT(601.92,"AC",ADMIN)) Q:'ADMIN  D
 . S IEN=0 F  S IEN=$O(^YTT(601.92,"AC",ADMIN,IEN)) Q:'IEN  D
 . . ; if IEN doesn't exist, remove index
 . . I '$D(^YTT(601.92,IEN,0)) D RM92AC(ADMIN,IEN) QUIT
 . . ; if ADMIN doesn't match, remove index
 . . I $P($G(^YTT(601.92,IEN,0)),U,2)'=ADMIN D RM92AC(ADMIN,IEN)
 Q
RM92AC(ADMIN,IEN) ; remove bad index
 K ^YTT(601.92,"AC",ADMIN,IEN)
 D LOG("92AC",ADMIN,"",IEN)
 Q
 ;
 ; -- these tags set any index nodes that are missing
 ;
RESET85C ; Rebuild the "AC" index for MH ANSWERS (601.85)
 N ADMIN,QSTN,IEN,X0
 S IEN=0 F  S IEN=$O(^YTT(601.85,IEN)) Q:'IEN  D
 . S X0=$G(^YTT(601.85,IEN,0)),ADMIN=$P(X0,U,2),QSTN=$P(X0,U,3)
 . I 'ADMIN!('QSTN) QUIT                        ; no index if missing data
 . I $D(^YTT(601.85,"AC",ADMIN,QSTN,IEN)) QUIT  ; index is correct
 . N DIK,DA                                     ; set new "AC" index
 . S DIK="^YTT(601.85,",DIK(1)="1^AC",DA=IEN
 . D EN^DIK
 . D LOG("85ACI",ADMIN,QSTN,IEN)
 Q
RESET85D ; Rebuild the "AD" index for MH ANSWERS (601.85)
 N ADMIN,IEN,X0
 S IEN=0 F  S IEN=$O(^YTT(601.85,IEN)) Q:'IEN  D
 . S X0=$G(^YTT(601.85,IEN,0)),ADMIN=$P(X0,U,2)
 . I 'ADMIN QUIT                                ; no index if missing data
 . I $D(^YTT(601.85,"AD",ADMIN,IEN)) QUIT       ; index is correct
 . N DIK,DA                                     ; set new "AD" index
 . S DIK="^YTT(601.85,",DIK(1)="1^AD",DA=IEN
 . D EN^DIK
 . D LOG("85ADI",ADMIN,"",IEN)
 Q
RESET92 ; Rebuild the "AC" index for MH RESULTS (601.92)
 N ADMIN,IEN
 S IEN=0 F  S IEN=$O(^YTT(601.92,IEN)) Q:'IEN  D
 . S ADMIN=+$P($G(^YTT(601.92,IEN,0)),U,2)
 . I 'ADMIN QUIT                                ; no index if admin missing
 . I $D(^YTT(601.92,"AC",ADMIN,IEN)) QUIT       ; index is correct
 . N DIK,DA                                     ; set new "AC" index
 . S DIK="^YTT(601.92,",DIK(1)="1^AC",DA=IEN
 . D EN^DIK
 . D LOG("92ACI",ADMIN,"",IEN)
 Q
 ;
 ; -- status notifications
 ;
LOG(FIX,ADMIN,QSTN,IEN) ; Log fixes
 S YS148CNT=YS148CNT+1
 I '$D(ZTQUEUED) S ^XTMP("YTS-RE-INDEX",YS148CNT)=FIX_U_ADMIN_U_$G(QSTN)_U_IEN
 S ^XTMP("YTS-RE-INDEX","ERRS")=YS148CNT
 Q
UPD(MSG) ; set parameter to current status
 D EN^XPAR("SYS","YS123 RE-INDEX STATUS",1,MSG)
 I '$D(ZTQUEUED) W !,MSG
 Q
NOTIFY(MSG) ; send message to installer
 N XMDUZ,XMSUB,XMTEXT,XMY,XMZ,XMMG,DIFROM,YSTEXT
 S YSTEXT(1)="Re-indexing of the MH RESULTS and MH ANSWERS files has completed"
 S YSTEXT(2)="with the following status:"
 S YSTEXT(3)=" "
 S YSTEXT(4)=MSG
 S XMDUZ="YS*5.01*148 POST INSTALL"
 S XMSUB="Re-Index of Mental Health Results Completed"
 S:$G(DUZ) XMY(DUZ)="" S:$G(YS148IN) XMY(YS148IN)=""
 S XMTEXT="YSTEXT("
 D ^XMD
 Q
 ;
 ; YS123 RE-INDEX MONITOR option
 ;
MONITOR ; Check status of re-index, allows re-queuing
 W !,"MH RESULTS and MH ANSWERS Re-Index Monitor"
 D STATUS
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YA^^"
 S DIR("A")="Do you want to queue re-indexing of MH RESULTS and MH ANSWERS? "
 S DIR("B")="NO"
 S DIR("?")="Answer YES to re-index (only needed if errors are occurring)."
 D ^DIR
 Q:$D(DIRUT)  Q:$D(DIROUT)  Q:'Y
 S DIR(0)="DA^::FR"
 S DIR("A")="Queue Re-Indexing to Run: "
 S DIR("B")="NOW"
 S DIR("?")="Enter the date/time when the re-indexing task should begin"
 D ^DIR
 Q:$D(DIRUT)  Q:$D(DIROUT)  Q:'Y
 D QTASK^YS148PST(Y)
 Q
STATUS ; Loop showing status until done
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 F  D  Q:'Y
 . W !!,"  Status: ",$$GET^XPAR("SYS","YS123 RE-INDEX STATUS",1,"Q")
 . W !,"  Errors Repaired: ",+$G(^XTMP("YTS-RE-INDEX","ERRS")),!
 . S DIR(0)="YA^^"
 . S DIR("A")="Refresh? "
 . S DIR("B")="Yes"
 . D ^DIR
 . I $D(DIRUT)!$D(DIROUT) S Y=0
 Q
