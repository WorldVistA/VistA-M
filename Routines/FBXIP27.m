FBXIP27 ;WOIFO/SS-PATCH INSTALL ROUTINE ;8/27/01
 ;;3.5;FEE BASIS;**27**;JAN 30, 1995
 ;File #162.7 conversion routine
 Q  ;stub
 ;
 ;/**
 ;post-install entry point
POST27 ;*/
 N FBSNDML S FBSNDML=1
 D PREPRPT
 Q
 ;
 ;/**
 ;This utility can be run anytime to detect claims that don't have 
 ;all required information. 
 ;
REPORT ;*/
 N FBLIMDT S FBLIMDT=0
 S DIR("A",1)="  This utility can be run anytime to detect claims that don't have all"
 S DIR("A",2)="  the required information. The user is able to specify a starting date"
 S DIR("A",3)="  for the report. If the date is specified then the utility shows only"
 S DIR("A",4)="  the claims that were received on this date or later."
 S DIR("A",5)=" "
 Q:$$SETLIMT()=1
 D PREPRPT
 Q
 ;
 ;/**
 ;specifies the starting date 
SETLIMT() ;*/
 N DUOUT,DIROUT,DIRUT,DTOUT
 N FBDT1 S FBDT1=0
 K ^TMP($J,"FBXIP27")
 S DIR("A")="  Do you want to specify the starting date for the report? "
 S DIR("?")="  Please answer Yes or No."
 S DIR("B")="YES",DIR(0)="YA^^"
 D ^DIR K DIR
 I $D(DUOUT)!($D(DIROUT)) Q 1
 I $D(DIRUT) Q 0
 I $G(Y)=0 S FBLIMDT=0 Q 0
 W !
 S DIR("A")="  Starting date for the report: "
 S DIR("?")="  Enter a date in proper format."
 S FBDT1=$$FMADD^XLFDT($$DT^XLFDT,-365*2,0,0,0)
 S DIR("B")=$$FMTE^XLFDT(FBDT1)
 S DIR(0)="DA^::EX^"
 D ^DIR K DIR
 I $D(DUOUT)!($D(DIROUT)) Q 1
 I $D(DIRUT) S Y=FBDT1
 S FBLIMDT=Y
 Q 0
 ;
 ;/**
 ;Prepares report for claims w/o required information
 ;
PREPRPT ;*/
 N FBDTS,FBS,FBS1,FBV,FBP,FBVP,FBV1,FBP1,FBVP1,FBCNT,FBIND,FBTXTCNT,FBSTRDT
 S (FBS,FBS1,FBV,FBP,FBVP,FBV1,FBP1,FBVP1,FBCNT,FBTXTCNT)=0,(FBDTS,FBIND)=""
 S FBSTRDT=$G(XPDQUES("POS2"))
 S:$D(FBLIMDT) FBSTRDT=$G(FBLIMDT)
 K ^TMP($J,"FBXIP27")
 S FBS1=FBSTRDT-1 F  S FBS1=$O(^FB583("B",FBS1)) Q:+FBS1=0  D
 . S FBS=0 F  S FBS=$O(^FB583("B",FBS1,FBS)) Q:+FBS=0  D
 .. S FBDTS=$G(^FB583(FBS,0)) Q:FBDTS=""
 .. S FBCNT=FBCNT+1,FBIND=""
 .. I $P(FBDTS,"^",11)=1!($P(FBDTS,"^",11)=4) D
 ... I $P(FBDTS,"^",3)="" S FBIND=FBIND_"A"
 ... I $P(FBDTS,"^",10)="" S FBIND=FBIND_"B"
 .. I $P(FBDTS,"^",11)="",$P($G(^FB(162.92,+$P(FBDTS,"^",24),0)),"^",4)'<30 D
 ... I $P(FBDTS,"^",3)="" S FBIND=FBIND_"C"
 ... I $P(FBDTS,"^",10)="" S FBIND=FBIND_"D"
 .. I FBIND'="" S ^TMP($J,"FBXIP27",FBIND,FBS)=""
 .. S:FBIND="A" FBV=FBV+1
 .. S:FBIND="B" FBP=FBP+1
 .. S:FBIND="AB" FBVP=FBVP+1
 .. S:FBIND="C" FBV1=FBV1+1
 .. S:FBIND="D" FBP1=FBP1+1
 .. S:FBIND="CD" FBVP1=FBVP1+1
 ;
 D WBMES("  The following claims have been completed or dispositioned without")
 D WMES("  supplying all required information. It is necessary to review them")
 D WMES("  in order to supply the claims with all missed information.")
 I +FBSTRDT>0 S Y=FBSTRDT D DD^%DT,WBMES("  === STARTING DATE: "_Y_" ===")
 D WBMES("  === DISPOSITIONED CLAIMS ===")
 D REPTXT("A","  without VENDOR information ( "_FBV_" ) :")
 D REPTXT("B","  without PATIENT TYPE information ( "_FBP_" ) :")
 D REPTXT("AB","  without VENDOR and PATIENT TYPE information ( "_FBVP_" ) :")
 D WBMES("  === NON-DISPOSITIONED CLAIMS ===")
 D REPTXT("C","  without VENDOR information ( "_FBV1_" ) :")
 D REPTXT("D","  without PATIENT TYPE information ( "_FBP1_" ) :")
 D REPTXT("CD","  without VENDOR and PATIENT TYPE information ( "_FBVP1_" ) :")
 ;
 D PRINTREP
 D:$D(FBSNDML) SENDMAIL
 K ^TMP($J,"FBXIP27")
 Q
 ;
 ;
 ;/**
 ;prepares report text,
 ;list claims w/o required information 
REPTXT(TYPE,MESS1) ;*/
 I $D(^TMP($J,"FBXIP27")),+$O(^TMP($J,"FBXIP27",TYPE,0)) D
 . N FBDT,FBDA,FBMESS,FBTMP
 . D WBMES(MESS1)
 . D WBMES("  Claim Date   Patient                Vendor           Submitted by")
 . D WMES("  ------------ -------------------- ---------------- --------------------")
 . S FBDA=0 F  S FBDA=$O(^TMP($J,"FBXIP27",TYPE,FBDA)) Q:'FBDA  D
 . . S FBMESS=$$LJ^XLFSTR($E($$GET1^DIQ(162.7,FBDA_",",.01),1,12),12)_" "
 . . S FBMESS=FBMESS_$$LJ^XLFSTR($E($$GET1^DIQ(162.7,FBDA_",",2),1,20),20)_" "
 . . S FBMESS=FBMESS_$$LJ^XLFSTR($E($$GET1^DIQ(162.7,FBDA_",",1),1,16),16)_" "
 . . S FBMESS=FBMESS_$$LJ^XLFSTR($E($$GET1^DIQ(162.7,FBDA_",",23),1,20),20)_" "
 . . D WMES("  "_FBMESS)
 Q
 ;/**
 ;writes into ^TMP
WMES(FBSTR) ;*/
 S FBTXTCNT=FBTXTCNT+1
 S ^TMP($J,"FBXIP27","TXT",FBTXTCNT)=FBSTR
 Q
 ;
 ;/**
 ;writes into ^TMP with leading "" (it works like "!")
WBMES(FBSTR) ;*/
 D WMES("")
 D WMES(FBSTR)
 Q
 ;
 ;/**
 ;prints report on the install screen
PRINTREP ;*/
 Q:'$D(^TMP($J,"FBXIP27","TXT"))
 N CNT S CNT=0
 F  S CNT=$O(^TMP($J,"FBXIP27","TXT",CNT)) Q:+CNT=0  D
 . D MES^XPDUTL($G(^TMP($J,"FBXIP27","TXT",CNT)))
 Q
 ;
 ;/**
 ;sends e-mail with report to installer
 ;
SENDMAIL ;*/
 Q:'$D(^TMP($J,"FBXIP27","TXT"))
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="FB*3.5*27 Install: Claims w/o all necessary information."
 S XMDUZ=.5
 S XMTEXT="^TMP($J,""FBXIP27"",""TXT"","
 S XMY(DUZ)=""
 D ^XMD
 Q
 ;
