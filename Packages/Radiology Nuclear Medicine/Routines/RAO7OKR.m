RAO7OKR ;HISC/GJC-Receive OE/RR accept/reject msg (backdoor) ;1/5/95  08:54
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
 ;------------------------- Variable List -------------------------------
 ; RAECH="^~\&"                       RAECH(1)="^"
 ; RAECH(2)="~"                       RAECH(3)="\"
 ; RAECH(4)="&"                       RAHLFS="|"
 ; RAHLFS(0)=50 "|"'s                 RAERR='0' if msg ok, else '1'
 ; RASEG=each node of the message     RADATA=node minus the seg. header
 ; RAPID3=Pat. Id (IEN in ^DPT)       RAPID5=Pat. name (.01 fld of ^DPT)
 ; RAORC1=order control               RAORC2=placer order # OE/RR (100)
 ; RAORC3=filler order # RAD (75.1)   RAORC16=order control reason
 ; ----------------------------------------------------------------------
EN1(RAMSG) ; Pass in the message from OE/RR.  Decipher information.
 N RADATA,RAECH,RAORC1,RAORC2,RAORC3,RAORC16,RAPID3,RAPID5
 N RAHLFS,RASEG,X S (RAERR,X)=0
 D EN1^RAO7UTL ; setup field seperator data (see var list)
 F  S X=$O(RAMSG(X)) Q:X'>0  D
 . S RASEG=$G(RAMSG(X)) Q:$P(RASEG,RAHLFS)="MSH"  ; quit if MSH segment
 . S RADATA=$P(RASEG,RAHLFS,2,999)
 . D @$S($P(RASEG,RAHLFS)="PID":"PID",1:"ORC")
 . Q
 ; validate data
 S RAERR=$$EN3^RAO7VLD(75.1,RAORC3) S:RAERR RAERR=22 Q:RAERR
 ; *** quit on non-match of either the patient ien or patient name ***
 S RAERR=$$EN2^RAO7VLD(2,RAPID3,RAPID5) S:RAERR RAERR=2 Q:RAERR
 ; ***** set flag to '1' if the data was not filed properly *****
 S RAERR=$$FILE(RAORC2,RAORC3) S:RAERR RAERR=26
 Q
FILE(RAX,RAY) ; File data into 75.1 using FM21 DBS
 ; 'RAX' is placer order # (OE/RR), 'RAY' is filler order # (Rad)
 ; returns '0' for proper filing, '1' when an error is encountered
 N RADBS,RAFDA
 ; setup FDA_ROOT for DBS call i.e, RAFDA(file # , ien_"," , fld #)=value
 S RAFDA(75.1,RAY_",",7)=RAX
 D FILE^DIE("K","RAFDA","RADBS(""ERROR"")")
 Q $S($D(RADBS("ERROR","DIERR"))#2:1,1:RAERR)
PID ; breakdown the 'PID' segment
 S RAPID3=$P(RADATA,RAHLFS,3),RAPID5=$P(RADATA,RAHLFS,5)
 Q
ORC ; breakdown the 'ORC' segment
 ; RAORC1 will either be 'NA' number assigned, or 'DE' data errors
 S RAORC1=$P(RADATA,RAHLFS),RAORC2=+$P(RADATA,RAHLFS,2)
 S RAORC3=+$P(RADATA,RAHLFS,3),RAORC16=$P(RADATA,RAHLFS,16)
 Q
