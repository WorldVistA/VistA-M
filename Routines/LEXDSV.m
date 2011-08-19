LEXDSV ; ISL Defaults - Save                      ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 Q
 ;
 ; Needs
 ;
 ;   Application      File DA, Subfile DA(1)  LEXAP
 ;   User DUZ         Sub-file .01 DINUM      LEXDUZ
 ;   Default value                            LEXDVAL
 ;   Defualt name                             LEXDNAM
 ;   Default location Sub-file field          LEXFLD
 ;         
 ; Sets ^LEXT(757.2,LEXAP,200,LEXDUZ,LEXFLD)=LEXDVAL
 ; and  ^LEXT(757.2,LEXAP,200,LEXDUZ,(LEXFLD+.5))=LEXDNAM
 ;
 ;
SET(LEXDUZ,LEXAP,LEXDVAL,LEXDNAM,LEXFLD) ; 
 ;
 Q:'$L($G(LEXDVAL))  S:LEXDVAL["@" LEXDVAL="@",LEXDNAM="@" S DIC("P")="757.201PA"
 N LEXWARN S LEXWARN=0,(DIC,DIE)="^LEXT(757.2,"_LEXAP_",200,"
 S DA(1)=LEXAP,DA=LEXDUZ
 S DLAYGO=757.2,(DINUM,X)=LEXDUZ,DIC(0)="L"
 S DIC("DR")=LEXFLD_"////^S X=LEXDVAL" K DD,DO D FILE^DICN
EDIT ; Lock record and edit user default
 L +^LEXT(757.2,+LEXAP,200):1
 I '$T D  G EDIT
 . W:'$D(ZTQUEUED)&('LEXWARN) !,"Another user is editing this entry, please wait"
 . S LEXWARN=1 H 2
 S DA(1)=LEXAP,DA=LEXDUZ,DR=LEXFLD_"////^S X=LEXDVAL"
 D ^DIE I $L($G(LEXDNAM)) S DR=(LEXFLD+.5)_"////^S X=LEXDNAM" D ^DIE
 K DA,DR,DIE,DIC
 L -^LEXT(757.2,+LEXAP,200)
 ;
 ; Delete name if default is null
 ;
 N LEXX,LEXDEL S LEXX=0,LEXDEL=1
 F  S LEXX=$O(^LEXT(757.2,LEXAP,200,LEXDUZ,LEXX)) Q:+LEXX=0  D
 . I '$L($G(^LEXT(757.2,LEXAP,200,LEXDUZ,LEXX))) D
 . . I $L($G(^LEXT(757.2,LEXAP,200,LEXDUZ,(LEXX+.5)))) D
 . . . S LEXDVAL="@",DIC("P")="757.201PA"
 . . . S (DIC,DIE)="^LEXT(757.2,"_LEXAP_",200,",DA(1)=LEXAP,DA=LEXDUZ
 . . . S DLAYGO=757.2,(DINUM,X)=LEXDUZ,DIC(0)="L"
 . . . L +^LEXT(757.2,+LEXAP,200):1 I '$T H 2 S LEXX=LEXX-.05 Q
 . . . S DR=(LEXX+.5)_"////^S X=LEXDVAL"
 . . . D ^DIE S LEXX=LEXX+.5 K DA,DR,DIE,DIC
 . . . L -^LEXT(757.2,+LEXAP,200)
 . . I '$L($G(^LEXT(757.2,LEXAP,200,LEXDUZ,(LEXX+.5)))) D
 . . . K ^LEXT(757.2,LEXAP,200,LEXDUZ,LEXX),^LEXT(757.2,LEXAP,200,LEXDUZ,(LEXX+.5))
 . I $L($G(^LEXT(757.2,LEXAP,200,LEXDUZ,LEXX))) S LEXDEL=0
 ;
 ; Delete record if all defaults are null
 ;
 I LEXDEL D
 . S (DIC,DIE,DIK)="^LEXT(757.2,"_LEXAP_",200,"
 . S DA(1)=LEXAP,DA=LEXDUZ D ^DIK
 Q
