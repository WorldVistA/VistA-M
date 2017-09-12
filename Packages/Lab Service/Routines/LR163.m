LR163 ;DALISC/FHS - LR*5.2*163 PATCH ENVIRONMENT CHECK ROUTINE
 ;;5.2;LAB SERVICE;**163**;Sep 27, 1994
EN0 ;
 Q:'$G(XPDENV)
 L +^LRO(69,"AA"):15 I '$T D BMES^XPDUTL($$CJ^XLFSTR(" Unable to successfully lock the ^LRO(69,AA) global. ",80)) S XPQUIT=2
 I '$D(^LAM(0))#2 D BMES^XPDUTL($$CJ^XLFSTR("There is no WKLD CODE file.",80)) S XPQUIT=2
 I $$VERSION^XPDUTL("ICPT")'="6.0" D BMES^XPDUTL($$CJ^XLFSTR("You must install ICPT V6.0 Package first.",80)) S XPQUIT=2
 I '$O(^LAM(0)) D BMES^XPDUTL($$CJ^XLFSTR("There is no data in your WKLD CODE file.",80)) S XPDQUIT=2
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device in not defined.",80)) S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D BMES^XPDUTL($$CJ^XLFSTR("Please Log in to set local DUZ... variables.",80)) S XPDQUIT=2
 I '$D(^VA(200,$G(DUZ),0))#2 D BMES^XPDUTL($$CJ^XLFSTR("You are not a valid user on this system.",80)) S XPDQUIT=2
 I +$G(^LAM("VR"))'>5.1 D BMES^XPDUTL($$CJ^XLFSTR("You must have LAB V5.2 or greater Installed.",80)) S XPDQUIT=2
 I $G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("Install environment check FAILED.",80)) L -^LRO(69,"AA")
 I '$G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("Environment Check is Ok ---",80))
 Q
PRE ;LR*5.2*163 AFTER USER COMMITS ROUTINE KIDS INSTALL"
ENPRE ;
 Q:'$D(XPDNM)
 ;Cleanup broken X-Ref
 N I,N
 S I=0 F  S I=$O(^LAM(I)) Q:I<1  D
 . Q:'$D(^LAM(I,"7","B","LRDATA"))
 . S N=0 F  S N=$O(^LAM(I,7,"B","LRDATA",N)) Q:N<1  D
 . . K ^LAM(I,7,"B","LRDATA",N),^LAM(I,7,N,0)
 . . I $P(^LAM(I,7,0),U,4) S $P(^LAM(I,7,0),U,4)=$P(^LAM(I,7,0),U,4)-1
 I $D(^LAB(64.81,0))#2 S X=$P(^(0),U,1,2) K ^LAB(64.81) S ^LAB(64.81,0)=X
 S:$D(^LAM(0))#2 $P(^LAM(0),U,3)=2225 D
 . D BMES^XPDUTL($$CJ^XLFSTR("Removing 'Reserve 2 field (#8) in WKLD CODE file (#64).",80))
 . D BMES^XPDUTL($$CJ^XLFSTR("The field will be renamed 'PRICE'.",80))
 . N DA,DIK
 . S DA=8,DIK="^DD(64," D ^DIK
 D BMES^XPDUTL($$CJ^XLFSTR("Removing 'Reserve 2 field (#8) in WKLD CODE SUFFIX file (#64.2).",80))
 D BMES^XPDUTL($$CJ^XLFSTR("The field will be renamed 'PRICE'.",80)) D
 . N DA,DIK
 . S DA=8,DIK="^DD(64.2," D ^DIK
 D BMES^XPDUTL($$CJ^XLFSTR("Removing existing CPT codes for WKLD CODE file.",80))
 W ! S I=0 F  S I=$O(^LAM(I)) Q:I<1  D
 . I '$D(^LAM(I,0))#2 K ^LAM(I) Q
 . S:'$P(^LAM(I,0),U,7) $P(^(0),U,7)=38 K:$D(^LAM(I,4)) ^LAM(I,4) W:'(I#50) "."
 K ^LAM("AD")
 D SPCK
 D BMES^XPDUTL($$CJ^XLFSTR("** Pre Install Step Complete **",80))
 Q
PURG ;
 K DIK,DA S DIK="^LAB(64.81,",DA=LRIEN,DA(1)=64.81 D ^DIK K DIK
 Q
SPCK K ^XTMP("LR","SPELL ERR")
 S ^XTMP("LR","SPELL ERR")="LR*5.2*163 Spelling errors"
 D BMES^XPDUTL($$CJ^XLFSTR("Correcting Duplicates or Spelling Errors",80))
 D BMES^XPDUTL($$CJ^XLFSTR("Names that begin with 'X*' have codes that are incorrect.",80))
 K CK S CK="" F I=1:1 S LN=$T(SPELL+I) Q:$P(LN,";;",2)="STOP"  S CK(I)=LN
 S I=0 F  S I=$O(CK(I)) Q:I<1  D BMES^XPDUTL($$CJ^XLFSTR($P(CK(I),";",3)_"  "_$P(CK(I),";",4),80))
 K DIC S DIC=64,DIC(0)="XNZM"
 S II=0 F  S II=$O(CK(II)) Q:II<1  D
 . S X=$P(CK(II),";",3)_".0000",NM=$P(CK(II),";",4) D ^DIC
 . I Y<1 D BMES^XPDUTL($$CJ^XLFSTR("*** Unable to find WKLD Code [ "_X_" ] in your file #64 ****",80)) Q
 . ;W !,Y  W:Y>1 !,Y(0)
 . S LNX=$P(Y,U,2) I LNX'=NM S CK=1 D FILE
 D BMES^XPDUTL($$CJ^XLFSTR("Spelling updates completed.",80))
 Q
SPELL ;
 ;;97485;X*Hepatitis C RNA;
 ;;STOP
FILE ;
 N LRROOT,DA
 D BMES^XPDUTL($$CJ^XLFSTR("Correcting Spelling of entry "_+Y_" from "_LNX_" to "_NM,80))
 S DA=+Y,LRROOT(64,DA_",",.01)=NM
 D FILE^DIE("","LRROOT",^XTMP("LR","SPELL ERR"))
 Q
POST ;LR*5.2*163 POST INSTALL ROUTINE KIDS INSTALL"
ENPOS ;
 S:$D(^LAM(0))#2 $P(^(0),U,3)=99999 S $P(^LAB(69.9,1,"VSIT"),U)=1
 D BMES^XPDUTL($$CJ^XLFSTR("LABORATORY SITE FILE (#69.9) field PCE/VSIT ON (#615)",80))
 D BMES^XPDUTL($$CJ^XLFSTR("is set to transmit CPT codes ONLY - No stop code transmission.",80))
 I '$O(^LAB(64.81,0)) W $C(7) D BMES^XPDUTL($$CJ^XLFSTR("No data in file # 64.81 - No linking done.",80)) G MSG
 D BMES^XPDUTL($$CJ^XLFSTR("** Starting CPT to NLT linking - Standby **",80))
CPT ;
 S LRACTDT="MARCH 1, 1997" W !
 K DIE S LRIEN=0,DIE="^LAM(" F  S LRIEN=$O(^LAB(64.81,LRIEN)) Q:LRIEN<1  I $D(^(LRIEN,0))#2 S DATA=^(0) D  I '$P(^LAB(64.81,LRIEN,0),U,9) D PURG
 . S LRNLT=$P(DATA,U,2),LRCPT=$P(DATA,U,3),LRRNAME=$P(DATA,U,8)
 . Q:'LRNLT!('LRCPT)
 . W:'(LRIEN#50) "." D LK
 I '$O(^LAB(64.81,0)) D BMES^XPDUTL($$CJ^XLFSTR("Database Upgrade Completed Successfully",80)) G MSG
 D BMES^XPDUTL($$CJ^XLFSTR(" Database Upgrade is Incomplete - Use FM to print upgrade errors",80))
 D BMES^XPDUTL($$CJ^XLFSTR("stored in the LAB NLT/CPT CODES (#64.81) file.",80))
MSG ;
 D BMES^XPDUTL($$CJ^XLFSTR("Checking File pointer integrity",80))
 D
 . S LRI=0 F  S LRI=$O(^LAB(64.2,LRI)) Q:LRI<1  I $D(^(LRI,0)),'$D(^LAB(64.3,+$P(^(0),U,14),0)) D
 . . N DIE,DA,DR W "."
 . . S DR="11///1",DA=LRI,DIE="^LAB(64.2," D ^DIE
 D
 . S LRI=0 F  S LRI=$O(^LAM(LRI)) Q:LRI<1  I $D(^(LRI,0)),'$D(^LAB(64.3,+$P(^(0),U,14),0)) D
 . . N DIE,DA,DR W "*"
 . . S DR="12///1",DA=LRI,DIE="^LAM(" D ^DIE
 D BMES^XPDUTL($$CJ^XLFSTR("Use 'Workload code list option [LRCAPD] for a full listing of",80))
 D BMES^XPDUTL($$CJ^XLFSTR("ALL NLT Codes used in Laboratory Test File (#60).",80))
 D BMES^XPDUTL($$CJ^XLFSTR("You can also use the [Edit or Print WKLD CODES] option for a listing",80))
 D BMES^XPDUTL($$CJ^XLFSTR("of linked CPT linked NLT codes.",80))
 L -^LAB(69,"AA")
 D BMES^XPDUTL($$CJ^XLFSTR("** Post install completed **",80))
 Q
LK ;
 S LRCODE=0 F  S LRCODE=+$O(^LAM("C",LRNLT_" ",LRCODE)) Q:LRCODE<1  D
 .  K DA S TAG="*",DA=LRCODE I '$D(^LAM(DA,0))#2 D ERR Q
 .  S TAG="|" I +$P(^LAM(DA,0),U,2)'[+LRNLT D ERR Q
 .  K DR D ADD
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
 W $C(7) D BMES^XPDUTL($$CJ^XLFSTR("Error Processing WKLD CODE "_LRNLT_" Logged in "_LRIEN,80)) Q
