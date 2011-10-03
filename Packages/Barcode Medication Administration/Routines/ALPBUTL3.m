ALPBUTL3 ;OIFO-DALLAS MW,SED,KC-BCBU BACKUP REPORT FUNCTIONS AND UTILITIES  ;01/01/03
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
START(DAY) ;Get current date
 D NOW^%DTC
 S Y=X
 S STARD=%I(2)
 D DD^%DT
 S MON=$E(Y,1,3)
 S LD=$S(MON="JAN":31,MON="FEB":29,MON="MAR":31,MON="APR":30,MON="MAY":31,MON="JUN":30,MON="JUL":31,MON="AUG":31,MON="SEP":30,MON="OCT":31,MON="NOV":30,MON="DEC":31)
 S LDD=LD+1
 S SP=69,CNT=0
 S SS=STARD+DAY
 I SS>LDD S SS=LDD
 I SS<LDD S LDD=SS
 F J=STARD:0 DO  Q:J=LDD
 .S SP=SP+6,CNT=CNT+1
 .W ?SP,J
 .S J=J+1
 .I J=SS Q
 I CNT'=DAY F J=1:1 DO  Q:CNT=DAY
 .S SP=SP+6,CNT=CNT+1
 .W ?SP,J
 Q
MON(DAY) ;Get the month
 D NOW^%DTC
 S Y=X
 S STARD=%I(2)
 D DD^%DT
 S MON=$E(Y,1,3)
 S LD=$S(MON="JAN":31,MON="FEB":29,MON="MAR":31,MON="APR":30,MON="MAY":31,MON="JUN":30,MON="JUL":31,MON="AUG":31,MON="SEP":30,MON="OCT":31,MON="NOV":30,MON="DEC":31)
 Q
ARRAY(DAY)   ;BUILD ARRAY FOR TO FIND NEXT MONTH
 S MONT("JAN")="FEB"
 S MONT("FEB")="MAR"
 S MONT("MAR")="APR"
 S MONT("APR")="MAY"
 S MONT("MAY")="JUN"
 S MONT("JUN")="JUL"
 S MONT("JUL")="AUG"
 S MONT("AUG")="SEP"
 S MONT("SEP")="OCT"
 S MONT("OCT")="NO"
 S MONT("NOV")="DEC"
 S MONT("DEC")="JAN"
 D NOW^%DTC
 S Y=X
 S STARD=%I(2)
 D DD^%DT
 S MON=$E(Y,1,3)
 S LD=$S(MON="JAN":31,MON="FEB":29,MON="MAR":31,MON="APR":30,MON="MAY":31,MON="JUN":30,MON="JUL":31,MON="AUG":31,MON="SEP":30,MON="OCT":31,MON="NOV":30,MON="DEC":31)
 S LDD=LD+1
 S SP=69,CNT=0
 S SS=STARD+DAY
 I SS>LDD S SS=LDD
 I SS<LDD S LDD=SS
 F J=STARD:0 DO  Q:J=LDD
 .S SP=SP+6,CNT=CNT+1
 .S J=J+1
 .I J=SS Q
 I CNT'=DAY W ?SP+6,$P(MONT(MON),"^",1)
 Q
DEFML() ; fetch and return default med log print...
 ; returns default number of med log entries to print based on entry in
 ; MED-LOG NUMBER field in BCMA BACKUP PARAMETERS file (53.71)
 N X
 S X=$S(+$P($G(^ALPB(53.71,1,2)),U,4)>0:+$P(^ALPB(53.71,1,2),U,4),1:1)
 Q X
DEFOR() ; fetch and return purge order flag...
 ; returns the number of day to hold a patient order after
 ; the Stop Date. Default is 7
 ; Based on entry in PURGE ORDER DAYS field in BCMA BACKUP
 ; PARAMETERS file (53.71)
 N X
 S X=$S(+$P($G(^ALPB(53.71,1,2)),U,2)>0:+$P(^ALPB(53.71,1,2),U,2),1:7)
 Q X
DEFPR() ; fetch and return purge patient flag...
 ; returns the number of days to hold the patient record
 ; with no orders. Default is 30
 ; Based on entry in PURGE PATIENT field in BCMA BACKUP
 ; PARAMETERS file (53.71)
 N X
 S X=$S(+$P($G(^ALPB(53.71,1,2)),U,3)>0:+$P(^ALPB(53.71,1,2),U,3),1:30)
 Q X
LSTACT ; Build a cross reference by patient by drug to keep up 
 ; with the last action of the drug. The x-ref is built but stays
 ; even if order is purged. The x-ref gets removed when the patient
 ; is purged.
 ; ^ALPB(53.1,DFN,"LSTACT",DRUG,ACTION DATE)=PERSON^ACTION
 N ALP,DRUG,DATE
 ;Q:+$G(DA(2))'>0!(+$G(DA(1))'>0)!(+$G(DA)'>0)
 ; get drug info - can be multiple
 S ALP=0 F ALP=$O(^ALPB(53.7,DA(2),2,DA(1),7,ALP)) Q:+ALP'>0  D
 . S DRUG=$P($G(^ALPB(53.7,DA(2),2,DA(1),7,ALP,0)),U,1)
 . Q:+DRUG'>0
 . S DATE=$P($G(^ALPB(53.7,DA(2),2,DA(1),10,DA,0)),U,1)
 . S ^ALPB(53.7,DA(2),"LSTACT",DRUG,(9999999-DATE))=$G(^ALPB(53.7,DA(2),2,DA(1),10,DA,0))
 Q
LACT(ALPDFN,ALPDRUG) ;  Retrieve the last action infor for a patient
 ; for a certian drug
 ; ALPDFN = Patient DFN
 ; ALPDRUG = Drug Ordable Item IEN 
 N DATA,ALP
 Q:+$G(ALPDFN)'>0 ""
 Q:+$G(ALPDRUG)'>0 ""
 I '$D(^ALPB(53.7,ALPDFN,"LSTACT",ALPDRUG)) Q ""
 S ALP=$O(^ALPB(53.7,ALPDFN,"LSTACT",ALPDRUG,0))
 S DATA=$G(^ALPB(53.7,ALPDFN,"LSTACT",ALPDRUG,ALP))
 Q DATA
