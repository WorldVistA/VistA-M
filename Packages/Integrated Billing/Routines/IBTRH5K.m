IBTRH5K ;ALB/JWS - HCSR Create 278 Request ;11-DEC-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Entry points and functions used in creating a 278 request from a
 ; selected entry in the HCSR Response worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ; REQMISS      - Checks for missing required fields in a request 
 ;-----------------------------------------------------------------------------
 Q
 ;
REQMISS ; Additional required field checking for 278 transaction
 ; Input:   CTC         - Certification Type Code IEN
 ;          IENS        - IEN_"," of the entry being checked
 ;          IBTRIEN     - IEN of the entry being checked
 ;          MISSING()   - Current array of missing fields
 ; Output:  MISSING()   - Updated array of missing fields
 ;
 ; Check Attachments multiple 356.2211
 N CNT,COMN,COMQ,RTC,ZZ
 S XX=$O(^IBT(356.22,IBTRIEN,11,0))
 I XX D
 . S (XX,CNT)=0
 . F  S XX=$O(^IBT(356.22,IBTRIEN,11,XX)) Q:XX'=+XX  D
 . . S CNT=CNT+1
 . . I $$GET1^DIQ(356.2211,XX_","_IENS,.01)="" D
 . . . S ZZ="The Report Type Code is required for all Attachment entries"
 . . . D MISSING("Attachment Multiple "_CNT_" Report Type Code",ZZ)
 . . S RTC=$$GET1^DIQ(356.2211,XX_","_IENS,.02,"I")
 . . I RTC="" D
 . . . S ZZ="The Report Transmission Code is required for all Attachment entries"
 . . . D MISSING("Attachment Multiple "_XX_" Report Trans Code",ZZ)
 . . I $$GET1^DIQ(356.2211,XX_","_IENS,.03)="" D
 . . . I $F(",BM,EL,EM,FX,",","_RTC_",") D
 . . . . S ZZ="The Attachment Control Number is required for any Attachment "
 . . . . S ZZ=ZZ_"entries with a Transmission Code of 'By Mail', 'Electronically Only', 'E-mail', or 'Fax'."
 . . . . D MISSING("Attachment Multiple "_XX_" CTL #",ZZ)
 ;
 ; Check Patient Event Provider multiple
 I '$D(^IBT(356.22,IBTRIEN,13)) D
 . I $$GET1^DIQ(356.22,IENS,2.01,"I")=1!('$O(^IBT(356.22,IBTRIEN,16,0))) D  Q
 . . S ZZ="There must be at least one Patient Event Service Provider included "
 . . S ZZ=ZZ_"in a 278 Request with Request Category equal to Admission Review "
 . . S ZZ=ZZ_"or with no Service Line detail entered."
 . . D MISSING("Patient Event Provider Multiple",ZZ)
 . S XX=0
 . F  S XX=$O(^IBT(356.22,IBTRIEN,16,XX)) Q:XX'=+XX  I '$O(^IBT(356.22,IBTRIEN,16,XX,8,0)) S XX="BAD" Q
 . S ZZ="There must be at least one Patient Event Service Provider included in "
 . S ZZ=ZZ_"a 278 Request if a Service Detail Line does not have a Service Provider entered."
 . I XX="BAD" D MISSING("Patient Event Provider Multiple",ZZ)
 ;
 ; Check Patient Event Transport multiple
 I $D(^IBT(356.22,IBTRIEN,14)) D
 . N CNT,CT,ZZ
 . S (CNT,XX,CT)=0
 . F  S XX=$O(^IBT(356.22,IBTRIEN,14,XX)) Q:XX'=+XX  D
 . . S CNT=CNT+1
 . . S CT=$G(CT)+1,CT(CT)=$$GET1^DIQ(356.2214,XX_","_IENS,.01,"I"),CT(CT(CT))=CT
 . . I CT(CT)="" D
 . . . S ZZ="Patient Event Transport multiple entry "_CNT_" is missing a required Location Type."
 . . . D MISSING("Patient Event Trans "_CNT_" .01",ZZ)
 . . I $$GET1^DIQ(356.2214,XX_","_IENS,.03)="" D
 . . . S ZZ="Patient Event Transport multiple entry "_CNT_" is missing a required Address Line."
 . . . D MISSING("Patient Event Trans "_CNT_" .03",ZZ)
 . . I $$GET1^DIQ(356.2214,XX_","_IENS,.07)="" D
 . . . N CITY,ST
 . . . S CITY=$$GET1^DIQ(356.2214,XX_","_IENS,.05)
 . . . I CITY="" D
 . . . . S ZZ="Patient Event Transport multiple entry "_CNT_" is missing a required City."
 . . . . D MISSING("Patient Event Trans "_CNT_" .05",ZZ)
 . . . S ST=$$GET1^DIQ(356.2214,XX_","_IENS,.06)
 . . . I ST="" D
 . . . . S ZZ="Patient Event Transport multiple entry "_CNT_" is missing a required State/Province Code."
 . . . . D MISSING("Patient Event Trans "_CNT_" .06",ZZ)
 . . . I ST="",CITY="" D
 . . . . S ZZ="Patient Event Transport multiple "_CNT_" must have a Zip code entered if no City "
 . . . . S ZZ=ZZ_"and State are entered."
 . . . . D MISSING("Patient Event Trans "_CNT_" .07",ZZ)
 . I CT=1 D
 . . S ZZ="There must be at least 2 entries in the Patient Event Transport multiple "
 . . S ZZ=ZZ_"indicating the pickup address and the final destination address."
 . . D MISSING("Patient Event Transport Multiple",ZZ)
 . I CT=2,'$D(CT("PW")),'$D(CT("FS")) D
 . . S ZZ="For the Patient Event Transport multiple, if there are 2 entries, one "
 . . S ZZ=ZZ_"must be for the Pickup address and the other must be the Final scheduled destination."
 . . D MISSING("Patient Event Transport Multiple",ZZ)
 ;
 ; Check OTHER UMO multiple
 I $D(^IBT(356.22,IBTRIEN,15)) D
 . N CNT,ZZ
 . S (CNT,XX)=0
 . F  S XX=$O(^IBT(356.22,IBTRIEN,15,XX)) Q:XX'=+XX  D
 . . S CNT=CNT+1
 . . I $$GET1^DIQ(356.2215,XX_","_IENS,.01)="" D
 . . . S ZZ="Other UMO entry "_CNT_" must have a UMO Entity Identifier code."
 . . . D MISSING("Other UMO multiple entry "_CNT_" .01",ZZ)
 . . I $$GET1^DIQ(356.2215,XX_","_IENS,.03)="" D
 . . . S ZZ="Other UMO entry "_CNT_" must have an Other UMO Denial Reason."
 . . . D MISSING("Other UMO multiple entry "_CNT_" .03",ZZ)
 . . I $$GET1^DIQ(356.2215,XX_","_IENS,.07)="" D
 . . . S ZZ="Other UMO entry "_CNT_" must have a UMO Denial Date entered."
 . . . D MISSING("Other UMO multiple entry "_CNT_" .07",ZZ)
 ;
 ; Check Service Line multiples
 I $D(^IBT(356.22,IBTRIEN,16)) D
 . N CNT,XX,YY,ZZ,I
 . S (CNT,YY,XX)=0
 . F  S XX=$O(^IBT(356.22,IBTRIEN,16,XX)) Q:XX'=+XX  D
 . . S CNT=CNT+1
 . . I $$GET1^DIQ(356.2216,XX_","_IENS,.15)="" D
 . . . F I=.02,.03,.04,.05 I $$GET1^DIQ(356.2216,XX_","_IENS,I)'="" S YY=1 Q
 . . . S ZZ="Service Line "_CNT_" requires the UMO Type to be included with service line information."
 . . . I YY D MISSING("Service Line "_CNT_" .15",ZZ)
 Q
 ;
 ;
MISSING(SUB,DESC) ; Function to generate MISSING array
 ; Input: SUB - subscript of MISSING array
 ;        DESC - description of error condition
 ; Returns: MISSING  array
 ;
 S MISSING=MISSING+1
 S MISSING(SUB)=DESC
 Q
 ;
CLRENTRY(IBTRIEN) ; clear an entry in file 356.22
 ; clears all fields except for .01 - .11, .16, and 4.01 - 4.02 at the top level
 ; IBTRIEN - file 356.22 ien
 ;
 N FDA,Z,Z1
 ; top level
 F Z=.12:.01:.15,.17:.01:.25,2.01:.01:2.26,4.03:.01:4.14,5.01:.01:5.18 S FDA(356.22,IBTRIEN_",",Z)="@"
 F Z=6.01:.01:6.18,7.01:.01:7.13,8.01:.01:8.08,9.01:.01:9.08,10.01:.01:10.13 S FDA(356.22,IBTRIEN_",",Z)="@"
 F Z=12,17.01,17.02,18.01:.01:18.1,19:.01:19.03,20:1:23,103.01:.01:103.04 S FDA(356.22,IBTRIEN_",",Z)="@"
 ; multiples
 F Z=1,3,11,13,14,15,16,101,105,107 D
 .S Z1=0 F  S Z1=$O(^IBT(356.22,IBTRIEN,Z,Z1)) Q:'Z1  S FDA(356.22_Z,Z1_","_IBTRIEN_",",.01)="@"
 .Q
 D FILE^DIE(,"FDA")
 Q
 ;
CLRASK() ; prompt user for clearing the entry in file 356.22
 ; returns 1 if entry should be cleared, 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="Clear existing data? (Y/N): ",DIR("B")="Y",DIR(0)="YAO" D ^DIR
 I $G(DTOUT)!$G(DUOUT)!$G(DIROUT)!($G(Y)'=1) Q 0
 Q 1
