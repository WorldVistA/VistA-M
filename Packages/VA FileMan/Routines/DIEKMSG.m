DIEKMSG ;SFISC/MKO-PRINT MESSAGE ABOUT BAD KEYS ;12:47 PM  18 Feb 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
MSG(DIEBADK,DIEREST) ;Print message
 Q:$D(DIEBADK)<2
 ;
 N ANS,FIL,FINFO,FLD,KEY,LEV,MSG,NEW,OLD,REC,RFIL,TXT,DIERR
 K ^TMP("DIEMSG",$J)
 ;
 D PROMPT(DIEREST,.ANS) Q:'ANS
 ;
 W !
 I DIEREST D
 . D L("The following field(s) have been restored to their pre-edited values:")
 E  D L("The following field values are not valid:")
 D L("")
 ;
 ;Loop through root files
 S RFIL=0 F  S RFIL=$O(DIEBADK(RFIL)) Q:'RFIL  D
 . D FILENAME^DIKCU1(RFIL,.TXT,.FINFO) Q:'$D(FINFO)
 . D FILELN(.TXT,FINFO)
 . ;
 . ;Loop through keys
 . S KEY=0 F  S KEY=$O(DIEBADK(RFIL,KEY)) Q:'KEY  D
 .. D L("  Key: "_$P(^DD("KEY",KEY,0),U,2))
 .. ;
 .. ;Loop through files
 .. S FIL=0 F  S FIL=$O(DIEBADK(RFIL,KEY,FIL)) Q:'FIL  D
 ... ;
 ... ;Loop through records
 ... S REC=0 F  S REC=$O(DIEBADK(RFIL,KEY,FIL,REC)) Q:'REC  D
 .... D RECNAME^DIKCU1("",REC,.TXT,.FINFO)
 .... D RECLN(.TXT,FINFO)
 .... ;
 .... ;Loop through fields
 .... S FLD=0 F  S FLD=$O(DIEBADK(RFIL,KEY,FIL,REC,FLD)) Q:'FLD  D
 ..... S OLD=$G(DIEBADK(RFIL,KEY,FIL,REC,FLD,"O"))
 ..... S NEW=$G(DIEBADK(RFIL,KEY,FIL,REC,FLD,"N"))
 ..... S OLD=$S(OLD]"":$$EXTERNAL^DILFD(FIL,FLD,"",OLD,"MSG"),1:"<null>")
 ..... S NEW=$S(NEW]"":$$EXTERNAL^DILFD(FIL,FLD,"",NEW,"MSG"),1:"<null>")
 ..... I $G(DIERR) K DIERR,MSG Q
 ..... D L("")
 ..... D L($J("",14)_"Field: "_$P(^DD(FIL,FLD,0),U)_" (#"_FLD_")")
 ..... D L($J("",6)_"Invalid value: "),L(NEW,1,21)
 ..... D:$G(DIEREST) L($J("",8)_"Restored to: "),L(OLD,1,21)
 .... D L("")
 ;
 I $D(^TMP("DIEMSG",$J)) D PRINT
 K ^TMP("DIEMSG",$J)
 Q
 ;
FILELN(TXT,LEV) ;
 N I,MAR
 S MAR=$S($G(IOM)<40:80,1:IOM)-1
 ;
 S TXT=$S(LEV:"Subfile",1:"File")_": "_TXT
 D WRAP^DIKCU2(.TXT,MAR-9,MAR)
 D L(TXT) F I=1:1 Q:'$D(TXT(I))  D L($J("",9)_TXT(I))
 Q
 ;
RECLN(TXT,LEV) ;
 N I,MAR
 S MAR=$S($G(IOM)<40:80,1:IOM)-1
 ;
 S TXT="    Record: "_TXT
 D WRAP^DIKCU2(.TXT,MAR-12,MAR)
 D L(TXT) F I=1:1 Q:'$D(TXT(I))  D L($J("",12)_TXT(I))
 Q
 ;
L(X,A,LM) ;Add X to the DIEMSG array
 N LC
 S LC=$O(^TMP("DIEMSG",$J,""),-1)
 ;
 I '$G(LM) D  Q
 . I '$G(A) S ^TMP("DIEMSG",$J,LC+1)=X
 . E  S ^(LC)=^TMP("DIEMSG",$J,LC)_X
 ;
 N I,M,T
 S M=$S($G(IOM)<40:80,1:IOM)-1 S:M'>LM LM=0
 F I=1:1 D   Q:X=""
 . S T=$E(X,1,M-LM),X=$E(X,M-LM+1,999)
 . I I=1,$G(A) S ^(LC)=^TMP("DIEMSG",$J,LC)_T
 . E  S LC=LC+1,^TMP("DIEMSG",$J,LC)=$J("",LM)_T
 Q
 ;
PRINT ;Print lines stored in ^TMP("DIEMSG",$J)
 N I,LC,SL
 S SL=$S($G(IOSL)<4:24,1:IOSL)
 S (I,LC)=0 F  S I=$O(^TMP("DIEMSG",$J,I)) Q:'I  D
 . S LC=LC+1
 . W ^TMP("DIEMSG",$J,I),!
 . I LC'<(SL-2) D
 .. N DIR,DUOUT,DTOUT,DIRUT,DIROUT,X,Y
 .. S DIR(0)="E" D ^DIR W !!
 .. S LC=0
 Q
 ;
PROMPT(DIEREST,ANS) ;Ask user whether to print report
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 W !!,$C(7)_"*****  NOTE  *****"
 W !!,"Some of the previous edits are not valid because they create one or more"
 W !,"duplicate keys."
 I $G(DIEREST) D
 . W "  Some fields have been restored to their pre-edited"
 . W !,"values."
 W !
 ;
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Do you want to see a list of those fields"
 D ^DIR W !
 S ANS=Y=1
 Q
