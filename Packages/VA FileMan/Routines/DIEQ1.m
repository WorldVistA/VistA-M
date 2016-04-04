DIEQ1 ;SFISC/XAK,YJK-HELP WRITE ;5/27/94  7:29 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
T S A1="T" F DG=2:1 S X=$T(T+DG) Q:X=""  S DST=$E(X,4,99) D DS^DIEQ
 K A1,DST Q
 ;;If you simply enter a name then the system will search each of
 ;;the above files for the name you have entered. If a match is
 ;;found the system will ask you if it is the entry that you desire.
 ;;
 ;;However, if you know the file the entry should be in, then you can
 ;;speed processing by using the following syntax to select an entry:
 ;;      <Prefix>.<entry name>
 ;;                or
 ;;      <Message>.<entry name>
 ;;                or
 ;;      <File Name>.<entry name>
 ;;
 ;;Also, you do NOT need to enter the entire file name or message
 ;;to direct the look up. Using the first few characters will suffice.
