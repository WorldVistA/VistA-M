GMTSPDXZ ;SLC/NCG - Create Data Segment from H.S. Component ;26-OCT-94 ;1/4/95  09:22
 ;;2.7;Health Summary;;Oct 20, 1995
VAQUTL50 ;ALB/JRP - CREATE DATA SEGMENT FROM H.S. COMPONENT ;26-OCT-94
 ;;1.5;PATIENT DATA EXCHANGE;**11**;NOV 17, 1993
ADDSEG(HSPTR,MAXTIME,MAXOCCUR) ;ADD NEW DATA SEGMENT USING H.S. COMPONENT
 ;INPUT  : HSPTR - Pointer to HEALTH SUMMARY COMPONENT file (#142.1)
 ;         MAXTIME - Max time limit allowed for auto processing
 ;         MAXOCCUR - Max occurrence limit allowed for auto processing
 ;OUTPUT : X - Pointer to VAQ - DATA SEGMENT file (#394.71) that
 ;             was created
 ;        -1^ErrorText - Entry not created
 ;NOTES  : If time and/or occurrence limits do not apply to the
 ;         component, MAXTIME and/or MAXOCCUR are not required.
 ;       : If time and/or occurrence limits apply to the component,
 ;         default values will be taken from the VAQ - PARAMETER
 ;         file (#394.81).  If parameter file does not contain these
 ;         values, a default of 1 year and 10 occurrences will be used.
 ;       : If a maximum limit is not valid, the default limit will
 ;         be used.
 ;
 ;CHECK INPUT
 S HSPTR=+$G(HSPTR)
 Q:('HSPTR) "-1^Did not pass pointer to HEALTH SUMMARY COMPONENT file"
 Q:('$D(^GMT(142.1,HSPTR,0))) "-1^Did not pass valid pointer to HEALTH SUMMARY COMPONENT file"
 S MAXTIME=$G(MAXTIME)
 S MAXOCCUR=$G(MAXOCCUR)
 ;DECLARE VARIABLES
 N NAME,ABB,TIME,OCCUR,TMP,DEFTIME,DEFOCCUR
 N X,Y,DIC,DINUM,DA,DIE,DR
 ;GET COMPONENT NAME & ABBREVIATION
 S TMP=$G(^GMT(142.1,HSPTR,0))
 S NAME=$P(TMP,"^",1)
 Q:(NAME="") "-1^Entry in HEALTH SUMMARY COMPONENT file did not contain a name"
 S ABB=$P(TMP,"^",4)
 Q:(ABB="") "-1^Entry in HEALTH SUMMARY COMPONENT file did not contain an abbreviation"
 ;CONVERT NAME SO ONLY FIRST CHARACTER OF EVERY WORD IS IN UPPERCASE
 S NAME=$$FIRSTUP(NAME)
 ;SEE IF NAME OR ABBREVIATION ALREADY EXIST IN DATA SEGMENT FILE
 Q:($D(^VAT(394.71,"B",NAME))) "-1^"_NAME_" already exists in VAQ - DATA SEGMENT file"
 Q:($D(^VAT(394.71,"CAPS",NAME))) "-1^"_NAME_" already exists in VAQ - DATA SEGMENT file"
 Q:($D(^VAT(394.71,"C",ABB))) "-1^Abbreviation of "_ABB_" already used in VAQ - DATA SEGMENT file"
 ;GET DEFAULT TIME AND OCCURRENCE LIMITS
 S X=+$O(^VAT(394.81,0))
 S TMP=$G(^VAT(394.81,X,"LIMITS"))
 S DEFTIME=$P(TMP,"^",1)
 S:(DEFTIME="") DEFTIME="1Y"
 S DEFOCCUR=$P(TMP,"^",2)
 S:(DEFOCCUR="") DEFOCCUR=10
 ;DETERMINE IF TIME AND/OR OCCURRENCE LIMITS APPLY
 S TMP=$$LIMITS^VAQDBIH3(HSPTR)
 S TIME=+TMP
 S OCCUR=+$P(TMP,"^",2)
 ;SET MAX LIMITS
 I (TIME) S:($$VALOCC^VAQDBIH2(MAXTIME,0)<0) MAXTIME=DEFTIME
 I ('TIME) S MAXTIME=""
 I (OCCUR) S:($$VALOCC^VAQDBIH2(MAXOCCUR,1)<0) MAXOCCUR=DEFOCCUR
 I ('OCCUR) S MAXOCCUR=""
 ;SET UP CALL TO FILEMAN & CREATE STUB
 K DD,DO
 S DIC="^VAT(394.71,"
 S DIC(0)="L"
 S X=NAME
 D FILE^DICN
 S DA=+Y
 Q:(DA<0) "-1^Unable to create entry in VAQ - DATA SEGMENT file"
 ;SET UP CALL TO FILEMAN & FINISH ENTRY
 S DIE="^VAT(394.71,"
 S DR=".02///^S X=ABB"
 S DR(1,394.71,.03)=".03///YES"
 S DR(1,394.71,.04)=".04////"_HSPTR
 S DR(1,394.71,.05)=".05///^S X=MAXTIME"
 S DR(1,394.71,.06)=".06///^S X=MAXOCCUR"
 S DR(1,394.71,10)="10///$$GET^GMTSPDX(TRAN,DFN,SEGPTR,ROOT,(OFFSET-1),TIMLIM,OCCLIM)"
 S DR(1,394.71,20)="20///@"
 D ^DIE
 Q 0
LOWER(STRING) ;CONVERT UPPERCASE TO LOWERCASE
 ;INPUT  : STRING - Text string to convert
 ;OUTPUT : string - Same text string in all lowercase
 ;
 Q $TR($G(STRING),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
FIRSTUP(TEXT) ;FIRST CHARACTER EVERY WORD UPPER
 ;INPUT  : TEXT - Text string to convert
 ;OUTPUT : Text - Same text string with beginning of every word
 ;                in uppercase and all other characters in lowercase
 ;
 ;CHECK INPUT
 Q:($G(TEXT)="") ""
 ;DECLARE VARIABLES
 N OUTTEXT,SPOT,UPCHAR,X,Y,LEN
 ;CONVERT TO LOWERCASE
 S OUTTEXT=$$LOWER(TEXT)
 ;CAPITALIZE FIRST WORD
 S X=$E(OUTTEXT,1)
 X ^%ZOSF("UPPERCASE")
 S OUTTEXT=Y_$E(OUTTEXT,2,$L(OUTTEXT))
 ;CAPITALIZE REST OF WORDS
 S SPOT=1
 S LEN=$L(OUTTEXT)
 F  S SPOT=$F(OUTTEXT," ",SPOT) Q:('SPOT)  D
 .S X=$E(OUTTEXT,SPOT)
 .X ^%ZOSF("UPPERCASE")
 .S OUTTEXT=$E(OUTTEXT,1,(SPOT-1))_Y_$E(OUTTEXT,(SPOT+1),LEN)
 Q OUTTEXT
