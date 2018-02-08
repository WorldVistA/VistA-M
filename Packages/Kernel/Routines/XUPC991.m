XUPC991 ;BPO/CLT - UPDATE EFFECTIVE DATE FIELD ; 06 Oct 2016  8:49 AM
 ;;8.0;KERNEL;**671**;JUL 10, 1995;Build 16
 ;
 ; since the original field STATUS (#3)is part of the 8932.1 file screen check and
 ; has a built in trigger to set field 4 to the current date if the status is Inactive
 ; the update of the STATUS field must be synchronized with the standarized VUID status.
 ;
SET(XUDA,XUDA1) ;SET THE EFFECTIVE DATE FIELD INFO TO CURRENT STATUS and DATE
 ; XUDA - The IEN of vuid STATUS (#8932.199,.02)
 ; XUDA1 - The IEN of the PERSON CLASS (#8932.1) entry
 ; X1 - old change array before edit
 ; X2 - new change array after edit
 ; XUNM -  external name value of vuid STATUS field
 ;
 N ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDESC,XUN,XUO,XUNM
 M XUO=X1,XUN=X2
 S XUNM=$G(%)
 S ZTDTH=$$NOW^XLFDT,ZTDESC="Save of Vuid Status to 8932.1 Status (#3) and update field 4 inactive date"
 S ZTRTN="SETJ^XUPC991("_XUDA_","_XUDA1_")",ZTSAVE("XUDA")="",ZTSAVE("XUDA1")="",ZTSAVE("XUNM")=""
 S ZTSAVE("XUO(")="",ZTSAVE("XUN(")=""
 S ZTIO=""
 ;D ^%ZTLOAD
 D SETJ(XUDA,XUDA1)
 ;
 K ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDESC,XUN,XUO,XUNM
 Q
 ;
SETJ(XUDA,XUDA1) ; save of vuid status to field 3 and 4
 N DIE,DIQ,DR,XUSTAT,XUDT,DP,DI,DL,A,B,C,D,E,F,CS,CD,AR,DA,FDA
 D GETS^DIQ(8932.1,XUDA1_",","3;4","IE","F")
 M AR=F("8932.1",XUDA1_",")
 S CS=AR(3,"I")
 S A=+$G(XUN(1)),B=$G(XUNM)
 I (+A=0!(B="INACTIVE"))&(CS'="i") D SETSD,SETS G SETQ
 I +A=1&(CS'="a") D SETSA,SETS,SETD G SETQ
 G SETQ
 ;
SETS ;save the status
 ;S DIE="^USC(8932.1,",DA=XUDA1
 ;S DR="3///"_XUSTAT D ^DIE
 K FDA
 S FDA(8932.1,XUDA1_",",3)=XUSTAT
 D FILE^DIE("","FDA")
 Q
SETD ; make sure field 4 is clear when status is 'a'
 ;S DIE="^USC(8932.1,",DA=XUDA1
 ;S XUDT="@",DR="4///"_XUDT D ^DIE
 K FDA
 S FDA(8932.1,XUDA1_",",4)="@"
 D FILE^DIE("","FDA")
 Q
 ;
SETQ ; quit
 Q
 ;
SETSD ;set for inactive
 S XUSTAT="i"
 Q
SETSA ;set for active
 S XUSTAT="a"
 Q
 ;
KILL(XUDA,XUDA1) ;
 Q  ; do not change value of field #3 STATUS
 ;
 ; S $P(^USC(8932.1,XUDA1,0),U,4,5)="a^"
 Q
