SPNLCNV0 ;HISC/DAD-CONVERSION ;11/7/95  12:35
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
 I $O(^SPNL(154,0))'>0 Q
 W !!,"This routine will convert the following fields in the SCD (SPINAL CORD)"
 W !,"REGISTRY file (#154):",!
 W !?3,"Old Fields (V1.0)               New Fields (V1.5)"
 W !?3,"=================               ================="
 W !?3,"REGISTRATION STATUS (154,.03)   REGISTRATION STATUS (154,.03)"
 W !?3,"COMPLETENESS OF NLOI (154,2.2)  COMPLETE / INCOMPLETE (154,6.09)"
 W !?3,"SOURCE OF NLOI (154,2.3)        INFORMATION SOURCE FOR SCD (154,2.3)"
 W !?3,"DATE OF ONSET (154,3.2)         DATE OF ONSET (154.004,.01)"
 W !?3,"ETIOLOGY (154,3.3)              ETIOLOGY (154.004,.02)",!
 W !,"The DATE OF ONSET and ETIOLOGY fields will be converted to a multiple.  The"
 W !,"codes for REGISTRATION STATUS and SOURCE OF NLOI have been changed, the old"
 W !,"values will be converted.  The COMPLETENESS OF NLOI data will be moved to its"
 W !,"new location.  This conversion may be run multiple times without adversely"
 W !,"affecting the database.  When the conversion finishes you will receive a"
 W !,"MailMan message listing any problems found during the conversion process."
 ;
 K DIR S DIR(0)="SOM^R:Run now;Q:Queue later;"
 S DIR("A")="When do you want to do the conversion"
 S DIR("?",1)="   Enter 'R' to run the conversion now"
 S DIR("?",2)="   Enter 'Q' to queue the conversion"
 S DIR("?")="Choose 'R' or 'Q'"
 D ^DIR W ! S SPN=Y I $D(DIRUT) G EXIT
 I SPN="Q" D  G EXIT
 . S ZTRTN="TASK^SPNLCNV0",ZTDESC="SCD Registry conversion",ZTIO=""
 . D ^%ZTLOAD
 . I $G(ZTSK) W !,"Task queued, task number: ",ZTSK
 . E  W !,"Task NOT queued"
 . Q
TASK ;
 I '$D(ZTQUEUED) W !,"Working..."
 D EXIT S SPNERR=0
 D ^SPNLCNV1
 ;
 S SPND0=0
 F  S SPND0=$O(^SPNL(154,SPND0)) Q:SPND0'>0  D
 . I '$D(ZTQUEUED) W "."
 . F SPN=0:1:3 S SPNDATA(SPN)=$G(^SPNL(154,SPND0,SPN))
 . S SPNDFN=+$P(SPNDATA(0),U),SPNDFN(0)=$P($G(^DPT(SPNDFN,0)),U)
 . I SPNDFN(0)="" Q
 . S SPNLCOMP=$P(SPNDATA(2),U,2)
 . S SPNREGST("OLD")=$P(SPNDATA(0),U,3),SPNNLOI("OLD")=$P(SPNDATA(2),U,3)
 . S SPNDATE=$P(SPNDATA(3),U,2),SPNETIOL("OLD")=+$P(SPNDATA(3),U,3)
 . S (SPNREGST("NEW"),SPNNLOI("NEW"))=""
 . I SPNREGST("OLD")]"" S SPNREGST("NEW")=$G(^TMP($J,"SPN REGSTAT",SPNREGST("OLD")))
 . I SPNNLOI("OLD")]"" S SPNNLOI("NEW")=$G(^TMP($J,"SPN NLOI",SPNNLOI("OLD")))
 . I SPNREGST("OLD")]"",SPNREGST("NEW")="" D
 .. S X="Cannot convert REGISTRATION STATUS '"_SPNREGST("OLD")
 .. S X=X_"' for "_SPNDFN(0)_", SCD Registry record #"_SPND0
 .. D ERR(X)
 .. Q
 . I SPNNLOI("OLD")]"",SPNNLOI("NEW")="" D
 .. S X="Cannot convert SOURCE OF NLOI '"_SPNNLOI("OLD")
 .. S X=X_"' for "_SPNDFN(0)_", SCD Registry record #"_SPND0
 .. D ERR(X)
 .. Q
 . I SPNDATE'?7N D  Q  ; *** Bad date of onset
 .. I SPNREGST("OLD")?1N Q
 .. I SPNDATE="" S SPNDATE="<NULL>"
 .. S X="Cannot convert DATE OF ONSET '"_SPNDATE
 .. S X=X_"' for "_SPNDFN(0)_", SCD Registry record #"_SPND0
 .. D ERR(X)
 .. Q
 . D CONV1
 . I $O(^TMP($J,"SPN ETIOLOGY",""))="" Q  ; *** No etiology conv table
 . S SPNETIOL("NEW")=+$G(^TMP($J,"SPN ETIOLOGY",SPNETIOL("OLD")))
 . I SPNETIOL("OLD")>0,SPNETIOL("NEW")'>0 D  Q  ; *** Bad etiology
 .. S SPNETIOL=$P($G(^SPNL(154.02,SPNETIOL("OLD"),0)),U)
 .. I SPNETIOL="" S SPNETIOL=SPNETIOL("OLD")
 .. S X="Cannot convert ETIOLOGY '"_SPNETIOL
 .. S X=X_"' for "_SPNDFN(0)_", SCD Registry record #"_SPND0
 .. D ERR(X)
 .. Q
 . D CONV2
 . Q
MAIL ;
 N DIFROM D KILL^XM
 I SPNERR=0 D
 . S ^TMP($J,"SPN ERROR",1)="Conversion finished, no problems found"
 . Q
 S XMY(DUZ)="",(XMDUN,XMDUZ)="<Spinal Cord Dysfunction Package>"
 S XMTEXT="^TMP($J,""SPN ERROR"","
 S XMSUB="SCD Registry Conversion"
 D ^XMD
EXIT ;
 D KILL^XM
 F SPN="ERROR","ETIOLOGY","NLOI","REGSTAT" K ^TMP($J,"SPN "_SPN)
 K DA,DD,DIC,DIE,DINUM,DIR,DIRUT,DLAYGO,DO,DR,DTOUT,DUOUT,OFFSET,SPN
 K SPND0,SPNDATA,SPNDATE,SPNDFN,SPNERR,SPNETIOL,SPNEXIT,SPNLCOMP
 K SPNLINE,SPNNEW,SPNNEWD0,SPNNLOI,SPNOLD,SPNREGST,SPNTYPE,X,Y
 K ZTDESC,ZTIO,ZTRTN,ZTSK
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
CONV1 ; *** Registration Status and Source of NLOI
 K DA,DIE,DR
 I (SPNREGST("NEW")]"")&(SPNREGST("NEW")'=SPNREGST("OLD")) D
 . S DR=".03///^S X="_SPNREGST("NEW")
 . Q
 I (SPNNLOI("NEW")]"")&(SPNNLOI("NEW")'=SPNNLOI("OLD")) D
 . S DR=$S($G(DR)]"":DR_";",1:"")_"2.3///^S X="_SPNNLOI("NEW")
 . Q
 I SPNLCOMP]"" D
 . S DR=$S($G(DR)]"":DR_";",1:"")_"6.09///^S X="""_SPNLCOMP_""""
 . Q
 I $G(DR)]"" S DIE="^SPNL(154,",DA=SPND0 D ^DIE
 Q
 ;
CONV2 ; *** Etiology
 I $O(^SPNL(154,SPND0,"E","B",SPNDATE,0))'>0 D
 . K DA,DD,DIC,DINUM,DO
 . S DIC="^SPNL(154,"_SPND0_",""E"",",DIC(0)="L"
 . S DIC("P")=$P(^DD(154,4,0),U,2),DLAYGO=+DIC("P")
 . S (D0,DA(1))=SPND0,X=SPNDATE
 . I SPNETIOL("NEW") S DIC("DR")=".02///`"_SPNETIOL("NEW")
 . D FILE^DICN
 . Q
 Q
ERR(X) ;
 S SPNERR=SPNERR+1
 S ^TMP($J,"SPN ERROR",SPNERR)=X
 Q
