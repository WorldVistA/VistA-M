DG774PF ;WPW,MHH ; HL7 LOGICAL LINK UPDATE; 21-AUG-2008
 ;DG;5.3;Registration;**791**;13-AUG-1993;Build 3
 ;
 ;
EN ;1-time run routine
 ;
 ;PURPOSE Update "VIC NCMD" Logical Link for TCP/IP transmissions.  The
 ;        current definition has a hard coded IP address.  The existing IP
 ;        will be removed and a DNS domain name will be added in HLCS(870).
 ;
 N TEST,FILE,DATA,DGENDA,RETURN,ERROR
 ;
 S U=$G(U,"^")  ;set default value to ^, if it doesn't exist
 S TEST=$S($P($$PARAM^HLCS2,U,3)="P":0,1:1)          ; Test=1, Production=0
 S FILE=870                                          ; Logical Link file
 S DATA(.01)="VIC NCMD"                              ; Logical Link name; This is the value to file in DGENDBS
 S DATA(.08)=$S(TEST:"",1:"VETERANS1.ONEVA.VA.GOV")  ; DNS Domain Name
 S DATA(400.01)=""                                   ; TCP/IP Address
 S DGENDA=$O(^HLCS(FILE,"B",DATA(.01),0))            ; "VIC NCMD"; Logical Link IEN; cross reference
 I DGENDA="" Q ""                       ; If "VIC NCMD" not defined quit.
 ;
 ;DGENDBS;File data into an existing record
 S RETURN=$$UPD^DGENDBS(FILE,.DGENDA,.DATA,.ERROR)
 S:ERROR]""!(+RETURN=0) RETURN=-1_"^"_ERROR
 ;
 Q
