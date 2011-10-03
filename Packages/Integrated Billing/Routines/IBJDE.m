IBJDE ;ALB/RB - DM DATA EXTRACTION (MAIN ROUTINE) ; 15-APR-99
 ;;2.0;INTEGRATED BILLING;**100,118,123,235,248,254,244**;21-MAR-94
 ;
BJ ; - Entry point from IBAMTC.
 I $D(^IBE(351.7,"DISABLE")) G ENQ ; DM extraction process disabled.
 ;
 I $E(DT,6,7)=$E($$LDATE(DT)+1,6,7) S IBDT=$E($P($$M1(DT,0),"^",1),1,5)_"00"
 I '$G(IBDT) S IBDT=$$M1(DT,1)
 I $E(IBDT,6,7)'="00" S IBDT=$E(IBDT,1,5)_"00"
 I $D(^IBE(351.71,"AC",3,IBDT)) G ENQ ; Extract done for this date.
 ;
 D NOW^%DTC S IBRD=%,IBS=$P(%H,",",2)
 I $D(^IBE(351.71,IBDT,0)) D  G ST ; Entry for this date already made.
 .S DIE="^IBE(351.71,",DR=".02////1;.03////"_IBRD,DA=IBDT D ^DIE
 .K DA,DIE,DR
 ;
 ; - Create entry in IB DM EXTRACT DATA ELEMENTS file (#351.71).
 S DIC="^IBE(351.71,",DIC(0)="L",DIC("DR")=".02////1;.03////"_IBRD
 S (DINUM,X)=IBDT K DD,DO D FILE^DICN K DIC,DINUM,DD,DO S IBDT=+Y
 ;
ST ; - Start extraction process.
 I '$$CHK(IBDT) G COMP ; If data from all reports extracted, E-mail file.
 ;
 N IBUNBILL
 I $E(DT,6,7)=$E($$LDATE(DT)+1,6,7) S IBA0=$O(^IBE(351.7,"B","UNBILLED AMOUNTS REPORT",0)) G:'IBA0 ENQ  S IBN0=^IBE(351.7,IBA0,0),IBUNBILL=1 D EXTRACT G ENQ
 S IBA0=0 F  S IBA0=$O(^IBE(351.7,IBA0)) Q:'IBA0  S IBN0=^(IBA0,0) I $P(IBN0,"^",1)'="UNBILLED AMOUNTS REPORT" S IBUNBILL=0 D EXTRACT
 G ENQ
 ;
EXTRACT I $P(IBN0,U,2) Q  ;                      Report has been disabled.
 I $D(^IBE(351.71,"AD",3,IBDT,IBA0)) Q  ; Extract of report done.
 ;
 I '$D(^IBE(351.71,IBDT,1,IBA0,0)) D  ; Create REPORT sub-file entry.
 .S DIC="^IBE(351.71,"_IBDT_",1,",DIC(0)="L",DIC("DR")=".02////1"
 .S DIC("P")="351.711P",DA(1)=IBDT,(DA,DINUM,X)=IBA0 K DD,DO
 .D FILE^DICN K DA,DIC,DINUM,DD,DO
 ;
 ; - Set input variables.
 S IBA1=0 N ZTIO,ZTDESC,ZTSK,ZTDTH,ZTRTN,ZTSAVE
 F  S IBA1=$O(^IBE(351.7,IBA0,1,IBA1)) Q:'IBA1  S IBN1=$G(^(IBA1,0)) D
 .I $D(^IBE(351.7,IBA0,1,IBA1,1)) X ^(1)
 .E  S IBV=$P(IBN1,U),@(IBV)=$P(IBN1,U,2),ZTSAVE(IBV)=""
 ;
 ; - Set other ZT* variables for queueing.
 S ZTSAVE("IBUNBILL")=""
 S ZTDESC=$P(IBN0,U),ZTSAVE("IBXTRACT")=1,ZTIO=""
 I $G(IBX) S ZTSAVE("IBXDATE")=IBDT ; Date from DME manual start option.
 S ZTRTN=$G(^IBE(351.7,IBA0,2)) Q:ZTRTN=""  I ZTRTN'["^" S ZTRTN=U_ZTRTN
 S IBS=IBS+300,%=IBS D S^%DTC S ZTDTH=$P(IBRD,".")_% ; Run in 5 mins.
 D ^%ZTLOAD
 Q
 ;
 ;
E(RI,J) ; - Change report extract status/load DM summary report data.
 ;   Input: RI=Report IEN from IB DM EXTRACT REPORTS file (#351.7).
 ;           J=1-Change status, 0=Load DM data
 S IBDT=$S($G(IBXDATE):$E(IBXDATE,1,5)_"00",'$G(IBUNBILL):$$M1(DT,1),1:$E($P($$M1(DT,0),"^",1),1,5)_"00") I 'J G E1
 ;
 I '$D(^IBE(351.71,"AC",2,IBDT)) D  ; Change extract status to STARTED.
 .D NOW^%DTC S DIE="^IBE(351.71,",DR=".02////2;.03////"_%,DA=IBDT D ^DIE
 .K DA,DIE,DR
 ;
 ; - Change report extract status to EXTRACT STARTED.
 I '$D(^IBE(351.71,"AD",2,IBDT,RI)) D
 .D NOW^%DTC S DIE="^IBE(351.71,"_IBDT_",1,",DR=".02////2;.03////"_%
 .S DA(1)=IBDT,DA=RI D ^DIE K DA,DIE,DR
 ;
 G ENQ
 ;
E1 ; - Load DM summary report data into file #351.71.
 I $G(IBUNBILL) G E2
 S IBA0=0 F  S IBA0=$O(^IBE(351.701,"C",RI,IBA0)) Q:'IBA0  D
 .S IBN0=$P($G(^IBE(351.701,IBA0,0)),U,2) Q:IBN0=""  S IBN0=@(IBN0)
 .;
 .; - Create DATA ELEMENT sub-file entry in REPORT sub-file of #351.71
 .S DIC="^IBE(351.71,"_IBDT_",1,"_RI_",1,",DIC(0)="L"
 .S DIC("DR")=".02////"_IBN0,DIC("P")="351.7111P",DA(2)=IBDT,DA(1)=RI
 .S (DA,DINUM,X)=IBA0 K DD,DO D FILE^DICN K DA,DIC,DINUM,DD,DO
 ;
 ; - Change status in REPORT sub-file of #351.71 to EXTRACT COMPLETED.
E2 D NOW^%DTC S DIE="^IBE(351.71,"_IBDT_",1,",DR=".02////3;.04////"_%
 S DA(1)=IBDT,DA=RI D ^DIE K DA,DIE,DR,IBXDATE,IBXTRACT
 ;
 ; - Check if all data from all reports have been extracted, then change
 ;   status in file #351.71 entry to EXTRACT COMPLETED.
 I $$CHK(IBDT) G ENQ ; All reports not completed yet.
 ;
COMP D NOW^%DTC
 S DIE="^IBE(351.71,",DR=".02////3;.04////"_%,DA=IBDT D ^DIE K DA,DIE,DR
 I '$P(^IBE(351.71,IBDT,0),U,5) D XM^IBJDE1(IBDT) ; Transmit extract.
 ;
ENQ I '$G(IBX) K IBDT
 K IBA0,IBA1,IBCT,IBN0,IBN1,IBRD,IBS,IBV,IBV1,X,Y,%
 Q
 ;
M1(X,Y) ; - Return first/last day of month (if Y=0), previous month (if Y=1),
 ;   first/last day of month in MMDDYYYY format (if Y=2), or date in
 ;   external format (if Y=3).
 N X1,X2 S:'$G(X)!(X'?7N.1".".6N) X=DT S:'$G(Y) Y=0
 S X2="31^"_$S($E(X,1,3)#4=0:29,1:28)_"^31^30^31^30^31^31^30^31^30^31"
 I 'Y S X=$E(X,1,5),X=X_"01"_U_X_$P(X2,U,+$E(X,4,5)) G M1Q
 I Y=1 S X=($E(X,1,5)_"00")-$S(+$E(X,4,5)=1:8900,1:100) G M1Q
 I Y=2 D  G M1Q
 .S X1=1700+$E(X,1,3),X=$E(X,4,5),X=X_"01"_X1_U_X_$P(X2,U,+X)_X1
 S Y=X X ^DD("DD") S X=Y
M1Q Q X
 ;
M2(X,Y,Z,R) ; - Return specific date range.
 ; Input: X=Date in Fileman format
 ;        Y=Number of months back from X
 ;        Z=Number of months ahead from date created via Y
 ;        R=0-Date range in Fileman format, 1-In MMDDYYYY format 
 N X1,X2
 S:'$G(X) X=DT S:'$G(Y) Y=1 S:'$G(Z) Z=1 S:'$G(R) R=0 I X'?7N S X=DT
 S X=$E(X,1,5)
 S X1="31^"_$S($E(X,1,3)#4=0:29,1:28)_"^31^30^31^30^31^31^30^31^30^31"
 F X2=1:1:Y S X=X-$S(+$E(X,4,5)=1:89,1:1) I X2=Y S X3=X_"01"
 F X2=1:1:Z S X=X+$S(+$E(X,4,5)=12:89,1:1)
 S X=X3_U_X_$P(X1,U,+$E(X,4,5)) I 'R G M2Q
 S X1=1700+$E(X,1,3),X2=1700+$E(X,9,11),X=$E(X,4,7)_X1_U_$E(X,12,15)_X2
M2Q Q X
 ;
M3(X) ;Beginning date 365 days prior
 N X1,X2
 S X1=X,X2=-365 D C^%DTC
 Q X
CHK(X) ; - Check if all extract reports have completed.
 ;    Input: X=Date IEN of entry in file #351.71
 ;   Output: Y=0-Completed, 1-Not completed
 N X1,X2,X3 S (X1,X2,X3,Y)=0
 F  S X1=$O(^IBE(351.7,X1)) Q:'X1  I '$P(^(X1,0),U,2) S X2=X2+1
 S X1=0 F  S X1=$O(^IBE(351.71,"AD",3,X,X1)) Q:'X1  S X3=X3+1
 I X2'=X3 S Y=1
 Q Y
LDATE(X) ; DETERMINE CUT-OFF DATE FOR THE MONTH
 S X=$E(X,1,5)_$P("31^28^31^30^31^30^31^31^30^31^30^31","^",+$E(X,4,5))
 I +$E(X,6,7)=28,$E(X,2,3)#4=0 S $E(X,6,7)=29
 S X=$$WORKPLUS^XUWORKDY(X,-3)
 Q X
