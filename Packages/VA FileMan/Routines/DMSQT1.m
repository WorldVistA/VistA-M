DMSQT1 ;SFISC/EZ-STATUS CHECK ;11/13/97  12:08
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
WAIT() ; extrinsic function, checks if SQLI is running (you must wait)
 ; returns 1 if nodes in ^DMSQ are changing, null otherwise
 D DT^DICRW N J,FLG,DM S FLG=""
 D SET H 2 D CHK
 I FLG Q 1
 E  Q ""
SET ; set the DM array with current record counts
 S J=""
 F  S J=$O(^DMSQ(J)) Q:J=""  S DM(J)=$P(^(J,0),U,3)
 Q
CHK ; check whether the counts have changed
 S J=""
 F  S J=$O(^DMSQ(J)) Q:J=""  S:DM(J)'=$P(^(J,0),U,3) FLG=1
 Q
IDX(TI) ; extrinsic function, checks for indexes on table TI
 ; returns 1 if there are more indexes to process
 ; see INDEX^DMSQF2 for similar index checking code
 N F,FI,IN,I,IF,IX,CI,FLG D DT^DICRW S FLG=""
 S F=$P(^DMSQ("T",TI,0),U,7)
 S FI=0 F  S FI=$O(^DD(F,FI)) Q:'FI  D
 . S IN=0 F  S IN=$O(^DD(F,FI,1,IN)) Q:'IN  D
 .. S I=$G(^DD(F,FI,1,IN,0))
 .. I $P(I,U,3)]"" Q   ; not a regular index
 .. I I="" Q           ; no data at DD location
 .. S IF=+I,IX=$P(I,U,2) I IX=""!'IF Q  ; no file # or index name
 .. I $G(^DD(F,FI,1,IN,1))'[",DA)" Q  ; last subscript isn't DA
 .. S CI=$O(^DMSQ("C","D",F,FI,"")) Q:'CI  ; missing column
 .. S FLG=2  ; this index is a candidate for projection
 I FLG=2 Q 1
 E  Q ""
