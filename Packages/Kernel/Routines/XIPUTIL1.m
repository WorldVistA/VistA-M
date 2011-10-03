XIPUTIL1 ;OIFO/SO- CONTINUATION OF ROUTINE XIPUTIL;2:15 PM  10 Jul 2003
 ;;8.0;KERNEL;**292**;Jul 10, 1995
 ; Continuation of API POSTALB
 Q
 ;
PBC ; POSTALB's Continuation Entry Point
 ;
 ; INPUT
 ;     PCODE - Postal Code for which to return the data
 ;
 ; OUTPUT
 ;     XIP(n) - the number of primary subscripts
 ;     XIP(n,"POSTAL CODE") - the value used to lookup postal data
 ;     XIP(n,"CITY") - the city that the USPS assigned to this PCODE
 ;     XIP(n,"COUNTY") - The county associated with this PCODE
 ;     XIP(n,"COUNTY POINTER") - pointer to the county in file #5.13
 ;     XIP(n,"STATE") - The state associated with this PCODE
 ;     XIP(n,"STATE POINTER") - pointer to the state in file #5
 ;     XIP(n"CITY KEY") - USPS's assigned city key
 ;     XIP(n,"PREFERRED CITY KEY") - USPS's Preferred (DEFAULT) city key
 ;     XIP(n,"CITY ABBREVIATION") - USPS's assigned abbreviation
 ;     XIP(n,"UNIQUE KEY") - a unique look-up value
 ;     XIP(n,"FIPS CODE") - 5 digit FIPS code associated with the county
 ;     XIP("ERROR") - returns errors encountered during look-up
 ;
 N D512,XIPERR
 S XIP=0
 D
 . N DIERR,FIELDS,S512
 . S FIELDS="@;.01"
 . S S512="I $P(^(0),U,5)=""""" ; Screen out INACTIVE Zip Codes
 . D LIST^DIC(5.12,"",FIELDS,"P","","",LPCODE,"B",S512,"","D512","XIPERR")
 . Q
 I $D(XIPERR) S XIP("ERROR")=XIPERR("DIERR",1,"TEXT",1) Q
 I +D512("DILIST",0)=0 S XIP("ERROR")="Postal Code cannot be found" Q
 N I,I1
 S I=0
 F I1=0:1 S I=$O(D512("DILIST",I)) Q:'I  D
 . N X
 . S XIP512=+$P(D512("DILIST",I,0),"^")
 . S X=^XIP(5.12,XIP512,0)
 . S XIP(I,"POSTAL CODE")=LPCODE
 . S XIP(I,"CITY")=$P(X,"^",2)
 . I $P(X,"^",6)=$P(X,"^",7) S XIP(I,"CITY")=XIP(I,"CITY")_"*" ; Indicate this is the DEFAULT city
 . S XIP(I,"COUNTY POINTER")=$P(X,"^",3)
 . S XIP(I,"STATE POINTER")=$P(X,"^",4)
 . S XIP(I,"CITY KEY")=$P(X,"^",6)
 . S XIP(I,"PREFERRED CITY KEY")=$P(X,"^",7)
 . S XIP(I,"CITY ABBREVIATION")=$P(X,"^",8)
 . S XIP(I,"UNIQUE KEY")=$P(X,"^",9)
 . S XIP(I,"STATE")=$P($G(^DIC(5,+XIP(I,"STATE POINTER"),0)),"^")
 . S XIP(I,"COUNTY")=$P($G(^XIP(5.13,+XIP(I,"COUNTY POINTER"),0)),"^",2)
 . S XIP(I,"FIPS CODE")=$P($G(^XIP(5.13,+XIP(I,"COUNTY POINTER"),0)),"^")
 S XIP=I1
 Q
