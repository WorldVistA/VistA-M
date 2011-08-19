PRCNTIPP ;SSI/SEB,ALA-PPM Turn-in review ;[ 05/31/96  10:34 AM ]
 ;;1.0;Equipment/Turn-In Request;**15**;Sep 13, 1996
SELECT ; Select a Turn-in request
 N PRCNFLAG S PRCNFLAG=0  ; PRCN*1.0*15
 D WOC,FAC^PRCNFAP,FDC^PRCNFAP S PRCNFLAG=PRCNFLAG+1
 S DIC(0)="AEQZ",DIC="^PRCN(413.1,"
 I PRCNUSR=2 S DIC("S")="I $P(^(0),U,7)=23"
 I PRCNUSR=1 S DIC("S")="I $P(^(0),U,7)=6!($P(^(0),U,7)=25)"
 D ^DIC K DIC("S") G EXIT:+Y<0
PR S (IN,PRCNTDA,DA)=+Y,TIF=1 D SETUP^PRCNTIPR
 K F,FF,FN,ID,PRCNDD,PRCNDEEP,PV,TIF
 I PRCNUSR=2 D  G SELECT
 . S TDA=PRCNTDA,STAT=44,CKA=1 D CK^PRCNFAP I SFL D SQ Q
 . S DR="[PRCNTIPPM]",DIE=413.1 W ! D ^DIE
 . D:'POP RESET^PRCNUTL  ; PRCN*1.0*15
 . D SQ
 . K POP  ; PRCN*1.0*15
 S TDA=DA,TI=0,STAT=$P(^PRCN(413.1,TDA,0),U,7),WOFL=0
 I STAT=25 D WH,SQ G SELECT
 F  S TI=$O(^PRCN(413.1,TDA,1,TI)) Q:TI'>0  D  Q:$D(DUOUT)
 . S WOFL=0 D ITEM Q:$D(DUOUT)
 . I 'WOFL D WH Q
 . I WOFL S DA=TDA,(DIC,DIE)=413.1,DR="6////^S X=21;7////^S X=DT" D ^DIE,SQ Q
 D SQ
 G SELECT
WH W !,"Is this request ready to go to Warehouse for pickup"
QH S %=1 D YN^DICN
 I %=0 D  G QH
 . W !!,"Enter 'Yes' to send the turn-in request to Warehouse user."
 I %=1 S DA=TDA,DIE=413.1,DR="6////^S X=22;7////^S X=DT" D ^DIE
SQ K DIC,DIE,DR,DA,DUOUT,IN,Y,C,%,WOFL,SFL
 Q
ITEM ; Display and process line items
 S NL=0 D TURNIN^PRCNPRNT
 S WODATA=IN_U_$P($G(^ENG(6914,IN,3)),U,5)
COND ;  Get the condition code
 S DA(1)=TDA,DA=TI,DIC="^PRCN(413.1,"_DA(1)_",1,"
 S DIE=DIC,DR=1 D ^DIE
WO K % I $G(^DIC(6910,1,0))="" S %=2
 W !!,"Should a work order be generated for this line item" D YN^DICN
 I %=-1,%Y="^" S DUOUT="^" Q
 I %=0 D  G WO
 . W !!,"Please enter 'Y'es if Engineering must disconnect or otherwise support the turn-in of this equipment."
 S C=$S(%=1:"Y",1:"N"),$P(^PRCN(413.1,TDA,1,TI,0),U,4)=C
 I C'="Y" Q
 S PRCNSRV=$P(^PRCN(413.1,TDA,0),U,3)
 D TRNIN^ENWONEW2
 I $G(ENDA)="" W !,"Not able to create work order at this time!" G WO
 S DA(1)=TDA,DA=TI,DIC="^PRCN(413.1,"_DA(1)_",1,",DIE=DIC,WOFL=1
 S DR="11////^S X=ENDA" D ^DIE
IQ K NL,WODATA,C,CODES,II,S,PRCNFL,ENDR,ENLO,ENHI,PRCNSRV,ENDA,ENWO
 Q
WOC ;  Work order completion
 S TDA="" F  S TDA=$O(^PRCN(413.1,"AC",21,TDA)) Q:TDA=""  D CS
 K TDA Q
CS ; Check if all work orders have been completed
 S N=0 F  S N=$O(^PRCN(413.1,TDA,1,N)) Q:N'>0  D
 . S WODA=$P(^PRCN(413.1,TDA,1,N,0),U,14) Q:WODA=""
 . I $P($G(^ENG(6920,WODA,5)),U,2)'="" S DA=TDA,DIE=413.1,DR="6////^S X=25;7////^S X=DT" D ^DIE
 K DA,DIE,DR,N,WODA
 Q
PRT ;  Print turnin item
 NEW X,Y,N,F,I
 S TDA=D0,TI=D1,NL=0 D TURNIN^PRCNPRNT
 K F,FF,FN,GLO,I,IN,J,N,N2,NEWL,NL,OGLO,OID,OIN,OPC,PC,PGLO,PRCNDD
 K PRCNDEEP,PGL,PV,TDA,TI,VAL,CODES
 Q
EXIT K PRCNTDA,DIC,DIE,DR,DA,DUOUT,IN,Y,C,%,WOFL,SFL,D0,D1,D,TDA,CODE,CODES
 K CP,DIR,PGL,OIN,PC,PRCNCT,L,OGLO,OID,OPC
 Q
