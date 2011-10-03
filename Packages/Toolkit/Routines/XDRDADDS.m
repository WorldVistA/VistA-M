XDRDADDS ;SF-IRMFO/TKW -  SILENT API TO ADD POTENTIAL DUPLICATE PAIR TO FILE 15 ;9/22/08  11:27
 ;;7.3;TOOLKIT;**113,124**;Apr 25, 1995;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified
ADD(XDRSLT,XDRFL,XDRFR,XDRTO) ; Add a pair to the DUPLICATE RECORD file (#15)
 ; Called from REMOTE PROCEDURE - XDR ADD POTENTIAL PATIENT DUPS
 ;  XDRSLT = OUTPUT results.
 ;    set to DFN in file 15 if add was successful, -1^ERRMSG if error
 ;  XDRFL = File number where duplicate records reside. If not passed, defaults to PATIENT file.
 ;  XDRFR = From entry IEN (DFN if PATIENT file entry)
 ;  XDRTO = To entry IEN (DFN if PATIENT file entry)
 ;  
 K XDRSLT
 N XDRGBL,XDRPN1,XDRPN2,XDRI,XDRREC1,XDRREC2,XDRFDA,XDRIEN,XDRPN1,XDRPN2
 N XDRSSN1,XDRSSN2,X,X1,X2,X3,I
 ; Default file is PATIENT file.
 S XDRFL=+$G(XDRFL)
 S:'XDRFL XDRFL=2
 S XDRGBL=$G(^DIC(XDRFL,0,"GL"))
 I (XDRGBL="")!($G(^VA(15.1,XDRFL,0))="") D  Q
 . S XDRSLT="-1^File number parameter missing or invalid" Q
 ; Check IENs to make sure they're valid
 S XDRFR=+$G(XDRFR),XDRTO=+$G(XDRTO)
 S XDRPN1=$P($G(@(XDRGBL_XDRFR_",0)")),U)
 I XDRPN1="" D  Q
 . S XDRSLT="-1^First IEN input parameter invalid" Q
 S XDRPN2=$P($G(@(XDRGBL_XDRTO_",0)")),U)
 I XDRPN2="" D  Q
 . S XDRSLT="-1^Second IEN input parameter invalid" Q
 ; If From and To Record pair are already on the Duplicate Record File save IEN and quit.
 S XDRSLT=0
 S XDRREC1=XDRFR_";"_$P(XDRGBL,U,2)
 S XDRREC2=XDRTO_";"_$P(XDRGBL,U,2)
 S X1=XDRREC1_U_XDRREC2,X2=XDRREC2_U_XDRREC1
 F I=0:0 S I=$O(^VA(15,"B",XDRREC1,I)) Q:I'>0  D  Q:XDRSLT
 . S X3=$P($G(^VA(15,I,0)),U,1,2)
 . I X3'=X1,X3'=X2 Q
 . S XDRSLT=I
 . Q
 Q:XDRSLT
 ; If patients, get SSN
 S (XDRSSN1,XDRSSN2)=""
 I XDRFL=2 D
 . S X=$$GET1^DIQ(2,XDRFR_",",.09) S:X]"" XDRSSN1=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10)
 . S X=$$GET1^DIQ(2,XDRTO_",",.09) S:X]"" XDRSSN2=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10)
 . Q
 ; Add new record to DUPLICATE RECORD file.
 K XDRFDA,XDRIEN
 S XDRFDA(15,"+1,",.01)=XDRREC1
 S XDRFDA(15,"+1,",.02)=XDRREC2
 S XDRFDA(15,"+1,",.03)="P"
 S XDRFDA(15,"+1,",.06)=DT
 S XDRFDA(15,"+1,",.09)=.5
 F I=.15,.16,.17,.18,.19 S XDRFDA(15,"+1,",I)=0
 D UPDATE^DIE("","XDRFDA","XDRIEN")
 S I=+$O(XDRIEN(0)),I=$G(XDRIEN(I))
 I 'I D  Q
 . S XDRSLT="-1^Error adding record to DUPLICATE RECORD file" Q
 S XDRSLT=I
 ; Send a notice to the DUPLICATE MANAGER MAIL GROUP if the
 ; SEND NEW DUP REC EMAIL field is not set to 1 (suppress). (XT*7.3*113)
 S X=$$GET1^DIQ(15.1,XDRFL_",",99,"I")
 Q:X=1
 D SENDMSG(XDRFL,XDRFR,XDRPN1,XDRSSN1,XDRTO,XDRPN2,XDRSSN2,XDRSLT)
 Q
 ;
SENDMSG(XDRFL,XDRFR,XDRPN1,XDRSSN1,XDRTO,XDRPN2,XDRSSN2,XDRNEWR) ; Send email message
 N XDRGRP,XDRGRPN,XMY,XMTEXT,XMSUB,XMDUZ,XMDUN,XMZ,X,R
 ; Find DUPLICATE MANAGER MAIL GROUP on DUPLICATE RESOLUTION file.
 S XDRGRP=$$GET1^DIQ(15.1,"2,",.11,"I")
 S XDRGRPN=""
 S:XDRGRP>0 XDRGRPN=$$GET1^DIQ(3.8,XDRGRP,.01)
 I XDRGRPN]"" S XMY("G."_XDRGRPN)=""
 E  S XMY(.5)="" ;If no mail grp found, send msg to postmaster
 S X="PATIENT" S:XDRFL'=2 X=$P($G(^DIC(XDRFL,0)),U)
 ; Build mail message
 S R(1)="The following two "_X_" records have been found to be potential duplicates"
 S R(2)="by the MPI matching algorithm. These records have been added to the local"
 S R(3)="DUPLICATE RECORD file and assigned record number "_XDRNEWR_"."
 S R(4)="Please review these records to verify whether they are duplicates"
 S R(5)="and if so merge using the DUPLICATE RECORD MERGE software."
 S R(6)=""
 S R(7)="  "_X_" 1: "_XDRPN1_"  "_XDRSSN1_"  (IEN #"_XDRFR_")"
 S R(8)="  "_X_" 2: "_XDRPN2_"  "_XDRSSN2_"  (IEN #"_XDRTO_")"
 S XMTEXT="R(",XMSUB="Potential Duplicate "_X_" records found by MPI",XMDUZ=.5
 D ^XMD
 Q
 ;
 ;
