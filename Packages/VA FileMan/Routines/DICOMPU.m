DICOMPU ;GFT/GFT - META-DATA-DICTIONARY LOOKUP;24JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1024,1032**
 ;
EN(Y,J,DICOMP,DICMX) ; Main Entry Point
 ;Y=expression; DICOMP=parameter string; J array by reference, as set up by IJ^DIUTL, or just FILE NUMBER; DICMX defined means multiples allowed
 N DATE,D,DD,DIS,DISTART,DICN,FIL,FIELD,F,FLD,DSPI,FILE,DIC,%,X,ASKED
 I $D(J)=1 S D=J K J S J(0)=D
 K DUOUT
 S DISTART=Y K Y I $L(DISTART)>31!($D(J)<9)!($L(DISTART)<3) Q ""  ;1 or 2 characters isn't enough
 I '$D(DICOMP) S DICOMP="?"
 D DRW^DICOMPX ;Sets up DIC("S") (see tags PTQ+2 and ACCESS+2)
 S D="" F  S D=$O(J(D)) Q:D=""  S FILE(J(D))="" ;builds list of Files we know to start with
 ;Here we go, looping thru ^DDD
 S DIS=DISTART
X F DICN=0:0 S DICN=$O(^DDD("C",DIS,DICN)) Q:'DICN  S DIC=$G(^DDD(DICN,0)),X=$P(DIC,U,2),FIL=$P(DIC,U,3),FIELD=$P(DIC,U,4),F=$$LOOK G QX:$D(DUOUT) I F]"" S:$P(DIC,U,5) FIELD=FIELD_"="""_X_"""" G GOT
 ;That 5th piece would be a VALUE, like "ILLINOIS"
 I $L(DISTART)>2 S DIS=$O(^DDD("C",DIS)) I DIS]"",$P(DIS,DISTART)="" G X
 ;Couldn't find simple field name.  Let's see if it's "FILE FIELD"
 S X=DISTART
 F DSPI=1:1:$L(X," ")-1 S FIL=$P(X," ",1,DSPI) I FIL]"",$L(FIL)<32 S FIL=$O(^DIC("B",FIL,0)) I FIL S FIELD=$P(X," ",DSPI+1,999) I FIELD]"",$L(FIELD)<32 S FIELD=$O(^DD(FIL,"B",FIELD,0)),F=$$LOOK Q:$D(DUOUT)  G GOT:F]""
QX K ^TMP("DICOMPU",$J) Q ""
 ;
 ;
LOOK() N TRY K ^TMP("DICOMPU",$J)
 ;In ^TMP("DICOMPU",$J,"F") we will store failure to go FORWARD
 ;In ^TMP("DICOMPU",$J,"B") we will store failure to go BACKWARD
 I 'FIL!'FIELD Q ""
 Q $$FIELD(FIL,FIELD)
 ;Following subroutine is called RECURSIVELY
FIELD(F,DD) ;Can we TRANSlate File F, Field DD to the context of FILE?
 I '$D(^DD(F,DD,0)) Q ""
 I '$D(DICMX),$P(^(0),U,2) Q "" ;Can we go to a multiple field?
 I $D(TRY(F)) Q ""
 I '$$ACCESS(F,DD) Q "" ; Not if they don"t have access to that File & Field
 S TRY(F)="" N T M T=TRY N TRY M TRY=T K T ;Inherit everything tried
MULTIPL ;First, can we get to the context by going up from a MULTIPLE
 N OUT,B,T,TRANS,L,D,I
 I $D(DICMX) S T=F,TRANS="" K D D  I $D(D) S TRANS=$$TOOLONG(D,TRANS) D SAVE G OUT:$G(OUT)
 .F  Q:'$D(^DD(T,0,"UP"))  S D=T,TRANS=$O(^DD(T,0,"NM",0))_":"_TRANS,T=^DD(T,0,"UP"),D=$O(^DD(T,"SB",D,0))
 .I TRANS=""!$D(TRY(T)) K D Q
 .I $D(FILE(T)) S D="",OUT=1 Q
 .S D=$$FIELD(T,D) I D="" K D
FORWARD ;Next, can we go FROM our context TO the found File F?
 D  D SAVE G OUT:$G(OUT)
 .N Y,KEEP,UP,FI,FLD ;Can we go from our context to File F?
 .S FI=1.9,KEEP=""
PTQ .S TRANS=KEEP,FI=$O(^DD(F,0,"PT",FI)) I 'FI Q  ;Can we get to this F FILE from another?
 .G PTQ:$D(TRY(FI))!$D(^TMP("DICOMPU",$J,"F",F,FI)) I FI[".",$D(^DD(FI,0,"UP")) G PTQ:'$D(DICMX)
 .S FLD=0
F .S FLD=+$O(^DD(F,0,"PT",FI,FLD)) I 'FLD G PTQ ;go thru all the Pointers to File F in File FI, and take those that...
 .S %=$P($G(^DD(FI,FLD,0)),U,2) I %'["P" G F ;...are regular pointers (not VARIABLE-POINTER)...
 .I +$P(%,"P",2)=FI G F ;not to itself
 .S TRANS=$P(^(0),U)_":" I $D(FILE(FI)) S OUT=1 Q
 .S T=$$FIELD(FI,FLD) I T="" S ^TMP("DICOMPU",$J,"F",F,FI)="" G PTQ
 .S KEEP=$$TOOLONG(T,TRANS) G F
BACK ;Finally, is there a Pointer FROM the found file TO our context?
 ;if file's .01 field is a DINUM pointer, maybe we can get to it by Backwards-pointer syntax -- "FILE NAME:"
 I $P($G(^DD(F,.01,0)),U,2)["P",$P(^(0),U,5,99)["DINUM=X" S T=+$P($P(^(0),U,2),"P",2) I T-F,$D(FILE(T)),$G(^DIC(F,0))[U S TRANS=$P(^(0),U)_":" D SAVE G OUT
 I $D(DICMX) F T=0:0 S T=$O(FILE(T)) Q:'T!$G(OUT)  D
 .N R,D,B,L,I ;Does File F eventually point to File T?
 .F D=1.9:0 S D=$O(^DD(T,0,"PT",D)) Q:'D  D:'$D(TRY(D))&'$D(^TMP("DICOMPU",$J,"B",F,D,T))  Q:$G(OUT)
 ..S B=$$TOP(D) I B>0,B-T F L=0:0 S L=$O(^DD(T,0,"PT",D,L)) Q:'L  I $P($G(^DD(D,L,0)),U,2)["P" F I=0:0 S I=$O(^DD(D,L,1,I)) Q:'I  I +$G(^(I,0))=B,$P(^(0),U,3,9)="" D  D SAVE Q:$G(OUT)
 ...S TRANS=$O(^DD(B,0,"NM",0))_":" I TRANS=":" S TRANS="" Q
 ...I B=F S OUT=1 Q  ;if we are at File F, we have succeeded
 ...N FILE K TRY(F) S TRY(D)="",FILE(B)="",FILE=$$RECURSE ;Otherwise, we CHANGE THE CONTEXT
 ...I FILE]"" S TRANS=$$TOOLONG(TRANS,FILE) Q
 ...S TRANS="",^TMP("DICOMPU",$J,"B",F,D,T)=""
OUT S OUT="",T=0 ;Of our possible paths, let's choose the SHORTEST
 I '$D(DUOUT) F %=1:1 Q:'$D(OUT(%))  S L=$L(OUT(%),":") D
 .I OUT]"" Q:T'>L  I ":"_OUT(%)[":*" Q  ;We don't like * fields
 .S OUT=OUT(%),T=L
 Q OUT
 ;
RECURSE() G MULTIPL
 ;
 ;
TOP(B) ;
UP I '$D(^DD(B,0)) Q -999
 I $D(^(0,"UP")) S B=^("UP") G UP
 Q B
 ;
ACCESS(A,B) I DUZ(0)="@" Q 1
 N Y S Y=$$TOP(A) I '$D(^DIC(Y,0)) Q 0
 X DIC("S") E  Q 0
 I '$D(^DD(A,B,8)) Q 1
 Q $TR(DUZ(0),^(8))'=DUZ(0)
 ;
TOOLONG(A,B) I $L(A)+$L(B)+$L(FIELD)>($G(^DD("STRING_LIMIT"),255)-5) Q ""
 Q A_B
 ;
SAVE I TRANS]"" D ASK I TRANS]"" D  Q
 .;I TRANS'[":" K OUT S OUT=1 Q
 .S OUT($O(OUT(""),-1)+1)=TRANS
 S OUT=$G(DUOUT) Q
 ;
ASK I $D(DUOUT) S TRANS="" Q  ;TRANS is the return value
 I DICOMP'["?"!'DD!$G(DSPI) Q  ;if Field Number is zero, or input was in form of 'FILE FIELD', don't ASK
 I $D(ASKED(FIL,FIELD)) S:'ASKED(FIL,FIELD) TRANS="" Q
 N DIASK
 W !?7 S DIASK(1)=DISTART,DIASK(3)=$P(DIC,U,2),%=$P(DIC,U),DIASK(2)=$P(%,"_",1,$L(%,"_")-1)
 D BLD^DIALOG(8201,.DIASK),MSG^DIALOG("WM")
 S %=1 D YN^DICN I %<0 S DUOUT=1
 S ASKED(FIL,FIELD)=%=1 S:%-1 TRANS="" Q
 ;
GOT K ^TMP("DICOMPU",$J) Q F_"#"_FIELD ;we've GOT the expression.
