VAQDBIP7 ;ALB/JRP - CONTINUATION FOR VAQDBIP4: 3/17/2004
 ;;1.5;PATIENT DATA EXCHANGE;**13,42**;NOV 17, 1993
INSURE ;INSURANCE EXTRACTION (ALL NON-EXPIRED)
 ;  DECLARATIONS DONE IN VAQDBIP4
 ;GET LIST OF FIELDS TO EXTRACT
 S TMP=$T(INSURE+1^VAQDBII1)
 S FLDS(1)=$TR($P(TMP,";",4),",",";")
 S TMP=$T(INSURE+2^VAQDBII1)
 S FLDS(2)=$TR($P(TMP,";",4),",",";")
 S TMP=$T(INSURE+3^VAQDBII1)
 S FLDS(3)=$TR($P(TMP,";",4),",",";")
 ;ENCRYPT PATIENT NAME (ID FOR INSURANCE COMPANY & GROUP PLAN)
 S STRING=$P($$PATINFO^VAQUTL1(DFN),U,1)
 S ENCSTR=STRING
 I $$NCRPFLD^VAQUTL2(2,.01) X ENCRYPT
 S NAME=ENCSTR
 N VAQINS
 ;DETERMINE IF COVERED BY HEALTH INSURANCE & ENCRYPT
 ;S TMP=$$INSUR^IBBAPI(DFN,DT,"R",.VAQINS,"1,2,3,4,5,6,8,10,11,12,13,14,18") ; Get all active (not expired) insurance, reimbursable or not
 S TMP=$$INSUR^IBBAPI(DFN,"","ARB",.VAQINS,"1,2,3,4,5,6,8,10,11,12,13,14,18") ; Get all insurance, expired or not, reimbursable or not
 S STRING=$S(TMP:"YES",1:"NO")
 S ENCSTR=STRING
 I $$NCRPFLD^VAQUTL2(2,.3192) X ENCRYPT
 ;GET SEQUENCE NUMBER & STORE INFO
 S SEQ=$$GETSEQ^VAQDBIP(ARRAY,2,.3192)
 S @ARRAY@("ID",2,.3192,SEQ)=NAME
 S @ARRAY@("VALUE",2,.3192,SEQ)=ENCSTR
 ;EXTRACT DATA
 K ^UTILITY("DIQ1",$J)
 S TMP=0
 F  S TMP=$O(VAQINS("IBBAPI","INSUR",TMP)) Q:'TMP  D
 .;EXTRACT INSURANCE INFO
 .;Prior to patch *42, we took the info directly from file 2.
 .;Now we get it from the IB API call.
 .;PATIENT (#2) file
 .;INSURANCE TYPE (#2.312) Subfile             API field equivalent
 .;------------------------------------------  --------------------
 .;.01 INSURANCE TYPE (ptr to file 36)          1 insurance company name
 .;.18 GROUP PLAN (ptr to file 355.3)          --
 .;1   SUBSCRIBER ID                           14 subscriber ID
 .;2   *GROUP NUMBER                           --
 .;3   INSURANCE EXPIRATION DATE               11 expiration date
 .;6   WHOSE INSURANCE (v=vet;s=spouse;o=other)12 subscriber relationship
 .;7   *RENEWAL DATE                           --
 .;8   EFFECTIVE DATE OF POLICY                10 effective date
 .;16  PT. RELATIONSHIP TO INSURED             12 subscriber relationship
 .;17  NAME OF INSURED                         13 subscriber name
 .S ^UTILITY("DIQ1",$J,2.312,TMP,.01,"E")=$P(VAQINS("IBBAPI","INSUR",TMP,1),U,2)
 .S ^UTILITY("DIQ1",$J,2.312,TMP,1,"E")=VAQINS("IBBAPI","INSUR",TMP,14)
 .S ^UTILITY("DIQ1",$J,2.312,TMP,3,"E")=$$FMTE^XLFDT(VAQINS("IBBAPI","INSUR",TMP,11))
 .I VAQINS("IBBAPI","INSUR",TMP,12)[U S ^UTILITY("DIQ1",$J,2.312,TMP,6,"E")=$P(VAQINS("IBBAPI","INSUR",TMP,12),U,2)
 .E  S ^UTILITY("DIQ1",$J,2.312,TMP,6,"E")=VAQINS("IBBAPI","INSUR",TMP,12)
 .S ^UTILITY("DIQ1",$J,2.312,TMP,8,"E")=$$FMTE^XLFDT(VAQINS("IBBAPI","INSUR",TMP,10))
 .S ^UTILITY("DIQ1",$J,2.312,TMP,16,"E")=^UTILITY("DIQ1",$J,2.312,TMP,6,"E")
 .S ^UTILITY("DIQ1",$J,2.312,TMP,17,"E")=VAQINS("IBBAPI","INSUR",TMP,13)
 .;EXTRACT INFO ABOUT INSURANCE COMPANY
 .;Prior to patch *42, we took the info directly from file 36.
 .;Now we get it from the IB API call.
 .;INSURANCE COMPANY (#36) file                API field equivalent
 .;------------------------------------------  --------------------
 .;.01  NAME                                   1 insurance company name
 .;.111 STREET ADDRESS [LINE 1]                2 street address
 .;.112 STREET ADDRESS [LINE 2]                -
 .;.113 STREET ADDRESS [LINE 3]                -
 .;.114 CITY                                   3 city
 .;.115 STATE                                  4 state
 .;.316 ZIP                                    5 zip
 .;.131 PHONE NUMBER                           6 phone number
 .S ^UTILITY("DIQ1",$J,36,TMP,.01,"E")=$P(VAQINS("IBBAPI","INSUR",TMP,1),U,2)
 .S ^UTILITY("DIQ1",$J,36,TMP,.111,"E")=VAQINS("IBBAPI","INSUR",TMP,2)
 .S ^UTILITY("DIQ1",$J,36,TMP,.114,"E")=VAQINS("IBBAPI","INSUR",TMP,3)
 .S ^UTILITY("DIQ1",$J,36,TMP,.115,"E")=$P(VAQINS("IBBAPI","INSUR",TMP,4),U,2)
 .S ^UTILITY("DIQ1",$J,36,TMP,.316,"E")=VAQINS("IBBAPI","INSUR",TMP,5)
 .S ^UTILITY("DIQ1",$J,36,TMP,.131,"E")=VAQINS("IBBAPI","INSUR",TMP,6)
 .;EXTRACT INFO ABOUT GROUP PLAN
 .;Prior to patch *42, we took the info directly from file 355.3.
 .;Now we get it from the IB API call.
 .;GROUP INSURANCE PLAN (#355.3) file          API field equivalent
 .;------------------------------------------  --------------------
 .;.01 INSURANCE COMPANY (ptr to file 36)       1 insurance company name
 .;.02 IS THIS A GROUP POLICY? (1=yes/0=no)     -
 .;.03 GROUP NAME                               8 policy IEN and name
 .;.04 GROUP NUMBER                            18 policy number
 .;.1  INDIVIDUAL POLICY PATIENT (ptr to file 2)-
 .S ^UTILITY("DIQ1",$J,355.3,TMP,.01,"E")=$P(VAQINS("IBBAPI","INSUR",TMP,1),U,2)
 .S ^UTILITY("DIQ1",$J,355.3,TMP,.03,"E")=$P(VAQINS("IBBAPI","INSUR",TMP,8),U,2)
 .S ^UTILITY("DIQ1",$J,355.3,TMP,.04,"E")=VAQINS("IBBAPI","INSUR",TMP,18)
 .;GET SEQUENCE NUMBER FOR INSURANCE
 .S SEQ=$$GETSEQ^VAQDBIP(ARRAY,2.312,.01)
 .;ENCRYPT COMPANY NAME
 .S STRING=$G(^UTILITY("DIQ1",$J,2.312,TMP,.01,"E"))
 .S ENCSTR=STRING
 .I $$NCRPFLD^VAQUTL2(2.312,.01) X ENCRYPT
 .S PRIME=ENCSTR
 .;STORE COMPANY NAME/ID
 .S @ARRAY@("ID",2.312,.01,SEQ)=NAME
 .S @ARRAY@("VALUE",2.312,.01,SEQ)=PRIME
 .F X=1:1:$L(FLDS(1),";") D
 ..S Z=$P(FLDS(1),";",X)
 ..Q:(Z=.01)
 ..;STORE ID (COMPANY NAME)
 ..S @ARRAY@("ID",2.312,Z,SEQ)=PRIME
 ..;ENCRYPT/STORE VALUE
 ..S STRING=$G(^UTILITY("DIQ1",$J,2.312,TMP,Z,"E"))
 ..S ENCSTR=STRING
 ..I $$NCRPFLD^VAQUTL2(2.312,Z) X ENCRYPT
 ..S @ARRAY@("VALUE",2.312,Z,SEQ)=ENCSTR
 .;GET SEQUENCE NUMBER FOR COMPANY
 .S SEQ=$$GETSEQ^VAQDBIP(ARRAY,36,.01)
 .;ENCRYPT COMPANY NAME
 .S STRING=$G(^UTILITY("DIQ1",$J,36,TMP,.01,"E"))
 .S ENCSTR=STRING
 .I $$NCRPFLD^VAQUTL2(36,.01) X ENCRYPT
 .S PRIME=ENCSTR
 .;STORE COMPANY NAME/ID
 .S @ARRAY@("ID",36,.01,SEQ)=NAME
 .S @ARRAY@("VALUE",36,.01,SEQ)=PRIME
 .F X=1:1:$L(FLDS(2),";") D
 ..S Z=$P(FLDS(2),";",X)
 ..Q:(Z=.01)
 ..;STORE ID (COMPANY NAME)
 ..S @ARRAY@("ID",36,Z,SEQ)=PRIME
 ..;ENCRYPT/STORE VALUE
 ..S STRING=$G(^UTILITY("DIQ1",$J,36,TMP,Z,"E"))
 ..S ENCSTR=STRING
 ..I $$NCRPFLD^VAQUTL2(36,Z) X ENCRYPT
 ..S @ARRAY@("VALUE",36,Z,SEQ)=ENCSTR
 .;GET SEQUENCE NUMBER FOR GROUP PLAN
 .S SEQ=$$GETSEQ^VAQDBIP(ARRAY,355.3,.01)
 .;ENCRYPT PLAN NAME
 .S STRING=$G(^UTILITY("DIQ1",$J,355.3,TMP,.01,"E"))
 .S ENCSTR=STRING
 .I $$NCRPFLD^VAQUTL2(355.3,.01) X ENCRYPT
 .S PRIME=ENCSTR
 .;STORE PLAN NAME/ID
 .S @ARRAY@("ID",355.3,.01,SEQ)=NAME
 .S @ARRAY@("VALUE",355.3,.01,SEQ)=PRIME
 .F X=1:1:$L(FLDS(3),";") D
 ..S Z=$P(FLDS(3),";",X)
 ..Q:(Z=.01)
 ..;STORE ID (PLAN NAME)
 ..S @ARRAY@("ID",355.3,Z,SEQ)=PRIME
 ..;ENCRYPT/STORE VALUE
 ..S STRING=$G(^UTILITY("DIQ1",$J,355.3,TMP,Z,"E"))
 ..S ENCSTR=STRING
 ..I $$NCRPFLD^VAQUTL2(355.3,Z) X ENCRYPT
 ..S @ARRAY@("VALUE",355.3,Z,SEQ)=ENCSTR
 .K ^UTILITY("DIQ1",$J)
 Q
