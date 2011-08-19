LEXDFN2 ; ISL Default Names                        ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
AP(X) ; Application Pointer
 S X=$G(X) S X=$$NS(X) Q:X="" 1
 N LEXIEN,LEXNS
 I $L($G(X)),$D(^LEXT(757.2,"AN",X)) S X=$O(^LEXT(757.2,"AN",X,0)) Q X
 I $L($G(X)),$D(^LEXT(757.2,"B",X)) D  I LEXNS'="" S X=LEXIEN Q X
 . S LEXIEN=$O(^LEXT(757.2,"B",X,0))
 . S LEXNS=$P($G(^LEXT(757.2,LEXIEN,5)),"^",5)
 I $L($G(X)),$D(^LEXT(757.2,"C",$$UP^XLFSTR(X))) D  I LEXNS'="" S X=LEXIEN Q X
 . S LEXIEN=$O(^LEXT(757.2,"C",$$UP^XLFSTR(X),0))
 . S LEXNS=$P($G(^LEXT(757.2,LEXIEN,5)),"^",5)
 I $L($G(X)),$D(^LEXT(757.2,"APPS",X)) D  I LEXNS'="" S X=LEXIEN Q X
 . S LEXIEN=$O(^LEXT(757.2,"APPS",X,0))
 . S LEXNS=$P($G(^LEXT(757.2,LEXIEN,5)),"^",5)
 Q 1
NS(X) ; Namespace
 S X=$G(X) Q:X="" "LEX"
 I +X>0,$D(^LEXT(757.2,+X)) S X=$P($G(^LEXT(757.2,+X,5)),"^",5) S:X="" X="LEX" Q X
 I X'="",$D(^LEXT(757.2,"AA",X)) D  S:X="" X="LEX" Q X
 . N LEXR S LEXR=$O(^LEXT(757.2,"AA",X,0)) I +LEXR>0,$D(^LEXT(757.2,+LEXR,0)) S X=$P($G(^LEXT(757.2,+LEXR,5)),"^",5)
 I X'="",$D(^LEXT(757.2,"AB",X)) D  S:X="" X="LEX" Q X
 . N LEXR S LEXR=$O(^LEXT(757.2,"AB",X,0)) I +LEXR>0,$D(^LEXT(757.2,+LEXR,0)) S X=$P($G(^LEXT(757.2,+LEXR,5)),"^",5)
 I X'="",$D(^LEXT(757.2,"APPS",X)) D  S:X="" X="LEX" Q X
 . N LEXR S LEXR=$O(^LEXT(757.2,"APPS",X,0)) I +LEXR>0,$D(^LEXT(757.2,+LEXR,0)) S X=$P($G(^LEXT(757.2,+LEXR,5)),"^",5)
 I X'="",$D(^LEXT(757.2,"AN",X)) D  S:X="" X="LEX" Q X
 . N LEXR S LEXR=$O(^LEXT(757.2,"AN",X,0)) I +LEXR>0,$D(^LEXT(757.2,+LEXR,0)) S X=$P($G(^LEXT(757.2,+LEXR,5)),"^",5)
 I X'="",$D(^LEXT(757.2,"C",$$UP^XLFSTR(X))) D  S:X="" X="LEX" Q X
 . N LEXR S LEXR=$O(^LEXT(757.2,"C",$$UP^XLFSTR(X),0)) I +LEXR>0,$D(^LEXT(757.2,+LEXR,0)) S X=$P($G(^LEXT(757.2,+LEXR,5)),"^",5)
 Q "LEX"
MD(X) ; Mode/Subset
 S X=$G(X) Q:X="" "WRD"
 I $D(^LEXT(757.2,"AA",X)) D  S:X="" X="WRD" Q X
 . N LEXR S LEXR=$O(^LEXT(757.2,"AA",X,0)) I +LEXR>0,$D(^LEXT(757.2,+LEXR,0)) S X=$$MODE(+LEXR)
 I $D(^LEXT(757.2,"AB",X)) D  S:X="" X="WRD" Q X
 . N LEXR S LEXR=$O(^LEXT(757.2,"AB",X,0)) I +LEXR>0,$D(^LEXT(757.2,+LEXR,0)) S X=$$MODE(+LEXR)
 I $D(^LEXT(757.2,"APPS",X)) D  S:X="" X="WRD" Q X
 . N LEXR S LEXR=$O(^LEXT(757.2,"APPS",X,0)) I +LEXR>0,$D(^LEXT(757.2,+LEXR,0)) S X=$$MODE(+LEXR)
 I $D(^LEXT(757.2,"AN",X)) D  S:X="" X="WRD" Q X
 . N LEXR S LEXR=$O(^LEXT(757.2,"AN",X,0)) I +LEXR>0,$D(^LEXT(757.2,+LEXR,0)) S X=$$MODE(+LEXR)
 I $D(^LEXT(757.2,"C",$$UP^XLFSTR(X))) D  S:X="" X="WRD" Q X
 . N LEXR S LEXR=$O(^LEXT(757.2,"C",$$UP^XLFSTR(X),0)) I +LEXR>0,$D(^LEXT(757.2,+LEXR,0)) S X=$$MODE(+LEXR)
 I +X>0,$D(^LEXT(757.2,+X)) S X=$$MODE(+X) S:X="" X="WRD" Q X
 Q "WRD"
MODE(X) ;
 N LEXMD S X=+($G(X)) Q:X=0 "WRD"
 S LEXMD=$P($G(^LEXT(757.2,X,5)),"^",1) I LEXMD'="" S X=LEXMD Q X
 S LEXMD=$P($G(^LEXT(757.2,X,5)),"^",2) I LEXMD'="" S X=LEXMD Q X
 S LEXMD=$P($G(^LEXT(757.2,X,0)),"^",2) I LEXMD'="" S X=LEXMD Q X
 Q "WRD"
