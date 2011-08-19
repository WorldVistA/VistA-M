MDCPID ;HINES OIFO/DP/BJ - Wrapper for PID Segment Builder;23 Nov 2005
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10106       - HLFNC calls                      HL7                   (supported)
 ;  #  263       - $$EN^VAFHLPID                    Registration          (supported)
 ;  #10035       - access ^DPT(                     Registration          (supported)
 ;
 ; This wrapper will accept the basic input parameters from the PFSS message builder and
 ; call the standard ZEN segment builder to create the necessary output.  It will then
 ; check for required fields based on the PFSS Profiles and return an array containing
 ; the segment data
 ;
EN(DFN,MDCPID,MDCERR) ;function returns ZEN segment containing enrollment data.
 ;
 ;  Input:
 ;         DFN    -- Patient Number
 ;         MDCPID  -- Array passed by reference to contain the message array.
 ;         ERR    -- Error variable to be set if there is a missing required field.
 ;
 ;  Output:
 ;         MDCPID  -- Array passed by reference returned with message data
 ;         ERR    -- Error variable is defined only if there is an error condition
 ;
 N ARRAY,CNT,DATA,DOD,ICN,J,MAXLEN,PNAME,SSN,MDCIEN,MDCENR,MDCSTR
 ;
 ;   Determine maximum length of segment
 S MAXLEN=$G(HLMAXLEN,245)
 ;
 ;   Build MDCSTR for fields required by CLIO/ICU
 S MDCSTR="1,3,5,6,7,8,11,13,14,16,17"
 ;
 ;   Call original segment builder complete with SSN
 S MDCPID=$$EN^VAFHLPID(DFN,MDCSTR,"0001",3)
 ;
 ;   Break segment into an array.  It is possible that the segment can exceed the maximum length
 F CNT=2:1:$L(MDCPID,HLFS) S ARRAY(CNT-1)=$P(MDCPID,HLFS,CNT)
 ;
 ;   Collect Data
 M DATA(.01)=^DPT(DFN,.01) ; Alias File
 M DATA(.02)=^DPT(DFN,.02) ; Race File
 ;
 ;   PID.3
 ;   Remove "universal ID type (ID)" from component 4
 S SSN=ARRAY(3),$P(SSN,HLCM,1)=$TR($P(SSN,HLCM,1),"-"),$P(SSN,HLCM,4)=$P($P(ARRAY(3),HLCM,4),HLSC,1)
 ;   Check that all required components are present
 I $TR(SSN,(HLECH_HLQ))="" S MDCERR=$$REQ("PID.3 - SSN",DFN) Q
 I $TR(SSN,(HLECH_HLQ))'="" D  I $D(MDCERR) Q
 . N PCE
 . I $P(SSN,HLCM,1)="" S MDCERR=$$REQ("PID.3.1 - ID",DFN) Q
 . I $P(SSN,HLCM,4)="" S MDCERR=$$REQ("PID.3.4 - Assigning Authority",DFN) Q
 . I $P(SSN,HLCM,5)="" S MDCERR=$$REQ("PID.3.5 - Identifier Type Code",DFN) Q
 I $D(MDCERR) G ENQ
 ;   Get ICN
 S ICN=$P($$EN^VAFHLPID(DFN,3,,1),HLFS,4)
 ;   Remove "universal ID type (ID)" from component 4
 S $P(ICN,HLCM,4)=$P($P(ICN,HLCM,4),HLSC,1)
 ;   Check that all required components are present
 I $TR(ICN,(HLECH_HLQ))="" S MDCERR=$$REQ("PID.3 - SSN",DFN) Q
 I $TR(ICN,(HLECH_HLQ))'="" D  I $D(MDCERR) Q
 . N PCE
 . I $P(ICN,HLCM,1)="" S MDCERR=$$REQ("PID.3(1).1 - ID",DFN) Q
 . I $P(ICN,HLCM,4)="" S MDCERR=$$REQ("PID.3(1).4 - Assigning Authority",DFN) Q
 . I $P(ICN,HLCM,5)="" S MDCERR=$$REQ("PID.3(1).5 - Identifier Type Code",DFN) Q
 I $D(MDCERR) G ENQ
 ;   Restore data to array
 S ARRAY(3)=SSN_HLRP_ICN
 ;
 ;   PID.5
 ;   Add Name Type Code
 S $P(ARRAY(5),HLCM,7)="L"
 ;   Check for REQ components
 I $P(ARRAY(5),HLCM,1)="" S MDCERR=$$REQ("PID.5.1 - Family Name",DFN) G ENQ
 I $P(ARRAY(5),HLCM,2)="" S MDCERR=$$REQ("PID.5.2 - Given Name",DFN) G ENQ
 ;   Add Aliases to Array
 F CNT=1:1 Q:'$D(DATA(.01,CNT))  D  I $D(MDCERR) Q
 . N NIEN,NAME,NAME1,PCE
 . S NIEN=$P(DATA(.01,CNT,0),U,3)
 . I NIEN D
 .. S MDF20=20,NAME1=""
 .. F PCE=1,2,3,5,4,6 D  I $D(MDCERR) Q
 ... S DATA=$$GET1^DIQ(MDF20,NIEN_",",PCE),NAME1=NAME1_$S($L(NAME1):HLCM,1:"")_DATA
 .. K MDF20
 . I 'NIEN S NAME1=$$HLNAME^HLFNC($P(DATA(.01,CNT,0),U,1))
 . I $TR(NAME1,HLCM)'="",$P(NAME1,HLCM,1)="" S MDCERR=$$REQ("PID.5"_CNT_".1 - Family Name",DFN) Q
 . S ARRAY(5)=ARRAY(5)_HLRP_NAME1_HLCM_"A"
 I $D(MDCERR) G ENQ
 ;
 ;   PID.6 - Mother's Maiden Name
 ;   Need to make HL7 compliant
 S ARRAY(6)=$P($$HLNAME^HLFNC(ARRAY(6)),HLCM,1,3) S $P(ARRAY(6),HLCM,7)="M"
 ;
 ;   PID.7 - Date/Time of Birth
 I ARRAY(7)="" S MDCERR=$$REQ("PID.7 - Date/Time of Birth",DFN) G ENQ
 ;
 ;   PID.8 - Administrative Sex
 ;   Check for Required Data
 I ARRAY(8)="" S MDCERR=$$REQ("PID.8 - Administrative Sex",DFN) G ENQ
 ;    Change U to I
 I ARRAY(8)="U" S ARRAY(8)="I"
 ;
 ;   PID.10 - Race
 ;S ARRAY(10)="",J=0
 ;F  S J=$O(DATA(.02,J)) Q:'J  D  I $D(MDCERR) Q
 ;. N D1,D2,P1,P2,PCE,STR
 ;. S (D1,D2,P1,P2)="" ;Initialize
 ;. ;
 ;. ;  Initialize pointers
 ;. S P1=$P($G(DATA(.02,J,0)),U),P2=$P($G(DATA(.02,J,0)),U,2)
 ;. ;
 ;. ;  Convert Pointers to data
 ;. I P1 S D1=$P($G(^DIC(10,P1,0)),U,3),D2=$P($G(^DIC(10,P1,0)),U,1)
 ;. I P2 S D1=D1_"-"_$P($G(^DIC(10.3,P2,0)),U,3)
 ;. ;
 ;. ;  If any components are present check that all components are present
 ;. I D1'=""!(D2'="") D  I $D(MDCERR) Q
 ;.. I D1="" S MDCERR=$$REQ("PID.10.1 - Race Identifier",DFN) Q
 ;.. I D2="" S MDCERR=$$REQ("PID.10.2 - Race Text",DFN) Q
 ;. ;
 ;. ;  Store data in ARRAY(10)
 ;. S ARRAY(10)=ARRAY(10)_$S($L(ARRAY(10)):HLRP,1:"")_D1_HLCM_D2_HLCM_"HL70005"
 ;I $D(MDCERR) G ENQ
 ;
 ;   PID.17 - Religion
 I $G(ARRAY(17)) S MDF13=13 S ARRAY(17)=$$GET1^DIQ(MDF13,ARRAY(17)_",","NAME") K MDF13
 ;
 ;   PID.22 - Ethnic Group
 ;   strip extra COMPONENT data
 ;S ARRAY(22)=$P(ARRAY(22),HLCM,1)
 ;
 ;   PID.27 - Veterans Military Status
 S ARRAY(27)=$G(^DPT(DFN,"VET"))
 ;
 ;   PID.29 and PID.30 Patient Death info
 S DOD=$P($G(^DPT(DFN,.35)),U,1)
 I DOD S ARRAY(29)=$$HLDATE^HLFNC(DOD,"TS")
 S ARRAY(30)=$S(DOD:"Y",1:"N")
 ;
 ;  Build segment
 D MAKESEG^MDCUTL(.ARRAY,.MDCPID,,"PID")
 ;
 ;  Quit to Calling Routine
DONE Q
 ;
ENQ ;I '$D(MDCERR),(MDCPID'="") S ZENSEG=MDCZEN
 ;
 ;   Quit to calling routine
 Q
 ;
REQ(ELEMENT,DFN) ;Required Item missing
 N MDCPARM
 S MDCPARM(1)=ELEMENT
 S MDCPARM(2)=DFN
 S MDCPARM(3)=2
 Q $$EZBLD^DIALOG(7040020.001,.MDCPARM)
