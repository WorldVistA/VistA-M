DINIT27H ;SFISC/DPC -FOREIGN FORMAT DELIMITED ;11/30/92  3:51 PM
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT27I S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.44,.998,0)
 ;;=USER DEFINED (DELIMITED)^ASK^ask^^^^^0^1^^^1
 ;;^DIST(.44,.998,3,0)
 ;;=^^3^3^2921120^
 ;;^DIST(.44,.998,3,1,0)
 ;;=User will be prompted for field and record delimiters and for the maximum
 ;;^DIST(.44,.998,3,2,0)
 ;;=length of an exported record.  A field delimiter is mandatory; a record
 ;;^DIST(.44,.998,3,3,0)
 ;;=delimiter is optional.
