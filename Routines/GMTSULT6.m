GMTSULT6 ; SLC/KER - HS Type Lookup (Select)     ; 08/27/2002
 ;;2.7;Health Summary;**30,32,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10026  ^DIR
 ;   DBIA 10006  ^DIC  (file #142)
 ;   DBIA 10060  ^VA(200,
 ;   DBIA  2056  $$GET1^DIQ  (file #200)
 ;   DBIA 10016  ^DIM
 ;   DBIA  2055  RECALL^DILFD
 Q
 ;                          
MULTI ; Selection when Multiple Entries are found
 I $L($G(GMTSDICB)),GMTSDEF=1 D DEF Q
 S GMTSDICW=$$DICW($G(GMTSDICW)) K:'$L(GMTSDICW) GMTSDICW
 N GMTSIEN,GMTSE,GMTSO,GMTST,GMTSTOT,GMTSM S GMTSTOT=^TMP("GMTSULT",$J,0) Q:+GMTSTOT=0  I +GMTSTOT=1 D ONE Q
 W ! W:+GMTSTOT>1 !,GMTSTOT," Health Summary Types found"
 N GMTSI,GMTSS,GMTSEX,X,GMTSTR,GMTSTR2,GMTSTR3,GMTSLEN S GMTSLEN=75,GMTSS=0,GMTSEX=0
 ;   List 5 at a time
 F GMTSI=1:1:^TMP("GMTSULT",$J,0) Q:((GMTSS>0)&(GMTSS<GMTSI+1))  Q:GMTSEX  D  Q:GMTSEX
 . S GMTSE=$G(^TMP("GMTSULT",$J,GMTSI))
 . S GMTSM=GMTSI W:GMTSI#5=1 ! W !,$J(GMTSI,4),".  "
 . S GMTSIEN=+GMTSE,(GMTST,GMTSTR)=$P(GMTSE,U,7),GMTSO=$P(GMTSE,U,2)
 . S:'$L(GMTSTR)&($L(GMTSO)) GMTSTR=GMTSO
 . D WRM1
 . W:GMTSI#5=0 ! S:GMTSI#5=0 GMTSS=$$SEL(GMTSM) S:GMTSS["^" GMTSEX=1
 I GMTSI#5'=0,+GMTSS=0 W ! S GMTSS=$$SEL(GMTSM) S:GMTSS["^" GMTSEX=1
 I 'GMTSEX,+GMTSS>0 D  Q
 . N GMTSNAM K Y S Y=+($G(^TMP("GMTSULT",$J,+GMTSS)))
 . S GMTSNAM=$P($G(^GMT(142,+Y,0)),"^",1) I '$L(GMTSNAM) K Y S Y=-1 Q
 . D Y(+Y)
 K Y S Y=-1
 Q
WRM1 ;   Write one entry of muli selection
 N Y,GMTS S Y=+GMTSIEN,GMTS=$G(^GMT(142,+Y,0))
 I '$D(GMTSDICW) W:$L(GMTSTR)'>GMTSLEN GMTSTR D:$L(GMTSTR)>GMTSLEN LONG Q
 I $D(GMTSDICW),$G(GMTSDIC0)'["S" W $P(GMTS,"^",1),"  " X GMTSDICW Q
 I $D(GMTSDICW),$G(GMTSDIC0)["S" X GMTSDICW Q
 Q
SEL(X) ;   Select multiple
 N Y,GMTSM,DTOUT,DUOUT,DIRUT,DIROUT S GMTSM=+($G(X)) Q:GMTSM=0 -1
 S:+($O(^TMP("GMTSULT",$J,+($G(GMTSI)))))>0 DIR("A")="Press <RETURN> for more, '^' to exit, or Select 1-"_GMTSM_":  "
 S:+($O(^TMP("GMTSULT",$J,+($G(GMTSI)))))'>0 DIR("A")="Select 1-"_GMTSM_":  "
 S (DIR("?"),DIR("??"))="Answer must be from 1 to "_GMTSM_", or <Return> to continue  "
 S DIR(0)="NAO^1:"_GMTSM_":0" D ^DIR S:$D(DTOUT)!(X[U) X=U K DIR Q X
 Q
 ;                          
ONE ; One entry on the selection list
 I $L($G(GMTSDICB)),GMTSDEF=1 D DEF Q
 N GMTSEX,GMTSIEN,GMTSTR,GMTSTR2,GMTSY,GMTSX,GMTSLEN,DIR,X
 S GMTSLEN=75,Y=0 S:GMTSQ!($G(GMTSDIC0)["E") GMTSQ=1,Y=1
 S GMTSEX=0
 ;   No Echo or if Ask
 S GMTSIEN=+($G(^TMP("GMTSULT",$J,1)))
 I 'GMTSQ!($G(GMTSDIC0)["A") D
 . N X S GMTSTR=$P($G(^TMP("GMTSULT",$J,1)),U,7)
 . S:'$L(GMTSTR) GMTSTR=$P($G(^TMP("GMTSULT",$J,1)),U,2)
 . D WRO1 S Y=$$OK S:Y["^" GMTSEX=1
 I 'GMTSEX,+Y>0 D  Q
 . N GMTSNAM K Y S Y=+($G(^TMP("GMTSULT",$J,1)))
 . S GMTSNAM=$P($G(^GMT(142,+Y,0)),"^",1) I '$L(GMTSNAM) K Y S Y=-1 Q
 . D Y(+Y)
 K Y S Y=-1
 Q
WRO1 ;   Write one entry of single selection
 W !!,"  " N Y,GMTS S Y=+GMTSIEN,GMTS=$G(^GMT(142,+Y,0))
 I '$D(GMTSDICW) W:$L(GMTSTR)'>GMTSLEN GMTSTR D:$L(GMTSTR)>GMTSLEN LONG W ! Q
 I $D(GMTSDICW),$G(GMTSDIC0)'["S" W $P(GMTS,"^",1),"  " X GMTSDICW W ! Q
 I $D(GMTSDICW),$G(GMTSDIC0)["S" X GMTSDICW W ! Q
 Q
OK(X) ;   Select one if DIC(0)["A" Ask OK
 N DIR,DTOUT,DUOUT,DIROUT S DIR(0)="YAO",DIR("B")="YES"
 S DIR("A")="  OK?  " D ^DIR S:X'["^" X=+Y S:$D(DTOUT)!($D(DUOUT)) X="^" S:X["^" X="^" Q X
 ;                          
DEF ; Select Default Entry
 N GMTSNAM K Y S Y=+($G(^TMP("GMTSULT",$J,1)))
 S GMTSNAM=$P($G(^GMT(142,+Y,0)),"^",1) I '$L(GMTSNAM) K Y S Y=-1 Q
 D Y(+Y)
 Q
 ;                       
 ; Display
LONG ;   Handle a long string
 N GMTSP,GMTSOK,GMTSCHR,GMTSPSN,GMTSTO,GMTSREM,GMTSLN,GMTSOLD S GMTSLN=0,GMTSOLD=GMTSTR,GMTSP=5
 F  Q:$L(GMTSTR)<(GMTSLEN+1)  D PARSE Q:$L(GMTSTR)<(GMTSLEN+1)
 S GMTSLN=GMTSLN+1 W:GMTSLN>1 ! W ?GMTSP,GMTSTR
 Q
PARSE ;   Parse a long string to screen length
 S GMTSOK=0,GMTSCHR="" F GMTSPSN=GMTSLEN:-1:0 Q:+GMTSOK=1  D  Q:+GMTSOK=1
 . I $E(GMTSTR,GMTSPSN)=" " S GMTSCHR=" ",GMTSOK=1 Q
 . I $E(GMTSTR,GMTSPSN)="," S GMTSCHR=",",GMTSOK=1 Q
 . I $E(GMTSTR,GMTSPSN)="/" S GMTSCHR="/",GMTSOK=1 Q
 . I $E(GMTSTR,GMTSPSN)="-" S GMTSCHR="-",GMTSOK=1 Q
 I GMTSCHR=" " S GMTSTO=$E(GMTSTR,1,GMTSPSN-1),GMTSREM=$E(GMTSTR,GMTSPSN+1,$L(GMTSTR))
 I GMTSCHR="," S GMTSTO=$E(GMTSTR,1,GMTSPSN),GMTSREM=$E(GMTSTR,(GMTSPSN+1),$L(GMTSTR)) S:$E(GMTSREM,1)=" " GMTSREM=$E(GMTSREM,2,$L(GMTSREM))
 I GMTSCHR="/" S GMTSTO=$E(GMTSTR,1,GMTSPSN),GMTSREM=$E(GMTSTR,(GMTSPSN+1),$L(GMTSTR)) S:$E(GMTSREM,1)=" " GMTSREM=$E(GMTSREM,2,$L(GMTSREM))
 I GMTSCHR="-" S GMTSTO=$E(GMTSTR,1,GMTSPSN),GMTSREM=$E(GMTSTR,(GMTSPSN+1),$L(GMTSTR)) S:$E(GMTSREM,1)=" " GMTSREM=$E(GMTSREM,2,$L(GMTSREM))
 S GMTSTR=GMTSREM,GMTSLN=GMTSLN+1 W:GMTSLN>1 ! W ?GMTSP,GMTSTO
 Q
DICW(X) ;   Check for valid DIC("W")
 S X=$G(X) Q:'$L(X) ""
 D ^DIM I '$D(X) Q ""
 Q X
 ;                       
 ; Post Selection
Y(X) ;   Set Y
 K Y S X=+($G(X))
 S:X'>0!('$D(^GMT(142,+X,0))) Y=-1 Q:X'>0!('$D(^GMT(142,+X,0)))
 S Y=+X_"^"_$P($G(^GMT(142,+X,0)),"^",1)
 S:$G(GMTSDIC0)["Z"!($G(DIC(0))["Z") Y(0)=$G(^GMT(142,+X,0)),Y(0,0)=$P($G(^GMT(142,+X,0)),"^",1),Y(0,1)=$$MX(Y(0,0))
 I +($G(GMTSWY))=0 W:$G(GMTSDIC0)["E"!($G(DIC(0))["E") "  ",$P($G(^GMT(142,+X,0)),"^",1) S GMTSWY=1
 D:$G(GMTSDIC0)'["F"&($G(DIC(0))'["F") SDISV
 Q
SDISV ;   Save Default Value (Spacebar-Return)
 Q:$G(GMTSDIC0)["F"  Q:+($G(DUZ))=0  Q:'$L($$GET1^DIQ(200,(+($G(DUZ))_","),.01))  Q:+($G(Y))=0  Q:'$D(^GMT(142,+($G(Y)),0))
 D RECALL^DILFD(142,+($G(Y))_",",+($G(DUZ))) Q
 Q
MX(X) ; Mix Case
 Q $$EN^GMTSUMX(X)
