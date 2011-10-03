ONCODEL ;Hines OIFO/GWB - EXTENSION and LYMPH NODES ;8/12/94
 ;;2.11;ONCOLOGY;**7,15,19,22,27,28,30,36,47,49**;Mar 07, 1995;Build 38
 ;
IN ;EXTENSION (165.5,30) and LYMPH NODES (165.5,31) INPUT TRANSFORM
 S ONCOT=$P($G(^ONCO(165.5,D0,2)),U,1)
 N OP S OP=$$GETLIST(D0,ONCOX,ONCOT)
 I OP D
 .I X?.N D  Q
 ..I (X>99)!(X<0)!(X?.E1"."1N.N)!(X'?1.2N) K X W "  Invalid code" Q
 ..S:($L(X)=2)&($E(X,1)="0") X=$E(X,2)
 ..S Y=$G(^ONCO(164.5,OP,1,(X+1),0))
 ..I Y="" K X W "  Invalid Code" Q
 ..W ?(17-$L(X))," "_Y
 .I X?.AP D UCASE^ONCOU D  Q
 ..S XX=X
 ..I $D(^ONCO(164.5,OP,1,"C",X)) D  Q
 ...S X=$O(^ONCO(164.5,OP,1,"C",X,0)),X=X-1
 ...W ?(17-$L(X)),$P(Y,XX,2)
 ..S Y=$O(^ONCO(164.5,OP,1,"C",X))
 ..I ($P(Y,XX,1)'="")!(Y="") K X W "  Invalid code" Q
 ..S X=$O(^ONCO(164.5,OP,1,"C",Y,0)),X=X-1
 ..W ?(17-$L(X)),$P(Y,XX,2)
 .K X W "  Invalid code"
 E  W:OP'="" !,OP,*7,! K X
 D EX Q
 ;
OT ;EXTENSION (165.5,30) and LYMPH NODES (165.5,31) OUTPUT TRANSFORM
 Q:Y=""
 N YY,OP
 S ONCOT=$P($G(^ONCO(165.5,D0,2)),U,1)
 S OP=$$GETLIST(D0,ONCOX,ONCOT)
 I ONCOX="E",$L(Y)=1 S Y="0"_Y
 I OP S YY=$G(^ONCO(164.5,OP,1,(Y+1),0)),Y=$S(YY="":"Invalid code",1:Y_" "_YY)
 E  S Y=OP
 D EX
 Q
 ;
HP ;EXTENSION (165.5,30) and LYMPH NODES (165.5,31) HELP
 S ONCOT=$P($G(^ONCO(165.5,D0,2)),U,1)
 N OP S OP=$$GETLIST(D0,ONCOX,ONCOT)
 I OP D
 .W !?2,$P(^ONCO(164.5,OP,0),U)," (",SEERED," edition)",!
 .N X,Y S X=0
 .F  S X=$O(^ONCO(164.5,OP,1,X)) Q:X'>0  D
 ..S Y=X-1 S:($L(Y)=1)&(ONCOX="E") Y="0"_Y W !?2,Y_" "_^(X,0)
 E  W:OP'="" !,OP,*7,! K X
 W !
 D EX Q
 ;
EX ;KILL variables
 K HISTNAM,HSTFLD,ICDFILE,ONCOX,SEERED,ONCFLD,XX
 Q
 ;
GETLIST(ONCOIX,CODTYP,ONCOT,OUTFLAG) ;CODTYP (E=extension, L=lymph node)
 N OP
 N ED S ED=$$EDITION^ONCOU55(ONCOIX)
 S SEERED=$S(ED=3:"3rd",ED=2:"2nd",ED=1:"1st",1:ED)
 N ONCOER
 N SCOD S SCOD=$P(^ONCO(165.5,ONCOIX,0),U)
 I ONCOT="" S ONCOER="No PRIMARY SITE."
 I $G(ONCOER)="" N HST S HST=$$HIST^ONCFUNC(D0,.HSTFLD,.HISTNAM,.ICDFILE) I HST="" S ONCOER="No HISTOLOGY."
 I $G(ONCOER)="" D
 .N MELANOMA S MELANOMA=$$MELANOMA^ONCOU55(ONCOIX)
 .I MELANOMA,$P($G(^ONCO(164,ONCOT,0)),U,15) S OP=$S(CODTYP="E":145,CODTYP="L":146,1:0) ;Malignant melanoma of the skin
 .E  I MELANOMA,ED=2,ONCOT=67690 S OP=$S(CODTYP="E":167,CODTYP="L":172,1:0) ;Malignant melanoma of the conjunctiva (uses Conjunctiva list)
 .E  I MELANOMA,ED=2,ONCOT>67690,ONCOT<67700 S OP=$S(CODTYP="E":169,CODTYP="L":170,1:0) ;Malignant Melanoma of Uvea - 2nd edition
 .E  I MELANOMA,ED=3,ONCOT>67690,ONCOT<67700 S OP=$S(CODTYP="E":241,CODTYP="L":170,1:0) ;Malignant Melanoma of Uvea - 3rd edition 
 .E  D
 ..S OP=$P($G(^ONCO(ICDFILE,HST,CODTYP)),U,ED) ;Histology
 ..I '$G(OP),ONCOT=67422,(($E(HST,1,3)<959)!($E(HST,1,3)>971)),'$$LEUKEMIA^ONCOAIP2(ONCOIX),HST'=91403 S OP=$S(CODTYP="E":132,1:133)
 ..I '$G(OP),((ONCOT=67770)&((SCOD=62)!(SCOD=63)))!(SCOD=35)!(SCOD=39)!(SCOD=40) S OP=$P($G(^ONCO(164.2,SCOD,CODTYP)),U,ED) ;Special site-groups
 ..I '$G(OP),ONCOT=67619,$G(ONCFLD)=30,ED=3 S OP=$P($G(^ONCO(164,ONCOT,CODTYP)),U,ED) ;Prostate Gland--Clincal Extension
 ..I '$G(OP),ONCOT=67619,$G(ONCFLD)=30.1,ED=3 S OP=250 ;Prostate Gland--Pathologic Extension
 ..I '$G(OP) S OP=$P($G(^ONCO(164,ONCOT,CODTYP)),U,ED) ;Topography
 ..I '$G(OP) S OP=$P($G(^ONCO(164.2,SCOD,CODTYP)),U,ED) ;Other site-groups
 I $D(ONCOER) Q ONCOER
 E  Q $S($G(OUTFLAG)'="OUT":OP,1:OP_" "_$P(^ONCO(164.5,OP,0),U,5)_" "_ED_" "_$P(^(0),U))
