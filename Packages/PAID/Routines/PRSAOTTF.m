PRSAOTTF ;WCIOFO/JAH-OVERTIME WARNINGS FILER--8/18/98
 ;;4.0;PAID;**43**;Sep 21, 1995
 ; = = = = = = = = = = = = = = = = = 
 ;
FILEOTW(PPI,DFN,WK,O8,OA) ;Add an overtime warning (OTW) to 458.6
 ; Input:  PPI--pay period (pp) ien from 458
 ;         DFN--employee ien in 450 who has more calc ot than approved
 ;         WK--week 1 or 2 of pp
 ;         O8--overtime (OT) in 8b string
 ;         OA--ot in requests file w/ approved status
 ;         (O8 and OA are totals for the range covered by PPI and WK)
 ;
 N IEN,DA,X,DIC,DLAYGO
 Q:(PPI'>0)!(DFN'>0)!(WK<1)!(WK>2)!(O8<0)!(O8>99)!(OA<0)!(OA>99)
 ;
 ;Overwrite existing warning.
 ;
 S IEN=$$WRNEXIST(PPI,DFN,WK)
 I IEN D
 .  S DIE="^PRST(458.6,",DA=IEN,DR="7///^S X=O8;8///^S X=OA"
 .  L +^PRST(458.6,IEN):5 D ^DIE L -^PRST(458.6,IEN)
 Q:IEN
 ;
 ;For new warnings, use next available entry.
 ;Lock header node so that 2 supervisors approving records
 ;with warnings will not get the same ien to use for the warning.
 ;
 L +^PRST(458.6,0):10 I $T S IEN=$$NEXTWRN()
 Q:'IEN
 ;
 ; unlock header and quit if can't lock record
 L +^PRST(458.6,IEN):0
 I '$T L -^PRST(458.6,0) Q
 ;
 S DIC="^PRST(458.6,",DIC(0)="L",DLAYGO=458.6,(DA,X)=IEN
 S DIC("DR")="1///^S X=DFN;2///^S X=PPI;3///^S X=WK;7///^S X=O8;8///^S X=OA"
 K DD,DO D FILE^DICN
 L -^PRST(458.6,IEN)
 L -^PRST(458.6,0)
 Q
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
WRNEXIST(PPI,DFN,WK) ;
 ;return ien from 458.6 if OTW exists 4 this employ, PP and week 
 ;otherwise return false.
 ;
 N REC,TMPIEN,IEN
 S U="^"
 S (TMPIEN,IEN)=0
 F  S TMPIEN=$O(^PRST(458.6,"C",PPI,TMPIEN)) Q:TMPIEN'>0!(IEN)  D
 .  S REC=$G(^PRST(458.6,TMPIEN,0))
 .  I $P(REC,U,2)=DFN,$P(REC,U,4)=WK S IEN=TMPIEN
 Q IEN
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
NEXTWRN() ;
 ;find last entry in file and increment. if no entries start at 1.
 N IEN S IEN=+$P(^PRST(458.6,0),"^",3)+1
 ;
 ;ensure entry is valid. if not loop increments and checks until an
 ;available spot is found.
 F  Q:'$D(^PRST(458.6,IEN,0))  S IEN=IEN+1
 Q IEN
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
STATCHNG(IEN,STAT) ;OTW STATUS CHANGE BOOLEAN FUNCTION
 ; WARNING:  called from Mumps x-ref (AC) on STATUS field in 458.6
 ; Extrinsic function checks if status currently being set is different
 ; from existing status.
 ; INPUT:   IEN - record # in OTW file.
 ;          STAT - value that the STATUS field is being set to.  (i.e
 ;                 X is defined in the calling x-ref. code.)
 ; OUTPUT:  returns true if new and existing STATUS is different, false
 ;          otherwise.
 ;
 N ACT,CLR,OLDSTAT
 S (RET,ACT,CLR)=0
 ;ensure we have a record # and a new status of active or cleared.
 Q:$G(IEN)'>0!(($G(STAT)'="A")&($G(STAT)'="C")) RET
 ;
 ; look at "E" x-ref of status field to determine if the OT warning is
 ; active or inactive.
 ;
 S ACT=$D(^PRST(458.6,"E","A",IEN))
 S CLR=$D(^PRST(458.6,"E","C",IEN))
 S OLDSTAT=$S(ACT:"A",CLR:"C",1:"")
 S RET=$S(OLDSTAT'=STAT:1,1:0)
 ;
 Q RET
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
CLRXREF(IEN) ;
 ; set LAST UPDATED BY field in file 458.6 when the status field is
 ; changed.  Use global set since this function is being called from 
 ; X-ref and potentially via DIE call in CLEAR^PRSAOTTF.
 ;
 ; ensure current users DUZ is defined and we have an OT warning.
 Q:($G(DUZ)'>0)!('$D(^PRST(458.6,$G(IEN),0)))
 ;
 S $P(^PRST(458.6,IEN,0),"^",6)=DUZ
 ;
 Q
 ;
 ; = = = = = = = = = = = = = = = = = 
 ;
EXIT ; -- exit code
 D CLEAR^VALM1 K ^TMP("PRSOTW",$J),^TMP("PRSOTR",$J)
 K PRSIEN,PRSOUT,PRSWPP,PRSWPPI,PRSWSTAT,PRSWSTAT
 K PRSRREC,PRSRPPI,PRSRPPE,PRSREMP,PRSRWK,PRSRNM
 K PRSCREC
 Q
