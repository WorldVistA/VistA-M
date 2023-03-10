DGADDVAL ;ALB/JAM - UAM Address Validation ;28 May 2020  10:33 AM
 ;;5.3;Registration;**1014,1040**;Aug 13, 1993;Build 15
 ;
EN(DGINPUT,DGTYPE) ; Main entry point 
 ; Input:  DGINPUT (Required, pass by reference) - Array containing the address to be validated
 ;         DGTYPE (optional) - Address Type: "R"-Residential "C"-Confidential "P"-Permanent (default)
 ; Output: DGINPUT (Pass by reference) - Array will contain the address accepted by the user
 ; Return: 0 - error has been encountered
 ;         1 - validation is completed and DGINPUT contains the accepted address
 ;
 ;  Format of DGINPUT array
 ;   DGINPUT(field#)=VALUE
 ;
 ;  Note:  For Residential and Perm Addresses:
 ;     State VALUE = "STATENAME^STATECODE"
 ;     Country VALUE = "COUNTRY^COUNTRYCODE"
 ;     County VALUE = "COUNTY^COUNTYCODE
 ;         For Confidential Addresses:
 ;     State VALUE = "STATECODE^STATENAME"
 ;     Country VALUE = "COUNTRYCODE^COUNTRY"
 ;     County VALUE = "COUNTYCODE^COUNTY
 ;
 N DGCNT,DGADDR,DGFLDS,DGFORGN,DGCTRYCD,DGSTR,DGX,DGRECS,DGSELADD,DGSTAT,DGSTATECD,DGTMOT
 ;
 ; Set up string of address field numbers - Format:
 ;    "AddressLine1,AddressLine2,AddressLine3,City,State,County,Zip,Province,PostalCode^Country"
 S DGFLDS=".111,.112,.113,.114,.115,.117,.1112,.1171,.1172,.1173"  ; Permanent Address fields
 I $G(DGTYPE)="R" S DGFLDS=".1151,.1152,.1153,.1154,.1155,.1157,.1156,.11571,.11572,.11573"  ; Residential address fields
 I $G(DGTYPE)="C" S DGFLDS=".1411,.1412,.1413,.1414,.1415,.14111,.1416,.14114,.14115,.14116"  ; Confidential address fields
 ;
 ; All addresses are placed in the DGADDR array for user selection
 ; First address displayed is the address DGINPUT
 S DGCNT=1
 M DGADDR(DGCNT)=DGINPUT
 ; Normalize the Country and State entries for Conf address in DGADDR so the format is the same for all addresses in DGADDR array
 I DGTYPE="C" D
 . ; State may not be defined
 . I $D(DGADDR(1,$P(DGFLDS,",",5))) S DGX=DGADDR(1,$P(DGFLDS,",",5)),DGADDR(1,$P(DGFLDS,",",5))=$P(DGX,"^",2)_"^"_$P(DGX,"^",1)
 . S DGX=DGADDR(1,$P(DGFLDS,",",10)),DGADDR(1,$P(DGFLDS,",",10))=$P(DGX,"^",2)_"^"_$P(DGX,"^",1)
 ; Capture the State code passed in
 S DGCTRYCD=$P(DGADDR(1,$P(DGFLDS,",",10)),"^",2)
 ; Get flag for domestic/foreign address
 S DGFORGN=0
 S DGFORGN=$$FORIEN^DGADDUTL(DGCTRYCD)
 I 'DGFORGN S DGSTATECD=$P(DGADDR(1,$P(DGFLDS,",",5)),"^",2)
 ;
 ; Call the validation service
 S DGSTAT=$$EN^DGUAMWS(.DGADDR,DGFLDS,DGFORGN)  ; DGADDR is updated with address validation results
 I +DGSTAT=0 QUIT DGSTAT
 ; get total records returned. Subtract one for the original.
 S DGRECS=$O(DGADDR(""),-1)-1
 F DGX=1:1:DGRECS D
 . S DGCNT=DGCNT+1
 . ; Store in this array entry the same country that was passed in
 . S DGADDR(DGCNT,$P(DGFLDS,",",10))=DGADDR(1,$P(DGFLDS,",",10))
 . I 'DGFORGN D
 . . ; Store the same county that was passed in
 . . S DGADDR(DGCNT,$P(DGFLDS,",",6))=DGADDR(1,$P(DGFLDS,",",6))
 ;
 ; Call DGEN ADDR VAL list to show addresses and allow user selection
 S DGADDR=DGCNT
 ; DG*5.3*1040; Add DTMOUT param for Timeout in the subroutine
 D EN^DGADDLST(DFN,DGFLDS,.DGADDR,.DGSELADD,.DGTMOT)
 ; DG*5.3*1040; If DGTMOT set, return -1 to flag that a timeout occurred
 I +$G(DGTMOT) Q -1
 ; Move selected address into DGINPUT array
 M DGINPUT=DGSELADD
 ; Put the State and Country fields back in DGINPUT to the format used for Conf addresses
 I DGTYPE="C" D
 . I $D(DGADDR(1,$P(DGFLDS,",",5))) D
 . . S DGX=DGINPUT($P(DGFLDS,",",5)),DGINPUT($P(DGFLDS,",",5))=$P(DGX,"^",2)_"^"_$P(DGX,"^",1)
 . . ; If the State code is empty, put the original State code in the array - Confidential Address needs the State code to file
 . . I $P(DGINPUT($P(DGFLDS,",",5)),"^",1)="" S $P(DGINPUT($P(DGFLDS,",",5)),"^",1)=DGSTATECD
 . S DGX=DGINPUT($P(DGFLDS,",",10)),DGINPUT($P(DGFLDS,",",10))=$P(DGX,"^",2)_"^"_$P(DGX,"^",1)
 Q 1
