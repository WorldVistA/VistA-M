LEXDD1 ; ISL Display Defaults                     ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
SHOW ; Show user defaults
 W @IOF
 N LEXMODE,LEXUSER,LEXSERV
SELUSR ; Select user/user group
 K LEXD,LEXMODE
 W !!,"Show User Defaults for"
 W !!,"  1:  All users with defaults"
 W !,"  2:  A Single User"
 W !,"  3:  Users in a Service",!
BYUSR ; Get response to user/user group
 K ZTSAVE S LEXMODE=$$USR G:LEXMODE[U SHOWQ
 I LEXMODE=1 D  G SELUSR
 . S ZTRTN="ALL^LEXDD1" D DEV,HOME^%ZIS
 I LEXMODE=2 D  G:+($G(LEXDUZ))'<1 SELUSR
 . W ! S LEXDUZ=$$USER^LEXDM4,LEXDUZ=+LEXDUZ
 . I +LEXDUZ'<1 D
 . . S ZTRTN="ONE^LEXDD1"
 . . S ZTSAVE("LEXDUZ")=""
 . . D DEV,HOME^%ZIS
 I LEXMODE=3 D  G SELUSR
 . W ! S LEXSERV=$$SERV^LEXDM4
 . I +LEXSERV>0 D
 . . S ZTRTN="SERV^LEXDD1"
 . . S ZTSAVE("LEXSERV")=""
 . . D DEV,HOME^%ZIS
 G SHOWQ
 Q
DEV ; Request a device
 N LEXCNT,LEXLC,LEXC S (LEXCNT,LEXLC)=0,LEXC=""
 S (ZTSAVE("LEXC"),ZTSAVE("LEXCNT"),ZTSAVE("LEXLC"))=""
 N %ZIS,IOP S %ZIS="PQ" D ^%ZIS Q:POP  I $D(IO("Q")) D QUE Q
NOQUE ; Local display
 W @IOF D @ZTRTN,^%ZISC K ZTSAVE Q
QUE ; Queue task to a selected device
 N %,ZTDESC,ZTDTH,ZTIO,ZTSK Q:'$D(ZTRTN)  K IO("Q")
 S ZTDESC="Lexicon Defaults",ZTIO=ION,ZTDTH=$H
 D ^%ZTLOAD
 W !,$S($D(ZTSK):"Request Queued",1:"Request Cancelled"),!
 K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE D ^%ZISC
 Q
ALL ; Display for all users
 N LEXUSR,LEXDUZ,LEXITLE
 S LEXUSR=""
 S LEXITLE="Lexicon User Defaults (all users with defaults)"
 W !,LEXITLE W:IOST["P-" !! S LEXLC=$S(IOST["P-":LEXLC+3,1:LEXLC+1)
 F  S LEXUSR=$O(^LEXT(757.2,"AUD",LEXUSR)) Q:LEXUSR=""  D
 . N LEXDUZ S LEXDUZ=0
 . F  S LEXDUZ=$O(^LEXT(757.2,"AUD",LEXUSR,LEXDUZ)) Q:+LEXDUZ=0  D
 . . I +LEXDUZ'<1 D
 . . . S LEXOK=$$DEF I LEXOK D BUILD^LEXDD2 S LEXCNT=LEXCNT+1
 I +LEXCNT=0 D
 . W !!,"No users found with defaults set."
 D ^%ZISC I $D(ZTQUEUED) S ZTREQ="@"
 Q
ONE ; Display for one user
 Q:+($G(LEXDUZ))<1  N LEXITLE,LEXOK
 S LEXITLE="Lexicon User Defaults (Single User)"
 W !,LEXITLE W:IOST["P-" !! S LEXLC=$S(IOST["P-":LEXLC+3,1:LEXLC+1)
 I LEXDUZ'<1,$D(^VA(200,+LEXDUZ)) D
 . S LEXOK=$$DEF I LEXOK D BUILD^LEXDD2 S LEXCNT=LEXCNT+1
 . I 'LEXOK D
 . . I $P($G(^VA(200,LEXDUZ,0)),"^",1)'="" D
 . . . N LEXNAME S LEXNAME=$P($G(^VA(200,LEXDUZ,0)),"^",1)
 . . . S LEXNAME=$$FL^LEXDD4(LEXNAME)
 . . . W !,LEXNAME," has no defaults set",!
 . . I $P($G(^VA(200,LEXDUZ,0)),"^",1)="" D
 . . . W !,"User has no defaults set",!
 I LEXDUZ'<1,'$D(^VA(200,+LEXDUZ)) D
 . W !,"User not found",!
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
SERV ; Display for users in a Service
 Q:'$D(LEXSERV)  N LEXITLE
 S LEXSERV=+LEXSERV
 S LEXITLE="Lexicon User Defaults in a Single Service ("_$P(^DIC(49,LEXSERV,0),U,1)_")"
 W !,LEXITLE W:IOST["P-" !! S LEXLC=$S(IOST["P-":LEXLC+3,1:LEXLC+1)
 S LEXUSR=""
 F  S LEXUSR=$O(^LEXT(757.2,"AUD",LEXUSR)) Q:LEXUSR=""  D
 . N LEXDUZ S LEXDUZ=0
 . F  S LEXDUZ=$O(^LEXT(757.2,"AUD",LEXUSR,LEXDUZ)) Q:+LEXDUZ=0  D
 . . I +LEXDUZ'<1 D
 . . . I $P($G(^VA(200,LEXDUZ,5)),"^",1)=LEXSERV D
 . . . . S LEXOK=$$DEF
 . . . . I LEXOK D BUILD^LEXDD2 S LEXCNT=LEXCNT+1
 I +LEXCNT=0 D
 . W !!,"No users found with defaults set in the ",$P(^DIC(49,LEXSERV,0),U,1)," service."
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
SHOWQ ; Quit SHOW
 I IOST["P-" D ^%ZISC
 K ZTSAVE,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTSK,X,Y
 K DIR,DIC,DIC("S"),%,%ZIS,POP,IOP
 K LEX,LEXA,LEXAP,LEXAPID,LEXC,LEXCNT,LEXCTR,LEXCTX,LEXD
 K LEXDATA,LEXDICS,LEXDUZ,LEXFIL,LEXFN,LEXI,LEXIEN,LEXITL
 K LEXITLE,LEXT,LEXLC,LEXLN,LEXMODE,LEXNAME,LEXOK,LEXSERV
 K LEXSHOW,LEXSPC,LEXSTLN,LEXSTR,LEXSUB,LEXUSER,LEXUSR
 Q
DEF(X) ; Based on DUZ determines if there are defaults defined
 S X=0 Q:+($G(LEXDUZ))=0 X N LEXAPID,LEXIEN S LEXAPID=0
 ; Defaults by Application
 F  S LEXAPID=$O(^LEXT(757.2,"ADEF",LEXAPID)) Q:+LEXAPID=0!(X)  D  Q:X
 . S LEXIEN=0 F  S LEXIEN=$O(^LEXT(757.2,"ADEF",LEXAPID,LEXIEN)) Q:+LEXIEN=0!(X)  D  Q:X
 . . S:$L($G(^LEXT(757.2,LEXIEN,200,LEXDUZ,1))) X=1 Q:X
 . . S:$L($G(^LEXT(757.2,LEXIEN,200,LEXDUZ,2))) X=1 Q:X
 . . S:$L($G(^LEXT(757.2,LEXIEN,200,LEXDUZ,3))) X=1 Q:X
 . . S:$L($G(^LEXT(757.2,LEXIEN,200,LEXDUZ,4))) X=1 Q:X
 Q X
USR(X) ; Get response for user type/group
 N Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR("A")="Select (1-3):  ",DIR("B")=2
 S DIR("?")="Answer must be from 1 to 3"
 S DIR(0)="NAO^1:3:0" D ^DIR
 S X=$S($D(DTOUT)!(X[U)!(X=""):U,1:X) K DIR Q X
