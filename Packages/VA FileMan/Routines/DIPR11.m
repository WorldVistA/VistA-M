DIPR11 ;SFISC/MKO-PRE INSTALL ROUTINE FOR PATCH DI*22.0*11 ;2/15/00  10:22
 ;;22.0;VA FileMan;**11**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Modify the trigger logic of fields that trigger fields with
 ;New-Style Indexes, so that they call ^DICR unconditionally,
 ;This ensures that New-Style Indexes on the triggered fields are
 ;are fired when the trigger logic is executed.
 ;Also, recompile any input templates that contain fields that trigger
 ;fields with new-style indexes.
TRIG N FIL,FLD,NAM,OUT,TEM
 K ^TMP("DIPR11",$J)
 S FIL=.9999 F  S FIL=$O(^DD("IX","F",FIL)) Q:'FIL  D
 . S FLD=0 F  S FLD=$O(^DD("IX","F",FIL,FLD)) Q:'FLD  D
 .. Q:$D(^TMP("DIPR11",$J,FIL,FLD))  S ^(FLD)=""
 .. K OUT D TRMOD^DICR(FIL,FLD,.OUT) Q:'$D(OUT)
 .. M ^TMP("DIPR11",$J)=OUT
 ;
 S FIL=0 F  S FIL=$O(^TMP("DIPR11",$J,FIL)) Q:'FIL  D
 . S FLD=$O(^TMP("DIPR11",$J,FIL,FLD)) Q:'FLD  D
 .. S TEM=0 F  S TEM=$O(^DIE("AF",FIL,FLD,TEM)) Q:'TEM  D
 ... Q:$D(^TMP("DIPR11",$J,"TEM",TEM))  S ^(TEM)=""
 ... S NAM=$G(^DIE(TEM,"ROUOLD")) Q:NAM=""
 ... D EN2^DIEZ(TEM,"",NAM)
 K ^TMP("DIPR11",$J)
 ;
NODE0 ; Repair 0 node of INDEX and KEY files
 N I,DICNT,DILAST S DICNT=0,DILAST="",I=0
 F  S I=$O(^DD("IX",I)) Q:'I  I $D(^DD("IX",I,0))#2 S DICNT=DICNT+1,DILAST=I
 S $P(^DD("IX",0),"^",3,4)=DILAST_"^"_DICNT
 S DICNT=0,DILAST="",I=0
 F  S I=$O(^DD("KEY",I)) Q:'I  I $D(^DD("KEY",I,0))#2 S DICNT=DICNT+1,DILAST=I
 S $P(^DD("KEY",0),"^",3,4)=DILAST_"^"_DICNT
 Q
 ;
