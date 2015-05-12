IB3PSOU ;WOIFO/PLT-Outpatient Pharmacy Administrative Fee Change Update ;8/17/10  10:24
 ;;2.0;INTEGRATED BILLING;**437,510,538**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 QUIT  ;invalid entry
 ; Procedure updates rate schedules for default rate types or types
 ; specified in IBRATY by inactivating currently active rate
 ; schedules with date (IBDFFDT-1 ) that contain either RX Cost or
 ; TL Fill charge sets.  Procedure adds new rate schedules for the
 ; rate types defined, setting the activation date to IBDFFDT and
 ; updating any defined Fees or adjustment.  When rate schedules
 ; updated by this procedure also contain additional charge sets
 ; other than RX Cost or TL Fill then a separate rate schedule is
 ; created with those additional charge sets and the original fees
 ; and adjustments are maintained.
 ;
 ; Default Rate Types:  REIMBURSABLE INS., NO FAULT INS., TORT 
 ; FEASOR, WORKERS' COMP.
 ;
 ;Input parameters:
 ;
 ;  IBRATY:  (optional) rate type names separated by ^.  If defined
 ;           use these rate types instead of default types.
 ;  IBDFFDT: (required)  Effective date in form mm/dd/yyyy for new rate 
 ;           schedules.
 ;  IBADFE:  (optional)    not currently in use.
 ;  IBDISP:  (required) Dispense Fee: to contain the new annual 
 ;           administrative fee for rate schedules.
 ;  IBADJUST: (optional) if defined must be MUMPS code to define a
 ; unique adjustment to the rate schedule.  If not defined default
 ; adjustment is S X = X + $G(IBADFE) + $G(IBDISP)
 ;
 ;ibraty=rate type name of file #399.3^rate type name^rate type name...
 ;   =""for all-reimbursable ins., no fault ins., tort feasor, works' comp.
 ;ibeffdt=effective external date (mm/dd/yyyy)
 ;ibadfe=administrative fee (ddd.cc)
 ;ibdisp=dispensing fee (ddd.cc)
 ;ibadjust=adjustment mumps code
ENT(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST) ;update admin/disp fee and adjustment of file #363
 N A,B,X,Y,IBA,IBB,IBC,IBINADT,IBRFRC,IBRCOST
 S:IBRATY="" IBRATY="REIMBURSABLE INS.^NO FAULT INS.^WORKERS' COMP.^TORT FEASOR"
 S IBRATY="^"_IBRATY_"^"
 S X=IBEFFDT D ^%DT S IBEFFDT=Y,IBINADT=$$FMADD^XLFDT(IBEFFDT,-1)
 ;get iens of 'tl-rx fill' and 'rx cost' of charge set file #363.1
 ;set ien of 'ia-rx fill' in ibrfrc to create ia-rx rate schedule *538
 S (IBRFRC,IBRCOST)="^" F A="TL-RX FILL","RX COST","IA-RX FILL" S B=0 F B=$O(^IBE(363.1,"B",A,B)) QUIT:'B  S IBRFRC=IBRFRC_B_"^" S:A="RX COST" IBRCOST=IBRCOST_B_"^"
 ;loop through charge set iens of 'ti-rx til' and'rx cost' in ibrfrc
 F IBA=2:1 S IBB=$P(IBRFRC,U,IBA) QUIT:'IBB  D
 . N IBIEN,IBRTNM
 . ;find rate schedule with no inactive date, effective date<ibeffdt, rate type contained in ibraty
 . S IBIEN=0 F  S IBIEN=$O(^IBE(363,"C",IBB,IBIEN)) QUIT:'IBIEN  S A=^IBE(363,IBIEN,0),IBRTNM=$P(^DGCR(399.3,$P(A,U,2),0),U) I '$P(A,U,6),$P(A,U,5)<IBEFFDT,$P(A,U,2),IBRATY[("^"_IBRTNM_"^") D
 .. ;copy-to new entry, and copy-to new entry again if the copy-from entry has charge set other than 'tr-rf fill' and 'rx cost'
 .. S IBC=$$COPY(IBIEN,"") S:IBC IBC=$$COPY(IBIEN,1)
 .. ;inactivate the copy-from entry.
 .. D INACT(IBIEN)
 .. QUIT
 . QUIT
 QUIT
 ;
 ;
 ;ibien=the ien of the copy-from rate schedule file #363
 ;ibc="" copy and update adm, disp, adj including only charge sets for 'tr-rf fill' and 'rx cost'
 ;   =1 copy and no update including all other charge set only
COPY(IBIEN,IBC) ;extrinsic function ="" or 1
 N IBD,IBE,IBNIEN,IBRS0,IBRS1,IBRS10,IBRS11,IBRSCS
 ;copy-to a new entry from ibien containing charge set iba
 N IBNRX S IBNRX=""
 S IBRS0=$G(^IBE(363,IBIEN,0)),IBRS1=$G(^(1)),IBRS10=$G(^(10)),IBRS11=$G(^(11)) D  QUIT:'$G(IBNIEN)
 . ;add new charge set hmn/inelig-rx *510
 . I 'IBC,'$O(^IBE(363,"B",$P($P(IBRS0,U),"-")_"-RX",0)) S IBNRX=$P($P(IBRS0,U),"-")_"-RX"
 . ;add new entry of file #363
 . N DO,DIC,DA,X,DINUM,Y,DTOUT,DUOUT
 . N DIE,DA,DR
 . S DIC="^IBE(363,",DIC(0)="F",X=$S(IBNRX="":$P(IBRS0,U),1:IBNRX)
 . ;copy data fields with new administration fee
 . S DIC("DR")=".02////"_$P(IBRS0,U,2)_";.03////"_$P(IBRS0,U,3)_";.04////"_$P(IBRS0,U,4)_";.05////"_IBEFFDT
 . ;reserve adm, disp values
 . I IBC S DIC("DR")=DIC("DR")_";1.01////"_$P(IBRS1,U)_";1.02////"_$P(IBRS1,U,2)
 . ;update adm, disp values
 . I 'IBC S DIC("DR")=DIC("DR")_";1.01////"_$G(IBDISP)_";1.02////"_$G(IBADFE)
 . D FILE^DICN I Y<0 D MES^XPDUTL("The Rate Schedule "_X_" update failed") QUIT
 . S IBNIEN=+Y
 . ;set adjustment value
 . S DIE="^IBE(363,",DA=IBNIEN,DR="10////"_$S('IBC:$G(IBADJUST),1:IBRS10)
 . D ^DIE
 . QUIT
 ;copy/edit charge set multiple.
 S IBRSCS=0 F  S IBRSCS=$O(^IBE(363,IBIEN,11,IBRSCS)) QUIT:'IBRSCS  S IBD=^(IBRSCS,0) D
 . N DO,DIC,DA,X,DINUM,Y,DTOUT,DUOUT
 . I IBC,IBRFRC[("^"_$P(IBD,U)_"^") QUIT
 . I 'IBC,IBRFRC'[("^"_$P(IBD,U)_"^") S IBE=1 QUIT
 . ;change charge set 'tr-rf fill' to 'rx cost'
 . I 'IBC,IBRCOST'[("^"_$P(IBD,U)_"^") S $P(IBD,U)=$P(IBRCOST,U,2),$P(IBD,U,2)=1
 . ;not 'rx cost' the auto add is null - comment out *510
 . ;S:IBC $P(IBD,U,2)=""
 . S DIC="^IBE(363,"_IBNIEN_",11,",DIC(0)="F",DA(1)=IBNIEN,X=$P(IBD,U),DINUM=$S(IBNRX="":IBRSCS,1:1),DIC("DR")=".02////"_$P(IBD,U,2)
 . D FILE^DICN I Y<0 D MES^XPDUTL("The Rate Schedule "_$P(IBRS0,U)_"'s Charge Set "_X_" update failed")
 . QUIT
 QUIT $G(IBE)
 ;
 ;ibien=the ien of the file #363
INACT(IBIEN) ;inactivate the copy-from rate schedule
 N D,D0,DI,DIC,DQ,DIE,DA,DR,DTOUT
 S DIE="^IBE(363,",DA=IBIEN,DR=".06////"_IBINADT D ^DIE
 QUIT
 ;
