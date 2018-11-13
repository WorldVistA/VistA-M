PSOERXU4 ;ALB/BLB - eRx utilities ; 2/21/2018 4:00pm
 ;;7.0;OUTPATIENT PHARMACY;**520**;DEC 1997;Build 52
 ;
 Q
DERX1(PSOIEN,PSOIENS,DFLG) ;
 N EDRG,ERXDAT,ESIG,COMM,SUBS,DFORM,DSTR,QQUAL,POTUC,QTY,DAYS,REFILL,COMMARY,SIGARY,ERXRFLS,I
 D GETS^DIQ(52.49,PSOIENS,"3.1;4.6;4.8;5.1;5.2;5.4;5.5;5.6;5.7;5.8;7;8;41;42;43","E","ERXDAT")
 S DFLG=$G(DFLG,"")
 S EDRG=$G(ERXDAT(52.49,PSOIENS,3.1,"E"))
 S ESIG=$G(ERXDAT(52.49,PSOIENS,7,"E"))
 S COMM=$G(ERXDAT(52.49,PSOIENS,8,"E"))
 S SUBS=$G(ERXDAT(52.49,PSOIENS,5.8,"E"))
 S DFORM=$G(ERXDAT(52.49,PSOIENS,41,"E"))
 S DSTR=$G(ERXDAT(52.49,PSOIENS,43,"E"))
 S QQUAL=$G(ERXDAT(52.49,PSOIENS,5.2,"E"))
 S POTUC=$G(ERXDAT(52.49,PSOIENS,42,"E"))
 S QTY=$G(ERXDAT(52.49,PSOIENS,5.1,"E"))
 S DAYS=$G(ERXDAT(52.49,PSOIENS,5.5,"E"))
 S REFILL=$G(ERXDAT(52.49,PSOIENS,5.6,"E"))
 I REFILL="" D
 .S REFILL=$G(ERXDAT(52.49,PSOIENS,5.7,"I"))
 D TXT2ARY^PSOERXD1(.SIGARY,ESIG,,69)
 D TXT2ARY^PSOERXD1(.COMMARY,COMM,,65)
 W !!!,"eRx Drug: "_EDRG
 W !,"eRx Sig: "
 S I=0 F  S I=$O(SIGARY(I)) Q:'I  D
 .W $S(I>1:"         "_SIGARY(I),1:SIGARY(I)),!
 I '$L(ESIG) W !
 W "eRx Notes: "
 S I=0 F  S I=$O(COMMARY(I)) Q:'I  D
 .W $S(I>1:"              "_COMMARY(I),1:COMMARY(I)),!
 I '$L(COMM) W !
 Q:DFLG=1
 W "Drug Form: "_DFORM,?40,"Strength: "_DSTR
 W !,"Qty Qualifier: "_QQUAL,?40,"Potency Unit Code: "_POTUC
 W !,"DAW Code: "_SUBS
 W !,"Qty: "_QTY,?25,"Days Supply: "_DAYS,?55,"Refills: "_REFILL,!!
 Q
REM ;
 N DIR,Y,PSSRET,PSOIENS,REMIEN,REMSTA,REMTXT,ERXRMIEN,DIC,X,RXSTAT
 D FULL^VALM1
 S PSOIENS=PSOIEN_","
 S VALMBCK="R"
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E") I RXSTAT="RJ"!(RXSTAT="RM")!(RXSTAT="PR") D  Q
 .W !!,"Cannot remove a prescription with a status of 'Rejected', 'Removed',",!,"or 'Processed",!
 .S DIR(0)="E" D ^DIR
 S DIR(0)="YO",DIR("A")="Would you like to 'Remove' eRx #"_$$GET1^DIQ(52.49,PSOIEN,.01,"E"),DIR("B")="Y" D ^DIR K DIR
 Q:'Y
 S DIC="^PS(52.45,",DIC(0)="AEMQ",DIC("S")="I $D(^PS(52.45,""TYPE"",""REM"",Y))",DIC("A")="Select REMOVAL reason code: "
 D ^DIC K DIC
 I $P(Y,U)<1 W !,"Removal reason code required!" S DIR(0)="E" D ^DIR K DIR Q
 S REMIEN=$P(Y,U),REMSTA=$P(Y,U,2)
 K X,Y S DIR(0)="FO^1:70",DIR("A")="Additional Comments (Optional)" D ^DIR K DIR
 Q:Y="^"
 S REMTXT=Y
 S FDA(52.4919,"+1,"_PSOIENS,.01)=$$NOW^XLFDT,FDA(52.4919,"+1,"_PSOIENS,.02)=REMIEN
 S FDA(52.4919,"+1,"_PSOIENS,.03)=DUZ,FDA(52.4919,"+1,"_PSOIENS,1)=REMTXT
 D UPDATE^DIE(,"FDA") K FDA
 ; SET THE ERX STATUS TO THE REMOVAL REASON
 S ERXRMIEN=$O(^PS(52.45,"C","ERX","RM",0))
 S DIE="^PS(52.49,",DR="1///"_ERXRMIEN,DA=PSOIEN D ^DIE
 K DIE,DA,DR
 Q
 ; reject eRx
REJ ;
 N DIR,DIC,Y,PSSRET,PSOIENS,REMTXT,REJSTA,FULLTXT,ERXRJIEN,REJDESC,REJIEN,REJTXT,X,RXSTAT
 D FULL^VALM1
 S PSOIENS=PSOIEN_","
 S VALMBCK="R"
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E") I RXSTAT="RJ"!(RXSTAT="RM")!(RXSTAT="PR") D  Q
 .W !!,"Cannot reject a prescription with a status of 'Rejected', 'Removed',",!,"or 'Processed",!
 .S DIR(0)="E" D ^DIR
 S DIR(0)="YO",DIR("A")="Would you like to 'Reject' eRx #"_$$GET1^DIQ(52.49,PSOIEN,.01,"E"),DIR("B")="Y" D ^DIR K DIR
 Q:'Y
 S DIC="^PS(52.45,",DIC(0)="AEMQ",DIC("S")="I $D(^PS(52.45,""TYPE"",""REJ"",Y))",DIC("A")="Select REJECT reason code: "
 D ^DIC K DIC
 I $P(Y,U)<1 W !,"Reject reason required! eRx NOT rejected." S DIR(0)="E" D ^DIR K DIR Q
 S REJIEN=$P(Y,U),REJSTA=$P(Y,U,2)
 K X,Y,DIR
 S DIR(0)="FO^1:70",DIR("A")="Additional Comments (Optional)" D ^DIR K DIR
 Q:Y="^"
 ;I '$L(Y)!(Y="^") W !,"Reject reason text required. eRx NOT rejected." S DIR(0)="E" D ^DIR K DIR Q
 ; if reject reason was entered, log the activity.
 S REJTXT=Y
 S REJDESC=$$GET1^DIQ(52.45,REJIEN,.02,"E")
 S FULLTXT=REJSTA_"-"_REJDESC
 D POST^PSOERXO1(PSOIEN,.PSSRET,900,"",$E(FULLTXT,1,70))
 ; if the post was unsuccessful, inform the user and quit.
 I $P(PSSRET(0),U)<1 W !,$P(PSSRET(0),U,2) S DIR(0)="E" D ^DIR K DIR Q
 I $D(PSSRET("errorMessage")) W !,PSSRET("errorMessage") S DIR(0)="E" D ^DIR K DIR Q
 W !!,"Rejection message sent." S DIR(0)="E" D ^DIR K DIR
 ; if post is successful, change the eRx status and log the status activity.
 S FDA(52.4919,"+1,"_PSOIENS,.01)=$$NOW^XLFDT
 S FDA(52.4919,"+1,"_PSOIENS,.02)=REJIEN
 S FDA(52.4919,"+1,"_PSOIENS,.03)=DUZ
 S FDA(52.4919,"+1,"_PSOIENS,1)=REJTXT
 D UPDATE^DIE(,"FDA") K FDA
 ; SET THE ERX STATUS TO THE REJECT REASON
 S ERXRJIEN=$O(^PS(52.45,"C","ERX","RJ",0))
 S DIE="^PS(52.49,",DR="1///"_ERXRJIEN,DA=PSOIEN D ^DIE
 K DIE,DR,DA
 Q
 ;/BLB/ - BEGIN CHANGE - EDIT IN VD
QTYDSRFL(ERXIEN,EDTYP) ;
 ; ERXIEN - ien from 52.49
 ; EDTYP:
 ;        1 - DAYS SUPPLY
 ;        2 - QUANTITY
 ;        3 - REFILLS
 N PSODRUG,PSODIR,ERXDRUG,PSODFN,ERXIENS,FDA,CLOZPAT,PSOY,PATSTAT,Y,DONE,DIR,ANS,PSODRG
 S ERXIENS=ERXIEN_","
 ; setup drug array
 S ERXDRUG=$$GET1^DIQ(52.49,ERXIEN,3.2,"I") Q:'ERXDRUG 0
 S PSOY=ERXDRUG,PSOY(0)=$G(^PSDRUG(ERXDRUG,0))
 D SET^PSODRG
 S PSODRG=ERXDRUG
 ; set quanity, days supply, refill, and patient information
 S PSODFN=$$GET1^DIQ(52.49,ERXIEN,.05,"I")
 S PSODIR("QTY")=$$GET1^DIQ(52.49,ERXIEN,20.1,"E")
 S PSODIR("DAYS SUPPLY")=$$GET1^DIQ(52.49,ERXIEN,20.2,"E")
 S PSODIR("# OF REFILLS")=$$GET1^DIQ(52.49,ERXIEN,20.5,"E")
 S PSODIR("PATIENT STATUS")=$P(^PS(55,PSODFN,"PS"),U)
 S PSODIR("DFLG")=0
 S PATSTAT=$$GET1^DIQ(55,PSODFN,3,"E")
 I '$L(PATSTAT) D
 .S DONE=0
 .F  D  Q:DONE
 ..W !,"This is a required response. Enter '^' to exit"
 ..S DIR(0)="55,3",DIR("A")="PATIENT STATUS" D ^DIR K DIR
 ..I +Y S DONE=1 Q
 ..I Y["^" S PQUIT=1,DONE=1 Q
 .S ANS=$P(Y,"^",1)
 .S FDA(55,PSODFN_",",3)=ANS
 .D FILE^DIE(,"FDA","ERR") K FDA,ERR
 S PSODIR("PTST NODE")=$G(^PS(55,PSODFN,"PS"))
 I $P($G(^PSDRUG(PSODRG,"CLOZ1")),"^")="PSOCLO1" D
 .S CLOZPAT=$O(^YSCL(603.01,"C",PSODFN,0)) Q:'CLOZPAT
 .S CLOZPAT=$P(^YSCL(603.01,CLOZPAT,0),"^",3)
 .S CLOZPAT=$S(CLOZPAT="M":2,CLOZPAT="B":1,1:0)
 ; once called, PSODIR will be updated with the appropriate information 
 ;(refills/days supply/quantity)
 I EDTYP=1 S PSONEW("FLD")=7 D DAYS^PSODIR1(.PSODIR)
 I EDTYP=2 S PSONEW("FLD")=5 D QTY^PSODIR1(.PSODIR)
 I EDTYP=3 S PSONEW("FLD")=8 D REFILL^PSODIR1(.PSODIR)
 I $G(PSODIR("DFLG"))=1 Q 1
 S FDA(52.49,ERXIENS,20.1)=$G(PSODIR("QTY"))
 S FDA(52.49,ERXIENS,20.2)=$G(PSODIR("DAYS SUPPLY"))
 S FDA(52.49,ERXIENS,20.5)=$G(PSODIR("# OF REFILLS"))
 D FILE^DIE(,"FDA") K FDA
 Q 0
 ;/BLB/ - END CHANGE
