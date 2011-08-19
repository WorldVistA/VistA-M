SCUTBK10 ;ALB/SCK - Scheduling Broker Utilities ; 04 Sep 2002  12:53 PM
 ;;5.3;Scheduling;**41,264,297**;AUG 13, 1993
 ;
 Q
 ;
PARSE(SC) ;
 S SCFILE=$G(SC("FILE"))
 S SCIEN=$G(SC("IEN"))
 S SCVAL=$G(SC("VALUE"))
 S SCSTATUS=$G(SC("STATUS"))
 S SCSUBJ=$G(SC("SUBJ"),"PCMM NOTIFICATION")
 S SCDATE=$G(SC("DATE"))
 S SCADR=$G(SC("ADDRESS"))
 S SCHIEN=$G(SC("HIEN"))
 Q
 ;
PTASGMM(SCOK,SC) ;  Send MailMan message on single patient assignment to either 
 ; a team or a position.
 ;
 ;   Input:   SC = BT^404.42 Ien   Sets before action for team assign.
 ;            SC = AT^404.42 Ien   Sets after action for team assign.
 ;            SC = BP^404.43 Ien  Sets before action for position assign
 ;            SC = BA^404.43 Ien  Sets after action for position assign 
 ;
 N SCACT,SCIEN
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S SCOK=0
 S SCACT=$P($G(SC),U,1)
 S SCIEN=$P($G(SC),U,2)
 G:SCACT="" PTASGNQ
 G:SCIEN="" PTASGNQ
 ;
 D @SCACT
 S SCOK=1
PTASGNQ Q
 ;
BT ;
 D BEFORETM^SCMCDD1(SCIEN)
 Q
AT ;
 D AFTERTM^SCMCDD1(SCIEN)
 Q
BP ;
 D BEFORETP^SCMCDD1(SCIEN)
 Q
AP ;
 D AFTERTP^SCMCDD1(SCIEN)
 Q
 ;
MAILC(SCOK,SC) ;   call to invoke broker to send a mailman message from the
 ;           client
 ;
 N SCSUBJ,SCTEXT
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S SCOK=0
 S SCSUBJ=$G(SC("SUBJ"),"PCMM NOTIFICATION")
 S SCADR=$G(SC("ADDRESS"))
 ;
 S XMDUZ=DUZ
 S XMSUB=SCSUBJ
 D XMZ^XMA2
 G:XMZ<1 MAILQ
 ;
 D BLDTEXT(.SC,.SCTEXT)
 S XMTEXT="SCTEXT("
 ;
 I $P(SCADR,U,2)="TEST" D
 . S XMY("G.PCM MESSAGING@DEVFEX.ISC-ALBANY.VA.GOV")=""
 ;
 I $P(SCADR,U,2)="S" D
 . S XMY($P(SCADR,U,1))=""
 ;
 I $D(XMY)>0 D
 . D ^XMD
 . S SCOK=XMZ
MAILQ Q
 ;
BLDTEXT(SCVAL,SCTXT) ;  Build the message text array from the client
 ;
 N SCLINE,CNT
 S SCLINE=""
 F  S SCLINE=$O(SCVAL(SCLINE)) Q:+SCLINE=0  D
 . S SCTXT(SCLINE)=SCVAL(SCLINE)
 Q
 ;
NEWHIST(SCOK,SC) ;  Call to invoke the broker to determine whether the date for
 ;          the history entry being added is valid.
 ;
 N SCFILE,SCIEN,SCDATE,SCSTATUS,SCVAL,SCERMSG
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S SCOK=0
 D PARSE(.SC)
 ;
 S SCOK=$$NEWHIST^SCMCDD(SCFILE,SCIEN,SCDATE,"SCERMSG",SCSTATUS)
NEWDTQ Q
 ;
NEWSTC(SCOK,SC) ;  Call to invoke the broker to determine whether the status
 ;          entry for the current entry is valid.
 ;
 N SCFILE,SCIEN,SCDATE,SCSTATUS,SCVAL,SCERMSG
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S SCOK=0
 D PARSE(.SC)
 ;
 S SCOK=$$NEWHIST^SCMCDD(SCFILE,SCIEN,SCDATE,"SCERMSG",SCSTATUS)
NEWSTQ Q
 ;
DELDTC(SCOK,SC) ;  Call to invoke the broker to see if the history entry can
 ;          be deleted.
 ;
 N SCFILE,SCHIEN,SCERMSG
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S SCOK=0
 D PARSE(.SC)
 ;
 S SCOK=$$OKDEL^SCMCDD(SCFILE,SCHIEN,"SCERMSG")
DELDTQ Q
 ;
INACTC(SCOK,SC) ;   Call to invoke the broker to see if the history entry can
 ;           be inactivated.
 ;
 N SCFILE,SCIEN,SCDATE
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S SCOK=0
 D PARSE(.SC)
 ;
 S SCOK=$$OKINACT^SCMCDD(SCFILE,SCIEN,SCDATE,"SCERMSG")
INACTQ Q
 ;
CHGDTC(SCOK,SC) ;  Call to see if the date change for the history entry is 
 ;          valid.
 ;
 N SCFILE,SCIEN,SCDATE,SCERMSG
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S SCOK=0
 D PARSE(.SC)
 ;
 S SCOK=$$OKCHGDT^SCMCDD(SCFILE,SCHIEN,SCDATE,"SCERMSG")
CHGDTQ Q
 ;
MNTEST(SCOK,SC) ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 S DFN=+SC
 S SCOK=$$LST^DGMTU(DFN),$P(SCOK,U,10)=$$ONWAIT^SCMCWAIT(DFN),$P(SCOK,U,11)=$$SC^SCMCWAIT(SC)
 S $P(SCOK,U,12)=$$IU^SCMCTSK1(DFN)
 Q
 ;
