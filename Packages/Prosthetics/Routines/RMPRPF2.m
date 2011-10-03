RMPRPF2 ;HOIFO/TH,DDA - PFSS CHARGE ;8/18/05
 ;;3.0;PROSTHETICS;**98**;Feb 09, 1996
 ;
 ; This routine gets and stores a PFSS Charge ID, send charge message 
 ; and updated charge to IBB.
 ;
 ;  DBIA # 4665 for GETCHGID^IBBAPI and CHARGE^IBBAPI
 Q
 ;
EN ; Entry Point
 ; Quit if no Delivery Date
 I $P(^RMPR(660,RMPRDA,0),U,12)="" D DELAPD^RMPRPF1 Q
 ; If no PFSS Account Reference, then attempt to get one
 I $P(^RMPR(660,RMPRDA,"PFSS"),U,1)="" D
 . S RMPRSWDT=$P($$SWSTAT^IBBAPI(),"^",2)
 . ; quit if Delivery Date is not after PFSS Switch On date.
 . Q:$P(^RMPR(660,RMPRDA,0),"^",12)<RMPRSWDT
 . D EN2^RMPRPF1
 . Q
 ; If still no PFSS Account Reference, then record is not valid for PFSS- QUIT
 I $P(^RMPR(660,RMPRDA,"PFSS"),U,1)="" D DELAPD^RMPRPF1 Q
 ;
 S RMPRFLAG=1
 ; After Charge Msg sent (Charge ID exists); kill APD x-ref 
 ;     if PSAS HCPCS did not get updated AND
 ;     if QTY did not get updated AND 
 ;     if Total Cost did not get updated AND
 ;     if Ordering Provider did not get updated.
 I $P(^RMPR(660,RMPRDA,"PFSS"),U,2)'="" D
 . I $P($G(^RMPR(660,RMPRDA,1)),U,4)=$P($G(^RMPR(660,RMPRDA,"PFSS")),U,3) S RMPRFLAG=0   ; PSAS HCPCS
 . E  S RMPRFLAG=1 Q
 . I $P(^RMPR(660,RMPRDA,0),U,7)=$P($G(^RMPR(660,RMPRDA,"PFSS")),U,4) S RMPRFLAG=0   ; QTY
 . E  S RMPRFLAG=1 Q
 . I $P(^RMPR(660,RMPRDA,0),U,16)=$P($G(^RMPR(660,RMPRDA,"PFSS")),U,5) S RMPRFLAG=0  ; Total Cost
 . E  S RMPRFLAG=1 Q
 . I $P($G(^RMPR(660,RMPRDA,10)),U,6)=$P($G(^RMPR(660,RMPRDA,"PFSS")),U,6) S RMPRFLAG=0  ; Ordering Provider
 . E  S RMPRFLAG=1 Q
 I RMPRFLAG=0 D DELAPD^RMPRPF1
 ; 
 ; Quit if QTY=0 or null
 S (RMPRQTY,RMPRTC)=0
 S RMPRQTY=$P(^RMPR(660,RMPRDA,0),U,7)
 I RMPRQTY=0!(RMPRQTY="") D DELAPD^RMPRPF1 Q
 ; Quit if Total Cost=0 or null
 S RMPRTC=$P(^RMPR(660,RMPRDA,0),U,16)
 I RMPRTC=0!(RMPRTC="") D DELAPD^RMPRPF1 Q
 ;
 I RMPRFLAG=1 D
 . ; Check if PFSS Charge ID exists
 . I $P($G(^RMPR(660,RMPRDA,"PFSS")),U,2)="" D GETUCID,STORE
 . ; Get charge data
 . D GETDATA
 . ; Send charge data to IBB
 . D SENDCHRG
 . ; If charge msg was sent successfully, 
 . ; Update latest PSAS HCPCS, QTY, Total Cost, and Ordering Provider
 . ; then kill the x-ref
 . I RMPRCHRG'=0 D UPDATE D DELAPD^RMPRPF1
 D EXIT
 Q
 ;
GETUCID ; Obtain PFSS Charge ID
 S RMPRUCID=""
 S RMPRUCID=$$GETCHGID^IBBAPI()
 Q
 ;
STORE ; Store PFSS Charge ID
 L +^RMPR(660,RMPRDA)
 S DIE="^RMPR(660,",DA=RMPRDA
 S DR="101////^S X=RMPRUCID" D ^DIE
 L -^RMPR(660,RMPRDA)
 K DA,DIE,DR
 Q
 ;
GETDATA ; Get Charge Data
 S RMPRDFN=$P(^RMPR(660,RMPRDA,0),U,2)           ; Patient ID
 S RMPRARFN=$P($G(^RMPR(660,RMPRDA,"PFSS")),U,1)     ; PFSS Acct Ref
 S RMPRTYPE="CG" ; Charge Type = Debit
 S RMPRUCID=$P($G(^RMPR(660,RMPRDA,"PFSS")),U,2)     ; PFSS Charge ID
 ;
 ; FT1
 S RMPRDEL=$P(^RMPR(660,RMPRDA,0),U,12)
 S RMPRFT1(4)=RMPRDEL      ; Delivery Date
 S RMPRFT1(10)=RMPRQTY    ; Transaction Quantity
 S RMPRFT1(13)=423               ; Department Code
 ; Ordering Provider/Ordered by Code
 S RMPRORD=$P($G(^RMPR(660,RMPRDA,10)),U,6)
 S RMPRFT1(21)=RMPRORD
 ; Unit Cost = Total Cost/QTY
 S RMPRFT1(22)=RMPRTC/RMPRQTY
 ;
 ; PR1
 S RMPRHCPC=$P($G(^RMPR(660,RMPRDA,1)),"^",4)
 S RMPRHCDT=$P(^RMPR(660,RMPRDA,0),"^")
 D PSASHCPC^RMPOPF
 S RMPRPR1(3)=RMPRVHC   ; Procedure Code
 S RMPRPR1(4)=RMPRTHC   ; PSAS HCPCS text
 ; Procedure Functional Type - I:Stock Issue;P:Purchasing
 S RMPRPFT="",RMPRPFT=$S($P(^RMPR(660,RMPRDA,0),U,13)=11:"I",1:"P")
 S RMPRPR1(6)=RMPRPFT
 ;
 ; PROS
 S (RMPRVNDR,RMPROBL)=""
 S RMPRVNDR=$P(^RMPR(660,RMPRDA,0),U,9)
 S RMPRPROS(1)=RMPRVNDR       ; Vendor
 S RMPROBL=$E($P($G(^RMPR(660,RMPRDA,1)),U,1),1,30)
 S RMPRPROS(2)=RMPROBL         ; OBL#
 ;
DG1ZCL ; SET UP DATA FOR DG1 AND ZCL
 S RMPRBA1=$G(^RMPR(660,RMPRDA,"BA1"))
 S RMPRBA2=$G(^RMPR(660,RMPRDA,"BA2"))
 S RMPRBA3=$G(^RMPR(660,RMPRDA,"BA3"))
 S RMPRBA4=$G(^RMPR(660,RMPRDA,"BA4"))
 S RMPRDIAG=$P($G(^RMPR(660,RMPRDA,10)),"^",8)
 S RMPRICDT=$P(^RMPR(660,RMPRDA,0),"^")
 F I=1:1:4 D
 .; DG1
 .;CSV CHECK
 .S RMPRDRG=$P(@("RMPRBA"_I),"^")
 .S:+RMPRDRG RMPRDRG=$$STATCHK^ICDAPIU($P($G(^ICD9(RMPRDRG,0)),"^"),RMPRICDT)
 .Q:+RMPRDRG=0
 .S RMPRDG1(I,3)=$P(RMPRDRG,"^",2) ; Diagnosis Code
 .S RMPRDG1(I,6)="F"      ; Diagnosis Type
 .;
 .; ZCL
 .F J=2:1:8 I $P(@("RMPRBA"_I),"^",J)'="" D
 ..; Set type and value.  Overwrite null and zero values
 ..S:+$G(RMPRZCL(J-1,3))=0 RMPRZCL(J-1,2)=J-1,RMPRZCL(J-1,3)=$P(@("RMPRBA"_I),"^",J)
 ..Q
 .Q
 ; IF NO CONSULT DIAG, USE PROSTHETICS ONE
 I $G(RMPRDG1(1,3))="" D
 .S RMPRDRG=$$STATCHK^ICDAPIU($P($G(^ICD9(RMPRDIAG,0)),"^"),RMPRICDT)
 .Q:+RMPRDRG=0
 .S RMPRDG1(1,3)=$P(RMPRDRG,"^",2),RMPRDG1(1,6)="F"
 .Q
 Q
 ;
SENDCHRG ; Send Charge Data
 S RMPRCHRG=""
 S RMPRCHRG=$$CHARGE^IBBAPI(RMPRDFN,RMPRARFN,RMPRTYPE,RMPRUCID,.RMPRFT1,.RMPRPR1,.RMPRDG1,.RMPRZCL,"","",.RMPRPROS)
 Q
 ;
UPDATE ; Update latest fields
 L +^RMPR(660,RMPRDA)
 ; Store updates 102-latest PSAS HCPCS; 103-latest QTY; 104-latest Total Cost; 
 ; 105-latest Ordering Provider
 S DIE="^RMPR(660,",DA=RMPRDA
 S DR="102////^S X=RMPRHCPC;103////^S X=RMPRQTY;104////^S X=RMPRTC;"
 S DR=DR_"105////^S X=RMPRORD"
 D ^DIE
 L -^RMPR(660,RMPRDA)
 K DA,DIE,DR
 Q
 ;
EXIT ; Common exit point
 K RMPRFLAG,RMPRQTY,RMPRTC,RMPRCHRG,RMPRUCID,RMPRDFN
 K RMPRARFN,RMPRTYPE,RMPRFT1,RMPRPR1,RMPRCPT,RMPRRICP
 K RMPRDG1,RMPRDIAG,RMPRZCL,RMPRNODE,RMPRPROS,RMPRHCPC
 K RMRICPP,RMPRCPT
 Q
