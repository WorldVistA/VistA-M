XPDIB ;SFISC/RSD - Backup installed Package ;12:29 PM  16 Oct 2000
 ;;8.0;KERNEL;**10,58,108,178,713**;Jul 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
EN ;
 ;p713 - added support to create Build from Transport Global to create a backup
 N DA,DIR,DIRUT,DUOUT,I,J,XPD,XPDA,XPDBLD,XPDFILE,XPDFLD,XPDFL,XPDGREF,XPDI,XPDIDVT,XPDNM,XPDOLDA
 N XPDPKG,XPDQUIT,XPDST,XPDT,XPDSBJ,XPDSD,XPDSUBDD,XPDVER,X,Y,%
 S %="I '$P(^(0),U,9),$D(^XTMP(""XPDI"",Y))",XPDST=$$LOOK^XPDI1(%)
 Q:'XPDST!$D(XPDQUIT)
 S XPDNM=$P(XPDT(1),U,2),DIR(0)="F^3:65",DIR("A")="Subject"
 S DIR("?")="characters and must not contain embedded up-arrows."
 S DIR("?",1)="Enter the subject for this Backup Message"
 S DIR("?",2)="This response must have at least 3 characters and no more than 63"
 S DIR("B")=$E(("Backup of "_XPDNM_" on "_$$FMTE^XLFDT(DT)),1,63)
 W ! D ^DIR I $D(DIRUT) G QUIT
 S XPDSBJ=Y,XPDBLD=+$O(^XTMP("XPDI",XPDST,"BLD",0)),Y0=$G(^(XPDBLD,0)),XPDT=1
 K DIR
 ;if not Single Package
 I $P(Y0,U,3) D
 . S %=$S($P(Y0,U,3)=1:"Multi-Package",1:"Global Package")
 . W !!,"Only a Single Package Build can do a Build Backup.",!,$P(XPDT(1),U,2)," is of type ",%,!,"You can only Backup the Routines.",!!
 . S DIR(0)="S^R:Routines"
 . Q
 ;Build or Routines
 E  S DIR(0)="S^B:Build;R:Routines"
 D ^DIR G:$D(DIRUT) QUIT
 ;R=routine Packman msg
 I Y="R" D ROUTINE Q
 ;create new build, add "b" to mark as backup & change ^XTMP(
 S XPDI=XPDNM,XPDNM=XPDNM_"b",$P(^XTMP("XPDI",XPDST,"BLD",XPDBLD,0),U)=XPDNM
 ;$$BLD needs: XPDPKG=0 no package pointer,XPDA=install #,XPDBLD=build #, in XTMP("XPDI",XPDA,"BLD",XPDBLD,
 S XPDPKG=0,XPDA=XPDST,XPDA=$$BLD^XPDIP(XPDBLD) G:'XPDA QUIT
 ;reset ^XTMP back to original value
 S $P(^XTMP("XPDI",XPDST,"BLD",XPDBLD,0),U)=XPDI
 D QUIT ;this unlocks the INSTALL file entry XPDST, don't need it anymore
 K XPD,XPDI
 ;change TYPE(2)=single, TRACK NATIONALLY(5)=no, ALPHA/BETA TESTING(20),INSTALLATION MSG(21),ADDRESS(22),Build number(63)
 S %=XPDA_",",XPD(9.6,%,2)=0,XPD(9.6,%,5)="n",XPD(9.6,%,20)="n",XPD(9.6,%,21)="n",XPD(9.6,%,22)="n",XPD(9.6,%,63)=0
 S XPD(9.6,%,3)="XPDI",XPDI(1,0)=XPDSBJ,XPDI(2,0)=" "
 ;add warning msg and file Description
 D WARN("XPDI",3),FILE^DIE("","XPD")
 ;delete multiples: REQUIRED BUILD(11), PACKAGE NAMESPACE(23), INSTALL QUESTIONS(50), XPFn(51.01-51.13), TEST/SEQ/TRANS(61-62)
 K ^XPD(9.6,XPDA,"REQB"),^("ABNS"),^("QUES"),^("QDEF"),^(6)
 ;delete PRE-T(900), ENVIR(913), POST(914), PRE-IN(916), DELETE routine
 K ^XPD(9.6,XPDA,"PRET"),^("PRE"),^("INIT"),^("INI"),^("INID")
 ;Restore Routine, move to Post Install
 I $G(^XPD(9.6,XPDA,"REST"))]"" S ^XPD(9.6,XPDA,"INIT")=^("REST")
 ;scan Build Components and reset actions
 S XPDFILE=0
 F  S XPDFILE=$O(^XPD(9.6,XPDA,"KRN",XPDFILE)),XPDOLDA=0 Q:'XPDFILE  D
 . F  S XPDOLDA=$O(^XPD(9.6,XPDA,"KRN",XPDFILE,"NM",XPDOLDA)) Q:'XPDOLDA  S Y0=$G(^(XPDOLDA,0)) D
 .. ;XPDFL= 0-send,1-delete,2-link,3-merge,4-attach,5-disable
 .. S XPDFL=$P(Y0,U,3),X=$P(Y0,U)
 .. I XPDFILE=9.8 S J=$$RTN(X),$P(Y0,U,3)=J D SETKRN(Y0) Q  ;routines
 .. S J=$$KRN(XPDFILE,X),$P(Y0,U,3)=J D SETKRN(Y0) ;everything else
 .. Q
 . Q
 ;scan Files  ^XPD(file#,222)=update DD^Security^f=full,p=partial DD^resolve pointers
 S XPDFILE=0
 F  S XPDFILE=$O(^XPD(9.6,XPDA,4,XPDFILE)) Q:'XPDFILE  S XPDFL=$G(^(XPDFILE,222)) D
 . I $P(XPDFL,U,3)="f" D:'$D(^DD(XPDFILE))  Q  ;full DD - delete if new
 .. N DIK,DA
 .. S DIK="^XPD(9.6,"_XPDA_",4,",DA=XPDFILE,DA(1)=XPDA
 .. D ^DIK Q 
 . ;Partial DD, loop thru subDD (XPDSUBDD) to find the fields (XPDFLD). subDD with no fields=send all fields.
 . S (XPDSD,XPDSUBDD)=0
 . F  S XPDSUBDD=$O(^XPD(9.6,XPDA,4,XPDFILE,2,XPDSUBDD)),XPDFLD=0 Q:'XPDSUBDD  D
 .. I $O(^XPD(9.6,XPDA,4,XPDFILE,2,XPDSUBDD,1,0)) D  Q  ;fields are specified
 ... F  S XPDFLD=$O(^XPD(9.6,XPDA,4,XPDFILE,2,XPDSUBDD,1,XPDFLD)) Q:'XPDFLD  D FLD(XPDSUBDD,XPDFLD) ;loop thru fields
 ... D:'$O(^XPD(9.6,XPDA,4,XPDFILE,2,XPDSUBDD,1,0)) DEL(XPDFILE,XPDSUBDD) ;if all fields were removed, remove subDD
 ... Q
 .. D:'($D(^DD(XPDSUBDD,0))#10) DEL(XPDFILE,XPDSUBDD) ;fields not specified - all fields under subdd
 .. Q
 . Q
 ;don't need the new transport global
 K ^XTMP("XPDT",XPDA)
 S XPDVER="",XPDGREF="^XTMP(""XPDT"","_+XPDA_",""TEMP"")"
 ;from XPDT, transport build
 F X="DD^XPDTC","KRN^XPDTC","QUES^XPDTC","INT^XPDTC","BLD^XPDTC" D @X Q:$D(XPDERR)
 ;XPDTP to build Packman message
 N XCNP,DIF,XMSUB,XMDUZ,XMDISPI,XMZ
 S XMDUZ=+DUZ,XMSUB=XPDSBJ
 K ^TMP("XMP",$J)  ;create message text for Packman
 D WARN("^TMP(""XMP"",$J)",1),KD^XPDTP
 W !!,"Message sent",!
 Q
 ;
ROUTINE ;Packman msg
 N XCNP,DIF,XMSUB,XMDUZ,XMDISPI,XMZ
 S XMSUB=XPDSBJ_". Routines Only",XMDUZ=+DUZ
 D XMZ^XMA2 I XMZ<1 D QUIT^XPDI1(XPDST) Q
 S Y=$$NOW^XLFDT,%=$$DOW^XLFDT(Y),Y=$$FMTE^XLFDT(Y,2)
 S X="PACKMAN BACKUP Created on "_%_", "_$P(Y,"@")_" at "_$P(Y,"@",2)
 I $D(^VA(200,DUZ,0)) S X=X_" by "_$P(^(0),U)_" "
 S:$D(^XMB("NAME")) X=X_"at "_$P(^("NAME"),U)_" "
 S ^XMB(3.9,XMZ,2,0)="^3.92A^^^"_DT,^(1,0)="$TXT "_X,XCNP=1
 S XPDT=0
 F  S XPDT=$O(XPDT(XPDT)) Q:'XPDT  D
 .S XPDA=+XPDT(XPDT),XPDNM=$P(XPDT(XPDT),U,2),X=""
 .I '$D(^XTMP("XPDI",XPDA,"RTN")) W !,"No routines for ",XPDNM,! Q
 .W !,"Loading Routines for ",XPDNM
 .F  S X=$O(^XTMP("XPDI",XPDA,"RTN",X)) Q:X=""  D  W "."
 .. N %N,DIF
 .. X ^%ZOSF("TEST") E  W !,X,?10,"Doesn't Exist" Q  ;p713
 .. S XCNP=XCNP+1,^XMB(3.9,XMZ,2,XCNP,0)="$ROU "_X_" (PACKMAN_BACKUP)",DIF="^XMB(3.9,XMZ,2,"
 .. X ^%ZOSF("LOAD")
 .. S $P(^XMB(3.9,XMZ,2,0),U,3,4)=XCNP_U_XCNP,^(XCNP,0)="$END ROU "_X_" (PACKMAN-BACKUP)"
 .. Q
 . Q
 D EN3^XMD,QUIT
 Q
 ;
DIR(DIR) ;
 S DIR("A")="Backup Type",DIR("?")="Backup the entire Build or just the Routines."
 D ^DIR I $D(DIRUT) Q 0
 Q Y
 ;
RTN(X) ;X=routine name, return: 0 if exist - backup will overwrite
 ;1 if don't exists - backup needs to delete
 N %N,DIF
 X ^%ZOSF("TEST")
 I  Q 0
 Q 1
 ;
KRN(FILE,X) ;FILE=file #, X=component
 N FGR
 S FGR=$$FILE^XPDV(FILE)
 ;If X exists, return 0 - send
 I $O(@FGR@("B",X,0)) Q 0
 ;if X doesn't exists, return 1 - delete
 Q 1
 ;
SETKRN(X) ;set BLD node to X
 S ^XPD(9.6,XPDA,"KRN",XPDFILE,"NM",XPDOLDA,0)=X
 Q
 ;
FLD(DD,FIELD) ;check FIELD exists
 D:'($D(^DD(DD,FIELD,0))#10) DEL(XPDFILE,DD,FIELD) ;field is new, delete
 Q
 ;
DEL(FILE,SUBDD,FIELD) ;deletes partials: FILE=file#, SUBDD=sub dictionary#, FIELD=field#, XPDA=ien in Build file
 I $G(FIELD) K ^XPD(9.6,XPDA,4,FILE,2,SUBDD,1,FIELD),^XPD(9.6,XPDA,4,"APDD",FILE,SUBDD,FIELD) Q  ;delete FIELD & index
 I $G(SUBDD) K ^XPD(9.6,XPDA,4,FILE,2,SUBDD),^XPD(9.6,XPDA,4,"APDD",FILE,SUBDD) Q  ;delete SUBDD & index
 I $G(FILE) K ^XPD(9.6,XPDA,4,FILE),^XPD(9.6,XPDA,4,"APDD",FILE),^XPD(9.6,XPDA,4,"B",FILE) ;delete FILE & index
 Q
 ;
WARN(X,Y) ;create warning message in array X starting at Y
 S @X@(Y,0)="Warning:  Installing this backup patch message will install older versions"
 S @X@(Y+1,0)="of routines and globals.  Please verify with the Development Team that it is safe to install."
 Q
 ;
QUIT ;unlock Install # XPDST
 D QUIT^XPDI1(XPDST)
 Q
