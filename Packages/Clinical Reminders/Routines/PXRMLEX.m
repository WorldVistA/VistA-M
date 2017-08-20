PXRMLEX ;SLC/PKR - Routines for working with Lexicon. ;03/02/2016
 ;;2.0;CLINICAL REMINDERS;**17,18,26,47**;Feb 04, 2005;Build 289
 ;
 ;==========================================
CODESYSL(CODESYSL) ;Return the list of Lexicon coding systems supported
 ;by Clinical Reminders.
 S CODESYSL("10D")="",CODESYSL("10P")=""
 S CODESYSL("CPC")="",CODESYSL("CPT")=""
 S CODESYSL("ICD")="",CODESYSL("ICP")=""
 S CODESYSL("SCT")=""
 Q
 ;
 ;==========================================
GETCSYS(CODE) ;Given a code return the coding system.
 ;Order the checking so the most commonly used coding systems
 ;are done first.
 ;
 ;ICD-9 CM diagnosis patterns.
 I CODE?3N1"."0.2N Q "ICD"
 I CODE?1"E"3N1"."0.2N Q "ICD"
 I CODE?1"V"2N1"."0.2N Q "ICD"
 ;
CHK10D ;ICD-10 CM diagnosis patterns.
 N CN,F4C,OK
 S F4C=$E(CODE,1,4)
 S OK=(F4C?1U2N1".")!(F4C?1U1N1U1".") I 'OK G CHKCPT
 S CN=$E(CODE,5),OK=(CN?1N)!(CN?1U)!(CN?1"") I 'OK G CHKCPT
 S CN=$E(CODE,6),OK=(CN?1N)!(CN?1U)!(CN?1"") I 'OK G CHKCPT
 S CN=$E(CODE,7),OK=(CN?1N)!(CN?1U)!(CN?1"") I 'OK G CHKCPT
 S CN=$E(CODE,8),OK=(CN?1N)!(CN?1U)!(CN?1"") I 'OK G CHKCPT
 Q "10D"
 ;
CHKCPT ;CPT-4 Procedure pattterns.
 I (CODE?5N)!(CODE?4N1U) Q "CPT"
 ;
CHKCPC ;HCPS Procedure patterns.
 I (CODE?1U4N) Q "CPC"
 ;
CHKICP ;ICD-9 Procedure patterns.
 I CODE?2N1"."1.3N Q "ICP"
 ;
CHKSCT ;SNOMED CT patterns.
 ;Cannot start with a 0.
 I $E(CODE,1)=0 G CHK10P
 ;If a code is 7 numeric characters it can be 10P or SCT.
 N DATA
 ;DBIA #5679
 I (CODE?7N),(+$$HIST^LEXU(CODE,"10P",.DATA)=1) Q "10P"
 I (CODE?6.18N) Q "SCT"
 ;
CHK10P ;ICD-10 Procedure patterns.
 S CN=$E(CODE,1),OK=(CN?1N)!(CN?1U) I 'OK Q "UNK"
 S CN=$E(CODE,2),OK=(CN?1N)!(CN?1U)!(CN?1"Z") I 'OK Q "UNK"
 S CN=$E(CODE,3),OK=(CN?1N)!(CN?1U) I 'OK Q "UNK"
 S CN=$E(CODE,4),OK=(CN?1N)!(CN?1U)!(CN?1"Z") I 'OK Q "UNK"
 S CN=$E(CODE,5),OK=(CN?1N)!(CN?1U)!(CN?1"Z") I 'OK Q "UNK"
 S CN=$E(CODE,6),OK=(CN?1N)!(CN?1U)!(CN?1"Z") I 'OK Q "UNK"
 S CN=$E(CODE,7),OK=(CN?1N)!(CN?1U)!(CN?1"Z") I 'OK Q "UNK"
 Q "10P"
 ;
 Q "UNK"
 ;
 ;==========================================
VCODE(CODE) ;Check that a code is valid.
 N CODESYS,DATA,IEN,RESULT,VALID
 S CODESYS=$$GETCSYS^PXRMLEX(CODE)
 I CODESYS="UNK" Q 0
 ;The code fits the pattern for a supported coding system, verify that
 ;it is a valid code.
 S VALID=0
 ;DBIA #5679
 S RESULT=$$HIST^LEXU(CODE,CODESYS,.DATA)
 I $P(RESULT,U,1)'=-1 Q 1
 I (CODESYS="CPC")!(CODESYS="CPT") D
 .;DBIA #1995
 . S RESULT=$$CPT^ICPTCOD(CODE)
 . S IEN=$P(RESULT,U,1)
 . I IEN=-1 S VALID=0 Q
 . I CODESYS="CPC",$P(RESULT,U,5)="H" S VALID=1 Q
 . I CODESYS="CPT",$P(RESULT,U,5)="C" S VALID=1 Q
 I VALID=1 Q VALID
 ;DBIA #3990
 I CODESYS="ICD" S RESULT=$$ICDDX^ICDCODE(CODE,DT,"",0)
 I CODESYS="ICP" S RESULT=$$ICDOP^ICDCODE(CODE,DT,"",0)
 S IEN=$P(RESULT,U,1)
 S VALID=$S(IEN=-1:0,1:1)
 Q VALID
 ;
 ;==========================================
VCODESYS(CODESYS) ;Make sure the coding system is one taxonomies support.
 N CODESYSL
 D CODESYSL^PXRMLEX(.CODESYSL)
 Q $S($D(CODESYSL(CODESYS)):1,1:0)
 ;
