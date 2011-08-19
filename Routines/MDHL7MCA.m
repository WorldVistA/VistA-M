MDHL7MCA ; HOIFO/REL-Routine to Decode HL7 for MEDICINE ; [05-07-2001 10:38]
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ; Reference DBIA #10035 for DPT calls.
 ; Reference DBIA #10062 for VADPT calls.
 ; Reference DBIA #10106 for HL7 calls.
 ; Reference DBIA #10096 for ^%ZOSF calls.
EN ; Entry Point for Message Array in MSG
 N MSG
 K ERRTX
 S MDERROR=0
 ;F I=3:1 X HLNEXT Q:HLQUIT'>0  S MSG(I)=HLNODE,J=0 F  S J=$O(HLNODE(J)) Q:'J  S MSG(I,J)=HLNODE(J)
 M MSG=^TMP($J,"MDHL7A")
 S NUM=1
MSH ; Decode MSH
 K SEG
 I '$D(MSG(NUM)) G KIL
 S X=$G(MSG(NUM)),SEG("MSH")=X,MCAPP=""
 I $E(X,1,3)'="MSH" S ERRTX="MSH not first record" D ^MDHL7MCX G KIL
 S MCAPP=$P(MSG(NUM),"|",4) I MCAPP="" G KIL
 S NUM=NUM+1
PID ; Check PID
 S X=$G(MSG(NUM)) I $E(X,1,3)'="PID" S ERRTX="PID not second record" D ^MDHL7MCX G KIL
 S SEG("PID")=X
 S NAM=$P(X,"|",6),MDSSN=$P(X,"|",20) I $L(MDSSN)<9 S MDSSN=$P(X,"|",4)
 S MDSSN=$P(MDSSN,"^",1) I MDSSN'?9N S MDSSN=$TR(MDSSN,"- ","")
 S:MDSSN'?9N MDSSN=" " S DFN=$O(^DPT("SSN",MDSSN,0))
 I 'DFN S ERRTX="SSN not found" D ^MDHL7MCX G KIL
 S Z1=$P($G(^DPT(DFN,0)),",",1),Z2=$P(NAM,"^",1)
 S Z1=$TR(Z1,"abcdefghijklmnopqrstuvwxyz- '","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S Z2=$TR(Z2,"abcdefghijklmnopqrstuvwxyz- '","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I $E(Z1,1,3)'=$E(Z2,1,3) S ERRTX="Last Name MisMatch" D ^MDHL7MCX G KIL
 D PID^VADPT6 S PID=$G(VA("PID")),BID=$G(VA("BID")) K VA
 ; If DFN not a medical patient, add DFN to medical patient file
 I '$D(^MCAR(690,DFN)) S ^MCAR(690,DFN,0)=DFN,^MCAR(690,"B",DFN,DFN)="",$P(^MCAR(690,0),U,4)=$P(^MCAR(690,0),U,4)+1 S:$P(^MCAR(690,0),U,3)<DFN $P(^MCAR(690,0),U,3)=DFN
 S NUM=NUM+1
 ; Skip PV1, ORC if necessary
LPOBR I $E(MSG(NUM),1,3)'="OBR" S NUM=NUM+1 G LPOBR
 ;I $E(MSG(NUM),1,3)="ORC" S NUM=NUM+1
OBR ; Check OBR
 S X=$G(MSG(NUM)) I $E(X,1,3)'="OBR" S ERRTX="OBR not found when expected" D ^MDHL7MCX G KIL
 S SEG("OBR")=X
 S ORIFN=$P(X,"|",3),INST=$P(X,"|",25) I MCAPP="Instrument Manager",INST'="" S MCAPP=INST
 S ORIFN=$P(X,"|",3),(EXAM,%)=$P(X,"|",5) I EXAM'="" S EXAM=$P(%,"^",2),EXAM2=$P(%,"^",1) I EXAM="" S EXAM=EXAM2
 S CPT=$P(X,"|",5) I $P(CPT,"^",3)["CPT" S CPT=$P(CPT,"^",1)
 S DTO="",DATE=$P(X,"|",8) I DATE'="" S:$L(DATE)>14 DATE=$E(DATE,1,14) S DTO=$$FMDATE^HLFNC(DATE)
 I DTO="" S ERRTX="Missing required Date/Time of Procedure in OBR" D ^MDHL7MCX G KIL
 K SET S SET=DTO_"^"_DFN,NUM=NUM+1,ICNT=0 K IMP
 ; Go to Application
 S INST=$O(^MCAR(690.7,"B",MCAPP,0)) I 'INST S X=MCAPP,ERRTX="Invalid Application Code" D ^MDHL7MCX G KIL
 S MCRTN=$G(^MCAR(690.7,INST,1)) S:MCRTN'["^" MCRTN="^"_MCRTN
 ; test for existence
 S X=MCRTN S:X["^" X=$P(X,"^",2) X ^%ZOSF("TEST") I '$T S ERRTX="Processing routine not found" D ^MDHL7MCX G KIL
 D @MCRTN G KIL
PROC ; Create Procedure entry in appropriate file (FIL)
 I $P(SET,"^",1)=""!($P(SET,"^",2)="") Q
 S DA=0 F  S DA=$O(^MCAR(FIL,"B",$P(SET,"^",1),DA)) Q:'DA  I $P($G(^MCAR(FIL,DA,0)),"^",1,2)=SET Q
 Q:DA
P1 L +^MCAR(FIL,0):3 G:'$T P1 S DA=$P(^MCAR(FIL,0),"^",3)+1,$P(^MCAR(FIL,0),"^",3,4)=DA_"^"_DA L -^MCAR(FIL,0)
 I $D(^MCAR(FIL,DA)) G P1
 S ^MCAR(FIL,DA,0)=SET S DIK="^MCAR("_FIL_"," D IX1^DIK Q
KIL ; Kill Variables
 K %,BID,CODE,CPT,DA,DATE,DFN,DIK,DLCO,DTO,ERRTX,EXAM,EXAM2,EXE,FIL
 K I,ICNT,ID,IMP,J,K,LBL,LINE,LN,MCAPP,MCRTN,MG,MSG,N,NAM,NEXT,NUM
 K ORIFN,P,PID,PIEN,S,SEG,SEP,SET,MDSSN,STR,STYP,SUB,TCNT,TXT
 K UNITS,VA,VAL,X,XMBODY,XMDUZ,XMSUBJ,XMTO,Z1,Z2
 Q
