DIPR89 ;SFISC/SO-PRE INSTALL ROUTINE FOR PATCH DI*22.0*89 ;5:23 AM  2 Feb 2002
 ;;22.0;VA FileMan;**89**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Utility to follow up patch DI*22*83
 ;Check for field whose type are Pointer and Set Of Codes
 ;whose $P#3 was has been corrupted and report them out for maual
 ;correction.
 ;Reference NOIS: BRX-1001-12770, Note #7 for replication and 'how
 ;to' manually correct.
 S X="Check for corrupted 3rd piece, Type: Pointer or Set Of Codes."
 D MES^XPDUTL(X)
 S X="Checking..."
 D MES^XPDUTL(X)
 ;
S ; Start testing
 N DDFILE,NOERR
 S NOERR=0
 S DDFILE=1.99999
 F  S DDFILE=$O(^DD(DDFILE)) Q:'DDFILE  D
 . N DDFIELD
 . S DDFIELD=0
 . F  S DDFIELD=$O(^DD(DDFILE,DDFIELD)) Q:'DDFIELD  D
 . . N NODE
 . . S NODE=$G(^DD(DDFILE,DDFIELD,0))
 . . I $P(NODE,U,3)]"" Q  ;No corruption here
 . . I $P(NODE,U,2)'["P",$P(NODE,U,2)'["S" Q  ;Something other than a Pointer or Set Of Codes Field
 . . ;Piece #3 of the DD node is Null & the field type is a Pointer or Set Of Codes
 . . I +$P(NODE,U,2) Q  ;We are looking at a Multiple
 . . S NOERR=1
 . . N X
 . . S X=">>File/Subfile: "_DDFILE
 . . D MES^XPDUTL(X)
 . . S X="  Field: #"_DDFIELD_"("_$P(NODE,U)_")  Type: "_$S($P(NODE,U,2)["P":"Pointer",$P(NODE,U,2)["S":"Set",1:"")
 . . D MES^XPDUTL(X)
 . . S X="  Node="_NODE
 . . D MES^XPDUTL(X)
 I 'NOERR S X="No problems found" D MES^XPDUTL(X)
 Q
