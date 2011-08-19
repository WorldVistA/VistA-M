FHORD4 ; HISC/REL/NCA - Isolation/Precaution ;10/11/00  07:52
 ;;5.5;DIETETICS;;Jan 28, 2005
 S ALL=0 D ^FHDPA G:'DFN KIL G:'FHDFN KIL
 D NOW^%DTC S NOW=% K %,%H,%I
 I $P(^FHPT(FHDFN,"A",ADM,0),"^",10)'="" G F1
 K DIC S DIC="^FH(119.4,",DIC(0)="AEQM" W ! D ^DIC G:Y<1 KIL S IS=+Y
 S FHNOW=NOW D FIL,ISO^FHWOR61 S NOW=FHNOW
 S TYP=$P(^FHPT(FHDFN,"A",ADM,0),"^",5) I TYP'="C",TYP'="D" G S2
S1 R !!,"Patient is on CAFETERIA/DINING ROOM Service. Change to TRAY? YES// ",X:DTIME G:'$T!(X["^") KIL
 S:X="" X="Y" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G S1
 G:X?1"N".E S2 D CUR^FHORD7 I "^^^^"[FHOR S $P(^FHPT(FHDFN,"A",ADM,0),"^",5)="T" G S2
 S TYP="T",D2=$P(X,"^",10),(D3,D4)=0,COM="",D1=NOW,DT=NOW\1 D STR^FHORD7
S2 ;
 W "  ... done" G KIL
F1 S X=$P(^FHPT(FHDFN,"A",ADM,0),"^",10)
 W !!,"Isolation/Precaution Type is: ",$P($G(^FH(119.4,X,0)),"^",1)
F2 R !!,"Do you wish to remove? (Y/N) ",X:DTIME G:'$T!(X["^") KIL S:X="" X="*" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G F2
 I X?1"Y".E D CAN S FHORN=$P(^FHPT(FHDFN,"A",ADM,0),"^",13) D:FHORN>0 CODE^FHWOR61 W "  ...removed" G KIL
 W "  ... no change made" G KIL
FIL ; File Isolation
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",10)=IS,X=^FH(119.4,IS,0)
 S ^FHPT("AIS",FHDFN,ADM)=""
 S EVT="I^O^"_IS D ^FHORX Q
CAN ; Cancel Isolation
 S IS=$P(^FHPT(FHDFN,"A",ADM,0),"^",10),$P(^(0),"^",10)="" K ^FHPT("AIS",FHDFN,ADM)
 S EVT="I^C^"_IS D ^FHORX Q
KIL K %DT,ADM,ALL,BY,C,COM,D1,D2,D3,D4,DA,FHDFN,DFN,DHD,DIC,DIE,DR,FHDU,FHLD,FHORD,FHDR,FHOR,FHORN,FHWF,FHPV,FLDS,FR,I,IS,L,NOW,POP,TO,TYP,WARD,X,X1,Y Q
EN1 ; Enter/Edit Isolation/Precaution Types
 K DIC S (DIC,DIE)="^FH(119.4,",DIC(0)="AEQLM",DIC("DR")=".01",DLAYGO=119.4 W ! D ^DIC K DIC,DLAYGO G KIL:"^"[X!$D(DTOUT),EN1:Y<1
 S DA=+Y,DR=".01:99" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=119.4 D ^DIE K DA,DIE,DIDEL,DR G EN1
EN2 ; List Isolation/Precaution Types
 W ! S L=0,DIC="^FH(119.4,",FLDS="[FHISLST]",BY="NAME"
 S (FR,TO)="",DHD="ISOLATION/PRECAUTION TYPES" D EN1^DIP,RSET G KIL
RSET K %ZIS S IOP="" D ^%ZIS K %ZIS,IOP,BY,DA,DHD,DIC,DIE,DR,FLDS,FR,L,TO,X,Y Q
SETVAR ; Set Date in HL7 format
 S FHIDT=$$FMTHL7^XLFDT(NOW) ;HL7 date format
 S FILL="I"_";"_ADM_";"_IS D SITE^FH
 Q
