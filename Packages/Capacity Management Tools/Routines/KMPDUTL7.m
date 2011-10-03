KMPDUTL7 ;OAK/RAK - CM Tools Utility ;2/17/04  10:52
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**2,5**;Mar 22, 2002
 ;
RSTART(KMPDIEN) ;-- start routine statistics
 ;-----------------------------------------------------------------------
 ; KMPDIEN.... Ien for file #8972.1 (CM CODE EVALUATOR).
 ;-----------------------------------------------------------------------
 Q:'$G(KMPDIEN)
 Q:'$D(^KMPD(8972.1,+KMPDIEN,0))#5
 ; quit if not 'active'
 Q:'$P($G(^KMPD(8972.1,+KMPDIEN,0)),U,11)
 K KMPDU(KMPDIEN)
 S KMPDU(KMPDIEN,"START")=$$STATS^%ZOSVKR
 Q
 ;
RSTOP(KMPDIEN) ;-- stop routine statistics
 ;-----------------------------------------------------------------------
 ; KMPDIEN.... Ien for file #8972.1 (CM CODE EVALUATOR).
 ;-----------------------------------------------------------------------
 Q:'$G(KMPDIEN)
 Q:'$D(^KMPD(8972.1,+KMPDIEN,0))#5
 ; quit if no 'start' subscript
 Q:'$D(KMPDU(KMPDIEN,"START"))
 ; quit if not 'active'
 Q:'$P($G(^KMPD(8972.1,+KMPDIEN,0)),U,11)
 ;
 N ARRAY,I,OVERHEAD,ZIEN
 ;
 S KMPDU(KMPDIEN,"STOP")=$$STATS^%ZOSVKR
 F I=1:1:6 D 
 .; check for negative numbers
 .S $P(KMPDU(KMPDIEN,"START"),U,I)=$$NUMBER($P(KMPDU(KMPDIEN,"START"),U,I))
 .S $P(KMPDU(KMPDIEN,"STOP"),U,I)=$$NUMBER($P(KMPDU(KMPDIEN,"STOP"),U,I))
 .; calculate difference
 .S $P(KMPDU(KMPDIEN,"DIFF"),U,I)=$P(KMPDU(KMPDIEN,"STOP"),U,I)-$P(KMPDU(KMPDIEN,"START"),U,I)
 .; check 'difference' for negative number
 .S $P(KMPDU(KMPDIEN,"DIFF"),U,I)=$$NUMBER($P(KMPDU(KMPDIEN,"DIFF"),U,I))
 ;
 ; get overhead data.
 S OVERHEAD=$$GETROVHD
 ; subtract overhead data from "DIFF".
 F I=1:1:6 D 
 .S $P(KMPDU(KMPDIEN,"DIFF"),U,I)=$P(KMPDU(KMPDIEN,"DIFF"),U,I)-$P(OVERHEAD,U,I)
 ;
 ; file results
 ; elements.
 F I=1:1:6 S ARRAY((I+3)*.01)=$P(KMPDU(KMPDIEN,"DIFF"),U,I)
 ; file data
 D EDIT^KMPDUTL8(KMPDIEN,"ARRAY")
 ;
 K KMPDU(KMPDIEN)
 ;
 Q
 ;
CONVERT(KMPDTEXT) ;-- extrinsic function - convert disallowed character(s)
 ;-----------------------------------------------------------------------
 ; KMPDTEXT.. Text to convert.
 ;             '^' will be converted to '~'
 ;-----------------------------------------------------------------------
 ;
 S KMPDTEXT=$TR(KMPDTEXT,"^","~")
 Q $E(KMPDTEXT,1,30)
 ;
GETROVHD() ;-- extrinsic - get routine overhead stats.
 ;-----------------------------------------------------------------------
 ; Return: overhead data in 9 up-arrow (^) pieces:
 ;         piece 1 - CPU Time
 ;         piece 2 - DIO References
 ;         piece 3 - BIO References
 ;         piece 4 - Page Faults
 ;         piece 5 - M Commands
 ;         piece 6 - GLO References
 ;         piece 7 - $H Day
 ;         piece 8 - $H Seconds
 ;         piece 9 - ASCII Date/Time
 ;-----------------------------------------------------------------------
 ;
 D:$G(^XTMP("KMPD","ROVHD"))="" ROVHD
 Q $G(^XTMP("KMPD","ROVHD"))
 ;
ROVHD ;-- calculate overhead for routine stats.
 ;
 ; This sub-routine determines the overhead for elements when running
 ; RSTART^KMPDUTL1 and RSTOP^KMPDUTL1.  The overhead numbers are stored
 ; in ^XTMP("KMPD","ROHD"), and are subtracted from the final numbers
 ; to get as true a picture as possible of the actual elements for the
 ; calling routine.
 ;
 N DIFF,I,START,STOP
 S DIFF=""
 S START=$$STATS^%ZOSVKR
 S STOP=$$STATS^%ZOSVKR
 F I=1:1:6 D 
 .S $P(DIFF,U,I)=$P(STOP,U,I)-$P(START,U,I)
 ; m commands.
 S $P(DIFF,U,5)=$P(DIFF,U,5)+8
 ; glo references.
 S $P(DIFF,U,6)=$P(DIFF,U,6)+2
 S ^XTMP("KMPD",0)=$$FMADD^XLFDT($$DT^XLFDT,300)
 S ^XTMP("KMPD","ROVHD")=DIFF
 ;
 Q
 ;
NUMBER(KMPDNUM) ;-- extrinsic function - check for negative numbers
 ;-----------------------------------------------------------------------
 ; KMPDNUM... Number to be checked
 ;
 ; Return: non-negative number
 ;
 ; Because certain data elements (such as m commands and global 
 ; references) can grow to such large numbers, these numbers must be
 ; checked.  If they have become negative (the register flips) they
 ; can be turned into positive numbers with
 ;-----------------------------------------------------------------------
 ;
 S KMPDNUM=$G(KMPDNUM)
 Q:KMPDNUM="" KMPDNUM
 Q:KMPDNUM'<0 KMPDNUM
 Q KMPDNUM+(2**32)
 ;
TRANSTO(KMPDIEN,KMPDAPP,KMPDRES) ;-- return 'transmit to' for data transmission
 ;-----------------------------------------------------------------------
 ; KMPDIEN.... Ien for file #8973 (CP PARAMETERS)
 ; KMPDAPP.... Application:
 ;              1 = sagg
 ;              2 = rum
 ;              3 = hl7
 ;              4 = timing
 ;              5 = vista monitor
 ; KMPDRES().. Results array in format:
 ;              KMPDRES(ExternalFormat)=IEN
 ;              KMPDRES(...           )=IEN
 ;-----------------------------------------------------------------------
 ;
 K KMPDRES
 Q:'$G(KMPDIEN)
 Q:'$D(^KMPD(8973,KMPDIEN,0))
 Q:'$G(KMPDAPP)
 Q:KMPDAPP<1!(KMPDAPP>5)
 ;
 N DATA,I,NODE
 ;
 S NODE=21+(KMPDAPP*.1),I=0
 F  S I=$O(^KMPD(8973,KMPDIEN,NODE,I)) Q:'I  D 
 .Q:'$D(^KMPD(8973,KMPDIEN,NODE,I,0))  S DATA=^(0)
 .S KMPDRES(DATA)=I
 ;
 Q
