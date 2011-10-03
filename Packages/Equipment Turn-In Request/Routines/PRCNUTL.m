PRCNUTL ;SSI/ALA-UTILITY PROGRAM ;[ 09/11/96  2:08 PM ]
 ;;1.0;Equipment/Turn-In Request;**15**;Sep 13, 1996
SEQ ;  Get the next sequential number, returns PRCNDA and TST
 ;   TST is the beginning part of the transaction number
 S NDA=$O(^PRCN(413.7,"B",TST,"")) I NDA="" D
 . NEW DIC,DIE,DA,DR,DLAYGO
 . S X=TST,DIC="^PRCN(413.7,",DIC(0)="L",DLAYGO=413.7 D FILE^DICN
 . S NDA=+Y,$P(^PRCN(413.7,NDA,0),U,2)=0
 S PRCNDA=$P(^PRCN(413.7,NDA,0),U,2)+1,$P(^PRCN(413.7,NDA,0),U,2)=PRCNDA
EXIT K NDA,X,Y Q
EMSG ;  Loop for message for requests
 S (X,CT)=0 F  S X=$O(^PRCN(413,"AC",STA,X)) Q:X=""  D
 . I STA=1,$P(^PRCN(413,X,0),U,2)'=DUZ Q
 . I STA=3,$P(^PRCN(413,X,0),U,6)'=DUZ Q
 . I STA=9,$G(^PRCN(413,X,5,"B",DUZ))="" Q
 . I STA=45,$P(^PRCN(413,X,0),U,6)'=DUZ Q
 . S CT=CT+1
 I CT>0 W $C(7),!!! D
 . S TEX3=$P(^PRCN(413.5,STA,0),U),TEX1=$S(CT=1:"is",1:"are")
 . S TEX2=$S(CT=1:"request",1:"requests")
 . W !,?3,"There "_TEX1_" "_CT_" equipment "_TEX2_" "_TEX3_"."
 K X,CT,TEX1,TEX2,TEX3
 Q
TMSG ;  Loop for turn-in messages
 S (X,CT)=0 F  S X=$O(^PRCN(413.1,"AC",STA,X)) Q:X=""  D
 . I STA=1,$P(^PRCN(413.1,X,0),U,2)'=DUZ Q
 . I STA=3,$P(^PRCN(413.1,X,0),U,6)'=DUZ Q
 . S CT=CT+1
 I CT>0 W $C(7),!!! D
 . S TEX1=$S(CT=1:"is",1:"are"),TEX2=$S(CT=1:"request",1:"requests")
 . S TEX3=$P(^PRCN(413.5,STA,0),U)
 . W ?3,"There "_TEX1_" "_CT_" Turn-In "_TEX2_" "_TEX3
 K X,CT Q
 ; Electronic Signature Code check. FAIL is defined if check fails.
ES S FAIL="" D ESIG^PRCUESIG(DUZ,.FAIL)
ES1 I FAIL<1 W $C(7),"  SIGNATURE CODE FAILURE " R X:3 G EQ
EQ K X,I Q
FYQ ;RETURNS FY AND QTR GIVEN IN FILEMANAGER DATE IN 'X'
 G:'$D(X) QQ G:X=""!($E(X,1,7)'?7N)!(+$E(X,1,7)'=$E(X,1,7)) QQ
 S Y=$E(X,2,3),Y(1)=$E(X,4,5),PRC("FY")=$S(Y(1)<10:Y,1:Y+1)
 S PRC("QTR")=$S(Y(1)<4:2,Y(1)<7:3,Y(1)<10:4,1:1) K Y S %=1 Q
QQ K PRC,PRCF("X"),PRCB,%DT,DIC,%F,A,B,X,Y S %=0 Q
EN1 ;  Check for utilities=13 to ask for free text OTHER
 S FL=0 S:$D(^PRCN(413,DA,3,"B",13)) FL=1
 Q
VEN ; Translate potential vendor field into pointer and store it
 S VEN=X
 N DIEL,DM,DC,DH,DI,DK,DP,DL,DIFLD,DQ,DR,DIC,DIE,DA,X,Y
 S X=VEN,DIC(0)="EZ",DIC="^PRC(440," D ^DIC S PRCNVEN=+Y
 I PRCNVEN<0 S $P(^PRCN(413,D0,1,D1,0),U,13)=VEN,$P(^(0),U,2)="" G EX
 I PRCNVEN'<0 S $P(^PRCN(413,D0,1,D1,0),U,2)=PRCNVEN,$P(^(0),U,13)=""
EX K VEN,PRCNVEN
 Q
VENHLP ; Executable help for potential vendor field
 S DUOUT=0,PRCNCT=0,HL0=0
 F  S HL0=$O(^DD(413.015,2,21,HL0)) Q:HL0'>0  W !,^DD(413.015,2,21,HL0,0)
 W !!,"Current Vendors: "
 S L="" F  S L=$O(^PRC(440,"B",L)) Q:L=""  D T I $G(DUOUT)=1 S DUOUT=0 Q
 K L,PRCNDI,PRCND,PRCNA,X
 Q
T S PRCNCT=PRCNCT+1
 I PRCNCT<10 W !,L Q
 R !,"'^' TO STOP: ",PRCNA:DTIME S:'$T PRCNA=U
 I $G(PRCNA)[U S DUOUT=1 Q
 S PRCNCT=0 Q
 ;
CHECK ; PRCN*1.0*15 new subroutine to check if all line items for a
 ; transaction have been dispositioned - CMR equals null if dispo'd
 N N1,PRCNT0
 S POP=1
 S N1=999 F  S N1=$O(^PRCN(413.1,PRCNTDA,1,N1),-1) Q:'N1  D
 . S PRCNT0=$P($G(^PRCN(413.1,PRCNTDA,1,N1,0)),U)
 . I +$P($G(^ENG(6914,PRCNT0,2)),U,9) S POP=0 Q
 D:'POP DMSG
 Q
 ;
DMSG ; PRCN*1.0*15 new subroutine to display message to user
 W !! F X=1:1:79 W "*"
 W !,"* SORRY.  THERE ARE ADDITIONAL LINE ITEMS FOR TRANSACTION:",?78,"*"
 W !,"*",?78,"*"
 W !,"*",?80-$L($G(Y(0,0)))/2,$G(Y(0,0)),?78,"*"
 W !,"*",?78,"*"
 W !,"* THAT MUST BE DISPOSITIONED BEFORE THIS TRANSACTION CAN BE FINALIZED.",?78,"*"
 W ! F X=1:1:79 W "*"
 W !!
 Q
 ;
RESET ; PRCN*1.0*15 reset status, plus original CMR and SGL values
 ; and set disposition date, method and value each to null
 N DATA,OLDCMR,OLDSGL,OLDUST,NULL,N
 S DIE="^PRCN(413.1,",DR="6////"_23 D ^DIE
 N DA
 S N=0 F  S N=$O(OLDVALUE(N)) Q:'N  D
 . S DATA=OLDVALUE(N),NULL=""
 . S DA=$P(DATA,U,1),OLDCMR=$P(DATA,U,2),OLDUST=$P(DATA,U,3),OLDSGL=$P(DATA,U,4)
 . S DIE="^ENG(6914,"
 . S DR="19////^S X=OLDCMR;20////^S X=OLDUST;38////^S X=OLDSGL;22///@;31///@;32///@" D ^DIE
 . K DA,DIE,DR
 Q
