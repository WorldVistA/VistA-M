ACKQCD2 ;AUG/JLTP BIR/PTD HCIOFO/AG-Generate A&SP Service CDR - CONTINUED ; [05/15/96 9:30 ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
INDCAT(ACKCDR) ;Enter hours for CDR account.
 N DIR,Y,CDR,X
INDCAT2 K DIRUT,DUOUT,DTOUT,DIR S X=ACKCDR
 S DIR(0)="N^0:"_ACKRTH,CDR=$P(^ACK(509850,X,0),U)_" "_$P(^(0),U,2)
 S DIR("A")="Enter Hours for "_CDR
 S DIR("??")="^W !!,""Enter the number of hours that you wish to charge to CDR"",!,""account "",CDR,""."""
 D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G INDCAT2
 Q:$D(DIRUT)
 S ^TMP("ACKQCDR",$J,"ACKH",+CDR)=Y,ACKRTH=ACKRTH-Y
 Q
PASS ;Enter hours for pass-through account.
 N DIC,DIR,X,Y,CDR
PASS2 S DIC="^ACK(509850,",DIC("A")="Select Pass-Through Account: "
 S DIC("S")="I $P(^(0),U,3)=""P""",DIC(0)="AEMQZ"
 D ^DIC K DIC
 I X?1"^"1.E W !,"Jumping not allowed.",! G PASS2
 I Y<0 S DIRUT=1 Q
 S CDR=+$P(Y,U,2),CDR(0)=$P(Y(0),U,2)
PASS3 I $D(^TMP("ACKQCDR",$J,"ACKH",CDR)) S DIR("B")=^TMP("ACKQCDR",$J,"ACKH",CDR)
 S DIR(0)="N^0:"_ACKRTH,DIR("A")="Enter Hours for "_CDR(0)
 S DIR("??")="^W !!,""Enter the number of hours to charge to "",CDR(0)"
 D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G PASS3
 Q:$D(DIRUT)
 S ^TMP("ACKQCDR",$J,"ACKH",CDR)=Y S:$D(DIR("B")) ACKRTH=ACKRTH+DIR("B") S ACKRTH=ACKRTH-Y
 Q
DISREM ;DISTRIBUTE REMAINING HOURS
 N I,X
 S I=0 F  S I=$O(ACKTCH(I)) Q:'I  D
 .S X=(ACKTCH(I)/ACKTCH)*ACKRTH,ACKTCH(I)=ACKTCH(I)+X
 Q
PERCENT ;CONVERT ALL VALUES TO %
 N I,X
 S ACKTP=0
 S I=0 F  S I=$O(^TMP("ACKQCDR",$J,"ACKH",I)) Q:'I  S X=^TMP("ACKQCDR",$J,"ACKH",I)/ACKTPH*100,^TMP("ACKQCDR",$J,"ACKH",I)=X,ACKTP=ACKTP+X
 S I=0 F  S I=$O(ACKTCH(I)) Q:'I  S ^TMP("ACKQCDR",$J,"ACKH",I)=ACKTCH(I)/ACKTPH*100,ACKTP=ACKTP+^TMP("ACKQCDR",$J,"ACKH",I)
 K ACKTCH Q
CLINH ;Calculate number of clinic hours & student training (.12) by CDR series. See README at end.
 N C,D,I,V
 K ACKTCH,ACKTSH S (ACKTCH,ACKTSH)=0
 ;Loop through selected date range.
 F D=(ACKSD-.1):0 S D=$O(^ACK(509850.6,"B",D)) Q:'D!(D>(ACKED+.9))  D
 .S V=0 F  S V=$O(^ACK(509850.6,"B",D,V)) Q:'V  D
 ..;Get TIME SPENT and CDR#. Student present? YES, increment ACKTSH array; else increment ACKTCH array.
 ..S M=+$P(^ACK(509850.6,V,0),U,7),ACK2=^(2),C=+$P($G(ACK2),U,2),C=+$G(^ACK(509850,C,0))
 ..I $P(ACK2,U,4) S ACKTSH=ACKTSH+M,ACKTSH($E(C,1,2))=$G(ACKTSH($E(C,1,2)))+M
 ..I '$P(ACK2,U,4) S ACKTCH=ACKTCH+M,ACKTCH(C)=$G(ACKTCH(C))+M
 ;Convert minutes to hours.
 S ACKTCH=ACKTCH/60 S C=0 F  S C=$O(ACKTCH(C)) Q:'C  S ACKTCH(C)=ACKTCH(C)/60
 S ACKTSH=ACKTSH/60 S C=0 F  S C=$O(ACKTSH(C)) Q:'C  S ACKTSH(C)=ACKTSH(C)/60
 ;Move student hours array into ^TMP global.
 S I=0 F  S I=$O(ACKTSH(I)) Q:'I  S ^TMP("ACKQCDR",$J,"ACKH",$S(((I<21)!(I>27)):I_"00.12",1:2800.12))=+ACKTSH(I)
 Q
TPH ;Ask for Total Paid Hours.
 N DIR,X,Y
TPH2 K DTOUT,DUOUT,DIRUT,DIR
 S DIR(0)="N^1:9999",DIR("A")="Enter Total Paid Hours"
 S DIR("?")="Enter a number between 1 and 9999."
 S DIR("??")="^D TPH^ACKQCD1"
 W ! D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G TPH2
 S ACKTPH=+Y
 Q
INDEX ;Build ^TMP arrays in category and CDR# order.
 N I,CAT,CDR
 S I=0 F  S I=$O(^ACK(509850,I)) Q:'I  S CDR=^(I,0),CAT=$P(CDR,U,4),^TMP("ACKQCDR",$J,"ACKCAT",CAT,+CDR)=$P(CDR,U,1,2) S:ACKSAV ^TMP("ACKQCDR",$J,"ACKNDX",+CDR)=$P(CDR,U)
 Q
SAVE ;
 N IFN,M
 S IFN=+$$SITE^VASITE_$E(ACKMO,1,5)
 I $O(^ACK(509850.7,IFN,4,0)) D  Q:$D(DIRUT)
 .K DIR,X,Y S DIR(0)="Y",DIR("A")="Delete existing CDR data and regenerate the CDR for "_ACKXRNG,DIR("B")="NO"
 .S DIR("?")="Enter YES to delete and regenerate the CDR, otherwise enter NO.",DIR("??")="^D REGEN^ACKQHLP1"
 .W ! D ^DIR K DIR S:Y=0 DIRUT=1 Q:$D(DIRUT)
DIK .;User wants to delete CDR subfile for date.
 .S DIK="^ACK(509850.7,"_IFN_",4,",DA(1)=IFN S SUB=0
 .F  S SUB=$O(^ACK(509850.7,IFN,4,SUB)) Q:'SUB  S DA=SUB D ^DIK
 .S DIE="^ACK(509850.7,",DA=IFN,DR=".09///"_"@" D ^DIE K DIE,DA,DR
 .; changed to check for Division level data before removing the month node
 .I '$O(^ACK(509850.7,IFN,1,0)),'$D(^ACK(509850.7,IFN,5)) S DIK="^ACK(509850.7,",DA=IFN D ^DIK
 L +^ACK(509850.7,IFN) D:'$D(^ACK(509850.7,IFN,0)) CREATE
 S DIE="^ACK(509850.7,",DA=IFN,DR=".09////"_ACKTPH D ^DIE K DIE,DA,DR
 S CDR=0 F  S CDR=$O(^TMP("ACKQCDR",$J,"ACKH",CDR)) Q:'CDR  I ^TMP("ACKQCDR",$J,"ACKH",CDR) D
 .S DIC="^ACK(509850.7,"_IFN_",4,",DIC(0)="L",DLAYGO=509850.7,X=$P(^TMP("ACKQCDR",$J,"ACKNDX",CDR),U),DINUM=+X
 .S DIC("P")=$P(^DD(509850.7,4,0),U,2),DA(1)=IFN K DD,DO D FILE^DICN K DA
 .S DIE="^ACK(509850.7,"_IFN_",4,",DA=+CDR,DR=".02////"_$J(^TMP("ACKQCDR",$J,"ACKH",+CDR),0,9)
 .D ^DIE
 L -^ACK(509850.7,IFN)
 Q
CREATE ;
 N DIC,DINUM,CDR,DD,DO
 S DIC="^ACK(509850.7,",DIC(0)="L",DLAYGO=509850.7,ACKLAYGO="",X=ACKMO,DINUM=IFN D FILE^DICN
 Q
README ;Instructional Support (.12) Calculation:
 ;As per Dr. Kyle Dennis 5/13/96. First 2 digits of CDR#
 ;identify most CDR categories. 11-Medical, 12-Surgical,
 ;13-Psych, 14-NH, 15-Dom Care, 16-Inter. Care, 17-Psych Rehab.
 ;The CDR to be credited is: First 2 digits_"00.12"
 ;CDR range 2110 through 2780 is Outpatient Care 2800.12.
 ;If site uses 5100 HBHC, site must add 5100.12 to CDR file.
 ;If site uses 8024 DOD SHARE, site must add 8000.12 to CDR file.
 ;Ignore CATEGORY 11 and 12 from CDR file (#509850).
