FBAAEPI ;AISC/GRR - EDIT PREVIOUSLY ENTERED PHARMACY INVOICE ;11/20/2014
 ;;3.5;FEE BASIS;**38,61,124,132,123,154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
RD W ! S DIC="^FBAA(162.1,",DIC(0)="AEQM",DIC("A")="Select Invoice #: ",DIC("S")="I $P(^(0),U,5)'=4!($P(^(0),U,5)=4&$D(^XUSEC(""FBAA LEVEL 2"",DUZ)))" D ^DIC K DIC("S") G END:X=""!(X="^"),RD:Y<0
 S (DA,FBDA)=+Y,DIE=DIC
 ;
 ; loop thru Rx and enforce separation of duty
 I $$SODPINV(FBDA) D  G RD
 . W !!,"You cannot process this payment due to separation of duties."
 . W !,"You previously entered/edited an associated authorization."
 ;
 ; save FPPS data prior to edit session
 S (FBFPPSC,FBFPPSC(0))=$P($G(^FBAA(162.1,FBDA,0)),U,13)
 D LASTRXDT ;Look up last RX FILL DATE in selected invoice, for use in validating Invoice Received Date if it is edited.
 S DR="@1;1;I $$BADDATE^FBAAEPI(LASTRXDT,X) S Y=""@1"";Q;12;S FBX=$$FPPSC^FBUTL5(1,FBFPPSC);S:FBX=-1 Y=0;S:FBX="""" Y=""@10"";13///^S X=FBX;S FBFPPSC=X;S Y=""@15"";@10;13///@;S FBFPPSC="""";@15;3;5"
 D ^DIE K DIC
 ; if FPPS CLAIM ID changed, then update Rx's
 I FBFPPSC'=FBFPPSC(0) D CKINVEDI^FBAAEPI1(FBFPPSC(0),FBFPPSC,FBDA)
 S DIC="^FBAA(162.1,DA,""RX"",",DIC(0)="AEQM",DIC("W")="W ?30,""DATE RX FILLED: "",$E($P(^(0),U,3),4,5)_""/""_$E($P(^(0),U,3),6,7)_""/""_$E($P(^(0),U,3),2,3)" D ^DIC K DIC("W")
 I Y<0 D END G RD ; a prescription was not selected
 W !
 S (FBJ,FBK)=0
 ;check status of batch rx is in.
 S DA=+Y,DA(1)=FBDA S FBSTAT=$P($G(^FBAA(161.7,+$P($G(^FBAA(162.1,+FBDA,"RX",+DA,0)),U,17),"ST")),U) I FBSTAT]"" D
 .I '$D(^XUSEC("FBAA LEVEL 2",DUZ)) D
 .. I $S(FBSTAT="O":0,FBSTAT="C":0,1:1) D
 ... W !,*7,"You cannot edit a payment once released by a supervisor.",! S FBOUT=1 Q
 .I $S(FBSTAT="T":1,FBSTAT="F":1,FBSTAT="V":1,1:0) D
 .. W !,*7,"You cannot edit an invoice when the batch has been sent to Austin",! S FBOUT=1
 I $G(FBOUT) D END G FBAAEPI
 ;
 ; FB*3.5*123 - Edit pharmacy IPAC data for Federal Vendors
 I '$$IPACEDIT^FBAAPET1(162.1,.DA) D END G FBAAEPI
 ;
 S DIE="^FBAA(162.1,FBDA,""RX"","
 ; get current value of FPPS LINE ITEM to use as default
 S FBFPPSL=$P($G(^FBAA(162.1,FBDA,"RX",DA,3)),U)
 ; load current adjustment data
 D LOADADJ^FBRXFA(DA_","_FBDA_",",.FBADJ)
 ; save adjustment data prior to edit session in sorted list
 S FBADJL(0)=$$ADJL^FBUTL2(.FBADJ) ; sorted list of original adjustments
 ; load current remittance remark data
 D LOADRR^FBRXFR(DA_","_FBDA_",",.FBRRMK)
 ; save remittance remarks prior to edit session in sorted list
 S FBRRMKL(0)=$$RRL^FBUTL4(.FBRRMK)
 S DR=".01;S:FBFPPSC="""" Y=1;S FBX=$$FPPSL^FBUTL5(FBFPPSL);S:FBX=-1 Y=0;36///^S X=FBX;S FBFPPSL=X;1;1.5;1.6;3;S FBJ=X;I $P(^FBAA(162.1,DA(1),""RX"",DA,0),U,9)=1 S Y="""";I 1;5"
 S DR(1,162.11,1)="S FBA=$P($G(^FBAA(162.1,DA(1),""RX"",DA,2)),U,6);S FB1725=$S(FBA[""FB583"":+$P($G(^FB583(+FBA,0)),U,28),1:0);W:FB1725 !?2,""**Payment is for emergency treatment under 38 U.S.C. 1725."""
 S DR(1,162.11,2)="@12;S FBHAP=$P(^FBAA(162.1,DA(1),""RX"",DA,0),U,16);6.5;S FBK=X;S:FBK]"""" Y=""@20"";K FBADJ,FBRRMK;S Y=8"
 S DR(1,162.11,3)="@20;I FBK>FBJ S $P(^FBAA(162.1,DA(1),""RX"",DA,0),U,16)=FBHAP W !,*7,""Amount Paid cannot be greater than the Amount Claimed"" S Y=""@12"""
 S DR(1,162.11,4)="K FBADJD;M FBADJD=FBADJ;S FBX=$$ADJ^FBUTL2(FBJ-FBK,.FBADJ,2,,.FBADJD,1);K FBADJD"
 S DR(1,162.11,5)="K FBRRMKD;M FBRRMKD=FBRRMK;S FBX=$$RR^FBUTL4(.FBRRMK,2,,.FBRRMKD);K FBRRMKD;S:FBX=-1 Y=0;8"
 D ^DIE
 I '$D(DA) D END G RD ; prescription was deleted
 ; if adjustment data changed then file
 I $$ADJL^FBUTL2(.FBADJ)'=FBADJL(0) D FILEADJ^FBRXFA(DA_","_FBDA_",",.FBADJ)
 ; if remit remark data changed then file
 I $$RRL^FBUTL4(.FBRRMK)'=FBRRMKL(0) D FILERR^FBRXFR(DA_","_FBDA_",",.FBRRMK)
 ; clean up and return to invoice selection
 D END G RD
 ;
LASTRXDT ;Look up last RX FILL DATE in selected invoice, for use in validating Invoice Received Date if it is edited.
 ;DA contains the selected INV#
 N I
 S LASTRXDT=0
 F I=1:1 Q:'$D(^FBAA(162.1,DA,"RX",I))  D
 .N RXDT S RXDT=$P(^FBAA(162.1,DA,"RX",I,0),"^",3)
 .I RXDT>LASTRXDT S LASTRXDT=RXDT,RXNUM=$P(^FBAA(162.1,DA,"RX",I,0),"^",1)
 Q
 ;
BADDATE(LASTRXDT,INVRCVDT) ;Reject entry if InvRcvDt is Prior to the last Rx Fill Date on the Invoice
 I INVRCVDT<LASTRXDT D  Q 1 ;Reject entry
 .N SHOWRXDT  S SHOWRXDT=$E(LASTRXDT,4,5)_"/"_$E(LASTRXDT,6,7)_"/"_$E(LASTRXDT,2,3) ;Convert RXDT into display format for error message
 .W *7,!!?5,"*** Invoice Received Date cannot be prior to the last",!?8," Prescription Filled Date on the Invoice ("_SHOWRXDT_" for RX# "_RXNUM_") !!!"
 Q 0 ;Accept entry
 ;
END K D,DA,DIC,DIE,DR,FBJ,FBK,FBDA,FBOUT,FBSTAT,FBHAP,X,Y,FBA,FB1725
 K FBADJ,FBADJD,FBADJL,FBFPPSC,FBFPPSL,FBRRMK,FBRRMKD,FBRRMKL,LASTRXDT,RXNUM
 Q
 ;
GETIPAC(FBDA,FBVEN,FBIA,FBDODINV) ; Get vendor/IPAC data for Pharmacy (FB*3.5*123)
 ; All parameters required and assumed to exist
 ; Called by $$IPACEDIT^FBAAPET1
 S FBVEN=+$P($G(^FBAA(162.1,FBDA(1),0)),U,4)               ; vendor ien
 S FBIA=+$P($G(^FBAA(162.1,FBDA(1),0)),U,23)               ; IPAC agreement ien
 S FBDODINV=$P($G(^FBAA(162.1,FBDA(1),"RX",FBDA,6)),U,1)   ; DoD invoice#
 Q
 ;
DELIPAC(FBDA) ; Delete all IPAC data on file for Pharmacy (FB*3.5*123)
 ; Called by $$IPACEDIT^FBAAPET1
 N FBIENS,FBIAFDA,DIE,DA,DR,DIC
 S FBIENS=FBDA_","_FBDA(1)_","
 S FBIAFDA(162.11,FBIENS,39)=""       ; remove DoD invoice# from subfile 162.11
 D FILE^DIE("","FBIAFDA")
 S DIE=162.1,DA=FBDA(1),DR="14///@" D ^DIE  ; remove IPAC ptr from file top level 162.1
 Q
 ;
SAVEIPAC(FBDA,FBIA,FBDODINV,WHICH) ; Store IPAC data into the database for Pharmacy (FB*3.5*123)
 ; Called by $$IPACEDIT^FBAAPET1
 N FBIENS,FBIAFDA,DIE,DA,DR,DIC
 S:'$D(WHICH) WHICH=""
 S FBIENS=FBDA_","_FBDA(1)_","
 I WHICH'=1 D
 . S FBIAFDA(162.11,FBIENS,39)=FBDODINV       ; store DoD invoice# in subfile 162.11
 . D FILE^DIE("","FBIAFDA")
 I WHICH'=2 D
 . S DIE=162.1,DA=FBDA(1),DR="14////^S X=FBIA" D ^DIE    ; store IPAC pointer ien in file top level 162.1
 Q
 ;
SODPINV(FBDA) ; check separation of duty for pharmacy invoice
 ; checks all prescriptions on invoice for separation of duty issue
 ; input
 ;   FBDA (required) IEN of pharmacy invoice in file 162.1
 ;   DUZ (current user)
 ; result
 ;   = 0 if user did not enter or edit any associated authorization
 ;   = 1 if user did enter or edit at least one associated authorization
 ;     and thus should be prevented from processing the payment
 N FBDFN,FBFTP,FBI,FBRET
 S FBRET=0
 ; loop thru all Rx on invoice
 S FBI=0 F  S FBI=$O(^FBAA(162.1,FBDA,"RX",FBI)) Q:'FBI  D  Q:FBRET
 . S FBDFN=$P($G(^FBAA(162.1,FBDA,"RX",FBI,0)),U,5)
 . Q:'FBDFN
 . S FBFTP=$P($G(^FBAA(162.1,FBDA,"RX",FBI,2)),U,7)
 . Q:'FBFTP
 . I '$$UOKPAY^FBUTL9(FBDFN,FBFTP) S FBRET=1
 Q FBRET
