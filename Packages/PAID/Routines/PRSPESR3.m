PRSPESR3 ;WOIFO/JAH - Part-time physicians ESR Edit;11/04/04
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
GETTOUR(PRSIEN,PRSD,TC,Y1,Y4) ; Return all segments of tour with special
 ; tour indicators if any
 N L1,A1,L3,L4,PRSTR
 I Y1="" S Y1=$S(TC=1:"Day Off",TC=2:"Day Tour",TC=3!(TC=4):"Intermittent",1:"")
 ;
 S PRSTR=""
 S (L3,L4)=0
 ;
 F L1=1:3:19 S A1=$P(Y1,"^",L1) Q:A1=""  D
 . S L3=L3+1,Y1(L3)=A1
 . S:$P(Y1,"^",L1+1)'="" Y1(L3)=Y1(L3)_"-"_$P(Y1,"^",L1+1)
 . S:PRSTR'="" PRSTR=PRSTR_", " S PRSTR=PRSTR_Y1(L3)
 . I $P(Y1,"^",L1+2)'="" D
 ..  S L3=L3+1
 ..  S Y1(L3)="  "_$P($G(^PRST(457.2,+$P(Y1,"^",L1+2),0)),"^",1)
 ..  S PRSTR=PRSTR_" "_$P($G(^PRST(457.2,+$P(Y1,"^",L1+2),0)),"^",6)
 ;
 ; add all segments of second tour if any
 ;
 I Y4'="" D
 .F L1=1:3:19 S A1=$P(Y4,"^",L1) Q:A1=""  D
 .. S L3=L3+1,Y1(L3)=A1
 .. S:$P(Y4,"^",L1+1)'="" Y1(L3)=Y1(L3)_"-"_$P(Y4,"^",L1+1)
 .. S:PRSTR'="" PRSTR=PRSTR_", " S PRSTR=PRSTR_Y1(L3)
 .. I $P(Y4,"^",L1+2)'="" D
 ...  S L3=L3+1
 ...  S Y1(L3)="  "_$P($G(^PRST(457.2,+$P(Y4,"^",L1+2),0)),"^",1)
 ...  S PRSTR=PRSTR_" "_$P($G(^PRST(457.2,+$P(Y1,"^",L1+2),0)),"^",6)
 ;
 Q PRSTR
INCESRS(PRSIEN,PPI) ;function returns count of incomplete ESR 
 ;                days (ESR status xref)
 ; effectively a count of the ptp's unsigned esr days (status < 4).
 ; days off don't get added to total
 ; 
 ;
 N INCS
 S INCS=0
 Q:(($G(PRSIEN)'>0)!($G(PPI)'>0)) INCS
 N PPE,STAT,I
 S PPE=$P($G(^PRST(458,PPI,0)),U)
 Q:PPE="" INCS
 S I=0
 F  S I=$O(^PRST(458,"AEA",PRSIEN,PPE,I)) Q:I=""  D
 .  S STAT=$$GETSTAT^PRSPESR1(PRSIEN,PPI,I)
 .  I STAT<4 S INCS=INCS+1
 Q INCS
WARNMSG(STR) ; write string to 80 column output
 ; format a long message string to break lines at words
 N WORD,I
 S WORD=""
 F I=1:1:$L(STR," ") D
 .  S WORD=$P(STR," ",I)
 .  Q:WORD=""
 .  I ($X+$L(WORD)+10)>IOM W !
 .  W WORD," "
 Q
