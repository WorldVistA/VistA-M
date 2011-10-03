YSD40031 ;DALISC/LJA/MJD - Repoint MR data continued... ;12/09/93 16:45 [ 04/08/94  11:59 AM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
REP ;  Repoint MR data  (Called from ^YSD40030)
 ;
 ;  Key Variables...
 ;  YSD4IEN -- req  --> YSD4CFLG   Conversion flag
 ;  (^MR ien)       --> YSD4FND    Number of Modifiers found
 ;                  --> YSD4CONV   Number of Modifiers converted
 ;
 S (YSD4CFLG,YSD4FND,YSD4CONV)=0
 ;
 ;  DX node.  (Field# 103 - DSM-III DIAGNOSIS)
 S YSD4MIEN=0
 F  S YSD4MIEN=$O(^MR(+YSD4IEN,"DX",YSD4MIEN)) QUIT:YSD4MIEN'>0  D
 .  I '$D(^MR(+YSD4IEN,"DX",+YSD4MIEN,0)) D  QUIT
 .  .  D NOW^%DTC
 .  .  D PED^YSD4E010(%,"Invalid data structure",90,"DX",+YSD4IEN,+YSD4MIEN,+YSD4DIEN)
 .
 .  S YSD4DIEN=+$G(^MR(+YSD4IEN,"DX",+YSD4MIEN,0)) QUIT:YSD4DIEN'>0  D DX
 ;
 ;
 ;  DX1 node.  (Field#'s 102 - PRIN DSM-III DIAG, 102.6 - X DXM-III DIAG)
 S YSD4DX1=$G(^MR(+YSD4IEN,"DX1"))
 I $P(YSD4DX1,U,2)>0!($P(YSD4DX1,U,4)>0) D DX1
 ;
 ;
 ;  PDX node.  (Field# 99.06PA:.01 - PAST PRINCIPAL DX)
 S YSD4MIEN=0
 F  S YSD4MIEN=$O(^MR(+YSD4IEN,"PDX",YSD4MIEN)) QUIT:YSD4MIEN'>0  D
 .  I '$D(^MR(+YSD4IEN,"PDX",+YSD4MIEN,0)) D  QUIT
 .  .  D NOW^%DTC
 .  .  D PED^YSD4E010(%,"Invalid data structure",90,"PDX",+YSD4IEN,+YSD4MIEN,+YSD4DIEN)
 .
 .  S YSD4DIEN=+$G(^MR(+YSD4IEN,"PDX",+YSD4MIEN,0)) QUIT:YSD4DIEN'>0  D PDX
 ;
 ;
 ;  XDX node.  (Field# 90.07PA:.01 - PAST X DIAGNOSIS)
 S YSD4MIEN=0
 F  S YSD4MIEN=$O(^MR(+YSD4IEN,"XDX",YSD4MIEN)) QUIT:YSD4MIEN'>0  D
 .  I '$D(^MR(+YSD4IEN,"XDX",+YSD4MIEN,0)) D  QUIT
 .  .  D NOW^%DTC
 .  .  D PED^YSD4E010(%,"Invalid data structure",90,"XDX",+YSD4IEN,+YSD4MIEN,+YSD4DIEN)
 .  S YSD4DIEN=+$G(^MR(+YSD4IEN,"XDX",+YSD4MIEN,0)) QUIT:YSD4DIEN'>0  D XDX
 ;
 ;
 ; If YSD4FND>0 and YSD4CONV=0   NO DSM qualifiers match
 ;    Change status to ERROR 
 ;    return control to (REPOINT^YSD40030)
 ;
 I YSD4FND>0&(YSD4CONV=0) D  QUIT  ;->
 .  S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="E"
 ;
 ;  Change Status to CONVERTED
 S $P(^YSD(627.99,+YSD4CIEN,0),U,2)="C",YSD4CFLG=1
 QUIT
 ;
DX ;
 ;  YSD4DIEN,YSD4IEN,YSD4MIEN -- req
 ;  YSD4NDN - New DSM file number
 ;
 S YSD4FND=YSD4FND+1
 ;
 ;  Get DSM pointer for DSM3 entry
 S YSD4NDN=$$NDN(+YSD4DIEN)
 ;
 ;  Quit if not found...
 I 'YSD4NDN D  QUIT  ;->
 .  D NOW^%DTC
 .  D PED^YSD4E010(%,"New DSM # not found",90,"DX",+YSD4IEN,+YSD4MIEN,+YSD4DIEN)
 ;
 ;  Record value in Conversion file
 S ^YSD(627.99,+YSD4CIEN,"DX",+YSD4MIEN,0)=+YSD4DIEN
 ;
 ;  Convert now...
 K ^MR(+YSD4IEN,"DX","B",YSD4DIEN,+YSD4MIEN)
 S ^MR(+YSD4IEN,"DX","B",YSD4NDN,+YSD4MIEN)=""
 S $P(^MR(+YSD4IEN,"DX",+YSD4MIEN,0),U)=+YSD4NDN
 S YSD4CONV=YSD4CONV+1
 QUIT
 ;
DX1 ;
 ;  YSD4DX1,YSD4IEN -- req
 ;
 N YSD4HDX1
 S YSD4HDX1=YSD4DX1,(YSD4DX1F,YSD4DX1C)=0
 ;
 F YSD4P=2,4 S YSD4DIEN=$P(YSD4DX1,U,+YSD4P) I YSD4DIEN>0 D
 .  S YSD4FND=YSD4FND+1,YSD4DX1F=YSD4DX1F+1
 .  S YSD4NDN=$$NDN(+YSD4DIEN)
 .  I YSD4NDN'>0 D  QUIT  ;->
 .  .  D NOW^%DTC
 .  .  D PED^YSD4E010(%,"New DSM # not found on piece "_YSD4P_" of this node",90,"DX1",+YSD4IEN,"",+YSD4DIEN)
 .
 .  S $P(YSD4DX1,U,+YSD4P)=YSD4NDN
 .  S YSD4CONV=YSD4CONV+1,YSD4DX1C=YSD4DX1C+1
 ;
 ;  If DX1 node is found and no qualifier exist QUIT
 ;
 QUIT:YSD4DX1F>0&(YSD4DX1C=0)  ;->
 ;
 ;  Record Conversion file data...
 ;  2nd & 4th pieces repointed... Now, store changes...
 ;
 S ^YSD(627.99,+YSD4CIEN,"DX1")=YSD4HDX1,^MR(+YSD4IEN,"DX1")=YSD4DX1
 ;
 QUIT
 ;
PDX ;
 S YSD4FND=YSD4FND+1
 ;
 ;  YSD4DIEN,YSD4IEN,YSD4MIEN -- req
 ;  YSD4NDN - New DSM file number
 ;
 S YSD4NDN=$$NDN(+YSD4DIEN)
 ;
 ;  New DSM # found?
 I 'YSD4NDN D  QUIT  ;->
 .  D NOW^%DTC
 .  D PED^YSD4E010(%,"New DSM # not found",90,"PDX",+YSD4IEN,+YSD4MIEN,+YSD4DIEN)
 ;
 ;  Record value in Conversion file
 ;  Set ^MR node...
 ;
 S ^YSD(627.99,+YSD4CIEN,"PDX",+YSD4MIEN,0)=+YSD4DIEN,$P(^MR(+YSD4IEN,"PDX",+YSD4MIEN,0),U)=+YSD4NDN
 ;
 ;  Note!  No B xref exists on this field
 ;
 S YSD4CONV=YSD4CONV+1
 QUIT
 ;
XDX ;
 S YSD4FND=YSD4FND+1
 ;
 ;  YSD4DIEN,YSD4IEN,YSD4MIEN -- req
 ;  YSD4NDN - New DSM file number
 ;
 S YSD4NDN=$$NDN(+YSD4DIEN)
 ;
 I 'YSD4NDN D  QUIT  ;->
 .  D NOW^%DTC
 .  D PED^YSD4E010(%,"New DSM # not found",90,"XDX",+YSD4IEN,+YSD4MIEN,+YSD4DIEN)
 ;
 ;  Record value in Conversion file
 ;  Set ^MR node...
 ;
 S ^YSD(627.99,+YSD4CIEN,"XDX",+YSD4MIEN,0)=+YSD4DIEN,$P(^MR(+YSD4IEN,"XDX",+YSD4MIEN,0),U)=+YSD4NDN
 ;
 ;  Note!  No B xref exists on this field
 ;
 S YSD4CONV=YSD4CONV+1
 QUIT
 ;
NDN(ONO) QUIT +$P($G(^DIC(627,+$G(ONO),0)),U,4)
 ;
EOR ;YSD40031 - Repoint MR data continued... ;12/9/93 10:03
