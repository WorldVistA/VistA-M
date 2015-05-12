DVBAB1A ;ALB/GAK - CAPRI Exam Complete Email Driver ; 03/13/2013 11:23 AM
 ;;2.7;AMIE;**185,187,189**;Apr 10, 1995;Build 22
 ;
 Q
 ; 
MSG2(ERR,DUZ,RIEN,ELIST) ;
 ;
 ;DUZ     PERSON FILE DFN
 ;RIEN    2507 REQUEST IEN #396.3
 ;ELIST   2507 EXAM LIST #396.4
 ;
 N DVBOPEN,DVBOPENS,DVBOPENC,J
 N PNAM,PSSN,CNUM,ERR3,ERR2,ERR4,RTN,RTN2,XX
 ;N POE
 N MSG1,MERR1,CTR1
 N MSG2,MERR2,CTR2
 N CLMTYP
 N EIEN,EARY,EERR,ENAM,ESTA
 N XMTEXT,L,XMSUB,XMY
 N MSG,MERR
 ;
 S ERR=""
 I DUZ="" S ERR="NO DUZ PASSED" Q ERR
 I RIEN="" S ERR="NO REQUEST IEN PASSED" Q ERR
 I $D(ELIST)'>1 S ERR="NO EXAM LIST PASSED" Q ERR
 ;
 K ^TMP($J,"DVBAB1A")
 K ^TMP($J,"AMIE")
 K ^TMP($J,"AMIE1")
 ;
 S J=""
 F  S J=$O(ELIST(J)) Q:J=""  D
 . S ^TMP($J,"DVBAB1A","ELIST",J)=J
 ;
 ;Determine and count number of open exams on 2507 request
 S DVBOPEN=""
 S DVBOPENS=0,DVBOPENC=0
 D FINDEXAM^DVBAB1(.DVBOPEN,RIEN)
 S J="" F  S J=$O(DVBOPEN(J)) Q:J=""  D
 . I $E(DVBOPEN(J),($L(DVBOPEN(J))-5),$L(DVBOPEN(J)))="[OPEN]" S DVBOPENS=1,DVBOPENC=DVBOPENC+1
 ;
 ;Determine patient name, SSN and C-Number
 S (PNAM,PSSN,CNUM,ERR3,ERR2,RTN,RTN2,XX)=""
 K RTN,ERR3
 D GETS^DIQ(396.3,RIEN,".01","I","RTN","ERR3")
 I $D(RTN) D
 . S XX=""_".01;.09;.313"_""
 . K RTN2,ERR2
 . D GETS^DIQ(2,RTN(396.3,RIEN_",",.01,"I"),XX,"E","RTN2","ERR2")
 . S PNAM=$G(RTN2(2,RTN(396.3,RIEN_",",.01,"I")_",",.01,"E"))
 . S PSSN=$G(RTN2(2,RTN(396.3,RIEN_",",.01,"I")_",",.09,"E"))
 . S CNUM=$G(RTN2(2,RTN(396.3,RIEN_",",.01,"I")_",",.313,"E"))
 S:'$D(PNAM) PNAM=""
 S:'$D(PSSN) PSSN=""
 S:'$D(CNUM) CNUM=""
 ;
 ;Build Exam Array Info
 K ^TMP($J,"DVBAB1A","ELIST")
 S J=""
 F  S J=$O(ELIST(J)) Q:J=""  D
 . S EIEN=ELIST(J)
 . K EARY,EERR
 . D GETS^DIQ(396.4,EIEN,".03;.04","IE","EARY","EERR")
 . Q:'$D(EARY(396.4,EIEN_",",.03,"E"))
 . S ENAM=$G(EARY(396.4,EIEN_",",.03,"E"))
 . S ESTA=$G(EARY(396.4,EIEN_",",.04,"E"))
 . S ^TMP($J,"DVBAB1A","ELIST",J)=ENAM_$E("                                   ",1,35-$L(ENAM))_" "_ESTA
 ;
 ;Determine Priority of Exam
 ;K ERR4
 ;S POE=$$GET1^DIQ(396.3,RIEN_",",9,"E","","ERR4")
 ;I '$D(POE) S POE=""
 ;
 ;Build Claim Type Info
 N MSG1,MERR1,CTR1
 K ^TMP($J,"DVBAB1A","CT")
 S MSG1="",MERR1="",CTR1=1
 D GETS^DIQ(396.3,RIEN_",","9.1*","E","MSG1","MERR1")
 I $G(MERR1)'="" S ^TMP($J,"DVBAB1A","CT",CTR1)="ERROR GETTING CLAIM TYPE CODES"
 S J=""
 F  S J=$O(MSG1(396.32,J)) Q:J=""  D
 . S CTR1=CTR1+1
 . S ^TMP($J,"DVBAB1A","CT",CTR1)=$G(MSG1(396.32,J,.01,"E"))
 ;
 ;Build Special Considerations Info
 N MSG2,MERR2,CTR2
 K ^TMP($J,"DVBAB1A","SC")
 S MSG2="",MERR2="",CTR2=1
 D GETS^DIQ(396.3,RIEN,"50*","IE","MSG2","MERR2")
 I $G(MERR2)'="" S ^TMP($J,"DVBAB1A","SC",CTR2)="ERROR GETTING SPECIAL CONSIDERATION CODES"
 S J=""
 F  S J=$O(MSG2(396.31,J)) Q:J=""  D
 . S CTR2=CTR2+1
 . S ^TMP($J,"DVBAB1A","SC",CTR2)=$G(MSG2(396.31,J,.01,"E"))
 ;
 ;
 D ONEEMAIL
 ;
 K ^TMP($J,"DVBAB1A","ELIST")
 K ^TMP($J,"DVBAB1A","CT")
 K ^TMP($J,"DVBAB1A","SC")
 K ^TMP($J,"AMIE")
 K ^TMP($J,"AMIE1")
 I $D(ERR) Q ERR
 ;
 Q
 ;
 ;
 ;
ONEEMAIL ;
 K ERR
 N DVBA0,DVBADFN,DVBASITE,DVBADT,DVBAREQ,DVBAEA
 S XMDUZ=DUZ
 ;following call supported by IA 3858
 N DUZ
 ;SINCE MAILMAN DOES NOT ALLOW MESSAGES TO BE SENT FROM USERS WITHOUT ACCESS CODES OR MAILBOXES
 ;WHICH CAPRI REMOTE USER DO NOT HAVE, WE HAVE TO NEW DUZ AND CHANGE XMDUZ TO THE NAME OF THE USER
 ;AS A STRING SO THE PROCESS IS STILL LINKED TO THE USER SENDING/TRIGGERING THE MESSAGE
 ;
 S XMDUZ=$P($G(^VA(200,XMDUZ,0)),"^",1)_" CAPRI"
 I $G(^DVB(396.3,RIEN,0))="" S ERR="INVALID REQUEST 396.3 TOP NODE" Q
 S DVBA0=$G(^DVB(396.3,RIEN,0))
 S DVBADFN=$P(DVBA0,"^",1),DVBAREQ=$P(DVBA0,"^",4),DVBADT=$$FMTE^XLFDT($P(DVBA0,"^",2))
 ;following call supported by IA 3858
 ;rra 938270 make sure email address exists prior to attempting to send notification
 S DVBAEA=$P($G(^VA(200,DVBAREQ,.15)),"^",1)
 I DVBAEA="" Q
 S XMY(DVBAEA)=""
 ;
 S DVBASITE=$$SITE^VASITE
 I '$D(DVBASITE) S DVBASITE="^"
 ;
 S XMSUB="CAPRI: Completion of 2507 Exams"
 ;
 S L=0
 S L=L+1
 S ^TMP($J,"AMIE",L)="The following veteran had one or more 2507 exams completed.",L=L+1
 I DVBOPENS=0 S ^TMP($J,"AMIE",L)="A 2507 request as described below has been completed and released to the regional office and is now available in CAPRI.",L=L+1
 S ^TMP($J,"AMIE",L)=" ",L=L+1
 S ^TMP($J,"AMIE",L)="DFN: `"_DVBADFN_"       SITE: "_$P($G(DVBASITE),"^",2)_"       Request Date: "_DVBADT
 S L=L+1
 S ^TMP($J,"AMIE",L)=" ",L=L+1
 ;
 S ^TMP($J,"AMIE",L)="  Special Consideration(s):",L=L+1
 S J=""
 F  S J=$O(^TMP($J,"DVBAB1A","SC",J)) Q:J=""  D
 . S ^TMP($J,"AMIE",L)="    "_^TMP($J,"DVBAB1A","SC",J),L=L+1
 S ^TMP($J,"AMIE",L)=" ",L=L+1
 ;
 ;S ^TMP($J,"AMIE",L)="  Priority of Exam: "_POE,L=L+1
 ;S ^TMP($J,"AMIE",L)=" ",L=L+1
 ;
 S ^TMP($J,"AMIE",L)="  Claim Type:",L=L+1
 S J=""
 F  S J=$O(^TMP($J,"DVBAB1A","CT",J)) Q:J=""  D
 . S ^TMP($J,"AMIE",L)="    "_^TMP($J,"DVBAB1A","CT",J),L=L+1
 S ^TMP($J,"AMIE",L)=" ",L=L+1
 ;
 S ^TMP($J,"AMIE",L)="Exam(s)",L=L+1
 S ^TMP($J,"AMIE",L)="   EXAM TYPE                          STATUS",L=L+1
 ;
 S J=""
 F  S J=$O(^TMP($J,"DVBAB1A","ELIST",J)) Q:J=""  D
 . S ^TMP($J,"AMIE",L)="   "_^TMP($J,"DVBAB1A","ELIST",J),L=L+1
 ;
 S ^TMP($J,"AMIE",L)=" ",L=L+1
 S ^TMP($J,"AMIE",L)=" ",L=L+1
 ;
 I DVBOPENS=1 S ^TMP($J,"AMIE",L)="*** Number of exams still open on this request: "_DVBOPENC_" ***",L=L+1
 I DVBOPENS=0 S ^TMP($J,"AMIE",L)="*** This is the last exam to be completed on this 2507 request. ***",L=L+1
 ;
 S ^TMP($J,"AMIE",L)=" ",L=L+1
 S ^TMP($J,"AMIE",L)=" ",L=L+1
 S ^TMP($J,"AMIE",L)="** NOTE: To view the patient using the DFN, paste the DFN number into the CAPRI **",L=L+1
 S ^TMP($J,"AMIE",L)="** Patient Selector 'Patient ID' field to find the patient. Be sure to include  **",L=L+1
 S ^TMP($J,"AMIE",L)="** the ` (backward-apostrophe) character.                                       **",L=L+1
 S ^TMP($J,"AMIE",L)=" ",L=L+1
 S ^TMP($J,"AMIE",L)="*****This is an auto-generated email.  Do not respond to this email address.*****",L=L+1
 ;
 S XMTEXT="^TMP($J,""AMIE"","
 ;
 D ^XMD
 ;
 I $D(XMMG) S ERR=XMMG
 I $D(XMZ) S ERR="MESSAGE SENT"
 ;
 Q
