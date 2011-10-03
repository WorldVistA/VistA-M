OCXBDT ;SLC/RJS,CLA - BUILD OCX PACKAGE DIAGNOSTIC ROUTINES ;8/04/98  13:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 N X,IOP,TOTL S TOTL=0
 I '$D(IOM) S IOP=0 D ^%ZIS K IOP
 K ^TMP("OCXBDT",$J),^UTILITY($J),OCXPATH
 S ^TMP("OCXBDT",$J)=($P($H,",",2)+($H*86400)+(4*60*60))_" <- ^TMP ENTRY EXPIRATION DATE FOR ^OCXOPURG"
 S OCXLIN2=$T(+2)
 S OCXLIN3=$T(+3)
 ;
 D ^OCXBDT1 ; Get Routine Checksums
 ;
 D ^OCXBDT2 ; Get File Data
 ;
 S TOTL=$$EN^OCXBDT3 ; File Routines
 ;
 S TOTL=TOTL+$$EN^OCXBDTA ; File Runtime Library Routine OCXDIAG
 ;
 S TOTL=TOTL+$$EN^OCXBDT4 ; File Runtime Library Routine OCXDI0
 ;
 S TOTL=TOTL+$$EN^OCXBDT5 ; File Runtime Library Routine OCXDI1
 ;
 S TOTL=TOTL+$$EN^OCXBDT6 ; File Runtime Library Routine OCXDI2
 ;
 S TOTL=TOTL+$$EN^OCXBDT7 ; File Runtime Library Routine OCXDI3
 ;
 S TOTL=TOTL+$$EN^OCXBDT8 ; File Runtime Library Routine OCXDI4
 ;
 S TOTL=TOTL+$$EN^OCXBDT9 ; File Runtime Library Routine OCXDI5
 ;
EXIT K ^TMP("OCXBDT",$J),^UTILITY($J)
 ;
 W !!,TOTL,"  total lines of code filed.",!!
 ;
 Q
 ;
READ(OCX0,OCXA,OCXB,OCXL) ;
 N X,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q:'$L($G(OCX0)) U
 S DIR(0)=OCX0
 S:$L($G(OCXA)) DIR("A")=OCXA
 S:$L($G(OCXB)) DIR("B")=OCXB
 F X=1:1:($G(OCXL)-1) W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q U
 Q Y
 ;
CUCI() Q:'$D(^%ZOSF("UCI")) "" N Y X ^%ZOSF("UCI") Q Y
 ;
