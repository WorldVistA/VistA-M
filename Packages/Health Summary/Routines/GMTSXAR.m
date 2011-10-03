GMTSXAR ; SLC/KER - List Parameters/Resequence            ; 02/27/2002
 ;;2.7;Health Summary;**49,62**;Oct 20, 1995
 ;                    
 ; External References
 ;  DBIA 10022  %XY^%RCR
 ;  DBIA 10018  ^DIE (file #8989.51)
 ;  DBIA 10006  ^DIC (file #8989.51, 8989.518)
 ;  DBIA 10026  ^DIR
 ;  DBIA  2056  $$GET1^DIQ (file #8989.513)
 ;  DBIA  2052  FIELD^DID (file #8989.51)
 ;  DBIA  2992  ^XTV(8989.51,
 ;           
 Q
EN ; Main Entry
 N X,%X,Y,%Y,DA,DIC,DIDEL,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,GMTSA,GMTSC,GMTSCHG,GMTSCNT,GMTSCONT,GMTSCT,GMTSCUR,GMTSD,GMTSEQ,GMTSEXIT
 N GMTSF,GMTSFI,GMTSI,GMTSIE,GMTSM,GMTSMAX,GMTSN,GMTSNEW,GMTSNXC,GMTSNXT,GMTSO,GMTSOK,GMTSOLD,GMTSON,GMTSORD,GMTSPARM,GMTSPI,GMTSREM
 N GMTSREO,GMTSSSO,GMTST,GMTSTOT,GMTSUSR,GMTSMGR
 S GMTSMGR=$$MGR^GMTSXAW3 Q:GMTSMGR'>0
 S GMTSCHG=0,GMTSPARM="ORWRP HEALTH SUMMARY TYPE LIST"
 S GMTSPI=$$PDI^GMTSXAW3(GMTSPARM) Q:+GMTSPI=0
 S %X="^XTV(8989.51,"_GMTSPI_",30,",%Y="GMTSO(""AL""," D %XY^%RCR S %X="^XTV(8989.518,",%Y="GMTSO(""ET""," D %XY^%RCR K GMTSO("ET","B"),GMTSO("ET","C")
 S (GMTSI,GMTSC)=0 F  S GMTSI=$O(GMTSO("AL","B",GMTSI)) Q:+GMTSI=0  D
 . N GMTSIE S GMTSEQ(GMTSI)="",GMTSIE=0
 . F  S GMTSIE=$O(GMTSO("AL","B",GMTSI,GMTSIE)) Q:+GMTSIE=0  D
 . . N GMTSF S GMTSF=$P($G(GMTSO("AL",GMTSIE,0)),"^",2) Q:+GMTSF=0  Q:'$D(GMTSO("ET",GMTSF,0))
 . . S GMTSC=GMTSC+1
 . . S (GMTSCUR(GMTSC),GMTSOLD(GMTSC))=GMTSI_"^"_GMTSF_"^"_$G(GMTSO("ET",GMTSF,0))
 . . S GMTSOLD("B",GMTSI,GMTSC)=""
 D ORD D:+($G(GMTSEXIT))=0 CHK
 W:+($G(GMTSCHG))'>0 !!,?2,"No Changes Made"
 Q
ORD ; Order of Entities
 N GMTSI,GMTST,GMTSC,GMTSCNT,GMTSTOT,GMTSREM,GMTSSO,GMTSNXT,GMTSNXC,GMTSON
 S (GMTSSO,GMTSCNT,GMTSI,GMTSON)=0,(GMTSTOT,GMTST)=$$TOT Q:+GMTSTOT'>1
 S GMTSEXIT=0,GMTSCONT=$$CONT I +GMTSCONT>0 S GMTSEXIT=1 Q
 W !!,"     Please select the order in which you want these to be entities"
 W !,"     to be used." F  Q:+($G(GMTSEXIT))>0  D SO Q:+($G(GMTSEXIT))>0  Q:'$D(GMTSOLD)
 S GMTSEXIT=0
 Q
 ;           
SO ; Select Order
 K GMTSOLD("B") N GMTSI,GMTSC,GMTSMAX,GMTSREO S GMTSI=0,GMTSREM=$$TOT
 S GMTSCNT=GMTSTOT-GMTSREM,GMTSNXT=GMTSCNT+1,GMTSSO=+($G(GMTSSO))+1
 S GMTSNXC=$S(GMTSNXT=1:(GMTSNXT_"st"),GMTSNXT=2:(GMTSNXT_"nd"),GMTSNXT=3:(GMTSNXT_"rd"),1:(GMTSNXT_"th"))
 I +GMTSREM=1 S Y=+GMTSREM D SET Q
 W ! D SOL,REO S (GMTSC,GMTSI)=0
 S GMTSMAX=GMTSREM W ! N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR(0)="NAO^1:"_GMTSMAX_":0",DIR("?")="^D SOH1^GMTSXAR",DIR("??")="^D SOH2^GMTSXAR"
 S DIR("A")="        Select the "_GMTSNXC_" entity to be used:  "
 K DIR("B") S:+($O(GMTSREO(0)))>0 DIR("B")=+($O(GMTSREO(0)))
 D ^DIR I Y="",X="@" D
 . N GMTSD S GMTSD=$P($G(^GMT(142.98,+($G(GMTSUSR)),1)),"^",2)
 . S GMTSEXIT="1^"_$S($L(GMTSD):"",1:"exiting")
 . S Y="@" K GMTSORD S GMTSORD("@")=""
 S:Y["^"!($D(DUOUT))!($D(DIROUT)) GMTSEXIT="1^exiting" S:$D(DTOUT) GMTSEXIT="1^try later"
 I +($G(GMTSEXIT))>0 W $S($L($P(GMTSEXIT,"^",2)):"...",1:""),$P(GMTSEXIT,"^",2) Q
 I +Y>0,+Y'>GMTSREM D SET
 Q
SOL ;   List 
 N GMTSN,GMTSA,GMTST,GMTSC,GMTSI S (GMTSC,GMTSI)=0 F  S GMTSI=$O(GMTSOLD(GMTSI)) Q:+GMTSI=0  D
 . S GMTSC=GMTSC+1,GMTSA=$P(GMTSOLD(GMTSI),"^",4),GMTSN=$P(GMTSOLD(GMTSI),"^",5)
 . S GMTST=GMTSN_$S(GMTSA="DEV"!(GMTSA="DIV")!(GMTSA="SYS")!(GMTSA="PKG")!(GMTSA="LOC")!(GMTSA="BED"):" level ",1:" ")_"defined Health Summary Types"
 . W !,?5,$J(GMTSC,4),"  ",GMTST
 Q
SOH1 ;   Help - Single ?
 N GMTSC,GMTSI,GMTSN,GMTSCT S (GMTSC,GMTSI)=0,GMTSCT=+($G(GMTSNXT)) F  S GMTSI=$O(GMTSOLD(GMTSI)) Q:+GMTSI=0  S GMTSC=GMTSC+1
 S GMTSN=$S(GMTSCT=1:"first",GMTSCT=2:"second",GMTSCT=3:"third",GMTSCT=4:"fourth",GMTSCT=5:"fifty",GMTSCT=6:"sixth",GMTSCT=7:"seventh",GMTSCT=8:"eighth",GMTSCT=9:"nineth",GMTSCT=10:"tenth",GMTSCT=11:"eleventh",1:"")
 I '$L(GMTSN),+GMTSC>1 W !,?11,"Select a Health Summary Type entity to list" W:$L($G(GMTSNXC)) " ",GMTSNXC W " (1-",GMTSC,")",!
 I $L(GMTSN),+GMTSC>1 W !,?11,"Select a Health Summary Type entity to list ",GMTSN," (1-",GMTSC,")",!
 D SOL
 Q
SOH2 ;   Help - Double ??
 I '$L($G(GMTSPARM)) D SOH1 Q
 W !,?11,"Parameter """,GMTSPARM,""" has multiple "
 W !,?11,"allowable entities for which Health Summary Types may"
 W !,?11,"be assigned and displayed on the CPRS reports tab.  Now"
 W !,?11,"you must select the order in which you want these entites"
 W !,?11,"to be used by the site.",!
 D SOL
 Q
 ;          
 ; Arrange
SET ;   Set Order
 D REO N GMTSO S GMTSO=+($O(GMTSORD(" "),-1))+1
 I $L($P($G(GMTSREO(+($G(Y)))),"^",2,299)) D
 . S GMTSON=$O(GMTSEQ(GMTSON))
 . S GMTSORD(GMTSO)=GMTSON_"^"_$P($G(GMTSREO(+Y)),"^",2,299)
 S (GMTSC,GMTSI)=0
 F  S GMTSI=$O(GMTSOLD(GMTSI)) Q:+GMTSI=0  D
 . S GMTSC=GMTSC+1 I GMTSC=+Y K GMTSOLD(GMTSI),GMTSREO(GMTSC)
 Q
REO ;   Re-order
 K GMTSREO N GMTSC,GMTSI S (GMTSC,GMTSI)=0
 F  S GMTSI=$O(GMTSOLD(GMTSI)) Q:+GMTSI=0  D
 . S GMTSC=GMTSC+1 S GMTSREO(GMTSC)=$G(GMTSOLD(GMTSI))
 Q
TOT(X) ;   Total Allowable Entities
 N GMTSI S (X,GMTSI)=0 F  S GMTSI=$O(GMTSOLD(GMTSI)) Q:+GMTSI=0  S X=X+1
 Q X
CONT(X) ; Ask to Continue
 S:$O(GMTSCUR(0))=0!('$L($G(GMTSPARM)))!(+($G(GMTSTOT))'>1) GMTSEXIT=1
 Q:$O(GMTSCUR(0))=0!('$L($G(GMTSPARM)))!(+($G(GMTSTOT))'>1) 0
 W !!!," Parameter """,GMTSPARM,""" has ",GMTSTOT," allowable entities"
 W !," which may have the Health Summary Types on the CPRS reports tab "
 W !," and are used in the following order:"
 N DIR,DIROUT,DUOUT,DTOUT,GMTSA,GMTSN,GMTST,GMTSC,GMTSI D CONTM
 S DIR("A")=" Are these in the correct order for your site?  "
 S (DIR("?"),DIR("??"))="^D CONTH^GMTSXAR",DIR("B")="Y",DIR(0)="YAO" W ! D ^DIR
 S X=+($G(Y)) Q X
 Q 1
CONTH ;   Continue Help
 W !,"   Enter either 'Y' or 'N'"
 D CONTM Q
CONTM ;   Continue Menu
 S (GMTSC,GMTSI)=0 F  S GMTSI=$O(GMTSCUR(GMTSI)) Q:+GMTSI=0  D
 . S GMTSA=$P(GMTSCUR(GMTSI),"^",4),GMTSN=$P(GMTSCUR(GMTSI),"^",5)
 . S GMTST=GMTSN_$S(GMTSA="DEV"!(GMTSA="DIV")!(GMTSA="SYS")!(GMTSA="PKG")!(GMTSA="LOC")!(GMTSA="BED"):" level ",1:" ")_"defined Health Summary Types"
 . S GMTSC=GMTSC+1 W:GMTSC=1 ! W !,$J(GMTSC,6),"  ",GMTST
 Q
CHK ; Check if OK
 N GMTSC,GMTSI,GMTSA S (GMTSC,GMTSI)=0 F  S GMTSI=$O(GMTSCUR(GMTSI)) Q:+GMTSI=0  S:GMTSCUR(GMTSI)'[$G(GMTSORD(GMTSI)) GMTSC=1
 I 'GMTSC S GMTSCHG=0 Q
 W !!,?8,"You have selected to resequenced the Health Summary Type"
 W !,?8,"entities in the following order:",!
 D CHKM S GMTSA=$$OK D:+($G(GMTSA))>0 ED
 Q
CHKM ;   Check (Menu)
 N GMTSC,GMTSI S (GMTSC,GMTSI)=0 F  S GMTSI=$O(GMTSCUR(GMTSI)) Q:+GMTSI=0  S:GMTSCUR(GMTSI)'[$G(GMTSORD(GMTSI)) GMTSC=1
 Q:'GMTSC  S (GMTSC,GMTSI)=0 F  S GMTSI=$O(GMTSCUR(GMTSI)) Q:+GMTSI=0  D
 . S GMTSC=GMTSC+1 W:GMTSC=1 !,?13,"FROM (Current)",?33,"TO (Resequenced)",!,?13,"----------------",?33,"----------------"
 . W !,?7,$J(GMTSC,4),?13,$P($G(GMTSCUR(GMTSI)),"^",5),?33,$P($G(GMTSORD(GMTSI)),"^",5)
 Q
OK(X) ; Ask if OK
 W ! N DIR,DIROUT,DUOUT,DTOUT S (DIR("?"),DIR("??"))="^D OKH^GMTSXAR"
 S DIR("A")="         Is this OK?  ",DIR("B")="Y",DIR(0)="YAO" D ^DIR S X=+($G(Y)) Q X
OKH ;   OK Help
 W !,"           Enter either 'Y' or 'N'",!,!,"         Resequence entities:",! D CHKM Q
 ;           
ED ; Edit Record
 N DIC,DA,DIE,DR,DIDEL,DTOUT,GMTSFI,GMTSI,GMTSEQ,GMTSCNT,GMTST
 S GMTSPI=+($G(GMTSPI)),GMTSCNT=0
 I GMTSPI'>0!(+($O(GMTSORD(0)))'>0)!('$L($G(GMTSPARM)))!($$PDN^GMTSXAW3(+GMTSPI)'=$G(GMTSPARM)) D  Q
 . W !,?5," Unable to resequence at this time."
 S DA(1)=+($G(GMTSPI)) Q:DA(1)'>0  S (DIC,DIE)="^XTV(8989.51,"_DA(1)_",30,",DR=".02///^S X=$G(GMTSFI)"
L ;   Lock Record
 L +^XTV(8989.51,+($G(GMTSPI))) S GMTSCNT=GMTSCNT+1,GMTST=$T
 I 'GMTST,GMTSCNT'>3 H 2 G L
 I 'GMTST,GMTSCNT>3 W !," Another user is editing this entry.",!," Unable to resequence at this time." Q
 S GMTSI=0 F  S GMTSI=$O(GMTSORD(GMTSI)) Q:+GMTSI=0  D
 . S GMTSFI=$P(GMTSORD(GMTSI),"^",2),GMTSEQ=$P(GMTSORD(GMTSI),"^",1)
 . S DA=$$DA(DA(1),GMTSEQ),X=GMTSEQ D ^DIE S GMTSCHG=1
 L -^XTV(8989.51,+($G(GMTSPI)))
 Q
DA(GMTSI,X) ;   Get DA
 N DA,DIC,DTOUT,DUOUT,Y,GMTSM S DA(1)=+($G(GMTSI)),X=+($G(X))
 S DIC="^XTV(8989.51,"_DA(1)_",30,",DIC(0)="M" D ^DIC S X=+($G(Y)) Q X
 Q
 ;                
ADED ; Add/Edit
 N X,Y,DA,DIC,DIE,DLAYGO,DR,DTOUT,DUOUT,GMTSCNT,GMTSDEF,GMTSENT
 N GMTSM,GMTSMGR,GMTSNEW,GMTSPARM,GMTSPI,GMTST
 S GMTSMGR=$$MGR^GMTSXAW3 Q:GMTSMGR'>0
 S GMTSPARM="ORWRP HEALTH SUMMARY TYPE LIST"
 S GMTSPI=$$PDI^GMTSXAW3(GMTSPARM) Q:+GMTSPI=0
 W !! W:$L(GMTSPARM) "'" W GMTSPARM W:$L(GMTSPARM) "' " W "ALLOWABLE ENTITIES",!
 S DA(1)=+($G(GMTSPI)),GMTSCNT=0
 S (DIC,DIE)="^XTV(8989.51,"_DA(1)_",30,",DIC(0)="AEQMLZ"
 S DIC("DR")=".02///^S X=$$AE^GMTSXAR(+($G(Y)))"
 S DLAYGO="" D FIELD^DID(8989.51,30,"","SPECIFIER","GMTST(""DID"")","GMTSM(""ERR"")")
 S:$L($G(GMTST("DID","SPECIFIER"))) DIC("P")=$G(GMTST("DID","SPECIFIER"))
L2 ;   Lock Record
 L +^XTV(8989.51,+($G(GMTSPI))) S GMTSCNT=GMTSCNT+1,GMTST=$T
 I 'GMTST,GMTSCNT'>3 H 2 G L2
 I 'GMTST,GMTSCNT>3 W !," Another user is editing this entry.",!," Unable to resequence at this time." Q
 D ^DIC S GMTSNEW=+($P($G(Y),"^",3)) Q:GMTSNEW>0  Q:+Y'>0
 N DIC,DIE S DA(1)=GMTSPI,DA=+($G(Y)),(DIC,DIE)="^XTV(8989.51,"_DA(1)_",30,"
 S DA=+($G(Y)),DR=".01;.02///^S X=$$AE^GMTSXAR("_DA_")"
 D ^DIE L -^XTV(8989.51,+($G(GMTSPI)))
 Q
AE(X) ;   Allowable Entity
 N DA,DIC,DTOUT,DUOUT,Y,GMTSPARM,GMTSPI,GMTSENT,GMTSDEF
 S GMTSDEF="",GMTSENT=+($G(X)),GMTSPARM="ORWRP HEALTH SUMMARY TYPE LIST"
 S GMTSPI=$$PDI^GMTSXAW3(GMTSPARM) Q:+GMTSPI=0 ""
 S:+GMTSENT>0 GMTSDEF=$$GET1^DIQ(8989.513,(GMTSENT_","_GMTSPI_","),.02)
 N DA,DIC,DTOUT,DUOUT,Y S DIC="^XTV(8989.518,",DIC(0)="AEMQ"
 S DIC("S")="I Y'=3.5&(Y'=9.4)&(Y'=44)&(Y'=404.51)&(Y'=405.4)"
 S:$L($G(GMTSDEF)) DIC("B")=GMTSDEF D ^DIC S X=+($G(Y))
 Q X
