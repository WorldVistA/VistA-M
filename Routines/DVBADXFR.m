DVBADXFR ;ALB/GTS-AMIE 7131 DIVISIONAL TRANSFER RTN ; 12/6/94  2:00 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
MAIN ;**Loop to select and update 7131 report divisions
 F  DO  I $D(DTOUT)!($D(DUOUT)!($D(DVBAOUT))) Q  ;**QUIT top 'For' loop
 .D HOME^%ZIS
 .W @IOF
 .W !!,?5,"7131 Divisional Transfer",!!
 .S REQDA=$$SEL7131^DVBAUTL7()
 .S:+REQDA'>0 DVBAOUT=""
 .I +REQDA>0 DO
 ..D INITIAL,REQVARS
 ..D INITRPT^DVBAUTL7(REQDA)
 ..K DTOUT,DUOUT,DVBAOUT
 ..F  DO  I $D(DTOUT)!($D(DUOUT)!($D(DVBAOUT))) Q  ;**QUIT 'For' loop
 ...K NODIV
 ...D DRAW
 ...D READ I $D(DTOUT)!($D(DUOUT)!($D(DVBAOUT))) Q  ;**QUIT 'For' loop
 ...D DIVSEL I $D(DTOUT)!($D(DUOUT)!($D(DVBAOUT))) Q  ;**QUIT 'For' loop
 ...D:'$D(NODIV) ADJ
 ..I '$D(DTOUT)&('$D(DUOUT)) D FILE^DVBAUTL7
 ..D EXITLP
 K DVBAOUT,REQDA,DA,DIE,DIR,DR,DTOUT,DUOUT
 W @IOF
 Q
 ;
EXITLP K A,DA,DIE,DIR,DR,DTOUT,DUOUT,DVBADSCH,DVBAER,DVBAHD21,DVBALN,DVBAOUT
 K FLDDIV,FLDDTE,REQDIV,DVBARPT,DVBATDT,DVBATITL,DVBAX,X,Z,DVBAP,DVBAO
 K REQDTE,DVBARPT,REQDA,DVBCSSNO,SSN,HNAME,PNAM,DVBREQDT,DFN,RPTVAR
 K NDIVIEN,NDIVNAME,CNUM,NODIV
 Q
 ;
INITIAL ;**initialize general variables
 S $P(DVBALN,"-",80)=""
 S DVBATITL="7131 Divisional Transfer"
 S X="NOW",%DT="ST"
 D ^%DT
 X ^DD("DD")
 S DVBATDT=Y
 S HNAME=$$SITE^DVBCUTL4()
 K X,Y,%DT
 Q
 ;
REQVARS ;**Set variables unique to 7131
 S DVBREQDT=$P(^DVB(396,REQDA,0),U,4)
 I $P(^DVB(396,REQDA,2),U,10)="L" D ACT
 I $P(^DVB(396,REQDA,2),U,10)="A" D ADM
 S DFN=$P(^DVB(396,REQDA,0),U,1)
 S PNAM=$P(^DPT(DFN,0),U,1),SSN=$P(^DPT(+DFN,0),U,9)
 S CNUM=$S($D(^DPT(+DFN,.31)):$P(^(.31),U,3),1:"Unknown")
 D SSNOUT^DVBCUTIL
 S SSN=DVBCSSNO
 Q
 ;
ADM ;**Set up admission date and discharge variables
 S Y=DVBREQDT
 D DD^%DT
 S DVBAHD21="Admission Date: "_Y
 K Y
 Q
 ;
ACT ;**Set up activity date variable
 S Y=DVBREQDT
 D DD^%DT
 S DVBAHD21="Activity Date: "_Y
 K Y
 Q
 ;
DRAW ;** Output Division screen
 I IOST?1"C-".E W @IOF
 W "Information Request Form"
 W ?35,HNAME
 W ?59,DVBATDT
 W !,DVBALN
 W !,"Patient: "
 W PNAM
 W ?54,"SSN: "
 W SSN
 W !,"Claim #: ",CNUM,!
 W DVBAHD21
 W !!,?9,"Report",?37,"Selected",?48,"Status",?58,"Division"
 W !,DVBALN
 F DVBAX=0:0 S DVBAX=$O(DVBARPT(DVBAX)) Q:'DVBAX  D DRAW1
 W !,DVBALN
 Q
 ;
DRAW1 ;** Output a report to the screen
 W !,DVBAX
 W ?3,$P(DVBARPT(DVBAX),U,1)
 W ?40,$S($P(DVBARPT(DVBAX),U,2)["Y":"YES",1:"NO")
 W ?48,$S($P(DVBARPT(DVBAX),U,3)="C":"Completed",$P(DVBARPT(DVBAX),U,3)="P":"Pending",1:"")
 W ?58,$E($P(DVBARPT(DVBAX),U,4),1,20)
 Q
 ;
READ ;** Read selected report
 S DIR(0)="LAO^1:11^K:X[""."" X"
 S DIR("A")="Select Report(s) to Transfer: "
 S DIR("?",1)="Select a number or range of numbers from 1 to 10 (1,3,5 or 2-4,8).  You will"
 S DIR("?",2)="then be asked to select a division to transfer the report(s) to.  After a"
 S DIR("?")="division is selected, the new division will display next to the report(s)."
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) Q
 I 'Y S DVBAOUT="" ;**User hit Return at report prompt
 S:$D(Y) RPTVAR=Y
 Q
 ;
DIVSEL ;** Select a division to transfer to  (Division must be in AMIE Site
 ;**  Parameter File)
 N PARAMDA
 S PARAMDA=$$IFNPAR^DVBAUTL3()
 D:PARAMDA'>0 PARAMERR
 I PARAMDA>0 DO
 .S DIC(0)="AEMQ"
 .S DIC("A")="Select a Division to Transfer to: "
 .S DIC="^DVB(396.1,PARAMDA,2,"
 .D ^DIC
 .S:+Y>0 NDIVIEN=$P(^DVB(396.1,PARAMDA,2,+Y,0),U,1)
 .S:+Y>0 NDIVNAME=$P(^DG(40.8,NDIVIEN,0),U,1)
 .S:+Y'>0 NODIV=""
 .K DIC,Y
 Q
 ;
PARAMERR ;** Error if the AMIE Site Parameter file has a problem
 W *7,!,"The AMIE Site Parameter File is not set up properly."
 W !,"Contact the Medical Center's IRM department."
 W !,?30,"<Return> to continue."
 R Z:DTIME
 S DVBAOUT=""
 Q
 ;
ADJ ;** Adjust local array DVBARPT(#)
 K DVBAER
 N X,A
 F X=1:1:11 S A=$P(RPTVAR,",",X) Q:'A  D CHECK
 D:'$D(DVBAER) CHNG
 K Y
 Q
 ;
CHECK ;** Check for X-fer of report with status '= Pending
 I $P(DVBARPT(A),U,3)'="P" DO:'$D(DVBAER)  S DVBAER=1 Q
 .W *7,!,"You have selected a report with a status other than Pending."
 .W !,"All reports selected for transfer must be Pending."
 .W !,?30,"<Return> to continue."
 .R Z:DTIME
 .Q
 Q
 ;
CHNG ;** Update local array DVBARPT(#)
 F X=1:1:11 S A=$P(RPTVAR,",",X) Q:'A  DO
 .I $P(DVBARPT(A),U,3)="P" DO
 ..S $P(DVBARPT(A),U,4)=NDIVNAME
 ..S $P(DVBARPT(A),U,5)=NDIVIEN
 Q
