ACKQP17 ;ST/BP-OIFO Post Install routine for ACKQ*3*17 ; 9/23/09 6:37am
 ;;3.0;QUASAR;**17**;Sept. 26, 2007;Build 28
 ;
 ;This is the Post install for ACKQ*3*17
 ;Data migration of file 509850.3 and Mailman message displaying after
 ; data in file.
 ;
 Q
POST ;Repoint (POST INSTALL ACKQ*3*17)
 N ACKQA,DA,DIE,DR,MSG,MCNT,NPIEN,NPNAM,XMDUZ,XMSUB,XMTEXT,USRPT,MASK,ERR
 S MCNT=1,MASK="                                                       "
 S ACKQA=0,DIE="^ACK(509850.3,"
 ;Quit if this patch has been previously installed.
 I $$PATCH^XPDUTL("ACKQ*3.0*17") D  Q
 . S XMSUB="ACKQ*3.0*17 Installed Without Data Migration."
 . F  S ACKQA=$O(^ACK(509850.3,ACKQA)) Q:'ACKQA  I $$GET1^DIQ(509850.3,ACKQA,.06,"I") S:$$GET1^DIQ(509850.3,ACKQA,.07,"I") XMY($$GET1^DIQ(509850.3,ACKQA,.07,"I"))=""
 . S XMY(DUZ)=""
 . S MSG(MCNT)="Patch ACKQ*3.0*17 was previously installed, the data migration",MCNT=MCNT+1
 . S MSG(MCNT)="has been skipped on the previously rebuilt file #509850.3",MCNT=MCNT+1
 . S XMDUZ="QUASAR",XMSUB="ACKQ*3.0*17 Post Install Message.",XMTEXT="MSG("
 . N DIFROM D ^XMD
 S MSG(MCNT)="This is a list of data in the A&SP Staff File after installation",MCNT=MCNT+1
 S MSG(MCNT)=" of ACKQ*3*17. Be sure to double check this data is correct before running",MCNT=MCNT+1
 S MSG(MCNT)=" any ACKQ Menu options.",MCNT=MCNT+1
 S MSG(MCNT)="File 200 IEN & NAME                            File 509850.3 IEN",MCNT=MCNT+1
 F  S ACKQA=$O(^ACK(509850.3,ACKQA)) Q:'ACKQA  D
 . S USRPT=$$GET1^DIQ(509850.3,ACKQA,.01,"I"),NPIEN=$$GET1^DIQ(8930.3,$G(USRPT),.01,"I"),NPNAM=$$GET1^DIQ(200,NPIEN,.01,"E")
 . I (NPNAM="")!('NPIEN) S ERR(MCNT)="Bad entry at ^ACK(509850.3,"_ACKQA_" Please review." Q
 . I $$GET1^DIQ(509850.3,ACKQA,.06,"I") S XMY(NPIEN)=""
 . S MSG(MCNT)=NPIEN_$E(MASK,1,12-$L(NPIEN))_NPNAM_$E(MASK,1,35-$L(NPNAM))_ACKQA_$E(MASK,1,12-$L(ACKQA)),MCNT=MCNT+1
 . S DA=ACKQA,DR=".01////"_NPNAM_";.07////"_NPIEN
 . D ^DIE
 S DIK="^ACK(509850.3," D IXALL^DIK ;reindex.
 D DELIX^DDMOD(509850.3,.01,2,"") K ^ACK(509850.3,"D") ; Remove "D" X-ref.
 ;Tack known ERROR data on at end of mail msg.
 S CNT=0 F  S CNT=$O(ERR(CNT)) Q:'CNT  S MSG(MCNT)=ERR(CNT),MCNT=MCNT+1
 S XMDUZ="QUASAR",XMSUB="VERIFY A&SP STAFF DATA (POST INSTALL)",XMTEXT="MSG("
 N DIFROM D ^XMD
 Q
 ;
