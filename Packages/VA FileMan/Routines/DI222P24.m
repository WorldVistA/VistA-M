DI222P24 ;OAKFO/REM - Post Install for patch 24 ; FEB 05, 2023@13:20:47
 ;;22.2;VA FileMan;**24**;Jan 05, 2016;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; clean up ^DIST(1.2,IEN,0) nodes
 N NAME,IEN
 S NAME="" F  S NAME=$O(^DIST(1.2,"B",NAME)) Q:NAME=""  D 
 .S IEN=0 F  S IEN=$O(^DIST(1.2,"B",NAME,IEN)) Q:IEN=""  D 
 ..I ^DIST(1.2,IEN,0)'=NAME S ^DIST(1.2,IEN,0)=NAME
 Q
