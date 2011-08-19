PSULRHL3 ;HCIOFO/BH - Daily file procesing ; 1/20/11 3:03pm
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**3,18**;MARCH, 2005;Build 7
 ;
 ; ** THIS ROUTINE SHOULD NEVER BE INSTALLED AT A SITE ***
 ; ** THIS ROUTINE IS ONLY TO BE RUN ON THE CMOP-NAT SERVER ***
 ;
 Q
 ;
PROCESS ; This process loops through the file containing parsed HL7 data.
 ; This process runs each day and collects up to the previous days data.
 ; The data is ordered by facility.  All the data for the facility for
 ; for up to the previous day gets filed into one flat file for PBM to
 ; process.   A pre-init sub routine CULL loops through all x-refs that 
 ; indicate processed data for facility and date and culls the data and
 ; removes the FD x-ref.
 ; 
 ;
 D CULL
 ;
 ;
 N DFN,EDATE,FACILITY,FILE,IEN,OPEN,OUTDIR,PSUDTE,QUIT,RDATE,RC,SDATE,TEMP,X,X1,X2
 ;
 ; End date for search
 D NOW^%DTC S TEMP=%,EDATE=$P(TEMP,".",1)
 ; Run date i.e. going to process data up to yesterday 
 S X1=$P(TEMP,".",1),X2="-1" D C^%DTC S RDATE=$P(X,".",1)
 ;
 ;
 S FACILITY="",(QUIT,OPEN)=0
 ;
 F  S FACILITY=$O(^DIZ(99999,"FDP",FACILITY)) Q:'FACILITY!(QUIT)  D
 . ;
 . I $D(^DIZ(99999,"FD",FACILITY,RDATE)) D  Q
 . . D ERROR(3,FACILITY,RDATE) Q
 . ; New facility so close any open files.
 . I OPEN D CLOSE S OPEN=0
 . S DATE="0"
 . F  S DATE=$O(^DIZ(99999,"FDP",FACILITY,DATE)) Q:'DATE!(DATE'<EDATE)!(QUIT)  D
 . . ;
 . . S DFN=""
 . . F  S DFN=$O(^DIZ(99999,"FDP",FACILITY,DATE,DFN)) Q:'DFN!(QUIT)  D
 . . . S IEN=""
 . . . F  S IEN=$O(^DIZ(99999,"FDP",FACILITY,DATE,DFN,IEN)) Q:'IEN!(QUIT)  D
 . . . . I 'OPEN D  Q:'RC
 . . . . . S RC=$$OPEN()
 . . . . . I 'RC S QUIT=1 Q
 . . . . . S OPEN=1
 . . . . D FILE
 I OPEN D CLOSE
 Q
 ;
 ;
OPEN() ; Open the output directory
 N DST,POP,SRC
 S FILE=FACILITY_DT_".DAT"
 ;S OUTDIR="W:\PBM\National-PBM"
 S OUTDIR="USER$:[PBM.LAB]"
 ;
 K DST,SRC
 S SRC(FILE)=""
 I $$LIST^%ZISH(OUTDIR,"SRC","DST") D ERROR(2,FACILITY,FILE) Q 0
 ;
 D OPEN^%ZISH("HL7FILE",OUTDIR,FILE,"W")
 I $G(POP) D ERROR(1,FACILITY,OUTDIR_FILE) Q 0
 ;
 Q 1
 ;
CLOSE ; Set Cross ref indicating that facilities data for the day got 
 ; processed, and close the output file.
 N FDA
 K FDA
 S FDA(99999,"+1,",.01)=$E(FILE,1,3)
 S FDA(99999,"+1,",.03)=RDATE
 D UPDATE^DIE("","FDA",)
 D CLOSE^%ZISH("HL7FILE")
 Q
 ;
FILE ; File the lab data to the output file in the following single string format.
 ;
 ;  PSU*4*18 Add use of STA5A
 ;  PAT|Facility|ICN|SSN|DFN|Date/Time Specimen Collected|STA5A|Site/Specimen|Local Lab Number^Local Lab Name|
 ;  NLT Code^NLT Name|LOINC Code^LOINC Name|Result|Units|Low Range|High Range|
 ;
 ;
 N CNT,CR,DFN,FAC,HRANGE,ICN,LABA,LABB,LABC,LNCODE,LNNAME,LOCALLAB
 N LRANGE,NLTCODE,NLTNAME,RANGE,REC,RESIEN,RESREC,RESREC1,RESULT,SPEC
 N SPECDATE,SPECREC,SPECIEN,SSN,STR,STR1,TEST,UNITS,STA5A
 ;
 U IO
 S REC=^DIZ(99999,IEN,0)
 S SSN=$P(REC,U,5),ICN=$P(REC,U,4),FAC=$P(REC,U,1),DFN=$P(REC,U,2),STA5A=$P(REC,U,6)
 ;
 S SPECIEN=0
 F  S SPECIEN=$O(^DIZ(99999,IEN,1,SPECIEN)) Q:'SPECIEN  D
 . ; Do not file if Specimen has no results
 . S TEST=0
 . S TEST=$O(^DIZ(99999,IEN,1,SPECIEN,1,TEST)) Q:'TEST
 . S SPECREC=^DIZ(99999,IEN,1,SPECIEN,0)
 . S SPEC=$P(SPECREC,U,1),SPECDATE=$P(SPECREC,U,2)
 . S STR="PAT|"_FAC_"|"_ICN_"|"_SSN_"|"_DFN_"|"_SPECDATE_"|"_STA5A_"|"_SPEC
 . ;W STR
 . S RESIEN=0
 . ;S CNT=0
 . F  S RESIEN=$O(^DIZ(99999,IEN,1,SPECIEN,1,RESIEN)) Q:'RESIEN  D
 . . S RESREC=^DIZ(99999,IEN,1,SPECIEN,1,RESIEN,0)
 . . S RESREC1=^DIZ(99999,IEN,1,SPECIEN,1,RESIEN,2)
 . . ;S CNT=CNT+1
 . . S LOCALLAB=$P(RESREC,U,6),NLTCODE=$P(RESREC,U,2)
 . . S NLTNAME=$P(RESREC,U,3),LNNAME=$P(RESREC,U,5)
 . . S LNCODE=$P(RESREC,U,4),RESULT=$P(RESREC,U,1)
 . . S UNITS=$P(RESREC1,U,1),RANGE=$P(RESREC1,U,2)
 . . ; Most of the time High and Low range are separated by a "-"
 . . I RANGE["-" D
 . . . S LRANGE=$P(RANGE,"-",1),HRANGE=$P(RANGE,"-",2)
 . . I RANGE'["-" D
 . . . S LRANGE=RANGE,HRANGE=""
 . . S LABA="|^"_LOCALLAB_"|"_NLTCODE_"^"_NLTNAME_"|"_LNCODE_"^"_LNNAME_"|"
 . . ;
 . . S LABB=RESULT_"|"_UNITS_"|"
 . . ;
 . . S LABC=LRANGE_"|"_HRANGE_"|"
 . . W STR_LABA_LABB_LABC,!
 Q
 ;
ERROR(CODE,FAC,MESSAGE) ; Error processing
 N ARR,STR
 I CODE=1 S STR=DT_": Cannot open output file "_MESSAGE
 I CODE=2 S STR=DT_": File name already exists in the output directory "_MESSAGE
 I CODE=3 D
 . S MESSAGE=$E(MESSAGE,4,5)_"/"_$E(MESSAGE,6,7)_"/"_$E(MESSAGE,2,3)
 . S STR=DT_": Trying to process records for Facility #"_FAC_" for the date of "_MESSAGE_" that  have already been processed."
 S FDA(99999,"+1,",.01)=FAC
 S FDA(99999,"+1,",2)=STR
 D UPDATE^DIE("","FDA",)
 Q
 ;
 ;
CULL ;  Cull all entries for a facility that have been processed on or before the date in FD x-ref
 N A,B,DFN,DELLIEN,FAC,IDATE,IEN,PDATE
 S FAC="0"
 F  S FAC=$O(^DIZ(99999,"FD",FAC)) Q:'FAC  D
 . S PDATE=0
 . F  S PDATE=$O(^DIZ(99999,"FD",FAC,PDATE)) Q:'PDATE  D
 . . S IDATE=0
 . . ;  Remove entry with FD x-ref
 . . S DELLIEN=0
 . . S DELLIEN=$O(^DIZ(99999,"FD",FAC,PDATE,DELLIEN))
 . . K B
 . . S B(99999,DELLIEN_",",.01)="@" D FILE^DIE(,"B")
 . . ;
 . . F  S IDATE=$O(^DIZ(99999,"FDP",FAC,IDATE)) Q:'IDATE!($P(IDATE,".",1)>PDATE)  D
 . . . S DFN=0
 . . . F  S DFN=$O(^DIZ(99999,"FDP",FAC,IDATE,DFN)) Q:'DFN  D
 . . . . S IEN=0
 . . . . F  S IEN=$O(^DIZ(99999,"FDP",FAC,IDATE,DFN,IEN)) Q:'IEN  D
 . . . . . K A
 . . . . . S A(99999,IEN_",",.01)="@" D FILE^DIE(,"A")
 Q
 ;
 ;
ERORDSP ; Display errors
 ;
 N DATE,DONE,EDATE,FAC,IEN,PG
 S PG=0,DATE=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 D HEAD
 I '$D(^DIZ(99999,"FDE")) W "No Error's to report." H 4 Q
 ;
 ;
 S FAC="0"
 F  S FAC=$O(^DIZ(99999,"FDE",FAC)) Q:'FAC  D
 . ;
 . S EDATE=0
 . F  S EDATE=$O(^DIZ(99999,"FDE",FAC,EDATE)) Q:'EDATE  D
 . . S IEN=0
 . . F  S IEN=$O(^DIZ(99999,"FDE",FAC,EDATE,IEN)) Q:'IEN  D
 . . . S MSG=^DIZ(99999,IEN,2)
 . . . I ($Y+4>IOSL) D PRTC Q:$D(DONE)  D HEAD
 . . . W !,"  "_MSG,!
 Q
 ;
HEAD ;
 W:$Y>0 @IOF S PG=PG+1
 W "  "_DATE,?71,"Page ",PG,!!
 W "  Error log for PBM III national database processing.",!
 W "  ---------------------------------------------------",!
 Q
 ;
PRTC ;press return to continue prompt
 Q:$E(IOST,1,2)'="C-"!($D(IO("S")))
 K DIR W ! S DIR(0)="E" D ^DIR K DIR I 'Y S DONE=1
 Q
 ;
 ;
