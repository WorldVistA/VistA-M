ENTIDD ;WOIFO/SAB - Engineering DD ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ;
ITTCHK(ENCMR,ENX) ; IT Tracking Check
 ; called by input transform on CMR file IT TRACKING field
 ; input
 ;   ENCMR - CMR ien
 ;   ENX - user input (1 for yes or 0 or no)
 ; returns 1 (true) if change should be prevented
 ;
 N ENRET
 S ENRET=0
 I ENX'=1,$$AITACMR(ENCMR) D
 . S ENRET=1
 . D EN^DDIOL("CMR has equipment with an active IT assignment. Can't change IT TRACKING.")
 Q ENRET
 ;
AITACMR(ENCMR) ; Active IT Assignment CMR
 ; input ENCMR = CMR internal entry number
 ; returns 1 (if any equipment on CMR has an active assignment) or 0
 N ENEQ,ENRET
 S ENRET=0
 ;
 ; loop thru equipment on CMR
 S ENEQ=0 F  S ENEQ=$O(^ENG(6914,"AD",ENCMR,ENEQ)) Q:'ENEQ  D  Q:ENRET
 . I $D(^ENG(6916.3,"AEA",ENEQ)) S ENRET=1
 ;
 Q ENRET
 ;
CMRCHK(ENDA,ENX) ; CMR Check
 ; called by EQUIPMENT INV. file CMR field Input Transform
 ; input
 ;   ENDA - equipment ien
 ;   ENX - user input, CMR ien
 ; returns 1 (true) if change should be prevented
 N DA,X ; protect variables used by input transform
 N ENA,ENRET,ENY
 S ENRET=0
 ;
 D
 . ; perform checks
 . Q:'$D(^ENG(6916.3,"AEA",ENDA))  ; no active assignments for equip
 . S ENY=$G(^ENG(6914.1,ENX,0)) ; CMR zero node
 . Q:$P(ENY,"^",9)  ; IT Tracking of new CMR is Yes
 . Q:$E($P(ENY,"^"),1,2)="99"  ; CMR name starts 99, may be for excess
 . ;
 . ; must be an inappropriate change
 . S ENRET=1
 . S ENA(1)="Equipment has an active IT assignment."
 . S ENA(2)="New CMR must be excess (99x) or have IT TRACKING = YES."
 . D EN^DDIOL(.ENA)
 ;
 Q ENRET
 ;
CMRUPD(ENEQ,ENCMR1,ENCMR2) ; terminate IT responsibilities when CMR changed
 ; called by cross-reference on Equipment Inv. file CMR field
 ; input
 ;   ENEQ   - equipment ien
 ;   ENCMR1 - old CMR ien
 ;   ENCMR2 - new CMR ien (or null if value deleted)
 Q:$D(ENDJCMR1)  ; edited by DJ screen, change may be backed out so wait
 Q:'$D(^ENG(6916.3,"AEA",ENEQ))  ; no active assignments for equip
 I ENCMR2,$D(^ENG(6914.1,"AIT",1,ENCMR2)) Q  ; new CMR IT TRACKING = yes
 ;
 ; equipment with active assignments is no longer on a tracked CMR
 N ENCMR1N,ENCMR2N,ENDA,ENL,ENTX,ENX
 N DIFROM,XMDUZ,XMMG,XMROU,XMSTRIP,XMSUB,XMTEXT,XMY,XMYBLOB,XMZ
 ; loop thru assignments
 S ENL=5
 S ENDA=0 F  S ENDA=$O(^ENG(6916.3,"AEA",ENEQ,ENDA)) Q:'ENDA  D
 . ; terminate assignment
 . S ENX=$$TERM^ENTIUTL1(ENDA)
 . ; place on message text
 . S ENL=ENL+1
 . S ENTX(ENL)="Owner: "_$$GET1^DIQ(6916.3,ENDA,1)
 ;
 ; send message
 S ENCMR1N=$S(ENCMR1:$P($G(^ENG(6914.1,ENCMR1,0)),U),1:ENCMR1)
 S ENCMR2N=$S(ENCMR2:$P($G(^ENG(6914.1,ENCMR2,0)),U),1:"<deleted>")
 S ENTX(1)="The CMR value for Equipment Entry # "_ENEQ_" was changed"
 S ENTX(2)="from "_ENCMR1N_" to "_ENCMR2N_" by "_$$GET1^DIQ(200,DUZ,.01)
 S ENTX(3)="The following IT assignments were automatically terminated"
 S ENTX(4)="since the new CMR value does not have IT TRACKING = Yes."
 S ENTX(5)=" "
 ;
 S XMDUZ="AEMS/MERS"
 S XMSUB="IT Assignments Terminated for Entry # "_ENEQ
 S XMY("G.EN IT EQUIPMENT")=""
 S XMTEXT="ENTX("
 D ^XMD
 Q
 ;
CMRDJPR ; CMR Label Pre-Action for ENEQ1 DJ Edit Screen 
 I $D(^ENG(6915.2,"B",DA)) S X=$$CHKFA^ENFAUTL(DA) I $P(X,U)=1 D
 . W "Capitalized asset. CMR may only be edited via FAP documents."
 . W !,"Press <RETURN> to continue..."
 . R X:DTIME
 . S DJNX=9
 ;
 ; if CMR field will be edited save current CMR value
 ; note: the existence of this variable will prevent the ACMR x-ref from
 ; deleting any active IT assignments
 I $G(DJNX)'=9 S ENDJCMR1=$P($G(^ENG(6914,DA,2)),U,9)
 Q
 ;
CMRDJPS ; CMR Label Post-Action for ENEQ1 DJ Edit Screen
 ; note that new data has already been filed by this point
 ; input ENDJCMR1 - CMR (internal) value prior to the edit
 ;                  note: this variable will be killed
 ;       DA - equipment ien being edited
 ; output
 ;   may reset value of CMR field, if value was reset the following
 ;   two DJ screen handler variables will also be modified 
 ;     V(8) - update to reflect the reset CMR value (external)
 ;     DJNX - update to re-edit the CMR field
 ;
 Q:'$D(ENDJCMR1)
 N ENFDA,ENOLD,ENNEW,ENX,X
 S ENOLD=ENDJCMR1 ; old CMR value
 S ENNEW=$P($G(^ENG(6914,DA,2)),U,9) ; new CMR value
 I ENNEW'=ENOLD D
 . ; CMR was changed
 . S ENX=$$CMRCHK^ENTIDD(DA,ENNEW) ; may display message
 . I ENX D
 . . ; change was not appropriate - pause after message
 . . W !,"Press <RETURN> to continue..."
 . . R X:DTIME
 . . ; change back to original value
 . . S ENFDA(6914,DA_",",19)=ENOLD
 . . D FILE^DIE("","ENFDA")
 . . ; fix screen
 . . S V(8)=$$GET1^DIQ(6914,DA,19)
 . . S DJNX=8
 . I 'ENX D
 . . ; change was appropriate
 . . ; terminate any active IT assignments
 . . K ENDJCMR1 ; to prevent following call from quitting
 . . D CMRUPD^ENTIDD(DA,ENOLD,ENNEW)
 ;
 ; clean up symbol table for variable set by the pre-action
 K ENDJCMR1
 Q
 ;
 ;ENTIDD
