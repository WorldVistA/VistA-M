DIPR120 ;O-OIFO/SO-Move PRIORDATE, PRIORUSER, & PRIORVALUE To FM's #;10:20 AM  12 Dec 2002
 ;;22.0;VA FileMan;**120**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N COUNT,X,IEN,SADAT,SAVAL,SAUSER
 S X="Beginning Pre-Installation..." D MES^XPDUTL(X)
 S COUNT=0
 D RPDATE,RPUSER,RPVAL
 S X=" " D MES^XPDUTL(X)
 I '$D(SADAT) D APDATE
 I '$D(SAUSER) D APUSER
 I '$D(SAVAL) D APVAL
 D END
 Q
RPDATE ; Find & Remove PRIORDATE
 I $D(^DD("FUNC",91,0))#2,$P(^DD("FUNC",91,0),U)="PRIORDATE",'$D(^DD("FUNC",91,1)) S SADAT=1
 I '$D(SADAT),$D(^DD("FUNC",91,0))#2 D  S SADAT=1
 . N I S I=91 D ERRMES Q
 S IEN=99
 F  S IEN=$O(^DD("FUNC","B","PRIORDATE",IEN)) Q:'IEN  D
 . I ^DD("FUNC",IEN,9)'="When it has an argument (Fieldname), returns as a multiple all prior Date/Times of auditing, most recent first.  Without an argument, it is most recent audited Date/Time for the Entry" Q
 . S X="Deleting Function PRIORDATE" D MES^XPDUTL(X)
 . K ^DD("FUNC",IEN)
 . K ^DD("FUNC","B","PRIORDATE",IEN)
 . S COUNT=COUNT-1
 Q
 ;
RPUSER ; Find & Remove PRIORUSER
 I $D(^DD("FUNC",92,0))#2,$P(^DD("FUNC",92,0),U)="PRIORUSER",'$D(^DD("FUNC",92,1)) S SAUSER=1
 I '$D(SAUSER),$D(^DD("FUNC",92,0))#2 D  S SAUSER=1
 . N I S I=92 D ERRMES Q
 S IEN=99
 F  S IEN=$O(^DD("FUNC","B","PRIORUSER",IEN)) Q:'IEN  D
 . I ^DD("FUNC",IEN,9)'="When it has an argument (Fieldname), returns as a multiple all prior audited Users, most recent first.  Without an argument, it is most recent audited User for the Entry" Q
 . S X="Deleting Function PRIORUSER" D MES^XPDUTL(X)
 . K ^DD("FUNC",IEN)
 . K ^DD("FUNC","B","PRIORUSER",IEN)
 . S COUNT=COUNT-1
 Q
 ;
RPVAL ; Find & Remove PRIORVALUE
 I $D(^DD("FUNC",90,0))#2,$P(^DD("FUNC",90,0),U)="PRIORVALUE",'$D(^DD("FUNC",90,1)) S SAVAL=1
 I '$D(SAVAL),$D(^DD("FUNC",90,0))#2 D  S SAVAL=1
 . N I S I=90 D ERRMES Q
 S IEN=99
 F  S IEN=$O(^DD("FUNC","B","PRIORVALUE",IEN)) Q:'IEN  D
 . I ^DD("FUNC",IEN,9)'="Takes name of an Audited Field.  Returns as a multiple all prior values of the field, most recent first." Q
 . S X="Deleting Function PRIORVALUE" D MES^XPDUTL(X)
 . K ^DD("FUNC",IEN)
 . K ^DD("FUNC","B","PRIORVALUE",IEN)
 . S COUNT=COUNT-1
 Q
 ;
APDATE ; Add PRIORDATE at IEN 91
 S X="Installing Function PRIORDATE at #91" D MES^XPDUTL(X)
 S ^DD("FUNC",91,0)="PRIORDATE"
 S ^DD("FUNC",91,3)="VARIABLE"
 S ^DD("FUNC",91,9)="When it has an argument (Fieldname), returns as a multiple all prior Date/Times of auditing, most recent first.  Without an argument, it is most recent audited Date/Time for the Entry"
 S ^DD("FUNC","B","PRIORDATE",91)=""
 S COUNT=COUNT+1
 Q
 ;
APUSER ; Add PRIORUSER at IEN 92
 S X="Installing Function PRIORUSER at #92" D MES^XPDUTL(X)
 S ^DD("FUNC",92,0)="PRIORUSER"
 S ^DD("FUNC",92,3)="VARIABLE"
 S ^DD("FUNC",92,9)="When it has an argument (Fieldname), returns as a multiple all prior audited Users, most recent first.  Without an argument, it is most recent audited User for the Entry"
 S ^DD("FUNC","B","PRIORUSER",92)=""
 S COUNT=COUNT+1
 Q
 ;
APVAL ; Add PRIORVALUE at IEN 90
 S X="Installing Function PRIORVALUE at #90" D MES^XPDUTL(X)
 S ^DD("FUNC",90,0)="PRIORVALUE"
 S ^DD("FUNC",90,9)="Takes name of an Audited Field.  Returns as a multiple all prior values of the field, most recent first."
 S ^DD("FUNC","B","PRIORVALUE",90)=""
 S COUNT=COUNT+1
 Q
 ;
END I COUNT=0 D ENDMES Q  ; Count piece doesn't need updating
 ; Update 4th piece of Zeroth node
 L +^DD("FUNC",0):5 S $P(^(0),"^",4)=$P(^DD("FUNC",0),"^",4)+COUNT I  L -^DD("FUNC",0)
 D ENDMES
 Q
 ;
ENDMES ;
 S X="Done..." D MES^XPDUTL(X)
 Q
ERRMES ;
 S X="The "_$P(^DD("FUNC",I,0),U)_" Function needs to be evaluated by SD&D."  D MES^XPDUTL(X)
 Q
