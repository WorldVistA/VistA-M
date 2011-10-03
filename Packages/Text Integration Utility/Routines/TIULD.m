TIULD ; SLC/JER - Admission related functions ; 1/13/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**7,21,148,156**;Jun 20, 1997
GETTIU(TIUY,TIUDA) ; Gets admission array for existing DCS
 N TIUMVN,TIUPTF,TIUVSTR,TIUDTYP,TIUD0,TIUD12,TIUD14
 S TIUD0=$G(^TIU(8925,+TIUDA,0)),TIUD12=$G(^(12)),TIUD14=$G(^(14))
 S TIUDTYP=+TIUD0,DFN=+$P(TIUD0,U,2),TIUMVN=$P(TIUD14,U)
 S TIUVSTR=$P(TIUD12,U,11)_";"_$P(TIUD0,U,7)_";"_$P(TIUD0,U,13)
 S TIUY("DOCTYP")=TIUDTYP_U_$$PNAME^TIULC1(TIUDTYP)
 I +$G(^TIU(8925,+TIUDA,13)) S TIUY("REFDT")=+$G(^(13))
 ; If the Patient Movement Pointer's broken, try to fix
 I +TIUMVN,'$D(^DGPM(+TIUMVN,0)),+$G(TIUVSTR) D FIXMOVE(.TIUY,DFN,TIUVSTR,TIUDA) Q:+$G(TIUY("AD#"))
 D PATVADPT^TIULV(.TIUY,DFN,TIUMVN,TIUVSTR)
 Q
FIXMOVE(TIUY,DFN,TIUVSTR,TIUDA) ; See if Admission has been reinstated, and fix
 N TIUEDT,TIULDT,TIULOC
 S TIUEDT=$P(TIUVSTR,";",2) Q:+TIUEDT'>0
 S TIULDT=$$FMADD^XLFDT(TIUEDT,1),TIULOC=+TIUVSTR
 Q:+TIULDT'>0!(+TIULOC'>0)
 D MAIN^TIUMOVE(.TIUY,DFN,"",TIUEDT,TIULDT,1,"LAST",0,+TIULOC)
 I +$G(TIU("AD#"))>0,$D(^DGPM(+$G(TIU("AD#")))) D
 . N DIE,DR,DA S DA=TIUDA,DR="1401////"_+$G(TIU("AD#")),DIE="^TIU(8925,"
 . D ^DIE
 Q
CHEKDS(X) ; Display/validate correct patient/treatment episode
 N DIR,Y,TIURC S Y=0
 I X("AD#")'>0!(X("EDT")="") D  G CHEKDSX
 . W !!,"Movement data doesn't exist for admission, can't create "
 . W "Summary",!
 I +$$ISA^USRLM(DUZ,"TRANSCRIPTIONIST")>0 S Y=1 G CHEKDSX
 W !!?1,"Patient: ",$$NAME^TIULS(X("PNM"),"LAST, FIRST MI"),?40,"SSN: "
 W X("SSN"),?62,"Sex: ",$S(X("SEX")]"":$P(X("SEX"),U,2),1:"UNKNOWN"),!
 W ?5,"Age: ",$S(X("AGE")]"":X("AGE"),1:"UNKNOWN"),?40,"Claim #: "
 W $S(X("CLAIM")]"":X("CLAIM"),1:"UNKNOWN"),!
 W "Adm Date: ",$$DATE^TIULS($P(X("EDT"),U),"MM/DD/YY"),?40,"Ward: "
 W $P(X("WARD"),U,2),!
 W:X("LDT")]"" "Dis Date: ",$$DATE^TIULS(X("LDT"),"MM/DD/YY"),!
 W ?2,"Adm Dx: ",X("ADDX")
 ; Below TIU*148
 I $G(X("NUMRACE"))>0 D
 . W !?4,"Race: " F TIURC=1:1:X("NUMRACE") W ?10,$P(X("RACE",TIURC),U,2),!
 I $G(X("RACENO"))=0 W !?4,"Race: ",$P($G(X("RACE")),U,2),!
 I $D(X("DICTDT")) D
 . W !,"A DISCHARGE SUMMARY is already on file:",!
 . W ?2,"Dict'd: ",X("DICTDT"),?41,"By: ",X("AUTHOR"),!
 . W ?2,"Signed: ",X("SIGDT"),?35,"Cosigned: ",X("COSDT"),!
 . S Y=1
 E  S Y=$$READ^TIUU("YO","Correct VISIT","YES")
 W !
CHEKDSX Q Y
CHEKPN(X,TIUBY) ; Display/validate demographic/visit information
 W !!,"Enter/Edit "
 W $S(+$G(TIUCLASS):$S(TIUCLASS=3:"PROGRESS NOTE",TIUCLASS=+$$CLASS^TIUCNSLT:"CONSULT RESULT",1:$$PNAME^TIULC1(+TIUCLASS)),1:"PROGRESS NOTE"),"..."
 W !?10,"Patient Location:  ",$S(+X("LOC"):$P(X("LOC"),U,2),1:"UNKNOWN")
 W !?$S(+$G(X("AD#")):4,1:8),"Date/time of "
 W $S(+$G(X("AD#")):"Admission:  ",1:"Visit:  ")
 W $S(+$P($G(X("VSTR")),";",2):$$DATE^TIULS($P(X("VSTR"),";",2),"MM/DD/YY HR:MIN"),1:"UNKNOWN")
 W !?9,"Date/time of Note:  "
 W $S(+$G(X("REFDT"))>0:$$DATE^TIULS(X("REFDT"),"MM/DD/YY HR:MIN"),1:"NOW")
 S:+$G(X("REFDT"))'>0 X("REFDT")=$$NOW^TIULC
 W !?12,"Author of Note:  "
 W $$PERSNAME^TIULC1($S($D(TIUAUTH):+TIUAUTH,1:DUZ))
 S Y=$$READ^TIUU("YO","   ...OK","YES")
 I $S($D(DIROUT):1,$D(DUOUT):1,$D(DTOUT):1,1:0) Q 0
 S TIUBY=+Y
 S:'+Y Y=$$READ^TIUU("YO","Correct VISIT","YES")
 I $S($D(DIROUT):1,$D(DUOUT):1,$D(DTOUT):1,1:0) Q 0
 I +Y'>0 D
 . K X N TIUINOUT
 . S TIUINOUT=$$INOUT^TIUVSIT
 . I $S($D(DIROUT):1,$D(DUOUT):1,$D(DTOUT):1,1:0) Q
 . I $P(TIUINOUT,U)="o" D MAIN^TIUVSIT(.X,DFN,"","","","",1)
 . I $P(TIUINOUT,U)'="o" D MAIN^TIUMOVE(.X,DFN,"","","",1,"LAST",1)
 . S Y=$S($D(X)>9:$$CHEKPN(.X,.TIUBY),1:0)
 Q Y
