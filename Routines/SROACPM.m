SROACPM ;BIR/ADM - CARDIAC RESOURCE INFO ;12/04/07
 ;;3.0; Surgery ;**71,93,95,99,100,125,142,160,164,166,174**;24 Jun 93;Build 8
 ;
 ; Reference to ^DGPM("APTT1" supported by DBIA #565
 ;
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START G:SRSOUT END D HDR^SROAUTL
 S DIR("A",1)="Enter/Edit Patient Resource Data",DIR("A",2)=" ",DIR("A",3)="1. Capture Information from PIMS Records",DIR("A",4)="2. Enter, Edit, or Review Information",DIR("A",5)=" "
 S DIR("?",1)="Enter '1' if you want to capture patient information from PIMS",DIR("?",2)="records.  Enter '2' if you want to enter, edit, or review patient",DIR("?")="other information on this screen."
 S DIR("A")="Select Number",DIR(0)="NO^1:2" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRSOUT=1 G END
 I Y=1 D PIMS G START
EDIT N DAYS,HOURS,MINS
 S:$P(^SRF(SRTN,206),"^",41)="" $P(^SRF(SRTN,206),"^",41)="N"
 S SRR=0 S SRPAGE="PAGE: 1" D HDR^SROAUTL K DR S SRQ=0,(DR,SRDR)="418;419;440;.205;.22;.23;.232;470;471;473;472;431;442"
 K DA,DIC,DIQ,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="IE",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 K SRZ S SRZ=0 F M=1:1 S I=$P(SRDR,";",M)  Q:'I  D
 .D TR,GET
 .S SRZ=SRZ+1,Y=$P(X,";;",2),SRFLD=$P(Y,"^"),(Z,SRZ(SRZ))=$P(Y,"^",2)_"^"_SRFLD,SREXT=SRY(130,SRTN,SRFLD,"E")
 .W:M>1 ! W $J(SRZ,2)_". "_$P(Z,"^")_": " D EXT
 D CHCK W ! F K=1:1:80 W "-"
 D SEL G:SRR=1 EDIT
 G START
 Q
CHCK ; compare admission and discharge dates to each other
 N SRADM,SRDIS,SROUT,SRDICU,SREXT
 S SROUT=SRY(130,SRTN,.232,"I"),SRDICU=SRY(130,SRTN,471,"I"),SREXT=SRY(130,SRTN,470,"I")
 S SRADM=SRY(130,SRTN,418,"I"),SRDIS=SRY(130,SRTN,419,"I") W !
 I SRADM,SRDIS,SRADM'<SRDIS W !,"*** NOTE: Discharge Date precedes Admission Date!!  Please check. ***"
 I SREXT,SROUT,SREXT'>SROUT W !,"*** NOTE: D/Time Pt Extubated should be later than the D/Time Pt Out of OR. ***"
 I SREXT,SRDICU,SREXT'<SRDICU W !,"*** NOTE: D/Time Pt Extubated should be < the ICU Discharge D/Time. ***"
 I SRDICU,SREXT,SRDICU'>SREXT W !,"*** NOTE: D/Time Discharged from ICU should be > the Extubation D/Time. ***"
 I SRDICU,SRDIS,SRDICU>SRDIS W !,"*** NOTE: D/Time Discharged from ICU should be <= the Hospital Discharge D/Time*"
 Q
EXT I SRFLD=440&(SREXT="NS") S SREXT=SREXT_"-"_$S(SREXT="NS":"No Study",1:SREXT)
 I SRFLD=470,(SREXT="NS"!(SREXT="RI")) S SREXT=SREXT_"-"_$S(SREXT="NS":"Unable to determine",SREXT="RI":"Remains intubated at 30 days",1:SREXT)
 I SRFLD=470,$G(SRY(130,SRTN,470,"I")) D  Q
 .S X=$$FMDIFF^XLFDT(SRY(130,SRTN,470,"I"),SRY(130,SRTN,.232,"I"),2) W ?39,SREXT,!,?10,"Postop Intubation Hrs: "_$FN((X/3600),"+",1)
 I SRFLD=471,(SREXT="NS"!(SREXT="RI")) S SREXT=SREXT_"-"_$S(SREXT="NS":"Unable to determine",SREXT="RI":"Remains in ICU at 30 days",1:SREXT)
 I $L(SREXT)<41 W ?39,SREXT W:SRFLD=247 $S(SREXT="":"",SREXT=1:" Day",SREXT=0:" Days",SREXT>1:" Days",1:"") Q
 I SRFLD=431 D
 .I $L(SREXT)<52 W ?28,SREXT Q 
 .N I,J,X,Y S X=SREXT F  D  W:$L(X) ! I $L(X)<52!($L(X)>51&(X'[" ")) W ?28,X Q
 ..F I=0:1:50 S J=51-I,Y=$E(X,J) I Y=" " W ?28,$E(X,1,J-1) S X=$E(X,J+1,$L(X)) Q
 Q
SEL S SRSOUT=0 W !!,"Select Resource Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q:X=""  S:X="a" X="A" I '$D(SRFLG),'$D(SRZ(X)),(X'?1.2N1":"1.2N),X'="A" D HELP S SRR=1 Q
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRZ)!(Y>Z) D HELP S SRR=1 Q
 I X="A" S X="1:"_SRZ
 I X?1.2N1":"1.2N D RANGE S SRR=1 Q
 I $D(SRZ(X)),+X=X S EMILY=X D  S SRR=1
 .I $$LOCK^SROUTL(SRTN) D ONE,UNLOCK^SROUTL(SRTN)
 Q
PIMS ; get update from PIMS records
 W ! K DIR S DIR("A")="Are you sure you want to retrieve information from PIMS records ? ",DIR("B")="YES",DIR(0)="YOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y Q
 W ! D WAIT^DICD D ^SROAPIMS
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRZ_") to update an individual item.  (For example,",!,"   enter '1' to update "_$P(SRZ(1),"^")_".)"
 W !!,"3. Enter a range of numbers (1-"_SRZ_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 I $D(SRFLG) W !,"4. Enter 'N' or 'NO' to enter negative response for all items.",!!,"5. Enter '@' to delete information from all items.",!
PRESS W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 I EMILY=9 D LIST
 I EMILY'=9 K DR,DA,DIE S DR=$P(SRZ(EMILY),"^",2)_"T",DA=SRTN,DIE=130,SRDT=$P(SRZ(EMILY),"^",3) S:SRDT DR=DR_";"_SRDT_"T" D ^DIE K DR,DA I $D(Y) S SRSOUT=1
 I 'SRSOUT,EMILY=1!(EMILY=2) D OK
 Q
OK ; compare admission date to discharge date
 N SRADM,SRDIS S X=$G(^SRF(SRTN,208)),SRADM=$P(X,"^",14),SRDIS=$P(X,"^",15)
 I SRADM,SRDIS,SRADM'<SRDIS W !!,"  ***  NOTE: Discharge Date precedes Admission Date!!  Please check.  ***",! D PRESS W !
 Q
LIST ; display list of patient movements
 N CNT,SRADM,SRLOC,SRMOVE,SRMVMT,SRN,SRT,SRTYPE,SRZ,SRY
 S DFN=$P(^SRF(SRTN,0),"^"),SRZ=$P($G(^SRF(SRTN,.2)),"^",12)
 S SRADM=0 D ADM
 S CNT=0 F  Q:'SRZ  D:SRZ MVMT
 ;Q:CNT=0
 W !!,?5,"To identify the date and time the patient was discharged from intensive",!,?5,"care following surgery, see the following list of patient movements"
 W !,?5,"that occurred during the inpatient stay associated with this surgery.",!
 S (CNT,SRN)=0 F  S CNT=$O(SRMVMT(CNT)) Q:'CNT  S X=SRMVMT(CNT),SRT=$P(X,"^",2),SRN=SRN+1 W !,$J(SRN,3)_".",?5,$P($P(X,"^"),":",1,2),?25,$P(X,"^",3),?37,$S(SRT=3:"From",1:"To")_": "_$P(X,"^",4)
 I '$O(SRMVMT(0)) W !,?5,">> No postoperative patient movements were found for this patient."
 W ! E  K DIR S DIR("A")="Select patient movement from list",DIR(0)="NO^1:"_SRN_":0" D ^DIR K DIR I Y D  Q
 .S SRT=$P($P(SRMVMT(Y),"^"),":",1,2) K DA,DIE,DR S DA=SRTN,DIE=130,DR="471///"_SRT D ^DIE K DA,DIE,DR
 K DA,DIE,DR S DA=SRTN,DIE=130,DR="471T" D ^DIE K DA,DIE,DR
 Q
MVMT S VAIP("D")=SRZ D IN5^VADPT S SRY=$P(VAIP(3),"^")
 I SRY S CNT=CNT+1 D
 .S SRMOVE=$P(VAIP(3),"^",2),SRTYPE=$P(VAIP(2),"^",1,2),SRLOC=$P(VAIP(5),"^",2)
 .S SRMVMT(CNT)=SRMOVE_"^"_SRTYPE_"^"_SRLOC
 I 'SRY S SRZ="" Q
 I VAIP(1)=VAIP(17) S SRZ="" Q
 I VAIP(16),VAIP(16)=VAIP(17) S CNT=CNT+1,SRMOVE=$P(VAIP(16,1),"^",2),SRTYPE=$P(VAIP(16,2),"^",1,2),SRLOC=$P(VAIP(16,4),"^",2),SRMVMT(CNT)=SRMOVE_"^"_SRTYPE_"^"_SRLOC,SRZ="" Q
 S SRZ=$P(VAIP(16,1),"^")
 Q
ADM N SR24 S VAIP("D")=SRZ D IN5^VADPT
 I 'VAIP(13) S X1=SRZ,X2=1 D C^%DTC S SR24=X,SRDT=$O(^DGPM("APTT1",DFN,SRZ)) Q:'SRDT!(SRDT>SR24)  S VAIP("D")=SRDT D IN5^VADPT I 'VAIP(13) S SRZ="" Q
 I VAIP(13) S SRZ=$P(VAIP(13,1),"^")+.000001
 Q
TR S J=I,J=$TR(J,"1234567890.","ABCDEFGHIJP")
 Q
GET S X=$T(@J)
 Q
END W @IOF D ^SRSKILL
 Q
DAH ;;418^Hospital Admission Date
DAI ;;419^Hospital Discharge Date
DDJ ;;440^Cardiac Catheterization Date
PBJE ;;.205^Time Patient In OR
PBB ;;.22^Date/Time Operation Began
PBC ;;.23^Date/Time Operation Ended
PBCB ;;.232^Time Patient Out OR
DGJ ;;470^Date/Time Patient Extubated
DGA ;;471^Date/Time Discharged from ICU
DDB ;;442^Employment Status Preoperatively
DCA ;;431^Resource Data Comments
DGC ;;473^Homeless
DGB ;;472^Surg Performed at Non-VA Facility
