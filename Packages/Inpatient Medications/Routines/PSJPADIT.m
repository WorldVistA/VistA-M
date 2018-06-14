PSJPADIT ;BIR/JCH-INPATIENT PADE INVENTORY FILE UTILITIES ;25 SEP 97 / 7:41 AM
 ;;5.0;INPATIENT MEDICATIONS ;**317,356**;16 DEC 97;Build 7
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to ^XLFDT is supported by DBIA 10103.
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ;
FIL58601(PADATA,PSJOMS) ; File PADE data into PADE INVENTORY file #58.601
 ; PADE HL7 messages filed into the PADE IN TRANSACTION (#58.6) trigger new-style 'AC' action cross reference, entering here.
 ;
 ;INPUT:PADATA array - Passed in X(n) array from ACTION cross reference on PADE INBOUND TRANSACTIONS (#58.6) file.
 ;        Array Node   File#   Field#    Field Name              Description
 ;        ----------   ------  ------    ------------------      -------------   
 ;        PADATA(1)   58.6       1.1    PADE VENDOR             IEN of PADE system from file 58.7
 ;        PADATA(2)   58.6         1    DISPENSING DEVICE       Name (text) of PADE DEVICE
 ;        PADATA(3)   58.6       1.2    DRAWER                  Name (text) of PADE DRAWER
 ;        PADATA(4)   58.6         2    DRUG                    Pointer to DRUG (#50) file.
 ;        PADATA(5)   58.6         4    TYPE OF TRANSACTION     Set of codes describing transaction (L=LOAD,U=UNLOAD,D=DISPENSE,R=RETURN,X=DESTROY).
 ;        PADATA(6)   58.6         3    QUANTITY                Quantity (item count) of drugs documented in transaction.
 ;        PADATA(7)   58.6        10    POCKET                  Most specific storage location within drawer or subdrawer.
 ;        PADATA(8)   58.6        13    ACTUAL BEGIN BALANCE    Actual item count performed at PADE device prior to transaction.
 ;        PADATA(9)   58.6       .01    TRANSACTION DATE/TIME   Date/Time the activity occurred at the dispensing device
 ;        PADATA(10)  58.6        11    SUBDRAWER               Another storage division of a cabinet
 ;        PADATA(12)  58.6        12    EXPECTED BEGIN COUNT    Expected Quantity of Drug in Bin/Pocket at start of transaction
 ;        PADATA(16)  58.6        16    POCKET BALANCE          Item count of pocket/bin
 ;
 ;INPUT:PSJOMS array - Additional PADE HL7 information
 ;        PSJOMS("DRGITM") - Drug ID
 ;        PSJOMS("CABID")  - PADE Cabinet ID
 ;        PSJOMS("DISPSYS")- PADE System
 ;
 N ERRMSG,PADNOW,PSJNOTE
 Q:'$D(PADATA)>1          ; No data passed in
 ; Don't allow future Last Pocket Update date/times (could suppress actual updates)
 S PADNOW=$$NOW^XLFDT()
 I $G(PADATA(9))>PADNOW S PADATA(9)=PADNOW
 ;
 N INVDATA  ; Array to hold data returned from GETS^DIQ calls (re-initialized and re-used)
 N ERR      ; Array to hold messages returned from DIE and DIC calls. (re-initialized and re-used).
 N FDA      ; Array containing the name of the root of a VA FileMan Data Array
 ;
 N PS586IEN S PS586IEN=+$G(DA) I PS586IEN I $P($G(^PS(58.6,PS586IEN,3)),"^")]"" S $P(^PS(58.6,PS586IEN,3),"^")="I"
 S PSJNOTE=$$UPPER^HLFNC($G(^PS(58.6,+$G(PS586IEN),2)))
 I PSJNOTE["CANCEL" Q   ; Cancel Inventory Update if comments contain 'CANCEL'
 S PADATA(12)=$P($G(^PS(58.6,+$G(PS586IEN),0)),"^",13)
 S PADATA(16)=$P($G(^PS(58.6,+$G(PS586IEN),1)),"^",2)
 ;S PADATA(4)=$P($G(^PS(58.6,+$G(PS586IEN),0)),"^",3) ;UNCOMMENT THIS LINE IN TEST SYSTEM ONLY TO MOCK TEST CREATING AN INVENTORY UPDATE IN FILEMAN
 Q:$E($G(PADATA(5)))="W"&(PSJNOTE'["RETURN BIN")  ; Waste Transaction should not update inventory, unless RETURN BIN
 ;
 ; Quit if this transaction is older than the most recent update date/time for the pocket-drug
 N TMPARRAY M PSTMPAR=PADATA
 I $$OLDPKUP^PSJPAD70(.PSTMPAR,.ERR,PS586IEN) D LOGERR(.ERR) Q
 K PSTMPAR
 ;
 ; File PADE System from PADE INBOUND TRANSACTION file to PADE INVENTORY file
 I '$$FILSYS(.PADATA,.ERR) S ERR="CANNOT FILE SYSTEM "_ERR D LOGERR(.ERR) Q
 ;
 ; File PADE Device from PADE INBOUND TRANSACTION file to PADE INVENTORY file
 I '$$FILDEV^PSJPADIU(.PADATA,.ERR) S ERR="PADE DEVICE NOT UPDATED "_ERR D LOGERR(.ERR) Q
 ;
 I ($TR(PADATA(3),"~")="")&($TR(PADATA(7),"~")="") Q   ; No drawer, no pocket = no inventory update
 ;
 ; Add PADE Drawer from PADE INBOUND TRANSACTION file to PADE System Dispensing Device in PADE INVENTORY file
 I '$$FILDRWR(.PADATA,.ERR) S ERR="DRAWER NOT UPDATED "_ERR D LOGERR(.ERR) Q
 ;
 ; Add drug from PADE INBOUND TRANSACTION file to PADE System Dispensing Device in PADE INVENTORY file.
 I '$$FILDRUG(.PADATA,.ERR) S ERR="DRUG/DEVICE NOT UPDATED "_ERR D  Q
 .Q:'$G(PADATA(4))  ; Consider drug 'NOT ON FILE' only if a valid VistA IEN (all numeric). Otherwise, the ID was never intended for VistA.
 .I $L($G(PSJOMS("DRGITM"))) Q:PSJOMS("DRGITM")'?1.N
 .S:$L($G(PSJOMS("CABID"))) ERR=ERR_":CABINET="_PSJOMS("CABID")
 .S:$L($G(PSJOMS("DISPSYS"))) ERR=ERR_":SYSTEM="_PSJOMS("DISPSYS")
 .D LOGERR(.ERR) Q
 ;
 ; Add drug from PADE INBOUND TRANSACTION file to Drug sub-file in Drawer multiple of PADE INVENTORY file
 I '$$DRGDRWR(.PADATA,.ERR) S ERR="DRUG/DRAWER NOT UPDATED "_ERR D LOGERR(.ERR) Q
 ;
 ; Add Pocket sub-file entry to Drawer multiple in PADE INVENTORY file
 I '$$UPCKDRW(.PADATA,.ERR) S ERR="POCKET NOT UPDATED "_ERR D LOGERR(.ERR) Q
 ;
 ; Update Pocket balance
 I '$$UPCKBAL(.PADATA,.ERR) S ERR="POCKET BALANCE NOT UPDATED "_ERR D LOGERR(.ERR)
 ; Update Drug (Drawer) balance in PADE INVENTORY file
 I '$$UPDRWBAL(.PADATA,.ERR) S ERR="DRUG/DRAWER BALANCE NOT UPDATED "_ERR D LOGERR(.ERR)
 ;
 I '($G(PSJNOTE)["PATIENT SPECIFIC BIN")&'($G(PSJNOTE)["RETURN BIN") D
 .; Update Drug (Device) balance in PADE INVENTORY file
 .I '$$UPDEVBAL(.PADATA,.ERR) S ERR="DRUG/DEVICE BALANCE NOT UPDATED "_ERR D LOGERR(.ERR)
 ;
 ; Delete (Unload) drug from device
 I $$DELCHK(.PADATA) D
 .N SYS,DEV,DRW,DRGDEV,DRG,PCK
 .S SYS=$G(PADATA("SYS IEN"))          ; IEN of system in file 58.601
 .S DEV=$G(PADATA("DEVICE IEN"))       ; IEN of device from subfile 58.6011
 .S DRW=$G(PADATA("DRAWER IEN"))       ; IEN of drawer from subfile 58.60112
 .S DRGDEV=$G(PADATA("DRUG DEV IEN"))  ; IEN of drug (device) from subfile 58.60111
 .S DRG=$G(PADATA("DRUG IEN"))         ; IEN of drug (drawer) from subfile 58.601121
 .S PCK=$G(PADATA("POCK/SUB IEN"))     ; IEN of pocket/subdrawer from subfile 58.601122
 .D UNLOAD^PSJPAD70(SYS,DEV,DRW,DRG,DRGDEV,PCK)
 ;
 ; Transaction processing complete
 I $G(PS586IEN) I $P($G(^PS(58.6,PS586IEN,3)),"^")]"" S $P(^PS(58.6,PS586IEN,3),"^")="C"
 Q
 ;
DELCHK(PADATA) ; Check if incoming transaction represents a drug removed from the device
 N PSJTTRAN
 S PSJTTRAN=$G(PADATA(5)) I PSJTTRAN="U"!(PSJTTRAN="B") Q 1
 Q 0
 ;
FILSYS(PADATA,ERRMSG) ; Check for PADE Inbound System in PADE INVENTORY file
 K DIERR,ERR S PADATA("SYS IEN")=$$FIND1^DIC(58.601,"","MXQ",$G(PADATA(1)),,,"ERR") K DIERR  ;*356
 I '$G(PADATA("SYS IEN")) S ERRMSG="UNABLE TO FIND PADE SYSTEM "_PADATA(1) Q 0
 Q 1
 ;
FILEDEV(XARRAY) ; File device from PADE DISPENSING DEVICE (#58.63) file
 N PADATA0
 I $G(XARRAY(2)) S PADATA("SYS IEN")=XARRAY(2)
 I '$G(XARRAY(2)),$G(XARRAY("SYS IEN"))]"" S PADATA(2)=$P($G(^PS(58.601,+XARRAY("SYS IEN"),0)),"^")
 I $G(XARRAY(1))]"" S PADATA(2)=XARRAY(1)
 D FILDEV^PSJPADIU(.PADATA)
 Q
 ;
FILDRWR(PADATA,ERRMSG) ; Add PADE Drawer to PADE System's DISPENSING DEVICE in PADE INVENTORY file
 I $G(PADATA(3))="" S PADATA(3)="zz"
 K ERR,DIERR S PADATA("DRAWER IEN")=$$FIND1^DIC(58.60112,","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",","MX",PADATA(3),,,"ERR") K DIERR  ;*356
 I '$G(PADATA("DRAWER IEN")) D
 .K FDA,ERR,DIERR S FDA(58.60112,"?+1,"_+PADATA("DEVICE IEN")_","_+PADATA("SYS IEN")_",",.01)=PADATA(3) D UPDATE^DIE("E","FDA","","ERR") K DIERR  ;*356
 .K ERR,DIERR S PADATA("DRAWER IEN")=$$FIND1^DIC(58.60112,","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",","MX",PADATA(3),,,"ERR") K DIERR ;*356
 I '$G(PADATA("DRAWER IEN")) S ERRMSG="Unable to file PADE drawer"_PADATA(3) Q 0
 Q 1
 ;
FILDRUG(PADATA,ERRMSG)  ; Add drug from PADE INBOUND TRANSACTION file to PADE System Dispensing Device in PADE INVENTORY file
 N DRUG,DEVIEN,SYSIEN
 S DRUG=$G(PADATA(4))                          ; Drug
 S DEVIEN=$G(PADATA("DEVICE IEN"))             ; Dispensing Device IEN
 S SYSIEN=$G(PADATA("SYS IEN"))                ; PADE System IEN
 I '(DRUG]"") S ERRMSG="MISSING DRUG" Q 0      ; No drug, no go
 ;
 I '$D(^PSDRUG(+DRUG,0)) D  Q 0
 .N DRGNAME,DRGID,DRGNODE
 .S DRGNODE=$G(^PS(58.6,+$G(PS586IEN),1))
 .S DRGNAME=$P(DRGNODE,"^",6)
 .S DRGID=$P(DRGNODE,"^",7)
 .S ERRMSG="DRUG NOT ON FILE|"   ; No LAYGO - Unknown DRUG (#50) file IEN
 .S ERRMSG=ERRMSG_"DRG ID="_DRGID_"|NAME="_DRGNAME
 ; Must have PADE system and Dispensing Device
 I '$G(DEVIEN) S ERRMSG="MISSING DEVICE IEN" Q 0
 I '$G(SYSIEN) S ERRMSG="MISSING SYSTEM IEN" Q 0
 N DA,FDA,X,Y,DIC,DIE,DR,D0,ERR,D,DD,DICR,DICRS,DO
 K ERR,DIERR S PADATA("DRUG DEV IEN")=$$FIND1^DIC(58.60111,","_DEVIEN_","_SYSIEN_",","MXQ",DRUG,,,"ERR") K DIERR  ;*356
 I 'PADATA("DRUG DEV IEN") D
 .K ERR,DIERR S FDA(58.60111,"?+1,"_+DEVIEN_","_+SYSIEN_",",.01)=DRUG D UPDATE^DIE("E","FDA","ERR") K DIERR  ;*356
 .K ERR,DIERR S PADATA("DRUG DEV IEN")=$$FIND1^DIC(58.60111,","_DEVIEN_","_SYSIEN_",","MXQ",DRUG,,,"ERR") K DIERR  ;*356
 K ERR,DIERR S PADATA("DRUG DEV IEN")=$$FIND1^DIC(58.60111,","_DEVIEN_","_SYSIEN_",","MXQ",DRUG,,,"ERR") K DIERR  ;*356
 I '$G(PADATA("DRUG DEV IEN")) S ERRMSG="UNABLE TO FILE DRUG "_DRUG Q 0
 Q 1
 ;
DRGDRWR(PADATA,ERRMSG)  ; Add drug to drawer in PADE INVENTORY file
 N FDA,ERR
 K ERR,DIERR S PADATA("DRUG IEN")=$$FIND1^DIC(58.601121,","_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",","MXQ",PADATA(4),,,"ERR") K DIERR  ;*356
 I '$G(PADATA("DRUG IEN")) D
 .S FDA(58.601121,"?+1,"_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",",.01)=PADATA(4) K ERR,DIERR D UPDATE^DIE("","FDA","","ERR") K DIERR  ;*356
 .K DIERR,ERR S PADATA("DRUG IEN")=$$FIND1^DIC(58.601121,","_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",","MXQ",PADATA(4),,,"ERR") K DIERR ;*356
 .Q:'PADATA("DRUG IEN")  N DBALIENS,TRNSIGN,TRNSAMT
 .; If a new drug was added to drawer, initialize drug's drawer balance to Actual Begin Count (PADATA(8)) from HL7 message
 .S DBALIENS=PADATA("DRUG IEN")_","_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_","
 .S FDA(58.601121,DBALIENS,1)=$G(PADATA(8))
 .; File the updated drawer total for this drug
 .K DIERR,ERR D FILE^DIE("","FDA","ERR") K DIERR ;*356
 I '$G(PADATA("DRUG IEN")) S ERRMSG="Unable to file PADE drug (drawer) IEN"_PADATA(4) Q 0
 Q 1
 ;
UPDEVBAL(PADATA,ERRMSG)  ; Update Drug (Device) balance
 ;  Get current device total count of drug
 N DBALIENS,FDA,INVDATA,BALANCE,TRERR,DOSFORM
 ;
 I $E($G(PADATA(5)))="B" Q 1  ; "BIN" transaction does not update device balance
 I $E($G(PADATA(5)))="W" Q 1  ; "WASTE" transaction does not update device balance
 ;
 ; Get Device Balance from transaction, if sent
 S BALANCE=+$P($G(^PS(58.6,+$G(PS586IEN),1)),"^",5)
 S:BALANCE<0 BALANCE=0
 ;
 ; Done with 58.6, now set IENS to refer to 58.60111
 S DBALIENS=PADATA("DRUG DEV IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_","
 ;
 ; Reported Device Balance. Do this before Calculated Balance.
 ; File transaction's Device Balance for current device and drug to the Reported Device Balance
 N TRERR,FDA K DIERR S FDA(58.60111,DBALIENS,2)=BALANCE D FILE^DIE("","FDA","TRERR") K DIERR  ;*356
 ;
 ; Add transaction input quantity to Drug's calculated Device balance
 N TRERR,FDA,DOSFORM
 ; Update Drug Dosage Form from transaction
 S DOSFORM=$P($G(^PS(58.6,+$G(PS586IEN),0)),"^",6)
 S FDA(58.60111,DBALIENS,1)=$$DEVBAL(PADATA("SYS IEN"),PADATA("DEVICE IEN"),PADATA(4))
 I DOSFORM]"" S FDA(58.60111,DBALIENS,4)=DOSFORM
 K DIERR,TRERR D FILE^DIE("","FDA","TRERR") K DIERR ;*356
 Q 1
 ;
UPDRWBAL(PADATA,ERRMSG)  ; Update Drug (Drawer) balance
 ; Get current drawer total count of drug
 N DBALIENS,INVDATA,FDA,BALANCE,II,PSYS,PDEV,PDRW,PDRG,POCK,PTOT,PNOD
 S PSYS=+$G(PADATA("SYS IEN")),PDEV=+$G(PADATA("DEVICE IEN")),PDRW=+$G(PADATA("DRAWER IEN")),PDRG=+$G(PADATA("DRUG IEN"))
 S (POCK,PTOT)=0 F  S POCK=$O(^PS(58.601,PSYS,"DEVICE",PDEV,"DRAWER",PDRW,"SUB",POCK)) Q:'POCK  S PNOD=^(POCK,0) D
 .Q:$P(PNOD,"^",5)'=$G(PADATA(4))
 .S PTOT=$G(PTOT)+$P(PNOD,"^",2)
 N ERR
 ; Add the updated pocket totals to the drawer total for this drug
 S DBALIENS=PDRG_","_PDRW_","_PDEV_","_PSYS_","
 S FDA(58.601121,DBALIENS,1)=PTOT
 ; File the updated drawer total for this drug
 K DIERR,ERR D FILE^DIE("","FDA","ERR") K DIERR ;*356
 Q 1
 ;
UPCKDRW(PADATA,ERRMSG)  ; Add pocket/subdrawer sub-file entry to Drawer multiple
 N FDA       ;   Fileman data array
 N ERR       ;   Fileman error message array
 N POCKSUB   ;   POCKET_SUBDRAWER concatenated
 N DRGIENS   ;   IEN string for Drug field
 N INVDATA   ;   Data returned from PADE INVENTORY (#58.601) file
 N DOSFORM   ;   Dose Form from HL7 message from PADE vendor
 N PADATA6   ;   Signed value of inbound Quantity; positive for PADATA(5)=LOAD or RETURN, negative for PADATA(5)=DISPENSE/VEND/ISSUE and UNLOAD
 N PSPRVDT   ;   The last transaction date/time (date/time of the activity at the cabinet) this pocket was updated
 N PSPRVDIE  ;  The IEN of the last transaction date/time in the "PKUPDT" multiple
 ;
 S DOSFORM=$P($G(^PS(58.6,+$G(PS586IEN),0)),"^",6)
 S PADATA(10)=$TR(PADATA(10),"~~")_"~~"_+$G(PADATA(4))   ; Append subdrawer unique drug IEN suffix to handle different drugs in same subdr-pocket combo
 S:$G(PADATA(10))="" PADATA(10)=$P($G(^PS(58.6,+$G(PS586IEN),0)),"^",12) S:PADATA(10)="" PADATA(10)="~~"_+$G(PADATA(4))
 S POCKSUB=$G(PADATA(7))_"_"_$G(PADATA(10))  ;  "POCKET_SUBDRAWER" storage location
 K ERR,DIERR S PADATA("POCK/SUB IEN")=$$FIND1^DIC(58.601122,","_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",","MX",POCKSUB,,,"ERR") K DIERR ;*356
 ; Get the last date/time this drawer/subdrawer~drug/pocket was updated
 S PSPRVDIE=$O(^PS(58.601,+$G(PADATA("SYS IEN")),"DEVICE",+$G(PADATA("DEVICE IEN")),"DRAWER",+$G(PADATA("DRAWER IEN")),"PKUPDT","B",POCKSUB,""))
 ;
 S PSPRVDT=$P($G(^PS(58.601,+$G(PADATA("SYS IEN")),"DEVICE",+$G(PADATA("DEVICE IEN")),"DRAWER",+$G(PADATA("DRAWER IEN")),"PKUPDT",+$G(PSPRVDIE),0)),"^",2)
 ; If this current update contains a transaction date/time (i.e., activity date/time) older than the last update, don't update inventory
 I $G(PSPRVDT)&$G(PADATA(9)) I PADATA(9)<PSPRVDT D  Q 0
 .S ERRMSG="- OUTDATED TRANSACTION - "_$G(PADATA(1))_"."_$G(PADATA(2))_".DRUG="_$G(PADATA(4))_".POCKET="_$G(PADATA(7))
 .S ERRMSG=ERRMSG_".LAST UPDATED="_PSPRVDT_".TRANS DT="_PADATA(9)
 I 'PADATA("POCK/SUB IEN") D
 .S FDA(58.601122,"?+1,"_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",",.01)=POCKSUB K DIERR,ERR D UPDATE^DIE("","FDA","","ERR") K DIERR ;*356
 .K ERR,DIERR S PADATA("POCK/SUB IEN")=$$FIND1^DIC(58.601122,","_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",","MX",POCKSUB,,,"ERR") K DIERR ;*356
 I PADATA("POCK/SUB IEN") D  ; File Pocket and Subdrawer references in the POCK/SUB sub-file to ensure distinguishing between the two
 .N PKSBIENS S PKSBIENS=PADATA("POCK/SUB IEN")_","_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_","
 .S FDA(58.601122,PKSBIENS,1)=PADATA(4)                            ; DRUG
 .N PKBAL S PKBAL=PADATA(8)+PADATA(6) S FDA(58.601122,PKSBIENS,2)=$S(PKBAL<0:0,1:PKBAL)    ; NEW BALANCE (BALANCE FORWARD)
 .S FDA(58.601122,PKSBIENS,3)=PADATA(7)                            ; POCKET
 .S FDA(58.601122,PKSBIENS,4)=PADATA(10)                           ; SUBDRAWER
 .I DOSFORM]"" S FDA(58.601122,PKSBIENS,5)=DOSFORM                 ; DRUG DOSE FORM
 .K ERR,DIERR D FILE^DIE("","FDA","ERR") K DIERR ;*356
 .I '$G(PSPRVDT),($G(POCKSUB)]"") D
 ..N FDA S FDA(58.601123,"?+1,"_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",",.01)=POCKSUB
 ..S FDA(58.601123,"?+1,"_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",",1)=PADATA(9)
 ..K DIERR,ERR D UPDATE^DIE("","FDA","","ERR") K DIERR ;*356
 .K DIERR,ERR S PSPRVDIE=$$FIND1^DIC(58.601123,","_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_",","MX",POCKSUB,,,"ERR") K DIERR ;*356
 .I PSPRVDIE S DBALIENS=PSPRVDIE_","_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_"," D
 ..I $G(PADATA(9))?7N.".".8N S FDA(58.601123,DBALIENS,1)=PADATA(9)  ; TRANSACTION DATE/TIME
 ..Q:'$G(FDA(58.601123,DBALIENS,1))
 ..K DIERR,ERR D FILE^DIE("","FDA","ERR") K DIERR ;*356
 I 'PADATA("POCK/SUB IEN") S ERRMSG="Unable to file PADE pocket/subdrawer "_POCKSUB Q 0
 Q 1
 ;
UPCKBAL(PADATA,ERRMSG)  ; Update pocket / subdrawer balance
 ; Add transaction Quantity to Actual Begin Balance
 ;
 N PCK     ; Pocket ID
 N PCKBEG  ; Total of Actual Begin Balance
 N FDA     ; Fileman data array
 N TRNSAMT ; Transaction amount
 N PCKTOT  ; New balance of pocket
 N DRW     ; Drawer ID
 N SUBDRW  ; Subdrawer ID
 N DBALIENS ; IENS to System, Cabinet, Drawer, Drug, Pocket, Subdrawer
 ;
 S PCK=$G(PADATA(10))
 S TRNSAMT=$G(PADATA(6))
 S:$E(TRNSAMT)="-" TRNSAMT=+$P(TRNSAMT,"-",2)
 S TRNSAMT=$$TSIGN(.PADATA)_TRNSAMT
 S PCKBEG=$S($G(PADATA(8))&($G(PADATA(5))="C"):$G(PADATA(8)),1:$G(PADATA(12)))
 S PCKTOT=$S($E($G(PADATA(5)))="C":PCKBEG,1:PCKBEG+TRNSAMT)
 S PCKTOT=$S(PCKTOT<0:0,1:PCKTOT)
 S DRW=$G(PADATA(1.2))
 S SUBDRW=$G(PADATA(10))
 S DBALIENS=PADATA("POCK/SUB IEN")_","_PADATA("DRAWER IEN")_","_PADATA("DEVICE IEN")_","_PADATA("SYS IEN")_","
 S FDA(58.601122,DBALIENS,2)=PCKTOT
 ; File the updated drawer total for this drug
 K DIERR,ERR D FILE^DIE("","FDA","ERR") K DIERR ;*356
 Q 1
 ;
LOGERR(ERRMSG) ; Log error ERRMSG
 D ERROR^PSJPAD7U(.ERRMSG)
 Q
 ;
ORDIX(PS586IEN)  ; Computed ORDER to handle blank orders in primary patient sort PADE cross reference - "zz" = patient transaction types without order
 N ORDER,RESULTS,RESULT
 K DIERR,ERROR D GETS^DIQ(58.6,PS586IEN_",","4;15","","RESULT","ERROR") K DIERR ;*356
 S ORDER=$G(RESULT(58.6,PS586IEN_",",15))
 Q:$G(ORDER) ORDER
 Q:(",LOAD,UNLOAD,"[(","_$G(RESULT(58.6,PS586IEN_",",4))_",")) "INVENTORY"
 Q "zz"
 ;
DRWRBAL(PADESYS,PADEDEV,PADEDRWR,DRUGIEN)  ; Calculate drawer balance for PADE device=PADEDEV, drawer=PADEDRWR, drug=DRUGIEN
 ; PADESYS  =  PADE vendor system IEN from file 58.601
 ; PADEDEV  =  PADE device IEN from file 58.601
 ; PADEDRWR =  PADE drawer from file 58.601
 ; DRUGIEN  =  Drug IEN from file 58.601 (points to file 50)            
 K DRWBAL S DRWBAL=""                        ; Initialize returned balance
 N SUBDRW                                      ; Pocket_subdrawer IEN
 N OUT                                         ; Return array from LIST^DIC
 ;
 Q:'$G(PADESYS)!'$G(PADEDEV)!'$G(PADEDRWR) ""  ; We need system, device, and drawer to find a drawer balance
 Q:'DRUGIEN ""
 D LIST^DIC(58.601121,","_PADEDRWR_","_PADEDEV_","_PADESYS_",","1IE;2","","","","","","","","OUT","WTF")
 S SUBDRW=0 F  S SUBDRW=$O(OUT("DILIST","ID",SUBDRW)) Q:'SUBDRW  D
 .N DRUG S DRUG=$G(OUT("DILIST","ID",SUBDRW,1,"I")) I DRUG,(DRUG=DRUGIEN) S DRWBAL=DRWBAL+$G(OUT("DILIST","ID",SUBDRW,2))
 Q DRWBAL
 ;
DEVBAL(PADESYS,PADEDEV,DRUGIEN)  ; Calculate Device BALANCE for PADE device=PADEDEV drug=DRUGIEN
 Q $$DEVBAL^PSJPDRU1(PADESYS,PADEDEV,DRUGIEN)
 ;
TSIGN(PADATA) ; Determine if the transaction amount needs to be added or subtracted, depending on the transaction type
 Q $$TSIGN^PSJPDRU1(.PADATA)
