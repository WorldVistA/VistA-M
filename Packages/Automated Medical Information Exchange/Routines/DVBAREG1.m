DVBAREG1 ;ALB/JLU;557/THM-REQ FOR ADMITTED VETS ; 10/29/90  7:53 AM
 ;;2.7;AMIE;**14**;Apr 10, 1995
EN ;this is the main entry point for the driver
 D TERM
 I '$D(DVBAQUIT) DO
 .F  D BODY Q:$D(DVBAQUIT)
 .Q
 D EXIT^DVBAUTIL
 Q
 ;
TERM ;this subroutine will set various necessary variables
 ;
 K DVBAQUIT
 D DUZ2^DVBAUTIL
 Q:$D(DVBAQUIT)
 D NOPARM^DVBAUTL2
 Q:$D(DVBAQUIT)
 D HOME^%ZIS
 Q:$D(DVBAQUIT)
 S OPER=$S($D(^VA(200,+DUZ,0)):$P(^(0),U,1),1:"Unknown")
 S HD="PATIENT LOOKUP"
 S LOC=$S($D(^DIC(4,+DUZ(2),0)):$P(^(0),U,1),1:"")
 S HNAME=$$SITE^DVBCUTL4()
 S DVBAENTR=0
 Q
 ;
BODY ;this subroutine is a subdriver for this functionality
 S DVBAENTR=0
 D UNLOCK^DVBAUTL6(DVBAENTR) ;unlocks the record
 D CLEAN^DVBAREG2 ;cleans up some variables
 D PAGE^DVBAREG2 ;checks for bottom of the screen or page
 D SET1^DVBAREG3 ;sets a few variables
 S DFN=$$PAT^DVBAREG3() ;function call to get the patient
 I DFN=0 S DVBAQUIT=1 Q
 D SET2^DVBAREG3 ;sets up patient information variables
 D CLEAR^DVBAUTL4
 D DTRNG^DVBAREG2(DFN) ;gets the date range
 I $D(DVBAQUIT)!($D(DVBASTOP)) Q
 I DVBBDT>0 S DVBCHK=$$CHK(DFN,DVBBDT,DVBEDT)
 I DVBBDT=0 S DVBCHK=$$CHK(DFN,2010101,DT)
 D CLEAR^DVBAUTL4
 I DVBCHK=0 D ERR^DVBAUTL6(DVBBDT) S DVBASTOP=1 Q
 I DVBCHK="B" D QUEST1(DFN) Q:$D(DVBAQUIT)
 D OLD^DVBAREN1
 D DISPLAY
 Q:$D(DVBAQUIT)
 ;
 ;*The following line of code was removed as part of the coding to allow
 ;* Admission and Activity 7131s with the same date
 ;I $D(DVBANS) S DVBDOC=$$DOC^DVBAREG3(DVBANS)
 I '$D(DVBANS) DO SRCH I $D(DVBASTOP)!($D(DVBAQUIT))!('$D(DVBAENTR)) Q
 I $D(DVBANS) D SELECT^DVBAREG2
 Q:$D(DVBASTOP)!($D(DVBAQUIT))
 D ^DVBARQP
 D UNLOCK^DVBAUTL6(DVBAENTR)
 Q
 ;
CHK(A,B,C) ;checks for the existance of admissions, appointments, dispositions 
 ;or stop codes
 ;A is the DFN of the Patient
 ;B is the beginning date
 ;C is the ending date
 ;If all is selected then B and C should be dates that encompise all
 ;possible dates
 ;the date ranges provided must iclude the +/-for end of days
 N ADM,APT,DISP,SPCOD,B1,C1,C2,DVBADM,DVBAPT,DVBDISP,DVBSPCOD,DVBENC,DVBZERR
 S (DVBADM,DVBAPT,DVBDISP,DVBSPCOD)=0
 S B1=9999999.9999999-B
 S C1=9999999.9999999-C
 S ADM=$O(^DGPM("APTT1",+A,B))
 I ADM,ADM'>C S DVBADM=1
 S APT=$O(^DPT(+A,"S",B))
 I APT,APT'>C S DVBAPT=1
 S DISP=$O(^DPT(+A,"DIS",C1))
 I DISP,DISP'>B1 S DVBDISP=1
 ; Scheduling conversion
 S SPCOD=$$EXOE^SDOE(+A,B,9999999,,"DVBZERR")
 I SPCOD D GETGEN^SDOE(SPCOD,"DVBENC","DVBZERR") S SPCOD=$G(DVBENC(0))\1
 ;
 I SPCOD,SPCOD'>C S DVBSPCOD=1
 I DVBADM&((DVBAPT)!(DVBDISP)!(DVBSPCOD)) Q "B"
 I DVBADM Q "A"
 I DVBAPT!(DVBDISP)!(DVBSPCOD) Q "N"
 Q 0
 ;
QUEST1(DFN) ;ask user which they wish to see admission or non
 S DIR("A")="Which would you prefer"
 S DIR("A",1)=$P(DFN,U,2)_" has both Admission and Non Admission information."
 S DIR(0)="SM^A:Admissions;N:Non Admissions;B:Both"
 D ^DIR
 K DIR
 I $D(DTOUT)!($D(DUOUT))!(X="") S DVBAQUIT=1 Q
 S DVBCHK=Y
 Q
 ;
DISPLAY ;displays the patient information to the user.  Also asks the user
 ;to select which info.
 N X1,X2,X3,X4,VAR1
 I DVBANL=1 D SINGLE^DVBAREG2 Q
 K DVBANS
 S X2=$O(^TMP("DVBA",$J,0))
 I 'X2 S DVBASTOP=1 Q
 S $P(VAR1," ",5)=""
 S (X1,DVBCNT)=0
 F  DO  Q:$D(DVBASTOP)!($D(DVBANS))
 .S XTYPE=""
 .F  S XTYPE=$O(^TMP("DVBA",$J,X2,XTYPE)) Q:XTYPE=""  DO
 ..S X1=X1+1
 ..S DVBCNT=DVBCNT+1
 ..S VAR(DVBCNT,0)="0,0,0,1,0^"_X1_$E(VAR1,1,5-$L(X1))_$P(^TMP("DVBA",$J,X2,XTYPE),U,1)
 ..I '(X1#12)!($O(^TMP("DVBA",$J,X2,XTYPE))=""&'$O(^TMP("DVBA",$J,X2))) DO
 ...D WR^DVBAUTL4("VAR")
 ...K VAR
 ...S DVBCNT=0
 ...D CONT^DVBAREG2
 .S X2=$O(^TMP("DVBA",$J,X2))
 .I '$D(DVBANS),('X2) S DVBASTOP=1 Q
 .Q
 I $D(DVBANS) DO
 .S (X3,X4)=0,(DVBTYPE,DVBDOC)=""
 .F  Q:+X3=+DVBANS  S X4=$O(^TMP("DVBA",$J,X4)) Q:X4=""  DO
 ..F  Q:+X3=+DVBANS  S DVBTYPE=$O(^TMP("DVBA",$J,X4,DVBTYPE)) Q:DVBTYPE=""  S X3=X3+1
 .S DVBANS=X4
 .S DVBDOC=$S(DVBTYPE["ADMISSION":"A",1:"L")
 .Q
 K XTYPE
 Q
 ;
SRCH ;searches the 7131 file for an existing 7131 request.
 K DA,Y,DVBASTOP,DVBAENTR
 D DICW^DVBAUTIL
 S VAR(1,0)="0,0,0,2,0^Searching file for existing 7131 requests for "_PNAM
 D WR^DVBAUTL4("VAR")
 K VAR
 S DIC="^DVB(396,",DIC(0)="EM",X=SSN
 I DVBCHK'="B",DVBBDT=0 S DIC("S")=$S(DVBCHK="A":"I $P(^(2),U,10)=""A""",1:"I $P(^(2),U,10)=""L"""),DVBDOC=$S(DVBCHK="A":"A",1:"L")
 I DVBCHK'="B",DVBBDT>0 S DIC("S")=$S(DVBCHK="A":"I $P(^(2),U,10)=""A""",1:"I $P(^(2),U,10)=""L""")_",$P(^(0),U,4)>(DVBBDT-.0000001),$P(^(0),U,4)<(DVBEDT+.0000001)"
 D ^DIC
 K DIC
 S DVBAY=Y
 I DVBAY<0 DO  Q
 .S VAR(1,0)="0,0,0,2:2,0^No selection made!"
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .D CONTMES^DVBCUTL4
 .S DVBASTOP=1
 .Q
 I DVBAY>0 DO
 .I '$$LOCK^DVBAUTL6(+DVBAY) S DVBASTOP=1 Q
 .S (ZI,DA,DVBAIFN)=+DVBAY
 .S DVBREQDT=$P(^DVB(396,DA,0),U,4)
 .D ALERT^DVBAREG2(+DVBAY)
 .D ASK^DVBAREG2
 .Q:$D(DVBAQUIT)!($D(DVBASTOP))
 .S ONFILE=0
 .S DVBAENTR=+DVBAY
 .S DVBDOC=$P(^DVB(396,DVBAENTR,2),U,10)
 .I DVBDOC["A" S ADMNUM=$$ADM(DVBREQDT,+DFN)
 .I STAT'="" D ALERT1^DVBAREG2
 .I $D(DVBAQUIT) K DVBAEDT
 .I ONFILE=1 S DVBASTOP=1 Q
 .Q
 K DVBAY
 Q
 ;
ADM(A,B) ;This entry point will return the IEN in DGPM for the patient
 ;and admission date given.  A will be the admission date and B will
 ;be the DFN of the patient.
 ;
 N X
 S A=9999999.9999999-A
 S X=$O(^DGPM("ATID1",+B,A,0))
 I X DO
 .I '$D(^DGPM(X,0)) S X=""
 .Q
 I X="" Q 0
 Q X
