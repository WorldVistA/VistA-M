MAGXCVP ;WOIFO/SEB,MLH - Image Index Conversion Generate & Commit ; 05/18/2007 11:23
 ;;3.0;IMAGING;**17,25,31,54**;03-July-2009;;Build 1424
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
 ;
 ; Input starting and ending IENs. Return in variables START and END.
BOUNDS(START,END) N TEMP
START R !,"From ID: 1 // ",START:DTIME
 I $E(START)="?" D  G START
 . W !!,"Please enter the ID of an entry in the image file. This will be the first image"
 . W !,"in the range of images processed by this menu option.",!
 . Q
 I START="" S START=1
 I START="^" Q
 I +START'=START W !!,"Please enter a starting image ID - numbers only." G START
END R !,"To ID: LAST // ",END:DTIME
 I $E(END)="?" D  G END
 . W !!,"Please enter the ID of an entry in the image file. This will be the last image"
 . W !,"in the range of images processed by this menu option.",!
 . Q
 I "^LAST"[("^"_$$UCASE(END)) D  ; includes null response default
 . W "  LAST"
 . S END=+$P($G(^MAG(2005,0)),U,3)
 . Q
 I END="^" S START="^" Q
 I +END'=END W !!,"Please enter an ending image ID - numbers only." G END
 I START>END D  G END ;S TEMP=END,END=START,START=TEMP
 . W !!,"'To ID' value must not be less than 'From ID' value."
 . Q
 Q
 ;
 ; Prompt whether the user wishes to recreate previously-calculated indices. Return in FLAG.
RECREATE(FLAG) S FLAG=""
RECR R !,"Recreate previously calculated indices? Y // ",FLAG:DTIME
 S FLAG=$$UCASE($E(FLAG)) I FLAG="" S FLAG="Y"
 I FLAG="?" D  G RECR
 . W !!,"Entering YES will cause index fields that have been calculated by a previous"
 . W !,"execution of this option to be recalculated. Entering NO will cause the option"
 . W !,"to skip images that already have index fields.",!
 . Q
 I "YN^"'[FLAG W !!,"Please enter YES or NO." G RECR
 Q
 ;
 ; Ask if user wishes to job a task into the background with TaskMan. Returns NULL if
 ; the user wishes to run it in the foreground, and a schedule date/time if the user
 ; wishes to use TaskMan.
TASKMAN(RETURN) N ASK,X,%DT
 I '$$TM^%ZTLOAD() S RETURN="" Q
TMA R !,"Would you like to schedule this with TaskMan? Y // ",ASK:DTIME
 S ASK=$$UCASE($E(ASK))
 I ASK="?" D  G TMA
 . W !!,"Entering YES will run this task with TaskMan. Entering NO will cause it to"
 . W !,"run in the foreground.",!
 I "YN^"'[ASK W !!,"Please enter YES or NO." G TMA
 I ASK="^" S RETURN="^" Q
 I ASK="N" S RETURN="" Q
SCHED R !!,"Please enter the date/time for scheduling the task: NOW // ",X:DTIME I X="" S X="NOW"
 I X="^" S RETURN="^" Q
 S %DT="R" D ^%DT I Y=-1 G SCHED
 S RETURN=Y Q
 Q
 ;
DONE W !!,"Done!"
 Q
 ;
 ; Generate a notification message and send it to group MAG SERVER
NOTIFY(RESULT,SUBJECT,STARTDT,ENDDT,STARTIEN,ENDIEN,RECR) N Y,LOC,XMSUB,DIS,CAP,CNT,I,VR,DM,SUMMARY
 K ^TMP($J,"MAGQ")
 S Y=$$HTE^XLFDT($H,1) ; EdM: is Y used anywhere?
 S U="^",LOC=$$KSP^XUPARAM("WHERE")
 S SUBJECT=$G(SUBJECT)
 I +SUBJECT=SUBJECT S SUBJECT=$P("Generate^Commit",U,SUBJECT)
 S XMSUB=SUBJECT_" Image Index Conversion Values: "_$G(ENDDT)
 S ^TMP($J,"MAGQ",1)="Status: "_$$ST^MAGXCVR
 S ^TMP($J,"MAGQ",2)="Started on: "_$G(STARTDT)
 S ^TMP($J,"MAGQ",3)="Finished on: "_$G(ENDDT)
 S ^TMP($J,"MAGQ",4)="Starting IEN: "_$G(STARTIEN)
 S ^TMP($J,"MAGQ",5)="Ending IEN: "_$G(ENDIEN)
 S ^TMP($J,"MAGQ",6)="Recreate Indices: "_$G(RECR)
 S SUMMARY=""
 F I=7:1 S SUMMARY=$O(^XTMP("MAG30P25","SUMMARY",SUMMARY)) Q:SUMMARY=""  D
 . S ^TMP($J,"MAGQ",I)=SUMMARY_U_^XTMP("MAG30P25","SUMMARY",SUMMARY)
 . Q
 N XMY,XMTEXT
 S XMTEXT="^TMP($J,""MAGQ"","
 S:$G(DUZ) XMY(DUZ)=""
 S XMY("G.MAG SERVER")=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 D ^XMD
 S RESULT="1"
 K ^TMP($J,"MAGQ")
 Q
 ; 
 ; Convert a string to all uppercase.
UCASE(STRING) N OUTPUT
 S OUTPUT=$TR(STRING,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q OUTPUT
 ;
 ; Convert a string to all lowercase.
LCASE(STRING) N OUTPUT
 S OUTPUT=$TR(STRING,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 Q OUTPUT
 ;
 ; Strip leading and trailing spaces.
STRIP(STRING) N START,END
 F START=1:1:$L(STRING) I $E(STRING,START)'=" " Q
 F END=$L(STRING):-1:1 I $E(STRING,END)'=" " Q
 Q $E(STRING,START,END)
 ;
SCRUBTKN(XSTRING) ; FUNCTION - Create standard token delimiters for parsing
 ; by changing all punctuation to spaces.
 N STRING ; output string
 S STRING=$TR(XSTRING,"+-/\.,~`!@#$%^&*()_-={}[]|:;""'<>?","                                 ")
 ; compress multiple spaces to single space
 F  Q:STRING'["  "  S STRING=$P(STRING,"  ",1)_" "_$P(STRING,"  ",2,999)
 Q STRING
 ;
