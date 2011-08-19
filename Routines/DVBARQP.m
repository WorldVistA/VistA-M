DVBARQP ;ALB/JLU-7131 request processing routine ;1/28/93
 ;;2.7;AMIE;**32**;Apr 10, 1995
BEG ;
 D INITIAL
 D INITRPT^DVBAUTL3
 F  DO  I DVBANY>0!($D(DTOUT)) Q
 .S DVBAOUT=0
 .F  DO  I $D(DTOUT)!($D(DUOUT))!(DVBAOUT) Q
 ..D DRAW
 ..D READ I $D(DTOUT)!($D(DUOUT))!(DVBAOUT) Q
 ..D ADJ
 ..Q
 .D FILE
 .Q
 D EXIT
 Q
 ;
EXIT K A,ADMNUM,DA,DIE,DIR,DR,DTOUT,DUOUT,DVBADSCH,DVBAER,DVBAHD21,DVBAHD22,DVBALN,DVBAOLD,DVBAOUT,DVBARPT,DVBATDT,DVBATITL,DVBAX,X,Z,DVBAP,DVBAO,DVBANY
 Q
 ;
INITIAL ;This subroutine will initialize most of the variable needed for this
 ;option.
 S $P(DVBALN,"-",80)=""
 S DVBATITL="7131 Report Requesting"
 S X="NOW",%DT="ST"
 D ^%DT
 X ^DD("DD")
 S DVBATDT=Y
 I $D(ADMNUM) D ADM
 I DVBDOC="L" D ACT
 D SSNOUT^DVBCUTIL
 S SSN=DVBCSSNO
 S DVBANY=0
 Q
 ;
ADM ;sets up admission date variable and discharge variable if applicable
 S Y=DVBREQDT
 D DD^%DT
 S DVBAHD21="Admission Date: "_Y
 I '$D(^DGPM(+ADMNUM,0)) K Y Q
 I $P(^DGPM(+ADMNUM,0),U,17)]"" DO
 .S Y=$P(^(0),U,17) ;naked from line before
 .S Y=$P(^DGPM(+Y,0),U,1)
 .D DD^%DT
 .S DVBADSCH=Y
 .S DVBAHD22="Discharge Date: "_Y
 .Q
 K Y
 Q
 ;
ACT ;sets up activity date variable
 S Y=DVBREQDT
 D DD^%DT
 S DVBAHD21="Activity Date: "_Y
 K Y
 Q
 ;
DRAW ;This subroutine will draw the screen
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
 W:$D(DVBAHD22) ?40,DVBAHD22
 W !!,?9,"Report",?37,"Selected",?60,"Status"
 W !,DVBALN
 F DVBAX=0:0 S DVBAX=$O(DVBARPT(DVBAX)) Q:'DVBAX  D DRAW1
 W !,DVBALN
 Q
 ;
DRAW1 ;rights the reports to the screen
 W !,DVBAX
 W ?3,$P(DVBARPT(DVBAX),U,1)
 W ?40,$S($P(DVBARPT(DVBAX),U,2)["Y":"YES",1:"NO")
 W ?60,$S($P(DVBARPT(DVBAX),U,3)="C":"Completed",$P(DVBARPT(DVBAX),U,3)="P":"Pending",1:"")
 Q
 ;
READ ;reads the user answer
 S DIR(0)="LAO^1:10^K:X[""."" X"
 S DIR("A")="Select Report: "
 S DIR("?",1)="Select a number or range of numbers from 1 to 10 (1,3,5 or 2-4,8).  This will"
 S DIR("?",2)="initially mark the report as 'YES'.  If the number is selected again then it"
 S DIR("?")="will be changed to 'NO' or vice versa"
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) Q
 I 'Y S DVBAOUT=1
 Q
 ;
ADJ ;This subroutine adjusts the local array
 K DVBAER
 N X,A,FLOP
 F X=1:1:10 S A=$P(Y,",",X) Q:'A  D DISC
 Q
 ;
DISC ;checks for bad answers
 I $D(ADMNUM),$D(DVBADSCH),A=1 DO:'$D(DVBAER)  S DVBAER=1 Q
 .W *7,!,"Vet already discharged - you cannot request Notice of Discharge."
 .W !,?30,"<Return> to continue."
 .R Z:DTIME
 .Q
 I DVBDOC="L",(A=1!(A=2)!(A=3)!(A=9)) DO:'$D(DVBAER)  S DVBAER=1 Q
 .W *7,!,"Cannot select 'Notice of Discharge', 'Hospital Summary', 'Certificate (21-day)', or 'Admission Report' for an activity date."
 . W !,?30,"<Return> to continue."
 .R Z:DTIME
 .Q
 ;
 ;If Notice of Discharge selected, check patient's Claim Folder Location.
 I A=1 S FLOP=0 D  Q:FLOP
 . N CK S CK=$$CKCFLOC()
 . I CK=1 S FLOP=1 W *7,!,"The patient has no Claim Folder Location in the Patient File.",!,"Notice of Discharge would not be returned.",!,?30,"<Return> to continue." R Z:DTIME
 . I CK=2 S FLOP=1 D
 .. W *7,!,"The patient's Claim Folder Location has no Station Number in file #4.",!,"Notice of Discharge would not be returned.",!,"Please check the Claim Folder Location and its entry in file #4.",!,?30,"<Return> to continue." R Z:DTIME
 ;
 ;If 21 Day Certificate selected, check patient's Claim Folder Location.
 I A=3 S FLOP=0 D  Q:FLOP
 . N CK S CK=$$CKCFLOC()
 . I CK=1 S FLOP=1 W *7,!,"The patient has no Claim Folder Location in the Patient File.",!,"21 Day Certificate would not be returned.",!,?30,"<Return> to continue." R Z:DTIME
 . I CK=2 S FLOP=1 D
 .. W *7,!,"The patient's Claim Folder Location has no Station Number in file #4.",!,"21 Day Certificate would not be returned.",!,"Please check the Claim Folder Location and its entry in file #4.",!,?30,"<Return> to continue." R Z:DTIME
 D CHNG
 Q
 ;
CKCFLOC() ;Check if Claim Folder Location or its Station Number is null.
 ;If Claim Folder Location and Station Number are not null, CK=0.
 ;If Claim Folder Location is null, CK=1.
 ;If Station Number is null, CK=2.
 N CK,ZDFN,ZCFLOC
 S CK=0
 S ZDFN=$P($G(DFN),U) I $G(ZDFN)="" S CK=3 Q CK
 S ZCFLOC=$P($G(^DPT(ZDFN,.31)),U,4)
 I $G(ZCFLOC)="" S CK=1
 I $G(ZCFLOC)'="" S:$P($G(^DIC(4,ZCFLOC,99)),U)="" CK=2
 Q CK
 ;
CHNG ;updates the local array
 Q:$P(DVBARPT(A),U,3)["C"
 S DVBAOLD=$P(DVBARPT(A),U,2)
 S DVBAOLD=$S(DVBAOLD["Y":"NO",1:"YES")
 S $P(DVBARPT(A),U,2)=DVBAOLD
 S $P(DVBARPT(A),U,3)=$S(DVBAOLD["Y":"P",1:"")
 Q
 ;
FILE ;this subroutine sets the data into the file and asks the last three 
 ;questions
 I $D(DTOUT) S DVBANY=1 D DEL^DVBAUTL3(DVBAENTR):'$D(DVBAEDT) Q
 I $D(DUOUT) DO  Q
 .I '$D(DVBAEDT) S DVBANY=1 D DEL^DVBAUTL3(DVBAENTR) Q
 .S DVBANY=$$ANYSEL(DVBAENTR)
 .I DVBANY'>0 D ERR
 .Q
 D LAST
 I $D(Y) I '$D(DVBAEDT) DO  Q
 .D DEL^DVBAUTL3(DVBAENTR)
 .S DVBANY=1
 .Q
 S DVBANY=$$ANYSEL(DVBAENTR)
 I 'DVBANY D ERR Q
 D STM^DVBCUTL4
 D FILE^DVBAUTL3
 S XRTN=$T(+0)
 D SPM^DVBCUTL4
 ;;;D TEST:'$D(DVBAEDT)
 Q
 ;
ERR ;this subroutine will print out an error message when no reports are
 ;selected on the 7131.
 S VAR(1,0)="1,0,0,2,0^You have not selected any reports for this 7131 request"
 S VAR(2,0)="0,0,0,1:2,0^or have selected number 4 but not entered any remarks."
 D WR^DVBAUTL4("VAR")
 K VAR
 D CONTMES^DVBCUTL4
 Q
 ;
ANYSEL(B) ;
 ;This subroutine checks to see if any reports were selected on the 7131
 ;request.
 ;B is the internal entry number in file 396
 N X,CNT
 S CNT=0
 F X=0:0 S X=$O(DVBARPT(X)) Q:'X!(CNT)  DO  ;checking each report
 . I $P(DVBARPT(X),U,2)="YES" S CNT=1
 .Q
 I $P(^DVB(396,B,0),U,25)]"" S CNT=1 ;checking opt date range
 I $P(DVBARPT(4),U,2)="YES",'$O(^DVB(396,B,5,0)) S CNT=0 ;if no remarks set to zero
 Q CNT
 ;
LAST ;this subroutine will ask the last three questions
 S DIE="^DVB(396,",DA=DVBAENTR
 S DR="18;S X=X;19///^S X=$S($P(^DVB(396,DA,0),U,25)']"""":""@"",$P(^(0),U,26)=""C"":""C"",1:""P"");29Routing Location;.5;23///"_DT_";24///"_DT_";27///"_LOC_";28///"_OPER
 D ^DIE
 Q
 ;
TEST ;tests to see if the user wants this 7131
 D DRAW
 W !,*7,"Do you want to file this request"
 S %=1 D YN^DICN
 I %=2 D DEL^DVBAUTL3(DVBAENTR)
 Q
