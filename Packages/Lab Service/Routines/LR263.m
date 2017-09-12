LR263 ;DALOI/FHS - LR*5.2*263 PATCH ENVIRONMENT CHECK & CONVERT ROUTINE ; 5/1/99 ;
 ;;5.2;LAB SERVICE;**263**;Sep 27, 1994
EN ; Does not prevent loading of the transport global.
 ; Environment check is done only during the install.
 Q:'$G(XPDENV)
 D CHECK
 D EXIT
 Q
 ;
CHECK ; Perform environment check
 N VER
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D
 . D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device is not defined",80))
 . S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D
 . D BMES^XPDUTL($$CJ^XLFSTR("Please log in to set local DUZ... variables",80))
 . S XPDQUIT=2
 I '$D(^VA(200,$G(DUZ),0))#2 D
 . D BMES^XPDUTL($$CJ^XLFSTR("You are not a valid user on this system",80))
 . S XPDQUIT=2
 S VER=$$VERSION^XPDUTL("LA7")
 I VER'>5.1 D
 . D BMES^XPDUTL($$CJ^XLFSTR("You must have LAB MESSAGING PACKAGE V5.2 Installed",80))
 . S XPDQUIT=2
 S VER=$$VERSION^XPDUTL("LR")
 I VER'>5.1 D
 . D BMES^XPDUTL($$CJ^XLFSTR("You must have LAB SERVICE PACKAGE V5.2 Installed",80))
 . S XPDQUIT=2
LMI ;
 N DIC,X,Y
 S DIC=3.8,DIC(0)="NMXO",X="LMI" D ^DIC
 I Y<1 D
 . D BMES^XPDUTL($$CJ^XLFSTR("You must have Mail Group [ LMI ] defined.",80))
 . S XPDQUIT=2
 Q:$G(XPDQUIT)<1
 S XPDIQ("XPZ1","B")="NO"
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Install Environment Check FAILED ---",80))
 I '$G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",80))
 Q
CONV ;Convert data to new DD structure
 K ^TMP("LRCPT",$J),^TMP("LRCPT@",$J),LRDA,LRROOT,LRDEL,LRTXT
 K ^TMP("LRCPTERR",$J)
 S LRMSG="^TMP(""LRCPT"","_$J_")",CNT=0
 S LRSUB="LRCPTERR",$P(LRTXT(5),"=",40)="",LRTXT(4)=""
 S LRDA(1)=0 F  S LRDA(1)=$O(^LAM(LRDA(1))) Q:LRDA(1)<1  D
 . S LRDA=0 F  S LRDA=$O(^LAM(LRDA(1),4,LRDA)) Q:LRDA<1  D
 . . I '$D(^LAM(LRDA(1),4,LRDA,0)) K ^LAM(LRDA(1),4,LRDA) Q
 . . S LRN=^LAM(LRDA(1),4,LRDA,0)
 . . K LRROOT
 . . S LRS=$P(LRN,U,2) I '$L(LRS) D BMES^XPDUTL($$CJ^XLFSTR("DATA BASE ERROR",80)) D DEL Q
 . . S:LRS="L" LRS="LOINC"
 . . S LRROOT(64.018,$$IENS^DILF(.LRDA),.01)=LRS_"."_+$P(LRN,U) D UPDATE
MAIL ;Send message to G.LMI local mail group
 I '$O(^TMP(LRSUB,$J,0)) D BMES^XPDUTL($$CJ^XLFSTR("No CPT Errors were found - No Mail message required.",80))
 I $O(^TMP(LRSUB,$J,0)) D
 . D BMES^XPDUTL($$CJ^XLFSTR("Creating Mail Message containing CPT Changes",80))
 . D BMES^XPDUTL($$CJ^XLFSTR("Sending message to LMI Mail Group.",80))
 . N DIFROM,XMSUB,XMDUZ,XMTEXT,XMY
 . S XMSUB="WKLD CODE - CODE CHECK REPORT "_$$FMTE^XLFDT($$NOW^XLFDT,"1S")
 . S XMY("G.LMI")="",XMTEXT="^TMP(""LRCPTERR"","_$J_",",XMDUZ=.5
 . D ^XMD
 D LNK6064
 S:$D(^LAM(0))#2 $P(^(0),U,3)=99999
PUNCT ;Make venipuncture WKLD CODE(s) billable
 D
 . N DIC,X,Y
 . S DIC="^LAM(",DIC(0)="ONMX"
 . F X="89343.0000","89341.0000" D ^DIC I Y>1 D
 . . I $D(^LAM(+Y,0))#2 S $P(^(0),U,5)=1
END ;
 Q:$G(LRDBUG)
 K ^LRO(69,"AE"),^LRO(69,"AA",0)
 K ^TMP("LRCPT",$J),^TMP("LRCPT@",$J),^TMP("LRCPTERR",$J)
 K CNT,I,LRCMT,LRDA,LRDEL,LRMSG,LRN,LRROOT,LRS,LRSUB,LRTXT,SUB,TXT
 K XMDUZ,XMSUB,XMTEXT,XMY
 Q
LNK6064 ; Relink NATIONAL VA LAB CODE with WKLD CODE file
 D BMES^XPDUTL($$CJ^XLFSTR("Relinking NATIONAL VA LAB CODES TO WKLD CODES",80))
 N CNT,CNTT,RT,IEN,LR64,CODE,NAME,DATA,LRX,I
 S I=0 F  S I=$O(^LAM(I)) Q:I<1  K ^LAM(I,7)
 K ^LAM("AE","LAB(60,")
 S (CNTT,CNT)=0
 S LRX=0 F  S LRX=$O(^LAB(60,LRX)) Q:LRX<1  D
 . S CODE=+$P($G(^LAB(60,LRX,64)),U)
 . Q:'$D(^LAM(CODE,0))#2    ; no code to update
 . S NAME=$P(^LAB(60,LRX,0),U)
 . S CNT=CNT+1 K ERR,RT,IEN
 . S DATA="LAB(60,.`"_LRX,CNTT=CNTT+1
 . S IEN="+1,"_CODE_",",RT(64.023,IEN,.01)=DATA
 . D UPDATE^DIE("ES","RT","IEN","^LAH(""ERR243"")")
 . W "."
 Q
UPDATE ;
 S CNT=$G(CNT)+1
 D FILE^DIE("E","LRROOT","^TMP(""LRCPT"","_$J_","_CNT_")")
 I $D(LRROOT) W ! D DEL Q
 W:'$D(ZTQUEUED) "."
 Q
DEL K LRDEL
 N LRNOP
 S LRTXT(2)="Removing "_LRS_" Code "_$P(LRN,U) D BMES^XPDUTL(LRTXT(2))
 I $D(^LAM(LRDA(1),0))#2 S LRTXT(3)="From "_$P(^LAM(LRDA(1),0),U,2)_"  "_$S($P(^(0),U,5):"+",1:"")_$P(^(0),U)
 E  S LRTXT(3)="DATABASE ERROR FOR ENTRY "_LRDA(1),LRNOP=1
 S LRTXT(4)=$$FMTE^XLFDT($$NOW^XLFDT)
 D BMES^XPDUTL(LRTXT(3))
 S LRDEL(64.018,$$IENS^DILF(.LRDA),.01)="@"
 D:'$G(LRNOP) FILE^DIE("E","LRDEL","TMP(""LRCPT@"","_$J_","_CNT_")")
 D MSGSET(LRSUB,.LRTXT)
 I '$G(LRNOP) D WP^DIE(64,LRDA(1)_",",24,"A","LRTXT","TMP(""LRCPT@"","_$J_","_CNT_")")
 Q
MSGSET(SUB,TXT) ;SUB=subscript - TXT = array containing the message
 N I        ;
 S LRCMT=$P($G(^TMP(SUB,$J,0)),U,4)
 S I=0 F  S I=$O(TXT(I)) Q:I<1  D
 . S LRCMT=LRCMT+1,^TMP(SUB,$J,LRCMT,0)=TXT(I)
 S $P(^TMP(SUB,$J,0),U,4)=LRCMT
 Q
