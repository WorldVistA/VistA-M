LR127PO ;DALISC/FHS - LR*5.2*127 POST INSTALL ROUTINE KIDS INSTALL
 ;;5.2;LAB SERVICE;**127**;Sep 27, 1994
EN ;
STOP ;
 L +^LAM(0):2 I $T S:$D(^LAM(0))#2 $P(^(0),U,3)=99999 L -^LAM(0)
 S $P(^LAB(69.9,1,"NITE"),U,6)=""
 S X=$$ADD^XPDMENU("LR LIM/WKLD MENU","LR7O 60-64")
 W !!," 'National Laboratory File' menu was ",$S(X:"added",1:"NOT ADDED")," to [LR LIM/WKLD] Menu ",! W:'X $C(7)
 I '$O(^LAB(64.81,0)) W $C(7),$$CJ^XLFSTR("No data in file # 64.81 - No linking done.",80) G MSG
 W !!,$$CJ^XLFSTR("Starting CPT to NLT linking  Standby",80),!
CPT ;
 S LRACTDT="JULY 17,1996"
 K DIE S LRIEN=0,DIE="^LAM(" F  S LRIEN=$O(^LAB(64.81,LRIEN)) Q:LRIEN<1  I $D(^(LRIEN,0))#2 S DATA=^(0) D  I '$P(^LAB(64.81,LRIEN,0),U,9) D PURG
 . S LRNLT=$P(DATA,U,2),LRCPT=$P(DATA,U,3)
 . Q:'LRNLT!('LRCPT)  W "." D LK
 I '$O(^LAB(64.81,0)) W !,$$CJ^XLFSTR("Database Upgrade Completed Sucessfully",80),!! G MSG
 W !?10," Database Upgrade Incomplete - Use FM to Print a Listing"
 W !,"of the LAB NLT/CPT CODES (#64.81) for a listing of errors",!!
MSG S $P(^LAB(69.9,1,"VSIT"),U)=2
 W !,$$CJ^XLFSTR("PCE/VSIT ON (#615) field in LABORATORY SITE (#69.9) file",80)
 W !,$$CJ^XLFSTR("has been set to BOTH PCE/VSIT AND STOP CODES",80),!!
 W !,$$CJ^XLFSTR("You can use the [Edit or Print WKLD CODES] option for a printed list",80)
 W !,$$CJ^XLFSTR("of linked CPT linked NLT codes.",80),!
 W !!,$$CJ^XLFSTR("Post install completed",80),!!
 W !!?5," The Laboratory LIM should use the National Laboratory File"
 W !,"Menu [LR7O 60-64] to link Laboratory Test to WKLD CODES (#64) "
 W !,"This should be done before 10/1/96 to permit CPT codes to be"
 W !,"passed to the PCE package",!,$C(7),!
END ;
 Q:$G(LRDBUG)
 K DA,DATA,DIE,DIK,DIC,DR,LRACTDT,LRCODE,LRCPT,LRIEN,LRNLT,LRNODE,TAG,X
 Q
LK ;
 S LRCODE=0 F  S LRCODE=+$O(^LAM("C",LRNLT_" ",LRCODE)) Q:LRCODE<1  D
 .  K DA S TAG="*",DA=LRCODE I '$D(^LAM(DA,0))#2 D ERR Q
 .  S TAG="|" I +$P(^LAM(DA,0),U,2)'[+LRNLT D ERR Q
 .  K DR D ADD
SUF S LRNODE="^LAM(""E"","_+LRNLT_")" F  S LRNODE=$Q(@LRNODE) Q:$QS(LRNODE,2)'[+LRNLT  D
 . K DA,DR,DIC S DA=$QS(LRNODE,3) D ADD
 Q
ADD ;
 Q:$D(^LAM(DA,4,"B",LRCPT))
 Q:'$P($G(^LAM(DA,0)),U,2)  Q:$P(^(0),U,2)'[+LRNLT
 S DA(1)=4,DR="18///"_LRCPT_";",DR(1,64)="18///"_LRCPT,DR(2,64.018)=".01///"_LRCPT_";2///"_LRACTDT_";5///"_"CPT"
 W:$G(LRDBUG) "DA = ",DA_"  " D ^DIE I $D(^LAM(DA,4,"B",LRCPT)) W:$G(LRDBUG) ". - " Q
 S TAG="/" D ERR
 Q
ERR ;
 S:'$D(TAG) TAG="+" S $P(^LAB(64.81,LRIEN,0),U,9)=$P(^(0),U,9)_LRNLT_TAG
 W $C(7) W !,"Error Processing WKLD CODE "_LRNLT_" Logged in "_LRIEN,! Q
PURG ;
 K DIK S DIK="^LAB(64.81,",DA=LRIEN,DA(1)=64.81 D ^DIK K DIK
 Q
