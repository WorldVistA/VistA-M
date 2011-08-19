PRCNTIWH ;SSI/SEB,ALA-Warehouse review ;[ 05/20/96  10:10 AM ]
 ;;1.0;Equipment/Turn-In Request;**6**;Sep 13, 1996
EN ;  Warehouse entry point
 S DIC("S")="I $P(^(0),U,7)=22",DIC(0)="AEQZ",DIC="^PRCN(413.1,"
 D ^DIC K DIC("S") G EXIT:Y<0 S WDA=+Y
 S C=""
 I $P($G(^PRCN(413.1,WDA,3)),U,4)="" D ASSIG G EXT
 E  D WHSIG
EXT K DIC,DA,Y,WDA,DIE,DR,C,F,NL,TDA,TI,X,ANS,PRCNTI,PRCNFA,XMB,XMDUZ,XMY
 G EN
ASSIG ; Warehouse manager assigns item to a warehouse worker
 S TI=0 F  S TI=$O(^PRCN(413.1,WDA,1,TI)) Q:'+TI!(C="^")  D
 . S NL=0,TDA=WDA D TURNIN^PRCNPRNT W ! F J=1:1:78 W "-"
 S DIC="^VA(200,"
 W ! S DIC("A")="Assign turn-in # "_$P(^PRCN(413.1,WDA,0),U)_" to whom? "
 D ^DIC I Y'<0 S $P(^PRCN(413.1,WDA,3),U,4)=+Y
 ;  Send a message to assigned person
 S XMB="PRCNWHSE",XMB(1)=$P(^PRCN(413.1,WDA,0),U),XMDUZ=DUZ,XMY(+Y)=""
 D ^XMB
 Q
WHSIG ; Display line items & ask for warehouse signature
 S TI=0 F  S TI=$O(^PRCN(413.1,WDA,1,TI)) Q:'+TI!(C="^")  D
 . S NL=0,TDA=WDA D TURNIN^PRCNPRNT W ! F J=1:1:78 W "-"
 . S DA(1)=WDA,DA=TI
 . R !!,"Is this the correct item turned in? ",ANS:DTIME I '$T S C="^" Q
 . S ANS=$$UP^XLFSTR(ANS)
 . I ANS'="Y" S C="^" Q
 . S DIC="^PRCN(413.1,"_DA(1)_",1,",DIE=DIC,DR=1 D ^DIE
 . R !,"Hit RETURN to continue. ",C:DTIME
 . S PRCNTI=$P(^PRCN(413.1,WDA,1,TI,0),U),PRCNFA=$$CHKFA^ENFAUTL(PRCNTI)
 Q:$G(C)="^"
 D ES^PRCNUTL I $G(FAIL)<1 K FAIL Q
 I +PRCNFA S DR="6////^S X=43;7////^S X=DT"
 I '+PRCNFA S DR="6////^S X=23;7////^S X=DT"
 S DIE=413.1,DA=WDA D ^DIE
 Q
EXIT K DIC,FF,FN,GLO,I,ID,IN,J,N,N2,NEWL,PC,PGL,PRCNDD,PRCNDEEP,PV,VAL
 Q
