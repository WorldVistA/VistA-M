XIPUTIL ;ALB/BRM,OIFO/SO - POSTAL AND COUNTY CODE APIS ;2:16 PM  10 Jul 2003
 ;;8.0;KERNEL;**246,292**;Jul 10, 1995
 ;
 ; this routine holds APIs used to extract data from the
 ; County Code (#5.13) and Postal Code (#5.12) files.
 ;
 Q
 ;
POSTAL(PCODE,XIP) ; return all data for the Prefered City for a postal code
 ;
 ; INPUT
 ;     PCODE - Postal Code for which to return the data
 ;
 ; OUTPUT
 ;     XIP("POSTAL CODE") - the value used to lookup postal data
 ;     XIP("CITY") - the city that the USPS assigned to this PCODE
 ;     XIP("COUNTY") - The county associated with this PCODE
 ;     XIP("COUNTY POINTER") - pointer to the county in file #5.13
 ;     XIP("STATE") - The state associated with this PCODE
 ;     XIP("STATE POINTER") - pointer to the state in file #5
 ;     XIP("CITY KEY") - USPS's assigned city key
 ;     XIP("PREFERRED CITY KEY") - USPS's Prefered (DEFAULT) city key
 ;     XIP("CITY ABBREVIATION") - USPS's assigned abbreviation
 ;     XIP("UNIQUE KEY") - a unique look-up value
 ;     XIP("FIPS CODE") - 5 digit FIPS code associated with the county
 ;     XIP("ERROR") - returns errors encountered during look-up
 ;
 I $G(PCODE)']"" S XIP("ERROR")="Missing Input Parameter" Q
 N X,ERR512,XIP512,XIPTMP,X,Y,DA,D,DIQ,DIC,IENS,XIPERR,LPCODE
 ; initialize the XIP data array
 D INITXIP(.XIP)
 ; initialize additional XIP subscripts
 F X="CITY","COUNTY POINTER","POSTAL CODE","CITY KEY","PREFERRED CITY KEY","CITY ABBREVIATION","UNIQUE KEY" S XIP(X)=""
 K XIP("INACTIVE DATE") ;Inactive dates are screen out
 ; if input parameter (PCODE) is less than 5 characters, quit w/error
 I $L(PCODE)<5 S XIP("ERROR")="PCODE entered was less than 5 characters." Q
 S (LPCODE,XIP("POSTAL CODE"))=$E(PCODE,1,5)
 S XIP512=0
 D
 . N DIERR,XIPERR,FIELDS,I,D512,S512
 . S FIELDS="@;5;6"
 . S S512="I $P(^(0),U,5)=""""" ; Screen out INACTIVE Zip Codes
 . D LIST^DIC(5.12,"",FIELDS,"P","","",LPCODE,"B",S512,"","D512","XIPERR")
 . Q:$D(DIERR)
 . S I=0
 . F  S I=$O(D512("DILIST",I)) Q:'I  D
 .. I $P(D512("DILIST",I,0),"^",2)=$P(D512("DILIST",I,0),"^",3) S XIP512=$P(D512("DILIST",I,0),"^",1)
 I 'XIP512 S XIP("ERROR")="Postal Code cannot be found" Q
 N X
 S X=^XIP(5.12,XIP512,0)
 S XIP("CITY")=$P(X,"^",2)
 S XIP("COUNTY POINTER")=$P(X,"^",3)
 S XIP("STATE POINTER")=$P(X,"^",4)
 S XIP("INACTIVE DATE")=$P(X,"^",5)
 S XIP("CITY KEY")=$P(X,"^",6)
 S XIP("PREFERRED CITY KEY")=$P(X,"^",7)
 S XIP("CITY ABBREVIATION")=$P(X,"^",8)
 S XIP("UNIQUE KEY")=$P(X,"^",9)
 S XIP("STATE")=$P($G(^DIC(5,+XIP("STATE POINTER"),0)),"^")
 S XIP("COUNTY")=$P($G(^XIP(5.13,+XIP("COUNTY POINTER"),0)),"^",2)
 S XIP("FIPS CODE")=$P($G(^XIP(5.13,+XIP("COUNTY POINTER"),0)),"^")
 Q
 ;
INITXIP(ARRY) ;initialize the county code array
 F X="COUNTY","STATE","STATE POINTER","INACTIVE DATE","FIPS CODE" S ARRY(X)=""
 Q
 ;
FIPS(PCODE) ;API to return the FIPS code associated with the postal code
 ;
 ;INPUT:
 ;     PCODE - Postal code
 ;OUTPUT:
 ;      5 digit FIPS code associated with the entered postal code
 ;   or "0^error message" if a processing error occurs
 ;
 Q:PCODE']"" "0^Missing Input Parameter"
 Q:$L(PCODE)<5 "0^Input Parameter is less than 5 characters"
 ;
 N IEN512,IEN513,FIPS
 I $L(PCODE)>5 S PCODE=$E(PCODE,1,5)
 S IEN512=0
 D
 . N DIERR,XIPERR,FIELDS,XIPTMP,I
 . S FIELDS="@;5;6"
 . D LIST^DIC(5.12,"",FIELDS,"P","","",PCODE,"","","","XIPTMP","XIPERR")
 . Q:$D(DIERR)
 . S I=0
 . F  S I=$O(XIPTMP("DILIST",I)) Q:'I  D
 .. I $P(XIPTMP("DILIST",I,0),"^",2)=$P(XIPTMP("DILIST",I,0),"^",3) S IEN512=$P(XIPTMP("DILIST",I,0),"^",1)
 Q:'IEN512 "0^Postal Code not found"
 S IEN513=$P($G(^XIP(5.12,IEN512,0)),"^",3)
 Q:'IEN513 "0^County cannot be determined"
 S FIPS=$$GET1^DIQ(5.13,IEN513_",",.01)
 Q:FIPS FIPS
 Q "0^FIPS Code cannot be determined"
 ;
CCODE(FIPS,XIPC) ; return all data related to a FIPS county code
 ;
 ; INPUT
 ;     FIPS - 5 digit FIPS County Code for which to return the data
 ;
 ; OUTPUT
 ;     XIPC("FIPS CODE") - 5 digit FIPS county code
 ;     XIPC("COUNTY") - The county associated with this FIPS code
 ;     XIPC("STATE") - The state associated with this FIPS code
 ;     XIPC("STATE POINTER") - pointer to the state in file #5
 ;     XIPC("INACTIVE DATE") - date this FIPS code was inactivated
 ;     XIPC("LATITUDE") - The estimated Latitude of the county
 ;     XIPC("LONGITUDE") - The estimated Longitude of the county
 ;     XIPC("ERROR") - returns errors encountered during look-up
 ;
 I $G(FIPS)']"" S XIPC("ERROR")="Missing Input Parameter" Q
 ;
 N X,XIPCTMP,XIP513,ERR513,IENS
 ; initialize the XIPC data array
 D INITXIP(.XIPC)
 S XIPC("LATITUDE")="",XIPC("LONGITUDE")=""
 S XIPC("FIPS CODE")=FIPS
 ; if input parameter (FIPS) is less than 5 characters, quit w/error
 I $G(FIPS)'?5N S XIPC("ERROR")="FIPS Code input parameter is not valid."  Q
 ;
 S XIP513=0
 D
 . N DIERR,XIPERR
 . S XIP513=$$FIND1^DIC(5.13,,"BOX",FIPS,"","","XIPERR")
 I 'XIP513 D  Q:'XIP513
 .S XIP513=$O(^XIP(5.13,"B",FIPS,""))
 .I XIP513 S XIPC("ERROR")="Multiple entries exist for FIPS code" Q
 .S XIPC("ERROR")="Entered FIPS Code could not be found"
 D
 . N DIERR
 . D GETS^DIQ(5.13,XIP513_",","**","IE","XIPCTMP","ERR513")
 I $D(ERR513) S XIPC("ERROR")="Error occurred while retrieving County Code data" Q
 ;put data into array
 S XIP513=XIP513_","
 S XIPC("COUNTY")=$G(XIPCTMP(5.13,XIP513,1,"E"))
 S XIPC("STATE")=$G(XIPCTMP(5.13,XIP513,2,"E"))
 S XIPC("STATE POINTER")=$G(XIPCTMP(5.13,XIP513,2,"I"))
 S XIPC("INACTIVE DATE")=$G(XIPCTMP(5.13,XIP513,3,"I"))
 S XIPC("LATITUDE")=$G(XIPCTMP(5.13,XIP513,4,"E"))
 S XIPC("LONGITUDE")=$G(XIPCTMP(5.13,XIP513,5,"E"))
 Q
FIPSCHK(FIPS) ; does this FIPS code exist?
 Q:$G(FIPS)']"" 0
 Q:$L(FIPS)<5 0
 Q +$O(^XIP(5.13,"B",FIPS,""))
 ;
POSTALB(PCODE,XIP) ; return all data related to a postal code
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
 ;     XIP(n,"INACTIVE DATE") - date on which this PCODE was inactivated
 ;     XIP(n"CITY KEY") - USPS's assigned city key
 ;     XIP(n,"PREFERRED CITY KEY") - USPS's Preferred (DEFAULT) city key
 ;     XIP(n,"CITY ABBREVIATION") - USPS's assigned abbreviation
 ;     XIP(n,"UNIQUE KEY") - a unique look-up value
 ;     XIP(n,"FIPS CODE") - 5 digit FIPS code associated with the county
 ;     XIP("ERROR") - returns errors encountered during look-up
 ;
 S XIP=0
 I $G(PCODE)']"" S XIP("ERROR")="Missing Input Parameter" Q
 N X,ERR512,XIP512,XIPTMP,X,Y,DA,D,DIQ,DIC,IENS,XIPERR,LPCODE
 ; if input parameter (PCODE) is less than 5 characters, quit w/error
 I $L(PCODE)<5 S XIP("ERROR")="PCODE entered was less than 5 characters." Q
 ;
 S LPCODE=$E(PCODE,1,5)
 D PBC^XIPUTIL1 ; Continue processing
 Q
