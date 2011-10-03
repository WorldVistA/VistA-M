OREORV1 ; SLC/GDU - Orderable Items Records Validation [10/15/04 09:16]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**217**;Dec 17,1997
 ;OREORV1 - Orderable Items Record Validation
 ;
 ;BUG FIX FOR NOIS CASES:
 ;DAN-0204-42157, ALB-1001-51034, SBY-0803-30443, NJH-0402-20607
 ;
 ;Scans the ^ORD(101.43, file and does the following:
 ;  1. Counts the total number of entries in ^ORD(101.43,
 ;  2. Determines if a source record ien is stored in the ID field of
 ;     file 101.43.
 ;  3. Determines if a package code is stored in the ID field of file
 ;     101.43.
 ;  4. Determines if the package code matches the expected pattern of 
 ;     99XXX (XXX are 3 upper case letters).
 ;  5. Using the interface standard (documented in OE/RR V3 Package
 ;     Interface Specifications, July 2001) it determines if the
 ;     package code is one that it can test for. If it can not be tested
 ;     for it is considered requiring manual confirmation. It counts the
 ;     number of OI records needing manual confirmation, subtotaled by
 ;     package.
 ;  6. If the OI record can be tested for a source record and one is
 ;     found it is considered validated. It counts the number of
 ;      validated OI records and gives subtotals by package. 
 ;  7. If the OI record can be tested for a source record and one is not
 ;     found it is considered invalid. It counts the number of OI records
 ;     considered invalid. It subtotals by the active flag. It subtotals
 ;     by package. It will flag active records as inactive effective
 ;     immediately.
 ;
 ;This routine builds the temp global ^TMP($J,"OIC"
 ;All of this information is written to a temporary global.
 ;This is its structure:
 ;$J    - The M system variable for job number
 ;OIC   - Orderable Item Check
 ;OIIEN - Orderable Item Internal Entry Number
 ;OIIF  - Orderable Item Inactive Flag
 ;OIN   - Orderable Item Name
 ;OIPC  - Orderable Item OIPC
 ;Note all totals are calculated at run time.
 ;^TMP($J,"OIC",0)=Total records processed
 ;^TMP($J,"OIC",1)=Total records with null ID field
 ;^TMP($J,"OIC",1,OIIEN)=Null
 ;^TMP($J,"OIC",1,"B",OIN)=OIIEN^OIIF
 ;^TMP($J,"OIC",2)=Total records with null source IENs
 ;^TMP($J,"OIC",2,OIIEN)=Null
 ;^TMP($J,"OIC",2,"B",OIN)=OIIEN^OIIF
 ;^TMP($J,"OIC",3)=Total records with null source package codes
 ;^TMP($J,"OIC",3,OIIEN)=Null
 ;^TMP($J,"OIC",3,"B",OIN)=OIIEN^OIIF
 ;^TMP($J,"OIC",4)=Total records with bad source package codes
 ;^TMP($J,"OIC",4,OIPC)=Total by package
 ;^TMP($J,"OIC",4,OIPC,OIIEN)=Null
 ;^TMP($J,"OIC",4,OIPC,"B",OIN)=OIIEN^OIIF
 ;^TMP($J,"OIC",5)=Total records not part of current specification
 ;^TMP($J,"OIC",5,OIPC)=Total by package code
 ;^TMP($J,"OIC",5,OIPC,OIIEN)=Null
 ;^TMP($J,"OIC",5,OIPC,"B",OIN)= OIIEN^OIIF
 ;^TMP($J,"OIC",6)=Total validated records
 ;^TMP($J,"OIC",6,OIPC)=Total by package code
 ;^TMP($J,"OIC",7)=Total records with no matching source records
 ;^TMP($J,"OIC",7,"A")=Total active records
 ;^TMP($J,"OIC",7,"A",OIPC)=Total by package code
 ;^TMP($J,"OIC",7,"A",OIPC,OIIEN)=Null
 ;^TMP($J,"OIC",7,"A",OIPC,"B",OIN)= OIIEN^OIIF
 ;^TMP($J,"OIC",7,"I")=Total inactive records
 ;^TMP($J,"OIC",7,"I",OIPC)=Total by package code
 ;^TMP($J,"OIC",7,"I",OIPC,OIIEN)=Null
 ;^TMP($J,"OIC",7,"I",OIPC,"B",OIN)= OIIEN^OIIF
 ;
 ;External References
 ;  $$FIND1^DIC    DBIA 2051
 ;  UPDATE^DIE     DBIA 2053
 ;  FDA^DILF       DBIA 2054
 ;  $$GET1^DIQ     DBIA 2056
 ;
OIIDIS ;Orderable Item ID Index Scan
 ;Scan the ^ORD(101.43 and builds a list of orderable items with no
 ;match in the source files.
 ;  ID    - ID, field # 2, from file 101.43
 ;  IA    - INACTIVATED, field # .1, from file 101.43.
 ;  IF    - Inactive flag
 ;          If IA is null then it is set to A for active.
 ;          If IA is not null then it is set to I for inactive.
 ;  IEN   - Internal Entry Number of record from file 101.43
 ;  NAME  - NAME, field # .01, from file 101.43
 ;  SRIEN - Source Record Internal Entry Number, 1st piece ID
 ;  SRP   - Source Record Package, 2nd piece ID
 ;  SRC   - Source Record Check
 ;          0 - source record does not exist
 ;          1 - source record exist
 ;  U     - Fileman, Kernel default delimiter variable, value of "^".
 ;          U is not newed or deleted.
 N AF,IA,ID,IF,IEN,NAME,SRIEN,SRP,SRC,X
 S U="^"
 K ^TMP($J,"OIC")
 F X=0:1:7 S ^TMP($J,"OIC",X)=0
 S IEN=0 F  S IEN=$O(^ORD(101.43,IEN)) Q:'IEN  D
 . S (ID,IF,NAME,SRIEN,SRP)="",SRC=0
 . S ^TMP($J,"OIC",0)=$$CI(^TMP($J,"OIC",0))
 . S NAME=$$GET1^DIQ(101.43,IEN,.01)
 . S ID=$$GET1^DIQ(101.43,IEN,2)
 . S IA=$$GET1^DIQ(101.43,IEN,.1)
 . S IF=$S(IA="":"A",1:"I")
 . I ID="" D BUILD(1,IEN,ID,IA,IF,NAME,SRP) Q
 . S SRIEN=$P(ID,";")
 . S SRP=$P(ID,";",2)
 . I SRIEN="" D BUILD(2,IEN,ID,IA,IF,NAME,SRP) Q
 . I SRP="" D BUILD(3,IEN,ID,IA,IF,NAME,SRP) Q
 . I SRP'?1."99"3U D BUILD(4,IEN,ID,IA,IF,NAME,SRP) Q
 . I $$PC(SRP)=0 D BUILD(5,IEN,ID,IA,IF,NAME,SRP) Q
 . S SRC=$$SRC(SRP,SRIEN)
 . I SRC>0 D BUILD(6,IEN,ID,IA,IF,NAME,SRP) Q
 . D BUILD(7,IEN,ID,IA,IF,NAME,SRP)
 Q
BUILD(NODE,OIIEN,OIID,OIIA,OIIF,OIN,OISRP) ;
 ;Build the temp OIC global
 ;Variables passed to BUILD
 ;  NODE  - Node to be written to
 ;          1 = ID field is null
 ;          2 = 1st piece of ID field is null
 ;          3 = 2nd piece of ID field is null
 ;          4 = 2nd piece of ID field is not properly formatted
 ;          5 = 2nd piece of ID field is a package code not
 ;              part of current interface specification and
 ;              must be manually validated
 ;          6 = OI record is considered valid
 ;          7 = OI record has no matching source record
 ;  OIIEN - Orderable Item IEN
 ;  OIID  - Orderable Item ID field
 ;  OIIA  - Orderable Item INACTIVE field
 ;  OIIF  - Orderable Item Inactive Flag
 ;  OIN   - Orderable Item Name
 ;  OISRP - Orderable Item Source Record Package
 ;Local variable
 ;  EM    - Error message returned by FDA^DILF
 ;  FDA   - FileMan Data Array, output of FDA^DILF, an input
 ;          array variable for UPDATE^DIE
 N EM,FDA
 S ^TMP($J,"OIC",NODE)=$$CI(^TMP($J,"OIC",NODE))
 I NODE=1!(NODE=2)!(NODE=3) D  Q
 . S ^TMP($J,"OIC",NODE,OIIEN)=""
 . S ^TMP($J,"OIC",NODE,"B",OIN)=OIIEN_U_$P(OIIA,"@")
 I NODE=4!(NODE=5) D  Q
 . S:$D(^TMP($J,"OIC",NODE,OISRP))=0 ^TMP($J,"OIC",NODE,OISRP)=0
 . S ^TMP($J,"OIC",NODE,OISRP)=$$CI(^TMP($J,"OIC",NODE,OISRP))
 . S ^TMP($J,"OIC",NODE,OISRP,OIIEN)=""
 . S ^TMP($J,"OIC",NODE,OISRP,"B",OIN)=OIIEN_U_$P(OIIA,"@")
 I NODE=6 D  Q
 . S:$D(^TMP($J,"OIC",NODE,OISRP))=0 ^TMP($J,"OIC",NODE,OISRP)=0
 . S ^TMP($J,"OIC",NODE,OISRP)=$$CI(^TMP($J,"OIC",NODE,OISRP)) Q
 S:$D(^TMP($J,"OIC",NODE,OIIF))=0 ^TMP($J,"OIC",NODE,OIIF)=0
 S ^TMP($J,"OIC",NODE,OIIF)=$$CI(^TMP($J,"OIC",NODE,OIIF))
 S:$D(^TMP($J,"OIC",NODE,OIIF,OISRP))=0 ^TMP($J,"OIC",NODE,OIIF,OISRP)=0
 S ^TMP($J,"OIC",NODE,OIIF,OISRP)=$$CI(^TMP($J,"OIC",NODE,OIIF,OISRP))
 S ^TMP($J,"OIC",NODE,OIIF,OISRP,OIIEN)=""
 I OIIF="A" D
 . D FDA^DILF(101.43,OIIEN_",",.1,"R","T","FDA")
 . D UPDATE^DIE("E","FDA",OIIEN_",","EM")
 I OIIA="" S OIIA=$$GET1^DIQ(101.43,OIIEN,.1)
 S ^TMP($J,"OIC",NODE,OIIF,OISRP,"B",OIN)=OIIEN_U_$P(OIIA,"@")
 Q
PC(PK) ;Package Check
 ;Returns 1 if it is one of the source packages in July 2001 specs doc
 ;Returns 0 if not one of the source packages in July 2001 specs doc
 ;Variable passed to PC
 ;  PK   - Package of the source record
 S PK=$S(PK="99CON":1,PK="99FHD":1,PK="99FHT":1,PK="99LRT":1,PK="99ORD":1,PK="99PRC":1,PK="99PRO":1,PK="99PSP":1,PK="99RAP":1,1:0)
 Q PK
SRC(PK,SRI) ;Source Record Check
 ;Returns 1 if source record is found, 0 if not
 ;Variables passed to SRC
 ;  PK   - Package of the source record
 ;  SRI  - Source Record IEN
 ;Local Variables
 ;  FN   - File Number of source record. Determined by package code.
 ;  FR   - Found Record, it is the return value.
 ;         It is equal to 1 if source record found, 0 if not
 ;  ORLV - Lookup Value, input variable for $$FIND1^DIC 
 N ERR,FN,FR,ORLV
 S FN=$S(PK="99CON":123.5,PK="99FHD":111,PK="99FHT":118.2,PK="99LRT":60,PK="99ORD":101.43,PK="99PRC":123.3,PK="99PRO":101,PK="99PSP":50.7,1:71)
 S ORLV="`"_SRI
 S FR=$$FIND1^DIC(FN,"","",.ORLV,"","","ERR")
 Q FR
CI(CNT) ;Counter
 ;  CNT - Counter
 S CNT=CNT+1
 Q CNT
