IBECUS21 ;RLM/DVAMC - FILE TRICARE PHARMACY TRANSACTIONS ; 14-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,240,274**;21-MAR-94
 ;
TRAN ; File a Pharmacy Billing transaction in file #351.5.
 ;  Input:      DFN  --  Pointer to the patient in file #2
 ;           IBLINE  --  Array of data transmitted to the FI
 ;           IBRESP  --  Array of data received from the FI
 ;            IBKEY  --  1 ; 2, where
 ;                         1 = Pointer to the prescription in file #52
 ;                         2 = Pointer to the refill in file #52.1, or
 ;                             0 for the original fill
 ;           IBKEYD  --  1 ^ 2 ^ 3 ^ 4, where
 ;                         1 = Rx label printing device
 ;                         2 = Pointer to the Pharmacy in file #59
 ;                         3 = Pointer to the Pharmacy user in file #200
 ;                         4 = Pointer to the billing transaction
 ;                             in file #351.5 (cancellations only)
 ;
 ; - don't process duplicate transactions
 I $E(IBRESP(1),17)="D" Q
 ;
 ; - find transaction entry or create a new one
 S IBCHTRN=$O(^IBA(351.5,"B",IBKEY,0))
 I 'IBCHTRN D
 .S I=$P(^IBA(351.5,0),"^",3)
 .F  S I=I+1 L +^IBA(351.5,I):1 Q:$T&'$D(^IBA(351.5,I))  L -^IBA(351.5,I)
 .S ^IBA(351.5,I,0)=IBKEY,^IBA(351.5,"B",IBKEY,I)=""
 .S ^IBA(351.5,0)=$P(^IBA(351.5,0),"^",1,2)_"^"_I_"^"_($P(^IBA(351.5,0),"^",4)+1)
 .S IBCHTRN=I L -^IBA(351.5,IBCHTRN)
 ;
 ; - prepare i/o for filing
 S IBPROC("I")="" F IBI=1:1:2 S IBPROC("I")=IBPROC("I")_$G(IBRESP(IBI))
 S IBPROC("O")="" F IBI=1:1:5 S IBPROC("O")=IBPROC("O")_$G(IBLINE(IBI))
 S IBPROC("O")=$E(IBPROC("O"),3,999)
 ;
 ; - file transaction data
 S $P(^IBA(351.5,IBCHTRN,0),"^",2,6)=DFN_"^"_$P(IBCDFND,"^",2)_"^"_$TR(IBDRX("NDC"),"-","")_"^"_$J((+IBUAC/100),0,2)_"^"_IBDRX("QTY")
 F IBI=1:1 S IBTABLE=$T(TABLE+IBI) Q:$P(IBTABLE,";",3)="$END"  D
 .Q:$P(IBTABLE,";",4)<2
 .;
 .; - file only the 0th node for rejects
 .I $E(IBRESP(1),17)="R",$P(IBTABLE,";",4)>1 Q
 .;
 .S X="" I $P(IBTABLE,";",6)'?1.N X $P(IBTABLE,";",6)
 .I X="" S X=$E(IBPROC($P(IBTABLE,";",3)),$P(IBTABLE,";",6),$P(IBTABLE,";",7))
 .I $P(IBTABLE,";",2)["D" Q:'X  D DOLLAR
 .;
 .; - file each field individually
 .I X]"" S $P(^IBA(351.5,IBCHTRN,$P(IBTABLE,";",4)),"^",$P(IBTABLE,";",5))=X
 ;
 ; - delete cancellation authorization number
 S $P(^IBA(351.5,IBCHTRN,6),"^")=""
 ;
 ; - handle rejects, update transaction date and cross reference
 D REJECT
 N DIQUIET S DIQUIET=1 D DT^DICRW S $P(^IBA(351.5,IBCHTRN,0),U,7)=DT
 S DA=IBCHTRN,DIK="^IBA(351.5," D IX^DIK
 Q
 ;
 ;
DOLLAR ; Convert cents to dollars.
 S X=$E(X,1,($L(X)-2))_"."_$E(X,($L(X)-1),$L(X))
 F  Q:$E(X,1)'=0  S X=$E(X,2,999)
 Q
 ;
 ;
REJECT ; Act on billing rejects.
 ;
 ; - file reject information
 S IBREJ="" I $E(IBRESP(1),17)="R" D
 .F IBJ=20:2 S IBJA=$E(IBRESP(1),IBJ,IBJ+1) Q:IBJA="  "!(IBJA="")  D
 ..S IBERRP=$$ERRIEN^IBECUS22("UNIVERSAL",IBJA)
 ..I IBERRP S IBREJ=IBREJ_","_IBERRP
 S:$L(IBREJ) IBREJ=$E(IBREJ,2,999)
 S ^IBA(351.5,IBCHTRN,5)=IBREJ
 ;
 ; - if the transaction was not rejected, delete the existing
 ;   reject entry if it exists
 S IBCHREJ=$O(^IBA(351.52,"B",IBKEY,0))
 I IBREJ="" D  G REJECTQ
 .I IBCHREJ S DA=IBCHREJ,DIK="^IBA(351.52," D ^DIK K DA,DIK
 ;
 ; - add a new reject entry if necessary
 I 'IBCHREJ D ADDREJ
 ;
 ; - update reject file
 S DA=IBCHTRN,DIE="^IBA(351.52,",DR=".02////"_IBCHTRN_";.03////"_DT
 D ^DIE K DA,DIE,DR
 S ^IBA(351.52,IBCHREJ,1)=IBREJ
 ;
 ; - generate a reject alert
 S XQA("G.IB CHAMP RX REJ")="",XQA(+$P(IBKEYD,"^",3))=""
 S XQAMSG="Prescription #"_IBDRX("RX#")_" rejected for reason #"_IBREJ
 S XQADATA=IBDRX("RX#")_"^"_IBREJ_"^"_DFN,XQAROU="DISP^IBECUS22"
 D SETUP^XQALERT
 ;
 ; - remove prescription from queue
 I $P($G(^IBE(351.51,+IBREJ,0)),"^",2)<89 K ^IBA(351.5,"APOST",IBKEY)
REJECTQ Q
 ;
 ;
ADDREJ ; Add stub entry to the Reject file.
 S I=$P(^IBA(351.52,0),"^",3)
 F  S I=I+1 L +^IBA(351.52,I):1 Q:$T&'$D(^IBA(351.52,I))  L -^IBA(351.52,I)
 S ^IBA(351.52,I,0)=IBKEY,^IBA(351.52,"B",IBKEY,I)=""
 S ^IBA(351.52,0)=$P(^IBA(351.52,0),"^",1,2)_"^"_I_"^"_($P(^IBA(351.52,0),"^",4)+1)
 S IBCHREJ=I L -^IBA(351.52,I)
 Q
 ;
 ;
TABLE ; Table of field positions and file locations in file #351.5.
 ;;O;0;2;S X=DFN
 ;;O;0;3;48;65
 ;;O;0;4;268;278
 ;D;O;0;5;280;285
 ;;O;0;6;259;263
 ;D;I;2;1;18;23
 ;D;I;2;2;24;29
 ;D;I;2;3;30;35
 ;D;I;2;4;36;41
 ;D;I;2;5;42;47
 ;;I;2;6;48;61
 ;;I;2;7;62;101
 ;D;I;3;1;102;109
 ;D;I;3;2;110;117
 ;D;I;3;3;118;125
 ;D;I;3;4;126;131
 ;D;I;3;5;132;137
 ;D;I;3;6;138;143
 ;D;I;3;7;144;149
 ;D;I;3;8;150;155
 ;;I;3;9;156;157
 ;D;I;3;10;158;163
 ;;I;7;1;164;323
 ;;I;8;1;324;403
 ;;$END
