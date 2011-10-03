GMTSOBT ; SLC/KER - HS Object - Time and Type        ; 01/06/2003
 ;;2.7;Health Summary;**58**;Oct 20, 1995
 ;                
 ; External References
 ;   DBIA  10104  $$UP^XLFSTR
 ;   DBIA  10088  ENDR^%ZISS
 ;   DBIA  10026  ^DIR        
 ;            
 Q
TP ; Time Period
 Q:+($G(GMTSQ))>0  N X,Y,DIR,GMTSX,GMTSDEF K GMTSOBJ("TIME")
 S GMTSDEF=$$TIM($P($G(^GMT(142.5,+($G(GMTSDA)),0)),U,4))
 S DIR("A")=" Enter REPORT PERIOD:  ",DIR("B")="3M" S:$L(GMTSDEF) DIR("B")=GMTSDEF
 S DIR(0)="FAO^2;5^S X=$$TIM^GMTSOBT(X) S:$L(X) GMTSX=X K:'$L(X) X"
 S (DIR("?"),DIR("??"))="^D TH^GMTSOBT"
 D ^DIR S:$D(DIROUT)!($D(DTOUT)) GMTSQ=1
 Q:+($G(GMTSQ))>0  Q:'$L($G(GMTSX))  W "  ",GMTSX S GMTSOBJ("TIME")=$G(GMTSX)
 Q
TH ;   Time Help
 D ATTR
 W !,"     Enter a time limit for the Health Summary report/object.  It"
 W !,"     must be in the format of a numeric time length and an alpha"
 W !,"     time unit, and can not exceed 5 characters.  If no time unit"
 W !,"     is provided, then the time unit will be set to Days (D), i.e.,"
 W !,"     "
 W !,$G(BOLD),"                 11, 2D, 4D, 6W, 18W, 3M, 6M, 1Y",$G(NORM)
 D KATTR
 Q
TIM(X) ;   Input Transform for Time
 Q:$L(X)=1&(X="@") X  S X=$$UP^XLFSTR($G(X)) Q:$L($G(X))>5 ""  Q:$L((+($G(X))))>4 ""  S X=$G(X)
 N GMTSLEN,GMTSUNIT S GMTSLEN=+X,GMTSUNIT=$E(X,$L(X)) S:+GMTSUNIT>0 GMTSUNIT="D" S:$L(GMTSLEN)=$L(X) GMTSUNIT="D"
 Q:GMTSUNIT'="D"&(GMTSUNIT'="W")&(GMTSUNIT'="M")&(GMTSUNIT'="Y") ""
 I GMTSUNIT="D",GMTSLEN>5 D
 . N GMTSO S GMTSO=GMTSLEN I +GMTSLEN>89!(GMTSLEN#7=0)!(GMTSLEN#7=6) D
 . . S GMTSLEN=GMTSLEN\7,GMTSUNIT="W"
 . . S:GMTSO#7>3 GMTSLEN=GMTSLEN+1
 . I GMTSUNIT="D",GMTSLEN#32>28 D
 . . S GMTSLEN=GMTSLEN\32 S:GMTSO#32>28 GMTSLEN=GMTSLEN+1 S GMTSUNIT="M"
 I GMTSUNIT="W",GMTSLEN>3 D
 . N GMTSO S GMTSO=GMTSLEN I +GMTSLEN>23!(GMTSLEN#4=3)!(GMTSLEN#4=0) D
 . . S GMTSLEN=GMTSLEN\4.333333333,GMTSUNIT="M"
 . . S:GMTSO#4.333333333>3 GMTSLEN=GMTSLEN+1
 I GMTSUNIT="M",GMTSLEN>11 D
 . N GMTSO S GMTSO=GMTSLEN I GMTSLEN#12=11!(GMTSLEN#12=0) D
 . . S GMTSLEN=GMTSLEN\12,GMTSUNIT="Y" S:GMTSO#12=11 GMTSLEN=GMTSLEN+1
 S X=GMTSLEN_GMTSUNIT
 Q X
 ;                    
TYPE(I) ; Select Type
 ;   Uses Fileman's DIC variables for Lookup
 N GMTSHDR,GMTSNOQ,GMTSNOI,GMTSX,GMTSREDO
TY2 ;   Prompt for Type
 S GMTSX=$$TYPE^GMTSULT I X["@" S X="@",Y=-1 Q -1
 Q:+GMTSX'>0 -1
 S GMTSHDR(1)="You have selected the following Health Summary Type to use as an Object:"
 S GMTSHDR(2)=" ",GMTSNOQ="",GMTSNOI="",GMTSREDO=0
 D DT^GMTSOBD(+GMTSX) I $D(^TMP("GMTSOBT",$J)) D
 . D NOQUE^GMTSOBD W ! N DIR,DTOUT,DUOUT S DIR(0)="YAO",DIR("A")="Is this correct?  ",DIR("B")="Y"
 . D ^DIR S:$$UP^XLFSTR($E(X,1))="N" GMTSREDO=1 I +Y'>0 S GMTSX=-1
 W:+GMTSREDO>0 ! G:+GMTSREDO>0 TY2
 D XY(GMTSX) S I=GMTSX K ^TMP("GMTSOBT",$J)
 Q I
 ;                   
RP(TYPE,OBJ) ; Report Period
 ;   Input    TYPE   Required, Health Summary Type IEN
 ;            OBJ    Optional, Health Summary Object IEN
 ;
 ;   Output   X      Report Period, "" or "@"
 ;            GMTSQ  Up Arrow/Time Out
 ;
 Q:+($G(GMTSQ))>0 ""  N X,Y,DIR,GMTSX,GMTSDEF,GMTSS,GMTSTY,GMTSOB K GMTSOBJ("TIME") S GMTSOB=+($G(OBJ)),GMTSTY=+($G(TYPE)) Q:+GMTSTY=0 "@"
 S GMTSS=$$RT(GMTSTY) Q:+($G(GMTSQ))>0 -1  Q:GMTSS'>0 "@"
 S GMTSDEF=$$TIM($P($G(^GMT(142.5,+($G(GMTSDA)),0)),U,4))
 S DIR("A")=" Enter new TIME LIMIT:  " S:$L(GMTSDEF) DIR("B")=GMTSDEF
 S DIR(0)="FAO^1;5^S X=$$TIM^GMTSOBT(X) S:$L(X) GMTSX=X K:'$L(X) X"
 S (DIR("?"),DIR("??"))="^D TH^GMTSOBT" W ! D ^DIR I X="@",Y="" Q X
 S:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) GMTSQ=1 Q:+($G(GMTSQ))>0 -1
 Q:'$L($G(GMTSX)) ""  W "  ",GMTSX S GMTSOBJ("TIME")=$G(GMTSX)
 S X=GMTSX
 Q X
RT(X) ;   Report Period or Time Limits
 ;     Input  X   IEN or Health Summary Type
 Q:+($G(GMTSQ))>0 -1  N Y,DIR,GMTSX S GMTSX=+($G(X)) D RTA(+GMTSX)
 I '$D(DIR("A")) S DIR("A",1)=" Overwrite Health Summary Type Time Limits ",DIR("A")=" with Health Summary Object Report Period?  "
 S DIR(0)="YAO",DIR("B")="N",(DIR("?"),DIR("??"))="^D RTH^GMTSOBT(GMTSX)"
 W ! D ^DIR S:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) GMTSQ=1
 Q:+($G(GMTSQ))>0 -1 S X=+($G(Y))
 Q X
RTH(X) ;   Report Period or Time Limits Help
 ;     Input  X   IEN or Health Summary Type
 D LS(+($G(X))) W !
 D ATTR
 W !,"     Entering a new TIME LIMIT for the Health Summary Object will "
 W !,"     overwrite the TIME LIMITS set the for individual components. "
 W !,"     It must be alpha numeric and can not exceed 5 characters."
 W !,"     Examples:  ",$G(BOLD),"3D, 6W, 3M, 1Y",$G(NORM)
 D KATTR
 Q
RTA(X) ;   Report Period or Time Limit DIR(A)
 D ATTR K DIR("A") N GMTSC,GMTST,GMTSP,GMTSS,GMTSR,GMTSI,GMTSN S GMTSI=+($G(X)) Q:+X'>0
 S GMTSN=$P($G(^GMT(142,+GMTSI,0)),"^",1)
 Q:'$L(GMTSN)
 I $L(GMTSN) D
 . S GMTST="Do you want to overwrite the TIME LIMITS in the Health Summary Type '"
 . S GMTST=GMTST_$$UP^XLFSTR(GMTSN)_"'?"
 I '$L(GMTSN) D
 . S GMTST="Do you want to overwrite the TIME LIMITS in the Health Summary Type?"
 F  Q:'$L($$TRIM(GMTST))  D
 . I $L(GMTST)'>60 S GMTSC=+($G(GMTSC))+1,DIR("A",GMTSC)=" "_$$TRIM(GMTST)_"  ",GMTST="" Q
 . S GMTSS=$E($$TRIM(GMTST),1,60),GMTSS=$P(GMTSS," ",1,($L(GMTSS," ")-1)),GMTSR=$P($$TRIM(GMTST),GMTSS,2,299),GMTST=GMTSR,GMTSC=+($G(GMTSC))+1,DIR("A",GMTSC)=" "_$$TRIM(GMTSS)_"  "
 S:+($G(GMTSC))>0 DIR("A")=DIR("A",GMTSC) K:+($G(GMTSC))>0 DIR("A",GMTSC)
 S (GMTSC,GMTSI)=0 F GMTSC=1:1 D  Q:GMTSI>0
 . S:'$D(DIR("A",GMTSC)) GMTSS="DIR(""A"")",GMTSI=1
 . S:$D(DIR("A",GMTSC)) GMTSS="DIR(""A"","_GMTSC_")"
 . S GMTST=@GMTSS I GMTST["Time Limits" S GMTST=$P(GMTST,"Time Limits",1)_$G(BOLD)_"Time Limits"_$G(NORM)_$P(GMTST,"Time Limits",2),@GMTSS=GMTST Q
 . S GMTST=@GMTSS I GMTST["Report Period" S GMTST=$P(GMTST,"Report Period",1)_$G(BOLD)_"Report Period"_$G(NORM)_$P(GMTST,"Report Period",2),@GMTSS=GMTST Q
 . S GMTST=@GMTSS I GMTST["a Report" S GMTST=$P(GMTST,"a Report",1)_"a "_$G(BOLD)_"Report"_$G(NORM)_$P(GMTST,"a Report",2),@GMTSS=GMTST
 . S GMTST=@GMTSS I GMTST["Period which" S GMTST=$P(GMTST,"Period which",1)_$G(BOLD)_"Period"_$G(NORM)_" which"_$P(GMTST,"Period which",2,299),@GMTSS=GMTST
 D KATTR
 Q
LS(X) ; List Structure
 D ATTR
 N GMTST,GMTSS,GMTSC,GMTSTA,GMTSI,GMTSAB,GMTSOL,GMTSTL,GMTSNM,GMTSHD,GMTSCT
 S GMTST=+($G(X)) Q:'$D(^GMT(142,+GMTST,0))!('$D(^GMT(142,+GMTST,1))) 0
 S (GMTSCT,GMTSTA,GMTSI)=0
 F  S GMTSI=$O(^GMT(142,+GMTST,1,GMTSI)) Q:+GMTSI=0  D  Q:+($G(GMTSCT))>1
 . S GMTSS=$G(^GMT(142,+GMTST,1,GMTSI,0)),GMTSC=$G(^GMT(142.1,+($P(GMTSS,"^",2)),0)) Q:+($P(GMTSS,"^",4))'>0!($P(GMTSC,"^",3)'="Y")
 . S GMTSOL=$P(GMTSS,"^",3) S:'$L(GMTSOL) GMTSOL="--" S GMTSTL=$P(GMTSS,"^",4),GMTSNM=$$EN2^GMTSUMX($P(GMTSC,"^",1))
 . S GMTSHD=$P(GMTSC,"^",9) S:$L(GMTSHD) GMTSNM=GMTSNM S GMTSAB=$P(GMTSC,"^",4),GMTSCT=+($G(GMTSCT))+1
 . I GMTSCT=1 D
 . . W !,"     Example of Health Summary Type component ",$G(BOLD),"TIME LIMITS",$G(NORM),!
 . . W !,?9,"Abbr",?15,"Component Name",?45,"Max Occurrences",?62,$G(BOLD),"Time Limits",$G(NORM)
 . . W !,?9,"----------------------------------------------------------------"
 . W !,?9,GMTSAB,?15,GMTSNM,?49,$J(GMTSOL,4),?63,$G(BOLD),$J(GMTSTL,5),$G(NORM)
 D KATTR
 Q
TA(X) ; Time Limits Applicable
 N GMTST,GMTSS,GMTSC,GMTSTA,GMTSI
 S GMTST=+($G(X)) Q:'$D(^GMT(142,+GMTST,0))!('$D(^GMT(142,+GMTST,1))) 0
 S (GMTSTA,GMTSI)=0
 F  S GMTSI=$O(^GMT(142,+GMTST,1,GMTSI)) Q:+GMTSI=0  D  Q:+GMTSTA>0
 . S GMTSS=$G(^GMT(142,+GMTST,1,GMTSI,0))
 . S GMTSC=$G(^GMT(142.1,+($P(GMTSS,"^",2)),0))
 . S:+($P(GMTSS,"^",4))>0&($P(GMTSC,"^",3)="Y") GMTSTA=1
 S X=GMTSTA
 Q X
 ;                     
 ; Miscellaneous
TRIM(X) ;   Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
XY(I) ;   Set X and Y Variables
 K Y,X S X=+($G(I)) I X'>0!('$D(^GMT(142,+X,0))) S Y=-1 Q
 S Y=+X_"^"_$P($G(^GMT(142,+X,0)),"^",1),Y(0)=$G(^GMT(142,+X,0)),Y(0,0)=$P($G(^GMT(142,+X,0)),"^",1),Y(0,1)=$$EN^GMTSUMX(Y(0,0))
 Q
ATTR ;   Set Screen Attributes
 N X,IOINHI,IOINORM S X="IOINHI;IOINORM" D ENDR^%ZISS S BOLD=$G(IOINHI),NORM=$G(IOINORM) Q
KATTR ;   Kill Screen Attributes
 K NORM,BOLD Q
