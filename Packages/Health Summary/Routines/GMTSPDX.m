GMTSPDX ;SLC/JER,SBW - PDX Health Summary Driver ; 08/27/2002
 ;;2.7;Health Summary;56;Oct 20, 1995
 ;
 ; External References
 ;   DBIA   298  ^VAT(394.61
 ;   DBIA   820  ^VAT(394.71
 ;   DBIA   819  $$ENCDSP^VAQHSH
 ;   DBIA   818  $$NCRYPTON^VAQUTL2
 ;   DBIA   817  $$TRANENC^VAQUTL3
 ;   DBIA  3587  ^XMB(3.51
 ;   DBIA  2056  $$GET1^DIQ (file 3.51)
 ;   DBIA  3588  ^XMBS(3.519
 ;   DBIA   999  ^DD(142.99
 ;   DBIA 10035  ^DPT(
 ;   DBIA 10086  ^%ZIS
 ;   DBIA 10089  ^%ZISC
 ;   DBIA 10004  Y^DIQ
 ;   DBIA  1092  DSD^ZISPL
 ;   DBIA  1092  DSDOC^ZISPL
 ;                    
GET(TRAN,DFN,SEGPTR,ROOT,GMTSLCNT,GMTSDLM,GMTSNDM) ; Get HS for PDX
 ;                       
 ; Data retrieved from HS is return in ROOT parameter
 ; reference passing.  Function returns 2 piece 
 ; variable delimited with "^".
 ;                     
 ;   Piece 1 = tot line cnt of data extract to ROOT.
 ;   Piece 2 = contains entry line cnt (GMTSLCNT) + Piece 1
 ;                  
 ; Note: Currently Data begins with GMTSLCNT + 1 and
 ;       Piece 2 is last node # of ROOT
 ;                        
 ;     If TRAN is passed
 ;         The patient pointer of the transaction will be used
 ;         Encryption will be based on the transaction
 ;                        
 ;     If DFN is passed
 ;         Encryption will be based on the site parameter
 ;                        
 ;     Pointer to transaction takes precedence over DFN ... if
 ;         TRAN>0 the DFN will be based on the transaction
 ;                         
 ;   Determin true DFN
 S TRAN=+$G(TRAN),DFN=+$G(DFN)
 Q:(('TRAN)&('DFN)) "-1^Did not pass pointer to transaction or patient"
 I (TRAN) Q:('$D(^VAT(394.61,TRAN))) "-1^Did not pass valid pointer to VAQ - TRANSACTION file"
 I (TRAN) S DFN=+$P($G(^VAT(394.61,TRAN,0)),"^",3) Q:('DFN) "-1^Transaction did not contain pointer to PATIENT file"
 Q:('$D(^DPT(DFN))) "-1^Did not pass valid pointer to PATIENT file"
 ;   NEW variables not cleaned up by %ZIS SPOOLER call
 N C,D0,DA,DI,DIE,DIC,DQ,DR,GMTS,GMTS1,GMTS2,GMTSAGE,GMTSDOB,GMTSDTM
 N GMTSDUZ,GMTSLO,GMTSLPG,GMTSPNM,GMTSRB,GMTSSN,GMTSSPL,GMTSWARD,GMTSY
 N SEX,SPLDOC,VADM,VAERR,VAIN,X,Y,ZISIOST,LINES,INCOMP
 N %,%X,%XX,%Y,%YY,%Z4,%ZDA,%ZS,%ZY,POP,Y,C
 S GMTSDUZ=$G(DUZ),DUZ=.5
 S Y=$P($G(^GMT(142.99,1,0)),U,4),C=$P(^DD(142.99,.04,0),U,2)
 D Y^DIQ
 S GMTSSPL=Y
 I GMTSSPL']"" S GMTSY="-1^No Spool Device allocated" G GETX
 ;   Convert SEGPTR to entry in file 142.1
 S X=+$P($G(^VAT(394.71,SEGPTR,0)),"^",4)
 I ('X) S GMTSY="-1^Unable to convert PDX data segment to Health Summary component" G GETX
 S SEGPTR=X
 ;   Determin if Component has benn disabled
 S X=$G(^GMT(142.1,SEGPTR,0))
 I (($P(X,"^",6)="T")!($P(X,"^",6)="P")) D  G GETX
 .S GMTSY=$P(X,"^",8)
 .I (GMTSY'="") S GMTSY="-1^"_GMTSY Q
 .S GMTSY="-1^Component has been disabled  "
 .S GMTSY=GMTSY_$S($P(X,"^",6)="T":"(temporary)",1:"(permanent)")
 ;   Open SPOOL Device
 S IOP=GMTSSPL_";HSPDX"_DFN D ^%ZIS
 I POP S GMTSY="-1^Spool open failed" G GETX
 ;   Write Component
 D ONECOMP(DFN,SEGPTR,$G(GMTSDLM),$G(GMTSNDM))
 S SPLDOC=$G(IO("SPOOL")) D ^%ZISC
 I +SPLDOC D
 . N SPLSTAT,SPLPTR,LINES,INCOMP
 . ;   Wait until document is "ready" (Check every 5 seconds)
 . F  Q:$$GET1^DIQ(3.51,(+SPLDOC_","),2,"I")="r"  H 5
 . S SPLPTR=$$GET1^DIQ(3.51,(+SPLDOC_","),9,"I")
 . S LINES=$$GET1^DIQ(3.51,(+SPLDOC_","),8,"I")
 . S INCOMP=+($$GET1^DIQ(3.51,(+SPLDOC_","),10,"I"))
 . I '+SPLPTR!('+LINES) S GMTSY="-1^No data available" Q
 . S GMTSY=$$XFER(SPLPTR,ROOT,INCOMP,+$G(GMTSLCNT))
 . D DSDOC^ZISPL(SPLDOC),DSD^ZISPL(SPLPTR)
 . ;   Check to see if Encryption is ON
 . S:(TRAN) X=$$TRANENC^VAQUTL3(TRAN,0)
 . S:('TRAN) X=$$NCRYPTON^VAQUTL2(0)
 . S:(X) X=$$ENCDSP^VAQHSH(TRAN,ROOT,X,(GMTSLCNT+1),+GMTSY)
 E  S GMTSY="-1^Spool document not created"
GETX ;   End Getting HS for PDX
 S DUZ=+$G(GMTSDUZ)
 Q $G(GMTSY)
 ;                  
ONECOMP(DFN,SEGPTR,GMTSDLM,GMTSNDM) ; Print a single HS component to IO
 N GMTSEG,GMTSEGI,GMTSEGC,GMTSTITL
 S GMTSTITL="PDX TRANSMISSION"
 S GMTSEG(1)=1_U_SEGPTR_U_$G(GMTSNDM)_U_$G(GMTSDLM)_U_U_"N"_U_"L"_U_"Y"
 S (GMTSEGI(SEGPTR),GMTSEGC)=1
 D EN^GMTS1
 Q
 ;                  
XFER(SPLDAT,ROOT,INCOMP,GMTSLCNT) ; Transfer text from SPOOL DOC to ROOT
 N GMTSI,GMTSL,GMTSREC,GMTSPRT,GMTSX S (GMTSI,GMTSL)=0,GMTSPRT=1
 F  S GMTSI=$O(^XMBS(3.519,SPLDAT,2,GMTSI)) Q:+GMTSI'>0  D  Q:$E(GMTSREC,1,7)="*** END"
 . S GMTSREC=$G(^XMBS(3.519,SPLDAT,2,GMTSI,0))
 . ;                              
 . ;   Don't transfer data until a line with 3 hyphens or 
 . ;   ** DECEASED ** is found nor after "*** END" is found
 . ;                              
 . I (GMTSL=0&($E(GMTSREC,1,3)="---")!(GMTSREC["** DECEASED **"))!((GMTSL>0)&($E(GMTSREC,1,7)'="*** END")) D
 . . I GMTSREC["|TOP|" S GMTSPRT=0
 . . S:GMTSPRT GMTSL=GMTSL+1,GMTSLCNT=GMTSLCNT+1,@ROOT@("DISPLAY",GMTSLCNT,0)=GMTSREC
 . . I GMTSREC["(continued)" S GMTSPRT=1
 ;   Incomplete Report Indicator
 I +GMTSL,+($G(INCOMP)) D
 . S GMTSL=GMTSL+1,@ROOT@("DISPLAY",GMTSL,0)="*** Data is incomplete ***"
 ;   Transfer Failed
 I '+GMTSL S GMTSL="-1^Text transfer from Spool Document failed"
 Q $G(GMTSL)_U_$G(GMTSLCNT)
