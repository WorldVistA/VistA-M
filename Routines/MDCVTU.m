MDCVTU ; HOIFO/NCA - Medicine Conversion Verification Utility ; [08-28-2003 11:34]
 ;;1.0;CLINICAL PROCEDURES;**5**;Apr 01, 2004;Build 1
 ; Integration Agreement:
 ; IA #10155 Access 3rd piece of ^DD(filenumber,fieldnumber,0)
 ;
EN ; [Procedure] Verify the Medicine Records Are Converted
 N CNT,CNTS,MDC,MDK,MDL,MDTIT
 S MDTIT=";"_$P($G(^DD(703.92,.02,0)),U,3)
 D EN1 W !!!
 S MDK="" F  S MDK=$O(MDC(MDK)) Q:MDK=""  S MDX=$G(MDC(MDK)) D
 .I +MDX S MDL=$F(MDTIT,";"_MDK_":") W !,$P($E(MDTIT,MDL,999),";")_": ",?30,+MDX
 I '$D(MDC) W !,"Verified Medicine Reports Conversion Completed.",!
 W !,"Reports Converted ",?30,CNT
 W !,"Reports Skipped: ",?30,CNTS
 Q
EN1 ; Loop to Check Medicine Records
 N MDP,MDPTR,MDREC,MDS,MDX
 S MDREC=$NA(^MCAR(690,"AC")),(CNT,CNTS)=0
 F  S MDREC=$Q(@MDREC) Q:MDREC=""  Q:$QS(MDREC,2)'="AC"  D
 .S MDPTR=$QS(MDREC,6)_";"_$QS(MDREC,5)_","
 .S MDP=$O(^MDD(703.9,1,2,"B",MDPTR,0))
 .I 'MDP S MDS=$$STATUS^MDCVT(MDPTR) S:$G(MDC(MDS))="" MDC(MDS)=0 S MDC(MDS)=MDC(MDS)+1 Q
 .S MDS=$P(^MDD(703.9,1,2,MDP,0),U,2)
 .I MDS="CR" S CNT=CNT+1 Q
 .I MDS="S" S CNTS=CNTS+1 Q
 .S:$G(MDC(MDS))="" MDC(MDS)=0 S MDC(MDS)=MDC(MDS)+1
 .Q
 Q
