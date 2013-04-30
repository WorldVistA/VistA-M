MAGGTRPT ;WOIFO/RED/GEK/SG - Display Associated Report ; 3/9/09 12:52pm
 ;;3.0;IMAGING;**8,48,93,122**;Mar 19, 2002;Build 92;Aug 02, 2012
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
BRK(MAGRPTY,MAGGIEN,NOCHK) ;RPC [MAGGRPT]  Call to return Image report
 ;  MAGGIEN is internal number in Image File ^MAG(2005,
 ;  NOCHK   is a Flag that tell to Not run the QA check, just return
 ;          the report.
 ;
 S MAGRPTY=$NA(^TMP($J,"WSDAT"))
 K @MAGRPTY ; clean it up first.
 S @MAGRPTY@(0)="0^Building the Image report..."
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTRPT"
 ;
 N X,Y,Z,MAGGBRK,MAGO,MAGGRPO,MAGDFN,MAGTMPR,MAGTMPRT
 N MAGNODIS,MAGTMPR2,MAGDESC,MAGISGRP,MAGQA,%ZIS,IOP
 S MAGGBRK=1,MAGISGRP=0
 S MAGO=+$P(MAGGIEN,"^")
 S NOCHK=+$G(NOCHK)
 ;
 I 'MAGO S @MAGRPTY@(0)="INVALID Image pointer: '"_MAGGIEN_"'" Q
 I $$ISDEL^MAGGI11(MAGO)  D  Q
 . S X=$$NODE^MAGGI11(MAGO)  S:X'="" X=$G(@X@(2))
 . S @MAGRPTY@(0)="0^Image : """_$P(X,U,4)_""" has been deleted."
 . Q
 ; Requesting a report, have to check Image
 ;   and Group, if this image is in a group.
 I 'NOCHK D  Q:'MAGQA(0)
 . D CHK^MAGGSQI(.MAGQA,MAGO)
 . I 'MAGQA(0) S @MAGRPTY@(0)="-2^"_$P(MAGQA(0),U,2,99) Q
 . S MAGGRPO=+$P(^MAG(2005,MAGO,0),U,10)
 . Q:'MAGGRPO  K MAGQA
 . D CHK^MAGGSQI(.MAGQA,MAGGRPO)
 . I 'MAGQA(0) S @MAGRPTY@(0)="-2^"_$P(MAGQA(0),U,2,99) Q
 ;
 S MAGDESC="",MAGDFN=$P(^MAG(2005,MAGO,0),U,7)
 ; IN check we get Desc for Report Window header,
 ;    and Define Group IEN  - MAGGRPO if it exists.
 ;    and Define MAGISGRP = 1 if this MAGO is a group itself
 D CHECK(.MAGO,MAGDFN,.MAGDESC,.MAGGRPO,.MAGISGRP)
 ; quit if NO PARENT DATA FILE and No long description.
 ;  for the Image or the Group entry
 I ($P($G(^MAG(2005,MAGO,2)),U,6)="")&('$D(^MAG(2005,MAGO,3)))&($P($G(^MAG(2005,MAGGRPO,2)),U,6)="")&('$D(^MAG(2005,MAGGRPO,3))) S @MAGRPTY@(0)="0^No Report for this Image" Q
 S IOP="IMAGING WORKSTATION",%ZIS=0 D ^%ZIS
 I POP S @MAGRPTY@(0)="0^Can't open device IMAGING WORKSTATION" K POP Q
 U IO D BUILD
 ;
 D:IO'=IO(0) ^%ZISC
 S:+$P(@MAGRPTY@(0),"^") @MAGRPTY@(0)="1^"_MAGDESC
 Q
BUILD ;
 K DIC,DIR
 N MAGDASH,DIWR,DIWL
 S $P(MAGDASH,"_",79)="_"
 ; If Child of group get PARENT DATA FILE from group
 I MAGGRPO S MAGTMPR=$G(^MAG(2005,MAGGRPO,2)),MAGTMPRT=$P(MAGTMPR,"^",6)  ;
 ; if not child of group, then get PARENT DATA FILE from original IEN
 I 'MAGGRPO S MAGTMPR=$G(^MAG(2005,MAGO,2)),MAGTMPRT=$P(MAGTMPR,"^",6)
 S DIWR=80,DIWL=1
 ;  IF This is a group call GRPDESC which will print ALL image long descriptions , not just the group long desc
 I MAGISGRP D GRPDESC^MAGGTRP1(MAGO)
 ; If not a group, then print group long desc if it exists,
 ;   and/or the long desc of the Images itself
 I 'MAGISGRP D
 . I MAGGRPO D GETDESC^MAGGTRP1(MAGGRPO)
 . D GETDESC^MAGGTRP1(MAGO)
 . W MAGDASH
 I MAGTMPRT="" D ENTRY^MAGLOG("LONGDES",DUZ,MAGO,"MAGRPT-WIN",MAGDFN,0) Q
 I $P(MAGTMPR,"^",7)="" S @MAGRPTY@(0)="0^Full report not available through this windows option." Q
 ;
 ; Surgery reports
 S MAGTMPR2=$P(^MAG(2005.03,MAGTMPRT,0),"^",1) I MAGTMPR2="SURGERY" D  Q
 . S SRTN=$P(MAGTMPR,"^",7)
 . D ^SROPRPT K SRTN
 . D ENTRY^MAGLOG("SURGRPT",DUZ,MAGO,"MAGRPT",MAGDFN,0)
 ;
 ; TIU documents;
 I MAGTMPRT=8925 D  Q
 . N I,MAGY
 . D TGET^TIUSRVR1(.MAGY,$P(MAGTMPR,"^",7))
 . S I="" F  S I=$O(@MAGY@(I)) Q:'I  W !,@MAGY@(I)
 . D ENTRY^MAGLOG("TIURPT",DUZ,MAGO,"MAGRPT",MAGDFN,0)
 ;
 ; Medicine reports
 I MAGTMPRT>689.999&(MAGTMPRT<703) D  Q
 . S MAGNODIS=1
 . D REPRT^MCMAGDSP($P(MAGTMPR,"^",7),MAGTMPRT)
 . D ENTRY^MAGLOG("MEDRPT",DUZ,MAGO,"MAGRPT-WIN",MAGDFN,0)
 ;
 ; Radiology reports
 I MAGTMPRT=74 D  Q
 . D BUILD^MAGGTRP1($P(MAGTMPR,U,7))
 . D ENTRY^MAGLOG("RADRPT",DUZ,MAGO,"MAGRPT-WIN",MAGDFN,0)
 ;
 ;Laboratory reports
 I $P(^MAG(2005.03,MAGTMPRT,0),"^",4)=63 D @$S(MAGTMPRT=63:"AU",MAGTMPRT=63.2:"AU",1:"LAB") Q
 ;
 S @MAGRPTY@(0)="0^Full report not available through this windows option."
 Q
 ;
CHECK(MAGO,MAGDFN,MAGDESC,MAGGRPO,MAGISGRP) ;
 ; 9/28/99  Change Report long description, so this is changed to 
 ; return the desc of MAGO, and define MAGGRPO if this is child of grp
 N MAGTMP
 I '$D(^MAG(2005,MAGO)) S @MAGRPTY@(0)="0^Invalid Image pointer"_MAGO Q
 S MAGDESC=$P($G(^MAG(2005,MAGO,2)),U,4)
 I $O(^MAG(2005,MAGO,1,0)) S MAGISGRP=1
 S MAGGRPO=+$P(^MAG(2005,MAGO,0),U,10)
 ;
 S MAGTMP=$S(MAGGRPO:MAGGRPO,1:MAGO)
 Q:'$D(^MAG(2005,MAGTMP,2))
 ; Procedure Exam Date/Time
 S Y=$P(^MAG(2005,MAGTMP,2),U,5),X=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_($E(Y,1,3)+1700)
 ;             procedure                     short description
 S Y=X_"  "_$P(^MAG(2005,MAGTMP,0),U,8)_"  "_$P($G(^MAG(2005,MAGTMP,2)),U,4)
 I MAGDFN S MAGDESC=MAGDESC_"^"_$P($G(^DPT(MAGDFN,0)),U)
 Q
LAB ; Pathology Reports
 N LINE,MAGIOPEN,MAGSTART,MAGEND,MAGSUB,TYPE,MAGXX,MAGLR
 S TYPE=$P(^MAG(2005.03,MAGTMPRT,0),"^",2)
 S MAGSTART=$P(^MAG(2005,MAGO,2),"^",10),MAGLR=$P(^MAG(2005,MAGO,2),"^",7)
 I MAGSTART,MAGLR,$D(^LR(MAGLR,TYPE,MAGSTART,0)) D
 . S (MAGSTART,MAGEND)=9999999-MAGSTART
 . Q
 ;if no pointer back to lab file use the procedure date/time.
 I 'MAGSTART D 
 . S MAGSTART=$P(^MAG(2005,MAGO,2),"^",5)
 . S (MAGSTART,MAGEND)=$P(MAGSTART,".")
 . Q
 I '$L(MAGSTART) D  Q
 . S @MAGRPTY@(1)="No Procedure Date/Time entered in file 2005 for this Image"
 S TYPE=$S(TYPE="SP":"SURGICAL PATHOLOGY",TYPE="CY":"CYTOPATHOLOGY",1:TYPE)
 S MAGSUB=1,MAGSUB(TYPE)="",MAGXX=""
 S MAGIOPEN=1
 D EN^LR7OSUM(MAGXX,MAGDFN,MAGSTART,MAGEND,10,80,.MAGSUB)
 I '$D(^TMP("LRC",$J)) S @MAGRPTY@(1)="No report(s) on file." Q
 E  S LINE=0 F  S LINE=$O(^TMP("LRC",$J,LINE)) Q:LINE<1  W !,^TMP("LRC",$J,LINE,0)
 D ENTRY^MAGLOG("LABRPT",DUZ,MAGO,"MAGRPT-WIN",MAGDFN,0)
 K ^TMP("LRC",$J),^TMP("LRT",$J),^TMP("LRH",$J)
 Q
AU ;Autopsy Report
 N LRDFN,MAGSUB,MAGXX,LINE
 S MAGSUB("AUTOPSY")=""
 I '$D(MAGO)!'$D(MAGDFN) W !,"Missing imaging pointers." Q
 S LRDFN=$P(^MAG(2005,MAGO,2),"^",7),LRDFN=+LRDFN
 I 'LRDFN!'$D(^LR(LRDFN,0)) W !,"Information missing, please use DHCP Lab print options." Q
 I '$D(^LR(LRDFN,"AU")) W !,"Missing autopsy information." K LRDFN Q
 D EN^LR7OSUM(.MAGXX,MAGDFN,,,,80,.MAGSUB)
 I '$D(^TMP("LRC",$J)) S @MAGRPTY@(1)="No autopsy report on file." Q
 S LINE=0 F  S LINE=$O(^TMP("LRC",$J,LINE)) Q:LINE<1  W !,^TMP("LRC",$J,LINE,0)
 D ENTRY^MAGLOG("LABRPT",DUZ,MAGO,"MAGRPT-WIN",MAGDFN,0)
 K ^TMP("LRC",$J)
 Q
ERRA ;
 S @MAGRPTY@(0)="0^ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q
