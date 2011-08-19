DINIT27I ;SFISC/DPC-FOREIGN FORMAT USER FIXED ;2/26/93  10:57 PM
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT27J S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.44,.999,0)
 ;;=USER DEFINED (FIXED LENGTH)^^^^^1^^0^1^^^1
 ;;^DIST(.44,.999,3,0)
 ;;=^^2^2^2921120^
 ;;^DIST(.44,.999,3,1,0)
 ;;=The export will consist of fixed length records.  User will be prompted
 ;;^DIST(.44,.999,3,2,0)
 ;;=for the length of each field and for the maximum record length.
 ;;^DIST(.44,.999,4,0)
 ;;=^^4^4^2921120^
 ;;^DIST(.44,.999,4,1,0)
 ;;=The user-supplied maximum record length must be greater than the sum of
 ;;^DIST(.44,.999,4,2,0)
 ;;=the lengths of all the exported fields.  Date values will not be
 ;;^DIST(.44,.999,4,3,0)
 ;;=truncated; the record length must be at least 11 characters to hold the VA
 ;;^DIST(.44,.999,4,4,0)
 ;;=FileMan external form of the date.
 ;;^DIST(.44,.999,5,0)
 ;;=^.441^^
