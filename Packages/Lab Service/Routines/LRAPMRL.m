LRAPMRL ;DALOI/STAFF - AP MODIFY RELEASED REPORT;02/28/12  20:38
 ;;5.2;LAB SERVICE;**259,295,317,368,397,350**;Sep 27, 1994;Build 230
 ;
MAIN ;
 N LRQUIT,LRMSG,LREND,LRDATA,LRREL,LRAU,LREFPD,LRWM,LRCT,LRTMP,LRGMDF
 N LRFLD,LRDSC,LRCHG,LRXTMP,LRYTMP,LRIENS1,LRFILE,LRFLDA,LRAD1,LRIENS
 N LRORIEN,LRWPROOT,LRFDA,LRDA,LRFIELD,LRFILE1,LRIENS2,LRDT0,LRESCPT
 N LRQUIT1,LREDIAG,LRLOCK,LRNOTXT,LRORIEN,LRSEL
 S LRESCPT=0
 D TITLE
 I LRQUIT D END Q
 D NOTICE
 I LRQUIT D END Q
 D SECTION
 I LRQUIT D END Q
 D WHAT
 I LRQUIT D END Q
 D CPTCHK
 ;D SECTION
 I LRQUIT D END Q
 D ASK
 I LRQUIT D END Q
 D SETDR^LRAPMRL1
 D ACCYR
 I LRQUIT D END Q
 D ACCPN
 D END
 D V^LRU
 Q
 ;
 ;
ACCPN ; Prompt for accession number or patient name or UID
 F  D  Q:LREND
 . S (LRQUIT,LREND)=0
 . D CPTCHK
 . D LOOKUP^LRAPUTL(.LRDATA,LRH(0),LRO(68),LRSS,LRAD,LRAA)
 . I LRSEL=3,$D(X) I X=""!(X[U) S LREND=1 Q
 . I '$D(LRSEL)!(LRDATA<1)!('$G(LRAN))!($G(LRAN)=-1) S LREND=1 Q
 . I 'LRSEL S LREND=1 Q
 . S LRDFN=LRDATA,LRI=LRDATA(1)
 . S LRLOCK="^LR(LRDFN"_$S(LRAU:")",1:",LRSS,LRI)")
 . L +@(LRLOCK):DILOCKTM I '$T D  Q
 . . S LRMSG="This record is locked by another user.  "
 . . S LRMSG=LRMSG_"Please try again later."
 . . D EN^DDIOL(LRMSG,"","!!") K LRMSG
 . S LRIENS=$S('LRAU:LRI_",",1:"")_LRDFN_","
 . D RELCHK^LRAPMRL1
 . I LRQUIT D UNLOCK Q
 . D RELEASE^LRAPMRL1
 . D QUEUPD^LRAPMRL1
 . D:LRCAPA C^LRAPSWK
 . D:'LREDIAG SETDR^LRAPMRL1,EDIT^LRAPMRL1
 . I LRQUIT D UNLOCK Q
 . I 'LRAU D
 . . F LRFLD=1,1.1,1.4,1.3 D  Q:LRQUIT
 . . . Q:LREDIAG&(LRFLD'=1.4)
 . . . Q:'LREDIAG&(LRFLD=1.4)
 . . . Q:LRFLD=1.3&(LRSS'="SP")
 . . . D ASK2 Q:LRQUIT!('LRGMDF)
 . . . D SAVTXT
 . . . K DR S DR=LRFLD
 . . . D EDIT^LRAPMRL1
 . . . D COMPARE Q:LRQUIT
 . . . D AUDIT Q:LRQUIT
 . . . D STORE
 . I LRAU,LREDIAG D
 . . S LRDSC="PATHOLOGICAL DIAGNOSIS"
 . . S LRFLD=32.3
 . . D SAVTXT
 . . K DR S DR=LRFLD
 . . D EDIT^LRAPMRL1
 . . D COMPARE
 . I $G(SEX)["F","SPCY"[LRSS D DEL^LRWOMEN
 . I LRQUIT D UNLOCK Q
 . I LREDIAG D UNLOCK Q
 . D:LRESCPT CPTCODE^LRAPMRL1
 . D UNLOCK
 Q
 ;
 ;
TITLE ; Title
 S (LRQUIT,LRQUIT1)=0
 D CK^LRAP
 I Y=-1 S LRQUIT=1 Q
 W @IOF
 S LRMSG="Modify Released Pathology Reports"
 S LRMSG(1)=$$CJ^XLFSTR(LRMSG,IOM)
 S LRMSG(1,"F")="!!"
 S LRMSG(2)="",LRMSG(2,"F")="!"
 D EN^DDIOL(.LRMSG) K LRMSG
 Q
 ;
 ;
NOTICE ; Warn the user and allow an exit
 N LRMSG
 S LRMSG(1)=$$CJ^XLFSTR("NOTICE",IOM),LRMSG(1,"F")="!!"
 S LRMSG(2)=" ",LRMSG(2,"F")="!"
 S LRMSG(3)=$C(7)_"This option allows modification of a verified/released pathology report.",LRMSG(3,"F")="!?3"
 S LRMSG(4)="Continuing with this option will unrelease the report and flag the report",LRMSG(4,"F")="!?3"
 S LRMSG(5)="as modified even if the data is unchanged.  It will also be queued to the",LRMSG(5,"F")="!?3"
 S LRMSG(6)="final report queue so that it may be verified/released again.",LRMSG(6,"F")="!?3"
 D EN^DDIOL(.LRMSG)
 W !!
 S DIR(0)="Y",DIR("A")="Do you wish to continue",DIR("B")="NO"
 D ^DIR
 S:Y<1 LRQUIT=1
 Q
 ;
 ;
WHAT ; What is to be edited
 N XASK
 W !
 K DIR
 ; Don't ask to Edit Diagnosis if initial entry of diagnosis is turned off at data entry for SP, CY, EM's
 S LRASK=1,XASK=""
 I 'LRAU D
 . S XASK=$S(LRSS="SP":11.2,LRSS="CY":11.3,1:"")
 . S:XASK="" XASK=$S(LRSS="EM":11.4,1:"")
 . S LRASK=$$GET1^DIQ(69.9,"1,",XASK,"I")
 S:LRASK DIR(0)="S^1:Edit Report;2:Edit Diagnosis"
 S:LRASK DIR("A")="Enter selection",DIR("B")=1
 S:'LRASK DIR(0)="Y",DIR("B")="YES",DIR("A")="Edit Report?"
 D ^DIR
 I $D(DIRUT) S LRQUIT=1 Q
 S LREDIAG=$S(Y=2:1,1:0)
 Q
 ;
 ;
CPTCHK ; Determine if CPT is activated
 Q:$T(ES^LRCAPES)=""
 S LRESCPT=$$ES^LRCAPES()
 Q
 ;
 ;
SECTION ; Choose Anatomic Pathology section (AU,SP,CY,EM)
 W !
 D ^LRAP
 I '$D(Y)!('$D(LRSS)) S LRQUIT=1 Q
 S:LRO(68)="EM" LRO(68)="ELECTRON MICROSCOPY"
 S LRAU=0            ; LRAU = 0 - Not Autopsy
 S:LRSS="AU" LRAU=1  ;      = 1 - Autopsy
 I LRCAPA D @(LRSS_"^LRAPSWK")
 S LRMSG(1)=LRO(68)_" ("_LRABV_")",LRMSG(1,"F")="!?20"
 S LRMSG(2)="",LRMSG(2,"F")="!"
 D EN^DDIOL(.LRMSG) K LRMSG
 Q
 ;
 ;
ASK ; Ask etiology,function,procedure,disease,weights,measures
 I LREDIAG D  Q
 . S:'LRAU LREFPD=0
 . S:LRAU LRWM=0
 W !
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Edit etiology, function, procedure & disease"
 D ^DIR
 I Y="^" S LRQUIT=1 Q
 S LREFPD=$S(+Y:1,1:0)
 I LRAU D
 . W !
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Edit weights and measures"
 . D ^DIR
 . I Y="^" S LRQUIT=1 Q
 . S LRWM=$S(+Y:1,1:0)
 Q
 ;
 ;
ACCYR ; Determine Accession Year
 D ACCYR^LRAPUTL(.LRAD1,LRH(0),LRAA,LRO(68))
 I LRAD1=-1 S LRQUIT=1 Q
 I LRAD1 S LRAD=$P(LRAD1,U),LRH(0)=$P(LRAD1,U,2)
 Q
 ;
 ;
ASK2 ; Ask about other fields
 S LRGMDF=0
 K LRDSC
 I LRFLD=1!(LRFLD=1.1) D
 . S:LRFLD=1 LRFLDA=7
 . S:LRFLD=1.1 LRFLDA=4
 . S LRDSC=$S(LRFLD=1:"GROSS",LRFLD=1.1:"MICROSCOPIC",1:"")
 . S LRDSC=LRDSC_" DESCRIPTION"
 S:LRFLD=1.4 LRDSC="DIAGNOSIS",LRFLDA=5
 S:LRFLD=1.3 LRDSC="FROZEN SECTION",LRFLDA=6
 I 'LREDIAG D
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Edit "_LRDSC
 . D ^DIR
 . I Y="^" S LRQUIT=1 Q
 . S LRGMDF=$S(+Y:1,1:0)
 S:LREDIAG LRGMDF=1
 Q
 ;
 ;
SAVTXT ; Save word processing field text.
 S LRNOTXT=0
 K ^TMP("DIQ1",$J)
 S:'LRAU LRIENS=LRI_","_LRDFN_",",LRFILE=LRSF
 S:LRAU LRIENS=LRDFN_",",LRFILE=63
 Q:LRFLD=""
 S LRTMP=$$GET1^DIQ(LRFILE,LRIENS,LRFLD,"","^TMP(""DIQ1"",$J)")
 I LRTMP="" D
 . N LRMSG
 . S LRMSG(1)="There is no "_LRDSC_" text to modify.",LRMSG(1,"F")="!!"
 . S LRMSG(2)="Report was released before entering text.",LRMSG(2,"F")="!"
 . D EN^DDIOL(.LRMSG)
 . S LRNOTXT=1
 Q
 ;
 ;
COMPARE ; Compare report text
 S (LRCHG,LRQUIT,LRCT)=0
 S:'LRAU LRFILE="^LR(LRDFN,LRSS,LRI,LRFLD,"
 S:LRAU LRFILE="^LR(LRDFN,82,"
 I '$D(@(LRFILE_"0)")) D  Q
 . Q:LRNOTXT
 . S LRQUIT=1
 F  S LRCT=$O(@(LRFILE_"LRCT)")) Q:'LRCT  D
 . S LRXTMP=@(LRFILE_"LRCT,0)")
 . I '$D(^TMP("DIQ1",$J,LRCT)) S LRCHG=1 Q
 . S LRYTMP=^TMP("DIQ1",$J,LRCT)
 . I LRXTMP'=LRYTMP S LRCHG=1
 ;
 I 'LRCHG D
 . S LRCT=0 F  S LRCT=$O(^TMP("DIQ1",$J,LRCT)) Q:'LRCT  D
 . . I '$D(@(LRFILE_"LRCT,0)")) S LRCHG=1
 ;
 I 'LRCHG D  Q
 . D EN^DDIOL("No changes made to "_LRDSC_".","","!!")
 . W !
 . K ^TMP("DIQ1",$J)
 ;
 ; Indicate that the diagnosis has been modified.
 I LRCHG&(LRFLD=1.4!(LRFLD=32.3)) D
 . K LRFDA
 . S:'LRAU LRFDA(LRSF,LRIENS,.172)=1
 . ;KLL-CORRECT BUG WHERE LRSF IS NULL, REPLACE LRSF WITH 63
 . S:LRAU LRFDA(63,LRIENS,102.2)=1
 . ;S:LRAU LRFDA(LRSF,LRIENS,102.2)=1
 . D FILE^DIE("","LRFDA")
 ;
 Q
 ;
 ;
AUDIT ;
 N LRNTIME
 K LRFDA
 D NOW^%DTC S LRNTIME=%
 S LRIENS1="+1,"_LRIENS
 S LRFILE=+$$GET1^DID(LRSF,LRFLDA,"","SPECIFIER")
 I LRFILE="" S LRQUIT=1 Q
 S LRFDA(1,LRFILE,LRIENS1,.01)=LRNTIME
 S LRFDA(1,LRFILE,LRIENS1,.02)=DUZ
 D UPDATE^DIE("","LRFDA(1)","LRORIEN")
 Q
 ;
 ;
STORE ;
 K LRIENS1
 S LRIENS1=LRORIEN(1)_","_LRIENS
 S LRWPROOT="^TMP(""DIQ1"",$J)"
 D WP^DIE(LRFILE,LRIENS1,1,"",LRWPROOT)
 K ^TMP("DIQ1",$J),LRORIEN
 Q
 ;
 ;
SUPRPT ; Supplementary Report
 K DIR
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Edit SUPPLEMENTARY REPORTS"
 D ^DIR
 I Y="^" S LRQUIT1=1 Q
 Q:Y<1
 N LRX,LRRLS,LRA,LRFLG,LRNOW
 D GETRPT^LRAPDSR Q:LRQUIT
 S LRRLS=1,LRRLS1=0
 D COPY^LRAPDSR Q:LRQUIT
 D RPT^LRAPDSR Q:LRQUIT
 S Y=LRDA
 D RELEAS2^LRAPDSR
 D COMPARE^LRAPDSR Q:LRQUIT
 D UNRELEAS^LRAPDSR
 D UPDATE^LRAPDSR Q:LRQUIT
 D STORE^LRAPDSR
 Q
 ;
 ;
UNLOCK ; Unlock the record
 D UPDATE^LRPXRM(LRDFN,$G(LRSS,"AU"),$G(LRI))
 L -@(LRLOCK)
 Q
 ;
 ;
END ; Clean-up variables and quit
 K ^TMP("LRAPBR",$J),^TMP("TIUP",$J)
 D CLEAN^DILF
 D:$T(CLEAN^LRCAPES)'="" CLEAN^LRCAPES
 D V^LRU
 Q
