GECSSITE ;WISC/RFJ/KLD-get site, fy, person data                        ;01 Nov 93
 ;;2.0;GCS;**6,15,27**;MAR 14, 1995
 ;
 N %,%Y,DIC,DONTASK,I,X,Y
 I $G(GECS("SITENOASK")) S DONTASK=GECS("SITENOASK")
 K GECS
 ;
 D GETUSER I '$D(GECS("PER")) Q
 ;
 ;  find site
 I '$O(^GECS(2101.7,0)) W !,"NO SITE PARAMETERS HAVE BEEN ENTERED IN FILE 2101.7," K GECS Q
 I $P($G(^GECS(2101.7,0)),"^",4)'>1 D GETSITE(+$O(^GECS(2101.7,0))) Q
 ;
 ;  if gecs("sitenoask") is defined (set in dontask), get param for site
 I $G(DONTASK) D  Q
 .   S %=+$O(^DIC(4,"D",+DONTASK,0)) I $D(^GECS(2101.7,%,0)) D GETSITE(%) Q
 .   W !,"SITE ",DONTASK," NOT FOUND IN FILE 2101.7." K GECS
 ;
 S %=$P($G(^DIC(4,+$G(^GECS(2101.7,"PRIMARY")),0)),"^")
 I %'="" S DIC("B")=%
 S DIC("A")="Select STATION NUMBER"_$S($D(DIC("B")):" (^ TO EXIT)",1:"")_": ",DIC="^GECS(2101.7,",DIC(0)="AEQMN" W ! D ^DIC I Y'>0 Q
 D GETSITE(+Y)
 Q
 ;
 ;
GETSITE(GECSSITE)  ;  get site parameters for gecssite
 N %,STATNAME,SUBSITE,SITE99
 ;  get user if not defined
 I '$D(GECS("PER")) D GETUSER I '$D(GECS("PER")) K GECS Q
 ;
 S %=$G(^GECS(2101.7,+GECSSITE,0)) I %="" D
 . W !!,"Site Missing From GENERIC CODE SHEET FILE 2101.7"
 . W !,$$REPEAT^XLFSTR("*",57)
 . W !,"Site ",GECS("SITE"),GECS("SITE1")," does not exist in File #2101.7. Please contact"
 . W !,"your Information Resource Management(IRM) Personnel and"
 . W !,"inform them that Site ",GECS("SITE"),GECS("SITE1")," must"
 . W " be inserted into File"
 . W !,"#2101.7 in order for you to continue with this option."
 . W !,$$REPEAT^XLFSTR("*",57)
 I %="" S SITEM=1 Q
 I '+GECSSITE D
 . I GECS("SITE") D
 . . S SUBSITE=$O(^DIC(4,"D",GECS("SITE")_GECS("SITE1"),""))
 . . I 'SUBSITE D
 . . . W !!,"Site Missing From INSTITUTION FILE #4"
 . . . W !,$$REPEAT^XLFSTR("*",51)
 . . . W !,"Site ",GECS("SITE"),GECS("SITE1")," does not exit"
 . . . W " in the INSTITUTION FILE #4"
 . . . W !,"Please contact your Information Resource Management"
 . . . W !,"(IRM) Personnel and inform them that Site "
 . . . W GECS("SITE"),GECS("SITE1")," must"
 . . . W !,"be inserted into File #4."
 . . . W !,$$REPEAT^XLFSTR("*",51)
 S STATNAME=$$GET1^DIQ(4,+GECSSITE,.01)
 I STATNAME="" D
 . S SITE99=$$GET1^DIQ(4,+GECSSITE,99) Q:'+SITE99
 . W !!,"STATION NAME missing from INSTITUTION FILE #4"
 . W !,$$REPEAT^XLFSTR("*",60)
 . W !,"Site ",$$GET1^DIQ(4,+GECSSITE,99)," STATION NAME is not entered in Field #.01 of the"
 . W !,"INSTITUTION FILE #4. Please inform your Information Resource"
 . W !,"Management(IRM) Personnel."
 . W !,$$REPEAT^XLFSTR("*",60)
 I STATNAME="",+SITE99 Q
 S %=$$GET1^DIQ(4,+GECSSITE,99) I %="" D
 . W !!,"STATION NUMBER missing from INSTITUTION FILE #4"
 . W !,$$REPEAT^XLFSTR("*",62)
 . W !,"INTERNAL ENTRY NUMBER(IEN) "_GECSSITE_" does not have "
 . W "a STATION NUMBER"
 . W !,"entered in field #99 of the INSTITUTION FILE #4. Please "
 . W "inform"
 . W !,"your Information Resource Management(IRM) Personnel."
 . W !,$$REPEAT^XLFSTR("*",62)
 Q:%=""
 S GECS("SITE")=$E(%,1,3),GECS("SITE1")=$E(%,4,6)
 I '$G(GECSFNOP) W !,"Station: ",STATNAME,"  (#",%,")"
 Q
 ;
 ;
GETUSER ;  find user
 N %,%H,%I,X,Y
 S GECS("PER")=+$G(DUZ)_"^"_$P($G(^VA(200,+$G(DUZ),0)),"^")
 I $P(GECS("PER"),"^",2)="" W !,"YOU ARE NOT AN AUTHORIZED USER.  CONTACT IRM SERVICE" K GECS Q
 D NOW^%DTC S Y=X X ^DD("DD") D
 . S GECS("FY")=$S($E(X,4,5)<10:$P(Y,",",2),1:$P(Y,",",2)+1)
 Q
