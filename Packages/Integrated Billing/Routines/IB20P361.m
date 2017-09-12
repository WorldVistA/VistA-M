IB20P361 ;BP/TJH - Preinit routine for IB*2.0*361 ; 12/14/2006
 ;;2.0;INTEGRATED BILLING;**361**;21-MAR-94;Build 9
 ;
 Q
EN ; entry point
 D ERRCD
 D SEXFILL
 Q
 ;
ERRCD ; add new error codes to 350.8
 N DO,DA,DIC,DIK,IBA,IBC,IBT,IBX,X,Y
 ;
 S IBC=0,(DIC,DIK)="^IBE(350.8,",DIC(0)=""
 F IBX=1:1 S IBT=$P($T(TXT+IBX),";",3) Q:'$L(IBT)  D
 . Q:$D(^IBE(350.8,"AC",$P(IBT,"^",3)))  ;  already on file
 . K DO
 . S X=$P(IBT,"^")
 . D FILE^DICN I Y>0 S ^IBE(350.8,+Y,0)=IBT,DA=+Y,IBC=IBC+1 D IX^DIK
 ;
 S IBA(2)="     "_IBC_" entries added to 350.8"
 S (IBA(1),IBA(3))=""
 ;
ERRCDX ;
 D MES^XPDUTL(.IBA)
 Q
 ;
SEXFILL ; fill INSURED'S SEX field with value where possible
 D BMES^XPDUTL(" Starting update of new INSURED'S SEX field for all existing policies.")
 D MES^XPDUTL(" . . . . . . .")
 N IBDFN,IBDA,IBVTSX,IBSPSX,IBWHOSE,START,PCTR,END,TT,MIN,SEC,MSG
T1 S START=$H,PCTR=0
 S IBDFN=0
 F  S IBDFN=$O(^DPT(IBDFN)) Q:'IBDFN  D
 . S PCTR=PCTR+1
 . Q:'$D(^DPT(IBDFN,.312))  ; no insurance to process
 . S IBVTSX=$P(^DPT(IBDFN,0),U,2) ; get veteran's sex
 . S IBSPSX=$TR(IBVTSX,"MF","FM") ; compute a spouse's sex in case it is needed
 . S IBDA=0
 . F  S IBDA=$O(^DPT(IBDFN,.312,IBDA)) Q:'IBDA  D
 .. S IBWHOSE=$P($G(^DPT(IBDFN,.312,IBDA,0)),U,6)
 .. Q:IBWHOSE=""  Q:'("sv"[IBWHOSE)  ; can't deal with anything but vet & spouse
 .. S $P(^DPT(IBDFN,.312,IBDA,3),U,12)=$S(IBWHOSE="v":IBVTSX,IBWHOSE="s":IBSPSX)
T2 S END=$H
 D BMES^XPDUTL(" INSURED'S SEX field update complete.")
 S TT=$P(END,",",2)-$P(START,",",2),MIN=TT\60,SEC=TT#60
 S MSG=" "_$FN(PCTR,",")_" patient records were processed in "_MIN_" minutes and "_SEC_" seconds."
 D BMES^XPDUTL(MSG)
 Q
TXT ; text of error messages to add
 ;;IB261^Primary insurance subscriber is missing INSURED'S SEX^IB261^1^1
 ;;IB262^Secondary insurance subscriber is missing INSURED'S SEX^IB262^1^1
 ;;IB263^Tertiary insurance subscriber is missing INSURED'S SEX^IB263^1^1
