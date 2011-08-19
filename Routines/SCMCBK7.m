SCMCBK7 ;bp/cmf - multiple patient assignments mail queue - RPCVersion = 1 ;;Aug 6, 1998
 ;;5.3;Scheduling;**148,177**;AUG 13, 1993
 Q
 ;
MAILLST(SCTM,SCFIELDA,SCDATE,SCNEWTM,SCOLDTM,SCBADTM,SCTOTCNT) ;
 ;       ;like MAILLIST^SCMCTMM(...
 ; Input:
 ;    SCTM     - Pointer to Team File (#404.51)
 ;    SCFIELDA - Field array with internal values
 ;    SCDATE   - Effective Date
 ;    SCNEWTM  - DFN array of newly assigned to team
 ;    SCOLDTM  - DFN array of previously assigned to team
 ;    SCBADTM  - DFN array of patients unassignable to team
 ;    SCTOTCNT - Count of DFN array passed to process
 ;
 N XMDUZ,XMY,XMSUB,XMTEXT,VA,VAERR,XMZ,Y,ZTQUEUED
 N SCTMNM,DFN,SCOK,SCPTNM,SCFLD,SCNODE,SCNDX,SCSPACE
 N SCE,SCB,SCDELTEM,SCJ,SCL,SCDETAIL
 ;
 D PREP1
 S SCTMNM=$P($G(^SCTM(404.51,+SCTM,0)),U,1)
 S XMSUB=$$S(4)_SCTMNM
 S XMTEXT="^TMP($J,""SCTMXM"","
 ;
 S SCTMNM=$P($G(^SCTM(404.51,+SCTM,0)),U,1)
 D SETLN($$S(5)_SCTMNM)
 D SETLN($$S(6)_$$FMTE^XLFDT(SCDATE))
 D SETLN($$S(7)_SCTOTCNT)
 D SETLN(" ")
 ;
 I $D(SCFIELDA) D
 .F SCNDX=1:1:14 S SCFLD=SCNDX*.01 IF $D(SCFIELDA(SCFLD)) D
 ..S $P(SCNODE,U,SCNDX)=SCFIELDA(SCFLD)
 ..D SETLN($$TEXT^SCMCTMM(404.42,SCNODE,SCNDX,SCSPACE,1))
 ;
 I SCTOTCNT=0 G MAIL
 ;
NEW I $S('$D(SCNEWTM):0,1:$O(@SCNEWTM@(0))) D BLDLST(1)
 ;
BAD I $S('$D(SCBADTM):0,1:$O(@SCBADTM@(0))) D BLDLST(2)
 ;
OLD I $S('$D(SCOLDTM):0,1:$O(@SCOLDTM@(0))) D BLDLST(3)
 ;
MAIL D SEND(8)
 ;
QTMULT K:$G(SCDELTEM) ^TMP("SCTM MAIL LST",$J,SCTM)
 K ^TMP($J,"SCTMXM")
 Q
 ;
PREP1 S ZTQUEUED=1
 S SCDELTEM=1 ;ok to delete tmp global
 S $P(SCSPACE," ",80)=""
 S SCLNCNT=0
 S SCOK=1
 Q
 ;
 ;
SETLN(TEXT) ;
 D SETLN^SCMCTMM(TEXT)
 Q
 ;
SEND(SCX) ;input SCX=points to string to use as sender
 ;
 S XMY(SCMAIL1)=""
 S XMDUZ=$$S(SCX)
 ;S XMDUZ=.5
 D ^XMD
 Q
 ;
BLDLST(SCL) ;create text by new/bad/old
 ;input SCL = for header line, ^tmp, $o
 N SCJ
 D SETLN(" ")
 D SETLN($$S(SCL))
 S SCJ="^TMP(""SCTM MAIL LST"","_$J_","_SCTM_","_SCL_")"
 S DFN=0
 F  S DFN=$$O(SCL) Q:'DFN  D DTLLST
 D SETLST(0)
 Q
 ;
DTLLST ;detail the list
 S SCPTNM=$P(^DPT(DFN,0),U,1)
 D PID^VADPT6
 S SCDETAIL="    "_SCPTNM_" ("_$G(VA("PID"))_")"
 I SCL=2 D RJD
 S @SCJ@(DFN)=SCDETAIL
 S @SCJ@("B",SCPTNM,DFN)=""
 Q
 ;
SETLST(SCX) ;set the list into message
 ;input: SCX: 0=team assignment, 1=position assignment
 S SCPTNM=""
 F  S SCPTNM=$O(@SCJ@("B",SCPTNM)) Q:SCPTNM']""  D
 .S DFN=0
 .F  S DFN=$O(@SCJ@("B",SCPTNM,DFN)) Q:'DFN  D
 ..S SCDETAIL=$G(@SCJ@(DFN))
 ..I SCX=0 D SETLN(SCDETAIL) Q
 ..D SETLN^SCMCTPM(SCDETAIL)
 ..Q
 .Q
 Q
 ;
RJD ;ReJect Detail
 ;
 N SCX
 I $D(SCBADTM) S SCX=$P(@SCBADTM@(DFN),U)
 E  S SCX=$P(@SCBADTP@(DFN),U)
 S SCDETAIL=SCDETAIL_" ["_SCX_"]"
 Q
 ;
O(SCL) ;returns next patient in array
 Q $S(SCL=1:$O(@SCNEWTM@(DFN)),SCL=2:$O(@SCBADTM@(DFN)),1:$O(@SCOLDTM@(DFN)))
 ;
S(SCL) ;returns line of text 
 Q $P($T(T+SCL),";;",2)
 ;
T ;;
1 ;;There has been a new team assignment for the following patients:
2 ;;There has been NO new team assignment for the following patients:
3 ;;The following patients were already assigned to the target team:
4 ;;Multiple PATIENT-TEAM ASSIGNMENT for ;;
5 ;;Team:                  ;;
6 ;;Effective Date:        ;;
7 ;;Processed:             ;;
8 ;;PCMM - Multiple Patient-Team Assignment
9 ;;PCMM - Multiple Patient-Position Assignment
