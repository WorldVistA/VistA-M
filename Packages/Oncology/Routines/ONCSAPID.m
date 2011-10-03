ONCSAPID ;Hines OIFO/SG - COLLABORATIVE STAGING (DEMO) ; 12/7/06 9:33am
 ;;2.11;ONCOLOGY;**40,47**;Mar 07, 1995;Build 19
 ;
 Q
 ;
 ;***** DEMO ENTRY POINT
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
DEMO(ONCSAPI) ;
 N DISPLAY,EXIT,I,INPUT,RC,STATUS,STORE
 W !!?10,"DEMO CLIENT FOR THE COLLABORATIVE STAGING API",!
 D CLEAR^ONCSAPIE(1)
 ;--- Check the DLL version
 S RC=$$CHKVER^ONCSAPIV(.ONCSAPI)
 D:RC<0 PRTERRS^ONCSAPIE()
 ;
 ;---
 S EXIT=0
 F  D  Q:EXIT
 . D CLEAR^ONCSAPIE()
 . ;--- Review/Edit input values
 . S RC=$$INPUT(.INPUT)
 . I RC<0  S EXIT=1  Q
 . ;--- Call the CS API
 . S RC=$$CALC^ONCSAPI3(.ONCSAPI,.INPUT,.STORE,.DISPLAY,.STATUS)
 . ;--- Display the output values
 . W !!,"Output values of the Collaborative Staging API",!
 . I $D(STORE)>1  S I=""  D  W !
 . . F  S I=$O(STORE(I))  Q:I=""  D
 . . . W !?2,$NA(STORE(I))_"="""_$G(STORE(I))_""""
 . . . W ?42,$NA(DISPLAY(I))_"="""_$G(DISPLAY(I))_""""
 . I RC  D  D ZW^ONCSAPIU("STATUS")
 . . W !,"$$CALC^ONCSAPI3="""_RC_"""",!
 . ;--- Display formatted error messages
 . D:RC<0 PRTERRS^ONCSAPIE()
 . ;--- Pause the output
 . S EXIT=$$PAGE^ONCSAPIU()  W !
 ;---
 Q
 ;
 ;***** USER INPUT FOR THE DEMO ENTRY POINT
 ;
 ; .ONCINP       Reference to a local variable for input parameters
 ;
 ; Return values:
 ;
 ;       -2  Timeout
 ;       -1  User entered an up-arrow
 ;        0  Ok
 ;
INPUT(ONCINP) ;
 ;;HIST     ^8000^4^Histologic Type ICD-O-3
 ;;SITE     ^C000^4^Primary Site
 ;;BEHAV    ^3   ^1^Behavior Code ICD-O-3
 ;;GRADE    ^1   ^1^Grade
 ;;AGE      ^043 ^3^Age at Diagnosis
 ;;SIZE     ^010 ^3^CS Tumor Size^1
 ;;EXT      ^20  ^2^CS Extension^2
 ;;EXTEVAL  ^0   ^1^CS Size/Ext Eval^3
 ;;NODES    ^11  ^2^CS Lymph Nodes^4
 ;;NODESEVAL^0   ^1^CS Reg Nodes Eval^5
 ;;LNPOS    ^98  ^2^Regional Nodes Positive^6
 ;;LNEXAM   ^00  ^2^Regional Nodes Examined^7
 ;;METS     ^00  ^2^CS Mets at DX^8
 ;;METSEVAL ^0   ^1^CS Mets Eval^9
 ;;SSF1     ^001 ^3^CS Site-Specific Factor 1^10
 ;;SSF2     ^000 ^3^CS Site-Specific Factor 2^11
 ;;SSF3     ^000 ^3^CS Site-Specific Factor 3^12
 ;;SSF4     ^000 ^3^CS Site-Specific Factor 4^13
 ;;SSF5     ^000 ^3^CS Site-Specific Factor 5^14
 ;;SSF6     ^000 ^3^CS Site-Specific Factor 6^15
 ;
 N DIR,DIRUT,DTOUT,DUOUT,FLDLST,ICOL,IFLD,IIF,IROW,ML,NAME,NFL,NR,ONCBUF,RC,TABLE,TMP,VAL,X,Y
 W !,"Input values for Collaborative Staging API"
 S RC=0
 ;--- Determine number of fields and load default values
 F NFL=1:1  S TMP=$P($T(INPUT+NFL),";;",2)  Q:TMP=""  D
 . S FLDESCR(NFL)=TMP,NAME=$TR($P(TMP,U)," ")
 . S:'$D(ONCINP(NAME)) ONCINP(NAME)=$TR($P(TMP,U,2)," ")
 S NFL=NFL-1
 ;
 ;--- Review and/or edit field values
 F  W !  D  Q:RC
 . ;--- Display current values
 . S NR=NFL\2
 . F IROW=1:1:NR  W !  D
 . . F ICOL=1,2   D
 . . . S IFLD=NR*(ICOL-1)+IROW,X=(ICOL-1)*40
 . . . S TMP=$P($T(INPUT+IFLD),";;",2),NAME=$TR($P(TMP,U)," ")
 . . . W ?(X+2),"["_$J(IFLD,2)_"] "_$P(TMP,U,4)
 . . . W ?(X+35),$G(ONCINP(NAME))
 . ;
 . ;--- Ask for field(s) to be edited
 . K DIR
 . S DIR(0)="LO^1:"_NFL_":0"
 . S DIR("A")="Select a field"
 . S DIR("?")="Enter field number(s), '^' to exit, or hit RETURN to call the CS API."
 . W !  D ^DIR
 . I $D(DTOUT)  S RC=-2  Q
 . I $D(DUOUT)  S RC=-1  Q
 . I '$G(Y)  S RC=1  Q
 . S FLDLST=Y
 . ;
 . F IIF=1:1  S IFLD=$P(FLDLST,",",IIF)  Q:IFLD'>0  D  Q:RC<0
 . . ;--- Edit the field value
 . . S TMP=$P($T(INPUT+IFLD),";;",2)
 . . S NAME=$TR($P(TMP,U)," "),ML=+$TR($P(TMP,U,3)," ")
 . . S TABLE=+$TR($P(TMP,U,5)," ")
 . . K DIR
 . . S DIR(0)="FO^1:"_ML
 . . S:TABLE>0 $P(DIR(0),U,3)="D INPUT^ONCSAPI1("_TABLE_","_ML_",,$G(ONCINP(""SITE"")),$G(ONCINP(""HIST"")))"
 . . S DIR("A")=$P(TMP,U,4)
 . . S DIR("B")=$G(ONCINP(NAME))
 . . S X=$S(ML>1:ML_" characters",1:"1 character")
 . . S DIR("?")="Enter the field value ("_X_")"
 . . S:TABLE>0 DIR("??")="^D HELP^ONCSAPI1("_TABLE_",,$G(ONCINP(""SITE"")),$G(ONCINP(""HIST"")))"
 . . W !
 . . S TMP=$$TBLTTL^ONCSAPIT(,$G(ONCINP("SITE")),$G(ONCINP("HIST")),TABLE)
 . . I TMP'<0  D:$P(TMP,U,3)'="" WW^ONCSAPIU($P(TMP,U,3),75)
 . . D ^DIR
 . . I $D(DTOUT)  S RC=-2  Q
 . . I $D(DUOUT)  S RC=-1  Q
 . . S ONCINP(NAME)=Y
 . S:(RC=-1)!(RC=-2) RC=0
 ;---
 Q $S(RC<0:RC,1:0)
