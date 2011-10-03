TIUCHLP ; SLC/SBW - Help for Clinician ;11/29/02
 ;;1.0;TEXT INTEGRATION UTILITIES;**3,21,109,148,156**;Jun 20, 1997
MAIN ; Control branching
 N DIC,X,Y,TIUI,TIUROOT,TIUFPRIV S TIUFPRIV=1
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 S DIC=8925.1,DIC(0)="AEMQZ",DIC("A")="Select DOCUMENT TYPE: "
 S DIC("B")=$G(^DISV(+DUZ,"^TIU(8925.1,"))
 D ^DIC I +Y'>0 D
 . W !!,"Required information for dictation help not set up for this report type."
 I +Y>0 D
 . I $P(TIUPRM0,U,16)="D" S TIUROOT="ITEM"
 . E  I $P(TIUPRM0,U,16)="C" S TIUROOT="HEAD"
 . I $G(TIUROOT)']"" W !!,"Required information for dictation help not set up for this report type." Q
 . W !!,"A Dictated ",$P(Y(0),U),", requires the following:"
 . S TIUI=0
 . F  S TIUI=$O(^TIU(8925.1,+Y,TIUROOT,TIUI)) Q:+TIUI'>0  D
 . . I +$P($G(^TIU(8925.1,+Y,TIUROOT,TIUI,0)),U,6) W !?10,$P($G(^(0)),U,2)
 W !!
 I $$READ^TIUU("YO","Do you want to get patient data","YES") D GETPAT
 Q
GETPAT ; Gets Dictation data for a specific patient
 N TIU,TIUOUT,DFN,SUCCESS,TITLE
 F  D  Q:$D(DUOUT)!$D(DIROUT)!+$G(TIUOUT)
 . S DFN=+$$PATIENT^TIULA
 . D MAIN^TIUMOVE(.TIU,DFN)
 . I $D(TIU) D PATDATA(.TIU)
 . S TIUOUT=$$READ^TIUU("Y","... OK","YES")
 D MAKE^TIUPEFIX(.SUCCESS,DFN,.TITLE,.TIU,$S(+$G(XQADATA):+$G(XQADATA),+$G(BUFDA):+$G(BUFDA),1:""))
 I +SUCCESS S TIUDONE=1
 Q
PATDATA(X) ; Display/validate correct patient/treatment episode
 N DIR,Y,TIURC
 W !!?1,"Patient: ",$$NAME^TIULS(X("PNM"),"LAST, FIRST MI"),?40,"SSN: ",X("SSN"),?62,"Sex: ",$P(X("SEX"),U,2),!
 W ?4,"Ward: ",$P(X("WARD"),U,2),?40,"Age: ",X("AGE"),!
 W "Att Phys: ",$P(X("AMD"),U,2),?34,"Prim Phys: ",$P(X("PMD"),U,2),!
 W "Adm Date: ",$$DATE^TIULS(+X("EDT"),"MM/DD/YY@HR:MIN:SEC")
 W:X("LDT")]"" ?35,"Dis Date: ",$$DATE^TIULS(X("LDT"),"MM/DD/YY")
 W !
 W ?2,"Adm Dx: ",X("ADDX")
 ; Below TIU*148
 I $G(X("NUMRACE"))>0 D
 . W !?4,"Race: " F TIURC=1:1:X("NUMRACE") W ?10,$P(X("RACE",TIURC),U,2),!
 I $G(X("RACENO"))=0 W !?4,"Race: ",$P($G(X("RACE")),U,2),!
 I $D(X("DICTDT")) D
 . W !,"A DISCHARGE SUMMARY is already on file:",!
 . W ?2,"Dict'd: ",X("DICTDT"),?41,"By: ",X("AUTHOR"),!
 . W ?2,"Signed: ",X("SIGDT"),?35,"Cosigned: ",X("COSDT"),!
 Q
GETPN ; Help get Fields for PN Dictation/Error Resolution
 N TIU,DFN,TIUY,TITLE
 S DFN=+$$PATIENT^TIULA Q:+DFN'>0
 D ENPN^TIUVSIT(.TIU,+DFN,1)
 I '$D(TIU) Q
 S TIUY=$$CHEKPN(.TIU)
 D MAKE^TIUPEFIX(.SUCCESS,DFN,.TITLE,.TIU,$S(+$G(XQADATA):+$G(XQADATA),+$G(BUFDA):+$G(BUFDA),1:""))
 I +SUCCESS S TIUDONE=1
 Q
CHEKPN(X,TIUBY) ; Display/validate demographic/visit information
 W !!,"Document Identifiers..."
 W !?14,"Patient Name:  ",$S($G(X("PNM"))]"":$G(X("PNM")),1:"UNKNOWN")
 W !?15,"Patient SSN:  ",$S($G(X("SSN"))]"":$G(X("SSN")),1:"UNKNOWN")
 W !?10,"Patient Location:  ",$S(+$G(X("LOC")):$P($G(X("LOC")),U,2),1:"UNKNOWN")
 W !?8,"Date/time of Visit:  ",$S($L($G(X("VSTR"))):$$DATE^TIULS($P(X("VSTR"),";",2),"MM/DD/YY HR:MIN"),1:"UNKNOWN")
 S Y=$$READ^TIUU("YO","   ...OK","YES")
 I $S($D(DIROUT):1,$D(DUOUT):1,$D(DTOUT):1,1:0) Q 0
 I +Y'>0 D
 . K X N TIUINOUT
 . S TIUINOUT=$$INOUT^TIUVSIT
 . I $S($D(DIROUT):1,$D(DUOUT):1,$D(DTOUT):1,1:0) Q
 . I $P(TIUINOUT,U)="o" D MAIN^TIUVSIT(.X,DFN,"","","","",1,"",20,1)
 . I $P(TIUINOUT,U)'="o" D MAIN^TIUMOVE(.X,DFN,"","","",1,"LAST",1)
 . S Y=$S($D(X)>9:$$CHEKPN(.X,.TIUBY),1:0)
 Q Y
