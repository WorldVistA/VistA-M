ENEQPMS8 ;(WIRMFO)/DH-Sort PM Worklist by LOCATION ;4.21.97
 ;;7.0;ENGINEERING;**26,35**;Aug 17, 1993
 ;
 ;  Programs calling this routine without having defined loc var
 ;   ENSRT("LOC","ALL") should expect it to exist upon return and
 ;   kill it before terminating job.
 ;
 ;  In processing ranges, values will be treated as numbers if all
 ;   values are numbers, otherwise all values will be treated as strings
 ;
LOC(DA) ;  DA => IEN for Equipment File (6914)
 ;  Expects ENSRT array as prepared via routine ENEQPMS1
 ;  Called by ENEQPMS2
 ;
 N SPC
 S SPC=$P($G(^ENG(6914,DA,3)),U,5) I SPC="" S X=-3 Q X
 I $E(SPC)="*" S X=-2_U_$P(SPC,",") Q X  ;Not a pointer
 I '$D(^ENG("SP",SPC,0)) S X=-2_U_$P(SPC,",") Q X  ;Not a pointer either
 D MAIN
 Q X
 ;
SPACE(SPC) ;  SPC => IEN for Space File (6928)
 ;  Expects ENSRT array as prepared via routine ENWOST
 ;  Called by ENWOP3
 ;
 I SPC="" S X=-3 Q X  ;Shouldn't happen
 I $E(SPC)="*" S X=-2_U_SPC Q X  ;Not a pointer
 I '$D(^ENG("SP",SPC,0)) S X=-2_U_$P(SPC,",") Q X  ;Still not a pointer
 D MAIN
 Q X
 ;
 ;  X returned
 ;    returned as less than 0 if entry is to be excluded, otherwise
 ;      piece 1 => DIVISION
 ;      piece 2 => BUILDING or WING, as specified
 ;      piece 3 => WING or BUILDING, as specified
 ;      piece 4 => ROOM
 ;
MAIN N A,I,J,D,B,W,R
 S (D,B,W,R)=0,X=""
 S:$G(ENSRT("LOC","ALL"))="" ENSRT("LOC","ALL")=1 I ENSRT("LOC","ALL")=1 D
 . S:'$D(ENSRT("BY")) ENSRT("BY")="DBWR"
 . F I="DIV","BLDG","WING","ROOM" S:ENSRT("BY")[$E(I) ENSRT(I,"ALL")=""
 F A="D","B","W","R" D @A Q:@A=-1  I @A'="N/A" S:@A="" @A=0 S:@A'?.N @A=""""_@A_"""" S X=X_@A_","
 I @A<0 S X=-1 Q
 S X=$E(X,1,$L(X)-1) ;Strip trailing coma
 Q  ;Design EXIT
 ;
D ;  Check DIVISION
 I ENSRT("BY")'["D" S D="N/A" Q
 S D=$P(^ENG("SP",SPC,0),U,10)
 I $D(ENSRT("DIV","ALL")) S:D?.N D=D_" " Q
 I D="",$D(ENSRT("DIV","AIND","NULL")) Q
 I D]"",$D(ENSRT("DIV","AIND",D)) S:D?.N D=D_" " Q
 S J=0 F  S J=$O(ENSRT("DIV","FR",J)) Q:'J!($D(D(0)))  D
 . I ENSRT("DIV","FR",J)?.N,ENSRT("DIV","TO",J)?.N,D?.N D  Q
 .. I ENSRT("DIV","FR",J)>D!(D>ENSRT("DIV","TO",J)) Q
 .. S D(0)="",D=D_" "
 . S:ENSRT("DIV","FR",J)?.N ENSRT("DIV","FR",J)=ENSRT("DIV","FR",J)_" "
 . S:ENSRT("DIV","TO",J)?.N ENSRT("DIV","TO",J)=ENSRT("DIV","TO",J)_" "
 . S:D?.N D=D_" "
 . I ENSRT("DIV","FR",J)]D!(D]ENSRT("DIV","TO",J)) Q
 . S D(0)=""
 I '$D(D(0)) S D=-1
 Q
 ;
B ;  Check BUILDING
 I ENSRT("BY")'["B" S B="N/A" Q
 S B=$P(^ENG("SP",SPC,0),U,2)
 I $D(ENSRT("BLDG","ALL")) S:B?.N B=B_" " Q
 I B="",$D(ENSRT("BLDG","AIND","NULL")) Q
 I B]"",$D(ENSRT("BLDG","AIND",B)) S:B?.N B=B_" " Q
 S J=0 F  S J=$O(ENSRT("BLDG","FR",J)) Q:'J!($D(B(0)))  D
 . I ENSRT("BLDG","FR",J)?.N,ENSRT("BLDG","TO",J)?.N,B?.N D  Q
 .. I ENSRT("BLDG","FR",J)>B!(B>ENSRT("BLDG","TO",J)) Q
 .. S B(0)="",B=B_" "
 . S:ENSRT("BLDG","FR",J)?.N ENSRT("BLDG","FR",J)=ENSRT("BLDG","FR",J)_" "
 . S:ENSRT("BLDG","TO",J)?.N ENSRT("BLDG","TO",J)=ENSRT("BLDG","TO",J)_" "
 . S:B?.N B=B_" "
 . I ENSRT("BLDG","FR",J)]B!(B]ENSRT("BLDG","TO",J)) Q
 . S B(0)=""
 I '$D(B(0)) S B=-1
 Q
 ;
W ;  Check WING
 I ENSRT("BY")'["W" S W="N/A" Q
 S W=$P(^ENG("SP",SPC,0),U,3)
 I $D(ENSRT("WING","ALL")) S:W?.N W=W_" " Q
 I W="",$D(ENSRT("WING","AIND","NULL")) Q
 I W]"",$D(ENSRT("WING","AIND",W)) S:W?.N W=W_" " Q
 S J=0 F  S J=$O(ENSRT("WING","FR",J)) Q:'J!($D(W(0)))  D
 . I ENSRT("WING","FR",J)?.N,ENSRT("WING","TO",J)?.N,W?.N D  Q
 .. I ENSRT("WING","FR",J)>W!(W>ENSRT("WING","TO",J)) Q
 .. S W(0)="",W=W_" "
 . S:ENSRT("WING","FR",J)?.N ENSRT("WING","FR",J)=ENSRT("WING","FR",J)_" "
 . S:ENSRT("WING","TO",J)?.N ENSRT("WING","TO",J)=ENSRT("WING","TO",J)_" "
 . S:W?.N W=W_" "
 . I ENSRT("WING","FR",J)]W!(W]ENSRT("WING","TO",J)) Q
 . S W(0)=""
 I '$D(W(0)) S W=-1
 Q
 ;
R ;  Check ROOM
 I ENSRT("BY")'["R" S R="N/A" Q
 S R=$P($P(^ENG("SP",SPC,0),U),"-")
 I $D(ENSRT("ROOM","ALL")) S:R?.N R=R_" " Q
 I $D(ENSRT("ROOM","AIND",R)) S:R?.N R=R_" " Q
 S J=0 F  S J=$O(ENSRT("ROOM","FR",J)) Q:'J!($D(R(0)))  D
 . I ENSRT("ROOM","FR",J)?.N,ENSRT("ROOM","TO",J)?.N,R?.N D  Q
 .. I ENSRT("ROOM","FR",J)>R!(R>ENSRT("ROOM","TO",J)) Q
 .. S R(0)="",R=R_" "
 . S:ENSRT("ROOM","FR",J)?.N ENSRT("ROOM","FR",J)=ENSRT("ROOM","FR",J)_" "
 . S:ENSRT("ROOM","TO",J)?.N ENSRT("ROOM","TO",J)=ENSRT("ROOM","TO",J)_" "
 . S:R?.N R=R_" "
 . I ENSRT("ROOM","FR",J)]R!(R]ENSRT("ROOM","TO",J)) Q
 . S R(0)=""
 I '$D(R(0)) S R=-1
 Q
 ;ENEQPMS8
