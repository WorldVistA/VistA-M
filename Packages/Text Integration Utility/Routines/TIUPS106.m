TIUPS106 ;SLC/JER,MKB,ASMR/BL - post install for 106 ; 10/16/15 2:12pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**106**;Jun 20, 1997;Build 328
 ;Per VA Directive 6402, this routine should not be modified.
 ;
MAIN ;controls branching
 D NEWXREF
 Q
 ;
NEWXREF ;creates new index "AEVT" on Documents file #8925
 D DELIXN^DDMOD(8925,"AVPR","W")
 N TIUARR,TIURES
 S TIUARR("FILE")=8925
 S TIUARR("NAME")="AEVT"
 S TIUARR("TYPE")="MU"
 S TIUARR("USE")="A"
 S TIUARR("EXECUTION")="R"
 S TIUARR("ACTIVITY")="R"
 S TIUARR("SET CONDITION")="S X=(X2(12)'="""")" ;Patient defined
 S TIUARR("KILL CONDITION")="S X=(X2(1)="""")" ;Document type deleted
 S TIUARR("SET")="D DOC^TIUDDX"
 S TIUARR("KILL")="D DOC^TIUDDX"
 S TIUARR("SHORT DESCR")="Data Update Event"
 S TIUARR("DESCR",1)="This is an action index that broadcasts when any of the fields"
 S TIUARR("DESCR",2)="in this index are changed. No actual cross-reference nodes are"
 S TIUARR("DESCR",3)="set or killed."
 S TIUARR("VAL",1)=.01
 S TIUARR("VAL",2)=.05
 S TIUARR("VAL",3)=.06
 S TIUARR("VAL",4)=.07
 S TIUARR("VAL",5)=.08
 S TIUARR("VAL",6)=1202
 S TIUARR("VAL",7)=1205
 S TIUARR("VAL",8)=1301
 S TIUARR("VAL",9)=1405
 S TIUARR("VAL",10)=1701
 S TIUARR("VAL",11)=2101
 S TIUARR("VAL",12)=.02
 D CREIXN^DDMOD(.TIUARR,"kW",.TIURES)
 ; Compiled xrefs require Activity=R so set NoReIndex flag [DBIA 4754]
 S:$G(TIURES) ^DD("IX",+TIURES,"NOREINDEX")=1
 Q
