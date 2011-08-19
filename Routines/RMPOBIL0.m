RMPOBIL0 ;EDS/MDB/HINES CIOFO/HNC - HOME OXYGEN BILLING TRANSACTIONS ;7/24/98  07:34
 ;;3.0;PROSTHETICS;**29,46,50,147**;Feb 09, 1996;Build 4
 ;
 ; ODJ - patch 50 - 7/25/00 fix DIR date call in PREBILL sub. so as to
 ;                          interpret 2 digit entry as month
 ;                          (FM interpets this as year)
 ;
OLD ; Enter from top (OLD code)
 ;
 D MAIN  ; D ^RMPOBIL1
 ;Q:'$D(RMPODATE)!'$D(RMPOVDR)!'$D(RMPOXITE)!QUIT
 I '$D(RMPODATE)!'$D(RMPOVDR)!'$D(RMPOXITE)!QUIT D EXIT Q
 K DIC,DIR,DIR,DD,DA,DR,DO  ;CLEANUP FOR L/M
 D EN^RMPOLM  ; -- List manager code
 D ACCEPT^RMPOPST3,EXIT
 Q
MAIN ; Proper entry point
 D HOME^%ZIS
 S QUIT=0
 D HOSITE^RMPOUTL0 Q:('$D(RMPOXITE))!QUIT
 D CKSITE
 D MONTH("AEQLMZ") Q:$D(RMPODATE)=0!QUIT
 D VENDOR("AEQLMZ") Q:$D(RMPOVDR)=0!QUIT
 ;Generate Vendor/Month of transactions
 I $O(^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,0))="V" Q
 D GEN1
 Q
VENDOR(LAYGO) ;Select Vendor
 ;
 K DIC,DA,RMPOVDR
 S DA(2)=RMPOXITE,DA(1)=RMPORVDT
 S DIC="^RMPO(665.72,"_DA(2)_",1,"_DA(1)_",1,"
 S DIC("P")=$P(^DD(665.723,1,0),U,2)
 S DIC(0)=$G(LAYGO,"AEQMZ") D ^DIC Q:(Y<0)!$$QUIT
 S RMPOVDR=+Y
 ;S RMPOVDR=$P(Y,U,2)  ; PER ANALYST
 I $P(Y,U,3)>0 D
 . S DIE=DIC,DA=+Y,DR="1///NOW" D ^DIE
 Q
CKSITE ;Set up Site in Billing if it is not there
 I '$D(^RMPO(665.72,RMPOXITE,0)) D
 . K DIC,DD,DO,DA
 . S (DINUM,X)=RMPOXITE,DIC="^RMPO(665.72,",DIC(0)="L" D FILE^DICN
 Q
MONTH(LAYGO) ;Determine Billing Month
 ;
 K DIC,DA,RMPODATE
 S DA(1)=RMPOXITE,DIC="^RMPO(665.72,"_DA(1)_",1,"
 S DIC("P")=$P(^DD(665.72,1,0),U,2)
 S DIC(0)=$G(LAYGO,"AEMQZ") D ^DIC Q:(Y<0)!$$QUIT
 S RMPODATE=+Y,RMPOMTH=Y(0,0)
 S RMPORVDT=RMPODATE
 Q
QUIT() S QUIT=$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q QUIT
 ;
BUILDM ; BUILD MONTH
 ; Set up Month
 Q:$D(^RMPO(665.72,RMPOXITE,1,RMPORVDT))  ; ALREADY DONE..
 K DIC,DA
 S X=RMPODATE,DINUM=RMPORVDT
 S DA(1)=RMPOXITE,DIC(0)="L"
 S DIC="^RMPO(665.72,"_DA(1)_",1,",DIC("P")=$P(^DD(665.72,1,0),U,2)
 D FILE^DICN
 Q
GEN1 ; ALL PATIENTS FOR A GIVEN VENDOR
 W !,"Generating "_RMPOMTH_" billing transactions for "
 W $$VDRNM^RMPOPED(RMPOVDR),!!,"This may take a while..."
 ;
 ; D BUILDM
 ;Copy Patient Boiler-plates
 ;fix to get ALL patients from same activation date
 S (ACTIVDT,RMPODFN)=0
 F  S ACTIVDT=$O(^RMPR(665,"AHO",ACTIVDT)) Q:ACTIVDT'>0  D
 . S RMPODFN=0
 . F  S RMPODFN=$O(^RMPR(665,"AHO",ACTIVDT,RMPODFN)) Q:RMPODFN'>0  D:$$OK2BLD>0 GEN2
 K DIR S DIR(0)="E" D ^DIR Q:$$QUIT
 Q
GEN2 ;INNER LOOP
 ;W !,RMPODFN
 S ZXITM=0
 F  S ZXITM=$O(^RMPR(665,RMPODFN,"RMPOC",ZXITM)) Q:ZXITM'>0  D
 . S ZX1=$G(^RMPR(665,RMPODFN,"RMPOC",ZXITM,0))
 . Q:$P(ZX1,U,2)'=RMPOVDR
 . D BUILDP,BUILDI
 Q
OK2BLD(VENDOR) ; Determine whether to include trx for RMPODFN
 ;
 ; Do NOT process if not at correct site.
 Q:$P($G(^RMPR(665,RMPODFN,"RMPOA")),U,7)'=RMPOXITE -1
 ;
 ; Do NOT process if no Boiler-plate
 Q:'$D(^RMPR(665,RMPODFN,"RMPOA")) -2
 ;
 ; Do NOT process if Inactivation date less the billing date.
 S RMPOINDT=$P($G(^RMPR(665,RMPODFN,"RMPOA")),U,3)
 I $G(RMPOINDT) Q:RMPOINDT<RMPODATE -3
 ;Q:$P($G(^RMPR(665,RMPODFN,"RMPOA")),U,3) -3
 ;
 ; Do NOT process if no Rx
 Q:'$D(^RMPR(665,RMPODFN,"RMPOB",0)) -4
 ;
 ; 1st find correct Rx
 S RMPORX=$O(^RMPR(665,RMPODFN,"RMPOB","B"),-1)
 Q:'RMPORX -5
 ;
 ; Quit if the Rx Expiration Date is before the billing period
 ; Expiration date check removed with patch *147  6/24/2008
 ;Q:$P(^RMPR(665,RMPODFN,"RMPOB",RMPORX,0),U,3)<(RMPODATE) -6
 ;
 ; Quit if there are no items.
 Q:$O(^RMPR(665,RMPODFN,"RMPOC",0))'>0 -7
 ;
 I $G(VENDOR)>0 Q $$VDRSTAT(VENDOR)
 Q 1
VDRSTAT(VDR) ;
 ;
 S ZXITM=0,FOUND=0
 F  S ZXITM=$O(^RMPR(665,RMPODFN,"RMPOC",ZXITM)) Q:ZXITM'>0  D
 . I $P($G(^RMPR(665,RMPODFN,"RMPOC",ZXITM,0)),U,2)=VDR S FOUND=1
 Q $S(FOUND=1:1,1:-8)
 Q
BUILDV ; Set up the VENDOR multiple
 Q:$D(^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR))  ; ALREADY DONE...
 K DA,DIC,DD,DO
 S DA(2)=RMPOXITE,DA(1)=RMPORVDT,(DINUM,X)=RMPOVDR
 S DIC="^RMPO(665.72,"_DA(2)_",1,"_DA(1)_",1,"
 S DIC("P")=$P(^DD(665.723,1,0),U,2),DIC(0)="L"
 D FILE^DICN
 Q
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
 S DR=DR_";4///^S X=RMREMARK"          ; REMARKS
 S DR=DR_";5///"_$P(ZX1,U,4)           ; UNIT COST
 S DR=DR_";6///"_$J($G(RMPOTOT),1,2)   ; TOTAL (QTY X UNIT COST)
 S DR=DR_";7///"_$P(ZX1,U,3)           ; QUANTITY
 S DR=DR_";9////"_$P(ZX1,U,8)          ; ICD-9 CODE
 S DR=DR_";12////"_ZXITM               ; IEN OF ITEM
 S DR=DR_";13////"_$P(ZX1,U,10)        ; ITEM TYPE
 S DR=DR_";14////"_$P(ZX1,U,5)         ; UNIT OF ISSUE
 D ^DIE
 Q
PREBILL ; Proper entry point
 D HOME^%ZIS
 S (RMEND,RMPOPRT,QUIT)=0
 D HOSITE^RMPOUTL0 Q:('$D(RMPOXITE))!QUIT
 D  Q:$D(RMPODATE)=0!QUIT
 . K DIR,RMPODATE
 . S DIR(0)="D^^I +X>0,+X'>12 S X=$E(100+X,2,3)_$E(DT,2,3) K Y,%DT D ^%DT"
 . ;S DIR(0)="D"
 . S DIR("A")="ENTER BILLING MONTH"
 . D ^DIR Q:$$QUIT!(Y<1)
 . S RMPODATE=$E(Y,1,5)_"00"
 . I Y X ^DD("DD") W ?25,Y
 . Q
 S DIC="^RMPR(665,",L=0
 S BY="[RMPO-BILLING-PRESORT]"
 S FLDS="[RMPO-BILLING-PRESORT]"
 S DIS(0)="S RMPODFN=D0,Z=$$OK2BLD^RMPOBIL0 I $D(^RMPR(665,RMPODFN,""RMPOA"")) I (Z'=1)&(Z'=-3)&($P(^RMPR(665,RMPODFN,""RMPOA""),U,7)=RMPOXITE)"
 S DIOEND="I $G(Y)'[U S RMEND=1 S:IOST[""P-"" RMPOPRT=1"
 D EN1^DIP
 I RMPOPRT=0,$G(RMEND) K DIR S DIR(0)="E" D ^DIR
 D EXIT
 Q
BLDSTAT(RMPODFN) ;STATUS OF PT FOR GIVEN BUILD
 ;
 S OK=$$OK2BLD($G(RMPOVDR))
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
EXIT ;Kill variables before quitting
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
