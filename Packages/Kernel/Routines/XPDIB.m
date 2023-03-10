XPDIB ;SFISC/RSD - Backup installed Package ; Jun 30, 2022@09:05:05
 ;;8.0;KERNEL;**10,58,108,178,713,738,750,755,768**;Jul 10, 1995;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified.
EN ;
 ;p713 - added support to create Build from Transport Global to create a backup
 N DIR,DIRUT,DUOUT,XPDA,XPDBLD,XPDTCNT,XPDH,XPDH1,XPDHD,XPDFMSG,XPDI,XPDIDVT,XPDMP,XPDNM,XPDPKG,XPDQUIT,XPDST
 N XPDT,XPDTB,XPDSBJ,XPDTYP,XPDVER,X,Y,Y0,%,XPDIB
 ;S %="I '$P(^(0),U,9),$D(^XPD(9.7,""ASP"",Y,1,Y)),$D(^XTMP(""XPDI"",Y))",XPDST=$$LOOK^XPDI1(%)
 S %="I $E($P(^(0),U),$L($P(^(0),U)))'=""b"",'$P(^(0),U,9),$D(^XPD(9.7,""ASP"",Y,1,Y)),$D(^XTMP(""XPDI"",Y))",XPDST=$$LOOK^XPDI1(%) ;p755 can't backup a backup
 Q:'XPDST!$D(XPDQUIT)
 ;XPDST=starting install ien, XPDNM=install name, XPDBLD=build #, XPDPKG=package file pointer, XPDT(#)=Install file #^Install file name  XPDIB=flag to not write errors
 S XPDIB=1 D BLDV(XPDST)
 S XPDTCNT=$O(XPDT("DA"),-1) ;XPDTCNT=# of installs
 I XPDTYP>1 W !!,"This is a Global Package and cannot be backed up.",!! Q  ;p738
 ;multi-package reset name to include all builds
 I XPDTCNT>1 S XPDNM="" F XPDT=1:1:XPDTCNT S XPDNM=XPDNM_$P(XPDT(XPDT),U,2)_$S(XPDT'=XPDTCNT:", ",1:"")
 S DIR(0)="F^3:65",DIR("A")="Subject"
 S DIR("?")="characters and must not contain embedded up-arrows."
 S DIR("?",1)="Enter the subject for this Backup Message"
 S DIR("?",2)="This response must have at least 3 characters and no more than 63"
 S DIR("B")=$E(("Backup of "_XPDNM_" on "_$$FMTE^XLFDT(DT)),1,63)
 W ! D ^DIR I $D(DIRUT) G QUIT
 S XPDSBJ=Y
 K DIR
 ;Build or Routines
 S DIR(0)="S^B:Build (including Routines);R:Routines Only",DIR("A")="Backup Type",DIR("B")="B"
 S DIR("?")="Backup the entire Build(routines, files, options, protocols, templates, etc.) or just the Routines." ;p738
 S DIR("??")="^D HELP^XPDIB" ;p750
 D ^DIR G:$D(DIRUT) QUIT
 ;R=routine Packman msg
 I Y="R" D ROUTINE G QUIT
 ;XPDTCNT: 1=single, >1=multi-package ;p738
 I XPDTCNT=1 S (XPDT,XPDTB)=1,XPDA=$$BLD(XPDST),XPDNM=$P(XPDTB(1),U,2) D PM(XPDA) G QUIT
 I XPDTCNT>1 D  G QUIT
 . N XPDSEQ,XPDSIZ,XPDSIZA,POP  ;used in GO^XPDT
 . S XPDH=XPDSBJ ;XPDH is HF header needed in DEV^XPDT
 . D DEV^XPDT Q:POP
 . S XPDTB=0
 . ;loop thru installs, XPDT(#)=install file #^name, XPDTB(#)=build file #^name
 . F XPDT=1:1:XPDTCNT S XPDTB=XPDTB+1,XPDA=+XPDT(XPDT),XPDA=$$BLD(XPDA,XPDST)
 . ;move XPDTB to XPDT
 . K XPDT M XPDT=XPDTB
 . S XPDFMSG=0 ;open Host File, XPDFMSG=1 is flag to send HF to Forum
 . D GO^XPDT ;write ^XTMP("XPDT" to HF
 . Q
 Q
BLD(XPDST,XPDMP) ;XPDST=Install #,XPDMP=master build or first Install # of multi-package; returns XPDA=new Build #
 N XPDA,XPDBLD,XPD,XPDERR,XPDFILE,XPDFL,XPDFLD,XPDGREF,XPDI,XPDNM,XPDOLDA,XPDREST,I,J,X,Y,Y0
 N XPDSD,XPDSUBDD
 D BLDV(XPDST)
 ;create new build, add "b" to mark as backup & change ^XTMP(
 S XPDI=XPDNM,XPDNM=XPDNM_"b",$P(^XTMP("XPDI",XPDST,"BLD",XPDBLD,0),U)=XPDNM
 ;$$BLD^XPDIP needs: XPDA, XPDBLD, XPDNM, XPDPKG
 S XPDA=XPDST,XPDA=$$BLD^XPDIP(XPDBLD) Q:'XPDA 0
 ;reset ^XTMP back to original value
 S $P(^XTMP("XPDI",XPDST,"BLD",XPDBLD,0),U)=XPDI,XPDTB(XPDTB)=XPDA_"^"_XPDNM
 ;change TRACK NATIONALLY(5)=no, ALPHA/BETA TESTING(20),INSTALLATION MSG(21),ADDRESS(22),Build number(63)
 S %=XPDA_",",XPD(9.6,%,5)="n",XPD(9.6,%,20)="n",XPD(9.6,%,21)="n",XPD(9.6,%,22)="n",XPD(9.6,%,63)=0
 S XPD(9.6,%,3)="XPDI",XPDI(1,0)=XPDSBJ,XPDI(2,0)=" " ;DESCRIPTION(3)
 ;add warning msg and file Description
 D WARN("XPDI",3),FILE^DIE("","XPD")
 ;delete multiples: REQUIRED BUILD(11), PACKAGE NAMESPACE(23), INSTALL QUESTIONS(50), XPFn(51.01-51.13), TEST/SEQ/TRANS(61-62)
 K ^XPD(9.6,XPDA,"REQB"),^("ABNS"),^("QUES"),^("QDEF"),^(6)
 ;Restore Routine ;p768
 I $G(^XPD(9.6,XPDA,"REST"))]"" M XPDREST=^XTMP("XPDI",XPDST,"REST")
 ;delete PRE-T(900), ENVIR(913), POST(914), PRE-IN(916), DELETE routine, RESTORE(917)
 K ^XPD(9.6,XPDA,"PRET"),^("PRE"),^("INIT"),^("INI"),^("INID"),^("REST")
 ;scan BUILD COMPONENTS(7) and reset actions
 S XPDFILE=0
 F  S XPDFILE=$O(^XPD(9.6,XPDA,"KRN",XPDFILE)),XPDOLDA=0 Q:'XPDFILE  D
 . F  S XPDOLDA=$O(^XPD(9.6,XPDA,"KRN",XPDFILE,"NM",XPDOLDA)) Q:'XPDOLDA  S Y0=$G(^(XPDOLDA,0)) D
 .. I XPDFILE=19!(XPDFILE=101),$P(Y0,U,3)>1 Q  ;menus action of attach,merge,link - don't change action
 .. D KRN(XPDFILE,.Y0),SETKRN(Y0)
 .. Q
 . Q
 ;scan FILE(#6)  ^XPD(file#,222)=update DD^Security^f=full,p=partial DD^^resolve pointers^data list^data comes^site data^may override
 S XPDFILE=0
 F  S XPDFILE=$O(^XPD(9.6,XPDA,4,XPDFILE)) Q:'XPDFILE  S XPDFL=$G(^(XPDFILE,222)) D
 . I $P(XPDFL,U,3)="f" D  Q  ;full DD
 .. I '$D(^DD(XPDFILE)) D DELF(XPDFILE) Q  ;delete if new
 .. ;can't backup data in file, set to 'no', kill 'select data screen' p738
 .. I $P(XPDFL,U,7)="y" S $P(XPDFL,U,7)="n",^XPD(9.6,XPDA,4,XPDFILE,222)=XPDFL K ^(223)
 .. Q
 . ;Partial DD, loop thru subDD (XPDSUBDD) to find the fields (XPDFLD). subDD with no fields=send all fields.
 . S (XPDSD,XPDSUBDD)=0
 . F  S XPDSUBDD=$O(^XPD(9.6,XPDA,4,XPDFILE,2,XPDSUBDD)),XPDFLD=0 Q:'XPDSUBDD  D
 .. I $O(^XPD(9.6,XPDA,4,XPDFILE,2,XPDSUBDD,1,0)) D  Q  ;fields are specified
 ... F  S XPDFLD=$O(^XPD(9.6,XPDA,4,XPDFILE,2,XPDSUBDD,1,XPDFLD)) Q:'XPDFLD  D FLD(XPDSUBDD,XPDFLD) ;loop thru fields
 ... D:'$O(^XPD(9.6,XPDA,4,XPDFILE,2,XPDSUBDD,1,0)) DEL(XPDFILE,XPDSUBDD) ;if all fields were removed, remove subDD
 ... Q
 .. D:'($D(^DD(XPDSUBDD,0))#10) DEL(XPDFILE,XPDSUBDD) ;fields not specified & subDD is new - remove subDD
 .. Q
 . D:'$O(^XPD(9.6,XPDA,4,XPDFILE,2,0)) DEL(XPDFILE) ;if all subDDs removed, remove file ;p768
 . Q
 ;kill transport global before we rebuild it
 K ^XTMP("XPDT",XPDA)
 ;XPDFREF is a documented variable for use in PRE-TRANSPORTATION routine
 S XPDVER="",XPDGREF="^XTMP(""XPDT"","_+XPDA_",""TEMP"")"
 ;from XPDT, transport build
 F X="DD^XPDTC","KRN^XPDTC","QUES^XPDTC","INT^XPDTC","BLD^XPDTC" D @X ;p755 don't check for errors $D(XPDERR)
 ;Load RESTORE routine ;p768
 I $D(XPDREST) D
 . S I=+$O(^XTMP("XPDT",XPDA,"BLD",0)) S:I ^XTMP("XPDT",XPDA,"BLD",I,"INIT")=XPDREST ;save RESTORE as POST-INIT in Build
 . S ^XTMP("XPDT",XPDA,"INIT")=XPDREST,Y=$P(XPDREST,"("),Y=$P(Y,U,$L(Y,U)) Q:$D(^("RTN",Y))
 . M ^XTMP("XPDT",XPDA,"RTN",Y)=XPDREST(Y) ;save RESTORE routine
 . ;^XTMP("XPDT",XPDA,"RTN",Y)=action^ien in Build^checksum
 . S X="B"_$$SUMB^XPDRSUM($NA(^XTMP("XPDT",XPDA,"RTN",Y))),^XTMP("XPDT",XPDA,"RTN",Y)="0^^"_X
 . ;update count node
 . S ^("RTN")=$G(^XTMP("XPDT",XPDA,"RTN"))+1
 . Q
 Q XPDA
 ;
BLDV(XPDA) ;variable setup for BLD, XPDA=Install #
 N Y0
 ;XPDNM=install name, XPDBLD=build #, Y0=zero node of build, XPDPKG=package file name
 S XPDBLD=+$O(^XTMP("XPDI",XPDA,"BLD",0)),Y0=$G(^(XPDBLD,0)),XPDNM=$P(Y0,U),XPDPKG=$P(Y0,U,2),XPDTYP=+$P(Y0,U,3)
 S:XPDPKG]"" XPDPKG=$$LKPKG^XPDUTL(XPDPKG) ;XPDPKG=package file #
 Q
 ;XPDTP to build Packman message
PM(XPDA) ;build MailMan message
 N DIFROM,XCNP,DIF,XMSUB,XMDUZ,XMDISPI,XMZ
 S DIFROM=1,XMDUZ=+DUZ,XMSUB=XPDSBJ ;p738
 W !!," **This Backup mail message should be sent to a Mail Group.  This will allow" ;p768
 W !," anyone in the Mail Group to back out the changes.**"
 K ^TMP("XMP",$J)  ;create message text for Packman
 D WARN("^TMP(""XMP"",$J)",1),KD^XPDTP
 Q:$D(DTOUT)!$D(DUOUT)
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
 . S XPDA=+XPDT(XPDT),XPDNM=$P(XPDT(XPDT),U,2),X=""
 . I '$D(^XTMP("XPDI",XPDA,"RTN")) W !,"No routines for ",XPDNM,! Q
 . W !,"Loading Routines for ",XPDNM
 . F  S X=$O(^XTMP("XPDI",XPDA,"RTN",X)) Q:X=""  D  W "."
 .. N %N,DIF
 .. X ^%ZOSF("TEST") E  W !,X,?10,"Doesn't Exist" Q  ;p713
 .. S XCNP=XCNP+1,^XMB(3.9,XMZ,2,XCNP,0)="$ROU "_X_" (PACKMAN_BACKUP)",DIF="^XMB(3.9,XMZ,2,"
 .. X ^%ZOSF("LOAD")
 .. S $P(^XMB(3.9,XMZ,2,0),U,3,4)=XCNP_U_XCNP,^(XCNP,0)="$END ROU "_X_" (PACKMAN-BACKUP)"
 .. Q
 . Q
 D EN3^XMD
 Q
 ;
KRN(FILE,XPDY) ;FILE=file #, XPDY=^XPD(9.6,XPDA,"KRN",XPDFILE,"NM",XPDOLDA,0) passed by ref.
 N DA,FGR,X
 S X=$P(XPDY,U)
 ;$P(XPDY,U,2) is file # for FileMan templates, reset name in Y0 before getting DA
 S:$P(XPDY,U,2) $P(Y0,U)=$P(Y0,"    FILE #")
 S FGR=$$FILE^XPDV(FILE),DA=$$ENTRY^XPDV(XPDY) ;check if exists
 ;If X exists, Y=0 - send
 I DA S $P(XPDY,U,3)=0 Q
 ;if X doesn't exists, Y=1 - delete
 E  S $P(XPDY,U,3)=1
 Q
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
DELF(FILE) ;delete full file DD
 N DIK,DA
 S DIK="^XPD(9.6,"_XPDA_",4,",DA=FILE,DA(1)=XPDA
 D ^DIK
 Q
 ;
WARN(X,Y) ;create warning message in array X starting at Y ;p738
 S @X@(Y,0)="Warning:  Installing this backup patch message will install older versions"
 S @X@(Y+1,0)="of routines and Build Components (options, protocols, templates, etc.)."
 S @X@(Y+2,0)="Please verify with the Development Team that it is safe to install."
 Q
 ;
QUIT ;unlock Install # XPDST
 D QUIT^XPDI1(XPDST)
 Q
 ;
HELP ;Help (DIR("??")) for DIR (Build/Routine) read ;p750
 W !," Enter 'B' to create a backup of this Build. A new Build will be created using",!,"the same Build name with a 'b' appended to the end. This new Build will be used"
 W !,"to create a KIDS backup of routines, files, options, protocols, templates, etc.",!,"If this backup is a single build, a Packman email is created.  If it is a multi-package a Host File is created."
 W !," Enter 'R' to create a Packman email of only the routines."
 Q
