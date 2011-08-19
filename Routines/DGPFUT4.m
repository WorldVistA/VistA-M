DGPFUT4 ;ALB/SAE - PRF UTILITIES CONTINUED ; 6/9/04 1:33pm
 ;;5.3;Registration;**554**;Aug 13, 1993
 ;
 Q  ; no direct entry
 ;
BLDGLOB(DGPFDA,DGPFHX,TXN,DGPFLOUT,DGPFGOUT) ; build global
 ;
 ; This procedure builds the temporary global for display.
 ; It first determines the longest label, then it steps thru the $TEXT
 ; list of labels of fields, which control the order of nodes created.
 ; For each label it appends the field value then adds the resulting
 ; value to the temporary global ^TMP("DGPFARY",$J).
 ;
 ; Input:
 ;   DGPFDA - data array
 ;        - derived from DGPFA  if called by Flag Assignment transaction
 ;        - derived from DGPFLF if called by Flag Management transaction
 ;   DGPFHX - history array
 ;        - derived from DGPFAH if called by Flag Assignment transaction
 ;        - derived from DGPFLH if called by Flag Management transaction
 ;   TXN - transaction - one of the following:
 ;         FA - FLAG ASSIGNMENT - Assign Flag
 ;         FA - FLAG ASSIGNMENT - Edit Flag Assignment
 ;         FA - FLAG ASSIGNMENT - Change Assignment Ownership
 ;         FM - FLAG MANAGEMENT - Add New Record Flag
 ;         FM - FLAG MANAGEMENT - Edit Record Flag
 ;   DGPFLOUT - (L)ocal (OUT)put array, containing non-WP fields
 ;   DGPFGOUT - (G)lobal (OUT)put array name to be built.
 ;
 ; Output:
 ;   DGPFGOUT - (G)lobal (OUT)put - name of ^TMP global built
 ;              Contains assignment detail
 ;              This global is displayed to screen for user.
 ;
 ; Temporary variables:
 N DGPFROOT  ; Array root subscript
 N DGPFCOL   ; Column value for each display field, stored in text block
 N DGPFLABL  ; Label of DGPFROOT for display
 N DGPFVAL   ; Value from DGPFROOT array node
 N DGPFPAD   ; Holds padded spaces for display alignment
 N DGPFOFST  ; Offset of text line in text subroutine
 N DGPFLONG  ; Longest label for later display
 N DGPFLINE  ; Line number incremented during final global build in SET
 N DGPFRTN   ; Routine that contains the TEXT from which to read
 N DGPFTEXT  ; value of text line retrieved from TEXT
 N DGPFTAG   ; tag at offset of TEXT
 N DGPFSR    ; TEXT subroutine to use to acquire data
 N DGPFPICT  ; count of number of times PRININV array has been read
 ;
 S DGPFLINE=0
 S DGPFRTN=$P(TXN,U)_"TXT"
 S DGPFPICT=0
 ;
 ; determine longest label - set this value into the variable DGPFLONG:
 S DGPFLONG=1
 F DGPFOFST=2:1 D  Q:DGPFROOT=""!(DGPFROOT="QUIT")
 . S DGPFTAG=DGPFRTN_"+"_DGPFOFST,DGPFTEXT=$T(@DGPFTAG)
 . S DGPFROOT=$P(DGPFTEXT,";",3)
 . Q:DGPFROOT=""!(";DESC;NARR;COMMENT;REASON;QUIT;"[(";"_DGPFROOT_";"))
 . I DGPFROOT="PRININV",'$D(DGPFLOUT(DGPFROOT)) Q
 . S DGPFLABL=$P(DGPFTEXT,";",5)
 . S DGPFLONG=$S($L(DGPFLABL)+1>DGPFLONG:$L(DGPFLABL)+1,1:DGPFLONG)
 ;
 ; step thru the text - this controls the order of display
 F DGPFOFST=2:1 D  Q:DGPFROOT=""!(DGPFROOT="QUIT")
 . S DGPFTAG=DGPFRTN_"+"_DGPFOFST,DGPFTEXT=$T(@DGPFTAG)
 . S DGPFROOT=$P(DGPFTEXT,";",3)
 . S DGPFLABL=$P(DGPFTEXT,";",5)
 . Q:DGPFROOT=""!(DGPFROOT="QUIT")
 . ;
 . ; build array from Principal Investigator multiple
 . I DGPFROOT="PRININV" D  Q
 . . D BLDPI(DGPFROOT,DGPFLABL,DGPFLONG,.DGPFLINE,.DGPFLOUT,DGPFGOUT)
 . ;
 . ; build array from word-processing multiple:
 . I ";DESC;NARR;COMMENT;REASON;"[(";"_DGPFROOT_";") D  Q
 . . D BLDWP(DGPFROOT,DGPFLABL,.DGPFLINE,.DGPFLOUT,DGPFGOUT)
 . ;
 . S DGPFCOL=DGPFLONG-$L(DGPFLABL)
 . S DGPFPAD=$E($J("",DGPFCOL),1,DGPFCOL)
 . S DGPFVAL=DGPFPAD_DGPFLABL_DGPFLOUT(DGPFROOT)
 . ;
 . S DGPFLINE=DGPFLINE+1
 . S @DGPFGOUT@(DGPFLINE,0)=DGPFVAL
 Q
 ;
BLDPI(DGPFROOT,DGPFLABL,DGPFLONG,DGPFLINE,DGPFLOUT,DGPFGOUT) ;
 ;
 ; Add each of the nodes from the PRININV array multiple to temp global.
 ;
 ; Input:
 ;   DGPFROOT - Name of the field derived from the $TEXT segment below
 ;   DGPFLABL - Label
 ;   DGPFLONG - Contains length of longest label
 ;   DGPFLINE - Line number for incrementing of global array nodes
 ;   DGPFLOUT - Local array of WP text
 ;   DGPFGOUT - (G)lobal (OUT)put - name of ^TMP global built
 ;
 ; Output:
 ;   none - build DGPFGOUT - (G)lobal (OUT)put ^TMP global
 ;
 ; Temporary variables:
 N DGPFSUB ; subscript
 N DGPFPAD ; padding for leading spaces for display
 N DGPFCOL ; column value for Principal Investigator label
 N DGPFVAL ; value from DGPFROOT array node
 ;
 S DGPFCOL=DGPFLONG-$L(DGPFLABL)
 S DGPFPAD=$E($J("",DGPFCOL),1,DGPFCOL)
 ;
 S DGPFSUB=""
 F  S DGPFSUB=$O(DGPFLOUT(DGPFROOT,DGPFSUB)) Q:'DGPFSUB  D
 . S DGPFVAL=DGPFPAD_DGPFLABL_$G(DGPFLOUT(DGPFROOT,DGPFSUB,0))
 . ;
 . S DGPFLINE=DGPFLINE+1
 . S @DGPFGOUT@(DGPFLINE,0)=DGPFVAL
 Q
 ;
BLDWP(DGPFROOT,DGPFLABL,DGPFLINE,DGPFLOUT,DGPFGOUT) ;build WP array
 ;
 ; This procedure adds each of the nodes from the word-processing
 ; multiple to the temp global (^TMP).
 ;
 ; Input:
 ;   DGPFROOT - Name of the field derived from the $TEXT segment below
 ;   DGPFLABL - label
 ;   DGPFLINE - Line number for incrementing of global array nodes
 ;   DGPFLOUT - Local array of WP text to be added to the global array
 ;   DGPFGOUT - (G)lobal (OUT)put - name of ^TMP global built
 ;
 ; Output:
 ;   none - build DGPFGOUT - (G)lobal (OUT)put ^TMP global
 ;
 ; Temporary variables:
 N DGSUB ; subscript value in word processing fields
 N DGPFPAD ; Padding as spaces for alignment of headers
 N DGPFVAL ; value from DGPFROOT array node
 ;
 S DGPFPAD=" "
 ;
 ; insert header for narrative:
 S DGPFVAL=DGPFPAD_DGPFLABL
 ;
 S DGPFLINE=DGPFLINE+1
 S @DGPFGOUT@(DGPFLINE,0)=DGPFVAL
 ;
 ; set each word processing line
 S DGSUB=0
 F  S DGSUB=$O(DGPFLOUT(DGPFROOT,DGSUB)) Q:'DGSUB  D
 . S DGPFVAL=DGPFPAD_$G(DGPFLOUT(DGPFROOT,DGSUB,0))
 . ;
 . S DGPFLINE=DGPFLINE+1
 . S @DGPFGOUT@(DGPFLINE,0)=DGPFVAL
 Q
 ;
FATXT ; ordered list of fields to be presented to user for Flag Assignment
 ;;ROOT;       ;LABEL;
 ;;PATIENT;    ;Patient Name: ;
 ;;FLAGNAME;   ;Flag Name: ;
 ;;FLAGTYPE;   ;Flag Type: ;
 ;;CATEGORY;   ;Flag Category: ;
 ;;STATUS;     ;Assignment Status: ;
 ;;INITASSIGN; ;Initial Assignment: ;
 ;;LASTREVIEW; ;Last Review Date: ;
 ;;REVIEWDT;   ;Next Review Date: ;
 ;;OWNER;      ;Owner Site: ;
 ;;ORIGSITE;   ;Originating Site: ;
 ;;ACTION;     ;Assignment Action: ;
 ;;ACTIONDT;   ;Action Date: ;
 ;;ENTERBY;    ;Entered By: ;
 ;;APPRVBY;    ;Approved By: ;
 ;;NARR;       ;Record Flag Assignment Narrative: ;
 ;;COMMENT;    ;Action Comments: ;
 ;;QUIT;
 Q
 ;
FMTXT ; ordered list of fields to be presented to user for Flag Management
 ;;ROOT;       ;LABEL;
 ;;FLAGNAME;   ;Flag Name: ;
 ;;CATEGORY;   ;Flag Category: ;
 ;;FLAGTYPE;   ;Flag Type: ;
 ;;STATUS;     ;Flag Status: ;
 ;;REVFREQ;    ;Review Frequency Days: ;
 ;;NOTIDAYS;   ;Notification Days: ;
 ;;REVGRP;     ;Review Mail Group: ;
 ;;TIUTITLE;   ;Progress Note Title: ;
 ;;ENTERDT;    ;Enter/Edit On: ;
 ;;ENTERBY;    ;Enter/Edit By: ;
 ;;PRININV;    ;Principal Investigator(s): ;
 ;;DESC;       ;Flag Description: ;
 ;;REASON;     ;Reason For Flag Enter/Edit: ;
 ;;QUIT;
 Q
