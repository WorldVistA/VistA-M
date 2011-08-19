EASEZU4 ;ALB/jap - Utilities for 1010EZ Processing ;10/25/00  08:08
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,70**;Mar 15, 2001;Build 26
 ;
PRT1010 ;print 10-10EZ form with data
 ;
 N TASK,REVDATE,PRTDATE,ACTION,DIR
 S ACTION="'Print 10-10EZ'"
 ;no action if closed
 I EASPSTAT="CLS" D NOACT^EASEZLM("Inactivated",ACTION) Q
 ;don't print if not at least reviewed
 S REVDATE=$P($G(^EAS(712,EASAPP,2)),U,1)
 I 'REVDATE D NOACT^EASEZLM("Unreviewed",ACTION) Q
 ;just in case
 I EASPSTAT="NEW" D NOACT^EASEZLM("New",ACTION) Q
 ;call to Steve's routine to print 10-10EZ
 D FULL^VALM1
 S TASK=$$QUE^EASEZPF(EASAPP,EASDFN)
 ;should return Task # if actually queued to print
 ;if printed, update processing status if necessary; can be printed multiple times
 S PRTDATE=$P(^EAS(712,EASAPP,2),U,3)
 I 'PRTDATE,$G(TASK) D
 . D SETDATE^EASEZU2(EASAPP,"PRT") S EASPSTAT="PRT"
 . ;rebuild selection list since this application is removed from list
 . D BLD^EASEZLM,HDR2^EASEZL1
 S VALMBCK="R"
 D PAUSE^VALM1
 Q
 ;
VERSIG ;verify Applicant signature on 10-10EZ
 ;
 N REVDATE,ACTION,DIR
 S ACTION="'Verify Signature'"
 ;no action if closed
 I EASPSTAT="CLS" D NOACT^EASEZLM("Inactivated",ACTION) Q
 ;can't verify sig if not at least reviewed
 S REVDATE=$P($G(^EAS(712,EASAPP,2)),U,1)
 I 'REVDATE D NOACT^EASEZLM("Unreviewed",ACTION) Q
 ;can't sign if already done
 I EASPSTAT="SIG" D NOACT^EASEZLM("Previously Signed",ACTION) Q
 ;just in case
 I EASPSTAT="NEW" D NOACT^EASEZLM("New",ACTION) Q
 I EASPSTAT="FIL" D NOACT^EASEZLM("Filed",ACTION) Q
 ;update processing status
 D SETDATE^EASEZU2(EASAPP,"SIG")
 S EASPSTAT="SIG"
 W !,"Applicant signature is verified...",!
 ;rebuild selection list since this application is removed from list
 D BLD^EASEZLM,HDR2^EASEZL1
 S VALMBCK="Q"
 D PAUSE^VALM1
 Q
 ;
FILE ;file 10-10EZ 'accepted' data to VistA Patient database
 ;
 N SIGDATE,ACTION,SAVE,ZTSK,STAT,DIR
 S ACTION="'File 10-10EZ'"
 ;no action if closed
 I EASPSTAT="CLS" D NOACT^EASEZLM("Inactivated",ACTION) Q
 ;must be signed before filing
 S SIGDATE=$P($G(^EAS(712,EASAPP,1)),U,1)
 I 'SIGDATE D NOACT^EASEZLM("Unsigned",ACTION) Q
 ;can't repeat filing
 I EASPSTAT="FIL" D NOACT^EASEZLM("Previously Filed",ACTION) Q
 S STAT=$$CURRSTAT^EASEZU2(EASAPP) I STAT="FIL" D NOACT^EASEZLM("Previously Filed",ACTION) Q
 ;just in case
 I EASPSTAT="NEW" D NOACT^EASEZLM("New",ACTION) Q
 I EASPSTAT="REV" D NOACT^EASEZLM("Unsigned",ACTION) Q
 I EASPSTAT="PRT" D NOACT^EASEZLM("Unsigned",ACTION) Q
 ;
 D FILE2
 ;rebuild selection list since this application is removed from list
 S VALMBCK="R"
 I $D(ZTSK) D
 . D SETDATE^EASEZU2(EASAPP,"FIL")
 . S EASPSTAT="FIL"
 . S $P(^EAS(712,EASAPP,2),U,11)=ZTSK
 . D BLD^EASEZLM S VALMBCK="Q"
 Q
 ;
CLOSE ;close/inactivate the Application
 ;
 N SIGDATE,FILDATE,ACTION
 S ACTION="'Inactivate'"
 ;not allowed if signed or filed
 S FILDATE=$P($G(^EAS(712,EASAPP,2)),U,5)
 I FILDATE D NOACT^EASEZLM("Filed",ACTION) Q
 S SIGDATE=$P($G(^EAS(712,EASAPP,1)),U,1)
 I SIGDATE D NOACT^EASEZLM("Signed",ACTION) Q
 ;no action if already closed
 I EASPSTAT="CLS" D NOACT^EASEZLM("Previously Inactivated",ACTION) Q
 ;clear accept flags and updates
 D OKRESET^EASEZU3
 ;update processing status
 D SETDATE^EASEZU2(EASAPP,"CLS")
 S EASPSTAT="CLS"
 W !,"Application has been closed/inactivated...",!
 D PAUSE^VALM1
 ;rebuild selection list since this application is removed from list
 D BLD^EASEZLM
 S VALMBCK="Q"
 Q
 ;
FILE2 ;
 N VALMDDF,ZTSAVE,ZTDESC,ZTRTN,ZTIO
 K ZTSAVE
 S ZTDESC="Filing 10-10EZ Data (Appl. #"_EASAPP_") to VistA",ZTRTN="QUE^EASEZFM",ZTIO=""
 S ZTSAVE("EASAPP")=""
 D ^%ZTLOAD
 I $D(ZTSK) D
 . ;update processing status
 . W !,"10-10EZ data is being filed as a background job."
 . W !,"Task #: ",ZTSK,!
 . K DIR D PAUSE^VALM1
 Q
 ;
SUPPRESS(EASAPP,DATAKEY,TYPE,VERSION) ;alb/cmf/51
 ;EASAPP = file 712 ien
 ;DATAKEY = file 711/.1
 ;TYPE = 0:display[default], 1:file, 2:accept
 ;VERSION = version # of an application
 ;
 ;RETURN VALUE = 1 if node should not be displayed, filed, or accepted
 ;               0, otherwise
 ;
 N FLAG,CHKKEY
 Q:$G(EASAPP)="" 0
 Q:$G(DATAKEY)="" 0
 S:$G(VERSION)="" VERSION=$$VERSION(EASAPP)
 Q:+VERSION<6 0
 S FLAG=0
 ;EAS*1.0*70 -- added CHKKEY and up-arrows around datakeys below
 S CHKKEY="^"_DATAKEY_"^"
 S TYPE=$S($G(TYPE)=1:1,$G(TYPE)=2:2,1:0)
 I TYPE=0 D  Q FLAG
 . I "^I;18A.^I;18B.^I;18C.^I;18D.^"[CHKKEY S FLAG=1 Q   ;obs
 . I "^IIC;1.1^IIC;1.2^IIC;1.3^"[CHKKEY S FLAG=1 Q       ;obs
 . I "^I;1A.5^IIC;3.^I;14D1.^"[CHKKEY S FLAG=1 Q         ;obs
 . I "^I;14C.^I;14D.^I;14D2.^I;14H.^"[CHKKEY S FLAG=1 Q  ;obs
 . I "^IIE;1.^IIE;2.^IIE;3.^"[CHKKEY S FLAG=1 Q          ;print only
 . ;EAS*1.0*70 - until added to the web form,
 . ;only print and file APPLICANT COUNTRY
 . I "^I;9H.^"[CHKKEY S FLAG=1 Q
 . Q
 I TYPE=1 D  Q FLAG
 . I "^I;14D.^I;14D1.^I;14D2.^"[CHKKEY S FLAG=1 Q    ;obs
 . I "^IIC;1.1^IIC;1.2^IIC;1.3^"[CHKKEY S FLAG=1 Q   ;obs
 . I "^IIE;1.^IIE;2.^IIE;3.^"[CHKKEY S FLAG=1 Q      ;print only
 . I "^IIC;1.6^IIC;2.3^IIC;3.3^"[CHKKEY S FLAG=1 Q   ;disp only
 . Q
 ;
 Q FLAG
 ;
VERSION(EASAPP) ;alb/cmf/51
 ;return the version # of an application
 Q:$G(EASAPP)="" -1
 Q:'$D(^EAS(712,EASAPP)) -1
 Q +$P(^EAS(712,EASAPP,0),U,12)
 ;
