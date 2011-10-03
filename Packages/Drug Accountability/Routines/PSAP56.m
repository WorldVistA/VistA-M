PSAP56 ;VMP/PDW-DUPLICATE REMOVAL ;93/17/2006
 ;;3.0;DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**56**; 10/24/97
 ;;References to ^PSDRUG( are covered by DBIA #2095
EN ;
 D EXIT
 S VSN=0 F  S VSN=$O(^PSDRUG("AVSN",VSN)) Q:VSN'>0  D VSN
 D MAILMSG,EXIT
 Q
VSN ;
 S DRDA=0,RXCNT=0 F  S DRDA=$O(^PSDRUG("AVSN",VSN,DRDA)) Q:DRDA'>0  D DRDA
 Q
DRDA ;process drug:VSN
 ;SYN0(counter)=node, SYNIEN(counter)=SYDA
 K SYN0,SYNIEN,SYNDUP,SYNDC,SYCNT
 S SYDA=0 F  S SYDA=$O(^PSDRUG("AVSN",VSN,DRDA,SYDA)) Q:SYDA'>0  D
 . ; if more DRUG VSN decendents process the DRUG
 .I +$O(^PSDRUG("AVSN",VSN,DRDA,SYDA)) D MORE
 Q
MORE ;
 K SYN0,SYNIEN,SYNDUP,SYNDC,SYCNT
 S SYNIEN=0 F  S SYNIEN=$O(^PSDRUG("AVSN",VSN,DRDA,SYNIEN)) Q:SYNIEN'>0  D
 .S SYCNT=$G(SYCNT)+1,SYN0(SYCNT)=^PSDRUG(DRDA,1,SYNIEN,0),SYNIEN(SYCNT)=SYNIEN
 .S SYDA=SYNIEN ; reset upper loop to end of VSNs
 ;
DUPS ;compare synonyms of the identical VSN/drug found
 K SYNDUP
 ;pairs of divisions may have set the same drug with different DUOU, dups then on sereval DUOU
 ;FIND EXACT MATCHES, store pairs in SYNDUP(N1,N2)="", and DELETE ALL BUT FIRST
 F N1=1:1:SYCNT-1 F N2=N1+1:1:SYCNT I SYN0(N1)=SYN0(N2) S SYNDUP(N1,N2)=""
 I '$D(SYNDUP) Q
 D DELETE
 D LOGDUP
 Q
DELETE ;
 Q:'$D(SYNDUP)
 S N1=0 F  S N1=$O(SYNDUP(N1)) Q:N1'>0  D
 . S N2=0 F  S N2=$O(SYNDUP(N1,N2)) Q:N2'>0  D
 . . K DIK S DA(1)=DRDA,DA=SYNIEN(N2),DIK="^PSDRUG("_DA(1)_",1," D ^DIK
 . . K SYNDC(N2) ;if dup N2 is removed its NDC match to others needs to be removed
 . . K SYNDUP(N2) ; if N2 has dups they will also have been picked up under N1 already
 Q
LOGDUP ;
 S DRGNM=$P(^PSDRUG(DRDA,0),U,1)
 S SYDAL=0 F  S SYDAL=$O(SYNDUP(SYDAL)) Q:SYDAL'>0  S ^TMP($J,"PSADUP",DRGNM,DRDA,SYNIEN(SYDAL))=0
 Q
 ;SYN0(SYCNT)=^PSDRUG(DRDA,1,SYDA,0)
 ;SYNIEN(SYCNT)=SYDA
 ;S SYNDUP(N1,N2)=""
 ;S SYNDC(N1,N2)=""
MAILMSG ; generate mail message of duplicates deleted.
 K ^TMP($J,"PSAMM")
 N DIFROM
 I $D(^TMP($J,"PSADUP")) I 1
 E  G NOMSG
 S X="PSA*3*56 DELETE DUPLICATE SYNONYMS REPORT" D MMLN
 S X="The following Drug-Synonyms have had identical synonyms removed from the drug." D MMLN
 S X="" D TXT("Drug Name",1),TXT("DRG#,SYN#",43),TXT("NDC",53),TXT("VSN",68),MMLN
 S DRGNM="" F  S DRGNM=$O(^TMP($J,"PSADUP",DRGNM)) Q:DRGNM=""  D DRIEN
 S XMSUB="PSA*3*56 Delete Duplicate Drug Synonyms report"
 S XMTEXT="^TMP($J,""PSAMM"",",XMDUZ="PSA*3*56 Post Init"
 S XMY(DUZ)=""
 D ^XMD
 Q
DRIEN ;work the specific drug
 S DRDA=0 F  S DRDA=$O(^TMP($J,"PSADUP",DRGNM,DRDA)) Q:DRDA'>0  D SYNDR
 Q
SYNDR ; work synonyms under a drug
 S SYNDA=0 F  S SYNDA=$O(^TMP($J,"PSADUP",DRGNM,DRDA,SYNDA)) Q:SYNDA'>0  D SYN
 Q
SYN ;report the individual synonym that had duplicates deleted
 K SYNFLD
 ;2-NDC'2 400-VSN'4 401-OU'5 402-PPOU'6 403-DUOU'7 404-PPDU'8
 S SYN0=^PSDRUG(DRDA,1,SYNDA,0),X=SYN0,DA=SYNDA,DA(1)=DRDA,IENS=DA_","_DA(1)_","
 S NDC=$P(X,U,2),VSN=$P(X,U,4),PPOU="PPOU: $"_$P(X,U,6),DUOU="DUOU: "_$P(X,U,7),PPDU="PPDU: $"_$P(X,U,8)
 S OU="OU: "_$$GET1^DIQ(50.1,IENS,401),DA(1)=DRDA
 S X="" D TXT(DRGNM,1),TXT(DRDA_","_SYNDA,43),TXT(NDC,53),TXT(VSN,68) D MMLN
 S X="" D TXT(OU,1),TXT(PPOU,15),TXT(DUOU,45),TXT(PPDU,60) D MMLN
 Q
MMLN S MMLC=+$G(MMLC)+1 S ^TMP($J,"PSAMM",MMLC)=X Q
TXT(VAL,COL) S:'$D(X) X="" S X=$$SETSTR^VALM1(VAL,X,COL,$L(VAL)) Q
NOMSG ; report no duplicates found to remove.
 S X="PSA*3*56 DELETE DUPLICATE SYNONYMS REPORT" D MMLN
 S X=" " D MMLN
 S X="There were no duplicate drug-synonyms found. No synonyms removed." D MMLN
 S XMSUB="PSA*3*56 Delete Duplicate Drug Synonyms report"
 S XMTEXT="^TMP($J,""PSAMM"",",XMDUZ="PSA*3*56 Post Init"
 S XMY(DUZ)=""
 D ^XMD
EXIT ;
 K COL,DIK,DRDA,DRGNM,DUOU,IENS,MMLC,N1,N2,NDC,OU,PPDU,DDOU,RXCNT,SYCNT,SYDA,SYN0
 K SYNDA,SYNDC,SYNDUP,SYNFLD,SYNIEN,SYN0,^TMP($J),VAL,VSN,PPOU,SYDAL
 Q
