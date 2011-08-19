SPNPRI19 ;SD/CM/Pre init action for patch 19; 1/16/2003 14:23
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
EN ;
 S U="^"
 Q:$G(^DD(154.1,1003,0))'=""  ; early quit if patch 19 prev installed
 Q:'+$P($G(^SPNL(154.1,0)),U,4)  ; early quit if no outcomes on file
 S SPNCNT=0,SPNCT=0,SPNK=0,SPNXMT=0,SPNBTOT=$O(^SPNL(154.1," "),-1)
 G:$P($G(^SPNL(154.7,+$$SITE^VASITE,0)),U,5)'="" ENREI ; just re-index
 ; Delete obsolete "XMT" nodes and convert Record Type data
 W !,"Please stand by while I remove an obsolete data node and update"
 W !,"the Record Type field in the Outcomes file (#154.1).",!!
 S SPNAIEN=SPNBTOT ; holds the cumulative last ien when adding records
 S SPNIEN=0 F  S SPNIEN=$O(^SPNL(154.1,SPNIEN)) Q:SPNIEN=SPNBTOT  D FIND,CHART,FAM,DIENER,DUSOI,KILLS,RESASIA
 S SPNIEN=SPNBTOT D FIND,CHART,FAM,DIENER,DUSOI,KILLS,RESASIA
ENREI W !,"Please stand by while I re-index the Outcomes file (#154.1).",!!
 S SPNIEN=0 F  S SPNIEN=$O(^SPNL(154.1,SPNIEN)) Q:'+SPNIEN  D REIND
 S $P(^SPNL(154.1,0),U,3)=$O(^SPNL(154.1," "),-1)
 S $P(^SPNL(154.1,0),U,4)=SPNCT
 W !,"D o n e! ",SPNCNT," entries have been processed, resulting in"
 W !,SPNK," new entries created by the splitting of CHART/FAM/DIENER/DUSOI"
 W !,"into separate Record Types."
 W !,"Also, ",SPNXMT," obsolete XMT nodes were removed."
 G EXIT
FIND ;
 S SPNCNT=SPNCNT+1 I SPNCNT#40=0 W "."
 I SPNCNT#610=0 W "Working"
 I +$G(SPNIEN),$D(^SPNL(154.1,SPNIEN,"XMT")) K ^SPNL(154.1,SPNIEN,"XMT") S SPNXMT=SPNXMT+1
 ; begin converting record type number, starting with MS (4 to 8)
 S $P(^SPNL(154.7,+$$SITE^VASITE,0),U,5)=SPNIEN ; stores last ien processed
 I $P($G(^SPNL(154.1,SPNIEN,0)),U,2)=4 S $P(^SPNL(154.1,SPNIEN,0),U,2)=8
 ; now store ASIA temporarily as a 9
 I $P($G(^SPNL(154.1,SPNIEN,0)),U,2)=5 S $P(^SPNL(154.1,SPNIEN,0),U,2)=9
 Q
 ; create new entries for the various 'CHART' record types
CHART ;
 I $P($G(^SPNL(154.1,SPNIEN,0)),U,2)=3,$D(^SPNL(154.1,SPNIEN,"CHART")) D ADDCRT
 Q
FAM ;
 I $P($G(^SPNL(154.1,SPNIEN,0)),U,2)=3,$D(^SPNL(154.1,SPNIEN,"FAM")) D ADDFAM
 Q
DIENER ;
 I $P($G(^SPNL(154.1,SPNIEN,0)),U,2)=3,$D(^SPNL(154.1,SPNIEN,"SCORE")),+$P($G(^SPNL(154.1,SPNIEN,"SCORE")),U,1) D ADDDEN
 Q
DUSOI ;
 I $P($G(^SPNL(154.1,SPNIEN,0)),U,2)=3,$D(^SPNL(154.1,SPNIEN,"SCORE")),+$P($G(^SPNL(154.1,SPNIEN,"SCORE")),U,2) D ADDDUS
 Q
KILLS ; now kill the old data nodes belonging to CHART Record Type (no dups)
 I $P($G(^SPNL(154.1,SPNIEN,0)),U,2)=3,$D(^SPNL(154.1,SPNIEN,"CHART")) D KILLOLD
 I $P($G(^SPNL(154.1,SPNIEN,0)),U,2)=3,$D(^SPNL(154.1,SPNIEN,"FAM")) D KILLOLD
 I $P($G(^SPNL(154.1,SPNIEN,0)),U,2)=3,$D(^SPNL(154.1,SPNIEN,"SCORE")) D KILLOLD
 Q
RESASIA ; now restore ASIA from 9 to 3
 I $P($G(^SPNL(154.1,SPNIEN,0)),U,2)=9 S $P(^SPNL(154.1,SPNIEN,0),U,2)=3
 Q
ADDCRT ;
 S SPNK=SPNK+1,SPNAIEN=SPNAIEN+1
 S SPNMOV(0)=^SPNL(154.1,SPNIEN,0)
 S:$D(^SPNL(154.1,SPNIEN,2)) SPNMOV(2)=^SPNL(154.1,SPNIEN,2)
 S:$D(^SPNL(154.1,SPNIEN,8)) SPNMOV(8)=^SPNL(154.1,SPNIEN,8)
 S SPNMOV("CHART")=^SPNL(154.1,SPNIEN,"CHART")
 S %X="SPNMOV(",%Y="^SPNL(154.1,SPNAIEN," D %XY^%RCR
 S $P(^SPNL(154.1,SPNAIEN,0),U,2)=4
 K SPNMOV
 Q
ADDFAM ;
 S SPNK=SPNK+1,SPNAIEN=SPNAIEN+1
 S SPNMOV(0)=^SPNL(154.1,SPNIEN,0)
 S:$D(^SPNL(154.1,SPNIEN,2)) SPNMOV(2)=^SPNL(154.1,SPNIEN,2)
 S:$D(^SPNL(154.1,SPNIEN,8)) SPNMOV(8)=^SPNL(154.1,SPNIEN,8)
 S SPNMOV("FAM")=^SPNL(154.1,SPNIEN,"FAM")
 S %X="SPNMOV(",%Y="^SPNL(154.1,SPNAIEN," D %XY^%RCR
 S $P(^SPNL(154.1,SPNAIEN,0),U,2)=5
 K SPNMOV
 Q
ADDDEN ;
 S SPNK=SPNK+1,SPNAIEN=SPNAIEN+1
 S SPNMOV(0)=^SPNL(154.1,SPNIEN,0)
 S:$D(^SPNL(154.1,SPNIEN,2)) SPNMOV(2)=^SPNL(154.1,SPNIEN,2)
 S:$D(^SPNL(154.1,SPNIEN,8)) SPNMOV(8)=^SPNL(154.1,SPNIEN,8)
 S SPNMOV("SCORE")=^SPNL(154.1,SPNIEN,"SCORE")
 S %X="SPNMOV(",%Y="^SPNL(154.1,SPNAIEN," D %XY^%RCR
 S $P(^SPNL(154.1,SPNAIEN,0),U,2)=6
 S $P(^SPNL(154.1,SPNAIEN,"SCORE"),U,2)=""
 K SPNMOV
 Q
ADDDUS ;
 S SPNK=SPNK+1,SPNAIEN=SPNAIEN+1
 S SPNMOV(0)=^SPNL(154.1,SPNIEN,0)
 S:$D(^SPNL(154.1,SPNIEN,2)) SPNMOV(2)=^SPNL(154.1,SPNIEN,2)
 S:$D(^SPNL(154.1,SPNIEN,8)) SPNMOV(8)=^SPNL(154.1,SPNIEN,8)
 S SPNMOV("SCORE")=^SPNL(154.1,SPNIEN,"SCORE")
 S %X="SPNMOV(",%Y="^SPNL(154.1,SPNAIEN," D %XY^%RCR
 S $P(^SPNL(154.1,SPNAIEN,0),U,2)=7
 S $P(^SPNL(154.1,SPNAIEN,"SCORE"),U,1)=""
 K SPNMOV
 Q
REIND ; reindex entire file, all cross references, all entries
 S SPNCT=SPNCT+1
 S DIK="^SPNL(154.1,",DA=SPNIEN D IX^DIK
 Q
KILLOLD ;
 S DIK="^SPNL(154.1,",DA=SPNIEN D ^DIK
 Q
EXIT ;
 K DA,DIK
 K SPNIEN,SPNAIEN,SPNCNT,SPNCT,SPNK,SPNBTOT,SPNMOV,SPNXMT
 Q
