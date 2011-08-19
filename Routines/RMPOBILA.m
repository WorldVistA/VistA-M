RMPOBILA ;HIN/RVD - BILLING TRANSACTIONS (ADD/DEL PATIENT) ;3/18/99
 ;;3.0;PROSTHETICS;**29,46,41**;Feb 09, 1996
 ;
ADD K DIC,RMPODFN
 S DIC("S")="I '$D(^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,""V"",+Y))"
 S DIC="^RMPR(665,",DIC(0)="QEAMZ" D ^DIC I Y<0!$$QUIT G EXIT
 S RMPODFN=+Y I $$VEN(RMPOVDR)<1 W !,"** Error: ",$$STAT(RMPODFN),! G EXIT
 I $D(^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,"V",RMPODFN)) G EXIT
GETPAT ;get patient information
 S ZXITM=0
 F  S ZXITM=$O(^RMPR(665,RMPODFN,"RMPOC",ZXITM)) Q:ZXITM'>0  D
 . S ZX1=$G(^RMPR(665,RMPODFN,"RMPOC",ZXITM,0))
 . Q:$P(ZX1,U,2)'=RMPOVDR  D BUILDP,BUILDI W !,"Item ",$P(ZX1,U,1)," was added to Billing Transaction....",!
 Q
 ;
VEN(RVEN) ; Determine whether to include trx for RMPODFN
 ;
 ; Do NOT process if not at correct site.
 Q:$P($G(^RMPR(665,RMPODFN,"RMPOA")),U,7)'=RMPOXITE -1
 ;
 ; Do NOT process if no Boiler-plate
 Q:'$D(^RMPR(665,RMPODFN,"RMPOA")) -2
 ;
 ; Do NOT process if Inactivation date less the billing date.
 S RMPOINDT=$P($G(^RMPR(665,RMPODFN,"RMPOA")),U,3)
 I $G(RMPOINDT) Q:RMPOINDT<RMPORVDT -3
 ;
 ; Do NOT process if no Rx
 Q:'$D(^RMPR(665,RMPODFN,"RMPOB",0)) -4
 ;
 ; 1st find correct Rx
 S RMPORX=$O(^RMPR(665,RMPODFN,"RMPOB","B"),-1)
 Q:'RMPORX -5
 ;
 ; Quit if the Rx Expiration Date is before the billing period
 Q:$P(^RMPR(665,RMPODFN,"RMPOB",RMPORX,0),U,3)<(RMPORVDT) -6
 ;
 ; Quit if there are no items.
 Q:$O(^RMPR(665,RMPODFN,"RMPOC",0))'>0 -7
 ;
 I $G(RVEN)>0 Q $$VDRSTAT(RVEN)
 Q 1
 ;
VDRSTAT(VDR) ;
 S ZXITM=0,FOUND=0
 F  S ZXITM=$O(^RMPR(665,RMPODFN,"RMPOC",ZXITM)) Q:ZXITM'>0  D
 . I $P($G(^RMPR(665,RMPODFN,"RMPOC",ZXITM,0)),U,2)=VDR S FOUND=1
 Q $S(FOUND=1:1,1:-8)
 Q
 ;
BUILDP ;Now the Patient level
 Q:$D(^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,"V",RMPODFN))  ; DONE
 K DA,DIC,DD,DO
 S DA(3)=RMPOXITE,DA(2)=RMPORVDT,DA(1)=RMPOVDR,(DINUM,X)=RMPODFN
 S DIC("P")=$P(^DD(665.7231,9,0),U,2),DIC(0)="L",ZV=",""V"","
 S DIC="^RMPO(665.72,"_DA(3)_",1,"_DA(2)_",1,"_DA(1)_ZV
 D FILE^DICN
 Q
 ;
BUILDI ; BUILD ITEM (REQUIRES ZX1 = ENTIRE ITEM NODE FROM FILE #665)
 ;Finally, set up the item multiple
 K DA,DIC,DD,DO,DINUM,DIE,DR
 S DA(4)=RMPOXITE,DA(3)=RMPORVDT,DA(2)=RMPOVDR,DA(1)=RMPODFN
 S X=$P(ZX1,U),ZV=",""V"","
 S DIC="^RMPO(665.72,"_DA(4)_",1,"_DA(3)_",1,"_DA(2)_ZV_DA(1)_",1,"
 S DIC("P")=$P(^DD(665.72319,1,0),U,2),DIC(0)="L"
 D FILE^DICN
 S DIE=DIC,DA=+Y
 ;Do some calculations
 ;Multiply the unit cost by the number of units
 S RMPOTOT=$P(ZX1,U,3)*$P(ZX1,U,4)
 S RMREMARK=$P(ZX1,U,9)
 S DR="1////"_$P(ZX1,U,11)             ; PRIMARY ITEM
 S DR=DR_";2////"_$P(ZX1,U,7)          ; HCPCS CODE
 S DR=DR_";3////"_$P(ZX1,U,6)          ; FUND CONTROL POINT
 S DR=DR_";4///^S X=RMREMARK"           ; REMARKS
 S DR=DR_";5///"_$P(ZX1,U,4)           ; UNIT COST
 S DR=DR_";6///"_$J($G(RMPOTOT),1,2)   ; TOTAL (QTY X UNIT COST)
 S DR=DR_";7///"_$P(ZX1,U,3)           ; QUANTITY
 S DR=DR_";8////"_$P(ZX1,U,8)          ; ICD-9 CODE
 S DR=DR_";12////"_ZXITM               ; IEN OF ITEM
 S DR=DR_";13////"_$P(ZX1,U,10)        ; ITEM TYPE
 S DR=DR_";14////"_$P(ZX1,U,5)         ; UNIT OF ISSUE
 S DR=DR_";17////"_$P(ZX1,U,12)        ; RENTAL FLAG
 S DR=DR_";18////"_$P(ZX1,U,13)        ; OXYGEN CONSERVING FLAG
 D ^DIE
 Q
STAT(RMPODFN) ;STATUS OF PT FOR GIVEN BUILD
 S OK=$$VEN($G(RMPOVDR))
 Q:OK=1 "OK"
 Q:OK=-1 "Different Home Oxygen Contract Location"
 Q:OK=-2 "No Home Oxygen Information"
 Q:OK=-3 "Deactivated"
 Q:OK=-4 "No RX on file"
 Q:OK=-5 "No RX on file"
 Q:OK=-6 "RX expires prior to billing period"
 Q:OK=-7 "No items on file"
 Q:OK=-8 "No items for vendor"
 Q "Other Unknown Error"
 Q
QUIT() S QUIT=$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q QUIT
 ;
EXIT ;Kill variables before quitting
 K DIC,RMPODFN,DA,DIR,Y,X,ZXITM
 Q
 ;
DEL I '$$OK2EDIT D  Q
 . W !,$C(7)_"Cannot DELETE a Posted or Partially Posted Transactions.  "
 . K DIR S DIR(0)="E" D ^DIR
 I $$LOCKED D  Q
 . W !,$C(7)_"Record is locked. " K DIR S DIR(0)="E" D ^DIR
 K DIR S DIR("A")="Are you sure you want to delete patient from this month's billing " S DIR("B")="N",DIR(0)="Y"
 D ^DIR I Y=0!$D(DTOUT)!$D(DUOUT) Q
 S DA(3)=RMPOXITE,DA(2)=RMPORVDT,DA(1)=RMPOVDR,DA=RMPODFN
 S DIK="^RMPO(665.72,"_DA(3)_",1,"_DA(2)_",1,"_DA(1)_","_"""V"""_","
 D ^DIK
 W:'$D(^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,"V",RMPODFN,0)) !!,"Patient deleted from billing..."
 Q
OK2EDIT() ;
 ;
 Q $P(^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,"V",RMPODFN,0),U,3)'="Y"&($P(^(0),U,3)'="P")
 Q
LOCKED() ;
 ;
 L +^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,"V",RMPODFN,0):2
 Q '$T
