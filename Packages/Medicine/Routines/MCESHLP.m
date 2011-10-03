MCESHLP ;WISC/DCB-Release Control Help  ;3/9/93
 ;;2.3;Medicine;;09/13/1996
HELP ;
 N HOLD2,PY,ESCAPE,RTN,NEW
 S HOLD2=IOUON_MCROUT_IOUOFF,PY=0,ESCAPE=0
 I '$D(^MCAR(MCFILE,REC,"ES")),(PROV<3) S NEW=1,MCESNEW=1
 E  S NEW=0,MCESNEW=0
 D HELP2,HEADER^MCESEDT Q
HELP2 ;
 W @IOF
 I (PROV=1)!(PROV=2) D
 .W IORVON,IODWL,"DRAFT",IORVOFF
 .W !!,"Is used to enter procedure results into the database."
 .D COMMON
 .W !!,IORVON,IODWL,"PROBLEM DRAFT",IORVOFF
 .W !!,"Is used to flag procedure results when the results"
 .W !,"are questionable or missing."
 .D COMMON,PRTC
 Q:ESCAPE=1
 I MCESNEW=0 D
 .W !,IORVON,IODWL,"RELEASED ON-LINE VERIFY",IORVOFF
 .W !!,"Is used by a ",HOLD2," key holder to review"
 .W !,"and sign the information on the screen by entering"
 .W !,"the electronic signiture code."
 .D OTHER S PY=PY+10 D CHECK
 Q:ESCAPE=1
 I (NEW)!(PROV=4)!(PROV=5) D
 .W !,IORVON,IODWL,"RELEASED OFF-LINE VERIFY",IORVOFF
 .W !!,"If the primary provider reviews the information and signed"
 .W !,"a paper copy of the report, a clerk holding the ",HOLD2
 .W !,"key may sign the report for the primary provider."
 .D OTHER S PY=PY+11 D CHECK
 Q:ESCAPE=1
 I (RNV=1),(NEW)!(PROV=5) D
 .W !,IORVON,IODWL,"RELEASED NOT VERIFY",IORVOFF
 .W !!,"Is used for when the authorized user who holds the"
 .W !,HOLD2," key, releases the information"
 .W !,"without checking the results."
 .W !!,"This option should be used with ",IOUON,"extreme caution",IOUOFF," since"
 .W !,"the information may not be ",IOBON,"accurate",IOBOFF," or ",IOUON,"complete",IOUOFF,"."
 .W !!,IOBON,"==>",IOBOFF," You can be held liable for releasing unverified reports. ",IOBON,"<==",IOBOFF
 .D OTHER S PY=PY+13 D CHECK
 Q:ESCAPE=1
 I PROV>2 D
 .W !,IORVON,IODWL,"SUPERSED",IORVOFF
 .W !!,"Is used when the procedure results are released."
 .W !,"This will copy the procedure to a new record and will allow you to make"
 .W !,"changes to the copy of the procedure.",!!!
 .D PRTC
 Q:ESCAPE=1
 W !,IOUON,"Electronic Signature",IOUOFF," is the unique set of key strokes entered"
 W !,"by a user of an information system in order to document approval"
 W !,"or concurrence."
 W !!,IOUON,"RELEASE CONTROL",IOUOFF," allows you to enter, research, and review"
 W !,"a set of results prior to making them available to other users."
 W !!,IOUON,"Edit/Deletion Control",IOUOFF," allows the user to control the"
 W !,"permanence of information entered into the information system."
 W !!,IOUON,"SUPERSEDED",IOUOFF," refers to the process of replacing a record with another"
 W !,"record by copying it.",!!!!
 D PRTC Q
OTHER ;
 W !!,"Once signed the record will become locked against edit or deletionand the"
 W !,"non-key holders will be able to view the data.",! Q
COMMON ;
 W !!,"Only ",HOLD2," Key holders can see or make"
 W !,"changes to the information.",! Q
CHECK ;
 I PY>(24-12) S PY=0 D PRTC
 Q
PRTC ;
 R !,"Press RETURN to continue or '^' to exit",RET:DTIME
 I '$T!(RET="^") S ESCAPE=1
 W @IOF Q
