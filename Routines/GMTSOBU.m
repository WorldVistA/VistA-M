GMTSOBU ; SLC/KER - HS Object - Utility           ; 01/06/2003
 ;;2.7;Health Summary;**58,89**;Oct 20, 1995;Build 61
 ;                      
 ; External References
 ;   DBIA 10096  ^%ZOSF("DEL"
 ;   DBIA 10112  $$SITE^VASITE
 ;   DBIA 10104  $$UP^XLFSTR
 ;   DBIA 10026  ^DIR        
 ;
 ; Errors
ER1 ;   Health Summary Object Exist
 N GMTSTXT,GMTSLN S GMTSTXT="Can not install Health Summary Object '"_GMTSOBJ_"'.  A Health Summary Object with the same name already exist." D WER S GMTSQIT=1 Q
ER2 ;   Health Summary Type Exist
 N GMTSTXT,GMTSLN S GMTSTXT="Can not install Health Summary Type '"_GMTSTYP_"' for use by the Health Summary Object '"_GMTSOBJ_"'.  A Health Summary Type with the same name already exist." D WER S GMTSQIT=1 Q
ER3 ;   Health Summary Title Exist
 N GMTSTXT,GMTSLN S GMTSTXT="Can not install Health Summary Type '"_GMTSTYP_"' for use by the Health Summary Object '"_GMTSOBJ_"'.  A Health Summary Type with the same TITLE ("_GMTSTTL_") already exist." D WER S GMTSQIT=1 Q
WER ;   Write Error
 W !," Error:"
WER2 ;   Write Error Text
 S GMTSLN=$$TRIM($E(GMTSTXT,1,65)),GMTSLN=$$TRIM($P(GMTSLN," ",1,($L(GMTSLN," ")-1))) S:$L(GMTSTXT)<65 GMTSLN=$$TRIM(GMTSTXT) W:$L(GMTSLN) !,"    ",GMTSLN
 S GMTSTXT=$$TRIM($P(GMTSTXT,GMTSLN,2,299)),GMTSLN=$$TRIM($E(GMTSTXT,1,65)),GMTSLN=$$TRIM($P(GMTSLN," ",1,($L(GMTSLN," ")-1))) S:$L(GMTSTXT)<65 GMTSLN=$$TRIM(GMTSTXT) W:$L(GMTSLN) !,"    ",GMTSLN
 S GMTSTXT=$$TRIM($P(GMTSTXT,GMTSLN,2,299)),GMTSLN=$$TRIM($E(GMTSTXT,1,65)),GMTSLN=$$TRIM($P(GMTSLN," ",1,($L(GMTSLN," ")-1))) S:$L(GMTSTXT)<65 GMTSLN=$$TRIM(GMTSTXT) W:$L(GMTSLN) !,"    ",GMTSLN
 Q
 ;                     
EHST(X) ; Existing Health Summary Type
 N GMTSRTN,GMTSEDAT,GMTSOBJ,GMTSTYP,GMTSTXT,GMTSLN,GMTS
 N Y,DIR,DIROUT,DTOUT,DUOUT
 S GMTSRTN="GMTSOBX",GMTSOBJ=$P($$TX(GMTSRTN,"OBJ",1),";",2),GMTSTYP=$P($$TX(GMTSRTN,"TYPE",1),";",2)
 Q:'$L(GMTSOBJ)!('$L(GMTSTYP)) 0
 W ! S GMTSTXT="Can not install Health Summary Type '"_GMTSTYP_"' to be used"
 S GMTSTXT=GMTSTXT_" by the object.  A Health Summary Type with the same name already exist." D WER2
 S GMTSEDAT=$$NWX(GMTSTYP) Q:+($G(GMTSEDAT))'>0 0
 S GMTSTXT="Do you want to use the pre-existing Health Summary Type '"_GMTSTYP_"' for this Object?  (Y/N)"
 S GMTSLN=$$TRIM($E(GMTSTXT,1,65))
 S GMTSLN=$$TRIM($P(GMTSLN," ",1,($L(GMTSLN," ")-1)))
 S:$L(GMTSTXT)<65 GMTSLN=$$TRIM(GMTSTXT) S:$L(GMTSLN) DIR("A",1)="    "_GMTSLN_"  "
 S GMTSTXT=$$TRIM($P(GMTSTXT,GMTSLN,2,299))
 S GMTSLN=$$TRIM($E(GMTSTXT,1,65))
 S GMTSLN=$$TRIM($P(GMTSLN," ",1,($L(GMTSLN," ")-1)))
 S:$L(GMTSTXT)<65 GMTSLN=$$TRIM(GMTSTXT) S:$L(GMTSLN) DIR("A")="    "_GMTSLN_"  "
 S DIR("B")="N",DIR(0)="YAO",(DIR("?"),DIR("??"))="^D YNH^GMTSOBU" W ! D ^DIR
 S GMTS=+($G(Y)) S X=0,GMTSQIT=1
 ;   Don't use the pre-existing HS
 I +GMTS'>0 S GMTSQIT=1,GMTSEDAT=0 D  Q X
 . ;   Rename HS
 . D REN I $L($G(GMTSETYP)),$L($G(GMTSETTL)) S GMTSTYP=GMTSETYP,GMTSTTL=GMTSETTL,(GMTSEDAT,GMTSDAT)=$$TIEN
 . S X=+GMTSEDAT S:+X>0 GMTSQIT=0
 ;   Use the pre-existing HS
 ;AGP CHANGE TO TEST POSSIBLE FIX
 ;I +GMTS>0,$L(GMTSTYP) BREAK S GMTSTE=1,(X,GMTSEDAT)=+($G(GMTSDAT)),GMTSQIT=0
 I +GMTS>0,$L(GMTSTYP) S GMTSTE=1,(X,GMTSEDAT)=+($G(GMTSEDAT)),GMTSQIT=0
 Q X
REN ; Rename Health Summary Type
 N DIR,DIROUT,DUOUT,DTOUT,X,Y,GMTSNN,GMTSNT,GMTSNA S (GMTSETYP,GMTSETTL)=""
 S DIR("A")="    Do you want to rename the imported Health Summary Type? (Y/N) "
 S DIR("B")="Y",DIR(0)="YAO"
 S (DIR("?"),DIR("??"))="^D YNH^GMTSOBU"
 W ! D ^DIR Q:+Y=0
 S GMTSETYP=$$EDN($G(GMTSTYP)) Q:'$L($G(GMTSETYP))
 S GMTSETTL=$$EDT($G(GMTSTTL),$G(GMTSETYP)) S:'$L($G(GMTSETTL)) GMTSETYP=""
 Q
EDN(X) ; Edit Health Summary Type Name
 N DIR,DIROUT,DUOUT,DTOUT,Y,GMTSNN,GMTSON,GMTSNA,GMTSETYP
 S GMTSON=$G(X),GMTSETYP="" Q:'$L(GMTSON) ""
 S DIR("A")="      Re-Name '"_GMTSON_"' to:  "
 S GMTSNN=GMTSON F  S GMTSNN=$$TRIM($$NN(GMTSNN)) Q:+($$NWX(GMTSNN))=0
 S:$L(GMTSNN) DIR("B")=GMTSNN
 S DIR(0)="FAO^3:30^N GMTS S GMTS=$$CKN^GMTSOBU($G(X)) W:+GMTS=0&($L(X)) !!,""          '""_$G(X)_""' already exist."" K:+GMTS=0&($L(X)) X"
 S (DIR("?"),DIR("??"))="^D LNH^GMTSOBU"
 D ^DIR S X="" S:$L(Y)>2&($L(Y)<31) X=Y
 Q X
EDT(X,Y) ;  Edit Health Summary Type Title
 N DIR,DIROUT,DUOUT,DTOUT,GMTSNT,GMTSOT,GMTSTT,GMTSTY,GMTSNA,GMTSETYP
 S GMTSOT=$G(X),GMTSTT=$$EN2^GMTSUMX($G(Y)),GMTSTY=$G(Y)
 S GMTSNT=GMTSOT S:'$L(GMTSNT) GMTSNT=GMTSTT S GMTSNT=$$EN2^GMTSUMX(GMTSNT)
 F  S GMTSNT=$$TRIM($$NN(GMTSNT)) Q:+($$TWX(GMTSNT))=0
 S DIR("A")="      Title:  " S:$L(GMTSNT)>2&($L(GMTSNT)<31) DIR("B")=GMTSNT
 S DIR(0)="FAO^3:30^N GMTS S GMTS=$$CKT^GMTSOBU($G(X)) W:+GMTS=0&($L(X)) !!,""          '""_$G(X)_""' already exist."" K:+GMTS=0&($L(X)) X"
 S (DIR("?"),DIR("??"))="^D LNH^GMTSOBU"
 D ^DIR S X="" S:$L(Y)>2&($L(Y)<31) X=Y
 Q X
YNH ; Yes No Help
 W !,"        Enter either 'Y' or 'N'." Q
LNH ; Length Help
 W !,"          This response must have at least 3 characters and no more than 30"
 W !,"          characters and must not contain embedded uparrow." Q
CKN(X) ; Check New Name is Unique
 S X=$$NWX($G(X)) S X=$S(+X>0:0,1:1) Q X
CKT(X) ; Check New Title is Unique
 S X=$$TWX($G(X)) S X=$S(+X>0:0,1:1) Q X
 ;                     
 ; Miscellaneous
TIEN(X) ;   Type IEN
 N GMTSI,GMTSIEN S GMTSIEN=0 F GMTSI=5:1  D  Q:+GMTSIEN>0
 . Q:$G(^GMT(142,GMTSI,0))["GMTS HS ADHOC OPTION"  I GMTSI>4999999 S GMTSI=5999999 Q
 . S:'$D(^GMT(142,GMTSI)) GMTSIEN=GMTSI
 S X=GMTSIEN Q X
OIEN(X) ;   Object IEN
 N GMTSIEN,GMTSIT S GMTSIT=+($P($$SITE^VASITE,"^",3)) Q:+GMTSIT=0 -1
 S GMTSIEN=+($O(^GMT(142.5,(GMTSIT_"9999")),-1))+1 Q:$D(^GMT(142.5,+GMTSIEN,0)) -1
 S X=GMTSIEN
 Q X
BOX(X) ;   Get HS Object IEN from B Index
 N GMTSI,GMTSX,GMTSO,GMTSN S GMTSN=$G(X) Q:'$L(GMTSN) 0
 S (GMTSI,GMTSO)=0 F  S GMTSI=$O(^GMT(142.5,"B",$E(GMTSN,1,30),GMTSI)) Q:+GMTSI=0  D  Q:GMTSO>0
 . S GMTSX=$P($G(^GMT(142.5,+GMTSI,0)),"^",1) S:$$UP^XLFSTR(GMTSN)=$$UP^XLFSTR(GMTSX) GMTSO=GMTSI
 S X=+($G(GMTSO))
 Q X
NWX(X) ;   Get HS Name IEN from Word Index
 N GMTSI,GMTSX,GMTST,GMTSN,GMTSW S GMTSN=$$UP^XLFSTR($G(X)) Q:'$L(GMTSN) 0
 S GMTSW=$P(GMTSN," ",1),(GMTSI,GMTST)=0 F  S GMTSI=$O(^GMT(142,"AW",GMTSW,GMTSI)) Q:+GMTSI=0  D  Q:GMTST>0
 . S GMTSX=$P($G(^GMT(142,+GMTSI,0)),"^",1) S:$$UP^XLFSTR(GMTSN)=$$UP^XLFSTR(GMTSX) GMTST=GMTSI
 S X=+($G(GMTST))
 Q X
TWX(X) ;   Get HS Title IEN from Word Index
 N GMTSI,GMTSX,GMTST,GMTSN,GMTSW S GMTSN=$$UP^XLFSTR($G(X)) Q:'$L(GMTSN) 0
 S GMTSW=$P(GMTSN," ",1),(GMTSI,GMTST)=0 F  S GMTSI=$O(^GMT(142,"AW",GMTSW,GMTSI)) Q:+GMTSI=0  D  Q:GMTST>0
 . S GMTSX=$P($G(^GMT(142,+GMTSI,"T")),"^",1) S:$$UP^XLFSTR(GMTSN)=$$UP^XLFSTR(GMTSX) GMTST=GMTSI
 S X=+($G(GMTST))
 Q X
NN(X) ;   New Name
 N GMTSNN,GMTSNI,GMTSNS
 S GMTSNN=$G(X),GMTSNI=$P(GMTSNN," ",$L(GMTSNN," "))
 S GMTSNS=$P(GMTSNN," ",1,($L(GMTSNN," ")-1))
 S:+GMTSNI=0 GMTSNS=GMTSNN S:+GMTSNI=0 GMTSNI=1 S GMTSNI=+GMTSNI+1
 S GMTSNS=$$TRIM(GMTSNS)
 S:($L(GMTSNS)+$L(GMTSNI))>29 GMTSNS=$E(GMTSNS,1,30-($L(GMTSNI)+2))
 S X=$$TRIM(GMTSNS)_" "_GMTSNI
 Q X
DEL(X) ;   Delete Routine X
 S X=$G(X) Q:'$L(X)  Q:$L(X)>8  Q:$$ROK(X)=0  X ^%ZOSF("DEL") Q
ROK(X) ;   Routine Ok
 S X=$G(X) Q:'$L(X) 0
 N GMTSEX,GMTSTXT S GMTSEX="S GMTSTXT=$T(+1^"_X_")" X GMTSEX Q:'$L(GMTSTXT) 0 Q 1
TX(R,T,L) ;   Get Text (Routine/Tag/Line)
 N GMTSEX,GMTSTXT S GMTSEX="S GMTSTXT=$T("_T_"+"_L_"^"_R_")" X GMTSEX S X=GMTSTXT
 Q X
TRIM(X) ;   Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 S X=$$UP^XLFSTR($E(X,1))_$E(X,2,$L(X))
 Q X
