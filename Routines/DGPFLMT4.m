DGPFLMT4 ;ALB/RBS - PRF TRANSMIT VIEW MESSAGE BUILD LIST AREA ; 10/19/06 10:59am
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 ;no direct entry
 QUIT
 ;
 ;
EN(DGARY,DGPFIEN,DGCNT) ;Entry point to build error detail list area.
 ;
 ;  Input:
 ;      DGARY - subscript name for temp global
 ;    DGPFIEN - IEN of record
 ;
 ; Output:
 ;      DGCNT - number of display lines, pass by reference (VALMCNT)
 ;
 ;quit if required input paramater not passed
 Q:'$G(DGPFIEN)
 ;
 S:$G(DGARY)="" DGARY="DGPFVDET"
 ;
 N DGAIEN   ;assignment ien
 N DGCOD    ;error code
 N DGLI     ;dialog text line number
 N DGPFA    ;assignment array
 N DGPFAH   ;assignment history data array
 N DGPFL    ;HL7 transmission log data array
 N DGLINE   ;line counter
 N DGSUB    ;subscript var
 N DGPFL    ;HL7 transmission log data array
 N DIERR    ;var returned from BLD^DIALOG
 N DGTBL    ;error code table array
 N DGTEMP   ;array returned from BLD^DIALOG with error msg text
 ;
 ;init variables
 S DGLINE=0
 K DGPFA,DGPFAH,DGPFL,DGTBL
 ;
 ;retrieve HL7 log data
 Q:'$$GETLOG^DGPFHLL(DGPFIEN,.DGPFL)
 Q:'+DGPFL("ASGNHIST")
 ;retrieve assignment history data to get PRF Assignment ien
 Q:'$$GETHIST^DGPFAAH(+DGPFL("ASGNHIST"),.DGPFAH)
 S DGAIEN=$P($G(DGPFAH("ASSIGN")),U,1)
 Q:'DGAIEN
 Q:'$$GETASGN^DGPFAA(DGAIEN,.DGPFA)
 ;
 ;set Error Received D/T
 S DGLINE=DGLINE+1
 D SET^DGPFLMT1(DGARY,DGLINE,"Error Received D/T: "_$$FDTTM^VALM1($P($G(DGPFL("ACKDT")),U,1)),10,,,.DGCNT)
 ;
 ;set Message Control ID
 S DGLINE=DGLINE+1
 D SET^DGPFLMT1(DGARY,DGLINE,"Message Control ID: "_$P($G(DGPFL("MSGID")),U,2),10,,,.DGCNT)
 ;
 ;set Flag Name
 S DGLINE=DGLINE+1
 D SET^DGPFLMT1(DGARY,DGLINE,"Flag Name: "_$P($G(DGPFA("FLAG")),U,2),19,,,.DGCNT)
 ;
 ;set Owner Site
 S DGLINE=DGLINE+1
 D SET^DGPFLMT1(DGARY,DGLINE,"Owner Site: "_$P($G(DGPFA("OWNER")),U,2),18,,,.DGCNT)
 ;
 ;set Assignment Transmitted To
 S DGLINE=DGLINE+1
 D SET^DGPFLMT1(DGARY,DGLINE,"Assignment Transmitted To: "_$P($G(DGPFL("SITE")),U,2),3,,,.DGCNT)
 ;
 ;set Assignment Transmission Date/Time
 S DGLINE=DGLINE+1
 D SET^DGPFLMT1(DGARY,DGLINE,"Assignment Transmission D/T: "_$$FDTTM^VALM1($P($G(DGPFL("TRANSDT")),U,1)),1,,,.DGCNT)
 ;
 ;set blank line
 S DGLINE=DGLINE+1
 D SET^DGPFLMT1(DGARY,DGLINE," ",1,,,.DGCNT)
 ;
 ;set Rejection Reason
 S DGLINE=DGLINE+1
 D SET^DGPFLMT1(DGARY,DGLINE,"Rejection Reason(s): ",1,,,.DGCNT)
 ;
 ;set underline
 S DGLINE=DGLINE+1
 D SET^DGPFLMT1(DGARY,DGLINE,"--------------------",1,,,.DGCNT)
 ;
 ;set no error code message
 I $O(DGPFL("ERROR",""))="" D  Q 
 . S DGLINE=DGLINE+1
 . D SET^DGPFLMT1(DGARY,DGLINE,">>> There are no Rejection Reason codes on file.",1,,,.DGCNT)
 ;
 ;load error code table
 D BLDVA086^DGPFHLU3(.DGTBL)
 ;
 ;loop and set error msg text lines
 S DGSUB=0
 F  S DGSUB=$O(DGPFL("ERROR",DGSUB)) Q:'DGSUB  D
 . Q:$G(DGPFL("ERROR",DGSUB))']""
 . K DGTEMP
 . S DGCOD=DGPFL("ERROR",DGSUB)
 . ;assume numeric error code is a DIALOG
 . I DGCOD?1N.N D BLD^DIALOG(DGCOD,"","","DGTEMP")
 . I $D(DGTEMP) D FORMAT(.DGTEMP,70)
 . ;if not a DIALOG, then is it a table entry?
 . I '$D(DGTEMP),DGCOD]"",$D(DGTBL(DGCOD,"DESC")) S DGTEMP(1)=DGTBL(DGCOD,"DESC") D FORMAT(.DGTEMP,70)
 . ;not a DIALOG or table entry - then error is unknown
 . I '$D(DGTEMP) S DGTEMP(1)="Unknown Error code: '"_DGCOD_"'"
 . ;
 . F DGLI=1:1 Q:'$D(DGTEMP(DGLI))  S DGLINE=DGLINE+1 D
 . . I DGLI=1 D SET^DGPFLMT1(DGARY,DGLINE,DGSUB_". "_DGTEMP(DGLI),1,,,.DGCNT)
 . . E  D SET^DGPFLMT1(DGARY,DGLINE,"   "_DGTEMP(DGLI),1,,,.DGCNT)
 ;
 Q
 ;
FORMAT(DGTEXT,DGMAX) ;format text lines to length
 ;This procedure formats an array of text lines to be less than a
 ;given maximum length.
 ;
 ;  Supported DBIA:  #10104 - $$TRIM^XLFSTR Kernel api to trim spaces
 ;
 ;  Input:
 ;      DGTEXT - (required) array of text lines (passed by reference)
 ;       DGMAX - (optional) maximum line length (default = 75)
 ;
 ; Output:
 ;      DGTEXT - re-formatted array of text lines
 ;
 Q:'$D(DGTEXT)
 ;
 N DGARRY   ;temp array for re-formatting
 N DGI      ;loop var
 N DGLN     ;line counter var
 N DGMORE   ;leftover words
 N DGNEWLN  ;new text line
 N DGOLDLN  ;original text line
 N DGSPOT   ;position of text line to break at
 ;
 S:'+$G(DGMAX) DGMAX=75
 ;
 S (DGI,DGLN,DGMORE,DGNEWLN,DGOLDLN,DGSPOT)=""
 ;
 F DGI=1:1 S DGOLDLN=$G(DGTEXT(DGI)) Q:'$L(DGOLDLN)&'$L(DGMORE)  D
 . I DGOLDLN'?1.P S DGOLDLN=$$TRIM^XLFSTR(DGOLDLN)
 . I $L(DGOLDLN)'>DGMAX,'$L(DGMORE) D  Q
 . . S DGLN=DGLN+1,DGARRY(DGLN)=DGOLDLN
 . ;
 . I $L(DGMORE),(DGOLDLN?1.P!('$L(DGOLDLN))) D  Q
 . . S DGLN=DGLN+1,DGARRY(DGLN)=DGMORE,DGMORE=""
 . . S:$L(DGOLDLN) DGLN=DGLN+1,DGARRY(DGLN)=DGOLDLN
 . ;
 . S:$L(DGMORE) DGOLDLN=DGMORE_" "_DGOLDLN,DGMORE=""
 . ;
 . I $L(DGOLDLN)>DGMAX F  D  Q:'$L(DGOLDLN)
 . . S DGSPOT=$L($E(DGOLDLN,1,DGMAX)," ")
 . . S DGNEWLN=$P(DGOLDLN," ",1,$S(DGSPOT>1:DGSPOT-1,1:1))
 . . S DGLN=DGLN+1,DGARRY(DGLN)=DGNEWLN,DGNEWLN=""
 . . S DGMORE=$P(DGOLDLN," ",$S(DGSPOT>1:DGSPOT,1:DGSPOT+1),$L(DGOLDLN," "))
 . . I $L(DGMORE)>DGMAX S DGOLDLN=DGMORE,DGMORE=""
 . . E  S DGOLDLN=""
 . E  D
 . . S DGLN=DGLN+1,DGARRY(DGLN)=DGOLDLN
 ;
 I $D(DGARRY) K DGTEXT M DGTEXT=DGARRY
 Q
