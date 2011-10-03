IBCEFG61 ;ALB/TMP - OUTPUT FORMATTER MAINT-FORM FLD ACTION PROCESSING (CONT) ;28-JAN-96
 ;;2.0;INTEGRATED BILLING;**52,51**;21-MAR-94
 ;
VIEW(IBDA,IBDA1) ; Display contents of ien IBDA in file 364.6 and
 ; field definition (ien IBDA1 in file 364.7)
 N IB0,IB00,IBELE,IBELE0,IB0X,Z,L,IBSEC
 S IB0=$G(^IBA(364.6,IBDA,0)),IB00=$G(^IBA(364.7,IBDA1,0)),IBELE=$P(IB00,U,3),IBELE0=$G(^IBA(364.5,+IBELE,0)),IBSEC=$S($P(IB00,U,2)="N":"National",1:"Local")
 S Z=$P(IB0,U,3),IB0X=$S('Z:IB0,1:$G(^IBA(364.6,Z,0)))
 S L="",$P(L,"*",81)="" W !,L
 I Z,Z'=+IB00 S Z="*Over-rides "_IBSEC_" Form Field: "_$P(IB0X,U,10)_"*" W !,?(80-$L(Z)\2),Z
 W !!,"    Page/Seg: ",$P(IB0X,U,4),?28,"First Line: ",$P(IB0X,U,5),?52,"Col/Pc: ",$P(IB0X,U,8)
 W !,"      Length: ",$P(IB0X,U,9),?35,"Pad: ",$$EXTERNAL^DILFD(364.7,.07,"",$P(IB00,U,7))
 W:$P(IB0X,U,6) !,"      Max #: ",$P(IB0X,U,6)
 W !
 S Z=$$EXTERNAL^DILFD(364.7,.05,"",$P(IB00,U,5)) S:Z="" Z="ALL"
 W !,"    Ins. Co.: ",Z
 S Z=$$EXTERNAL^DILFD(364.7,.06,"",$P(IB00,U,6)) S:Z="" Z="BOTH"
 W !,"   Bill Type: ",Z
 W:$P(IB00,U,3) !,"Data Element: ",$P(IBELE0,U)
 W:$P(IB00,U,4)'="" !," Scrn Prompt: ",$P(IB00,U,4)
 W:$P(IB00,U,9)'="" !," Edit Status: ",$$EXTERNAL^DILFD(364.7,.09,"",$P(IB00,U,9))
 W !
 W:$G(^IBA(364.5,+IBELE,2))'="" !," Array: ",^(2)
 W:$P(IBELE0,U,6)'="" !," Fileman Fld: ",$P(IBELE0,U,6)_"("_$S($P(IBELE0,U,6)="E":"ex",1:"in"),"ternal)"
 W:$P(IBELE0,U,8)'="" !,"Constant Val: ",$P(IBELE0,U,8)
 W:$G(^IBA(364.5,+IBELE,1))'="" !,"Extract Code:",!,"  ",^(1)
 W:$G(^IBA(364.7,IBDA1,1))'="" !," Format Code:",!,"  ",^(1)
 W !,L,!!!
 Q
 ;
VIEWE(IB) ; Display contents of data element ien IB in file 364.5
 N IBELE0,IB0X,Z,L
 S IBELE0=$G(^IBA(364.5,IB,0))
 S L="",$P(L,"*",81)="" W !,L
 W !,"National/Loc: ",$$EXTERNAL^DILFD(364.5,.02,"",$P(IBELE0,U,2))
 W !,"   Base File: ",$P(IBELE0,U,5)," - ",$P($G(^DIC(+$P(IBELE0,U,5),0)),U)
 W !,"        Type: ",$$EXTERNAL^DILFD(364.5,.03,"",$P(IBELE0,U,3))
 S Z=$P(IBELE0,U,4) S:Z="" Z="I"
 W !,"    Category: ",$$EXTERNAL^DILFD(364.5,.04,"",Z)
 W:$P(IBELE0,U,6)'="" !," Fileman Fld: ",$P(IBELE0,U,6)_"("_$S($P(IBELE0,U,6)="E":"ex",1:"in"),"ternal)"
 W:$P(IBELE0,U,8)'="" !,"Constant Val: ",$P(IBELE0,U,8)
 W:$G(^IBA(364.5,IB,2))'="" !,"       Array: ",^(2)
 W:$G(^IBA(364.5,IB,1))'="" !,"Extract Code:",!,"  ",^(1)
 I $O(^IBA(364.5,IB,3,0)) D
 .W !,"Description: "
 .S Z=0 F  S Z=$O(^IBA(364.5,IB,3,Z)) Q:'Z  W !," ",^(Z,0)
 W !,L,!!!
 Q
 ;
