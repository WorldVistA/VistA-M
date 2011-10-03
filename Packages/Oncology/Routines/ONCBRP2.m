ONCBRP2 ;HINES CIOFO/GWB - 1998 Breast Cancer Study - Table II ;6/1/98
 ;;2.11;ONCOLOGY;**18,25**;Mar 07, 1995
 K TABLE,HTABLE
 S TABLE("16. CLASS OF CASE")="COC"
 S TABLE("17. DIAGNOSTIC EVALUATION")="DE"
 S TABLE("18. (F) TYPE OF MAMMOGRAM")="TM"
 S TABLE("19. (F) PRESENTATION OF MOST DEFINITIVE MAMMOGRAM")="PMDM"
 S TABLE("20. DATE OF INITIAL DIAGNOSIS")="DID"
 S TABLE("21. DATE OF PATHOLOGIC DIAGNOSIS")="DPD"
 S TABLE("22. PRIMARY SITE (ICD-O-2)")="PS"
 S TABLE("23. HISTOLOGY (ICD-O-2)")="HIST"
 S TABLE("24. BEHAVIOR CODE(ICD-O-2)")="BC"
 S TABLE("25. IF INVASIVE DUCTAL CARCINOMA REPORTED, IS DCIS ALSO PRESENT")="IDCR"
 S TABLE("26. GRADE")="GRADE"
 S TABLE("27. ARCHITECTURE PATTERN IF DCIS IS PRESENT")="APIDIP"
 S TABLE("28. NUCLEAR GRADE IF DCIS IS PRESENT")="NGIDIP"
 S TABLE("29. DIAGNOSTIC CONFIRMATION")="DC"
 S TABLE("30. (M) LEVEL OF INVOLVEMENT")="LI"
 S TABLE("31. BIOPSY PROCEDURE")="BP"
 S TABLE("32. GUIDANCE")="G"
 S TABLE("33. PALPABILITY OF PRIMARY")="PP"
 S TABLE("34. FIRST DETECTED BY")="FDB"
 S HTABLE(1)="16. CLASS OF CASE"
 S HTABLE(2)="17. DIAGNOSTIC EVALUATION"
 S HTABLE(3)="18. (F) TYPE OF MAMMOGRAM"
 S HTABLE(4)="19. (F) PRESENTATION OF MOST DEFINITIVE MAMMOGRAM"
 S HTABLE(5)="20. DATE OF INITIAL DIAGNOSIS"
 S HTABLE(6)="21. DATE OF PATHOLOGIC DIAGNOSIS"
 S HTABLE(7)="22. PRIMARY SITE (ICD-O-2)"
 S HTABLE(8)="23. HISTOLOGY (ICD-O-2)"
 S HTABLE(9)="24. BEHAVIOR CODE (ICD-O-2)"
 S HTABLE(10)="25. IF INVASIVE DUCTAL CARCINOMA REPORTED, IS DCIS ALSO PRESENT"
 S HTABLE(11)="26. GRADE"
 S HTABLE(12)="27. ARCHITECTURE PATTERN IF DCIS IS PRESENT"
 S HTABLE(13)="28. NUCLEAR GRADE IF DCIS IS PRESENT"
 S HTABLE(14)="29. DIAGNOSTIC CONFIRMATION"
 S HTABLE(15)="30. (M) LEVEL OF INVOLVEMENT"
 S HTABLE(16)="31. BIOPSY PROCEDURE"
 S HTABLE(17)="32. GUIDANCE"
 S HTABLE(18)="33. PALPABILITY OF PRIMARY"
 S HTABLE(19)="34. FIRST DETECTED BY"
 S CHOICES=19
 K DIQ S DIC="^ONCO(165.5,",DR=".04;20.1;22;26",DA=ONCONUM,DIQ="ONC"
 S DIQ(0)="IE" D EN^DIQ1
 S DIE="^ONCO(165.5,",DA=ONCONUM
 W @IOF D HEAD^ONCBRP0
 W !," TABLE II - INITIAL DIAGNOSIS"
 W !," ----------------------------"
COC W !," 16. CLASS OF CASE.................: ",ONC(165.5,ONCONUM,.04,"E")
DE W !!," 17. DIAGNOSTIC EVALUATION:",!
 I $$GET1^DIQ(160,ONCOPA,10,"I")=2 D  G U
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,27)=""
 .W !,"     MAMMOGRAM (M).................: (Data Item for Males Only)"
 S DR="926     MAMMOGRAM (M)................." D ^DIE G:$D(Y) JUMP
U S DR="927     ULTRASOUND (M)(F)............." D ^DIE G:$D(Y) JUMP
 W !
TM W !," 18. (F) TYPE OF MAMMOGRAM:",!
 I $$GET1^DIQ(160,ONCOPA,10,"I")=1 D  W ! G PMDM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,19)=""
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,20)=""
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,21)=""
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,22)=""
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,23)=""
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,24)=""
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,25)=""
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,26)=""
 .W !,"  A. MAMMOGRAM GIVEN, TYPE UNKNOWN.: (Data Item for Females Only)"
 .W !,"     DATE..........................:"
 .W !,"  B. SCREENING MAMMOGRAM...........: (Data Item for Females Only)"
 .W !,"     DATE..........................:"
 .W !,"  C. DIAGNOSTIC MAMMOGRAM..........: (Data Item for Females Only)"
 .W !,"     DATE..........................:"
 .W !,"  D. MAGNIFICATION MAMMOGRAM.......: (Data Item for Females Only)"
 .W !,"     DATE..........................:"
 S DR="918  A. MAMMOGRAM GIVEN, TYPE UNKNOWN." D ^DIE G:$D(Y) JUMP
 I $G(X)="" D  G SM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,20)=""
 .W !,"     DATE..........................:"
 I $G(X)=0 D  G SM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,20)="0000000"
 .W !,"     DATE..........................: 00/00/0000"
 I $G(X)=9 D  G SM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,20)=9999999
 .W !,"     DATE..........................: 99/99/9999"
 S DR="919     DATE.........................." D ^DIE G:$D(Y) JUMP
SM S DR="920  B. SCREENING MAMMOGRAM..........." D ^DIE G:$D(Y) JUMP
 I $G(X)="" D  G DM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,22)=""
 .W !,"     DATE..........................:"
 I $G(X)=0 D  G DM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,22)="0000000"
 .W !,"     DATE..........................: 00/00/0000"
 I $G(X)=9 D  G DM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,22)=9999999
 .W !,"     DATE..........................: 99/99/9999"
 S DR="921     DATE.........................." D ^DIE G:$D(Y) JUMP
DM S DR="922  C. DIAGNOSTIC MAMMOGRAM.........." D ^DIE G:$D(Y) JUMP
 I $G(X)="" D  G MM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,24)=""
 .W !,"     DATE..........................:"
 I $G(X)=0 D  G MM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,24)="0000000"
 .W !,"     DATE..........................: 00/00/0000"
 I $G(X)=9 D  G MM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,24)=9999999
 .W !,"     DATE..........................: 99/99/9999"
 S DR="923     DATE.........................." D ^DIE G:$D(Y) JUMP
MM S DR="924  D. MAGNIFICATION MAMMOGRAM......." D ^DIE G:$D(Y) JUMP
 I $G(X)="" D  W ! G PMDM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,26)=""
 .W !,"     DATE..........................:"
 I $G(X)=0 D  W ! G PMDM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,26)="0000000"
 .W !,"     DATE..........................: 00/00/0000"
 I $G(X)=9 D  W ! G PMDM
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,26)=9999999
 .W !,"     DATE..........................: 99/99/9999"
 S DR="925     DATE.........................." D ^DIE G:$D(Y) JUMP
 W !
PMDM I $$GET1^DIQ(160,ONCOPA,10,"I")=1 D  W ! G DID
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,29)=""
 .W !," 19. (F) PRESENTATION OF MOST"
 .W !,"     DEFINITIVE MAMMOGRAM..........: (Data Item for Females Only)"
 S DR="928 19. (F) PRESENTATION OF MOST                                                        DEFINITIVE MAMMOGRAM.........." D ^DIE G:$D(Y) JUMP
DID S DID=$E(DATEDX,4,5)_"/"_$E(DATEDX,6,7)_"/"_(1700+$E(DATEDX,1,3))
 W !," 20. DATE OF INITIAL DIAGNOSIS.....: ",DID
DPD S DR="929 21. DATE OF PATHOLOGIC DIAGNOSIS.." D ^DIE G:$D(Y) JUMP
PS W !," 22. PRIMARY SITE (ICD-O-2)........: ",ONC(165.5,ONCONUM,20.1,"E")
HIST W !," 23. HISTOLOGY (ICD-O-2)...........: ",$E(ONC(165.5,ONCONUM,22,"I"),1,4)
BC W !," 24. BEHAVIOR CODE (ICD-O-2).......: ",$E(ONC(165.5,ONCONUM,22,"I"),5)
IDCR I IDC=0 D  G GRADE
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,31)=8
 .W !," 25. IF INVASIVE DUCTAL CARCINOMA"
 .W !,"     REPORTED, IS DCIS ALSO PRESENT: NA, reported tumor not invasive DC"
 S DR="930 25. IF INVASIVE DUCTAL CARCINOMA                                                    REPORTED, IS DCIS ALSO PRESENT" D ^DIE G:$D(Y) JUMP
GRADE S DR="24 26. GRADE........................." D ^DIE G:$D(Y) JUMP
APIDIP S DR="931 27. ARCHITECTURE PATTERN IF DCIS                                                    IS PRESENT...................." D ^DIE G:$D(Y) JUMP
NGIDIP S DR="932 28. NUCLEAR GRADE IF DCIS IS                                                        PRESENT......................." D ^DIE G:$D(Y) JUMP
DC W !," 26. DIAGNOSTIC CONFIRMATION.......: ",ONC(165.5,ONCONUM,26,"E")
LI W !!," 30. (M) LEVEL OF INVOLVEMENT:",!
 I $$GET1^DIQ(160,ONCOPA,10,"I")=2 D  W ! G BP
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,34)=""
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,35)=""
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,36)=""
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,37)=""
 .W !,"     SKIN..........................: (Data Item for Males Only)"
 .W !,"     CHEST WALL....................: (Data Item for Males Only)"
 .W !,"     PECTORAL MUSCLES..............: (Data Item for Males Only)"
 .W !,"     DERMAL/LYMPHATIC..............: (Data Item for Males Only)"
 S DR="933     SKIN.........................." D ^DIE G:$D(Y) JUMP
 S DR="934     CHEST WALL...................." D ^DIE G:$D(Y) JUMP
 S DR="935     PECTORAL MUSCLES.............." D ^DIE G:$D(Y) JUMP
 S DR="936     DERMAL/LYMPHATIC.............." D ^DIE G:$D(Y) JUMP
 W !
BP W !," DIAGNOSTIC AND STAGING PROCEDURES",!
 S DR="141 31. BIOSPY PROCEDURE.............." D ^DIE G:$D(Y) JUMP
 I $G(X)=1 D  G PP
 .S $P(^ONCO(165.5,ONCONUM,2.1),U,15)=1
 .W !," 32. GUIDANCE......................: Not guided, no biopsy"
 I $G(X)=6 D  G PP
 .S $P(^ONCO(165.5,ONCONUM,2.1),U,15)=9
 .W !," 32. GUIDANCE......................: Unknown/death cert only"
GOBTP S DR="142 32. GUIDANCE......................" D ^DIE G:$D(Y) JUMP
PP S DR="143 33. PALPABILITY OF PRIMARY........" D ^DIE G:$D(Y) JUMP
FDB S DR="144 34. FIRST DETECTED BY............." D ^DIE G:$D(Y) JUMP
PRTC W ! K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
 G EXIT
JUMP ;Jump to prompts
 S XX="" R !!," GO TO ITEM NUMBER: ",X:DTIME I (X="")!(X[U) S OUT="Y" G EXIT
 I X["?" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 I '$D(TABLE(X)) S:X?1.2N X=X_"." S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 S X=TABLE(X)
 G @X
EXIT K CHOICES,HTABLE,TABLE
 K DID,NCDS,CDS,PP,LP,GS,PIECE
 K DA,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,XX,Y
 Q
