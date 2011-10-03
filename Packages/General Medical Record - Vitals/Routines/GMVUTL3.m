GMVUTL3 ;HOIFO/YH,FT-RPCBROKER UTILITY ROUTINE TO EXTRACT NURSING UNIT/ROOM-BED - 3 ;10/24/03  14:20
 ;;5.0;GEN. MED. REC. - VITALS;**3**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ;  #2692 - ^ORQPTQ1 calls         (controlled)
 ; #10061 - ^VADPT calls           (supported)
 ; #10099 - ^GMRADPT calls         (supported)
 ; 
 ; This routine supports the following IAs:
 ; #4350  - GMV ALLERGY RPC called at ALLERGY  (private)
 ;
PTINFO(RESULT,DFN,GMVDT) ; gets patient demographic and eligibility info
 ;RESULT=SSN^DOB^SEX AND AGE^ATTENDING^VETERAN^INTERNAL DATE/TIME
 ;       DECEASED^EXTERNAL DATE/TIME DECEASED
 D 1^VADPT,ELIG^VADPT
 S RESULT=$P($G(VADM(2)),"^",2)_"^"_$P($G(VADM(3)),"^",2)_"^"_$P($G(VADM(5)),"^",2)_", "_$P($G(VADM(4)),"^")_" years"_"^"_$P($G(VAIN(11)),"^",2)
 S RESULT=RESULT_"^"_$S(VAEL(4)=1:"YES",1:"NO")_"^^^^"
 S $P(RESULT,"^",8)=$P(VAIN(4),"^",2),$P(RESULT,"^",9)=$P(VAIN(5),"^")
 I VADM(6)>0 S $P(RESULT,"^",6)=$P(VADM(6),"^"),$P(RESULT,"^",7)=$P(VADM(6),"^",2)
 S $P(RESULT,"^",10)=VADM(1)
 N GMVSENS
 S GMVSENS=$$PTREC^GMVRPCP(DFN) ;check sensitvity of DOB and SSN 
 S $P(RESULT,U,1)=$P(GMVSENS,U,11) ;SSN
 S $P(RESULT,U,2)=$P(GMVSENS,U,10) ;DOB
 Q
TEAMPT(RESULT,GMVTEAM) ;GMV TEAM PATIENTS [RPC entry point]
 ; Calls CPRS API (IA #2692) and return list of patients for a given
 ; team (File 100.21, Field 10).
 N GMVI,GMVOUT,GMVPTNUM
 ; Call CPRS API with name of array to return data in and the IEN of
 ; the File 100.21 entry. CPRS returns:
 ; Arrayname(Sequential #)=DFN ^ patient name (File 2, Field .01)
 D TEAMPTS^ORQPTQ1(.GMVOUT,GMVTEAM)
 I $P($G(GMVOUT(1)),U,1)="" S RESULT(1)="NO PATIENTS" Q
 S GMVI=0
 F  S GMVI=$O(GMVOUT(GMVI)) Q:'GMVI  D
 .S GMVPTNUM=+$P(GMVOUT(GMVI),U,1)
 .D PTINFO(.GMVPAT,GMVPTNUM)
 .S RESULT(GMVI)=$P(GMVOUT(GMVI),U,2)_U_+$P(GMVOUT(GMVI),U,1)_U_GMVPAT
 .Q
QUITP K OUT,ARRAY1
 Q
ALLERGY(RESULT,DFN) ;GMV ALLERGY [RPC entry point]
 N GMRAL,GMVALG,GN D EN1^GMRADPT M GMVALG=GMRAL
 I $O(GMVALG(0))'>0 D  Q
 . I $G(GMVALG)="" S RESULT(1)="No Allergy Assessment"
 . I $G(GMVALG)=0 S RESULT(1)="No Known Allergies"
 . Q
 S GN=1,RESULT(1)="This patient has the following allergy(ies): ",GN(1)=0 F  S GN(1)=$O(GMVALG(GN(1))) Q:GN(1)'>0  D
 . S GN=GN+1,RESULT(GN)=$P($G(GMVALG(GN(1))),U,2)
 Q
