DGPFLF1 ;ALB/KCL - PRF FLAG MANAGEMENT BUILD LIST AREA ; 3/11/03
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 ;no direct entry
 QUIT
 ;
EN(DGARY,DGCAT,DGSRTBY,DGCNT) ;Entry point to build list area for PRF Flags.
 ;
 ; The following variables are 'system wide variables' in the
 ; DGPF RECORD FLAG MANAGEMENT List Manager application:
 ;   Input:
 ;       DGARY - global array subscript
 ;       DGCAT - flag category (1=National, 2=Local)
 ;     DGSRTBY - list sort by criteria (N=Flag Name, T=Flage Type)
 ;
 ;  Output:
 ;       DGCNT - number of lines in the list
 ;
 ;display wait msg
 D WAIT^DICD
 ;
 ;retrieve all flags for the category specified
 D GET(DGARY,DGCAT,DGSRTBY)
 ;
 ;build list area for flag screen
 D BLD(DGSRTBY,.DGCNT)
 ;
 ;if no entries in list, display message in list area
 I 'DGCNT D
 . D SET^DGPFLMU1(DGARY,1,"",1,,,.DGCNT)
 . D SET^DGPFLMU1(DGARY,2,"There are currently no flags on file to display.",4,$G(IOINHI),$G(IOINORM),.DGCNT)
 ;
 Q
 ;
 ;
GET(DGARY,DGCAT,DGSRTBY) ;Get flag entries for display.
 ;
 ;  Input:
 ;      DGARY - global array subscript
 ;      DGCAT - flag category (1=National, 2=Local)
 ;    DGSRTBY - list sort by criteria (N=Flag Name, T=Flage Type)
 ;
 ; Output: None
 ;
 N DGFILE  ;file root of LOCAL or NATIONAL flag file
 N DGFLAG  ;local array used to hold flag record
 N DGIEN   ;ien of record in LOCAL or NATIONAL flag file
 N DGVPTR  ;IEN of record in PRF NATIONAL FLAG or PRF LOCAL FLAG file
 N DGRSULT
 ;
 ;determine LOCAL or NATIONAL flag file
 S DGFILE=$S(DGCAT=1:"^DGPF(26.15)",DGCAT=2:"^DGPF(26.11)",1:0)
 ;
 ;loop through each ien of flag file determined by value of DGFILE
 S DGIEN=0 F  S DGIEN=$O(@DGFILE@(DGIEN)) Q:'DGIEN  D
 . K DGFLAG
 . ;- if national, get flag into DGFLAG array
 . I DGCAT=1 D  Q:'$G(DGRSULT)
 . . S DGRSULT=$$GETNF^DGPFANF(DGIEN,.DGFLAG)
 . . S:DGRSULT DGVPTR=DGIEN_";DGPF(26.15,"
 . ;
 . ;- if local, get flag into DGFLAG array
 . I DGCAT=2 D  Q:'$G(DGRSULT)
 . . S DGRSULT=$$GETLF^DGPFALF(DGIEN,.DGFLAG)
 . . S:DGRSULT DGVPTR=DGIEN_";DGPF(26.11,"
 . ;
 . ;- set flag entry into sorted output array
 . D SORT(DGVPTR,DGSRTBY,DGIEN,.DGFLAG)
 ;
 Q
 ;
 ;
SORT(DGVPTR,DGSRTBY,DGIEN,DGFLAG) ;Set flag data into sorted output array based on the sort criteria passed.
 ;
 ;  Input:
 ;    DGVPTR - IEN of record in PRF NATIONAL FLAG or PRF LOCAL FLAG file
 ;             [ex: "1;DGPF(26.15,"]
 ;   DGSRTBY - list sort by criteria (N=Flag Name, T=Flage Type)
 ;     DGIEN - ien of record in LOCAL or NATIONAL flag file
 ;    DGFLAG - local array containing flag record
 ;
 ; Output: 
 ;  Temporary global with following structure -
 ;   Flag list sorted by flag name:
 ;     ^TMP("DGPFSORT",$J,<status>,<flag name>,<ien>)=<var pointer>^<flag name>^<flag type>^<flag status>
 ;   OR
 ;   Flag list sorted by flag type:
 ;      ^TMP("DGPFSORT",$J,<status>,<flag type>,<ien>)=<var pointer>^<flag name>^<flag type>^<flag status>
 ;
 I DGSRTBY="N" D  ;flag name
 . S ^TMP("DGPFSORT",$J,$P($G(DGFLAG("STAT")),U),$P($G(DGFLAG("FLAG")),U,2),DGIEN)=DGVPTR_U_$P($G(DGFLAG("FLAG")),U,2)_U_$P($G(DGFLAG("TYPE")),U,2)_U_$P($G(DGFLAG("STAT")),U,2)
 E  D  ;else flag type
 . S ^TMP("DGPFSORT",$J,$P($G(DGFLAG("STAT")),U),$P($G(DGFLAG("TYPE")),U,2),DGIEN)=DGVPTR_U_$P($G(DGFLAG("FLAG")),U,2)_U_$P($G(DGFLAG("TYPE")),U,2)_U_$P($G(DGFLAG("STAT")),U,2)
 ;
 Q
 ;
 ;
BLD(DGSRTBY,DGCNT) ;Build list area for flag screen.
 ;
 ;  Input:
 ;   DGSRTBY - list sort by criteria (N=Flag Name, T=Flage Type)
 ;
 ; Output:
 ;     DGCNT - number of lines in the list
 ;
 N DGFIEN  ;^tmp global subscript (flag ien)
 N DGLINE  ;line counter
 N DGNAME  ;flag name
 N DGNUM   ;list selction number
 N DGSI    ;flag status internal value
 N DGSTAT  ;flag status
 N DGSUB   ;^tmp global subscript (flag name or type)
 N DGTYPE  ;flag type
 N DGVPTR  ;IEN of record in PRF NATIONAL FLAG or PRF LOCAL FLAG file
 ;          [ex: "1;DGPF(26.15,"]
 N DGTEMP  ;sort array root
 ;
 ;init line counter and selection number
 S (DGLINE,DGNUM)=0
 ;- loop through ^TMP global by status, active (1) then inactive (0)
 F DGSI=1,0 D
 . ;- loop through sort selection by flag name or flag type
 . S DGSUB=$S(DGSRTBY="N":"",1:0)
 . F  S DGSUB=$O(^TMP("DGPFSORT",$J,DGSI,DGSUB)) Q:DGSUB=""  D
 . . ;- loop through flag file ien's
 . . S DGFIEN=0
 . . F  S DGFIEN=$O(^TMP("DGPFSORT",$J,DGSI,DGSUB,DGFIEN)) Q:'DGFIEN  D
 . . . ;-- get flag data fields from entry in ^TMP global
 . . . S DGTEMP=$NA(^TMP("DGPFSORT",$J))
 . . . S DGVPTR=$P($G(@DGTEMP@(DGSI,DGSUB,DGFIEN)),U)    ;flag IEN
 . . . S DGNAME=$P($G(@DGTEMP@(DGSI,DGSUB,DGFIEN)),U,2)  ;flag name
 . . . S DGTYPE=$P($G(@DGTEMP@(DGSI,DGSUB,DGFIEN)),U,3)  ;flag type
 . . . S DGSTAT=$P($G(@DGTEMP@(DGSI,DGSUB,DGFIEN)),U,4)  ;flag status
 . . . ;
 . . . ;-- increment selection number
 . . . S DGNUM=DGNUM+1
 . . . ;
 . . . ;-- increment line counter
 . . . S DGLINE=DGLINE+1
 . . . ;
 . . . ;-- set line into list area
 . . . D SET(DGARY,DGLINE,DGNUM,1,,,DGVPTR,DGNUM,.DGCNT)
 . . . D SET(DGARY,DGLINE,DGNAME,6,,,DGVPTR,DGNUM,.DGCNT)
 . . . D SET(DGARY,DGLINE,DGTYPE,38,,,DGVPTR,DGNUM,.DGCNT)
 . . . D SET(DGARY,DGLINE,DGSTAT,65,,,DGVPTR,DGNUM,.DGCNT)
 ;
 Q
 ;
 ;
SET(DGARY,DGLINE,DGTEXT,DGCOL,DGON,DGOFF,DGVPTR,DGNUM,DGCNT) ;This procedure will set the lines of flag details in the LM display area.
 ;
 ;  Input:
 ;    DGARY - global array subscript
 ;   DGLINE - line number
 ;   DGTEXT - text
 ;   DGVPTR - (optional) IEN of record in PRF NATIONAL FLAG or PRF LOCAL
 ;            FLAG file [ex: "1;DGPF(26.15,"]
 ;    DGNUM - (optional) selection number
 ;    DGCOL - starting column
 ;     DGON - highlighting on
 ;    DGOFF - highlighting off
 ;
 ; Output:
 ;   DGCNT - number of lines in the list, pass by reference
 ;
 N DGX
 S:DGLINE>DGCNT DGCNT=DGLINE
 S DGX=$S($D(^TMP(DGARY,$J,DGLINE,0)):^(0),1:"")
 S ^TMP(DGARY,$J,DGLINE,0)=$$SETSTR^VALM1(DGTEXT,DGX,DGCOL,$L(DGTEXT))
 D:$G(DGON)]""!($G(DGOFF)]"") CNTRL^VALM10(DGLINE,DGCOL,$L(DGTEXT),$G(DGON),$G(DGOFF))
 ;
 ;associate flag ien with list item for flag selection
 S:($G(DGVPTR)]"")&($G(DGNUM)) ^TMP(DGARY,$J,"IDX",DGLINE,DGNUM)=""
 S:($G(DGVPTR)]"")&($G(DGNUM)) ^TMP(DGARY,$J,"IDX",DGNUM)=DGVPTR
 Q
