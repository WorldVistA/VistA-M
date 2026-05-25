TIUMOBJ2 ;XAN/AJB - MEDICATION OBJECT LIST MANAGER ;Aug 29, 2025@06:54:46
 ;;1.0;TEXT INTEGRATION UTILITIES;**372**;Jun 20, 1997;Build 5
 ;
 Q
GETDT(P) ; get TIUDATE value(s)
 Q:P="" "" N DELIM S DELIM=$S(P[",X=$$LIST":",",P[" X=$$LIST":" ")
 Q $TR($P($P(P,"TIUDATE=",2),DELIM),$C(34),"")
MEDFIX(HV0,HV1) ; med rec fix
 N X,Y F X=1:1 S Y=$P($T(MRF+X),";;",2) Q:Y="EOM"  W @Y,!
 Q
MEDREC(P) ; prompt for TIUDATE values for med rec object
 N HELP,MAX,PROMPT,RESPONSE,TIUDATE,X,Y
 F X=1:1 S Y=$P($T(MR+X),";;",2) Q:Y="EOM"  W Y,!
 S MAX=7300,TIUDATE("Default")=$$GETDT($G(P("Method")))
 S Y=$Y F X=1:1:4 D  Q:RESPONSE=U
 . I X=2!(X=4),'$P(TIUDATE,U,X-1) S $P(TIUDATE,U,X)="" Q
 . S PROMPT=$P($T(@($S(X=1:"OB",X=2:"OE",X=3:"IB",X=4:"IE"))),";",2)_" "
 . N I,J F I=1:1 S J=$P($T(@($S(X=1:"OB",X=2:"OE",X=3:"IB",X=4:"IE"))+I),";;",2) Q:J="EOM"  S HELP(I)=J
 . S HELP="Enter a number from 1-"_$S(X=1!(X=3):MAX,1:$P(TIUDATE,U,X-1))_". '^' to exit."
 . S HELP($O(HELP(""),-1)+1)="",HELP($O(HELP(""),-1)+1)="Enter @ to delete an existing value."
 . D IOXY^XGF(Y,0),CLEAR^XGF(Y,0,Y+($O(HELP(""),-1)+4),79),IOXY^XGF(Y-1,0)
 . S RESPONSE=$$FMR^TIUMOBJLM("NOA^1:"_$S(X=1!(X=3):MAX,1:$P(TIUDATE,U,X-1)),"31;"_PROMPT,$P(TIUDATE("Default"),U,X),"^D HELP^TIUMOBJLM(30,$Y,.HELP)") Q:RESPONSE=U
 . S $P(TIUDATE,U,X)=RESPONSE
 . F J=1:1:$O(HELP(""),-1) K HELP(J)
 Q:RESPONSE=U
 S P("TIUDATE")=$S(TIUDATE="^^^":"",1:TIUDATE)
 Q
README ;
 N TEXT,X,Y
 F X=1:1 S Y=$P($T(RM+X),";;",2) Q:Y="EOM"  S TEXT(X)=Y
 D BROWSE^DDBR("TEXT","NR","Medication/Reconciliation Objects")
 Q
TIUDATE(TIUDATE) ; display med rec start/end values
 W "Medication Reconciliation  TIUDATE Start/End",!,"=============================================",!
 I TIUDATE="" W "  N/A    TIUDATE will equal """" in method.",!! Q
 I +TIUDATE,($P(TIUDATE,U,3)=""!($P(TIUDATE,U,3)=+TIUDATE)),($P(TIUDATE,U,2)=$P(TIUDATE,U,4)) D  W !! Q
 . N X S X="End Date: "_$S($P(TIUDATE,U,2):"T-"_$P(TIUDATE,U,2),1:"TODAY") W $$SETSTR^TIUMOBJ1(X,"Start Date: T-"_+TIUDATE,(46-$L(X)),$L(X))
 N X W "Inpatient",?27,"Outpatient",!
 S X="Start Date: "_$S(TIUDATE:"T-"_+TIUDATE,1:"N/A  ") W $$SETSTR^TIUMOBJ1(X,"Start Date: T-"_$P(TIUDATE,U,3),28,$L(X)),!
 S X="End Date: "_$S($P(TIUDATE,U,2):"T-"_$P(TIUDATE,U,2),1:"TODAY") W $$SETSTR^TIUMOBJ1(X,"  End Date: "_$S($P(TIUDATE,U,4):"T-"_$P(TIUDATE,U,4),1:"TODAY"),30,$L(X))
 W !!
 Q
UPDTMR(P,REP) ; update a med rec object
 D MEDREC(.P) I '$D(P("TIUDATE")) D CLS^TIUMOBJLM Q
 N DELIM S DELIM=$S(P("Method")[",X=$$LIST":",",P("Method")[" X=$$LIST":" ")
 S P("TIUDATE")=$S(P("TIUDATE")=U:"""""",$L(P("TIUDATE"),U)=1&P("TIUDATE"):+P("TIUDATE"),1:""""_P("TIUDATE")_"""")
 S REP("TIUDATE="_$P($P(P("Method"),"TIUDATE=",2),DELIM))="TIUDATE="_P("TIUDATE")
 S REP(" K TIUDATE")=""
 D CLS^TIUMOBJLM
 Q
MRF ;Med Rec Objects Fix
 ;;" Med Rec Objects:  The variable TIUDATE is set in the method and now supports"
 ;;"                   separate starting/ending dates for inpatient & outpatient"
 ;;"                   medications.  See Readme.txt for additional information."
 ;;""
 ;;"                   DISCONTINUED medications are always excluded."
 ;;""
 ;;" Medication objects receive medication data from OUTPATIENT PHARMACY.  In some"
 ;;" circumstances, active outpatient or non-VA medications that precede the start"
 ;;" date may be inadvertently excluded."
 ;;""
 ;;" A new parameter, 'Med Rec/TIUDATE Fix', may be set to "_HV1_"EXCLUDE TIUDATE"_HV0_" as part"
 ;;" of a temporary fix.  Detailed information is included in Readme.txt."
 ;;""
 ;;" This option provides an automated process to update this new parameter for all"
 ;;" Med Rec objects to the desired value."
 ;;""
 ;;" Enter YES below to begin this process.  No changes will be made until the"
 ;;" parameter value is selected and confirmed."
 ;;EOM
MR ;
 ;;
 ;;                              Medication Reconciliation:
 ;;
 ;;                              Date Parameters   T-#
 ;;                              ================  ===
 ;;                              Outpatient Start  1-7300
 ;;                              Outpatient End    Based on start
 ;;                              Inpatient Start   1-7300
 ;;                              Inpatient End     Based on start
 ;;
 ;;EOM
IB ;Inpatient Start:
 ;;
 ;;Enter the desired # of days calculated from TODAY
 ;;to search for INPATIENT and Clinic medications.
 ;;EOM
IE ;Inpatient End:
 ;;
 ;;Enter the ending # of days calculated from TODAY
 ;;to finish the search.  This value must be equal
 ;;to or less than the Begin INPATIENT search value.
 ;;
 ;;Leaving this value empty defaults to TODAY.
 ;;EOM
OB ;Outpatient Start:
 ;;
 ;;Enter the desired # of days calculated from TODAY
 ;;to search for OUTPATIENT and Non-VA medications.
 ;;EOM
OE ;Outpatient End:
 ;;
 ;;Enter the ending # of days calculated from TODAY
 ;;to finish the search.  This value must be equal
 ;;to or less than the Begin OUTPATIENT search value.
 ;;
 ;;Leaving this value empty defaults to TODAY.
 ;;EOM
RM ;Medication Objects 101
 ;;
 ;; Important Information:  If the "Med Rec/TIUDATE Fix" parameter is set to
 ;;                         EXCLUDE the TIUDATE variable for a specific object,
 ;;                         none of the values set in TIUDATE will be used.
 ;;
 ;;                         The object will behave like a standard medication
 ;;                         object.  This specific parameter value may be updated
 ;;                         for all 'Med Rec' objects automatically to the desired
 ;;                         value via the 'Med Rec Object Auto Fix' action.
 ;;
 ;; A medication object is any TIU object that SETS the variable X by invoking
 ;; $$LIST from the TIULMED or TIUMOBJ routines in its method.
 ;;
 ;;   Ex:  S X=$$LIST^TIULMED(<parameters>) or $$LIST^TIUMOBJ(<parameters>)
 ;;
 ;; A 'Medication Reconciliation' object is a medication object that sets a
 ;; variable, TIUDATE, in its method.  If TIUDATE exists in the object's method,
 ;; even with no value(s), it is still considered a 'Med Rec' object.
 ;;
 ;;   Ex:  S TIUDATE=<value(s)>,X=$$LIST^TIULMED(<parameters>)
 ;;
 ;; These objects behave differently than standard objects in two ways:
 ;;
 ;;    - The default starting value(s) for inpatient and outpatient medications
 ;;      are replaced by the values in the TIUDATE variable.
 ;;
 ;;    - Medications with a status of "Discontinued" will always be excluded from
 ;;      the data.
 ;;
 ;; TIUDATE now supports separate starting/ending dates for inpatient & outpatient
 ;; medications.  This update is fully compatible with existing objects.  See the
 ;; precedence list below on how objects with only the outpatient values will
 ;; function.
 ;;
 ;; TIUDATE may be set as a single numeric value, a 4-piece delimited string with
 ;; one or more numeric values, or an empty string (TIUDATE="").
 ;;
 ;;   Ex:  S TIUDATE="365^^180^"
 ;;
 ;; Piece 1:  Outpatient Starting Date
 ;;      Piece 2:  Outpatient Ending Date
 ;;           Piece 3:   Inpatient Starting Date
 ;;                Piece 4:   Inpatient Ending Date
 ;;
 ;; The numeric values in TIUDATE represent the # of days calculated from TODAY
 ;; to search in the past for the desired medication type.
 ;;
 ;; Important note:  if TIUDATE does not contain any numeric values, it will
 ;; function exactly like a standard medication object.
 ;;
 ;; Since all of the TIUDATE values are optional, the precedence for how specific
 ;; date combinations will work are detailed below.
 ;;
 ;;     OUTPATIENT Start:  The T-<value> date will apply to both outpatient &
 ;;                        inpatient medications if no inpatient value is set.
 ;;                        Default is T-120 if not set.
 ;;
 ;;       OUTPATIENT End:  May only have a value if start date exists.  Default is
 ;;                        TODAY if not set.
 ;;
 ;;      INPATIENT Start:  Applies only to inpatient medications even if there is
 ;;                        no value set for outpatient medications. Default is
 ;;                        T-30 if not set.
 ;;
 ;;        INPATIENT End:  May only have a value if start date exists.  Default is
 ;;                        TODAY if not set.
 ;;
 ;; The default values stated above are implemented by OUTPATIENT PHARMACY.  TIU
 ;; will always send the value stored in the TIUDATE variable, even if it's blank.
 ;;
 ;; There must be either an OUTPATIENT or INPATIENT start date set to automatically
 ;; exclude DISCONTINUED medications.  Re:  Important note above.
 ;;
 ;; This object utility will not convert a standard object to a 'Med Rec' object.
 ;; A 'Med Rec' object will function exactly like a standard object if the TIUDATE
 ;; variable is empty.
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;; I would like to thank everyone involved in the testing and release of this
 ;; patch.  All of the new functionality included here was directly suggested by
 ;; or inspired from the wonderful people at the Fargo, Minneapolis, & Providence
 ;; VAMCs.  Their feedback was instrumental and all of the good ideas are theirs
 ;; and any defects in the software are mine.
 ;;
 ;; ajb 08/28/2025
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;EOM
 ;;
