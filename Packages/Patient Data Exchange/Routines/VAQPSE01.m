VAQPSE01 ;ALB/JRP,JFP - EXPORTED PDX ROUTINE;9-FEB-94
 ;;1.5;PATIENT DATA EXCHANGE;**1**;NOV 17, 1993
GMTSPDX ; SLC/JER,SBW - PDX Health Summary Driver ;12/29/93  16:41
 ;;2.5;Health Summary;**8**;Dec 16, 1992
GET(TRAN,DFN,SEGPTR,ROOT,GMTSLCNT,GMTSDLM,GMTSNDM) ; Get HS for PDX
 ; Data retrieved from HS is return in ROOT parmeter reference passing.
 ; Function returns 2 piece variable delimited with "^".
 ; Piece 1 = tot line cnt of data extract to ROOT.
 ; Piece 2 = contains entry line cnt (GMTSLCNT) + Piece 1
 ; Note: Currently Data begins with GMTSLCNT + 1 and
 ;       Piece 2 is last node # of ROOT
 ;     : If TRAN is passed
 ;         The patient pointer of the transaction will be used
 ;         Encryption will be based on the transaction
 ;       If DFN is passed
 ;         Encryption will be based on the site parameter
 ;     : Pointer to transaction takes precedence over DFN ... if
 ;         TRAN>0 the DFN will be based on the transaction
 ;
 ;DETERMINE TRUE DFN
 S TRAN=+$G(TRAN)
 S DFN=+$G(DFN)
 Q:(('TRAN)&('DFN)) "-1^Did not pass pointer to transaction or patient"
 I (TRAN) Q:('$D(^VAT(394.61,TRAN))) "-1^Did not pass valid pointer to VAQ - TRANSACTION file"
 I (TRAN) S DFN=+$P($G(^VAT(394.61,TRAN,0)),"^",3) Q:('DFN) "-1^Transaction did not contain pointer to PATIENT file"
 Q:('$D(^DPT(DFN))) "-1^Did not pass valid pointer to PATIENT file"
 ;
 ; Scope FM local variables that don't get cleaned up by %ZIS
 ; SPOOLER call
 N C,D0,DA,DI,DIE,DIC,DQ,DR,GMTS,GMTS1,GMTS2,GMTSAGE,GMTSDOB,GMTSDTM
 N GMTSDUZ,GMTSLO,GMTSLPG,GMTSPNM,GMTSRB,GMTSSN,GMTSSPL,GMTSWARD,GMTSY
 N SEX,SPLDOC,VADM,VAERR,VAIN,X,Y,ZISIOST
 N %,%X,%XX,%Y,%YY,%Z4,%ZDA,%ZS,%ZY,POP
 S GMTSDUZ=$G(DUZ),GMTSSPL=$P($G(^GMT(142.99,1,0)),U,4),DUZ=.5
 I GMTSSPL']"" S GMTSY="-1^No Spool Device allocated" G GETX
 ;CONVERT SEGPTR TO ENTRY IN HEALTH SUMMARY COMPONENT FILE
 S X=+$P($G(^VAT(394.71,SEGPTR,0)),"^",4)
 I ('X) S GMTSY="-1^Unable to convert PDX data segment to Health Summary component" G GETX
 S SEGPTR=X
 ;DETERMINE IF COMPONENT HAS BEEN DISABLED
 S X=$G(^GMT(142.1,SEGPTR,0))
 I (($P(X,"^",6)="T")!($P(X,"^",6)="P")) D  G GETX
 .;DISABLED
 .S GMTSY=$P(X,"^",8)
 .I (GMTSY'="") S GMTSY="-1^"_GMTSY Q
 .S GMTSY="-1^Component has been disabled  "
 .S GMTSY=GMTSY_$S($P(X,"^",6)="T":"(temporary)",1:"(permanent)")
 ;OPEN SPOOL DEVICE
 S IOP=GMTSSPL_";HSPDX"_DFN D ^%ZIS
 I POP S GMTSY="-1^Spool open failed" G GETX
 D ONECOMP(DFN,SEGPTR,$G(GMTSDLM),$G(GMTSNDM)) ; Write component
 S SPLDOC=$G(IO("SPOOL")) D ^%ZISC
 I +SPLDOC D
 . N SPLSTAT,SPLPTR,GMTSDOC
 . ; Wait until spool document is "ready" (ONLY CHECK EVERY 5 SECONDS)
 . F  S SPLSTAT=$P($G(^XMB(3.51,SPLDOC,0)),U,3) Q:SPLSTAT="r"  H 5
 . S GMTSDOC=$G(^XMB(3.51,SPLDOC,0)),SPLPTR=$P(GMTSDOC,U,10)
 . I '+SPLPTR!('+$P(GMTSDOC,U,9)) S GMTSY="-1^No data available" Q
 . S GMTSY=$$XFER(SPLPTR,ROOT,GMTSDOC,+$G(GMTSLCNT))
 . D DSDOC^ZISPL(SPLPTR),DSD^ZISPL(SPLDOC)
 .;CHECK TO SEE IF ENCRYPTION IS ON
 .S:(TRAN) X=$$TRANENC^VAQUTL3(TRAN,0)
 .S:('TRAN) X=$$NCRYPTON^VAQUTL2(0)
 .S:(X) X=$$ENCDSP^VAQHSH(TRAN,ROOT,X,(GMTSLCNT+1),+GMTSY)
 E  S GMTSY="-1^Spool document not created"
GETX S DUZ=+$G(GMTSDUZ)
 Q $G(GMTSY)
ONECOMP(DFN,SEGPTR,GMTSDLM,GMTSNDM) ; Print a single HS component to IO
 N GMTSEG,GMTSEGI,GMTSEGC,GMTSTITL
 S GMTSTITL="PDX TRANSMISSION"
 S GMTSEG(1)=1_U_SEGPTR_U_$G(GMTSNDM)_U_$G(GMTSDLM)
 S (GMTSEGI(SEGPTR),GMTSEGC)=1
 D EN^GMTS1
 Q
XFER(SPLDAT,ROOT,GMTSDOC,GMTSLCNT) ; Transfer text from SPOOL DOC to ROOT
 N GMTSI,GMTSL,GMTSREC,GMTSPRT,GMTSX S (GMTSI,GMTSL)=0,GMTSPRT=1
 F  S GMTSI=$O(^XMBS(3.519,SPLDAT,2,GMTSI)) Q:+GMTSI'>0  D  Q:$E(GMTSREC,1,7)="*** END"
 . S GMTSREC=$G(^XMBS(3.519,SPLDAT,2,GMTSI,0))
 . ;Don't transfer data until a line with 3 hyphens or ** DECEASED **
 . ;is found nor after "*** END" is found
 . I (GMTSL=0&($E(GMTSREC,1,3)="---")!(GMTSREC["** DECEASED **"))!((GMTSL>0)&($E(GMTSREC,1,7)'="*** END")) D
 . . I GMTSREC["|TOP|" S GMTSPRT=0
 . . S:GMTSPRT GMTSL=GMTSL+1,GMTSLCNT=GMTSLCNT+1,@ROOT@("DISPLAY",GMTSLCNT,0)=GMTSREC
 . . I GMTSREC["(continued)" S GMTSPRT=1
 I +GMTSL,$P(GMTSDOC,U,11) D  ;incomplete report indicator
 . S GMTSL=GMTSL+1,@ROOT@("DISPLAY",GMTSL,0)="*** Data is incomplete ***"
 I '+GMTSL S GMTSL="-1^Text transfer from Spool Document failed"
 Q $G(GMTSL)_U_$G(GMTSLCNT)
