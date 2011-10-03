ENEWOD1 ;(WASH ISC)/DH-Display Electronic Work Order ;1.23.97
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
TOP ;  Physical print
 ;  Get BOLD and UNBOLD
 N IOINLOW,IOINHI,IOINORM D ZIS^ENUTL
 ;
 N I,J,X
 W:$E(IOST,1,2)="C-" @IOF
 S $X=1 W ?28 D W("ELECTRONIC WORK REQUEST")
 W ! D W(" 1) ") W "WORK ORDER #: " D W(EN(1))
 W ?41 D W(" 2) ") W "REQ DATE: " S X=EN(2) D PDT
 W ! D W(" 3) ") W "REQ MODE: " D W(EN(3)) W ?41 D W(" 4) ") W "LOCATION: " D W(EN(4))
 W ! D W(" 5) ") W "BED #: " D W(EN(5))
 W ?41 D W(" 6) ") W $S(ENDSTAT=35.2:"PM STATUS: ",1:"STATUS: ") D W(EN(6))
 W ! D W(" 7) ") W "TASK DESC: " D W(EN(7))
 W ! D W(" 8) ") W "CONTACT: " D W(EN(8)) W ?41 D W(" 9) ") W "PHONE: " D W(EN(9))
 W ! D W("10) ") W "ENTERED BY: " D W(EN(10)) W ?41 D W("11) ") W "SHOP: " D W(EN(11))
 W ! D W("12) ") W "PRIORITY: " D W(EN(12)) W ?41 D W("13) ") W "DATE ASSIGNED: " S X=EN(13) D PDT
 W ! D W("14) ") W "EQUIP ID#: " D W(EN(14)) W ?41 D W("15) ") W "LOCAL ID: " D W(EN(15))
 W ! D W("16) ") W "EQUIP CAT: " D W(EN(16)) W ?41 D W("17) ") W "MFGR: " D W(EN(17))
 W ! D W("18) ") W "MODEL: " D W(EN(18)) W ?41 D W("19) ") W "SERIAL #: " D W(EN(19))
 W ! D W("20) ") W "OWNER/DEPT: " D W(EN(20)) W ?49 D W("21) ") W "PM #: " D W(EN(21))
 W ! D W("22) ") W "DATE COMPLETE: " S X=EN(22) D PDT
 W ! D W("23) ") W "WORK PERFORMED: "
 I EN(23)]"" D
 . I $L(EN(23))<61 D W(EN(23)) Q
 . K ^UTILITY($J,"W") S X=EN(23),DIWL=1,DIWR=60,DIWF="" D ^DIWP
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:'I  W:I>1 !,?20 D W(^(I,0))
 W ! D W("24) ") W "COMMENTS: "
WCO I $D(^ENG(6920,DA,6)) S DIWL=5,DIWR=(IOM-5),DIWF="|",(X,ENX)=0 D  G:ENX="^" KILL
 . K ^UTILITY($J,"W")
 . S ENNX=0 F  S ENNX=$O(^ENG(6920,DA,6,ENNX)) Q:ENNX'>0  S X=^(ENNX,0)  D ^DIWP
 . W IOINHI S ENNX=0 F  S ENNX=$O(^UTILITY($J,"W",DIWL,ENNX)) Q:'ENNX  W !,?DIWL,^(ENNX,0) I (IOSL-$Y)'>1 D  Q:ENX="^"
 .. W IOINLOW D HOLD W:ENX'="^" IOINHI
 . W IOINLOW
BOTM ;  Bottom of page
 W ! D:(IOSL-$Y)'>1 HOLD K X I EN(14)]"",$D(^ENG(6914,EN(14),2)) S X=$P(^(2),U,5) I X]"" W "WARRANTY EXPIRATION: ",IOINHI W:+X>+DT "**" W $E(X,4,5),"/",$E(X,6,7),"/",$E(X,2,3) W:+X>+DT "**" W IOINLOW,?41
 S ENORIG=$P(^ENG(6920,DA,0),U,6) I ENORIG]"",ENORIG'=$P(^(0),U) W "(Original Work Order: "_ENORIG_")"
 I EN(14)>0 D
 . S ENUSE=$$GET1^DIQ(6914,EN(14),20) I ENUSE]"","TURNED IN^LOST OR STOLEN"[ENUSE W ! D:(IOSL-$Y)'>1 HOLD W "USE STATUS of this equipment is "_ENUSE_" and may need to be edited."
 . S I=9999999999 F  S I=$O(^ENG(6920,"G",EN(14),I),-1) Q:'I!($G(X("HA")))  D
 .. Q:$E($P($G(^ENG(6920,I,0)),U),1,3)="PM-"
 .. Q:$P($G(^ENG(6920,I,5)),U,2)]""  ;Closed work order
 .. S J=0 F  S J=$O(^ENG(6920,I,8,J)) Q:'J!($G(X("HA")))  I $P(^ENG(6920,I,8,J,0),U)=8 S X("HA")=I
 . I $G(X("HA"))>0 W ! D:(IOSL-$Y)'>1 HOLD W "Open HAZARD ALERT for this equipment. Work order: "_$P(^ENG(6920,X("HA"),0),U)_"."
 Q
 ;
PDT I X]"" S Y=X X ^DD("DD") D W(Y)
 Q
 ;
W(ENDATA) ;  Bold ENDATA
 N X
 S X=$X W IOINHI S $X=X W ENDATA
 S X=$X W IOINLOW S $X=X
 Q
 ;
HOLD I $E(IOST,1,2)="C-" W !,"          (Press <RETURN> to continue, '^' to escape...)" R ENX:DTIME S $Y=0 Q
 W @IOF,"(Work Order: "_$P(^ENG(6920,DA,0),U)_")"
 Q
 ;
KILL K EN,ENNX,ENORIG,ENUSE,ENX
 Q
 ;ENEWOD1
