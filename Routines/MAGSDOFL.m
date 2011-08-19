MAGSDOFL ;WOIFO/SF - Track Offline Images ; June 11, 2010 17:49
 ;;3.0;IMAGING;**18,98**;Mar 19, 2002;Build 1849;Sep 22, 2010
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
 Q
ENTRY ;Interactive entry here
 I '$D(DUZ) W !,"Use the MAG JB OFFLINE menu option to run this application" Q
 N BOLD,NORMAL,N,R
 D SETUP W @IOF
LOOP ; main menu loop
 D SETUP
 W !!,$P($T(OPTIONS),";",3),!
 S N=0 F I=1:1 S X=$P($T(OPTIONS+I),";",3,999) Q:X=""  D  ; list options
 . I $P(X,";")="" Q
 . S N=N+1 W !,?2,$J(N,2),?6,$P(X,";")
 . Q
 ;
AGAIN ;
 W !!,?2,"OPTION: " R " ",R:DTIME Q:R=""!(R="^")
 I R["?" D HELP2 G AGAIN
 I R?1N.N,R>0,R'>N D  G LOOP
 . S N=0 F I=1:1 D  Q:X=""  I R=N D @($P(X,";",2)),RETURN Q
 . . S X=$P($T(OPTIONS+I),";",3,999) Q:X=""
 . . S N=N+1
 . Q
 W " ??? -- Invalid option.  Try agin." G AGAIN
 ;
SETUP ;
 I ^%ZOSF("OS")?1"MSM".E S IOF="#"
 E  D HOME^%ZIS
 S U="^"
 S NORMAL=$C(27)_"[0;"_"44m" ; normal blue
 S BOLD=$C(27)_"[1;"_"44m" ; bold blue
 Q
 ;
RETURN ;
 D SETUP
 R !!,"Push <Enter> to continue...",X:DTIME
 Q
OFFLINE(MAGIN) ;Set images offline
 N COUNT
ASK1 I MAGIN="" R !!,"Enter file to read offline images from: ",X:DTIME
 I X="" Q
 I X="^" Q
 I X["?" D HELP1 G ASK1
 N IOP,MAGFDA,MAGFL
 I MAGIN="" S MAGIN=X
 S %ZIS="",%ZIS("HFSNAME")=MAGIN,%ZIS("HFSMODE")="R",IOP="HFS"
 S X="ERROR^MAGSDOFL",@^%ZOSF("TRAP")
 S MAGFL=2006.033
 S COUNT=0
 U IO(0) W !!,"Here goes nothing...",!
 D ^%ZIS
 F  U IO R LN:5 D
 . S COUNT=COUNT+1
 . S LN=$$TRIM(LN)
 . I LN["Media """ S MAGPLAT=$P(LN,"""",2) U IO(0) W !,MAGPLAT
 . I COUNT#50=0 U IO(0) W "."
 . S LN=$$FNAME(LN) Q:LN=""
 . K MAGIEN S MAGIEN="?+1,"
 . S MAGFDA(MAGFL,MAGIEN,.01)=LN
 . S MAGFDA(MAGFL,MAGIEN,1)=MAGPLAT
 . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . Q
 W !,"Done."
 Q
LINE(OUT,LN,MAGPLAT) ;RPC - MAG UTIL JBOFFLN
 ; LN := Process the line from JB platter/media report
 ; MAGPLAT := platter name
 ; OUT := return the result
 ;        e.g.: '0, Done'
 ;              '-1, Error message'
 ;
 N MAGFL,MAGIEN
 S OUT(0)=0,MAGFL=2006.033 ;;JB offline file
 I ($G(LN)="")!($G(MAGPLAT)="") S OUT(0)="-1,No text line value or specified platter" Q
 S LN=$$TRIM(LN)
 S LN=$$FNAME(LN) Q:LN=""
 K MAGIEN S MAGIEN="?+1,"
 S MAGFDA(MAGFL,MAGIEN,.01)=LN
 S MAGFDA(MAGFL,MAGIEN,1)=MAGPLAT
 D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 S OUT(0)="0,Done"
 Q
FNAME(LN) ;Find img file name
 N XX  ;OTG 4x or 5x
 I LN["\" D  Q XX
 . F N=1:1 S XX=$P(LN,"\",N) Q:XX=""  I XX?.E1"."2.5AN S LN=XX Q
 ;OTG 3x
 I $P(LN," ",1)'?.E1"."2.5AN Q ""
 S LN=$P(LN," ")
 Q LN
ONLINE(MAGPLAT) ;Set images back online
 ;
ASK I MAGPLAT="" U IO(0) R !!,"Enter the name of the platter being inserted: ",X:DTIME
 I X="" Q
 I X="^" Q
 I X["?" D HELP G ASK
 N MAGENT
 S MAGPLAT=X
 I '$D(^MAGQUEUE(2006.033,"C",MAGPLAT)) W "  Platter not on file..." Q
 S DIK="^MAGQUEUE(2006.033,"
 S MAGENT=""
 F  S MAGENT=$O(^MAGQUEUE(2006.033,"C",MAGPLAT,MAGENT)) Q:'MAGENT  D
 . S DA=MAGENT
 . D ^DIK
 . I $D(Y) U IO(0) W "."
 . E  U IO(0) W !,"Problem deleting entry# "_MAGENT
 U IO(0) W !,"Done."
 Q
HELP ;List offline platters
 U IO(0) W !,"Do you want to see a list of all offline platters? " R X:60
 I "?"[$E(X) W !!,"Answer ""yes"" to see a list of platters currently marked offline"
 I "?"[$E(X) W !,"Answer ""no"" to return",! G HELP
 I "Yy"'[$E(X) Q
LISTP S MAGPLAT=""
 F  S MAGPLAT=$O(^MAGQUEUE(2006.033,"C",MAGPLAT)) D  Q:MAGPLAT=""
 . U IO(0) W !,MAGPLAT
 Q
LISTOFL(OUT) ;RPC - MAG UTIL LSTOFLJB ;LIST OFFLINE JB PLATTER(S) ;;*98
 N MAGPLAT,CNT  S MAGPLAT="",OUT(1)="0"
 F CNT=1:1 S MAGPLAT=$O(^MAGQUEUE(2006.033,"C",MAGPLAT)) Q:MAGPLAT=""  S OUT(CNT)=MAGPLAT
 Q
BKONL(OUT,MAGPLAT) ;RPC - MAG UTIL BKONLJB ;Put images back online (Insert Jukebox Platter)
 N DIK,CNT,DA,Y
 S OUT(1)="0"
 I $G(MAGPLAT)="" S OUT(1)="-1,No JB Platter specified" Q
 I $O(^MAGQUEUE(2006.033,"C",MAGPLAT,0))="" S OUT(1)="-1,Platter not on file 2006.033 -"_MAGPLAT Q
 S DIK="^MAGQUEUE(2006.033,",MAGENT=""
 F CNT=0:1 S MAGENT=$O(^MAGQUEUE(2006.033,"C",MAGPLAT,MAGENT)) Q:'MAGENT  D
 . S DA=MAGENT D ^DIK
 I $D(Y) S OUT(1)="0,Done "_CNT
 Q
GROUP ;Remove platters in group
 N COUNT,MAGPLAT,PLAT,X,TOTAL,MAGIEN,CNT,IOP,MAGFDA,MAGFL,POP
ASK3 R !!,"Enter 'DIR' file to read offline platter TXT from: ",X:$G(DTIME)
 I X=""!(X="^") Q
 I X["?" D HELP3 G ASK3
 S MAGIN=X ;DIR filename
 S %ZIS="",%ZIS("HFSNAME")=MAGIN,%ZIS("HFSMODE")="R",IOP="HFS"
 S X="ERROR^MAGSDOFL",@^%ZOSF("TRAP")
 D ^%ZIS
 F  U IO R MAGPLAT:30 Q:($G(MAGPLAT)="")!($G(MAGPLAT)["~end")  I $L(MAGPLAT) S MAGPLAT(MAGPLAT)=0 U IO(0) W "|"
 D ^%ZISC
 S MAGFL=2006.033
 U IO(0) W !!,"Here goes nothing...",!,"50 per '.'",!
 S PLAT="" F CNT=0:1 S PLAT=$O(MAGPLAT(PLAT)) Q:PLAT=""  U IO(0) W !,PLAT D
 . S COUNT=0,%ZIS="",%ZIS("HFSNAME")=PLAT,%ZIS("HFSMODE")="R",IOP="HFS"
 . S X="ERROR^MAGSDOFL",@^%ZOSF("TRAP")
 . D ^%ZIS I POP W !,"Sorry, ",PLAT," not found, try later.",! Q
 . F  U IO R LN:5 D
 . . S COUNT=COUNT+1,TOTAL=$G(TOTAL)+1
 . . S LN=$$TRIM(LN)
 . . I LN["Media """ S MAGPLAT=$P(LN,"""",2) U IO(0) W !,MAGPLAT
 . . I COUNT#50=0 U IO(0) W "."
 . . S LN=$$FNAME(LN) Q:LN=""
 . . K MAGIEN S MAGIEN="?+1,"
 . . S MAGFDA(MAGFL,MAGIEN,.01)=LN
 . . S MAGFDA(MAGFL,MAGIEN,1)=MAGPLAT
 . . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . . Q
 . D ^%ZISC ;cls media report
 . Q
 U IO(0) W !,"Done (",CNT," platter(s), total files ",TOTAL," were marked offline.)",!
 Q
HELP1 ;Help for offline
 W !,"Enter the name of the file created by the jukebox media file report"
 Q
HELP2 ;Help for OPTION prompt
 W !,"Select option 1 if you are marking images offline"
 W !,"Select option 2 if you are marking images online"
 W !,"Select option 3 if you want the listing of off-line platter(s)"
 W !,"Select option 4 if you are taking the group of platters off-line"
 W !,"Type ""^"" to quit"
 Q
HELP3 ;Help for GROUP platters TXT
 W !,"Enter the full file name that is grouped by the jukebox media TXT file report",!
 W !,"For example: you do 'DIR JB*.TXT /B /S > [USER]DIR.TXT' ,append '~end' at end of file",!
 W !,"Then use [USER]DIR.TXT as source file",!
 Q
 ;
TRIM(X) ;
 N I,J
 F I=1:1:$L(X) Q:$E(X,I)'=" "
 F J=$L(X):-1:I Q:$E(X,J)'=" "
 Q $E(X,I,J)
ERROR ;Trap Errors Here
 D ^%ZISC
 Q
OPTIONS ; Offline Image Menu
 ;;Take images offline (Remove Jukebox Platter);OFFLINE("")
 ;;Put images back online (Insert Jukebox Platter);ONLINE("")
 ;;Take images offline (Group platters);GROUP
 ;;List current offline Jukebox Platter;LISTP
