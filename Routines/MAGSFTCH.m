MAGSFTCH ;WOIFO/JSL - IMAGE STORAGE COPY UTILITY PROGRAM  ; July 01, 2010  1:06 PM
 ;;3.0;IMAGING;**98**;Mar 19, 2002;Build 1849;Sep 22, 2010
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
FETCH(OUT,MAGIEN,DATE,NETLOC) ;RPC = MAG STORAGE FETCH
 ;; OUT() : result - code,message
 ;;   for example: OUT(1) = "0, Done",  OUT(1)= "Ien1: Ien2, copy command line"
 ;; MAGIEN : fetching IEN (start ien) | (stop ien)
 ;; DATE : image saved date (start date) | (stop date)
 ;; NETLOC : FROM | TO - network location | remove source file | WinZip option
 N CNT,CMD,DT1,DT2,DTOUT,ENDIM,EXT,FILE,FNAME,FROM,FRMLOC,IEN1,IEN2,IM,IN,IN1,IN2,JBLOC,LOC,LOCN,LNO
 N M,MOVOLD,WZIP,NTLOC,OK,PS,PLACE,RDLOC,SITE,START,STOP,STYP,TLOC,TO,TP,X,X0,X1,X2,XBIG,Y,WRTLOC,LOGTIME,BTMOUT
 K OUT S OUT(1)=0,OK=0,U="^",LNO=0
 S LOGTIME=$$NOW^XLFDT(),BTMOUT=+$P(^MAG(2006.1,$$PLACE^MAGBAPI(+$G(DUZ(2))),"KEYS"),U,2) I $G(XWBTIME) S:BTMOUT>XWBTIME BTMOUT=XWBTIME ;broker time out
 I $G(MAGIEN) S:'$G(DATE) DATE=$P($$NOW^XLFDT,"."),DT2="2800101" S IM=+$G(MAGIEN),ENDIM=$P($G(MAGIEN),":",2) ;ien range - IM ~ ENDIM
 E  S DATE=$G(DATE),DT2=$P(DATE,"|",2),DATE=+DATE ;DT2 fetch end date
 ;DATE range iens, find one
 I '$G(IM) S IM=$S($G(DATE):$$FINDIEN(DATE),1:$O(^MAG(2005," "),-1))
 I '$G(ENDIM) S ENDIM=$S($G(DT2):$$FINDIEN(DT2),$G(DATE):$$FINDIEN(DATE-1),1:0)
NEXT ;IEN range in reverse order, find matched IEN to fetch/copy
 S X0=$G(^MAG(2005,IM,0))
 I $P(X0,U,2)'["." I IM>1 F CNT=1:1:100000 S IM=$O(^MAG(2005,IM),-1) Q:'IM!(IM<ENDIM)  S X0=$G(^MAG(2005,IM,0)) I $P(X0,U,2)["." Q  ;find next
 I IM I ($$NOW^XLFDT-$G(^MAG(2005,IM,2)))<1 S IM=$O(^MAG(2005,IM),-1) G NEXT  ;exclude today image(s) IM
 I (IM'<ENDIM),($P(X0,U,2)[".") D FETCH1
 I OK S OUT(1)=IM_":"_ENDIM_",CMD summit "_LNO_U_WRTLOC_U_$G(FRMLOC)_U_DT1_U_$G(MOVOLD)_"@"_DATE_"|"_DT2_"|"_$G(STYP)_"|"_FNAME_"|"_+$G(XBIG,0)
 I $P(OUT(1),",",1)=-1 Q  ;error occured
 I 'OK I ($$FMDIFF^XLFDT($$NOW^XLFDT(),LOGTIME,2)+1)>$G(BTMOUT) D  Q  ;before BK time out, still not finding any image
 . S OUT(1)="-2,Cannot find image file on selected Source location to copy within IEN range("_IM_"~"_+$G(MAGIEN)_") after broker timeout"_$S($G(BTMOUT):" of "_BTMOUT_" sec.",1:".")
 . Q
 I 'OK,$G(OUT(2))="" S IM=$O(^MAG(2005,IM),-1) K OUT(2) G:IM>0 NEXT
 S:IM<1 OUT(1)=0_",Done"
 Q
 ;
FETCH1 ;Find the image file from share
 S XBIG=$G(^MAG(2005,IM,"FBIG"))
 S X2=$G(^MAG(2005,IM,2)),DT1=$P(X2,U) ;D/T image saved
 I DT1 I DT1<DT2 S:(DT1-DATE)<-1 IM=-1 Q  ;early than fetch end date, or stop the loop $O()
 S OUT(1)=IM_":"_ENDIM  ;last fetching IEN
 S LNO=1     ;LN number of OUT()
 S SITE=$P($G(^MAG(2005,IM,100)),U,3)       ;SITE ID
 S PLACE=+$S(SITE:$O(^MAG(2006.1,"B",SITE,0)),1:$O(^MAG(2006.1,0))) S:'PLACE PLACE=1
 S FRMLOC=+$P($G(NETLOC),"|"),WRTLOC=+$P($G(NETLOC),"|",2),MOVOLD=$P($G(NETLOC),"|",3),WZIP=$P($G(NETLOC),"|",4)
 I WRTLOC="" S OUT(1)="-1,Can't Find 'TO' write network location" Q
 S FNAME=$P(X0,U,2),FILE=$P(FNAME,"."),EXT=$P(FNAME,".",2) Q:FILE=""
 I $L(FILE)>8 I $L(FILE)'=14 I FRMLOC=$P(X0,U,3) D MAGFIX93(.OUT,IM) S X0=^MAG(2005,IM,0),FNAME=$P(X0,U,2),FILE=$P(FNAME,".") ;valid 8.3, 14.3
 I FRMLOC=$P(X0,U,5) D FULL Q
 I FRMLOC=$P(X0,U,3) D FULL Q
 I FRMLOC=$P(X0,U,4) D FULL Q
 I $L(XBIG) I (FRMLOC=$P(XBIG,U))!(FRMLOC=$P(XBIG,U,2)) D FULL Q
 I $P($G(NETLOC),"|")="*" D ALLCPY Q
 E  I (FRMLOC'=$P(X0,U,3))&(FRMLOC'=$P(X0,U,5)) S OK=0,OUT(1)=0,OUT(2)="" Q  ;Not on selected share 
 S:'WRTLOC WRTLOC=$P($G(^MAG(2006.1,PLACE,0)),U,3)  ;current write location vs Site ID
 I 'WRTLOC S OUT(1)="-1,Can't Find Current Write Location for ("_MAGIEN_")" Q
 Q
 ;
ALLCPY ;copy ALL set image files to JB
 N MKDIR,X1,NO S LNO=$S($D(OUT(2)):$O(OUT(" "),-1),1:2)
 S LOCN=$P(XBIG,U) S:LOCN LOCN(LOCN)=1 F PS=3,4 S LOCN=$P(X0,U,PS) S:LOCN LOCN(LOCN)=PS ;all possible RAID loc
 I '$O(LOCN(0)) S OUT(1)="-1,Can't Find Current Image Location for ("_MAGIEN_")" Q
 S LOCN=0 F  S LOCN=$O(LOCN(LOCN)) Q:'LOCN  D
 . S LOC=$G(^MAG(2005.2,LOCN,0)) Q:'$L(LOC)
 . I LOCN I LOCN'=$P(X0,U,5) I LOCN'=$P(X0,U,3) Q  ;not on RAID share nor JB
 . S STYP=$S($P(LOC,U,7)="MAG":"R",1:"J")  ;storage type
 . I $P(^MAG(2005.2,LOCN,0),U,10) Q:PLACE'=$P(^MAG(2005.2,LOCN,0),U,10)  ;chk PLACE
 . S TLOC=$G(^MAG(2005.2,WRTLOC,0)) Q:'$L(TLOC)
 . I $P(TLOC,U,8)'="Y" S OUT(1)="-1,WRITE Location is not hashed" Q 
 . S STYP="RJ"
 . S JBLOC=$P(LOC,U,2),RDLOC=$P(^MAG(2005.2,WRTLOC,0),U,2)  ;phyical location
 . S FROM=$$DIRHASH^MAGFILEB(FNAME,LOCN),FROM=$$CHKDIR(FROM) ;JB hash dir
 . S TO=$$DIRHASH^MAGFILEB(FNAME,WRTLOC),TO=$$CHKDIR(TO) ;RD hash dir
 . I '$G(MKDIR) D
 . . S:'$D(OUT(2)) OUT(2)="DIR "_JBLOC_FROM_FILE_".*"  ;chk file exist
 . . I $F(TO,"\") F NO=1:1 S X1=$P(TO,"\",NO) Q:X1=""  S LNO=LNO+1,OUT(LNO)="MKDIR "_RDLOC_$P(TO,"\",1,NO)
 . . E  S LNO=LNO+1,OUT(LNO)="MKDIR "_RDLOC_TO
 . . S MKDIR=1  ;create hash folder
 . . Q
 . D @STYP
 Q
 ;
FULL ;copy all images full set
 N X1,NO S LNO=$S($D(OUT(2)):$O(OUT(" "),-1),1:2)
 S LOCN=FRMLOC S:'LOCN LOCN=$P(X0,U,5) S:'LOCN LOCN=$P(X0,U,3) S:'LOCN LOCN=$P(X0,U,4) Q:'LOCN
 S LOC=$G(^MAG(2005.2,LOCN,0)) Q:'$L(LOC)
 I LOCN I LOCN'=$P(X0,U,5) I LOCN'=$P(X0,U,3) I LOCN'=$P(X0,U,4) I '(FRMLOC=$P(XBIG,U)) I '(FRMLOC=$P(XBIG,U,2)) Q  ;not on RAID share nor JB
 S STYP=$S($P(LOC,U,7)="MAG":"R",1:"J")  ;storage type
 I $P(^MAG(2005.2,LOCN,0),U,10) Q:PLACE'=$P(^MAG(2005.2,LOCN,0),U,10)  ;chk PLACE
 S TLOC=$G(^MAG(2005.2,WRTLOC,0)) Q:'$L(TLOC)
 I $P(TLOC,U,8)'="Y" S OUT(1)="-1,WRITE Location is not hashed" Q 
 S STYP=STYP_$S($P(TLOC,U,7)="MAG":"R",1:"J")
 S JBLOC=$P(LOC,U,2),RDLOC=$P(^MAG(2005.2,WRTLOC,0),U,2)  ;phyical location
 S FROM=$$DIRHASH^MAGFILEB(FNAME,LOCN),FROM=$$CHKDIR(FROM) ;JB hash dir
 S TO=$$DIRHASH^MAGFILEB(FNAME,WRTLOC),TO=$$CHKDIR(TO) ;RD hash dir
 S:'$D(OUT(2)) OUT(2)="DIR "_JBLOC_FROM_FILE_".*"  ;chk file exist
 I $F(TO,"\") F NO=1:1 S X1=$P(TO,"\",NO) Q:X1=""  S LNO=LNO+1,OUT(LNO)="MKDIR "_RDLOC_$P(TO,"\",1,NO)
 E  S LNO=LNO+1,OUT(LNO)="MKDIR "_RDLOC_TO ;create hashed dir
 I '(FRMLOC=$P(XBIG,U)) I '(FRMLOC=$P(XBIG,U,2)) S XBIG="" ;no BIG copy
 D @STYP
 Q
 ;
STYP ;; COPY image - JB->RAID  (e.g.:Fetching JB)
 ;;                  JB->JB    (e.g.:Hashing/Media Copy) 
 ;;                RAID->JB  (e.g.:Archive JB)
 ;;                RAID->RAID (e.g.: Media Copy)
JR ;JB to RAID
 D COPYCMD
 S OK=1
 Q
 ;
JJ ;JB to JB
 D COPYCMD
 S OK=1
 Q
 ;
RJ ;RAID to JB
 I $G(MOVOLD)=1 D MOVECMD S OK=1 Q
 D COPYCMD
 S OK=1
 Q
 ;
RR ;RAID to RAID
 I $G(MOVOLD)=1 D MOVECMD S OK=1 Q
 D COPYCMD
 S OK=1
 Q
COPYCMD ;create each copy cmd line for GUI (called by FETCH1/JR/JJ/RJ/RR)
 N SRC S CMD="",SRC=$$CHKSRC(STYP,X0,$G(XBIG))
 I $P(SRC,U,1) S CMD="COPY/Y /V "_JBLOC_FROM_FILE_".TXT "_RDLOC_TO_FILE_".TXT ",LNO=LNO+1,OUT(LNO)=CMD
 I $P(SRC,U,2) S CMD="COPY/Y /V "_JBLOC_FROM_FILE_".ABS "_RDLOC_TO_FILE_".ABS ",LNO=LNO+1,OUT(LNO)=CMD
 I $P(SRC,U,3) S CMD="COPY/Y /V "_JBLOC_FROM_FILE_"."_EXT_" "_RDLOC_TO_FILE_"."_EXT_" ",LNO=LNO+1,OUT(LNO)=CMD
 I $P(SRC,U,4) S CMD="COPY/Y /V "_JBLOC_FROM_FILE_".BIG "_RDLOC_TO_FILE_".BIG ",LNO=LNO+1,OUT(LNO)=CMD
 I CMD="" S OUT(1)="-1,Can't find image set for IEN("_MAGIEN_")" Q
 Q
MOVECMD ;create each Move cmd line for GUI
 N SRC S CMD="",SRC=$$CHKSRC(STYP,X0,$G(XBIG))
 I $P(SRC,U,1) S CMD="MOVE/Y "_JBLOC_FROM_FILE_".TXT "_RDLOC_TO_FILE_".TXT ",LNO=LNO+1,OUT(LNO)=CMD
 I $P(SRC,U,2) S CMD="MOVE/Y "_JBLOC_FROM_FILE_".ABS "_RDLOC_TO_FILE_".ABS ",LNO=LNO+1,OUT(LNO)=CMD
 I $P(SRC,U,3) S CMD="MOVE/Y "_JBLOC_FROM_FILE_"."_EXT_" "_RDLOC_TO_FILE_"."_EXT_" ",LNO=LNO+1,OUT(LNO)=CMD
 I $P(SRC,U,4) S CMD="MOVE/Y "_JBLOC_FROM_FILE_".BIG "_RDLOC_TO_FILE_".BIG ",LNO=LNO+1,OUT(LNO)=CMD
 I CMD="" S OUT(1)="-1,Can't find image set for IEN("_MAGIEN_")" Q
 Q
CHKSRC(STYP,X0,XBIG) ;check if source files exist for copy
 ;; STYP = storage types,  X0 = 2005 entry, XBIG = 2005 FBIG entry 
 N ABS,BIG,TGA,TXT S (ABS,BIG,TGA,TXT)=0
 I (STYP="RR") S:(LOCN=$P(X0,U,3)) (TXT,TGA)=1 S:(LOCN=$P(X0,U,4)) (TXT,ABS)=1 S:(LOCN=$P(XBIG,U)) (TXT,BIG)=1
 I (STYP="RJ") S:(LOCN=$P(X0,U,3))!(LOCN=$P(X0,U,4)) (TGA,ABS,TXT)=1 S:(LOCN=$P(XBIG,U)) (TXT,BIG)=1
 I (STYP="JJ") S:(LOCN=$P(X0,U,5)) (TGA,ABS,TXT)=1 S:(LOCN=$P(XBIG,U,2)) (TXT,BIG)=1
 I (STYP="JR") S:(LOCN=$P(X0,U,5)) (TGA,ABS,TXT)=1 S:(LOCN=$P(XBIG,U,2)) (TXT,BIG)=1
 Q TXT_U_ABS_U_TGA_U_BIG
 ;---------------------------------------------------------------------
SETLOC(OUT,IM,NTLOC) ;RPC = MAG STORAGE FETCH SET
 ;; Set the RAID location piece(NTLOC) in MAG(2005,IM includes 3,4 & FBIG
 ;; OUT(1)= 1  success     |   IM = ien IMAGE file #2005
 ;;         0  no action   |   NTLOC = network loction ien+(opt:overwrt "*" full or "@" .ABS or "b" .BIG) + (| source location)
 ;;         -1 error       |
 N OK,X,XBIG,Y,SRC
 K OUT S OUT(1)=0,OK=0,U="^"
 S SRC=+$P($G(NTLOC),"|",2) ;source location ien
 I '$G(IM) S OUT(1)="-1,No IMAGE IEN Specified ("_$G(IM)_")" Q
 I $G(NTLOC)="" S OUT(1)="-1,No Network Location Specified" Q
 S X=$G(^MAG(2005.2,+NTLOC,0)) Q:$P(X,U,9)  ;no Set for router
 I $P(X,U,2)="" S OUT(1)="-1,Invalid Network Location "_NTLOC Q
 I $P(X,U,7)["WORM" D SETJBL Q
 I $P(X,U,7)'="MAG" S OUT(1)="0,Not a RAID/MAG nor a JB/WORM NETWORK LOCATION type - IEN "_NTLOC Q
 S (X,Y)=$G(^MAG(2005,IM,0)) I X="" S OUT(1)="-1,No IMAGE File entry - IEN "_IM Q
 S XBIG=$G(^MAG(2005,IM,"FBIG"))
 I SRC>0 D  Q  ;with the file(s) source info, use it to set RAID pt
 . I ($P(X,U,4)=SRC)!($P(X,U,5)=SRC) S $P(Y,U,4)=+NTLOC,OK=1 ;ABS
 . I ($P(X,U,3)=SRC)!($P(X,U,5)=SRC) S $P(Y,U,3)=+NTLOC,OK=1 ;full
 . I OK S ^MAG(2005,IM,0)=Y,OUT(1)="1,Set RAID pointer for 2005 IMAGE IEN "_IM
 . I ($P(XBIG,U)=SRC)!($P(XBIG,U,2)=SRC) S $P(^MAG(2005,IM,"FBIG"),"^")=+NTLOC,OUT(1)=$S(OK:OUT(1)_" w/FBIG",1:"1,Set RAID(FBIG) pointer for 2005 IMAGE IEN "_IM)
 . Q
 I (NTLOC["b") G SETLOC4B  ;BIG file only
 I (NTLOC["@") S $P(Y,U,4)=+NTLOC,OK=1  ;set ABS only
 E  D
 . I '$P(X,U,4)!(NTLOC["*") S:'(NTLOC["r") $P(Y,U,4)=+NTLOC,OK=1 ;r : p3 only
 . I '$P(X,U,3)!(NTLOC["*")!(NTLOC["r") S $P(Y,U,3)=+NTLOC,OK=1  ;set FULL
 . Q
 I OK S ^MAG(2005,IM,0)=Y,OUT(1)="1,Set RAID pointer for 2005 IMAGE IEN ,"_IM
 I OK=0,$P(X,U,3) I (+NTLOC)'=$P(X,U,3) S OUT(1)="-1,Not setting #"_NTLOC_" already exist other network location #"_$P(X,U,3) Q
 Q:XBIG=""!(XBIG="^")!(NTLOC["@")  ;no BIG file to set
SETLOC4B ;BIG file RAID
 S $P(^MAG(2005,IM,"FBIG"),"^")=+NTLOC,OUT(1)=$S(OK:OUT(1)_" w/FBIG",1:"1,Set RAID(FBIG) pointer for 2005 IMAGE IEN "_IM)
 Q
 ;
SETJBL ;SET JB location
 I '$G(NTLOC)="" S OUT(1)="-1,No Network Location Specified" Q
 S (X,Y)=$G(^MAG(2005,IM,0)) I X="" S OUT(1)="-1,No Image File"_IM Q
 S XBIG=$G(^MAG(2005,IM,"FBIG"))
 I SRC>0 D  Q  ;with the source info, use it to set new jukebox pt
 . I ($P(X,U,3)=SRC)!($P(X,U,4)=SRC)!($P(X,U,5)=SRC) S $P(Y,U,5)=+NTLOC,OK=1 ;JB
 . I OK S ^MAG(2005,IM,0)=Y,OUT(1)="1,Set JB pointer for 2005 IMAGE IEN "_IM
 . I ($P(XBIG,U)=SRC)!($P(XBIG,U,2)=SRC) S $P(^MAG(2005,IM,"FBIG"),"^",2)=+NTLOC,OUT(1)=$S(OK:OUT(1)_" w/FBIG",1:"1,Set JB(FIBG) pointer for 2005 IMAGE IEN "_IM)
 . Q
 I $P(X,U,5)'=NTLOC S $P(Y,U,5)=+NTLOC,OK=1 ;set FULL
 I OK S ^MAG(2005,IM,0)=Y,OUT(1)="1,Set JB pointer for 2005 IMAGE IEN "_IM
 Q:XBIG=""!(XBIG="^")  ;no BIG
 I SRC>0 I $P(XBIG,U)'=SRC I $P(XBIG,U,2)'=SRC Q  ;not same source loc
 S $P(^MAG(2005,IM,"FBIG"),"^",2)=+NTLOC,OUT(1)=$S(OK:OUT(1)_" w/FBIG",1:"1,Set JB(FIBG) pointer for 2005 IMAGE IEN "_IM)
 Q
 ;
FINDIEN(DT1) ; Find last IEN mark(IN) to process on DT1         
 S IN1=0,IN2=$O(^MAG(2005,"A"),-1),IN=(IN1+IN2)\2
LOOP ;check image saved date
 S Y=$G(^MAG(2005,IN,2)) I Y="" S IN=IN+1 I IN<IN2 G LOOP
 I +Y>DT1 S IN2=IN,IN=(IN1+IN2)\2
 E  S IN1=IN,IN=(IN1+IN2)\2
 I IN1'=IN,IN2'=IN G LOOP
 Q IN
 ;
MAGFIX93(OUT,IEN) ;API - MAG UTIL FIX9.3, fix 9.3 10.3 file format (call by FETCH1)
 ;; OUT() : result - DOS commands to rename(move) the 9.3 or 10.3 file name to 14.3
 ;;   for example: OUT(1) = "move abc123456.abs abc0\00\00\12\34\abc00000123456.abs"
 ;; IEN : image file IEN
 ;;
 N NWNAME,NO,OFNAME,X,Y,LOCN,LOC,ODIR,EXT,NFNAME,NDIR,CMD,DIE,DA,DR,EXT1,CMD,X1,SITE
 S:'$D(U) U="^"
 S SITE=+$P($G(^MAG(2005,IEN,100)),U,3)       ;SITE ID 
 S:'$D(PLACE) PLACE=+$S(SITE:$O(^MAG(2006.1,"B",SITE,0)),1:$O(^MAG(2006.1,0))) S:'PLACE PLACE=1
 S LNO=2,NWNAME=$P(^MAG(2006.1,PLACE,0),U,2) ;current site namespace
 S X=$G(^MAG(2005,IEN,0)) I $L(X) D
 . S Y=$P(X,U,2) Q:Y=""  ;GROUP no file reference
 . S OFNAME=$P(Y,".") I ($L(OFNAME)=8)!(OFNAME="")!($L(OFNAME)=14) Q  ;8.3 14.3 format
 . S LOCN=$P(X,U,3) Q:'LOCN   ;RAID location
 . ;;I $P(X,U,5) Q  ;don't change file name w/ JB(WORM) copy
 . S LOC=$P($G(^MAG(2005.2,LOCN,0)),U,2) Q:'$L(LOC)
 . S ODIR=$$DIRHASH(OFNAME,LOCN),ODIR=$$CHKDIR(ODIR)
 . S EXT=$P(Y,".",2) Q:EXT=""  ;no extn?
 . S NFNAME=NWNAME_$$PRE0(IEN)_IEN    ;correct img file name
 . S NDIR=$$DIRHASH(NFNAME,LOCN),NDIR=$$CHKDIR(NDIR)
 . S OUT(2)="DIR "_LOC_ODIR_OFNAME_".*"  ;chk file exist
 . I $F(NDIR,"\") F NO=1:1 S X1=$P(NDIR,"\",NO) Q:X1=""  S LNO=LNO+1,OUT(LNO)="MKDIR "_LOC_$P(NDIR,"\",1,NO)  ; make sub dir
 . E  S LNO=LNO+1,OUT(LNO)="MKDIR "_LOC_NDIR
 . S EXT1="" F EXT1="ABS","TXT","BIG",EXT  D  ;copy all possible extn types
 . . I EXT1="BIG" I ($G(XBIG)="")!($G(XBIG)="^") Q
 . . S LNO=LNO+1,OUT(LNO)="MOVE/Y "_LOC_ODIR_OFNAME_"."_EXT1_" "_LOC_NDIR_NFNAME_"."_EXT1
 . . Q
 . S DA=+IEN,DR="1///"_NFNAME_"."_EXT,DIE="^MAG(2005," D ^DIE  ;chg "F" X-REF
 . D ENTRY^MAGLOG("MAG UTIL",$G(DUZ),IEN,"MAG UTIL FIX9.3","","1",OFNAME_"=>"_NFNAME)
 . Q
 Q
 ;
PRE0(IEN) ;pre '0' for 14 characters => Namespace_nnnnnnnn_ien'
 N NO,J
 S:$G(NWNAME)="" NWNAME=$P(^MAG(2006.1,PLACE,0),"^",2)
 S NO="" F J=1:1:(14-$L(IEN)-$L(NWNAME)) S NO=NO_"0"
 Q NO
 ;
CHKDIR(DIR) ; chk "\\"
 N L S L=$L(DIR) I $E(DIR,L-1,L)="\\" S DIR=$E(DIR,1,L-1) ;trim \\ at end
 Q DIR
 ;
DIRHASH(FILENAME,NETLOCN) ; determine the hierarchical file directory hash 
 ; Input Variables:
 ; FILENAME -- the name of the file, with or without the extension
 ; NETLOCN --- the network location file internal entry number
 ; Return Value: the hierarchical file directory hash
 N FN,HASHFLAG,HASH,I
 S HASHFLAG=$P(^MAG(2005.2,NETLOCN,0),"^",8)
 I HASHFLAG="Y" D  ; calculate the hierarchical directory hash
 . ; for an 8.3 filename AB123456.XYZ, the directory hash is AB\12\34
 . ; for a 14.3 filename BALT1234567890.XYZ, its BALT\12\34\56\78
 . S FN=$P(FILENAME,".") ; strip off the extension
 . I $L(FN)=8 S HASH=$E(FN,1,2)_"\"_$E(FN,3,4)_"\"_$E(FN,5,6)
 . E  S HASH=$E(FN,1,4) F I=5,7,9,11 S HASH=HASH_"\"_$E(FN,I,I+1)
 . S HASH=HASH_"\" ; add the trailing directory separator
 . Q
 E  S HASH="" ; flat directory structure, no hierarchical hashing 
 Q HASH
