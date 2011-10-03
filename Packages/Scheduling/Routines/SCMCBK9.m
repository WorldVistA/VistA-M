SCMCBK9 ;bp/cmf - multiple patient assignments mail queue - RPCVersion = 1;;Aug 7, 1998
 ;;5.3;Scheduling;**148**;AUG 13, 1993
 Q
 ;
MAILLST(SCTP,SCFIELDA,SCDATE,SCNEWTP,SCOLDTP,SCBADTP,SCTOTCNT) ;
 ;      ;like MAILLIST^SCMCTPM(...
 ; Input:
 ;    SCTP     - Pointer to Team Position File (#404.57)
 ;    SCFIELDA - Field array with internal values
 ;    SCDATE   - Effective Date
 ;    SCNEWTP  - DFN array of newly assigned to position
 ;    SCOLDTP  - DFN array of previously assigned to position
 ;    SCBADTP  - DFN array of patients unassignable to position
 ;    SCTOTCNT - Count of DFN array passed to process
 ;
 N XMDUZ,XMY,XMSUB,XMTEXT,VA,VAERR,XMZ,Y,SCTPDT,ZTQUEUED
 N SCTPNM,DFN,SCOK,SCPTNM,SCFLD,SCNODE,SCNDX,SCSPACE
 N SCE,SCB,SCTMNM,SCDELTEM,SCDETAIL,SCJ,SCL
 ;
 D PREP1^SCMCBK7
 ;
 S SCTPNM=$P($G(^SCTM(404.57,+SCTP,0)),U,1)
 S XMSUB=$$S(4)_SCTPNM
 S XMTEXT="^TMP($J,""SCTPXM"","
 S SCTMNM=$P($G(^SCTM(404.51,+$P($G(^SCTM(404.57,+SCTP,0)),U,2),0)),U,1)
 ;
 D SETLN($$S(5)_SCTMNM)
 D SETLN($$S(6)_SCTPNM)
 D SETLN($$S(7)_$$FMTE^XLFDT(SCDATE))
 D SETLN($$S(8)_SCTOTCNT)
 D SETLN(" ")
 ;
 IF $D(SCFIELDA) D
 .F SCNDX=1:1:14 S SCFLD=SCNDX*.01 IF $D(SCFIELDA(SCFLD)) D
 ..S $P(SCNODE,U,SCNDX)=SCFIELDA(SCFLD)
 ..D SETLN($$TEXT^SCMCTPM(404.43,SCNODE,SCNDX,SCSPACE,1))
 ;
 I SCTOTCNT=0 G MAIL
 ;
NEW I $S('$D(SCNEWTP):0,1:$O(@SCNEWTP@(0))) D BLDLST(1)
 ;
BAD I $S('$D(SCBADTP):0,1:$O(@SCBADTP@(0))) D BLDLST(2)
 ;
OLD I $S('$D(SCOLDTP):0,1:$O(@SCOLDTP@(0))) D BLDLST(3)
 ;
MAIL D SEND^SCMCBK7(9)
 ;
QTMULT K:$G(SCDELTEM) ^TMP("SCTP MAIL LST",$J,SCTP)
 K ^TMP($J,"SCTPXM")
 Q
 ;
SETLN(TEXT) ;
 D SETLN^SCMCTPM(TEXT)
 Q
 ;
BLDLST(SCL)     ;create text by new/bad/old
 ;input SCL = for header line, ^tmp, $o
 N SCJ
 D SETLN(" ")
 D SETLN($$S(SCL))
 S SCJ="^TMP(""SCTP MAIL LST"","_$J_","_SCTP_","_SCL_")"
 S DFN=0
 F  S DFN=$$O(SCL) Q:'DFN  D DTLLST^SCMCBK7
 D SETLST^SCMCBK7(1)
 Q
 ;
O(SCL) ;returns next patient in array
 Q $S(SCL=1:$O(@SCNEWTP@(DFN)),SCL=2:$O(@SCBADTP@(DFN)),1:$O(@SCOLDTP@(DFN)))
 ;
S(SCL) ;return text string
 Q $P($T(T+SCL),";;",2)
 ;
T ;;
 ;;There has been a new position assignment for the following patients:
 ;;There has been NO new position assignment for the following patients:
 ;;The following patients were already assigned to the target position:
 ;;Multiple PATIENT-POSITION ASSIGNMENT for ;;
 ;;Team:                  ;;
 ;;Position:              ;;
 ;;Effective Date:        ;;
 ;;Processed:             ;;
 ;                          
