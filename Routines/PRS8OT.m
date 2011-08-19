PRS8OT ;HISC/MRL-DECOMPOSITION, SCHEDULED OT ;3/26/93  12:34
 ;;4.0;PAID;;Sep 21, 1995
 ;
 ;This routine is used to determine whether OT/CT was scheduled
 ;in advance of the workweek for the date being processed.  OT/CT
 ;is considered scheduled in advance of the workweek if:
 ;
 ;   o   There is a 1098 request on file in file 458.2 for the
 ;       date being processed, and:
 ;   o   The request was made before the workweek on which the OT/
 ;       CT is worked, e.g., the ENTRY DATE/TIME was before the
 ;       SUNDAY preceeding the date worked, AND:
 ;   o   The request WAS NOT cancelled or disapproved.  Requests
 ;       which were scheduled but pending approval are, for this
 ;       purpose, considered to be approved unless cancelled or
 ;       disapproved.
 ;   o   In addition, once the above three criteria are met, the
 ;       T&L on which the OT/CT was worked must be one where
 ;       premium pay is usually paid.
 ;
 ;Called by Routines:  PRS8PP
 ;
 S OK=0,X=$P(PPD,"^",DAY) D ^%DT ;get today's date as Y
 S (X,NDD)=Y D H^%DTC ;get day number
 S X1=NDD,X2="-"_(%Y+1) D C^%DTC S NDD(1)=X ;get previous Saturday
 F ND=0:0 S ND=$O(^PRST(458.2,"AD",DFN,NDD,ND)) Q:ND'>0!(OK)  D
 .S X=^PRST(458.2,ND,0) ;zeroth node of the ot request file
 .I "DX"[$P(X,"^",8) Q  ;disapproved or cancelled
 .S X1=$P(X,"^",12) Q:'X1  ;no ENTRY DATE
 .I X1'>NDD(1) S OK=1,X=$P(X,"^",9)
 S ND=OK G END:'ND
 I $L(X)=3 D  ;check T&L for premium ok
 .S X=$O(^PRST(455.5,"B",X,0)) Q:'X
 .S X=$P($G(^PRST(455.5,+X,0)),"^",7)
 .S ND=+X ;reset ok to premium status
 ;
END ; --- done with this process
 K NDD,OK,X,X1,X2 Q
