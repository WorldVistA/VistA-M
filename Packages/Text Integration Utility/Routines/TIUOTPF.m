TIUOTPF ;BIR/CGN - OTP load HL7 dispense data into file #101.22 ; Oct 2, 2024@09:39:00
 ;;1.0;TEXT INTEGRATION UTILITIES;**360**;Jun 20, 1997;Build 14
 ;
 ; Reference to ^DPT in ICR# 10035
 ; Reference to ^HL(771 in ICR# 10136
 ; Reference to ^HL(772 in ICR# 4069
 ; Reference to ^ORD(101 in ICR# 872
 ;
 ; Reference to %DT in ICR# 10003
 ; Reference to UPDATE^DIE in ICR# 2053
 ; Reference to $$FIND1^DIC in ICR# 2051
 ; Reference to $$GET1^DIQ in ICR# 2056
 ; Reference to ^XLFDT in ICR# 10103
 ; Reference to EN^ORDOTP1 in ICR# 7500
 ;
PARSE(PTR) ;
 ; Extract HL7 dispense data and prepare to load those values into file #101.22
 ; Called from a protocol (EXIT ACTION)
 N COUNT,DATA,DFN,DTE,EVENT,F,FLD,I,INIT,L,NAME,P,SENDER,SETARRAY,SN,SQ,STR,TMP,VAL,X,XTMP,Y
 ;GET DATA
 I $$GET1^DIQ(772,PTR_",",.01)="" Q  ;No Data Found
 M TMP=^HL(772,PTR,"IN")
 S DATA=$P($G(^HL(772,PTR,0)),"^",10),SENDER=$P($G(^ORD(101,DATA,770)),"^",1)
 I SENDER'="" S SENDER=$P($G(^HL(771,SENDER,0)),"^",1)
 I SENDER="" S SENDER="OTP INTERFACE"
 S DTE=$P($G(^HL(772,PTR,0)),"^",1),COUNT="",SETARRAY=1,SQ=0
 F  S SQ=$O(TMP(SQ)) Q:SQ=""  D
 . S DATA=TMP(SQ,0)
 . I DATA="" S SETARRAY=1 Q
 . I DATA'="" D
 . . I $P(DATA,"|",1)="EVN" S EVENT=$P(DATA,"|",2)
 . . I SETARRAY S COUNT=COUNT+1,XTMP(COUNT)=DATA,SETARRAY=0
 . . E  S XTMP(COUNT)=XTMP(COUNT)_DATA
 S STR="" K %DT
 I $G(EVENT)="" Q
 I $G(EVENT)="T02" D
 . S FLD(.01)="Medication Date = ",FLD(2)="Medication Type = ",FLD(3)="Dispense Date = ",FLD(3.3)="Dispense Time = "
 . S FLD(4)="Dispensed By = ",FLD(6)="Pickup Type = ",FLD(7)="Dispense Amount = "
 . S SQ="" F  S SQ=$O(XTMP(SQ)) Q:SQ=""  D
 . . S DATA=XTMP(SQ) D
 . . . I $P(DATA,"|",1)="PID" S SN=$P($P(DATA,"|",4),"^",1),DFN=$$FIND1^DIC(2,"","X",SN,"SSN")
 . . . I $P(DATA,"|",1)="OBX" D
 . . . . F I=2,3,4,6,7 S P=FLD(I) S VAL=$P(DATA,P,2),VAL=$P(VAL,"~",1),VAL=$P(VAL,"|",1),$P(STR,"^",I)=VAL
 . . . . S VAL=$P(DATA,FLD(3.3),2),VAL=$P(VAL,"~",1),VAL=$P(VAL,":",1,2),X=$P(STR,"^",3)_"@"_VAL,%DT="T" D ^%DT S $P(STR,"^",3)=Y
 . . . . S VAL=$P(DATA,FLD(.01),2),VAL=$P(VAL,"~",1),X=VAL D ^%DT S $P(STR,"^",1)=Y
 I $G(EVENT)="P03" D
 . S SQ="" F  S SQ=$O(XTMP(SQ)) Q:SQ=""  D
 . . S DATA=XTMP(SQ) D
 . . . I $P(DATA,"|",1)="PID" S SN=$P(DATA,"|",20),DFN=$$FIND1^DIC(2,"","X",SN,"SSN")
 . . . I $P(DATA,"|",1)="FT1" D
 . . . . S $P(STR,"^",3)=$$HL7TFM^XLFDT($P(DATA,"|",5))
 . . . . S $P(STR,"^",1)=$P(DATA,"|",6)
 . . . . S $P(STR,"^",6)=$P(DATA,"|",7)
 . . . . S $P(STR,"^",7)=$P($P(DATA,"|",13),"^",5)
 . . . . S NAME=$P(DATA,"|",21),$P(STR,"^",4)=$P(NAME,"^",3)_","_$P(NAME,"^",2)
 . . . . S $P(STR,"^",2)=$P($P(DATA,"|",26),"^",2)
 S $P(STR,"^",6)=$S($P(STR,"^",6)["Clinic":"C",$P(STR,"^",6)["Take":"H",1:$P(STR,"^",6))
 S $P(STR,"^",8)=$S($G(DTE)="":DTE,1:$$NOW^XLFDT)
 S $P(STR,"^",9)=SENDER
 S NAME=$P(STR,"^",4),INIT=""
 I NAME["," S F=$P(NAME,",",2),L=$P(NAME,",",1),INIT=$E(F)_$E(L)
 E  S F=$E(NAME),L=$P(NAME," ",2),L=$E(L,1),INIT=F_L
 S $P(STR,"^",5)=INIT
 D EN^ORDOTP1(DFN,STR)
 Q
