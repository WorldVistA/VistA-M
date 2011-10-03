RMIMU ;WPB/JLTP ; FUNCTIONAL INDEPENDENCE UTILITIES ; 14-AUG-2002
 ;;1.0;FUNCTIONAL INDEPENDENCE;;Apr 15, 2003
A(X) ; Add New Record to FIM Database
 N AD,CASE,DA,DFN,DIE,DOB,DR,FAC,FACI,I,IFN,IG,OD,OK,OP,TYP
 S CASE=+X,X=$P(X,U,2,9),OK=1 F I=1:1:7 I $P(X,U,I)="" S OK=0 Q
 I 'OK Q $$ERR(-1)
 S DFN=+X,SSN=$P(X,U,2),DOB=$P(X,U,3),FAC=$P(X,U,4),TYP=$P(X,U,5)
 S IG=$P(X,U,6),OD=$P(X,U,7),AD=$P(X,U,8),OP="A"
 S X=$$NFE(CASE),IFN=+X,CASE=$P(X,U,2) I X'>0 Q $$ERR(-2)
 S X=IFN_U_CASE_U_DFN_U_SSN_U_DOB_U_FAC_U_TYP_U_IG_U_OD_U_AD
 I '$$CF(X) Q $$ERR(-7)
 Q IFN_U_CASE
NFE(C) ; Create Record and Return IFN
 N CASE,DA,DIC,DIE,DINUM,DR,IFN,X,Y
 S CASE=+$G(C)
 L +^RMIM(783,0) S X=$P(^RMIM(783,0),U,4)+1
 F  Q:'$D(^RMIM(783,X,0))  S X=X+1
 L +^RMIM(783.9,1,0)
 I 'CASE D
 .S CASE=$P(^RMIM(783.9,1,0),U,2)+1
 .F  Q:'$D(^RMIM(783,"CASE",CASE))  S CASE=CASE+1
 S DIC="^RMIM(783,",DIC(0)="L",DIC("DR")=".02////^S X=CASE",DINUM=X
 D FILE^DICN S IFN=+Y
 S $P(^RMIM(783.9,1,0),U,2)=CASE
 L -^RMIM(783,0) L -^RMIM(783.9,1,0)
 Q IFN_U_CASE
E(X) ; Edit Existing Record
 N CASE,CE,IFN,P,SENT,STATUS,X1
 S CASE=+X,IFN=$O(^RMIM(783,"CASE",CASE,0)) Q:'IFN $$ERR(-6)
 S X1=^RMIM(783,IFN,0),SENT=$P(X1,U,13)
 F P=5,9:1:12 S:$P(X1,U,P) $P(X1,U,P)=$$FMTE^XLFDT($P(X1,U,P),5)
 S CE=0 F P=2:1:9 I $P(X,U,P)'=$P(X1,U,P+1) S CE=1 Q
 I 0,CE,SENT D  Q STATUS
 .S STATUS=$$D(X) Q:STATUS<1
 .S STATUS=$$A(X)
 S X=IFN_U_X
 S STATUS=$$CF(X) I 'STATUS Q $$ERR(-7)
 Q IFN_U_CASE
D(X) ; Mark Record for Deletion
 Q 1 ;Not Currently Used... Maybe Later
 N CASE,DA,DIE,DR,IFN
 S CASE=+X,IFN=$O(^RMIM(783,"CASE",CASE,0)) Q:'IFN $$ERR(-6)
 S DA=IFN,DIE="^RMIM(783,",DR=".12////^S X=DT;.14////D" D ^DIE
 Q IFN_U_CASE
CF(VAL) ; File Critical Fields
 N DA,DIE,DR,EDIT,FLD,LINE,PCE,VAAR,X,Y
 S DR="" F LINE=1:1 S TEXT=$P($T(CRIT+LINE),";;",2) Q:TEXT=""  D
 .S FLD=$P(TEXT,U),PCE=$P(TEXT,U,2),VAR=$P(TEXT,U,3)
 .I PCE S EDIT=FLD_"///"_$P(VAL,U,PCE)
 .E  I VAR]"" S EDIT=FLD_"///^S X="_VAR
 .I ($L(DR)+$L(EDIT))>200 D
 ..S DA=+VAL,DIE="^RMIM(783," D ^DIE S DR=""
 .S:DR]"" DR=DR_";" S DR=DR_EDIT
 I DR]"" S DA=+VAL,DIE="^RMIM(783," D ^DIE
 Q 1
GC(RMIMR) ; Retrieve Critical Fields for a Case
 N FLD,GN,GP,LINE,N,P,X
 S IFN=+RMIMR(1)
 F LINE=1:1 S TEXT=$P($T(CRIT+LINE),";;",2) Q:TEXT=""  D
 .S FLD=$P(TEXT,U),P=$P(TEXT,U,2) Q:'P
 .S X=$P(^DD(783,+FLD,0),U,4),GN=$P(X,";"),GP=$P(X,";",2)
 .I FLD'=+FLD S $P(RMIMR(1),U,P)=$$GET1^DIQ(783,IFN,+FLD) Q
 .S X=$P($G(^RMIM(783,IFN,GN)),U,GP)
 .I X S $P(RMIMR(1),U,P)=$$FMTE^XLFDT(X,5)
 Q
ERR(E) ; Return Error Message
 Q E_U_$P($T(ERMSG+$$ABS^XLFMTH(E)),";;",2)
ERMSG ; Error Messages
 ;;Missing Required Data
 ;;New Record Could Not Be Created
 ;;Invalid Facility Number
 ;;No Data Received
 ;;Invalid Operation Code
 ;;Case # Not Found
 ;;Error Filing Critical Fields
 ;;Error Retrieving Patient Data
 ;;
CRIT ; Required Identifier Fields
 ;;.03/^3
 ;;.04/^4
 ;;.05^5
 ;;.06/^6
 ;;.07/^7
 ;;.08/^8
 ;;.09^9
 ;;.1^10
 ;;.12/^^DT
 ;;.14/^^OP
 ;;.15/^^1
 ;;
