DVBAREG2 ;ALB/JLU;second half of the 7131 input;3/2/99
 ;;2.7;AMIE;**3,5,14,17,20,25**;Apr 10, 1995
 ;
CONT ;asks selection from list
 S DIR(0)="NAO^1:"_X1_":0"
 S DIR("A")="Select 1-"_X1_"   or '^' to Exit or Return to continue "
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT) S DVBASTOP=1 Q
 I Y]"" S DVBANS=Y
 E  K DVBANS
 Q
 ;
SINGLE ;when select single entry point
 S XTYPE=""
 S X1=$O(^TMP("DVBA",$J,0))
 I X1="" S DVBASTOP=1 Q
 S XTYPE=$O(^TMP("DVBA",$J,X1,XTYPE))
 I XTYPE="" S DVBASTOP=1 Q
 S DIR("A",1)=""
 S DIR("A",2)=$P(^TMP("DVBA",$J,X1,XTYPE),U)
 S DIR("A")="Is this the correct information? "
 S DIR("B")="NO"
 S DIR(0)="YA"
 D ^DIR
 K DIR
 I $D(DUOUT)!($D(DTOUT)) S DVBASTOP=1 Q
 I Y S DVBANS=X1,DVBTYPE=XTYPE,DVBDOC=$S(DVBTYPE["ADMISSION":"A",1:"L")
 E  K DVBANS
 Q
 ;
DTRNG(DFN) ;gets date range from user
 S DIR("A",1)="Display Admission or Activity information"
 S DIR("A")="for "_$P(DFN,U,2)_"  by"
 S DIR("?")="Date Range will allow the user to select the specific dates."
 S DIR("?",1)="All Dates will show the user all possible information."
 S DIR(0)="SM^D:Date Range;A:All Dates"
 D ^DIR
 K DIR
 I $D(DTOUT)!($D(DUOUT)) S DVBAQUIT=1 Q
 I X="" S DVBASTOP=1 Q
 S DVBBDT=0,DVBEDT=0
 S VAR(1,0)="0,0,0,1,0^"
 D WR^DVBAUTL4("VAR")
 K VAR
 I Y="D" DO
 .D DATE^DVBCUTL4(.DVBBDT,.DVBEDT)
 .S Y="D"
 .I DVBBDT>0,'+$P(DVBBDT,".",2) S DVBBDT=DVBBDT-.0000001
 .I DVBEDT>0,'+$P(DVBEDT,".",2) S DVBEDT=DVBEDT+.9999999
 .I DVBBDT=0,DVBEDT=0 S DVBAQUIT=1
 .I DVBBDT=-1,DVBEDT=-1 S DVBASTOP=1
 .Q
 Q
 ;
CLEAN ;cleans up variables
 K DA,ADM,ADMDT,ADMNUM,DFN,DIC,A,DR,PNAM,SSN,TRN,Z,DINUM,DTAR,C,J,K,L,C,D,DIE,ONFILE,%,OLDDA,%Y,DIK,ZI,X,Y,AROWOUT,DVBAEDT,DVBAENTR,DVBASTOP,DVBREQDT,DVBANS,DVBTYPE
 K ^TMP("DVBA",$J),^UTILITY("DIQ1",$J)
 Q
 ;
PAGE ;pages/dispays end of page/screen
 S VAR(1,0)="0,0,0,0,1^"
 S VAR(2,0)="0,0,"_(IOM-$L(HD)\2)_":0,0,0^"_HD
 S VAR(3,0)="0,0,"_(IOM-$L(HNAME)\2)_":0,1:2,0^"_HNAME
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
 ;
SELECT ;checks doc type, request status and calls deletion, if necessary
 N ZI
 K DVBAENTR
 S DVBREQDT=9999999.9999999-DVBANS
 I DVBTYPE["ADMISSION" DO
 .S ADMNUM=$P(^TMP("DVBA",$J,DVBANS,DVBTYPE),U,2)
 D COMPSEL
 Q
 ;
COMPSEL ;** Compare selected 7131 to existing
 N DVBATMPT
 I DVBTYPE["ADMISSION" S DVBATMPT="A"
 I DVBTYPE'["ADMISSION" S DVBATMPT="L"
 F ZI=0:0 S ZI=$O(^DVB(396,"B",+DFN,ZI)) Q:ZI=""  I $D(^DVB(396,"G",+$E(DVBREQDT,1,14),ZI))&(DVBATMPT=$P(^DVB(396,ZI,2),"^",10)) S DVBAENTR=ZI Q
 I $D(DVBAENTR) DO
 .D ALERT(ZI)
 .D ASK
 .Q:$D(DVBAQUIT)!($D(DVBASTOP))
 .I '$$LOCK^DVBAUTL6(DVBAENTR) S DVBASTOP=1 Q
 .S STAT=$P(^DVB(396,DVBAENTR,1),U,12)
 .S ONFILE=0
 .I STAT'="" D ALERT1
 .Q:$D(DVBAQUIT)!($D(DVBASTOP))
 .I ONFILE=1 S DVBASTOP=1 Q
 .Q
 I '$D(DVBAENTR) DO
 .D DICW^DVBAUTIL
 .D ASK1
 .I $D(DVBASTOP)!($D(DVBAQUIT)) Q
 .D STUFF
 .Q
 I '$D(DVBAENTR) S DVBASTOP=1
 Q
 ;
ALERT(Y) ;displays when a potential hit in the 7131 file.
 S VAR(1,0)="1,0,0,2,0^There is a 7131 already on file for "_$$FMTE^XLFDT(DVBREQDT,"5DZ")
 S STAT=$P(^DVB(396,+Y,1),U,12)
 S VAR(2,0)="0,0,0,1:1,0^Status is "_$S(STAT'="":"FINALIZED",1:"OPEN")
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
ALERT1 ;
 I STAT'="" DO
 .S VAR(1,0)="0,0,0,1,0^"
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .S DIR("A")="Do you want to delete the existing 7131 for this date: "
 .S DIR(0)="YAO"
 .S DIR("B")="NO"
 .S DIR("?")="Answer YES or No.  You may not have two 7131s for the same admission date."
 .D ^DIR
 .K DIR
 .I $D(DTOUT)!($D(DUOUT))!(Y="") S DVBAQUIT=1 Q
 .I 'Y S DVBASTOP=1 Q
 .I Y DO
 ..S DA=+DVBAENTR
 ..D REOPEN^DVBAUTL2
 ..K DA
 ..Q
 .Q
 Q
 ;
ASK1 ;ask user if wish to add new 7131
 S DVBAASIH=$P(DVBREQDT,".",2) ;*ASIH admit? (P4,v2.7)
 D:$L(DVBAASIH)>6 ASIHALRT^DVBAUTL8 ;**Warn ASIH admit
 S VAR(1,0)="1,0,0,1,0^"
 D WR^DVBAUTL4("VAR")
 K VAR
 S DIR("A",1)="Do you want to add a NEW 7131"
 S DIR("A")="for "_$P(PNAM,",",2,99)_" "_$P(PNAM,",",1,1)_" :"
 S DIR(0)="YAO"
 S DIR("B")="NO"
 S DIR("?")="'YES' to enter a new 7131. 'NO' to search for an existing one."
 D ^DIR
 K DIR,DVBAASIH
 I $D(DUOUT)!($D(DTOUT)) S DVBAQUIT=1 Q
 S:Y=1 DVBREQDT=+$E(DVBREQDT,1,14)
 I Y=0 S DVBASTOP=1 Q
 Q
 ;
ASK ;ask the user if wish to edit existing 7131
 S VAR(1,0)="1,0,0,1,0^"
 D WR^DVBAUTL4("VAR")
 K VAR
 S DIR("A")="Are you sure you want to edit this 7131 request: "
 S DIR("B")="NO"
 S DIR("?")="'YES' to edit the 7131 request."
 S DIR(0)="YAO"
 D ^DIR
 K DIR
 I $D(DUOUT)!($D(DTOUT)) S DVBAQUIT=1 Q
 I Y=0 S DVBASTOP=1 Q
 I Y=1 S DVBAEDT=1
 Q
 ;
STUFF ;enters 7131 into 7131 form file
 K DA,DIC("S"),DD,DO
 S DLAYGO=396,DIC(0)="QLM",DIC="^DVB(396,",X=+DFN
 D FILE^DICN
 I 'Y DO  S DVBASTOP=1 Q
 .S VAR(1,0)="1,0,0,2,0^Unable to add this new record!"
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .Q
 I '$$LOCK^DVBAUTL6(Y) S DVBASTOP=1 Q
 S (DA,DVBAENTR)=+Y
 S DR="1////"_CNUM_";2////"_SSN_";3////"_DVBREQDT_";23////"_DT_";24////"_DT_";27////"_LOC_";28////"_OPER_";30////"_$S($D(ADMNUM):"A",1:"L")
 S DIE=DIC
 D ^DIE
 K DA,DLAYGO,DIC,DIE
 Q
 ;
