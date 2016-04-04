DINIT260 ;SFISC/XAK-INITIALIZE VA FILEMAN ;12/14/92  2:48 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT27:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DD(1.11,12,0)
 ;;=DATE LAST PRINTED^D^^0;13^S %DT="ETX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(1.11,12,3)
 ;;=Enter the date that the listing of items to be archived was last printed.
 ;;^DD(1.11,13,0)
 ;;=ARCHIVING ACTION IN PROGRESS^S^1:SELECTION;2:EDITING;4:ARCHIVING (TEMPORARY);5:ARCHIVING (PERMANENT);6:UPDATING DESTINATION FILE;90:PURGING;99:CANCELLING;^0;14^Q
 ;;^DD(1.11,13,3)
 ;;=Entry will be made here by system when user begins performing some action to this ARCHIVAL ACTIVITY and will be deleted when action is complete, to lock out other users.
 ;;^DD(1.11,14,0)
 ;;=DATE/TIME ACTIVITY BEGAN^D^^0;15^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(1.11,14,3)
 ;;=Date/time user began archiving action currently in progress.
 ;;^DD(1.11,15,0)
 ;;=USER PERFORMING ACTION^P200'^VA(200,^0;16^Q
 ;;^DD(1.11,15,3)
 ;;=User that initiated the archiving action.
 ;;^DD(1.11,16,0)
 ;;=TYPE OF ARCHIVE^S^0:ARCHIVING;1:EXTRACT;^0;17^Q
 ;;^DD(1.11,16,21,0)
 ;;=^^4^4^2921002^
 ;;^DD(1.11,16,21,1,0)
 ;;=This field indicates the archiving type for this particular archival
 ;;^DD(1.11,16,21,2,0)
 ;;=activity entry.  This should be 0 if the archival process is being done
 ;;^DD(1.11,16,21,3,0)
 ;;=under the Archiving options; or should be 1 if the archival process is
 ;;^DD(1.11,16,21,4,0)
 ;;=being done under the Extract Tool options.
 ;;^DD(1.11,17,0)
 ;;=DESTINATION FILE^P1'^DIC(^0;18^Q
 ;;^DD(1.11,17,21,0)
 ;;=^^2^2^2921002^
 ;;^DD(1.11,17,21,1,0)
 ;;=This field holds the number of the destination file for this archival
 ;;^DD(1.11,17,21,2,0)
 ;;=activity.
 ;;^DD(1.11,18,0)
 ;;=ARCHIVE DEVICE LABEL^F^^0;19^K:$L(X)>45!($L(X)<2) X
 ;;^DD(1.11,18,3)
 ;;=Answer must be 2-45 characters in length.
 ;;^DD(1.11,18,21,0)
 ;;=^^2^2^2921002^
 ;;^DD(1.11,18,21,1,0)
 ;;=This field holds the label information that identifies your archival
 ;;^DD(1.11,18,21,2,0)
 ;;=medium.
 ;;^DD(1.11,30,0)
 ;;=SUBFILE NUMBER^F^^1;1^K:+X'=X X
 ;;^DD(1.11,30,3)
 ;;=Type the number of a sub-file data dictionary.
 ;;^DD(1.11,31,0)
 ;;=SUBFILE SUBSCRIPTS^F^^1;2^K:$L(X)>50!($L(X)<3) X
 ;;^DD(1.11,31,3)
 ;;=Answer must be 3-50 characters in length.
 ;;^DD(1.11,32,0)
 ;;=SUBFILE SCREEN^1.1132A^^S;0
 ;;^DD(1.11,100,0)
 ;;=DATA^1.113^^D;0
 ;;^DD(1.113,0)
 ;;=DATA SUB-FIELD^^.01^1
 ;;^DD(1.113,0,"NM","DATA")
 ;;=
 ;;^DD(1.113,0,"UP")
 ;;=1.11
 ;;^DD(1.113,.01,0)
 ;;=DATA^WL^^0;1^Q
 ;;^DD(1.1132,0)
 ;;=SUBFILE SCREEN SUB-FIELD^^1^2
 ;;^DD(1.1132,0,"NM","SUBFILE SCREEN")
 ;;=
 ;;^DD(1.1132,0,"UP")
 ;;=1.11
 ;;^DD(1.1132,.01,0)
 ;;=SUBSCRIPT^F^^0;1^K:$L(X)>10!($L(X)<1) X
 ;;^DD(1.1132,.01,3)
 ;;=Answer must be 1-10 characters in length.
 ;;^DD(1.1132,1,0)
 ;;=CODE^K^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.1132,1,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(1.1132,1,9)
 ;;=@
 ;;^DD(1.11,200,0)
 ;;=DESTINATION FILE ENTRIES^1.14^^EX;0
 ;;^DD(1.14,0)
 ;;=DESTINATION FILE ENTRIES SUB-FIELD^^.01^1
 ;;^DD(1.14,0,"NM","DESTINATION FILE ENTRIES")
 ;;=
 ;;^DD(1.14,0,"UP")
 ;;=1.11
 ;;^DD(1.14,.01,0)
 ;;=DESTINATION FILE ENTRIES^MNJ9,0X^^0;1^K:+X'=X!(X>999999999)!(X<0)!(X?.E1"."1N.N) X I $D(X) S DINUM=X
 ;;^DD(1.14,.01,1,0)
 ;;=^.1
 ;;^DD(1.14,.01,1,1,0)
 ;;=1.14^B
 ;;^DD(1.14,.01,1,1,1)
 ;;=S ^DIAR(1.11,DA(1),"EX","B",$E(X,1,30),DA)=""
 ;;^DD(1.14,.01,1,1,2)
 ;;=K ^DIAR(1.11,DA(1),"EX","B",$E(X,1,30),DA)
 ;;^DD(1.14,.01,3)
 ;;=Type a Number between 0 and 999999999, 0 Decimal Digits
 ;;^DD(1.14,.01,21,0)
 ;;=^^2^2^2921208^
 ;;^DD(1.14,.01,21,1,0)
 ;;=This field holds the internal entry number of the record created in the
 ;;^DD(1.14,.01,21,3,0)
 ;;=destination file.
