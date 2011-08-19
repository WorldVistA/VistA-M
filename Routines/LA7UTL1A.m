LA7UTL1A ;HOIFO/BH - Microbiology Query Utility ; 3/11/03 10:45am
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**69**;Sep 27, 1994
 ;
 ;
GETDATA(LRDFN,LASDT,LAEDT,LASEARCH,RESULTS) ;
 ;
 ;    Input:
 ;
 ;    LRDFN - Lab DFN
 ;    LASDT - Search Start Date
 ;    LAEDT - Search End Date
 ;    LASEARCH - Set to CD (collection date) or RAD (completion date).
 ;    RESULTS - Closed root destination array reference
 ;
 ;    Output:
 ;    If an error is found with the input variables one for the
 ;    strings will be returned.
 ;
 ;       -1^Start date is after end date
 ;       -2^No return array global
 ;       -3^Global array only
 ;       -4^No Patient lab DFN
 ;       -5^No Start Date Range
 ;       -6^No End Date Range
 ;
 ;  If there are no errors with the input variables the processing
 ;  will return '1'.  If there is no data in the passed in global
 ;  there was no data available for the patient.
 ;
 ;  If there is data available for the patient the routine will pass 
 ;  back the following data (the example assumes the passed in closed 
 ;  root global was "^TMP($J)"):
 ;
 ;  Fields .01 (Accession date),.05 (Site Specimen),.055 (Sample Type),
 ;  .06 (Accession #),11.51 (Sterility Control),11.57 (Urine Screen),
 ;  11.58 (Sputum Screen), 22 (TB RPT Date Approved), 23 (TB RPT Status),
 ;  24 (ACID Fast Stain), 25 (Quantity) and .99 (Specimen Comment) from 
 ;  the top node in the following format;
 ;    
 ;  ^TMP($J,LRDFN,Record_IEN,"0",Field #,"E" or "I")=Field Data
 ;    
 ;  Field .01 of sub file 63.29 - Gram Stain - in the following format
 ;
 ; ^TMP($J,LRDFN,Record_IEN,"2",Sub File IEN,"0",Field #,"E" or "I")=Data
 ;
 ;  Field .01 (Organism) and 1 (Quantity) of sub file 63.3 in the 
 ;  following format;
 ;  
 ; ^TMP($J,LRDFN,Record_IEN,"3",Sub File IEN,"0",Field #,"E" or "I")=Data
 ;
 ;   Within the Organism data there is an antibiotic multiple.  The 
 ;   routine returns the antibiotic (.01) along with the Mic (field #1) 
 ;   and Mbc (field #2) from the sub file 63.32 in the following format;
 ;
 ;   ^TMP($J,LRDFN,Record_IEN,"3",Sub File IEN,"3",Sub-Sub File IEN,"0"
 ;   ,Field #,"E" or "I")=Data
 ;
 ;
 ;  Organisms can potentially have specific antibiotics associated with 
 ;  them. This API pulls any of the Antibiotics (along with their 
 ;  interpretation and screen) that have been entered in the antibiotic
 ;  fields that exist within the standard Lab DD.  Within this sub file
 ;  these fields are numbered between 5 and 160.2 and have node numbers
 ;  that begin with the numbers 2.00.
 ;  It is also possible for sites to enter their own specific named 
 ;  antibiotics within this multiple using a lab option.  This option 
 ;  creates a new node number for the new antibiotic entry that is 
 ;  comprised in the
 ;  following way "2.00"_site #_n (where n is an incremented number).
 ;  This node number also becomes the field number for this antibiotic.
 ;  The interpretation and screen values of these antibiotics should
 ;  follow a pattern where interpretation field number is comprised as
 ;  follows "2.00"_site #_n_1 and the screen is "2.00"_site #_n_2.
 ;
 ;  However only antibiotics have been entered in the standard Organism
 ;  DD will get extracted.  Any antibiotics entered into the site 
 ;  specified fields will not get extracted.
 ;
 ;  ^TMP($J,LRDFN,Record_IEN,"3",Sub File IEN,"0",Field #,"I")=data
 ;  ^TMP($J,LRDFN,Record_IEN,"3",Sub File IEN,"0",Field #,"E")=field name
 ;                                                             ^data
 ;
 ;  Note the "E" node contains the field name and it's related data.
 ;
 ;
 ;    Within the Organism data there is a comment multiple which the
 ;    routine also returns.  
 ;    Field .01 Comment of sub file 63.31 in the following format;
 ; 
 ;   ^TMP($J,LRDFN,Record_IEN,"3",Sub File IEN,"1",Sub-Sub File IEN,"0"
 ;   ,Field #,"E" or "I")=Data
 ;
 ;  Field .01 Bact RPT Remark of sub file 63.33 in the following format;
 ;
 ; ^TMP($J,LRDFN,Record_IEN,"4",Sub File IEN,"0",Field #,"E" or "I")=Data
 ;
 ;  Field .01 Parasite of sub file 63.34 in the following format;
 ;
 ; ^TMP($J,LRDFN,Record_IEN,"6",Sub File IEN,"0",Field #,"E" or "I")=Data
 ;
 ;   Within Parasite data there is a stage code multiple that the routine
 ;   also returns.
 ;   Fields .01 Stage code and 1 Quantity of sub file 63.35 in the 
 ;   following format;
 ;
 ;   ^TMP($J,LRDFN,Record_IEN,"6",Sub File IEN,"1",Sub-Sub File IEN,"0"
 ;   ,Field #,"E" or "I")=Data
 ;
 ;     Within the Stage Code multiple there can be a Stage Code Comment
 ;     multiple that this routine also returns;
 ;     Field .01 of the Stage Code Comment Multiple 63.351 in the 
 ;     following format;
 ;
 ;     
 ;     ^TMP($J,LRDFN,Record_IEN,"6",Sub File IEN,"1",Sub-Sub File IEN,"1"
 ;     ,Sub Sub Sub File IEN,"0",Field #,"E" or "I")=Data)
 ;
 ;  Field .01 Parasite RPT Remark 63.36 in the following format;
 ; 
 ; ^TMP($J,LRDFN,Record_IEN,"7",Sub File IEN,"0",Field #,"E" or "I")=Data
 ;
 ;  Field .01 Fungus/Yeast and field 1 Quantity of sub file 63.37 in the
 ;  following format;
 ;
 ; ^TMP($J,LRDFN,Record_IEN,"9",Sub File IEN,"0",Field #,"E" or "I")=Data
 ;
 ;    Within the Fungus/Yeast data there is a comment multiple which the
 ;    routine also returns.  
 ;    Field .01 Comment of sub file 63.372 in the following format;
 ;
 ;   ^TMP($J,LRDFN,Record_IEN,"9",Sub File IEN,"1",Sub-Sub File IEN,"0"
 ;   ,Field #,"E" or "I")=Data
 ;
 ;
 ;  Field .01 Mycobacterium and field 1 Quantity of sub file 63.39 in 
 ;  the following format;
 ;
 ; ^TMP($J,LRDFN,Record_IEN,"12",Sub File IEN,"0",Field #,"E" or "I")
 ;                                                                 =Data
 ;  Mycobacterium can potentially have antibiotics associated with them. 
 ;  This API pulls any of the Antibiotics that have been entered in the 
 ;  antibiotic
 ;  fields that exist within the standard Lab DD.  Within this sub file
 ;  these fields are numbered between 5 and 55).
 ;  It is also possible for sites to enter their own antibiotics
 ;  within this multiple using a lab option.  This option creates a new
 ;  node number for the new antibiotic entry that is comprised in the
 ;  following way "2.00"_site #_n (where n is an incremented number).
 ;  This node number also becomes the field number for this antibiotic.
 ;
 ;  However only antibiotics have been entered in the standard 
 ;  Mycobacterium antibiotic DD will get extracted.  Any antibiotics 
 ;  entered into the site specified fields will not get extracted.
 ;
 ;  ^TMP($J,LRDFN,Record_IEN,"12",Sub File IEN,"0",Field #,"I")=data
 ;  ^TMP($J,LRDFN,Record_IEN,"12",Sub File IEN,"0",Field #,"E")
 ;                                                     =field name^data
 ;
 ;  Note the "E" node contains the field name and it's related data.
 ;
 ;
 ;
 ;    Within the Mycobacterium data there is a comment multiple which the
 ;    routine also returns.  
 ;    Field .01 Comment of sub file 63.4 in the following format;
 ;
 ;   ^TMP($J,LRDFN,Record_IEN,"12",Sub File IEN,"1",Sub-Sub File IEN,"0"
 ;   ,Field #,"E" or "I")=Data
 ;
 ;  Field .01 BACT Smear/Prep of sub file 63.291 in the following format;
 ;
 ; ^TMP($J,LRDFN,Record_IEN,"25",Sub File IEN,"0",Field #,"E" or "I")
 ;                                                                = Data
 ;
 ;  Field .01 PARA Smear/Prep of sub file 63.341 in the following format;
 ;
 ; ^TMP($J,LRDFN,Record_IEN,"24",Sub File IEN,"0",Field #,"E" or "I")
 ;                                                                =Data
 ;
 ;  Field .01 VIRUS of sub file 63.43 in the following format;
 ;
 ; ^TMP($J,LRDFN,Record_IEN,"17",Sub File IEN,"0",Field #,"E" or "I")
 ;                                                                 =Data
 ;
 ;
 ; ---------------------------------------------------------------------
 ;
 N LAARRAY,LAINX,LATYP,LAFILE,LAARRET,LACD,LACDFLD,LACDTYP,LADATA,LASET,LASUB,LA763,LATYPE
 ;
 I LASDT>LAEDT Q "-1^Start date is after end date"
 I '$D(RESULTS) Q "-2^No return array global"
 I $E(RESULTS,1,1)'="^" Q "-3^Global array only"
 I '+$G(LRDFN) Q "-4^No Patient lab DFN"
 I '$G(LASDT) Q "-5^No Start Date Range"
 I '$G(LAEDT) Q "-6^No End Date Range"
 S LAFILE=63.05,LATYPE="MI"
 ;
 ; - Used for internal processing
 S LAARRAY="^XTMP(""LA7UTL1A"",$J)"
 ; - Passed in global reference, returns results
 S LAARRET=$S($G(RESULTS)'="":RESULTS,1:"^TMP(""LA7UTL1A"","_$J_")")
 K @LAARRAY,@LAARRET
 I LASEARCH="RAD" D RAD
 I LASEARCH="CD" D CD
 ;
 Q 1
 ;
CD ; Search by collection date
 ;
 N LRIDT,LRSS,LANSDT,LANEDT
 ;
 I LASDT S LANSDT=9999999-LASDT
 I LAEDT S LANEDT=9999999-LAEDT
 ;
 S LRIDT=LANSDT
 F  S LRIDT=$O(^LR(LRDFN,LATYPE,LRIDT),-1) Q:LRIDT=""!(LRIDT<LANEDT)  D
 . D MI^LA7UTL1C(LRDFN,LRIDT,LAARRAY),ARRANGE^LA7UTL1B(LAARRAY,LAARRET)
 ;
 Q
 ;
RAD ; Search by completion date.
 ;
 N LRIDT
 S LRIDT=0
 F  S LRIDT=$O(^LR(LRDFN,LATYPE,LRIDT)) Q:'LRIDT  D
 . S LA763(0)=$G(^LR(LRDFN,LATYPE,LRIDT,0))
 . I $P(LA763(0),"^",3)>LASDT,$P(LA763(0),"^",3)<LAEDT D MI^LA7UTL1C(LRDFN,LRIDT,LAARRAY),ARRANGE^LA7UTL1B(LAARRAY,LAARRET)
 Q
 ;
 ;
 ;
