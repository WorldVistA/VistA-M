SROAPM ;BIR/ADM - PATIENT DEMOGRAPHIC INFO ;05/28/10
 ;;3.0; Surgery ;**47,81,111,107,100,125,142,160,166,174**;24 Jun 93;Build 8
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START G:SRSOUT END D HDR^SROAUTL
 S DIR("A",1)="Enter/Edit Patient Demographic Information",DIR("A",2)=" ",DIR("A",3)="1. Capture Information from PIMS Records",DIR("A",4)="2. Enter, Edit, or Review Information",DIR("A",5)=" "
 S DIR("?",1)="Enter '1' if you want to capture patient movement information from PIMS",DIR("?",2)="records.  Enter '2' if you want to enter, edit, or review patient",DIR("?")="movement and other information on this screen."
 S DIR("A")="Select Number",DIR(0)="NO^1:2" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRSOUT=1 G END
 I Y=1 D PIMS G START
EDIT S SRR=0 D HDR^SROAUTL K DR S SRQ=0,(DR,SRDR)="413;452;453;454;418;419;420;421;247;.011"
 K DA,DIC,DIQ,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 K SRZ S SRZ=0 F M=1:1 S I=$P(SRDR,";",M)  Q:'I  D
 .D TR,GET
 .S SRZ=SRZ+1,Y=$P(X,";;",2),SRFLD=$P(Y,"^"),(Z,SRZ(SRZ))=$P(Y,"^",2)_"^"_SRFLD,SREXT=SRY(130,SRTN,SRFLD,"E")
 .W !,$S($L(SRZ)<2:" "_SRZ,1:SRZ)_". "_$P(Z,"^")_":" D EXT
 ;
 D DEM^VADPT
 ;Find patient's ethnicity and list it on the display
 W !,"11. Patient's Ethnicity:" S SRZ(11)="" D
 .I $G(VADM(11)) W ?40,$P(VADM(11,1),U,2)
 .I '$G(VADM(11)) W ?40,"UNANSWERED"
 ;
 ;Find all race entries and place into a string with commas inbetween
 S SRORC=0,C=1,SRORACE="",SROLINE="",N=1,SROL=""
 F  S SRORC=$O(VADM(12,SRORC)) Q:SRORC=""  Q:C=11  D
 .I $G(VADM(12,SRORC)) S SRORACE(C)=$P(VADM(12,SRORC),U,2)
 .I SROLINE'="" S SROLINE=SROLINE_", "_SRORACE(C)
 .I SROLINE="" S SROLINE=SRORACE(C)
 .S C=C+1
 ;
 ;Find total length of 'race' string and wrap the text if necessary
 I $L(SROLINE)=40!$L(SROLINE)<40 S SROL(N)=SROLINE,SRNUM1=2
 I $L(SROLINE)>40 D WRAP
 ;
 W !,"12. Patient's Race:" S SRZ(12)=""
 I $G(VADM(12)) F D=1:1:SRNUM1-1 D
 .W:D=1 ?40,SROL(D)
 .W:D'=1 !,?40,SROL(D)
 ;
 I '$G(VADM(12)) W ?40,"UNANSWERED"
 ;
 K DA,DIC,DIQ,DR,SRY S (DR,SRDR)=342,DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S SRZ=12 F M=1:1 S I=$P(SRDR,";",M)  Q:'I  D
 .D TR,GET
 .S SRZ=SRZ+1,Y=$P(X,";;",2),SRFLD=$P(Y,"^"),(Z,SRZ(SRZ))=$P(Y,"^",2)_"^"_SRFLD,SREXT=SRY(130,SRTN,SRFLD,"E")
 .W !,$S($L(SRZ)<2:" "_SRZ,1:SRZ)_". "_$P(Z,"^")_":" D EXT
 K SROL,SROLINE,SRORC,SRORACE,SROLN,SROLN1,SROWRAP,SRNUM1
 ;
 W !! F K=1:1:80 W "-"
 D SEL G:SRR=1 EDIT
 S SROERR=SRTN D ^SROERR0
 G START
 Q
 ;
WRAP ;Wrap multiple race entries so that wrapped line
 ;does not break in the middle of a word
 ;
 N SROLNGTH S SROLNGTH=$L(SROLINE),E=40,SROWRAP="",SROLN="",SROLN1="",SROL=""
 F I=1:40:SROLNGTH S SROLN(I)=SROWRAP_$E(SROLINE,I,E) D
 .F K=40:-1:1 I $E(SROLN(I),K)[" " D  Q    ;Break lines at space
 ..S SROLN1(I)=$E(SROLN(I),1,K-1)
 ..S SROWRAP=$E(SROLN(I),K+1,E)
 .S E=E+40
 ;
 S:'$D(SROLN1(I)) SROLN1(I)=SROLN(I),SROWRAP=""
 I $L(SROLN1(I))+$L(SROWRAP)>39 S SROLN1(I+1)=SROWRAP   ;Last line 
 I $L(SROLN1(I))+$L(SROWRAP)'>39 S SROLN1(I)=SROLN1(I)_" "_SROWRAP
 ;
 ;Renumber the SROLN1 array to be in numeric order
 S SRNUM=0,SRNUM1=1
 F  S SRNUM=$O(SROLN1(SRNUM)) Q:SRNUM=""  D
 .S SROL(SRNUM1)=SROLN1(SRNUM)
 .S SRNUM1=SRNUM1+1
 Q
 ;
EXT I $L(SREXT)<40 W ?40,SREXT W:SRFLD=247 $S(SREXT="":"",SREXT=1:" Day",SREXT=0:" Days",SREXT>1:" Days",1:"") Q
 N I,J,X,Y S X=SREXT F  D  W:$L(X) ! I $L(X)<40!(X'[" ") W ?40,X Q
 .F I=0:1:38 S J=39-I,Y=$E(X,J) I Y=" " W ?40,$E(X,1,J-1) S X=$E(X,J+1,$L(X)) Q
 Q
SEL W !!,"Select Patient Demographics Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I (X=11)!(X=12) S SRR=1 W !!,"The Patient's Race and Ethnicity information cannot be updated through the" D  Q
 .W !,"Surgery package options."
 .W !!,"Press RETURN to continue " R X:DTIME
 Q:X=""  S:X="a" X="A" I '$D(SRFLG),'$D(SRZ(X)),(X'?1.2N1":"1.2N),X'="A" D HELP S SRR=1 Q
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRZ)!(Y>Z) D HELP S SRR=1 Q
 I X="A" S X="1:"_SRZ
 I X?1.2N1":"1.2N D RANGE S SRR=1 Q
 I $D(SRZ(X)),+X=X S EMILY=X D  S SRR=1
 .I $$LOCK^SROUTL(SRTN) D ONE,UNLOCK^SROUTL(SRTN)
 Q
PIMS ; get update from PIMS records
 W ! K DIR S DIR("A")="Are you sure you want to retrieve information from PIMS records ? ",DIR("B")="YES",DIR(0)="YOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y Q
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .W ! D WAIT^DICD D ^SROAPIMS
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below.",!!,"NOTE: Items 11 and 12 cannot be updated through the surgery package options."
 W !!,"1. Enter 'A' to update items 1 through 10 and item 13.",!!,"2. Enter a number (1-"_SRZ_") to update an individual item.  (For example,",!,"   enter '1' to update "_$P(SRZ(1),"^")_")"
 W !!,"3. Enter a range of numbers (1-"_SRZ_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 I $D(SRFLG) W !,"4. Enter 'N' or 'NO' to enter negative response for all items.",!!,"5. Enter '@' to delete information from all items.",!
PRESS W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) D
 ..I SHEMP<13 F EMILY=SHEMP:1:10,13 Q:SRSOUT  D ONE
 ..I SHEMP=13 S EMILY=SHEMP Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 K DR,DA,DIE S DR=$P(SRZ(EMILY),"^",2)_"T",DA=SRTN,DIE=130,SRDT=$P(SRZ(EMILY),"^",3) S:SRDT DR=DR_";"_SRDT_"T" D ^DIE K DR,DA I $D(Y) S SRSOUT=1
 Q
TR S J=I,J=$TR(J,"1234567890.","ABCDEFGHIJP")
 Q
GET S X=$T(@J)
 Q
END W @IOF D ^SRSKILL
 Q
PJAA ;;.011^In/Out-Patient Status
BDG ;;247^Length of Postop Hospital Stay
CDB ;;342^Date of Death
DAC ;;413^Transfer Status
DAG ;;417^Patient's Race
DAH ;;418^Hospital Admission Date/Time
DAI ;;419^Hospital Discharge Date/Time
DBJ ;;420^Admit/Transfer to Surgical Svc.
DBA ;;421^Discharge/Transfer to Chronic Care
DEB ;;452^Observation Admission Date/Time
DEC ;;453^Observation Discharge Date/Time
DED ;;454^Observation Treating Specialty
