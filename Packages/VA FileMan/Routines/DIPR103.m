DIPR103 ;SFISC/SO-PRE INSTALL ROUTINE FOR PATCH DI*22.0*103 ;1:18 PM  28 Feb 2002
 ;;22.0;VA FileMan;**103**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Check for field whose type are WP and missing the 'W'
 ;whose $P#2 was has been corrupted and report them out for maunal
 ;correction.
 S X="Check for corrupted Type: Word Processing."
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
 . . I '$D(^DD(DDFILE,0,"UP")) Q  ;Not a sub-file
 . . I DDFIELD'=.01 Q  ;Not a field we are interested in
 . . N NODE
 . . S NODE=$G(^DD(DDFILE,DDFIELD,0))
 . . I $P(NODE,U,2)]"" Q  ;No corruption here
 . . ;Piece #2 of the DD node is Null
 . . S NOERR=1
 . . N X
 . . S X=">>Subfile: "_DDFILE
 . . D MES^XPDUTL(X)
 . . S X="  Field: #"_DDFIELD_"("_$P(NODE,U)_")"
 . . D MES^XPDUTL(X)
 . . S X="  Node="_NODE
 . . D MES^XPDUTL(X)
 I 'NOERR S X="No problems found" D MES^XPDUTL(X)
 Q
