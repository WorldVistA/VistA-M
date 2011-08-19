RMPOBIL2 ;EDS/MDB - HOME OXYGEN BILLING TRANSACTIONS ;7/28/98
 ;;3.0;PROSTHETICS;**29,44,46,50,110**;Feb 09, 1996;Build 10
 ; ODJ patch 50 - Fix crashes reported in NOIS LIT-0600-70930
 Q
2319 ; SHOW PAGE 8 OF 2319
 ;S:$D(RMPRDFN)&('$D(RMPODFN)) RMPODFN=RMPRDFN
 S RMPODFN=RMPRDFN
 D BPI,DPI
 K DIR S DIR(0)="E" D ^DIR I $$QUIT G ASK1^RMPRPAT
 D ^RMPOBIL5
 K PTI,I,RX,Y,DT1,DT2,TRX,IENS,DFN
 Q
QUIT() S QUIT=$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q QUIT
EQUIT() S QUIT=$D(DTOUT)!$D(Y) Q QUIT
LJ(S,W,C) ; Left justify S in a field W wide padding with char C
 ;
 S C=$G(C," ")   ; Default pad char is space
 I $L(S)'=W S $P(S,C,W-$L(S)+$L(S,C))=""
 Q $E(S,1,W)
EDIT ;NEW billing transaction edit module
 ;This module edits a single billing transaction (trx)
 ;a single trx is identified by 4 values
 ;  site, billing month, vendor, and patient
 ;  these four values represent an entry in file 665.72
 ;
 Q:'($D(RMPOXITE)&$D(RMPORVDT)&$D(RMPOVDR)&$D(RMPODFN))
 Q:'$D(^RMPO(665.72,+RMPOXITE,1,+RMPORVDT,1,+RMPOVDR,"V",+RMPODFN))
 ; previous two lines for development only - shouldn't be needed
 ;
 D ITEM
EXIT L -^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,"V",RMPODFN,0)
 K ITM,IEN,IENS,ITMACT,PTI,TMP,ZX1,TOT,T910,OTH,A,RX,TRX,DT1,DT2
 K DIC,DIE,DA,DR,DO,DD,DIR,DIK,DIROUT,DUOUT
 K TIEN,FCP,DFN,I,ITEM,NEW,QUIT,TOTAL,VADM,X,Y,Z,Z1,Z2,ZV,Z3
 K PSTFLG,PITM,BACKPTR,POSTED,SUSP,DFCP,C,W,S,CIEN,RMIT,RMDIC
 Q
QUIK ; QUICK ITEM EDIT
 ;
 I '$$OK2EDIT D  Q
 . W !,$C(7)_"Cannot edit Accepted Transactions.  "
 . W "Please 'Unaccept' first." K DIR S DIR(0)="E" D ^DIR
 I $$LOCKED D  Q
 . W !,$C(7)_"Record is locked. " K DIR S DIR(0)="E" D ^DIR
 D ITEMD
 F I=1:1:IEN D  Q:QUIT
 . W !,ITM(I)
 .K DR D SDICE
 .S DA=IEN(I),DR="7" D ^DIE Q:$$EQUIT
 .S Z=^RMPO(665.72,DA(4),1,DA(3),1,DA(2),"V",DA(1),1,DA,0)
 .S Z1=$P(Z,U,7),Z2=$P(Z,U,5),Z3=$P(Z,U,11)
 .S DR="6///"_((Z1*Z2)-Z3) D ^DIE Q:$$EQUIT
 D BII,DII
 K DIR S DIR(0)="E" D ^DIR Q:$$QUIT
 G EXIT
 Q
ITEM ; Main edit loop
 ;
 I '$$OK2EDIT D  Q
 . W !,$C(7)_"Cannot edit Accepted Transactions.  "
 . W "Please 'Unaccept' first." K DIR S DIR(0)="E" D ^DIR
 I $$LOCKED D  Q
 . W !,$C(7)_"Record is locked. " K DIR S DIR(0)="E" D ^DIR
 ;
ITEMLOOP ;
 ;
 S QUIT=0
 D ITEMD
 ; ask for ACTION, quit if <return>, timeout, etc
 S ITMACT=$$ITEMO Q:$$QUIT!(ITMACT="")
 ; if they entered 'A', do ADD ITEM, then edit it
 I ITMACT="A" D ITEMA Q:QUIT!(ITEM="")  D ITEME Q:QUIT  G ITEMLOOP
 ; if they entered 'D', select an item, then delete it
 I ITMACT="D" D ITEMS Q:QUIT!(ITEM="")  D ITEMK G ITEMLOOP
 ; if they entered 'E', select an item, then edit it
 I ITMACT="E" D ITEMS Q:QUIT!(ITEM="")  D ITEME Q:QUIT  G ITEMLOOP
 ; if they entered 'Z', select an item, then zero it
 I ITMACT="Z" D ITEMS Q:QUIT!(ITEM="")  D ITEMZ Q:QUIT  G ITEMLOOP
 G ITEMLOOP
 Q
OK2EDIT() ;
 ;
 Q $P(^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,"V",RMPODFN,0),U,2)'="Y"
 Q
LOCKED() ;
 ;
 L +^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,"V",RMPODFN,0):2
 Q '$T
 Q
ITEMD ; Display items
 ;
 D BPI,DPI,BII,DII
 Q
BPI ; Build pt info hdr
 K PTI
 ; Name,SSN
 S DFN=RMPODFN D DEM^VADPT
 S PTI(1)=VADM(1)_"    "_$P(VADM(2),U,2)
 ; Current Rx (IEN on ACT DATE)
 S RX=$O(^RMPR(665,RMPODFN,"RMPOB"," "),-1)
 Q:'RX
 S Y=$P(^RMPR(665,RMPODFN,"RMPOB",RX,0),U) X ^DD("DD") S DT1=Y
 S Y=$P(^RMPR(665,RMPODFN,"RMPOB",RX,0),U,3) X ^DD("DD") S DT2=Y
 S PTI(2)="Current Prescription (#"_RX_")"
 S PTI(3)="      Active Date: "_DT1_"    Expiration Date: "_DT2
 ; Rx Remarks
 K TRX
 S IENS=RX_","_RMPODFN_","
 D GETS^DIQ(665.193,IENS,3,,"TRX")
 S I=0 F  S I=$O(TRX(665.193,IENS,3,I)) Q:I=""  D
 . S PTI(3+I)="      "_TRX(665.193,IENS,3,I)
 Q
DPI ; Display pt info hdr
 S I=0 F  S I=$O(PTI(I)) Q:I=""  W !,PTI(I)
 Q
BII ; Build item info array
 K TRX,ITM,TOT,SUSP,POSTED,PITM,IEN,CIEN
 S SUSP=0,CIEN=1
 S IENS=RMPODFN_","_RMPOVDR_","_RMPORVDT_","_RMPOXITE
 D GETS^DIQ(665.72319,IENS,"**","IE","TRX")
 S ZX1=""
 F IEN=0:1 S ZX1=$O(TRX(665.723191,ZX1)) Q:ZX1=""  D
 . K TMP M TMP=TRX(665.723191,ZX1)
 . F Z=5,6,10 S TMP(Z,"E")=$J($G(TMP(Z,"E")),0,2)
 . S TIEN=+ZX1 D BIIL
 K TMP
 S TMP(2,"E")="HCPCS"
 S TMP(.01,"E")="Description"
 S TMP(3,"E")="FCP"
 S TMP(7,"E")="Qty"
 S TMP(5,"E")="Cost"
 S TMP(6,"E")="Total"
 S TMP(8,"I")=" "
 S TMP(10,"E")="Susp."
 S (CIEN,TIEN)=0 D BIIL
 Q
BIIL ;Build detail line
 ;
 S:TIEN IEN(CIEN)=TIEN ;S:TIEN IEN(TIEN)=TIEN
 S ITM(CIEN)="   "
 ;S:TIEN ITM(TIEN)=$J(TIEN,2)_"."                     ; ITEM #
 S:TIEN ITM(CIEN)=$J(CIEN,2)_"."                          ; ITEM #
 S PSTFLG=$S($G(TMP(8,"I"))="Y":"p",1:" ")
 S BACKPTR=$G(TMP(12,"I"))
 S TMP(.01,"E")=$G(TMP(.01,"E"))_"                          "
 S ITM(CIEN)=ITM(CIEN)_$$LJ(PSTFLG,2)                      ; POSTED
 S ITM(CIEN)=ITM(CIEN)_$$LJ($G(TMP(2,"E")),7)              ; HCPCS
 S ITM(CIEN)=ITM(CIEN)_$$LJ($G(TMP(.01,"E")),30)           ; ITEM DESCR
 S ITM(CIEN)=ITM(CIEN)_"  "_$$LJ($P($G(TMP(3,"E"))," "),5)  ; FCP
 S ITM(CIEN)=ITM(CIEN)_$J($G(TMP(7,"E")),5)                 ; QTY
 S ITM(CIEN)=ITM(CIEN)_$J($G(TMP(5,"E")),8)                 ; UNIT COST
 S ITM(CIEN)=ITM(CIEN)_$J($G(TMP(10,"E")),8)                ; SUSP
 S ITM(CIEN)=ITM(CIEN)_$J($G(TMP(6,"E")),8)                 ; QTY * CST
 ; Quit if we're doing the header
 Q:TIEN=0
 I $G(TMP(8,"I"))="Y" S POSTED(TIEN)=""
 ; Do totals while we're here
 S FCP=+TMP(3,"E"),TOTAL=TMP(6,"E")
 S TOT(FCP)=$G(TOT(FCP))+TOTAL
 S TOT=$G(TOT)+TOTAL
 S SUSP=SUSP+$G(TMP(10,"E")),CIEN=CIEN+1
 Q
DII ; Display item info array
 Q:'$G(IEN)
 W ! F I=0:1:IEN W !,ITM(I)
 W !!,"TOTAL COST",?72,$J(TOT,6,2),!
 W !,"Total 910 Charges:",?72,$J(+$G(TOT(910)),6,2),!
 W !,"Total Station FCP Charges:",?72,$J(TOT-$G(TOT(910)),6,2),!
 W:SUSP !,"Total Suspended Charges:",?72,$J(SUSP,6,2),!
 Q
ITEMO() ; Select action (A/E/D/Z)
 K DIR
 S DIR(0)="SBO^A:Add;D:Delete;E:Edit;Z:Zero"
 S DIR("A")="Select ACTION" D ^DIR
 Q Y
 Q
ITEMA ; Add an item
 S ITEM=""
 K DIC S DIC="^RMPR(661,",DIC(0)="AEQMZ" D ^DIC Q:Y<0!$$QUIT
 S NEW=+Y
 K DD,DO D SDICE S DIC(0)="LN" S X=NEW
 D FILE^DICN Q:Y<0!$$QUIT
 S DA=+Y,DR="2;9" D ^DIE I $$EQUIT S DIK=DIE D WAK Q
 ;S FCP=$$GETFCP^RMPOBILU I $$QUIT!(FCP<0) S DIK=DIE D WAK Q
 ;S DR="3///"_$P(FCP,U,2) D ^DIE I $$EQUIT S DIK=DIE D WAK Q
 ;S ITEM=DA,IEN=$G(IEN)+1,IEN(IEN)=ITEM
 S IEN=$G(IEN)+1,IEN(IEN)=DA,ITEM=IEN
 Q
SDICE ; Set DIC,DIE,DA for adding Trx items
 K DIC,DIE,DA
 S ZV=",""V"","
 S DA(1)=RMPODFN,DA(2)=RMPOVDR,DA(3)=RMPORVDT,DA(4)=RMPOXITE
 S DIC="^RMPO(665.72,"_DA(4)_",1,"_DA(3)_",1,"_DA(2)_ZV_DA(1)_",1,"
 S DIE=DIC
 Q
ITEMS ; Select an item
 I IEN=1 S ITEM=1 Q
 K DIR
 S ITEM=""
 S DIR(0)="NO^1:"_IEN,DIR("A")="Select an ITEM"
 S DIR("?")="Note:  You cannot select POSTED items"
 M DIR("?")=ITM
 D ^DIR Q:Y'>0!$$QUIT
 I $D(POSTED(+Y)) D  G ITEMS
 . W !,$C(7)_"Item "_(+Y)_" has been POSTED!"
 S ITEM=+Y I $P($G(^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,"V",RMPODFN,1,ITEM,0)),U,8)="Y" S PITM=ITEM
 S BACKPTR=$P($G(^RMPO(665.72,RMPOXITE,1,RMPORVDT,1,RMPOVDR,"V",RMPODFN,1,ITEM,0)),U,13)
 I $G(BACKPTR),$D(^RMPR(665,RMPODFN,"RMPOC",BACKPTR,0)),$P(^RMPR(665,RMPODFN,"RMPOC",BACKPTR,0),U,11)="Y" S PITM=ITEM
 Q
ITEME ; Edit an item
 K DR D SDICE
 S DIE("NO^")="BACK"
 S DA=IEN(ITEM),DR="1;7;S Z1=X;5;S Z2=X;4" D ^DIE Q:$$EQUIT
SACK S DR="10;S Z3=X" D ^DIE Q:$$EQUIT
 I Z3>(Z1*Z2) D  G SACK
 . W !,"SUSPENDED AMT SHOULD NOT BE GREATER THAN TOTAL AMOUNT!"
 S DR="11"_$S(+X=0:"///@",1:"") D ^DIE Q:$$EQUIT
 S DR="6///"_((Z1*Z2)-Z3) D ^DIE Q:$$EQUIT
 S DFCP=$P(^RMPO(665.72,DA(4),1,DA(3),1,DA(2),"V",DA(1),1,DA,0),U,3)
 F  D  Q:(FCP>0)!QUIT
 . S FCP=$P($$GETFCP^RMPOBILU(DFCP),U,2) Q:$$QUIT
 . I FCP<0!(FCP="") W $C(7)_"REQUIRED FIELD!"
 I FCP>0 S DR="3R///"_FCP_";13R;14" D ^DIE Q:$$EQUIT
 Q
ITEMZ ; Zero an item
 K DR D SDICE
 S DA=IEN(ITEM),DR="5///0;6///0;10///0;11///@" D ^DIE Q:$$EQUIT
 Q
ITEMK ; Delete an item
 D SDICE
 S RMDIC=DIC_IEN(ITEM)_",0)",RMIT=$G(@RMDIC),PITM=$P(RMIT,U,8)
 I PITM="Y" D  Q
 . W !,"Can't delete PRIMARY ITEM!"
 K DIR S DIR(0)="Y",DIR("A")="Are you SURE you want to delete this item"
 S DIR("B")="NO" D ^DIR Q:Y'>0
 K DIK,DA D SDICE S DIK=DIC,DA=IEN(ITEM)
WAK D ^DIK W "  ...deleted!"
 Q
