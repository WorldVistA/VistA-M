EAS114PT ; ALB/SCK - EAS*1.0*14 POST INSTALL CONVERSION ROUTINE ; 6/3/2002
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**14**;MAR 15,2001
 ;
EN ; Entry point for post installation routine
 N ZX,COUNT,CNVRT,DR,DA,NODE0,NODE4,NODEZ,EASPRE
 ;
 S DIR(0)="YAO",DIR("A")="Pre-scan for un-flagged 0-day letters? "
 S DIR("B")="YES"
 S DIR("?",1)="Pre-scan will provide the number of records which will have the 0-day"
 S DIR("?",2)="Flag-to-Print flag set to 'YES' when this routine is run in the conversion mode."
 S DIR("?",3)=""
 S DIR("?")="Enter 'YES' to pre-scan, 'NO' to convert the 0-day print flags"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EASPRE=Y
 ;
 W !!!,"Beginning scan for un-flagged 0-day letters"
 D WAIT^DICD W !
 ;
 S (COUNT,ZX,CNVRT)=0
 F  S ZX=$O(^EAS(713.2,ZX)) Q:'ZX  D
 . S NODE0=$G(^EAS(713.2,ZX,0))
 . S COUNT=COUNT+1 I (COUNT#100)=0 W "."
 . Q:$P(NODE0,U,4)=1
 . S NODE4=$G(^EAS(713.2,ZX,4))
 . S NODEZ=$G(^EAS(713.2,ZX,"Z"))
 . I $P(NODE4,U,3)=1 D
 . . I +$P(NODEZ,U,2)=0 D
 . . . I +$P(NODEZ,U,3)=0 D
 . . . . I 'EASPRE D
 . . . . . S DIE="^EAS(713.2,"
 . . . . . S DR="18///1",DA=ZX
 . . . . . D ^DIE K DIE
 . . . . S CNVRT=CNVRT+1
 ;
 W !?3,$FN(COUNT,",")," records scanned"
 W !?3,$FN(CNVRT,",")," records "_$S(EASPRE:"will have",1:"had")_" the 0-day flag set to print"
 Q
