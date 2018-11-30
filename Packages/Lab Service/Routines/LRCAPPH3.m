LRCAPPH3  ;DALOI/FHS/PC - CHECK CPT CODE AND FILE POINTERS ; 5/1/99
 ;;5.2;LAB SERVICE;**263,291**;Sep 27, 1994
 ;Called from LRCAPPH,LRCAPPH4
EN ;
 K ^TMP("LRCAPPH",$J),LRSEP S LRSEP(1)="==================="
 S LRSEP(2)="****************"
 K %DT S %DT="",X="T+5" D ^%DT S LRPGDT=Y
 S ^TMP("LRCAPPH",$J,0)=Y_U_$$NOW^XLFDT_U_"LAB CPT DATA CHECKER"
 S ^TMP("LRCAPPH60",$J,0)=Y_U_$$NOW^XLFDT_U_"LAB 60 CPT DATA CHECKER"
 K %DT S %DT="" S X="T-1" D ^%DT S LRINADT=$$FMTE^XLFDT(Y,1)
 S LRINADTX=Y K %DT
AA  ;Look for CPT processing errors
 D
 . N LRAAN,LRCE,LRTXT,LRX
 . S LRAAN="^LRO(69,""AA"")"
 . F  S LRAAN=$Q(@LRAAN) Q:$QS(LRAAN,2)'="AA"  D
 . . S LRX=@LRAAN Q:'LRX  S LRCE=$QS(LRAAN,3)
 . . K LRTXT
 . . S LRTXT="Lab Order Number "_LRCE_" "
 . . I LRX<1 D
 . . . S LRTXT(1)=LRTXT_" was rejected by the PCE API "
 . . I LRX=2 D
 . . . S LRTXT(1)=LRTXT_"has no Institution for the ordering location."
 . . I LRX=3 D
 . . . S LRTXT(1)=LRTXT_"Provider is InActive."
 . . I LRX=4 D
 . . . S LRTXT(1)=LRTXT_"Not Processed  "
 . . . S LRTXT(2)=" - No DEFAULT LAB OOS LOCATION defined."
 . . I LRX=5 D
 . . . S LRTXT(1)=LRTXT_"Ordering Location "
 . . . S LRTXT(2)=" has no STOP CODE NUMBER defined."
 . . I $D(LRTXT(1)) S LRTXT(10)=LRSEP(1) D MSGSET("LRCAPPH",.LRTXT)
LAM ;Look for inactive Codes and broken pointers.
 ;in ^LAM
 N LRI,LRXDT,LRY,LRII
 S LRI=0 F  S LRI=$O(^LAM(LRI)) Q:LRI<1  D  I '$D(ZTQUEUED) W:'(LRI#50) "."
 . I '$G(LRACT) Q:'$O(^LAM(LRI,7,0))
 . S LRII=0 F  S LRII=$O(^LAM(LRI,4,LRII)) Q:LRII<1  D
 . . I '$G(^LAM(LRI,4,LRII,0)) W:'$D(ZTQUEUED) !,"@@@@@@@@@@@",LRI,! D  Q
 . .  . I '$L($P($G(^LAM(LRI,4,LRII,0)),U)) K ^LAM(LRI,4,LRII) Q
 . .  . N DR,DA,DIE,DIK
 . .  . S DA=LRII,DA(1)=LRI,DIK="^LAM("_LRI_",4," D ^DIK
 . . K LRX S LRX=^LAM(LRI,4,LRII,0) D CK
LAB ;Look for inactive Codes in ^LAB
 N LRJ,LRN,LRSPEC,LRBECPT,MSGTYPE,MSGFLAG,DEFAULT,HCPCS,Y
 S LRJ=0 F  S LRJ=$O(^LAB(60,LRJ)) Q:'LRJ  D
 . S MSGFLAG=0
 . S X=^LAB(60,LRJ,0),LRN=$P(X,U,1)
 . I ($P(X,U,4)'="CH")&($P(X,U,4)'="MI") Q
 . S LRSPEC=0 F  S LRSPEC=$O(^LAB(60,LRJ,1,LRSPEC)) Q:'LRSPEC  D
 . . K LRBECPT
 . . D IACPT(LRJ,DT,LRSPEC)
 . . Q:('$D(LRBECPT(LRJ)))
 . . S X=$O(LRBECPT(LRJ,1,0)) Q:'X
 . . S MSGTYPE="SPECIMEN ("_LRSPEC_") CPT"
 . . D MSG2(MSGTYPE)
 . S X=$G(^LAB(60,LRJ,1.1)) S DEFAULT=$P(X,U,1),HCPCS=$P(X,U,2)
 . I HCPCS D
 . . S MSGTYPE="HCPCS CPT"
 . . S X=HCPCS,Y=$$CPT^ICPTCOD(X,,,) I '$P(Y,U,7) S X=$P(Y,U,2) D MSG2(MSGTYPE)
 . I DEFAULT D
 . . S MSGTYPE="DEFAULT CPT"
 . . S X=DEFAULT,Y=$$CPT^ICPTCOD(X,,,) I '$P(Y,U,7) S X=$P(Y,U,2) D MSG2(MSGTYPE)
 . I MSGFLAG D MSGSET("LRCAPPH60",.LRMSG)
 Q
 ;
IACPT(LRBETST,LRBECDT,LRSPEC) ; Get inactive specimen CPT
 N A,ARR,LRBEAX,LRBEIEN,LRBEAR60,X
 S LRBEIEN=LRSPEC_","_LRBETST_",",(LRI,LRBECPT)=""
 D GETS^DIQ(60.01,LRBEIEN,"96*","I","LRBEAR60")
 S A="" F  S A=$O(LRBEAR60(60.196,A)) Q:A=""  D
 . Q:$G(LRBEAR60(60.196,A,1,"I"))=""
 . S ARR($G(LRBEAR60(60.196,A,1,"I")))=$G(LRBEAR60(60.196,A,.01,"I"))
 S X=$O(ARR(LRBECDT),-1) I X D
 .S LRBEAX=ARR(X)
 .S LRBEAX=$$CPT^ICPTCOD(LRBEAX,LRBECDT)
 .I '$P(LRBEAX,U,7) S LRBECPT(LRBETST,1,$P(LRBEAX,U,2))="SPECIMEN CPT"
 Q
 ;
EN0 ;Entry point for scan 64, scan 60, and mail reports to G.LMI
 ;Called from LRCAPPH
 D EN
 D MAIL
 D MAIL2
END ;Called from LRCAPPH4
 I $E($G(IOST),1,2)="P-" W @IOF
 K DA,DIC,DIE,DIK,DR,I
 K LRACT,LRCMT,LRINADT,LRINADTX,LRI,LRII,LRMSG,LRN,LRPGDT,LRTST,LRSEP,LRX
 K LRTXT,X,XMTEXT,XMSUB,Y
 K ^TMP("LRCAPPH",$J),^TMP("LRCAPPH60",$J)
 D ^%ZISC
 Q
ACTIVE ;Print only WKLD CODES that have associated test assigned
 ;and do not have inactivation dates
 S LRACT=1 D EN0
 Q
CK ;
 I '$G(LRACT) Q:$P(LRX,U,4)
 K X,Y,DIC,LRMSG
 F I=1:1:5 S LRX(I)=$P(LRX,U,I)
 I LRX(2)="CPT" D  Q
 . S X=$P(LRX(1),";")
 . S Y=$$CPT^ICPTCOD(X,,,) I $S('$P(Y,U,7):1,LRX(4):1,1:0) D
 . . S ^TMP("LRCAPPH",$J,"ICPT",X)=""
 . . S Y(0)=$P(Y,U,2,3)_"^^1"
 . . D MSG
 S DIC(0)="XOZ",X=+LRX(1),DIC=U_$P(LRX(1),";",2)
 S:$E(LRX(2))="L" DIC("S")="I '$P($G(^(4)),U)"
 D ^DIC
 I Y<1 D MSG Q
 I $G(LRX(4)) D MSG
 Q
MSG ;
 K LRMSG
 S LRN=^LAM(LRI,0)
 S LRCMT=$P($G(^TMP("LRCAPPH",$J,0)),U,4)+1
 S LRMSG(LRCMT)=$P(LRN,U,2)_" ["_LRI_"]  "_$P(LRN,U),LRCMT=LRCMT+1
 I Y<1 D  Q
 . S LRMSG(LRCMT)="*** Has an invalid "_LRX(2)_" code of "_+X_" ."
 . D TST
 . I '$P(^LAM(LRI,4,LRII,0),U,4) S $P(^(0),U,4)=LRINADTX D
 . . S LRCMT=LRCMT+1,LRMSG(LRCMT)="Inactivation date of "_LRINADT_" has been entered."
 . S LRCMT=LRCMT+1,LRMSG(LRCMT)=LRSEP(1)
 . D MSGSET("LRCAPPH",.LRMSG)
 I $P($G(Y(0)),U,4) D
 . N LRXDT
 . S LRCMT=LRCMT+1,LRMSG(LRCMT)=$P(Y(0),U)_"  "_$P(Y(0),U,2),LRCMT=LRCMT+1
 . S LRMSG(LRCMT)="Is an inactive "_LRX(2)_" code."
 . D TST
 . S:'$P(^LAM(LRI,4,LRII,0),U,4) $P(^(0),U,4)=LRINADTX
 . S LRXDT=$P(^LAM(LRI,4,LRII,0),U,4)
 . S LRCMT=LRCMT+1,LRMSG(LRCMT)="Inactivation date of "_$$FMTE^XLFDT(LRXDT,1)_" has been entered."
 . S LRCMT=LRCMT+1,LRMSG(LRCMT)=LRSEP(2)
 . D MSGSET("LRCAPPH",.LRMSG)
 Q
MAIL ;Send message to G.LMI local mail group
 Q:'$O(^TMP("LRCAPPH",$J,0))
 N DUZ,XMDUZ,XMSUB,XMTEXT
 S LRCMT=$G(LRCMT)+1
 S ^TMP("LRCAPPH",$J,LRCMT,0)="Listing of all offending codes:"
 S LRCMT=$G(LRCMT)+1,^TMP("LRCAPPH",$J,LRCMT,0)=""
 S LRC="^TMP(""LRCAPPH"",$J,""A"")" F  S LRC=$Q(@LRC) Q:$QS(LRC,2)'=$J  D
 . S LRCMT=LRCMT+1,^TMP("LRCAPPH",$J,LRCMT,0)="   "_$QS(LRC,3)_"     "_$QS(LRC,4)
 S XMSUB=" NIGHTLY WKLD CODE CHECK REPORT "_$$FMTE^XLFDT($$NOW^XLFDT,"1S")
 S XMY("G.LMI")="",XMTEXT="^TMP(""LRCAPPH"","_$J_","
 D ^XMD
 Q
TST  ;
 Q:'$O(^LAM(LRI,7,0))
 K LRT N X
 S LRCMT=$G(LRCMT)+1 S LRMSG(LRCMT)="Associated Tests"
 S LRT=0 F  S LRT=$O(^LAM(LRI,7,LRT)) Q:LRT<1  S LRTST=$G(^(LRT,0)) D
 . S X=+LRTST
 . S LRTST="^"_$P(LRTST,";",2)_$P(LRTST,";")_",0)",LRCMT=LRCMT+1
 . S LRMSG(LRCMT)="     "_$P(@LRTST,U)_"  {"_X_"}"
 Q
MSGSET(SUB,TXT) ;SUB=subscript - TXT = array containing the message
 N I        ;
 S LRCMT=$P($G(^TMP(SUB,$J,0)),U,4)
 S I=0 F  S I=$O(TXT(I)) Q:I<1  D
 . S LRCMT=LRCMT+1,^TMP(SUB,$J,LRCMT,0)=TXT(I)
 S $P(^TMP(SUB,$J,0),U,4)=LRCMT
 Q
 ;
MSG2(MSGTYPE) ;
 I 'MSGFLAG D
 . K LRMSG
 . S LRCMT=$P($G(^TMP("LRCAPPH",$J,0)),U,4)+1,LRMSG(LRCMT)="  "
 . S LRCMT=LRCMT+1,LRMSG(LRCMT)=$P(LRN,U,1)_" ["_LRJ_"]"
 S LRCMT=LRCMT+1
 S LRMSG(LRCMT)="*** Has an inactive "_MSGTYPE_" Code of "_X_".",MSGFLAG=1
 Q
 ;
MAIL2 ;Send message to G.LMI local mail group
 N DUZ,XMDUZ,XMSUB,XMTEXT
 Q:'$O(^TMP("LRCAPPH60",$J,0))
 S LRCMT=$G(LRCMT)+1,^TMP("LRCAPPH60",$J,LRCMT,0)="  "
 S XMSUB="NIGHTLY FILE #60 CPT CODE CHECK REPORT "_$$FMTE^XLFDT($$NOW^XLFDT,"1S")
 S XMY("G.LMI")="",XMTEXT="^TMP(""LRCAPPH60"","_$J_","
 D ^XMD
 Q
