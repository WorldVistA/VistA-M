DVBAXML ;ALB/GAK - CAPRI Exam Complete Email Driver ; 8/29/13 10:39am
 ;;2.7;AMIE;**186**;Apr 10, 1995;Build 21
 ;
 ;
FILEIN(MSG,EXAMIEN,DAS,XML) ;Entry point
 ;
 ;RPC: DVBA CAPRI EXAM XML
 ;
 ; Y Returns successful filing status or error message
 ; EXAMIEN is the IEN of the 2507 EXAM file entry #396.4
 ; DAS is the XML DAS Conformation message
 ; XML is the array list format of the template being stored
 ;
 S MSG=""
 I $G(EXAMIEN)="" S MSG="ERROR EXAM IEN IS MISSING" Q MSG
 I $G(DAS)="" S MSG="ERROR DAS Conformation IS MISSING" Q MSG
 I $D(XML)<10 S MSG="ERROR XML MESSAGE IS MISSING" Q MSG
 ;
 N WPERR,ERRMSG,DVBAFDA,DVBAERR,DATTIM,Y,X,%,%H
 ;
 S %H=$H
 D YX^%DTC
 S DATTIM=X_%
 ;
 S DAS=$E(DAS,1,250)
 ;
 ;
 D WP^DIE(396.4,EXAMIEN_",",72,"K","XML","WPERR")
 I $D(WPERR) D  Q MSG
 . S ERRMSG=""
 . S ERRMSG=$G(WPERR("DIERR",1,"TEXT",1))
 . S MSG="ERROR XML MESSAGE DID NOT FILE "_ERRMSG
 S MSG="SUCCESSFUL"
 ;
 S DVBAFDA(396.4,EXAMIEN_",",73)=DAS
 S DVBAFDA(396.4,EXAMIEN_",",74)=DATTIM
 D FILE^DIE("","DVBAFDA","DVBAERR")
 ;
 ;
 Q MSG
LINK(RV,EXAMIEN,TIUIEN) ;Link Exam TIU document
 ;
 ; RPC: DVBA CAPRI EXAM LINK TIU
 ;
 ; RV - return value; returns 1 if the exam has been successfully
 ;      linked to the TIU Document; otherwise return 0^error message
 ; EXAMIEN - the exam ien in CAPRI TEMPLATES #396.17
 ; TIUIEN  - the tiu ien in TIU DOCUMENT #8925
 ;
 I +$G(EXAMIEN)=0 S RV="0"_U_"EXAM IEN IS REQUIRED" Q
 I +$G(TIUIEN)=0 S RV="0"_U_"TIU IEN IS REQUIRED" Q
 ;
 N FDAROOT,MSGROOT
 ;
 S FDAROOT(396.17,EXAMIEN_",",23)="`"_TIUIEN
 D FILE^DIE("E","FDAROOT","MSGROOT")
 ;
 I $D(MSGROOT)=0 S RV="1"
 E  S RV="0"_U_"FAILED TO BUILD LINK FROM EXAM TO TIU"
 Q
GETEXAM(RV,TIUIEN) ;Return TIU IEN
 ;
 ; RPC: DVBA CAPRI GET EXAM IEN
 ;
 ; RV - return value; returns a integer greater than zero if the exam
 ;      can be found; otherwise return -1^error message
 ; TIUIEN - the tiu ien in TIU DOCUMENT #8925
 ;
 I +$G(TIUIEN)=0 S RV="-1"_U_"TIU IEN IS REQUIRED" Q
 ;
 S RV=$O(^DVB(396.17,"TIU",TIUIEN,0))
 I +RV<=0 S RV="-1"_U_"TIU DOCUMENT NOT CROSS REFERENCED"
 Q
