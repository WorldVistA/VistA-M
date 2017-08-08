HMPMONX ;ASMR/BL,JCH, ^XTMP size support code ;Jan 20, 2017 17:18:18
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ; DE6644 - refactored, fixes to remote procedures, 7 September 2016
 ;
XTMPSIZE() ; function, eHMP storage in ^XTMP in kilobytes
 Q $J($$GETSIZE^HMPUTILS/1024,5,2)_" KB"  ; formatted
 ;
SIZE(HMPRSLT) ; remote procedure HMP GLOBAL SIZE returns ^XTMP size in kilobytes, HMPRSLT passed by ref.
 K HMPRSLT S HMPRSLT(1)=$J($$GETSIZE^HMPUTILS/1024,5,2)_" KB" Q
 ;
CHKXTMP(HMPRSLT) ; remote procedure HMP CHKXTMP, return data about ^XTMP, HMPRSLT passed by ref.
 ; returns 2 '^' delimited, lines, 1st line is value headers, 2nd line is the values
 ; Goes through ^XTMP, gets total patients, patients complete, and patients staging
 ; PTCNT - patient counter and list
 ; PTSTG - staging counter and list
 ;
 N ND,BTCH,PTCNT,PTIEN,PTSTG,S,SRVR,T,Y
 K HMPRSLT  ; clear any residual data
 S SRVR=$$GETSRVR^HMPMONM
 ; must have server
 I '(SRVR>0) S HMPRSLT(1)="Error^",HMPRSLT(2)="*server not found*" Q
 ;
 S SRVR(0)=^HMP(800000,SRVR,0),PTCNT=0,PTSTG=0  ; total and staging counts
 S ND="HMPFS~"_$P(SRVR(0),U)_"~",ND("L")=$L(ND)  ; starting node
 S BTCH=ND_"9999999"  ; past all dates
 F  S BTCH=$O(^XTMP(BTCH),-1) Q:'($E(BTCH,1,ND("L"))=ND)  D   ; iterate in reverse
 . S T=0 F  S T=$O(^XTMP(BTCH,T)) Q:'T  S Y=$G(^(T)) D:Y  ; only patients
 ..  S PTIEN=+Y,S=$P(Y,U,6) S:'$D(PTCNT(PTIEN)) PTCNT(PTIEN)="",PTCNT=PTCNT+1 Q:S  ;if S, domain done
 ..  Q:$D(PTSTG(PTIEN))  ; already counted
 ..  S PTSTG=PTSTG+1,PTSTG(PTIEN)=""
 ;
 S HMPRSLT(1)="site hash^site local date time^Patients in queue^Patients complete^Patients staging^XTMP('HMP') bytes^XTMP('HMP') objects"
 S HMPRSLT(2)=$$SYS^HMPUTILS_"^"_$$NOW^HMPMONL_"^"_PTCNT_"^"_(PTCNT-PTSTG)_"^"_PTSTG_"^"_$$GETSIZE^HMPUTILS
 Q
 ;
