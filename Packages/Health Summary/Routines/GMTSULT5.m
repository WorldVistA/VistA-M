GMTSULT5 ; SLC/KER - HS Type Lookup (User Input)  ; 01/06/2003
 ;;2.7;Health Summary;**30,35,56,58**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10026  ^DIR
 ;   DBIA 10006  ^DIC  (file #142)
 ;   DBIA 10060  ^VA(200,
 ;   DBIA  2056  $$GET1^DIQ  (file #200)
 ;                      
 Q
INPUT(X) ; Get User's Input
 N Y,GMTSDISV,GMTSB,GMTSD,DIR S GMTSDISV=0 D GDISV
 S DIR(0)="FAO^1:30^N GMTS S X=$$DEF^GMTSULT5(X),GMTS=$$INPT^GMTSULT5(X) K:'GMTS X"
 S DIR("?")="^D IN1^GMTSULT5",DIR("??")="^D IN2^GMTSULT5"
 S:'$L($G(GMTSDICA)) DIR("A")="Select HEALTH SUMMARY TYPE:  " S:$L($G(GMTSDICA)) DIR("A")=GMTSDICA
 S GMTSD=0 S:$L($G(GMTSDICB)) DIR("A")=DIR("A")_$G(GMTSDICB)_"//  "
 I $L($G(DIR("B"))) W !,DIR("A") S X=DIR("B") Q X
 D ^DIR K:X=""&($L($G(GMTSDICB)))&('$D(DTOUT)) DIRUT
 S:X=""&($L($G(GMTSDICB))) (X,Y)=GMTSDICB,GMTSDEF=1 Q:$D(DTOUT)!($D(DUOUT)) X
 S:X=" "&($L(Y))&($G(GMTSDIC0)'["F")&(+GMTSDISV>0)&($L($P($G(^GMT(142,+GMTSDISV,0)),"^",1))) X="`"_GMTSDISV
 Q X
 ;                        
 ; Help
IN1 ;   Single Question Mark Help ? for User Input
 N %,%A,%B,%B1,%B2,%B3,%BA,%C,%E,%G,%H,%I,%J,%N,%P,%S,%T,%W,%X,%Y,%BU,%J1,%A0,%W0,%D1,%D2,%DT,%K,%M
 I X=" "&($G(GMTSDIC0)'["F") D  Q
 . D GDISV
 . S:+($G(GMTSDISV))>0 X=$P($G(^GMT(142,+($G(GMTSDISV)),0)),U,1),(Y,GMTSD)=+GMTSDISV
 D GHT Q
IN2 ;   Double Question Mark Help ? with listing
 N %,%A,%B,%B1,%B2,%B3,%BA,%C,%E,%G,%H,%I,%J,%N,%P,%S,%T,%W,%X,%Y,%BU,%J1,%A0,%W0,%D1,%D2,%DT,%K,%M
 W !!,"Choose from:"
 N GMTSHS,GMTSC,GMTSCT,GMTSIEN,GMTSOK,GMTSTR,GMTSTL,GMTST,GMTSPL,GMTSTT,GMTSRR
 S (GMTSC,GMTST)=0,GMTSCT=1,GMTSHS="",GMTSPL=+($G(IOSL))-8 S:GMTSPL'>0 GMTSPL=18
 S GMTSTT=0,GMTSHS="" F  S GMTSHS=$O(^GMT(142,"B",GMTSHS)) Q:GMTSHS=""  S GMTSIEN=0 F  S GMTSIEN=$O(^GMT(142,"B",GMTSHS,GMTSIEN)) Q:+GMTSIEN=0  S GMTSTT=GMTSTT+1
 S GMTSRR=GMTSTT F  S GMTSHS=$O(^GMT(142,"B",GMTSHS)) Q:GMTSHS=""!('GMTSCT)  Q:GMTST>0  D  Q:'GMTSCT  Q:GMTST>0
 . S GMTSIEN=0 F  S GMTSIEN=$O(^GMT(142,"B",GMTSHS,GMTSIEN)) Q:+GMTSIEN=0!('GMTSCT)  Q:GMTST>0  D  Q:'GMTSCT  Q:+GMTST>0
 . . S GMTSTL="",GMTSOK=1,GMTSTR=$P($G(^GMT(142,GMTSIEN,0)),U,1) Q:'$L(GMTSTR)
 . . S GMTSOK=1 I $L($G(GMTSDICS)) S GMTSOK=$$DICS^GMTSULT2(GMTSDICS,X,GMTSIEN) Q:'GMTSOK
 . . F  Q:$L(GMTSTR)>33  S GMTSTR=GMTSTR_" "
 . . S GMTSTL=$P($G(^GMT(142,GMTSIEN,"T")),U,1)
 . . S:$L(GMTSTL) GMTSTR=GMTSTR_GMTSTL
 . . S GMTSC=GMTSC+1,GMTSRR=GMTSRR-1 W !,?3,GMTSTR I +GMTSC>GMTSPL D IN2C S GMTSC=0
 W ! D:GMTST'>1 GHT Q
IN2C ;   Ask to Continue Listing
 N X W !,?3,"""^"" TO STOP:" R X:300
 S:'$T!(X["^") GMTSC=0 S:X["^" GMTST=1
 S:X["^^" GMTST=2 Q
GHT ;   General Help Text
 W !,?5,"Answer with Health Summary Type name, title, owner or hospital"
 W !,?5,"location using the summary.  Your response must be at least 2"
 W !,?5,"characters and no more than 30 characters and must not contain"
 W !,?5,"an embedded uparrow" Q
 ;                        
 ; Defaults values
DEF(X) ;   Default
 S X=$G(X)
 I +X>0,$D(^GMT(142,+X,0)),($G(GMTSDIC0)["N"!($G(GMTSDIC0)["N")) D  Q X
 . S (Y,GMTSD)=+X,X=$P($G(^GMT(142,+Y,0)),U,1)
 I $E(X,1)="`",+($E(X,2,$L(X)))>0,$D(^GMT(142,+($E(X,2,$L(X))),0)) D  Q X
 . S (Y,GMTSD)=+($E(X,2,$L(X))),X=$P($G(^GMT(142,+Y,0)),U,1)
 I X=" "&($G(GMTSDIC0)'["F") D
 . D GDISV S:+($G(GMTSDISV))>0 X=$P($G(^GMT(142,+($G(GMTSDISV)),0)),U,1),(Y,GMTSD)=+GMTSDISV
 Q X
GDISV ;   Get Default Value (Spacebar-Return)
 S GMTSDISV=0 N DIC,Y,X,DLAYGO,DINUM,DTOUT,DUOUT,GMTSOK,%,%A,%B,%B1,%B2,%B3,%BA,%C,%E,%G,%H,%I,%J,%N,%P,%S,%T,%W,%X,%Y,%BU,%J1,%A0,%W0,%D1,%D2,%DT,%K,%M
 Q:+($G(DUZ))=0  Q:'$L($$GET1^DIQ(200,(+($G(DUZ))_","),.01))  S DIC=142,DIC(0)="Z",X=" ",GMTSOK=1 D ^DIC
 S:$L($G(GMTSDICS)) GMTSOK=$$DICS^GMTSULT2($G(GMTSDICS),$G(X),+($G(Y))) S:+GMTSOK'>0 Y=-1
 S GMTSDISV=$S(+Y>0:+Y,1:"")
 Q
 ;                        
 ; Miscellaneous
INPT(X) ;   Input Transform
 N %,%A,%B,%B1,%B2,%B3,%BA,%C,%E,%G,%H,%I,%J,%N,%P,%S,%T,%W,%X,%Y,%BU,%J1,%A0,%W0,%D1,%D2,%DT,%K,%M
 N GMTSINPT,GMTSI,GMTST S (GMTST,X)=$G(X) I $L(X)=1,X'=" " Q 0
 I X=" "&($G(GMTSDIC0)'["F") D
 . D GDISV S:+($G(GMTSDISV))>0 X=$P($G(^GMT(142,+($G(GMTSDISV)),0)),U,1),(Y,GMTSD)=+GMTSDISV
 K ^TMP("GMTSULT",$J),^TMP("GMTSULT2",$J) S GMTSINPT="" D LIST^GMTSULT2(X) S X=$S($D(^TMP("GMTSULT",$J,0)):1,1:0)
 I +X=0,$L($G(GMTST))>2,$L($G(GMTST))<31,+($G(GMTSLGO))=142,$G(GMTSDIC0)["L" S X=1 Q X
 K ^TMP("GMTSULT",$J),^TMP("GMTSULT2",$J) Q X
