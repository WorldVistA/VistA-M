DINIT27 ;SFISC/DPC-LOADS DD OF FOREIGN FORMAT FILE ;01:40 PM  13 Sep 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT270:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DIC(.44,0,"GL")
 ;;=^DIST(.44,
 ;;^DIC("B","FOREIGN FORMAT",.44)
 ;;=
 ;;^DD(.44,0)
 ;;=FIELD^^11^19
 ;;^DD(.44,0,"DDA")
 ;;=N
 ;;^DD(.44,0,"DT")
 ;;=2930107
 ;;^DD(.44,0,"ID","WRITE")
 ;;=D:Y<1 EN^DDIOL("** DISTRIBUTED BY VA FILEMAN **","","?35")
 ;;^DD(.44,0,"IX","B",.44,.01)
 ;;=
 ;;^DD(.44,0,"IX","C",.441,.01)
 ;;=
 ;;^DD(.44,0,"NM","FOREIGN FORMAT")
 ;;=
 ;;^DD(.44,0,"PT",.4,105)
 ;;=
 ;;^DD(.44,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(.44,.01,1,0)
 ;;=^.1
 ;;^DD(.44,.01,1,1,0)
 ;;=.44^B
 ;;^DD(.44,.01,1,1,1)
 ;;=S ^DIST(.44,"B",$E(X,1,30),DA)=""
 ;;^DD(.44,.01,1,1,2)
 ;;=K ^DIST(.44,"B",$E(X,1,30),DA)
 ;;^DD(.44,.01,3)
 ;;=Name must be 3-30 characters in length, not starting with punctuation.
 ;;^DD(.44,.01,21,0)
 ;;=^^1^1^2920914^
 ;;^DD(.44,.01,21,1,0)
 ;;=This field identifies the format used by the non-VA FileMan application.
 ;;^DD(.44,.01,"DEL",1,0)
 ;;=I DA<1
 ;;^DD(.44,.01,"DT")
 ;;=2920914
 ;;^DD(.44,1,0)
 ;;=FIELD DELIMITER^FX^^0;2^K:$L(X)>15!($L(X)<1)!'((X?1AP.E)!(X?3N)!(X?3N1","3N)!(X?3N1","3N1","3N)!(X?3N1","3N1","3N1","3N)) X
 ;;^DD(.44,1,3)
 ;;=Answer must be 1-15 characters in length.
 ;;^DD(.44,1,21,0)
 ;;=^^10^10^2921028^
 ;;^DD(.44,1,21,1,0)
 ;;=Contents of the field delimiter is output between each field.  Depending
 ;;^DD(.44,1,21,2,0)
 ;;=on the contents of the SEND LAST FIELD DELIMITER? field, the delimiter may
 ;;^DD(.44,1,21,3,0)
 ;;=be output after the last field, too. Identify the delimiter either by 1-15
 ;;^DD(.44,1,21,4,0)
 ;;=characters not beginning with a number or by the ASCII value of the
 ;;^DD(.44,1,21,5,0)
 ;;=delimiter.  When specifying the ASCII value, use 3 numbers (e.g., '009'
 ;;^DD(.44,1,21,6,0)
 ;;=for ASCII 9).  Up to four ASCII-character values can be specified,
 ;;^DD(.44,1,21,7,0)
 ;;=separated by commas.
 ;;^DD(.44,1,21,8,0)
 ;;= 
 ;;^DD(.44,1,21,9,0)
 ;;=If 'Ask' is entered, the user will be prompted for the field delimiter
 ;;^DD(.44,1,21,10,0)
 ;;=when creating the EXPORT template.
 ;;^DD(.44,1,"DT")
 ;;=2920914
 ;;^DD(.44,2,0)
 ;;=RECORD DELIMITER^F^^0;3^K:$L(X)>15!($L(X)<1)!'((X?1AP.E)!(X?3N)!(X?3N1","3N)!(X?3N1","3N1","3N)!(X?3N1","3N1","3N1","3N)) X
 ;;^DD(.44,2,3)
 ;;=Answer must be 1-15 characters in length.
 ;;^DD(.44,2,21,0)
 ;;=^^8^8^2921026^
 ;;^DD(.44,2,21,1,0)
 ;;=Contents of the record delimiter is output after each record.  Identify
 ;;^DD(.44,2,21,2,0)
 ;;=the delimiter either by 1-15 characters not beginning with a number or by
 ;;^DD(.44,2,21,3,0)
 ;;=the ASCII value of the delimiter.  When specifying the ASCII value, use 3
 ;;^DD(.44,2,21,4,0)
 ;;=numbers (e.g., '009' for ASCII 9).  Up to four ASCII-character values can
 ;;^DD(.44,2,21,5,0)
 ;;=be specified, separated by commas.
 ;;^DD(.44,2,21,6,0)
 ;;= 
 ;;^DD(.44,2,21,7,0)
 ;;=If 'Ask' is entered, the user is prompted for the record delimiter when
 ;;^DD(.44,2,21,8,0)
 ;;=creating the EXPORT template.
 ;;^DD(.44,2,"DT")
 ;;=2920914
 ;;^DD(.44,3,0)
 ;;=LINE CONTINUATION CHARACTER^F^^0;4^K:$L(X)>15!($L(X)<1) X
 ;;^DD(.44,3,3)
 ;;=Answer must be 1-15 characters in length.
 ;;^DD(.44,3,21,0)
 ;;=^^1^1^2921028^
 ;;^DD(.44,3,21,1,0)
 ;;=Not used yet.
 ;;^DD(.44,3,"DT")
 ;;=2920828
 ;;^DD(.44,4,0)
 ;;=LINE CONTINUATION LOCATION^S^e:END OF LINE;b:BEGINNING OF LINE;^0;5^Q
 ;;^DD(.44,4,21,0)
 ;;=^^1^1^2920917^
 ;;^DD(.44,4,21,1,0)
 ;;=Not used yet.
 ;;^DD(.44,4,"DT")
 ;;=2920828
 ;;^DD(.44,5,0)
 ;;=RECORD LENGTH FIXED?^S^1:YES;0:NO;^0;6^Q
 ;;^DD(.44,5,21,0)
 ;;=^^3^3^2920917^
 ;;^DD(.44,5,21,1,0)
 ;;=Enter YES if the fields will be fixed length causing a fixed length record
 ;;^DD(.44,5,21,2,0)
 ;;=to be created.  When the EXPORT template is created, the user is prompted
 ;;^DD(.44,5,21,3,0)
 ;;=for the length of each field in the TARGET file.
 ;;^DD(.44,5,"DT")
 ;;=2920828
 ;;^DD(.44,6,0)
 ;;=NEED FOREIGN FIELD NAMES?^S^1:YES;0:NO;^0;7^Q
 ;;^DD(.44,6,21,0)
 ;;=^^3^3^2921013^
 ;;^DD(.44,6,21,1,0)
 ;;=Answer YES if it is necessary to save the field names from the foreign
 ;;^DD(.44,6,21,2,0)
 ;;=file in the export file.  The user will be prompted for the names when the
 ;;^DD(.44,6,21,3,0)
 ;;=EXPORT template is created.
 ;;^DD(.44,6,"DT")
 ;;=2920828
 ;;^DD(.44,7,0)
 ;;=MAXIMUM OUTPUT LENGTH^NJ4,0^^0;8^K:+X'=X!(X>9999)!(X<0)!(X?.E1"."1N.N) X
 ;;^DD(.44,7,3)
 ;;=Type a Number between 0 and 9999, 0 Decimal Digits
 ;;^DD(.44,7,21,0)
 ;;=^^7^7^2921026^
 ;;^DD(.44,7,21,1,0)
 ;;=The maximum length of a "line" of output; maximum number of characters
 ;;^DD(.44,7,21,2,0)
 ;;=before a LINE FEED is issued.  For most exports, this will be the maximum
 ;;^DD(.44,7,21,3,0)
 ;;=record length.
 ;;^DD(.44,7,21,4,0)
 ;;= 
