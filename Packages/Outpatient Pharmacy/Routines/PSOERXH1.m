PSOERXH1 ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,527,508,581,617,700,746,769,770**;DEC 1997;Build 145
 ;
 Q
 ; place eRx on Hold
HOLD ;
 N MBMSITE,DIE,DA,DR,CURSTAT,CSTATI,LMATCH,LSTAT,SUBFIEN,NEWSTAT,RESP,DIR,RXSTAT,HCOMM,MTYPE,HFFDT
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 Q:'$G(PSOIEN)
 D FULL^VALM1 S VALMBCK="R"
 I $$DONOTFIL^PSOERXUT(PSOIEN) Q
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I")
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 I RXSTAT="RJ"!(RXSTAT="RM")!($G(MBMSITE)&($E(RXSTAT,1,3)="REM"))!(RXSTAT="PR") D  Q
 . W !!,"Cannot hold a prescription with a status of 'Rejected', 'Removed',",!,"or 'Processed",!
 . S DIR(0)="E" D ^DIR
 I RXSTAT="RXP"!(RXSTAT="RXC")!(RXSTAT="RXE") D  Q
 . W !!,"Cannot hold a renewal response record that is in 'Complete', 'Processed', or 'Error' status.",!
 ; check to see if the erx order status is a hold status
 S CSTATI=$$GET1^DIQ(52.49,PSOIEN,1,"I")
 S CURSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 S VALMBCK="R" W !
 I $E(CURSTAT,1)="H" D  Q
 . S DIR(0)="YO",DIR("B")="NO"
 . S DIR("A",1)="This eRx is already in a 'HOLD' status."
 . S DIR("A")="Would you like to change the hold status and comments"
 . D ^DIR
 . Q:'Y
 . K DIR
 . W ! S RESP=$$HDIR(1)
 . I 'RESP D  Q
 . . W !!,"Hold Reason required. eRx not placed in a 'Hold' status."
 . . K DIR,DA S DIR(0)="E" D ^DIR
 . I $D(^PS(52.45,"B","HFF",RESP)) D  I $D(DIRUT)!$D(DIROUT) W !,"eRx NOT placed on hold." K DIR S DIR(0)="E" D ^DIR Q
 . . W !!,$G(IOINHI),"The eRx will be un-held automatically on the date you enter below and placed"
 . . W !,"in '",$$GET1^DIQ(52.45,$$GET1^DIQ(52.49,PSOIEN,1,"I"),.02),"' status.",$G(IOINORM)
 . . K DIR W ! S DIR(0)="DA^"_$$FMADD^XLFDT(DT,1)_":"_$$FMADD^XLFDT($$GET1^DIQ(52.49,PSOIEN,5.9,"I"),$S($$GET1^DIQ(52.49,PSOIEN,95.1,"I"):184,1:366))_":EX"
 . . I $$EFFDATE^PSOERXU5(PSOIEN,1)'="" S DIR("B")=$$FMTE^XLFDT($$EFFDATE^PSOERXU5(PSOIEN,1))
 . . S DIR("A")="Future Fill Hold Date: " D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 . . S HFFDT=Y
 . K DIR,DA S DIR(0)="52.4919,1",DIR("A")="Additional Comments (Optional)" D ^DIR
 . I Y="^" W !,"eRx NOT placed on hold." K DIR S DIR(0)="E" D ^DIR Q
 . S HCOMM=$G(Y)
 . S DIE="52.49",DA=PSOIEN,DR="1///"_RESP D ^DIE K DIE
 . D UPDSTAT^PSOERXU1(PSOIEN,$$GET1^DIQ(52.45,RESP,.01),HCOMM,,,$G(HFFDT))
 . K @VALMAR D REF^PSOERSE1 ;Refresh screen
 . S PSORFRSH=1
 . ; Batch Hold (Not an option for Future Fill Hold (HFF))
 . I '$D(^PS(52.45,"B","HFF",RESP)) D BATCHHLD^PSOERXH2(PSOIEN,RESP,HCOMM,"H")
 . D REF^PSOERSE1
 K Y
 S RESP=$$HDIR(),HFFDT=""
 I 'RESP D  Q
 . W !!,"Hold Reason required. eRx not placed in a 'Hold' status."
 . S DIR(0)="E" D ^DIR
 I $D(^PS(52.45,"B","HFF",RESP)) D  I $D(DIRUT)!$D(DIROUT) W !,"eRx NOT placed on hold." K DIR S DIR(0)="E" D ^DIR Q
 . W !!,$G(IOINHI),"The eRx will be un-held automatically on the date you enter below and placed"
 . W !,"in '",$$GET1^DIQ(52.45,$$GET1^DIQ(52.49,PSOIEN,1,"I"),.02),"' status.",$G(IOINORM)
 . K DIR W ! S DIR(0)="DA^"_$$FMADD^XLFDT(DT,1)_":"_$S($$GET1^DIQ(52.49,PSOIEN,95.1,"I"):$$FMADD^XLFDT(DT,185),1:$$FMADD^XLFDT(DT,364))_":EX"
 . I $$EFFDATE^PSOERXU5(PSOIEN,1)'="" S DIR("B")=$$FMTE^XLFDT($$EFFDATE^PSOERXU5(PSOIEN,1))
 . S DIR("A")="Future Fill Hold Date: " D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 . S HFFDT=Y
 W ! K DIR,DA S DIR(0)="52.4919,1",DIR("A")="Additional Comments (Optional)" D ^DIR K DIR
 I Y="^" Q
 S HCOMM=Y
 W !,"Updating..."
 D UPDSTAT^PSOERXU1(PSOIEN,$$GET1^DIQ(52.45,RESP,.01),HCOMM,,,$G(HFFDT))
 H .5 W "done.",$C(7) H 1
 S PSORFRSH=1
 ; Batch Hold (Not an option for Future Fill Hold (HFF))
 I '$D(^PS(52.45,"B","HFF",RESP)) D BATCHHLD^PSOERXH2(PSOIEN,RESP,HCOMM,"H")
 D REF^PSOERSE1
 Q
NSTAT(IEN,STAT,COMM) ;
 N SUBFIEN
 S FDA(52.4919,"+1,"_IEN_",",.01)=$$NOW^XLFDT()
 S FDA(52.4919,"+1,"_IEN_",",.02)=STAT
 S FDA(52.4919,"+1,"_IEN_",",.03)=$G(DUZ)
 S FDA(52.4919,"+1,"_IEN_",",1)=COMM
 D UPDATE^DIE(,"FDA","NEWSTAT") K FDA
 S SUBFIEN=$O(NEWSTAT(0)) Q:'SUBFIEN
 S SUBFIEN=$G(NEWSTAT(SUBFIEN))
 Q SUBFIEN
HDIR(HTYP) ; 
 N DIC,Y,X
 S DIC("A")="Select HOLD reason code: "
 S DIC="^PS(52.45,",DIC(0)="AEMQ",DIC("S")="I $D(^PS(52.45,""TYPE"",""ERX"",Y)),$E($P(^PS(52.45,Y,0),U),1)=""H"""
 D ^DIC K DIC
 I Y<1 Q 0
 Q:'+$P(Y,U) 0
 Q $P(Y,U)
 ; remove hold from eRx
UNHOLD ;
 N Y,DIR,DIE,DA,DR,NEWSIEN,RXSTAT,HFFHOLD,RXSTATI,MTYPE,QUIT,HOLDIEN
 D FULL^VALM1 S VALMBCK="R"
 I $$DONOTFIL^PSOERXUT(PSOIEN) Q
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I")
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E") S HFFHOLD=0 I RXSTAT="HFF" S HFFHOLD=1
 I RXSTAT="RJ"!(RXSTAT="RM")!($G(MBMSITE)&($E(RXSTAT,1,3)="REM"))!(RXSTAT="PR") D  Q
 . W !!,"Cannot un-hold a prescription with a status of 'Rejected', 'Removed',",!,"or 'Processed",!
 . S DIR(0)="E" D ^DIR
 W !
 I $E($$GET1^DIQ(52.49,PSOIEN,1,"E"),1)'="H" D  Q
 .W !,"This eRx is not currently on hold. Please use the 'Hold'",!,"function to update the hold status and comments.",!!
 .K DIR,DA S DIR(0)="E"
 .D ^DIR
 .K @VALMAR D REF^PSOERSE1
 ; Un-Hold Comments
 S DIR(0)="52.4919,1",DIR("A")="Additional Comments (Optional)" D ^DIR K DIR
 I Y="^" Q
 S UHCOMM=$G(Y)
 S HOLDIEN=$$GET1^DIQ(52.49,PSOIEN,1,"I")
 ;
 I RXSTAT="HC" D
 .W !,"A change request has been generated for this NewRx record.",!,"Are you sure you like to unhold this prescription?"
 .K DIR S DIR(0)="Y",DIR("B")="Y" D ^DIR
 .I Y<1 S QUIT=1
 I $G(QUIT) Q
 S RXSTAT=$$UHSTS(PSOIEN),RXSTATI=$$PRESOLV^PSOERXA1(RXSTAT,"ERX")
 I $G(HFFHOLD) K DIE S DIE="52.49",DA=PSOIEN,DR="6.7///@" D ^DIE K DIE
 D UPDSTAT^PSOERXU1(PSOIEN,RXSTAT,UHCOMM)
 W !,"eRx removed from hold status, and moved to '"_$$SENTENCE^XLFSTR($$GET1^DIQ(52.45,RXSTATI,.02,"E"))_"'."
 K DIR S DIR(0)="E" D ^DIR K DIR
 ;Batch Un-Hold (Not an option for Future Fill Hold (HFF))
 I '$G(HFFHOLD) D BATCHHLD^PSOERXH2(PSOIEN,HOLDIEN,UHCOMM,"U")
 K @VALMAR D REF^PSOERSE1
 Q
 ;
UHSTS(ERXIEN) ; Returns the eRx status after it's un-held
 ; Input: ERXIEN - Pointer to the eRx being worked on (Pointer to #52.49)
 ;Output: UHSTS  - Status after eRx is un-held
 ;
 N UHSTS,MTYPE,STSIEN
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I $$GET1^DIQ(52.49,ERXIEN,1.3,"I"),$$GET1^DIQ(52.49,ERXIEN,1.5,"I"),$$GET1^DIQ(52.49,ERXIEN,1.7,"I") D
 . S STSIEN=$$PRESOLV^PSOERXA1($S(MTYPE="N":"W",MTYPE="RE":"RXW",MTYPE="CX":"CXW",1:""),"ERX") I 'STSIEN Q
 . S UHSTS=$$GET1^DIQ(52.45,STSIEN,.01,"E")
 I '$G(STSIEN) D
 . S STSIEN=$$PRESOLV^PSOERXA1($S(MTYPE="N":"I",MTYPE="RE":"RXI",MTYPE="CX":"CXI",1:""),"ERX") I 'STSIEN Q
 . S UHSTS=$$GET1^DIQ(52.45,STSIEN,.01,"E")
 Q $G(UHSTS,"I")
