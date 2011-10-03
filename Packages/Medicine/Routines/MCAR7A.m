MCAR7A ; HIRMFO/REL-Main Routine to Decode HL7 ;5/26/00  09:43
 ;;2.3;Medicine;**24**;09/13/1996
EN ; Entry Point for Message Array in MSG
 ; Reference DBIA #10035 for DPT calls.
 K MSG,ERRTX
 F I=1:1 X HLNEXT Q:HLQUIT'>0  S MSG(I)=HLNODE,J=0 F  S J=$O(HLNODE(J)) Q:'J  S MSG(I,J)=HLNODE(J)
 S NUM=1
MSH ; Decode MSH
 K SEG
 I '$D(MSG(NUM)) G KIL
 S X=$G(MSG(NUM)),SEG("MSH")=X,MCAPP=""
 I $E(X,1,3)'="MSH" S ERRTX="MSH not first record" D ^MCAR7X G KIL
 S MCAPP=$P(MSG(NUM),"|",4) I MCAPP="" G KIL
 S NUM=NUM+1
PID ; Check PID
 S X=$G(MSG(NUM)) I $E(X,1,3)'="PID" S ERRTX="PID not second record" D ^MCAR7X G KIL
 S SEG("PID")=X
 S NAM=$P(X,"|",6),SSN=$P(X,"|",20) I $L(SSN)<9 S SSN=$P(X,"|",4)
 S SSN=$P(SSN,"^",1) I SSN'?9N S SSN=$TR(SSN,"- ","")
 S:SSN'?9N SSN=" " S DFN=$O(^DPT("SSN",SSN,0))
 I 'DFN S ERRTX="SSN not found" D ^MCAR7X G KIL
 S Z1=$P($G(^DPT(DFN,0)),",",1),Z2=$P(NAM,"^",1)
 S Z1=$TR(Z1,"abcdefghijklmnopqrstuvwxyz- '","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S Z2=$TR(Z2,"abcdefghijklmnopqrstuvwxyz- '","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I $E(Z1,1,3)'=$E(Z2,1,3) S ERRTX="Last Name MisMatch" D ^MCAR7X G KIL
 D PID^VADPT6 S PID=$G(VA("PID")),BID=$G(VA("BID")) K VA
 ; If DFN not a medical patient, add DFN to medical patient file
 I '$D(^MCAR(690,DFN)) S ^MCAR(690,DFN,0)=DFN,^MCAR(690,"B",DFN,DFN)="",$P(^MCAR(690,0),U,4)=$P(^MCAR(690,0),U,4)+1 S:$P(^MCAR(690,0),U,3)<DFN $P(^MCAR(690,0),U,3)=DFN
 S NUM=NUM+1
 ; Skip PV1, ORC if necessary
 I $E(MSG(NUM),1,3)="PV1" S NUM=NUM+1
 I $E(MSG(NUM),1,3)="ORC" S NUM=NUM+1
OBR ; Check OBR
 S X=$G(MSG(NUM)) I $E(X,1,3)'="OBR" S ERRTX="OBR not found when expected" D ^MCAR7X G KIL
 S SEG("OBR")=X
 S ORIFN=$P(X,"|",3),INST=$P(X,"|",25) I MCAPP="Instrument Manager",INST'="" S MCAPP=INST
 S ORIFN=$P(X,"|",3),(EXAM,%)=$P(X,"|",5) I EXAM'="" S EXAM=$P(%,"^",2),EXAM2=$P(%,"^",1) I EXAM="" S EXAM=EXAM2
 S CPT=$P(X,"|",5) I $P(CPT,"^",3)["CPT" S CPT=$P(CPT,"^",1)
 S DTO="",DATE=$P(X,"|",8) I DATE'="" S DTO=$$FMDATE^HLFNC(DATE)
 I DTO="" S ERRTX="Missing required Date/Time of Procedure in OBR" D ^MCAR7X G KIL
 K SET S SET=DTO_"^"_DFN,NUM=NUM+1,ICNT=0 K IMP
 ; Go to Application
 S INST=$O(^MCAR(690.7,"B",MCAPP,0)) I 'INST S X=MCAPP,ERRTX="Invalid Application Code" D ^MCAR7X G KIL
 S MCRTN=$G(^MCAR(690.7,INST,1)) S:MCRTN'["^" MCRTN="^"_MCRTN
 ; test for existence
 S X=MCRTN S:X["^" X=$P(X,"^",2) X ^%ZOSF("TEST") I '$T S ERRTX="Processing routine not found" D ^MCAR7X G KIL
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
 K ORIFN,P,PID,PIEN,S,SEG,SEP,SET,SSN,STR,STYP,SUB,TCNT,TXT
 K UNITS,VA,VAL,X,XMBODY,XMDUZ,XMSUBJ,XMTO,Z1,Z2 Q
