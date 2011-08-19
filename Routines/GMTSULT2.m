GMTSULT2 ; SLC/KER - HS Type Lookup (Search/List)   ; 08/27/2002
 ;;2.7;Health Summary;**30,32,35,29,56**;Oct 20, 1995
 ;
 ; External Reference
 ;   DBIA 10016  ^DIM
 ;                   
 Q
LIST(X) ; Get global array of Health Summary Types
 ;                      
 ;  LIST^GMTSULT2(<search string>)
 ;                      
 ;  ^TMP("GMTSULT",$J,#)
 ;                    
 ;     Piece 1 =  Internal Entry Number (IEN) in file 142
 ;     Piece 2 =  Health Summary Type Name
 ;     Piece 3 =  Health Summary Type Title
 ;     Piece 4 =  Health Summary Type Owner
 ;     Piece 5 =  Location Using Health Summary Type
 ;     Piece 6 =  Number of Components in Summary Type
 ;     Piece 7 =  Recommended Display Text (for 
 ;                selection or list box)
 ;                      
 ;  List Builder can use variable DIC("S") and DIC(0)
 ;                      
 ;     DIC("S") Screen out entries for selection/list
 ;                      
 ;     Processes DIC(0) N, OE (combination),X or B
 ;                      
 ;     Does not process DIC(0) components C or M.  Cross
 ;     reference suppression (C) is automatic in a multi-
 ;     term lookup, and the use of multiple indexes is
 ;     implied in the lookup and DD file structure.
 ;                      
 D CLR^GMTSULT N GMTSEO,GMTSEQ,GMTSIF,GMTSBI,GMTSIEN,GMTSWRDS,GMTSDS,GMTSD0
 S GMTSEO=+($$EMO),GMTSEQ=+($$EMQ),GMTSIF=+($$IF($G(X))),GMTSBI=+($$BI)
 S:$L($G(DIC("S")))&('$L($G(GMTSDICS))) GMTSDICS=$G(DIC("S")),GMTSDS=1
 S:$L($G(DIC(0)))&('$L($G(GMTSDIC0))) GMTSDIC0=$G(DIC(0)),GMTSD0=1
 I GMTSIF S GMTSIEN=$$IENF(X) I +GMTSIEN>0 D IENS(GMTSIEN) G:$D(^TMP("GMTSULT",$J,1)) LQ
 I GMTSBI D B^GMTSULT7 G LQ
 D PAR,FND,REO^GMTSULT3
 Q
LQ ; Quit List
 K:+($G(GMTSDS))>0 GMTSDICS K:+($G(GMTSD0))>0 GMTSDIC0
 Q
 ;                      
FND ; Find Health Summary Types (word search)
 N GMTSB,GMTSC,GMTSCTL,GMTSFND,GMTSI,GMTSI1,GMTSI2,GMTSI3,GMTSDS,GMTSD0,GMTSLEX,GMTSLEXM,GMTSASM,GMTSCMP,GMTSLOC,GMTSNAM,GMTSOK,GMTSRC,GMTSOW,GMTSTMP,GMTSTTL,GMTSWDS,GMTSRD,GMTSWRD,Y
 ;   Echo             E or broker
 S GMTSTMP=+($G(GMTSE)),GMTSIF=0 S:'$D(GMTSE) GMTSTMP=$$ECHO^GMTSULT N GMTSE S GMTSE=GMTSTMP,U="^"
 ;   Exact Match      X
 S GMTSLEX=$$EM(X) D:$G(GMTSDIC0)["X"&(GMTSLEX'>0) CLR^GMTSULT G:$G(GMTSDIC0)["X"&(GMTSLEX'>0) FNDQ
 S:+GMTSLEX>0 ^TMP("GMTSULT2",$J,"EM")=+GMTSLEX,^TMP("GMTSULT2",$J,"IEN",+GMTSLEX)=""
 ;   One Exact Match  OE
 S GMTSLEXM=0 S:$G(GMTSDIC0)["O"&($G(GMTSDIC0)["E") GMTSLEXM=1
 ;   Word Search
 S GMTSWDS=$O(GMTSWRDS(" "),-1) S GMTSWRD=$G(GMTSWRDS(1))
 G:'$L(GMTSWRD) FNDQ S GMTSCTL=GMTSWRD,GMTSWRD=$E(GMTSWRD,1,($L(GMTSWRD)-1))_$C($A($E(GMTSWRD,$L(GMTSWRD)))-1)_"~"
 S:+GMTSCTL=GMTSCTL GMTSWRD=GMTSCTL-1
 F  S GMTSWRD=$O(^GMT(142,"AW",GMTSWRD)) Q:GMTSWRD=""!($E(GMTSWRD,1,$L(GMTSCTL))'=GMTSCTL)  D
 . S (GMTSC,GMTSI1)=0
 . F  S GMTSI1=$O(^GMT(142,"AW",GMTSWRD,GMTSI1)) Q:+GMTSI1=0  D
 . . N GMTSIEN,GMTSKWRD S GMTSIEN=GMTSI1,GMTSKWRD=GMTSWRD
 . . D SM^GMTSULT3
 ;   Check for exact match in results
 S GMTSI=+($G(^TMP("GMTSULT2",$J,"EMI")))
 S GMTSB=$G(^TMP("GMTSULT2",$J,"EMB")) I GMTSI>0,$L(GMTSB)>0 D
 . S ^TMP("GMTSULT2",$J,"E")=$G(^TMP("GMTSULT2",$J,GMTSI))
 . K ^TMP("GMTSULT2",$J,GMTSI),^TMP("GMTSULT2",$J,"B",GMTSB),^TMP("GMTSULT2",$J,"EMB"),^TMP("GMTSULT2",$J,"EMI"),^TMP("GMTSULT2",$J,"EM")
FNDQ ; Find Quit
 K:+($G(GMTSDS))>0 GMTSDICS K:+($G(GMTSD0))>0 GMTSDIC0
 Q
 ;                      
PAR ; Parse User Input
 K GMTSWRDS N GMTSC,GMTSCT,GMTSPSN,GMTSTR,GMTSWRD
 S U="^",GMTSTR=$G(X) Q:'$L(GMTSTR)  S GMTSC=1,GMTSCT=0 F GMTSPSN=1:1:$L(GMTSTR)+1 D
 . S GMTSWRD=$E(GMTSTR,GMTSPSN) I "(,.?! '-/&:;)"[GMTSWRD D
 . . S GMTSWRD=$TR($E($E(GMTSTR,GMTSC,GMTSPSN-1),1,30),"""",""),GMTSC=GMTSPSN+1
 . . I $L(GMTSWRD)>0 S GMTSCT=GMTSCT+1,GMTSWRDS(GMTSCT)=$$UP(GMTSWRD)
 Q
IENF(X) ; Internal Entry Number Find
 N GMTS0,GMTSI S GMTSI=$G(X),X=$G(X),GMTS0=$G(DIC(0)) S:$E(X,1)="`" GMTSI=$E(GMTSI,2,$L(GMTSI)) S GMTSI=+GMTSI
 I GMTS0["N",+GMTSI>0,$D(^GMT(142,+GMTSI,0)) S X=+GMTSI Q X
 I $E(X,1)="`",+GMTSI>0,$D(^GMT(142,+GMTSI,0)) S X=+GMTSI Q X
 Q -1
IENS(X) ; Internal Entry Number Save
 N GMTSI1,GMTSI2,GMTSI3,GMTSIEN S (GMTSIEN,GMTSI1)=+X Q:+GMTSI1=0  Q:'$D(^GMT(142,+GMTSI1,0))
 D SM^GMTSULT3,REO^GMTSULT3
 Q
CM(X) ; Get Number of Components
 S X=+($G(X)) Q:X=0 "No components" Q:'$D(^GMT(142,+X,1)) "No components"
 N GMTSI,GMTSC S (GMTSC,GMTSI)=0 F  S GMTSI=$O(^GMT(142,+X,1,GMTSI)) Q:+GMTSI=0  S GMTSC=GMTSC+1
 S X=$S(+GMTSC>1:(+GMTSC_" components"),+GMTSC=1:(+GMTSC_" component"),1:"No components")
 Q X
EM(X) ; Exact Match when DIC(0) contains X
 S X=$G(X) Q:'$L(X) -1 N GMTSC,GMTSI,GMTSM,GMTSN,GMTSO,GMTSU S U="^"
 S GMTSU=$$UP(X),(GMTSC,GMTSO)=$$UP($E(X,1,30)),GMTSM=0,GMTSO=$E(GMTSO,1,($L(GMTSO)-1))_$C($A($E(GMTSO,$L(GMTSO)))-1)_"~",GMTSM=0
 F  S GMTSO=$O(^GMT(142,"AB",GMTSO)) Q:GMTSO=""!(GMTSO'[GMTSC)  D  Q:+GMTSM>0
 . S GMTSI=0 F  S GMTSI=$O(^GMT(142,"AB",GMTSO,GMTSI)) Q:+GMTSI=0  D  Q:+GMTSM>0
 . . S GMTSN=$P($G(^GMT(142,+GMTSI,0)),U,1) S:$$UP(GMTSN)=GMTSU GMTSM=GMTSI_U_GMTSN
 S:+GMTSM=0 GMTSM=-1 S X=GMTSM D Y^GMTSULT6(+GMTSM)
 Q X
 ;                      
DICS(S,X,DA) ; Check DIC("S") Screen
 N Y,GMTST,GMTSOX,GMTSDICS,GMTSIEN S (GMTSIEN,Y,DA)=+($G(DA)),GMTSDICS=$G(S),GMTSOX=$G(X) S X=GMTSDICS Q:'$L(GMTSDICS) 1
 D ^DIM Q:'$L($G(X)) 1 S GMTST=$G(^GMT(142,+GMTSIEN,0)) Q:'$D(^GMT(142,+GMTSIEN,0)) 0 S X=GMTSOX,(Y,DA)=GMTSIEN Q:GMTSIEN'>0 0
 X GMTSDICS S X=$T Q X
 ;                      
 ; Processing flags
EMQ(X) ;   Exact match flag
 N GMTS0 S X=0,GMTS0=$G(DIC(0)) Q:'$L(GMTS0) X
 S:$G(GMTS0)["X" X=1 Q X
EMO(X) ;   Exact match flag, only one
 N GMTS0 S X=0 S GMTS0=$G(DIC(0)) Q:'$L(GMTS0) X
 S:$G(GMTS0)["O"&($G(GMTS0)["E") X=1 Q X
BI(X) ;   Use the B Index flag
 N GMTS0 S X=0 S GMTS0=$G(DIC(0)) Q:'$L(GMTS0) X
 S:$G(GMTS0)["B" X=1 Q X
IF(X) ;   Internal Entry Number Flag
 N GMTS0,GMTSI S GMTSI=0,GMTS0=$G(DIC(0)) Q:'$L($G(X)) 0
 I $E(X,1)="`",$L($G(^GMT(142,+($E(X,2,$L(X))),0))) S GMTSI=1
 I +X>0,$L($G(^GMT(142,+X,0))),GMTS0["N" S GMTSI=1
 S X=GMTSI Q X
 ;                      
 ; TMP Global
TMP ;   Show first ^TMP Global
 N GMTSND,GMTSNC,GMTSNQ,GMTSC,GMTSTMP
 S GMTSC=0,GMTSTMP="",GMTSNQ="^TMP(""GMTSULT2"","_$J_")",GMTSNC="^TMP(""GMTSULT2"","_$J_","
 F  S GMTSNQ=$Q(@GMTSNQ) Q:GMTSNQ=""!(GMTSNQ'[GMTSNC)  D
 . S GMTSC=GMTSC+1 W:GMTSC=1 ! S GMTSND=@GMTSNQ W !,GMTSNQ,"=",GMTSND
 W:GMTSC>0 !
TMP2 ;   Show second ^TMP Global
 S GMTSC=0,GMTSNQ="^TMP(""GMTSULT"","_$J_")",GMTSNC="^TMP(""GMTSULT"","_$J_","
 F  S GMTSNQ=$Q(@GMTSNQ) Q:GMTSNQ=""!(GMTSNQ'[GMTSNC)  D
 . S GMTSC=GMTSC+1 W:'$D(GMTSTMP)&(GMTSC=1) ! S GMTSND=@GMTSNQ W !,GMTSNQ,"=",GMTSND
 W:GMTSC>0 !
 Q
 ; Miscellaneous
UP(X) ;   Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
OW(X) ;   Mix Case (owner name)
 Q:$G(X)'["," $$EN^GMTSUMX($G(X))
 Q $$EN^GMTSUMX(($P($G(X),",",1)_", "_$P($G(X),",",2)))
MX(X) ;   Mix Case
 Q $$EN^GMTSUMX(X)
