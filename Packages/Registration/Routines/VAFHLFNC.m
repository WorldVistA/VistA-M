VAFHLFNC ;ALB/MLI - Generic functions for MAS HL7 Interface ; 27 Feb 93
 ;;5.3;Registration;**33,122**;Aug 13, 1993
 ;
 ; This routine contains generic MAS functions used to interface with
 ; the DHCP HL7 package
 ;
ADDR(VAFADDR,VAFCOUNT) ; returns address in HL7 format
 ;
 ; NOTE:  THIS MAY BE REPLACED WITH AN HL7 CALL IN THE FUTURE
 ;
 ;  Input - VAFADDR as address in format:
 ;                line1^line2^line3^city^state^zip
 ;          VAFCOUNT as internal value of county (optional)
 ;
 ;      ****Also assumes all HL7 variables returned from****
 ;          INIT^HLTRANS are defined
 ;
 ; Output - HL7 formated Address_HLFS_County Code (if requested)
 ;
 N X,Y
 S X=$E(HLECH) ; first component separator
 S $P(Y,X,1)=$P(VAFADDR,"^",1) ; line 1
 S $P(Y,X,2)=$P(VAFADDR,"^",2)_$S($P(VAFADDR,"^",3)]"":" "_$P(VAFADDR,"^",3),1:"") ; lines 2 & 3
 S $P(Y,X,3)=$P(VAFADDR,"^",4),$P(Y,X,5)=$P(VAFADDR,"^",6) ; city,zip
 S $P(Y,X,4)=$P($G(^DIC(5,+$P(VAFADDR,"^",5),0)),"^",2) ; state abbr
 I $G(VAFCOUNT) D  ; county
 .S $P(Y,HLFS,2)=$P($G(^DIC(5,+$P(VAFADDR,"^",5),1,+$G(VAFCOUNT),0)),"^",3)
 .I $P(Y,HLFS,2)']"" S $P(Y,HLFS,2)=HLQ
 I $P(Y,HLFS,1)=(X_X_X_X) S $P(Y,HLFS,1)=HLQ ; if no data...only component separator
 Q Y
 ;
 ;
INS(DFN,VAFDT) ; call to see if pt has active insurance
 ;
 ;  Input - DFN as internal entry number of PATIENT file
 ;          VAFDT [optional] as date to compute ins coverage for
 ;
 ; Output - 1 if yes, 0 if no
 ;
INSQ Q $$INSURED^IBCNS1(DFN,$G(VAFDT))
 ;
 ;
YN(X) ; extrinsic function to convert YES/NO responses to 1/0
 ;           (format of MAS-HL7 table VA01)
 ;
 ;  Input - X as value of DHCP yes/no field
 ;
 ; Output - 1 if yes, 0 if no, or "" otherwise
 ;
 S X=$TR($E(X),"Yy1Nn0","111000")
 Q $S(X=1:X,X=0:0,1:HLQ)
 ;
STATION(INSTPTR) ;
 ;Description: Returns the facility number, including the suffix.
 ;
 ;Input:
 ;  INSTPTR - ien, record in the INSTITUTION file
 ;Output:
 ;  Function value - If unsuccessful, returns NULL, otherwise the facility number, including suffix
 ;
 Q:'$G(INSTPTR) ""
 Q $P($G(^DIC(4,INSTPTR,99)),"^",1)
