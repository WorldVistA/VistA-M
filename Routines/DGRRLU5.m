DGRRLU5 ; ALB/sgg/MM - DG Replacement and Rehosting RPC for VADPT ; May-4-2004  ;
 ;;5.3;Registration;**538**;Aug 13, 1993
 ; provider lookup
 ; called by DGRRLU at line PRVLUP^DGRRLU5 if PARAMS("SEARCH_TYPE") = "PRVLUP"
 ;
 ;
DOC ;INPUT:  Input is by the following parameters in the PARAMS() array:
 ;
 ;"PRV_VPID" - VPID [Required VPID unless PRV_LNAM is not Null.]
 ;             If not null the query will only return the one person 
 ;             with this VPID, and only then if SSN, PROV and STN filters
 ;             do not exclude this person.
 ;"PRV_LNAM" - LAST NAME [Required Char String unless VPID is not Null.]
 ;             If not null the query will only return persons whose 
 ;             last name starts with this string.
 ;"PRV_FNAM" - FIRST NAME [Optional: Character String or Null.]
 ;             If not null the query will only return persons whose 
 ;             first name starts with this string.
 ;"PRV_SSN"  - SSN FILTER [Optional: 9 digits or Null.]
 ;             If not null the query will only return persons with 
 ;             this social security number.
 ;"PRV_PROV" - PROVIDER FILTER [Optional: "P" or Null.]
 ;             If set to "P" the query includes only providers, i.e. 
 ;             persons with a person class active on the PRV_DATE.
 ;"PRV_STN"  - STATION NUMBER FILTER [Optional: an STN or Null.]
 ;             If not null the query only returns persons with this 
 ;             station number.
 ;"PRV_MNM"  - MAXIMUM NUMBER [Optional: min=1 max=50 default=50.]
 ;             The maximum number of persons the query will return.  
 ;             If VPID is not null this is always 1.
 ;"PRV_DATE" - DATE [Optional: if Null this defaults to Today.]
 ;             The Date against which a persons active person class is
 ;             determined.
 ;
 ;OUTPUT:  Output an XML with a schema as given:
 ;
 ; <?xml version="1.0" encoding="utf-8" ?>
 ;      <persons>                                   Example Data
 ;           <person>
 ;           </vpid>                                999999999
 ;           </ien>                                 11579
 ;           </lname>                               KRUSHER
 ;           </fname>                               WILL
 ;           </mname>                               MIDDIE
 ;           </ssn>                                 232323232
 ;           </dob>                                 2330303
 ;           </sex>                                 M
 ;                <providerInfo>
 ;                     </type>                      Physician Assistants
 ;                     </classification>            Physician Assistant
 ;                     </specialization>            Medical
 ;                     </VACode>                    V100100
 ;                     </X12Code>                   363AM0700N
 ;                     </SpecialityCode>            97
 ;                </providerInfo>                                      
 ;           </person>                                      
 ;           <error message=''></error>                                  
 ;           <maximum message=''></maximum>                         
 ;           <record count='1'></record>                           
 ;           <institution name='ALBANY' number='500' productiondatabase='0' domain='DMA.FO-ALBANY.MED.VA.GOV' ></institution>
 ;      </persons>
 ;
 ;
PRVLUP(RESULT,PARAMS) ;
 NEW DGRRVPID,DGRRLNAM,DGRRFNAM,DGRRSSN,DGRRPROV,DGRRSTN,DGRRMNM,DGRRDATE
 SET DGRRVPID=$G(PARAMS("PRV_VPID")) ; - The VPID of a Provider (Required unless lookup is by Provider Name)
 SET DGRRLNAM=$G(PARAMS("PRV_LNAM")) ; - Part or all of the last name to use for basis of query (Required unless lookup is by VPID)
 SET DGRRFNAM=$G(PARAMS("PRV_FNAM")) ; - Part or all of the first name to use for basis of query filter (optional, can be null)
 SET DGRRSSN=$G(PARAMS("PRV_SSN"))   ; - Social Security Number (null or full 9 digits) to use as additional filter for query
 SET DGRRPROV=$G(PARAMS("PRV_PROV")) ; - If value set to "P", screen for only providers (only persons with active person class)
 SET DGRRSTN=$G(PARAMS("PRV_STN"))   ; - Filter persons based on station number entered (optional, can be null)
 SET DGRRMNM=$G(PARAMS("PRV_MNM"))   ; - Maximum Number of entries to return (Number between 1 and 50.  Null defaults to 50)
 SET DGRRDATE=$G(PARAMS("PRV_DATE")) ; - Date to be used to determine whether person has active person class.  If null, current date is used.
 ;
 N DGRRARR,DGRRCNT,ERRMESS,DGRRGLB
 DO ADD("<persons>")
 SET DGRRCNT=0 ;Initialize Record Count
 IF (DGRRLNAM=""),(DGRRVPID="") SET ERRMESS="Query requires a last name or a VPID." GOTO FINALLY
 ;
 D EN1^XUPSQRY(.DGRRARR,DGRRVPID,DGRRLNAM,DGRRFNAM,DGRRSSN,DGRRPROV,DGRRSTN,DGRRMNM,DGRRDATE)
 K ^TMP($J,"PLUQRY")
 M ^TMP($J,"PLUQRY")=@DGRRARR
 I '$D(^TMP($J,"PLUQRY",1))!($G(^TMP($J,"PLUQRY",1))=0) D  Q
 .S ERRMESS="No records found."
 .D FINALLY
 N DGRRI,DGRRCNT
 S (DGRRI,DGRRCNT)=0
 F  S DGRRI=$O(^TMP($J,"PLUQRY",DGRRI)) Q:DGRRI=""  D
 .N DGRR0,DGRR1,DGRR2,DGRR3,DGRR4,DGRRVPID,DGRRIEN,DGRRNM,DGRRSSN,DGRRDOB,DGRRSEX
 .S DGRRCNT=DGRRCNT+1
 .; DGRR0=VPID^IEN^Last Name~First Name~Middle Name^SSN^DOB^SEX
 .S DGRR0=$G(^TMP($J,"PLUQRY",DGRRCNT,0))
 .S DGRR1=$G(^TMP($J,"PLUQRY",DGRRCNT,1))  ;Provider Type
 .S DGRR2=$G(^TMP($J,"PLUQRY",DGRRCNT,2))  ;Provider Classification
 .S DGRR3=$G(^TMP($J,"PLUQRY",DGRRCNT,3))  ;Area of Specialization
 .; DGRR4=VA Code^X12 Code^Specialty Code
 .S DGRR4=$G(^TMP($J,"PLUQRY",DGRRCNT,4))
 .S DGRRVPID=$P(DGRR0,U)
 .S DGRRIEN=$P(DGRR0,U,2)
 .S DGRRNM=$P(DGRR0,U,3)
 .S DGRRSSN=$P(DGRR0,U,4)
 .S DGRRDOB=$P(DGRR0,U,5)
 .S DGRRSEX=$P(DGRR0,U,6)
 .D FOUND
 D FINALLY
 Q
 ;
FINALLY DO ADD("<error message='"_$G(ERRMESS)_"'></error>")
 DO ADD("<maximum message=''></maximum>")
 DO ADD("<record count='"_DGRRCNT_"'></record>")
 I $G(DGRRARR)'="" K @DGRRARR
 K ^TMP($J,"PLUQRY")
 Q
 ;
FOUND ;Build XML of found records
 ;
 DO ADD("<person>")
 DO ADD("<vpid>"_$$CHARCHK^DGRRUTL(DGRRVPID)_"</vpid>")
 DO ADD("<ien>"_$$CHARCHK^DGRRUTL(DGRRIEN)_"</ien>")
 DO ADD("<lname>"_$$CHARCHK^DGRRUTL($P(DGRRNM,"~",1))_"</lname>")
 DO ADD("<fname>"_$$CHARCHK^DGRRUTL($P(DGRRNM,"~",2))_"</fname>")
 DO ADD("<mname>"_$$CHARCHK^DGRRUTL($P(DGRRNM,"~",3))_"</mname>")
 DO ADD("<ssn>"_$$CHARCHK^DGRRUTL(DGRRSSN)_"</ssn>")
 DO ADD("<dob>"_$$CHARCHK^DGRRUTL(DGRRDOB)_"</dob>")
 DO ADD("<sex>"_$$CHARCHK^DGRRUTL(DGRRSEX)_"</sex>")
 DO ADD("<providerInfo>")
 DO ADD("<type>"_$$CHARCHK^DGRRUTL($P(DGRR1,U))_"</type>")
 DO ADD("<classification>"_$$CHARCHK^DGRRUTL($P(DGRR2,U))_"</classification>")
 DO ADD("<specialization>"_$$CHARCHK^DGRRUTL($P(DGRR3,U))_"</specialization>")
 DO ADD("<VACode>"_$$CHARCHK^DGRRUTL($P(DGRR4,U))_"</VACode>")
 DO ADD("<X12Code>"_$$CHARCHK^DGRRUTL($P(DGRR4,U,2))_"</X12Code>")
 DO ADD("<SpecialityCode>"_$$CHARCHK^DGRRUTL($P(DGRR4,U,3))_"</SpecialityCode>")
 DO ADD("</providerInfo>")
 DO ADD("</person>")
 QUIT
 ;
ADD(STR) ; add string to array
 SET DGRRLINE=DGRRLINE+1
 SET @DGRRESLT@(DGRRLINE)=STR
 QUIT
