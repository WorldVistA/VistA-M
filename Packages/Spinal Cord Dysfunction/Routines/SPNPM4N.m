SPNPM4N ;SD/AB-PROGRAM MEASURE #4 NUMERATOR ;7/29/98
 ;;2.0;Spinal Cord Dysfunction;**6,7**;01/01/1997
MAIN ;-- Called from MAIN^SPNPM4
 ;-- This program will loop thru all SCD pts collected in the Denominator and count (for the Numerators Offered and Received) all Pts:
 ;-- who are SCD-CURRENTLY SERVED
 ;-- AND
 ;-- who have received or been offered an ANNUAL REHAB EVALUATION
 ;-- 1st loop thru ^SPNL(154,DFN) to get total of all SCD-R Pts
 D LOOPSCD
 D LOOPNUM
EXIT ;
 Q
LOOPSCD ;-- Loop thru ^SPNL(154,DFN) to count Total # SCD-R Pts
 S (SPN("DFN"),SPN("TOT_CNT"))=0
 F  S SPN("DFN")=$O(^SPNL(154,SPN("DFN"))) Q:'+SPN("DFN")  D
 .;-- Quit if no Zero node
 .Q:'$D(^SPNL(154,SPN("DFN"),0))
 .;-- Increment Total # SCD Pt counter (TOT_CNT)
 .S SPN("TOT_CNT")=SPN("TOT_CNT")+1
 .Q
 Q
LOOPNUM ;-- Loop thru Denominator global ^TMP($J,"SPNPM4","TOT_DENOM",DFN)
 S (SPN("DFN"),SPN("TOT_NUMO"),SPN("TOT_NUMR"),SPN("TOT_NUM"))=0
 ;-- Quit if '$D(^TMP($J,"SPNPM4","TOT_DENOM"))
 Q:'$D(^TMP($J,"SPNPM4","TOT_DENOM"))
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM4","TOT_DENOM",SPN("DFN"))) Q:'+SPN("DFN")  D
 .;-- Now check to see if Pt has received or been offered an Annual Rehab Eval
 .I $D(^SPNL(154,SPN("DFN"),"REHAB",0)) D CHKEVAL
 .;-- If ANNUAL REHAB EVAL flag (EVAL_FLGO) set to 1 then increment Numerator Offered counter (TOT_NUMO)
 .I +$G(SPN("EVAL_FLGO")) S SPN("TOT_NUMO")=SPN("TOT_NUMO")+1
 .;-- If ANNUAL REHAB EVAL flag (EVAL_FLGR) set to 1 then increment Numerator Received counter (TOT_NUMR)
 .I +$G(SPN("EVAL_FLGR")) S SPN("TOT_NUMR")=SPN("TOT_NUMR")+1
 .;-- If BOTH EVAL_FLGO and EVAL_FLGR set then increment Numeratoer Offered and Received counter (TOT_NUM)
 .I +$G(SPN("EVAL_FLGO"))&(+$G(SPN("EVAL_FLGR"))) S SPN("TOT_NUM")=SPN("TOT_NUM")+1
 .Q
 Q
CHKEVAL ;-- Check REHAB nodes to see if Pt Received or has been Offered an Annual Rehab Eval
 S (SPN("REHAB_NODE"),SPN("EVAL_FLGO"),SPN("EVAL_FLGR"))=0
 F  S SPN("REHAB_NODE")=$O(^SPNL(154,SPN("DFN"),"REHAB",SPN("REHAB_NODE"))) Q:'+SPN("REHAB_NODE")  D
 .;-- Set Annual Rehab Eval Offered Date variable (OFFRD_DT) and Annual Rehab Eval Received Date variable (RECVD_DT)
 .S SPN("OFFRD_DT")=+$P($G(^SPNL(154,SPN("DFN"),"REHAB",SPN("REHAB_NODE"),0)),U),SPN("RECVD_DT")=+$P($G(^SPNL(154,SPN("DFN"),"REHAB",SPN("REHAB_NODE"),0)),U,2)
 .;-- Look to see if any ANNUAL REAHB EVAL OFFERED dates exists w/in previous FY, if so set ANNUAL REHAB EVAL flag (EVAL_FLGO) to 1
 .I +SPN("OFFRD_DT")'<SPN("BEG_DT")&(SPN("OFFRD_DT")'>SPN("END_DT")) S SPN("EVAL_FLGO")=1
 .;-- Look to see if any ANNUAL REHAB RECEIVED dates exists w/in previous FY, if so set ANNUAL REHAB EVAL flag (EVAL_FLGR) to 1
 .I +SPN("RECVD_DT")'<SPN("BEG_DT")&(SPN("RECVD_DT")'>SPN("END_DT")) S SPN("EVAL_FLGR")=1
 .Q
 Q
