PSAVER7 ;BIR/JMB-Verify Invoices - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**12,21,42,56,64,66**; 10/24/97;Build 2
 ;Background Job
 ;This routine increments pharmacy location and master vault balances
 ;in 58.8 after invoices have been verified. This routine is called
 ;by PSAVER6.
 ;
 ;References to ^PSDRUG( are covered by IA #2095
TR ;File transaction data in 58.81
 I $D(PSADUREC),'PSADUREC Q  ;*56 block '0' quantity edits
 I $D(PSAQTY),'PSAQTY Q  ;*56 block '0' quantity edits
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSAT=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSAT)) S $P(^PSD(58.81,0),"^",3)=$P(^PSD(58.81,0),"^",3)+1 G FIND
 S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSAT D ^DIC K DIC,DINUM,DLAYGO L -^PSD(58.81,0)
 S DIE="^PSD(58.81,",DA=PSAT,DR="1////1;2////^S X=PSALOC;3////^S X=PSADT;4////^S X=PSADRG;5////^S X=PSADUREC;6////^S X=PSAVDUZ;9////^S X=PSABAL;71////^S X=PSAINV;106////^S X=PSAORD"
 I $G(PSACS) S DR=DR_";100////^S X=PSACS"
 F  L +^PSD(58.81,DA,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIE L -^PSD(58.81,DA,0) K DIE
 S:'$D(^PSD(58.8,PSALOC,1,PSADRG,4,0)) DIC("P")=$P(^DD(58.8001,19,0),"^",2)
 S DA(2)=PSALOC,DA(1)=PSADRG,(X,DINUM)=PSAT,DIC="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",4,",DIC(0)="L",DLAYGO=58.8
 F  L +^PSD(58.8,PSALOC,1,PSADRG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIC L -^PSD(58.8,PSALOC,1,PSADRG,0) K DIC,DINUM,DLAYGO
 ;
50 S PSAODASH=$P($G(^PSDRUG(PSADRG,2)),"^",4)
 S PSAONDC=$P(PSAODASH,"-")_$P(PSAODASH,"-",2)_$P(PSAODASH,"-",3)
 ;(PSA*3*21) NDC & PRICING UPDATES (DAVE BLOCKER 10NOV99)
 S PSADUOU=$S($G(PSADUOU)'>0:1,1:PSADUOU)
 S PSADUREC=(PSAQTY*PSADUOU)
 S DIE="^PSDRUG(",DA=PSADRG,DR="50////^S X="_(PSADUREC+$G(^PSDRUG(PSADRG,660.1)))
 F  L +^PSDRUG(DA,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIE L -^PSDRUG(DA,0) K DIE,DA,DR
 ;This section replaces most of the routine
 ;PSAOU = order unit from invoice
 ;PSAPOU & PSANPOU = Price of Order Unit from invoice
 ;PSADUOU=Dispense Units per OU form invoice data
 ;PSANPDU= Price of Dispense Units per Order Unit
 ;
 ;Drug file Information
 K DRUG
 S PSANODE=$G(^PSDRUG(PSADRG,660))
 F X=2,3,5,6 S DRUG(X)=$P($G(PSANODE),"^",X)
 ;
 S PSANPDU=$J(($G(PSAPOU)/$G(PSADUOU)),0,3) ;Price of Order Unit divide by Disp. Units per Order Unit
 ;PSA*3*42 |>  (let changes happen and file, put changes into mail message)
 S DIE="^PSDRUG(",(DA,OLDDA)=PSADRG,DR="12////^S X=PSAOU;15////^S X=PSADUOU;Q;13////^S X=PSAPOU" ;*42;*56
 F  L +^PSDRUG(DA,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIE K DIE,DA,DR
 ; <| PSA*42
PTCH21 ;PSA*3*21 (Vendor's VSN changing to 8 digits, check also)
 ;If NDC or VSN changes should it create to synonym entry ?
 I $G(^PSDRUG(PSADRG,1,PSASUB,0))="" G NDC
 I $G(^PSDRUG(PSADRG,1,PSASUB,0)) S PSAEDTT=0,DATA=^PSDRUG(PSADRG,1,PSASUB,0) D
 .I PSAVSN'=$P(DATA,"^",4) S PSAEDTT=1 ;VSN
 .I PSAPOU'=$P(DATA,"^",6) S PSAEDTT=1 ;Price per order unit
 .I PSADUOU'=$P(DATA,"^",7) S PSAEDTT=1 ;Dispense Units per Order Unit
 .I PSANPDU'=$P(DATA,"^",8) S PSAEDTT=1 ;New Price per dispense unit
 .I $G(PSAEDTT)>0 D
 ..S DA=PSASUB,DA(1)=PSADRG,DIE="^PSDRUG("_DA(1)_",1,"
 ..S DR="2////^S X=PSADASH"_$S(PSACS:";1////C",1:";1////D")_";400////^S X=PSAVSN;401////^S X=PSAOU"_$S(+PSAPOU:";402////^S X=PSAPOU",1:"")_";403////^S X=PSADUOU"_";404///^S X=PSANPDU"_";405///^S X=PSAVEND"
 ..D ^DIE K DIE,DR,DA
NDC ;NDC UPDATE
 I PSANDC'="",PSANDC'=PSAONDC D  ;*42
 .S DIE="^PSDRUG(",DA=PSADRG,DR="31////^S X=PSADASH"
 .F  L +^PSDRUG(DA,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .D ^DIE L -^PSDRUG(DA,0) K DIE,DA,DR
SYNONYM ;Adds/edits the SYNONYM multiple in DRUG file  >>*66 RJS
 G:PSANDC="" END
 S DA(1)=PSADRG  ;;  << *66 RJS
 ;
 S PSANPDU=$J(($G(PSAPOU)/$G(PSADUOU)),0,3) ;Price of Order Unit divide by Disp. Units per Order Unit
 S:'$D(^PSDRUG(PSADRG,1,0)) DIC("P")="50.1A"
 ; *56 Search for earliest best match of synonyms, start at bottom go up
 ; if VSN use it, if several VSNs use the first, IF VSN match NDCs must match also.
 ; if no VSN, make a new synonym
 ; no "B" synonym index exists
T0 N PSYNDA,PSYN0,PSTNDC,PSTVSN,PSMNDC,PSMBTH S (PSMNDC,PSMBTH)=0
 S PSYNDA="" F  S PSYNDA=$O(^PSDRUG(PSADRG,1,PSYNDA),-1) Q:PSYNDA'>0  D
 . S PSYN0=^PSDRUG(PSADRG,1,PSYNDA,0),PSTNDC=$P(PSYN0,U),PSTVSN=$P(PSYN0,U,4) ;zero node, test values of NDC VSN
 . I PSTNDC'=PSANDC Q
 . I PSTVSN=PSAVSN S PSMBTH=PSYNDA Q  ;both VSN & NDC matches
T1 S PSASUB=$S(PSMBTH:PSMBTH,1:0) ;PSAMBTH Match both vsn,ndc
 ;end *56
 I 'PSASUB!(PSASUB&('$D(^PSDRUG(PSADRG,1,PSASUB,0)))) D
 .S DIC="^PSDRUG("_DA(1)_",1,",DIC(0)="Z",X=PSANDC,DLAYGO=50
 .F  L +^PSDRUG(PSADRG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .D FILE^DICN L -^PSDRUG(PSADRG,0) K DIC,DLAYGO S PSASUB=+Y
 .K DIC,DA,DR,DIE
 I PSASUB,$D(^PSDRUG(PSADRG,1,PSASUB,0)) S DA=PSASUB
 S DA(1)=PSADRG,DIE="^PSDRUG("_DA(1)_",1,"
 S DR="2////^S X=PSADASH"_$S($G(PSACS)>0:";1////C",1:";1////D")_";400////^S X=PSAVSN;401////^S X=PSAOU"_$S(+PSAPOU:";402////^S X=PSAPOU",1:"")_";403////^S X=PSADUOU"_";404///^S X=PSANPDU;405///^S X=PSAVEND"
 F  L +^PSDRUG(PSADRG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIE L -^PSDRUG(PSADRG,0)
 K DIE,DR,X1,X2,DATA
END ; FINAL CLEANUP  << *66 RJS
 L -^PSDRUG(OLDDA,0) K OLDDA  ;; >> *66 RJS
 Q
