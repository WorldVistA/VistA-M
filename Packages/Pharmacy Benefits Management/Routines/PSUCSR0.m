PSUCSR0 ;BIR/DJM,DJE - Extract records for CS ;25 AUG 1998
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ; 3.2.11.34 Functional Requirement 34
 ;-------------------------------------
 ;
 ; 3.2.11.35 Functional Requirement 35
 ;-------------------------------------
 ;DBIA(S)
 ; Reference to file #4.3  supported by DBIA 2496
 ; Reference to file #40.8 supported by DBIA 2438
 ;
 ; ----- SEE SPECS FOR DETAIL
 ;
EN(PSUMSG) ;Scan and process for Division(s)
 ; PSUMSGT ("M")= # MESSAGES  ("L")= # LINES
 ;
TEST S Y=PSUSDT\1 X ^DD("DD") S PSUDTS=Y ;    start date
 S Y=PSUEDT\1 X ^DD("DD") S PSUDTE=Y ;    end date
 S PSUDUZ=$G(PSUDUZ,DUZ)
 S PSUDIV=0,Z=0
 S:'$D(PSUCSJB) PSUCSJB="PSUCS_"_PSUJOB
 S PSUMC=0 ; No messages set yet
 K ^XTMP(PSUCSJB,"MAIL")
 K ^XTMP(PSUCSJB,"REPORT")
 K ^XTMP(PSUCSJB,"CSFR-37")
 S PSUXMY(DUZ)="" ; *** TESTING
 I '$D(PSUXMY) S PSUXMY(PSUDUZ)="" ; THIS IS WHO WE MAIL TO
 N Z ; Z used to pass back "CONFIRM" numbers
 F  S PSUDIV=$O(^XTMP(PSUCSJB,"RECORDS",PSUDIV)) Q:PSUDIV=""  D
 . S PSUMSEQ=0
 . D DIV(.Z) ; Process a single divisions data extract
 . D SUMMRY^PSUCSR1(.Z) ; Send the summary report(s)
 ; PSUMC holding a variable
 I PSUMC=0 D  ; No data to send messages
 . S PSUMSEQ=0,PSUDIV=PSUSNDR
 . D DIV(.Z)
 . D SUMMRY^PSUCSR1(.Z)
 D VARS("MAIL",1,PSUMC)
 M ^XTMP("PSU_"_$G(PSUJOB,$J),"CONFIRM")=Z
 Q
 ; 3.2.11.36 Functional Requirement 36
 ;-------------------------------------
 ;
 ; 3.2.11.37 Functional Requirement 37
 ;-------------------------------------
 ;
 ;
DIV(PSUMSG) ;EP returns PSUMSG("M")= # MESSAGES ("L")= # LINES
 ; Scan TMP, split lines, transmit per MAX lines in Netmail
 S PSUMAX=$$VAL^PSUTL(4.3,1,8.3)
 S PSUMAX=$S(PSUMAX="":10000,PSUMAX>10000:10000,1:PSUMAX)
 ;
 ;   Split and store into ^XTMP(PSUCSJB,"MAIL",PSUMC,PSUMLC)
 S PSUOMC=PSUMC,PSUMC=PSUMC+1,PSUMSEQ=PSUMSEQ+1,PSUMLC=0
 K ^XTMP(PSUCSJB,"MAIL",PSUMC)
 S PSUTIEN="",PSULC=0,PSUTLC=0
 F  S PSUTIEN=$O(^XTMP(PSUCSJB,"RECORDS",PSUDIV,PSUTIEN)) Q:PSUTIEN=""  D
 . S PSULC=PSULC+1
 . S PSURC=$O(^XTMP(PSUCSJB,"RECORDS",PSUDIV,PSUTIEN,""))
 . S X=$G(^XTMP(PSUCSJB,"RECORDS",PSUDIV,PSUTIEN,PSURC))
 . D EN^PSUCSR1 ; Prepare data for next report (drug breakdown)
 . Q:$G(PSUSMRY)  ; Only do a summary
 . I $G(PSUMASF)!$G(PSUDUZ)!$G(PSUPBMG) D  ; Detail to Hines,self,group
 .. S PSUMLC=PSUMLC+1,PSUTLC=PSUTLC+1
 .. I PSUMLC>PSUMAX S PSUMC=PSUMC+1,PSUMLC=0,PSULC=PSULC+1 Q  ; +  message
 .. I $L(X)<235 S ^XTMP(PSUCSJB,"MAIL",PSUMC,PSUMLC)=X Q
 .. F I=235:-1:1 S Z=$E(X,I) Q:Z="^"
 .. S ^XTMP(PSUCSJB,"MAIL",PSUMC,PSUMLC)=$E(X,1,I)
 .. S PSUMLC=PSUMLC+1
 .. S ^XTMP(PSUCSJB,"MAIL",PSUMC,PSUMLC)="*"_$E(X,I+1,999)
 ; Go mail the message now
 ;I '$G(PSUMASF) S PSUMC=PSUMC-1 Q  ; Do not update the master file, commented out to send detailed message to user DAM
 I PSUMLC=0 D
 . S PSUMLC=PSUMLC+1
 . S ^XTMP(PSUCSJB,"MAIL",PSUMC,PSUMLC)="No data to report"
 S ^XTMP(PSUCSJB,"MAIL",PSUMC)=PSUDIV
 S ^XTMP(PSUCSJB,"DETAIL",PSUMC)=PSUMSEQ_"/"_(PSUMC-PSUOMC)
 S PSUMSG(PSUDIV,6,"M")=$G(PSUMSG(PSUDIV,6,"M"))+(PSUMC-PSUOMC)
 S PSUMSG(PSUDIV,6,"L")=$G(PSUMSG(PSUDIV,6,"L"))+PSUMLC
 Q
 ;
VARS(PSUMMS,S,E) ; Setup variables for contents
 S PSUMC=0,PSUTLC=0
 S XMDUZ=PSUDUZ
 F PSUM=S:1:E D
 . Q:'$D(^XTMP(PSUCSJB,"MAIL",PSUM))
 . S PSUMC=PSUMC+1
 . S PSUMLC=$O(^XTMP(PSUCSJB,"MAIL",PSUM,""),-1),PSUTLC=PSUTLC+PSUMLC
 . S PSUDIV=^XTMP(PSUCSJB,"MAIL",PSUM)
 . I $D(^XTMP(PSUCSJB,"DETAIL",PSUM)) M XMY=PSUXMYH
 . I $D(^XTMP(PSUCSJB,"SUMMARY 1",PSUM)) M XMY=PSUXMYS1
 . I $D(^XTMP(PSUCSJB,"SUMMARY 2",PSUM)) M XMY=PSUXMYS2
 . S X=PSUDIV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 . S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 . S PSUMSEQ=$G(^XTMP(PSUCSJB,"DETAIL",PSUM)) ; Get the mail sequence data
 . S PSUMSEQ=$S(PSUMSEQ="":" ",1:" "_PSUMSEQ_" ")
 . S XMSUB="V. 4.0 PBMCS "_PSUMON_PSUMSEQ_PSUDIV_" "_PSUDIVNM
 . S XMTEXT="^XTMP(PSUCSJB,PSUMMS,PSUM,"
 . S XMCHAN=1
 . D ^XMD
 ;
 Q
