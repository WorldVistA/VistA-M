DGRUADT0 ;ALB/GRR - INTEGRATED SITE PROCESSING FOR RAI/MDS ADT MESSAGING; 7-8-99
 ;;5.3;Registration;**190,312,328**;Aug 13, 1993
 ;
MV4(DFN,DGPMA) ;
 N VAIP,DGWDP,DGWDA,DGPDIV,DGCDIV,DGINTEG
 ;
 ; Variables
 ;   VAIP  - Patient Data array from lookup utility
 ;   DGWDP - Ward prior to the transfer
 ;   DGWDA - Ward after the transfer
 ;   DGPDIV - Division of Ward prior to transfer
 ;   DGCDIV - Division of Ward after transfer
 ;   DGINTEG - Integrated Site flag
 ;             0 - Not Integrated Site
 ;             1 - Integrated Site, Single Database
 ;             2 - Integrated Site, Multiple Database
 ;  
 ; Input
 ;   DFN   - IEN to Patient File #2
 ;   DGPMA - 0 node of patient movement file #405
 ; 
 ; Get before and after wards
 S VAIP("D")="LAST",VAIP("M")=1
 D IN5^VADPT
 ;
 ; Get ward prior to transfer, if no movement, then get the admission ward
 S DGWDP=+VAIP(15,4)
 S:'DGWDP DGWDP=+VAIP(13,4)
 ;
 ; Get ward after transfer
 S DGWDA=+VAIP(5)
 ;
 ;Get Division prior to transfer
 S DGPDIV=+$$GETDIV^DGRUUTL1(DGWDP)
 ;
 ;Get Ien of prior Movement
 S DGPPMDA=$S($G(DGPMP)]"":$O(^DGPM("B",+DGPMP,0)),$G(DGPM0)]"":$O(^DGPM("B",+DGPM0,0)),1:"")
 ;
 ;Get Division after transfer
 S DGCDIV=+$$GETDIV^DGRUUTL1(DGWDA)
 ;
 ;Get Integration flag
 S DGINTEG=$$GET1^DIQ(43,1,391.705,"I")
 ;
 ; If Transfer from MDS to MDS ward, send A02 transfer to COTS
 I $$CHKWARD^DGRUUTL(DGWDP)&($$CHKWARD^DGRUUTL(DGWDA)) D
 . I DGINTEG=1!(DGINTEG=2),DGPDIV'=DGCDIV D
 . . ;If Integrated Database and Wards are in different divisions
 . . ;Need to create an Admit to new Accu-Max Entity/Box
 . . ;Need to create Discharge for old Accu-Max Entity/Box
 . . D BLDMSG^DGRUADT1(DFN,"A03",DGPMDA,+DGPMA,DGWDP)
 . . D BLDMSG^DGRUADT1(DFN,"A01",DGPMDA,+DGPMA,DGWDA)
 . E  D BLDMSG^DGRUADT1(DFN,"A02",DGPMDA,+DGPMA,DGWDA)
 ;
 ; If Transfer from MDS to non-MDS ward, send A03 discharge to COTS
 I $$CHKWARD^DGRUUTL(DGWDP)&('$$CHKWARD^DGRUUTL(DGWDA)) D
 . D BLDMSG^DGRUADT1(DFN,"A03",DGPMDA,+DGPMA,DGWDA)
 ;
 ; If Transfer from non-MDS to MDS ward, send A01 admission to COTS
 I '$$CHKWARD^DGRUUTL(DGWDP)&($$CHKWARD^DGRUUTL(DGWDA)) D
 . D BLDMSG^DGRUADT1(DFN,"A01",DGPMDA,+DGPMA,DGWDA)
 ;
 ; If transfer from non-MDS to non-MDS ward: Do Nothing
 Q
 ;
MV40(DFN) ; Transfer TO ASIH (VAH)
 N NHCUADMT,NHCUNODE,PSUEDO,PSUNODE
 ; Variables
 ;    NHCUADMT - admission IEN to NHCU
 ;    NHCUNODE - Movement entry for admission to NHCU
 ;    MEDADMT  - Admission to ASIH Medical ward
 ;    MEDNODE  - movement entry to medical ward
 ;    PSUEDO   - Psuedo transfer IEN
 ;    PSUNODE  - Psuedi discharge node
 ;
 ; Retrieve transfer movement
 S TRANSFER=$O(VAFH(2,0))
 S TRSNODE=VAFH(2,TRANSFER,"A")
 ;
 ; Retrieve admission movement from transfer
 S NHCUADMT=$P(TRSNODE,"^",14)
 S NHCUNODE=VAFH(1,NHCUADMT,"A")
 ;
 ; Retrieve the ward the patient was admitted to prior to psuedo discharge
 S DGWARD=+$P(NHCUNODE,"^",6)
 ; If the ward was flagged RAI, send discharge message to COTS.
 I $$CHKWARD^DGRUUTL(DGWARD) D
 . D BLDMSG^DGRUADT1(DFN,"A21",TRANSFER,$P(TRSNODE,"^"),DGWARD)
 . D ADDASIH^DGRUASIH(DFN,+TRSNODE) ;added 11/22/00 p-328
 Q
 ;
MV41(DFN) ; Discharge from ASIH
 N TRANSFER,TRSNODE,DGWARD
 ;
 ; Retrieve transfer
 S TRANSFER=$O(VAFH(2,0))
 S TRSNODE=VAFH(2,TRANSFER,"A")
 ;
 ; Retrieve ward transferred to from ASIH discharge
 S DGWARD=$P(TRSNODE,"^",6)
 ;
 I $$CHKWARD^DGRUUTL(DGWARD) D
 . D BLDMSG^DGRUADT1(DFN,"A22",TRANSFER,+TRSNODE,DGWARD)
 . D ADDRDT^DGRUASIH(DFN,+TRSNODE) ;added 11/22/00 p-328
 Q
 ;
CN40(DFN) ; Cancel TO ASIH admission
 N NHCUADMT,NHCUNODE,TRANSFER,TRSNODE,DGWARD
 ;
 ; Retrieve transfer movement
 S TRANSFER=$O(VAFH(2,0))
 S TRSNODE=VAFH(2,TRANSFER,"P")
 ;
 ; Retrieve admission movement from transfer
 S NHCUADMT=$P(TRSNODE,"^",14)
 S NHCUNODE=$G(VAFH(1,NHCUADMT,"P"))
 ;
 ; Retrieve ward patient admitted to prior to psuedo discharge
 S DGWARD=$S(NHCUNODE]"":+$P(NHCUNODE,"^",6),1:$P(DGPMP,"^",6))
 D BLDMSG^DGRUADT1(DFN,"A12",TRANSFER,$P(TRSNODE,"^"),DGWARD)
 D DELASIH^DGRUASIH(DFN,+TRSNODE) ;added 11/22/00 p-328
 Q
 ;
MV1238(DFN) ;Discharge type Death, if patient was ASIH, send A03 to COTS
 Q:'$D(DGPMAN)
 N DGOMDT,DGOWARD,DGOIEN
 S DGOMDT=+$G(DGPMAN) Q:DGOMDT'>0
 S DGOMDT=$O(^DGPM("APRD",DFN,DGOMDT),-1) Q:DGOMDT'>0
 S DGOIEN=$O(^DGPM("APRD",DFN,DGOMDT,0))
 S DGOWARD=$$GET1^DIQ(405,DGOIEN,".06","I") Q:DGOWARD=""
 Q:'$$CHKWARD^DGRUUTL(DGOWARD)
 S DGASIH=1
 D BLDMSG^DGRUADT1(DFN,"A03",DGOIEN,+DGPMA,DGOWARD)
 D ADDRDT^DGRUASIH(DFN,+DGPMA) ;added 11/22/00 p-328
 Q
 ;
