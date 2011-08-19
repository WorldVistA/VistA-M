GMTSXAP ; SLC/KER - List Parameters/Precedence            ; 02/27/2002
 ;;2.7;Health Summary;**47,49**;Oct 20, 1995
 Q
 ;                          
 ; External References in GMTSXAP
 ;   DBIA  2343  $$ACTIVE^XUSER
 ;   DBIA 10026  ^DIR
 ;                          
EN ; Main Entry Point for Health Summary
 N GMTSUSR S GMTSUSR=+($G(DUZ)) D PREF Q
EN2(X) ; Entry Point for User
 N GMTSUSR S GMTSUSR=+($G(X)) D PREF Q
 ;                          
PREF ; Get Preference - Precedence
 N GMTSACT Q:'$L($$UNM^GMTSXAW3(+($G(GMTSUSR))))
 S GMTSACT=$$ACTIVE^XUSER(+GMTSUSR) D:+GMTSACT'>0 DP^GMTSXAP2(GMTSUSR)
 Q:+GMTSACT'>0  S X=$$PRE(GMTSUSR) D:$L(X) EDIT^GMTSXAP2(GMTSUSR,X) Q
 ;                                  
PRE(GMTSUSR) ; Precedence of Parameter Entities
 ;                          
 ;   Input    User, pointer to NEW PERSON file
 ;
 ;   Output   String of Selected Entity Abbreviations,
 ;            delimited by a semi-colon, and arranged in
 ;            the order they should be used.
 ;                          
 ;               Example:  USR;SYS;NAT
 ;                          
 ;             Use "User" defined Health Summary Types, 
 ;             "System" defined Health Summary Types and
 ;             "National" Health Summary Types in that order.
 ;                          
 N GMTSEL,GMTSORD,GMTS,GMTSDEF,GMTSEXIT,GMTSINC,GMTSIN,GMTSCPL,GMTSPRE
 S GMTSUSR=+($G(GMTSUSR)),GMTSEXIT=0 Q:'$L($$UNM^GMTSXAW3(+($G(GMTSUSR)))) ""
 W:+($G(GMTSUSR))'=.5 !,"CPRS Reports Tab, Health Summary Type List (Contents)",!
 W:+($G(GMTSUSR))=.5 !,"Site Default CPRS Reports Tab, Health Summary Type List (Contents)",!
 D INA S GMTSIN=0 F  S GMTSIN=$O(GMTSINC(GMTSIN)) Q:+GMTSIN=0  Q:+($G(GMTSEXIT))>0  D INC(GMTSINC(GMTSIN)) Q:+($G(GMTSEXIT))>0
 I +GMTSEXIT>0,$D(GMTSEL("@")) D ADEL^GMTSXAP2
 Q:+($G(GMTSEXIT))>0 "" S X="" I '$D(GMTSEL)!($O(GMTSEL(0))'>0) Q X
 I $D(GMTSEL),$O(GMTSEL(0))>0 D ORD
 I +GMTSEXIT>0,$D(GMTSORD("@")) D ADEL^GMTSXAP2
 S:+($G(GMTSEXIT))=0 X=$$CPL
 I +GMTSEXIT>0,$D(GMTSCPL("@")) D ADEL^GMTSXAP2
 Q X
 ; Include Health Summary Types
INA ;   Input Array (from Parameter File)
 N GMTSI,GMTST,GMTSA,GMTSN,GMTSP,GMTSH,GMTSC,GMTSALW D EN^GMTSXAW
 S (GMTSC,GMTSI)=0 F  S GMTSI=$O(GMTSALW(GMTSI)) Q:+GMTSI=0  D
 . S GMTST=$G(GMTSALW(GMTSI)) Q:'$L(GMTST)  S GMTSA=$P(GMTST,"^",1) Q:$L(GMTSA)'=3  S GMTSN=$P(GMTST,"^",4) Q:'$L(GMTSN)
 . ; Include User Preferred Health Summary Types:  (Y/N)
 . ; Include System Defined Health Summary Types:  (Y/N)
 . ; Group National Types together (Remote Data Views): (Y/N)
 . S GMTSP="Include "_GMTSN_" Defined Health Summary Types"
 . S GMTSH=GMTSN_" Level Health Summary Types"
 . S:GMTSA="USR" GMTSP="Include "_GMTSN_" Preferred Health Summary Types",GMTSH=GMTSN_" Preferred Health Summary Types"
 . S GMTSC=GMTSC+1,GMTSINC(GMTSC)=GMTSA_"^"_GMTSP_"^"_GMTSH
 S GMTSC=GMTSC+1,GMTSA="NAT",GMTSN="National"
 S GMTSP="Group "_GMTSN_" Types together (Remote Data View)"
 S GMTSH="Nationally Exported Health Summary Types"
 S GMTSINC(GMTSC)=GMTSA_"^"_GMTSP_"^"_GMTSH
 Q
INC(X) ;   Select Health Summary Types to Include
 Q:+($G(GMTSEXIT))>0  N Y,DIR,%,%P,DTOUT,DUOUT,DIRUT,DIROUT,GMTSI,GMTST,GMTSA,GMTSO S GMTST=$G(X)
 S GMTSA=$P(GMTST,"^",1),GMTSO=$P(GMTST,"^",3),GMTST=$P(GMTST,"^",2) Q:'$L(GMTST)  Q:GMTSA'?3U
 S GMTSI=+($O(GMTSDEF(" "),-1))+1,GMTSDEF(GMTSI)=GMTSA_"^"_GMTST_"^"_GMTSO
 S DIR(0)="YAO",DIR("A")="  "_GMTST_":" F  Q:$L(DIR("A"))>51  S DIR("A")=DIR("A")_" "
 S DIR("A")=DIR("A")_" (Y/N)  " S:$L(GMTSO) DIR("A")="  "_DIR("A")
 S DIR("B")="Y",DIR("?")="^D INH1^GMTSXAP",DIR("??")="^D INH2^GMTSXAP"
 S:DIR("A")["Group Nat" DIR("B")="N"
 D ^DIR I Y="",X="@" D
 . N GMTSD S GMTSD=$P($G(^GMT(142.98,+($G(GMTSUSR)),1)),"^",2)
 . S GMTSEXIT="1^"_$S($L(GMTSD):"",1:"exiting")
 . S Y="@" K GMTSEL S GMTSEL("@")=""
 S:Y["^"!($D(DUOUT))!($D(DIROUT)) GMTSEXIT="1^exiting"
 S:$D(DTOUT) GMTSEXIT="1^try later"
 I +($G(GMTSEXIT))>0 W $S($L($P(GMTSEXIT,"^",2)):"...",1:""),$P(GMTSEXIT,"^",2) Q
 I +Y>0 S GMTSI=+($O(GMTSEL(" "),-1))+1,GMTSEL(GMTSI)=GMTSA_"^"_GMTST_"^"_GMTSO
 Q
INH1 ;     Include Help - Single ?
 W !,"        Enter either 'Y' or 'N'" D INH3 Q
INH2 ;     Include Help - Double ??
 W !,"        Select specified groups of Health Summary Types to include in the"
 W !,"        Health Summary Types list on the CPRS Reports Tab.  Groups include:",!
 W !,"            USR   User Preferred Health Summary Types in the Parameters file"
 W !,"            SYS   System Defined Summary Types in the parameters file"
 W !,"            NAT   National Health Summary Types (Remote Data Views)" D INH3 Q
INH3 ;     Include Help - Prompt
 I $L($G(DIR("A"))),$G(DIR("A"))'["Include",$G(DIR("A"))=$G(%P) D
 . N GMTSL S GMTSL="            ",GMTSL=$S($G(DIR("A"))[GMTSL:"  ",1:"")
 . S (%P,DIR("A"))=GMTSL_"  Include "_$$TRIM^GMTSXA(DIR("A")," ",1)
 Q
 ;                              
ORD ; Order of Health Summaries in List
 N GMTSI,GMTST,GMTSC,GMTSCNT,GMTSTOT,GMTSREM,GMTSSO,GMTSNXT,GMTSNXC
 S (GMTSSO,GMTSCNT,GMTSI)=0,(GMTSTOT,GMTST)=$$SLT^GMTSXAP2
 ;   One Selected
 I GMTST=1 D  Q
 . S (GMTSI,GMTSC)=0 F  S GMTSI=$O(GMTSEL(GMTSI)) Q:+GMTSI=0  D
 . . S GMTST=$P($G(GMTSEL(GMTSI)),"^",1)
 . . S:GMTST?3U GMTSC=GMTSC+1,GMTSORD(GMTSC)=GMTSEL(GMTSI)
 ;   Multiple Selected
 W !!!," You have selected multiple Health Summary types to be listed on the CPRS",!," reports tab.  Now you must select the order in which you want these to",!," be displayed."
 F  Q:+($G(GMTSEXIT))>0  D SO Q:+($G(GMTSEXIT))>0  Q:'$D(GMTSEL)
 Q
SO ;   Select Order
 N GMTSI,GMTSC,GMTSMAX,GMTSREO S GMTSI=0,GMTSREM=$$SLT^GMTSXAP2
 S GMTSCNT=GMTSTOT-GMTSREM,GMTSNXT=GMTSCNT+1,GMTSSO=+($G(GMTSSO))+1
 S GMTSNXC=$S(GMTSNXT=1:(GMTSNXT_"st"),GMTSNXT=2:(GMTSNXT_"nd"),GMTSNXT=3:(GMTSNXT_"rd"),1:(GMTSNXT_"th"))
 I +GMTSREM=1 D  Q
 . S Y=+GMTSREM D SET
 W ! D:+($G(GMTSSO))=1 SOHD D SOL,REO S (GMTSC,GMTSI)=0
 S GMTSMAX=GMTSREM
 W ! N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR(0)="NAO^1:"_GMTSMAX_":0"
 S DIR("?")="^D SOH1^GMTSXAP"
 S DIR("??")="^D SOH2^GMTSXAP"
 S DIR("A")="         Select the "_GMTSNXC_" to be listed:  "
 K DIR("B") S:+($O(GMTSREO(0)))>0 DIR("B")=+($O(GMTSREO(0)))
 D ^DIR I Y="",X="@" D
 . N GMTSD S GMTSD=$P($G(^GMT(142.98,+($G(GMTSUSR)),1)),"^",2)
 . S GMTSEXIT="1^"_$S($L(GMTSD):"",1:"exiting")
 . S Y="@" K GMTSORD S GMTSORD("@")=""
 S:Y["^"!($D(DUOUT))!($D(DIROUT)) GMTSEXIT="1^exiting" S:$D(DTOUT) GMTSEXIT="1^try later"
 I +($G(GMTSEXIT))>0 W $S($L($P(GMTSEXIT,"^",2)):"...",1:""),$P(GMTSEXIT,"^",2) Q
 I +Y>0,+Y'>GMTSREM D SET
 Q
SOL ;     List - Included Health Summaries
 N GMTSC,GMTSI S (GMTSC,GMTSI)=0 F  S GMTSI=$O(GMTSEL(GMTSI)) Q:+GMTSI=0  D
 . S GMTSC=GMTSC+1 W !,?9,$J(GMTSC,4),"  ",$P(GMTSEL(GMTSI),"^",3)
 Q
SOHD ;     Help Text
 W !,"    Order to Display Included Health Summary Types",! Q
SOH1 ;     Help - Single ?
 N GMTSC,GMTSI,GMTSN,GMTSCT S (GMTSC,GMTSI)=0,GMTSCT=+($G(GMTSNXT)) F  S GMTSI=$O(GMTSEL(GMTSI)) Q:+GMTSI=0  S GMTSC=GMTSC+1
 S GMTSN=$S(GMTSCT=1:"first",GMTSCT=2:"second",GMTSCT=3:"third",GMTSCT=4:"fourth",GMTSCT=5:"fifty",GMTSCT=6:"sixth",GMTSCT=7:"seventh",GMTSCT=8:"eighth",GMTSCT=9:"nineth",1:"")
 I '$L(GMTSN),+GMTSC>1 W !,?9,"Select a group of Health Summary Types to list (1-",GMTSC,")",!
 I $L(GMTSN),+GMTSC>1 W !,?9,"Select a group of Health Summary Types to list ",GMTSN," (1-",GMTSC,")",!
 D SOL
 Q
SOH2 ;     Help - Double ??
 W !,"         You have included multiple Health Summary types to be"
 W !,"         listed on the CPRS reports tab, Health Summary Types box."
 W !,"         Now you must select the order in which you want these"
 W !,"         to be listed.",!
 D SOL
 Q
 ;                                 
 ; Arrange
SET ;   Set Order
 D REO N GMTSO S GMTSO=+($O(GMTSORD(" "),-1))+1
 S:$L($G(GMTSREO(+$G(Y)))) GMTSORD(GMTSO)=$G(GMTSREO(+Y))
 S (GMTSC,GMTSI)=0
 F  S GMTSI=$O(GMTSEL(GMTSI)) Q:+GMTSI=0  D
 . S GMTSC=GMTSC+1 I GMTSC=+Y K GMTSEL(GMTSI),GMTSREO(GMTSC)
 Q
REO ;   Re-order
 K GMTSREO N GMTSC,GMTSI S (GMTSC,GMTSI)=0
 F  S GMTSI=$O(GMTSEL(GMTSI)) Q:+GMTSI=0  D
 . S GMTSC=GMTSC+1 S GMTSREO(GMTSC)=$G(GMTSEL(GMTSI))
 Q
CPL(X) ;   Compile Order
 Q:+($G(GMTSEXIT))>0 ""
 N GMTSI,GMTSA,GMTSOK,GMTSNEW S X="",GMTSI=0
 F  S GMTSI=$O(GMTSORD(GMTSI)) Q:+GMTSI=0  D
 . S GMTSA=$$UP^GMTSXA($P($G(GMTSORD(GMTSI)),"^",1))
 . S:GMTSA?3U X=$G(X)_";"_GMTSA
 S (GMTSNEW,X)=$$TRIM^GMTSXA(X,";",3)
 S GMTSOK=$$OK^GMTSXAP2 Q:GMTSOK'>0 ""
 Q X
