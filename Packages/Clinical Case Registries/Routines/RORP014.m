RORP014 ;BP/ACS CCR POST-INIT PATCH 14 ;12/31/10
 ;;1.5;CLINICAL CASE REGISTRIES;**14**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #3556    GCPR^LA7QRY (controlled)
 ;
 ;******************************************************************************
 ;Change name of MELD report to "Liver Score by Range" in the ROR REPORT
 ;PARAMETERS file (#799.34)
 ;******************************************************************************
 ;find IEN of existing "MELD Score by Range" entry
 N IEN,IENS,RORFDA,RORMSG S IEN=$O(^ROR(799.34,"B","MELD Score by Range",0))
 I $G(IEN) S IENS=IEN_"," D
 . S RORFDA(799.34,IENS,.01)="Liver Score by Range"
 . K RORMSG D FILE^DIE(,"RORFDA","RORMSG")
 K RORFDA,RORMSG
 ;
 ;******************************************************************************
 ;Add new entries to the ROR XML ITEM file (#799.31).  These entries are needed
 ;for the new APRI/FIB4 calculations in the Liver Score by Range report.
 ;******************************************************************************
 N RORXML,RORTAG,RORFDA,RORERR
 ;--- add codes
 F I=1:1:5 S RORTAG="XML"_I D
 . S RORXML=$T(@RORTAG)
 . S RORXML=$P(RORXML,";;",2)
 . ;don't add if it's already in the global
 . Q:$D(^ROR(799.31,"B",RORXML))
 . S RORFDA(799.31,"+1,",.01)=RORXML
 . D UPDATE^DIE(,"RORFDA",,"RORERR")
 K RORFDA,RORERR
 ;
 ;******************************************************************************
 ;Add "Purchased Care" to the ROR DATA AREA file (#799.33)
 ;******************************************************************************
 ;remove old entries if they exist
 N DA,DIK
 S DIK="^ROR(799.33,",DA=$O(^ROR(799.33,"B","Purchased Care",0)) I $G(DA)>0 D ^DIK
 N RORDA F RORDA="Purchased Care" D
 . Q:$D(^ROR(799.33,"B",RORDA))  ;don't add if already in global
 . N RORFDA,RORERR,RORIEN
 . S RORFDA(799.33,"+1,",.01)=RORDA
 . S RORIEN(1)=20 ;IEN=20 for Purchased Care
 . D UPDATE^DIE(,"RORFDA","RORIEN","RORERR")
 . K RORFDA,RORERR,RORIEN
 ;
 ;******************************************************************************
 ;Update the PURCHASED CARE backpull entry in the ROR HISTORICAL DATA 
 ;EXTRACT file with END DATE and ACTIVATION DATE = current date.
 ;******************************************************************************
 N RORIEN S RORIEN=$O(^RORDATA(799.6,"B","PURCHASED CARE",0))
 I $G(RORIEN) D
 . N DIE,DA,DR
 . S DIE="^RORDATA(799.6,",DA=RORIEN,DR=".04///"_DT_";.07///"_DT D ^DIE
 ;
 ;******************************************************************************
 ;Add new entries to the ROR LIST ITEM file (#799.1) for the 2 new Liver reports
 ;in the MELD group
 ;******************************************************************************
 N RORDATA,RORTAG,RORFDA,I,TEXT,TYPE,REGISTRY,CODE
 F I=1:1:4  S RORTAG="LI"_I D
 . S RORDATA=$P($T(@RORTAG),";;",2)
 . S TEXT=$P(RORDATA,"^",1) ;TEXT to add
 . S TYPE=$P(RORDATA,"^",2) ;TYPE to add
 . S REGISTRY=$P(RORDATA,"^",3) ;REGISTRY to add
 . S CODE=$P(RORDATA,"^",4) ;CODE to add
 . ;don't add if it's already in the global
 . Q:$D(^ROR(799.1,"KEY",TYPE,REGISTRY,CODE))
 . S RORFDA(799.1,"+1,",.01)=TEXT
 . S RORFDA(799.1,"+1,",.02)=TYPE
 . S RORFDA(799.1,"+1,",.03)=REGISTRY
 . S RORFDA(799.1,"+1,",.04)=CODE
 . D UPDATE^DIE(,"RORFDA",,"RORERR")
 K RORFDA,RORERR
 ;
 ;******************************************************************************
 ;Add new LOINC codes to the VA HEPC lab search criteria in the
 ;ROR LAB SEARCH file #798.9.  Don't add them if they already exist.  Do not
 ;add the 'dash' or the number following it.
 ;******************************************************************************
 N I,HEPCIEN,RORDATA,RORLOINC,RORTAG K RORMSG
 N HEPCNT S HEPCNT=0
 S HEPCIEN=$O(^ROR(798.9,"B","VA HEPC",0)) ;HEPC top level IEN
 ;--- add LOINC codes to the VA HEPC search criteria
 F I=1:1:9  S RORTAG="HEP"_I D
 . S RORLOINC=$P($P($T(@RORTAG),";;",2),"-",1)
 . ;don't add if it's already in the global
 . Q:($D(^ROR(798.9,HEPCIEN,1,"B",RORLOINC)))
 . S RORDATA(1,798.92,"+2,"_HEPCIEN_",",.01)=$G(RORLOINC)
 . S RORDATA(1,798.92,"+2,"_HEPCIEN_",",1)=0 ;indicator: ingore
 . D UPDATE^DIE("","RORDATA(1)",,"RORMSG")
 . S HEPCNT=HEPCNT+1
 K RORDATA,RORMSG
 ;
 ;******************************************************************************
 ;Check each pending patient in the HEPC registry to see if they have ever had a positve
 ;HCV LOINC.  If they have, then confirm them into the registry immediately.
 ;******************************************************************************
 N IEN,DFN,PTID,START,END,RORFS,RORCS,H7CH,HEPCREG
 S H7CH="|^~\&",RORFS="|",RORCS="^"
 S HEPCREG=$O(^ROR(798.1,"B","VA HEPC",0)) Q:'HEPCREG  ;HEPC Registry IEN
 S IEN=0 F  S IEN=$O(^RORDATA(798,IEN)) Q:'IEN  D
 . Q:$P($G(^RORDATA(798,IEN,0)),U,2)'=HEPCREG  ;quit if not HEPC registry
 . Q:$P($G(^RORDATA(798,IEN,0)),U,5)'=4  ;quit if not pending patient
 . S DFN=$P($G(^RORDATA(798,IEN,0)),U,1) ;get patient DFN
 . Q:'DFN
 . S PTID=$$PTID^RORUTL02(DFN) ;get patient ID for call to GCPR^LA7QRY
 . Q:+PTID'>0
 . S START="2000101^CD" ;start date 1/1/1900
 . S END=DT_".235959^CD"
 . N RORLC,RORMSG,RORHCV
 . S RORLC="CH,MI" ;search Chem and Micro sub-files in #63
 . S RORLC(12)="11011-4^LN"
 . S RORLC(13)="29609-5^LN"
 . S RORLC(14)="34703-9^LN"
 . S RORLC(15)="34704-7^LN"
 . S RORLC(16)="10676-5^LN"
 . S RORLC(17)="20416-4^LN"
 . S RORLC(18)="20571-6^LN"
 . S RORLC(19)="49758-6^LN"
 . S RORLC(20)="50023-1^LN"
 . S RORHCV=$NA(^TMP("RORHCV",$J)) K @RORHCV ;output to hold the HCV test results
 . N RC S RC=$$GCPR^LA7QRY(PTID,START,END,.RORLC,"*",.RORMSG,RORHCV,H7CH)
 . I $D(@RORHCV)'>1 Q
 . N RORNODE,RORSEG,RORVAL,RORDONE,SEGTYPE
 . S RORNODE=0,RORDONE=0
 . ;loop through output and see if the test result value in OBX contains ">" in first character
 . F  S RORNODE=$O(^TMP("RORHCV",$J,RORNODE)) Q:(($G(RORNODE)="")!(RORDONE))  D
 .. S RORSEG=$G(^TMP("RORHCV",$J,RORNODE)) ;entire HL7 segment
 .. S SEGTYPE=$P(RORSEG,RORFS,1) ;segment type (PID,OBR,OBX,etc.)
 .. Q:SEGTYPE'="OBX"  ;we want OBX segments only
 .. S RORVAL=$P(RORSEG,RORFS,6) ;test result value
 .. S RORVAL=$TR(RORVAL,"""","") ;get rid of double quotes around values
 .. N IENS I $E($G(RORVAL),1,1)=">" S IENS=IEN_"," D  ;if positive test result
 ... S RORFDA(798,IENS,3)=0 ;set status = confirmed
 ... S RORFDA(798,IENS,12)="" ;set pending comment field to null
 ... K RORMSG D FILE^DIE(,"RORFDA","RORMSG") ;update
 ... S RORDONE=1
 ;
 D CLEAN^DILF
 Q
 ;******************************************************************************
 ;New HEPC LOINC codes
 ;******************************************************************************
HEP1 ;;11011-4
HEP2 ;;29609-5
HEP3 ;;34703-9
HEP4 ;;34704-7
HEP5 ;;10676-5
HEP6 ;;20416-4
HEP7 ;;20571-6
HEP8 ;;49758-6
HEP9 ;;50023-1
 ;
 ;
 ;******************************************************************************
 ;new XML tags to be added to ROR XML ITEM file (#799.31)
 ;******************************************************************************
XML1 ;;LOINC_CODES
XML2 ;;FIRSTDIAG
XML3 ;;APRI
XML4 ;;FIB4
XML5 ;;ULNAST
 ;
 ;******************************************************************************
 ; Data to be added to ROR LIST ITEM file (#799.1)
 ; TEXT^TYPE^REGIEN^CODE
 ;******************************************************************************
LI1 ;;APRI^6^1^3
LI2 ;;FIB-4^6^1^4
LI3 ;;APRI^6^2^3
LI4 ;;FIB-4^6^2^4
