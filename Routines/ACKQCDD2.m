ACKQCDD2 ;AUG/JLTP BIR/PTD HCIOFO/AG-Generate A&SP Service CDR for Division - CONTINUED ; [05/15/96 9:30 ]
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
 S ^TMP("ACKQCDD",$J,"ACKH",+CDR)=Y,ACKRTH=ACKRTH-Y
 Q
PASS ;Enter hours for pass-through account.
 N DIC,DIR,X,Y,CDR
PASS2 S DIC="^ACK(509850,",DIC("A")="Select Pass-Through Account: "
 S DIC("S")="I $P(^(0),U,3)=""P""",DIC(0)="AEMQZ"
 D ^DIC K DIC
 I X?1"^"1.E W !,"Jumping not allowed.",! G PASS2
 I Y<0 S DIRUT=1 Q
 S CDR=+$P(Y,U,2),CDR(0)=$P(Y(0),U,2)
PASS3 I $D(^TMP("ACKQCDD",$J,"ACKH",CDR)) S DIR("B")=^TMP("ACKQCDD",$J,"ACKH",CDR)
 S DIR(0)="N^0:"_ACKRTH,DIR("A")="Enter Hours for "_CDR(0)
 S DIR("??")="^W !!,""Enter the number of hours to charge to "",CDR(0)"
 D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G PASS3
 Q:$D(DIRUT)
 S ^TMP("ACKQCDD",$J,"ACKH",CDR)=Y S:$D(DIR("B")) ACKRTH=ACKRTH+DIR("B") S ACKRTH=ACKRTH-Y
 Q
DISREM ;DISTRIBUTE REMAINING HOURS
 N I,X
 S I=0 F  S I=$O(ACKTCH(I)) Q:'I  D
 .S X=(ACKTCH(I)/ACKTCH)*ACKRTH,ACKTCH(I)=ACKTCH(I)+X
 Q
PERCENT ;CONVERT ALL VALUES TO %
 N I,X
 S ACKTP=0
 S I=0 F  S I=$O(^TMP("ACKQCDD",$J,"ACKH",I)) Q:'I  D
 . S X=^TMP("ACKQCDD",$J,"ACKH",I)/ACKTPH*100
 . S ^TMP("ACKQCDD",$J,"ACKH",I)=X,ACKTP=ACKTP+X
 S I=0 F  S I=$O(ACKTCH(I)) Q:'I  D
 . S ^TMP("ACKQCDD",$J,"ACKH",I)=ACKTCH(I)/ACKTPH*100
 . S ACKTP=ACKTP+^TMP("ACKQCDD",$J,"ACKH",I)
 K ACKTCH
 Q
 ;
CLINH ;Calculate number of clinic hours & student training 
 ;   (.12) by CDR series. See README at end.
 ;  requires ACKSD - start of date range
 ;           ACKED - end of date range
 ;           ACKDIV - selected division
 N ACKCDR,ACKD,I,ACKV,ACKMINS
 K ACKTCH,ACKTSH S (ACKTCH,ACKTSH)=0
 ;Loop through selected date range and get total minutes and total
 ; student minutes
 F ACKD=(ACKSD-.1):0 S ACKD=$O(^ACK(509850.6,"B",ACKD)) Q:'ACKD!(ACKD>(ACKED+.9))  D
 .S ACKV=0 F  S ACKV=$O(^ACK(509850.6,"B",ACKD,ACKV)) Q:'ACKV  D
 .. ; check division
 .. S ACKVDIV=$$GET1^DIQ(509850.6,ACKV_",",60,"I")
 .. I ACKVDIV'=ACKDIV Q
 ..;Get TIME SPENT and CDR#. Student present? YES, increment ACKTSH array; else increment ACKTCH array.
 ..S ACKMINS=+$P(^ACK(509850.6,ACKV,0),U,7)
 ..S ACK2=^ACK(509850.6,ACKV,2)
 ..S ACKCDR=+$P(ACK2,U,2),ACKCDRN=+$P($G(^ACK(509850,ACKCDR,0)),U,1)
 ..I $P(ACK2,U,4) D  ;student present
 ...S ACKTSH=ACKTSH+ACKMINS
 ...S ACKTSH($E(ACKCDRN,1,2))=$G(ACKTSH($E(ACKCDRN,1,2)))+ACKMINS
 ..I '$P(ACK2,U,4) D  ;student not present
 ...S ACKTCH=ACKTCH+ACKMINS
 ...S ACKTCH(ACKCDRN)=$G(ACKTCH(ACKCDRN))+ACKMINS
 ;
 ;Convert minutes to hours - total time (less student)
 S ACKTCH=ACKTCH/60
 S ACKCDRN=0 F  S ACKCDRN=$O(ACKTCH(ACKCDRN)) Q:'ACKCDRN  D
 . S ACKTCH(ACKCDRN)=ACKTCH(ACKCDRN)/60
 ;Convert minutes to hours - student time, and move into ^TMP
 S ACKTSH=ACKTSH/60
 S ACKCDRN=0 F  S ACKCDRN=$O(ACKTSH(ACKCDRN)) Q:'ACKCDRN  D
 . S ACKTSH(ACKCDRN)=ACKTSH(ACKCDRN)/60
 . I (ACKCDRN<21)!(ACKCDRN>27) D
 .. S ^TMP("ACKQCDD",$J,"ACKH",ACKCDRN_"00.12")=+ACKTSH(ACKCDRN)
 . I ACKCDRN'<21,ACKCDRN'>27 D
 .. S ^TMP("ACKQCDD",$J,"ACKH",2800.12)=+ACKTSH(ACKCDRN)
 Q
 ;
TPH ;Ask for Total Paid Hours.
 N DIR,X,Y
TPH2 K DTOUT,DUOUT,DIRUT,DIR
 S DIR(0)="N^1:9999",DIR("A")="Enter Total Paid Hours"
 S DIR("?")="Enter a number between 1 and 9999."
 S DIR("??")="^D TPH^ACKQCDD1"
 W ! D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G TPH2
 S ACKTPH=+Y
 Q
INDEX ;Build ^TMP arrays in category and CDR# order.
 N I,CAT,CDR
 S I=0 F  S I=$O(^ACK(509850,I)) Q:'I  D
 . S CDR=^ACK(509850,I,0),CAT=$P(CDR,U,4)
 . S ^TMP("ACKQCDD",$J,"ACKCAT",CAT,+CDR)=$P(CDR,U,1,2)
 . S:ACKSAV ^TMP("ACKQCDD",$J,"ACKNDX",+CDR)=$P(CDR,U)
 Q
SAVE ;
 N IFN,M
 S IFN=+$$SITE^VASITE_$E(ACKMO,1,5)
 ;
 ; if there is data for the selected month/division then ask to delete
 I $O(^ACK(509850.7,IFN,5,ACKDIV,4,0)) D  Q:$D(DIRUT)
 .K DIR,X,Y S DIR(0)="Y",DIR("A")="Delete existing CDR data and regenerate the CDR for "_ACKXRNG,DIR("B")="NO"
 .S DIR("?")="Enter YES to delete and regenerate the CDR, otherwise enter NO.",DIR("??")="^D REGEN^ACKQHLP1"
 .W ! D ^DIR K DIR S:Y=0 DIRUT=1 Q:$D(DIRUT)
 .D KILLOLD ;remove old data for this month and division
 ;
 ; now (re)create the file
 L +^ACK(509850.7,IFN)
 ; check the headers exist
 I '$D(^ACK(509850.7,IFN,0)) D CRE8HDR
 I '$D(^ACK(509850.7,IFN,5,ACKDIV,0)) D CRE8DIV
 ;
 ; file the CDR total paid hours
 S DIE="^ACK(509850.7,"_IFN_",5,",DA=ACKDIV,DA(1)=IFN,DR="5.05////"_ACKTPH D ^DIE K DIE,DA,DR
 ;
 ; update CDR percentages
 S CDR=0 F  S CDR=$O(^TMP("ACKQCDD",$J,"ACKH",CDR)) Q:'CDR  I ^TMP("ACKQCDD",$J,"ACKH",CDR) D
 .S DIC="^ACK(509850.7,"_IFN_",5,"_ACKDIV_",4,",DIC(0)="L"
 .S DLAYGO=509850.75,X=$P(^TMP("ACKQCDD",$J,"ACKNDX",CDR),U),DINUM=+X
 .S DIC("P")=$P(^DD(509850.75,5.8,0),U,2),DA(2)=IFN,DA(1)=ACKDIV
 .K DD,DO D FILE^DICN K DA
 .S DIE="^ACK(509850.7,"_IFN_",5,"_ACKDIV_",4,"
 .S DA=+CDR,DA(1)=ACKDIV,DA(2)=IFN
 .S DR="54.02////"_$J(^TMP("ACKQCDD",$J,"ACKH",+CDR),0,9)
 .D ^DIE
 ;
 ; end
 L -^ACK(509850.7,IFN)
 Q
KILLOLD ;kill existing CDR data for the selected month and division
 S DIK="^ACK(509850.7,"_IFN_",5,"_ACKDIV_",4,",DA(2)=IFN,DA(1)=ACKDIV
 ; loop for each CDR and kill
 S SUB=0
 F  S SUB=$O(^ACK(509850.7,IFN,5,ACKDIV,4,SUB)) Q:'SUB  S DA=SUB D ^DIK
 ; remove the CDR total paid hours field
 S DIE="^ACK(509850.7,"_IFN_",5,",DA=ACKDIV,DA(1)=IFN
 S DR="5.02///"_"@" D ^DIE K DIE,DA,DR
 ; if there is no workload for the division for the month then empty the file completely
 I '$O(^ACK(509850.7,IFN,5,ACKDIV,1,0)) D
 . S DIK="^ACK(509850.7,"_IFN_",5,",DA=ACKDIV,DA(1)=IFN D ^DIK
 ; end
 Q
CRE8HDR ; create a header record for the month
 N DIC,DINUM,CDR,DD,DO
 S DIC="^ACK(509850.7,",DIC(0)="L",DLAYGO=509850.7
 S ACKLAYGO="",X=ACKMO,DINUM=IFN D FILE^DICN
 Q
CRE8DIV ; create a header record for the division
 N DIC,DINUM,CDR,DD,DO
 S DIC="^ACK(509850.7,"_IFN_",5,",DIC(0)="L",DLAYGO=509850.75
 S DIC("P")=$P(^DD(509850.7,5,0),U,2)
 S ACKLAYGO="",X=ACKDIV,DINUM=ACKDIV,DA=ACKDIV,DA(1)=IFN D FILE^DICN
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
