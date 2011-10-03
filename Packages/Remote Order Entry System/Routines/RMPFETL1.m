RMPFETL1 ;DDC/KAW-CONTINUATION OF RMPFETL [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 ;; input: RMPFX,DFN
 ;;output: RMPFTE
 G END:$P(RMPFSYS,U,13)
 S SX=$G(^RMPF(791810,RMPFX,2)),SD=$P(SX,U,8) G START:'SD
 I $D(^RMPF(791810,"AF",SD,RMPFX)) W $C(7),!!,"*** Eligibility Determination Awaiting Processing in PSAS ***" G END
START D ASK G END:$D(RMPFOUT),END:"Yy"'[Y
 D GETEL G END:$D(RMPFOUT)
END S RMPFTE="" K RMPFOUT,RMPFQUT,SD,SX Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
ASK ;;Request eligibility determination
 ;; input: None
 ;;output: Y
 W !!,"Request an Eligibility Determination from PSAS? YES// "
 D READ Q:$D(RMPFOUT)
ASK1 I $D(RMPFQUT) W !!,"Enter a <Y> to submit a request for eligibility determination from PSAS",!?5,"an <N> or <RETURN> to exit." G ASK
 S:Y="" Y="Y" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G ASK1
 Q
GETEL ;;Set up proposed eligibility fields
 ;; input: RMPFX
 ;;output: RMPFTE
 Q:'$D(DFN)  Q:'DFN  D PAT^RMPFUTL
 S DIC=791810.4,DIC(0)="AEQM",DIC("A")="Select Proposed Eligibility: " W ! D ^DIC G GETELE:Y=-1 S RMPFTE=+Y,RMPFELG=$P(Y,U,2)
 S X="NOW",%DT="T" D ^%DT S TD=Y
 S DIE="^RMPF(791810,",DA=RMPFX,DR="2.06////"_RMPFTE_";2.07////"_DUZ_";2.08////"_TD D ^DIE
MAIL ;;Send message to PSAS mail group
 ;; input: RMPFELG,RMPFNAM
 ;;output:
 S MG=$O(^XMB(3.8,"B","RMPF ROES UPDATES (PSAS)",0))
 I 'MG W $C(7),!!,"*** MAIL GROUP RMPF ROES UPDATES (PSAS) NOT ESTABLISHED - NO MESSAGE SENT ***" G GETELE
 S XMY("G."_$P($G(^XMB(3.8,MG,0)),U,1))=""
 S XMSUB="ROES PATIENT ELIGIBILITY DETERMINATION REQUEST"
 S XMTEXT(1)="The Remote Order/Entry System requires that a patient be eligible"
 S XMTEXT(2)="to receive a hearing aid, batteries or hearing aid services."
 S XMTEXT(3)="An eligibility determination has been requested by ASPS for:"
 S XMTEXT(4)=" "
 S XMTEXT(5)=RMPFNAM_"          SSN: "_RMPFSSN
 S XMTEXT(6)=" "
 S XMTEXT(7)="Proposed Eligibility: "_RMPFELG
 S XMTEXT="XMTEXT("
 D ^XMD W !!,"*** Message sent to PSAS Mail Group ***" H 2
GETELE K DIC,DIE,DA,DR,D0,DI,DISYS,DQ,TD,%DT,X,Y,RMPFNAM,RMPFSSN,RMPFDOB
 K RMPFDOD,RMPFELG,XMZ,XMDUZ,XCNP,MG,D Q
