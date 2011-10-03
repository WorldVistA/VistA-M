IVM273A ;ALB/PDJ IVM*2.0*73 - CLEANUP IVM PATIENT FILE;02/07/2003
 ;;2.0;INCOME VERIFICATION MATCH;**73**; 21-OCT-94
 ;
EN N DFN,I,R3015,SEG,TEXT,TYPE,X,X1,X2,%,XTPAT,IVMPH,IVMAD
 ;
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("   The Post Install will now process through the IVM PATIENT")
 D BMES^XPDUTL(" FILE to remove entries which do not contain any uploadable")
 D BMES^XPDUTL(" or non-uploadable fields.")
 D BMES^XPDUTL(" ")
 ;
 I $D(XPDNM) D
 . I $$VERCP^XPDUTL("R3015")'>0 D
 . . S %=$$NEWCP^XPDUTL("R3015","","0")
 ;
 F I="PATREC" D
 . I $D(^XTMP("IVM*2.0*73-"_I)) Q
 . S X1=DT
 . S X2=30
 . D C^%DTC
 . S TEXT=X_"^"_$$DT^XLFDT_"^IVM*2.0*73 POST-INSTALL "
 . S TEXT=TEXT_$S(I="PATREC":"IVM Patient Records",1:"filing errors")
 . S ^XTMP("IVM*2.0*73-"_I,0)=TEXT
 ;
 S XTPAT="IVM*2.0*73-PATREC"
 ;
 I '$D(XPDNM) D
 . S ^XTMP(XTPAT,1)=0
 I $D(XPDNM)&'$D(^XTMP(XTPAT,1)) S ^XTMP(XTPAT,1)=0
 I $D(XPDNM) S %=$$VERCP^XPDUTL("R3015")
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
 ;
EN1 I '$D(XPDNM) S R3015=0
 I $D(XPDNM) S R3015=$$PARCP^XPDUTL("R3015")
 F  S R3015=$O(^IVM(301.5,R3015)) Q:'R3015  D
 . S SEG="B"
 . F  S SEG=$O(^IVM(301.5,R3015,"IN",SEG),-1) Q:'SEG  D
 . . S (IVMAD,IVMPH)=0
 . . S DFN=+$P($G(^IVM(301.5,R3015,0)),U,1) Q:'DFN
 . . S TYPE=$P($G(^IVM(301.5,R3015,"IN",SEG,0)),U,2) Q:TYPE'="PID"
 . . D CHKREC
 . . S TYPE=$P($G(^IVM(301.5,R3015,"IN",SEG,0)),U,2)
 . . I TYPE="" D PROCREC
 . I $D(XPDNM) S %=$$UPCP^XPDUTL("R3015",R3015)
 ;
 D MAIL^IVM273M
 I $D(XPDNM) S %=$$COMCP^XPDUTL("R3015")
 D BMES^XPDUTL(" Cleanup of IVM PATIENT file is complete.")
 Q
 ;
CHKREC ; Check Demographic fields
 N DEMO,DATA0,FLDLOC,IVMDATA,PATPH,PH
 S DEMO=0
 F  S DEMO=$O(^IVM(301.5,R3015,"IN",SEG,"DEM",DEMO)) Q:'DEMO  D
 . S DATA0=$G(^IVM(301.5,R3015,"IN",SEG,"DEM",DEMO,0)) Q:DATA0=""
 . S FLDLOC=$P(DATA0,"^",1),IVMDATA=$P(DATA0,"^",2)
 . I IVMDATA="" D  Q
 . . ; only process address fields
 . . I '$D(^IVM(301.92,"AD",FLDLOC)) Q
 . . S IVMAD=1 D DELFLD
 . I FLDLOC=11 D
 . . S PATPH=$$CONVPH^IVMPREC8($P($G(^DPT(DFN,.13)),"^",1))
 . . S PH=$$CONVPH^IVMPREC8(IVMDATA)
 . . ; quit if the phone numbers are the same, otherwise delete
 . . ;   the field from the IVM PATIENT file
 . . I PATPH'=PH Q
 . . S IVMPH=1 D DELFLD
 ; If no uploadable and no non-uploadable fields delete then entry
 I '$$DEMO^IVMLDEM5(R3015,SEG,0),'$$DEMO^IVMLDEM5(R3015,SEG,1) D
 . D DELETE^IVMLDEM5(R3015,SEG,"NAME,DUMMY")
 Q
 ;
DELFLD ; Delete null field
 N DA,DIE,DR
 S DA=DEMO,DA(1)=SEG,DA(2)=R3015
 S DIE="^IVM(301.5,"_DA(2)_",""IN"","_DA(1)_",""DEM"","
 S DR=".01////@" D ^DIE
 Q
 ;
PROCREC ; Save processed records to the XTMP file
 N DATA,NAME,SSN
 S DATA=$G(^DPT(DFN,0)) Q:DATA=""
 S NAME=$P(DATA,"^",1)
 S SSN=$P(DATA,"^",9)
 ;
 ; Only count the record once even if more than one entry was
 ;   updated.
 ;
 I '$D(^XTMP(XTPAT,"RECS",DFN)) S ^XTMP(XTPAT,1)=$G(^XTMP(XTPAT,1))+1
 S ^XTMP(XTPAT,"RECS",DFN)=R3015_U_NAME_U_SSN
 I IVMAD S $P(^XTMP(XTPAT,"RECS",DFN),U,4)=1
 I IVMPH S $P(^XTMP(XTPAT,"RECS",DFN),U,5)=1
 Q
 ;
CLEANUP ; Used to cleanup XTMP global for testing only
 S XTPAT="IVM*2.0*73-PATREC"
 ;
 K ^XTMP(XTPAT)
 Q
