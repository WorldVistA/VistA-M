PSULR4 ;BIR/PDW - PBMS LABORATORY EMAIL GENERATOR ;10 JUL 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA(s)
 ; Reference to file  #4.3 supported by DBIA 2496,10091
 ; Reference to file #40.8 supported by DBIA 2438
 ;PSULC  = Line processing in ^tmp
 ;PSUTLC = Total Line count
 ;PSUMC  = Message counter
 ;PSUMLC = Message Line Counter
 ; RETURNS 
 ;PSUMSG("M") = # Messages
 ;PSUMSG("L") = # Lines
 ;
EN(PSUMSG) ;Scan and process for Division(s)
 ; PSUMSGT ("M")= # MESSAGES  ("L")= # LINES
 ;
 ;I '$G(PSUMASF) Q  ;Comment out so user can get detailed msg
 ;regardless of whether they send to Hines or not
 ;
 ;
 NEW PSUMAX,PSULC,PSUTMC,PSUTLC,PSUMC
 ; Scan TMP, split lines, transmit per MAX lines in Netmail
 S PSUMAX=$$VAL^PSUTL(4.3,1,8.3)
 S:PSUMAX'>0 PSUMAX=10000
 ;
 I '$D(^XTMP(PSULRSUB,"RECORDS")) G NODATA
DIV ;   Scan by division and send divisional messages
 ;
 S PSUDIV="" F  S PSUDIV=$O(^XTMP(PSULRSUB,"RECORDS",PSUDIV)) Q:PSUDIV=""  D MSG
 Q
 ;
MSG ;EP Send divisional message
 ;   Split and store into ^XTMP(PSULRSUB,"MESSAGE",PSUMC,PSULC)
 K ^XTMP(PSULRSUB,"MESSAGE")
 S PSUMC=1,PSUMLC=0
 F PSULC=1:1 S X=$G(^XTMP(PSULRSUB,"RECORDS",PSUDIV,PSULC)) Q:X=""  D
 . S PSUMLC=PSUMLC+1
 . I PSUMLC>PSUMAX S PSUMC=PSUMC+1,PSUMLC=0,PSULC=PSULC-1 Q  ; +  message
 . I $L(X)<235 S ^XTMP(PSULRSUB,"MESSAGE",PSUMC,PSUMLC)=X Q
 . F I=235:-1:1 S Z=$E(X,I) Q:Z="^"
 . S ^XTMP(PSULRSUB,"MESSAGE",PSUMC,PSUMLC)=$E(X,1,I)
 . S PSUMLC=PSUMLC+1
 . S ^XTMP(PSULRSUB,"MESSAGE",PSUMC,PSUMLC)="*"_$E(X,I+1,999)
 ;
 ;   Count Lines sent
 S PSUTLC=0
 F PSUM=1:1:PSUMC S X=$O(^XTMP(PSULRSUB,"MESSAGE",PSUM,""),-1),PSUTLC=PSUTLC+X
 ;
 S PSUMSG(PSUDIV,13,"M")=+$G(PSUMSG(PSUDIV,13,"M"))+PSUMC
 S PSUMSG(PSUDIV,13,"L")=+$G(PSUMSG(PSUDIV,13,"L"))+PSUTLC
TRANS ;EP   Transmit Messages
VARS ; Setup variables for contents
 ;
 I $D(^XTMP("PSU_"_PSUJOB,"DIV",PSUDIV)) D  Q
 .F PSUM=1:1:PSUMC D
 ..S PSUDIVNM=$P(^XTMP("PSU_"_PSUJOB,"DIV",PSUDIV),U,1)
 ..S XMSUB="V. 4.0 PBMLR "_$G(PSUMON)_" "_PSUM_"/"_PSUMC_" "_PSUDIV_" "_PSUDIVNM
 ..S XMDUZ=DUZ
 ..S XMTEXT="^XTMP(PSULRSUB,""MESSAGE"",PSUM,"
 ..M XMY=PSUXMYH
 ..S XMCHAN=1
 ..I $G(PSUMASF)!$G(PSUDUZ)!$G(PSUPBMG) D
 ...I PSUSMRY'=1 D ^XMD
 ;
 ;    Loop through messages generated and transmit them
 F PSUM=1:1:PSUMC D
 . S X=PSUDIV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 . S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 . S XMSUB="V. 4.0 PBMLR "_$G(PSUMON)_" "_PSUM_"/"_PSUMC_" "_PSUDIV_" "_PSUDIVNM
 . S XMDUZ=DUZ
 . S XMTEXT="^XTMP(PSULRSUB,""MESSAGE"",PSUM,"
 . M XMY=PSUXMYH
 . S XMCHAN=1
 . ;I $G(PSUMASF) D ^XMD
 . I $G(PSUMASF)!$G(PSUDUZ)!$G(PSUPBMG) D
 ..I PSUSMRY'=1 D ^XMD
 ;
 Q
NODATA ;EP transmit NO DATA FOUND
 S X=$$VALI^PSUTL(4.3,1,217),PSUSNDR=+$$VAL^PSUTL(4,X,99)
 S PSUDIV=PSUSNDR
 S PSUMSG(PSUDIV,13,"M")=$G(PSUMASF),PSUMSG(PSUDIV,13,"L")=0
 S XMDUZ=DUZ
 M XMY=PSUXMYH
 S PSUM=1,PSUMC=1
 S X=PSUDIV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 S XMSUB="V. 4.0 PBMLR "_$G(PSUMON)_" "_PSUM_"/"_PSUMC_" "_PSUDIV_" "_PSUDIVNM
 S X(1)="No data to report"
 S XMTEXT="X("
 S XMCHAN=1
 I $G(PSUMASF)!$G(PSUPBMG)!$G(PSUDUZ) D ^XMD
 Q
