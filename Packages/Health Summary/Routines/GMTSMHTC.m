GMTSMHTC ;SLC/WAT - Driver for MH Treatment Coordinator component ;06/08/11  08:35
 ;;2.7;Health Summary;**99**;Oct 20, 1995;Build 45
 ;
 Q
 ;
EN ;start
 ;get MHTC for this DFN and display
 Q
PRINT ;show output
 D CKP^GMTSUP Q:$D(GMTSQIT)
 Q
