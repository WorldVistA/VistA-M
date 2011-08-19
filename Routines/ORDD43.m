ORDD43 ; SLC/MKB - Build xrefs for file 101.43 ;7/2/97  10:52
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**26,68,94,164,190**;Dec 17, 1997
 ;
SET(X,IFN) ; Create new entry X in SET multiple
 N DIC,DA,Y Q:$D(^ORD(101.43,IFN,9,"B",X))  ; already exists
 S DIC="^ORD(101.43,"_IFN_",9,",DIC(0)="L",DA(1)=IFN
 S DIC("P")=$P(^DD(101.43,9,0),U,2) K DD,DO
 S ^ORD(101.43,"AH",X)=$H
 S ^ORD(101.43,"AH","S."_X)=$H
 D FILE^DICN
 Q
 ;
KILL(X,IFN) ; Remove entry X from SET multiple
 N DIK,DA
 S DIK="^ORD(101.43,"_IFN_",9,",DA(1)=IFN
 S ^ORD(101.43,"AH",X)=$H
 S DA=$O(^ORD(101.43,IFN,9,"B",X,0)) I DA D ^DIK
 Q
 ;
SETRA(NAME,ITYPE,CPROC) ; Set COMMON xref
 Q:'CPROC  Q:'$L(ITYPE)  ; not common, no IType
 S ^ORD(101.43,"COMMON",ITYPE,NAME,DA)=""
 Q
 ;
KILLRA(NAME,ITYPE,CPROC) ; Kill COMMON xref
 Q:'CPROC  Q:'$L(ITYPE)  ; not common, no IType
 K ^ORD(101.43,"COMMON",ITYPE,NAME,DA)
 Q
 ;
SS(NAME,DATE,LABTYP) ; -- Set S.SET xref by Name, Set multiple
 Q:'$L($G(NAME))  I ($G(LABTYP)="O")!($G(LABTYP)="N") D SK(NAME) Q
 N SET,SET0,SETNM,SETLST,QO
 S SET=0 F  S SET=$O(^ORD(101.43,DA,9,SET)) Q:SET'>0  S SET0=$G(^(SET,0)) D
 . S SETNM=$P(SET0,U),QO=$P(SET0,U,2)
 . S ^ORD(101.43,"S."_SETNM,$$UP^XLFSTR(NAME),DA)=U_NAME_U_$G(DATE)_U_U_QO
 . S ^ORD(101.43,"AH","S."_SETNM)=$H,SETLST("S."_SETNM)=""
 I $G(DATE),(DATE>$$NOW^XLFDT) D
 . N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 . S ZTRTN="DQAH^ORDD43",ZTDESC="CPRS AH Update",ZTDTH=DATE,ZTIO=""
 . S ZTSAVE("SETLST(")="" D ^%ZTLOAD
 Q
DQAH ; -- set new timestamps for sets where items are becoming inactive
 S ZTREQ="@"
 N X
 S X="" F  S X=$O(SETLST(X)) Q:X=""  S ^ORD(101.43,"AH",X)=$H
 Q
 ;
SK(NAME) ; -- Kill S.SET xref by Name, Set multiple
 Q:'$L($G(NAME))  N SET,SETNM
 S SET=0 F  S SET=$O(^ORD(101.43,DA,9,SET)) Q:SET'>0  S SETNM=$P(^(SET,0),U) D
 . K ^ORD(101.43,"S."_SETNM,$$UP^XLFSTR(NAME),DA)
 . S ^ORD(101.43,"AH","S."_SETNM)=$H
 Q
 ;
SS1(NAME,DATE,LABTYP) ; -- Set S.SET mnemonic xref by Synonym, Name, Set
 Q:'$L($G(NAME))  I ($G(LABTYP)="O")!($G(LABTYP)="N") D SK1(NAME) Q
 N SYN,SYNM,SET,SET0,SETNM,QO
 S SET=0 F  S SET=$O(^ORD(101.43,DA,9,SET)) Q:SET'>0  S SET0=$G(^(SET,0)) D
 . S SETNM=$P(SET0,U),QO=$P(SET0,U,2)
 . S SYN=0 F  S SYN=$O(^ORD(101.43,DA,2,SYN)) Q:SYN'>0  S SYNM=$P(^(SYN,0),U) D
 . . S:SYNM'=NAME ^ORD(101.43,"S."_SETNM,$$UP^XLFSTR(SYNM),DA)="1^"_SYNM_U_$G(DATE)_U_NAME_U_QO
 . . S ^ORD(101.43,"AH","S."_SETNM)=$H
 Q
 ;
SK1(NAME) ; -- Kill S.SET mnemonic xref by Synonym, Name, Set
 N SYN,SYNM,SET,SETNM
 S SET=0 F  S SET=$O(^ORD(101.43,DA,9,SET)) Q:SET'>0  S SETNM=$P(^(SET,0),U) D
 . S SYN=0 F  S SYN=$O(^ORD(101.43,DA,2,SYN)) Q:SYN'>0  S SYNM=$P(^(SYN,0),U) D
 . . I $G(^ORD(101.43,"S."_SETNM,$$UP^XLFSTR(SYNM),DA)) K ^(DA)
 . . S ^ORD(101.43,"AH","S."_SETNM)=$H
 Q
 ;
SS2 ; -- Set S.SET mnemonic xref from SET multiple
 N TYP,NAME,DATE,SYN,SYNM,I,QO
 S TYP=$P($G(^ORD(101.43,DA(1),"LR")),U,7) I (TYP="O")!(TYP="N") D SK2 Q
 S I=+$O(^ORD(101.43,DA(1),9,"B",X,0))
 S QO=$P($G(^ORD(101.43,DA(1),9,I,0)),U,2)
 S SYN=0,NAME=$P(^ORD(101.43,DA(1),0),U),DATE=$G(^(.1))
 F  S SYN=$O(^ORD(101.43,DA(1),2,SYN)) Q:SYN'>0  S SYNM=$P(^(SYN,0),U) D
 . S:SYNM'=NAME ^ORD(101.43,"S."_X,$$UP^XLFSTR(SYNM),DA(1))="1^"_SYNM_U_DATE_U_NAME_U_QO
 . S ^ORD(101.43,"AH","S."_X)=$H
 Q
 ;
SK2 ; -- Kill S.SET mnemonic xref from SET multiple
 N SYN,SYNM
 S SYN=0 F  S SYN=$O(^ORD(101.43,DA(1),2,SYN)) Q:SYN'>0  S SYNM=$P(^(SYN,0),U) D
 . I $G(^ORD(101.43,"S."_X,$$UP^XLFSTR(SYNM),DA(1))) K ^(DA(1))
 . S ^ORD(101.43,"AH","S."_X)=$H
 Q
 ;
SS3 ; -- Set S.SET mnemonic xref from SYN multiple
 N TYP,NAME,DATE,SET,SET0,SETNM,QO
 S TYP=$P($G(^ORD(101.43,DA(1),"LR")),U,7) I (TYP="O")!(TYP="N") D SK3 Q
 S NAME=$P(^ORD(101.43,DA(1),0),U),DATE=$G(^(.1)),SET=0 Q:X=NAME
 F  S SET=$O(^ORD(101.43,DA(1),9,SET)) Q:SET'>0  S SET0=$G(^(SET,0)) D
 . S SETNM=$P(SET0,U),QO=$P(SET0,U,2)
 . S ^ORD(101.43,"S."_SETNM,$$UP^XLFSTR(X),DA(1))="1^"_X_U_DATE_U_NAME_U_QO
 . S ^ORD(101.43,"AH","S."_SETNM)=$H
 Q
 ;
SK3 ; -- Kill S.SET mnemonic xref from SYN multiple
 N SET,SETNM
 S SET=0 F  S SET=$O(^ORD(101.43,DA(1),9,SET)) Q:SET'>0  S SETNM=$P(^(SET,0),U) D
 . I $G(^ORD(101.43,"S."_SETNM,$$UP^XLFSTR(X),DA(1))) K ^(DA(1))
 . S ^ORD(101.43,"AH","S."_SETNM)=$H
 Q
 ;
CS(NAME,CODE,DATE) ; -- Set C.SET xref by 'Code Name', Set
 Q:'$L($G(NAME))  Q:'$L($G(CODE))
 N X,XP,ORS,SET0,SETNM,QO
 S X=CODE_" "_NAME,XP=$$UP^XLFSTR(X)
 S ORS=0 F  S ORS=$O(^ORD(101.43,DA,9,ORS)) Q:ORS'>0  S SET0=$G(^(ORS,0)) D
 . S SETNM=$P(SET0,U),QO=$P(SET0,U,2)
 . S ^ORD(101.43,"C."_SETNM,XP,DA)=U_X_U_$G(DATE)_U_U_QO
 Q
 ;
CK(NAME,CODE) ; -- Kill C.SET xref
 Q:'$L($G(NAME))  Q:'$L($G(CODE))
 N XP,ORS,ORSET S XP=$$UP^XLFSTR(CODE_" "_NAME)
 S ORS=0 F  S ORS=$O(^ORD(101.43,DA,9,ORS)) Q:ORS'>0  S ORSET=$P(^(ORS,0),U) K ^ORD(101.43,"C."_ORSET,XP,DA)
 Q
 ;
QO(X) ; -- Add data to SET xrefs, set/kill AQO xref
 N NAME,XREF,SYN,SYNM S X=$G(X)
 S NAME=$$UP^XLFSTR($P($G(^ORD(101.43,DA(1),0)),U)),XREF="S."_$P($G(^(9,DA,0)),U)
 S:X ^ORD(101.43,DA(1),9,"AQO",XREF)=""
 K:'X ^ORD(101.43,DA(1),9,"AQO",XREF)
 Q:'$D(^ORD(101.43,XREF,NAME,DA(1)))  S $P(^(DA(1)),U,5)=X
 S SYN=0 F  S SYN=+$O(^ORD(101.43,DA(1),2,SYN)) Q:SYN<1  S SYNM=$P($G(^(SYN,0)),U),$P(^ORD(101.43,XREF,$$UP^XLFSTR(SYNM),DA(1)),U,5)=X
 S ^ORD(101.43,"AH",XREF)=$H
 Q
 ;
XHELP(INDEX,SCREEN) ; -- ??Help
 N X,Y,Y0,Z,SYN,CNT,D,DONE
 S:'$L($G(INDEX)) INDEX="B" W !!,"Choose from:" S CNT=1,D=INDEX
 S X="" F  S X=$O(^ORD(101.43,INDEX,X)) Q:X=""  S Y=0 D  Q:$G(DONE)
 . F  S Y=$O(^ORD(101.43,INDEX,X,Y)) Q:Y'>0  S SYN=$G(^(Y)) I 'SYN D  Q:$G(DONE)
 . . S Y0=$G(^ORD(101.43,Y,0)) X:$L($G(SCREEN)) SCREEN Q:'$T
 . . W !,"   "_X ;W:SYN "     "_$P(SYN,U,4) ; echo .01 if synonym
 . . S CNT=CNT+1 Q:CNT'>(IOSL-5)  S CNT=0
 . . W !,"   '^' TO STOP: " R Z:DTIME S:'$T!(Z["^") DONE=1
 W !
 Q
 ;
ACTIVE(ITM) ; -- Screen, if inactive or restricted to QO use only
 ;        Use in DIC("S") when searching #101.43
 N Y S Y=1
 I $G(ORTYPE)="D",$L($G(D)),$D(^ORD(101.43,+ITM,9,"AQO",$P(D,U))) S Y=0
 I $G(^ORD(101.43,+ITM,.1)),^(.1)'>$$NOW^XLFDT S Y=0  ;inactive
 Q Y
 ;
ID(OLD,NEW) ; -- API for package to update ID field [ code;99XXX ]
 ;    Returns 1 or 0, if successful or not
 N IFN,Y S Y=0
 G:'$G(OLD) IDQ G:$G(NEW)'?1.N1";99"3U IDQ ;invalid
 S IFN=+$O(^ORD(101.43,"ID",OLD,0)) G:IFN'>0 IDQ
 K ^ORD(101.43,"ID",OLD,IFN)
 S $P(^ORD(101.43,IFN,0),U,2)=NEW,^ORD(101.43,"ID",NEW,IFN)="",Y=1
IDQ Q Y
