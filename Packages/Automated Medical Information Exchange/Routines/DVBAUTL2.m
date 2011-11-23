DVBAUTL2 ;ALB/GTS-557/THM-AMIE UTILITIES ;24 AUG 89
 ;;2.7;AMIE;;Apr 10, 1995
 ;
REOPEN ;used by DVBAREG1 and DVBAREN1 only to re-log 7131s
 W *7,!!,"Are you sure you want to DELETE the existing 7131 for this date",!,"and log a NEW one" S %=2 D YN^DICN ;must be finalized to reopen
 I $D(%Y),%Y["?" W !!,"Enter Y to delete the finalized 7131 request that",!,"exists for this date and log a new one.",!!,"Enter N to leave the existing 7131 as is.",! G REOPEN
 I %'=1 S ONFILE=1 K OLDDA,%,%Y Q
 I '$D(DVBREQDT) W *7,!!,"Activity or admission date is missing !  Cannot reopen.",!! H 3 S ONFILE=1 Q
 K DIC("S"),DVBAEDT
 S OLDY=Y,OLDDA=DA,DIK="^DVB(396," D WAIT^DICD,^DIK S (DA,DINUM)=OLDDA,X=+DFN K DD,DO S DLAYGO=396,DIC(0)="EQLM",DIC="^DVB(396," D FILE^DICN ;use same IFN
 S DR="1////"_CNUM_";2////"_SSN_";3////"_DVBREQDT_";23////"_DT_";24////"_DT_";27////"_LOC_";28////"_OPER_";30////"_DVBDOC,DIE=DIC D ^DIE K DLAYGO
 W !!,*7,"You may now enter a new 7131 for this date.",!! H 2
 S Y=OLDY
 K OLDDA,%,%Y
 Q
 ;
NOPARM ;check for AMIE parameter setup
 I '$D(^DVB(396.1,1,0)) W !!,*7,"No site parameters have been setup in file 396.1.",!,"You must do this before running any reports.",!! S DVBAQUIT=1 H 3
 Q
 ;
ADTYPE W !!,"Do you want (A)&A, (P)ension, (S)ervice-connected, or AL(L) discharges ?  S// " R ADTYPE:DTIME I '$T!(ADTYPE=U) S DVBAQUIT=1 Q
 S X=ADTYPE X ^%ZOSF("UPPERCASE") S ADTYPE=Y
 S:ADTYPE="" ADTYPE="S" I ADTYPE'?1"A"&(ADTYPE'?1"S")&(ADTYPE'?1"L")&(ADTYPE'?1"P") W *7,!!,"Must be A for A&A, P for Pension, S for Service-connected, or L for All" G ADTYPE
 S HEAD=$S(ADTYPE="P":"PENSION",ADTYPE="A":"A&A",ADTYPE="S":"SERVICE-CONNECTED",ADTYPE="L":"COMPLETE",1:"UNKNOWN")_" DISCHARGE REPORT"
 Q
 ;
DELETE K OUT W !!,*7,"Are you sure you want to delete this request" S %=2 D YN^DICN I $D(DTOUT)!(%<0) Q  ;continue on timeout to set record
 I $D(%),%=1 S DIK="^DVB(396," D ^DIK S OUT=1 W "    ... deleted!",*7,!! H 2
 Q
 ;
CHKDIV ;** Check for selected Division on 7131
 K DVXST
 N ADIV
 S ADIV=$S($D(^DVB(396,D0,2)):$P(^(2),U,9),1:"""")
 S:XDIV=ADIV DVXST=""
 I '$D(DVXST) DO
 .N ADT
 .S ADT=""
 .F ADT=0:0 S ADT=$O(^DVB(396,"AF",D0,ADT)) Q:ADT=""!($D(DVXST))  DO
 ..S:($D(^DVB(396,"AF",D0,ADT,XDIV))) DVXST=""
 Q
 ;
WRDIV ;** Write Division for 7131 - Loop DA in 'AF' X-ref
 S TMP($J,"DVBA",$P(^(2),"^",9))=""
 F DVBADT=0:0 S DVBADT=$O(^DVB(396,"AF",DA,DVBADT)) Q:DVBADT=""  D LPDIV
 W !
 KILL TMP($J,"DVBA"),DVBADT,DVBADIV,DVBANAM
 Q
 ;
LPDIV ;** Loop Division in 'AF' X-ref
 S DVBADIV=0
 F  S DVBADIV=$O(^DVB(396,"AF",DA,DVBADT,DVBADIV)) Q:DVBADIV=""  DO
 .I '$D(TMP($J,"DVBA",DVBADIV)) DO
 ..S DVBANAM=$P(^DG(40.8,DVBADIV,0),"^",1)
 ..S TMP($J,"DVBA",DVBADIV)=""
 ..W !,?68,$E(DVBANAM,1,9)
 Q
 ;
DIVUPDT ;** Update 7131 Rpt Divisions & Tran Dates on new 7131
 K DR,DIE,DA
 S REQDTE=$P(^DVB(396,DVBAENTR,1),U,1),REQDIV=$P(^DVB(396,DVBAENTR,2),U,9)
 S:'$D(^DVB(396,DVBAENTR,6)) DVBANEW=""
 S:'$D(DVBANEW) NODE6=^DVB(396,DVBAENTR,6)
 F LPPCE=1:1:10 DO
 .S:LPPCE=1 FLDDIV=4.6,FLDDTE=4.7
 .S:LPPCE=2 FLDDIV=5.6,FLDDTE=5.7
 .S:LPPCE=3 FLDDIV=6.6,FLDDTE=6.7
 .S:LPPCE=4 FLDDIV=7.6,FLDDTE=7.7
 .S:LPPCE=5 FLDDIV=9.6,FLDDTE=9.7
 .S:LPPCE=6 FLDDIV=11.6,FLDDTE=11.7
 .S:LPPCE=7 FLDDIV=13.6,FLDDTE=13.7
 .S:LPPCE=8 FLDDIV=15.6,FLDDTE=15.7
 .S:LPPCE=9 FLDDIV=17.6,FLDDTE=17.7
 .S:LPPCE=10 FLDDIV=20.6,FLDDTE=20.7
 .I $P(DVBARPT(LPPCE),U,3)="P" D NEWCHK^DVBAUTL8 ;**Check for new report
 .I $P(DVBARPT(LPPCE),U,3)="" D CLRCHK^DVBAUTL8 ;**Check to clear fields 
 I $P(^DVB(396,DVBAENTR,0),U,26)="P" DO  ;**Check OPT TRT Rpt
 .S FLDDIV=18.6,FLDDTE=18.7
 .I $D(DVBANEW) D SETDR^DVBAUTL7 ;**OPT TRT Rpt included on new 7131
 .I '$D(DVBANEW),($P(NODE6,U,26)="") D SETDR^DVBAUTL7 ;**OPT Rpt Added
 I $P(^DVB(396,DVBAENTR,0),U,26)="" DO  ;**Check OPT TRT Rpt
 .I '$D(DVBANEW),($P(NODE6,U,26)'="") DO  ;**OPT Rpt deselected via edit
 ..S FLDDIV=18.6,FLDDTE=18.7
 ..D CLEARDR^DVBAUTL7
 I $D(DR) S DA=DVBAENTR,DIE="^DVB(396," D ^DIE
 K FLDDTE,FLDDIV,LPPCE,REQDTE,REQDIV,DA,DR,DIE,Y,DVBANEW,NODE6
 Q
