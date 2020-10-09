RAO7ROCN ;HISC/GJC-'DE' (error) message from OE/RR process. ; Jul 01, 2020@09:30:29
 ;;5.0;Radiology/Nuclear Medicine;**169**;Mar 16, 1998;Build 2
 ;
 ; Input: RARY=CPRS HL7 order message         
 ;        RAORD = Order control (ORC-1)
 ; ----------------------------------------------------------------------
 ;
EN1(RARY) ; 'DE' (error) message from OE/RR. File the cancel
 ;reason in the CANCEL DESCRIPTION (75.1;27) field. Note: RAORD="DE"
 ;
 ;Radiology basically ignored the "DE" message. Not anymore...
 ;
 ;OREMSG(1)="MSH|^~\&|ORDER ENTRY|16066|RADIOLOGY|16066|20200218145711-0600||ORR"
 ;OREMSG(2)="PID|||7171880||ZZZ,DUDE"
 ; PID-3 is the DFN of the patient
 ;OREMSG(3)="ORC|DE||1011^RA|||||||1786||||||Missing or invalid patient location"
 ; ORC-3.1 is the IEN of the RIS order (RAOIFN)
 ; ORC-10 is the person who entered the order (DFN of user in NEW PERSON file)
 ; ORC-16 is cancel reason to be filed as the CANCEL DESCRIPTION (75.1;27)
 ;        truncate ORC-16 to forty characters max.
 N I,RACS,RADFN,RAESC,RAFS,RANME,RAOIFN,RASEG,RAWHO,RAX,RAXX,RAY
 ;
 ;RAFS = field separator & RACS = component separator
 S RAY=+$O(RARY(0)) S RAX=$G(RARY(RAY))
 I $E(RAX,1,3)="MSH" S RAFS=$E(RAX,4),RACS=$E($P(RAX,RAFS,2),1)
 ;
 E  QUIT
 ;
 F  S RAY=$O(RARY(RAY)) Q:RAY'>0  D
 .S RAX=$G(RARY(RAY)),RASEG=$E(RAX,1,3)
 .S RAXX=$P(RAX,RAFS,2,99) ;strip of segment id
 .D @$S(RASEG="PID":"PID",RASEG="ORC":"ORC",1:"ERR")
 .Q
UPDB ;update RIS report database conditionally...
 ;If there is a study for this RIS order w/o a CPRS
 ;order IEN it's a legacy study. Don't cancel the order
 ;path: RAORDU -> RAORDC -> RAO7ROCN
 Q:$D(^RADPT("AO",RAOIFN,$G(RADFN,-1),$G(RADTI,-1),$G(RACNI,-1)))#2
 D FILE
 Q
 ;
FILE ;file data in REQUEST STATUS (fld: 5) and CANCEL
 ;DESCRIPTION (fld: 27)
 L +^RAO(75.1,RAOIFN):$G(DILOCKTM,25)
 I '$T QUIT
 N RAERR,RAFDA,RAIEN,RAPROC S RAIEN=RAOIFN_","
 S RAOIFN(0)=$G(^RAO(75.1,RAOIFN,0))
 S RAPROC=$E($P($G(^RAMIS(71,+$P(RAOIFN(0),U,2),0)),U),1,30) ;1st 30 of proc name
 S RAFDA(75.1,RAIEN,5)=13 ;cancelled **new ** (keep consistent spelling)
 S RAFDA(75.1,RAIEN,27)=RAREA
 D FILE^DIE("","RAFDA","RAERR")
 I $D(RAERR)#2 L -^RAO(75.1,RAOIFN) QUIT
 ;update (#75) REQUEST STATUS TIMES @75.12
 K RAFDA,RAIEN S RAIEN="+1,"_RAOIFN_","
 S RAFDA(75.12,RAIEN,.01)=$E($$NOW^XLFDT(),1,12)
 S RAFDA(75.12,RAIEN,2)=13 ;canceled
 S RAFDA(75.12,RAIEN,3)=+RAWHO
 D UPDATE^DIE("","RAFDA")
 L -^RAO(75.1,RAOIFN)
 W !!,"Order for ",RAPROC," has been rejected by CPRS.",!,"Reason: ",RAREA
 ;b/c the order is canceled we need to make sure we're exiting
 ;RA ORDEREXAM 'Request an Exam'
 ; RAOUT: checked in ADDORD1^RAORD1
 ;RADERR: checked in RAORDQ
 S (RAOUT,RADERR)=1
 Q
 ;
PID ; PID segment
 S RADFN=$P(RAXX,RAFS,3) ;DFN file 2
 S RANME=$P(RAXX,RAFS,5) ;patient name: last, first middle
 Q
 ;
ORC ;ORC segment
 ;IEN file 75.1 of RIS order canceled
 S RAOIFN=+$P(RAXX,RAFS,3)
 ;IEN file 200 or empty 
 S RAWHO=$P(RAXX,RAFS,10)
 ;cancel description or empty found in
 ;SN/SNQ^ORMRA.
 S RAREA=$E($P(RAXX,RAFS,16),1,40) ;safety first... :')
 Q
 ;
TXT ;for testing only...
 S OREMSG(1)="MSH|^~\&|ORDER ENTRY|16066|RADIOLOGY|16066|20200218145711-0600||ORR"
 S OREMSG(2)="PID|||7171880||ZZZ,DUDE"
 ; PID-3 is the DFN of the patient
 S OREMSG(3)="ORC|DE||1026^RA|||||||1787||||||Missing or invalid patient location"
 Q
 ;
